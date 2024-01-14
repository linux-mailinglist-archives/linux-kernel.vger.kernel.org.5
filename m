Return-Path: <linux-kernel+bounces-25473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0757F82D0D2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F140282324
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9A12581;
	Sun, 14 Jan 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3pwl/yx"
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F120EB;
	Sun, 14 Jan 2024 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so14024214a12.0;
        Sun, 14 Jan 2024 06:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705241292; x=1705846092; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4yDjR1SKUvH8EHTh9P5DMl/5y4Y79qGtVURgPZy4fo=;
        b=X3pwl/yxXuLrDLzJxJKkOaqOweXr9TcN1XMOecxpilAormWfAjyQZ0kupAlInzu+sx
         tfuDdPnQ9qfYl4j7lsUKv97rVRTMwaDDjWgGCC0n0O99Vf4LB8QZAg3VcYnWHXJrcQPV
         EgGvD8ohsoan/6xRa9irUl4tINNJ6hjuwUFDOlaSnpL2Dpsm1IG/4hOTJ4A/Lgdc2Ar6
         Q6Lo2osdw3mEdyuhtXY34bPRzDFW0lcJ5bP8wqPd89gtoD5uM9lc6gx0Z8zX62y4Jy6L
         XCuJemzXy9DFeNJDKUFvklc3gcnCXs16Ngh4aW5LVZwf7/XQpOQBUZ8b6sNW0pDffZs2
         irew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705241292; x=1705846092;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j4yDjR1SKUvH8EHTh9P5DMl/5y4Y79qGtVURgPZy4fo=;
        b=gl9Iz863Jt/x7nuptxdg8G+dQHUsqBmBJRNemW/ryhCBRfjCtWuLBd0QCq+Yu5QF8o
         ECveAezSruYFjRCDm2pJMHGWzx659pXljt7jFnjE4VwMZnNPpLzmVV0GuTi1A+UOIpKP
         y4QLI94r90GQ8O5yo3WONqfeZGULEot0vUkk20O1x9GzxI8qU4rN87SHbgQ99VV0Z82u
         oQ7xdFijskvIitprg/1bqwoGpl99fslBevPZEBnVrvVtdZoLuy+cpjftZPanFILZIGrp
         NOVNPB08ogowTwCMeYoLNOu6EZaPtzZxqhApNGg2KAmoDg4VzHpvUFgEYIp5ItQeCtBq
         4T7g==
X-Gm-Message-State: AOJu0Yyg63cF5KUBxAxMvqiN4/EkPGsb4LGRh07ax3lDI9JLm0pPsp6Z
	rQiiTyFsHPJpOxBxBcGdbUQ=
X-Google-Smtp-Source: AGHT+IE2owUaDz7v70BvnlPw2u8iTbzNWJL3M5ehmpIQC/t/8vAkqTHgBPbal7OLub4f/wd/kIeUng==
X-Received: by 2002:a05:6402:64c:b0:559:1ff3:d05e with SMTP id u12-20020a056402064c00b005591ff3d05emr1042062edx.10.1705241291732;
        Sun, 14 Jan 2024 06:08:11 -0800 (PST)
Received: from ?IPV6:2a04:ee41:81:c881:98da:8231:7230:735c? ([2a04:ee41:81:c881:98da:8231:7230:735c])
        by smtp.gmail.com with ESMTPSA id g19-20020a056402321300b00558cc87e582sm3216566eda.52.2024.01.14.06.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jan 2024 06:08:11 -0800 (PST)
Message-ID: <4f433c14-94d5-493d-96b1-8a0180026ad5@gmail.com>
Date: Sun, 14 Jan 2024 15:08:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Nicolas Maier <nicolas.maier.dev@gmail.com>
Subject: [PATCH v2] can: bcm: add recvmsg flags for own, local and remote
 traffic
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

