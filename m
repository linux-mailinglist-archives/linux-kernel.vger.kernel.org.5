Return-Path: <linux-kernel+bounces-146369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C7E8A645B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F62284661
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCD06BFCF;
	Tue, 16 Apr 2024 06:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="jRKSkB7y"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D7038FA1;
	Tue, 16 Apr 2024 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250362; cv=none; b=R3U629YPzmJuB6uC/PbDZQGj1p6OehXviVK/yCkII/SZRUHW59OSMxpR34j/31nxUQu9qVHKHBlnKpTrLOq/Qr5KpRh9G18wN9i/OOqDn6c+IFB6Rl8F896MaCEgaZ4cWhGzSRoWLpP/env+jxwQ+dUf/8MqUD0RWOsZcJmG1iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250362; c=relaxed/simple;
	bh=S1pvnXptsueGJlmYzd7gbkzrb6YjO9e15Db/gYxk/3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOHbrs6XeE23BqWBe+Ok3i5/4tkebqwUZlaOr2zB9zy77Ph8/119nBSty2UkaCHk/qPiufOEEa7zpAZJIRHKkGNOYN5BHQIxVwebLzAn+StQ5MaaPwYk+IK34KETPVPSQZYAzcogyoKsYJ18unmus5My5xxhsKI/j74wuMXjRaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=jRKSkB7y; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id B02E01FA40;
	Tue, 16 Apr 2024 08:52:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1713250359;
	bh=cpPQqvE4AvN4kCRAieck8ZZIHFRkfDxfmlvz+nNeJto=; h=From:To:Subject;
	b=jRKSkB7yQnaB6e+QDr2dIF7YvOxIND7oA6gpbo/Gozuxhl+vN479CEd3U16bCMZGJ
	 C0Hr2rWAWTeN5ko9Z0Ud512Xuq7SS8TPouUAVOIDWXr5cUNFS6H4i81nGCQCNaKObr
	 uqzDHWjEbol/AXC8DeIgv72b89uq+2SZJHJlXcEJsbUuMthyWsQmkOMJvy6x+/q4Cd
	 bkRb0mxzIO/d6NeCi5D0RwneygYeGasCNkjMGIfnVoXct9C5f0n9dTKoNrzbFunPwk
	 EI5+CdxLcLX2TVAKCcTH8hJbyuk0z1tnRBgZZCQHAE6glXKJYNNJQ0Y3paD32Ikk5P
	 evrWsvEpy7aCg==
Date: Tue, 16 Apr 2024 08:52:36 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] arm64: dts: imx8qm-mek: add fec2 support
Message-ID: <20240416065236.GB4165@francesco-nb>
References: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
 <20240415-dts_8qm_audio-v1-10-2976c35a0c52@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415-dts_8qm_audio-v1-10-2976c35a0c52@nxp.com>

On Mon, Apr 15, 2024 at 03:46:46PM -0400, Frank Li wrote:
> Add fec2 support.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 40 ++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> index da17161055179..84372c060e200 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> @@ -382,6 +391,19 @@ ethphy1: ethernet-phy@1 {
>  	};
>  };
>  
> +&fec2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec2>;
> +	phy-mode = "rgmii-txid";
> +	phy-handle = <&ethphy1>;
> +	phy-supply = <&reg_fec2_supply>;
> +	fsl,magic-packet;
this is supposed to be just before status, as per DT style guidelines.

> +	nvmem-cells = <&fec_mac1>;
> +	nvmem-cell-names = "mac-address";
> +	rx-internal-delay-ps = <2000>;
> +	status = "okay";
> +};

Francesco


