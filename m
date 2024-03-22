Return-Path: <linux-kernel+bounces-111028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AED8886722
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAFC6B221AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FAC10A13;
	Fri, 22 Mar 2024 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1cX5WG3"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0D2C122
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090321; cv=none; b=k7mq2/QtSzuPDWNWa4fIWjZKepbtbKN+0VCXVaye6jrViJMKV7Pm+c4v0QZMUSJx76NCmgn0EkhEeD0Px/0NwtqxuwXbgEhvJzlaBLeTksYdJymJOd33IdQIwqLa+FIoSQ8qOs8t5jBMqkkeeCo5PwzXxBfTCEXiCTwa/7svbbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090321; c=relaxed/simple;
	bh=3DB8/ndZ0hG0UTqmuHZpyySgdPsVbc/GtAqRomnPTXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8lvnTsCh2a4PZZ67O1zZvFBlFLztHbTc9YZ2w0rIoQtaAUCCBIvuG59R5GZVlP3hE+vPVXlwRt0L+aGp00PPimdsVjqsRJ+H4md9smIG0/P+CQs41ygTrtdjrjf+Ju/m1K4viIeBZr573V5JehzLd9wZmx4SmT7ivPHepZ9aC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1cX5WG3; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d68651e253so29480611fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711090318; x=1711695118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQYvnqPpmPRWALIPbnGUWqhvcfelCVUDC4x4RzHf1c4=;
        b=O1cX5WG3GINoI5WKT+/KfvTxk6g3ECCaT9ZOj+bCG4qvTNDKGCGyru6c2HAPPZ0mdv
         YW5MYNcj8B65FtauAMf2PJxMOQtX2qLcwNyY2IeC2nSw+vboqzYIo4faqO3ez3EbxCzJ
         h1M0AOStSUqP4xMsZtVM51zkxVlOjDVaWwPBcrWAIpMJuZzw2IUPH1IHevXkZyrLHywF
         5npIKtJxjHoxtQDTtYUhBqpymXgUpEe9LorUlxl1R5c5ADWB/ksIC1T2OWBEk2EwC2MK
         j1hL/7NKyM8oC/WqMfE9ShjZYq7dqWGfGMz8LNZkyjCw1nhI2E63SB126oF5q6RLOr7p
         3WRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711090318; x=1711695118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQYvnqPpmPRWALIPbnGUWqhvcfelCVUDC4x4RzHf1c4=;
        b=nkHqAPL7ty2F0m9VnDybXfsEaFb7lrh9ipD7pvm2XlAPgDlQojfZs1sLabC86YGrDE
         dTUup3CYARZWcFXZLtPWUtRSGaDY8Gv537A3UkVfeQgvmu1dSHKIJXDTZSWFhz0YyNI+
         TzzYle5HV25B/jw/qxvWn2BttSxgs+JRkhVWfa0nbM0Rvj5hz4NWJmYAxXaKmTVtw27B
         MMOlYk3KIy2ZRxr+N9TcVx5RpJ1X3mJjG09sWa9sDXlvcN/KcBgAXzn5uEIicyFPkg/9
         bVCgqmBI0Eepec+HAIzgawnRnsV88l0ln4/Llu+DdAoiOGeSfIlqBzYhyhCvPdXcy2/Y
         6/kg==
X-Gm-Message-State: AOJu0YwEbIvmJYUmuWl/KVMU6MmoNuJSgayj3Ks7nU4t/mC6OtX7pWhT
	gcuHZ7XH0MR/vWrbqmY+jvwstrHA8qsjUa1vtKDa4qxfyGuim0rcojP7X+AEguajup68btMU62o
	a1FRp+z1SPH3yHFvK1bP9Y/8oe8U=
X-Google-Smtp-Source: AGHT+IEUt9qXKfVdL6qrszu3OWdUns6CEVkOKC8OzVNPx+yIVChJwzNMgpLLICUyb+x3Nmm6QZDop9EP7+IGNg+rrh0=
X-Received: by 2002:a2e:9c0a:0:b0:2d3:1dcc:3b25 with SMTP id
 s10-20020a2e9c0a000000b002d31dcc3b25mr1011497lji.10.1711090317606; Thu, 21
 Mar 2024 23:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321195309.484275-1-ubizjak@gmail.com> <feb68b86-899e-42a2-a680-4a73366e540d@redhat.com>
In-Reply-To: <feb68b86-899e-42a2-a680-4a73366e540d@redhat.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 22 Mar 2024 07:51:45 +0100
Message-ID: <CAFULd4aR_zmUneh=3RKHnbT=8Fc_kCkLHs54aUVjfXoAJdXdGQ@mail.gmail.com>
Subject: Re: [PATCH] locking/qspinlock: Use atomic_try_cmpxchg_relaxed() in xchg_tail()
To: Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 12:52=E2=80=AFAM Waiman Long <longman@redhat.com> w=
rote:
>
> On 3/21/24 15:52, Uros Bizjak wrote:
> > Use atomic_try_cmpxchg_relaxed(*ptr, &old, new) instead of
> > atomic_cmpxchg_relaxed (*ptr, old, new) =3D=3D old in xchg_tail().
> > x86 CMPXCHG instruction returns success in ZF flag,
> > so this change saves a compare after cmpxchg.
> >
> > No functional change intended.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >   kernel/locking/qspinlock.c | 13 +++++--------
> >   1 file changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> > index ebe6b8ec7cb3..1df5fef8a656 100644
> > --- a/kernel/locking/qspinlock.c
> > +++ b/kernel/locking/qspinlock.c
> > @@ -220,21 +220,18 @@ static __always_inline void clear_pending_set_loc=
ked(struct qspinlock *lock)
> >    */
> >   static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail=
)
> >   {
> > -     u32 old, new, val =3D atomic_read(&lock->val);
> > +     u32 old, new;
> >
> > -     for (;;) {
> > -             new =3D (val & _Q_LOCKED_PENDING_MASK) | tail;
> > +     old =3D atomic_read(&lock->val);
> > +     do {
> > +             new =3D (old & _Q_LOCKED_PENDING_MASK) | tail;
> >               /*
> >                * We can use relaxed semantics since the caller ensures =
that
> >                * the MCS node is properly initialized before updating t=
he
> >                * tail.
> >                */
> > -             old =3D atomic_cmpxchg_relaxed(&lock->val, val, new);
> > -             if (old =3D=3D val)
> > -                     break;
> > +     } while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));
> >
> > -             val =3D old;
> > -     }
> >       return old;
> >   }
> >   #endif /* _Q_PENDING_BITS =3D=3D 8 */
>
> LGTM, note that this xchg_tail() variant is not used in all the distros
> that I am aware of as it requires NR_CPUS >=3D 16k.

Yes, I am aware of this. I have tested the patch simply by
unconditionally setting _Q_PENDING_BITS to 1 in
include/asm-generic/qspinlock_types.h.
>
> Reviewed-by: Waiman Long <longman@redhat.com>

Thanks,
Uros.

