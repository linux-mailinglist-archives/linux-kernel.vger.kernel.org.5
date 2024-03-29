Return-Path: <linux-kernel+bounces-125443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E32A8925F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D00B22551
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3708713D627;
	Fri, 29 Mar 2024 21:12:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA7513BC16
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746728; cv=none; b=TBuMwzIxV8bLi+qcQI7s2PGRwAUci2EATN5jrtTlBN6GNLx/tn6JU01C3toWyijsJKBWaiPUiPoi8PW2wi/L2Jlcl0ei3WZk05LrXlaEn18ZixKbJOaJKZw1x0hoNBFeoUU1eJGGX/Qg5SEkTvVZ6AWjgDrzekCPXa3HCe6h+ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746728; c=relaxed/simple;
	bh=Abug/1AlTVrkf5hoU+XeSHjL1x+TGk/87EavF9x/BFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JU/LZd64nStTKxcyZOuCu5mhCz8BYDmcPf+2tbejXFNSd5aasduNSS1kKNrZgayu/RiAAygvuYQsdH43R8Ti1TFysmKwCH9aKmrE94ZDo4KkbGUd5OogBXdf2GRA5cqwe0UlLU3h6sULSRk6n+y4tapuU9VzzSHqCi7TmgKfCmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqJVy-0001yH-0S; Fri, 29 Mar 2024 22:11:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqJVx-009GFU-Hx; Fri, 29 Mar 2024 22:11:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqJVx-00DTby-1Y;
	Fri, 29 Mar 2024 22:11:53 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] scsi: a4000t: Mark driver struct with __refdata to prevent section mismatch
Date: Fri, 29 Mar 2024 22:11:42 +0100
Message-ID:  <743c3cfaf12b9f61f66afa5529ac126c856e4d11.1711746359.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Abug/1AlTVrkf5hoU+XeSHjL1x+TGk/87EavF9x/BFc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmBy6QQWBCfh1ljFFUWoreRFgJSKNprv25A13+x KtQHBetN3GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZgcukAAKCRCPgPtYfRL+ TntLB/9EPkvxDhLxC/dP/J1d5lku5oO57nuWP1JUJ24B4Eig/oUqmOIB3+LMhMMLbTuwM24AjHs JrEp/xS0LMeX7ujvmBXYC1O2WpaG+D4VDnlD5AgRqrKFVuyq/flC9Y3kSS1O9a8iX34B5lJDVqz 2xvFVaZF0y8T0pLVMdA7/aT1JoRoqxNSSTJEkrhri98BmQNwP30eLtlkMLvTh7AxhdbuSp6Lb+w GqDbXhdClNSn4M0aep+zJXIn2ccvKyIRzgBcl/OAY6melzUihIWxGwb0pZK/hvPvOeMdQ2MTkGu x/CN54+6ndPif0jaxYsQa8vYbcnOeop6strleN2sBVaWFgsk
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

As described in the added code comment, a reference to .exit.text is ok
for drivers registered via module_platform_driver_probe(). Make this
explicit to prevent the following section mismatch warning

	WARNING: modpost: drivers/scsi/a4000t: section mismatch in reference: amiga_a4000t_scsi_driver+0x8 (section: .data) -> amiga_a4000t_scsi_remove (section: .exit.text)

that triggers on an allmodconfig W=1 build.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/scsi/a4000t.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/a4000t.c b/drivers/scsi/a4000t.c
index e435fc06a624..d9103adc87fe 100644
--- a/drivers/scsi/a4000t.c
+++ b/drivers/scsi/a4000t.c
@@ -108,7 +108,13 @@ static void __exit amiga_a4000t_scsi_remove(struct platform_device *pdev)
 	release_mem_region(res->start, resource_size(res));
 }
 
-static struct platform_driver amiga_a4000t_scsi_driver = {
+/*
+ * amiga_a4000t_scsi_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound at
+ * runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver amiga_a4000t_scsi_driver __refdata = {
 	.remove_new = __exit_p(amiga_a4000t_scsi_remove),
 	.driver   = {
 		.name	= "amiga-a4000t-scsi",
-- 
2.43.0


