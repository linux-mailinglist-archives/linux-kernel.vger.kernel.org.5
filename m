Return-Path: <linux-kernel+bounces-119048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C205E88C335
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38101C356E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6033870CBA;
	Tue, 26 Mar 2024 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mnj8t6Ox"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2BA71739;
	Tue, 26 Mar 2024 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459106; cv=none; b=VAg2rcgYuAHp3H8tgcDT5L5qXqyXvauzDsgOFsE9vrvrEFBYGyYr3wDLBQNHXRz0mGYsGYv+vs2dX/UgqNc+DnHSZfpOh6JRfUt6xCvW16sq9DPXL93gX/0JL3shHcXNNXJeK619bCLxqu9Lx6F+ZqxXRVmctBkwBi9O+8FwvlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459106; c=relaxed/simple;
	bh=G+Hn6cNlyKUyvTsdLqpYQU3MpaSHBX/VmoCrwmgKiuA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=dX/OToSOveVNJuuphO95+VJ8Igxa6WqeGb90MpOx6uqa2HMj7MjiW7EpzI93G/H1yJr7F8mQWllNXv0RbJs77qSSEf0+khLadUMwhg1OeGgMsuQGC3g7EZ2AVoBQphqh+06xJjTBbXrJE3znHcqr2EbQiWRPE5Jr0NtHiq0PQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mnj8t6Ox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E86C43390;
	Tue, 26 Mar 2024 13:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711459106;
	bh=G+Hn6cNlyKUyvTsdLqpYQU3MpaSHBX/VmoCrwmgKiuA=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=Mnj8t6OxtLu5AG5u89v26bd8wmZLcN0UmHvjkWAbtmKZtYzeFLucbhoW0h/+cR4WH
	 Uem+3ticvY2WBlCuBTbWDPMtTqaDWzCzkJd7UwMRGPpsp5Tqr+vLCY4s3Nn5iObh/9
	 6ndmKyH5POpbP/BbyaqBqloIgAPrVvE6f13T5Z8W1iVXCh+ZHMrCyie5kOMtxgMNrM
	 lu/a3BKf0wzlsW8ZU1Z5WyZgaAy2GdqWFUET2XEk6/N2YQKIITonFFq1KwPmNgY7E2
	 TGHWE7+bkMHXID92ze6dpg2dpwb2xbLo3VyUP5jG55oSeCsByjb3u7AHXy1JnQ5FFS
	 lVxeLvshqqILQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 15:18:21 +0200
Message-Id: <D03PM9A6IS79.3D6BW7KBLH9C3@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Masami Hiramatsu"
 <mhiramat@kernel.org>
Cc: <linux-riscv@lists.infradead.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>, <linux-modules@vger.kernel.org>, "Naveen
 N . Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 1/2] kprobes: textmem API
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240325215502.660-1-jarkko@kernel.org>
 <20240326095836.f43d259b7747269a7c0b9d23@kernel.org>
 <D03AL7A5G3M2.3UK4ASWILGBJS@kernel.org>
 <D03B7XJYRFC1.2L3I2TO5HNQD3@kernel.org>
In-Reply-To: <D03B7XJYRFC1.2L3I2TO5HNQD3@kernel.org>

On Tue Mar 26, 2024 at 4:01 AM EET, Jarkko Sakkinen wrote:
> On Tue Mar 26, 2024 at 3:31 AM EET, Jarkko Sakkinen wrote:
> > > > +#endif /* _LINUX_EXECMEM_H */
> > > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > > index 9d9095e81792..87fd8c14a938 100644
> > > > --- a/kernel/kprobes.c
> > > > +++ b/kernel/kprobes.c
> > > > @@ -44,6 +44,7 @@
> > > >  #include <asm/cacheflush.h>
> > > >  #include <asm/errno.h>
> > > >  #include <linux/uaccess.h>
> > > > +#include <linux/execmem.h>
> > > > =20
> > > >  #define KPROBE_HASH_BITS 6
> > > >  #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
> > > > @@ -113,17 +114,17 @@ enum kprobe_slot_state {
> > > >  void __weak *alloc_insn_page(void)
> > > >  {
> > > >  	/*
> > > > -	 * Use module_alloc() so this page is within +/- 2GB of where the
> > > > +	 * Use alloc_execmem() so this page is within +/- 2GB of where th=
e
> > > >  	 * kernel image and loaded module images reside. This is required
> > > >  	 * for most of the architectures.
> > > >  	 * (e.g. x86-64 needs this to handle the %rip-relative fixups.)
> > > >  	 */
> > > > -	return module_alloc(PAGE_SIZE);
> > > > +	return alloc_execmem(PAGE_SIZE, GFP_KERNEL);
> > > >  }
> > > > =20
> > > >  static void free_insn_page(void *page)
> > > >  {
> > > > -	module_memfree(page);
> > > > +	free_execmem(page);
> > > >  }
> > > > =20
> > > >  struct kprobe_insn_cache kprobe_insn_slots =3D {
> > > > @@ -1580,6 +1581,7 @@ static int check_kprobe_address_safe(struct k=
probe *p,
> > > >  		goto out;
> > > >  	}
> > > > =20
> > > > +#ifdef CONFIG_MODULES
> > >
> > > You don't need this block, because these APIs have dummy functions.
> >
> > Hmm... I'll verify this tomorrow.
>
> It depends on having struct module available given "(*probed_mod)->state"=
.
>
> It is non-existent unless CONFIG_MODULES is set given how things are
> flagged in include/linux/module.h.

Hey, noticed kconfig issue.

According to kconfig-language.txt:

"select should be used with care. select will force a symbol to a value
without visiting the dependencies."

So the problem here lies in KPROBES config entry using select statement
to pick ALLOC_EXECMEM. It will not take the depends on statement into
account and thus will allow to select kprobes without any allocator in
place.

So to address this I'd suggest to use depends on statement also for
describing relation between KPROBES and ALLOC_EXECMEM. It does not make
life worse than before for anyone because even with the current kernel
you have to select MODULES before you can move forward with kprobes.

BR, Jarkko

