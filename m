Return-Path: <linux-kernel+bounces-132478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311EF899592
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59CF1F21879
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097B124205;
	Fri,  5 Apr 2024 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="BlHXSaqW"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61204219FC;
	Fri,  5 Apr 2024 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299018; cv=none; b=l7Uv6qbWpN5R7zfxMDtpyfidao6DGNHp0wZM8BqeL+4VfwRydbD/CSz6eZm9a3u0pknr04yPHnXjr1NsbanRPvzYkui4zPDtXmHRJhDdgo61j0Ict0IbL14cHSealWiYhLbtl++pLCXT9/9AkFLVq0tEtnnvTbJ9oDM1mQFy4So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299018; c=relaxed/simple;
	bh=MF9x0u+ja/f5NG5xBWtjLFDFjBEi4bSDETo9bvduU0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzWTrPzxyOFreOj31gP9rxGeyqUQzAcbthNwsgNtTjhNiQbTv1s9lXrJKqf3+c8Lrzi/F0xGR2Z74hsgUQh2rdZThh5kc4cHQV7T/ZEzL8QKE1GArht0cUrcZmFHU/z8fQk5k2WqyB4oc6J3RrutLLYdvFd01HzFtSPGm0+pWSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=BlHXSaqW; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 941101F930;
	Fri,  5 Apr 2024 08:36:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712299013;
	bh=UC3T4Qz0UwYKpOOwA7clFwRt2M9KxDI2AekTfv3g9ns=; h=From:To:Subject;
	b=BlHXSaqWBfs60fQTTc+F47Eq2cXsItS6heieelM4AyiV1KlXwpzlS83Sk5Snl/rDZ
	 8QC2D93r4m01aixdZKcjUoR3mDHhMJtuBdwvt9mhkk2D0UCUZzAlVkkZkrqWGxQhOq
	 uRhupWPIOjE5SUoDFPK+hg3MZaWPfYV709gjmGojrfjPrkDZRj4AvXofOHQ6/HgMjd
	 f1v/2RiUHzoBQB24KudG4hmUNOM3+HS9AxaGwQKOYP7IGESXzuVK3+GwRh7klpnvmL
	 DYmhv00V17Atlh2LNAjgvEuU68j8RMOHfNhYcFCuodm7DpVk8lKjiKtzWF4dmC1uK1
	 G6M47heIyNU4Q==
Date: Fri, 5 Apr 2024 08:36:48 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8qxp-mek: add cm40_i2c, wm8960/wm8962
 and sai[0,1,4,5]
Message-ID: <20240405063648.GA4562@francesco-nb>
References: <20240404161914.1655305-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404161914.1655305-1-Frank.Li@nxp.com>

Hello Frank,

On Thu, Apr 04, 2024 at 12:19:13PM -0400, Frank Li wrote:
> imx8qxp-mek use two kind audio codec, wm8960 and wm8962. Using dummy gpio
> i2c bus mux to connect both i2c devices. One will probe failure and other
> will probe success when devices driver check whoami. So one dtb can cover
> both board configuration.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 210 ++++++++++++++++++
>  1 file changed, 210 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> index 8360bb851ac03..adff87c7cf305 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> @@ -44,6 +51,105 @@ usb3_data_ss: endpoint {

[...]

> +	/*
> +	 * This dummy i2c mux. GPIO actually will not impact selection. At actual boards, only 1
> +	 * device connectted. I2C client driver will check ID when probe. Only matched ID's driver
> +	 * probe successfully.
> +	 */
> +	i2cvmux: i2cmux {
> +		compatible = "i2c-mux-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		mux-gpios = <&lsio_gpio5 0 GPIO_ACTIVE_HIGH>; /* use an unused gpio */

There is for sure people that have more experience and competency that
me and it would be interesting to hear their feedback, but this
looks like a bad hack, and you are just playing with the driver
behavior to ensure that you get what you need.

Francesco



