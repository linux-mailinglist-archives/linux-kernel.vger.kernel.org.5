Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3688780B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376657AbjHRL1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376699AbjHRL1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:27:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8478D4204;
        Fri, 18 Aug 2023 04:27:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fea0640d7aso7883215e9.0;
        Fri, 18 Aug 2023 04:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692358052; x=1692962852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAZrEllq0Wy5uzPwEmIuVHBlwOQ/GuCMXULwdhFYbPA=;
        b=pWoUd3H7bpgF8f5t1c1wDTnvSEZS36Tzl301Ln8XQpeDWf9PndgkGIXJSfFTgy4aB3
         bWkzhGQWJEfcbFttGNUQuOuN/eVHxBW/EN6TTljoKsNu/wGpskvxs35ALamBQTWG73eR
         k1nLHXnOfcgcCnZ4dRthqUU0x8Xhg8s/3c+caMafbCGTCpWsc3t4zmoKZuC/lzzlF1XF
         S9qnJM7KePjtpV7vXqBgg7EhAQ3nBGZ7+60fqolVBRZ8fQQYCQz51UWQoLB2xInEVL3e
         E1frCN78e1ss492yMLv4ebzN3XkMW0Y4b5ADlBfTrzRu9XwrUYKcWjYN4M8jLjME1rG0
         zzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692358052; x=1692962852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAZrEllq0Wy5uzPwEmIuVHBlwOQ/GuCMXULwdhFYbPA=;
        b=IFcdaE12BErRVzyMspIZPXm1ljCiIGLx61j+a8li0njwq/aPE+c4Hruy5A1wPHHEwr
         HZGzzR0EPVw28aO9D6s+zZluE+/R56L0QCPPmEix3M/WGOgdxISy6j0fkaZrXQsIt5Qi
         hRp/l2AhPVsWd4gM9og5CyYWRIZsXEdTkS4y+usYxWDDhOw1bYDEYBJWbJGEBMb1ZAAJ
         37s9qLw0EJHPb2LiDeh4GOV5uwRLAkTB8wz3AM4UDk6AUlbHcuq12rG4wP6hDULlEx2m
         aPHhU7H+CCagGotawXXh8WP0dKBbNxPvA3pMTVBA2v8uCNSRa9XqcAA+G54vMU5935JW
         gWUQ==
X-Gm-Message-State: AOJu0YzLBi26nl+87K4xBzsZD5KBQ/EwViM7UqH4grWVKO8/0S7mUt7Q
        O3SYPn1peByoVaQK1qqAISs=
X-Google-Smtp-Source: AGHT+IG+Oudn/ihjE3uGCKh5RoOOaiQy8R7lDFTz5NY8QfhP4UXEEqNHPnViQpIAevzY/157i6mPyQ==
X-Received: by 2002:adf:e78d:0:b0:319:7c07:87bf with SMTP id n13-20020adfe78d000000b003197c0787bfmr1977066wrm.53.1692358051606;
        Fri, 18 Aug 2023 04:27:31 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-95-235.retail.telecomitalia.it. [79.42.95.235])
        by smtp.gmail.com with ESMTPSA id j7-20020adfea47000000b00317731a6e07sm2475940wrn.62.2023.08.18.04.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 04:27:30 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3] Documentation/page_tables: Add info about MMU/TLB and Page Faults
Date:   Fri, 18 Aug 2023 13:19:34 +0200
Message-ID: <20230818112726.6156-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v2 -> v3: This version fixes the grammar mistakes found by Linus
and forwards his "Reviewed-by" tag (thanks!).
https://lore.kernel.org/all/CACRpkdbq8UCtvtRH7FZUEqvTxPQcoGbrKvf_mT5QHMAfVoYNNQ@mail.gmail.com/

v1 -> v2: This version takes into account the comments provided by Mike
(thanks!). I hope I haven't overlooked anything he suggested :-)
https://lore.kernel.org/all/20230807105010.GK2607694@kernel.org/

Furthermore, v2 adds few more information about swapping which was not present
in v1.

before the "real" patch, this has been an RFC PATCH in its 2nd version for a week
or so until I received comments and suggestions from Jonathan Cameron (thanks!),
and then it morphed to a real patch.

The link to the thread with the RFC PATCH v2 and the messages between Jonathan
and me start at https://lore.kernel.org/all/20230723120721.7139-1-fmdefrancesco@gmail.com/#r


 Documentation/mm/page_tables.rst | 127 +++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/Documentation/mm/page_tables.rst b/Documentation/mm/page_tables.rst
index 7840c1891751..be47b192a596 100644
--- a/Documentation/mm/page_tables.rst
+++ b/Documentation/mm/page_tables.rst
@@ -152,3 +152,130 @@ Page table handling code that wishes to be architecture-neutral, such as the
 virtual memory manager, will need to be written so that it traverses all of the
 currently five levels. This style should also be preferred for
 architecture-specific code, so as to be robust to future changes.
