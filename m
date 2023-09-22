Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064BA7ABA8E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjIVUd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjIVUdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:33:55 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0691419E;
        Fri, 22 Sep 2023 13:33:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so2343825b3a.1;
        Fri, 22 Sep 2023 13:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695414829; x=1696019629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ujQqofflbFhC3FlZSdBu24bDcXpPxDmw20FYLc0vm1g=;
        b=ZkSdPnOwRFMn4pfDQDM+lpxF/8olEDpn8iDFhcw5HjCTl6vqGYWHTwPsCpEDY7TWf2
         AkNlJo/NjaAl/AVAg854Lcj1mGQMQHnE03MN7M+OVRvW0bLBzOn8Q3DEzCxBkoGVWXw7
         31aiSqr+Vbu3lnrnukUYwvqC5b2FWPzu+y3gJ/kzQeTRbTDesf9DZJSjZRwIWzMrp/w3
         IIPKugiF8WvOaY4+ln9jvWR6G9dTWVljYiCnZeMkd14t59r7d7dJhMd0N58hINIO6OWc
         +/S3QNE89DQEdR3UgprUSA3DEXRv45TCaUqQO/cHCAY25+J5k/Iom3oWmgoqxBzFL2/g
         12vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695414829; x=1696019629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujQqofflbFhC3FlZSdBu24bDcXpPxDmw20FYLc0vm1g=;
        b=t1EUmW6iI6y0UI5xFl+2fsZocFuAHOHXfo5XIS6qf+W8j4b0spKgTjzPzfnpyHr1jn
         sDQDsdvxcN28hBgMbaCr0qymvlqrVEDTqFUwsd2XbB9Mq3lVwmhTVcfArfEwLJcMI2Rs
         vLTbfXPGYJ5v0k9vw3qDK3KYgM8VQoUlRZpCRimAjosjSAxoYfuIkXqb6intQlW3bUIJ
         QRWyYo0vSdfQB+aL0czXl5kjySTU6iv7t1A/as+D6GXyJvZnUYifOH94kdnv1Ax9gcaj
         ntQUOA3LZYfUh3ph4N5uhcpKGDvhzciQI1LZ7Tu7RrX5OE79lxGLoECEz1TzcCN/qk8g
         rUxA==
X-Gm-Message-State: AOJu0YzVmJH6Ah85nYNT31z3t0rj5p4EnxSDUHOH5nv93Wn21Dm+Vm4B
        VIZj+1+07Ihon+sHrvbayjU=
X-Google-Smtp-Source: AGHT+IE0lp8OaTdfzen/WbpBiyQzw9e5TOrxAMJXZilMdPabykphOZO4LjZQmAUOIjNf2KlBWGsIOA==
X-Received: by 2002:a05:6a20:5659:b0:155:6e4f:8c1a with SMTP id is25-20020a056a20565900b001556e4f8c1amr537181pzc.25.1695414829391;
        Fri, 22 Sep 2023 13:33:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bb18-20020a17090b009200b0026fb228fafasm5311783pjb.18.2023.09.22.13.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 13:33:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4067f87f-c982-05c7-a198-49482da22817@roeck-us.net>
Date:   Fri, 22 Sep 2023 13:33:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drivers/watchdog: fix checkpatch error
Content-Language: en-US
To:     Nikita Bune <w1s2d5@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230922201025.64164-1-w1s2d5@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230922201025.64164-1-w1s2d5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/23 13:10, Nikita Bune wrote:
> Fix checkpatch ERROR: do not initialise statics to 0
> 
> Signed-off-by: Nikita Bune <w1s2d5@gmail.com>

Not applying. Please stop submitting such cosmetic patches.
Also please note that the subject should start with "<subsystem>: <driver>:".

Guenter

> ---
>   drivers/watchdog/uniphier_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
> index 8e9242c23022..7a080600d865 100644
> --- a/drivers/watchdog/uniphier_wdt.c
> +++ b/drivers/watchdog/uniphier_wdt.c
> @@ -41,7 +41,7 @@
>   #define WDT_PERIOD_MIN			1
>   #define WDT_PERIOD_MAX			128
>   
> -static unsigned int timeout = 0;
> +static unsigned int timeout;
>   static bool nowayout = WATCHDOG_NOWAYOUT;
>   
>   struct uniphier_wdt_dev {

