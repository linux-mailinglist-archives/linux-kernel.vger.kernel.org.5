Return-Path: <linux-kernel+bounces-167310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF398BA794
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5C328430F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCAB146D4B;
	Fri,  3 May 2024 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3NDGRMR"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB271146A6F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720812; cv=none; b=lMSHS7nDi0gYj5qJ8uBCodJhcYGm5xlH7sSq0MYj093keEh2pQlZkF2qZilLchi8RUhSn4fsdygZYhH7afFAk694bVsMaJiB2BKUQ0WkJbauPIDIrnKTPYY26JiFRrnXNBaTWSFz/V1P1xPig3yLqvaESMl1QP9yygmSU2whO1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720812; c=relaxed/simple;
	bh=9wIaPeFAaUloh+tV0Kf/Zmc8dIfcbAIB89NynZIAYBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyuJYHD343vVV1DoJEvZ7QRGA+SFprsrQRPIBCfWt0y4b3OfcBpz1vQCXVe+xwpnzsYoJWgc1/lT8kP5LbgaBWiv/zyO2SKYi5vrkRH+zu3OQiyET0RNFw1NSleO55qW4AmVB4mDsfXaA4NTiXwtqCSnt2lZDXeCNBpqROpn/us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K3NDGRMR; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de60d05adafso4555600276.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 00:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714720810; x=1715325610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9wIaPeFAaUloh+tV0Kf/Zmc8dIfcbAIB89NynZIAYBA=;
        b=K3NDGRMRh175rj4pKMzS8Pf/zz8LzbdOk+IvF4C4dlp0pUVg9xsOaKWv6pBo9BkO4o
         /aU+FPMulD6/ni4e916Lmrt/EhYv3VW7EWQCYMv5MCNEJDCiGOw7Omri5Jr2zkotEBnE
         RFRFnzsWPoS3HlN2y5UHdPKGF/cAw8pCUg+IFvTUdgStG+ed6AXYAzm0KY6jSJXd+HRh
         W6tlgTIKg8b+AkMSZ+tEUTsEtrGx+zukPxEta+dKeOdwOfLigEKdEHuB6Fyb+GJYdfxS
         ASjD7VSAeZt/6UMmrxc+DeHAeFveVGJPSRqo7i4hgDRJbo45CeY+QR5AN2PfGp+R/Mcx
         9HSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714720810; x=1715325610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wIaPeFAaUloh+tV0Kf/Zmc8dIfcbAIB89NynZIAYBA=;
        b=r5LZYrLX4V64YTdq2BjwWcM14PSsdhnduoadCFGndxnNnHAd1YxIVVCH/QvI7K2eP/
         4X1LsVvxSWE9UyMNXgHhAIlBfVxFqrixS3slymy3yBz5zvH0DNnvlUWeXKg9vPwLhdRa
         NqRRHJLJz1zaQ+HL8NNQ0/skWxtfabhgRtSSY8kGnsqN0N2KreoD7CYF3x3GVjYX/meF
         eVh9A3hoYpMCrsFmHCfL20h2bKOaiwTyayNWfghrcZIWj54xreaojSM/IOhXqyQtFNrA
         oexf+aBUAnRAhDmZ5m1yzFtHC4/QTvXwkjJgL9toY5ucgWUxJ3Qwwt1ml/003Ex7DSn/
         UKRA==
X-Forwarded-Encrypted: i=1; AJvYcCX2SK9q2SbwpvYgDL4s2C9EwAPeJzVfkA+bE/cX6thqpFwJgDh7MmqltFO6Odct9Ztnr+wLUmOKRc3IeEu6hl9uAlvABDzVG11UihqF
X-Gm-Message-State: AOJu0YyKYR7ywlOqUnYFHsJ1lrpOtEAzNT4A0+0APjMaXDurh9VvBDhj
	e67i/qAVwIDx2TKihapxIFylcXh5S0SWigcQESLWvtcXmga0YSamJZkMIxySf3/0x6ZurCjKbrA
	BJbdJKViovwbzZBkwQURl9fJI7RqLjZHebvc1sg==
X-Google-Smtp-Source: AGHT+IG2e9YB/XnLTQbvqj0kK4ATPxoJ7R6aIP282PPsbZXF297lXvACY/w/LCEjCFtAwBrhBmRU/mc6jno/5QoxHeQ=
X-Received: by 2002:a05:6902:2203:b0:dc2:2b0d:613e with SMTP id
 dm3-20020a056902220300b00dc22b0d613emr2388159ybb.10.1714720809843; Fri, 03
 May 2024 00:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
In-Reply-To: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 May 2024 09:19:58 +0200
Message-ID: <CACRpkdaRpJw=kHtya2iww7vvm+Bt6-oPMmz-6VzfhZniSoMP3w@mail.gmail.com>
Subject: Re: [PATCH 00/21] pinctrl: Use scope based of_node_put() cleanups
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Emil Renner Berthing <kernel@esmil.dk>, Jianlong Huang <jianlong.huang@starfivetech.com>, 
	Hal Feng <hal.feng@starfivetech.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Heiko Stuebner <heiko@sntech.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Chester Lin <chester62515@gmail.com>, 
	Matthias Brugger <mbrugger@suse.com>, Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Dan Carpenter <dan.carpenter@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	imx@lists.linux.dev, linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

Hi Peng,

thanks for doing this! I am very much in favor of using
scoped management of resources where it makes it easier to
do the right thing.

I agree with Krzysztof's comment that we should avoid scoping
in cases where there is a clear path grab/use/release so the
code is easy to read already as it is. Let's drop those.

I saw there was some patch that was even a fix, perhaps I
should pick that one separately for fixes, but probably it is
non-urgent.

I suppose we will just apply v2 after people had some time to
look at it!

Yours,
Linus Walleij

