Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F05D7EA409
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjKMTxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjKMTw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:52:59 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0136D71
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:55 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc7077d34aso35660105ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1699905175; x=1700509975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AuVLb4fA3daVXSMcJTuwoKLmJRUAXractVm1EqtscQ=;
        b=ePQu+mqr4WtTFIzKDW82Jzm/gLKLTtOZTeophnJwutuODl892TCUCRL2bA5EJJbd+F
         +uEkiNsJPG1muCXPZWl+2JRqXPQq+Y4Q/JMs1982gzkkLAdTbtEhtp4QPFpFvmELOexk
         C1fQmf6RasX6BwWxET5sm42tasmvnWbgtzpaxapPJUgSrYSsuVSIEsYtbai5R+YRXwh5
         W/BX/lRaGp4fH5Uylfz57rF+5hAo3TGDDlRSkSk9eimrBOV/pR98oUgrF3woiGlXV4B9
         H1fENO0uTFSJdbnjz+J+93xNmZuorYN36YxLdpJVNT81C4O+xc3OdInH35TjknpBfzmc
         B1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699905175; x=1700509975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AuVLb4fA3daVXSMcJTuwoKLmJRUAXractVm1EqtscQ=;
        b=QTeDfDHZ7DD5Twhk1HQCEwdws8Vs0uIkvGZwoqhSM5ymE08XCSJYzrBrqv1fGU1nx6
         JUwNEupEExlhoJTdREB+LSQa6MSSO7r6oaCudb/pT2bCdDTd6c7lgtgQUwXMM5JReNqq
         UE2AKXb002UpEFFyxHshzbgYLs2mHDSiTNWL2LwpBtueJKPjf9eeI52caPu7O4gpmDj8
         IMTo7m9De55X5tCzIlh2TQ1n1YuhxnDjAnm+DbR1XbwlNMPbnADvYaW0iUK62wSRRJNi
         +RTFW15VXp/ICrMVXsRQg0wzocRfPU71LMkFaYltC1pg/eWFMV+Xa3TrTy6JMgma2f5k
         8qww==
X-Gm-Message-State: AOJu0YxQe43dkiz1f0pHcsWnwhI14WRqf+wh3NxQXIQ5R8n4j8SA+ONJ
        bYLj/GO/ihqGVT8CphkA60zHkA==
X-Google-Smtp-Source: AGHT+IEX2t6diMZLW5mAIvZMQeMy5O7jfoM9b9RwdqVVznjEancZ7bMrFmVO6bLFpvzVB+dS9sshrA==
X-Received: by 2002:a17:902:e744:b0:1cc:6e8f:c14d with SMTP id p4-20020a170902e74400b001cc6e8fc14dmr278510plf.50.1699905175120;
        Mon, 13 Nov 2023 11:52:55 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b001c9d968563csm4395815plz.79.2023.11.13.11.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 11:52:54 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 6/7] Staging: rtl8192e: Rename variable bOverwritePending
Date:   Mon, 13 Nov 2023 11:59:09 -0800
Message-ID: <20231113195910.8423-7-tdavies@darkphysics.net>
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

Rename variable bOverwritePending to overwrite_pending to fix
checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index cbf74cac0599..3502f27342e3 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -462,11 +462,11 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 }
 
 void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
-			   u8 policy, u8	bOverwritePending)
+			   u8 policy, u8	overwrite_pending)
 {
 	struct ba_record *ba = &ts->TxPendingBARecord;
 
-	if (ba->b_valid && !bOverwritePending)
+	if (ba->b_valid && !overwrite_pending)
 		return;
 
 	deactivate_ba_entry(ieee, ba);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d2cf3cfaaaba..adaab56a9fb1 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1788,7 +1788,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
 void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
-			   u8 policy, u8 bOverwritePending);
+			   u8 policy, u8 overwrite_pending);
 void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 			   struct ts_common_info *pTsCommonInfo,
 			   enum tr_select TxRxSelect);
-- 
2.39.2

