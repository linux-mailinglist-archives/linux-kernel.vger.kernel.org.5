Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD17375E1AE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjGWMHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGWMH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:07:28 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CE11BF;
        Sun, 23 Jul 2023 05:07:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so31866665e9.2;
        Sun, 23 Jul 2023 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690114046; x=1690718846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jl9V448+HS+kG3h9U9ABN+uxksHk7/M2t2kRQ8frCBs=;
        b=UIcw8SNVSuvAizgs+6pAOn52gjXAnE/Wo4f9U3j9CIBWYFii4zlC7K53bRhNhvzq1N
         u2wY9sjM+3S9L27Q1E1tSoY1VEG+t3jLiq47prFi7X3j2SnDGzuV51Qmm/DlRA8dPew6
         s4Icsi6AEwfW/nCNWOI5CGlecEQ3AQXJ+FCl5ldV/6cWzHX4Xy5pQ08Xuxr7YwFpcBXi
         zpLQoB1CbYy5XeEb/6IMx23rqxvzvVmSkyzq7x23gA1jITU7Hjp/Urox+v01q2SiVwWv
         kp+xFVdT5u49BBbe0DkWTFxDZXcgxqzAIObU+ly4CLVtsBVCUcHzRsEFyKPnGc+YqZ94
         PNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690114046; x=1690718846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl9V448+HS+kG3h9U9ABN+uxksHk7/M2t2kRQ8frCBs=;
        b=E9e7LzOEdcc+rgyG1i2K5u+AkjoYE84gOGhcqGipHqpS5fnB7rs8+80FQpgQJq07iv
         BADx5IqukoZomRIQq20w9A/QJS7aovWHEjy0I0Mhy/9JYcBLd3tBE3JGVF+e6IzCLxLH
         LZ9O5ynZQHnLMpj53HZus9u5kA/1fnAKhTlIrq/XBFhhJ6wsZf69zBOfbwxdj/9RbdBj
         SGulgUgpMOaKuiB2Pi6upNyRtC4wrqua4AOzJrWfrZb30zr22eEMBjAO0lC9wlyhMknC
         LyWq+6F/JXeaFj4oJsnLlsoPURjM624xtjicZ+Cy7QYUJOm7HQ7R/BjBcXSmAwvHsXhV
         brdw==
X-Gm-Message-State: ABy/qLaZoeET2F5ukZXN8S0UYNbQsUzXkFJAHnJgHqIowXcUmQxvdWox
        DMDsr0L/GD41W3VzRo2m2p4jij2GXKY=
X-Google-Smtp-Source: APBJJlFJro/px5/72ampeOL2FhDNqs+UnxZgEBaBGjzVp/kUGIjSa1//DlV/GjH3QxXt8C8wZa15wA==
X-Received: by 2002:a5d:4dd2:0:b0:314:3ca0:c8c2 with SMTP id f18-20020a5d4dd2000000b003143ca0c8c2mr6078555wru.11.1690114045420;
        Sun, 23 Jul 2023 05:07:25 -0700 (PDT)
Received: from localhost.localdomain (host-87-20-104-222.retail.telecomitalia.it. [87.20.104.222])
        by smtp.gmail.com with ESMTPSA id v4-20020adff684000000b0031431fb40fasm9511466wrp.89.2023.07.23.05.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 05:07:24 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [RFC PATCH v2] Documentation/page_tables: Add info about MMU/TLB and Page Faults
Date:   Sun, 23 Jul 2023 14:07:09 +0200
Message-ID: <20230723120721.7139-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend page_tables.rst by adding a section about the role of MMU and TLB
in translating between virtual addresses and physical page frames.
Furthermore explain the concept behind Page Faults and how the Linux
kernel handles TLB misses. Finally briefly explain how and why to disable
the page faults handler.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: Add further information about lower level functions in the page
fault handler and add information about how and why to disable / enable
the page fault handler (provided a link to a Ira's patch that make use
of pagefault_disable() to prevent deadlocks).

This is an RFC PATCH because of two reasons:

1) I've heard that there is consensus about the need to revise and
extend the MM documentation, but I'm not sure about whether or not
developers need these kind of introductory information.

2) While preparing this little patch I decided to take a quicj look at
the code and found out it currently is not how I thought I remembered
it. I'm especially speaking about the x86 case. I'm not sure that I've
been able to properly understand what I described as a difference in
workflow compared to most of the other architecture.

Therefore, for the two reasons explained above, I'd like to hear from
people actively involved in MM. If this is not what you want, feel free
to throw it away. Otherwise I'd be happy to write more on this and other
MM topics. I'm looking forward for comments on this small work.

 Documentation/mm/page_tables.rst | 87 ++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/Documentation/mm/page_tables.rst b/Documentation/mm/page_tables.rst
