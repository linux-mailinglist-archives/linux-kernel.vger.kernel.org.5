Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8C3788AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343559AbjHYOH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343521AbjHYOHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:07:01 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9962710
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a529e1974so778113b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972381; x=1693577181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A45owKeZCcGxrJDvohEXl0lV0iLAnAAGipTcWp8WS68=;
        b=N2mNqQ7ynHFjULfa/isy/qSyIb6fQDkzLllxIB49iC+9AIUhWlyUjj3KG9aGfkbwdS
         v+rIywKc0XbU96DhGDnQ6A2hoLfXfFG9ngE74mDTy+7rGZf6OSoUX07oiFlrbC/XbzhA
         79Y8b0JaMUUS1i9/i7bmP4tRk51d2rtWgj5CxJmFujNt8K5dvY+VxbqWd1IXOP07N2d8
         C0y0oxwhnE6IJKbSOqQWjyFYiQKsrNZvSl8WANuuiAe514h6R4qZeieas7m1I+UJY82l
         vHX5kgiACDtLW0F8qbzLfZPbBRyFrTPBGSwnQ1Tno0BLcRLzfGG02Tp/aHXMaDFYO/kk
         rbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972381; x=1693577181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A45owKeZCcGxrJDvohEXl0lV0iLAnAAGipTcWp8WS68=;
        b=X3mIcghidoiN6tbvLjh+09BsDkxb9T0glIRIWSdlV7+0aftF/ixT4gk+FgxeSeT8kT
         zlR58yMfFfJnnjNKG+CH3A8FNXFMiaaqcukrKCZ/UkJT+RurhqBXBbc0g0Eb/YQaWTSe
         gRFnYE8ALo8g08dh+Ue7gOFYk7O3PWqVwZ33hzStzutX6+dzuL+eFO9uRdMkQwiueYve
         nw/Og/UeFbom6PW3NUzY+U8QwGWNzPcyeEQVgHhOPjiZbceJpe45qNPm+2HsL4dMSq5e
         1ZZmQTINjErMBXTehqd5clFoCxTJEoqird/tXRyb+4Ovrr/tY/eiMYn3UvOlniiYsODu
         PoWQ==
X-Gm-Message-State: AOJu0YyOI2G95rf0iTd8ElEwijkUcmU3Bcr6LYNUUQ09IZ/ActEzKmpX
        hRwfxQbrC3UKAPI+hZ5UNHlmEw==
X-Google-Smtp-Source: AGHT+IGpKjeOkUaxyU5TzsNzWONG0U609xLRucm36VdW3zMgzQ4JgsW1jEvmWr/sSGled5aJ04isfw==
X-Received: by 2002:a05:6a20:2446:b0:140:94b8:3b70 with SMTP id t6-20020a056a20244600b0014094b83b70mr18867226pzc.17.1692972381452;
        Fri, 25 Aug 2023 07:06:21 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:21 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 05/16] Staging: rtl8192e: Rename variable pRxTs in function rtllib_rx_ba_inact_timeout()
Date:   Fri, 25 Aug 2023 07:08:36 -0700
Message-ID: <20230825140847.501113-6-tdavies@darkphysics.net>
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

Rename varialbe pRxTs in function rtllib_rx_ba_inact_timeout() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v4:Resending as v4
v3:Resend as 16 patch series - no longer throttled by email provider
v2:Resending in smaller patch series
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 2aa624bcbfd1..bc6f9e8c5dd8 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -532,13 +532,13 @@ void rtllib_tx_ba_inact_timeout(struct timer_list *t)
 
 void rtllib_rx_ba_inact_timeout(struct timer_list *t)
 {
-	struct rx_ts_record *pRxTs = from_timer(pRxTs, t,
+	struct rx_ts_record *ts = from_timer(ts, t,
 					      rx_admitted_ba_record.timer);
-	struct rtllib_device *ieee = container_of(pRxTs, struct rtllib_device,
-				     RxTsRecord[pRxTs->num]);
+	struct rtllib_device *ieee = container_of(ts, struct rtllib_device,
+				     RxTsRecord[ts->num]);
 
-	rx_ts_delete_ba(ieee, pRxTs);
-	rtllib_send_DELBA(ieee, pRxTs->ts_common_info.Addr,
-			  &pRxTs->rx_admitted_ba_record, RX_DIR,
+	rx_ts_delete_ba(ieee, ts);
+	rtllib_send_DELBA(ieee, ts->ts_common_info.Addr,
+			  &ts->rx_admitted_ba_record, RX_DIR,
 			  DELBA_REASON_TIMEOUT);
 }
-- 
2.41.0

