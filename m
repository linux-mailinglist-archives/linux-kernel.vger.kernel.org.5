Return-Path: <linux-kernel+bounces-111465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC58886CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D36B28205B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439F24643A;
	Fri, 22 Mar 2024 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b="dTxUUrjP"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0956B446DB;
	Fri, 22 Mar 2024 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113683; cv=none; b=TMMou4eBt1EOXPSrEfRyhq2WuERDiPHuat3Q6KTqMHTd3PAUwqrENy/O10HOFD25TKFA+XOgTW+cBV8/Eqgoo2TUw5Cxl/m2lePzvyRj0vAiPEJCnqTSV3hrFuG6I49iXBBsZCUcjvPtFCDKiWZSDImWFla4swxGDgf4ToYquRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113683; c=relaxed/simple;
	bh=Bd0ZJKTPLntExIoYJ+0D2Ysg0apX7JcG8SwghE+P+EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fVul9J/my9fA6DtCea1xN47Se7fpRCc7Aepku8t+DnOmLwGyTzo46qDjhOS945oYXRdSgVSOdE68XgjF7jynvSg619NOi3/kbVp0GF6y2RtTBpseAWJORfr9PX57vpUDBSnVWnpOIMvzbqlX4mCuPF2AjlaNZejlt081auA+YHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com; spf=pass smtp.mailfrom=ziswiler.com; dkim=pass (2048-bit key) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b=dTxUUrjP; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziswiler.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
	s=s1-ionos; t=1711113678; x=1711718478; i=marcel@ziswiler.com;
	bh=hS0EhU2hZB+am5BBjCPMGTJbdV4iRS3G7g7Pk6drSvE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=dTxUUrjP+GhOH87HA1yrVu+ckrK+utpsE/aoqv9iOXnXjNUBw2svq7gjA0aJi6HL
	 n3zWmC9nH+Fi4r6Qg1MFp82coHYwxDrzXoVL6G4kkst+wvLhPHyEWHDzi1AQBDI5Y
	 939wf01RaTlBbGNmFu9mXAfCfjb/cgV5jWnSrpIVOQBtuf3Dq9hh+u1WqGRGE8mpZ
	 1xfqVo3zsAa+zes+4tx7VEgA9q8CfD/6Ea8ydFPkbVGq3AYwYTQ/TiQnwFAfiJwef
	 VhNHXxVOj4GmHIqqIOZpMgxNv/dRrtu7xKceaUmrwYJ9QqXU9gmlQ9U5+cYXdfja+
	 rD/QDQaysv9DH/hkIg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost.localdomain ([84.227.227.254]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Levg9-1qy9tL3jfr-00qjkg;
 Fri, 22 Mar 2024 14:07:01 +0100
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-phy@lists.infradead.org
Cc: linux-imx@nxp.com,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de,
	Richard Zhu <hongxing.zhu@nxp.com>,
	linux-kernel@vger.kernel.org,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Vinod Koul <vkoul@kernel.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	imx@lists.linux.dev
Subject: [PATCH v1 0/1] phy: freescale: imx8m-pcie: facing pcie link-up instability
Date: Fri, 22 Mar 2024 14:06:31 +0100
Message-ID: <20240322130646.1016630-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HbksDg0cngIhNhj/kmWLakIVtoaoqkjubx0k/GE+1UTtYoiJPYt
 mvNs7loxfRYXelWDuD4fsUK4rKwuy+r8Fw0tRSxLFQ1zb+LZJjPNssTjvNDybhIDz+I06/X
 5lk5hcLwYe5akl53H65rKfhUjeivfYWV2x1z93gVZvP5rNUpDZxHeDJsm4ARxjyNJhsvAMG
 OZtD6NzwaPq3nD50jo/hQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:74KcX7nW7Lw=;X3qNWHTWhdPGP4Bx7ruOjmlom1t
 jH5YtiuSOPVk+aY+hPN1VCaiVMjSxq6opeaKoSwgnnK8Vaqepb/M2GX/BOokDCU6x6heLdXvt
 CrdJIJVK6szYP09OJznxTK6qzO0HA/FiRe+y7dfqTKkEF+PC9IHBNI2VVeC601uPp+ukIDwDM
 8Te8DrdPzwIMBSd7sYBkd8KXpi/nrNkhFt0FNy3chWnftKRAWNDfvvL524u58DmPSfYH6h/71
 zaXi7de3UV4g0+o3dB4BvXJWWPustT1U9GI+zHzX549MjUhOPtJPN0en8gcSR5KyNP8wSIt6K
 Ut86YRpJFDOHxSf0PfPTZPtm+qzqslbaLDotkbJlc0p1PJznZFnHgiB86Uo/+uMNYHiRyP4u+
 +49/SkjWXTciUd4dxtcziR1weA7q/RpgL7voCba5OnCi4T8y2WJxCOo238hvn3pjowPQ9++m2
 0YtZpU6bdgs1Y7EsTIe4nMFRBR3e74cXbpLq61+f1SSH2tsXWvNqxSP8b4AdwZcbroaooMqWJ
 cfFE7+KNhv9jL9bElajVjjSCX4RwP3fDZwupWRBKTp94SELsjApFnk9lJgTQcP2lL7P9/n9xT
 aiByBGLsD3lUKvhij5JJKAcPHXvjSg42YmuHf89u/V6Gw8eZVKZrv4zIsMrxUIJq1MSMXfahv
 9UqMPySHYwmLz9IVAaCCXfBf30nVcgLvMN8/KKcl+4i5P66rt4q2HrSfopIQBOiSqftBxrgOv
 FouyEfBgQw1GL/puex+bMic26uJvPrX7g==

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


In our automated testing setup, we use Delock Mini-PCIe SATA cards [1].
While this setup has proven very stable overall we noticed upstream on
the i.MX8M Mini fails quite regularly (about 50/50) to bring up the PCIe
link while with NXP's downstream BSP 5.15.71_2.2.2 it always works. As
that old downstream stuff was quite different, I first also tried NXP's
latest downstream BSP 6.1.55_2.2.0 which from a PCIe point of view is
fairly vanilla, however, also there the PCIe link-up was not stable.
Comparing and debugging I noticed that upstream explicitly configures
the AUX_PLL_REFCLK_SEL to I_PLL_REFCLK_FROM_SYSPLL while working
downstream [2] leaving it at reset defaults of AUX_IN (PLL clock).
Unfortunately, the TRM does not mention any further details about this
register (both for the i.MX 8M Mini as well as the Plus). Maybe somebody
from NXP could further comment on this?

BTW: On the i.MX 8M Plus we have not seen any issues with PCIe with the
exact same setup which is why I left it unchanged.

[1] https://www.delock.com/produkt/95233/merkmale.html
[2] https://github.com/nxp-imx/linux-imx/blob/lf-5.15.71-2.2.0/drivers/pci=
/controller/dwc/pci-imx6.c#L1548


Marcel Ziswiler (1):
  phy: freescale: imx8m-pcie: fix pcie link-up instability

 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

=2D-
2.44.0


