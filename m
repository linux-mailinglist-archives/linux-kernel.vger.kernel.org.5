Return-Path: <linux-kernel+bounces-105435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E4487DDD5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9D41C208F8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE3F1C69D;
	Sun, 17 Mar 2024 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="E7CpAeJk"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F3A1BC3E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710688519; cv=none; b=L73srDQaCjv+O2tQeHUSEe5uOIFzgmaJW+THzf0pY5Ig951GvzjlU7kZ2zCeT7K89tdWooa3OnlHw1bOGg5pl9p3Ak9UQym/0uUSpDtT39j2DIPmuhIeDktJMkFIcyntPpt2s/YlTQha4DCbuc7i1w8A+IW9nUWpGux0JymhAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710688519; c=relaxed/simple;
	bh=kaYuKya9UBwriBUHa6o1pYqZcxX4fV9WUX+UUTj66MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1GHErp8V1Yxp9oCPpwDEnJADPYKRPHGiKeoBHD8rR9r9+EkH5blLuMPT/e25UJJV/AENqnzIGJOQLPpeoYNPsfDG9UKK69Y6vLG7o8Proq/J6AHfvfchEgR/virWhVflqhDpgY63SxmlUiHofgi8rSo0uSZo/3VDfqaN8zbIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=E7CpAeJk; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-430c45ab240so5769801cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710688517; x=1711293317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8Bq8ricK7SpfnlrwZMSGXpOWpIDbDpoqdg8e9TW9uQ=;
        b=E7CpAeJkmtbme8jISPd22wjBt0+y+vul46MqIqDxZTDEUgH4/Aa8kJ+P7+M6OfGOEP
         7x5K7HqPUZyjpHphiPQN7ZpWIvs0Ii1sy/VQNNKVMWgECD0OAvobIqbfrPG7HjhKkV/4
         an8ILbMbb4n4yJAnXPrN1zQj0744Mwj1J6ktlRqGT8Jtg/g5wUTXGJMCofFLfINVLqMn
         599UH3F0ddU1ODbF18skzOWtqTtiy6iVSq0sdyoIRcJun0cZPyBoTvvKx7bMePSrvWS9
         HrQWwtz5jWoMCGE8LUJq7lT3BalyXDYW+rxV6I8+sikk3ojGyJjrA9lEW68fIPZb7Nnd
         l6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710688517; x=1711293317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8Bq8ricK7SpfnlrwZMSGXpOWpIDbDpoqdg8e9TW9uQ=;
        b=crA4lIh1eAWhNt3znMN1HVq1OV+jZwrN6Nicg7+5GOqP7qlgqWExZV+xobbBBsM+8k
         kXypwbit2huEmCvFrZkzfWizQwZq3To8iYgOYBuyoheWSNcWfbPA4oFuXCpP3ce7T9jj
         Bsv7RQSUxqq1PxwY0KFVl8LF98fpZOWvfaSeXbX72UvFEh19aWAa3pMF48cjocNTSQMr
         QdXMDMLM5T4nh1cDY+MYatEAfu9kbIxkFmuTRUSgJFAB2iXm8wDUGfCx4+OPqa8BI09N
         OM8w4iYzi8fBOtHNqolexbzlMch6m309sNjRkHEmvaKYIK4eaQHY9jGXVIHHc+zMQxMl
         fUag==
X-Gm-Message-State: AOJu0Yzcm7EUwK9odp1mEaPFikVgWlEwM4irJKFeGbeDfcX+q6HMJYbV
	wu6koSPzEvr1p3PF5T2u3nihVOKCaWnVPgJhk2mbQZvnnCG98Vd7Yp12kbbicbM4X1iuRMK0s08
	tlDX9QFWt5GaqQaCir8+E2cw8pSjIz/KWxv0HkQ==
X-Google-Smtp-Source: AGHT+IHRAPcydBRpMUFgj5XZjiHwDEp09zHAlmm3AVMyNFl3KpX/jkVv43SatvVAp1AB+6jpq5N7cgzHOWpDQKo/lD0=
X-Received: by 2002:a05:622a:47cd:b0:430:c139:ba12 with SMTP id
 dp13-20020a05622a47cd00b00430c139ba12mr5702897qtb.1.1710688517145; Sun, 17
 Mar 2024 08:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-5-pasha.tatashin@soleen.com> <0c6974b4-ba1f-474c-aed4-6c06d26ddb0a@wanadoo.fr>
In-Reply-To: <0c6974b4-ba1f-474c-aed4-6c06d26ddb0a@wanadoo.fr>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 17 Mar 2024 11:14:41 -0400
Message-ID: <CA+CK2bANnehyxC4qqgG3Qsj7UwM81PMQRkX_XrkZb=RoK7re5A@mail.gmail.com>
Subject: Re: [RFC 04/14] fork: Remove assumption that vm_area->nr_pages equals
 to THREAD_SIZE
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

On Sun, Mar 17, 2024 at 10:45=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 11/03/2024 =C3=A0 17:46, Pasha Tatashin a =C3=A9crit :
> > In many places number of pages in the stack is detremined via
> > (THREAD_SIZE / PAGE_SIZE). There is also a BUG_ON() that ensures that
> > (THREAD_SIZE / PAGE_SIZE) is indeed equals to vm_area->nr_pages.
> >
> > However, with dynamic stacks, the number of pages in vm_area will grow
> > with stack, therefore, use vm_area->nr_pages to determine the actual
> > number of pages allocated in stack.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >   kernel/fork.c | 18 +++++++++---------
> >   1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 60e812825a7a..a35f4008afa0 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -243,13 +243,11 @@ static int free_vm_stack_cache(unsigned int cpu)
> >
> >   static int memcg_charge_kernel_stack(struct vm_struct *vm)
>
> Maybe s/vm/vm_area/ as done in 03/14?

Yes, I will add it to 03/14.

Thank you,
Pasha

>
> CJ
>
> >   {
> > -     int i;
> > -     int ret;
> > +     int i, ret, nr_pages;
> >       int nr_charged =3D 0;
> >
> > -     BUG_ON(vm->nr_pages !=3D THREAD_SIZE / PAGE_SIZE);
> > -
> > -     for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> > +     nr_pages =3D vm->nr_pages;
> > +     for (i =3D 0; i < nr_pages; i++) {
> >               ret =3D memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL, =
0);
> >               if (ret)
> >                       goto err;
> > @@ -531,9 +529,10 @@ static void account_kernel_stack(struct task_struc=
t *tsk, int account)
> >   {
> >       if (IS_ENABLED(CONFIG_VMAP_STACK)) {
> >               struct vm_struct *vm =3D task_stack_vm_area(tsk);
> > -             int i;
> > +             int i, nr_pages;
> >
> > -             for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> > +             nr_pages =3D vm->nr_pages;
> > +             for (i =3D 0; i < nr_pages; i++)
> >                       mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STA=
CK_KB,
> >                                             account * (PAGE_SIZE / 1024=
));
> >       } else {
> > @@ -551,10 +550,11 @@ void exit_task_stack_account(struct task_struct *=
tsk)
> >
> >       if (IS_ENABLED(CONFIG_VMAP_STACK)) {
> >               struct vm_struct *vm;
> > -             int i;
> > +             int i, nr_pages;
> >
> >               vm =3D task_stack_vm_area(tsk);
> > -             for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> > +             nr_pages =3D vm->nr_pages;
> > +             for (i =3D 0; i < nr_pages; i++)
> >                       memcg_kmem_uncharge_page(vm->pages[i], 0);
> >       }
> >   }
>