+
+
+MMU, TLB, and Page Faults
+=========================
+
+The `Memory Management Unit (MMU)` is a hardware component that handles virtual
+to physical address translations. It may use relatively small caches in hardware
+called `Translation Lookaside Buffers (TLBs)` and `Page Walk Caches` to speed up
+these translations.
+
+When CPU accesses a memory location, it provides a virtual address to the MMU,
+which checks if there is the existing translation in the TLB or in the Page
+Walk Caches (on architectures that support them). If no translation is found,
+MMU uses the page walks to determine the physical address and create the map.
+
+The dirty bit for a page is set (i.e., turned on) when the page is written to.
+Each page of memory has associated permission and dirty bits. The latter
+indicate that the page has been modified since it was loaded into memory.
+
+If nothing prevents it, eventually the physical memory can be accessed and the
+requested operation on the physical frame is performed.
+
+There are several reasons why the MMU can't find certain translations. It could
+happen because the CPU is trying to access memory that the current task is not
+permitted to, or because the data is not present into physical memory.
+
+When these conditions happen, the MMU triggers page faults, which are types of
+exceptions that signal the CPU to pause the current execution and run a special
+function to handle the mentioned exceptions.
+
+There are common and expected causes of page faults. These are triggered by
+process management optimization techniques called "Lazy Allocation" and
+"Copy-on-Write". Page faults may also happen when frames have been swapped out
+to persistent storage (swap partition or file) and evicted from their physical
+locations.
+
+These techniques improve memory efficiency, reduce latency, and minimize space
+occupation. This document won't go deeper into the details of "Lazy Allocation"
+and "Copy-on-Write" because these subjects are out of scope as they belong to
+Process Address Management.
+
+Swapping differentiates itself from the other mentioned techniques because it's
+undesirable since it's performed as a means to reduce memory under heavy
+pressure.
+
+Swapping can't work for memory mapped by kernel logical addresses. These are a
+subset of the kernel virtual space that directly maps a contiguous range of
+physical memory. Given any logical address, its physical address is determined
+with simple arithmetic on an offset. Accesses to logical addresses are fast
+because they avoid the need for complex page table lookups at the expenses of
+frames not being evictable and pageable out.
+
+If the kernel fails to make room for the data that must be present in the
+physical frames, the kernel invokes the out-of-memory (OOM) killer to make room
+by terminating lower priority processes until pressure reduces under a safe
+threshold.
+
+Additionally, page faults may be also caused by code bugs or by maliciously
+crafted addresses that the CPU is instructed to access. A thread of a process
+could use instructions to address (non-shared) memory which does not belong to
+its own address space, or could try to execute an instruction that want to write
+to a read-only location.
+
+If the above-mentioned conditions happen in user-space, the kernel sends a
+`Segmentation Fault` (SIGSEGV) signal to the current thread. That signal usually
+causes the termination of the thread and of the process it belongs to.
+
+This document is going to simplify and show an high altitude view of how the
+Linux kernel handles these page faults, creates tables and tables' entries,
+check if memory is present and, if not, requests to load data from persistent
+storage or from other devices, and updates the MMU and its caches.
+
+The first steps are architecture dependent. Most architectures jump to
+`do_page_fault()`, whereas the x86 interrupt handler is defined by the
+`DEFINE_IDTENTRY_RAW_ERRORCODE()` macro which calls `handle_page_fault()`.
+
+Whatever the routes, all architectures end up to the invocation of
+`handle_mm_fault()` which, in turn, (likely) ends up calling
+`__handle_mm_fault()` to carry out the actual work of allocating the page
+tables.
+
+The unfortunate case of not being able to call `__handle_mm_fault()` means
+that the virtual address is pointing to areas of physical memory which are not
+permitted to be accessed (at least from the current context). This
+condition resolves to the kernel sending the above-mentioned SIGSEGV signal
+to the process and leads to the consequences already explained.
+
+`__handle_mm_fault()` carries out its work by calling several functions to
+find the entry's offsets of the upper layers of the page tables and allocate
+the tables that it may need.
+
+The functions that look for the offset have names like `*_offset()`, where the
+"*" is for pgd, p4d, pud, pmd, pte; instead the functions to allocate the
+corresponding tables, layer by layer, are called `*_alloc`, using the
+above-mentioned convention to name them after the corresponding types of tables
+in the hierarchy.
+
+The page table walk may end at one of the middle or upper layers (PMD, PUD).
+
+Linux supports larger page sizes than the usual 4KB (i.e., the so called
+`huge pages`). When using these kinds of larger pages, higher level pages can
+directly map them, with no need to use lower level page entries (PTE). Huge
+pages contain large contiguous physical regions that usually span from 2MB to
+1GB. They are respectively mapped by the PMD and PUD page entries.
+
+The huge pages bring with them several benefits like reduced TLB pressure,
+reduced page table overhead, memory allocation efficiency, and performance
+improvement for certain workloads. However, these benefits come with
+trade-offs, like wasted memory and allocation challenges.
+
+At the very end of the walk with allocations, if it didn't return errors,
+`__handle_mm_fault()` finally calls `handle_pte_fault()`, which via `do_fault()`
+performs one of `do_read_fault()`, `do_cow_fault()`, `do_shared_fault()`.
+"read", "cow", "shared" give hints about the reasons and the kind of fault it's
+handling.
+
+The actual implementation of the workflow is very complex. Its design allows
+Linux to handle page faults in a way that is tailored to the specific
+characteristics of each architecture, while still sharing a common overall
+structure.
+
+To conclude this high altitude view of how Linux handles page faults, let's
+add that the page faults handler can be disabled and enabled respectively with
+`pagefault_disable()` and `pagefault_enable()`.
+
+Several code path make use of the latter two functions because they need to
+disable traps into the page faults handler, mostly to prevent deadlocks.
-- 
2.41.0

