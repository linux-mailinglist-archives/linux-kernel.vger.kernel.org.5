Return-Path: <linux-kernel+bounces-161267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1B08B49D9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36091281E70
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F9F7460;
	Sun, 28 Apr 2024 05:43:34 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645F33DF;
	Sun, 28 Apr 2024 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714283013; cv=none; b=QJb+MQ6KDWj8xn+uAgfWlko85Q4IlDyFRJMzVcmNoOmUvrGxeVQ9MeeFkJLs+eWKFw6qtwr9fqvbbvw70Pnanw6wMhYyLLalMgRxFEfXtEWUW7WLlHo/Js/A0nqh0pG/tYHHDleW7Uh7zmlo6LNhLU3GKEVs/dE1NlIzcXqpsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714283013; c=relaxed/simple;
	bh=yMsCNuwPFY0Fw5AmZTd2moSMyXbtQcD9yl1aC7ExeE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EUFWUMkHeofylPQgP22RTuT3DmVq6pm0GUOFyNHxfhpiNxM9Qs/D9kzuC0vrl51Ns55CVap2Ag+hELf1ekhlcNpB9AUI8hdlbKvHPXv3WjqS9zGFtsIwFT0Yna0hmPGMuDmYm+2XnndDxHOlnzJiAH62ZkFJHK2jcwpIFjnN+ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78f056f0a53so235297585a.1;
        Sat, 27 Apr 2024 22:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714283009; x=1714887809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpxGmTH8+/K+4NFwDFhXZtxUOTfL6buX1v9TIMBJn+w=;
        b=K4rDotU5Imqy0jjCi3E5gei3L0pGSOKLJEd/Ok4+1McHR3eRsNbWqgLb7oXV1HCEyD
         KUgOx72UlL9AJmYtiggF/6n+nXUTuIsDOtDFeVbe0jw9e94Rh0/9H3oDQ1d3OgCUmVXu
         PEf1Ul9jWfkOKEkqcMCFcKKPuSeItg1so3Gl132bAIBQS2J9B0Zs+vI6liCSvEo12eN+
         Q1q5Rj82KDOxcHPeX+lYWvoX6j/D8yp7uZLuQJMb0B72CKQdunA5646hO3RzaqJS8mwI
         d9nH6DPSQ2ZUqU3HA1a7oIfWMAeFJTYzN1i6t5z6M6ULX/RVVm1x6oELqV6Dti7OiDPM
         +2TA==
X-Forwarded-Encrypted: i=1; AJvYcCUDeFh9Dp8pOaxjP6tXwnCcjXsyckmxP7OTuqZOYULroXgkEIOfLK9EKOL2oQ4BHf1f9vUJeDtx1L8IuscigVdiMiVTSPtVqaYFxgxJUhhQXc4pFDUg1V9XYaC45tWN7IXS0v6k0vz3QSPXwU9D
X-Gm-Message-State: AOJu0YzttBTu/N02JgvFXmWA+30Bx+OLICd64CQV/I0R+qwluOkdUU92
	0jdsocqQvHVtodyuHxyOMjmzmNGlr+THwjOzezAKyap7ZrmGn3wf
X-Google-Smtp-Source: AGHT+IF2Vg477pszzAJ/5svMse7qtURlGeug5OYRkvL11QHnQm5FB0tEnhOzR36T70c98mdBUMDlyw==
X-Received: by 2002:ad4:5dcc:0:b0:6a0:b3cc:ee0e with SMTP id m12-20020ad45dcc000000b006a0b3ccee0emr6827804qvh.49.1714283009447;
        Sat, 27 Apr 2024 22:43:29 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id w5-20020a0c9c45000000b0069b27dad8c7sm9440906qve.101.2024.04.27.22.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 22:43:29 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: 
Cc: daveti@purdue.edu,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()
Date: Sun, 28 Apr 2024 01:43:08 -0400
Message-Id: <20240428054307.1178347-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, could you review this bug and its patch?

l2cap_le_flowctl_init() can cause both div-by-zero and an integer overflow.

l2cap_le_flowctl_init()
  chan->mps = min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
  chan->rx_credits = (chan->imtu / chan->mps) + 1;  <- div-by-zero

Here, mtu could be less than or equal to L2CAP_HDR_SIZE (4). If mtu is 4, it
causes div-by-zero. If mtu is less than 4, it causes an integer overflow.

How mtu could have such low value:

hci_cc_le_read_buffer_size()
  hdev->le_mtu = __le16_to_cpu(rp->le_mtu);

l2cap_conn_add()
  conn->mtu = hcon->hdev->le_mtu;

