Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90447805BC2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346929AbjLEQBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjLEQBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:01:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABC01AB;
        Tue,  5 Dec 2023 08:01:39 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3333224c7b9so3711757f8f.1;
        Tue, 05 Dec 2023 08:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701792097; x=1702396897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tvo/9rnArZ8fI0hFLD0+8fIJyDMuJ5boJQpNSGg0de4=;
        b=Ua44hSie5AoBdpKopXuz6XgZ4mVi8FN/VOwnnUMYnfUYsNcd6eJ3/x53YNLEo7xgim
         f/ZhmeoTXKDWSLDX7KvuO5yGQth/g1a8bZAkGRQynVUs1MOhIQMT1jRFwxzoA2ZPOmRU
         EqLNpvZegCB+wYnsUCWKcPQNxSaAV+2YsQMbdgXjyb/KQcW/oMAAgKMiMz8ZUgKk+XtA
         5H9DX+0KjHNPGO9vQLmeXzu8/4NaxXAzzWXIe5n4ji6P0ySLOErqzDaJQCr0zjidjjif
         56NOZxSinLA+Ar4kzkUUovi/jn8CWUURiTwlNqRvM7lafyN0+TabPRcW+po5OTqWgDZi
         6JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792097; x=1702396897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tvo/9rnArZ8fI0hFLD0+8fIJyDMuJ5boJQpNSGg0de4=;
        b=WlcMUCOIDrVGv/wcWvNtjLJ3i31U1+mr/SIDJu6lgY3g8icXq9q5srzDOdLNA+vh/7
         GpqG5nSqNQjfYcE2KvKTrBZ/Hgc67Igc89DzQDfnpY7LJ6bgwZtOnc12QtrWkRgpYx9k
         QfRt7l8eyF1MK+dO195vowrBmF6/uv8Wr9euNKNg9ZlUSGclMer3bf1YLHvJlSCFFjZm
         0xzrGkM0lBJU7OnfdVe9q9NINHPJR+E89Wj/clW9moeNP4wvelGw0KHZCLZ/PfjaixZ7
         KJaXfjbJ7nCjJyzMJNtkJR3jz2VFIp8fMpQ+AaVJsX+r7F/yztYdDdvIE2gp36L18DDo
         HFkQ==
X-Gm-Message-State: AOJu0YxqNdPTCMSO4qj7u9Bip/ed6fMPfTqFBEokZEzIX3+nDCH0huyw
        OMs7zRe8eIuKk/kTc7BHdnJf5W3RKA==
X-Google-Smtp-Source: AGHT+IGVDOHWf2/MsqsnRu1T0vHj++2BZvSkVNdgYatcywQjkipt57Ds2m07DrWUWbWeutZCjMzx6A==
X-Received: by 2002:adf:e349:0:b0:333:4862:8520 with SMTP id n9-20020adfe349000000b0033348628520mr2133188wrj.138.1701792097218;
        Tue, 05 Dec 2023 08:01:37 -0800 (PST)
Received: from p183 ([46.53.254.107])
        by smtp.gmail.com with ESMTPSA id r13-20020a056000014d00b003333fc2cb92sm8295598wrx.58.2023.12.05.08.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:01:36 -0800 (PST)
Date:   Tue, 5 Dec 2023 19:01:34 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
Message-ID: <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
 <87v89dvuxg.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v89dvuxg.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report available page shifts in arch independent manner, so that
userspace developers won't have to parse /proc/cpuinfo hunting
for arch specific strings:

Note!

This is strictly for userspace, if some page size is shutdown due
to kernel command line option or CPU bug workaround, than is must not
be reported in aux vector!

x86_64 machine with 1 GiB pages:

	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
	00000040  1d 00 00 00 00 00 00 00  00 10 20 40 00 00 00 00

x86_64 machine with 2 MiB pages only:

	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
	00000040  1d 00 00 00 00 00 00 00  00 10 20 00 00 00 00 00

AT_PAGESZ is always 4096 which is not that interesting.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	v2: switch to 1 bit per page shift (bitmask)

 arch/x86/include/asm/elf.h  |   12 ++++++++++++
 fs/binfmt_elf.c             |    3 +++
 include/uapi/linux/auxvec.h |   14 ++++++++++++++
 3 files changed, 29 insertions(+)

--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -358,6 +358,18 @@ else if (IS_ENABLED(CONFIG_IA32_EMULATION))				\
 
 #define COMPAT_ELF_ET_DYN_BASE	(TASK_UNMAPPED_BASE + 0x1000000)
 
+#define ARCH_AT_PAGE_SHIFT_MASK					\
+	do {							\
+		u32 val = 1 << 12;				\
+		if (boot_cpu_has(X86_FEATURE_PSE)) {		\
+			val |= 1 << 21;				\
+		}						\
+		if (boot_cpu_has(X86_FEATURE_GBPAGES)) {	\
+			val |= 1 << 30;				\
+		}						\
+		NEW_AUX_ENT(AT_PAGE_SHIFT_MASK, val);		\
+	} while (0)
+
 #endif /* !CONFIG_X86_32 */
 
 #define VDSO_CURRENT_BASE	((unsigned long)current->mm->context.vdso)
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -240,6 +240,9 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 #endif
 	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
 	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
+#ifdef ARCH_AT_PAGE_SHIFT_MASK
+	ARCH_AT_PAGE_SHIFT_MASK;
+#endif
 	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
 	NEW_AUX_ENT(AT_PHDR, phdr_addr);
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
--- a/include/uapi/linux/auxvec.h
+++ b/include/uapi/linux/auxvec.h
@@ -33,6 +33,20 @@
 #define AT_RSEQ_FEATURE_SIZE	27	/* rseq supported feature size */
 #define AT_RSEQ_ALIGN		28	/* rseq allocation alignment */
 
+/*
+ * Page sizes available for mmap(2) encoded as bitmask.
+ *
+ * Example: x86_64 system with pse, pdpe1gb /proc/cpuinfo flags reports
+ * 4 KiB, 2 MiB and 1 GiB page support.
+ *
+ *	$ hexdump -C /proc/self/auxv
+ *	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
+ *	00000040  1d 00 00 00 00 00 00 00  00 10 20 40 00 00 00 00
+ *
+ * For 2^64 hugepage support please contact your Universe sales representative.
+ */
+#define AT_PAGE_SHIFT_MASK	29
+
 #define AT_EXECFN  31	/* filename of program */
 
 #ifndef AT_MINSIGSTKSZ
