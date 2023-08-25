Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F00788AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343594AbjHYOHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343541AbjHYOHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:07:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402122736
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68becf931d0so795987b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972384; x=1693577184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPmplxJVV6adqWaaprj33kljpEVv+8iOqRG/qMzwQmY=;
        b=gFyPvcF1bpmtB7/Q+e/2+Ahm/70En8bzfs5SPZZJv05j9u5+1OxgOx6plbqRgT8x/j
         Tjr1dYdhTBInHYRNOeGcVhzcsRJBAvyzI0N+NAtDmuuFZh0pQ9Aaa8Wujal0F2bx2+Ww
         AnCjAHUIUZdpiqi2M+G0cINjyrKxDcm8NU0fOljhn082nA6BwWjuajg1q+sN6hkDyH8o
         y6g0EecchVkwPeSRZyvX2pkcJnNmIYGrgFjmKIMLPTE/RmRjCV0XOJhpw6vFSqb1Xz2N
         4dntDfXPeWN9jBibDAcagtiWgdckc83LcshhRkayzUSxXTx+OOdDu37ZKdqV5EzFKm0D
         7NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972385; x=1693577185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPmplxJVV6adqWaaprj33kljpEVv+8iOqRG/qMzwQmY=;
        b=VsLAbDIxNYgN7aMUKSHEywSlAIY/+nOXmDCNGOr5UdrQa4spwqsP1cnS/oKwBPVZeF
         jdLpxj4GwKSyt472p80UWStg4vBApGnsM8fpANINLICwrX9tOVYUP4b813bkPlUiL+To
         dZd+3qncK+5YDSvHY2yr+x5+yUIe738gH8TpCsiQGvQtp7195JajofVXhNe885g3o+f5
         DLhP4yq33wmKQ9Zhi3t4TrHIJspr/j0HIeIfLWgzqDM5PhF5c4mz+eRtD1tAVj4k3i3T
         keCbR8/pzDy23q4LkivMmjNOKYvMh6aUM0MFUVCQ+1CzTCqC+x2EdJOZCHGwMW3z4eaM
         zucQ==
X-Gm-Message-State: AOJu0YzVuVP+yKH0LuXKiRVTGibrOHhFm3icO42E+/cEhSfq4JYH9NMw
        YGQvUfJVfL7PBLqc5z31006JfQ==
X-Google-Smtp-Source: AGHT+IHLghVtlUhy40IKeq60myhHcheNDaxhWRMOKfgzl2oPFJ9rPcUgdHfhtVSDtmUgX9/F4odkxg==
X-Received: by 2002:a05:6a00:15cb:b0:688:11cc:ed98 with SMTP id o11-20020a056a0015cb00b0068811cced98mr19039922pfu.32.1692972384648;
        Fri, 25 Aug 2023 07:06:24 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:24 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 08/16] Staging: rtl8192e: Rename variable pRxTS in function TSInitialize()
Date:   Fri, 25 Aug 2023 07:08:39 -0700
Message-ID: <20230825140847.501113-9-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825140847.501113-1-tdavies@darkphysics.net>
References: <20230825140847.501113-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pRxTS in function TSInitialize() to rxts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v4:Resending whole series as v4
v3:No Changes
v2:Resend as 16 patch series - no longer throttled by email provider
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index c892fe044f29..ac97b6d627da 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -123,7 +123,7 @@ static void ResetRxTsEntry(struct rx_ts_record *ts)
 void TSInitialize(struct rtllib_device *ieee)
 {
 	struct tx_ts_record *pTxTS  = ieee->TxTsRecord;
-	struct rx_ts_record *pRxTS  = ieee->RxTsRecord;
+	struct rx_ts_record *rxts  = ieee->RxTsRecord;
 	struct rx_reorder_entry *pRxReorderEntry = ieee->RxReorderEntry;
 	u8				count = 0;
 
@@ -150,17 +150,17 @@ void TSInitialize(struct rtllib_device *ieee)
 	INIT_LIST_HEAD(&ieee->Rx_TS_Pending_List);
 	INIT_LIST_HEAD(&ieee->Rx_TS_Unused_List);
 	for (count = 0; count < TOTAL_TS_NUM; count++) {
-		pRxTS->num = count;
-		INIT_LIST_HEAD(&pRxTS->rx_pending_pkt_list);
-		timer_setup(&pRxTS->rx_admitted_ba_record.timer,
+		rxts->num = count;
+		INIT_LIST_HEAD(&rxts->rx_pending_pkt_list);
+		timer_setup(&rxts->rx_admitted_ba_record.timer,
 			    rtllib_rx_ba_inact_timeout, 0);
 
-		timer_setup(&pRxTS->rx_pkt_pending_timer, RxPktPendingTimeout, 0);
+		timer_setup(&rxts->rx_pkt_pending_timer, RxPktPendingTimeout, 0);
 
-		ResetRxTsEntry(pRxTS);
-		list_add_tail(&pRxTS->ts_common_info.List,
+		ResetRxTsEntry(rxts);
+		list_add_tail(&rxts->ts_common_info.List,
 			      &ieee->Rx_TS_Unused_List);
-		pRxTS++;
+		rxts++;
 	}
 	INIT_LIST_HEAD(&ieee->RxReorder_Unused_List);
 	for (count = 0; count < REORDER_ENTRY_NUM; count++) {
-- 
2.41.0

