Return-Path: <linux-kernel+bounces-98150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A530B8775BD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 09:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3906B28332A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 08:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1123C1CD24;
	Sun, 10 Mar 2024 08:06:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA617745
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710057988; cv=none; b=D7OqAnXP1/lStaB2bEsANj7XHsor07vYkiL+EbNcGoPCtN6qMw5q0Eu9IcXlVb8fXR+6YktHPkO0jYYAGRa0nMD9xGJmghcwG2lPUzdc9B4nHjC8SYmstYTvyEZC7xhGDa/ueL5V7F3E7m68yNpybo2GLHO7BeZ4iyfBCROhH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710057988; c=relaxed/simple;
	bh=h3r97+KA3pO8PB92IFOi8Ge/JxkA1X1PoGsiQ8fsG0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExQNZ8b9HvqNKOXlkUyYGHfgwVaIocHV51H7ajiaoJF9Baafdmd8uHo8TZEIOvbZhGEeH9iGG9nfXt5GIS+UGPGg6BpA5oYXb0rR8RnqQorR7caAM1CiH9GlPdxwmkbNDGZeeflTTG3X+cIDfHvILSBtHhlj4pS1RWbQg7RPcoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjECC-00073R-UW; Sun, 10 Mar 2024 09:06:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjECC-005Txw-5w; Sun, 10 Mar 2024 09:06:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjECC-003KQz-0K;
	Sun, 10 Mar 2024 09:06:12 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: William Breathitt Gray <william.gray@linaro.org>
Cc: David Lechner <david@lechnology.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 2/2] counter: ti-eqep: Convert to platform remove callback returning void
Date: Sun, 10 Mar 2024 09:06:07 +0100
Message-ID:  <bf78595f6a49be0b6bb403b466c13177d72c02b7.1710057753.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710057753.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710057753.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=h3r97+KA3pO8PB92IFOi8Ge/JxkA1X1PoGsiQ8fsG0I=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtS3mR+useY0bN28UIt5VoL4rbYuXbHwsv4v3Ynx2X4O8 w3Ot4h1MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCRKyLs/8OjbpbfkKlL+5Yi cpJnWdv62MUxIjsMr8VIPz1yv1K+rEPh4hwFo5TNy0QTg79J2hnGMzHa2nNxGTU1p0zj/hLkphP G88RE+orE0lKWZ/8ehkR17O+5I/Mro/7rhesXe9KFXktdmJzMXdf1MW2a44v5Sq2cFcXKOWc4Hi +496O1KvBWEWNh2ceEvm0TTij/v/P72N/TC0KX7havEBBrb1yq2VBZfeGtp7DW/jMFv+ZGph/6/ TRqyyVD7jsBPJYXDgi+PP40seQcZ2rnlM6FlvY23fZ3asoXWqW82R6u/fBz0LaDv32rFFUd1s8v /xelejx8+2th3labnwXfG5JlsuaLeju9/6PPUqojNUkNAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ti-eqep.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index b0f24cf3e891..072b11fd6b32 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -425,7 +425,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ti_eqep_remove(struct platform_device *pdev)
+static void ti_eqep_remove(struct platform_device *pdev)
 {
 	struct counter_device *counter = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
@@ -433,8 +433,6 @@ static int ti_eqep_remove(struct platform_device *pdev)
 	counter_unregister(counter);
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-
-	return 0;
 }
 
 static const struct of_device_id ti_eqep_of_match[] = {
@@ -445,7 +443,7 @@ MODULE_DEVICE_TABLE(of, ti_eqep_of_match);
 
 static struct platform_driver ti_eqep_driver = {
 	.probe = ti_eqep_probe,
-	.remove = ti_eqep_remove,
+	.remove_new = ti_eqep_remove,
 	.driver = {
 		.name = "ti-eqep-cnt",
 		.of_match_table = ti_eqep_of_match,
-- 
2.43.0


