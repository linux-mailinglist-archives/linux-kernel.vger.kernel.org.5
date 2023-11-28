Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70507FC5B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjK1Uni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbjK1Unc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:43:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B061BC1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:43:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3330bd1e9ecso257631f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701204216; x=1701809016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QnSXqV0Ukg8Tls+sByuxYlBpsCAZ28kGNWhfBeP1Ho=;
        b=E/bJsYoiSM68/R+ndirNNxut1KwVM9hdJjkeik6cfqNPtzGn6R/DU0uv6hXo0q164y
         WjxS92LM2Vq0wJlkS805KKfu7RODWs8I4Qjqhv4tcmNieAazdwthyH3yDllD1EXpZo11
         6kwNZkplr0DgICIZAQtHbCGO2dHEjZPsWVIKO0zGkg75kP42TMhW+W/Llh4bfWbeVH+X
         fmwM78CaR7iNzoWr4ohRcaUgqcWj61uRooRf0GPPUgX6KEa76IS5PELFmNgGqVTKWA7u
         e+pfqBhQqCTNikF1rJJoh5gYZxi83rPB9NxT4EIUVZJaHuIV7zhmQMeFRwwlfL/j1wpx
         Tt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204216; x=1701809016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QnSXqV0Ukg8Tls+sByuxYlBpsCAZ28kGNWhfBeP1Ho=;
        b=Xeo+hVsqfAvDv0Sva5VIzjLpZjcGNtatJb2XJaE7G6oYPKAMAxTQHRTnt1yiRcgwcd
         BGHyIbbD4nXXYajQb+iCzBkvboFxUkpLWXeaAWbdzQK63iLTQgy+SNo3p0n0cdligsDA
         GhwI8saX3akdFBYdWPMiaTqXnOfbKKxO3ILrpBx7rHCk3ew+f1UDZRW8xJhnjFWMEPjB
         akty7DNF59E7RV8CMt/OltiHqkTlFpesTMPrCvwORtpgIVIjE3niXcpehnaNqJH8FW1k
         OGwQAGW0pz4GxvT/wp3zG4DcCcBSE+SQZLH18KvXnpKPmDDDRJ/u7LM6yGAq3zi4acpe
         ng2g==
X-Gm-Message-State: AOJu0Ywn/tKP8GwjTTqI6SSdYD4kz58/6oF0+7S7kdZuoYGxK+kcsiTv
        Htj3jw13J3FlO5KO6+2lvuA=
X-Google-Smtp-Source: AGHT+IFlZOut4UOdkDfCqhaFrV+ufRdE2pcqAgXRc8/GSdFqLcF/4Ay8OYltPMEbnxhXgVTq0bEccg==
X-Received: by 2002:a05:6000:80e:b0:332:ff23:588a with SMTP id bt14-20020a056000080e00b00332ff23588amr5726442wrb.5.1701204216304;
        Tue, 28 Nov 2023 12:43:36 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d4f0b000000b00332e67d6564sm14585699wru.67.2023.11.28.12.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:43:36 -0800 (PST)
Date:   Tue, 28 Nov 2023 21:43:33 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] staging: rtl8192e: Remove unused function
 rtllib_FlushRxTsPendingPkts()
Message-ID: <1a4471053e200e0eb8a39b0a2de6c2f4e9a36656.1701202700.git.philipp.g.hortmann@gmail.com>
References: <cover.1701202700.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701202700.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function rtllib_FlushRxTsPendingPkts().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h    |  3 +--
 drivers/staging/rtl8192e/rtllib_rx.c | 33 ----------------------------
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 44a937953db8..b9ac313e5f97 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1814,8 +1814,7 @@ bool rtllib_MgntDisconnect(struct rtllib_device *rtllib, u8 asRsn);
 /* For the function is more related to hardware setting, it's better to use the
  * ieee handler to refer to it.
  */
-void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
-				 struct rx_ts_record *ts);
+
 int rtllib_parse_info_param(struct rtllib_device *ieee,
 			    struct rtllib_info_element *info_element,
 			    u16 length,
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index d9517dbc5593..fd0357753c30 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -488,39 +488,6 @@ void rtllib_indicate_packets(struct rtllib_device *ieee,
 	}
 }
 
-void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
-				 struct rx_ts_record *ts)
-{
-	struct rx_reorder_entry *pRxReorderEntry;
-	u8 RfdCnt = 0;
-
-	del_timer_sync(&ts->rx_pkt_pending_timer);
-	while (!list_empty(&ts->rx_pending_pkt_list)) {
-		if (RfdCnt >= REORDER_WIN_SIZE) {
-			netdev_info(ieee->dev,
-				    "-------------->%s() error! RfdCnt >= REORDER_WIN_SIZE\n",
-				    __func__);
-			break;
-		}
-
-		pRxReorderEntry = (struct rx_reorder_entry *)
-				  list_entry(ts->rx_pending_pkt_list.prev,
-					     struct rx_reorder_entry, List);
-		netdev_dbg(ieee->dev, "%s(): Indicate SeqNum %d!\n", __func__,
-			   pRxReorderEntry->SeqNum);
-		list_del_init(&pRxReorderEntry->List);
-
-		ieee->RfdArray[RfdCnt] = pRxReorderEntry->prxb;
-
-		RfdCnt = RfdCnt + 1;
-		list_add_tail(&pRxReorderEntry->List,
-			      &ieee->RxReorder_Unused_List);
-	}
-	rtllib_indicate_packets(ieee, ieee->RfdArray, RfdCnt);
-
-	ts->rx_indicate_seq = 0xffff;
-}
-
 static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 				    struct rtllib_rxb *prxb,
 				    struct rx_ts_record *ts, u16 SeqNum)
-- 
2.42.0

