Return-Path: <linux-kernel+bounces-94841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6290B8745D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B2C1C239B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E3BC136;
	Thu,  7 Mar 2024 01:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4bc4mQZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A5DC12C;
	Thu,  7 Mar 2024 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709776708; cv=none; b=bD/0ZTlLZBmcmqR2isGWZ2r3cKoB2kY/jeQlmoE/SL3Eo3s7Jtunxm38SldadStBGakDQQe8Dxg9KcRb9Kg2GeCVWG8oRnjZn2HKSdzrVUIf+xSH/ldPLSyozin/eXxXaQvk4XrcYx6rVEnk1yMGbt2aju0uYEQuKoQleFdthq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709776708; c=relaxed/simple;
	bh=L3O4A6I6q2xswAZ9waPqbgEcxCJuuOwWupiDClvIBCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWEiKoZH2fT2CoCE2YATTHGZAHwr3AqkuMRXZ95uD8jbBMB7W6naMFMKGfRtiypEKzrLoEeWe9LCCJi5q3Ju9aCcrEDjEbOEgTDPBwmAUAJh7lBUEvdBVDXAgu3X3PNEDKN7GYMV4jl5fSTyjX9mDHQf97ixADLhKGmL6w3TNNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4bc4mQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17E9C433B2;
	Thu,  7 Mar 2024 01:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709776707;
	bh=L3O4A6I6q2xswAZ9waPqbgEcxCJuuOwWupiDClvIBCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X4bc4mQZ0B3YJSeSKqiud7Pf5N/PjasxBQ1sMnySsbNAqELWmQzGCHW1xq+e8l4qF
	 z3M/dNxNVtfU1I30IY+TSKsj9VPCItZCs3R03RcrwhEKjqm6pGosP7tLrSpXYJKhag
	 Zc0MB8QQS6smVLljR7ow2tjallSs+HTHue72Adaz1fcfkwBVUhbmgQbYmUZT0ZKMEv
	 YKs57ytwtvBPJcshu67gsib/BYoBk+wVIJ0id6y0BgYNPrZxxaEdja4UPmzScUScm7
	 cWRfl8Lm0CLa7Hn+WgfIfZuTaVyqbuqk5XeZHM7xq2MWRgNAMyMQaZYnMD82QBKetV
	 3jORWmm61v4Mg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d27fef509eso4019021fa.3;
        Wed, 06 Mar 2024 17:58:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXstASmHxCVdk5buDowSfGS0POGtS013UP2BZAbe6bldIcMhcGVyIbLOd1hxY6FZwVOthZMofO39Lb9ya43yiS7fhTFmA7KdgQLvw49WNTGm18FwWeYOvjSqcefnnZpPsK3g96mB6xSWjZy86y/1CQirMtVyfS9J38TJc9+HiSJsQ==
X-Gm-Message-State: AOJu0YwvRVHOJPUdv9uYIVrayZ6uag2S0eijTKVYSdBgxEz/3HsiD+7S
	qI5Ub8qxbbtZAwCEeFGwdpjm4zYT4F4phkrYZUUwkJ74lRDHHFvMMkm0mi1X0hQTkvURs3rAHAx
	oPdE3F8kHL88xJYz+SNibpSn2M5s=
X-Google-Smtp-Source: AGHT+IGPIf6DMuhux4lfwdNlvY9b2iTHZNOuENjiG+dZoBpCzsrVoKx3uIZaEFLeNAPlIblsD05KjVQRj/3eo0KQ5xM=
X-Received: by 2002:a05:651c:1987:b0:2d2:a9d6:c435 with SMTP id
 bx7-20020a05651c198700b002d2a9d6c435mr451387ljb.34.1709776705769; Wed, 06 Mar
 2024 17:58:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709676663.git.jcalvinowens@gmail.com> <ZejhcP_r5QJZcS6j@bombadil.infradead.org>
 <Zej66vQInnDYgpNy@gmail.com>
In-Reply-To: <Zej66vQInnDYgpNy@gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 6 Mar 2024 17:58:14 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4UA9uCRK7EVCJGUvmroQhZZZiVdXotri4oO7+WRQr3sg@mail.gmail.com>
Message-ID: <CAPhsuW4UA9uCRK7EVCJGUvmroQhZZZiVdXotri4oO7+WRQr3sg@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] Make bpf_jit and kprobes work with CONFIG_MODULES=n
To: Calvin Owens <jcalvinowens@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Naveen N Rao <naveen.n.rao@linux.ibm.com>, 
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, David S Miller <davem@davemloft.net>, 
	Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Calvin,

It is great to hear from you! :)

On Wed, Mar 6, 2024 at 3:23=E2=80=AFPM Calvin Owens <jcalvinowens@gmail.com=
> wrote:
>
> On Wednesday 03/06 at 13:34 -0800, Luis Chamberlain wrote:
> > On Wed, Mar 06, 2024 at 12:05:07PM -0800, Calvin Owens wrote:
> > > Hello all,
> > >
> > > This patchset makes it possible to use bpftrace with kprobes on kerne=
ls
> > > built without loadable module support.
> >
> > This is a step in the right direction for another reason: clearly the
> > module_alloc() is not about modules, and we have special reasons for it
> > now beyond modules. The effort to share a generalize a huge page for
> > these things is also another reason for some of this but that is more
> > long term.
> >
> > I'm all for minor changes here so to avoid regressions but it seems a
> > rename is in order -- if we're going to all this might as well do it
> > now. And for that I'd just like to ask you paint the bikeshed with
> > Song Liu as he's been the one slowly making way to help us get there
> > with the "module: replace module_layout with module_memory",
> > and Mike Rapoport as he's had some follow up attempts [0]. As I see it,
> > the EXECMEM stuff would be what we use instead then. Mike kept the
> > module_alloc() and the execmem was just a wrapper but your move of the
> > arch stuff makes sense as well and I think would complement his series
> > nicely.
>
> I apologize for missing that. I think these are the four most recent
> versions of the different series referenced from that LWN link:
>
>   a) https://lore.kernel.org/all/20230918072955.2507221-1-rppt@kernel.org=
/
>   b) https://lore.kernel.org/all/20230526051529.3387103-1-song@kernel.org=
/
>   c) https://lore.kernel.org/all/20221107223921.3451913-1-song@kernel.org=
/
>   d) https://lore.kernel.org/all/20201120202426.18009-1-rick.p.edgecombe@=
intel.com/
>
> Song and Mike, please correct me if I'm wrong, but I think what I've
> done here (see [1], sorry for not adding you initially) is compatible
> with everything both of you have recently proposed above. How do you
> feel about this as a first step?

I agree that the work here is compatible with other efforts. I have no
objection to making this the first step.

>
> For naming, execmem_alloc() seems reasonable to me? I have no strong
> feelings at all, I'll just use that going forward unless somebody else
> expresses an opinion.

I am not good at naming things. No objection from me to "execmem_alloc".

Thanks,
Song

