Return-Path: <linux-kernel+bounces-125440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CDA8925F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EBE1C21415
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F8A13C9D1;
	Fri, 29 Mar 2024 21:12:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAAC13BC2A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746728; cv=none; b=J7jY3j4NGR+S03gvYm+H03xGcc4QUnvebg+md9/MIBMuiyzgcEe9hAVKKeQw6+aIa/U9mDoyQgnm0Tx1si3JWluEjZNmJPn8T8VpDTvP7da4bolKiavvtf4Plw7yz+KgmE+9lAxbxhXgdu5g1CUjCnXSEqoiVo8nkq1d0K+PjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746728; c=relaxed/simple;
	bh=+B0EcHTWfRe9T5vqvoCIeZk3emeJgiZZkzvz79SceLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTh0tBcLHgcHyXCe7TBrf2ONHtClEwjodgGRdpOzipM3qkmvDiH1UUXwQINek5L2SlX/85ysW8EXh5NQTKz8+RjSYLu06al3HPACXqa+EhNiu7LTVcEIy355zjwQlppFFYm2f3U8mJayMietkx1dHLz65b2NPy8S+EUQDR8azow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqJVy-0001yI-D8; Fri, 29 Mar 2024 22:11:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqJVx-009GFX-Ou; Fri, 29 Mar 2024 22:11:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqJVx-00DTc2-2E;
	Fri, 29 Mar 2024 22:11:53 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] scsi: atari_scsi: Mark driver struct with __refdata to prevent section mismatch
Date: Fri, 29 Mar 2024 22:11:43 +0100
Message-ID:  <0170bda7ac0be3d8b694dca1b2f079fb17d9539b.1711746359.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711746359.git.u.kleine-koenig@pengutronix.de>
References: <cover.1711746359.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+B0EcHTWfRe9T5vqvoCIeZk3emeJgiZZkzvz79SceLI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmBy6R2Hxu5ahCRTuWgYqbZUR7wXxX+KB9o2mrn drAu51Y5XSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZgcukQAKCRCPgPtYfRL+ TswvB/9yNSCzyf8x+1PBmtap9Aynu7xZo1qmeWeOk7qFEMxcBKrNT6TUlEW/uX1jylX+/E7S+rz 6B//Pw1yYD3Iv6f9br9/hdRL2MkjyMSRJ+yzt2t2A167Hbhajt1y4sDhYtuRqCgxfcolpfr6bG3 5sFDUTPhgyA84S7eC3bTjQtIyIurIW0IX+f1Lrvx4Gc0CWLdhqXG1SpvKkyKc9wuaxVVg20FIEU 0VZT2jbGtDb/27q3WdOf16OMzsI+ojIFTENOm8HA6idSLTmfqnYSOQyqHzm56TwMdxlsEs3ccXU rHOwVb/Dm6LDcPqmmSjvj6D60TllXTCdZ3Twl8UdG+yQzzDc
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

As described in the added code comment, a reference to .exit.text is ok
for drivers registered via module_platform_driver_probe(). Make this
explicit to prevent the following section mismatch warning

	WARNING: modpost: drivers/scsi/atari_scsi: section mismatch in reference: atari_scsi_driver+0x8 (section: .data) -> atari_scsi_remove (section: .exit.text)

that triggers on an allmodconfig W=1 build.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/scsi/atari_scsi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/atari_scsi.c b/drivers/scsi/atari_scsi.c
index d99e70914817..742625ac7d99 100644
--- a/drivers/scsi/atari_scsi.c
+++ b/drivers/scsi/atari_scsi.c
@@ -878,7 +878,13 @@ static void __exit atari_scsi_remove(struct platform_device *pdev)
 		atari_stram_free(atari_dma_buffer);
 }
 
-static struct platform_driver atari_scsi_driver = {
+/*
+ * atari_scsi_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound at
+ * runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver atari_scsi_driver __refdata = {
 	.remove_new = __exit_p(atari_scsi_remove),
 	.driver = {
 		.name	= DRV_MODULE_NAME,
-- 
2.43.0


