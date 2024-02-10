Return-Path: <linux-kernel+bounces-60571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CC78506DE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD801C21440
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8443C5FF1A;
	Sat, 10 Feb 2024 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMznyaVb"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC165FEF2;
	Sat, 10 Feb 2024 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707603760; cv=none; b=OD+NLypeVae6lwRUVoJsKdBbBeQK07pwNxRjLy6Hh5dENfyf7H19ZzmvSt1ZN3CRzqK+3oiwRurER9I2NYuYlLMVupxqWjiZ5KFTNpA0AS+EvU/ZWO6AypB13lPqX2khF3e7PjGNxMnbyVr6VJOaz4mlsAcNxHSopPoagxc6vHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707603760; c=relaxed/simple;
	bh=PCcBZJv6xJz28PqEjgos8upjm2e9HGHC2hr+XIa0fCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0XRcA5X9+pM0TPETUoEqLgUF5nSp8Skkg9mngxN116aYnZqaqQ/+xboxmjiJWHWlbFF6Go8RO1mTF0PpOYzurB6j++gDZ7PI7aeqAXMSXQubnSPw9iX5R10IzSF3WaUQStwIxYiMQB9SEL0XosUYFqBvG7r+28R1VPjed6SbcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMznyaVb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41089cc9ae4so5882265e9.1;
        Sat, 10 Feb 2024 14:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707603756; x=1708208556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dmLEMeOr1VEZaUc0OFLleQNloMiRyeCB0LCT+kawPg=;
        b=lMznyaVbbXqrjVDx2TlnRs4eM/HDD5kCJt0HsEnSKC5L83WiVmXIUkOmSEsLf++2sJ
         IcmYGQYzPHOgWpu32l77VtJRWlKEgeFcxFoCxfzhVGU+TPhF6CrbMOLO60gnQEph+c0v
         tGfD4imIpqfkOC6GMqjJ+AdYf6Pgi0gNoqVjt5QLCGtC5VniHt6TMbLLG5S5OrN8C90C
         U3vTkpWNdAheFOlsOOESZRulKBYe2IGNFyzEKMGwHB5ruPozaAZni5oXYcLos3GvBsNY
         3cdYrjWmU/O8hbM7iqjrbEf4L9j0WV0e3lVjPUJgouRVCMnCdekrzhIYL1VLLufP/gTV
         NiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707603756; x=1708208556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dmLEMeOr1VEZaUc0OFLleQNloMiRyeCB0LCT+kawPg=;
        b=N24AhicCsTKRpJlkFEj6GAZOGh47hxoyJeAN3VXXliMx/R2Z6IkWrk85MMW3Nr6kiT
         BhhcwQ90oQwdv31jzFK8B8YoBc/1ltiGiJZ28lmL1iJZ4+Cvm9icD2jCvJrfolHIcJYB
         HhCP9JKwXnjLK1Bhd4o1xz4Cc/hUAYTle/ClVnIX5dcTDIsG2RK0hKQ6hpBsnWl7JIdo
         +3SZX1MnYU6KYbw2IiOA4Rx9a6++1Mh4L2stc3t833GhWH4a1V2ksdwl5CVFEWVDBTmg
         dDkCtFPyckxJOawTMmQrM+nEmYEmeA23feWMXsPlE4qXH66P7kI6jKAIz0yp3dCJuT43
         oJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCXR3Rm7VzKbKTHTwbqBqbJnS3jhVSmX/FguzSSMcb76Rv2pBKZaSOqt532mVeRvP+qxa9mzXueDMf+P+95AJPTc5z6bwHWoJSYCaBhq
X-Gm-Message-State: AOJu0Yy5zLaM4OwwNR407jIJ1k5FuzmIcwFolA+NBvskWLhzNYirOJiT
	0Ui4+wPYLuPAvaA4DaSh0lt/vmnk5JiZ8jkZX0e8UMAwLmGjZiS8tsngWOVsWFg=
