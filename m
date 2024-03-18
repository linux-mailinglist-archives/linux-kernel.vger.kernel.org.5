Return-Path: <linux-kernel+bounces-106275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F19E87EBBD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F192811C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA9F4F200;
	Mon, 18 Mar 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Hlm4MGv7"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E305D4E1D3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774626; cv=none; b=sQUcSXnHK4RY0rfdqPMRIMQ0ootR8T2zdpsh4nBCAwsgs4rngOrosCCGJ/CfLHWP70sleir5vOn7kfmon1SOZM6Zj4DwBzeL4pB0AOqpbdkaIxQzA11wrz3VzcH7Ar5+PtzM+QleEsE1Um/cttk6wAhkFVL7047pGFbM9rSKWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774626; c=relaxed/simple;
	bh=73vfzaGUrkL8OR4EpKhuTHYiz7zUQJHz8EOvbTyVe8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nk7argkfrdfhsX5aPQ2ASXDpHrySeACLD3Ig04XOwIIEwSS+w3x81GEWWnTm7sifrTIwMwy8AuUT1qIGYMmGHfnkP+EEwmkmaWT0+Ju+XNUKuDebmc2VOMZ7EyeCGQ92G+YtRbo1MjUAajrY2q2R8neIVEJLJ3hvwE/e49hiSog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Hlm4MGv7; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-430c4d0408eso10002381cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710774624; x=1711379424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KVpr3mWHXuGxJ7EXrWZlpaYerSnna04C7a1q/1FFdM=;
        b=Hlm4MGv7QOpozYhUXKj+XpKx84GfcBbSjFyhHfhQRkbzn/ZXfy+LO4T3PLC+klsEhx
         jHqLEiemd1U6gAIlepSu8ISvSvmMYmvU7JPzR5DtnxoQszpO06xmns/wTxiR9jp0qRt3
         YwlZImcRBMk4jZXf3BZyd1o+icYzVSWwDkYm9m/5QdS4LTj7/HXs+YBLeAJ5EvPqzO0N
         HJrhQAN+XWJrsH7KjkVcEWRdtLY69u6KZVkYU0VxV7mJYda8ggoiMzyBZRoWck4QZAem
         p5U7RmaYtbkbncJ3soY/6VZhQmwNjhEdPd13WEGSozPYE3k571cfdevVuFPW16kieoXI
         Ul4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710774624; x=1711379424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KVpr3mWHXuGxJ7EXrWZlpaYerSnna04C7a1q/1FFdM=;
        b=pH+k7OKaobf7+jWZEhyDRkVebKVBeVLgnAaRxmYddDA2xW6ToqcRJEJYlP8rZ/idqs
         tkN9uyMROnWG3Q6B2UdYGRMFpwsR5eSBwZiyf3UyaoLhRh+MWjtI3TSAv93gdtfQHDY6
         hgorkCPw0r/KG9oPfWGYeZ4nwb7AF6seYKBdkxacK9WyM/PnRpPtKWOwWMrhE8WeQbgT
         854Rcgh7UVdIKKJvy+UoDuotWMfDB8aTD0WHuL7wCiSjM95iQEHbtlT0UfFOD1+BQNyK
         F9omowOUUgL+oX3g8LFJLYX9C3+sVX0FTgj2GlBciOdZNbxOlC/9f8Aq9wb1RXy4LLka
         3roA==
X-Forwarded-Encrypted: i=1; AJvYcCWeBZWBQ92zWeknSFCgtT/a9P990LMUsXHEJCAPeYjrwU9jJgGdYSBeP5ap+O9WFEgE3E156Ml85Bu/2sReNrNQlQCI/94jjtiMlb8m
X-Gm-Message-State: AOJu0Yy5Fqgvb+7P26Enre12C3WKlT+R8YRrOgzkSw4cu6AiCj1qT0P1
	NNCVbmTopXdN9LuckL7mbVdZp9oSBB3oOt9A6FTQvCYaiyHzUHrD+estT4gDL0vWrIDvP+jfykH
	c6mPnpXS8q4ui1xFJG5mCo6lXuf5EtnBkS2DSDQ==
