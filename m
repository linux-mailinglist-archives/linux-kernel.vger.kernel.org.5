Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B7B77BA2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjHNNer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjHNNe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:34:29 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D3DE7D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:34:28 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686be3cbea0so3593506b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692020068; x=1692624868;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5h96pxv2Yka7KmUWEJu66IE2CTecUjZawrP+6MraMNA=;
        b=OTfotuObIcudaAx7bUBWfq0umjGQXHRxWeuW+raRW5pJ5Rzp3SOodftij+df9OU8nH
         yTaBUr2lnQEVL68AgiAN7pjeCkPwp3bdT4NW1Y1qh8w2Cg3tYiATHuEBaL3WJSCUHpHV
         ts7vH90v8p8b1pyGJJyDnelM5NKGMj+YCA5tJrUDz2AR9Zph0lDpnUCiu1LUvj88TBlG
         U+Mk+nrX6yeVXrsQ8+Wv1CDZJZrK4Ul5HIOH/NuP6A2fnDGG0n6WzXqZR3kCHohr2yyK
         1HWQnrrD6ixjdr2Djoe+UFhUR+RJvpLF20ACEW2AD5YVBzPjePFc/C6PWe0m/raUf4XQ
         rKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692020068; x=1692624868;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5h96pxv2Yka7KmUWEJu66IE2CTecUjZawrP+6MraMNA=;
        b=UZUtWda+ILy6F1XMYws5udd/MAWtByGqGSXhIfLXbiYmzKiyLpxV2coRZ6N6rq8Z76
         5v332W7IRO3sLjOX1n9EH/sL2LqoJF40CJ/Zhm5bv9P6iuW/2AeOqNRsetIbNgN9UGnx
         y1s6wWSolUYzM3WXfrcQo90hP7JdKKlxJemwdpRJMtYZzjLJVXiS4fIbcMbadmymbn+C
         NNfvZ0vzoAPLzkg5TagF2CGCtrVj3qqh7E2a7isY6A88k5oNJR7ho2S7WjD5w+vLN1LN
         5VwXnS4k5Ratt7v2Xloj2xSBvHNnKsyXLATedh1TODmFrmDw8U0hooabok3lX1FpuX0d
         8exA==
X-Gm-Message-State: AOJu0YwYQhhcLpZrLw84h3iq8JZgmy/Ei7FzqzjOulSA2RWME54DPIET
        hlkGdjH4rdnftlqPjChrYfk=
X-Google-Smtp-Source: AGHT+IGmdEnS5dBWTUlvfmyfz1IkofxRcbSzi9/c/MmNDCAV5bsxedm6jpa32PW1iiiEhoagGV1RPw==
X-Received: by 2002:a05:6a20:394a:b0:140:c6b1:78d7 with SMTP id r10-20020a056a20394a00b00140c6b178d7mr15573025pzg.26.1692020067899;
        Mon, 14 Aug 2023 06:34:27 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([171.49.234.213])
        by smtp.gmail.com with ESMTPSA id x7-20020a63b207000000b0055386b1415dsm8576413pge.51.2023.08.14.06.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:34:27 -0700 (PDT)
Date:   Mon, 14 Aug 2023 19:04:21 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: vt6655: replace camel case by snake case
Message-ID: <ZNotXWJbJU1Gi2Gx@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace array name of camel case by snake case. Issue found
by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 v1 -> v2: 1. array name renamed from byVT3253B0_RFMD to by_vt3253b0_rfmd
           2. typo in the subject line "small case" corrected with the
              proper word "snake case"
 v2 -> v3: word "by_" dropped from array name "by_vt3253b0_rfmd"
           and became "vt3253b0_rfmd"

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/baseband.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 0e135af8316b..696d4dd03aa2 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -499,7 +499,7 @@ static const unsigned char by_vt3253_init_tab_rfmd[CB_VT3253_INIT_FOR_RFMD][2] =
 };
 
 #define CB_VT3253B0_INIT_FOR_RFMD 256
-static const unsigned char byVT3253B0_RFMD[CB_VT3253B0_INIT_FOR_RFMD][2] = {
+static const unsigned char vt3253b0_rfmd[CB_VT3253B0_INIT_FOR_RFMD][2] = {
 	{0x00, 0x31},
 	{0x01, 0x00},
 	{0x02, 0x00},
@@ -2005,8 +2005,8 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		} else {
 			for (ii = 0; ii < CB_VT3253B0_INIT_FOR_RFMD; ii++)
 				result &= bb_write_embedded(priv,
-					byVT3253B0_RFMD[ii][0],
-					byVT3253B0_RFMD[ii][1]);
+					vt3253b0_rfmd[ii][0],
+					vt3253b0_rfmd[ii][1]);
 
 			for (ii = 0; ii < CB_VT3253B0_AGC_FOR_RFMD2959; ii++)
 				result &= bb_write_embedded(priv,
-- 
2.34.1

