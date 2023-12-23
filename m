Return-Path: <linux-kernel+bounces-10201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1533481D127
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B541F265D0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C028026AE9;
	Sat, 23 Dec 2023 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="mGkC6Euw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E482224F6
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d427518d52so5662495ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 18:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296801; x=1703901601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BktDQORon2gJNPuuSt33xykHEvagQr8m3GmUmeHfDaE=;
        b=mGkC6EuwXVe5DoJdTAPK+v8iqFzLtLk8s1mwlx6/ZWEcM/IhMOX5//odE6NvlGKwn2
         aIlv8d+HZYb9ZzTCqAB/hJOYsr1xniP0dEs1eRzPatyG+SBTcRhiooX9Xm0nmX+GROLk
         tiTcbrLBEY9hsP3G/4tNsZOv3zJS+z2FiCQiTcEGRoi13yXiiVBkLZDdBAMfYMhs5Cjk
         8OcVh8NTl+SIsZ6Bw87UmEVPouk3DvMBjfjOnCT3s5vyvvAOvp15TU5RwS67Jpzka4oW
         6RB50/+311ab+ih5591uMt3/8WxKr+J+xoEwuTCBhlEfyTCYayCAVU5ZQAAXgG7sKwUK
         D2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296801; x=1703901601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BktDQORon2gJNPuuSt33xykHEvagQr8m3GmUmeHfDaE=;
        b=JDfHYg2MxxRIdumixHwl3jS4dTCJdxGuPPt6g2DQJLd9br3R5g7XpJbQbdkXkeHdnz
         NaVUIdLyG6IJGEOwdy+uiWaMv0BxqR1HEirKcprfgBzl3QiaDotnE6wTLrYOnMS2aLP0
         NScYQmlN2bjRKn2Bwkji7GReDfY1WeLgXvUHwaq/kr+OD0hItvDL3OdLqH8eupn2e+Kp
         UcTRbRDZiwBSZvqY1otg63uXSUo9P1zbqg4pcDAu1sGqsxFMxhKpsXsK8uYkLy45d/Hp
         1F5R6SucbqPesLx2VLF8WHaO7ETG4ulGV3WJSuX02AYKC9yqM+qSpM9nU/okZPPMs4ny
         QJxg==
X-Gm-Message-State: AOJu0Yyb9D6E2bWCtW41WApAlvdJuRsAayOIV2uhb5WXWsC0RXo4xITz
	+o+sK0IOJbSffQW/XSxu68MxXx+IjJPFEA==
X-Google-Smtp-Source: AGHT+IEDAPqY1m9Q3IRJ+TzSbrjIL9Kt3Y6V2C2Ze2q6HCrY+6y32Yrf55HnxaMk95EwK+LDj3onPQ==
X-Received: by 2002:a17:903:230a:b0:1d3:f8b8:4e6 with SMTP id d10-20020a170903230a00b001d3f8b804e6mr2587498plh.43.1703296801552;
        Fri, 22 Dec 2023 18:00:01 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.18.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 18:00:00 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 18/20] Staging: rtl8192e: Rename variable skb_waitQ
