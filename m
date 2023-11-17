Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E257EED79
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjKQIVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjKQIVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:21:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63885C4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700209306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+0IPYUuB6y8LVS3V3YvRYrvE/Uj5v9lAZt6UYvZz0Qc=;
        b=a+vNd1Yda7OnpSPOX1LukYVrGI1Z6r+kQHI4XLUVTyYduX6g0ixWCew26UnxKEA7Y2I2Yq
        meY3GUaOTg/UZZDFu9Q1ral4kep0Zb2xzsOye+T9RIYR5MohdmZ22qg3De91CB/TCjYIRV
        OiLyKm5UjYCvWj7LslxmjwQfFeNp6c0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-N-nJ3rrvPGOCY0SbwiDEVQ-1; Fri, 17 Nov 2023 03:21:41 -0500
X-MC-Unique: N-nJ3rrvPGOCY0SbwiDEVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40E1E832D60;
        Fri, 17 Nov 2023 08:21:41 +0000 (UTC)
Received: from localhost (unknown [10.72.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45D4240C6EB9;
        Fri, 17 Nov 2023 08:21:39 +0000 (UTC)
Date:   Fri, 17 Nov 2023 16:21:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH 2/7] kexec_file: print out debugging message if required
Message-ID: <ZVcikWw9lYN9SucO@MiWiFi-R3L-srv>
References: <20231114153253.241262-3-bhe@redhat.com>
 <202311160502.jnu7b8KF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311160502.jnu7b8KF-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 at 05:57am, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on tip/x86/core powerpc/next powerpc/fixes linus/master v6.7-rc1 next-20231115]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec_file-add-kexec_file-flag-to-control-debug-printing/20231114-234003
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/20231114153253.241262-3-bhe%40redhat.com
> patch subject: [PATCH 2/7] kexec_file: print out debugging message if required
> config: x86_64-randconfig-002-20231115 (https://download.01.org/0day-ci/archive/20231116/202311160502.jnu7b8KF-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160502.jnu7b8KF-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311160502.jnu7b8KF-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/crash_core.c: In function 'crash_prepare_elf64_headers':
> >> kernel/crash_core.c:412:17: error: implicit declaration of function 'kexec_dprintk'; did you mean '_dev_printk'? [-Werror=implicit-function-declaration]
>      412 |                 kexec_dprintk("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, "
>          |                 ^~~~~~~~~~~~~
>          |                 _dev_printk
>    cc1: some warnings being treated as errors
> 
> 
> vim +412 kernel/crash_core.c

Thanks for reporting this.

Below code can fix it.

crash_prepare_elf64_headers() could be used by kexec_load interface for
cpu/memory hotplug updating elfcoreheader, or by kexec_file_load
interface for elfcoreheader composing or updating. Only print out the
debugging message about ELF core header when kexec_file_load interface
is taken.

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 41001ffbaa99..1485fd7bb67f 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -551,10 +551,12 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
 		phdr->p_align = 0;
 		ehdr->e_phnum++;
+#ifdef CONFIG_KEXEC_FILE
 		kexec_dprintk("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, "
 			"sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
 			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
 			ehdr->e_phnum, phdr->p_offset);
+#endif
 		phdr++;
 	}

