Return-Path: <linux-kernel+bounces-92820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C4C87267B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C295E28BE48
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75E318C36;
	Tue,  5 Mar 2024 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJo1F27w"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA3718628;
	Tue,  5 Mar 2024 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663045; cv=none; b=RDj+NKqQDDM/7abhINDV8b/ezXrl4hqMacqi55gpVAkpJ32dgXQE16OkQZJMqZorXsv1tYku9HJxingtUy8PD5jgcy0cQiQBY2a+QuboDphrs+0h4npFgeSLkQW5t+kozSxXCw6/xNI5WgeXxGsBOKzJmX5OtsNpNNz2VMwahRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663045; c=relaxed/simple;
	bh=TdfupDTf1t5grk4CAdN9p9bu1bJf5wgJEBrWS5hljOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eT4eGTUeBsinTB1b+uRUm4hCWJfM7CeffWDU3uGxQHwOl5HK7A9cw7n+aAIqLdZP40XjIHhkxq12UD5KePSwm28Z/nZnKrJj1IjlxDAhspwzCWnzWf4dkx8dFDFTcz5N8BIfgDiOaWfXAdvqjgI78Cv51SdzjyIJ6zXzZFhe5nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJo1F27w; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412ee276dc9so6458255e9.1;
        Tue, 05 Mar 2024 10:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709663042; x=1710267842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vewip57IplzR6mytY6eKGIRl6x4l2s/G9UmkfWElT2c=;
        b=jJo1F27wG6ZlYZ4Lfj3ooioshZis+J3Rtgl3tnC9b+e8wJE9uCiceZ1RaqAODX2Irv
         mPGzsU18LEkBDqY25FwF5mKi1FQwd3tde6XAdyg1QqCzPFqmnFzHqQLBv576Tsi/x85P
         cFXMz+cQnr3nwR3fAx8CsDMGPgEwJogQmlnm7xrza0NVoEDDdUzGm8wPqMqR54oPPHNW
         VkRPSR8JwdOp5RTTYPGPtTsg9ymVGhpjmySwRvTAgjk8ide50dtoq3Q/ID1fMezklk/P
         T/BZ95NsEJNOx57WSbgz/5mNqEDLwzb9UK0vFrYfu8A5vM/eMZ+s4S+k7BLqt55pSNup
         ar9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709663042; x=1710267842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vewip57IplzR6mytY6eKGIRl6x4l2s/G9UmkfWElT2c=;
        b=dKz53j1hbJSZoHeZobNXhCPYk3SVtn7msCQyULto/ides2dpTcPySwe/lYIDPZgUYB
         REvNMBnmFd0T0r2MM0y0wYWBkxMZBiVxnz1bDq4ABUS3x/3U8tK8upNKvscWh8Bpcz04
         /GuloAoj7wwS8fNYD7XdVL9TYQFjn504elOTYuMZONbWuo9zck3C1G6EbYCqg8tUI3kB
         KRra4G6bsH3aU7z+t9KJeTn2AjsEbgiE2i1VPGdHaY/3rzsKpl/RzCfRV/hkv2paYFFn
         PG6g8ql+DpffTwJEhUKJkgA72vXESQvvvg7WR6PNDicIQJcRJpJBfcCfk39me3EZhRW4
         xKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4/yIQITTCf4EhsMjjyQ24JuNPBOibDRXvFSLBFnO+XTGtPeV+sNWDFB14Km5THBhpbBuGmzfYN3nEOENN7zxwvSBmSKjHcRe6OnqQ
X-Gm-Message-State: AOJu0Ywyn23oOlTimPZjxCGcy98aNijkKsZLLgG+Wd+1tu3IZMBRDPqW
	8qtX0ozSMQBbGllS5MgV6rxBe7XNgaAPGe+3MM+DMASnjLzdkJl0
X-Google-Smtp-Source: AGHT+IHuLC2lqjmF/KzE+5aw87KqSBEd9s52FBcCsTOYoo6Oei/ieq/y3oovoRv5bXnPKrKBSFxAIw==
X-Received: by 2002:a05:600c:3481:b0:412:e676:2ff1 with SMTP id a1-20020a05600c348100b00412e6762ff1mr4363859wmq.41.1709663041649;
        Tue, 05 Mar 2024 10:24:01 -0800 (PST)
Received: from [::1] ([2001:19f0:ac01:93b:5400:4ff:fe77:2098])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c1d0100b00412ea52b102sm3592206wms.34.2024.03.05.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:24:01 -0800 (PST)
From: Yuxin Wang <yuxinwang9999@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuxin Wang <yuxinwang9999@gmail.com>
Subject: [PATCH] Bluetooth: Fix inconsistent LE packet sending behaviors
Date: Tue,  5 Mar 2024 18:23:49 +0000
Message-Id: <20240305182349.4182578-1-yuxinwang9999@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the `hci_sched_le` function, the calculation of `quote` within
`hci_chan_sent` may become incorrect after breaking from the inner
while loop. The issue stems from `hci_chan_sent` using `hdev->le_cnt`
instead of the updated `cnt`. As a result, `quote` may exceed `cnt`,
leading to a negative `cnt` and causing further inconsistent behaviors.

This patch modifies `cnt` to be a pointer, aligning with the pattern
used in the nearby `hci_sched_iso` function.

Signed-off-by: Yuxin Wang <yuxinwang9999@gmail.com>
---
 net/bluetooth/hci_core.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2821a42ce..785a6dde9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3750,19 +3750,19 @@ static void hci_sched_le(struct hci_dev *hdev)
 {
 	struct hci_chan *chan;
 	struct sk_buff *skb;
-	int quote, cnt, tmp;
+	int quote, *cnt, tmp;
 
 	BT_DBG("%s", hdev->name);
 
 	if (!hci_conn_num(hdev, LE_LINK))
 		return;
 
-	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
+	cnt = hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
 
-	__check_timeout(hdev, cnt, LE_LINK);
+	__check_timeout(hdev, *cnt, LE_LINK);
 
-	tmp = cnt;
-	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
+	tmp = *cnt;
+	while (*cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote-- && (skb = skb_peek(&chan->data_q))) {
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
@@ -3777,7 +3777,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 			hci_send_frame(hdev, skb);
 			hdev->le_last_tx = jiffies;
 
-			cnt--;
+			(*cnt)--;
 			chan->sent++;
 			chan->conn->sent++;
 
@@ -3787,12 +3787,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 		}
 	}
 
-	if (hdev->le_pkts)
-		hdev->le_cnt = cnt;
-	else
-		hdev->acl_cnt = cnt;
-
-	if (cnt != tmp)
+	if (*cnt != tmp)
 		hci_prio_recalculate(hdev, LE_LINK);
 }
 
-- 
2.39.2


