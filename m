Return-Path: <linux-kernel+bounces-133862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF989AA10
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299332836C7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C462575A;
	Sat,  6 Apr 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuYAz4FM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EE024A06;
	Sat,  6 Apr 2024 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395120; cv=none; b=Q8rrSCmf8A2V15n8WdmE3C7VgoP9lqnrEX8bdRHgyKlgN5vz6eS8IyM3EsdJRcb+ERWQ/UgzjwUg9uSb39j/JXq2sYN2B3FI4wWXxOfbnr9aJ7yz5MAn96jHyYDDLxF6UAlRMic3HO6AdHDHYbWZNMlbLstY9Fb47bkODAVGV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395120; c=relaxed/simple;
	bh=srWDqFupvZIFWW4YuJg9/k4T6xavGfgaXIAS7e13Kko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n4x2oC3+ZLzt3PFcJsnrtkQ2NQgTAxgp9mFPKcfceRKyPWHZgAjSliucDGWrig8K3F6JhqX5/FWzUwDZf0b6iryMPpFimpoRUwoef1pvmoOEMU24YKMH74uKVYz/m4UGkGFtNl/z8gZg9cpvqzdIoOPQWDN4W8/Z4GLM/mJq8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuYAz4FM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2D1C433F1;
	Sat,  6 Apr 2024 09:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712395120;
	bh=srWDqFupvZIFWW4YuJg9/k4T6xavGfgaXIAS7e13Kko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JuYAz4FMXeLoVF7y6YymuOAgO0ndvqFogoacYc2yFzZFuzEjf9P7rd1qdQRjBCMoj
	 BYEDb0xtj1oR3oIp1ipb77zrlwdVVRQL4j40o+Ie23nYUWxYdXaK69aw6PAey4Aq7O
	 rogIOW6Q9/AwMnLMGPct5Djexz/lEQgbAu/QrVX5EsD+DwXYnvJyEQuUnvMVuYCw0L
	 shXbzAlyfW8rzmhjNqpQt/WpaCZG/KzWw9cIKrPS1m10xfDXBdvrd06JkdhrHltW06
	 gBYFooD+7c52V8tCKcAv5Iy6gScNMo/6dd1gz63klI0iiKAn4j2GldO018D7jz+6on
	 eBW+hicw4xgSg==
From: Vinod Koul <vkoul@kernel.org>
To: linux-phy@lists.infradead.org, Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-imx@nxp.com, Lucas Stach <l.stach@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, 
 Richard Zhu <hongxing.zhu@nxp.com>, linux-kernel@vger.kernel.org, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Tim Harvey <tharvey@gateworks.com>, Yang Li <yang.lee@linux.alibaba.com>, 
 imx@lists.linux.dev
In-Reply-To: <20240322130646.1016630-1-marcel@ziswiler.com>
References: <20240322130646.1016630-1-marcel@ziswiler.com>
Subject: Re: [PATCH v1 0/1] phy: freescale: imx8m-pcie: facing pcie link-up
 instability
Message-Id: <171239511427.352254.8525089049107113141.b4-ty@kernel.org>
Date: Sat, 06 Apr 2024 14:48:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 22 Mar 2024 14:06:31 +0100, Marcel Ziswiler wrote:
> In our automated testing setup, we use Delock Mini-PCIe SATA cards [1].
> While this setup has proven very stable overall we noticed upstream on
> the i.MX8M Mini fails quite regularly (about 50/50) to bring up the PCIe
> link while with NXP's downstream BSP 5.15.71_2.2.2 it always works. As
> that old downstream stuff was quite different, I first also tried NXP's
> latest downstream BSP 6.1.55_2.2.0 which from a PCIe point of view is
> fairly vanilla, however, also there the PCIe link-up was not stable.
> Comparing and debugging I noticed that upstream explicitly configures
> the AUX_PLL_REFCLK_SEL to I_PLL_REFCLK_FROM_SYSPLL while working
> downstream [2] leaving it at reset defaults of AUX_IN (PLL clock).
> Unfortunately, the TRM does not mention any further details about this
> register (both for the i.MX 8M Mini as well as the Plus). Maybe somebody
> from NXP could further comment on this?
> 
> [...]

Applied, thanks!

[1/1] phy: freescale: imx8m-pcie: fix pcie link-up instability
      commit: 3a161017f1de55cc48be81f6156004c151f32677

Best regards,
-- 
~Vinod



