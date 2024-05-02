Return-Path: <linux-kernel+bounces-165972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294228B9415
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEEF81F25859
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D121F95E;
	Thu,  2 May 2024 04:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aIIvqcKW"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1932917997;
	Thu,  2 May 2024 04:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625952; cv=none; b=Nm1IkRnG8hmP8JMFzxiaKBliCNYAn568srD87624FohKzwaFJj/17TKHLSS+kKau2CITM4MMur8ZsPyAFiDz2dbdK4v9vNs6rDnJg76OwdAAbBRMDl0vcgSBrT7HIDvpQirOOJykktRyip8Rovx0INcTmeQjJIrHcQXipSH2Eiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625952; c=relaxed/simple;
	bh=EP7mz2TcKDYylio2XdMJOHJ1aopi8ifMnNgfMKQJFAE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tvKcdBSiQaiZIUEq9sNeaolRjcS5SFaj1z9ad32cq1o/FAikht0xSzm3Fn3B3i9lTtX4S9NHK1v87wMoqhVBCjjM046L7hh0NBgqiQihV9Eg/bfrj+UUzOSwuUqgjYPzwXHuFGbY9zJkcXw4f2jWA0JKEvJ0JxreWryRuewAgJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aIIvqcKW; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714625951; x=1746161951;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EP7mz2TcKDYylio2XdMJOHJ1aopi8ifMnNgfMKQJFAE=;
  b=aIIvqcKWRens2Wt4/AW14I6HfTmGgjMPVRVRutoIzjeas8BXZFDz61Ae
   Dgg9nUPnKT2JvX34pcOaPMHVGrXdcczqgWX5omJdR3owDMbvYSAnrZYXk
   NhvNjITb1nHoMThbsoo6J0naMFmW+JiYIB1WXvAE6bqHgZeymKPXYNs0I
   xVB/vuZTQQ2qecrRNFIuW83GfXeCGOuv00PVMYeuB0pbW5ygGZxaDZu4X
   lNi1mItEdCKTb99KvZoNnMr0MjD1WjQIMPPdjl/TZdAve5CtQeMqIsl7h
   G1d3s4rOTHYu5u0E0f2xG1TZZRCDgiQNozSeOQ2cC1taMW2D3yMNoPatI
   A==;
X-CSE-ConnectionGUID: RHo6q7DuQ3Shfbla5e+9qg==
X-CSE-MsgGUID: 3ZcQlmuzTQeeaTXJkDWGxg==
X-IronPort-AV: E=Sophos;i="6.07,247,1708412400"; 
   d="scan'208";a="254174820"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 May 2024 21:59:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 21:59:01 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 21:58:58 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH net v1] lan78xx: Fix crash with multiple device attach
Date: Thu, 2 May 2024 10:27:48 +0530
Message-ID: <20240502045748.37627-1-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

After the first device(MAC + PHY) is attached, the corresponding
fixup gets registered and before it is unregistered next device
is attached causing the dev pointer of second device to be NULL.
Fixed the issue with multiple PHY attach by unregistering PHY
at the end of probe. Removed the unregistration during phy_init
since the handling has been taken care in probe.

Fixes: 89b36fb5e532 ("lan78xx: Lan7801 Support for Fixed PHY")
Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---

 drivers/net/usb/lan78xx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5add4145d..3ec79620f 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2383,14 +2383,8 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		netdev_err(dev->net, "can't attach PHY to %s\n",
 			   dev->mdiobus->id);
 		if (dev->chipid == ID_REV_CHIP_ID_7801_) {
-			if (phy_is_pseudo_fixed_link(phydev)) {
+			if (phy_is_pseudo_fixed_link(phydev))
 				fixed_phy_unregister(phydev);
-			} else {
-				phy_unregister_fixup_for_uid(PHY_KSZ9031RNX,
-							     0xfffffff0);
-				phy_unregister_fixup_for_uid(PHY_LAN8835,
-							     0xfffffff0);
-			}
 		}
 		return -EIO;
 	}
@@ -4458,6 +4452,14 @@ static int lan78xx_probe(struct usb_interface *intf,
 	pm_runtime_set_autosuspend_delay(&udev->dev,
 					 DEFAULT_AUTOSUSPEND_DELAY);
 
+	/* Unregistering Fixup to avoid crash with multiple device
+	 * attach.
+	 */
+	phy_unregister_fixup_for_uid(PHY_KSZ9031RNX,
+				     0xfffffff0);
+	phy_unregister_fixup_for_uid(PHY_LAN8835,
+				     0xfffffff0);
+
 	return 0;
 
 out8:
-- 
2.25.1


