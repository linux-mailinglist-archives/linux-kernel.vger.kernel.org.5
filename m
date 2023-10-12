Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DFA7C789E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442948AbjJLVbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442931AbjJLVa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:30:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB87D7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:30:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690d2441b95so1076861b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697146257; x=1697751057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd4EAPCUDqteVvPBzEw4y/R1EppHnpUiQatayG/T5e8=;
        b=CwpDT8VYn/VMYnYlMvHHyEf5SH9nwPYbdAx8IZNKw3To2L/PyLcqBht3shxTqDsvgK
         FgfJRw+DF6xPpy73WQc/1ZtgXmFyKQpi2tR4LE0WTdHB1ftsoS9Ilrq0e2hvEGD6q7Xa
         iNgENGRJB4qH9KC4aRIuhyd6ojz3E1dsNHgllRb6dewcehSGZeisYY75zpsKObJlOeGd
         OGvhLRS3Xvi4ZBMb7Um3WzUe2dJVvSS55N5lOQTGTSJ8yGnZ1cvn5kbDpiCgDZ0RwyG/
         VTDHPnFlrL7RlgxY73KZ8dv3uHKuYCLod6ZpuDvCkeao23Zxe69TJGqySOxn4mXPDmxf
         ydig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697146257; x=1697751057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yd4EAPCUDqteVvPBzEw4y/R1EppHnpUiQatayG/T5e8=;
        b=uVuqaCor0+fiH5LHR4wNLziLi2CV89jhkS0QGJ0kfhP3rchVJXHcrJDYh6AOsTOHr5
         ITn7kDeSMtE/Qi1ANET/nmZr3j/uzDFIY/BdGzkEL699d+8bvb3v0vlHJ/ZZlT8SKaTf
         yiyYTsVqpMJQvh8vZSOE6WvxG8oWnoXlXSwCyq6bwZU92C1z2okfz8wCotyY6gOOHbIT
         y8ovBgJoV7QTcKWOT0zyDk+fpZE5u6TkjuG+ROsr61azVjB76sy6C/nuQdiqbsfE0W9n
         xAAI8IxuHJTZBi4yivWZQkaDh//uUw3KdQyfCdI/qwHoh0Hw92/B3z2hpps5X8eniP/j
         iv2w==
X-Gm-Message-State: AOJu0YyHsKc3gwvMX6QaFHh9mtNj4CwGGNQaFiK8MWZoW+tDvfgse0KD
        GRb9o6xV9MlHU1hNLtbJKYPxWID8ZJs=
X-Google-Smtp-Source: AGHT+IE/t3Zi03zFqB1ZPSnk00Wz1Qg+wMCF5hhZGDZZTp6EsUAu70DF/Ewna4tGaoKfl0aN/wgR1Q==
X-Received: by 2002:a05:6a00:44c5:b0:6b1:5d1a:bd0c with SMTP id cv5-20020a056a0044c500b006b15d1abd0cmr1086103pfb.16.1697146257229;
        Thu, 12 Oct 2023 14:30:57 -0700 (PDT)
Received: from nickserv.taila7d40.ts.net (c-98-42-1-155.hsd1.ca.comcast.net. [98.42.1.155])
        by smtp.gmail.com with ESMTPSA id ka1-20020a056a00938100b006a6e0903dfesm6509024pfb.204.2023.10.12.14.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 14:30:56 -0700 (PDT)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nick Terrell <terrelln@meta.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>,
        syzbot+1f2eb3e8cd123ffce499@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] zstd: Fix array-index-out-of-bounds UBSAN warning
Date:   Thu, 12 Oct 2023 14:34:28 -0700
Message-ID: <20231012213428.1390905-1-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

Zstd used an array of length 1 to mean a flexible array for C89
compatibility. Switch to a C99 flexible array to fix the UBSAN warning.

Tested locally by booting the kernel and writing to and reading from a
BtrFS filesystem with zstd compression enabled. I was unable to reproduce
the issue before the fix, however it is a trivial change.

Reported-by: syzbot+1f2eb3e8cd123ffce499@syzkaller.appspotmail.com
Reported-by: Eric Biggers <ebiggers@kernel.org>
Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nick Terrell <terrelln@meta.com>
---
 lib/zstd/common/fse_decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/common/fse_decompress.c b/lib/zstd/common/fse_decompress.c
index a0d06095be83..8dcb8ca39767 100644
--- a/lib/zstd/common/fse_decompress.c
+++ b/lib/zstd/common/fse_decompress.c
@@ -312,7 +312,7 @@ size_t FSE_decompress_wksp(void* dst, size_t dstCapacity, const void* cSrc, size
 
 typedef struct {
     short ncount[FSE_MAX_SYMBOL_VALUE + 1];
-    FSE_DTable dtable[1]; /* Dynamically sized */
+    FSE_DTable dtable[]; /* Dynamically sized */
 } FSE_DecompressWksp;
 
 
-- 
2.42.0

