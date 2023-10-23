Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0681A7D2763
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 02:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjJWADY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 20:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJWADX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 20:03:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B08AC;
        Sun, 22 Oct 2023 17:03:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b26a3163acso1917978b3a.2;
        Sun, 22 Oct 2023 17:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698019401; x=1698624201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P0ZezZHBJgb9AA98w6pDydPHiJld1JFNGUsoHtLjS4g=;
        b=LKzBk1s9BJXAT6i+x1aUCVaL3/IZPxZv4FxQLTQF7pX54EkwIxbW0mx11iotFqEorK
         Ao9PzU5JZGqezYY8naqO+giV0nJqJoDFCgYZ8cDAI5IoH7A+ov9LEEaWHZT/8GjmOla4
         huUfPM15m47OL1CoSh8KTHQX6NpG+JdXIkgarPvyGAdlMkseFDq848or3UQMilnUIjaG
         sYyGZ03tmTI5pG5jwZhZ+xQiM0119WinGvR9007V/EQ+SiJSMPA+koLY8aeTvEHQL/++
         cJBN+b/QMB/5CI8brP1+SxL4ZjHYm5qDVnml5b1rkhchmV53GEVIc8MS1/5lqwkF3Ohc
         4lAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698019401; x=1698624201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0ZezZHBJgb9AA98w6pDydPHiJld1JFNGUsoHtLjS4g=;
        b=oMPqoAp1uT/x8714iDmvzmd5WUvP47PtoDgXDTuFrAp+v8NIkOXNrOOztD9Zy3aTEP
         qBwZB6hmCn/cQc/OBJC4Cy6MYu4/YNmuWH60ds3hfZNyKdu4Y+pWGwE7J54RkLHnSkBa
         Yo0aNWQljLX+XS44zUGYEriWfrQS9mqsY2MsdfvdSuellKhmRkvBTgf9EG3W+P6M4b8K
         YBb0Vi74uYyOQJHQWkdoLgTBVUSuFyRH81SRM8Or2PF+4W+1j56pc9v3qFXIBVrAsDj7
         4ajFGWtJSbvq6kRAsro5mpDc6tE5OzsMpL0kpBShE7bMjldaXTfMl2ZZLtEIYWo8Xj+3
         OfgQ==
X-Gm-Message-State: AOJu0YywIGA1p57prf1joNoHNiEVXCBT6+M/o10QS8eOm7uTtj065gwX
        LCFbXeP1WAOwfNgya2EFcQ0abemxjsY=
X-Google-Smtp-Source: AGHT+IGvibV/0iLpWnIQcpz0tjvzmkOjml/FAB8FNjwP8h3+cw19g0ygNq2EfrSqj9Jnb50HuyVAwg==
X-Received: by 2002:a05:6a00:1743:b0:6b1:bf32:4fb5 with SMTP id j3-20020a056a00174300b006b1bf324fb5mr5849024pfc.28.1698019400835;
        Sun, 22 Oct 2023 17:03:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w187-20020a6262c4000000b0068feb378b89sm5448267pfb.171.2023.10.22.17.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 17:03:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9d1b96a2-6709-819f-23aa-f91e9741a54d@roeck-us.net>
Date:   Sun, 22 Oct 2023 17:03:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_watchdog=5fdev=3a_Remove_unnecessary_?=
 =?UTF-8?B?4oCYMOKAmSB2YWx1ZXMgZnJvbSBlcnI=?=
Content-Language: en-US
To:     fenghui <fenghui@nfschina.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231021110538.441-1-fenghui@nfschina.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20231021110538.441-1-fenghui@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/23 04:05, fenghui wrote:
> err is assigned first, so it does not need to initialize the assignment.
> 
> Signed-off-by: fenghui <fenghui@nfschina.com>
> ---
>   drivers/watchdog/watchdog_dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 15df74e11a59..0868ccbcf92b 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -291,7 +291,7 @@ static int watchdog_start(struct watchdog_device *wdd)
>    */
>   static int watchdog_stop(struct watchdog_device *wdd)
>   {
> -	int err = 0;
> +	int err;
>   
>   	if (!watchdog_active(wdd))
>   		return 0;

NACK

...

        if (wdd->ops->stop) {
                 clear_bit(WDOG_HW_RUNNING, &wdd->status);
                 err = wdd->ops->stop(wdd);
                 trace_watchdog_stop(wdd, err);
         } else {
                 set_bit(WDOG_HW_RUNNING, &wdd->status);		<-- err is not set in this path
         }


