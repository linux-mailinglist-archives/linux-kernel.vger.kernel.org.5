Return-Path: <linux-kernel+bounces-82683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93258868844
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70AD1C21C90
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BB53366;
	Tue, 27 Feb 2024 04:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="lddZzrG2"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7EF524C3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008926; cv=none; b=rtVfeliRsjPFjcrMwpnnINo7mIScW6O1jrZ7hlBX221ddJDhY3uFTFyU+yWTIZHis9ua3zi8gg6yndch2PdHJ2f7+/Djs6JroevPusWtsocQ/ilbAEHIXUwD2YBnKNYIv79CaMX/2L8Dk+mncp9Td3kegISJlV8C1SOHguvVUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008926; c=relaxed/simple;
	bh=7FS6zboPVKp/u6cdjRlp/OUBOf4WFDoOI/h1oZm16XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MrUt39QWF1j2BdjKGyuvVlmmkRVPBdEIk+RPGQnSN8af59dS06r4WhrvVw2nd2hR6siX08dCoH+7GkAs//7HT2qh5rNPL1ohPWxMLmjEWMmc1Qmdn454OKZbr8UYfX3QKa2WZb65c5+78RUFdgqucSY7WfkAV6mI9/Lu5ssbiwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=lddZzrG2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e54d7b1167so9289b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008924; x=1709613724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOad59tfXdoV6gQPevYJtRHql3Ukjg+EtPQnCtMszN0=;
        b=lddZzrG2W1oupOZzphX0J/cjytkgPMX+mNAEmwXrgTXWPbBb8LEGrERseaMVmgBnEi
         PbZfOp6q9z5QlDxP6bcV+PvdlEsA1TAG1n6HKkXHdVlYbIx59fGaguBruY6im/u68ary
         vr1JHrTXl7lSDQTCIjC++yGCK3U2Y6x6Mv/tQsF7hctJE5ewtPmGjWdFWmaptcrCz+Rl
         LzlAbpr59Je07aVVDU0CWWBpKmlXj/7zWjFTje3uUMN1NnKYU8lSg1hkncSAOjQgb/fz
         u9uKnHyEpkq+pnBy0Lg92caqUYoSkUReVMoWlUFwrkLWuo9mUgk3URtStNAfGI5by8VH
         TwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008924; x=1709613724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOad59tfXdoV6gQPevYJtRHql3Ukjg+EtPQnCtMszN0=;
        b=tRRnMGvf//S+OBWgF+BAV/C6IKogmNjC2wwb2SiKXVitRRFxvip0ASy1WoSSkZ1c8l
         m8fXQPu/5Mt2KqNVHeN14vXzvQnFsjyfz0wVA6XKRYQ2WZjDsxj6A9sDRJoBqPPbhtdJ
         X1PArqUR8WXoJR6utQw85Bmjl1Mid9hR9mlMTe3/RpdXGIvjPSOQCGdTe4gbPz0NEMGw
         0tIgMSTrawDEatvrJ/L9fF926inJND9sD+oZoFS+TRb8vC5DwYLmatpjHYmcjyCDTNAm
         TcSYXTkBIK5UURzvLB3LUkd/qZ8v+kn7jbBg0U6Kple3h9YyKfvpMwllc0kvbuJR445s
         fc4w==
X-Forwarded-Encrypted: i=1; AJvYcCUOjluRJHzfKNR6PTBNVo6VwKautLEPbKjK+JCG3GYcRORSX/GnOUr6dfBVSyti9/7LpJCp/ewOMOesJ+Sa3f14f4OdLsv97pc5ssAo
X-Gm-Message-State: AOJu0YzLkjJFxIHkb4DXeymoBaTWXf9z9gl77OUICvJKNsN9zsQAjFwO
	teJUFG/+leLm9qaFeQlrksVUYIS3TMRDKZazJobyKVeRlSRcxJmfrP4KG4ucA81/ByyiySh662h
	K
X-Google-Smtp-Source: AGHT+IFcNV1zfISvABrSouUjN2uaWWu3Eyq8EiddX043di1NDkqN9zhHi91Q3oTfxvX8uty22dqS8A==
X-Received: by 2002:a05:6a00:1883:b0:6e4:8294:e0e5 with SMTP id x3-20020a056a00188300b006e48294e0e5mr12939162pfh.6.1709008924106;
        Mon, 26 Feb 2024 20:42:04 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:03 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 02/20] Staging: rtl8192e: Rename variable NumRecvDataInPeriod
