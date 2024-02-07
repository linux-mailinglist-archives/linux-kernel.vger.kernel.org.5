Return-Path: <linux-kernel+bounces-56575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005AD84CBDB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8C71F2408A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDE87A70B;
	Wed,  7 Feb 2024 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+nwHWID"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB577653;
	Wed,  7 Feb 2024 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313345; cv=none; b=lLnmNMccA1u4YpICDU08ZTPriL8NuGAtEvrQvazNkWXE+FmtX2YU7omIl/UEnf4AWWjMSoRqfRyjkvpZqPtplJLawNRdkn5AnPYEYAXy7jKxZe6IB91mLzEw2JQSYGPe3PXh8yxvGz/f6xOSGOq5lknFA9NlQ0gPmXVmuTEhsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313345; c=relaxed/simple;
	bh=Q5i1+JxAX3X37h5Opr/MnoRC2yOzxSaGQbgIbaLb9Dw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rBrcPDr/lbkcpvAAq5+EYwHf7WDVylMw0dkaB6HhZhcunRg0g2NLNRt0C00krece53ur4CdYssv/Oon2AxwKPCMpinqzc8GFVN1pAGEYIOLsCcaOiW0/MIfgRjg8/WOF1LPMJEccEebYTNk4+8pl7VJON8bXNHarVjnGW+AkiXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+nwHWID; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a38271c0bd5so90311066b.0;
        Wed, 07 Feb 2024 05:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707313341; x=1707918141; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svSDgPYX8pMwLFJxNK8qqtmJaLjednJg3y5h+ZDs4aw=;
        b=M+nwHWIDaEhPlc2rB25V/cc1VkKH3220dsBfYjfxui0UrnnayyBufGLVRHbMxls26H
         fhvwGA87pAjxZj6g4l4We9nO2lf5rab1Ey1wxkp62z99fKr63YlNcowwtJX8ELtgINLQ
         8rsg+FNnV+78EkdQScYAYxBgkrQGLbSPaVUWCrb37TuinQxbU2/3nfbCwxn9YCLk3ocG
         BHbDg5LtgbiNC8/JkdolEkYtRUF0w4h5Qxk631A2raqj1A1hLwvfRdEu0WX2QbW5DNJi
         mvsYrXKOIsYFZRF5tDGQ0Q2rAPY3tDMQ8/DrEPshr9sTlteUT/7DYfAW21O8/U6ElaeN
         vbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707313341; x=1707918141;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svSDgPYX8pMwLFJxNK8qqtmJaLjednJg3y5h+ZDs4aw=;
        b=fo7fTorFs3WxSGxBIdWW04hIyj+aB/WkAXI5vy/sdqXZU9Tnar27rHSCtKGHJzpH05
         AobVJEqFxq1NdmwjSBl9GwczBOxGpSte9yzh62zamPQSteQoSMaF9N/oC4YSOpNeUwU8
         XtjGXwDNJkiNhZ2VtLM8ydpPIocuZKfPib4Z9GtTwiJHquU63L3yP8i+MmO+P9I8pItu
         rWexOAVJ/pwmt5Y4LnwhEuyZfsXiYUZ7NpiT4bkvDGKwRtJHX5pfA7D9Bvr0oo2wZ+nP
         MWrcyhbh8NKrExae5BXRcmH/yyQFDjdrWXxdVe3ptwF4/++PLcSz1lOaiRJEC9sxU98U
         xfOg==
X-Gm-Message-State: AOJu0YxOCXeMbjjfnZFJK6H1q5CxoPqGAPJ9LA3TV7GRIYAmJ15dSp/a
	tel6dV9UDBDEygIbfEIN2b28u9aNOl6G+jj0RabwCGbJMKfjx/fa
