Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB02280118B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378946AbjLARXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378938AbjLARWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:22:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5A610FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:22:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db4038d7cfdso990208276.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451369; x=1702056169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i8lzNNyGh9YxFrbdbNM0dDCNT8qnC2FAkz/L9borbvI=;
        b=DPujzvQX/ijuvdElTrA+p6r+aHAN3CRTOq14R2EmCz6skT8/TO2GM61SIKl1qeXp0n
         fZ+Pr+0z6gznhqPFzbLfO3bTNj3zpwqWuNnbhpot4Zx9rOtr6YPGSzWO9pzuzadOARX4
         re7TI5zrcG4CGCpmHyNLCOJMRuXQXpPFqOh6MIXUZecKgXgZ9/3NmHHvt5rBUAVEIdzN
         b6q6wKVD7UwiSDrsCt9TdgAyXDW0ml9LncrmJSrtgUTZdEPk6AREk9ex1FLh98lOxg/V
         NnwLVqVLzSDFrHWNokgl8dWnxFqNYrmBTHKU3GsEppIEvIf/6yHOa/tx/fRJkBaIsK67
         9/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451369; x=1702056169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8lzNNyGh9YxFrbdbNM0dDCNT8qnC2FAkz/L9borbvI=;
        b=YBoQeZe9oI0BUzkJsan56vfCjlNH7ynAVJTsHoeVP1DpPd3MFVxlxHvQlbYMyvvv80
         cZH/5cPSKZ75kISWMbIedGlru2qUAJMBvSayQ+/nvHr9v4fdVbFQ840Grwt3Eg0nqG8e
         BdWXF7cm0uSpU5MjZUa50DtZj19Nh8qUNPyxyHwkP8M9TjL5G2jWb40Abq5NZaYsb6Ed
         Tc9vXhEjYDd30jYgd/kzX8zeIY9V1eZMJYDwnr1YhYbMsMIpIH/hjBWpfIH2JusTR5Ck
         D5Vyn7wQKv6HTQrUryGcpOEngotI/DhnVxwviMzEroRoo1d32En/2AYOZyMuCOTrKLUx
         mduQ==
X-Gm-Message-State: AOJu0Yw5Un3LJTG9M4qqJekechpR2atvJHWM84B21KsSYeTFXNLG9GMs
        XZ0hKajGFSLGaB4hqT21tNn72SvhlkAZrQ==
X-Google-Smtp-Source: AGHT+IHjF+ng2E43F9BQKf99LVucEjoO3ykuz42nnRR7hpAJ0pBW2m6GsFcflbGRPtHvtKawEVX1SCXVdvfftg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:d6c8:0:b0:db5:452a:8e4f with SMTP id
 n191-20020a25d6c8000000b00db5452a8e4fmr171087ybg.4.1701451368959; Fri, 01 Dec
 2023 09:22:48 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:36 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-8-cmllamas@google.com>
Subject: [PATCH v2 07/28] binder: fix comment on binder_alloc_new_buf() return value
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        stable@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
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

Update the comments of binder_alloc_new_buf() to reflect that the return
value of the function is now ERR_PTR(-errno) on failure.

No functional changes in this patch.

Cc: stable@vger.kernel.org
Fixes: 57ada2fb2250 ("binder: add log information for binder transaction failures")
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index a124d2743c69..a56cbfd9ba44 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -556,7 +556,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
  * is the sum of the three given sizes (each rounded up to
  * pointer-sized boundary)
  *
- * Return:	The allocated buffer or %NULL if error
+ * Return:	The allocated buffer or %ERR_PTR(-errno) if error
  */
 struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 					   size_t data_size,
-- 
2.43.0.rc2.451.g8631bc7472-goog

