Return-Path: <linux-kernel+bounces-125442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC92B8925F5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CC9284B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BFA13CF9A;
	Fri, 29 Mar 2024 21:12:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB6D13BC3D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746728; cv=none; b=g/0SNDQ8FbeYHdpp20mp+O/dyq+3U9Hn6OIYrxovDI7nOS+7U74NozIaCR3njyCAJki7v2v9JRtN+LDT2HJeNg1r0LG8qMyIDryBcwXMX3ucmMRlTZ7Ozo5TuMSamB6Wnm9XpYuEkN67I3wuMEX1aWNWDU1YU2k0Kh+xNGt+ShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746728; c=relaxed/simple;
	bh=bKdMOx1D1ms9abbmdlq3OhzYAiylGh+vfVq74VLFAqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8DFYQJk3wLPDMO+8YOGop50Ap+ECtR/sVeqU/45EuJe7U7ENAGn278zDryxxX9QXfZN5yLoY4jvrNubqZnPlv9BjKoTNZgBhwZYYwoN37rFa1MwWtEN+bHZpA8EuDRay5pORR1vZPubP1hF54+FRUs+g9UB3n0dMaFvgYVPFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqJVy-0001yG-0Q; Fri, 29 Mar 2024 22:11:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqJVx-009GFR-BC; Fri, 29 Mar 2024 22:11:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqJVx-00DTbu-0s;
	Fri, 29 Mar 2024 22:11:53 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] scsi: a3000: Mark driver struct with __refdata to prevent section mismatch
Date: Fri, 29 Mar 2024 22:11:41 +0100
Message-ID:  <c7222ad7f0baaff78b19f16e789726d42515f025.1711746359.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=bKdMOx1D1ms9abbmdlq3OhzYAiylGh+vfVq74VLFAqI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmBy6P+LLBanKBe+nswRcMQfjDig8IwRQDd0edP 2le/lg8Ub2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZgcujwAKCRCPgPtYfRL+ TnO8CAClW1s6i+N5UZj8nckRXB2iZWFepVWwMVK5aeqULpdOk/7G295An1wcD0C1418mVSFEK8a +WbDZrMfKRqqFmhhMjMxCN7PTqBftKCsrJS2jWG0jDtoXI8xw/EuvWK31TxYrrXd6fLpukonF5i EDWGIAfoqiyVvrrI/TJdR182Gl0bIm5DxgR53j7kM7+mxMWH/iAK71jD3/x8Rf9HD5PMVTMxUnp ndfm3Ee3eWHYTnXFDH8EcnSOOxqVePxuA+ZkIc2Axa3Spt3TJ4r13+LXP/VYwm4viH90mu+ZS0U BgeBAcHFEwHXZR0YWoPetpGIRqBMOZXnHkyES6i+gHjQM1Si
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

As described in the added code comment, a reference to .exit.text is ok
for drivers registered via module_platform_driver_probe(). Make this
explicit to prevent the following section mismatch warning

	WARNING: modpost: drivers/scsi/a3000: section mismatch in reference: amiga_a3000_scsi_driver+0x8 (section: .data) -> amiga_a3000_scsi_remove (section: .exit.text)

that triggers on an allmodconfig W=1 build.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/scsi/a3000.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/a3000.c b/drivers/scsi/a3000.c
index 378906f77909..ad39797890e5 100644
--- a/drivers/scsi/a3000.c
+++ b/drivers/scsi/a3000.c
@@ -295,7 +295,13 @@ static void __exit amiga_a3000_scsi_remove(struct platform_device *pdev)
 	release_mem_region(res->start, resource_size(res));
 }
 
-static struct platform_driver amiga_a3000_scsi_driver = {
+/*
+ * amiga_a3000_scsi_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound at
+ * runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver amiga_a3000_scsi_driver __refdata = {
 	.remove_new = __exit_p(amiga_a3000_scsi_remove),
 	.driver   = {
 		.name	= "amiga-a3000-scsi",
-- 
2.43.0