index 7840c1891751..2be56f50c88f 100644
--- a/Documentation/mm/page_tables.rst
+++ b/Documentation/mm/page_tables.rst
@@ -152,3 +152,90 @@ Page table handling code that wishes to be architecture-neutral, such as the
 virtual memory manager, will need to be written so that it traverses all of the
 currently five levels. This style should also be preferred for
 architecture-specific code, so as to be robust to future changes.
+
+
+MMU, TLB, and Page Faults
+=========================
+
+The Memory Management Unit (MMU) is a hardware component that handles virtual to
+physical address translations. It uses a relatively small cache in hardware
+called the Translation Lookaside Buffer (TLB) to speed up these translations.
+When a process wants to access a memory location, the CPU provides a virtual
+address to the MMU, which then uses the TLB to quickly find the corresponding
+physical address.
+
+However, sometimes the MMU can't find a valid translation in the TLB. This
+could be because the process is trying to access a range of memory that it's not
+allowed to, or because the memory hasn't been loaded into RAM yet. When this
+happens, the MMU triggers a page fault, which is a type of interrupt that
+signals the CPU to pause the current process and run a special function to
+handle the fault.
+
+One cause of page faults is due to bugs (or maliciously crafted addresses) and
+happens when a process tries to access a range of memory that it doesn't have
+permission to. This could be because the memory is reserved for the kernel or
+for another process, or because the process is trying to write to a read-only
+section of memory. When this happens, the kernel sends a Segmentation Fault
+(SIGSEGV) signal to the process, which usually causes the process to terminate.
+
+An expected and more common cause of page faults is "lazy allocation". This is
+a technique used by the Kernel to improve memory efficiency and reduce
+footprint. Instead of allocating physical memory to a process as soon as it's
+requested, the kernel waits until the process actually tries to use the memory.
+This can save a significant amount of memory in cases where a process requests
+a large block but only uses a small portion of it.
+
+A related technique is "Copy-on-Write" (COW), where the Kernel allows multiple
+processes to share the same physical memory as long as they're only reading
+from it. If a process tries to write to the shared memory, the kernel triggers
+a page fault and allocates a separate copy of the memory for the process. This
+allows the kernel to save memory and avoid unnecessary data copying and, by
+doing so, it reduces latency.
+
+Now, let's see how the Linux kernel handles these page faults:
+
+1. For most architectures, `do_page_fault()` is the primary interrupt handler
+   for page faults. It delegates the actual handling of the page fault to
+   `handle_mm_fault()`. This function checks the cause of the page fault and
+   takes the appropriate action, such as loading the required page into
+   memory, granting the process the necessary permissions, or sending a
+   SIGSEGV signal to the process.
+
+2. In the specific case of the x86 architecture, the interrupt handler is
+   defined by the `DEFINE_IDTENTRY_RAW_ERRORCODE()` macro, which calls
+   `handle_page_fault()`. This function then calls either
+   `do_user_addr_fault()` or `do_kern_addr_fault()`, depending on whether
+   the fault occurred in user space or kernel space. Both of these functions
+   eventually lead to `handle_mm_fault()`, similar to the workflow in other
+   architectures.
+
+`handle_mm_fault()` (likely) ends up calling `__handle_mm_fault()` to carry
+out the actual work of allocation of the page tables. It works by using
+several functions to find the entry's offsets of the 4 - 5 layers of tables
+and allocate the tables it needs to. The functions that look for the offset
+have names like `*_offset()`, where the "*" is for pgd, p4d, pud, pmd, pte;
+instead the functions to allocate the corresponding tables, layer by layer,
+are named `*_alloc`, with the above mentioned convention to name them after
+the corresponding types of tables in the hierarchy.
+
+At the very end of the walk with allocations, if it didn't return errors,
+`__handle_mm_fault()` finally calls `handle_pte_fault()`, which via
+`do_fault()` performs one of `do_read_fault()`, `do_cow_fault()`,
+`do_shared_fault()`. "read", "cow", "shared" give hints about the reasons
+and the kind of fault it's handling.
+
+The actual implementation of the workflow is very complex. Its design allows
+Linux to handle page faults in a way that is tailored to the specific
+characteristics of each architecture, while still sharing a common overall
+structure.
+
+To conclude this brief overview from very high altitude of how Linux handles
+page faults, let's add that page faults handler can be disabled and enabled
+respectively with `pagefault_disable()` and `pagefault_enable()`.
+
+Several code path make use of the latter two functions because they need to
+disable traps into the page faults handler, mostly to prevent deadlocks.[1]
+
+[1] mm/userfaultfd: Replace kmap/kmap_atomic() with kmap_local_page()
+https://lore.kernel.org/all/20221025220136.2366143-1-ira.weiny@intel.com/
+
-- 
2.41.0

