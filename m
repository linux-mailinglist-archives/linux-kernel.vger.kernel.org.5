Return-Path: <linux-kernel+bounces-18510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5032B825E6F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771051C241A6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B862BAF0;
	Sat,  6 Jan 2024 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="iHu6W19B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87A2250FA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so810096b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520585; x=1705125385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H33jhdtcfhHUPT0ndrN93Mt9bUqcWYbvRKTpfThBxFU=;
        b=iHu6W19BRMQ9Fn7GRtxQp5E4FJZ17vEW0aooEhZiS6YzWgtFMNwgo9B+dwwZfZKymu
         q6XI3wcxCjesfmvMbkUQMTSB2hWczNoPh/9pp/o5UdSmlDo9FRrq4AuWAlYByGS49W/h
         NjjlsnWnAPJ4cCgEOMJ8QW+LxuPzeQ4HGKZBn6kzfZtoxtHDhPLCSa3DDkqigyHuE90i
         MmE35+7GdT7fwxnB68ryIwBc7AbEDSCJYFLlmT85NHSQMZkEy6xUIWA2FmwBAPpYskh+
         9nM7cyyXqny/Tfa3yP987BF37mK5IpsIS4odq+O2flaiXGCQhNAQFKIOfMAHAkINULb4
         CcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520585; x=1705125385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H33jhdtcfhHUPT0ndrN93Mt9bUqcWYbvRKTpfThBxFU=;
        b=X7+M9byH+Mh4axCrXlHqkxBEa6DXd2uoqao0fyMPj0u4bHYst5UtSNJCyhw2Hk5lEK
         rRvh9eGOL2Ji8OweRyPtaRK1LNb1Z9wH/FKKyrq6rjb82dL/Vc9MfFOETSh9z1s6pLiw
         Pi9ULFyC22YWeiVGHS1feO6lOGV9UN6DmCDVzMJEte9miCE6JPueOBwx31BpLujncZxc
         YclSlvnm6bbRVcdZgWtNLtH6wcrH5rflqKozuSzkwAOVLyVD0NOZeQ54eKQSed0b9s8E
         5XgyHqNMOqhtIE35O9TMGxwGg2lHHw5kbUjZWPt7lfhC4MxQ9Um0Mrt1zL5gEVHh05Wp
         cy0Q==
X-Gm-Message-State: AOJu0YwB5Ct/oFXRp2bnu24+yf1kw2VH7ykfUE9oBAoZly7yCUAWwcyJ
	CnS2YGbFytblf9tZpZ9mazV8IpNVbgzRAw==
X-Google-Smtp-Source: AGHT+IE0OGnyRMqlsYFSqrgQHOLMwZ791g7109T94tDn06CdJ37PcUAjai85tfC9UA5L9YDF40OP/g==
X-Received: by 2002:a05:6a20:4305:b0:199:729f:c0b6 with SMTP id h5-20020a056a20430500b00199729fc0b6mr292122pzk.1.1704520585431;
        Fri, 05 Jan 2024 21:56:25 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:25 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 20/21] Staging: rtl8192e: Rename function GetNmodeSupportBySecCfg()
Date: Fri,  5 Jan 2024 21:55:55 -0800
Message-Id: <20240106055556.430948-21-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240106055556.430948-1-tdavies@darkphysics.net>
References: <20240106055556.430948-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function GetNmodeSupportBySecCfg to get_nmode_support_by_sec_cfg
fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index e499f96e9010..76aacd27e157 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -656,7 +656,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->enter_sleep_state = rtl92e_enter_sleep;
 	priv->rtllib->ps_is_queue_empty = _rtl92e_is_tx_queue_empty;
 
-	priv->rtllib->GetNmodeSupportBySecCfg = rtl92e_get_nmode_support_by_sec;
+	priv->rtllib->get_nmode_support_by_sec_cfg = rtl92e_get_nmode_support_by_sec;
 	priv->rtllib->GetHalfNmodeSupportByAPsHandler =
 						rtl92e_is_halfn_supported_by_ap;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index c453af8dec47..2d753a159358 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1484,7 +1484,7 @@ struct rtllib_device {
 	void (*set_bw_mode_handler)(struct net_device *dev,
 				    enum ht_channel_width bandwidth,
 				    enum ht_extchnl_offset Offset);
-	bool (*GetNmodeSupportBySecCfg)(struct net_device *dev);
+	bool (*get_nmode_support_by_sec_cfg)(struct net_device *dev);
 	void (*set_wireless_mode)(struct net_device *dev, u8 wireless_mode);
 	bool (*GetHalfNmodeSupportByAPsHandler)(struct net_device *dev);
 	u8   (*rtllib_ap_sec_type)(struct rtllib_device *ieee);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 533af4b28aa7..b9b79f6b0c08 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1664,7 +1664,7 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 		ieee->link_state = RTLLIB_ASSOCIATING_AUTHENTICATED;
 		ieee->softmac_stats.rx_auth_rs_ok++;
 		if (!(ieee->ht_info->iot_action & HT_IOT_ACT_PURE_N_MODE)) {
-			if (!ieee->GetNmodeSupportBySecCfg(ieee->dev)) {
+			if (!ieee->get_nmode_support_by_sec_cfg(ieee->dev)) {
 				if (is_ht_half_nmode_aps(ieee)) {
 					support_nmode = true;
 					half_support_nmode = true;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index f1e9a0390be0..b82f3415085b 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -286,7 +286,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 	if (ht_info->iot_action & HT_IOT_ACT_TX_NO_AGGREGATION)
 		return;
 
-	if (!ieee->GetNmodeSupportBySecCfg(ieee->dev))
+	if (!ieee->get_nmode_support_by_sec_cfg(ieee->dev))
 		return;
 	if (ht_info->current_ampdu_enable) {
 		if (!rtllib_get_ts(ieee, (struct ts_common_info **)(&ts), hdr->addr1,
-- 
2.39.2