X-Google-Smtp-Source: AGHT+IF6NiX4YRFe3jCUm3SxN3vg9kz9itawc10yzR0q093MV0iz1bq8dFO2iN0CPWBVgW61stuECg==
X-Received: by 2002:a5d:5484:0:b0:33b:6585:9ab7 with SMTP id h4-20020a5d5484000000b0033b65859ab7mr2005705wrv.46.1707603756419;
        Sat, 10 Feb 2024 14:22:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZEO1XMzTBwVZ7hZSNKejTqIOs9jtf7HEbzgV0GTna2QsGF5rVmHlAhUaDR8tk8Cxqu/KiJUu3dStOh46YeTBBrK1s+3Cd6pcqQ7QGmf3/IbfkqkuqWTJLbfIeMhbcvWzm0nDjlT7QxqTTHpsov7sb8nHHcCLZCQ0=
Received: from vibhavp-mega.lan ([2401:4900:1c0a:39ad:8621:c30e:70c4:e9ea])
        by smtp.gmail.com with ESMTPSA id l21-20020adfa395000000b0033b3ceda5dbsm2827164wrb.44.2024.02.10.14.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 14:22:35 -0800 (PST)
From: Vibhav Pant <vibhavp@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org,
	Vibhav Pant <vibhavp@gmail.com>
Subject: [PATCH 1/1] Bluetooth: mgmt: Add command for getting device IO capabilities.
Date: Sun, 11 Feb 2024 03:52:26 +0530
Message-ID: <20240210222226.890031-2-vibhavp@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210222226.890031-1-vibhavp@gmail.com>
References: <20240210222226.890031-1-vibhavp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_device_io_capability allows to get a connected device's IO
capabilities, including the authentication method (and MITM support)
requested, stored in the hci_conn for the device.

Signed-off-by: Vibhav Pant <vibhavp@gmail.com>
---
 include/net/bluetooth/mgmt.h | 19 ++++++++
 net/bluetooth/mgmt.c         | 89 ++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index d382679efd2b..dba431baaef8 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -878,6 +878,25 @@ struct mgmt_cp_mesh_send_cancel {
 } __packed;
 #define MGMT_MESH_SEND_CANCEL_SIZE	1
 
+#define MGMT_OP_GET_DEVICE_IO_CAPABILITY         0x005B
+struct mgmt_cp_get_device_io_capability {
+	struct mgmt_addr_info addr;
+} __packed;
+#define MGMT_GET_DEVICE_IO_CAPABILITY_SIZE       MGMT_ADDR_INFO_SIZE
+struct mgmt_rp_get_device_io_capability {
+	struct mgmt_addr_info addr;
+	__u8 flags;
+} __packed;
+
+#define MGMT_DEVICE_IO_CAP_FLAG_IO_DISPLAY_ONLY       BIT(0)
+#define MGMT_DEVICE_IO_CAP_FLAG_IO_DISPLAY_YESNO      BIT(1)
+#define MGMT_DEVICE_IO_CAP_FLAG_IO_KEYBOARD_ONLY      BIT(2)
+#define MGMT_DEVICE_IO_CAP_FLAG_IO_NO_INPUT_OUTPUT    BIT(3)
+#define MGMT_DEVICE_IO_CAP_FLAG_AT_NO_BONDING         BIT(4)
+#define MGMT_DEVICE_IO_CAP_FLAG_AT_DEDICATED_BONDING  BIT(5)
+#define MGMT_DEVICE_IO_CAP_FLAG_AT_GENERAL_BONDING    BIT(6)
+#define MGMT_DEVICE_IO_CAP_FLAG_AT_MITM               BIT(7)
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 78ab562807d0..92b4317e60a1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -28,6 +28,7 @@
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/hci_sock.h>
 #include <net/bluetooth/l2cap.h>
@@ -67,6 +68,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_PIN_CODE_REPLY,
 	MGMT_OP_PIN_CODE_NEG_REPLY,
 	MGMT_OP_SET_IO_CAPABILITY,
+	MGMT_OP_GET_DEVICE_IO_CAPABILITY,
 	MGMT_OP_PAIR_DEVICE,
 	MGMT_OP_CANCEL_PAIR_DEVICE,
 	MGMT_OP_UNPAIR_DEVICE,
@@ -3303,6 +3305,92 @@ static int set_io_capability(struct sock *sk, struct hci_dev *hdev, void *data,
 				 NULL, 0);
 }
 
