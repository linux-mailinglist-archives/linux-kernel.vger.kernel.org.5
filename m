Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB40F7F9043
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 00:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjKYXKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 18:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYXKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 18:10:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B3E10B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 15:10:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40839652b97so20658515e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 15:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1700953845; x=1701558645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oNiZ0WOzTAV3L7455QiacDrpLq7f4/1o2lfYS0Foxfw=;
        b=OPclexMT3Eqmk//h2K2gjUp25wBxtFtJOkzfprvVKGD5jpssC4OPWGfB4MyrghwWHL
         VflP/0oDe+YjYJ3zpGre9LUKkdbPAniAGXw4F99MpzC/EHTJDLcxnL+Gek1hGWHaHEal
         pkbe2LtNEP4aRDjegzdLWylSb2Ybg52lX+GIF1BDv5NcZlenanpcyPpXbZn3wAMV2o6B
         8i+a4Fyp/+WPUxE8A8oAvZ2tJX5BXq4kH74q2dfKOb+R4Z//HGpXD/hERDKCj/bIi8PV
         rCzHFmZKt8naPlgT6+FD3H20vg2angIeytGO8AXLhu0yOcis7/f7mUtYM8dnUUD5QqRd
         05pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700953845; x=1701558645;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNiZ0WOzTAV3L7455QiacDrpLq7f4/1o2lfYS0Foxfw=;
        b=MeBSNx6Q5rCS/gDRjYxm1zuVOJRRhstj1YqKNRZcEH0r4Wry7iLF+jxA8YyNEjjv3m
         89OEszjZARCf1Guy+Bkq8CeHFxIV7ZYWmY9j+eNubO2uO4acLvVzHfsTBYVZ8CTo2ke6
         7lbNevFLIrRiqIpFbBcFK7U2/2xsjcGqOti8xegm7VjAaaeuHov2WBdpLwDX/tlbl6vX
         YRlWZBwpuXjfskr3WUNODugr6jSRP2Byu+pnuXmH5LL6ewU1AebxkEw5YWxWDVmAj3Uk
         Uh0BkpSUQYKCYwggdJ+vQkc7dkTeEhOwfmmCWGPYo//CPUclCmSZ7SI126RtkzxhkSPZ
         bylQ==
X-Gm-Message-State: AOJu0Ywhn+pnEX4OxbjaaS1u1PuljXWpDvVnLjW8ZvgPKi4A0SS1Sc8t
        Cx5q/lB/TQ2qDae2lh/YekAUoQ==
X-Google-Smtp-Source: AGHT+IEIXmZ9SSqNoPouyelTnEwM+YSm+OIdhr6YJ1d8IHhmIBrHsEleYcYCZqdWLXfDROH4jWuvsw==
X-Received: by 2002:a05:600c:4f88:b0:409:2c35:7b3e with SMTP id n8-20020a05600c4f8800b004092c357b3emr5476999wmq.8.1700953845282;
        Sat, 25 Nov 2023 15:10:45 -0800 (PST)
Received: from [192.168.0.20] ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id fl8-20020a05600c0b8800b004030e8ff964sm9707637wmb.34.2023.11.25.15.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 15:10:44 -0800 (PST)
Message-ID: <fd5f08c0-4603-471a-bd6f-44a2e6191ac7@smile.fr>
Date:   Sun, 26 Nov 2023 00:10:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kconfig: default to zero if int/hex symbol lacks
 default property
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20231125163559.824210-1-masahiroy@kernel.org>
 <20231125163559.824210-2-masahiroy@kernel.org>
Content-Language: en-US
From:   Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <20231125163559.824210-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/11/2023 à 17:35, Masahiro Yamada a écrit :
> When a default property is missing in an int or hex symbol, it defaults
> to an empty string, which is not a valid symbol value.
> 
> It results in a incorrect .config, and can also lead to an infinite
> loop in scripting.
> 
> Use "0" for int and "0x0" for hex as a default value.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks! It does fix our problem.

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>

> ---
> 
>  scripts/kconfig/symbol.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
> index f7075d148ac7..a5a4f9153eb7 100644
> --- a/scripts/kconfig/symbol.c
> +++ b/scripts/kconfig/symbol.c
> @@ -338,7 +338,11 @@ void sym_calc_value(struct symbol *sym)
>  
>  	switch (sym->type) {
>  	case S_INT:
> +		newval.val = "0";
> +		break;
>  	case S_HEX:
> +		newval.val = "0x0";
> +		break;
>  	case S_STRING:
>  		newval.val = "";
>  		break;
> @@ -746,14 +750,17 @@ const char *sym_get_string_default(struct symbol *sym)
>  		case yes: return "y";
>  		}
>  	case S_INT:
> +		if (!str[0])
> +			str = "0";
> +		break;
>  	case S_HEX:
> -		return str;
> -	case S_STRING:
> -		return str;
> -	case S_UNKNOWN:
> +		if (!str[0])
> +			str = "0x0";
> +		break;
> +	default:
>  		break;
>  	}
> -	return "";
> +	return str;
>  }
>  
>  const char *sym_get_string_value(struct symbol *sym)

-- 
Yoann Congal
Smile ECS - Tech Expert
