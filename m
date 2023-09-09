Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF207999D6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbjIIQ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbjIIPuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 11:50:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F0C13D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 08:50:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52eed139ec2so2307805a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 08:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694274626; x=1694879426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sknai5FFuIetKPlXqiA1Cp0a6VVzO5G1drcSPHamhSM=;
        b=bHJjDkAiKHJJTWtGyXAmrWs/LpxePTz5wWG5g0aApGg0tJ94Bh+Zne9SeqmEv/XxSA
         oV8SyshAQxjEtvNyy8P3NzscH/b0zHwfEmAX2rJVHOG3/I36hZy7PDo66lNM6W9MOuFA
         hUQYAaf5dw0eiet/0FWnZdcTRJP9SQZtjO4z1BnWbN62ATBFkO64Tf/Fc4qZzIq32YNl
         t4I2EQMJrshryqc6zePfHiEm18pIF+Cxw42jR4ghq77lvxSLqqj4O3K0Uotz8nKPycsb
         oMLxnIBkXF/6avUizoNhDeaeg/V56jAsV5VssZx9Yuec/RSrgDzRj1qFnuzlhQw8gIyf
         GW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694274626; x=1694879426;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sknai5FFuIetKPlXqiA1Cp0a6VVzO5G1drcSPHamhSM=;
        b=oP4su4cchSPYvV0ZQxNFySmyePKFg5kKNiuVbEhd3fXzjgRPpDRsu8bCp/g0BTlep7
         yDgr1GJc3j9VKZ3RoAOs1StppO0ZYoTn2XuaY2ifkPvkO2tFHoiEpBghxKMFIj79vePB
         BIA614QkEIhZiTAhnVl6i0hF5XpdsuJ1wxjXFy7E+8/ePzJvp+bqGlIjcGkA2RhLXQx+
         IRhwIWJO5eqYO9NCOaq1E/rsqkrMZj1HPdQ5no5rq01Ui6sW5PvfThLZkXaceRjNCsHe
         p/e1cVnTUWhqJNQuvMBBvxDCrp494shRcabSCQfW7QqNEa4ij9nJoXj8ONhzM2SbkSMH
         bv4A==
X-Gm-Message-State: AOJu0YywTgr82LZHaXN3y2xwbLeNaNF7A0OEptVtGAEDgjaXyNQhAxbW
        sRJ9zneReOpEwWI890tnxN2F6w==
X-Google-Smtp-Source: AGHT+IFIx6SV+2c2xfDJFgpQ06FHcnSrdYso9uKZrShPha5V1mFgHPCEMdJzdc0nqXxSAxWpzFmfBw==
X-Received: by 2002:aa7:d7d3:0:b0:528:925f:413e with SMTP id e19-20020aa7d7d3000000b00528925f413emr4350346eds.12.1694274625896;
        Sat, 09 Sep 2023 08:50:25 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id m16-20020aa7c490000000b005236410a16bsm2325875edq.35.2023.09.09.08.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 08:50:25 -0700 (PDT)
Message-ID: <c9464c59-2f70-0345-1ebe-ec6ce9c292db@tuxon.dev>
Date:   Sat, 9 Sep 2023 18:50:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v4 4/8] drm: atmel-hlcdc: Define SAM9X7 SoC XLCDC specific
 registers
To:     Manikandan Muralidharan <manikandan.m@microchip.com>,
        sam@ravnborg.org, bbrezillon@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, lee@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
        Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
        Balakrishnan.S@microchip.com
References: <20230825125444.93222-1-manikandan.m@microchip.com>
 <20230825125444.93222-5-manikandan.m@microchip.com>
Content-Language: en-US
In-Reply-To: <20230825125444.93222-5-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/23 15:54, Manikandan Muralidharan wrote:
> From: Durai Manickam KR <durai.manickamkr@microchip.com>
> 
> The register address of the XLCDC IP used in SAM9X7 SoC family
> are different from the previous HLCDC.Defining those address
> space with valid macros.
> 
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> [manikandan.m@microchip.com: Remove unused macro definitions]
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h | 42 ++++++++++++++++++++
>  include/linux/mfd/atmel-hlcdc.h              | 10 +++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index d68c79a6eae7..8b05a54b5fd0 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -15,6 +15,7 @@
>  
>  #include <drm/drm_plane.h>
>  
> +/* LCD controller common registers */
>  #define ATMEL_HLCDC_LAYER_CHER			0x0
>  #define ATMEL_HLCDC_LAYER_CHDR			0x4
>  #define ATMEL_HLCDC_LAYER_CHSR			0x8
> @@ -128,6 +129,47 @@
>  
>  #define ATMEL_HLCDC_MAX_LAYERS			6
>  
> +/* XLCDC controller specific registers */
> +#define ATMEL_XLCDC_LAYER_ENR			0x10
> +#define ATMEL_XLCDC_LAYER_EN			BIT(0)
> +
> +#define ATMEL_XLCDC_LAYER_IER			0x0
> +#define ATMEL_XLCDC_LAYER_IDR			0x4
> +#define ATMEL_XLCDC_LAYER_ISR			0xc
> +#define ATMEL_XLCDC_LAYER_OVR_IRQ(p)		BIT(2 + (8 * (p)))
> +
> +#define ATMEL_XLCDC_LAYER_PLANE_ADDR(p)		(((p) * 0x4) + 0x18)
> +
> +#define ATMEL_XLCDC_LAYER_DMA_CFG		0
> +
> +#define ATMEL_XLCDC_LAYER_DMA			BIT(0)
> +#define ATMEL_XLCDC_LAYER_REP			BIT(1)
> +#define ATMEL_XLCDC_LAYER_DISCEN                BIT(4)

