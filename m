Return-Path: <linux-kernel+bounces-12271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B73281F223
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41B81F231EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22620481A8;
	Wed, 27 Dec 2023 21:03:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561E47F7C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3M-0000le-3j; Wed, 27 Dec 2023 22:03:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3H-001wEi-AR; Wed, 27 Dec 2023 22:02:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3I-001ZVE-0o;
	Wed, 27 Dec 2023 22:02:56 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-sunxi@lists.linux.dev,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	kernel@pengutronix.de
Subject: [PATCH 00/12] mailbox: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 22:02:28 +0100
Message-ID: <cover.1703710628.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2241; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=TnloZYpKIYRmaOM4Vyp6tR8nMUztNxQOKpyjV0rpvQ4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljJDlF5RcQbsMo+jn9Hk4Fn0DGB3DTp1LZRoam 4uXEKKoj2GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYyQ5QAKCRCPgPtYfRL+ TmefCACxCqozxo0GnqWmhu00tf7kElJNTysNznKKdidgf7fo9mcsJuA7Ck125Ja84llYdplJCvv Dsdgd+ignUqSSvOgP0rhHT1pxzc3t9CgKIvLUZMIwaiFUxnPuGs0iLILF0hhUoUb6JLwyAFJw/W pPtgJ/owxsaEcqXJEcIL+CMDaCWvE8mUTxuY4pmJCm6WMPBEM3f8affobB2FMtJ7qI2crJx7ojl xgvXdsuX9EtOecBbxd/N706v8sAbPO2cSehuoXojKHPV81zg+QhoTYPjdqW75nODS26hacjnboO xL/0decenMphAvdsq/GieTqJqbXlITNBQapQQbyLQwxG+KFY
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series converts all platform drivers below drivers/mailbox that
make use of .remove() to use .remove_new() instead.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.
The TL;DR; is to make it harder for driver authors to leak resources
without noticing. The drivers here get it right though and so can be
converted trivially.

This is merge window material. All patches are pairwise independent, so
they can be applied individually.

Best regards
Uwe

Uwe Kleine-König (12):
  mailbox: bcm-flexrm: Convert to platform remove callback returning void
  mailbox: bcm-pdc: Convert to platform remove callback returning void
  mailbox: imx: Convert to platform remove callback returning void
  mailbox: mailbox-test: Convert to platform remove callback returning void
  mailbox: mtk-cmdq: Convert to platform remove callback returning void
  mailbox: omap: Convert to platform remove callback returning void
  mailbox: qcom-apcs-ipc: Convert to platform remove callback returning void
  mailbox: qcom-ipcc: Convert to platform remove callback returning void
  mailbox: stm32-ipcc: Convert to platform remove callback returning void
  mailbox: sun6i-msgbox: Convert to platform remove callback returning void
  mailbox: tegra-hsp: Convert to platform remove callback returning void
  mailbox: zynqmp-ipi: Convert to platform remove callback returning void

 drivers/mailbox/bcm-flexrm-mailbox.c    | 6 ++----
 drivers/mailbox/bcm-pdc-mailbox.c       | 5 ++---
 drivers/mailbox/imx-mailbox.c           | 6 ++----
 drivers/mailbox/mailbox-test.c          | 6 ++----
 drivers/mailbox/mtk-cmdq-mailbox.c      | 5 ++---
 drivers/mailbox/omap-mailbox.c          | 6 ++----
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 6 ++----
 drivers/mailbox/qcom-ipcc.c             | 6 ++----
 drivers/mailbox/stm32-ipcc.c            | 6 ++----
 drivers/mailbox/sun6i-msgbox.c          | 6 ++----
 drivers/mailbox/tegra-hsp.c             | 6 ++----
 drivers/mailbox/zynqmp-ipi-mailbox.c    | 6 ++----
 12 files changed, 24 insertions(+), 46 deletions(-)

base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
-- 
2.43.0


