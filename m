Return-Path: <linux-kernel+bounces-12126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC6481F05F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400451F214C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A954652C;
	Wed, 27 Dec 2023 16:26:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A654643C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWk0-00059r-38; Wed, 27 Dec 2023 17:26:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjx-001tZZ-Qh; Wed, 27 Dec 2023 17:26:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjy-001Wn1-2g;
	Wed, 27 Dec 2023 17:26:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Gabriel Somlo <somlo@cmu.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: kernel@pengutronix.de,
	qemu-devel@nongnu.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] firmware: qemu_fw_cfg: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 17:26:30 +0100
Message-ID:  <8d7d86a24ea36985845c17b6da0933fedbf99ad8.1703693980.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Nuh2zfgdzxmPQm9xjM7Qd8aGlwMSzi2SytLozr/ldNI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljFA4SiZA8Czr5oUw4pC3X33baRdQ2zK8UNaGd qJkOIfRcM+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYxQOAAKCRCPgPtYfRL+ TiVtB/9jFGL9M1pmYrAxhcbUa8Fjt8yPqmgn+z7SvuziuDVEWqFHjFWJ8VQZBJ5zynq/yVPl1f6 urdnJg6eOFNj0PYq6BeEZ0EBhieCqObdsqUavigZblPpdxkoUx+3OknYd6j30HbZY3oT2XIJb7g z8LpDGjq3AtUsQvnbSDQnY2Yo/6iw96gEaXu2oAj6UECO8y+KSbYOOhmw320RX5KTlY0lrGlFl1 JHVQBU5OErrYaujF0lFh2gCB3ZMzwHWgidVCDjnKmdMZShf75AeOFCD20INk02WCoNgbKOxzM6S iYLX9UIsbnWxPSzM3Y6UDLK4MeGi4N/dEn96Fg/SHu+Ia7E2
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
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/firmware/qemu_fw_cfg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 1448f61173b3..03da9a4354f8 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -731,7 +731,7 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int fw_cfg_sysfs_remove(struct platform_device *pdev)
+static void fw_cfg_sysfs_remove(struct platform_device *pdev)
 {
 	pr_debug("fw_cfg: unloading.\n");
 	fw_cfg_sysfs_cache_cleanup();
@@ -739,7 +739,6 @@ static int fw_cfg_sysfs_remove(struct platform_device *pdev)
 	fw_cfg_io_cleanup();
 	fw_cfg_kset_unregister_recursive(fw_cfg_fname_kset);
 	fw_cfg_kobj_cleanup(fw_cfg_sel_ko);
-	return 0;
 }
 
 static const struct of_device_id fw_cfg_sysfs_mmio_match[] = {
@@ -758,7 +757,7 @@ MODULE_DEVICE_TABLE(acpi, fw_cfg_sysfs_acpi_match);
 
 static struct platform_driver fw_cfg_sysfs_driver = {
 	.probe = fw_cfg_sysfs_probe,
-	.remove = fw_cfg_sysfs_remove,
+	.remove_new = fw_cfg_sysfs_remove,
 	.driver = {
 		.name = "fw_cfg",
 		.of_match_table = fw_cfg_sysfs_mmio_match,
-- 
2.43.0


