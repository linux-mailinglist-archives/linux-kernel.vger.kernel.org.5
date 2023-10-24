Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E1B7D5028
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjJXMpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbjJXMpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4039B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698151491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CODKCtH5hmSRh9bBGyaKTVCZDnlLHU54pzgVooF1R0k=;
        b=K2aBzznKyPB+oZvX6wC1JK9zwbhAYeTk6u2POCy95FaHd7+XwOD6R2QpVV+9cl8yf87Uog
        VvkHdw3wlu8jSs50W/jGGTgeVZcgSOTOJRywo+A1YSzFPnHWLFSlVJt7hnCVuAxddAFCqd
        npNoL4gTuXpOfYYiMy04IvAe6UAqv+0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-tcJAmO1PPUKcVk6oYnFHmw-1; Tue, 24 Oct 2023 08:44:41 -0400
X-MC-Unique: tcJAmO1PPUKcVk6oYnFHmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74E253C0F435;
        Tue, 24 Oct 2023 12:44:40 +0000 (UTC)
Received: from localhost (unknown [10.72.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C6822026D4C;
        Tue, 24 Oct 2023 12:44:39 +0000 (UTC)
Date:   Tue, 24 Oct 2023 20:44:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, eric_devolder@yahoo.com
Subject: Re: [PATCH 1/2] kexec: fix KEXEC_FILE dependencies
Message-ID: <ZTe8NOgAjvKDA6z0@MiWiFi-R3L-srv>
References: <20231023110308.1202042-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023110308.1202042-1-arnd@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just add people and mailing list to CC since I didn't find this mail in
my box, just drag it via 'b4 am'.

On 10/23/23 at 01:01pm, Arnd Bergmann wrote:
......
> ---
>  arch/powerpc/Kconfig | 4 ++--
>  arch/riscv/Kconfig   | 4 +---
>  arch/s390/Kconfig    | 4 ++--
>  arch/x86/Kconfig     | 4 ++--
>  kernel/Kconfig.kexec | 1 +
>  5 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index d5d5388973ac7..4640cee33f123 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -607,10 +607,10 @@ config ARCH_SUPPORTS_KEXEC
>  	def_bool PPC_BOOK3S || PPC_E500 || (44x && !SMP)
>  
>  config ARCH_SUPPORTS_KEXEC_FILE
> -	def_bool PPC64 && CRYPTO=y && CRYPTO_SHA256=y
> +	def_bool PPC64
>  
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
> -	def_bool KEXEC_FILE
> +	def_bool y
>  
>  config ARCH_SELECTS_KEXEC_FILE
>  	def_bool y
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 25474f8c12b79..f571bad2d22d0 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -687,9 +687,7 @@ config ARCH_SELECTS_KEXEC_FILE
>  	select KEXEC_ELF
>  
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
> -	def_bool KEXEC_FILE
> -	depends on CRYPTO=y
> -	depends on CRYPTO_SHA256=y
> +	def_bool y
>  
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index b0d67ac8695f9..ec77106af4137 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -253,13 +253,13 @@ config ARCH_SUPPORTS_KEXEC
>  	def_bool y
>  
>  config ARCH_SUPPORTS_KEXEC_FILE
> -	def_bool CRYPTO && CRYPTO_SHA256 && CRYPTO_SHA256_S390
> +	def_bool y
>  
>  config ARCH_SUPPORTS_KEXEC_SIG
>  	def_bool MODULE_SIG_FORMAT
>  
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
> -	def_bool KEXEC_FILE
> +	def_bool y
>  
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 94efde80ebf35..f9975b15ccd57 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2073,7 +2073,7 @@ config ARCH_SUPPORTS_KEXEC
>  	def_bool y
>  
>  config ARCH_SUPPORTS_KEXEC_FILE
> -	def_bool X86_64 && CRYPTO && CRYPTO_SHA256
> +	def_bool X86_64
>  
>  config ARCH_SELECTS_KEXEC_FILE
>  	def_bool y
> @@ -2081,7 +2081,7 @@ config ARCH_SELECTS_KEXEC_FILE
>  	select HAVE_IMA_KEXEC if IMA
>  
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
> -	def_bool KEXEC_FILE
> +	def_bool y
>  
>  config ARCH_SUPPORTS_KEXEC_SIG
>  	def_bool y
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 7aff28ded2f48..bfc636d64ff2b 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -36,6 +36,7 @@ config KEXEC
>  config KEXEC_FILE
>  	bool "Enable kexec file based system call"
>  	depends on ARCH_SUPPORTS_KEXEC_FILE
> +	depends on CRYPTO_SHA256=y || !ARCH_SUPPORTS_KEXEC_PURGATORY

I am not sure if the logic is correct. In theory, kexec_file code
utilizes purgatory to verify the checksum digested during kernel loading
when try to jump to the kernel. That means kexec_file depends on
purgatory, but not contrary?

With these changes, we can achieve the goal to avoid building issue,
whereas the code logic becomes confusing. E.g people could disable
CONFIG_KEXEC_FILE, but still get purgatory code built in which is
totally useless.

Not sure if I think too much over this.

>  	select KEXEC_CORE
>  	help
>  	  This is new version of kexec system call. This system call is
> -- 
> 2.39.2

