Return-Path: <linux-kernel+bounces-48004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B571B84561D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4C11F27EAC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F18E15CD52;
	Thu,  1 Feb 2024 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+4pRo2H"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98615B977
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706786460; cv=none; b=hD6XdkdGxZrr9iIt42rujCFEEdbiUwFr8w1W1k2VxaDibPClG19R9nDHvyWjKgtFsL/pYFOHMOGKVzxk5dnRe8KWoqoVLkOttwjSg5Bzf27kyG0oWi46QD6lFF8P4+Q9gIlzbDYdj9xdnxmssxMrHbe3L3LZl6QfcjbMmGVpug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706786460; c=relaxed/simple;
	bh=Ax9q6XdL8l3da+gxb5wqLwZfnS4ZPMgqFPPKuBivo04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwB1gx8RVf7y2AgbD6TAUPSXKKMLMrloBIz1eyx/7qlusdTDvfJkh+1EUAdH+iLGyhjNAcf1VMYO2iZRvAf5jiDyHWYoSJPbm69oXa9g2d/GelkCHcTOdnY/dGBQoqD9oizwS9F18pil4Tbusba/Nzn1KXET63wkXZILKv1Z+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+4pRo2H; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-428405a0205so251651cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 03:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706786458; x=1707391258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fqzrZh/phrQ2srQm2BnmFIw+lB3QB2LYN941NxOH46g=;
        b=C+4pRo2HcAnJaDdpwWj7ejlONPX3+e6214GlefReuASF2252AZ9/tpUMrDjBOXQrX9
         QmKxes7XdJ37+YFR0ZXFpr5ck3kaeIku5SIXkIEXENOwyp1MLnkenr1mYmMk18C3rBkh
         1v5wsf3KnSkFseCVnb0h5b/3so8QFyhRbof7qLu5CE2vT5lu1NsL5GjjPFdqvgpsGHyy
         ASmLA7SyZbyaU6BomKxknqcqMraYLBpEINcypJTLfLVYxQb0Lzkl499cjy27WtV99jla
         rhYUWnkLtxI2sBljYo7ecii5UyLrytbuMrEgkarHIcJi7FX4U9o6OKc1fAqK93/wu7BN
         6bmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706786458; x=1707391258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqzrZh/phrQ2srQm2BnmFIw+lB3QB2LYN941NxOH46g=;
        b=xRFMKNLy8ovvNW4cfDRBOgjtiH+YiaMTvCLWCwoJdgAvxFBXduCyta89CmnH58Mcih
         RXJjWJOhHXoQa8P/pBqyh8QE7VdncRskdlrPU4tYhU2FJoRDS08ilTngAPZYCQh7WOzt
         hg6VzR1lSse/xV3oqi9WX+leonKCcmnlvzAHIK0UbUkAirOE4mFdw3FElGU9smXLLNsV
         /zYLcbyj+p0Azcgu7twqyzoGbiOGxaY35f1qDuVbOB+Bb0jX6AqFfPfc7ASzODnDLxz3
         dks7+Wf/kR5aKQyBYoEw2Ahug5eDm4glnKpQpGO12u/pTjbQdrJ1v0d5xPQXFwhclY4V
         j2CQ==
X-Gm-Message-State: AOJu0YwLJOQT0hxN6UK/e/3O97gARDYKL5nEYrnl4lPcpPOF5SEsX7UF
	8LL8ozvZm4beUdNT6k4uEpzLPgklJzdYvxXvNqqkXfrRiQKOsyT2aKVT/4ALaQ==
X-Google-Smtp-Source: AGHT+IFvcoacZcqmKjVlcfvGKTUBeXwJNujhqrCXdRQ1KCKeKplLNH4V2pWPkKaOWPM/NS3weOopUQ==
X-Received: by 2002:a05:622a:a092:b0:42b:e315:7ccc with SMTP id jv18-20020a05622aa09200b0042be3157cccmr179396qtb.3.1706786457784;
        Thu, 01 Feb 2024 03:20:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU0wMEaqr74OBV3IHDIugd73kg2KetkRS38VGng+OIGRFCMvNEaekrFtURewaeEdG1F+u9/Dgblys1sQbiYMbf0aQ721uWy38FP0H3tS52Lll7Nnd6MzgPnoTkvCvwSFjyMZfDB+tqeouwk4ZabKh3wxFG2TdnVOgVN36+uHAfY2lrDw86DWsq0szNB2c0Z88GfYVP3UvNpfImSbsrnQk4ZtHneNxIVlTFIVZjuazK2tPnU/mUzMyY2bDGXC7cCmbnq9z5QyHZCmR4tct3UW5Ob1HmPjsdefDb9lHvU1u7X47hqi903Ur/iknc83B+y0sRAb+Nk9xBK/7wZ+CjoUCiFO8fFqK+HoCqF7qh7f7NpajjOvppdHZVfdaocn45UkvEqLwIIPKuykdNqtIfGKrTU6L3sUDmSC+K6z69OwNWqiGezCWTITsE9hiskswGIKfHkyMD98Y1frCYc+9ScqnwGMgqzbigCvpCJthk9nFW+zUdzQ5xjlitPeTAq2rmJUuw=
