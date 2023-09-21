Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33A47A913B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 05:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjIUDVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 23:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjIUDVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 23:21:33 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351D4F4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:28 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1d71102a35bso287320fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1695266487; x=1695871287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9T28hoTLO5x87Ag4jPx5k+ew24pfn/Ng0oLtGe8Q28Q=;
        b=a7s+zgYanGaqQr93A9KsL4wq7Bblrpo2B2zsVwPDCHopSLFey23hRGx/YrOqmKm/kA
         J8qtQoEgANw/V8+oZe2WrenUzWUAQ8IukZL7reHlU+UeJ+T5zuLsxPgCFjXEqaVDnyB3
         3ThD4xG1Unocals08kHpjIgevddHUXYbMGfyqTxRhCECP4FnynQh3gHXnQc84bIoMjop
         LmiYQZp6wqbiXxZEhodwfLo6MbHm8fH2q9B9bPUJBrOd6NLfZBlcrD7g1rif2UgeWfLe
         gqoesk5KwekBE2BEBDq/wjh+ZtHI4MUVak/NtIjApCxgjHwNfiTiUgHUEjChi5BHfKqw
         /2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266487; x=1695871287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9T28hoTLO5x87Ag4jPx5k+ew24pfn/Ng0oLtGe8Q28Q=;
        b=V/uTIUsRbCas1NR8kQjv51TYizk7ULFDVLWjJctvr42LuNH/DZk3/liDljaxq+IwwZ
         +7akxTTAvUwhlfBcynD8ZdN0A6f6MnwrSDEk2SPPCxY2Dll6ufkGIJv3xcFY7w3PLiIY
         hZRwvOugyOMK5jaJaDeA61jX5jCvrWg1FTYvweKD2nGDXMRlbqynEuatf31v2B/ikUQg
         SYtOohetNuI8q9MNvXxUF8Gq8fPYlN+BEWwzEQ9PJz6wo4rsFmwRPXFfPIx8uBmM/WVV
         hIjJaW2O1AOaSRhLnywwQkASTrYFEH3jS1K/Ti3D17i871ve/p+zqhkOun4vpGuucaC8
         9R9w==
X-Gm-Message-State: AOJu0YxmnrVNMuJRrmAkt/e6dUahm9UuNC2/tp2I4pCMF3Doo0JRExUv
        3ZsCuNZoqKaJoWyRDWXPGC1nLg==
X-Google-Smtp-Source: AGHT+IHsYeM75yCubkThm39347Ub1pA0th/L+sZyeodDPuns08ZJlB2AazSGK2eQEmTUCju7/FMPmw==
X-Received: by 2002:a05:6870:14d2:b0:1d5:e15c:5dba with SMTP id l18-20020a05687014d200b001d5e15c5dbamr4980714oab.45.1695266487482;
        Wed, 20 Sep 2023 20:21:27 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068e49cb1692sm237324pff.1.2023.09.20.20.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:21:27 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 02/11] Staging: rtl8192e: Rename variable pAdmittedBa
Date:   Wed, 20 Sep 2023 20:25:06 -0700
Message-ID: <20230921032515.96152-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921032515.96152-1-tdavies@darkphysics.net>
References: <20230921032515.96152-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pAdmittedBa to admitted_ba to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index fbac0e598cf9..a12966cadbca 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -25,7 +25,7 @@ static void deactivate_ba_entry(struct rtllib_device *ieee, struct ba_record *pB
 
 static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *pTxTs)
 {
-	struct ba_record *pAdmittedBa = &pTxTs->TxAdmittedBARecord;
+	struct ba_record *admitted_ba = &pTxTs->TxAdmittedBARecord;
 	struct ba_record *pPendingBa = &pTxTs->TxPendingBARecord;
 	u8 bSendDELBA = false;
 
@@ -34,8 +34,8 @@ static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *pTxTs
 		bSendDELBA = true;
 	}
 
-	if (pAdmittedBa->b_valid) {
-		deactivate_ba_entry(ieee, pAdmittedBa);
+	if (admitted_ba->b_valid) {
+		deactivate_ba_entry(ieee, admitted_ba);
 		bSendDELBA = true;
 	}
 	return bSendDELBA;
-- 
2.39.2

