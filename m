Return-Path: <linux-kernel+bounces-25825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3BF82D662
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159301F225B5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA303F508;
	Mon, 15 Jan 2024 09:52:47 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BFFF4E7;
	Mon, 15 Jan 2024 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.96)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1rPJdb-000XGc-1V;
	Mon, 15 Jan 2024 10:52:11 +0100
Date: Mon, 15 Jan 2024 10:52:11 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: vf610: allow disabling the vf610 driver
Message-ID: <ZaUAS2syv-hnE7qS@v2202401214221251712.nicesrv.de>
References: <20240111150429.681567-1-martin@kaiser.cx>
 <DU0PR04MB9417956F985780AD85FD733E886F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417956F985780AD85FD733E886F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Hi Peng,

Thus wrote Peng Fan (peng.fan@nxp.com):

> Thanks Linus for Ccing me.

I did already Cc you on the initial patch. My hope was to get feedback about
unwanted side effects.

> > Subject: [PATCH] gpio: vf610: allow disabling the vf610 driver

> > The vf610 gpio driver is enabled by default for all i.MX machines, without any
> > option to disable it in a board-specific config file.

> > Most i.MX chipsets have no hardware for this driver. Change the default to
> > enable GPIO_VF610 for SOC_VF610 and disable it otherwise.

> > Add a text description after the bool type, this makes the driver selectable by
> > make config etc. i.MX chips other than SOC_VF610 can now enable the driver
> > from their board config.

> This will break i.MX8QM,DXL,ULP/i.MX93 boot. You could add text description
> to make it selectable, but please not drop def y. Or you need update defconfig.

Thanks for bringing this up.

It seems to me that other gpio drivers are disabled by default and enabled
where needed. I suggest adding CONFIG_GPIO_VF610=y to
arch/arm64/configs/defconfig and probably also to
arch/arm/configs/imx_v6_v7_defconfig.

I'll send a v2 with these changes unless you (or someone else) disagree.

Thanks,
Martin

