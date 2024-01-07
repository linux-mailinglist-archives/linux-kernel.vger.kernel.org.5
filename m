Return-Path: <linux-kernel+bounces-18805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBA1826334
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 07:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519011F21C05
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DF512B78;
	Sun,  7 Jan 2024 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkM8r+Q8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F0125AF;
	Sun,  7 Jan 2024 06:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-40e43e489e4so2908645e9.1;
        Sat, 06 Jan 2024 22:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704609869; x=1705214669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgblN3HcigowbWqXBnPjGd+MmpbzJDJ5UWz+u8rMOAE=;
        b=mkM8r+Q8frRdXMwdnhvlKLRLdjx/+ei9saaTq/sFQOiNbNfWkzBDPiNypptzojGwCL
         i/pTANmi8Dic7mgIIhq+RhYoMRUo73HjaGVUXAgr5TuqNYL8USar7gi1CfCRRmLu319J
         Sr7HD0di5rwlAXFxWV16W6OL42dSvzFwlMezc2MGTH5CQoRokux7t7Llc4VgndOfZV3E
         dwt9cMqwBEY8bAWStcCkNE042p63UGMt8W8dB/viJTh+75h2q/xljei7Gsb9spgED1co
         q687JhijZuw935l0AR9UT04LSi8FjPkKJ3wJguyqJxVirrKSepcHms/KM4/7hUQG0LE9
         FOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704609869; x=1705214669;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tgblN3HcigowbWqXBnPjGd+MmpbzJDJ5UWz+u8rMOAE=;
        b=OHJhegLI+9SR7DAgr+i0nWgCgcIM2S9gJ6hSsHMWzw7KGyTaNppxwN8IYcel8SZoa1
         sIcGMFBq42qgXzIpdhJx22MEQ0aHvjEdYFvCgzPO6jsi23lDlR4sx05Qxfliispkxh8/
         /LQ/yoPtDjjU6gYgCc+nEm6HjoZzCc8K8kNItLO//7pPdZu1xHPcgvx6MHK9UlJmwBJ5
         etDwPy865jFgcRjRdX1imHdTXS2z307/n921W43Pmg00MnN2HdmLpThF9FdqnPQF0vhK
         pakSKyrp392nWKUhQDjFhrEJssdSZ4vbQxiu7F+FB5vdBoMW3g2ieojwUMD3ALx7y8Kr
         5Fcg==
X-Gm-Message-State: AOJu0Yznt+LU6h2HFC0xOcsGAi7d99+W+twcfqoIToj1iDYgqJdKhboA
	APIkb0gj8Q53JFKhjL9vgB8=
X-Google-Smtp-Source: AGHT+IEAFQmvda4HBy3z9WBFN501KNJDs2F6x8J/2VqOwWvjD6vx5tJx6o7ebX8iB2b9zmKLZnAFEA==
X-Received: by 2002:a7b:c2b2:0:b0:40d:8892:f372 with SMTP id c18-20020a7bc2b2000000b0040d8892f372mr976687wmk.57.1704609869195;
        Sat, 06 Jan 2024 22:44:29 -0800 (PST)
Received: from ?IPV6:2a04:ee41:81:c881:8dae:eb66:b750:3c50? ([2a04:ee41:81:c881:8dae:eb66:b750:3c50])
        by smtp.gmail.com with ESMTPSA id z9-20020a170906714900b00a28479fcb8esm2699045ejj.103.2024.01.06.22.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 22:44:28 -0800 (PST)
Message-ID: <1cf96afe-6a27-4fd5-975e-96122f72df2e@gmail.com>
Date: Sun, 7 Jan 2024 07:44:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Nicolas Maier <nicolas.maier.dev@gmail.com>
Subject: [PATCH] can: bcm: add recvmsg flags for own, local and remote traffic
To: socketcan@hartkopp.net, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

