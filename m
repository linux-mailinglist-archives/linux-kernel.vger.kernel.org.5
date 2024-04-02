Return-Path: <linux-kernel+bounces-128296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6F58958FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F9128DA45
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05001133401;
	Tue,  2 Apr 2024 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b="QfVU6kTu"
Received: from mail.wantyapps.xyz (mail.wantyapps.xyz [66.135.5.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF001E480;
	Tue,  2 Apr 2024 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.135.5.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073396; cv=none; b=Na3wTjCURBdRKJygXb0+J01/YjbmlZ2AnuvMRXk/3ZnBTuMyioyxtheB/g0oK54z4YtVG6xseCbpzy5t8A8Y+14+ZHcIwZeCyQ5gTZ6dbziHa/kcwNAykzuqTnjduZQ/gQ7QCwTfL3NCfgSbB08AGV89RK/wCZSkr4fplHtS0Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073396; c=relaxed/simple;
	bh=3uUdxpNMJCSv/whZqF+Y9KRjEax86QarR254jAZl9Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0sk6NRkc54MQXVJag8yyyWNzoNZ7MXdEHUr6txJEVMIgDJ7qqxpfbCsrFrvlLaAgdE56s5i611aFkdUtdDG2zlnvHTP4+5Fa8h/F8ngxwP6VigA57cd8ozUop+3Z3i2UaC9fxYz8lZZlzui+wZCCi4c9fcR+nJWf37wb6PP8nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz; spf=pass smtp.mailfrom=wantyapps.xyz; dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b=QfVU6kTu; arc=none smtp.client-ip=66.135.5.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantyapps.xyz
Received: from multivac.localdomain (unknown [147.235.205.62])
	by mail.wantyapps.xyz (Postfix) with ESMTPSA id 511EE93B8D;
	Tue,  2 Apr 2024 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
	s=mail; t=1712073388;
	bh=3uUdxpNMJCSv/whZqF+Y9KRjEax86QarR254jAZl9Yk=;
	h=From:To:Cc:Subject:Date:From;
	b=QfVU6kTuNxAmCn40yRCWmwiXs5oahcAAdwl6+mD5HGXHiPqbuuMc5Qi30vucXyPnB
	 RzxEreWWA2qmbt15BSjFox8EV6Y4Qh2KX1t1Cz1bg0o2/P21j1MsTcCPj+fewPLjhO
	 Oizd914Iem9wFMdpDgZZjL1xCUeKbD+GHMA3mmuRWEiATrm297T6nV1wyyTRoteUPV
	 Nb/nMWqV4h7Rc5Ug5VpK1HTCCUdyk2x2D/bzJWNzrScR4zG32r8zlTuXmssdwL6Qrl
	 YdjPkZVy7QYUc2cVcyUKFbZK34jj21aDnPOcn5mQLTyLplNi3qtSZco6dmWDh8xwOv
	 jU6X5vSSrGCdg==
From: me@wantyapps.xyz
To: 
Cc: me@wantyapps.xyz,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_intel: Fix multiple issues reported by checkpatch.pl
Date: Tue,  2 Apr 2024 18:55:38 +0300
Message-ID: <20240402155543.36856-1-me@wantyapps.xyz>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Uri Arev <me@wantyapps.xyz>

This fixes the following CHECKs, WARNINGs, and ERRORs reported in
hci_intel.c

Reported by checkpatch.pl:
-----------
hci_intel.c
-----------
WARNING: Prefer using '"%s...", __func__' to using 'intel_setup', this function's name, in a string
+	bt_dev_dbg(hdev, "start intel_setup");

ERROR: code indent should use tabs where possible
+        /* Check for supported iBT hardware variants of this firmware$

ERROR: code indent should use tabs where possible
+         * loading method.$

ERROR: code indent should use tabs where possible
+         *$

ERROR: code indent should use tabs where possible
+         * This check has been put in place to ensure correct forward$

ERROR: code indent should use tabs where possible
+         * compatibility options when newer hardware variants come along.$

ERROR: code indent should use tabs where possible
+         */$

CHECK: No space is necessary after a cast
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;

CHECK: No space is necessary after a cast
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;

WARNING: Missing a blank line after declarations
+		int err = PTR_ERR(intel->rx_skb);
+		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);

Signed-off-by: Uri Arev <me@wantyapps.xyz>
---
 drivers/bluetooth/hci_intel.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 78afb9a348e7..44731de1a2d6 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -537,7 +537,7 @@ static int intel_setup(struct hci_uart *hu)
 	int speed_change = 0;
 	int err;
 
-	bt_dev_dbg(hdev, "start intel_setup");
+	bt_dev_dbg(hdev, "start %s", __func__);
 
 	hu->hdev->set_diag = btintel_set_diag;
 	hu->hdev->set_bdaddr = btintel_set_bdaddr;
@@ -591,12 +591,12 @@ static int intel_setup(struct hci_uart *hu)
 		return -EINVAL;
 	}
 
-        /* Check for supported iBT hardware variants of this firmware
-         * loading method.
-         *
-         * This check has been put in place to ensure correct forward
-         * compatibility options when newer hardware variants come along.
-         */
+	/* Check for supported iBT hardware variants of this firmware
+	 * loading method.
+	 *
+	 * This check has been put in place to ensure correct forward
+	 * compatibility options when newer hardware variants come along.
+	 */
 	switch (ver.hw_variant) {
 	case 0x0b:	/* LnP */
 	case 0x0c:	/* WsP */
@@ -777,7 +777,7 @@ static int intel_setup(struct hci_uart *hu)
 
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
 
 	bt_dev_info(hdev, "Firmware loaded in %llu usecs", duration);
 
@@ -822,7 +822,7 @@ static int intel_setup(struct hci_uart *hu)
 
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
 
 	bt_dev_info(hdev, "Device booted in %llu usecs", duration);
 
@@ -977,6 +977,7 @@ static int intel_recv(struct hci_uart *hu, const void *data, int count)
 				    ARRAY_SIZE(intel_recv_pkts));
 	if (IS_ERR(intel->rx_skb)) {
 		int err = PTR_ERR(intel->rx_skb);
+
 		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
 		intel->rx_skb = NULL;
 		return err;
-- 
2.44.0


