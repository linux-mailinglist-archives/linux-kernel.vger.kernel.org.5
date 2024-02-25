Return-Path: <linux-kernel+bounces-79964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3A3862906
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1A81F217C3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8DD63CF;
	Sun, 25 Feb 2024 03:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="N/eA0FLM"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F1B53A0;
	Sun, 25 Feb 2024 03:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708832360; cv=none; b=oSvpsz82uZIgkQ9wODldGnQheO1ZVxdZwypJQScLz4Wyan6kmN5BfpnLn9qxPcnkLhlyY/qQtdIGkUlzUhIH279LRGSxIiri70uz2zEpkYtRKUl/TgvbQ7+tS2eFQqWt5VO3NjoV2JhwrE/ONtU57QN1/BLIiz5MfMSoJUL2qUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708832360; c=relaxed/simple;
	bh=u7WCIjEpOQKsg1ni3/puehCB5TErmSAdlAtba0R5QoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCbm5ANqCCUIeEbRAR0DiWVavYw3xhKLa9pnUcpnqB5QVgOvqed+SpqTc+e9vKVq/YS6StzRl5BH+uwSsq/wU97FSFisid+R0ClRBuOg7UQ1KAXAfh9Y/rz0ZPsSImajq6PQwwg5p0t2bZWrG6YcRd5Kw97LZCw5Y2lr6N7AuqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=N/eA0FLM; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=3BZz6CYSY0RLqb7uGYPPOD2+QTos9rTXVXkguc6zZB0=;
	b=N/eA0FLMYrdF1EIPQ0boc+Y934+F9NBus66NuyAGB+fDulTvyBJWp6v8z06ySp
	tY1vJriSBjIq7l4nWGMQek+rA4DlgEf3xQ5+Z8chVYF7twSFhGtZEyGe9G1LApom
	hZWvhIJLyoRSyKCYeVUEYqoHScxSZMwkL9mEqDiEznOdw=
Received: from dragon (unknown [183.213.196.200])
	by smtp2 (Coremail) with SMTP id C1UQrAD3H0A7ttplRc1PBA--.39055S3;
	Sun, 25 Feb 2024 11:38:36 +0800 (CST)
Date: Sun, 25 Feb 2024 11:38:34 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	Roland Hieber <rhi@pengutronix.de>,
	Hiago De Franco <hiagofranco@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1] ARM: dts: imx7: remove DSI port endpoints
Message-ID: <Zdq2OhFYa7BOhXxt@dragon>
References: <20240216104255.21052-1-francesco@dolcini.it>
 <20240223171901.GA22584@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223171901.GA22584@francesco-nb>
X-CM-TRANSID:C1UQrAD3H0A7ttplRc1PBA--.39055S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF48ZF1rKw1DGw4UXFW7CFg_yoWkCFX_uF
	1Sv3yIgw4UWFW0q39FqF1F9rWxW3yrJ34jqFWagr43Za4fA34UJF93KryDXwn3Wayftrsx
	u3Z5Krn0vr1qvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn7fQtUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFQ2PZV6Nm6WPWwABsK

On Fri, Feb 23, 2024 at 06:19:01PM +0100, Francesco Dolcini wrote:
> On Fri, Feb 16, 2024 at 11:42:55AM +0100, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > This fixes the display not working on colibri imx7, the driver fails to
> > load with the following error:
> > 
> >   mxsfb 30730000.lcdif: error -ENODEV: Cannot connect bridge
> > 
> > NXP i.MX7 LCDIF is connected to both the Parallel LCD Display and to a
> > MIPI DSI IP block, currently it's not possible to describe the
> > connection to both.
> > 
> > Remove the port endpoint from the SOC dtsi to prevent regressions, this
> > would need to be defined on the board DTS.
> > 
> > Reported-by: Hiago De Franco <hiagofranco@gmail.com>
> > Closes: https://lore.kernel.org/r/34yzygh3mbwpqr2re7nxmhyxy3s7qmqy4vhxvoyxnoguktriur@z66m7gvpqlia/
> > Fixes: edbbae7fba49 ("ARM: dts: imx7: add MIPI-DSI support")
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Hello Shawn, what do you plan to do with this?
> 
> This fixes a regression from v6.8-rc1 and would be nice to have it into
> the final v6.8.

Applied as a fix for 6.8, thanks!


