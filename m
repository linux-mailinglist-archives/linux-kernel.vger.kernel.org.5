Return-Path: <linux-kernel+bounces-51958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F18CB8491EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303141C21D4C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AE5D2FF;
	Sun,  4 Feb 2024 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIu3YSea"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8E010A01;
	Sun,  4 Feb 2024 23:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707090710; cv=none; b=MCNGchZiiAXL6IMIkD4Tmq1uuaiKtIozi3XXBX6kTs0kZJUO5cMHjm8EiIzV27B90qIgNX0t7XMy0WiDfzpmno585u5VBdexKoLW7hI+QcUQ3ilFdgFQCkTR8Z0OpcOvmIuJLqg2H2I0V9FhHBTtyPgTb7dsJJ/kUVG4ccGZo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707090710; c=relaxed/simple;
	bh=S5+yOW1fwHQyJj0sOhgYQreMUV92ha/EDUifdia3nD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXuxF9ZXAtpzdiU9sbFwEvJVo5fl4394L7SKR249iqK2ncDU4mMsboJc8yjCtmuCRGjj8fCpaIKgPUY/j90TR5AzdLzkwBfBoMlZbC6OepPMcuT5icIRUL6skKaS/pJp7/Un5erP9u3VTGS3KSmL1zJxIFryFaU/LO706hs3ukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIu3YSea; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d70b0e521eso29269665ad.1;
        Sun, 04 Feb 2024 15:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707090708; x=1707695508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J9c1PueahzlnEV7zj03GiOjDwB/y0QH2NIRlKBvzg9o=;
        b=DIu3YSeaovtVBb98Ghd8Sy/XupmqmDppfTp5Dok3WNbPuNeTXG9HPO/Lppb68FNmY8
         QtOCe69j0utHT/b2xV0T9/LusWt1oOcv5Tvv6T7DAU8QpRguqLhLgz4zQ6MXUN0h4wOs
         UPfhsTOIU8KSIndFYIIlow3yyk7Lt1XC2C3FFJ/i1i6IhvhnGdcLmNZs0HUoGUgQ4xZ9
         d8/LZg0T9nFYg9bDDKmpFzcL1mOHzuZAomLBsnP7TauchLbRl8QiEE9KpcxiQDqgBhcB
         VMkol3F+9Du50aeXdRBPRyusvRKvCTz5E6SKXoajpwN1z/p0bMBF2irxvmCkmUQRrgzW
         2H8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707090708; x=1707695508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9c1PueahzlnEV7zj03GiOjDwB/y0QH2NIRlKBvzg9o=;
        b=OfwLJDySQP+NVgcSP8EQhAmILroxiEulCLQ6M/oAjxsAeEc81O92BqY4Dz6kDH5LEn
         5LRyVAFdnXkk9CXjBvBH4S5VpdEZMY1aJ7upwAJCaTGSFMWkjoFMRcA/Na901CCeUR8q
         yjOZW0RRLwTSfm9fwpqZMii42nVeEhD73CPypHtpjzY4Z8vN7uMWObdylKNeoLmwuZGs
         nK3pVdC+Dfq7zaUiMZoAoHBUA1G+EJ2kTwiLRh30OOuvSBmo6Zy0rxp8+a+3c+XYEkIr
         gHFcnFLqkwwH0tbuRcETFhjtY7eghmdE1fRSggXjN/ujKZDOoB8kBMEgpYez2vz0psnO
         FH/w==
X-Gm-Message-State: AOJu0Yw9csBYOeqVNENarfY/BlL8AY0QORoj6x/C8O6Q2qOFilpzlcjn
	zNmfliFlTHfYo59PcNS+BENVPYTUMd0RtetUH1dRlWiXsHew9Fvc
