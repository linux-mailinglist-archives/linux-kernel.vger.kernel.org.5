Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8251A7EA40A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjKMTxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjKMTxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:53:04 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2980D10DA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:56 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc3bb32b5dso42789645ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1699905176; x=1700509976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENLdxhSBNg8SuBVApZdY1dC55L+cF5EgmlEgQ0l3pHA=;
        b=iiZLq/NOap7KMX8EA/cKcOBYHxl03EXa0EQ7EGVRBBG4bXHURFFTO6irJtZqmRJ+I4
         2OWw6hoGjzDFECtAA1qUvR7VdGEmwq2G/+TQTMMtkb/+Qk2SsZiPvYAI/G3vIS4sP0i4
         hj4okORLMM+gxFn0jJ3gBdgTs5tGsn016EC8b9BmIJK72Mu9X+FWDIrbQFJQtnApshck
         Q1CHUzcTmJ2ktYX691cdWxqmurCmp79HJMitW7nGxJ6FXikz+rCYlNj8Jn3aW6o1mC8A
         p8fRviwcLMPbf1omf3Bs9F71yAOGvcB/r3V3s1q4z975yXuXqj+hLefgFDY56aHwXbbR
         8Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699905176; x=1700509976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENLdxhSBNg8SuBVApZdY1dC55L+cF5EgmlEgQ0l3pHA=;
        b=eawjKAnIyWQij9M1GYlo/D53rjEbLp8gvWSXh4YZqD9Y+utU0TYJZnakciZEbZ0YsJ
         0axGt3D0kUyh7gVEVrxU2yS+Kkn3yYKKPr0mlKOaWo+uHdiOTRA1/IpdhnZGfeix36+T
         u9dgYI/JpB5GEz/FB1BHEzoO+BeJ5Ru4oIq5KjVVpjSBgV16HhIehEAJdleDacOEfopS
         oVB8dtoC6v0zEm8+epIdmX4LVACdexx3pBbQlHvU+mbz78sUeLsWN7tAv0punDRXftAA
         5bOeVv9RrqCgpIXQl6bWg1VQWer0BmuFnNu3010dlEYSHRdmyD93qe7RAVkP0mFBpk+R
         9KMQ==
X-Gm-Message-State: AOJu0Yw8A389799laHfNQOKJvhGsF2gsOm7BzIZRaJadmK8/0sbQGB/R
        ozO8r/6oisO33bhnRH112K/lbg==
X-Google-Smtp-Source: AGHT+IE3RbDYuZkrueUm6r3KpdLcuEAtVYjitEdyMsjoi2L+H/t40Z2To2M7tJtBGaYaGMDqlQGuZA==
X-Received: by 2002:a17:903:2448:b0:1cc:be6b:80fa with SMTP id l8-20020a170903244800b001ccbe6b80famr315322pls.12.1699905176423;
        Mon, 13 Nov 2023 11:52:56 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b001c9d968563csm4395815plz.79.2023.11.13.11.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 11:52:56 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 7/7] Staging: rtl8192e: Rename variable bDisable_AddBa
Date:   Mon, 13 Nov 2023 11:59:10 -0800
Message-ID: <20231113195910.8423-8-tdavies@darkphysics.net>
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

Rename variable bDisable_AddBa to disable_add_ba to fix
checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 3502f27342e3..b52b42ac0fc4 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -382,7 +382,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		activate_ba_entry(pAdmittedBA, *pBaTimeoutVal);
 	} else {
 		ts->add_ba_req_delayed = true;
-		ts->bDisable_AddBa = true;
+		ts->disable_add_ba = true;
 		reason_code = DELBA_REASON_END_BA;
 		goto OnADDBARsp_Reject;
 	}
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 289314de1193..742f575ea637 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -30,7 +30,7 @@ struct tx_ts_record {
 	u8				add_ba_req_in_progress;
 	u8				add_ba_req_delayed;
 	u8				using_ba;
-	u8				bDisable_AddBa;
+	u8				disable_add_ba;
 	struct timer_list		TsAddBaTimer;
 	u8				num;
 };
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 867889dc4fb6..41c1e768348a 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -104,7 +104,7 @@ static void ResetTxTsEntry(struct tx_ts_record *ts)
 	ts->add_ba_req_in_progress = false;
 	ts->add_ba_req_delayed = false;
 	ts->using_ba = false;
-	ts->bDisable_AddBa = false;
+	ts->disable_add_ba = false;
 	rtllib_reset_ba_entry(&ts->TxAdmittedBARecord);
 	rtllib_reset_ba_entry(&ts->TxPendingBARecord);
 }
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index cee3b8855c0e..1da098f5b84c 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -300,7 +300,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 				;
 			} else if (tcb_desc->bdhcp == 1) {
 				;
-			} else if (!pTxTs->bDisable_AddBa) {
+			} else if (!pTxTs->disable_add_ba) {
 				TsStartAddBaProcess(ieee, pTxTs);
 			}
 			goto FORCED_AGG_SETTING;
-- 
2.39.2

