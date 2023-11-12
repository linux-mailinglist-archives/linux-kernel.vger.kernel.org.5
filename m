Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D207E8EE5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 08:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjKLHJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 02:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKLHJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 02:09:15 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B012D7C;
        Sat, 11 Nov 2023 23:09:11 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6be0277c05bso2992473b3a.0;
        Sat, 11 Nov 2023 23:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699772951; x=1700377751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8PDeTg7PKwhqfguBg7PMVy7HQDw3DouE0XLq7ilffc4=;
        b=fPoyUJfI+wz5ElFB1v7Rca9vEgrF8jI3igaBYyxGLLdNNd4Dx+FIAY5QBl52vKSpUa
         1EBflskr6F95Lc34VitrzSPqXGBELKXAcUGDCbxyy3yycQ0Dg3dFC8Y75adji6gG49X+
         ARPf9TULnVo/PN7mUia60X/0irWSBMSJ62aGtglo7aNQUyZbrFk1I6hMFzzfOe/44h6E
         mELV44copbza4r1d3C+L4wmtMPhEhK2F5J62rWcHHtLP2dtAOwnkuqh59F2YJFBeIf7E
         L+BQX3vwCfrOVFxKoGl7zrk0Pq3OYZaSrsQp4AOKCbwcKIu/TfPdARduzRi3Ss1bfOy8
         BdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699772951; x=1700377751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PDeTg7PKwhqfguBg7PMVy7HQDw3DouE0XLq7ilffc4=;
        b=F1u9jVG0qrb0f2Nc3svrliaz2uZpx8EUox2D4d0FzaI1aypU/OYDUctEFMQx2KKcEd
         vnQ7D6mjQ3gjNh3sWpHq4z4C3kyhw/CzipL6UK9ahnIV3viDppMGP6Ivgsg+EVFpFTrj
         XHihcJ3Tv7ZcEvkRbVmS1Djva6BJmdfyoT7mRDD9BhQFxEFa6jt8RxbRp//QFelvcGuQ
         mHRMpv2zltm5s8PtwKXc+olXYM3XLa6Ya7Lb+roojiMbnYzP9d0cVNkYzl/OEMZLyqfa
         PJIPy2MsYFWlLkOsf/mdaRiNBrC4pbzvklRDcwiauqLFXl+uzFjxwWm7HwvqaoXPUhVQ
         qqWQ==
X-Gm-Message-State: AOJu0Yxs2xsQ1vd55jrDtXTFeFgvs/oDIlGa0d9XlH/s4YzPDbUBSyEe
        0jhERd/nUkfjTck5TbcQdgyzJ9/W7SXJiw==
X-Google-Smtp-Source: AGHT+IFy/HMZftejlADZuQZbQZuWPs0PijJ4pwbhAPi7LHzCoDtmUxpPKq6OHFaI1otrtDzFtzD2iQ==
X-Received: by 2002:a17:90b:3a8c:b0:280:2652:d41 with SMTP id om12-20020a17090b3a8c00b0028026520d41mr2058935pjb.4.1699772951317;
        Sat, 11 Nov 2023 23:09:11 -0800 (PST)
Received: from localhost.localdomain ([112.96.230.35])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a01d600b0027d0a60b9c9sm4393560pjd.28.2023.11.11.23.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 23:09:11 -0800 (PST)
From:   "shiqiang.deng" <shiqiang.deng213@gmail.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "shiqiang.deng" <shiqiang.deng213@gmail.com>
Subject: [PATCH] test_ida: Fix compilation errors
Date:   Sun, 12 Nov 2023 15:08:40 +0800
Message-Id: <20231112070840.327190-1-shiqiang.deng213@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In lib/test_ida.c, we found that IDA_BUG_ON
uses the ida_dump() function. When __ Kernel__ is not defined,
a missing-prototypes error will occur during compilation.
Fix it now.

Signed-off-by: shiqiang.deng <shiqiang.deng213@gmail.com>
---
 include/linux/idr.h | 4 ++++
 lib/idr.c           | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index a0dce14090a9..e091efdc0cf7 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -109,6 +109,10 @@ static inline void idr_set_cursor(struct idr *idr, unsigned int val)
 #define idr_unlock_irqrestore(idr, flags) \
 				xa_unlock_irqrestore(&(idr)->idr_rt, flags)
 
+#ifndef __KERNEL__
+void ida_dump(struct ida *ida);
+#endif
+
 void idr_preload(gfp_t gfp_mask);
 
 int idr_alloc(struct idr *, void *ptr, int start, int end, gfp_t);
diff --git a/lib/idr.c b/lib/idr.c
index 13f2758c2377..66d0c6e30588 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -589,7 +589,7 @@ static void ida_dump_entry(void *entry, unsigned long index)
 	}
 }
 
-static void ida_dump(struct ida *ida)
+void ida_dump(struct ida *ida)
 {
 	struct xarray *xa = &ida->xa;
 	pr_debug("ida: %p node %p free %d\n", ida, xa->xa_head,
-- 
2.30.0

