Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5777775E1AA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjGWMCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjGWMCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:02:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0435C10C7;
        Sun, 23 Jul 2023 05:02:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-307d20548adso2362547f8f.0;
        Sun, 23 Jul 2023 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690113755; x=1690718555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLocNhdXvsCh5682u3tK4o2ag/IbV/VNJhwUsrpqvbM=;
        b=Cb2lfDRlIrYNFNu7MM2OIF0BLCRrxQvyJKUmU5c7sAJLDXZ/VV6fli0zv1I1+j/M3N
         GqA+9LIteXR+lEttcbLme0xBL39wB2Nxb0KJmCzwgLIeRksm0rY4KsJh7rlx40EW2Ls8
         F5Z9QCaEXQg5dOci/yYs4ojTcr4AfyLFQLVCve+g+EGLOEWPTDhY4Lpu7sTwF6XHimWX
         runWvZRbxnJFG1fgTuNkdajG3cYFzmWOtK5je/8kEQSj7iA4RAbFSyZcpYM5Uz3285zA
         HJV1yNMqd/WlfR9HJODdp0qgw4JrFDxBWPJd4HMTwog5obAgrcU53MU5OcPlu0AVXCH+
         Sxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690113755; x=1690718555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLocNhdXvsCh5682u3tK4o2ag/IbV/VNJhwUsrpqvbM=;
        b=mFfSFYPcH576UV4/S3z1s5S8uf17nlxNiDYZKeuuX/Ry9QR8H0/DhBuZWaLsIoPsZE
         pEATuIa0gD1z3ovGAuKJhEUdSMIcNQFmtDnrKKX8CMWQH/mRrtkMqDXqsYcibPX8uQGD
         i149U5gzyhvLARr4A41RaQy6i+qWeGeUliTDffhNyyVBJ0Fpcen0PJ7yP0HJXoZ81UWd
         hI/HMj60N5Cp2oJ1n7YsQSnQpmTktXvOMm3zVle4VFzEMgO85DzLmHemk8YAWCYpwEp6
         7hKinbS5tn/zTJ4t9+Hr0BFvUJhmryeOQz1obdO+ja7SppPWDGPwvZfAu6GTl/rvdaLZ
         qJSQ==
X-Gm-Message-State: ABy/qLZHao1d3PyBZ0TMU3dM6yFoKq4u3lNLvEgu1EDvi+UER7XT2iL9
        ihHoCEiY+dNLRgxcAeeo7TdwT1wqJu8=
X-Google-Smtp-Source: APBJJlHR0BT4IvdyoiCMYrkcYODlZ7zleJUj+ySiHvfmTMOTHWoNqt26QTCoF0V+jtZBTkizWiMgUg==
X-Received: by 2002:a05:6000:1373:b0:307:8c47:a266 with SMTP id q19-20020a056000137300b003078c47a266mr3730382wrz.61.1690113755166;
        Sun, 23 Jul 2023 05:02:35 -0700 (PDT)
Received: from localhost.localdomain (host-87-20-104-222.retail.telecomitalia.it. [87.20.104.222])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c21c300b003fa95890484sm7561611wmj.20.2023.07.23.05.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 05:02:34 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [RFC PATCH v2] Documentation/page_tables: MMU, TLB, and Page Faults
Date:   Sun, 23 Jul 2023 13:56:38 +0200
Message-ID: <20230723120100.5891-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend page_tables.rst by adding a small introductive section about
the role of MMU and TLB in translating between virtual addresses and
physical page frames. Furthermore explain the concepts behind the
Page Faults exceptions and how Linux handles them.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
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
of pagefault_disable() to prevent deadlocks.

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

 Documentation/mm/page_tables.rst | 61 ++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/mm/page_tables.rst b/Documentation/mm/page_tables.rst
index 7840c1891751..fa617894fda8 100644
--- a/Documentation/mm/page_tables.rst
+++ b/Documentation/mm/page_tables.rst
@@ -152,3 +152,64 @@ Page table handling code that wishes to be architecture-neutral, such as the
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
+The actual implementation of the workflow is very complex. Its design allows
+Linux to handle page faults in a way that is tailored to the specific
+characteristics of each architecture, while still sharing a common overall
+structure.
-- 
2.41.0

