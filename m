Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037757A1CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjIOK77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbjIOK7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:59:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3C0CC4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:59:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8191a1d5acso1961969276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775585; x=1695380385; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dKUQWZsAVWnYh2N3/tMI/up9IoZgDH1PEAwTzCTiQv4=;
        b=VEPfBEVXTmYLoHER1CewY8TLgJJJdmC+XcNqAnmS2A+IIP2QTrpVnBGgnTjVsSFNKO
         I+9/qcdpOGpj6tG1v4xqvLtgWOgT1VG7aYNS9Mnfyc2G8saHlYRws/+BoL4+s9bjrbTo
         fgPbErMim2HYgkcTDbtAw8GiOTxtQkPF8wGj7yWskWt3M7XXYbvDjdqdBVAzXm90+7yR
         gweACBwsKptAT/hkF7Mb3asWpix2DuE9DxsI5GI0xnGX4aAAuQETWwmlptjAMiwwVuny
         EaYa5Ld9q+oCWdEiJ/Gotd7V4ml45kkXp6YjgvxTUYY+11euFyFxpY5dbhER+6FSw8df
         zUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775585; x=1695380385;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKUQWZsAVWnYh2N3/tMI/up9IoZgDH1PEAwTzCTiQv4=;
        b=GNJf9wvy0qkkweoS+6jGhuCqy+B4ttDdngtaP/raY0ekuK0RB0fYaYtfIXOhYyai0/
         UUy6NJ4eV+3W1XgjkxJFfcbV9FocjWZmmDnzEuyN3AeSN+RuQKNkyd7gfwldNIkay+Ap
         yFriap8BfwjdUFmPNcuzF2MU1G/h5xxdMZWr88AIm55al6YXRWL5cjIawc7i4ZL0wSgo
         YUVPsT3t9k9EBEUuL5FNk/5FEdThMJwEN2tUAq6FamCSLGvFubDTxqekUGrRezSUKADc
         WJ0oSTX+pEEuwnSro8T6qtAz1eEOhcrAdFyES6SBIjnr9cSeQ8FWcVjufM7TdC3RBpSy
         L/Dg==
X-Gm-Message-State: AOJu0YzS8eKVitQ8TxjgWRaTStzJrKaaVK3WD+NTyM+uN4ovzjJjNMdH
        ru0NQ6C7+RXHOYRRbGbltFZWWsp2Zm1sMkdkzQ==
X-Google-Smtp-Source: AGHT+IExUgO0kRxpLLuV9VDemRInF3a4NZjmmNsX0ecLXHU0nrTEoCf8spF7NDX59lcBkESYL/MAzaMJx3pxH3/0YQ==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a05:6902:138e:b0:d78:245a:aac4 with
 SMTP id x14-20020a056902138e00b00d78245aaac4mr27236ybu.1.1694775585627; Fri,
 15 Sep 2023 03:59:45 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:22 +0000
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
Mime-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-4-matteorizzo@google.com>
Subject: [RFC PATCH 03/14] mm/slub: move kmem_cache_order_objects to slab.h
From:   Matteo Rizzo <matteorizzo@google.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org
Cc:     jannh@google.com, matteorizzo@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

This is refactoring for SLAB_VIRTUAL. The implementation needs to know
the order of the virtual memory region allocated to each slab to know
how much physical memory to allocate when the slab is reused. We reuse
kmem_cache_order_objects for this, so we have to move it before struct
slab.

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 include/linux/slub_def.h |  9 ---------
 mm/slab.h                | 22 ++++++++++++++++++++++
 mm/slub.c                | 12 ------------
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index deb90cf4bffb..0adf5ba8241b 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -83,15 +83,6 @@ struct kmem_cache_cpu {
 #define slub_percpu_partial_read_once(c)	NULL
 #endif // CONFIG_SLUB_CPU_PARTIAL
 
-/*
- * Word size structure that can be atomically updated or read and that
- * contains both the order and the number of objects that a slab of the
- * given order would contain.
- */
-struct kmem_cache_order_objects {
-	unsigned int x;
-};
-
 /*
  * Slab cache management.
  */
diff --git a/mm/slab.h b/mm/slab.h
index 25e41dd6087e..3fe0d1e26e26 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -38,6 +38,15 @@ typedef union {
 	freelist_full_t full;
 } freelist_aba_t;
 
+/*
+ * Word size structure that can be atomically updated or read and that
+ * contains both the order and the number of objects that a slab of the
+ * given order would contain.
+ */
+struct kmem_cache_order_objects {
+	unsigned int x;
+};
+
 /* Reuses the bits in struct page */
 struct slab {
 	unsigned long __page_flags;
@@ -227,6 +236,19 @@ static inline struct slab *virt_to_slab(const void *addr)
 	return folio_slab(folio);
 }
 
+#define OO_SHIFT	16
+#define OO_MASK		((1 << OO_SHIFT) - 1)
+
+static inline unsigned int oo_order(struct kmem_cache_order_objects x)
+{
+	return x.x >> OO_SHIFT;
+}
+
+static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
+{
+	return x.x & OO_MASK;
+}
+
 static inline int slab_order(const struct slab *slab)
 {
 	return folio_order((struct folio *)slab_folio(slab));
diff --git a/mm/slub.c b/mm/slub.c
index b69916ab7aa8..df2529c03bd3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -284,8 +284,6 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
  */
 #define DEBUG_METADATA_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER)
 
-#define OO_SHIFT	16
-#define OO_MASK		((1 << OO_SHIFT) - 1)
 #define MAX_OBJS_PER_PAGE	32767 /* since slab.objects is u15 */
 
 /* Internal SLUB flags */
@@ -473,16 +471,6 @@ static inline struct kmem_cache_order_objects oo_make(unsigned int order,
 	return x;
 }
 
-static inline unsigned int oo_order(struct kmem_cache_order_objects x)
-{
-	return x.x >> OO_SHIFT;
-}
-
-static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
-{
-	return x.x & OO_MASK;
-}
-
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 static void slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
 {
-- 
2.42.0.459.ge4e396fd5e-goog