CAN RAW sockets allow userspace to tell if a received CAN frame comes
from the same socket, another socket on the same host, or another host.
See commit 1e55659ce6dd ("can-raw: add msg_flags to distinguish local
traffic"). However, this feature is missing in CAN BCM sockets.

Add the same feature to CAN BCM sockets. When reading a received frame
(opcode RX_CHANGED) using recvmsg, two flags in msg->msg_flags may be
set following the previous convention (from CAN RAW), to distinguish
between 'own', 'local' and 'remote' CAN traffic.

Update the documentation to reflect this change.

Signed-off-by: Nicolas Maier <nicolas.maier.dev@gmail.com>
---
 Documentation/networking/can.rst | 34 ++++++++++++++------------
 net/can/bcm.c                    | 42 +++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index d7e1ada905b2..62519d38c58b 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -444,6 +444,24 @@ definitions are specified for CAN specific MTUs in include/linux/can.h:
   #define CANFD_MTU (sizeof(struct canfd_frame)) == 72  => CAN FD frame
 
 
+Returned Message Flags
+----------------------
+
+When using the system call recvmsg(2) on a RAW or a BCM socket, the
+msg->msg_flags field may contain the following flags:
+
+MSG_DONTROUTE:
+	set when the received frame was created on the local host.
+
+MSG_CONFIRM:
+	set when the frame was sent via the socket it is received on.
+	This flag can be interpreted as a 'transmission confirmation' when the
+	CAN driver supports the echo of frames on driver level, see
+	:ref:`socketcan-local-loopback1` and :ref:`socketcan-local-loopback2`.
+	(Note: In order to receive such messages on a RAW socket,
+	CAN_RAW_RECV_OWN_MSGS must be set.)
+
+
 .. _socketcan-raw-sockets:
 
 RAW Protocol Sockets with can_filters (SOCK_RAW)
@@ -693,22 +711,6 @@ where the CAN_INV_FILTER flag is set in order to notch single CAN IDs or
 CAN ID ranges from the incoming traffic.
 
 
-RAW Socket Returned Message Flags
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-When using recvmsg() call, the msg->msg_flags may contain following flags:
-
-MSG_DONTROUTE:
-	set when the received frame was created on the local host.
-
-MSG_CONFIRM:
-	set when the frame was sent via the socket it is received on.
-	This flag can be interpreted as a 'transmission confirmation' when the
-	CAN driver supports the echo of frames on driver level, see
-	:ref:`socketcan-local-loopback1` and :ref:`socketcan-local-loopback2`.
-	In order to receive such messages, CAN_RAW_RECV_OWN_MSGS must be set.
-
-
 Broadcast Manager Protocol Sockets (SOCK_DGRAM)
 -----------------------------------------------
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 9168114fc87f..32345e155006 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -72,9 +72,11 @@
 #define BCM_TIMER_SEC_MAX (400 * 24 * 60 * 60)
 
 /* use of last_frames[index].flags */
+#define RX_LOCAL   0x10 /* frame was created on the local host */
+#define RX_OWN     0x20 /* frame was sent via the socket it was received on */
 #define RX_RECV    0x40 /* received data for this element */
 #define RX_THR     0x80 /* element not been sent due to throttle feature */
-#define BCM_CAN_FLAGS_MASK 0x3F /* to clean private flags after usage */
+#define BCM_CAN_FLAGS_MASK 0x0F /* to clean private flags after usage */
 
 /* get best masking value for can_rx_register() for a given single can_id */
 #define REGMASK(id) ((id & CAN_EFF_FLAG) ? \
@@ -138,6 +140,19 @@ static LIST_HEAD(bcm_notifier_list);
 static DEFINE_SPINLOCK(bcm_notifier_lock);
 static struct bcm_sock *bcm_busy_notifier;
 
+/* Return pointer to store the extra msg flags for bcm_recvmsg().
+ * We use the space of one unsigned int beyond the 'struct sockaddr_can'
+ * in skb->cb.
+ */
+static inline unsigned int *bcm_flags(struct sk_buff *skb)
+{
+	sock_skb_cb_check_size(sizeof(struct sockaddr_can) +
+			       sizeof(unsigned int));
+
+	/* return pointer after struct sockaddr_can */
+	return (unsigned int *)(&((struct sockaddr_can *)skb->cb)[1]);
+}
+
 static inline struct bcm_sock *bcm_sk(const struct sock *sk)
 {
 	return (struct bcm_sock *)sk;
@@ -325,6 +340,7 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 	struct sock *sk = op->sk;
 	unsigned int datalen = head->nframes * op->cfsiz;
 	int err;
+	unsigned int *pflags;
 
 	skb = alloc_skb(sizeof(*head) + datalen, gfp_any());
 	if (!skb)
@@ -344,8 +360,16 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 		 * relevant for updates that are generated by the
 		 * BCM, where nframes is 1
 		 */
-		if (head->nframes == 1)
+		if (head->nframes == 1) {
+			pflags = bcm_flags(skb);
+			*pflags = 0;
+			if (firstframe->flags & RX_LOCAL)
+				*pflags |= MSG_DONTROUTE;
+			if (firstframe->flags & RX_OWN)
+				*pflags |= MSG_CONFIRM;
+
 			firstframe->flags &= BCM_CAN_FLAGS_MASK;
+		}
 	}
 
 	if (has_timestamp) {
@@ -444,7 +468,7 @@ static void bcm_rx_changed(struct bcm_op *op, struct canfd_frame *data)
 		op->frames_filtered = op->frames_abs = 0;
 
 	/* this element is not throttled anymore */
-	data->flags &= (BCM_CAN_FLAGS_MASK|RX_RECV);
+	data->flags &= ~RX_THR;
 
 	memset(&head, 0, sizeof(head));
 	head.opcode  = RX_CHANGED;
@@ -642,7 +666,7 @@ static enum hrtimer_restart bcm_rx_thr_handler(struct hrtimer *hrtimer)
 static void bcm_rx_handler(struct sk_buff *skb, void *data)
 {
 	struct bcm_op *op = (struct bcm_op *)data;
-	const struct canfd_frame *rxframe = (struct canfd_frame *)skb->data;
+	struct canfd_frame *rxframe = (struct canfd_frame *)skb->data;
 	unsigned int i;
 
 	if (op->can_id != rxframe->can_id)
@@ -657,6 +681,13 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 			return;
 	}
 
+	/* add flags to distinguish between own/local/remote CAN traffic */
+	if (skb->sk) {
+		rxframe->flags |= RX_LOCAL;
+		if (skb->sk == op->sk)
+			rxframe->flags |= RX_OWN;
+	}
+
 	/* disable timeout */
 	hrtimer_cancel(&op->timer);
 
@@ -1675,6 +1706,9 @@ static int bcm_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
 	}
 
+	/* assign the flags that have been recorded in bcm_send_to_user() */
+	msg->msg_flags |= *(bcm_flags(skb));
+
 	skb_free_datagram(sk, skb);
 
 	return size;
-- 
2.34.1


