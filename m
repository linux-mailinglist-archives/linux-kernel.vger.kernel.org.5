Return-Path: <linux-kernel+bounces-106252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A914187EB70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6CB1C20FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E69C4EB36;
	Mon, 18 Mar 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdxMXb2i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870D2C6B7;
	Mon, 18 Mar 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710773666; cv=none; b=JD4DmvmcD6jMjHs2RpUbqT/xAp1P73pUjSLoxRoHUDNJP7FSYHRs57+gPNTsGLXfgmVAbZf70/J80R0+N/MiLKDDvxu5fjjx0Qxh525W76GHoX+8hP+iPhWnjis09lcNbfBdNPMLRxKCmJDsAwVFfgfBKqjL4Q7ee7JWjUyjpr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710773666; c=relaxed/simple;
	bh=ywjXIx6HmklPsjIr1i1IzyaHa8odZGdCDM27OSINcmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctbxpUvm2bAH26FndHjEHPLkPr4hk4NWsdzmYdAT1cGutYQM7P9FyIkiNFzS+DGvqqOUvB61OO4qE/44u6eZQ3RAZu4K4GsSKlu+IiXhC7jsChOCD6E1kd0lpkiTWkIv/iDbSRRF1a5eE1sv52zIHfOF6ByEvLybqj1PV+G0kvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdxMXb2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D660CC433F1;
	Mon, 18 Mar 2024 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710773666;
	bh=ywjXIx6HmklPsjIr1i1IzyaHa8odZGdCDM27OSINcmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdxMXb2iz+7JsM/SUAYZYz1a0za5xAhxZOCC3lmz+q98zXps0G46eAz43LPzBoHsn
	 67j2U2E6WOpFWw9gsmMa4RPICEsQH7XpodOIBhZfCOPZRDZQrlL4oFPQatyssd2sPw
	 BH/mzt6eQXw1JFkZzOkzubzdLiWh2/M7CM+Ka8ye+662wrxuwr8SCxxrygrKl4Gsg1
	 /G3P/Ru1sNH+HD/YJe0O9YGY2xeuCbVL8NqM/64UstD292013btVgoFU+JyBbJQyZB
	 HorS0tvkqpI3CtDmcIzAMY3ZbVd907Gnr7iPnj4t/Cq6r+usfMMJRdpoVPAfltgbVS
	 cQDML6T2f56HA==
Date: Mon, 18 Mar 2024 09:54:23 -0500
From: Rob Herring <robh@kernel.org>
To: Lucas Tanure <tanure@linux.com>
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>, Yu Tu <yu.tu@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [RFC][PATCH 1/2] clk: meson: T7: add support for Amlogic T7 SoC
 PLL clock driver
Message-ID: <20240318145423.GA3993342-robh@kernel.org>
References: <20240318114346.112935-1-tanure@linux.com>
 <20240318114346.112935-2-tanure@linux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318114346.112935-2-tanure@linux.com>

On Mon, Mar 18, 2024 at 11:43:45AM +0000, Lucas Tanure wrote:
> Add the T7 PLL clock controller driver in the T7 SoC family.
> 
> This is RFC patch that enables SDCard, Ethernet and Clocking
> for Amlogic T7 soc.
> In this current state the patch doesn't work and gives a kernel
> panic when probing the meson-axg-mmc for the SDCard.
> DO NOT MERGE.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  drivers/clk/meson/Kconfig                     |   25 +
>  drivers/clk/meson/Makefile                    |    2 +
>  drivers/clk/meson/t7-peripherals.c            | 6368 +++++++++++++++++
>  drivers/clk/meson/t7-peripherals.h            |  131 +
>  drivers/clk/meson/t7-pll.c                    | 1543 ++++
>  drivers/clk/meson/t7-pll.h                    |   83 +
>  .../clock/amlogic,t7-peripherals-clkc.h       |  410 ++
>  .../dt-bindings/clock/amlogic,t7-pll-clkc.h   |   69 +
>  8 files changed, 8631 insertions(+)
>  create mode 100644 drivers/clk/meson/t7-peripherals.c
>  create mode 100644 drivers/clk/meson/t7-peripherals.h
>  create mode 100644 drivers/clk/meson/t7-pll.c
>  create mode 100644 drivers/clk/meson/t7-pll.h

>  create mode 100644 include/dt-bindings/clock/amlogic,t7-peripherals-clkc.h
>  create mode 100644 include/dt-bindings/clock/amlogic,t7-pll-clkc.h

I'm assuming since this is an RFC you know these go in a separate patch 
with the DT binding schema which is missing.

Rob