Date: Fri, 22 Dec 2023 17:59:40 -0800
Message-Id: <20231223015942.418263-19-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223015942.418263-1-tdavies@darkphysics.net>
References: <20231223015942.418263-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable skb_waitQ to skb_waitq to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c    | 2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c      | 6 +++---
 drivers/staging/rtl8192e/rtllib.h                 | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c         | 8 ++++----
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
index eba8364d0ff2..7f0c160bc741 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
@@ -63,9 +63,9 @@ bool rtl92e_send_cmd_pkt(struct net_device *dev, u32 type, const void *data,
 
 		if (type == DESC_PACKET_TYPE_INIT &&
 		    (!priv->rtllib->check_nic_enough_desc(dev, TXCMD_QUEUE) ||
-		     (!skb_queue_empty(&priv->rtllib->skb_waitQ[TXCMD_QUEUE])) ||
+		     (!skb_queue_empty(&priv->rtllib->skb_waitq[TXCMD_QUEUE])) ||
 		     (priv->rtllib->queue_stop))) {
-			skb_queue_tail(&priv->rtllib->skb_waitQ[TXCMD_QUEUE],
+			skb_queue_tail(&priv->rtllib->skb_waitq[TXCMD_QUEUE],
 				       skb);
 		} else {
 			priv->rtllib->softmac_hard_start_xmit(skb, dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 763ecaad6652..ed0c152c2477 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1728,7 +1728,7 @@ void rtl92e_stop_adapter(struct net_device *dev, bool reset)
 	}
 
 	for (i = 0; i < MAX_QUEUE_SIZE; i++)
-		skb_queue_purge(&priv->rtllib->skb_waitQ[i]);
+		skb_queue_purge(&priv->rtllib->skb_waitq[i]);
 
 	skb_queue_purge(&priv->skb_queue);
 }
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index bef042233117..5107d06a9fd0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -723,7 +723,7 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	skb_queue_head_init(&priv->skb_queue);
 
 	for (i = 0; i < MAX_QUEUE_SIZE; i++)
-		skb_queue_head_init(&priv->rtllib->skb_waitQ[i]);
+		skb_queue_head_init(&priv->rtllib->skb_waitq[i]);
 }
 
 static void _rtl92e_init_priv_lock(struct r8192_priv *priv)
@@ -1574,9 +1574,9 @@ static void _rtl92e_tx_resume(struct net_device *dev)
 
 	for (queue_index = BK_QUEUE;
 	     queue_index < MAX_QUEUE_SIZE; queue_index++) {
-		while ((!skb_queue_empty(&ieee->skb_waitQ[queue_index])) &&
+		while ((!skb_queue_empty(&ieee->skb_waitq[queue_index])) &&
 		(priv->rtllib->check_nic_enough_desc(dev, queue_index) > 0)) {
-			skb = skb_dequeue(&ieee->skb_waitQ[queue_index]);
+			skb = skb_dequeue(&ieee->skb_waitq[queue_index]);
 			ieee->softmac_data_hard_start_xmit(skb, dev, 0);
 		}
 	}
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 4df46eae6aa8..9fd8a7199ee0 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1382,7 +1382,7 @@ struct rtllib_device {
 	int mgmt_queue_head;
 	int mgmt_queue_tail;
 	u8 AsocRetryCount;
-	struct sk_buff_head skb_waitQ[MAX_QUEUE_SIZE];
+	struct sk_buff_head skb_waitq[MAX_QUEUE_SIZE];
 
 	bool	bdynamic_txpower_enable;
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 3f7d2954ebd7..e4e1a84932ba 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -236,7 +236,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct rtllib_device *ieee)
 		/* check whether the managed packet queued greater than 5 */
 		if (!ieee->check_nic_enough_desc(ieee->dev,
 						 tcb_desc->queue_index) ||
-		    skb_queue_len(&ieee->skb_waitQ[tcb_desc->queue_index]) ||
+		    skb_queue_len(&ieee->skb_waitq[tcb_desc->queue_index]) ||
 		    ieee->queue_stop) {
 			/* insert the skb packet to the management queue
 			 *
@@ -246,7 +246,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct rtllib_device *ieee)
 			netdev_info(ieee->dev,
 			       "%s():insert to waitqueue, queue_index:%d!\n",
 			       __func__, tcb_desc->queue_index);
-			skb_queue_tail(&ieee->skb_waitQ[tcb_desc->queue_index],
+			skb_queue_tail(&ieee->skb_waitq[tcb_desc->queue_index],
 				       skb);
 		} else {
 			ieee->softmac_hard_start_xmit(skb, ieee->dev);
@@ -1823,7 +1823,7 @@ void rtllib_softmac_xmit(struct rtllib_txb *txb, struct rtllib_device *ieee)
 	 * the wait queue
 	 */
 	for (i = 0; i < txb->nr_frags; i++) {
-		queue_len = skb_queue_len(&ieee->skb_waitQ[queue_index]);
+		queue_len = skb_queue_len(&ieee->skb_waitq[queue_index]);
 		if ((queue_len  != 0) ||
 		    (!ieee->check_nic_enough_desc(ieee->dev, queue_index)) ||
 		    (ieee->queue_stop)) {
@@ -1832,7 +1832,7 @@ void rtllib_softmac_xmit(struct rtllib_txb *txb, struct rtllib_device *ieee)
 			 * to check it any more.
 			 */
 			if (queue_len < 200)
-				skb_queue_tail(&ieee->skb_waitQ[queue_index],
+				skb_queue_tail(&ieee->skb_waitq[queue_index],
 					       txb->fragments[i]);
 			else
 				kfree_skb(txb->fragments[i]);
-- 
2.39.2


