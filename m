Return-Path: <linux-kernel+bounces-164926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D7D8B8507
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 113D6B20EA9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76823D97D;
	Wed,  1 May 2024 04:32:37 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86975D2E5;
	Wed,  1 May 2024 04:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537957; cv=none; b=lp/SMW6kt7mB8XKlHUavBALKxYLBjDbyWQqJEqtB4XsoTmcdxXSvKQQ3DIr3GpvpOLgYWAvm6C/QSqeyPH439z3O4pccYQrSfOAS+gqcz/2JEwBdUS9T63yhjluElzDtxw7UxA9N5PK4sW9BzI3fInBDlkja2Bhg84YogGmMaE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537957; c=relaxed/simple;
	bh=2JY5OY0eLf0Go09E4VV+/1JdG4dIaohPD9zFXAum5sk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kMv6ohQXWjRsYECJ948FEzlvCN1Wynpxaokj1lOBAsJ6gZ2c6oLpnnc3Si4ELebYnB7B5NcoKWoZOYrhfSBIQP3z0+GO2iBI2geApfJCqhT6tresxyRPEkn/xMND6tlNfrALOFVm/JXzXF3Q0PyRIXfq3++dSAv4lMITXQmJVL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4dee77a2b49so1212153e0c.1;
        Tue, 30 Apr 2024 21:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714537954; x=1715142754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Z5lN9ouraph5ntmF9cLLqC94FKMgX8DNOshw4gn8zw=;
        b=JusS84OA+OTwpPp8KwmveLTPm22mgiuGnpmpf6KAJAaTJ4nZuvz539jvj57IQZegSJ
         7I3EqlDAXc589bq3m460sw/0S9iR6TIgkGexZDLGfhqTfl68imgW1oddJyMDOdyNm64N
         JUIzVXhv1e/W1PppsOhtowbq2oFGEK/eEtOUNVu/A+FTxdojr/Axd3yvhLiM/nPH+gZS
         YZAPsCc9etC0X2PFn8C5FZxKc8cZzHbpFmL1PKqjhiuFKYdtUintZaf5Ry8HjbU5k0Bd
         fz1zh66jWWE8Atv10UgMdUV4sKtMvAhmKtt1PsSyJIWOWdp2ZPm6DCFR1GbrzYFIxc0q
         Pb2A==
X-Forwarded-Encrypted: i=1; AJvYcCWRKqHPccsbp7AkOu/wMEhKtXsqnjKx8L6Qu2YB4dvbJwt7cU9tLOLB8bVhfKB5jW0DI5e/n+kVjMfjXMNafew2cwdG0Ww6OHvnYLnolBu2Kv81QDVXHSuhK/EErg50J5sIAWhsNpbqVuYPnpxEKHb8F8yR2+26qoD42AtjrTwJRCfDORS8
X-Gm-Message-State: AOJu0YzLZtxOYdGvvpjB/JWg3QaNmHO8IXaK/SNvPrdhnxRJNlpnVntf
	AXYkYQ48iPG6jh0olP/NeMLpmFjrhuXr6oBMz+M4AJNnEdtDFujT
X-Google-Smtp-Source: AGHT+IFEsfnWehxiAiumsg8emFvB06y8Nfu+9ZDYXnIqFHeuB3FAWBoMcAZIutFPX/7RUaCD07qFjw==
X-Received: by 2002:a05:6122:3187:b0:4d4:1ec7:76e5 with SMTP id ch7-20020a056122318700b004d41ec776e5mr1328818vkb.16.1714537954179;
        Tue, 30 Apr 2024 21:32:34 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id i1-20020ae9ee01000000b0078f12b01bbdsm11618561qkg.101.2024.04.30.21.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:32:33 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: luiz.dentz@gmail.com
Cc: daveti@purdue.edu,
	benquike@gmail.com,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()
Date: Wed,  1 May 2024 00:29:36 -0400
Message-Id: <20240501042936.2579739-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz, could you review this patch?

This patch prevents a div-by-zero error and potential int overflow by
adding a range check for MTU in hci_cc_le_read_buffer_size() and
hci_cc_le_read_buffer_size_v2().
Also, hci_connect_le() will refuse to allocate hcon if the MTU is not in
the valid range.

Bug description:

l2cap_le_flowctl_init() can cause both div-by-zero and an integer overflow.

l2cap_le_flowctl_init()
  chan->mps = min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
  chan->rx_credits = (chan->imtu / chan->mps) + 1;  <- div-by-zero

Here, chan->conn->mtu could be less than or equal to L2CAP_HDR_SIZE (4).
If mtu is 4, it causes div-by-zero. If mtu is less than 4, it causes an
integer overflow.

How mtu could have such low value:

hci_cc_le_read_buffer_size()
  hdev->le_mtu = __le16_to_cpu(rp->le_mtu);

l2cap_conn_add()
  conn->mtu = hcon->hdev->le_mtu;

