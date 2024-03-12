Return-Path: <linux-kernel+bounces-100547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434D2879969
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE60D283D72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD20137C27;
	Tue, 12 Mar 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="vaS6OPCR"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3ED137C21
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262437; cv=none; b=KvQIKGNYpeKU3MPPb1awU/4xLOXmG/Mm3nFsLtl/b8OqMP/eCdTLq4L5TKBdJS7RlcI5Ys6llUX0qyKYb53Fh/JkGDGzbvKlvGKrVPkE3NVkRt7qqzWkZ6JjVWTcJbc6umlUzAihjAsjtr0snBtzvsgNSCIyw/TI6rZYbGrOkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262437; c=relaxed/simple;
	bh=+CjwWxU3WvMQ2dFXQoBkooFJ2ARG/C9oWs3kM1P/OpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGed9R3XP2jJszkFVYvM9mB4Qn6X4muKvsn3hWY1+ZpVXV0oJSQg1o9Z05bY8BtyWkOAwYVActg33Fgi8vUAuns0+5AveTjAErILCbwT035IF7badmwOPUEMiOnrPAV8G22X+XIz5tuLjvDBjuhhZE/qUde01mHha4j3kM5HWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=vaS6OPCR; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42e323a2e39so270981cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710262435; x=1710867235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAMusPdvz5a8W0RgIatIFRN14xcgJUxEx/bPUCmYvZI=;
        b=vaS6OPCRcZUIiuH51Zlg89+fw7QA+4oBrgkEy5z/RVQn8tZ5lUtfqsBIx1SLjQ+KQY
         6ZT1bQgavH+UUOalQdqxU4rmsEGhD3wREEEcbM6QcwfeTyOEjFQ9q0/Ht5dSARF8c/Dj
         bmDsU/sDqL9pdlZoczONLZmchm6WIZxZsAj7Xc+3BU9xRvP+9KnWJMaRpgvcR7LXekPM
         BNv7M1uZPfS2vJ0R1qJ6T0m5dfdpUvSye3zczFqZq4Fe9ETJfycaoa7rtOl/k+4F9rLb
         yOeQN3WZOusOdnWciunGTRAXcBjGzLo+XbeW72fANloMhaRgKKTy16fljsszQC5Z7GqS
         Qewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710262435; x=1710867235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAMusPdvz5a8W0RgIatIFRN14xcgJUxEx/bPUCmYvZI=;
        b=oGHN1AAHZcQEkRjzpT6qvo4zSbe46eXb8jo7wQrSzuAhRZKgWm5MLU6Ajx6IK8mF1o
         3rBJPLDRpnLsBPAuM776ABIfBd5kxIJlCPbA+CH6RoVg+wecop+mFF1routb/AlY1zMc
         wwJfnMhtM5v+YaBRB1diBPNuZIfhkw4IgY0cHCp8NddqaP6xWikpRfzQRGZ6fVfmRKE8
         em1UYdVA4rEEHqjx8ryoy1/XnwPLHga91HxsahLY42jZyzjiYCu3XYOM7ODxZpXhHM//
         DUD9I+x+VqIDTa5/g/u3kPTH8J6HWBteRNcu2vbAHH64uuN+BAkB56DDooUNeuJVVXUO
         hj7Q==
X-Gm-Message-State: AOJu0YwO4srZy9ciGANRap3K22kEnn5+PRgUzP16wrUtdo6/bA1x0OXk
	7TLqU16JEwC+bdxE48HqS+6R6zNCWz6lUWZH1tB6zGuSFpIfcX8mlFQccrRkhia8d73ZcDVdunP
	bMJCHtXNd60GYpsOZwAEB38y8pO/B3d/njhPO+Q==
X-Google-Smtp-Source: AGHT+IEHJBCriKeLHdESWyjbldGlr/KrnIvjIKeKrARpBoZ5wXfYc8la50wvxNKDwp+NxL7/FwXEt6glvxmRx6CXXYI=
X-Received: by 2002:ac8:5bc9:0:b0:42e:bb8c:6344 with SMTP id
 b9-20020ac85bc9000000b0042ebb8c6344mr214265qtb.9.1710262434782; Tue, 12 Mar
 2024 09:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-7-pasha.tatashin@soleen.com> <f5105c5d-59fb-4bca-af70-353e480f2b12@suse.com>
In-Reply-To: <f5105c5d-59fb-4bca-af70-353e480f2b12@suse.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 12 Mar 2024 12:53:16 -0400
Message-ID: <CA+CK2bD0ShasU0U5gzp_m99V=NAg1o8wAKH3_+1ghZHmsWhL9w@mail.gmail.com>
Subject: Re: [RFC 06/14] fork: zero vmap stack using clear_page() instead of memset()
To: Nikolay Borisov <nik.borisov@suse.com>
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
	tglx@linutronix.de, urezki@gmail.com, vincent.guittot@linaro.org, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 3:16=E2=80=AFAM Nikolay Borisov <nik.borisov@suse.c=
om> wrote:
>
>
>
> On 11.03.24 =D0=B3. 18:46 =D1=87., Pasha Tatashin wrote:
> > In preporation for dynamic kernel stacks do not zero the whole span of
> > the stack, but instead only the pages that are part of the vm_area.
> >
> > This is because with dynamic stacks we might have only partially
> > populated stacks.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >   kernel/fork.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 6a2f2c85e09f..41e0baee79d2 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -263,8 +263,8 @@ static int memcg_charge_kernel_stack(struct vm_stru=
ct *vm)
> >   static int alloc_thread_stack_node(struct task_struct *tsk, int node)
> >   {
> >       struct vm_struct *vm_area;
> > +     int i, j, nr_pages;
> >       void *stack;
> > -     int i;
> >
> >       for (i =3D 0; i < NR_CACHED_STACKS; i++) {
> >               vm_area =3D this_cpu_xchg(cached_stacks[i], NULL);
> > @@ -282,7 +282,9 @@ static int alloc_thread_stack_node(struct task_stru=
ct *tsk, int node)
> >               stack =3D kasan_reset_tag(vm_area->addr);
> >
> >               /* Clear stale pointers from reused stack. */
> > -             memset(stack, 0, THREAD_SIZE);
> > +             nr_pages =3D vm_area->nr_pages;
> > +             for (j =3D 0; j < nr_pages; j++)
> > +                     clear_page(page_address(vm_area->pages[j]));
>
> Can't this be memset(stack, 0, nr_pages*PAGE_SIZE) ?

No, we can't, because the pages can be physically discontiguous.

Pasha

