Return-Path: <linux-kernel+bounces-97558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAE7876BE9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CAE4B21F1D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A02F5E094;
	Fri,  8 Mar 2024 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeYY5oGy"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE511D52D;
	Fri,  8 Mar 2024 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930167; cv=none; b=V6GCLxr9yhPvfMhW/B3n6qtCrdIsOTKHgcrTmcGdkzaLfUzKFdq2P8cCbS4RfazcsuuzpeadjcdgMu0nA2Pn+hufkf6iS79fnt5vDPQS+aGdhXrBWUs5NWhIyU9m5J7dbMyev0c9hezO5kJRUuXSs8433mnKC9zlmRP4OfN0ki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930167; c=relaxed/simple;
	bh=2DJgVA5hEWcv6uQ9ADvTEvGHCBiB/9lOyZUdjddNE1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWMTEkJVKtfk/LBQQPIh3ZVJ++W+uNAbYvXfxDyw5S9mNAd+H30wuuyZeXBGAEPCrf1s1RUN9pvrFjPS9hVnx4LXVqFRUjtQf/dy+shXi53hdWq1CLmnvGxwjLuoXWzPQzWj9AiEF7lO4RvfTvf3QjyyXUVEXypyu4AbR2fyl/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeYY5oGy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e62c65865cso2127241b3a.2;
        Fri, 08 Mar 2024 12:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709930165; x=1710534965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5KLgrDjMCRpuO7WBfnDia6NDpj8Onfdt2Teu/Yvj1Oo=;
        b=PeYY5oGyBC1yeeK/Tw/CVQkPLIYXaPkDh0IaWmXvsHxqAINOyKDSrKW7EfQ0pvmjPP
         EX+0NXcOeE2X04OGbOH0Und6s7ONheBF4O49gCRo6qvJm3YZTeQ99SN52/Cnhw0z0uoZ
         /XLtXaA7YlaKQ3D6h43IB/MpoWDRVptYF/WJqQ8myzmwQTIicQ+rXyB7xoOeMhmbOzcj
         M/RnqipAMQbZNnp5ytijQjK9J0mrwwvFUSQN1X/s83JL15fMVO11Eam4MCwYFli1u/62
         7sgUe5kgu26LhjOWM9cdm9bN0lKrVLTAAor9Ro8NOVHMcq/qGsKyXGCSs3oOQbZIseM6
         rbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709930165; x=1710534965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KLgrDjMCRpuO7WBfnDia6NDpj8Onfdt2Teu/Yvj1Oo=;
        b=bt7hB+TKQ9+Xge1k7d+LjbrFq7eLLip0YgyB6DknaNi6PT24BqUegQuCB/gXl4ebcF
         cYDBNcQLrKtiMNHJV9CA+kohNwrNwENfYVFP4kprOlp0l1xFxLpON/lhr6eJ6sWkIe8t
         SXy/y/xB6Gpy3brEtL0Cug+i6T3rAkucdkexrp7Vi27Cj7kuUyK401pCQRfmneEHqPLF
         /1fg8WhOy0eduBM7WqC0KTJWbiQbaJ1hfUFo8Vu2vAx/hl1fRXg6nbZVHbS7EfLwQ8On
         auzN5BEfhFV6NbcBzqgTp1QzqEQtwMsreMHTnfqdqu081izQ8i/nWqm8N2NIiSJ6uTvL
         b2Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXDoKTRN8LvBAAVNpnuwV542No8sWU3mf8Y3512KPbLHmAUhP1ZKBpLvbcA8f+uQVnZHN8pBFO9Y91afDXM7qhd31B7fHQiG/azWd9c0RlR3zPQtakYYjuukY9IYoGrbGAy4uQvnMKyg8wMNYoNoXQogHRxVcAS9HR3GNY0yz/y9Q==
