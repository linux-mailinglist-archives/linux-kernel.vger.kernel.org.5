Return-Path: <linux-kernel+bounces-127718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABEE894FEA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59935B257B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937025B694;
	Tue,  2 Apr 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="jjco8P1w"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5369A5A4C4;
	Tue,  2 Apr 2024 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053132; cv=none; b=qXXWRx29OyxvUAmJfOqAURiclz3vtrpj1lXaStPV7fvrppUQ8hexGEaZhhTu82B6sFiMY605XuNXpuOXZBegE0ZZV0mVExH14IXz0qgd42s2zqWKJUml3ybBfgmYloR+6NkuXzD6wWAkI+xi/Usakt2UcG5eIedUGWhcZZRCmH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053132; c=relaxed/simple;
	bh=oCCd1NEMOfap/SBGTjeaM0mUdXqfZaCiEI9hX3jv8U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLwOQRqWxZ8rO3pVMLUq3Mbzre/0VDA43PaNXXzwqefvEwWwrK/ngP74J28KTdeIXOJ9Upag6K2H+rzj7BGwrrHWV6GLzWPINwWK7h7I22xH5r4fga3cZATZmcDCxqAoH9ss8Q+y7n6Z2wHdtwc7r7cwKtJHR0K1ajU4pv7/0bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=jjco8P1w; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=TudOynzXL5p6NHhnCOdBHK1d6O7sgae9r5YMMS/KyE8=;
	b=jjco8P1wQsoEcdEjc+TctwBhboJC7E/3c9s0Tmmkp4CInyiRuUq0p/eAyI0te4
	o0VkV8Q8/Zv2DW0tcVDlbSekCrK5heiWkuvtrP3GbmcqKrcO7S7Zc/uBGiqB54jq
	UXFyR8QHpC1J/oktE7A2KVUyr0cSiul5GQWkUdNTSFNZw=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrAAHbxhP2wtmefuoAg--.42789S3;
	Tue, 02 Apr 2024 18:17:52 +0800 (CST)
Date: Tue, 2 Apr 2024 18:17:51 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Vitor Soares <ivitro@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vitor Soares <vitor.soares@toradex.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: freescale: verdin-imx8mp: enable Verdin
 I2C_3_HDMI interface
Message-ID: <ZgvbT6AtxRY+DFsN@dragon>
References: <20240322124620.40250-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322124620.40250-1-ivitro@gmail.com>
X-CM-TRANSID:C1UQrAAHbxhP2wtmefuoAg--.42789S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVpVbDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGBC0ZV6NnqhwdQAAs5

On Fri, Mar 22, 2024 at 12:46:20PM +0000, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> Enable Verdin I2C_3_HDMI interface on iMX8MP Toradex Verdin boards.
> 
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Applied, thanks!


