Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3B97F4989
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbjKVO6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjKVO6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:58:49 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C2992;
        Wed, 22 Nov 2023 06:58:45 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5cb5248a21fso8094297b3.1;
        Wed, 22 Nov 2023 06:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700665125; x=1701269925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gLUH9VRtYoY3AbMiFDMwADpfDgn46e/c/woEd/BrTwk=;
        b=BGjrkRTHhBnhBNnc/XINYJAtuqfUSJmIKn5UZINOiAFw792kTg6Ihi07xCp6Mqj6mb
         yHNdhE7k7JAwhaYEkqMxhm821XTxWB2+0HsbBfdFjoXUZOWtMLKxdTHfRmKk5er9r+hh
         zc6sREDKVqPY3qdn/ax7LGDaY9p15SnzY8CLLb05ISF3FOp6lr3t5NoVYwdjsvNKnsEj
         TEwPjJG4Z7lFuPUgi8Gx/gmhaqeV3GWB9fQb/ZIOOKL/dE7+FMQ/RCSrl/bqIT+mgsmk
         KqCTY6x0PLQMEPVx2LWl0zmNVQgvEVwaQem83ovqhl40dwf9iY7LFSGX9h7J3u01GYAY
         4EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700665125; x=1701269925;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLUH9VRtYoY3AbMiFDMwADpfDgn46e/c/woEd/BrTwk=;
        b=vry0muSZFFAklYZlq0wnYaZcrF+VQvVsGLddDrcB81geyL+gZ2/ETDhMqvzjj444r4
         RfPNUlGk7Xkh9YxRj+uJM35ReCqeX9TMAsC+Z6SVdODZ1nv/avWVdZEZ+rXJWUpYUwwo
         JVCtWKG2orAZk7Uie16P9ZAIpls3RHGQyUJ+uzBGSVeLqHydUlQTeGgITN8foBb5qRqA
         7fdxb9rrevhlRvx14rd25X+KpIN6bVb1HbKXcUVrzBDrQyU7EJED/KI7mKGjpDUbJRvc
         Q5+/fHQfhPt3gkOv1xtfrhrr0+nsKi9pGAS7if+y7C2h3OmOiIxRcq0ZA0/QP52/jPAC
         4m/Q==
X-Gm-Message-State: AOJu0YwZAwZjDiNnDWzGFaXW072aiBzxYdsMgJhzmeiAxuotK/WtJpPs
        GD0yTA4LDr1eB7ivTs9DCCo+AhqDXxU=
X-Google-Smtp-Source: AGHT+IFqthOa6AA4cNgGUR/KB3AfjQNwqcVFb8F79hchbyNao8ZLxACCYG1IaP2lyRmd2cbXVPOxrQ==
X-Received: by 2002:a81:6cd3:0:b0:5cc:9ef4:b01d with SMTP id h202-20020a816cd3000000b005cc9ef4b01dmr846648ywc.21.1700665124979;
        Wed, 22 Nov 2023 06:58:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s8-20020a817708000000b0059af121d0b8sm3780744ywc.52.2023.11.22.06.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 06:58:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f95c53d5-f88f-47b9-abcc-78a644cf7a7b@roeck-us.net>
Date:   Wed, 22 Nov 2023 06:58:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: starfive: add lock annotations to fix context
 imbalances
Content-Language: en-US
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, samin.guo@starfivetech.com,
        xingyu.wu@starfivetech.com, linux-kernel@vger.kernel.org
References: <20231122085118.177589-1-ben.dooks@codethink.co.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231122085118.177589-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 00:51, Ben Dooks wrote:
> Add the necessary __acquires() and __releases() to the functions
> that take and release the wdt lock to avoid the following sparse
> warnings:
> 
> drivers/watchdog/starfive-wdt.c:204:13: warning: context imbalance in 'starfive_wdt_unlock' - wrong count at exit
> drivers/watchdog/starfive-wdt.c:212:9: warning: context imbalance in 'starfive_wdt_lock' - unexpected unlock
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/starfive-wdt.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> index 5f501b41faf9..49b38ecc092d 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -202,12 +202,14 @@ static u32 starfive_wdt_ticks_to_sec(struct starfive_wdt *wdt, u32 ticks)
>   
>   /* Write unlock-key to unlock. Write other value to lock. */
>   static void starfive_wdt_unlock(struct starfive_wdt *wdt)
> +	__acquires(&wdt->lock)
>   {
>   	spin_lock(&wdt->lock);
>   	writel(wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
>   }
>   
>   static void starfive_wdt_lock(struct starfive_wdt *wdt)
> +	__releases(&wdt->lock)
>   {
>   	writel(~wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
>   	spin_unlock(&wdt->lock);

