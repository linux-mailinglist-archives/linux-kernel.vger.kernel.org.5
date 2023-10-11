Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0431F7C57F7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjJKPVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjJKPVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:21:13 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07407A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:21:11 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bd04558784so5043969a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1697037670; x=1697642470; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dfNYmjm/uFgx111cfPaMERYkgdpgrFgbtQwTcUB7K4U=;
        b=eABFgWMlppCYjF+kcXksHEOHgw90HNj76lFXVonmQF8p50JPStLLanJRTQ+QNrGwQi
         S+GtVY+H3zo/NkfcK7armaI/fFTmKdRZ0U8+WGTm0SqYIllojKRfHvRewmyjhwxP5Bcf
         +YQ9nj0UFf3fhbnqjhJ/6CO2NfuAPDyUGEl2f6AmUialz8x+U8XCHwLNT2uUxFX2cafS
         XdTCuaU2HyJOYyGlUYLyD6U2VkeGok26zcfZ0rtCbXnLPeEY6eoLnr50MrAUMbj4fCgq
         i7REsRwx91TL8ewMRAWvZOIhHe/AtBDzqnOQWmHR8h5KcbIjO5M5iW38Jhp5qWwMnedP
         EFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697037670; x=1697642470;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfNYmjm/uFgx111cfPaMERYkgdpgrFgbtQwTcUB7K4U=;
        b=o41s51vQsim6T144aImDdQM5H8NumYOkqk7H6y6InbwnUj6K4RqVx3gfINBIgKbgNO
         7FffRr/6tBdvZQOOlJvIL+Osc9OAwfDdwTTKi6MRTzrZf6i5tuQYsfAY8PMcRy+EqrY7
         aNRaUycGrBRsuzlF4ybDLwjauN7JWJWcKJqmBBb1W7nxNwOHZf9LdT7jbIhPNBw/RrAH
         XuikbXBW4HRozj9mwBFnYh3T9gVxnsVsmcV/1qz4xF6Y55CdG318vr4jlSSykgltaRj9
         Ud0gE5KCKUiKRTlYHagbtQIbBIUyqDHxAMQwjBu+SG5f7ECC96opQ8sD9DP0g7RieAGP
         BeRw==
X-Gm-Message-State: AOJu0YxxLv+pgXhoPoOmrY6XdeO+sS5CvM9FH+YB4w08Jkbqnn2N+qaC
        Rr2aDYvJ6LKQZnIVmAodJX9kmvPLX1qQLkM9Rz+QlA==
X-Google-Smtp-Source: AGHT+IEfshJitRCRQHy6kukyaj1QhoumhCmEaw+rt3b41dzH+jEO1FCFjVWPqToDbaQ0e3gNW0uqkA==
X-Received: by 2002:a05:6830:ca:b0:6c4:ded2:44d0 with SMTP id x10-20020a05683000ca00b006c4ded244d0mr23749841oto.27.1697037670271;
        Wed, 11 Oct 2023 08:21:10 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:a4b3::580])
        by smtp.gmail.com with ESMTPSA id fy11-20020a05622a5a0b00b004198d026be6sm5449755qtb.35.2023.10.11.08.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:21:09 -0700 (PDT)
Message-ID: <5d4fd4848e8a0e9cd33c9777a99189c2c1f79333.camel@ndufresne.ca>
Subject: Re: [PATCH 2/7] media: hantro: add support for STM32MP25 VDEC
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Date:   Wed, 11 Oct 2023 11:21:08 -0400
In-Reply-To: <20231004091552.3531659-3-hugues.fruchet@foss.st.com>
References: <20231004091552.3531659-1-hugues.fruchet@foss.st.com>
         <20231004091552.3531659-3-hugues.fruchet@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mercredi 04 octobre 2023 =C3=A0 11:15 +0200, Hugues Fruchet a =C3=A9crit=
