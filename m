Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327577B0EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjI0Wb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjI0Wb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:31:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB72FB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:31:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c4ec85ea9so233334607b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695853885; x=1696458685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPFPSld1QoxNNv2eOiTPtaeDc/jtQaoLteL64zdeiXU=;
        b=kZ4XSwqVrMmKuD8FA7L0Wj44EDWvr11JwzdxaVcNe1IgX7jFd5gmKu4N4pgBYweuiC
         OKrcoe5QNWVrnwdqJ6mnfNr2X5nUXWH/m0TdEP1f+mGdgEIXMgpV48e9bSJijmjQ14O4
         Teo+a4oUm80LZz3uo90XmohNkPdtS/8dPBaXYA76b+IsP+iaV0+vepyFnCyIjI1Nk+Lb
         jKcOVg22xhp7VuXQjYEmmgH4iaZAFvWfQRYrY19R3GGBOnPcGKmu7Q9jk83AxpJ8jf19
         1lBcM/tux1Rmn4Un+Ssl80mfh02FxatpUEaBJQ+9hQbevKsu8cM7wWKphJKf1WLtgICK
         uEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695853885; x=1696458685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yPFPSld1QoxNNv2eOiTPtaeDc/jtQaoLteL64zdeiXU=;
        b=nvcbBr6N4bYoD0ylBy3CXNkUwu7f1c96+BlJ3tjcpKBinQooyaepoHPgzhW4n6MHKb
         2fLDEildCGRpBzLbnh9Wd5uIW2pUh+oRxL1IvFSIiEWy6lYlRzJS7tAJRwEyA4+/4fpM
         QcAQIBczGdds8DARmyVqx0BNGjo/RSkxEKdvwf3UvAntBfLlX1WEOEBR9/1JviS+y+ie
         DDkyduJ1wuO6ZtMakgE2NvZX5fiRcSJVtcxOSuo9tjQl0siCs4u4wrRkzVdd/aG25CxD
         SESNybX6gXcVm8+kl1dpn9wHs66OthE88ocj1EMqRDn7Dx3OPdsBDUZ8+olbu1kmZsrD
         74nw==
X-Gm-Message-State: AOJu0YxJ4YyInoXz2uehcGYU9+M8vut5MkPCbLzdJuGolBYdBZN/1u8z
        uDt5k+wcN636oO4g1yZNXJd5Onlrkjw=
X-Google-Smtp-Source: AGHT+IHzMWTwaEgO6mf9o8MaJUtvk19Egxe0QVczeyRnzbzsBUsGOjmR+c7nEst3ug6Uxjox+Nt5NLKNrf4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ad25:0:b0:59f:3cde:b33a with SMTP id
 l37-20020a81ad25000000b0059f3cdeb33amr50816ywh.6.1695853885399; Wed, 27 Sep
 2023 15:31:25 -0700 (PDT)
Date:   Wed, 27 Sep 2023 15:31:23 -0700
In-Reply-To: <20230824215244.3897419-1-kyle.meyer@hpe.com>
Mime-Version: 1.0
References: <20230824215244.3897419-1-kyle.meyer@hpe.com>
Message-ID: <ZRStOxiGwvDwGlNq@google.com>
Subject: Re: [PATCH v3] KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS
From:   Sean Christopherson <seanjc@google.com>
To:     Kyle Meyer <kyle.meyer@hpe.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@intel.com, x86@kernel.org, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, dmatlack@google.com, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, steve.wahl@hpe.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023, Kyle Meyer wrote:
> Add a Kconfig entry to set the maximum number of vCPUs per KVM guest and
> set the default value to 4096 when MAXSMP is enabled.

I'd like to capture why the max is set to 4096, both the justification and why
we don't want to go further at this point.

If you've no objection, I'll massage the changelog to this when applying:

  Add a Kconfig entry to set the maximum number of vCPUs per KVM guest and
  set the default value to 4096 when MAXSMP is enabled, as there are use
  cases that want to create more than the currently allow 1024 vCPUs and
  are more than happy to eat the memory overhead.

  The Hyper-V TLFS doesn't allow more than 64 sparse banks, i.e. allows a
  maximum of 4096 virtual CPUs. Cap KVM's maximum number of virtual CPUs
  to 4096 to avoid exceeding Hyper-V's limit as KVM support for Hyper-V is
  unconditional, and alternatives like dynamically disabling Hyper-V
  enlightenments that rely on sparse banks would require non-trivial code
  changes.

> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
> v2 -> v3: Default KVM_MAX_VCPUS to 1024 when CONFIG_KVM_MAX_NR_VCPUS is not
> defined. This prevents build failures in arch/x86/events/intel/core.c and
> drivers/vfio/vfio_main.c when KVM is disabled.
> 
>  arch/x86/include/asm/kvm_host.h |  4 ++++
>  arch/x86/kvm/Kconfig            | 11 +++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 3bc146dfd38d..cd27e0a00765 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -39,7 +39,11 @@
>  
>  #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
>  

And another thing I'll add if you don't object is a comment to explain that this
is purely to play nice with CONFIG_KVM=n.  And FWIW, I hope to make this go away
entirely: https://lore.kernel.org/all/20230916003118.2540661-27-seanjc@google.com

/*
 * CONFIG_KVM_MAX_NR_VCPUS is defined iff CONFIG_KVM!=n, provide a dummy max if
 * KVM is disabled (arbitrarily use default from CONFIG_KVM_MAX_NR_VCPUS).
 */ 

> +#ifdef CONFIG_KVM_MAX_NR_VCPUS
> +#define KVM_MAX_VCPUS CONFIG_KVM_MAX_NR_VCPUS
> +#else
>  #define KVM_MAX_VCPUS 1024
> +#endif
>  
>  /*
>   * In x86, the VCPU ID corresponds to the APIC ID, and APIC IDs
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 89ca7f4c1464..e730e8255e22 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -141,4 +141,15 @@ config KVM_XEN
>  config KVM_EXTERNAL_WRITE_TRACKING
>  	bool
>  
> +config KVM_MAX_NR_VCPUS
> +	int "Maximum number of vCPUs per KVM guest"
> +	depends on KVM
> +	range 1024 4096
> +	default 4096 if MAXSMP
> +	default 1024
> +	help
> +	  Set the maximum number of vCPUs per KVM guest. Larger values will increase
> +	  the memory footprint of each KVM guest, regardless of how many vCPUs are
> +	  configured.

Last nit, I think the last linke should be like so:

       the memory footprint of each KVM guest, regardless of how many vCPUs are
       created for a given VM.

No need for a v4 unless you object to any of the above, I'm happt to fixup when
applying.
