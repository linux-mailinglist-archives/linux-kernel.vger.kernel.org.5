Return-Path: <linux-kernel+bounces-79318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0828620B3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B9628559D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D80514DFDA;
	Fri, 23 Feb 2024 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="hYQNp5fd"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A55414D44A;
	Fri, 23 Feb 2024 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731215; cv=none; b=Rl4fMRcfgH8owEKqvFoVGrhEunAPakUtDXfGdmPvjXJ+oVmv1k5z2zEbW+Lxy5hvfvr89IXmQwbMvu5Ba+FT0Cdx9qpT+ocupqaBDWKKtTcmKAWWgC4UGimm1K6SH31aznsxl2Fa8bVjD5Odz5RyYg8N+v3mNacAPYF0WZKvozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731215; c=relaxed/simple;
	bh=QvReWiiur8SYGs5uaKN8mx3ALFlfw1WkRkgG0CneWAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpZ9TJzEsD/bOiL8JB0Vi1RZpzMR+mtP3xxqysse/p76iuRzsfTIsrsBLKfN8nSGVwLNBqp8nInxpoRnH0c+2tCDX2K2BCKnvHcu31PNjox454HEkl/Qiujg3C2eBL8Ytogq7yiS/ggnZn4m+NI2rAzG3tKJpUSv42g0unyohEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=hYQNp5fd; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=l4z91o6goByVRV29UVchlrb57CwSGXGW5ZjXIXoGNv4=;
	b=hYQNp5fdBJql9uj6OdXcc7YuUxjqSiyIQI2kojMiAumVQzTRWbWJU0y+FXuQnC
	67DIjttV4YOzQF96ZGJv3d04elGTCItlQ7DCQ0u9nfoI+yHY9ALgNbEZeDuQUUkn
	44xwCYDUoX1FwbH49F6mMdIc5cjKSu8SajawwGpVnyfKQ=
Received: from dragon (unknown [183.213.196.200])
	by smtp2 (Coremail) with SMTP id C1UQrAC3nYc2K9ll3H48BA--.10236S3;
	Sat, 24 Feb 2024 07:33:11 +0800 (CST)
Date: Sat, 24 Feb 2024 07:33:09 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Manuel Traut <manuel.traut@mt.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6ul: Set macaddress location in ocotp
Message-ID: <ZdkrNfkXGo2pprLW@dragon>
References: <20240208122012.1959628-1-manuel.traut@mt.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208122012.1959628-1-manuel.traut@mt.com>
X-CM-TRANSID:C1UQrAC3nYc2K9ll3H48BA--.10236S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1UCw13Kw1kAFy3KF47XFb_yoW8Xw4fp3
	srWrZ8Gr4IkF1Ikay3Jr1qgr95Aas8tr1FvF17WFyjkay7Za47Kr1kKr13u345ZF4Fyayr
	trs7ur17ur4DtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4Q6JUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDxeNZVnxce-IJgAAso

On Thu, Feb 08, 2024 at 01:19:59PM +0100, Manuel Traut wrote:
> If a bootloader does not configure the MAC address, devices come up with
> a random MAC at the moment.
> 
> ocotp provides registers for storing the mac-address.
> Configure those for i.MX6UL and i.MX6ULL allows net/core to retrieve it from
> there.
> 
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> ---
>  arch/arm/boot/dts/nxp/imx/imx6ul.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
> index a27a7554c2e7..e5e8bf814f77 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
> @@ -538,6 +538,8 @@ fec2: ethernet@20b4000 {
>  				fsl,num-rx-queues = <1>;
>  				fsl,stop-mode = <&gpr 0x10 4>;
>  				fsl,magic-packet;
> +				nvmem-cells = <&fec2_mac_addr>;
> +				nvmem-cell-names = "mac-address";
>  				status = "disabled";
>  			};
>  
> @@ -897,6 +899,8 @@ fec1: ethernet@2188000 {
>  				fsl,num-rx-queues = <1>;
>  				fsl,stop-mode = <&gpr 0x10 3>;
>  				fsl,magic-packet;
> +				nvmem-cells = <&fec1_mac_addr>;
> +				nvmem-cell-names = "mac-address";
>  				status = "disabled";
>  			};
>  
> @@ -1004,6 +1008,14 @@ tempmon_temp_grade: temp-grade@20 {
>  				cpu_speed_grade: speed-grade@10 {
>  					reg = <0x10 4>;
>  				};

Have a newline between nodes.

> +				fec1_mac_addr: mac-addr@88 {
> +					reg = <0x88 6>;
> +				};
> +
> +				fec2_mac_addr: mac-addr@8e {
> +					reg = <0x8e 6>;
> +				};
> +

Dropped this one.

I fixed them up and applied the patch.

Shawn

>  			};
>  
>  			csi: csi@21c4000 {
> -- 
> 2.43.0
> 


