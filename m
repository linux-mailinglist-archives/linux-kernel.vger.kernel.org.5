Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2496D7A1D04
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjIOLBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjIOLBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:01:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5FF2D54
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-594e5e2e608so25545777b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775614; x=1695380414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/kdjtZjOl0pG1Y8OuH7SH0XgMhsH4ZDWKrdEtcTG86U=;
        b=3ndptF9yE0L023Xk0WgZY1aIs2w8tVLrrV0WwCIQAni/dKRZByoLnrT4Lu1rqRxp4f
         3aE2B70ZTkvS/LjcxEI6kN/ibdqHpR4C0ru2VUsEkAnV8zATtSXLvuNoLPr0cfTii1DQ
         crghhB/Xk/og2ZfPvknCkfOpKwNz8M04i8MHtgefFYZKRTjvZdFXYHTrs6xR8KkJmPWg
         i95HteKNtPwzhxRjoPS0s85gf4CWtjHzloF9Irb4BKNgiq+MdlPNvUkgApzudF4r/Bo7
         jtEl/yrmZCLqEUeC8CNGp9VFPm3KBg9kur28tfqVBmd6tzAQFCS0tJvvB0BVA4li4xl2
         HHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775614; x=1695380414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kdjtZjOl0pG1Y8OuH7SH0XgMhsH4ZDWKrdEtcTG86U=;
        b=IaSmLEvjQDCgfaSBiZQyBI3A043AaAaYKAQKDgBgLdooWAEoOZtmDIYLcP1WZmV/ko
         Rbutw2J06hc5asmTMWagz1Jdz6Y1ZwSd9twAEvcidxJ5q/SUvuE8ue02+ImzHgPleHov
         9xIYC66YGL83ULsTKJEwSD7BRl8OF9OLjxFcJsn20Xah3AoDdMuOCPAJ1kS49X/EYGtt
         afws1GxvePIG3ABP5SFzv1Tnh34ljlIl9aa6JXl58UvM2qqYb9eksLTWAnfIWPT2JeWy
         uzki95pynXB8ruhuYzVHpKWnUyMoeQKmMJIOYCa0UfsrDIjYsL+TW+hpPPY9Wl8E0qGq
         YLHg==
X-Gm-Message-State: AOJu0Yw/0l8tvyMYZ6UXzLmkk05+81AW2TqyDB31WT8eYZMbrR2QPiMd
        W3EvoKBG5tMDmrphyJjvzzT1n3e05M8GR4YeXQ==
X-Google-Smtp-Source: AGHT+IH3LIX5OX5bZq/S9d+gFcO+JqbLY4Sep9fDWrOQHGQEzWkq5gu7AdHBA2+dfu8HpxR++S9aMZH+wQ9NGJ4UEA==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a81:b643:0:b0:59b:f863:6f60 with SMTP
 id h3-20020a81b643000000b0059bf8636f60mr37260ywk.4.1694775614195; Fri, 15 Sep
 2023 04:00:14 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:33 +0000
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
Mime-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-15-matteorizzo@google.com>
Subject: [RFC PATCH 14/14] security: add documentation for SLAB_VIRTUAL
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

Document what SLAB_VIRTUAL is trying to do, how it's implemented, and
why.

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 Documentation/security/self-protection.rst | 102 +++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/Documentation/security/self-protection.rst b/Documentation/security/self-protection.rst
index 910668e665cb..5a5e99e3f244 100644
--- a/Documentation/security/self-protection.rst
+++ b/Documentation/security/self-protection.rst
@@ -314,3 +314,105 @@ To help kill classes of bugs that result in kernel addresses being
 written to userspace, the destination of writes needs to be tracked. If
 the buffer is destined for userspace (e.g. seq_file backed ``/proc`` files),
 it should automatically censor sensitive values.