X-Google-Smtp-Source: AGHT+IHFN0fU8r0syuFMehIeN1NFAZzvX59LJVNDd/w7DnmgPi3+6kWifl8gfb5LM7luoZkAmDyKUfv3vsiwBPByVnk=
X-Received: by 2002:a05:622a:d4:b0:430:d2ed:3bbe with SMTP id
 p20-20020a05622a00d400b00430d2ed3bbemr3376760qtw.59.1710774623709; Mon, 18
 Mar 2024 08:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com> <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>
 <ZfNWojLB7qjjB0Zw@casper.infradead.org> <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
 <39F17EC4-7844-4111-BF7D-FFC97B05D9FA@zytor.com> <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>
 <bb203717ab644362a8eafe78aff23947@AcuMS.aculab.com>
In-Reply-To: <bb203717ab644362a8eafe78aff23947@AcuMS.aculab.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Mar 2024 11:09:47 -0400
Message-ID: <CA+CK2bAuNLXq4p8pjwAatuw2KuadhKjD6JRwJN8ZvSEd1d7ntA@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: David Laight <David.Laight@aculab.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Matthew Wilcox <willy@infradead.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>, "brauner@kernel.org" <brauner@kernel.org>, 
	"bristot@redhat.com" <bristot@redhat.com>, "bsegall@google.com" <bsegall@google.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"dianders@chromium.org" <dianders@chromium.org>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, 
	"eric.devolder@oracle.com" <eric.devolder@oracle.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"hch@infradead.org" <hch@infradead.org>, 
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "jroedel@suse.de" <jroedel@suse.de>, 
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "kinseyho@google.com" <kinseyho@google.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "lstoakes@gmail.com" <lstoakes@gmail.com>, 
	"luto@kernel.org" <luto@kernel.org>, "mgorman@suse.de" <mgorman@suse.de>, "mic@digikod.net" <mic@digikod.net>, 
	"michael.christie@oracle.com" <michael.christie@oracle.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"mjguzik@gmail.com" <mjguzik@gmail.com>, "mst@redhat.com" <mst@redhat.com>, 
	"npiggin@gmail.com" <npiggin@gmail.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"pmladek@suse.com" <pmladek@suse.com>, 
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"surenb@google.com" <surenb@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"urezki@gmail.com" <urezki@gmail.com>, 
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "vschneid@redhat.com" <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 2:58=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Pasha Tatashin
> > Sent: 16 March 2024 19:18
> ...
> > Expanding on Mathew's idea of an interface for dynamic kernel stack
> > sizes, here's what I'm thinking:
> >
> > - Kernel Threads: Create all kernel threads with a fully populated
> > THREAD_SIZE stack.  (i.e. 16K)
> > - User Threads: Create all user threads with THREAD_SIZE kernel stack
> > but only the top page mapped. (i.e. 4K)
> > - In enter_from_user_mode(): Expand the thread stack to 16K by mapping
> > three additional pages from the per-CPU stack cache. This function is
> > called early in kernel entry points.
> > - exit_to_user_mode(): Unmap the extra three pages and return them to
> > the per-CPU cache. This function is called late in the kernel exit
> > path.
>
> Isn't that entirely horrid for TLB use and so will require a lot of IPI?

The TLB load is going to be exactly the same as today, we already use
small pages for VMA mapped stacks. We won't need to have extra
flushing either, the mappings are in the kernel space, and once pages
are removed from the page table, no one is going to access that VA
space until that thread enters the kernel again. We will need to
invalidate the VA range only when the pages are mapped, and only on
the local cpu.

> Remember, if a thread sleeps in 'extra stack' and is then resheduled
> on a different cpu the extra pages get 'pumped' from one cpu to
> another.

Yes, the per-cpu cache can get unbalanced this way, we can remember
the original CPU where we acquired the pages to return to the same
place.

> I also suspect a stack_probe() is likely to end up being a cache miss
> and also slow???

Can you please elaborate on this point. I am not aware of
stack_probe() and how it is used.

> So you wouldn't want one on all calls.
> I'm not sure you'd want a conditional branch either.
>
> The explicit request for 'more stack' can be required to be allowed
> to sleep - removing a lot of issues.
> It would also be portable to all architectures.
> I'd also suspect that any thread that needs extra stack is likely
> to need to again.
> So while the memory could be recovered, I'd bet is isn't worth
> doing except under memory pressure.
> The call could also return 'no' - perhaps useful for (broken) code
> that insists on being recursive.

The current approach discussed is somewhat different from explicit
more stack requests API. I am investigating how feasible it is to use
kernel stack multiplexing, so the same pages can be re-used by many
threads when they are actually used. If the multiplexing approach
won't work, I will come back to the explicit more stack API.

> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

