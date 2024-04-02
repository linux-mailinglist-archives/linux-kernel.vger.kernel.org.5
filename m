Return-Path: <linux-kernel+bounces-128511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54CD895BD8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33341C22579
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F18C15B12D;
	Tue,  2 Apr 2024 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b="mpHq3mLG"
Received: from mail.wantyapps.xyz (mail.wantyapps.xyz [66.135.5.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38898495;
	Tue,  2 Apr 2024 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.135.5.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083095; cv=none; b=Bdab9A39dNgorgRY5K2bd7DdNMBCXG+v5jfo6LjruxOWdsSHzpBc+odz74h3RCBugr1Oo418if5s39iEv4Ha3InolxZn8b3/pbhEiWYTyb/E7NkhNu+roPH19vMePJctGc5S0XX4JHwSgJS4r6QXcjb05AiBN50zE6KZKCBJ6qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083095; c=relaxed/simple;
	bh=HhaPo8p+l4ugT5iV2J7FKycZxcYWiG4CD/2/oEp97F4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7eqdUcffozHmlSloE6iByyeJpWC0QWWLIGEyEtuXP7Pvc9m9sokHaRqAUwi7nMh3gee8AxdXd9riGP0cAJ1n/YjWO08UgCKaoD5elzQhm4TosyB7lptB/3cU80z+IKcbJjlMGrM/Rnfn1Oz2/8cPj5gQjmnjS0ljbREqwaplLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz; spf=pass smtp.mailfrom=wantyapps.xyz; dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b=mpHq3mLG; arc=none smtp.client-ip=66.135.5.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantyapps.xyz
Received: from multivac.localdomain (unknown [147.235.205.62])
	by mail.wantyapps.xyz (Postfix) with ESMTPSA id 7620893C6F;
	Tue,  2 Apr 2024 18:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
	s=mail; t=1712083088;
	bh=HhaPo8p+l4ugT5iV2J7FKycZxcYWiG4CD/2/oEp97F4=;
	h=From:To:Cc:Subject:Date:From;
	b=mpHq3mLGer51ZCGSPiMBmMV93fF3Y0AwjwCSRRqnVlwh0WrJnw9U1YAwWmMlw3DGr
	 nAbSsU8s/lWucsAdGplNstTBEy4V8JSneGk6txUPGqOvybJ6QelqA5uGyqauG18NId
	 vI/8eeoxvT+LVreue2gEgV938955bQIrj9AXZC179wVuGC4lloZTlrWUKcevUKpjJ6
	 ZLykB0G0HoxeIHkEpLWD9fU3v3HsigCo8QFAqxIYq+ncbfyZxo8zhoH7AvvyWKac69
	 yT0BpOzh7gusP0x0hfvE0MNkZ4ThzkhFmlwtWnsjS1A4cWZuzMBUqQZUwGWy70LGEj
	 h64dmbvmUDQ5w==
From: me@wantyapps.xyz
To: 
Cc: me@wantyapps.xyz,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_intel: Fix multiple issues reported by checkpatch.pl
Date: Tue,  2 Apr 2024 21:37:45 +0300
Message-ID: <20240402183751.107948-1-me@wantyapps.xyz>
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
WARNING: Prefer using '"%s...", __func__' to using 'intel_setup', this
        function's name, in a string
+       bt_dev_dbg(hdev, "start intel_setup");

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
+       duration = (unsigned long long) ktime_to_ns(delta) >> 10;

CHECK: No space is necessary after a cast
+       duration = (unsigned long long) ktime_to_ns(delta) >> 10;

WARNING: Missing a blank line after declarations
+               int err = PTR_ERR(intel->rx_skb);
+               bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);

Signed-off-by: Uri Arev <me@wantyapps.xyz>
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
---
Changes in v2:
Changed bt_dev_dbg(hdev, "start intel_setup"); to bt_dev_dbg(hdev, "");
as suggested by Luiz Augusto von Dentz
---
 drivers/bluetooth/hci_intel.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 78afb9a348e7..53e394676f6b 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -537,7 +537,7 @@ static int intel_setup(struct hci_uart *hu)
 	int speed_change = 0;
 	int err;
 
-	bt_dev_dbg(hdev, "start intel_setup");
+	bt_dev_dbg(hdev, "");
 
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


