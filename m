Return-Path: <linux-kernel+bounces-96466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B86D875C8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2751C21030
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF8B2B9A9;
	Fri,  8 Mar 2024 02:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFPKSoji"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0B2206E;
	Fri,  8 Mar 2024 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709866570; cv=none; b=baPUVNRREZwKU0n3/VQhT9+N6pXCQwr4khLgsKiRlsfKur2W1S+ZO23azP8yFpYpEvFWMKA9lU2opLfUqAxWNc4pHfvogzszV24Ig2ADK3yTlExZiLj98SQebut9V5IDdR986A4jSyPiKSGucAPfIWkmedaZVPJrK8dZdZsGivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709866570; c=relaxed/simple;
	bh=O95sEDBHKlBxmI+Kun+U9XpoeKXC65Z/tjyVRlGZfD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9Bmce8JI6KSwZKRzH2iMOn9WsIcgt1zUtMpqoCLcOf0VLp59ocd4opg9cewcy1b5egJ0QoXnEyahu7CNUzC0jBnPgCXGfO1jP8rDfIk84JX2bEIt29qHIJ8/Y9eA6yXrTdShzl6PlSwoUFfG4hEcM+aNzyUVTfZy6hphK4qkpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFPKSoji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B74C433C7;
	Fri,  8 Mar 2024 02:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709866569;
	bh=O95sEDBHKlBxmI+Kun+U9XpoeKXC65Z/tjyVRlGZfD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lFPKSojiP08GAcm8Uun68CQAe3lGPh/XNkJtEcSofQOV/0Oixf4WFmPM6l5kAv+lh
	 URGIpvvtgAc9hO/XheJjVZDtL5ytCnDgKBjaD/xVPeXNpi31e84vYrjrm9gPDoZa/2
	 ZrJ0gC8ixgJTKcdWO/N8r5PbUg+BhHu1cn+cBOaOjeNM8fGElgbCg/wlu0M8qGtDpK
	 xMoYo5PilviL5173tV07WNMXz7uAeie5rI5MylgHB/4cAslzaXlpWVfsWvuGAizpJx
	 lF6VtxvrEZRlKihDeCcbk/qbSqyXPuQ60GsU3B/uXmj2Od3vxvOj+8p6P5Xawck5ZR
	 wMEhyAiEjDQ7Q==
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e709ea81bso309820f8f.0;
        Thu, 07 Mar 2024 18:56:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbos2XWtatKFssa8vpfxKoZLsf8i8SDE5WJOmLiRNnu+vPflE/MR3Z1a6focyOY4pbC10t+irJInNRlYJ0LqmVavVHQdnvYE+ilPM8tRVsd25Go+iK5vSa80Awd44ndlyrHFR2rmDLnvPf0l1aeEq+ZfPk8Nayk1IP1siwTsaZ+Q==
X-Gm-Message-State: AOJu0YwooNMWpjCD+yoDfufnFzwwvJTWsA1Jj7lWQMr0rGXcprUhaoMR
	3cnQO66UVVMIk9Hi356wrccdvLcrgYiwLEk0ulF5JLoN8XucMjT9lC7lgi8ZzM+HYvfIIfEwUQP
	k80dyW1yqpan44JOEJK3zd96T+Zc=
X-Google-Smtp-Source: AGHT+IFA+EpXZ8DU5O5i90wf6QNjD/b0i2o8zbBYyj5KgEBVpBG7ZvhG/lbQBVhsKz8pWnyfZQOjeB+Al5KbfoUNZYs=
X-Received: by 2002:adf:9782:0:b0:33d:61d9:2d5d with SMTP id
 s2-20020adf9782000000b0033d61d92d5dmr13037996wrb.34.1709866568177; Thu, 07
 Mar 2024 18:56:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709676663.git.jcalvinowens@gmail.com> <ZejhcP_r5QJZcS6j@bombadil.infradead.org>
 <Zej66vQInnDYgpNy@gmail.com> <CAPhsuW4UA9uCRK7EVCJGUvmroQhZZZiVdXotri4oO7+WRQr3sg@mail.gmail.com>
 <20240308115004.22fe5bb7ecea4080aa2ef383@kernel.org>
