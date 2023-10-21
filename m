Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FC37D1BD4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 10:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjJUIpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 04:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJUIpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 04:45:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45497A3;
        Sat, 21 Oct 2023 01:45:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40853c639abso9394855e9.0;
        Sat, 21 Oct 2023 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697877907; x=1698482707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbM2kehTdlvWz3ew9KyBopTdTuaDL5DOg4Ugwe/xjTU=;
        b=ngQKqO0h5VrAac86U66PRlZ4lZKbn0C2GY5YPSS6BuW9CWC1ohdzHysZcnLA4EQGyD
         pHZ7PPTLcM64Bd4dqKeTYfokzOSh8+a6Mh+26Sd7b563aTRz8XjUU85C/0VJCA5HVrNQ
         2XYK4TQJ/vUJmWUKjkBdPiHsHS9maNdX949ejNPujkbCXjzPaOead/rUeDK3MmICS6nU
         EKPOJ8oP3fIQarw8aPKPhi0pogi3jZu2lwcZWarZ0HRDomxSnlv/VYILhRZRmOVBj1lO
         Oz0LLptUQ0pnf1LUjzgLyU7A67AkjzzI1zbJ3ytwBZJtY9oKRmcg03/hPqE6MguJ1CLk
         epxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697877907; x=1698482707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbM2kehTdlvWz3ew9KyBopTdTuaDL5DOg4Ugwe/xjTU=;
        b=OzzQwyLxMG8PwFTQLLDVg6XI2ajyN5RY9NA432lv4ChBPRRfuXqbVM130XjwxqPkJ9
         b59J1afmjIZxzwAcEnrPyaQIkO1BktS5taVYTzld5P8awqMUYH0H+GLO0hCQyWgXAc9L
         pke0aT6T/94VToAKOQWwdHA48hefjmtPW55IeKvHx2mruhObZ6I0AxIuuFtG7SoLUIAh
         u7tDcabVWcuWpaOhsuY+4Y5X8Wr2yZMptaYIW41IF4TuZL/PdChMbKF3cV/nfH2s2Wza
         vLULmwSo8nK87cvFWjWOWfyUlHOiphJYQnnxdYSI+aCACriY+lmfk9I5vp8zTG43/xOA
         Sgkw==
X-Gm-Message-State: AOJu0YwYW1Ujdm8mRJa90LN1xdZH7vll39e/zTB568VEpkMzUFTlUtmG
        dnAWsxNib/0lhxks0bD4mtE=
X-Google-Smtp-Source: AGHT+IE8DL8ZmA5tRJtZogyJFafz5UsLQjhEVC1rEoQ20i3O7PGT0P+TtpeBi4JssvLKyrXMD/tE7A==
X-Received: by 2002:a05:6000:11c7:b0:31f:b120:143 with SMTP id i7-20020a05600011c700b0031fb1200143mr2823328wrx.59.1697877906464;
        Sat, 21 Oct 2023 01:45:06 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0032d8f075810sm3330391wrt.10.2023.10.21.01.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 01:45:06 -0700 (PDT)
Message-ID: <ef1c52ab-3006-4630-bbb5-9cdaa83efdcc@gmail.com>
Date:   Sat, 21 Oct 2023 10:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] power: supply: surface_battery: replace deprecated
 strncpy with strscpy
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231020-strncpy-drivers-power-supply-surface_battery-c-v2-1-29ed16b2caf1@google.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231020-strncpy-drivers-power-supply-surface_battery-c-v2-1-29ed16b2caf1@google.com>
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

On 10/20/23 21:39, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect bat->name to be NUL-terminated based on its usage with
> strcmp():
> 
> power_supply_core.c:
> 445: return strcmp(psy->desc->name, name) == 0;
> 
> ... and also by the manual `... - 1` for the length argument of the
> original strncpy() invocation.
> 
> Furthermore, no NUL-padding is needed as bat is zero-allocated before
> calling spwr_battery_init():
> 826: bat = devm_kzalloc(&sdev->dev, sizeof(*bat), GFP_KERNEL);
> 827: if (!bat)
> 828:   return -ENOMEM;
> 829:
> 830: spwr_battery_init(bat, sdev, p->registry, p->name);
> 
> ... this means any further NUL-byte assignments (like the ones that
> strncpy() does) are redundant.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's also opt to use the more idiomatic strscpy() usage of:
> (dest, src, sizeof(dest)).
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
> Changes in v2:
> - fix subject line
> - Link to v1: https://lore.kernel.org/r/20231020-strncpy-drivers-power-supply-surface_battery-c-v1-1-cabaea50e667@google.com
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>   drivers/power/supply/surface_battery.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
> index 19d2f8834e56..196d290dc596 100644
> --- a/drivers/power/supply/surface_battery.c
> +++ b/drivers/power/supply/surface_battery.c
> @@ -722,7 +722,7 @@ static void spwr_battery_init(struct spwr_battery_device *bat, struct ssam_devic
>   			      struct ssam_event_registry registry, const char *name)
>   {
>   	mutex_init(&bat->lock);
> -	strncpy(bat->name, name, ARRAY_SIZE(bat->name) - 1);
> +	strscpy(bat->name, name, sizeof(bat->name));
>   
>   	bat->sdev = sdev;
>   
> 
> ---
> base-commit: bb55d7f7f7445abcc8db50e6a65d4315e79f75c7
> change-id: 20231020-strncpy-drivers-power-supply-surface_battery-c-b0c84b05ac28
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
