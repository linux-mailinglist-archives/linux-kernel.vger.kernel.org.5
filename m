Return-Path: <linux-kernel+bounces-18511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1904C825E70
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5291F25D18
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146B22D606;
	Sat,  6 Jan 2024 05:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="VZOVmtDE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259BF29427
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bbce1202ebso323408b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520586; x=1705125386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAaCyCwNzfZ4eZtP0QBXi92ekqTnHBNVbyk0eh6Fz3I=;
        b=VZOVmtDEIcVZFfG167hE/CSrxMJTtBpyUGPK1wrtprBNiM7h1bj4VGb91OrlQBLusY
         gHZqRcGOLw7Fb0xvbu0KwNI2BSO+85eZeD62e3epSvVfKEb2RN5h90BA1gXYhLJ3yYKz
         xuLiz5Vube8oVg85zkqTEV7LUU/WG5yhn97wH35bvN6EHpJh3BOkkMvweAoa5DSYLq5g
         2oA3v+fBIz3Ry1qnIzCow/Ymwp/LZ22NtxMU6dG2fBwYjSIK7J9p4/bN2TaJG9Hu/faX
         u+1ABh4cJKy1HBJ1xWip0vAqByDIGLMjlW8xmCICGUgOblH7sI6KS4dsqDi5VEAPCknh
         jAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520586; x=1705125386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAaCyCwNzfZ4eZtP0QBXi92ekqTnHBNVbyk0eh6Fz3I=;
        b=w7D9PTCEk6GGwNkO0oQBlg/loOkGeDosstFCSABTF8/asLlYag1Uc4O/CwaLGGPLDs
         VTeAgU9ZTeI30cZlhGedQyYwCC3HIFZelGxhb3Nz6/9b+75A/kYipQpzwxOGhdVQ6JwN
         0TIfvoQ7iasMdux3TSM8Ln2AXixj3H1KaTPsFxH3hTjl4e4Uqilk/nfLOi+Le4EqkGQn
         v/IuX0XIgTGZXJzltaa0XnMoDDj39hT7hOB2v5r+aUeUgki9uXq5UiIBT8UFX1bduOCJ
         zrLkryj3i67ORRf5KYG1R0VfyQ0IOceHXS1AbYE2BwYLZbgKatoG/mOJdwQc+bfgBMlB
         PMOg==
X-Gm-Message-State: AOJu0YyQJa8/3RmDhMZg7qsoaact1uP5vJin/B7iGABubRNnycvmIh86
	+5ePEhZ5dulXQnkk+t36PqyY7QcZfCJzkHm4bItuPbufRgA=
X-Google-Smtp-Source: AGHT+IGtShcAqSOMMtfiQpHHm5D3egyd8RbgBFbci66ojX1tytzPh76rigCSaDDSry9QBBu+IwgZ/A==
X-Received: by 2002:a05:6808:2390:b0:3bb:754b:ffd8 with SMTP id bp16-20020a056808239000b003bb754bffd8mr623084oib.84.1704520586359;
        Fri, 05 Jan 2024 21:56:26 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:26 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 21/21] Staging: rtl8192e: Rename variable AsocRetryCount
Date: Fri,  5 Jan 2024 21:55:56 -0800
Message-Id: <20240106055556.430948-22-tdavies@darkphysics.net>
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

Rename variable AsocRetryCount to asoc_retry_count to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 2d753a159358..0fdc767d43e0 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1381,7 +1381,7 @@ struct rtllib_device {
 	struct sk_buff *mgmt_queue_ring[MGMT_QUEUE_NUM];
 	int mgmt_queue_head;
 	int mgmt_queue_tail;
-	u8 AsocRetryCount;
+	u8 asoc_retry_count;
 	struct sk_buff_head skb_waitq[MAX_QUEUE_SIZE];
 
 	bool	bdynamic_txpower_enable;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index b9b79f6b0c08..9d1e9b780bc7 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1216,7 +1216,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 			ieee->wmm_acm = 0;
 			if (ieee->iw_mode == IW_MODE_INFRA) {
 				/* Join the network for the first time */
-				ieee->AsocRetryCount = 0;
+				ieee->asoc_retry_count = 0;
 				if ((ieee->current_network.qos_data.supported == 1) &&
 				    ieee->current_network.bssht.bd_support_ht)
 					ht_reset_self_and_save_peer_setting(ieee,
@@ -1319,10 +1319,10 @@ static inline u16 assoc_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 	   status_code == WLAN_STATUS_CAPS_UNSUPPORTED) &&
 	   ((ieee->mode == WIRELESS_MODE_G) &&
 	   (ieee->current_network.mode == WIRELESS_MODE_N_24G) &&
-	   (ieee->AsocRetryCount++ < (RT_ASOC_RETRY_LIMIT - 1)))) {
+	   (ieee->asoc_retry_count++ < (RT_ASOC_RETRY_LIMIT - 1)))) {
 		ieee->ht_info->iot_action |= HT_IOT_ACT_PURE_N_MODE;
 	} else {
-		ieee->AsocRetryCount = 0;
+		ieee->asoc_retry_count = 0;
 	}
 
 	return le16_to_cpu(response_head->status);
@@ -1634,7 +1634,7 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 			netdev_info(ieee->dev,
 				    "Association response status code 0x%x\n",
 				    errcode);
-			if (ieee->AsocRetryCount < RT_ASOC_RETRY_LIMIT)
+			if (ieee->asoc_retry_count < RT_ASOC_RETRY_LIMIT)
 				schedule_delayed_work(&ieee->associate_procedure_wq, 0);
 			else
 				rtllib_associate_abort(ieee);
-- 
2.39.2