Date: Mon, 26 Feb 2024 20:41:39 -0800
Message-Id: <20240227044157.407379-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227044157.407379-1-tdavies@darkphysics.net>
References: <20240227044157.407379-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable NumRecvDataInPeriod to num_recv_data_in_period to
fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Fix 75 char line limit checkpatch warning
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 6 +++---
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 705b94f0911e..f99cc5b639fe 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -925,7 +925,7 @@ static void _rtl92e_update_rxcounts(struct r8192_priv *priv, u32 *TotalRxBcnNum,
 	priv->rtllib->link_detect_info.RxBcnNum[slot_index] =
 			priv->rtllib->link_detect_info.num_recv_bcn_in_period;
 	priv->rtllib->link_detect_info.RxDataNum[slot_index] =
-			priv->rtllib->link_detect_info.NumRecvDataInPeriod;
+			priv->rtllib->link_detect_info.num_recv_data_in_period;
 	for (i = 0; i < priv->rtllib->link_detect_info.slot_num; i++) {
 		*TotalRxBcnNum += priv->rtllib->link_detect_info.RxBcnNum[i];
 		*TotalRxDataNum += priv->rtllib->link_detect_info.RxDataNum[i];
@@ -1045,7 +1045,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 			priv->check_roaming_cnt = 0;
 		}
 		ieee->link_detect_info.num_recv_bcn_in_period = 0;
-		ieee->link_detect_info.NumRecvDataInPeriod = 0;
+		ieee->link_detect_info.num_recv_data_in_period = 0;
 	}
 
 	spin_lock_irqsave(&priv->tx_lock, flags);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 95a8e9416f61..30b9178071ae 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1111,7 +1111,7 @@ enum scan_op_backup_opt {
 #define RT_MAX_LD_SLOT_NUM	10
 struct rt_link_detect {
 	u32				num_recv_bcn_in_period;
-	u32				NumRecvDataInPeriod;
+	u32				num_recv_data_in_period;
 
 	u32				RxBcnNum[RT_MAX_LD_SLOT_NUM];
 	u32				RxDataNum[RT_MAX_LD_SLOT_NUM];
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 29bdaff4cbab..526d5969399c 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1283,7 +1283,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	/* Filter WAPI DATA Frame */
 
 	/* Update statstics for AP roaming */
-	ieee->link_detect_info.NumRecvDataInPeriod++;
+	ieee->link_detect_info.num_recv_data_in_period++;
 	ieee->link_detect_info.num_rx_ok_in_period++;
 
 	/* Data frame - extract src/dst addresses */
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index f12ee685e989..83f337e27209 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1075,9 +1075,9 @@ static void rtllib_associate_complete_wq(void *data)
 				       ieee->current_network.beacon_interval /
 				       500);
 	if (ieee->link_detect_info.num_recv_bcn_in_period == 0 ||
-	    ieee->link_detect_info.NumRecvDataInPeriod == 0) {
+	    ieee->link_detect_info.num_recv_data_in_period == 0) {
 		ieee->link_detect_info.num_recv_bcn_in_period = 1;
-		ieee->link_detect_info.NumRecvDataInPeriod = 1;
+		ieee->link_detect_info.num_recv_data_in_period = 1;
 	}
 	psc->lps_idle_count = 0;
 	ieee->link_change(ieee->dev);
@@ -2071,7 +2071,7 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 	ieee->link_detect_info.slot_index = 0;
 	ieee->link_detect_info.slot_num = 2;
 	ieee->link_detect_info.num_recv_bcn_in_period = 0;
-	ieee->link_detect_info.NumRecvDataInPeriod = 0;
+	ieee->link_detect_info.num_recv_data_in_period = 0;
 	ieee->link_detect_info.num_tx_ok_in_period = 0;
 	ieee->link_detect_info.num_rx_ok_in_period = 0;
 	ieee->link_detect_info.num_rx_unicast_ok_in_period = 0;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 4102c2d4f8dd..d6bc74ba9092 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -348,9 +348,9 @@ void rtllib_wx_sync_scan_wq(void *data)
 	rtllib_sta_ps_send_null_frame(ieee, 0);
 
 	if (ieee->link_detect_info.num_recv_bcn_in_period == 0 ||
-	    ieee->link_detect_info.NumRecvDataInPeriod == 0) {
+	    ieee->link_detect_info.num_recv_data_in_period == 0) {
 		ieee->link_detect_info.num_recv_bcn_in_period = 1;
-		ieee->link_detect_info.NumRecvDataInPeriod = 1;
+		ieee->link_detect_info.num_recv_data_in_period = 1;
 	}
 	rtllib_wake_all_queues(ieee);
 
-- 
2.39.2


