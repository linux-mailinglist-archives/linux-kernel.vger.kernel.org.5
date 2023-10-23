Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCC37D2A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjJWGk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjJWGkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:40:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27F010E2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:40:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c14313eb1cso78560466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698043233; x=1698648033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RsMa50p68QhR354G2viJMWnZKa/lXMk6KHxdlxw2gzI=;
        b=LLtMeARRNEk6WlW4hvZUgad0aMot+miJFKYSdM5r8l5LBi2Yo1GlAiJ88jYIAfiwc7
         YpbTqemQp3l5+ur6MRf9HZdwgVzu7VePus1VXn/VckxKbvij+WjUF3niDDvMKMwN2X8f
         htpSsas5uX/qBLhW3MMx4MMYbnfFKdWolP/qYIbrVSBcGaC34we3LzjFX29tN0d/+GoL
         iOWrbmQKuUICeqEIBiDBrqnxB9k1SvKwtXdMF1K0+ikzSjvdmDG/I+6YwgXHOrgvbXpv
         JPi5JxHsgs4ivdcp+8LdrU3Ls4W3YN/nnoZ3HpJAW3QuBrajq4bzz+SbEyl4K4ecj1Uw
         3e+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698043233; x=1698648033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsMa50p68QhR354G2viJMWnZKa/lXMk6KHxdlxw2gzI=;
        b=urZEpi+l50/VWp+FxLXWiSvDvyEfZv/Vr+vNMa/K4TEov4Lm3EnElCFB0gThSyFSN5
         in3xCNZtwB/0zsI/k2UbXWY54ZP4eOCOBoSRFTkuugCWQ45bAtXeyXVGxulHZ+5ZwSTJ
         BmJ9MZ6pvXhLVf2GKbOT6S/7j4FyAjp28a1r+fuSP28thV8zpyG7GaNAYCc1ZzjE4QPm
         TzCBWUgW12NBLV9AeK6lsxYnNntfAqyYGgFQbBvU9ol8smYL+I/bhhKMKrDM7xZ8cQKD
         SE5Ne4AGz1cjsuFZGl7EczUu+u9j4qPVQ+8uwSwXXdIRxfRlZN4oJVwsN/Jbml/CKnuz
         pm2g==
X-Gm-Message-State: AOJu0YzTqJ69GfkOMFSEBS10CS4+0d9YJoREKzCEHwGh8yx2sOB3o1tf
        5VJh0CLoDAmTqhvCE/559X0=
X-Google-Smtp-Source: AGHT+IEsdcmaU2zY9FGIdiFU06ARn586Mzhve6d4j/27ev1POhNcYfLkiBTs79P6+rnoWvGp6FqQDg==
X-Received: by 2002:a17:906:51ce:b0:9ae:2f35:442a with SMTP id v14-20020a17090651ce00b009ae2f35442amr4689670ejk.5.1698043233066;
        Sun, 22 Oct 2023 23:40:33 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id gx13-20020a1709068a4d00b009ae6a6451fdsm6085254ejc.35.2023.10.22.23.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 23:40:32 -0700 (PDT)
Date:   Mon, 23 Oct 2023 08:40:31 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] staging: rtl8192e: Remove last three parameters of
 MakeTSEntry()
Message-ID: <ebcd7eaeba89bdc4f19053681b98fd1b8cce5aaf.1698042685.git.philipp.g.hortmann@gmail.com>
References: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove last three parameters of MakeTSEntry() as those are always Null
or 0.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index fbbe538f0632..96022c5ed60f 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -215,11 +215,8 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 }
 
 static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *addr,
-			struct qos_tsinfo *pTSPEC, union qos_tclas *pTCLAS,
-			u8 TCLAS_Num, u8 TCLAS_Proc)
+			struct qos_tsinfo *pTSPEC)
 {
-	u8	count;
-
 	if (!pTsCommonInfo)
 		return;
 
@@ -228,13 +225,6 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *addr,
 	if (pTSPEC)
 		memcpy((u8 *)(&(pTsCommonInfo->TSpec)), (u8 *)pTSPEC,
 			sizeof(struct qos_tsinfo));
-
-	for (count = 0; count < TCLAS_Num; count++)
-		memcpy((u8 *)(&(pTsCommonInfo->TClass[count])),
-		       (u8 *)pTCLAS, sizeof(union qos_tclas));
-
-	pTsCommonInfo->TClasProc = TCLAS_Proc;
-	pTsCommonInfo->TClasNum = TCLAS_Num;
 }
 
 bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
@@ -321,7 +311,7 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 		ts_info->ucTSID = UP;
 		ts_info->ucDirection = Dir;
 
-		MakeTSEntry(*ppTS, addr, &TSpec, NULL, 0, 0);
+		MakeTSEntry(*ppTS, addr, &TSpec);
 		list_add_tail(&((*ppTS)->List), pAddmitList);
 
 		return true;
-- 
2.42.0

