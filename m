Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7A975D867
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 02:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGVApB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 20:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGVAo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 20:44:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D851BE4;
        Fri, 21 Jul 2023 17:44:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-991da766865so382993466b.0;
        Fri, 21 Jul 2023 17:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689986697; x=1690591497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSkVUAs/bC4Qut2615ixo6merV8IPi1f4c7VcSRSGl0=;
        b=Eka2UzXKh4jYI0Tmj260Dr+WcsoM73VBZr4t67pnteCoEuo6f2v5+NQpVU2CbJgk7P
         CnC78vdJ99kATvqTXIrkvk0lCKfQnAL58eNo6lcRNxbNjw92mCUzxMqPjeCNaVC3FvI/
         dbw/cOIlDNI+axS73IiJypZeOVRkT2lSnnExKAqsuBJVmORMhTlGkrw/KapjU9Dm6xui
         L/EuNEIdvYu4byMwItAaExzXCnXqG7noxoRYAdo8JEPy/LmbjlfljHPEx+4viZYy6U0N
         fU4FNSQOLXmV1ABQuH1zclehlgoZZRLwFyoxAFb1WKoJd8aDh4hiqRgXQJKPJOCe5laD
         02Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689986697; x=1690591497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSkVUAs/bC4Qut2615ixo6merV8IPi1f4c7VcSRSGl0=;
        b=ede08CYG8wAWmEv8CEsN0ouNfYNVLQfB4/1+HAm1GQEw+icLnWCKNa2b8DSaUhlUUz
         hMp/gCrsMG7VHfRzNej8KMgGE3S4R3DeYIq8HsvtEmGmO/9NiOxuwzoaQLwuKNZlnOzd
         9DDb7x+Wd/nmVqSX42apQIYXE/m/MXg5wYEbKLzHFbyhZUmpmFHMLXFhjvJgWK8ig+jE
         SUha5vheUyecRe+2FoAtwPsrB3l6MqTz0xSmhHQa2+hp6LOhhYHp0AySHaRurPXssOxc
         Z9cSbFq//5YkWoAZvWEWO/aH0H75sTbvb+QMG0yDd9TxqFwMt73AfC234amLSU0Homcr
         TRCQ==
X-Gm-Message-State: ABy/qLYfE8SujjomnGdQ1S9hbyzOrNri1TrnzOug4BbALW6+/M2TF2gf
        tAKvhM1tH10tdnuAgcJ00Mo=
X-Google-Smtp-Source: APBJJlFkEZtV9yQDYlcm5eBbc3TmV1SftKpzjlhgBWwW1LaVDbWsTb+Z5w0CocRBp9A77mYvyyvq7Q==
X-Received: by 2002:a17:906:18c:b0:957:2e48:5657 with SMTP id 12-20020a170906018c00b009572e485657mr3200545ejb.68.1689986696396;
        Fri, 21 Jul 2023 17:44:56 -0700 (PDT)
Received: from localhost.localdomain (host-79-21-231-40.retail.telecomitalia.it. [79.21.231.40])
        by smtp.gmail.com with ESMTPSA id r11-20020a056000014b00b0031437299fafsm5507490wrx.34.2023.07.21.17.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 17:44:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [RFC PATCH] Documentation/page_tables: MMU, TLB, and Page Faults
Date:   Sat, 22 Jul 2023 02:43:13 +0200
Message-ID: <20230722004451.7730-1-fmdefrancesco@gmail.com>
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