X-Gm-Message-State: AOJu0YzWwdP4GW/BbouVN9rks3tKUWMMjCm/p4OhEKn8pIRTyIjUBTPH
	8lHdWiGY2WfnIdNSy6IOqF2RhVct3riEcAXwXIqsemMeI4dWYi4B
X-Google-Smtp-Source: AGHT+IGPH4hm9U5ivGtNFAgXMPMjIph/C46hT5a647tMtgPEKrAlzMz9Ca/0FZJBDPhbjbwTce6o9Q==
X-Received: by 2002:a05:6a21:3985:b0:1a1:4c8f:fdc0 with SMTP id ad5-20020a056a21398500b001a14c8ffdc0mr101628pzc.43.1709930165026;
        Fri, 08 Mar 2024 12:36:05 -0800 (PST)
Received: from gmail.com ([192.184.166.229])
        by smtp.gmail.com with ESMTPSA id r2-20020aa79ec2000000b006e31f615af6sm114076pfq.17.2024.03.08.12.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 12:36:04 -0800 (PST)
Date: Fri, 8 Mar 2024 12:36:02 -0800
From: Calvin Owens <jcalvinowens@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	David S Miller <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 3/4] kprobes: Allow kprobes with CONFIG_MODULES=n
Message-ID: <Zet2ssRGrOLVqZq-@gmail.com>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
 <2af01251ca21d79fa29092505d192f1f1b746cff.1709676663.git.jcalvinowens@gmail.com>
 <ZelrH2hiUmaomDv2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZelrH2hiUmaomDv2@kernel.org>

On Thursday 03/07 at 09:22 +0200, Mike Rapoport wrote:
> On Wed, Mar 06, 2024 at 12:05:10PM -0800, Calvin Owens wrote:
> > If something like this is merged down the road, it can go in at leisure
> > once the module_alloc change is in: it's a one-way dependency.
> > 
> > Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
> > ---
> >  arch/Kconfig                |  2 +-
> >  kernel/kprobes.c            | 22 ++++++++++++++++++++++
> >  kernel/trace/trace_kprobe.c | 11 +++++++++++
> >  3 files changed, 34 insertions(+), 1 deletion(-)
> 
> When I did this in my last execmem posting, I think I've got slightly less
> ugly ifdery, you may want to take a look at that:
> 
> https://lore.kernel.org/all/20230918072955.2507221-13-rppt@kernel.org

Thanks Mike, I definitely agree. I'm annoyed at myself for not finding
your patches, I spent some time looking for prior work and I really
don't know how I missed it...

> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index cfc24ced16dd..e60ce984d095 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -52,8 +52,8 @@ config GENERIC_ENTRY
> >  
> >  config KPROBES
> >  	bool "Kprobes"
> > -	depends on MODULES
> >  	depends on HAVE_KPROBES
> > +	select MODULE_ALLOC
> >  	select KALLSYMS
> >  	select TASKS_RCU if PREEMPTION
> >  	help
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 9d9095e81792..194270e17d57 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1556,8 +1556,12 @@ static bool is_cfi_preamble_symbol(unsigned long addr)
> >  		str_has_prefix("__pfx_", symbuf);
> >  }
> >  
> > +#if IS_ENABLED(CONFIG_MODULES)
> >  static int check_kprobe_address_safe(struct kprobe *p,
> >  				     struct module **probed_mod)
> > +#else
> > +static int check_kprobe_address_safe(struct kprobe *p)
> > +#endif
> >  {
> >  	int ret;
> >  
> > @@ -1580,6 +1584,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
> >  		goto out;
> >  	}
> >  
> > +#if IS_ENABLED(CONFIG_MODULES)
> 
> Plain #ifdef will do here and below. IS_ENABLED is for usage withing the
> code, like
> 
> 	if (IS_ENABLED(CONFIG_MODULES))
> 		;
> 
> >  	/* Check if 'p' is probing a module. */
> >  	*probed_mod = __module_text_address((unsigned long) p->addr);
> >  	if (*probed_mod) {
> 
> -- 
> Sincerely yours,
> Mike.

