Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560E47C92C5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 06:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjJNEkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 00:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjJNEj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 00:39:58 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A93C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 21:39:56 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d865854ef96so3086299276.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 21:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1697258396; x=1697863196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3p4Okgx4XgnfPEk0qlyDp2kdSWTE4Yw2JPS7XRRWXKU=;
        b=in8BDVw2NSqC/hwwBFHlITLRGfHF369gMtyQKk6s3in8kKCGVYwyvh4rEI4Yqqm2KC
         4JKW3tNAFE8OJbi9p7elVWukREQ3AlU+tg0i2OHcHI1VoDbA6h1eDnnEv9+GHH6x+mNg
         nIxlC0PNNzxZpoLWC30q2CnFJZ/KxxaVvaSx0tExLODlwGCIDLSG6Pjk/0y2G/Eoywac
         XrFLXmiPMh30tstN5YXfsIsXxkBOmcuzeNcIfEClj/EnDmgMyXRIta7JfRt2CudoBEOJ
         C7G9s4WDqU/vIs3GlO9LbPbd6j6p0TXfHIRKWvUygE+Om11/K/YoGoBJyL7PwFjRK6w3
         Jadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697258396; x=1697863196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3p4Okgx4XgnfPEk0qlyDp2kdSWTE4Yw2JPS7XRRWXKU=;
        b=pnZuxJTWvgnob5KLDg1YinEgN04jy0tHlBxO94lMRFNziyOuAWPF9zXl6dbHwMucTJ
         EAcSJozsv9ej00jC2UIA3FnbkF7QUweVfHlL4pbH/EriLoMJuUL3tuXIDa1SsaF4vzFC
         QRlI0T1XeefnJ/r9MgzsEI+oHWHA8iI4AF1hEgD6/0Y+UAUfOr6iQPMykBaan2+1zw2O
         3MYmtHaFvpfRMPTxsVhJ1gxSlO9MWrSrRDG2lna4GLW4Ymy7QfkghT538uc9Gp0q3xWp
         BO11SJ0bfg0QiQQfakbU/HsIApVKgJnOdetDYSdAAb4Tg8+cQahknfTdoFaRns6I20dr
         STvQ==
X-Gm-Message-State: AOJu0YwmqRAGfu+SGpo9WyKJAmX8xMavA/fdGM87+rn5ii3TaEdJmHIt
        D2NtNGjHfse1t0IIaXiGrFpVRw==
X-Google-Smtp-Source: AGHT+IGOm4VbjmfX1M+04K7SHGsvYD4Af/ZHbQ1I2dUB4WYp6pgyJp2GGtzKt+QJxwbyW/FYiNDBlg==
X-Received: by 2002:a25:c702:0:b0:d9a:c946:bb47 with SMTP id w2-20020a25c702000000b00d9ac946bb47mr6573250ybe.5.1697258396095;
        Fri, 13 Oct 2023 21:39:56 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y6-20020aa78046000000b006934350c3absm14271926pfm.109.2023.10.13.21.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 21:39:55 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 2/4] Staging: rtl8192e: Rename variable TSInfo
Date:   Fri, 13 Oct 2023 21:44:33 -0700
Message-ID: <20231014044435.11947-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014044435.11947-1-tdavies@darkphysics.net>
References: <20231014044435.11947-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable TSInfo to ts_info to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_Qos.h    | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index a2a0573c3444..a5165fe88217 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -474,7 +474,7 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 	ba->dialog_token++;
 	ba->ba_param_set.field.amsdu_support = 0;
 	ba->ba_param_set.field.ba_policy = policy;
-	ba->ba_param_set.field.tid = pTS->TsCommonInfo.TSpec.f.TSInfo.field.ucTSID;
+	ba->ba_param_set.field.tid = pTS->TsCommonInfo.TSpec.f.ts_info.field.ucTSID;
 	ba->ba_param_set.field.buffer_size = 32;
 	ba->ba_timeout_value = 0;
 	ba->ba_start_seq_ctrl.field.seq_num = (pTS->TxCurSeq + 3) % 4096;
diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index 0499711ea2bf..37677366c397 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -60,7 +60,7 @@ union tspec_body {
 	u8		charData[55];
 
 	struct {
-		union qos_tsinfo TSInfo;
+		union qos_tsinfo ts_info;
 		u16	NominalMSDUsize;
 		u16	MaxMSDUsize;
 		u32	MinServiceItv;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index eaa2a82558f1..16d5164e860d 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -201,8 +201,8 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 			continue;
 		list_for_each_entry(pRet, psearch_list, List) {
 			if (memcmp(pRet->addr, addr, 6) == 0 &&
-			    pRet->TSpec.f.TSInfo.field.ucTSID == TID &&
-			    pRet->TSpec.f.TSInfo.field.ucDirection == dir)
+			    pRet->TSpec.f.ts_info.field.ucTSID == TID &&
+			    pRet->TSpec.f.ts_info.field.ucDirection == dir)
 				break;
 		}
 		if (&pRet->List  != psearch_list)
@@ -242,7 +242,7 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 {
 	u8	UP = 0;
 	union tspec_body TSpec;
-	union qos_tsinfo *ts_info = &TSpec.f.TSInfo;
+	union qos_tsinfo *ts_info = &TSpec.f.ts_info;
 	struct list_head *pUnusedList;
 	struct list_head *pAddmitList;
 	enum direction_value Dir;
-- 
2.39.2

