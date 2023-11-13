Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930247EA408
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjKMTxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjKMTw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:52:57 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66641D73
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:54 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3814483a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1699905174; x=1700509974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3ZFbRf5QF8emwC/w3WYuA83Bws9qICliBA0TogsMdo=;
        b=C9cvfKJq5yD4E4vvUiGkPlzpuhE5+L8ul489z3OL3Ey72yg33prIo+1eEZBB4WPd9I
         4GjV0ypfy/vuXVHtjmIVgjIeK/2xm6Hx7J9dhyB+feqAP4hVDrVKKFnEPnA/jmcG/jpM
         J7YukHRnGa7mgyg2SGeQ1a+CpF+kp31yBRbpm2etkHnaR/lt1XqEC+AjD2pCK5/yyyEa
         ohLofxhW0PDz3YFiQUCO1LwJYUYfkXJa6BJrV81R4wkcfkxITB+pC+ziBIOJuMbE0l84
         /47F2s5OWD5UdXmeT8iwAFhEyPMucAImVWV7QIQ7+eni3mJusWQZSngkxIqWGtxCz6CU
         f4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699905174; x=1700509974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3ZFbRf5QF8emwC/w3WYuA83Bws9qICliBA0TogsMdo=;
        b=LnEl+ohFVDdFyO163EzN4qiI6pz8QQ529qSjKRXdj9kVohY2vu7sBc1QTDHIw4Oglt
         WN3E0s6IeWLUi2xRM+9gq34eyBFNdHJLVxn9chvoWiXz6OUndZcvza2rAwhQbaMaoVbl
         BN7ywwDYqf4Bur/ELGNHHneXSbXRYI83ydQgl1/JxSksZp2Vp2MZLSOxgOlUgJiA/r2h
         endhTzUOdRlmikTRGfSkh7e7CtX15C+/C5WjJ7LFshqwq8kNpJAj1HOrGnktX18b7c7z
         rMGwL6eX3sUadny9Fw7Van22Z1coixVUWjL2Et/yj8skYBpeDc3BqSJnrWLw3C24/Xmi
         azKg==
X-Gm-Message-State: AOJu0YzgmY2WA5TP0MqEQskKuXndNNHjes8g6cSoJjDAaOBHeQy4mVg9
        zAXwV7Gk6KG4vRTREDU7exjAriusnDtFNJGmjz4=
X-Google-Smtp-Source: AGHT+IEtWbSm/kFvgs2GDyN6Y4UoiO3YT99eZWrDpnzlkY9UbFzF0XU7r+hqJe3A6AfSDkL2UQDGcA==
X-Received: by 2002:a05:6a20:8e26:b0:17b:9d92:7d0 with SMTP id y38-20020a056a208e2600b0017b9d9207d0mr9292514pzj.52.1699905173900;
        Mon, 13 Nov 2023 11:52:53 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b001c9d968563csm4395815plz.79.2023.11.13.11.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 11:52:53 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 5/7] Staging: rtl8192e: Rename variable bUsingBa
Date:   Mon, 13 Nov 2023 11:59:08 -0800
Message-ID: <20231113195910.8423-6-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113195910.8423-1-tdavies@darkphysics.net>
References: <20231113195910.8423-1-tdavies@darkphysics.net>
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

Rename variable bUsingBa to using_ba to fix
checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c      | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 631c857c508f..cbf74cac0599 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -452,7 +452,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 			return -1;
 		}
 
-		pTxTs->bUsingBa = false;
+		pTxTs->using_ba = false;
 		pTxTs->add_ba_req_in_progress = false;
 		pTxTs->add_ba_req_delayed = false;
 		del_timer_sync(&pTxTs->TsAddBaTimer);
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 0bf73b625708..289314de1193 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -29,7 +29,7 @@ struct tx_ts_record {
 	struct ba_record TxAdmittedBARecord;
 	u8				add_ba_req_in_progress;
 	u8				add_ba_req_delayed;
-	u8				bUsingBa;
+	u8				using_ba;
 	u8				bDisable_AddBa;
 	struct timer_list		TsAddBaTimer;
 	u8				num;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 3a1bb512ca69..867889dc4fb6 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -103,7 +103,7 @@ static void ResetTxTsEntry(struct tx_ts_record *ts)
 	ts->TxCurSeq = 0;
 	ts->add_ba_req_in_progress = false;
 	ts->add_ba_req_delayed = false;
-	ts->bUsingBa = false;
+	ts->using_ba = false;
 	ts->bDisable_AddBa = false;
 	rtllib_reset_ba_entry(&ts->TxAdmittedBARecord);
 	rtllib_reset_ba_entry(&ts->TxPendingBARecord);
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index a99c3b3f867c..cee3b8855c0e 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -304,10 +304,10 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 				TsStartAddBaProcess(ieee, pTxTs);
 			}
 			goto FORCED_AGG_SETTING;
-		} else if (!pTxTs->bUsingBa) {
+		} else if (!pTxTs->using_ba) {
 			if (SN_LESS(pTxTs->TxAdmittedBARecord.ba_start_seq_ctrl.field.seq_num,
 				    (pTxTs->TxCurSeq + 1) % 4096))
-				pTxTs->bUsingBa = true;
+				pTxTs->using_ba = true;
 			else
 				goto FORCED_AGG_SETTING;
 		}
-- 
2.39.2

