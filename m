Return-Path: <linux-kernel+bounces-2884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9B081639A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAC8282ACF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD41F4D5B9;
	Sun, 17 Dec 2023 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="KwtAIyS+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57594CB22
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28a5d0ebf1fso2689995a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 15:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1702857329; x=1703462129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Xh9057HjSReuOSkTJHqLjqeYxKmFJY7/nLpPeU9NVU=;
        b=KwtAIyS+Hm6LTpgKfZXfcpVbe37qhwjRXNzqLDL2yLCKbZWetwY7bTEWGLb+Y9ScVZ
         tsunYMrxpJ4iLsIHS4nXTLNjk/JUBUfPaqZ43mSTRAE/9LsaOO+beq+gshAlp4ctbkPB
         OtD+PIYovk2eLvjB05ftZbeYKb4kiJXbbm79OyFOZT8OPZLieCiddm4NhxbnusZGn7LM
         vhUkp5F0t1twuCcc7grpVe5CjHXNh2xPHBJ/WyoiyzfxahajFog2KzNupdtAKp7+zyKY
         VuzjywduzkGQPQKpJwEc2rF7MTaWq4QLF2Zy+QQhxEfFvDMCU/TJcl9kUkIe4DpJm8R/
         8GCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702857329; x=1703462129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Xh9057HjSReuOSkTJHqLjqeYxKmFJY7/nLpPeU9NVU=;
        b=XOpZDlztQISD51S7CWf3VsYsfN2cIVVXO4cXaWDQ+rL6fAR9bOwljriZr0iaay4duB
         o6PlBITC1JeKR0yjWXddXsMSSGzX1VknMKxUhDdqJ1uWorbuF9llgZWzAcHHcGqPceas
         UUWQjCNdsFVAGPcZYsn73NjoJ2CGKClMRiqHVQqC53c9zasXAZBZ2YGUc/uRS1ma/bCd
         BG/R6QIIkuwIs4EMXt4Wa+DQwU8zTvHliWJgoniCqIxizvzHooW5JUwTeimGdNlch0c/
         QruAFCHW+i+oBYBdRkIsEQrq2tIiaQZwceQf3V5WXMccTMPl+O9ZMp46SJVhLPifeSc2
         Ti3w==
X-Gm-Message-State: AOJu0Yz2Y539nQ6oF44icdVJ2vhVoFeRgE1jnyCFkwhCyF31S/0tOWek
	u9EqQ5cKokmfuJ+W38IqEwDzbA==
X-Google-Smtp-Source: AGHT+IFb2n5v3YoFspuLtRt+lyzQo9g1VO/PMtFjwsN0/BR9zn2VrKZerGUAbdGHdA6juw82EwWWrQ==
X-Received: by 2002:a17:90a:c705:b0:28b:5cd5:9ff9 with SMTP id o5-20020a17090ac70500b0028b5cd59ff9mr2713446pjt.39.1702857329474;
        Sun, 17 Dec 2023 15:55:29 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090aec8b00b0028ae8284840sm9036176pjy.10.2023.12.17.15.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 15:55:28 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 6/6] Staging: rtl8192e: Rename variable pBaStartSeqCtrl
Date: Sun, 17 Dec 2023 15:55:20 -0800
Message-Id: <20231217235520.30377-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231217235520.30377-1-tdavies@darkphysics.net>
References: <20231217235520.30377-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable pBaStartSeqCtrl to ba_start_seq_ctrl to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index b816f94336f0..3db7dcc3bd23 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -219,7 +219,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	struct ba_record *ba = NULL;
 	union ba_param_set *ba_param_set = NULL;
 	u16 *ba_timeout_value = NULL;
-	union sequence_control *pBaStartSeqCtrl = NULL;
+	union sequence_control *ba_start_seq_ctrl = NULL;
 	struct rx_ts_record *ts = NULL;
 
 	if (skb->len < sizeof(struct ieee80211_hdr_3addr) + 9) {
@@ -241,7 +241,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	dialog_token = tag + 2;
 	ba_param_set = (union ba_param_set *)(tag + 3);
 	ba_timeout_value = (u16 *)(tag + 5);
-	pBaStartSeqCtrl = (union sequence_control *)(req + 7);
+	ba_start_seq_ctrl = (union sequence_control *)(req + 7);
 
 	if (!ieee->current_network.qos_data.active ||
 	    !ieee->ht_info->current_ht_support ||
@@ -274,7 +274,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	ba->dialog_token = *dialog_token;
 	ba->ba_param_set = *ba_param_set;
 	ba->ba_timeout_value = *ba_timeout_value;
-	ba->ba_start_seq_ctrl = *pBaStartSeqCtrl;
+	ba->ba_start_seq_ctrl = *ba_start_seq_ctrl;
 
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev) ||
 	   (ieee->ht_info->iot_action & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
-- 
2.39.2


