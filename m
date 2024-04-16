Return-Path: <linux-kernel+bounces-147483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A17B8A7516
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C0FB21B80
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78D713956C;
	Tue, 16 Apr 2024 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="PBcZVa4c"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BAA1386C8;
	Tue, 16 Apr 2024 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713296944; cv=none; b=CLHaUx34BM5xxQxETxOrvkhQ3TZ89OR+MDV9BlBuK0MCL0EWT/dfPXd6Tt4ljKx27PkyE1H6zk54HUQwFQDokomKDYFM1QsXG/bGAQGkN7vlrZ946NFUQKzygrBW6mzqcq3sQFbRj+Xfe3amipBEQKvz81dz24gY+7V/ndOAGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713296944; c=relaxed/simple;
	bh=DRHJkO6kW21lCA8xbVqR0lnoCcT0jw+6x4TIGceqT/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWJeXI0Sq3C2y/BeNywMnPoUD4DdCe0bWqEsmZlNR8oWNoRcjMe/rbkW30zMYiFVYbWgasx1WV3VjBTUoymuKRMmf421PiCieV000690asjM7flbUNTSQDXpVoB5hrdRTU/flbmXvhs3LfnB5csuilPj7Z4Mp4ceEJaZX5sHTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=PBcZVa4c; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 012F51FA95;
	Tue, 16 Apr 2024 21:48:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1713296933;
	bh=jolt/bWmgNdjRRTMqPywevqRkZPgyOYkBhjw856lYdo=; h=From:To:Subject;
	b=PBcZVa4cg0mVFmI3uTE8852dqxAzDK436gZT9jvdoTf83VrACJi2J8/DYlYI3cLII
	 9sgvOB08nw0yo/5GrZ3F3sBC7LEsrrWhh1naocGWlR3rfBie2tQgXGR3IAd2fa1OcU
	 gmYcMSWrQGU+iCKVjVPNfwkLWOC/ai+foIZD3ZQw0/JYuDtgN2tJ5o+YZv+Vpsk7Ed
	 dKe21O6t/nxHEs8gATTO/VMT3IaD9WdCWb2b3f2uMSF96KA6Pqr9yohVzyvkg/xCKY
	 EPi3izCyV4Jk6oOCeRlfd2YH1Gbzu8bW+yZtwTnvhXovceQp+tVdLSuyAsr+r0BcId
	 izsiS91/0Ui5w==
Date: Tue, 16 Apr 2024 21:48:49 +0200
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
Subject: Re: [PATCH v2 1/1] arm64: dts: imx8qxp-mek: add cm40_i2c, wm8960 and
 sai[0,1,4,5]
Message-ID: <20240416194849.GA4516@francesco-nb>
References: <20240416163256.2121923-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416163256.2121923-1-Frank.Li@nxp.com>

Hello Frank,

On Tue, Apr 16, 2024 at 12:32:56PM -0400, Frank Li wrote:
> Add cm40_i2c, wm8960 and sai[0,1,4,5] for imx8qxp-mek (SCH-38813).
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v1 to v2
>     Remove dummy i2c bus to support both wm8960 and wm8962 boards.
>     Only support old wm8960 boards in this patch, which most popluar in market.
> 
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 139 ++++++++++++++++++
>  1 file changed, 139 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> index 8360bb851ac03..36a7d16f658f8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> @@ -188,6 +205,47 @@ typec_con_ss: endpoint {

..

> +	wm8960: wm8960@1a {
> +		compatible = "wlf,wm8960";
> +		reg = <0x1a>;
> +		clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
> +		clock-names = "mclk";
> +		wlf,shared-lrclk;
> +		wlf,hp-cfg = <2 2 3>;
> +		wlf,gpio-cfg = <1 3>;

wlf,* properties should be last, see DT coding guidelines

Francesco