As shown, mtu is an input from an HCI device. So, any HCI device can
set mtu value to any value, such as lower than 4.

To fix this, this patch adds a validation before subtractions. If MTU is
too small, the corresponding value will set by 0, and a warning message
will show up.

However, I'm not sure that 0-ing the value is the best. It'd be great if
you could comment on this.

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
 net/bluetooth/l2cap_core.c | 94 +++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 84fc70862..472ddfb2e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -541,10 +541,17 @@ static void l2cap_le_flowctl_init(struct l2cap_chan *chan, u16 tx_credits)
 	chan->sdu_last_frag = NULL;
 	chan->sdu_len = 0;
 	chan->tx_credits = tx_credits;
-	/* Derive MPS from connection MTU to stop HCI fragmentation */
-	chan->mps = min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
-	/* Give enough credits for a full packet */
-	chan->rx_credits = (chan->imtu / chan->mps) + 1;
+
+	if (chan->conn->mtu < L2CAP_HDR_SIZE) {
+		BT_WARN("mtu is too small (mtu %d < %d)", chan->conn->mtu, L2CAP_HDR_SIZE);
+		chan->mps = 0;
+		chan->rx_credits = 0;
+	} else {
+		/* Derive MPS from connection MTU to stop HCI fragmentation */
+		chan->mps = min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
+		/* Give enough credits for a full packet */
+		chan->rx_credits = (chan->imtu / chan->mps) + 1;
+	}
 
 	skb_queue_head_init(&chan->tx_q);
 }
@@ -2222,7 +2229,12 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 	BT_DBG("chan %p psm 0x%2.2x len %zu", chan,
 	       __le16_to_cpu(chan->psm), len);
 
-	count = min_t(unsigned int, (conn->mtu - hlen), len);
+	if (conn->mtu < hlen) {
+		count = 0;
+		BT_WARN("mtu is too small (mtu %d < len %d)", conn->mtu, hlen);
+	} else {
+		count = min_t(unsigned int, (conn->mtu - hlen), len);
+	}
 
 	skb = chan->ops->alloc_skb(chan, hlen, count,
 				   msg->msg_flags & MSG_DONTWAIT);
@@ -2253,7 +2265,12 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 
 	BT_DBG("chan %p len %zu", chan, len);
 
-	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
+	if (conn->mtu < L2CAP_HDR_SIZE) {
+		BT_WARN("mtu is too small (mtu %d < %d)", conn->mtu, L2CAP_HDR_SIZE);
+		count = 0;
+	} else {
+		count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
+	}
 
 	skb = chan->ops->alloc_skb(chan, L2CAP_HDR_SIZE, count,
 				   msg->msg_flags & MSG_DONTWAIT);
@@ -2295,7 +2312,12 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 	if (chan->fcs == L2CAP_FCS_CRC16)
 		hlen += L2CAP_FCS_SIZE;
 
-	count = min_t(unsigned int, (conn->mtu - hlen), len);
+	if (conn->mtu < hlen) {
+		BT_WARN("mtu is too small (mtu %d < len %d)", conn->mtu, hlen);
+		count = 0;
+	} else {
+		count = min_t(unsigned int, (conn->mtu - hlen), len);
+	}
 
 	skb = chan->ops->alloc_skb(chan, hlen, count,
 				   msg->msg_flags & MSG_DONTWAIT);
