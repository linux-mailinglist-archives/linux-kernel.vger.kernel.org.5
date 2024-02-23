Return-Path: <linux-kernel+bounces-78819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF75861941
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C631F25E38
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0655112FB22;
	Fri, 23 Feb 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="rKxv/KTt"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009A12DD81;
	Fri, 23 Feb 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708760; cv=none; b=u7as/aREbGjNx9iJgkWXfVz31wd/XDIkvfzJlAdNVKTTDQ7sfIJii/gt0eaRmyXPGMVzb/qLuTiqvabzRByePuXQHtYzNmUiXvJyLEyGuVhElUrCw3lEOfis5w/ynVgQsRxoiWgmStySfbEJqKeRPiz9VGVbCinc+1qfYAxdVGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708760; c=relaxed/simple;
	bh=djVppOvAgFVIlgt/WIoVQ6u2hzYwkqEWVq8VEJwptqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFlK8WyPn0jOXs+6Ei/y4VX0AL5v2TjSwbheKIWvEmHp3vaALCeM+ozgI5uzBj89+shwC8IjVbo3fghIqKj+NujqBTtzg6pnQIsKRsNZ3ONfAKn9hGHnIADdPmhzW7/8AeoTfn8dQlsq+ZP2xFvDqLZ944hr3KTvY+pTwx8YW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=rKxv/KTt; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A8D49225AC;
	Fri, 23 Feb 2024 18:19:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1708708748;
	bh=GqOXTbroCo6UamNlREFgTejmjaBG9X8jsQRMkSHXfaw=; h=From:To:Subject;
	b=rKxv/KTtPN1evHqGHGEOrwfrRmANaLCkTpETdw9Rgs7AKH4Pn7kUF4BIUak59M2tf
	 yi+O2aJDTsW2M/NbXL2PL0/oFjffofUEp/eOtDKwliGGQFZ9KX6GxhNiaVEGQItGRw
	 FMzrlC57WS91J1ytQk1bhu6oSk0XXkzZVZAP0RGhqthUVL2heSFSLHgYNAVoVb6hdz
	 R4s2nX2c0VDyOf5Sj7Vy323+GYwAzuA0wS3h59vYzbBAFByaNWKhKidQm3Gxb4jYiD
	 Fiw62mI5DTRu8LVZHyDltyv52R3R+PFtYcvOBBbyWqh3zVczS+5XI2+VRTpzmqX+rh
	 SNn4K2bGK6O9g==
Date: Fri, 23 Feb 2024 18:19:01 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20240223171901.GA22584@francesco-nb>
References: <20240216104255.21052-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216104255.21052-1-francesco@dolcini.it>

On Fri, Feb 16, 2024 at 11:42:55AM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> This fixes the display not working on colibri imx7, the driver fails to
> load with the following error:
> 
>   mxsfb 30730000.lcdif: error -ENODEV: Cannot connect bridge
> 
> NXP i.MX7 LCDIF is connected to both the Parallel LCD Display and to a
> MIPI DSI IP block, currently it's not possible to describe the
> connection to both.
> 
> Remove the port endpoint from the SOC dtsi to prevent regressions, this
> would need to be defined on the board DTS.
> 
> Reported-by: Hiago De Franco <hiagofranco@gmail.com>
> Closes: https://lore.kernel.org/r/34yzygh3mbwpqr2re7nxmhyxy3s7qmqy4vhxvoyxnoguktriur@z66m7gvpqlia/
> Fixes: edbbae7fba49 ("ARM: dts: imx7: add MIPI-DSI support")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Hello Shawn, what do you plan to do with this?

This fixes a regression from v6.8-rc1 and would be nice to have it into
the final v6.8.

Francesco


