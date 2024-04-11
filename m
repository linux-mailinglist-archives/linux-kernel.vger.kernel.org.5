Return-Path: <linux-kernel+bounces-140680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4A38A17B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396601F212C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7030815E96;
	Thu, 11 Apr 2024 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCHGrgrW"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B110A12
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846557; cv=none; b=Y48Fl5749wGELKzYY+igrwFyf5O7UWDRkv+01RB6mWRwGm9MrMXXpZSK4Ta+Oa1/FRSdQGB/XxE6wnXSIbmmVecCUL1msQOmZLR8FSGBkqIxdaFuz8gU9oizBFwoZ3Tse1PFbzleyIuQYvaraRqYif1usPeSzIlyzrsIcZzelLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846557; c=relaxed/simple;
	bh=lLmUkBVWQote8gmmiGUoDCeT6ATpdtartPFO4yZyyXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEZt4//pyputFLUU6ucWcROKkO1M4yE3a2V8Qa/eea4ZbCO+8o6I0HNJA7M5oQLqGFiZs/T3W71So2uk8/oGgksIZ3OOjVxBk2R5W8+vhTYKmGqUX4KaIpnZdxvCUBafprCTWMibbDFqgKmzWKrEAPzxPItPH0RlcAI7ioSnaRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FCHGrgrW; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7e6756ec17bso1756875241.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712846555; x=1713451355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8o2ZUqx3sq1IytIXpQ76g0fDLa2ucl5SB8oDkvzy80=;
        b=FCHGrgrWorb5hmHt+Had1a0UWUQ7r5koNWJJNSQpz+AVD0eHcurkTD16VZ5XMLZoDE
         uR6xwmVbiEiIO+GnpiZSwPUAoWz0fL3ZfW1fFvdxXd/X4CCUSB2UbfFwCnCmzYPGKdDs
         dUnq2MXCNjOkIxLKLXXfhV9LoPUbufWJoFs8PonrtK4pMMqv2M+peKBRVWBVc6LFwoKa
         cnz5ObjeqywhsrjwSQgRwtEFTgALC3izdPI+CC5xMqjZK6E4Bf8N0XjAit+ryXAM+eKv
         72qbh0J/fMj6ImRcQz82ptJKHu4keTS9pkfbN6X5vhGuEpKoJRvPSs48OtilQ3b5IBB1
         HqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712846555; x=1713451355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8o2ZUqx3sq1IytIXpQ76g0fDLa2ucl5SB8oDkvzy80=;
        b=bI9FFsez/7x8jOdiBSJV26faAqyoarWaJsLeZ0NSgTU98wspBtwQRQxvZOuVlqpbi3
         oomlRw8n3xO99cUYiIT+m1b15OVbwMb5zzrLjHHolZdYI6eLp1CgXwSUBSHt6WpDgvhN
         tjC0arKHcjm+bw9JwqOCoGcpfUVUN1A/7j6yp3vX3ymssdu2la3DXEcRU/aOokRKqHnt
         Ci3sBYHJpar+e6YLwh/L5TvliomceAn+pYJIArnffqiv8dIcneB1hxckya7X6VICPjfL
         dtVC+z6xJlm4Z3k4i2uzXrWtPPmqaDAVryTwFaiIRTbtbk760rlXHpzWtYf4mo/Yc7d/
         +gwg==
X-Forwarded-Encrypted: i=1; AJvYcCWBpyAVHNKWg3+zanKaexoQlnuGsEGGw0GSN8RpAtzdxp5Qgw6cK1rS03Pbt2YyA2Vy0GwKCbVY6HnOKXYZwbpAP2YoPIkj95uNHaZZ
X-Gm-Message-State: AOJu0Yyt1gw2JRNLRj8Qs2EjakJHeALIvmnbpo4JCBrIEp5ZwESIYLAG
	5FNErVAIcDqGV0awZaUrP7lGGVTmlqDktK/SoDTsIEqgX/cA2/0264wWXznuUTtDOfWPGw4HBdB
	ruJi2OAIHR74sE2weEkpxeJ2RunpoHGqgQixYJw==