=C2=A0:
> Add support for STM32MP25 VDEC video hardware decoder.
> H264/VP8 decoding up to 4080x4080.
> No post-processor support.
> VDEC has its own reset/clock/irq.
>=20
> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
> ---
>  drivers/media/platform/verisilicon/Kconfig    | 14 ++-
>  drivers/media/platform/verisilicon/Makefile   |  3 +
>  .../media/platform/verisilicon/hantro_drv.c   |  3 +
>  .../media/platform/verisilicon/hantro_hw.h    |  1 +
>  .../platform/verisilicon/stm32mp25_vdec_hw.c  | 92 +++++++++++++++++++
>  5 files changed, 110 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/media/platform/verisilicon/stm32mp25_vdec_hw.=
c
>=20
> diff --git a/drivers/media/platform/verisilicon/Kconfig b/drivers/media/p=
latform/verisilicon/Kconfig
> index e65b836b9d78..7642ff9cf96c 100644
> --- a/drivers/media/platform/verisilicon/Kconfig
> +++ b/drivers/media/platform/verisilicon/Kconfig
> @@ -4,7 +4,7 @@ comment "Verisilicon media platform drivers"
> =20
>  config VIDEO_HANTRO
>  	tristate "Hantro VPU driver"
> -	depends on ARCH_MXC || ARCH_ROCKCHIP || ARCH_AT91 || ARCH_SUNXI || COMP=
ILE_TEST
> +	depends on ARCH_MXC || ARCH_ROCKCHIP || ARCH_AT91 || ARCH_SUNXI || ARCH=
_STM32 || COMPILE_TEST
>  	depends on V4L_MEM2MEM_DRIVERS
>  	depends on VIDEO_DEV
>  	select MEDIA_CONTROLLER
> @@ -16,8 +16,8 @@ config VIDEO_HANTRO
>  	select V4L2_VP9
>  	help
>  	  Support for the Hantro IP based Video Processing Units present on
> -	  Rockchip and NXP i.MX8M SoCs, which accelerate video and image
> -	  encoding and decoding.
> +	  Rockchip, NXP i.MX8M and STM32MP25 SoCs, which accelerate video
> +	  and image encoding and decoding.
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called hantro-vpu.
> =20
> @@ -52,3 +52,11 @@ config VIDEO_HANTRO_SUNXI
>  	default y
>  	help
>  	  Enable support for H6 SoC.
> +
> +config VIDEO_HANTRO_STM32MP25
> +	bool "Hantro STM32MP25 support"
> +	depends on VIDEO_HANTRO
> +	depends on ARCH_STM32 || COMPILE_TEST
> +	default y
> +	help
> +	  Enable support for STM32MP25 SoCs.
> diff --git a/drivers/media/platform/verisilicon/Makefile b/drivers/media/=
platform/verisilicon/Makefile
> index 6ad2ef885920..5854e0f0dd32 100644
> --- a/drivers/media/platform/verisilicon/Makefile
> +++ b/drivers/media/platform/verisilicon/Makefile
> @@ -39,3 +39,6 @@ hantro-vpu-$(CONFIG_VIDEO_HANTRO_ROCKCHIP) +=3D \
> =20
>  hantro-vpu-$(CONFIG_VIDEO_HANTRO_SUNXI) +=3D \
>  		sunxi_vpu_hw.o
> +
> +hantro-vpu-$(CONFIG_VIDEO_HANTRO_STM32MP25) +=3D \
> +		stm32mp25_vdec_hw.o
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index 423fc85d79ee..8c6e0c66f0cd 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -732,6 +732,9 @@ static const struct of_device_id of_hantro_match[] =
=3D {
>  #endif
>  #ifdef CONFIG_VIDEO_HANTRO_SUNXI
>  	{ .compatible =3D "allwinner,sun50i-h6-vpu-g2", .data =3D &sunxi_vpu_va=
riant, },
> +#endif
> +#ifdef CONFIG_VIDEO_HANTRO_STM32MP25
> +	{ .compatible =3D "st,stm32mp25-vdec", .data =3D &stm32mp25_vdec_varian=
t, },
>  #endif
>  	{ /* sentinel */ }
>  };
> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/med=
ia/platform/verisilicon/hantro_hw.h
> index 7f33f7b07ce4..b7eccc1a96fc 100644
> --- a/drivers/media/platform/verisilicon/hantro_hw.h
> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
> @@ -406,6 +406,7 @@ extern const struct hantro_variant rk3568_vpu_variant=
;
>  extern const struct hantro_variant rk3588_vpu981_variant;
>  extern const struct hantro_variant sama5d4_vdec_variant;
>  extern const struct hantro_variant sunxi_vpu_variant;
> +extern const struct hantro_variant stm32mp25_vdec_variant;
> =20
>  extern const struct hantro_postproc_ops hantro_g1_postproc_ops;
>  extern const struct hantro_postproc_ops hantro_g2_postproc_ops;
> diff --git a/drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c b/dri=
vers/media/platform/verisilicon/stm32mp25_vdec_hw.c
> new file mode 100644
> index 000000000000..c9f107bc09db
> --- /dev/null
> +++ b/drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * STM32MP25 VDEC video decoder driver
> + *
> + * Copyright (C) STMicroelectronics SA 2022
> + * Authors: Hugues Fruchet <hugues.fruchet@foss.st.com>
> + *          for STMicroelectronics.
> + *
> + */
> +
> +#include "hantro.h"
> +
> +/*
> + * Supported formats.
> + */
> +
> +static const struct hantro_fmt stm32mp25_vdec_fmts[] =3D {
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_NV12,
> +		.codec_mode =3D HANTRO_MODE_NONE,
> +		.frmsize =3D {
> +			.min_width =3D 96,

This is suspicious, this would be the only "implementation" with that minim=
um.
Have you tested FMT_MIN_WIDTH/FMT_MIN_HEIGHT (48) ?

> +			.max_width =3D 4080,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D 96,
> +			.max_height =3D 4080,
> +			.step_height =3D MB_DIM,

My own datasheet says that the 4K fuse register means max width of 4096, we=
re
did these numbers came from ? My first impression would be that that the co=
rrect
values are FMT_4K_WIDTH / FMT_4K_HEIGHT.

p.s. a lot of the max/min are simply copied from SoC white paper in this dr=
iver,
this is a known issue, or perhaps a non-issue considering that at maximum
hardware capacity, the resulting performance might not be worth using the
hardware accelerator in the first place.

> +		},
> +	},
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_VP8_FRAME,
> +		.codec_mode =3D HANTRO_MODE_VP8_DEC,
> +		.max_depth =3D 2,
> +		.frmsize =3D {
> +			.min_width =3D 96,
> +			.max_width =3D 4080,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D 96,
> +			.max_height =3D 4080,
> +			.step_height =3D MB_DIM,
> +		},
> +	},
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_H264_SLICE,
> +		.codec_mode =3D HANTRO_MODE_H264_DEC,
> +		.max_depth =3D 2,
> +		.frmsize =3D {
> +			.min_width =3D 96,
> +			.max_width =3D 4080,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D 96,
> +			.max_height =3D 4080,
> +			.step_height =3D MB_DIM,
> +		},
> +	},
> +};
> +
> +/*
> + * Supported codec ops.
> + */
> +
> +static const struct hantro_codec_ops stm32mp25_vdec_codec_ops[] =3D {
> +	[HANTRO_MODE_VP8_DEC] =3D {
> +		.run =3D hantro_g1_vp8_dec_run,
> +		.reset =3D hantro_g1_reset,
> +		.init =3D hantro_vp8_dec_init,
> +		.exit =3D hantro_vp8_dec_exit,
> +	},
> +	[HANTRO_MODE_H264_DEC] =3D {
> +		.run =3D hantro_g1_h264_dec_run,
> +		.reset =3D hantro_g1_reset,
> +		.init =3D hantro_h264_dec_init,
> +		.exit =3D hantro_h264_dec_exit,
> +	},
> +};
> +
> +static const struct hantro_irq stm32mp25_irqs[] =3D {
> +	{ "vdec", hantro_g1_irq },
> +};
> +
> +static const char * const stm32mp25_clk_names[] =3D { "vdec-clk" };
> +
> +const struct hantro_variant stm32mp25_vdec_variant =3D {
> +	.dec_fmts =3D stm32mp25_vdec_fmts,
> +	.num_dec_fmts =3D ARRAY_SIZE(stm32mp25_vdec_fmts),
> +	.codec =3D HANTRO_VP8_DECODER | HANTRO_H264_DECODER,
> +	.codec_ops =3D stm32mp25_vdec_codec_ops,
> +	.irqs =3D stm32mp25_irqs,
> +	.num_irqs =3D ARRAY_SIZE(stm32mp25_irqs),
> +	.clk_names =3D stm32mp25_clk_names,
> +	.num_clocks =3D ARRAY_SIZE(stm32mp25_clk_names),
> +};

