Return-Path: <linux-kernel+bounces-52993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F197849F3F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38E3282FA1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7713A27E;
	Mon,  5 Feb 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4r0uvxH"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505533CDB
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149128; cv=none; b=l7KU+Hy/uceMgDJ4Mq78Va5fQFZpXpjVObT7qBqAITsiiH/ORqGtCBB6UsBRY09jYb+WiCRitFIL+3F98QjDYag3EEuWBjzIfwLnabh7l6cjSXVA8vfEKAv3O/5AdnC/7wfN7ijS39sdGbT4N5VmxDPeXq5rZVUfYEMdOmvDLY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149128; c=relaxed/simple;
	bh=NuQZpRiWrPYNbtok44uV0c5QL3pOiTiUKf8wXxbmRZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6YfH/CqTIeQbyFtQK3LptcH6NobUlWnDp27xlc0Yf2Vx44YGVlWdgIUWKE8rCJJPGQxL/foqu3AJl3ZmSeZqfJZ/r/NPXYZ+Y+jBNpN0keq+od9losI+Sv1/e8VjHwDAEe0sCS+JHs5AvcvMgSq1nxiDme7gT7K/CHd0dcQZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S4r0uvxH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fd15fe6a8so75045e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 08:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707149124; x=1707753924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYZyNjIxlDFPhWyjksZUxS6xmnfxwnVZbORSM0gvtHE=;
        b=S4r0uvxH7N4CShH7d/GQ1sH8oVj1zNIqz3aALePMDH0LqIm1dvW5Uk1xaT0OkZGpk9
         IIupQRkB9AgUQklijdC9h7aUToBm7DUgl5jmawQTLhXQY3yHtD8EWXRPA+bppIkQG9eS
         TWrB27QjHHuDjAaRHtp4qK/DCajVPlvObsuNTycz9V83u4BI/TR10maSTdAaDFQzojE1
         zXnaZ0FHwI+GpMZN0KRxS+D9WnRDnOFqwjNTav59xj4UoVf3ljMoL6/OW4BkIpl+YGnD
         bMM+HWY9oX+umgmxIk+H6pu07gsgJPdtaDmzOYUMn1+7Clk7XZ7aS7vtPK7N1gMEJW+X
         W6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149124; x=1707753924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYZyNjIxlDFPhWyjksZUxS6xmnfxwnVZbORSM0gvtHE=;
        b=pa6DDm8nOmTwpXrL3mNygMgI6qowc3ptA7ZOij+VzUvFfRHznzjrV8gPGvLzycaYQb
         I8PFQSuLQQWgopiZiGTQ/ubBADCcwcNvAOuPboyrk5EJxIwKSFiuIIDSp/o0XjCb9IJZ
         PmrQLjuWUz81eaBrk+6l5iIZ1BO1OP9+ADnsvTyy9JFgt9pInfJubx3UP3RAWawKX6T8
         TNVqzs43N5POTtcwm+LYi/fbtPOF741ADYquMenHFa6yRwEyXdafmxo4mtivYyO2pmOq
         hiEsUCssOfkrm1vQYmja0BbD77zw3M2qv3pzLgy0/9DSHKG84hc8G8P1dm1qkzhEXUA3
         h6mA==
X-Gm-Message-State: AOJu0YwI/BXhg1F+Va1sVZPpfaTCGooS0OxDgYgjbFEJeyOKwUdVFE0a
	skZM573o/TCCUQjLngtp/NRegvxs7CzNjadwn34CqdGr0oVc5aLmtgwH3prbWQ==
X-Google-Smtp-Source: AGHT+IFbUog5YW+R34dfZwqpeAWaXbXS7kqTE+M1tcTJHXAI7hpcjA6iAanTUc4hznRPTVUGW1SHQQ==
X-Received: by 2002:a05:600c:5187:b0:40f:dd8f:152c with SMTP id fa7-20020a05600c518700b0040fdd8f152cmr113764wmb.4.1707149123951;
        Mon, 05 Feb 2024 08:05:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXeaO7j728zekDuQdzDKwJj2UOXOnTcpuMyB6C4+Q/i3YYe48qy8m5wOt1VAn4vSM36Of0JOYedLRDhCezQCi9WSzqvziZN9Mcz+RWLUtL0W8QqzxtnX04pfT9/tnXCV5gCJ/M4fiV+bkF8tx6qEmYqYNNFRnYaJg0H/jhAb/3EHAidNkEd5nIvEaOQ7b1cGd+IoqPAyayKCaa5VABEicjCg3Asnx1c7M14Ut0q8OOJUaXZ/u06rAKoDL6pohqagXPpCy2OtI8wR4UbRVo08w7sWzp41yLno0GCkQvP3UtkEXhdMBixOShYUnV4lxo2iw53PjjnwyhKHlMW42EQOoDmLgXrDZc1w9M4ehA0O2RYTsLi+SBRkvuXnLbBPQrnIktEGrdaxCl7YDZUHlF3Ba5yuOqDtG1fGi0RruYyz1hh/DMCoXh1eOlrjOgq0cqoRZPLv5IJwUgjHnZaJM4G23i2rfovFO6ruRQNeXxm8m96KGETgu0gU89j23IBhUo801E=
