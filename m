Return-Path: <linux-kernel+bounces-2879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CE0816395
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBB2282B07
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B8C4B153;
	Sun, 17 Dec 2023 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="fDgO2nlN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7224B130
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b7a9f90edaso238350239f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 15:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1702857325; x=1703462125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlIlq7rrvboEhaW2FAIKDo9AZsxFYdYIP5zRDMCBPuc=;
        b=fDgO2nlNl6Irt/nPw77Do2GkJPFGm/+O6fVZsZLx/gJ+bRDdbAFSVSRV/s04GgVKQ6
         pofSqzK+AFyTPvwktr81ykJaAeOgjsBBest9GoNg+2Q0137LTBPYw/akJBARj22NwqNl
         Fazw489kVwDj9XyDMqgngCY/f7mbxLKNv3DHjw/d3bhYMIO9fpHUVeqWLYLeZxd95Ugo
         TS/XrkxGwbTR0sqU26rmhBt/G4LWr03Uwa58rQ5KHy74jBIQcz1tC0mVfO3aF+tcljCi
         jGkrN/F9zb33/doA5Wsh0fZuf4YqC36CPaWWZ+zF2K9qCZZueKJpoQE1VCZm5U+85Jod
         3qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702857325; x=1703462125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlIlq7rrvboEhaW2FAIKDo9AZsxFYdYIP5zRDMCBPuc=;
        b=sfLjyTuAq3qDiAoyPsOvY2G4IkDsVk/HC0untOIR3eKT0WepY7r37K7W9uuFj8r3B0
         8lKTBkqg9u8VNrkystJXgX1Z79zOdp2aTxg/0rsLFbw1Zru8HLLSB/+ujGqBlJdHyvds
         /JkbAIMd8scUrdlqig0TwqajrzMBrDhnb07FcSDUOo9XEC7YkpxkX1X3yqCUk8BTc4Mm
         70/6+4HEPk6KpHB+uPtpb/Y4XaJ6QjP4Z3yNvi/DRpOzFyJsy55H9dzkiQyI3eowEE8k
         8HLVtICDPbWZhR8vJmdjik33gcJBoO2JBegK6lQoh0d36DeUiTp0xcT8tvdWyzXZU8Gj
         HhCg==
X-Gm-Message-State: AOJu0Yx6mboY3hsNrx4SBzL3yeCrNBChYMLus4zXOLVBhbC3S8nty/3g
	mXAvhUL4fvJZRrvQoKf4DXCLu2S/7xEs18Lkoww=
X-Google-Smtp-Source: AGHT+IGjV+FP//5kKSDOp3LMi7b3ZkUoCSpDUFLiW2Dbmec94LzKeDbbpeXD4QlwM7/d7TeBkW+bJw==
X-Received: by 2002:a05:6e02:1baa:b0:35f:a8fb:e6ad with SMTP id n10-20020a056e021baa00b0035fa8fbe6admr4077531ili.53.1702857325084;
        Sun, 17 Dec 2023 15:55:25 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090aec8b00b0028ae8284840sm9036176pjy.10.2023.12.17.15.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 15:55:24 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 2/6] Staging: rtl8192e: Rename array variable TxTsRecord
Date: Sun, 17 Dec 2023 15:55:16 -0800
Message-Id: <20231217235520.30377-3-tdavies@darkphysics.net>
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

Rename array variable TxTsRecord to tx_ts_records to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 401b9efb25aa..cdbda65b4d50 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -523,7 +523,7 @@ void rtllib_tx_ba_inact_timeout(struct timer_list *t)
 	struct tx_ts_record *ts = from_timer(ts, t,
 					      tx_admitted_ba_record.timer);
 	struct rtllib_device *ieee = container_of(ts, struct rtllib_device,
-				     TxTsRecord[ts->num]);
+				     tx_ts_records[ts->num]);
 	tx_ts_delete_ba(ieee, ts);
 	rtllib_send_DELBA(ieee, ts->ts_common_info.addr,
 			  &ts->tx_admitted_ba_record, TX_DIR,
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index d23d35d5dce1..489261831462 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -85,7 +85,7 @@ static void TsAddBaProcess(struct timer_list *t)
 	struct tx_ts_record *ts = from_timer(ts, t, ts_add_ba_timer);
 	u8 num = ts->num;
 	struct rtllib_device *ieee = container_of(ts, struct rtllib_device,
-				     TxTsRecord[num]);
+				     tx_ts_records[num]);
 
 	rtllib_ts_init_add_ba(ieee, ts, BA_POLICY_IMMEDIATE, false);
 	netdev_dbg(ieee->dev, "%s(): ADDBA Req is started\n", __func__);
@@ -119,7 +119,7 @@ static void ResetRxTsEntry(struct rx_ts_record *ts)
 
 void rtllib_ts_init(struct rtllib_device *ieee)
 {
-	struct tx_ts_record *pTxTS  = ieee->TxTsRecord;
+	struct tx_ts_record *pTxTS  = ieee->tx_ts_records;
 	struct rx_ts_record *rxts  = ieee->rx_ts_records;
 	struct rx_reorder_entry *pRxReorderEntry = ieee->RxReorderEntry;
 	u8				count = 0;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index e7d4ed9eb899..d8da772b0f39 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1225,7 +1225,7 @@ struct rtllib_device {
 	struct list_head		Tx_TS_Admit_List;
 	struct list_head		Tx_TS_Pending_List;
 	struct list_head		Tx_TS_Unused_List;
-	struct tx_ts_record TxTsRecord[TOTAL_TS_NUM];
+	struct tx_ts_record tx_ts_records[TOTAL_TS_NUM];
 	struct list_head		Rx_TS_Admit_List;
 	struct list_head		Rx_TS_Pending_List;
 	struct list_head		Rx_TS_Unused_List;
-- 
2.39.2


