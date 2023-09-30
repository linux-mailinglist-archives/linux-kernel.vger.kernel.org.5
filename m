Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B232E7B4121
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjI3OuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjI3OuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:50:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FDDB7;
        Sat, 30 Sep 2023 07:50:15 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso12016054b3a.2;
        Sat, 30 Sep 2023 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696085415; x=1696690215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHMHOCbixbP361tjm3x9vQKWGYP3T+423b+GFOCAXdk=;
        b=mIlmEJm1YDOHynGLzxrHF7QvI0cFKypZsgREhL/eabWa8S5yJoQXJKolg0xUcDs7Vj
         4TD0l38MjiYSnfIy3Z7Ghl/gdPuT7xcMiXMUfW51OPIbOplxxxjeSmiXyvhlt26G/ChU
         O3lH7Ffpg+SlcAmy3GgYyq04pI2CPQbTHdh1qCUm1k04H7PQhTmKwwhthB9CK569oz2S
         AihLVxQmSfa5CGkJEVFGyQM2yHRvQOOuJQU5IGsvk4spulkR5CBiGSE0RPIt3b/kc2oI
         bgOr1wzOjVu/L6H71xKHtcV/vR6Xe6W1j41V46aSvqIGDLFL/9h78EgVZZvqGtWy4MOo
         SZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696085415; x=1696690215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHMHOCbixbP361tjm3x9vQKWGYP3T+423b+GFOCAXdk=;
        b=Qfyokfn4yWY9tMa3ZKk7be6A31Key4IYlF7RzTktgk/Qcy9mz0yv+44TqOMW2Kazl2
         Gfr3w2y3NeSF1uczfBOV6lrx6XFwM1Vy3Q+WBxVNPuPXEKLTwgcUBZ6fXmdd4howd/OS
         DxoyaQGGSYQuh6q+4HoZ/SxLcRyg6HV10y2Uai171O+tkoVq2HO/o5KufrGjuAiFdAiX
         zUI8/aC5xtfafAAy8GC4FRis7aE2e/JqpbkDpWVpPkJL4tvra3CNEmFNEsuW96+Dytz/
         jmjaaVxinlR8da9rT0mHIG2GQC/DfaeqCA9uAB9IpUOaUW9IqOXKgEmlC55MiUWmtfpR
         fcBQ==
X-Gm-Message-State: AOJu0Yycv2s8fo6M1salTq7enU9OuUqgSckRtemYEnzBrjXA9B3cHu+J
        17gYERLDqAxfavvodo1vuBHr4ka7QbAvcQ==
X-Google-Smtp-Source: AGHT+IHQprCbCbpwm1s8WJoftwJB8bwd4PGmOOzaxnXGk/laL4wySuxlz61Nl6Hy56Wl/Hj6WLae+Q==
X-Received: by 2002:a05:6a00:190b:b0:690:41a1:9b6c with SMTP id y11-20020a056a00190b00b0069041a19b6cmr6919885pfi.10.1696085415004;
        Sat, 30 Sep 2023 07:50:15 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id x9-20020a056a00270900b00690fdeb5c07sm17201762pfv.13.2023.09.30.07.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 07:50:14 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH] rust: error: fix the description for `ECHILD`
Date:   Sat, 30 Sep 2023 11:49:58 -0300
Message-Id: <20230930144958.46051-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Wedson Almeida Filho <walmeida@microsoft.com>

A mistake was made and the description of `ECHILD` is wrong (it reuses
the description of `ENOEXEC`). This fixes it to reflect what's in
`errno-base.h`.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/error.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 05fcab6abfe6..bab2c043fc42 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -37,7 +37,7 @@ macro_rules! declare_err {
     declare_err!(E2BIG, "Argument list too long.");
     declare_err!(ENOEXEC, "Exec format error.");
     declare_err!(EBADF, "Bad file number.");
-    declare_err!(ECHILD, "Exec format error.");
+    declare_err!(ECHILD, "No child process.");
     declare_err!(EAGAIN, "Try again.");
     declare_err!(ENOMEM, "Out of memory.");
     declare_err!(EACCES, "Permission denied.");

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.34.1

