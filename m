Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7228E7819A4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 15:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjHSNH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 09:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjHSNH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 09:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E123B1B33A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692450284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=44t+slypeaFqQqg1YfQ+1N3czVzY0JoGqBhiZJtua2M=;
        b=Gvv0k3hR6e7A9OKO9Y/G3apd4uax4ucU311Zj7MHInsWqwYwoXcmXX68igKcwAsHMWbfoi
        ZmmQUSqZmBmxSXc5zwdVf6aR1chOvphgMxjwy1ybENZ3HETaoBn1tmoloqh1jwVqr1spSF
        C/4UPNEmkz6jqlxYjnlOuBX2VPObjDg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-jSEZ7sAUNXaqrfFwWEhtYw-1; Sat, 19 Aug 2023 09:04:39 -0400
X-MC-Unique: jSEZ7sAUNXaqrfFwWEhtYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8A7C185A78F;
        Sat, 19 Aug 2023 13:04:38 +0000 (UTC)
Received: from localhost (unknown [10.72.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A102D5CBFF;
        Sat, 19 Aug 2023 13:04:36 +0000 (UTC)
Date:   Sat, 19 Aug 2023 21:04:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>, eric.devolder@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, sourabhjain@linux.ibm.com, hbathini@linux.ibm.com
Subject: Re: [BUG resend next-20230818] error: 'prepare_elf_headers' defined
 but not used
Message-ID: <ZOC94WelqfS0vsFK@MiWiFi-R3L-srv>
References: <08fc20ef-854d-404a-b2f2-75941eeeccf8@paulmck-laptop>
 <4a991983-da2e-4fcd-965c-5b65de6700da@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a991983-da2e-4fcd-965c-5b65de6700da@paulmck-laptop>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/18/23 at 07:28pm, Paul E. McKenney wrote:
> Hello!
> 
> This morning's rcutorture testing on next-20230818 complained about
> prepare_elf_headers() being defined but unused on several rcutorture
> scenarios.  The patch below makes rcutorture happy, but might or might
> not be a proper fix.
> 
> This is a resend adding a few more people on CC, given a possible
> relationship to 9f1f399ca999 ("x86/crash: add x86 crash hotplug support").
> 
> Thoughts?
> 

Thanks for reporting this, Paul.
> 
> ------------------------------------------------------------------------
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 1d0f824559fce..926c39e22387b 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -127,7 +127,8 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>  	crash_save_cpu(regs, safe_smp_processor_id());
>  }
>  
> -#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_DUMP)
> +#if (defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_DUMP)) && defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)

Hi Eric,

Now prepare_elf_headers() is needed for kexec_file_load and crash
hotplug support of kexec_load, change it like this?

#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_HOTPLUG)