As shown, mtu is an input from an HCI device. So, any HCI device can
set mtu value to any value, such as lower than 4.
According to the spec v5.4 7.8.2 LE Read Buffer Size command, the value
should be fall in [0x001b, 0xffff].

Thank you,
Sungwoo.

divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 PID: 67 Comm: kworker/u5:0 Tainted: G        W          6.9.0-rc5+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci0 hci_rx_work
RIP: 0010:l2cap_le_flowctl_init+0x19e/0x3f0 net/bluetooth/l2cap_core.c:547
Code: e8 17 17 0c 00 66 41 89 9f 84 00 00 00 bf 01 00 00 00 41 b8 02 00 00 00 4c 89 fe 4c 89 e2 89 d9 e8 27 17 0c 00 44 89 f0 31 d2 <66> f7 f3 89 c3 ff c3 4d 8d b7 88 00 00 00 4c 89 f0 48 c1 e8 03 42
RSP: 0018:ffff88810bc0f858 EFLAGS: 00010246
RAX: 00000000000002a0 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffff88810bc0f7c0 RDI: ffffc90002dcb66f
RBP: ffff88810bc0f880 R08: aa69db2dda70ff01 R09: 0000ffaaaaaaaaaa
R10: 0084000000ffaaaa R11: 0000000000000000 R12: ffff88810d65a084
R13: dffffc0000000000 R14: 00000000000002a0 R15: ffff88810d65a000
FS:  0000000000000000(0000) GS:ffff88811ac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000100 CR3: 0000000103268003 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 l2cap_le_connect_req net/bluetooth/l2cap_core.c:4902 [inline]
 l2cap_le_sig_cmd net/bluetooth/l2cap_core.c:5420 [inline]
 l2cap_le_sig_channel net/bluetooth/l2cap_core.c:5486 [inline]
 l2cap_recv_frame+0xe59d/0x11710 net/bluetooth/l2cap_core.c:6809
 l2cap_recv_acldata+0x544/0x10a0 net/bluetooth/l2cap_core.c:7506
 hci_acldata_packet net/bluetooth/hci_core.c:3939 [inline]
 hci_rx_work+0x5e5/0xb20 net/bluetooth/hci_core.c:4176
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0x90f/0x1530 kernel/workqueue.c:3335
 worker_thread+0x926/0xe70 kernel/workqueue.c:3416
 kthread+0x2e3/0x380 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---

Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
v1 -> v2:
- Reply with an error code if a given MTU is not valid.
- Refuse hcon allocation if MTU is not still valid.

 include/net/bluetooth/hci.h | 6 ++++++
 net/bluetooth/hci_conn.c    | 4 ++++
 net/bluetooth/hci_event.c   | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5c12761cb..a7bc07e9c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1666,6 +1666,12 @@ struct hci_cp_le_set_event_mask {
 	__u8     mask[8];
 } __packed;
 
+/* BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E
+ * 7.8.2 LE Read Buffer Size command
+ */
+#define HCI_MIN_LE_MTU 0x001b
+#define HCI_MAX_LE_MTU 0xFFFF
+
 #define HCI_OP_LE_READ_BUFFER_SIZE	0x2002
 struct hci_rp_le_read_buffer_size {
 	__u8     status;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 05346250f..0b86a7452 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1277,6 +1277,10 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
+	/* Check the mtu is valid */
+	if (hdev->le_mtu < HCI_MIN_LE_MTU || HCI_MAX_LE_MTU < hdev->le_mtu)
+		return ERR_PTR(-ECONNREFUSED);
+
 	/* Since the controller supports only one LE connection attempt at a
 	 * time, we return -EBUSY if there is any connection attempt running.
 	 */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4a27e4a17..a8563cbe2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1263,6 +1263,9 @@ static u8 hci_cc_le_read_buffer_size(struct hci_dev *hdev, void *data,
 
 	BT_DBG("%s le mtu %d:%d", hdev->name, hdev->le_mtu, hdev->le_pkts);
 
+	if (hdev->le_mtu < HCI_MIN_LE_MTU || HCI_MAX_LE_MTU < hdev->le_mtu)
+		return HCI_ERROR_INVALID_PARAMETERS;
+
 	return rp->status;
 }
 
@@ -3821,6 +3824,9 @@ static u8 hci_cc_le_read_buffer_size_v2(struct hci_dev *hdev, void *data,
 	BT_DBG("%s acl mtu %d:%d iso mtu %d:%d", hdev->name, hdev->acl_mtu,
 	       hdev->acl_pkts, hdev->iso_mtu, hdev->iso_pkts);
 
+	if (hdev->le_mtu < HCI_MIN_LE_MTU || HCI_MAX_LE_MTU < hdev->le_mtu)
+		return HCI_ERROR_INVALID_PARAMETERS;
+
 	return rp->status;
 }
 
-- 
2.34.1


