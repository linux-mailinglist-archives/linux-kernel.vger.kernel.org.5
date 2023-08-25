Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C075C788ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbjHYOHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343508AbjHYOG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:06:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C491BC9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:31 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a6f6a66e1so798235b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972377; x=1693577177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7BuzSgv+mV1XgYmM8KKw4E3Wmr18hM3/dmMAvH4FIg=;
        b=Bj7OWyCmjpTyzAG3Z5hNbC0NmbuodJ7j+VUJ4kdJW8rQzR1A80UnFgX/ARmAjkacfY
         mr5htT9mwrw+58SleD8l++DqdjItLH25+6phCFdZLLUbqsxk3cJ4pyodziDjJV4ruPgn
         SZ3JPpbfauid7bfRHGD1Mooq0/ljcbTyb0MBXtQ3qAOuFBFZWo2f2p+gkAWyyLlABChO
         cuQEyo+9r3ByqWJTktG+AZCdezw3QvVM7eF+sDOKAwn8kJk7/3YN5akbGnzMvjDiQCoU
         AzBNbOz4FsYxOxn/Se4DLzSU35LGNa3GxbdnLaWkZc8/VJqRQEKeJNHS84LSEhRwefLA
         N5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972377; x=1693577177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7BuzSgv+mV1XgYmM8KKw4E3Wmr18hM3/dmMAvH4FIg=;
        b=gVxTB+uOv2rzZvI51s85kN/zZf0CIliP7ze8G4X8x4UJi6/tnWVgOS1nnQi3vi3TuE
         i0ocpH4vOuRII+YWVTNXW6rYEarrr3uF8lmH4JCxfSSL17t2C1tvAUIljMjjGYAlhrWz
         r7w9w3aMJVKbcRehZ0vZG3Sq/8o0u7bDhKge1PHIYreo6rQAOUTJGMQl1pTSJBtmdz2x
         yjiQ5ztWMl4KKFaF7+tKvKAh1R1x91dwEVXJwScwtNF7A3Zd4PPLeyol8ufCKlv8dZLG
         BvEcI3y0yGBco1ZgRKWPJbDn6WDdqeQe2Ig+lq5zPsL8cQJqkAXRDKg69+dDdos61YiK
         CCwg==
X-Gm-Message-State: AOJu0Yzz2Dh3LV+bILS9ttkgxHB7tT9Z1pX6UEhzeVcYuzZXE2bLI55b
        94r8gSYCLuVZczMJnny/vi7eSQ==
X-Google-Smtp-Source: AGHT+IHFjPmazLN9TKXBJHjpSBbOGbQOCMalqzkwNPATG5eN2Xdd6Zyw65eD81dmEyAH64op4N6rRw==
X-Received: by 2002:a05:6a20:948a:b0:13f:8855:d5a0 with SMTP id hs10-20020a056a20948a00b0013f8855d5a0mr13376475pzb.50.1692972377069;
        Fri, 25 Aug 2023 07:06:17 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:16 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 01/16] Staging: rtl8192e: Rename variable pRxTs in function rx_ts_delete_ba()
Date:   Fri, 25 Aug 2023 07:08:32 -0700
Message-ID: <20230825140847.501113-2-tdavies@darkphysics.net>
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

Rename variable pRxTs in function rx_ts_delete_ba() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v4:Resending as v4
v3:Resend as 16 patch series - no longer throttled by email provider, fix commit msg
v2:Resending in smaller patch series
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 0e3372868f97..da29163f3022 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -41,9 +41,9 @@ static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *pTxTs
 	return bSendDELBA;
 }
 
-static u8 rx_ts_delete_ba(struct rtllib_device *ieee, struct rx_ts_record *pRxTs)
+static u8 rx_ts_delete_ba(struct rtllib_device *ieee, struct rx_ts_record *ts)
 {
-	struct ba_record *pBa = &pRxTs->rx_admitted_ba_record;
+	struct ba_record *pBa = &ts->rx_admitted_ba_record;
 	u8			bSendDELBA = false;
 
 	if (pBa->b_valid) {
-- 
2.41.0

