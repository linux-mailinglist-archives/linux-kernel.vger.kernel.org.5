Return-Path: <linux-kernel+bounces-74474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9038D85D4FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60271C220A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F78E405F7;
	Wed, 21 Feb 2024 09:54:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC43FB2A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509262; cv=none; b=FJ+t9fnKbYSNjhGPcOjpNHBptJddZEYpl2B26gUWbRTCt/BnwBKFN6KhxnkhzfnAHF2YsRPx0bstf/i0YvW4/eHdveE87OYybLBN87v8I04whQOJmSPBQ8UIm7m14m+DjOHly3iphWwfkG+2N93OGvDe5HcdTip/7888bGHHGqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509262; c=relaxed/simple;
	bh=1Z54PMlB3uNqDfv1xecC8r8Edn2ML2Zvp9x4nuVYV3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/lkOw/6/vJy8i4NKB4/6uilIDnlfhU0FqqWd+vUIoYl7KjeLam5Ksl/+EF2+EY8o/tg+gxXv25sOiaRpepQZ72N9KxaIFUr3hEtgiZeji6BV8X+vvSClwdFo/CIO4pf9rahoCElQqRZMd46Sa46VHmFZRgYJ06yisHN+neJw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-0007Gg-8w; Wed, 21 Feb 2024 10:54:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIo-0020pU-Qo; Wed, 21 Feb 2024 10:54:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIo-008mZN-2Q;
	Wed, 21 Feb 2024 10:54:10 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de,
	John Stultz <jstultz@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] misc: hisi_hikey_usb: Convert to platform remove callback returning void
Date: Wed, 21 Feb 2024 10:53:48 +0100
Message-ID:  <8775e9573fec55c5fc04151800829e9aeafc5dda.1708508896.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708508896.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708508896.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1Z54PMlB3uNqDfv1xecC8r8Edn2ML2Zvp9x4nuVYV3s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl1cgv2nbHxGDWaticI3bDrXDbYlbfZUnXlTE+1 zv94VRrZ6+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdXILwAKCRCPgPtYfRL+ Tg4CCAClj1GP7ZrUNgTlSi/kreAIKQ/JhxiKDe18AYkwFXhy6iBSkctLx7qsuIt29uelDFx0KSx E3YteCh6vLx3BPASCUeA1pKoWr9aFwkkuyY3q6qULNG2oB+Q75GwtxU9tQKBArBE8u6ykOXmulP 6g5451qNLZJC1zXJD3xBZYi1UGJm9VOaAXv4U3zKMBTkfDhNLIeAiZsu1c+POgXN4o0qc63GQ+c hMxPV+YK4wjToqrIeLlJgNHTPVdujfSPxKMkQzXNs/wvEQHjmnb70eljV5mRq3obp296Z0cpXCR 778EN4lfI4y4+BwRI4hTzv4hyfI/6gyfx/ygU4xK0A+egwYK
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
 drivers/misc/hisi_hikey_usb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
index 2165ec35a343..8f55db8938e6 100644
--- a/drivers/misc/hisi_hikey_usb.c
+++ b/drivers/misc/hisi_hikey_usb.c
@@ -239,7 +239,7 @@ static int hisi_hikey_usb_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int  hisi_hikey_usb_remove(struct platform_device *pdev)
+static void hisi_hikey_usb_remove(struct platform_device *pdev)
 {
 	struct hisi_hikey_usb *hisi_hikey_usb = platform_get_drvdata(pdev);
 
@@ -251,8 +251,6 @@ static int  hisi_hikey_usb_remove(struct platform_device *pdev)
 	} else {
 		hub_power_ctrl(hisi_hikey_usb, HUB_VBUS_POWER_OFF);
 	}
-
-	return 0;
 }
 
 static const struct of_device_id id_table_hisi_hikey_usb[] = {
@@ -263,7 +261,7 @@ MODULE_DEVICE_TABLE(of, id_table_hisi_hikey_usb);
 
 static struct platform_driver hisi_hikey_usb_driver = {
 	.probe = hisi_hikey_usb_probe,
-	.remove = hisi_hikey_usb_remove,
+	.remove_new = hisi_hikey_usb_remove,
 	.driver = {
 		.name = DEVICE_DRIVER_NAME,
 		.of_match_table = id_table_hisi_hikey_usb,
-- 
2.43.0