@@ -2412,7 +2434,12 @@ static struct sk_buff *l2cap_create_le_flowctl_pdu(struct l2cap_chan *chan,
 	if (sdulen)
 		hlen += L2CAP_SDULEN_SIZE;
 
-	count = min_t(unsigned int, (conn->mtu - hlen), len);
+	if (conn->mtu < hlen) {
+		BT_WARN("mtu is too small (mtu %d < len %d)", conn->mtu, hlen);
+		count = 0;
+	} else {
+		count = min_t(unsigned int, (conn->mtu - hlen), len);
+	}
 
 	skb = chan->ops->alloc_skb(chan, hlen, count,
 				   msg->msg_flags & MSG_DONTWAIT);
@@ -3225,6 +3252,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	void *ptr = req->data;
 	void *endptr = data + data_size;
 	u16 size;
+	int hlen;
 
 	BT_DBG("chan %p", chan);
 
@@ -3275,14 +3303,19 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data, size_t data
 		break;
 
 	case L2CAP_MODE_ERTM:
+		hlen = L2CAP_EXT_HDR_SIZE + L2CAP_SDULEN_SIZE + L2CAP_FCS_SIZE;
 		rfc.mode            = L2CAP_MODE_ERTM;
 		rfc.max_transmit    = chan->max_tx;
 
 		__l2cap_set_ertm_timeouts(chan, &rfc);
 
-		size = min_t(u16, L2CAP_DEFAULT_MAX_PDU_SIZE, chan->conn->mtu -
-			     L2CAP_EXT_HDR_SIZE - L2CAP_SDULEN_SIZE -
-			     L2CAP_FCS_SIZE);
+		if (chan->conn->mtu < hlen) {
+			BT_WARN("mtu is too small (mtu %d < len %d)", chan->conn->mtu, hlen);
+			size = 0;
+		} else {
+			size = min_t(u16, L2CAP_DEFAULT_MAX_PDU_SIZE, chan->conn->mtu - hlen);
+		}
+
 		rfc.max_pdu_size = cpu_to_le16(size);
 
 		l2cap_txwin_setup(chan);
@@ -3310,6 +3343,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data, size_t data
 		break;
 
 	case L2CAP_MODE_STREAMING:
+		hlen = L2CAP_EXT_HDR_SIZE + L2CAP_SDULEN_SIZE + L2CAP_FCS_SIZE;
 		l2cap_txwin_setup(chan);
 		rfc.mode            = L2CAP_MODE_STREAMING;
 		rfc.txwin_size      = 0;
@@ -3317,9 +3351,12 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data, size_t data
 		rfc.retrans_timeout = 0;
 		rfc.monitor_timeout = 0;
 
-		size = min_t(u16, L2CAP_DEFAULT_MAX_PDU_SIZE, chan->conn->mtu -
-			     L2CAP_EXT_HDR_SIZE - L2CAP_SDULEN_SIZE -
-			     L2CAP_FCS_SIZE);
+		if (chan->conn->mtu < hlen) {
+			BT_WARN("mtu is too small (mtu %d < len %d)", chan->conn->mtu, hlen);
+			size = 0;
+		} else {
+			size = min_t(u16, L2CAP_DEFAULT_MAX_PDU_SIZE, chan->conn->mtu - hlen);
+		}
 		rfc.max_pdu_size = cpu_to_le16(size);
 
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
@@ -3351,7 +3388,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	void *endptr = data + data_size;
 	void *req = chan->conf_req;
 	int len = chan->conf_len;
-	int type, hint, olen;
+	int type, hint, olen, hlen;
 	unsigned long val;
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	struct l2cap_conf_efs efs;
@@ -3496,6 +3533,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 			break;
 
 		case L2CAP_MODE_ERTM:
+			hlen = L2CAP_EXT_HDR_SIZE + L2CAP_SDULEN_SIZE + L2CAP_FCS_SIZE;
 			if (!test_bit(CONF_EWS_RECV, &chan->conf_state))
 				chan->remote_tx_win = rfc.txwin_size;
 			else
@@ -3503,9 +3541,15 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 
 			chan->remote_max_tx = rfc.max_transmit;
 
-			size = min_t(u16, le16_to_cpu(rfc.max_pdu_size),
-				     chan->conn->mtu - L2CAP_EXT_HDR_SIZE -
-				     L2CAP_SDULEN_SIZE - L2CAP_FCS_SIZE);
+			if (chan->conn->mtu < hlen) {
+				BT_WARN("mtu is too small (mtu %d < len %d)",
+					chan->conn->mtu, hlen);
+				size = 0;
+			} else {
+				size = min_t(u16, le16_to_cpu(rfc.max_pdu_size),
+					     chan->conn->mtu - hlen);
+			}
+
 			rfc.max_pdu_size = cpu_to_le16(size);
 			chan->remote_mps = size;
 
@@ -3534,9 +3578,17 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 			break;
 
 		case L2CAP_MODE_STREAMING:
-			size = min_t(u16, le16_to_cpu(rfc.max_pdu_size),
-				     chan->conn->mtu - L2CAP_EXT_HDR_SIZE -
-				     L2CAP_SDULEN_SIZE - L2CAP_FCS_SIZE);
+			hlen = L2CAP_EXT_HDR_SIZE + L2CAP_SDULEN_SIZE + L2CAP_FCS_SIZE;
+
+			if (chan->conn->mtu < hlen) {
+				BT_WARN("mtu is too small (mtu %d < len %d)",
+					chan->conn->mtu, hlen);
+				size = 0;
+			} else {
+				size = min_t(u16, le16_to_cpu(rfc.max_pdu_size),
+					     chan->conn->mtu - hlen);
+			}
+
 			rfc.max_pdu_size = cpu_to_le16(size);
 			chan->remote_mps = size;
 
-- 
2.34.1


