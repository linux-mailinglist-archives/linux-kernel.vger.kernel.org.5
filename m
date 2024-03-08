Return-Path: <linux-kernel+bounces-97551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EF8876BD9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B1E1C21684
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21745E074;
	Fri,  8 Mar 2024 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+Wb+pKE"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9EF5E065;
	Fri,  8 Mar 2024 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929676; cv=none; b=qN3qp+Dv7sHxuXikiPyoQ8EEz2Ttx5Btccj9MZEXdfLgiHUzsQkWN/lAlp43J236Ct24YgHGxvezqAXXTRaT6UT2T81eujia/h5r+F/g92rRPWwuVlmtlI8FyN1I8rDy+Fh+A1zAhpSPEcvBGFLUHQXv8Br0blNmIGad+EcUMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929676; c=relaxed/simple;
	bh=mQcD5ykMCdd/SZ7+M4Y9X6BbATMyJuVX8fjLs9rMW6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lt+IutL5EJ6mdl2iWRtDAs5jP+7i8ZCv3zoqOlY6EsQwqi/N91QVxqER6DuEYoK6J0AovTHYaXZEQNT6vdES5d/Xoji5RoCNGKgtU4DtXbwwwWXREdlo36kltTsRErMBvc516xsSru0XB4xf8IMkGAsihc2dXHC8H2uJ/ANeVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+Wb+pKE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e56787e691so2491469b3a.0;
        Fri, 08 Mar 2024 12:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709929674; x=1710534474; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wXUjGZ9jnAwCdwAfXjSSya1Xbt4jMaLFoszBP4rfXz4=;
        b=C+Wb+pKELrY3+HDDncr9v4kbytGC47A9na5afTsWgqNuKP+43EG4Mq+qONCF4Z0lUJ
         McRchkk/LDOP08C0gqTwpH3ilG/EsptNiNFTX2gdVQvrOMobEbyAFA/W2Z5oAij0RIZI
         VsDRL9s9Cgc8mLHf2zJGs8UnqZH9VzXTtvXwVOijsYrlaGrDXVcVhTNbae90ICP0pxUT
         DYtX6ioxRlaVwhNbIh8DB2n03cuXrXsclHBlbYHBGkOTPqLfQ3xva12i2Nw0X061Lx+z
         f7HwZGxK9VqscxLjszuH56QqFGLGK0F6v0GYDkDyLvq9Vs0sBz2VbpJIw5Qgk5Y3qnDf
         kTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709929674; x=1710534474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXUjGZ9jnAwCdwAfXjSSya1Xbt4jMaLFoszBP4rfXz4=;
        b=tLM85lXynCzUmkZGo1TXPmjacNxnaXgbA7ZTRUA+4Bp+bN8O1WtXSzDeZTE/uhkbG8
         MgQqMGOIATVNRnxUBtGPSmzhRfLEG+UvHieVmOaJmLFr53u7B2n2SWZxGxrg9KwymaPv
         aoVkIVkaOM/6o/nFafL9YuZ8VSErO1LQslSoh1dJBfwGPh3PSn2IAzUesaSILLSFjRdg
         Ui7H750qAbea9FKculAaGqzh4Z1JBpEKCU5Kz1gCElmeSAVKRBvDNizbImcQ9wE83GEQ
         GIOM4aXqe2Ryhr1w/QvqQ2DxHSTaS4agfGF6oVu7vuQqz+cfXZs1CcQ/L0R/0T7H5QSZ
         8ITQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZuqBAWNoTO0vQYRx0v8bLj6RabK56m5PYSm+qML8sDhZWArMxIqstCtD9hjaTxTEHsmWk+IRi6RvgiGjDKwySvaY4P0JkrqKU35pXcGslcC5A5ewSuO6g6r/sa/Vc6i4Skd8WQAEnfw5uutmD/ySbu4k1Dd4CDJaGTpxDdyNcWw==
X-Gm-Message-State: AOJu0Yy7aDiuoRfCpiErXiVlWmxoKuhcGL/qLfDfzTUseQ84/TldGe4D
	vyt0KWi/6Rd4GzvjwcMZYj3kCCce4unRn70z3MJoW8hXNXlDl3J8
X-Google-Smtp-Source: AGHT+IEmOBhZjqMgFca4qw/6mMXRhzelSikcLVjZYKzNw0aKx+OmvlvhRngoIFIQUR84hPVcrzzQlQ==
X-Received: by 2002:a05:6a21:3284:b0:1a1:82e0:3ad4 with SMTP id yt4-20020a056a21328400b001a182e03ad4mr349882pzb.7.1709929673633;
        Fri, 08 Mar 2024 12:27:53 -0800 (PST)
