Return-Path: <linux-kernel+bounces-13052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF4D81FF03
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67B41F23E85
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A302811185;
	Fri, 29 Dec 2023 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAMLSXQy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B79D10A26;
	Fri, 29 Dec 2023 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e49a0b5caso7591003e87.0;
        Fri, 29 Dec 2023 03:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703847739; x=1704452539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NsD+IB2GT6Qzi6UFqd7zR6s13SfDz8WzYWnYArIREis=;
        b=nAMLSXQyfAOAF30s4eIBTK4KLNyHBeqwrAt5x8PG3P++ouDlOKAbekcTJWJ/6myYEl
         Q4tjN/kTUD72XXVKNvOJnb/51XrFPOuZX/t4J8Mv0WzlscoMU4FLLiSBLXps1evByo0n
         Jpv8fGXMCZFAnsYStdBB7re9JsY/XeLf8x7LwTMLjSoAy0gYKjehMIM90pBCq824g0hp
         y9aZNN1IEgWG4FVx35IAV0qt0UrR9FOrKO5Af/uimHHzBRRV96QtDPOkXv2xw7ZXb2yV
         YA4+ODoCp62qvYoMsfd5NEWTtHip7OKCw1INftcSgiVsyfUunUHkJK7YzB2TYanUKRHr
         Z3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703847739; x=1704452539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsD+IB2GT6Qzi6UFqd7zR6s13SfDz8WzYWnYArIREis=;
        b=FHIBqnqRr9jdoI+2yDHWxGqLyTwpcgtqVbAbM1rEiJ/4P6NaotHjOioQat2kYIzeWt
         KqxaxTVZKJJxxQ3ibACQwonpO0sB1SDrmF1NNJpEZlzISAdE9528u1SlJZ2+U/dpF5dV
         I8SvLcjEb7ffAWXUcZ/qQVfLHPFyZY35zI18g0lz9cSMAwXDGPRsYk80pOXh8yzm8TSw
         N/VuAASIRiHp+fbjK484X/DCs6Pza8xExkjQ9dVeiMcvwuvEXSJAvnMf+YWW2prqhiZj
         mwrpescNLugmitL880J/ROw65xlZjRbju+poZqsg5dovgMd8ppCFfLbAHuiigIRe4M9P
         eBSQ==
X-Gm-Message-State: AOJu0Ywf0xPjgGlHil99iC9SmdJrjfETq8ZetkprHUHfYL9antg49NJf
	wmluFbXojr6nlLykb/iVUgdANS1WHNsOeJnzCsI=
X-Google-Smtp-Source: AGHT+IERL8Fz7j8WMbUOpMCFPbrDbSTtPYypwgal/QfaUZS54vWya0WCGbTSxe/zIN2kyKTgHAh7Lm/csOMuUbNpOMM=
X-Received: by 2002:ac2:4259:0:b0:50e:40bf:e0a4 with SMTP id
 m25-20020ac24259000000b0050e40bfe0a4mr4242506lfl.132.1703847739347; Fri, 29
 Dec 2023 03:02:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228131617.3411561-1-liujianfeng1994@gmail.com> <20231228131617.3411561-3-liujianfeng1994@gmail.com>
In-Reply-To: <20231228131617.3411561-3-liujianfeng1994@gmail.com>
From: Hugh Cole-Baker <sigmaris@gmail.com>
Date: Fri, 29 Dec 2023 11:02:08 +0000
Message-ID: <CAAXNxMRkpM+dSV3azDFgm07ygJrXyS=Htz_h8Z_WMmeG0YZ+ig@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: rockchip: Add Hantro G1 VPU support
 for RK3588
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de, mchehab@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	heiko@sntech.de, sfr@canb.auug.org.au, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Dec 2023 at 13:17, Jianfeng Liu <liujianfeng1994@gmail.com> wrote:
>
> This patch enables Hantro G1 video decoder in RK3588's
> devicetree.
>
> Tested with FFmpeg v4l2_request code taken from [1]
> with MPEG2, H.264 and VP8 samples.
>
> [1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/multimedia/ffmpeg/patches/v4l2-request/ffmpeg-001-v4l2-request.patch
>
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 5fb0baf8a..5da668184 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -640,6 +640,26 @@ i2c0: i2c@fd880000 {
>                 status = "disabled";
>         };
>
> +       vpu: video-codec@fdb50400 {

The node name should be video-codec@fdb50000 to match the reg address.

> +               compatible = "rockchip,rk3588-vpu";
> +               reg = <0x0 0xfdb50000 0x0 0x800>;
> +               interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
> +               clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
> +               clock-names = "aclk", "hclk";
> +               iommus = <&vdpu_mmu>;
> +               power-domains = <&power RK3588_PD_VDPU>;
> +       };
> +
> +       vdpu_mmu: iommu@fdb50800 {
> +               compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
> +               reg = <0x0 0xfdb50800 0x0 0x40>;
> +               interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
> +               clock-names = "aclk", "iface";
> +               clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
> +               power-domains = <&power RK3588_PD_VDPU>;
> +               #iommu-cells = <0>;
> +       };
> +
>         vop: vop@fdd90000 {
>                 compatible = "rockchip,rk3588-vop";
>                 reg = <0x0 0xfdd90000 0x0 0x4200>, <0x0 0xfdd95000 0x0 0x1000>;
> --
> 2.34.1

