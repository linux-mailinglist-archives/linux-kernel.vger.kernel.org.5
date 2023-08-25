Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFC8788ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbjHYOHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343523AbjHYOHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:07:01 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062312713
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68730bafa6bso1432263b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972382; x=1693577182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwwuCo8KBh0cfLqeeZn8s6/Au0pyZRuVkbX5bDVq5Js=;
        b=K/DFww+41uC/mYbcn9wLhQ8uT+9am4Jiz0TKX1Yx/LS9E+78+bxfuvpGrWOHWfRE+z
         Ft+ovDIZKXqb5psgxfIoiAkRmoRixABTpr3zqlOHZjdN7A7aR99r2a+tWVPgrD2YTFP8
         QW/fadhVrvU+71IdYTb79h4JIISzXp5ahEJ8pGEPKpSMqwQhaUQvMmmcVRuoiyGyODL7
         SOOd57ZxMzanK7ZhsG5zgLUDZymN3Oqo0OmHrmbtygUbWRIjFbp///zWOCzUs+qEBwLa
         OVAcb3iwKV8h8Y8Opxi9W91KvnnJcGS1Js6ZaaxO6M+r9rzqh1ThGpA3hMTSpChTyGRB
         gBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972382; x=1693577182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwwuCo8KBh0cfLqeeZn8s6/Au0pyZRuVkbX5bDVq5Js=;
        b=H+/hb6nnKOYp/RjLq31ZvDAmQGKF5yStaKW2godmIfDOQfYQkPZEAWBf+8tRpptdJe
         Mf3qkmzdliXL8NRq7wLGTqmh8xCfpj6hBpUP9la92LTdlVHqqNYEIFsU8qxDe5RtIfwz
         7Czp7HElKZsJf/fkpszSF67rYd4RJ3rGEgPF8Z0c/K4AfS9A2HtsF/aUHXcAX6SgdiIR
         ZB+0bzBuMNB6Cn3kBryuPvKip5x9mZnWMFTrPlFkCnL/xdzLHnlvXWYbxMU2AMqogcej
         o/b9upuYhUL2nqnyZZCV9PNcQuaf38x96QN4yqR514w6AZH+kqEqbqGO8n355bbxN3Pn
         jZZg==
X-Gm-Message-State: AOJu0YzUMoqVjyGw1SloSUf74h4XJre6hJU0QkiXpnqTwv0x75fha+qA
        TlUasxduSF7tyUzcAaR44363XA==
X-Google-Smtp-Source: AGHT+IHunQoKYS3z2B0VHjx+wPLMR7nRVQI8gs30w81Z94gKnaWmHdCfkUcSP18FAo2T0+0XX/iF2w==
X-Received: by 2002:a05:6a20:7491:b0:f0:50c4:4c43 with SMTP id p17-20020a056a20749100b000f050c44c43mr27532780pzd.5.1692972382385;
        Fri, 25 Aug 2023 07:06:22 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:22 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 06/16] Staging: rtl8192e: Rename variable pRxTs in function RxPktPendingTimeout()
Date:   Fri, 25 Aug 2023 07:08:37 -0700
Message-ID: <20230825140847.501113-7-tdavies@darkphysics.net>
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

Rename variable pRxTs in function RxPktPendingTimeout() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v4:Resending as v4
v3:Resend as 16 patch series - no longer throttled by email provider
v2:Resending in smaller patch series
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 33 +++++++++++------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 24a8b9fc0168..75bf59d267c2 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -10,10 +10,9 @@
 
 static void RxPktPendingTimeout(struct timer_list *t)
 {
-	struct rx_ts_record *pRxTs = from_timer(pRxTs, t,
-						     rx_pkt_pending_timer);
-	struct rtllib_device *ieee = container_of(pRxTs, struct rtllib_device,
-						  RxTsRecord[pRxTs->num]);
+	struct rx_ts_record *ts = from_timer(ts, t, rx_pkt_pending_timer);
+	struct rtllib_device *ieee = container_of(ts, struct rtllib_device,
+						  RxTsRecord[ts->num]);
 
 	struct rx_reorder_entry *pReorderEntry = NULL;
 
@@ -22,24 +21,24 @@ static void RxPktPendingTimeout(struct timer_list *t)
 	bool bPktInBuf = false;
 
 	spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
-	if (pRxTs->rx_timeout_indicate_seq != 0xffff) {
-		while (!list_empty(&pRxTs->rx_pending_pkt_list)) {
+	if (ts->rx_timeout_indicate_seq != 0xffff) {
+		while (!list_empty(&ts->rx_pending_pkt_list)) {
 			pReorderEntry = (struct rx_reorder_entry *)
-					list_entry(pRxTs->rx_pending_pkt_list.prev,
+					list_entry(ts->rx_pending_pkt_list.prev,
 					struct rx_reorder_entry, List);
 			if (index == 0)
-				pRxTs->rx_indicate_seq = pReorderEntry->SeqNum;
+				ts->rx_indicate_seq = pReorderEntry->SeqNum;
 
 			if (SN_LESS(pReorderEntry->SeqNum,
-				    pRxTs->rx_indicate_seq) ||
+				    ts->rx_indicate_seq) ||
 			    SN_EQUAL(pReorderEntry->SeqNum,
-				     pRxTs->rx_indicate_seq)) {
+				     ts->rx_indicate_seq)) {
 				list_del_init(&pReorderEntry->List);
 
 				if (SN_EQUAL(pReorderEntry->SeqNum,
-				    pRxTs->rx_indicate_seq))
-					pRxTs->rx_indicate_seq =
-					      (pRxTs->rx_indicate_seq + 1) % 4096;
+				    ts->rx_indicate_seq))
+					ts->rx_indicate_seq =
+					      (ts->rx_indicate_seq + 1) % 4096;
 
 				netdev_dbg(ieee->dev,
 					   "%s(): Indicate SeqNum: %d\n",
@@ -58,7 +57,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 	}
 
 	if (index > 0) {
-		pRxTs->rx_timeout_indicate_seq = 0xffff;
+		ts->rx_timeout_indicate_seq = 0xffff;
 
 		if (index > REORDER_WIN_SIZE) {
 			netdev_warn(ieee->dev,
@@ -72,9 +71,9 @@ static void RxPktPendingTimeout(struct timer_list *t)
 		bPktInBuf = false;
 	}
 
-	if (bPktInBuf && (pRxTs->rx_timeout_indicate_seq == 0xffff)) {
-		pRxTs->rx_timeout_indicate_seq = pRxTs->rx_indicate_seq;
-		mod_timer(&pRxTs->rx_pkt_pending_timer,  jiffies +
+	if (bPktInBuf && (ts->rx_timeout_indicate_seq == 0xffff)) {
+		ts->rx_timeout_indicate_seq = ts->rx_indicate_seq;
+		mod_timer(&ts->rx_pkt_pending_timer,  jiffies +
 			  msecs_to_jiffies(ieee->ht_info->rx_reorder_pending_time)
 			  );
 	}
-- 
2.41.0