v2:
* add 'traffic_flags' parameter to bcm_rx_update_and_send and
  bcm_rx_cmp_to_index, to put the flags in the can frame after its data
  has been copied

 Documentation/networking/can.rst | 34 +++++++++--------
 net/can/bcm.c                    | 65 ++++++++++++++++++++++++++------
 2 files changed, 72 insertions(+), 27 deletions(-)

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
index 9168114fc87f..8c0468823911 100644
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
@@ -465,13 +489,17 @@ static void bcm_rx_changed(struct bcm_op *op, struct canfd_frame *data)
  */
 static void bcm_rx_update_and_send(struct bcm_op *op,
 				   struct canfd_frame *lastdata,
-				   const struct canfd_frame *rxdata)
+				   const struct canfd_frame *rxdata,
+				   unsigned char traffic_flags)
 {
 	memcpy(lastdata, rxdata, op->cfsiz);
 
 	/* mark as used and throttled by default */
 	lastdata->flags |= (RX_RECV|RX_THR);
 
+	/* add own/local/remote traffic flags */
+	lastdata->flags |= traffic_flags;
+
 	/* throttling mode inactive ? */
 	if (!op->kt_ival2) {
 		/* send RX_CHANGED to the user immediately */
@@ -508,7 +536,8 @@ static void bcm_rx_update_and_send(struct bcm_op *op,
  *                       received data stored in op->last_frames[]
  */
 static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
-				const struct canfd_frame *rxdata)
+				const struct canfd_frame *rxdata,
+				unsigned char traffic_flags)
 {
 	struct canfd_frame *cf = op->frames + op->cfsiz * index;
 	struct canfd_frame *lcf = op->last_frames + op->cfsiz * index;
@@ -521,7 +550,7 @@ static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
 
 	if (!(lcf->flags & RX_RECV)) {
 		/* received data for the first time => send update to user */
-		bcm_rx_update_and_send(op, lcf, rxdata);
+		bcm_rx_update_and_send(op, lcf, rxdata, traffic_flags);
 		return;
 	}
 
@@ -529,7 +558,7 @@ static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
 	for (i = 0; i < rxdata->len; i += 8) {
 		if ((get_u64(cf, i) & get_u64(rxdata, i)) !=
 		    (get_u64(cf, i) & get_u64(lcf, i))) {
-			bcm_rx_update_and_send(op, lcf, rxdata);
+			bcm_rx_update_and_send(op, lcf, rxdata, traffic_flags);
 			return;
 		}
 	}
@@ -537,7 +566,7 @@ static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
 	if (op->flags & RX_CHECK_DLC) {
 		/* do a real check in CAN frame length */
 		if (rxdata->len != lcf->len) {
-			bcm_rx_update_and_send(op, lcf, rxdata);
+			bcm_rx_update_and_send(op, lcf, rxdata, traffic_flags);
 			return;
 		}
 	}
@@ -644,6 +673,7 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	struct bcm_op *op = (struct bcm_op *)data;
 	const struct canfd_frame *rxframe = (struct canfd_frame *)skb->data;
 	unsigned int i;
+	unsigned char traffic_flags;
 
 	if (op->can_id != rxframe->can_id)
 		return;
@@ -673,15 +703,24 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 		return;
 	}
 
+	/* compute flags to distinguish between own/local/remote CAN traffic */
+	traffic_flags = 0;
+	if (skb->sk) {
+		traffic_flags |= RX_LOCAL;
+		if (skb->sk == op->sk)
+			traffic_flags |= RX_OWN;
+	}
+
 	if (op->flags & RX_FILTER_ID) {
 		/* the easiest case */
-		bcm_rx_update_and_send(op, op->last_frames, rxframe);
+		bcm_rx_update_and_send(op, op->last_frames, rxframe,
+				       traffic_flags);
 		goto rx_starttimer;
 	}
 
 	if (op->nframes == 1) {
 		/* simple compare with index 0 */
-		bcm_rx_cmp_to_index(op, 0, rxframe);
+		bcm_rx_cmp_to_index(op, 0, rxframe, traffic_flags);
 		goto rx_starttimer;
 	}
 
@@ -698,7 +737,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 			if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) ==
 			    (get_u64(op->frames, 0) &
 			     get_u64(op->frames + op->cfsiz * i, 0))) {
-				bcm_rx_cmp_to_index(op, i, rxframe);
+				bcm_rx_cmp_to_index(op, i, rxframe,
+						    traffic_flags);
 				break;
 			}
 		}
@@ -1675,6 +1715,9 @@ static int bcm_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
 	}
 
+	/* assign the flags that have been recorded in bcm_send_to_user() */
+	msg->msg_flags |= *(bcm_flags(skb));
+
 	skb_free_datagram(sk, skb);
 
 	return size;
-- 
2.34.1


