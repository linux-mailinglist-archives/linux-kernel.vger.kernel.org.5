Return-Path: <linux-kernel+bounces-118277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557C888B72E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879B71C38A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234DA5A119;
	Tue, 26 Mar 2024 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lhw57AEB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C0C4E1A2;
	Tue, 26 Mar 2024 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711418488; cv=none; b=mlfoy4RKRAxs4U+9P8T5Pf1WWG/DrfaAhhwrLrHvFatIoKNRO+y367y8fw4hlX2PibA9R2xufgnpZI4N3kfhuk6lNkXVgzphmHOa1Wm7n2ng8Sw4g6SrOZq6tHvZW/ATozYJ9yTrt1XOfbt6hDH8WhUDztiLX79gGTwBOTiANPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711418488; c=relaxed/simple;
	bh=MF9ovmrIg6e8IQIMkwaYLFqAcxexDC3fSt0fm0vWIc4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=b/BFF/gY99v+1+T2d4mIUbUsWitjPom1cu/Ph7PUl/Jan9WJCU8mILUA31hUSBk7lZiXQJGAj+m3+igau7kB/Kv6jOOhdZ83lv9WaujFPxjVvJUN82ddE60i+LA53+GnFfIiGcX3NgzsxZXPAO05+ffZ1ZwTZEmOqN+8AhQo9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lhw57AEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E47C433C7;
	Tue, 26 Mar 2024 02:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711418487;
	bh=MF9ovmrIg6e8IQIMkwaYLFqAcxexDC3fSt0fm0vWIc4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Lhw57AEBPxbjD9GL0sYfWTtjr9JPLANVwg5Yz1VhBT/S50e2etFPWxhogAEkIOW7w
	 c4trvVg5EzC3Xng1V19j2Dm9Yvs33knBUrCaRLqlKh5lpCKfiSULRnnfK970su7Qqa
	 W/VlNom4Hf+B+NR3A8gZ5pDfJuvrir5CEOuQVEhvMxh/DHply97ElQUI2qaCFvjXxH
	 v69BQSz8BF6/g/XGpOUqx7Wlwxz2dSU8gNRRBmcYWDH0/acsGQLVPhwpDs0EIXacI+
	 n1PHMW9iMhAtQfL24uHs7U5cspXL0IC8tZrffj/YxQzXR8I/J0VlMxyYuEnr5XaqI4
	 tqMgvIYyYUWiQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 04:01:23 +0200
Message-Id: <D03B7XJYRFC1.2L3I2TO5HNQD3@kernel.org>
Cc: <linux-riscv@lists.infradead.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>, <linux-modules@vger.kernel.org>, "Naveen
 N . Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 1/2] kprobes: textmem API
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Masami Hiramatsu"
 <mhiramat@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240325215502.660-1-jarkko@kernel.org>
 <20240326095836.f43d259b7747269a7c0b9d23@kernel.org>
 <D03AL7A5G3M2.3UK4ASWILGBJS@kernel.org>
In-Reply-To: <D03AL7A5G3M2.3UK4ASWILGBJS@kernel.org>

On Tue Mar 26, 2024 at 3:31 AM EET, Jarkko Sakkinen wrote:
> > > +#endif /* _LINUX_EXECMEM_H */
> > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > index 9d9095e81792..87fd8c14a938 100644
> > > --- a/kernel/kprobes.c
> > > +++ b/kernel/kprobes.c
> > > @@ -44,6 +44,7 @@
> > >  #include <asm/cacheflush.h>
> > >  #include <asm/errno.h>
> > >  #include <linux/uaccess.h>
> > > +#include <linux/execmem.h>
> > > =20
> > >  #define KPROBE_HASH_BITS 6
> > >  #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
> > > @@ -113,17 +114,17 @@ enum kprobe_slot_state {
> > >  void __weak *alloc_insn_page(void)
> > >  {
> > >  	/*
> > > -	 * Use module_alloc() so this page is within +/- 2GB of where the
> > > +	 * Use alloc_execmem() so this page is within +/- 2GB of where the
> > >  	 * kernel image and loaded module images reside. This is required
> > >  	 * for most of the architectures.
> > >  	 * (e.g. x86-64 needs this to handle the %rip-relative fixups.)
> > >  	 */
> > > -	return module_alloc(PAGE_SIZE);
> > > +	return alloc_execmem(PAGE_SIZE, GFP_KERNEL);
> > >  }
> > > =20
> > >  static void free_insn_page(void *page)
> > >  {
> > > -	module_memfree(page);
> > > +	free_execmem(page);
> > >  }
> > > =20
> > >  struct kprobe_insn_cache kprobe_insn_slots =3D {
> > > @@ -1580,6 +1581,7 @@ static int check_kprobe_address_safe(struct kpr=
obe *p,
> > >  		goto out;
> > >  	}
> > > =20
> > > +#ifdef CONFIG_MODULES
> >
> > You don't need this block, because these APIs have dummy functions.
>
> Hmm... I'll verify this tomorrow.

It depends on having struct module available given "(*probed_mod)->state".

It is non-existent unless CONFIG_MODULES is set given how things are
flagged in include/linux/module.h.

BR, Jarkko

