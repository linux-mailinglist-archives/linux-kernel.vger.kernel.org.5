Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC98788AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbjHYOHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343525AbjHYOHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:07:02 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ADC271B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68c0d4cc3a4so354193b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972383; x=1693577183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aS8RW24A+VhbeLeW/x1pXyWQVP1i13AEod4T/j3ZeOQ=;
        b=by3Rq0bWej+6fWMcIoZ9f+pZvhr/ca19pJ8U31QSmWYDusMvaUd+gFxSgU7ck2x3o1
         HFopoJY6yuPUp4QZKLgJl2CRNKUSub1+rijEkWFydHwOg3rrntXe6AkU+I+aeUn/T0Qc
         NFPFraYl1f5JOTO2GCDhvdVEpJHiImrQp2tha1v5N1LsMwi6mh8K0Uxr0gCLlN/tJw+Q
         48347XKUeekQREtY5yZeGwvmwglMjGU+28D/EjMmLGAVw7L/8mEhs6tSz2yHOAVcSWnS
         A7am8jXkhgXenphx/XY9OrmjCg5OwW/A8BIEi/Z1P2PLujS/60wRgNcCVsqGaaaaki50
         ha4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972383; x=1693577183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aS8RW24A+VhbeLeW/x1pXyWQVP1i13AEod4T/j3ZeOQ=;
        b=L4uDBrQ8vjktmn5phWQwU2IvW4JTJpz8J59IGfz98Xc+ieeq3maJbkNB+WDYB53NMc
         PiyUDrgI6WolBrilnMUw5CN9XtcZlmuul9QRLAavhNjBIkWehMBrcD+dBbczRRz4q3Zi
         ePuyiF5HCtfXTySC911uXAMyKTvTQ6EBZ3a9C2z1xfMItH2Qz2IylmVb8WtO4My5TzIl
         sViulJiL4+s8N3sfLDvkyWJSCS+yIdmKjdZ4lB3yDwE/H4H4q7uAVqI4pV585L9PTFbA
         szm9FSVHnvWwFqInvCf/M3yuiseah90gHChGhGhjec9r7584B/Y89bIcl2PmRChClQjo
         LfAg==
X-Gm-Message-State: AOJu0Yxth0eaXL/actOKUKlbgFqRfJKvsmr3vmuUYyhl7AV+AMQokoVw
        v/z7t0LvutdNS0rOibLRAc82SA==
X-Google-Smtp-Source: AGHT+IHav3DWiLHxKSQsCWwprt1q/ej7MVP59i96628ieP9AHXfewnr0fGy1tCSuFCYT6P/iNq17qg==
X-Received: by 2002:a05:6a00:b4e:b0:68b:e29c:b6b with SMTP id p14-20020a056a000b4e00b0068be29c0b6bmr8414938pfo.27.1692972383421;
        Fri, 25 Aug 2023 07:06:23 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:22 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 07/16] Staging: rtl8192e: Rename variable pTS in function ResetRxTsEntry()
Date:   Fri, 25 Aug 2023 07:08:38 -0700
Message-ID: <20230825140847.501113-8-tdavies@darkphysics.net>
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

Rename variable pTS in function ResetRxTsEntry() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v4:Resending whole series as v4
v3:No changes
v2:Resend as 16 patch series - no longer throttled by email provider
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 75bf59d267c2..c892fe044f29 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -112,12 +112,12 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS)
 	rtllib_reset_ba_entry(&pTS->TxPendingBARecord);
 }
 
-static void ResetRxTsEntry(struct rx_ts_record *pTS)
+static void ResetRxTsEntry(struct rx_ts_record *ts)
 {
-	ResetTsCommonInfo(&pTS->ts_common_info);
-	pTS->rx_indicate_seq = 0xffff;
-	pTS->rx_timeout_indicate_seq = 0xffff;
-	rtllib_reset_ba_entry(&pTS->rx_admitted_ba_record);
+	ResetTsCommonInfo(&ts->ts_common_info);
+	ts->rx_indicate_seq = 0xffff;
+	ts->rx_timeout_indicate_seq = 0xffff;
+	rtllib_reset_ba_entry(&ts->rx_admitted_ba_record);
 }
 
 void TSInitialize(struct rtllib_device *ieee)
-- 
2.41.0

