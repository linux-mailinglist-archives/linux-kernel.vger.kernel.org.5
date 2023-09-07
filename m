Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64533797354
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjIGPXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjIGPVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50121197
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 22:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694065356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/CWGvO9dl10nwF5u1Uuz14eYbdHi5ccVChxSLOIBUU=;
        b=FIuZ3RGhiRNYxi/FwYf13a4c/93JoMDUw0jUnL9BKBli1oDXefRdZUHBHaAVwp4IKLpwdy
        oeNNK6qvlUbIF7PcoZZs34boon3d8p5vcpA0aOcr5ccsTN4itm8dYcZi1r5CMNsKRLlOBC
        GPOz/ZxMIDnyz6kTbwkEiW38EwENxHQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-ITvlD7nyOtqFbA3L-3aP4w-1; Thu, 07 Sep 2023 01:42:30 -0400
X-MC-Unique: ITvlD7nyOtqFbA3L-3aP4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9F37816526;
        Thu,  7 Sep 2023 05:42:28 +0000 (UTC)
Received: from localhost (unknown [10.72.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7288AC03292;
        Thu,  7 Sep 2023 05:42:27 +0000 (UTC)
Date:   Thu, 7 Sep 2023 13:42:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>,
        Dave Young <dyoung@redhat.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/3] powerpc/fadump: make is_fadump_active() visible
 for exporting vmcore
Message-ID: <ZPliwJ6b9oNDtAHC@MiWiFi-R3L-srv>
References: <20230905183604.568996-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905183604.568996-1-hbathini@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/23 at 12:06am, Hari Bathini wrote:
> Include asm/fadump.h in asm/kexec.h to make it visible while exporting
> vmcore. Also, update is_fadump_active() to return boolean instead of
> integer for better readability. The change will be used in the next
> patch to ensure vmcore is exported when fadump is active.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Thanks, Hari. The whole series looks good to me.

Acked-by: Baoquan He <bhe@redhat.com>

Since it's a power specific change, should be picked into powerpc tree?

Thanks
Baoquan

> ---
> 
> Changes in v2:
> * New patch based on Baoquan's suggestion to use is_fadump_active()
>   instead of introducing new function is_crashdump_kernel().
> 
> 
>  arch/powerpc/include/asm/fadump.h | 4 ++--
>  arch/powerpc/include/asm/kexec.h  | 8 ++++++--
>  arch/powerpc/kernel/fadump.c      | 4 ++--
>  3 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
> index 526a6a647312..27b74a7e2162 100644
> --- a/arch/powerpc/include/asm/fadump.h
> +++ b/arch/powerpc/include/asm/fadump.h
> @@ -15,13 +15,13 @@ extern int crashing_cpu;
>  
>  extern int is_fadump_memory_area(u64 addr, ulong size);
>  extern int setup_fadump(void);
> -extern int is_fadump_active(void);
> +extern bool is_fadump_active(void);
>  extern int should_fadump_crash(void);
>  extern void crash_fadump(struct pt_regs *, const char *);
>  extern void fadump_cleanup(void);
>  
>  #else	/* CONFIG_FA_DUMP */
> -static inline int is_fadump_active(void) { return 0; }
> +static inline bool is_fadump_active(void) { return false; }
>  static inline int should_fadump_crash(void) { return 0; }
>  static inline void crash_fadump(struct pt_regs *regs, const char *str) { }
>  static inline void fadump_cleanup(void) { }
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index a1ddba01e7d1..b760ef459234 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -51,6 +51,7 @@
>  
>  #ifndef __ASSEMBLY__
>  #include <asm/reg.h>
> +#include <asm/fadump.h>
>  
>  typedef void (*crash_shutdown_t)(void);
>  
> @@ -99,10 +100,13 @@ void relocate_new_kernel(unsigned long indirection_page, unsigned long reboot_co
>  
>  void kexec_copy_flush(struct kimage *image);
>  
> -#if defined(CONFIG_CRASH_DUMP) && defined(CONFIG_PPC_RTAS)
> +#if defined(CONFIG_CRASH_DUMP)
> +#define is_fadump_active		is_fadump_active
> +#if defined(CONFIG_PPC_RTAS)
>  void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
>  #define crash_free_reserved_phys_range crash_free_reserved_phys_range
> -#endif
> +#endif /* CONFIG_PPC_RTAS */
> +#endif /* CONFIG_CRASH_DUMP */
>  
>  #ifdef CONFIG_KEXEC_FILE
>  extern const struct kexec_file_ops kexec_elf64_ops;
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 3ff2da7b120b..5682a65e8326 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -187,9 +187,9 @@ int should_fadump_crash(void)
>  	return 1;
>  }
>  
> -int is_fadump_active(void)
> +bool is_fadump_active(void)
>  {
> -	return fw_dump.dump_active;
> +	return !!fw_dump.dump_active;
>  }
>  
>  /*
> -- 
> 2.41.0
> 

