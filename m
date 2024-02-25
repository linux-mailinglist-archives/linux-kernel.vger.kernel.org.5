Return-Path: <linux-kernel+bounces-80084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC583862A8D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2301C20B5B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0A013FE7;
	Sun, 25 Feb 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="NCvpJ3gc"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2282C15E96;
	Sun, 25 Feb 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708869414; cv=none; b=fi1ep7hctCl+pPUmPPJW/qJvMTmjkGI9LZ0X1MgyWezihpbZ8hd98ResZDaWPctrdWhjO6QigFfO0SHk51J7G4zxAWhZDPGZ+nYpNVz8u2BwTwQvT724C5FVgU/O68S1/0xUhsaQtW7vOMlmNbALz1UGnbPCNebwmKE12wejUmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708869414; c=relaxed/simple;
	bh=N/cRVtGOgy5HV63A/6OwYzevNp4n/p7tVqsx0cuh4Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ux/dxTDuhXhVPjoA84ZtU5SjuhypPMPDDl2toMiYcp6Hvni5to1sHE5KM9OAldwnr/bILT9dcQUVtI3OWh6GpmlwMO8rfJxfW6puJcHgFMyN3chJOKScwhrJ3/Ot+WqHpDqmlzHD/jTFfs5xwklyuuTq4cJS92zAOazWrCcft+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=NCvpJ3gc; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=qKWEkJYVw81S0VeRuiqVxNM0a7yov2EvZP0Joy7oCnI=;
	b=NCvpJ3gcKV4CmPufB3Oz9V4RT/PE9lRZ7BJNvZCrlk+R30y4yYUa0sSOtqVVmU
	7YT+zMzOeqZK++EKbtpCmZzxDBYuMdUdd44HG02whac3zjldWWDZWFs/jHfXrWpJ
	s/7ETLHBNCTNteO7wyX6iVi/mgOa+iHHs39/+qULRJi/U=
Received: from dragon (unknown [183.213.196.200])
	by smtp1 (Coremail) with SMTP id ClUQrADHjCHxRttlGsJXBA--.13482S3;
	Sun, 25 Feb 2024 21:56:03 +0800 (CST)
Date: Sun, 25 Feb 2024 21:56:01 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 12/16] ARM: dts: nxp: imx6ul: fix touchscreen node name
Message-ID: <ZdtG8SVU36/KOEjP@dragon>
References: <20240224213240.1854709-1-sre@kernel.org>
 <20240224213240.1854709-13-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224213240.1854709-13-sre@kernel.org>
X-CM-TRANSID:ClUQrADHjCHxRttlGsJXBA--.13482S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUalApUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGAKPZV6NnjV6cwABsA

On Sat, Feb 24, 2024 at 10:29:44PM +0100, Sebastian Reichel wrote:
> The canonical node name for touchscreens is "touchscreen",
> so update the i.MX6UL "tsc" node accordingly.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Applied, thanks!