+static int get_device_io_capability(struct sock *sk, struct hci_dev *hdev,
+				    void *data, u16 len)
+{
+	struct mgmt_cp_get_device_io_capability *cp = data;
+	struct mgmt_rp_get_device_io_capability rp;
+	struct hci_conn *conn;
+	int err = 0;
+
+	bt_dev_dbg(hdev, "sock %p", sk);
+
+	memset(&rp, 0, sizeof(rp));
+	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
+	rp.addr.type = cp->addr.type;
+
+	if (!bdaddr_type_is_valid(cp->addr.type))
+		return mgmt_cmd_complete(sk, hdev->id,
+					 MGMT_OP_GET_DEVICE_IO_CAPABILITY,
+					 MGMT_STATUS_INVALID_PARAMS, &rp,
+					 sizeof(rp));
+	hci_dev_lock(hdev);
+
+	if (!hdev_is_powered(hdev)) {
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_GET_DEVICE_IO_CAPABILITY,
+					MGMT_STATUS_NOT_POWERED, &rp,
+					sizeof(rp));
+		goto unlock;
+	}
+
+	if (cp->addr.type == BDADDR_BREDR)
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
+					       &cp->addr.bdaddr);
+	else
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
+
+	if (!conn) {
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_GET_DEVICE_IO_CAPABILITY,
+					MGMT_STATUS_NOT_CONNECTED, &rp,
+					sizeof(rp));
+		goto unlock;
+	}
+
+	switch (conn->remote_cap) {
+	case HCI_IO_DISPLAY_ONLY:
+		rp.flags |= MGMT_DEVICE_IO_CAP_FLAG_IO_DISPLAY_ONLY;
+		break;
+	case HCI_IO_DISPLAY_YESNO:
+		rp.flags |= MGMT_DEVICE_IO_CAP_FLAG_IO_DISPLAY_YESNO;
+		break;
+	case HCI_IO_KEYBOARD_ONLY:
+		rp.flags |= MGMT_DEVICE_IO_CAP_FLAG_IO_KEYBOARD_ONLY;
+		break;
+	case HCI_IO_NO_INPUT_OUTPUT:
+		rp.flags |= MGMT_DEVICE_IO_CAP_FLAG_IO_NO_INPUT_OUTPUT;
+		break;
+	}
+
+	switch (conn->remote_auth) {
+	case HCI_AT_NO_BONDING_MITM:
+		rp.flags |= MGMT_DEVICE_IO_CAP_FLAG_AT_MITM;
+		fallthrough;
+	case HCI_AT_NO_BONDING:
+		rp.flags |= MGMT_DEVICE_IO_CAP_FLAG_AT_NO_BONDING;
+		break;
+	case HCI_AT_DEDICATED_BONDING_MITM:
+		rp.flags |= MGMT_DEVICE_IO_CAP_FLAG_AT_MITM;
+		fallthrough;
+	case HCI_AT_DEDICATED_BONDING:
+		rp.flags |= MGMT_DEVICE_IO_CAP_FLAG_AT_DEDICATED_BONDING;
+		break;
+	case HCI_AT_GENERAL_BONDING_MITM:
+		rp.flags |= MGMT_DEVICE_IO_CAP_FLAG_AT_MITM;
+		fallthrough;
+	case HCI_AT_GENERAL_BONDING:
+		rp.flags |= MGMT_DEVICE_IO_CAP_FLAG_AT_GENERAL_BONDING;
+		break;
+	}
+
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_DEVICE_IO_CAPABILITY,
+				MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static struct mgmt_pending_cmd *find_pairing(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -9217,6 +9305,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ pin_code_reply,          MGMT_PIN_CODE_REPLY_SIZE },
 	{ pin_code_neg_reply,      MGMT_PIN_CODE_NEG_REPLY_SIZE },
 	{ set_io_capability,       MGMT_SET_IO_CAPABILITY_SIZE },
+	{ get_device_io_capability,MGMT_GET_DEVICE_IO_CAPABILITY_SIZE },
 	{ pair_device,             MGMT_PAIR_DEVICE_SIZE },
 	{ cancel_pair_device,      MGMT_CANCEL_PAIR_DEVICE_SIZE },
 	{ unpair_device,           MGMT_UNPAIR_DEVICE_SIZE },
-- 
2.43.0


