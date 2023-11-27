Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6917F98C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjK0Fgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjK0FgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:24 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCDA1B6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:29 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c2ad6a5515so1007149a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063388; x=1701668188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn+SPjvCPtSLlzTnlY099QE9bYM53ql+/mB40G+ws6Y=;
        b=KQAyij6wDBvQ5Jd4JPkBcuB0Zy5KonjrGspYmlwW0RYrEjNFbgS2q/Igd0oL5mMlFP
         ezrpApv+Uq1wU7+GF5cVa9mLV1Yc7u+4ZsdgolkcGhCcQb0sEYMlxVxYgjTFTmRPO71X
         8XL77tamJYop09ltTwip+PaKt4MjlRQPTxl8hyel0P8iJA/yRLme6lqbziDyxEqblnoG
         X2IKMTcls1EWhwf5ZAEbpySrTSSpj06vw6ZfItjul1HO1eo6qMflbW8uBMTOj1LhK5GM
         E92KLUDQ3XX16H/QKBBehuxcWT3WXh+jzyaiT6BAc6W2jM6juuteIq+mrSMGls+iWgmV
         Y71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063388; x=1701668188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wn+SPjvCPtSLlzTnlY099QE9bYM53ql+/mB40G+ws6Y=;
        b=J4kWPM70ER7i5q01XkbrARkKewayp+z35DkKFm2qnNXCrjwb7HWJWjm+F/6EIfA1dr
         jGt5j0d0ytbl+MEmVwCyl4P+mbz6VGF4lwK+Zn2zQHgirfKa5k8ZZLgtVdnRRNLR67QW
         JetGATwKpwmtDiAStd3dHYBRNzFA3j57PUbERMyxz1CjBWAu3gJlFqhKKVWHQAyWtUjH
         oU8UIyCGb71ztcuInF8QN3eMYBHiIMh3aPHsMqR4Gpm4l1jxsFv9JOOhn87/Fadhr0KL
         0Tzn2yESZqDgDRaFkPGqHsyeklhKoCghRyV01oWD+IEosVYfMBVdAU8wOpLg4vc/tCMd
         CDYA==
X-Gm-Message-State: AOJu0YztzQS/T7boLdoE0xUqRpqCwfV0ubfOmpv3EbkazdNABdqlOaQc
        ecA7kgh+lP8NDG6oq0mvNAUE8w==
X-Google-Smtp-Source: AGHT+IG0xQP2toGzHlRIhECM2hmUB67kjEwko7EwyI04YY4RSvtctedIYN/3QUnzDAUPFlegfWeQvA==
X-Received: by 2002:a05:6a20:1587:b0:185:a3d6:7bda with SMTP id h7-20020a056a20158700b00185a3d67bdamr10611887pzj.39.1701063388371;
        Sun, 26 Nov 2023 21:36:28 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:28 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 10/15] Staging: rtl8192e: Rename variable TsAddBaTimer
Date:   Sun, 26 Nov 2023 21:43:00 -0800
Message-ID: <20231127054305.148276-11-tdavies@darkphysics.net>
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

Rename variable TsAddBaTimer to ts_add_ba_timer to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c |  2 +-
 drivers/staging/rtl8192e/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 328947fc058c..2053feb51f61 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -455,7 +455,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 		ts->using_ba = false;
 		ts->add_ba_req_in_progress = false;
 		ts->add_ba_req_delayed = false;
-		del_timer_sync(&ts->TsAddBaTimer);
+		del_timer_sync(&ts->ts_add_ba_timer);
 		tx_ts_delete_ba(ieee, ts);
 	}
 	return 0;
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 4ab712634b4b..8e22c717fb27 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -31,7 +31,7 @@ struct tx_ts_record {
 	u8				add_ba_req_delayed;
 	u8				using_ba;
 	u8				disable_add_ba;
-	struct timer_list		TsAddBaTimer;
+	struct timer_list		ts_add_ba_timer;
 	u8				num;
 };
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index e06e563ae718..f96538f3e4ee 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -82,7 +82,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 
 static void TsAddBaProcess(struct timer_list *t)
 {
-	struct tx_ts_record *ts = from_timer(ts, t, TsAddBaTimer);
+	struct tx_ts_record *ts = from_timer(ts, t, ts_add_ba_timer);
 	u8 num = ts->num;
 	struct rtllib_device *ieee = container_of(ts, struct rtllib_device,
 				     TxTsRecord[num]);
@@ -130,7 +130,7 @@ void rtllib_ts_init(struct rtllib_device *ieee)
 
 	for (count = 0; count < TOTAL_TS_NUM; count++) {
 		pTxTS->num = count;
-		timer_setup(&pTxTS->TsAddBaTimer, TsAddBaProcess, 0);
+		timer_setup(&pTxTS->ts_add_ba_timer, TsAddBaProcess, 0);
 
 		timer_setup(&pTxTS->tx_pending_ba_record.timer, rtllib_ba_setup_timeout,
 			    0);
@@ -356,7 +356,7 @@ static void RemoveTsEntry(struct rtllib_device *ieee,
 	} else {
 		struct tx_ts_record *pTxTS = (struct tx_ts_record *)pTs;
 
-		del_timer_sync(&pTxTS->TsAddBaTimer);
+		del_timer_sync(&pTxTS->ts_add_ba_timer);
 	}
 }
 
@@ -438,11 +438,11 @@ void TsStartAddBaProcess(struct rtllib_device *ieee, struct tx_ts_record *pTxTS)
 
 		if (pTxTS->add_ba_req_delayed) {
 			netdev_dbg(ieee->dev, "Start ADDBA after 60 sec!!\n");
-			mod_timer(&pTxTS->TsAddBaTimer, jiffies +
+			mod_timer(&pTxTS->ts_add_ba_timer, jiffies +
 				  msecs_to_jiffies(TS_ADDBA_DELAY));
 		} else {
 			netdev_dbg(ieee->dev, "Immediately Start ADDBA\n");
-			mod_timer(&pTxTS->TsAddBaTimer, jiffies + 10);
+			mod_timer(&pTxTS->ts_add_ba_timer, jiffies + 10);
 		}
 	} else {
 		netdev_dbg(ieee->dev, "BA timer is already added\n");
-- 
2.39.2