You have spaces after macro name

> +
> +#define ATMEL_XLCDC_LAYER_SFACTC_A0_MULT_AS	(4 << 6)
> +#define ATMEL_XLCDC_LAYER_SFACTA_ONE		BIT(9)
> +#define ATMEL_XLCDC_LAYER_DFACTC_M_A0_MULT_AS	(6 << 11)
> +#define ATMEL_XLCDC_LAYER_DFACTA_ONE		BIT(14)
> +
> +#define ATMEL_XLCDC_LAYER_A0_SHIFT		16
> +#define ATMEL_XLCDC_LAYER_A0(x)			\
> +	((x) << ATMEL_XLCDC_LAYER_A0_SHIFT)
> +
> +#define ATMEL_XLCDC_LAYER_VSCALER_LUMA_ENABLE		BIT(0)
> +#define ATMEL_XLCDC_LAYER_VSCALER_CHROMA_ENABLE		BIT(1)
> +#define ATMEL_XLCDC_LAYER_HSCALER_LUMA_ENABLE		BIT(4)
> +#define ATMEL_XLCDC_LAYER_HSCALER_CHROMA_ENABLE		BIT(5)
> +
> +#define ATMEL_XLCDC_LAYER_VXSYCFG_ONE		BIT(0)
> +#define ATMEL_XLCDC_LAYER_VXSYTAP2_ENABLE	BIT(4)
> +#define ATMEL_XLCDC_LAYER_VXSCCFG_ONE		BIT(16)
> +#define ATMEL_XLCDC_LAYER_VXSCTAP2_ENABLE	BIT(20)
> +
> +#define ATMEL_XLCDC_LAYER_HXSYCFG_ONE		BIT(0)
> +#define ATMEL_XLCDC_LAYER_HXSYTAP2_ENABLE	BIT(4)
> +#define ATMEL_XLCDC_LAYER_HXSCCFG_ONE		BIT(16)
> +#define ATMEL_XLCDC_LAYER_HXSCTAP2_ENABLE	BIT(20)
> +
>  /**
>   * Atmel HLCDC Layer registers layout structure
>   *
> diff --git a/include/linux/mfd/atmel-hlcdc.h b/include/linux/mfd/atmel-hlcdc.h
> index a186119a49b5..80d675a03b39 100644
> --- a/include/linux/mfd/atmel-hlcdc.h
> +++ b/include/linux/mfd/atmel-hlcdc.h
> @@ -22,6 +22,8 @@
>  #define ATMEL_HLCDC_DITHER		BIT(6)
>  #define ATMEL_HLCDC_DISPDLY		BIT(7)
>  #define ATMEL_HLCDC_MODE_MASK		GENMASK(9, 8)
> +#define ATMEL_XLCDC_MODE_MASK		GENMASK(10, 8)
> +#define ATMEL_XLCDC_DPI			BIT(11)
>  #define ATMEL_HLCDC_PP			BIT(10)
>  #define ATMEL_HLCDC_VSPSU		BIT(12)
>  #define ATMEL_HLCDC_VSPHO		BIT(13)
> @@ -34,6 +36,12 @@
>  #define ATMEL_HLCDC_IDR			0x30
>  #define ATMEL_HLCDC_IMR			0x34
>  #define ATMEL_HLCDC_ISR			0x38
> +#define ATMEL_XLCDC_ATTRE		0x3c
> +
> +#define ATMEL_XLCDC_BASE_UPDATE		BIT(0)
> +#define ATMEL_XLCDC_OVR1_UPDATE		BIT(1)
> +#define ATMEL_XLCDC_OVR3_UPDATE		BIT(2)
> +#define ATMEL_XLCDC_HEO_UPDATE		BIT(3)
>  
>  #define ATMEL_HLCDC_CLKPOL		BIT(0)
>  #define ATMEL_HLCDC_CLKSEL		BIT(2)
> @@ -48,6 +56,8 @@
>  #define ATMEL_HLCDC_DISP		BIT(2)
>  #define ATMEL_HLCDC_PWM			BIT(3)
>  #define ATMEL_HLCDC_SIP			BIT(4)
> +#define ATMEL_XLCDC_SD			BIT(5)
> +#define ATMEL_XLCDC_CM			BIT(6)
>  
>  #define ATMEL_HLCDC_SOF			BIT(0)
>  #define ATMEL_HLCDC_SYNCDIS		BIT(1)
