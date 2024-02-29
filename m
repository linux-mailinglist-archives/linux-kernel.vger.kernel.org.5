Return-Path: <linux-kernel+bounces-86063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0344B86BF19
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811E11F22A66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29AA40BE7;
	Thu, 29 Feb 2024 02:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="TgQOZxbL"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5AD3BBCF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709174623; cv=none; b=Nr9yQkg4DNJrT+yBqRtNHV69h0ntVb93quMKQHqBCsFxvD09s1mNRX3857IewFLT0b1X3eeUutlIwMwecMDsFGfEfr44vw7S8IVI305UCSkpDeJIAH7ma6/cDgaiG3OZ/YRkAKMBoIzNwwmJHBzr2c9ROFERD9MteG6AbpATMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709174623; c=relaxed/simple;
	bh=3Bml3fisOhf12xoHuFgq9dvsIWbtNV/lOg2k7b3U5H4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSHMRYsjwIwBBPDyg2orgQGWgJt2DNSyNPd5UWmDeKQ0BSbH+dyzgCb4cgOZ+6ye01zzMUI3qZDCf9Am+/tVY/jbsBoWIvgFeHfMEuEKHYvPbPkFpXFQRsRxn9bqgUDDIeBmjpL5Dw5ijQcvqUGOa3O5LL2Endl7Li8CXOAOsHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=TgQOZxbL; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c7f3f66d17so19602239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709174620; x=1709779420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0/Uo8bpOofX8j1GcCdenVCAyHrsJbHLlgNs8scFou8=;
        b=TgQOZxbL+79lTGwM2Zl8pEXWYom9hJA5OztW3zkIaiK3lxViPu0aY8K2q8LXOaMDfT
         h6MOkRuRuvfZn5Dd8s8j8aLJRzMUWHv1xx9kblr45h9SiAPV3htsF9eviXCkUEYQnqim
         kq96zYIYL1x0HI8mXJMYC2kvWXfJ+bk+PbRbH2Og+ej4CWcVuJfhP3Kmi2+7YSK68NZs
         zEVq1SGzigaa6ampzEF7kQ6sot+qIavrq8TNd7q/6cDWKE22UphXlNh2iyCkjY8ZrG8C
         7XtaUSrNTxnrA48koJZgJZL4fLO3vHqa3EssEtpFwPOefk8jvXRbF15/67yoIXRVw0St
         vaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709174620; x=1709779420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0/Uo8bpOofX8j1GcCdenVCAyHrsJbHLlgNs8scFou8=;
        b=nsMHCXA3Mai0999fZ3zMlEhzGcvPH0U5MppjbtL8x0ZBvRh/dKFHrJJnsShZm4xtlG
         0xKuLS337/a/3ilUh+YoD2dUIlQ+qzul7DRDP7V+CgfJX7GiMmYJN4qXtaVNm8YNio1M
         aet55D4Ws9GDHl2FCC8xXLdr+gcH0X3lrerIqDQX1FqUliFtZ8L7AQZK1wsWRZN3osef
         vxxEE4uEQy6cZeQC8tA9MPf94thgIYK9iRdIBr9TQzCezW47mTK0Rrg2Ct0gn1gB/rHr
         zaMqgQUxYWLPp4eaVA/J3s+bKeDNgZguuLgLSCmVA4Pj8RHf2eE/Wvi70U8I/+T6fK0h
         YEpA==
X-Forwarded-Encrypted: i=1; AJvYcCWSvkOsYZwhYZwivAum0zAAAl4MSyhSrzlXrK7AvFDGbKh/uoys5AMwsTy5oo/6V2WTr8lqJ/fsS0RbJgEMbazX+82SfobBF8Pn2wBL
X-Gm-Message-State: AOJu0YwS+VRd1xVkXNX0QStv/ZZ5wd7QAlGu202XUyjjG38kqdOi/+IQ
	m3+GdKVZmFY4njNiN1jXLQIPA67WqxhuciO4rQmx6Ers8lVjKKxKlphytOmkYF8=
X-Google-Smtp-Source: AGHT+IFHS+/I2I1geaDiHB0u47wojczAJlRr4O9aK0E5+a2fyLFbLDiHZLmrP7DZFQ/lEpHyiN1qfg==
X-Received: by 2002:a92:c990:0:b0:365:1044:4dcd with SMTP id y16-20020a92c990000000b0036510444dcdmr1252439iln.16.1709174619962;
        Wed, 28 Feb 2024 18:43:39 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id u23-20020aa78497000000b006e5092fb3efsm141504pfn.159.2024.02.28.18.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 18:43:39 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 8/8] Staging: rtl8192e: Rename function GetHalfNmodeSupportByAPsHandler()
