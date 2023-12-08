Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14D680ACE0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574663AbjLHTXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574675AbjLHTXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:23:09 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296011718
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:23:15 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54cd8f5bb5cso3232525a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 11:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702063393; x=1702668193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYer3k5AHgALqQa9MbWQNvQ/NvhzpotSwy0iRJYUHjg=;
        b=UI/4NpLYxLd82S9b6hJY0f8ZeN7PpXu9hGZ1iUt8jGVDLSCELaZPtmzqr5OoudwIUH
         g4smNPWS+fWNQHsUq8FXGe4BTBZXt+1FiTJIauSHjt0sOnFS7CwfwiKBtRtB3JpZ6886
         AM5a1oe5KDwC5rX44ET6y9RCceW+QGA1EjBV63nJPDY50zzVAZXdc5T2FcdK5BnnoyQq
         nCbZbYHTLoZkJTEnCC0ui6pn1fKoVBlcKujR/TX69to53mz3/Ib7T4awkld+bprPsplR
         Gw/kCSXbxzMM36PVYwVGvZBg59B65LEC+t+Ag9SeP1NFgLEwWmXzqrnkgllDLs7hg2Ap
         jdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063393; x=1702668193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYer3k5AHgALqQa9MbWQNvQ/NvhzpotSwy0iRJYUHjg=;
        b=ZmlGl5Ne4xVd4dT4GzijyxlRH8brQyA7FhLG19przHFNCh+3PDYVmFFRHVNHvysguj
         vJXsVORsskg9raI5zGaJjStNMUAI/7MMvSIWIl286IzShzoIqkEWTjnOR7gz7uuy4Gsa
         v/FpEJFcw1m7BNyYInLriWU8Lps5swRe78iVea5d85IZ13QsQUXjR20529XHMEIThJhU
         UlmuT5Tdm9VIQapbAe7on51PQdlg5zRomzbJU8hH/J3MLsxyHBmnjzArcVpux8aZogRf
         x1r0soMKw+U/CrZvGlOhi2RUL5nkUpInqoSGZsHB6kjSm0N+yX5jgDmMtIfSauNNNoYG
         +wUA==
X-Gm-Message-State: AOJu0YwY4bYfS34WoESpFV09C+FIpeJg4z9HVgVerLUqHCQVCGVsw4Cw
        W7OsEhzWdLAFKI4w4sdGngLsuw==
X-Google-Smtp-Source: AGHT+IE9MSc735O8yJ+Sy59fmTbRrabH9hyXZet59qWEG0OGbjPGuhfmOnDpW6nkiL5l2/tKSm9Oow==
X-Received: by 2002:a17:906:54:b0:a18:aa41:7c6f with SMTP id 20-20020a170906005400b00a18aa417c6fmr207587ejg.7.1702063393502;
        Fri, 08 Dec 2023 11:23:13 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.22])
        by smtp.gmail.com with ESMTPSA id vv6-20020a170907a68600b00a1dff479037sm1321205ejc.127.2023.12.08.11.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 11:23:13 -0800 (PST)
Message-ID: <e062a92a-b82d-4d7e-8111-fa901067be57@tuxon.dev>
Date:   Fri, 8 Dec 2023 21:23:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: soc: atmel: Adjust defines to follow
 alphabetical order
Content-Language: en-US
To:     Ryan.Wanner@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231208170230.551265-1-Ryan.Wanner@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231208170230.551265-1-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ryan,

On 08.12.2023 19:02, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Move the defines so that they are in aphabetical order based on SOC.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

This doesn't apply clean on top of v6.7-rc1. I guess it's related to SAM9X7
defines that are not yet in v6.7-rc1.

Thank you,
Claudiu Beznea

