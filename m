Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5541E7B3BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjI2VME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjI2VMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:12:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B4C1A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:12:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d85fc6261ffso21294473276.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696021920; x=1696626720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FR1ZKwT/o63KmLhMDo8tUZzc0vKzUsUCbtQdapDGJGA=;
        b=bf1EOsOuDJTQHfN+mIHHCC1FmaxjQbk+q6a+dHkaFwE7mFrm300htcxJdAnrxtZNGd
         WZ7+4BLcYv+U5MeLcWFhYD5wMwHMSyTPj2qL6tfB29U1Y7UtKmKKUOfhBROhY22K1uAp
         XinQzJrrlts0sSGRZL0HhqldQ2dXE4cps+upv5jq8qzpnB/v6sfI+4m6X/xrVlBCc808
         8Ap+9jHGNfmZKtnxaNBMucN132MaX7kseHR0Gri2cvPMqTn885FgVP24lAsBSpWjq8Ea
         Ks2+jgzjvZBU+5QdLtw+q/+KP5aaTjz1oClDwgpu8gi9dIgsUYPZsToyU7t8iwC0ya9v
         5FKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696021920; x=1696626720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FR1ZKwT/o63KmLhMDo8tUZzc0vKzUsUCbtQdapDGJGA=;
        b=baoJ17LVjX1zDZKp8FXOgwmMAFhy9ZogkfFXH7IGHZm7ZK++16JMI/W7DYE3vYYk0f
         ENbIQFwzMU0NZ577SYhEeDU3xlH6pu8XJVb8g3K8XGMSfvDUYhjl8OY3yKePynvL+W+z
         qn9UWFHKxAomapuuvg7FvHzf/qpUT5PJ+SaWTaXIpI/h87lgn2f5WvS2uQSXgtCIUUSp
         PVFHUcGPqnUwIpBUrmUs7UOXwzohAv148puTgqdsjFCBP2NkxcknVRWbCsV2yYMde+0c
         68dktrecAp+ajP9jND2uekTsBXb6U3oG1F6x9u8z3qCsmh59IGNTXP9yTB0Sg7buco0l
         YN6A==
X-Gm-Message-State: AOJu0Ywln8LRN80JYTx9d1k4mSDojarbnUJtUHuctoMcpjosBnxbq3hz
        k/jarm8QWufflEEx0Q838Swg0xQfcLHe70tFe5w=
X-Google-Smtp-Source: AGHT+IHnDIypgcCWBxPESiB/yrBCpKXqORME3PWFhWMxCeyFk9cmGmraRzLwQcSrcYatS2Uvi9kN6m0eWCmXEF8Vfz0=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a25:6812:0:b0:d13:856b:c10a with SMTP
 id d18-20020a256812000000b00d13856bc10amr77200ybc.3.1696021920090; Fri, 29
 Sep 2023 14:12:00 -0700 (PDT)
Date:   Fri, 29 Sep 2023 21:11:57 +0000
In-Reply-To: <20230929211155.3910949-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230929211155.3910949-4-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=samitolvanen@google.com;
 h=from:subject; bh=ARqQmg1Q7FqF1vgF9dpD7yhcKdtd1MfRgn2maiynoVQ=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBlFz2bINQRa9JuNqXpxYBQVzDJb/c0+7N1HB+sp
 2/Sm1UUS7iJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZRc9mwAKCRBMtfaEi7xW
 7vOOC/9tO/6MqlDPfjsiexFNXOEfW7Ar2H9OEVyVIE92EgZgm/mYuBlQqBRKkWvnSCUPZ+ktWxw
 /8gD9WFejtTnKMje8tf/4wwgxbVQuClXmgi7zZQJvbJ2+SG6cp6B7JcXsMhPsJsbuh3NhTEQj/o
 pgpvv9Uyv2mK/vRlud+N82dGqhUfLNAWNPfHmZmQ/tMcij5bpFL8VvhWPFF6Akufb6mjaM9D8vG
 +cR914ZzFo93wp2YlrOemHXK7uUcqH8HHjkYtoFn7o8xhU+VQ7oy1yajipTLM7ewaa0tOrdIWqa
 08cpT5V8GX3uAGGuFOzPlMxeF7o/GIDLXMxDfovUqIRoGLzciTjGMCqRmRapZU6oY3GqWEqPSnx
 GnCaN0xzRvU31sMOUQQkusxUC/3qLR05lv7v/sDAlG5Yah5czQB5w1+2ClKsbQ3sCX6HmpcfWsx r/VvM19V0Dekn+5QLhuwnCOlt6Hs+HBdn3kG1truvPJvtRa+QxsCoiBcfxXnVWnQrVOuI=
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230929211155.3910949-5-samitolvanen@google.com>
Subject: [PATCH 1/2] mm: Change mmap_rnd_bits_max to __ro_after_init
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow mmap_rnd_bits_max to be updated on architectures that
determine virtual address space size at runtime instead of relying
on Kconfig options by changing it from const to __ro_after_init.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/mm.h | 2 +-
 mm/mmap.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf5d0b1b16f4..72a98b2afaf9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -86,7 +86,7 @@ extern int sysctl_legacy_va_layout;
 
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
 extern const int mmap_rnd_bits_min;
-extern const int mmap_rnd_bits_max;
+extern int mmap_rnd_bits_max __ro_after_init;
 extern int mmap_rnd_bits __read_mostly;
 #endif
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
diff --git a/mm/mmap.c b/mm/mmap.c
index b56a7f0c9f85..ed1b178b223a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -64,7 +64,7 @@
 
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
 const int mmap_rnd_bits_min = CONFIG_ARCH_MMAP_RND_BITS_MIN;
-const int mmap_rnd_bits_max = CONFIG_ARCH_MMAP_RND_BITS_MAX;
+int mmap_rnd_bits_max __ro_after_init = CONFIG_ARCH_MMAP_RND_BITS_MAX;
 int mmap_rnd_bits __read_mostly = CONFIG_ARCH_MMAP_RND_BITS;
 #endif
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
-- 
2.42.0.582.g8ccd20d70d-goog