X-Google-Smtp-Source: AGHT+IHbuvGjT0Vd8LtdWDajODsTZctUdqUCO9ot6uEy57r0b1GGenN9vqs2vYUNuRPv5JZCloCWSg==
X-Received: by 2002:a17:906:6b8a:b0:a38:5ce0:2f86 with SMTP id l10-20020a1709066b8a00b00a385ce02f86mr2068370ejr.40.1707313341068;
        Wed, 07 Feb 2024 05:42:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQUo4LjH42nATAcFls2YkfgXjqFucrIzJNeMt2O3ck/gNRxyB9Ojr2MGAyqtKC5s7Yz50dTEybm2p/kIx8iZDASxV7O8bLBhDK4BJjgqPQdRq9IBbqqfSlNcj7Zw+WKiTjVUHu+6B5gMP3/zu18rVj+Zvt9RQssMySw0CWz2h+zj++XYSc+polmuP3vdkPFmSKZuHkn41Z2x5Oi7oGnrEnItfSXRelUGYlKxhFWJi/9QU9BuGh
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:81be:a476:88e2:db23])
        by smtp.gmail.com with ESMTPSA id c17-20020a170906695100b00a34d0a865ecsm754770ejs.163.2024.02.07.05.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:42:20 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] Bluetooth: hci_event: Remove code to removed CONFIG_BT_HS
Date: Wed,  7 Feb 2024 14:42:11 +0100
Message-Id: <20240207134211.29201-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit cec9f3c5561d ("Bluetooth: Remove BT_HS") removes config BT_HS, but
misses two "ifdef BT_HS" blocks in hci_event.c.

Remove this dead code from this removed config option.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 net/bluetooth/hci_event.c | 163 --------------------------------------
 1 file changed, 163 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 271c00792801..07e690b7f8db 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5676,150 +5676,6 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev, void *edata,
 	hci_dev_unlock(hdev);
 }
 
