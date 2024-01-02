Return-Path: <linux-kernel+bounces-14937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092898224B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A053283A5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D054B1803A;
	Tue,  2 Jan 2024 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO3Oyjwh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CB818030
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704234330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5R/jtTW84OX0RSh5nyVXqIswewgE+KuxBYp1xxey84s=;
	b=YO3Oyjwh1iOE2kkrHDWrjGMJwLEeQYRBaVuxPrS1oEpHiLmKSyk6dji3dIBgHKIcMGHe1f
	TXgRKgfuqCo1zoAnptdSw8eCjB7vE/eMBPwGmc3Lp+L94whz2Glu74M3VtFFrrLR56TKPw
	MWq38D6M31ljxuFbdDA9zY4e6WDVa84=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645--Ay9a9OsPAG6uk40tPWgHA-1; Tue, 02 Jan 2024 17:25:29 -0500
X-MC-Unique: -Ay9a9OsPAG6uk40tPWgHA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3368abe10c5so6793821f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704234328; x=1704839128;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5R/jtTW84OX0RSh5nyVXqIswewgE+KuxBYp1xxey84s=;
        b=DGTYjup0NueF5ZusmUIHTAT6SpioaMFtdG7FE5aAI7S/X1Iq2DpjFNVOtu6J93d9wZ
         uq+zEjk6IZCyT9jJBPg8DVVpY/CErJpgjJKCMb+1LuDLXUpLLENhJ4cggpdkDA/Bmo1M
         yRwyIzQ3z8/r5RYmO6iynvTix6px7zHfjdg8F+pRBqjocIvKF/igbIZJfDtsyY5Zmv7m
         PT3uF3otmtV762hA1fcJSJFaQt3IlFoDCdRsV/CBcH4OSQpwTsXl2KD4gB/eD4Ho8h/K
         YiMDk+zzNVQwe4RWqVJBuuVuuq/D63Jal4qX/kpVATtWBxtf5uAhn8nDDQ+iHPXtLnEF
         lEJg==
X-Gm-Message-State: AOJu0YyVynbcN0hpQsKq3G14l/1zFvnYyKoMcucQQ22QoY9NY1AeXM6H
	Q07bQrJH1JvGQ72fHYln5YQ/6YHOYRrrvLLaBIooFmzPWOqzvyTi9Mki5W9RPIJrShNBjdnu2fu
	WyG6n9eaU9ApRX2HAQhVcR7mCf9amzqQv
X-Received: by 2002:a05:600c:4ecc:b0:40d:8795:f773 with SMTP id g12-20020a05600c4ecc00b0040d8795f773mr1425545wmq.46.1704234328395;
        Tue, 02 Jan 2024 14:25:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsd1McnJkcymNMgMhuVTtjlMTFLKYIxe3mUYlG4YCd6FOI6xXIrbVLMeFGFsFDLv/Q+AVkTw==
X-Received: by 2002:a05:600c:4ecc:b0:40d:8795:f773 with SMTP id g12-20020a05600c4ecc00b0040d8795f773mr1425542wmq.46.1704234328068;
        Tue, 02 Jan 2024 14:25:28 -0800 (PST)
Received: from starship ([147.235.223.38])
        by smtp.gmail.com with ESMTPSA id jb18-20020a05600c54f200b0040d3dc78003sm316298wmb.17.2024.01.02.14.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:25:27 -0800 (PST)
Message-ID: <ff50b8907eb6aa475b4572f6ec03355cb0d3d2a9.camel@redhat.com>
Subject: Re: [PATCH v8 04/26] x86/fpu/xstate: Introduce
 XFEATURE_MASK_KERNEL_DYNAMIC xfeature set
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com, 
	pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, chao.gao@intel.com, rick.p.edgecombe@intel.com, 
	john.allen@amd.com
Date: Wed, 03 Jan 2024 00:25:26 +0200
In-Reply-To: <20231221140239.4349-5-weijiang.yang@intel.com>
References: <20231221140239.4349-1-weijiang.yang@intel.com>
	 <20231221140239.4349-5-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2023-12-21 at 09:02 -0500, Yang Weijiang wrote:
> Define a new XFEATURE_MASK_KERNEL_DYNAMIC mask to specify the features
> that can be optionally enabled by kernel components. This is similar to
> XFEATURE_MASK_USER_DYNAMIC in that it contains optional xfeatures that
> can allows the FPU buffer to be dynamically sized. The difference is that
> the KERNEL variant contains supervisor features and will be enabled by
> kernel components that need them, and not directly by the user. Currently
> it's used by KVM to configure guest dedicated fpstate for calculating
> the xfeature and fpstate storage size etc.
> 
> The kernel dynamic xfeatures now only contain XFEATURE_CET_KERNEL, which
> is supported by host as they're enabled in kernel XSS MSR setting but
> relevant CPU feature, i.e., supervisor shadow stack, is not enabled in
> host kernel therefore it can be omitted for normal fpstate by default.
> 
> Remove the kernel dynamic feature from fpu_kernel_cfg.default_features
> so that the bits in xstate_bv and xcomp_bv are cleared and xsaves/xrstors
> can be optimized by HW for normal fpstate.
> 
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/asm/fpu/xstate.h | 5 ++++-
>  arch/x86/kernel/fpu/xstate.c      | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index 3b4a038d3c57..a212d3851429 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -46,9 +46,12 @@
>  #define XFEATURE_MASK_USER_RESTORE	\
>  	(XFEATURE_MASK_USER_SUPPORTED & ~XFEATURE_MASK_PKRU)
>  
> -/* Features which are dynamically enabled for a process on request */
> +/* Features which are dynamically enabled per userspace request */
>  #define XFEATURE_MASK_USER_DYNAMIC	XFEATURE_MASK_XTILE_DATA
>  
> +/* Features which are dynamically enabled per kernel side request */
> +#define XFEATURE_MASK_KERNEL_DYNAMIC	XFEATURE_MASK_CET_KERNEL
> +
>  /* All currently supported supervisor features */
>  #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID | \
>  					    XFEATURE_MASK_CET_USER | \
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 03e166a87d61..ca4b83c142eb 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -824,6 +824,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
>  	/* Clean out dynamic features from default */
>  	fpu_kernel_cfg.default_features = fpu_kernel_cfg.max_features;
>  	fpu_kernel_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
> +	fpu_kernel_cfg.default_features &= ~XFEATURE_MASK_KERNEL_DYNAMIC;
>  
>  	fpu_user_cfg.default_features = fpu_user_cfg.max_features;
>  	fpu_user_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;


I still think that we should consider adding XFEATURE_MASK_CET_KERNEL to
XFEATURE_MASK_INDEPENDENT or at least have a good conversation on why this doesn't make sense,
but I also don't intend to fight over this, as long as the code works.

Best regards,
	Maxim Levitsky


