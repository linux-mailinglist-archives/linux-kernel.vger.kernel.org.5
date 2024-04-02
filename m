Return-Path: <linux-kernel+bounces-127564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A73C8894DB2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C840B22943
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCD545007;
	Tue,  2 Apr 2024 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="WY7ZjIS1"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359A857315;
	Tue,  2 Apr 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046957; cv=none; b=cP+IjKm1Z4bR5eoL2F4tB4uzLPVYB/m+x99M1wxULGZMbohntckSBMRiwcCFfuYVEbrPrKE5UAbIbiQ6opAiAjUJYLpEy6R4vzf69EJWOM3JZU6DMLaIUMNs8ilj6t1rUvsd1hLQgTKrsG+qpUFthBTpOu7qpnovUaC2sNHZEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046957; c=relaxed/simple;
	bh=m1lsPFgluw1lDbgABtZXAsUlTb+3eksNMgaT//vCYKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXx4yI/vk5+xhd33+t2IibPxZJ9+EY+CDeHaX6x/05MsnDacozXnmKEAgbGG6deNtvDs6Zy4Wu4Fh1xlA8A/LlyH2EUTunVJxqt9m9seFPM6rj8AN+M8j8pjeaNCOAvG5PeVASP1j6nBApE1KZd4dvxQQMWt+y9D5DTKxoBVnqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=WY7ZjIS1; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=M3q2o7D5pZ85OztyvHOJ0Lrj1x7gKAWNHO9XsIQgyCI=;
	b=WY7ZjIS1JceGpx3YMaJsQUOcbU7LHMV+fdhIi/fMaWrsVj/fiPhLOunx6UDLSf
	SrX8WUN9X9uhFkcNlO4kuVlwUvI3uZkY70qlfT+uRmcgDI4gaNxELGkmSkWgdcBq
	02hgY6gnV0xqhxnRJIKL8cehVJoHwlNkrY4zHZzfgB05A=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrADX_0ZMwwtm6q+iAQ--.45423S3;
	Tue, 02 Apr 2024 16:35:25 +0800 (CST)
Date: Tue, 2 Apr 2024 16:35:24 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
	conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, peter.chen@kernel.org,
	jun.li@nxp.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 03/11] arm64: dts: imx8ulp-evk: enable usb nodes and
 add ptn5150 nodes
Message-ID: <ZgvDTPiBM65l3F+U@dragon>
References: <20240321081439.541799-1-xu.yang_2@nxp.com>
 <20240321081439.541799-3-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321081439.541799-3-xu.yang_2@nxp.com>
X-CM-TRANSID:ClUQrADX_0ZMwwtm6q+iAQ--.45423S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw47AFyktw1fuFWfJr13Jwb_yoW5XFWkpr
	9rGrsxXw17WF47KF98JrnxKr93Jan3Gr97uw12g340kr1Du347Jr10grn5Wrs8ur43Xw4a
	yFsYgrW2grnF9wUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jseOLUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDQ20ZVszXX09xgAAsi

On Thu, Mar 21, 2024 at 04:14:31PM +0800, Xu Yang wrote:
> Enable 2 USB nodes and add 2 PTN5150 nodes on i.MX8ULP evk board.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v2:
>  - fix format as suggusted by Fabio
>  - add PTN5150 nodes
> Changes in v3:
>  - no changes
> Changes in v4:
>  - no changes
> Changes in v5:
>  - no changes
> Changes in v6:
>  - no changes
> Changes in v7:
>  - no changes
> Changes in v8:
>  - no changes
> Changes in v9:
>  - no changes
> Changes in v10:
>  - no changes
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> index 69dd8e31027c..bf418af31039 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> @@ -133,6 +133,64 @@ pcal6408: gpio@21 {
>  		gpio-controller;
>  		#gpio-cells = <2>;
>  	};
> +
> +	ptn5150_1: typec@1d {

Could you sort devices in unit-address?

> +		compatible = "nxp,ptn5150";
> +		reg = <0x1d>;
> +		int-gpios = <&gpiof 3 IRQ_TYPE_EDGE_FALLING>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_typec1>;
> +		status = "disabled";
> +	};
> +
> +	ptn5150_2: typec@3d {
> +		compatible = "nxp,ptn5150";
> +		reg = <0x3d>;
> +		int-gpios = <&gpiof 5 IRQ_TYPE_EDGE_FALLING>;
> +			pinctrl-names = "default";

Broken indent?

Shawn

> +		pinctrl-0 = <&pinctrl_typec2>;
> +		status = "disabled";
> +	};
> +};
> +
> +&usbotg1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb1>;
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	adp-disable;
> +	over-current-active-low;
> +	status = "okay";
> +};
> +
> +&usbphy1 {
> +	fsl,tx-d-cal = <110>;
> +	status = "okay";
> +};
> +
> +&usbmisc1 {
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb2>;
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	adp-disable;
> +	over-current-active-low;
> +	status = "okay";
> +};
> +
> +&usbphy2 {
> +	fsl,tx-d-cal = <110>;
> +	status = "okay";
> +};
> +
> +&usbmisc2 {
> +	status = "okay";
>  };
>  
>  &usdhc0 {
> @@ -224,6 +282,32 @@ MX8ULP_PAD_PTE13__LPI2C7_SDA	0x20
>  		>;
>  	};
>  
> +	pinctrl_typec1: typec1grp {
> +		fsl,pins = <
> +			MX8ULP_PAD_PTF3__PTF3           0x3
> +		>;
> +	};
> +
> +	pinctrl_typec2: typec2grp {
> +		fsl,pins = <
> +			MX8ULP_PAD_PTF5__PTF5           0x3
> +		>;
> +	};
> +
> +	pinctrl_usb1: usb1grp {
> +		fsl,pins = <
> +			MX8ULP_PAD_PTF2__USB0_ID	0x10003
> +			MX8ULP_PAD_PTF4__USB0_OC	0x10003
> +		>;
> +	};
> +
> +	pinctrl_usb2: usb2grp {
> +		fsl,pins = <
> +			MX8ULP_PAD_PTD23__USB1_ID	0x10003
> +			MX8ULP_PAD_PTF6__USB1_OC	0x10003
> +		>;
> +	};
> +
>  	pinctrl_usdhc0: usdhc0grp {
>  		fsl,pins = <
>  			MX8ULP_PAD_PTD1__SDHC0_CMD	0x3
> -- 
> 2.34.1
> 