X-Google-Smtp-Source: AGHT+IEWN2MWtvcSuVScyg8iDI8sD9qUnP2yw9atfXaadtr2cR3gq/s7TwivZv/5vWqjogoRoq0APGMiT2Md4bTJQZI=
X-Received: by 2002:a1f:e684:0:b0:4c9:c252:6afb with SMTP id
 d126-20020a1fe684000000b004c9c2526afbmr6728636vkh.10.1712846554897; Thu, 11
 Apr 2024 07:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410102710.35911-1-naresh.kamboju@linaro.org>
 <20240410152307.GA25111@willie-the-truck> <CABVgOSmJX=scCGZ7FWafpKB8CdQD17Uh5MuTeoFx2BhGC0DMSw@mail.gmail.com>
In-Reply-To: <CABVgOSmJX=scCGZ7FWafpKB8CdQD17Uh5MuTeoFx2BhGC0DMSw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 11 Apr 2024 20:12:23 +0530
Message-ID: <CA+G9fYuuLXnVuc2fqy_-EY3QBiUxroU9uw74vZ2i08qW=-q1tQ@mail.gmail.com>
Subject: Re: BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq next-20240410
To: David Gow <davidgow@google.com>
Cc: Will Deacon <will@kernel.org>, mic@digikod.net, keescook@chromium.org, 
	rmoar@google.com, lkft-triage@lists.linaro.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	longman@redhat.com, boqun.feng@gmail.com, anders.roxell@linaro.org, 
	dan.carpenter@linaro.org, arnd@arndb.de, linux@roeck-us.net, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Apr 2024 at 09:55, David Gow <davidgow@google.com> wrote:
>
> On Wed, 10 Apr 2024 at 23:23, Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, Apr 10, 2024 at 03:57:10PM +0530, Naresh Kamboju wrote:
> > > Following kernel crash noticed on Linux next-20240410 tag while runni=
ng
> > > kunit testing on qemu-arm64 and qemu-x86_64.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >

<trim>

> >
> > Ok, so 'task_struct->vfork_done' is NULL. Looks like this code was adde=
d
> > recently, so adding Micka=C3=ABl to cc.
> >
>
> Thanks. This looks like a race condition where the KUnit test kthread
> can terminate before we wait on it.
>
> Micka=C3=ABl, does this seem like a correct fix to you?
> ---
> From: David Gow <davidgow@google.com>
> Date: Thu, 11 Apr 2024 12:07:47 +0800
> Subject: [PATCH] kunit: Fix race condition in try-catch completion
>
> KUnit's try-catch infrastructure now uses vfork_done, which is always
> set to a valid completion when a kthread is crated, but which is set to
> NULL once the thread terminates. This creates a race condition, where
> the kthread exits before we can wait on it.
>
> Keep a copy of vfork_done, which is taken before we wake_up_process()
> and so valid, and wait on that instead.
>
> Fixes: 4de2a8e4cca4 ("kunit: Handle test faults")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: David Gow <davidgow@google.com>

This patch tested on top of Linux next and reported issues fixed.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

> ---
> lib/kunit/try-catch.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index fa687278ccc9..fc6cd4d7e80f 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -63,6 +63,7 @@ void kunit_try_catch_run(struct kunit_try_catch
> *try_catch, void *context)
> {
>        struct kunit *test =3D try_catch->test;
>        struct task_struct *task_struct;
> +       struct completion *task_done;
>        int exit_code, time_remaining;
>
>        try_catch->context =3D context;
> @@ -75,13 +76,14 @@ void kunit_try_catch_run(struct kunit_try_catch
> *try_catch, void *context)
>                return;
>        }
>        get_task_struct(task_struct);
> +       task_done =3D task_struct->vfork_done;
>        wake_up_process(task_struct);
>        /*
>         * As for a vfork(2), task_struct->vfork_done (pointing to the
>         * underlying kthread->exited) can be used to wait for the end of =
a
>         * kernel thread.
>         */
> -       time_remaining =3D wait_for_completion_timeout(task_struct->vfork=
_done,
> +       time_remaining =3D wait_for_completion_timeout(task_done,
>                                                     kunit_test_timeout())=
;
>        if (time_remaining =3D=3D 0) {
>                try_catch->try_result =3D -ETIMEDOUT;
> --

--
Linaro LKFT
https://lkft.linaro.org