+
+
+Memory Allocator Mitigations
+============================
+
+Protection against cross-cache attacks (SLAB_VIRTUAL)
+-----------------------------------------------------
+
+SLAB_VIRTUAL is a mitigation that deterministically prevents cross-cache
+attacks.
+
+Linux Kernel use-after-free vulnerabilities are commonly exploited by turning
+them into an object type confusion (having two active pointers of different
+types to the same memory location) using one of the following techniques:
+
+1. Direct object reuse: make the kernel give the victim object back to the slab
+   allocator, then allocate the object again from the same slab cache as a
+   different type. This is only possible if the victim object resides in a slab
+   cache which can contain objects of different types - for example one of the
+   kmalloc caches.
+2. "Cross-cache attack": make the kernel give the victim object back to the slab
+   allocator, then make the slab allocator give the page containing the object
+   back to the page allocator, then either allocate the page directly as some
+   other type of page or make the slab allocator allocate it again for a
+   different slab cache and allocate an object from there.
+
+In either case, the important part is that the same virtual address is reused
+for two objects of different types.
+
+The first case can be addressed by separating objects of different types
+into different slab caches. If a slab cache only contains objects of the
+same type then directly turning an use-after-free into a type confusion is
+impossible as long as the slab page that contains the victim object remains
+assigned to that slab cache. This type of mitigation is easily bypassable
+by cross-cache attacks: if the attacker can make the slab allocator return
+the page containing the victim object to the page allocator and then make
+it use the same page for a different slab cache, type confusion becomes
+possible again. Addressing the first case is therefore only worthwhile if
+cross-cache attacks are also addressed. AUTOSLAB uses a combination of
+probabilistic mitigations for this. SLAB_VIRTUAL addresses the second case
+deterministically by changing the way the slab allocator allocates memory.
+
+Preventing slab virtual address reuse
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+In theory there is an easy fix against cross-cache attacks: modify the slab
+allocator so that it never gives memory back to the page allocator. In practice
+this would be problematic because physical memory remains permanently assigned
+to a slab cache even if it doesn't contain any active objects. A viable
+cross-cache mitigation must allow the system to reclaim unused physical memory.
+In the current design of the slab allocator there is no way
+to keep a region of virtual memory permanently assigned to a slab cache without
+also permanently reserving physical memory. That is because the virtual
+addresses that the slab allocator uses come from the linear map region, where
+there is a 1:1 correspondence between virtual and physical addresses.
+
+SLAB_VIRTUAL's solution is to create a dedicated virtual memory region that is
+only used for slab memory, and to enforce that once a range of virtual addresses
+is used for a slab cache, it is never reused for any other caches. Using a
+dedicated region of virtual memory lets us reserve ranges of virtual addresses
+to prevent cross-cache attacks and at the same time release physical memory back
+to the system when it's no longer needed. This is what Chromium's PartitionAlloc
+does in userspace
+(https://chromium.googlesource.com/chromium/src/+/354da2514b31df2aa14291199a567e10a7671621/base/allocator/partition_allocator/PartitionAlloc.md).
+
+Implementation
+~~~~~~~~~~~~~~
+
+SLAB_VIRTUAL reserves a region of virtual memory for the slab allocator. All
+pointers returned by the slab allocator point to this region. The region is
+statically partitioned in two sub-regions: the metadata region and the data
+region. The data region is where the actual objects are allocated from. The
+metadata region is an array of struct slab objects, one for each PAGE_SIZE bytes
+in the data region.
+Without SLAB_VIRTUAL, struct slab is overlaid on top of the struct page/struct
+folio that corresponds to the physical memory page backing the slab instead of
+using a dedicated memory region. This doesn't work for SLAB_VIRTUAL, which needs
+to store metadata for slabs even when no physical memory is allocated to them.
+Having an array of struct slab lets us implement virt_to_slab efficiently purely
+with arithmetic. In order to support high-order slabs, the struct slabs
+corresponding to tail pages contain a pointer to the head slab, which
+corresponds to the slab's head page.
+
+TLB flushing
+~~~~~~~~~~~~
+
+Before it can release a page of physical memory back to the page allocator, the
+slab allocator must flush the TLB entries for that page on all CPUs. This is not
+only necessary for the mitigation to work reliably but it's also required for
+correctness. Without a TLB flush some CPUs might continue using the old mapping
+if the virtual address range is reused for a new slab and cause memory
+corruption even in the absence of other bugs. The slab allocator can release
+pages in contexts where TLB flushes can't be performed (e.g. in hardware
+interrupt handlers). Pages to free are not freed directly, and instead they are
+put on a queue and freed from a workqueue context which also flushes the TLB.
+
+Performance
+~~~~~~~~~~~
+
+SLAB_VIRTUAL's performance impact depends on the workload. On kernel compilation
+(kernbench) the slowdown is about 1-2% depending on the machine type and is
+slightly worse on machines with more cores.
-- 
2.42.0.459.ge4e396fd5e-goog

