Return-Path: <linux-kernel+bounces-64479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F85853F00
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7FE1C27EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B4B62801;
	Tue, 13 Feb 2024 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="KHU+A3iT"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568E48480;
	Tue, 13 Feb 2024 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864345; cv=none; b=U1V6+2NDVgjSuB0bQLI3CNKHlypT7FrgaVS2liboer+aJVuRxUoCEO0+H/EHSzXAJklZPr2f0EbF1a4JfXHfqj92LMgrV4/DJ6w1cEjVcBrGpqp1ccGtZ6+RZ5JIuPp4xQRnPSbQMk4KCp6SyDXT2fw9hg72qSrpwy+MVOMid3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864345; c=relaxed/simple;
	bh=KLYrH8Ylikqod5SY8xZFc7IShzY791qjEAAqCu3NKE8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DFoL2DaWiLfNiHlOe99Vbt3icLGQKca9a9ZIMfjN+5fdMRBHw69aDIcvk7qXApzGktgqmKUBnsOQNucDvXXVTMnO8TEO3zYwk6joLvFz75WmDwt6VQ/SAVbK7ZmUYBeJ0U/mEQL0BXCyxY+7iCfTSy03aQ6NnN18R3N71/YLF10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=KHU+A3iT; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from heihei.fritz.box (ppp14-2-125-29.adl-apt-pir-bras32.tpg.internode.on.net [14.2.125.29])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9AC79201BD;
	Wed, 14 Feb 2024 06:45:20 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1707864333;
	bh=rroNdU9BVPUWE5wDt+3REaeJt2znsw1CC54JRzmWpmY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KHU+A3iT+rXyEDnXx+5mY8gdyPd9RWW+IqjkatculYf0WMU9pEWV3lRQCkTDA0EzI
	 xaQRdVv6ONl5bSVVt+LS/QHv9KXR0YT+wOKEzHEk6ENorzt6peBUrGxgmVVbj1w/iy
	 1HjnEw+ZCd2iWua115sYd63cgh4PNaf4kwKyTyoar7mOLyZhESbJxdxIq+yzZzyaNX
	 SW0fRRSQjx4ywPBzEZtsbYSOEQ+k4WVQplTD0W2lni1ygtrlTWCGNAeTjZ9xaf0EWM
	 Dto/KMIkfYa0O5HKCg8KnOdWszlCAKyfH/kkPoEvmSP1qCSUbu5pEXrDsZ9ADFy8aH
	 cV53xTq95Tecw==
Message-ID: <9a67cee101e7e15d5e70553e3929ee2fbd480c1f.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/6] arm: dts: Fix dtc interrupt_provider warnings
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, soc@kernel.org, Shawn Guo
 <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 NXP Linux Team <linux-imx@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>, Tsahee Zidenberg <tsahee@annapurnalabs.com>, Antoine
 Tenart <atenart@kernel.org>, Joel Stanley <joel@jms.id.au>, Ray Jui
 <rjui@broadcom.com>,  Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew@lunn.ch>,  Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,  Jonathan
 =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Stefan
 Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,  =?ISO-8859-1?Q?Beno=EEt?=
 Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Chanho
 Min <chanho.min@lge.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, Linus Walleij <linusw@kernel.org>, Imre Kaloz
 <kaloz@openwrt.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kbuild@vger.kernel.org
Date: Wed, 14 Feb 2024 09:15:14 +1030
In-Reply-To: <20240213-arm-dt-cleanups-v1-2-f2dee1292525@kernel.org>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
	 <20240213-arm-dt-cleanups-v1-2-f2dee1292525@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 13:34 -0600, Rob Herring wrote:
> The dtc interrupt_provider warning is off by default. Fix all the warning=
s
> so it can be enabled.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/boot/dts/amazon/alpine.dtsi                   |  1 -
>  arch/arm/boot/dts/aspeed/aspeed-g4.dtsi                | 14 ------------=
--
>  arch/arm/boot/dts/aspeed/aspeed-g5.dtsi                | 15 +-----------=
---
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi                | 18 ++----------=
------

I wrote a very similar patch just a day or so ago, so thanks :)

For the Aspeed portions:

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

