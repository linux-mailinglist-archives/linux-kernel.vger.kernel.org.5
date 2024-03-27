Return-Path: <linux-kernel+bounces-121661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7AA88EBF2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8780C29F5C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7617514C5BE;
	Wed, 27 Mar 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMXB4AEi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B278E1AAD7;
	Wed, 27 Mar 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558805; cv=none; b=n8T29SpC5rXBu6ml8LJMaecYq4QDQwOxtq85D8ttdiVi1H8kw2MAmsXTGpqz1NMhL72Ib6y43DqL4kxqkIdaNpJw50L9C/ojTsjk3+WT54m+X9PwL/kEw4uyArKAozabFfhWigaE/r5tlgcDc2fvmBvTGFV52Q9Y38+IagH/Nvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558805; c=relaxed/simple;
	bh=kFJK27eqsn3b94GlLP703fwEajJD+XlRkEDUgGuh2cI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hlPgyuU1f+9q5wxJUW0KA5Y4AN9XyCCmktimbSNiysMVNIppCMsOG/2xRrgC1OlKmm/O2V4uKWuaEpqczgXNv85e+RXjjeSgGZv/kql71PY4ZBufKUSV1eAuyN/yW9w9Xd5lgsYTQd/S3PRH3X+yJJ4VJMN91+J+Jhh4N7ZqUGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMXB4AEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F492C433F1;
	Wed, 27 Mar 2024 17:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711558805;
	bh=kFJK27eqsn3b94GlLP703fwEajJD+XlRkEDUgGuh2cI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=LMXB4AEil8mhpE14pDOZqk5V1G188v/TX9AtT86gdloR9J8ZE6YYFIuKlQ6Z5UZai
	 ksIWU4umsus3CI4jcIqamwIW1/1BUK51hMF6nWTO/ybRk6h24jLLwM5k9LsVDzmjen
	 KSlyP8rn5Cl3MBWOuEJuMsCHv3G+qvASXSOYok+8tEK4bRu4FYc4uHhXpqFNyzugKX
	 W86SAEnJ+6FFFqq0dK7TLagxjyFHw/IXsCFF00jRzL4KQm0Ckp17ryUENvaKF3ioao
	 rk7UvQWIGDvrFX2dp1rP4Ha5h/BhxE0MXQRiFlHeaoDv2p1LHr8qkdigCDJAVZXITN
	 LHE94pHdXHP7A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Mar 2024 19:00:00 +0200
Message-Id: <D04OYICG7UM7.3SFZE1NKID389@kernel.org>
Cc: <linux-riscv@lists.infradead.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>, <linux-modules@vger.kernel.org>, "Naveen
 N . Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 "Masami Hiramatsu" <mhiramat@kernel.org>
Subject: Re: [PATCH v7 2/2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Conor Dooley" <conor@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240326134616.7691-1-jarkko@kernel.org>
 <20240326134616.7691-2-jarkko@kernel.org>
 <20240326-cape-compacted-e76df066752f@spud>
In-Reply-To: <20240326-cape-compacted-e76df066752f@spud>

On Tue Mar 26, 2024 at 8:42 PM EET, Conor Dooley wrote:
> On Tue, Mar 26, 2024 at 03:46:16PM +0200, Jarkko Sakkinen wrote:
> > Tacing with kprobes while running a monolithic kernel is currently
> > impossible due the kernel module allocator dependency.
> >=20
> > Address the issue by implementing textmem API for RISC-V.
>
> This doesn't compile for nommu:
>   /build/tmp.3xucsBhqDV/arch/riscv/kernel/execmem.c:10:46: error: 'MODULE=
S_VADDR' undeclared (first use in this function)
>   /build/tmp.3xucsBhqDV/arch/riscv/kernel/execmem.c:11:37: error: 'MODULE=
S_END' undeclared (first use in this function)
>   /build/tmp.3xucsBhqDV/arch/riscv/kernel/execmem.c:14:1: error: control =
reaches end of non-void function [-Werror=3Dreturn-type]
> Clang builds also report:
> ../arch/riscv/kernel/execmem.c:8:56: warning: omitting the parameter name=
 in a function definition is a C2x extension [-Wc2x-extensions]
>
> >=20
> > Link: https://www.sochub.fi # for power on testing new SoC's with a min=
imal stack
> > Link: https://lore.kernel.org/all/20220608000014.3054333-1-jarkko@profi=
an.com/ # continuation
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v5-v7:
> > - No changes.
> > v4:
> > - Include linux/execmem.h.
> > v3:
> > - Architecture independent parts have been split to separate patches.
> > - Do not change arch/riscv/kernel/module.c as it is out of scope for
> >   this patch set now.
>
> Meta comment. I dunno when v1 was sent, but versions can you please
> relax with submitting new versions of your patches? There's conversations
> ongoing on v5 at the moment, while this is a more recent version. v2
> seems to have been sent on the 23rd and there's been 5 versions in the
> last day:
> https://patchwork.kernel.org/project/linux-riscv/list/?submitter=3D195059=
&state=3D*
>
> Could you please also try and use a cover letter for patchsets, ideally
> with a consistent subject? Otherwise I have to manually mark stuff as
> superseded.

Point taken but the work has been taken over by Mark and relevant
changes are now sucked into that patch set.

> Thanks,
> Conor.

BR, Jarkko