Date: Wed, 28 Feb 2024 18:43:25 -0800
Message-Id: <20240229024325.453374-9-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229024325.453374-1-tdavies@darkphysics.net>
References: <20240229024325.453374-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function GetHalfNmodeSupportByAPsHandler to
get_half_nmode_support_by_aps_handler to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Fix commit message 75 char limit
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   | 2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c    | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index fc5014f719d7..50a4e1cb8c79 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -657,7 +657,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->ps_is_queue_empty = _rtl92e_is_tx_queue_empty;
 
 	priv->rtllib->get_nmode_support_by_sec_cfg = rtl92e_get_nmode_support_by_sec;
-	priv->rtllib->GetHalfNmodeSupportByAPsHandler =
+	priv->rtllib->get_half_nmode_support_by_aps_handler =
 						rtl92e_is_halfn_supported_by_ap;
 
 	priv->rtllib->set_hw_reg_handler = rtl92e_set_reg;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 57e1a361a7c9..047da39f730e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -354,7 +354,7 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 			}
 		}
 
-		if (priv->rtllib->GetHalfNmodeSupportByAPsHandler(dev))
+		if (priv->rtllib->get_half_nmode_support_by_aps_handler(dev))
 			target_ratr &=  0xf00fffff;
 
 		current_ratr = rtl92e_readl(dev, RATR0);
diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 04f3fb54d1b7..834329886ea2 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -276,7 +276,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 	ba->ba_timeout_value = *ba_timeout_value;
 	ba->ba_start_seq_ctrl = *ba_start_seq_ctrl;
 
-	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev) ||
+	if (ieee->get_half_nmode_support_by_aps_handler(ieee->dev) ||
 	    (ieee->ht_info->iot_action & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
 		ba->ba_param_set.field.buffer_size = 1;
 	else
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index abc21ae49ff7..fa96a2c2c916 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -252,7 +252,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	}
 
 	cap_ele->AdvCoding		= 0;
-	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
+	if (ieee->get_half_nmode_support_by_aps_handler(ieee->dev))
 		cap_ele->ChlWidth = 0;
 	else
 		cap_ele->ChlWidth = 1;
@@ -301,7 +301,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 		if (ht->iot_action & HT_IOT_ACT_DISABLE_RX_40MHZ_SHORT_GI)
 			cap_ele->ShortGI40Mhz		= 0;
 
-		if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
+		if (ieee->get_half_nmode_support_by_aps_handler(ieee->dev)) {
 			cap_ele->ChlWidth = 0;
 			cap_ele->MCS[1] = 0;
 		}
@@ -408,7 +408,7 @@ static u8 ht_filter_mcs_rate(struct rtllib_device *ieee, u8 *pSupportMCS,
 
 	ht_pick_mcs_rate(ieee, pOperateMCS);
 
-	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
+	if (ieee->get_half_nmode_support_by_aps_handler(ieee->dev))
 		pOperateMCS[1] = 0;
 
 	for (i = 2; i <= 15; i++)
@@ -666,7 +666,7 @@ void ht_set_connect_bw_mode(struct rtllib_device *ieee,
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
+	if (ieee->get_half_nmode_support_by_aps_handler(ieee->dev))
 		bandwidth = HT_CHANNEL_WIDTH_20;
 
 	if (ht_info->sw_bw_in_progress) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 9d9420f7a371..be2615bae6ca 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1486,7 +1486,7 @@ struct rtllib_device {
 				    enum ht_extchnl_offset Offset);
 	bool (*get_nmode_support_by_sec_cfg)(struct net_device *dev);
 	void (*set_wireless_mode)(struct net_device *dev, u8 wireless_mode);
-	bool (*GetHalfNmodeSupportByAPsHandler)(struct net_device *dev);
+	bool (*get_half_nmode_support_by_aps_handler)(struct net_device *dev);
 	u8   (*rtllib_ap_sec_type)(struct rtllib_device *ieee);
 	void (*init_gain_handler)(struct net_device *dev, u8 Operation);
 	void (*ScanOperationBackupHandler)(struct net_device *dev,
-- 
2.39.2


