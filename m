Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70087F98C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjK0Fgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjK0FgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:23 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30358131
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:27 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfd04a6e49so2948175ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063386; x=1701668186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnWmbSD77bZFfBCr2C5cF8GBPNk3SBRZbqkEH4Q4DFY=;
        b=C5DC+bbwR+oBVZg2XtK/24utG0D3Cw9mSC3FuZg0+4LqhZtDWtzdb5JMEbS4VXbz6M
         HxOVFZOPe/aHwzavDvd1+BdUb6sO7mJamDGqi3zY4O4RVtmjQLZShnTpQADKp/Knk87S
         BRxwx+HMul8M9qEcb4TAZi8IoYkfV9FxRwXy1+NU+6sgJmdPDBbVakwKxPC4A9QfOsdm
         mx/rB8BNfvlp9gUpKA4oowDdWqJsiCITnfsXLK/ROCJk8LuBzzwBA0mtu64ozh/BXncW
         yr2oEnAuqEJx3p1NDEXn925MuDcaSOL+nFvhQqCq+qiIjNf2noSRXpjs1qOBbatcklRT
         Bm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063386; x=1701668186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnWmbSD77bZFfBCr2C5cF8GBPNk3SBRZbqkEH4Q4DFY=;
        b=jLCcO4dVGTBJN9EdhacaYXskUwI+Uq9RPMtk9c2agxm8VBbdd8Vn1HCtD5F3YF8WTr
         5ia1OPGHuJUuXzudN1J62xOnZaNHtsvPdhmVB/LKqsXHswQt70tnxxTrAsr7WlsedIaq
         nu6BzOaYahvg7t+UnD1VoL3L0MbWl/qa5OeOCSCVbVJnDX49tz3tI4gbzgPsAt7mBxBf
         r5SZaCaqFzsBO0DTGR/3p9BieLY8K8yTuVFOxyVWHhqvPVwxMC+J/LuEqxaOjVDm97gm
         J++qphHTuG0zOm55WK+yzZc3ycbuSurc8kTiN1YGBR3El+M+tepsrKdnT2E/iNqQ3wzP
         5I8g==
X-Gm-Message-State: AOJu0Yy905C1LU8Ajwtcaljk4GUc1FeY6FhZogA55ZfpPQ/dPe5Txa2G
        VEJD7T02nfVrUH5FGaJMYDE1ig==
X-Google-Smtp-Source: AGHT+IEhKJ19eBREPey/YsreiDKMqly62ClQzzPUbIbQxPlO5yC8nHUg9ET24Ff1ZstcsMmqXStOVg==
X-Received: by 2002:a17:903:1245:b0:1cf:6675:b313 with SMTP id u5-20020a170903124500b001cf6675b313mr15105151plh.22.1701063386692;
        Sun, 26 Nov 2023 21:36:26 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:26 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 09/15] Staging: rtl8192e: Rename variable TxCurSeq
Date:   Sun, 26 Nov 2023 21:42:59 -0800
Message-ID: <20231127054305.148276-10-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127054305.148276-1-tdavies@darkphysics.net>
References: <20231127054305.148276-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable TxCurSeq to tx_cur_seq to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c      | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index d11cbe3bbb31..328947fc058c 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -477,7 +477,7 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 	ba->ba_param_set.field.tid = ts->TsCommonInfo.tspec.ucTSID;
 	ba->ba_param_set.field.buffer_size = 32;
 	ba->ba_timeout_value = 0;
-	ba->ba_start_seq_ctrl.field.seq_num = (ts->TxCurSeq + 3) % 4096;
+	ba->ba_start_seq_ctrl.field.seq_num = (ts->tx_cur_seq + 3) % 4096;
 
 	activate_ba_entry(ba, BA_SETUP_TIMEOUT);
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index fdd5f1a2e835..4ab712634b4b 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -24,7 +24,7 @@ struct ts_common_info {
 
 struct tx_ts_record {
 	struct ts_common_info TsCommonInfo;
-	u16				TxCurSeq;
+	u16				tx_cur_seq;
 	struct ba_record tx_pending_ba_record;
 	struct ba_record tx_admitted_ba_record;
 	u8				add_ba_req_in_progress;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 2e6b705437d9..e06e563ae718 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -100,7 +100,7 @@ static void ResetTsCommonInfo(struct ts_common_info *ts_common_info)
 static void ResetTxTsEntry(struct tx_ts_record *ts)
 {
 	ResetTsCommonInfo(&ts->TsCommonInfo);
-	ts->TxCurSeq = 0;
+	ts->tx_cur_seq = 0;
 	ts->add_ba_req_in_progress = false;
 	ts->add_ba_req_delayed = false;
 	ts->using_ba = false;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 51a8286abd18..92e5be85148e 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -306,7 +306,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 			goto FORCED_AGG_SETTING;
 		} else if (!ts->using_ba) {
 			if (SN_LESS(ts->tx_admitted_ba_record.ba_start_seq_ctrl.field.seq_num,
-				    (ts->TxCurSeq + 1) % 4096))
+				    (ts->tx_cur_seq + 1) % 4096))
 				ts->using_ba = true;
 			else
 				goto FORCED_AGG_SETTING;
@@ -500,8 +500,8 @@ static u16 rtllib_query_seqnum(struct rtllib_device *ieee, struct sk_buff *skb,
 		if (!rtllib_get_ts(ieee, (struct ts_common_info **)(&ts), dst,
 			   skb->priority, TX_DIR, true))
 			return 0;
-		seqnum = ts->TxCurSeq;
-		ts->TxCurSeq = (ts->TxCurSeq + 1) % 4096;
+		seqnum = ts->tx_cur_seq;
+		ts->tx_cur_seq = (ts->tx_cur_seq + 1) % 4096;
 		return seqnum;
 	}
 	return 0;
-- 
2.39.2