> ---
>  drivers/soc/atmel/soc.h | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
> index 26dd26b4f179..9b2d31073b88 100644
> --- a/drivers/soc/atmel/soc.h
> +++ b/drivers/soc/atmel/soc.h
> @@ -39,13 +39,13 @@ at91_soc_init(const struct at91_soc *socs);
>  #define AT91SAM9261_CIDR_MATCH		0x019703a0
>  #define AT91SAM9263_CIDR_MATCH		0x019607a0
>  #define AT91SAM9G20_CIDR_MATCH		0x019905a0
> -#define AT91SAM9RL64_CIDR_MATCH		0x019b03a0
>  #define AT91SAM9G45_CIDR_MATCH		0x019b05a0
> -#define AT91SAM9X5_CIDR_MATCH		0x019a05a0
>  #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
> +#define AT91SAM9RL64_CIDR_MATCH		0x019b03a0
> +#define AT91SAM9X5_CIDR_MATCH		0x019a05a0
>  #define SAM9X60_CIDR_MATCH		0x019b35a0
> -#define SAMA7G5_CIDR_MATCH		0x00162100
>  #define SAM9X7_CIDR_MATCH		0x09750020
> +#define SAMA7G5_CIDR_MATCH		0x00162100
>  
>  #define AT91SAM9M11_EXID_MATCH		0x00000001
>  #define AT91SAM9M10_EXID_MATCH		0x00000002
> @@ -62,19 +62,15 @@ at91_soc_init(const struct at91_soc *socs);
>  #define AT91SAM9N12_EXID_MATCH		0x00000006
>  #define AT91SAM9CN11_EXID_MATCH		0x00000009
>  
> +#define AT91SAM9XE128_CIDR_MATCH	0x329973a0
> +#define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
> +#define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
> +
>  #define SAM9X60_EXID_MATCH		0x00000000
>  #define SAM9X60_D5M_EXID_MATCH		0x00000001
>  #define SAM9X60_D1G_EXID_MATCH		0x00000010
>  #define SAM9X60_D6K_EXID_MATCH		0x00000011
>  
> -#define SAMA7G51_EXID_MATCH		0x3
> -#define SAMA7G52_EXID_MATCH		0x2
> -#define SAMA7G53_EXID_MATCH		0x1
> -#define SAMA7G54_EXID_MATCH		0x0
> -#define SAMA7G54_D1G_EXID_MATCH		0x00000018
> -#define SAMA7G54_D2G_EXID_MATCH		0x00000020
> -#define SAMA7G54_D4G_EXID_MATCH		0x00000028
> -
>  #define SAM9X75_EXID_MATCH		0x00000000
>  #define SAM9X72_EXID_MATCH		0x00000004
>  #define SAM9X70_EXID_MATCH		0x00000005
> @@ -83,10 +79,6 @@ at91_soc_init(const struct at91_soc *socs);
>  #define SAM9X75_D1M_EXID_MATCH		0x00000003
>  #define SAM9X75_D2G_EXID_MATCH		0x00000006
>  
> -#define AT91SAM9XE128_CIDR_MATCH	0x329973a0
> -#define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
> -#define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
> -
>  #define SAMA5D2_CIDR_MATCH		0x0a5c08c0
>  #define SAMA5D21CU_EXID_MATCH		0x0000005a
>  #define SAMA5D225C_D1M_EXID_MATCH	0x00000053
> @@ -122,6 +114,14 @@ at91_soc_init(const struct at91_soc *socs);
>  #define SAMA5D43_EXID_MATCH		0x00000003
>  #define SAMA5D44_EXID_MATCH		0x00000004
>  
> +#define SAMA7G51_EXID_MATCH		0x3
> +#define SAMA7G52_EXID_MATCH		0x2
> +#define SAMA7G53_EXID_MATCH		0x1
> +#define SAMA7G54_EXID_MATCH		0x0
> +#define SAMA7G54_D1G_EXID_MATCH		0x00000018
> +#define SAMA7G54_D2G_EXID_MATCH		0x00000020
> +#define SAMA7G54_D4G_EXID_MATCH		0x00000028
> +
>  #define SAME70Q21_CIDR_MATCH		0x21020e00
>  #define SAME70Q21_EXID_MATCH		0x00000002
>  #define SAME70Q20_CIDR_MATCH		0x21020c00
