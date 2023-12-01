Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB37801199
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379106AbjLARYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378848AbjLARX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:23:58 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA1E2723
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:19 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ca2a6f07b6so40373367b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451398; x=1702056198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cAIHsbo51mg8B6aRA1t9pk6vlJjR/cpfdTMz4BgsBxY=;
        b=zKxTteOXbaQc0IqiA38KA8PjIECFgLqerLwkt5XhrU6CiQrLbjZrIBNuLwdCuk7Y2y
         LBSfb7ZdBGQpST+1vYvMS/Dh+3qe+Y1Mj5pkWQy67cPRdf7W+AXHcmZZPoEyV4YBDFKp
         w29X/sJXDxK7p0Qfz3FvbpR+eFTF4TFkxY6Oriwa1Q/LktaMBVxHxeGMZ4PurMXVV/3i
         XfOpZJUiW64Ltu7ZH0+XJt+T3JGgU7n7x86qotfS2T79p8t/lLzbNEIxqrOklcP4buR/
         7OZraIEoxHcWNJdfrlknD0ykveja6+K+yp8JRwPj076IBTnurRrWHHAvbFezbLnpq2Bk
         wcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451398; x=1702056198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAIHsbo51mg8B6aRA1t9pk6vlJjR/cpfdTMz4BgsBxY=;
        b=nfkMJbU0WrhAc5DUz/9xE757ipn5NgPQHPpFqQrlGBv0rbJsw/fY3Fe/s2GquFpEF6
         p8/XGnrzxHxqFC6Gtx2TNMa2YhXH4r6JGwZ5VsYFYgh5QKxemPt4BgJ7yEw4JI4Pofns
         gBlt5oOtQePuMiUOtlsWGcXj9s95GlFrFO2vM2fX5nuAyCLIGl76dkMTewDvDS3xf4G6
         IaQ3X72tLBnImzaW4dv4xSBZwjbx4n9MhafXZ32GnP0yivi46aDRNYGXEeOvGVvKDl4A
         GEnTYRncigpSL3SmmohwmIzzo/c08zWPQcA1TTESWhR+Iqa9M9iggcy+A6mnGo1Kge8r
         XZEA==
X-Gm-Message-State: AOJu0YzxcYFzf2NLohF8Jx9lidbb5YLNzWzjhwejxMxbVkk8VWzhASNC
        JtbMK/NxCTSFda2Ch/EIWIFYL6PCx1qphQ==
X-Google-Smtp-Source: AGHT+IEOJDTYB57hjmKhd8EwwHUzy1iTghVQUhIePO1/xcuUbCKBwqLTyAkiZ5O2yf2CWxPKFJEDSlp064JQNQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a81:5213:0:b0:5d6:d039:bbf with SMTP id
 g19-20020a815213000000b005d6d0390bbfmr31961ywb.4.1701451398740; Fri, 01 Dec
 2023 09:23:18 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:49 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-21-cmllamas@google.com>
Subject: [PATCH v2 20/28] binder: remove redundant debug log
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debug information in this statement is already logged earlier in the
same function. We can get rid of this duplicate log.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 551f08e84408..c9292eee8fee 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -512,9 +512,6 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	buffer->free = 0;
 	buffer->allow_user_free = 0;
 	binder_insert_allocated_buffer_locked(alloc, buffer);
-	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-		     "%d: binder_alloc_buf size %zd got %pK\n",
-		      alloc->pid, size, buffer);
 	buffer->async_transaction = is_async;
 	buffer->oneway_spam_suspect = false;
 	if (is_async) {
-- 
2.43.0.rc2.451.g8631bc7472-goog