-#if IS_ENABLED(CONFIG_BT_HS)
-static void hci_chan_selected_evt(struct hci_dev *hdev, void *data,
-				  struct sk_buff *skb)
-{
-	struct hci_ev_channel_selected *ev = data;
-	struct hci_conn *hcon;
-
-	bt_dev_dbg(hdev, "handle 0x%2.2x", ev->phy_handle);
-
-	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
-	if (!hcon)
-		return;
-
-	amp_read_loc_assoc_final_data(hdev, hcon);
-}
-
-static void hci_phy_link_complete_evt(struct hci_dev *hdev, void *data,
-				      struct sk_buff *skb)
-{
-	struct hci_ev_phy_link_complete *ev = data;
-	struct hci_conn *hcon, *bredr_hcon;
-
-	bt_dev_dbg(hdev, "handle 0x%2.2x status 0x%2.2x", ev->phy_handle,
-		   ev->status);
-
-	hci_dev_lock(hdev);
-
-	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
-	if (!hcon)
-		goto unlock;
-
-	if (!hcon->amp_mgr)
-		goto unlock;
-
-	if (ev->status) {
-		hci_conn_del(hcon);
-		goto unlock;
-	}
-
-	bredr_hcon = hcon->amp_mgr->l2cap_conn->hcon;
-
-	hcon->state = BT_CONNECTED;
-	bacpy(&hcon->dst, &bredr_hcon->dst);
-
-	hci_conn_hold(hcon);
-	hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
-	hci_conn_drop(hcon);
-
-	hci_debugfs_create_conn(hcon);
-	hci_conn_add_sysfs(hcon);
-
-	amp_physical_cfm(bredr_hcon, hcon);
-
-unlock:
-	hci_dev_unlock(hdev);
-}
-
-static void hci_loglink_complete_evt(struct hci_dev *hdev, void *data,
-				     struct sk_buff *skb)
-{
-	struct hci_ev_logical_link_complete *ev = data;
-	struct hci_conn *hcon;
-	struct hci_chan *hchan;
-	struct amp_mgr *mgr;
-
-	bt_dev_dbg(hdev, "log_handle 0x%4.4x phy_handle 0x%2.2x status 0x%2.2x",
-		   le16_to_cpu(ev->handle), ev->phy_handle, ev->status);
-
-	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
-	if (!hcon)
-		return;
-
-	/* Create AMP hchan */
-	hchan = hci_chan_create(hcon);
-	if (!hchan)
-		return;
-
-	hchan->handle = le16_to_cpu(ev->handle);
-	hchan->amp = true;
-
-	BT_DBG("hcon %p mgr %p hchan %p", hcon, hcon->amp_mgr, hchan);
-
-	mgr = hcon->amp_mgr;
-	if (mgr && mgr->bredr_chan) {
-		struct l2cap_chan *bredr_chan = mgr->bredr_chan;
-
-		l2cap_chan_lock(bredr_chan);
-
-		bredr_chan->conn->mtu = hdev->block_mtu;
-		l2cap_logical_cfm(bredr_chan, hchan, 0);
-		hci_conn_hold(hcon);
-
-		l2cap_chan_unlock(bredr_chan);
-	}
-}
-
-static void hci_disconn_loglink_complete_evt(struct hci_dev *hdev, void *data,
-					     struct sk_buff *skb)
-{
-	struct hci_ev_disconn_logical_link_complete *ev = data;
-	struct hci_chan *hchan;
-
-	bt_dev_dbg(hdev, "handle 0x%4.4x status 0x%2.2x",
-		   le16_to_cpu(ev->handle), ev->status);
-
-	if (ev->status)
-		return;
-
-	hci_dev_lock(hdev);
-
-	hchan = hci_chan_lookup_handle(hdev, le16_to_cpu(ev->handle));
-	if (!hchan || !hchan->amp)
-		goto unlock;
-
-	amp_destroy_logical_link(hchan, ev->reason);
-
-unlock:
-	hci_dev_unlock(hdev);
-}
-
-static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev, void *data,
-					     struct sk_buff *skb)
-{
-	struct hci_ev_disconn_phy_link_complete *ev = data;
-	struct hci_conn *hcon;
-
-	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
-
-	if (ev->status)
-		return;
-
-	hci_dev_lock(hdev);
-
-	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
-	if (hcon && hcon->type == AMP_LINK) {
-		hcon->state = BT_CLOSED;
-		hci_disconn_cfm(hcon, ev->reason);
-		hci_conn_del(hcon);
-	}
-
-	hci_dev_unlock(hdev);
-}
-#endif
-
 static void le_conn_update_addr(struct hci_conn *conn, bdaddr_t *bdaddr,
 				u8 bdaddr_type, bdaddr_t *local_rpa)
 {
@@ -7629,25 +7485,6 @@ static const struct hci_ev {
 	/* [0x3e = HCI_EV_LE_META] */
 	HCI_EV_REQ_VL(HCI_EV_LE_META, hci_le_meta_evt,
 		      sizeof(struct hci_ev_le_meta), HCI_MAX_EVENT_SIZE),
-#if IS_ENABLED(CONFIG_BT_HS)
-	/* [0x40 = HCI_EV_PHY_LINK_COMPLETE] */
-	HCI_EV(HCI_EV_PHY_LINK_COMPLETE, hci_phy_link_complete_evt,
-	       sizeof(struct hci_ev_phy_link_complete)),
-	/* [0x41 = HCI_EV_CHANNEL_SELECTED] */
-	HCI_EV(HCI_EV_CHANNEL_SELECTED, hci_chan_selected_evt,
-	       sizeof(struct hci_ev_channel_selected)),
-	/* [0x42 = HCI_EV_DISCONN_PHY_LINK_COMPLETE] */
-	HCI_EV(HCI_EV_DISCONN_LOGICAL_LINK_COMPLETE,
-	       hci_disconn_loglink_complete_evt,
-	       sizeof(struct hci_ev_disconn_logical_link_complete)),
-	/* [0x45 = HCI_EV_LOGICAL_LINK_COMPLETE] */
-	HCI_EV(HCI_EV_LOGICAL_LINK_COMPLETE, hci_loglink_complete_evt,
-	       sizeof(struct hci_ev_logical_link_complete)),
-	/* [0x46 = HCI_EV_DISCONN_LOGICAL_LINK_COMPLETE] */
-	HCI_EV(HCI_EV_DISCONN_PHY_LINK_COMPLETE,
-	       hci_disconn_phylink_complete_evt,
-	       sizeof(struct hci_ev_disconn_phy_link_complete)),
-#endif
 	/* [0x48 = HCI_EV_NUM_COMP_BLOCKS] */
 	HCI_EV(HCI_EV_NUM_COMP_BLOCKS, hci_num_comp_blocks_evt,
 	       sizeof(struct hci_ev_num_comp_blocks)),
-- 
2.17.1


