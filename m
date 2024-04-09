Return-Path: <linux-kernel+bounces-137364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DA689E10C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E86D1C20EFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E4615622D;
	Tue,  9 Apr 2024 17:03:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752F155382
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682217; cv=none; b=QF+Aw2pXMPi+p3DS+MuLxzVSAGGpfpP1HGiV4eMOC5EkYdrnA2eVvBfKSSxKVhrO0olei9UHpJMTBFRPv3X9bnexpZ7zm04oNLGXruSNqKGk17Bjm4MnMwV88aPxvE7OTix+cP0n3KKz8Ty8HwLKWsNwEwgiMCgqI9/Qa7gCLOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682217; c=relaxed/simple;
	bh=SInnTnTlpk4lC0a1OFt5dfcAXu152vN+6fS/Qz+hcZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HijmMW7Wy74oaHdj/5rjL5+lXLeVzMf53HZ4NaeDP4KeReEucaKv5HLJLIxlAiiDMsN55Bs9lb21e2ClAOaGygHXD5RYkRn3ejQOm/VLwV9mKAC1pjgdXw+8gDLMFy7Fqo8uNXXwMO79xYZxnlR7akWaNZSEVoDGCr9059wjwVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEsE-0003vU-EZ; Tue, 09 Apr 2024 19:03:06 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEsC-00BKy7-Eu; Tue, 09 Apr 2024 19:03:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEsC-00H4tQ-19;
	Tue, 09 Apr 2024 19:03:04 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	linux-tegra@vger.kernel.org
Subject: [PATCH 0/4] gpu: Convert to platform remove callback returning void
Date: Tue,  9 Apr 2024 19:02:47 +0200
Message-ID: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=SInnTnTlpk4lC0a1OFt5dfcAXu152vN+6fS/Qz+hcZ0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFXS3eAV7HI2w8HMoMiE4vmmyNOiQhnxVpMoga STlONQCJeyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhV0twAKCRCPgPtYfRL+ Tm+HB/92rq+dGfXMi0jrB/Ig/F+qBugwFODSuTOyjy9rrlH4AbZ4W23SnRx9za6p66ippE8ctgz 9TSLyCzQFTSC1kUwwpfXiF//p46buUY7wyYNB+1r9bavrmtsfuUkxRiJBk3P/tFZ28590ooBHUf 3yanYVUV6taxIgLBgoTtP0VPRWVc7pF/NM9ROjGokRfxYButJMxp2QFvxylGFwzU5kZnrKx2+z7 85Gu6iiva8+Vvl9PYX0+fizhotAEJuzFoGSIVDJcXGWiZLs34HriSVUiRa5zOOwEIS9Ipfm6RJO 0fV6zSjsXrEXUIyQ4e3uTNm5H9eGFEBBhs3DLnhZuy8EwSdC
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

with some patches sent earlier[1], this series converts all platform
drivers below drivers/gpu to not use struct platform_device::remove()
any more.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.

All conversations are trivial, because the driver's .remove() callbacks
returned zero unconditionally.

There are no interdependencies between these patches. This is merge
window material.

Best regards
Uwe

Uwe Kleine-König (4):
  drm/imagination: Convert to platform remove callback returning void
  drm/mediatek: Convert to platform remove callback returning void
  gpu: host1x: Convert to platform remove callback returning void
  gpu: ipu-v3: Convert to platform remove callback returning void

 drivers/gpu/drm/imagination/pvr_drv.c  | 7 ++-----
 drivers/gpu/drm/mediatek/mtk_padding.c | 5 ++---
 drivers/gpu/host1x/dev.c               | 6 ++----
 drivers/gpu/ipu-v3/ipu-common.c        | 6 ++----
 drivers/gpu/ipu-v3/ipu-pre.c           | 5 ++---
 drivers/gpu/ipu-v3/ipu-prg.c           | 6 ++----
 6 files changed, 12 insertions(+), 23 deletions(-)

base-commit: a053fd3ca5d1b927a8655f239c84b0d790218fda
-- 
2.43.0