Received: from google.com (161.126.77.34.bc.googleusercontent.com. [34.77.126.161])
        by smtp.gmail.com with ESMTPSA id d1-20020a814f01000000b0060406f89705sm1031527ywb.144.2024.02.01.03.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 03:20:57 -0800 (PST)
Date: Thu, 1 Feb 2024 11:20:53 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: will@kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
	mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	vdonnefort@google.com, qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v4 02/10] KVM: arm64: Add ptdump registration with
 debugfs for the stage-2 pagetables
Message-ID: <Zbt-leieTD64ZefR@google.com>
References: <20231218135859.2513568-2-sebastianene@google.com>
 <20231218135859.2513568-4-sebastianene@google.com>
 <ZYSAfORj2-cXo5t_@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYSAfORj2-cXo5t_@linux.dev>

On Thu, Dec 21, 2023 at 06:14:20PM +0000, Oliver Upton wrote:

Hi Oliver,

I am planning to split the series based on your suggestion and I
wanted to make sure that I understand your feedback.

> On Mon, Dec 18, 2023 at 01:58:52PM +0000, Sebastian Ene wrote:
> > +config PTDUMP_STAGE2_DEBUGFS
> > +       bool "Present the stage-2 pagetables to debugfs"
> > +       depends on PTDUMP_DEBUGFS && KVM
> > +       default n
> > +       help
> > +         Say Y here if you want to show the stage-2 kernel pagetables
> > +         layout in a debugfs file. This information is only useful for kernel developers
> > +         who are working in architecture specific areas of the kernel.
> > +         It is probably not a good idea to enable this feature in a production
> > +         kernel.
> 
> It isn't really a good idea to mount debugfs at all in a production
> system. There are already plenty worse interfaces lurking in that
> filesystem. The pKVM portions already depend on CONFIG_NVHE_EL2_DEBUG,
> so I don't see a need for this Kconfig option.
> 

I created a separate option because I wanted to re-use the parsing
functionality from the already existing ptdump code for EL1. This option
is turned off in production and only enabled for debug.

I was thinking to make use of the `CONFIG_NVHE_EL2_DEBUG` but then I abandoned 
this ideea as one can use ptdump for vHE as well.

> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index e5f75f1f1..ee8d7cb67 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -40,6 +40,7 @@
> >  #include <asm/kvm_pkvm.h>
> >  #include <asm/kvm_emulate.h>
> >  #include <asm/sections.h>
> > +#include <kvm_ptdump.h>
> >  
> >  #include <kvm/arm_hypercalls.h>
> >  #include <kvm/arm_pmu.h>
> > @@ -2592,6 +2593,7 @@ static __init int kvm_arm_init(void)
> >  	if (err)
> >  		goto out_subs;
> >  
> > +	kvm_ptdump_register_host();
> >  	kvm_arm_initialised = true;
> >  
> >  	return 0;
> > diff --git a/arch/arm64/kvm/kvm_ptdump.h b/arch/arm64/kvm/kvm_ptdump.h
> > new file mode 100644
> > index 000000000..98b595ce8
> > --- /dev/null
> > +++ b/arch/arm64/kvm/kvm_ptdump.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +//
> > +// Copyright (C) Google, 2023
> > +// Author: Sebastian Ene <sebastianene@google.com>
> 
> You've got the comment styles backwards for these. The SPDX license uses
> the 'C++' style comment (//), whereas your multiline comment should always
> use a 'C' style comment (/* */).
>

Let me fix this, thanks.

> > +struct kvm_ptdump_register {
> > +	void *(*get_ptdump_info)(struct kvm_ptdump_register *reg);
> > +	void (*put_ptdump_info)(void *priv);
> > +	int (*show_ptdump_info)(struct seq_file *m, void *v);
> > +	void *priv;
> > +};
> 
> Please thoroughly consider the necessity of this. You're wrapping a
> callback structure with yet another callback structure. IMO, it would
> make a lot more sense to implement the file ops structure for every
> walker variant you need and avoid the indirection, it's hard to
> understand.
>

I think we can drop this and have different file_ops.

> > +void kvm_ptdump_register_host(void)
> > +{
> > +	if (!is_protected_kvm_enabled())
> > +		return;
> > +
> > +	kvm_ptdump_debugfs_register(&host_reg, "host_page_tables",
> > +				    kvm_debugfs_dir);
> > +}
> > +
> > +static int __init kvm_host_ptdump_init(void)
> > +{
> > +	host_reg.priv = (void *)host_s2_pgtable_pages();
> > +	return 0;
> > +}
> > +
> > +device_initcall(kvm_host_ptdump_init);
> 
> Why can't all of this be called from finalize_pkvm()?
> 

I guess it can be called from finalize_pkvm before the is_protected_kvm_enabled
check. This should work for nvhe & vhe as well.

Thanks,
Seb

> > -- 
> > 2.43.0.472.g3155946c3a-goog
> > 
> 
> -- 
> Thanks,
> Oliver

