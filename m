Return-Path: <linux-kernel+bounces-33917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2810583702C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B01B1C24AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A726604BD;
	Mon, 22 Jan 2024 18:08:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD2F56478
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946905; cv=none; b=YqdtGE8L6jZZyfpsQw7TqvFW8MBs0G7IUZyqc9K61JDmnF83hoNzaVqWJ2GIJlEii2uyHLIBefcj7FYmsVh65wkhC6aOlbQeyD/hfqmgR9XkLZ+SiNpdkSnjVuWhK7uEcoAsS0bGfHC845kzdWKFitF2TusBsnupRtX+drOi3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946905; c=relaxed/simple;
	bh=GJnKadlNnJS1gno0Yw0zl0W6daCJwsdHG/qNey5ch9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6/pCrIWkoX0chod9GJHtHe894aVVkhqS6T/cgQGB7smULBJ+aFKCDV8sYdcgh1B8xxt1GnTjv/frgXwRPLYAKZfPFZonzYR7Z1uiY2Uc3SDT9JtAYOLnmwzsHU9l00RA8TuWpQpqYlIIIxxGko9bpuxFStPNjcU+09TVyKPo1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiX-000216-SG; Mon, 22 Jan 2024 19:08:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiX-001eQZ-8y; Mon, 22 Jan 2024 19:08:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiX-005ZyJ-0c;
	Mon, 22 Jan 2024 19:08:17 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/33] spi: loopback-test: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:17 +0100
Message-ID:  <ab9c65cee88831da83150eeac1950e20be5a83a7.1705944943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=GJnKadlNnJS1gno0Yw0zl0W6daCJwsdHG/qNey5ch9c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7cFWUHqF/1PJE9bgirCfBKrrnbczVV9Nzd+ 52F1bO91zuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u3AAKCRCPgPtYfRL+ TpjtCACopMzJq78D6c9de/3xtOaBrobZMBg3LSNI9eYsfs1uObHHyCx4hgT9/F2yMX2WoGuznXa qviGmFeToNOOm6Otniy17PoTkr4sTwOuyhc1wC4L5kKSYZ2JlmvajXIhmQ8lAR0lPwV/z9KAgvG pPnN/IeraDAuRTl383rvg4so8DZb1DCSBIIOhOi2qbtRyv/sqiLr1uinuatJopsY0KIjtRyloQA u4I1gzEmgVE3WZ2xSNOLgIqJbMDuimF3TIpsH4DwqkumYH4v6n457I5eA9tSGC4HPj3cw47a7P0 VoolGG6sXwSjdmnJw2zmZ/N4+7MJtReEPNKOxERkqGSdGkk0
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
this driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-loopback-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index bbf2015d8e5c..fee8893d2751 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -1031,8 +1031,8 @@ int spi_test_run_test(struct spi_device *spi, const struct spi_test *test,
 #define FOR_EACH_ALIGNMENT(var)						\
 	for (var = 0;							\
 	    var < (test->iterate_##var ?				\
-			(spi->master->dma_alignment ?			\
-			 spi->master->dma_alignment :			\
+			(spi->controller->dma_alignment ?		\
+			 spi->controller->dma_alignment :		\
 			 test->iterate_##var) :				\
 			1);						\
 	    var++)
-- 
2.43.0