In-Reply-To: <20240308115004.22fe5bb7ecea4080aa2ef383@kernel.org>
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Thu, 7 Mar 2024 18:55:55 -0800
X-Gmail-Original-Message-ID: <CAB=NE6V+HroMv4vNBJkCu_6Sbu08mPh0ZBadDEQxOKWoKoBk1w@mail.gmail.com>
Message-ID: <CAB=NE6V+HroMv4vNBJkCu_6Sbu08mPh0ZBadDEQxOKWoKoBk1w@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] Make bpf_jit and kprobes work with CONFIG_MODULES=n
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Song Liu <song@kernel.org>, Calvin Owens <jcalvinowens@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Naveen N Rao <naveen.n.rao@linux.ibm.com>, 
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, David S Miller <davem@davemloft.net>, 
	Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 6:50=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Wed, 6 Mar 2024 17:58:14 -0800
> Song Liu <song@kernel.org> wrote:
>
> > Hi Calvin,
> >
> > It is great to hear from you! :)
> >
> > On Wed, Mar 6, 2024 at 3:23=E2=80=AFPM Calvin Owens <jcalvinowens@gmail=
com> wrote:
> > >
> > > On Wednesday 03/06 at 13:34 -0800, Luis Chamberlain wrote:
> > > > On Wed, Mar 06, 2024 at 12:05:07PM -0800, Calvin Owens wrote:
> > > > > Hello all,
> > > > >
> > > > > This patchset makes it possible to use bpftrace with kprobes on k=
ernels
> > > > > built without loadable module support.
> > > >
> > > > This is a step in the right direction for another reason: clearly t=
he
> > > > module_alloc() is not about modules, and we have special reasons fo=
r it
> > > > now beyond modules. The effort to share a generalize a huge page fo=
r
> > > > these things is also another reason for some of this but that is mo=
re
> > > > long term.
> > > >
> > > > I'm all for minor changes here so to avoid regressions but it seems=
 a
> > > > rename is in order -- if we're going to all this might as well do i=
t
> > > > now. And for that I'd just like to ask you paint the bikeshed with
> > > > Song Liu as he's been the one slowly making way to help us get ther=
e
> > > > with the "module: replace module_layout with module_memory",
> > > > and Mike Rapoport as he's had some follow up attempts [0]. As I see=
 it,
> > > > the EXECMEM stuff would be what we use instead then. Mike kept the
> > > > module_alloc() and the execmem was just a wrapper but your move of =
the
> > > > arch stuff makes sense as well and I think would complement his ser=
ies
> > > > nicely.
> > >
> > > I apologize for missing that. I think these are the four most recent
> > > versions of the different series referenced from that LWN link:
> > >
> > >   a) https://lore.kernel.org/all/20230918072955.2507221-1-rppt@kernel=
org/
> > >   b) https://lore.kernel.org/all/20230526051529.3387103-1-song@kernel=
org/
> > >   c) https://lore.kernel.org/all/20221107223921.3451913-1-song@kernel=
org/
> > >   d) https://lore.kernel.org/all/20201120202426.18009-1-rick.p.edgeco=
mbe@intel.com/
> > >
> > > Song and Mike, please correct me if I'm wrong, but I think what I've
> > > done here (see [1], sorry for not adding you initially) is compatible
> > > with everything both of you have recently proposed above. How do you
> > > feel about this as a first step?
> >
> > I agree that the work here is compatible with other efforts. I have no
> > objection to making this the first step.
> >
> > >
> > > For naming, execmem_alloc() seems reasonable to me? I have no strong
> > > feelings at all, I'll just use that going forward unless somebody els=
e
> > > expresses an opinion.
> >
> > I am not good at naming things. No objection from me to "execmem_alloc"=
.
>
> Hm, it sounds good to me too. I think we should add a patch which just
> rename the module_alloc/module_memfree with execmem_alloc/free first.

I think that would be cleaner, yes. Leaving the possible move to a
secondary patch and placing the testing more on the later part.

 Luis

