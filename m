Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A707B3FD0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 12:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjI3KCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 06:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjI3KCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 06:02:19 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B32DD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 03:02:17 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7a26fd82847so54163239f.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 03:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1696068136; x=1696672936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rfnTfQu22tuidv9d3nXXTKmbxSkfqoFQYQEuh21EROo=;
        b=bzxkc9jMA56dO4Ys1bqkvRoZmWcUjFIv05vdsSIniW/6YXLiVZQL2zqqld6aJ91EDz
         ngOZD/7DCaBPDval6XseQ3hEv9WwIvCJs8Ea+50w2+KWXy15/CkznhpNNEVEvA3NyM1O
         lFZ7T+ekTJ+pG14GgDsx9j9n8dVEl2j4qJptuTDJecffdS9Nn7k3EkYpHLMjWxkKkg0s
         xRD/eSMuA42m+mY1Pv2TKEgcCWnVcdsrPR/0JMUa7S2oXcpIOZyMsp3+gEha7OngjP7V
         yAiPgBS5V5K8TOL44Hg5ckpv8fxLTp8hTgZrYz4eiL3Lw2P+/9zLPfk8B935D5a0HqMa
         YOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696068136; x=1696672936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfnTfQu22tuidv9d3nXXTKmbxSkfqoFQYQEuh21EROo=;
        b=RbCyr70p6+TfQL5MQJJ72NwEwZ7XJPqOjrlU985SUylE5y8kwSDR/2O+Jo0OMOeePu
         2VcTds//t99AOLO8naUt1CkLwiU5IudqN+M28L4C79AGMtsIiZ4VfJO515sm+ve2FQDu
         K1TbTY8HojwIxMKpdFbGAAvTCaxZkK57CqsyUqJswHZZfQWacPqUPRWn96TOK2zCukKp
         CRRezarJycNrAbyM/Z0dDAu9OLEKYGs4qWJv7n3buNctqEq/yxusdjGaUE2uMCDyRPKM
         PJTu12ZN6MpYcp5ytzMg/R3zPABxK3FRpRLhO9j6WJI17BvaEfkPDYkJhKsXeuPfNkes
         zpZQ==
X-Gm-Message-State: AOJu0Yzlf+9hYRvE8Tga4ChO57Yx5iU7uCnPmaD82tB5yLq5m//5k+zP
        Bp6wP0S0hoKZZZM/8EhzbH52BQZegV9WJqS+Yuf4riV9
X-Google-Smtp-Source: AGHT+IHUqJsnhyIOBWBH6ysvmXkoACde17fdKTXXuFeBJlU81/nFod9xN829C+rn7Yr/H0SKLTVzMw==
X-Received: by 2002:a05:6e02:216d:b0:351:5716:2bdb with SMTP id s13-20020a056e02216d00b0035157162bdbmr8609691ilv.5.1696068136703;
        Sat, 30 Sep 2023 03:02:16 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id t21-20020a63b255000000b00578e9751b88sm15864937pgo.1.2023.09.30.03.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 03:02:16 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, mszeredi@redhat.com,
        bigeasy@linutronix.de, mcgrof@kernel.org, xiubli@redhat.com,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH RESEND 1/2] vfs: remove unused d_backing_dentry() function
Date:   Sat, 30 Sep 2023 10:01:55 +0000
Message-Id: <20230930100156.24014-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

d_backing_dentry() isn't used by anyone, so remove it.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Reviewed-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/dcache.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6b351e009f59..13023c7211d6 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -545,21 +545,6 @@ static inline struct inode *d_backing_inode(const struct dentry *upper)
 	return inode;
 }
 
-/**
- * d_backing_dentry - Get upper or lower dentry we should be using
- * @upper: The upper layer
- *
- * This is the helper that should be used to get the dentry of the inode that
- * will be used if this dentry were opened as a file.  It may be the upper
- * dentry or it may be a lower dentry pinned by the upper.
- *
- * Normal filesystems should not use this to access their own dentries.
- */
-static inline struct dentry *d_backing_dentry(struct dentry *upper)
-{
-	return upper;
-}
-
 /**
  * d_real - Return the real dentry
  * @dentry: the dentry to query
-- 
2.25.1

