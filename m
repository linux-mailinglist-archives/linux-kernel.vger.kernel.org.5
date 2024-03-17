Return-Path: <linux-kernel+bounces-105438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2762687DDD9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5CC1F210D2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D06D1C6A0;
	Sun, 17 Mar 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="VzxyZ1sI"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633DC1C691
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710688568; cv=none; b=OpK0HForiEzoQ+VIZ78fXXHJnq1oqSaY931oOJl3IrDCvUK1d28UMB3MQqxCReILqw8BAMOROpb3Tb61eWOrtQZtmIXeWfTklrUJV7k9JJ7YJoRIeQkPDpi2Ays0OAjf4nG3DCv+qajpo87iALl0c5trFdvcqr714exYMBGk2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710688568; c=relaxed/simple;
	bh=v/r9GzEEJW7NCpbQtiA2Yy7aQl3CkuMH2nMUbvdvaPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMwCtyHlD83IS6CmvY2qfHrenSfnXZyFj4n7AOPK/nfjsqT+wqYlvrZ98eL/dKNwJgJcCc7KY0OrC5XV/gGpfF2/J9TOEW5eqwWKqrFVFr4jPQj3U2D6xchHOxZEVjOh8f/uj21Sp8fkfAoyBMKYikIUA46XJlXurLEBdeCmh5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=VzxyZ1sI; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42e323a2e39so32174881cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 08:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710688566; x=1711293366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/SLJTPrYdvSiWiNqrR3D72kmqik90U4Q+5rpGyYCw0=;
        b=VzxyZ1sIrCTHkbJ3KXMWV72Cq/iWv5+jZ/i8l4k9xRgzFglFOIhCXtbEEe/Reju02n
         oqpsX7hHkaFbGpsWlsLMj5+dh9FvKsZHAt+gjvlNfd9Fa9SPa4tFHzOkMo7CMd508s7x
         W8S1oY3jADuQhrNt9OYHUMQdgDNV0nxCZhd/9NoFGKEx4eUbR4MjHi5VVCn299uUFu0S
         9X3o8gPoGHU5RcKAnh6SjBaDXUlhyOWsF53LZ4bfdLM5o4pc97xl1UCIVD4KjLGmlxgO
         5pU0m95eVrB46lbhXjPvUAxp8h3BkFXBGm5N/F/M+l6UNwnF9zZ6RNOWw1dG1P5XjRpd
         n9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710688566; x=1711293366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/SLJTPrYdvSiWiNqrR3D72kmqik90U4Q+5rpGyYCw0=;
        b=totJfrxcIWuMoOnla06wP+T7po5fIonwUtLZBiw5MtoR5rHHR02H827iWudkLFWDmJ
         P5lZmR//kOe71Tf2Q/zgbuoVB9ey9Q4JBM2LXQ401dDvTp4tXmE0iq7NgA5HT1wJWvSy
         zdtxmpUmCrWnTarHcj9HxIRQQVeFzid14Cp7vYuXwXPSJcMFCvVoLUt3dROn3K2Jdbwe
         4nbTPLQKDFuf3tLjRBWI7c2P/zaCWxGwHIJcUOI00lPpvq541mqyYU5U63h1hNe83RzP
         oIqCg5JMWS6jO3N1tWIEUezPNsOvOdykGDi1gg7EtZQSShXg/aEiwrZOgdLK0ZjsT/37
         A8qw==
X-Gm-Message-State: AOJu0Yy248QjVVvqBNM/qcg4a2p+05p04XLU5iXPLjvft3VeLLIQigij
	fOLSQi6RKVhPOsw+wTnZ8pj0qplqxITbOpup+lEP0omo6CpV7vmvKUZ7rQXRvdOIp28Kgt3cOU0
	iEzcMkmHwPB51phV5PuduBW4QRdN9yK6kJErAGzxqCrEUk/pX
X-Google-Smtp-Source: AGHT+IFyMnpiLXfaKDgSZc8JDytGevRilFiWhY+KM0uCrVLml93IBlU+ayqqnkbK9D40N3mi9WfLuogGFdgae/8Py/I=
X-Received: by 2002:ac8:7e95:0:b0:430:bb91:2ae9 with SMTP id
 w21-20020ac87e95000000b00430bb912ae9mr6676290qtj.14.1710688566343; Sun, 17
 Mar 2024 08:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-9-pasha.tatashin@soleen.com> <5b98c4a1-26c0-4b69-b000-44ae97eb6edb@wanadoo.fr>
In-Reply-To: <5b98c4a1-26c0-4b69-b000-44ae97eb6edb@wanadoo.fr>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 17 Mar 2024 11:15:30 -0400
Message-ID: <CA+CK2bB+NVzFW5DpmrL3jJPZFyaKyHdqge3KNf1eLBe0YeHhfA@mail.gmail.com>
Subject: Re: [RFC 08/14] fork: separate vmap stack alloction and free calls
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, hpa@zytor.com, 
	jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, jpoimboe@kernel.org, 
	jroedel@suse.de, juri.lelli@redhat.com, kent.overstreet@linux.dev, 
	kinseyho@google.com, kirill.shutemov@linux.intel.com, lstoakes@gmail.com, 
	luto@kernel.org, mgorman@suse.de, mic@digikod.net, 
	michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com, 
	mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, 
	tglx@linutronix.de, urezki@gmail.com, vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 10:52=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 11/03/2024 =C3=A0 17:46, Pasha Tatashin a =C3=A9crit :
> > In preparation for the dynamic stacks, separate out the
> > __vmalloc_node_range and vfree calls from the vmap based stack
> > allocations. The dynamic stacks will use their own variants of these
> > functions.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >   kernel/fork.c | 53 ++++++++++++++++++++++++++++++--------------------=
-
> >   1 file changed, 31 insertions(+), 22 deletions(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 3004e6ce6c65..bbae5f705773 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -204,6 +204,29 @@ static bool try_release_thread_stack_to_cache(stru=
ct vm_struct *vm_area)
> >       return false;
> >   }
> >
> > +static inline struct vm_struct *alloc_vmap_stack(int node)
> > +{
> > +     void *stack;
> > +
> > +     /*
> > +      * Allocated stacks are cached and later reused by new threads,
> > +      * so memcg accounting is performed manually on assigning/releasi=
ng
> > +      * stacks to tasks. Drop __GFP_ACCOUNT.
> > +      */
> > +     stack =3D __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
> > +                                  VMALLOC_START, VMALLOC_END,
> > +                                  THREADINFO_GFP & ~__GFP_ACCOUNT,
> > +                                  PAGE_KERNEL,
> > +                                  0, node, __builtin_return_address(0)=
);
> > +
> > +     return (stack) ? find_vm_area(stack) : NULL;
>
> Nit: superfluous ()

Thank you.

>
> > +}
>
> ...
>

