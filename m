Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D7C7F928A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 13:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjKZLzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 06:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjKZLzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 06:55:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827E510F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 03:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700999750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=10f/Bul9KbIaMsjeanbNOmm62BHIxQH0eftSF3zeoHA=;
        b=IXiDeKM6E1pRz0aHXANjgB3J97HfSg2MI8kj1Qbv7ixMTk5kvOshWSH+1nfBzG9StVSS4L
        rx26h/szJb9S2etl8A60o5/n/QXs0LxaRslobBpTAlxWyK/mw1rNSIvbUJchrJKmPWu9F9
        CKfipjWZa3Nlz54iZdbEKhyDw31CuCw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-n79wBA5hOnSAQHO1OAsXyg-1; Sun,
 26 Nov 2023 06:55:45 -0500
X-MC-Unique: n79wBA5hOnSAQHO1OAsXyg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90DF23C0C88A;
        Sun, 26 Nov 2023 11:55:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8B1340C6EB9;
        Sun, 26 Nov 2023 11:55:43 +0000 (UTC)
Date:   Sun, 26 Nov 2023 19:55:40 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, kexec@lists.infradead.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
        joe@perches.com, nathan@kernel.org, yujie.liu@intel.com
Subject: Re: [PATCH v2 4/7] kexec_file, arm64: print out debugging message if
 required
Message-ID: <ZWMyPB6HjxAczLzZ@MiWiFi-R3L-srv>
References: <20231124033642.520686-5-bhe@redhat.com>
 <202311260548.1HaxcDnE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311260548.1HaxcDnE-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/23 at 05:26am, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on tip/x86/core powerpc/next powerpc/fixes linus/master v6.7-rc2 next-20231124]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec_file-add-kexec_file-flag-to-control-debug-printing/20231124-113942
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/20231124033642.520686-5-bhe%40redhat.com
> patch subject: [PATCH v2 4/7] kexec_file, arm64: print out debugging message if required
> config: arm64-randconfig-001-20231126 (https://download.01.org/0day-ci/archive/20231126/202311260548.1HaxcDnE-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231126/202311260548.1HaxcDnE-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311260548.1HaxcDnE-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/arm64/kernel/machine_kexec.c:35:2: error: implicit declaration of function 'kexec_dprintk' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>            kexec_dprintk("%s:%d:\n", func, line);
>            ^
>    1 error generated.

Thanks for reporting. It has below kexec related config items, whereas
the kexec_drpintk() is only defined in CONFIG_KEXEC_FILE ifdeffery
scope, moving it to CONFIG_KEXEC_CORE iddeffery scope in <linux/kexec.h>
can fix it as below draft code. Will update patch 1 to include the code
change.

===
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
===

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 66997efe36f1..b457b0d70f3f 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -265,13 +265,6 @@ arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
 }
 #endif
 
-extern bool kexec_file_dbg_print;
-
-#define kexec_dprintk(fmt, ...)					\
-	printk("%s" fmt,					\
-	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
-	       ##__VA_ARGS__)
-
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
@@ -508,6 +501,13 @@ static inline int crash_hotplug_memory_support(void) { return 0; }
 static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
 #endif
 
+extern bool kexec_file_dbg_print;
+
+#define kexec_dprintk(fmt, ...)					\
+	printk("%s" fmt,					\
+	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
+	       ##__VA_ARGS__)
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..bddba29a1557 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -52,6 +52,8 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
+bool kexec_file_dbg_print;
+
 int kexec_should_crash(struct task_struct *p)
 {
 	/*
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 7ae1b0901aa4..8f87644b4eec 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -38,8 +38,6 @@ void set_kexec_sig_enforced(void)
 }
 #endif
 
-bool kexec_file_dbg_print;
-
 static int kexec_calculate_store_digests(struct kimage *image);
 
 /* Maximum size in bytes for kernel/initrd files. */