Received: from google.com (161.126.77.34.bc.googleusercontent.com. [34.77.126.161])
        by smtp.gmail.com with ESMTPSA id w15-20020a05600c474f00b0040fc26183e8sm259274wmo.8.2024.02.05.08.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:05:23 -0800 (PST)
Date: Mon, 5 Feb 2024 16:05:21 +0000
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
Message-ID: <ZcEHQSFx4gNh4yMm@google.com>
References: <20231218135859.2513568-2-sebastianene@google.com>
 <20231218135859.2513568-4-sebastianene@google.com>
 <ZYSAfORj2-cXo5t_@linux.dev>
 <Zbt-leieTD64ZefR@google.com>
 <ZcDfM2VRiTETM04I@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcDfM2VRiTETM04I@linux.dev>

On Mon, Feb 05, 2024 at 01:14:27PM +0000, Oliver Upton wrote:
> On Thu, Feb 01, 2024 at 11:20:53AM +0000, Sebastian Ene wrote:
> > On Thu, Dec 21, 2023 at 06:14:20PM +0000, Oliver Upton wrote:
> > 
> > Hi Oliver,
> > 
> > I am planning to split the series based on your suggestion and I
> > wanted to make sure that I understand your feedback.
> > 
> > > On Mon, Dec 18, 2023 at 01:58:52PM +0000, Sebastian Ene wrote:
> > > > +config PTDUMP_STAGE2_DEBUGFS
> > > > +       bool "Present the stage-2 pagetables to debugfs"
> > > > +       depends on PTDUMP_DEBUGFS && KVM
> > > > +       default n
> > > > +       help
> > > > +         Say Y here if you want to show the stage-2 kernel pagetables
> > > > +         layout in a debugfs file. This information is only useful for kernel developers
> > > > +         who are working in architecture specific areas of the kernel.
> > > > +         It is probably not a good idea to enable this feature in a production
> > > > +         kernel.
> > > 
> > > It isn't really a good idea to mount debugfs at all in a production
> > > system. There are already plenty worse interfaces lurking in that
> > > filesystem. The pKVM portions already depend on CONFIG_NVHE_EL2_DEBUG,
> > > so I don't see a need for this Kconfig option.
> > > 
> > 
> > I created a separate option because I wanted to re-use the parsing
> > functionality from the already existing ptdump code for EL1. This option
> > is turned off in production and only enabled for debug.
> > 
> > I was thinking to make use of the `CONFIG_NVHE_EL2_DEBUG` but then I abandoned 
> > this ideea as one can use ptdump for vHE as well.
> 
> Fair enough. I was going to say we could just have KVM follow
> CONFIG_PTDUMP_DEBUGFS, but it doesn't matter either way.
> 
> > > > +void kvm_ptdump_register_host(void)
> > > > +{
> > > > +	if (!is_protected_kvm_enabled())
> > > > +		return;
> > > > +
> > > > +	kvm_ptdump_debugfs_register(&host_reg, "host_page_tables",
> > > > +				    kvm_debugfs_dir);
> > > > +}
> > > > +
> > > > +static int __init kvm_host_ptdump_init(void)
> > > > +{
> > > > +	host_reg.priv = (void *)host_s2_pgtable_pages();
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +device_initcall(kvm_host_ptdump_init);
> > > 
> > > Why can't all of this be called from finalize_pkvm()?
> > > 
> > 
> > I guess it can be called from finalize_pkvm before the is_protected_kvm_enabled
> > check. This should work for nvhe & vhe as well.
> 
> What does nvhe and vhe modes have to do with it? I thought this was for
> hooking up the host's S2, which does not exist outside protected mode.
> 

True I guess there is no other need for the initialization portion in
this function. I will split the series to address the non-protected
support first.

Thanks,
Seb

> -- 
> Thanks,
> Oliver

