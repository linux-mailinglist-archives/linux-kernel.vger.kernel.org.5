Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70D07DD3CF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbjJaRDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbjJaRDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:03:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2834E3856
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:52:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32f78dcf036so10839f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698771140; x=1699375940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=B10QPUDObmarU8vPj+67Qb/5mnoa2NVk9HZWVYIAw6s=;
        b=TLq4FkOnRabqrqy22BVXxnCLhat0l43Szg9LFBsqLLHGAgS1hRyXmZySuUnF+Ox6y7
         bwVdMKuHw/61Z/mcP1u0441Dl9wFHZHiv/svuIAR3TCw1WWGPDJqK6wbzqw98H/gBBLJ
         tZ+SE5u2E1nxAEPdDQFO3T48c0rLDwUCPRVewpeA1V5yyTRloZmJco7njJ1Y/phVrqR/
         XikKefHRhgy7A02r5mMyhdbhsY/jm1viWKa5UPlTDL5kGZsjJeJ0AEDP7bfMiVknj+t2
         V7Lm2bGxsl6rWlC3rBjQ/EmVY5kWCSQqRih0eWdJa+ideLcCBTUVBAAHZlVS9xliW5MP
         DPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698771140; x=1699375940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B10QPUDObmarU8vPj+67Qb/5mnoa2NVk9HZWVYIAw6s=;
        b=ox4LsNPwqm1Jcta5vIhrG/K78H7XxVNvU15O0XJvMIpPcTwnRK9WnIwsae51J+VVHQ
         cwplyOOCwfc1jqouQW47Q1Fgvz0/9R17pxrHV+VIEgkF733MuIkQb3Ke+85CDpCLnC1I
         YImlEA1MUk7lh9qreqj0Pda9jy2c05a0Mis/7BJYuvjnix6uytz6QEZIRli4NHlFHKKU
         c/RNJq18RaRMwIJpfEu4/1tpLtuWdj7L1pEr3Svu/wVjWMwy22M88gPicfRWAUycSC+B
         bXEzmuu9gaYso7fVisNp2hgqyZHZ+3y3cJNnu+MSVHjnIjzQulq+MRx6U+zYWeLs0X3P
         6yjA==
X-Gm-Message-State: AOJu0YwwATL7M7e01dkpijI09m1WAPXFrLyvNvsFnnLXloLz/G/fkKhu
        LbZC4VNYPEwCmZ0wWSl6crRswAdtuXiEKQ==
X-Google-Smtp-Source: AGHT+IE4GEYOmImMQV3GfQunimmfcE5jq+MDaw6kOWE9TmsEmnxUvCsmV+NSwX9CWNuT2Ca4G+mlUg==
X-Received: by 2002:a05:6000:2c4:b0:32d:cb21:4e99 with SMTP id o4-20020a05600002c400b0032dcb214e99mr164071wry.13.1698771140138;
        Tue, 31 Oct 2023 09:52:20 -0700 (PDT)
Received: from archlinux.. ([88.127.172.169])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d4b0c000000b003143c9beeaesm1918432wrq.44.2023.10.31.09.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 09:52:19 -0700 (PDT)
Sender: Dima <dimadrumspro@gmail.com>
From:   dimadrumspro@yahoo.com
X-Google-Original-From: dimadrumspro@@gmail.com
To:     dimadrumspro@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: comedi: drivers: ssv_dnp: fixed a brace coding style issue
Date:   Tue, 31 Oct 2023 17:25:54 +0100
Message-ID: <20231031162554.4189-1-dimadrumspro@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_YAHOO_RCVD,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dimaaac <dimadrumspro@gmail.com>

Fixed a coding style issue, as well as a typo (lowercased word)
and removed unnecessary filename comment.

Signed-off-by: dimaaac <dimadrumspro@gmail.com>
---
 drivers/comedi/drivers/ssv_dnp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/comedi/drivers/ssv_dnp.c b/drivers/comedi/drivers/ssv_dnp.c
index 813bd0853b0b..d0747767810b 100644
--- a/drivers/comedi/drivers/ssv_dnp.c
+++ b/drivers/comedi/drivers/ssv_dnp.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * ssv_dnp.c
- * generic comedi driver for SSV Embedded Systems' DIL/Net-PCs
+ * Generic comedi driver for SSV Embedded Systems' DIL/Net-PCs
  * Copyright (C) 2001 Robert Schwebel <robert@schwebel.de>
  *
  * COMEDI - Linux Control and Measurement Device Interface
@@ -91,13 +90,13 @@ static int dnp_dio_insn_config(struct comedi_device *dev,
 	if (ret)
 		return ret;
 
-	if (chan < 8) {			/* Port A */
+	if (chan < 8)			/* Port A */
 		mask = 1 << chan;
 		outb(PAMR, CSCIR);
-	} else if (chan < 16) {		/* Port B */
+	else if (chan < 16)		/* Port B */
 		mask = 1 << (chan - 8);
 		outb(PBMR, CSCIR);
-	} else {			/* Port C */
+	else				/* Port C */
 		/*
 		 * We have to pay attention with port C.
 		 * This is the meaning of PCMR:
@@ -109,7 +108,6 @@ static int dnp_dio_insn_config(struct comedi_device *dev,
 		 */
 		mask = 1 << ((chan - 16) * 2);
 		outb(PCMR, CSCIR);
-	}
 
 	val = inb(CSCDR);
 	if (data[0] == COMEDI_OUTPUT)
-- 
2.42.0