X-Google-Smtp-Source: AGHT+IEQzf3T/DsZ+gLybq9GG1uTDhww9NauGQ0moQr56uX5Li2129TC8nNekCdGTi7PxOyGDhM7pA==
X-Received: by 2002:a17:902:d581:b0:1d9:3771:4941 with SMTP id k1-20020a170902d58100b001d937714941mr11097435plh.13.1707090708424;
        Sun, 04 Feb 2024 15:51:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUpbnI+zh47PF1z8j6T9Fvd5XduCLwpbldC1cjvXLOEbyGp7jD3tdlmPJhwqpu3d+A5hc/fBSFCZXrynEjbsNii7SW+se1UUzcYydGtLp7766J8UHBC9XmTcreKDIx6hvbEi4s4whIjpJ11Aeg96b685UWSGlITaznAVuCqKD1/LUo6cg2bOZR4zIboWBC+jJKfYsnj+rFUP6JPaj+Ty4pf1BRAPvrroVDJos1RYzYh/vr4zpHRv03R+Lk9sKQkPqqbs036zqJRFeUrk7tKjpuSmbGp0MKlFrf5Yk26tf/f8VKQG9Sv2ZD84FVZqVHCbO/NNqFdiyNK9+u6UHXuAnoV33tVOSNhynpxkB5Y6qej+hXIvYY2TRDfPuOGUAURiU0tIau+7q74KbLLPqdLHIN+dA==
Received: from dragon (89.208.243.31.16clouds.com. [89.208.243.31])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902e2c300b001d9773a1993sm4449951plc.213.2024.02.04.15.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:51:47 -0800 (PST)
Date: Mon, 5 Feb 2024 07:51:34 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-evk: Add PDM micphone sound card
 support
Message-ID: <20240204235134.GA804317@dragon>
References: <1703136188-7222-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1703136188-7222-1-git-send-email-shengjiu.wang@nxp.com>

On Thu, Dec 21, 2023 at 01:23:07PM +0800, Shengjiu Wang wrote:
> Add PDM micphone sound card support, configure the pinmux.
> 
> This sound card supports recording sound from PDM micphone
> and convert the PDM format data to PCM data.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index b53104ed8919..9679786dac51 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -151,6 +151,18 @@ simple-audio-card,codec {
>  			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
>  		};
>  	};
> +
> +	sound-micfil {
> +		compatible = "fsl,imx-audio-card";
> +		model = "micfil-audio";

Have a newline between properties and child node.

> +		pri-dai-link {
> +			link-name = "micfil hifi";
> +			format = "i2s";

Ditto

Shawn

> +			cpu {
> +				sound-dai = <&micfil>;
> +			};
> +		};
> +	};
>  };
>  
>  &A53_0 {
> @@ -434,6 +446,16 @@ &lcdif {
>  	status = "okay";
>  };
>  
> +&micfil {
> +	#sound-dai-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pdm>;
> +	assigned-clocks = <&clk IMX8MM_CLK_PDM>;
> +	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <196608000>;
> +	status = "okay";
> +};
> +
>  &mipi_csi {
>  	status = "okay";
>  
> @@ -636,6 +658,18 @@ MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5       0x41
>  		>;
>  	};
>  
> +	pinctrl_pdm: pdmgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI5_MCLK_SAI5_MCLK        0xd6
> +			MX8MM_IOMUXC_SAI5_RXC_PDM_CLK           0xd6
> +			MX8MM_IOMUXC_SAI5_RXFS_SAI5_RX_SYNC     0xd6
> +			MX8MM_IOMUXC_SAI5_RXD0_PDM_DATA0        0xd6
> +			MX8MM_IOMUXC_SAI5_RXD1_PDM_DATA1        0xd6
> +			MX8MM_IOMUXC_SAI5_RXD2_PDM_DATA2        0xd6
> +			MX8MM_IOMUXC_SAI5_RXD3_PDM_DATA3        0xd6
> +		>;
> +	};
> +
>  	pinctrl_pmic: pmicirqgrp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x141
> -- 
> 2.34.1
> 

