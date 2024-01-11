Return-Path: <linux-kernel+bounces-23365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1742182ABA9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA942285373
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47BE1426C;
	Thu, 11 Jan 2024 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhZcfqHi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4F13FF4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704967998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldnyq6EPpzLG7h736KFOi2wOevyG8A+Ngm+5TTm+rYA=;
	b=OhZcfqHiB9JpXLTv7B1/s183jxPhavg8o+V98x1gkBxdG1jh6S8Xuo4tk767+yHPJ0JAFy
	+6eON5l0CHAkp8zdJgzLTGxASw0i5Gqxh+ZcqYGcon3WhxK8K5nxWMFbW2zrJpUJbX+4iL
	Hu4lo/aWzs6q8BTCwpg3V5NfAw7B/9Q=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-ZrPOiMQeOb6VVRJQxbglWw-1; Thu, 11 Jan 2024 05:13:16 -0500
X-MC-Unique: ZrPOiMQeOb6VVRJQxbglWw-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4b72368af77so879578e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704967996; x=1705572796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ldnyq6EPpzLG7h736KFOi2wOevyG8A+Ngm+5TTm+rYA=;
        b=uJedvdEFI2W9aBKtL5c7bzVyzn71hOQSMBaSCg8aiUyC4QSJfszwEkfdmeOezCb8ZO
         5vGHKFP1SEyjPYhB3ve6gQNl3KAP0esttKaA/H3g3Hr2UeX/+5UABHYZdv6NMc89YKoS
         +WnpzSwbhjFcaaScf/HwzvJ72aOt5chL9LInfQBcknPHdwOH8DvswqYPn2d+kGbw5gle
         TbCfJdk70qyunh6WUryFLF6oyo8kCzyYMmD1aCimv/gsw06vmhcE2eAcuCh2+Q7uqy3c
         OXNyQpvcRx9K0yMLmUx1YjFwr6WLw/sD6qMLuJiWHxwOU8owx6avjjdUvt80fyL5rzB6
         VOZw==
X-Gm-Message-State: AOJu0Yy/V28M1W9NxHgRYmLeF+NRmRGikIxCXQtluSTCL/Zx1e8nbHRI
	O1o6544hP0E+cUFXma8hlcUuZJ3VZNSTAujgD1AJVkTjA9e3UVNUWzncP4iHgGB/9X/CAqujilh
	tMQw1XV/E6UD6bBBCpR6fhbdN6gpq6wz7mN3ko83nguyLIhPJ
X-Received: by 2002:ac5:c1c7:0:b0:4b7:440f:604e with SMTP id g7-20020ac5c1c7000000b004b7440f604emr114149vkk.25.1704967996351;
        Thu, 11 Jan 2024 02:13:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQveUhpuYoemuVfCSD5ZoMn1XJr7GEhpzsdWjfgve6dVnamtFz3DAV4pWDKDfFXCRuidGoxe7giOqFtU6JTMQ=
X-Received: by 2002:ac5:c1c7:0:b0:4b7:440f:604e with SMTP id
 g7-20020ac5c1c7000000b004b7440f604emr114139vkk.25.1704967996098; Thu, 11 Jan
 2024 02:13:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110002340.485595-1-seanjc@google.com>
In-Reply-To: <20240110002340.485595-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Jan 2024 11:13:04 +0100
Message-ID: <CABgObfYqDsFGf4nm_g9Kfbe7heupnLLDWRsnrhh=LNSjFAmqmQ@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: Add a VMX flag to enumerate 5-level EPT support
 to userspace
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yi Lai <yi1.lai@intel.com>, 
	Tao Su <tao1.su@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 1:23=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> Add a VMX flag in /proc/cpuinfo, ept_5level, so that userspace can query
> whether or not the CPU supports 5-level EPT paging.

I think this is a good idea independent of the selftests issue.

For selftests, we could get similar info from the feature MSR
mechanism, i.e. KVM_GET_MSRS(MSR_IA32_VMX_EPT_VPID_CAP), but only on
Intel and only if nested virtualization is enabled, so that's
inferior.

A better idea for selftests is to add a new KVM_CAP_PHYS_ADDR_SIZE,
which could be implemented by all architectures and especially by both
x86 vendors. However, I am not sure for example if different VM types
(read: TDX?) could have different maximum physical addresses, and that
would have to be taken into consideration when designing the API.

Paolo

> tip-tree folks, this is obviously not technically KVM code, but I'd like =
to
> take this through the KVM tree so that we can use the information to fix
> KVM selftests (hopefully this cycle).
>
>  arch/x86/include/asm/vmxfeatures.h | 1 +
>  arch/x86/kernel/cpu/feat_ctl.c     | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/arch/x86/include/asm/vmxfeatures.h b/arch/x86/include/asm/vm=
xfeatures.h
> index c6a7eed03914..266daf5b5b84 100644
> --- a/arch/x86/include/asm/vmxfeatures.h
> +++ b/arch/x86/include/asm/vmxfeatures.h
> @@ -25,6 +25,7 @@
>  #define VMX_FEATURE_EPT_EXECUTE_ONLY   ( 0*32+ 17) /* "ept_x_only" EPT e=
ntries can be execute only */
>  #define VMX_FEATURE_EPT_AD             ( 0*32+ 18) /* EPT Accessed/Dirty=
 bits */
>  #define VMX_FEATURE_EPT_1GB            ( 0*32+ 19) /* 1GB EPT pages */
> +#define VMX_FEATURE_EPT_5LEVEL         ( 0*32+ 20) /* 5-level EPT paging=
 */
>
>  /* Aggregated APIC features 24-27 */
>  #define VMX_FEATURE_FLEXPRIORITY       ( 0*32+ 24) /* TPR shadow + virt =
APIC */
> diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ct=
l.c
> index 03851240c3e3..1640ae76548f 100644
> --- a/arch/x86/kernel/cpu/feat_ctl.c
> +++ b/arch/x86/kernel/cpu/feat_ctl.c
> @@ -72,6 +72,8 @@ static void init_vmx_capabilities(struct cpuinfo_x86 *c=
)
>                 c->vmx_capability[MISC_FEATURES] |=3D VMX_F(EPT_AD);
>         if (ept & VMX_EPT_1GB_PAGE_BIT)
>                 c->vmx_capability[MISC_FEATURES] |=3D VMX_F(EPT_1GB);
> +       if (ept & VMX_EPT_PAGE_WALK_5_BIT)
> +               c->vmx_capability[MISC_FEATURES] |=3D VMX_F(EPT_5LEVEL);
>
>         /* Synthetic APIC features that are aggregates of multiple featur=
es. */
>         if ((c->vmx_capability[PRIMARY_CTLS] & VMX_F(VIRTUAL_TPR)) &&
>
> base-commit: 1c6d984f523f67ecfad1083bb04c55d91977bb15
> --
> 2.43.0.472.g3155946c3a-goog