Received: from gmail.com ([192.184.166.229])
        by smtp.gmail.com with ESMTPSA id bm24-20020a656e98000000b005cfbdf71baasm84122pgb.47.2024.03.08.12.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 12:27:53 -0800 (PST)
Date: Fri, 8 Mar 2024 12:27:50 -0800
From: Calvin Owens <jcalvinowens@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Song Liu <song@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	David S Miller <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] Make bpf_jit and kprobes work with
 CONFIG_MODULES=n
Message-ID: <Zet0xm0Nf2k9O7U9@gmail.com>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
 <ZejhcP_r5QJZcS6j@bombadil.infradead.org>
 <Zej66vQInnDYgpNy@gmail.com>
 <CAPhsuW4UA9uCRK7EVCJGUvmroQhZZZiVdXotri4oO7+WRQr3sg@mail.gmail.com>
 <20240308115004.22fe5bb7ecea4080aa2ef383@kernel.org>
 <CAB=NE6V+HroMv4vNBJkCu_6Sbu08mPh0ZBadDEQxOKWoKoBk1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB=NE6V+HroMv4vNBJkCu_6Sbu08mPh0ZBadDEQxOKWoKoBk1w@mail.gmail.com>

On Thursday 03/07 at 18:55 -0800, Luis Chamberlain wrote:
> On Thu, Mar 7, 2024 at 6:50 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Wed, 6 Mar 2024 17:58:14 -0800
> > Song Liu <song@kernel.org> wrote:
> >
> > > Hi Calvin,
> > >
> > > It is great to hear from you! :)
> > >
> > > On Wed, Mar 6, 2024 at 3:23 PM Calvin Owens <jcalvinowens@gmail.com> wrote:
> > > >
> > > > On Wednesday 03/06 at 13:34 -0800, Luis Chamberlain wrote:
> > > > > On Wed, Mar 06, 2024 at 12:05:07PM -0800, Calvin Owens wrote:
> > > > > > Hello all,
> > > > > >
> > > > > > This patchset makes it possible to use bpftrace with kprobes on kernels
> > > > > > built without loadable module support.
> > > > >
> > > > > This is a step in the right direction for another reason: clearly the
> > > > > module_alloc() is not about modules, and we have special reasons for it
> > > > > now beyond modules. The effort to share a generalize a huge page for
> > > > > these things is also another reason for some of this but that is more
> > > > > long term.
> > > > >
> > > > > I'm all for minor changes here so to avoid regressions but it seems a
> > > > > rename is in order -- if we're going to all this might as well do it
> > > > > now. And for that I'd just like to ask you paint the bikeshed with
> > > > > Song Liu as he's been the one slowly making way to help us get there
> > > > > with the "module: replace module_layout with module_memory",
> > > > > and Mike Rapoport as he's had some follow up attempts [0]. As I see it,
> > > > > the EXECMEM stuff would be what we use instead then. Mike kept the
> > > > > module_alloc() and the execmem was just a wrapper but your move of the
> > > > > arch stuff makes sense as well and I think would complement his series
> > > > > nicely.
> > > >
> > > > I apologize for missing that. I think these are the four most recent
> > > > versions of the different series referenced from that LWN link:
> > > >
> > > >   a) https://lore.kernel.org/all/20230918072955.2507221-1-rppt@kernel.org/
> > > >   b) https://lore.kernel.org/all/20230526051529.3387103-1-song@kernel.org/
> > > >   c) https://lore.kernel.org/all/20221107223921.3451913-1-song@kernel.org/
> > > >   d) https://lore.kernel.org/all/20201120202426.18009-1-rick.p.edgecombe@intel.com/
> > > >
> > > > Song and Mike, please correct me if I'm wrong, but I think what I've
> > > > done here (see [1], sorry for not adding you initially) is compatible
> > > > with everything both of you have recently proposed above. How do you
> > > > feel about this as a first step?
> > >
> > > I agree that the work here is compatible with other efforts. I have no
> > > objection to making this the first step.
> > >
> > > >
> > > > For naming, execmem_alloc() seems reasonable to me? I have no strong
> > > > feelings at all, I'll just use that going forward unless somebody else
> > > > expresses an opinion.
> > >
> > > I am not good at naming things. No objection from me to "execmem_alloc".
> >
> > Hm, it sounds good to me too. I think we should add a patch which just
> > rename the module_alloc/module_memfree with execmem_alloc/free first.
> 
> I think that would be cleaner, yes. Leaving the possible move to a
> secondary patch and placing the testing more on the later part.

Makes sense to me.

