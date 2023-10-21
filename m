Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B787D1BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 10:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjJUIoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 04:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUIoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 04:44:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43981D63;
        Sat, 21 Oct 2023 01:44:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-408382da7f0so12913455e9.0;
        Sat, 21 Oct 2023 01:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697877855; x=1698482655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDtjhJ1x9aGm8BrdvhZ66AGy0SmCLFMPb2JjWVfHFBk=;
        b=QbX7K/R5kyYFPxYQ/dL4hYzL7PUjvp17peRPV+KZvWduaZBeZpRmmyMDoUXVMHQJR7
         tKFqjGBG8JzQ5K9UiaScT2D4HexObZzAcjs+TbeCds7LZmF24wlnipm+CJLGp6pGld/Z
         jARhriOBO/+P7MMBERmolXDPmvVTdE1enEjq9Ew2lo6t73yGJygk4yO45zTAdrrkZpTJ
         d+LWEJF9ADkPmYbFef5L3stEAjrGgOcosuZzIyL90iILwe/lsI3xMnfmSHW8atM5LURs
         0ybAshAEtjRd2M3h1PoUrM36zOb8BYQ1hng2if8LLcyNgko4EPM7w7ZDtdq9eYXGCHge
         XPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697877855; x=1698482655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDtjhJ1x9aGm8BrdvhZ66AGy0SmCLFMPb2JjWVfHFBk=;
        b=SpVmcUpIm+NdlBA/1mY2hgxU5VwtYymRSAg2Mkajx5gtgxzHXhhZfAvzV9x5eXmVqj
         E9bg1LWQ9bQ8nuX3tIF98Ve4YodhV+VY8Rpgrngyv2Sv9p3zrYQGWkipc/6Rf6s4k5zF
         wMfVMuUPIFm9sZIeA6XgbcdINRug+acw4nRzkHcNFukcff0sUPiZ2YqpThOTtWizfbGI
         trU2jyLjN4mwaWvJ1lwYno0/JEK5UUSO1zsrdhkxmVJPctSQS9tTKpq4oIybEMh2hBXg
         H4MmEry3WEhBA4jWg5Ibp2iRmVtC9dtgW3jaOhQ67+WkVqRLzgYODgbSlQjxgye/Yu7X
         VOvw==
X-Gm-Message-State: AOJu0YywJIh0FpBeLTFIcyK1UlevCsjW4Pi7sxHjBsrxn6Jvjn/XdUBy
        PxzhMN0jYdSFkx7ZZWdFgKKJAcSxmww=
X-Google-Smtp-Source: AGHT+IH3YJXlZ9rb6za5kZD23xgJGN1GKKAW0E94ivZevJl0rG6Lw2BuTTvMP8fgULJJZiY0bYQADg==
X-Received: by 2002:a05:600c:45c7:b0:408:4918:590e with SMTP id s7-20020a05600c45c700b004084918590emr2958392wmo.39.1697877854236;
        Sat, 21 Oct 2023 01:44:14 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0032d8f075810sm3330391wrt.10.2023.10.21.01.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 01:44:13 -0700 (PDT)
Message-ID: <5b9cf91a-d726-44d0-99e4-9440c6bd3165@gmail.com>
Date:   Sat, 21 Oct 2023 10:44:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: surface-charger: replace deprecated
 strncpy with strscpy
To:     Justin Stitt <justinstitt@google.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231020-strncpy-drivers-power-supply-surface_charger-c-v1-1-93ddbf668e10@google.com>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231020-strncpy-drivers-power-supply-surface_charger-c-v1-1-93ddbf668e10@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/23 21:46, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect ac->name to be NUL-terminated based on its usage with format
> strings:
> 
> surface_charger.c:
> 190: ac->psy_desc.name = ac->name;
> 
> ...
> 
> power_supply_core.c:
> 174: dev_dbg(&psy->dev, "%s: Found supply : %s\n",
> 175:   psy->desc->name, epsy->desc->name);
> 
> Moreover, NUL-padding is not required as ac is already zero-allocated
> before being passed to spwr_ac_init():
> 
> surface_charger.c:
> 240: ac = devm_kzalloc(&sdev->dev, sizeof(*ac), GFP_KERNEL);
> 241: if (!ac)
> 242:   return -ENOMEM;
> 243:
> 244: spwr_ac_init(ac, sdev, p->registry, p->name);
> 
> ... this means any future NUL-byte assignments (like the ones that
> strncpy() does) are redundant.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's also opt for the more idiomatic strscpy() usage of:
> (dest, src, sizeof(dest))
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Tested-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>   drivers/power/supply/surface_charger.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/supply/surface_charger.c
> index cabdd8da12d0..7a6c62d6f883 100644
> --- a/drivers/power/supply/surface_charger.c
> +++ b/drivers/power/supply/surface_charger.c
> @@ -175,7 +175,7 @@ static void spwr_ac_init(struct spwr_ac_device *ac, struct ssam_device *sdev,
>   			 struct ssam_event_registry registry, const char *name)
>   {
>   	mutex_init(&ac->lock);
> -	strncpy(ac->name, name, ARRAY_SIZE(ac->name) - 1);
> +	strscpy(ac->name, name, sizeof(ac->name));
>   
>   	ac->sdev = sdev;
>   
> 
> ---
> base-commit: bb55d7f7f7445abcc8db50e6a65d4315e79f75c7
> change-id: 20231020-strncpy-drivers-power-supply-surface_charger-c-466920fb1f48
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
