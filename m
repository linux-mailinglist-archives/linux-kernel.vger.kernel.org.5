Return-Path: <linux-kernel+bounces-10443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C3D81D474
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F0F1C2108D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA80FC1D;
	Sat, 23 Dec 2023 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfejQFLy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30549F9F7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so2459110f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 06:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703340789; x=1703945589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hx/fXV+EcHbqpmmSYcyDXOeCutL7EPAM7xBLrv4uEvE=;
        b=BfejQFLyOA5EmkBCyc/rkh6eDytFQUyGrM/vx6P1c/0F6JYTUkEdy8pAfk0o9mqzp9
         rOuAHgf7oE8kaBYuDs44wbvJuNdJQPx+HfDpVd8jPDPq1tlpTUzHY8fu9s0yxW90aBxY
         R3ZyRiSobj0Up8CTajNz9jE4QdJDjcnwRA0whHwd8VU+yhNuOV+EBXvHpbgRV8yZnOGZ
         bwq/uZiHScHN2sPWG44w/DcRQjnoLxev7l9o48OUuGXQbXvmQT8FKvte4guTjBnTdbge
         BF4c+1MGRKyiAyIcm+3BacXm2qJGxAWwJuz9Pj1lF1ccKXexcIEYzSaR25YSUtO2LTfq
         y20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703340789; x=1703945589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hx/fXV+EcHbqpmmSYcyDXOeCutL7EPAM7xBLrv4uEvE=;
        b=Tb2MtED21+RdHiABCzHAL0gyEENESTmKcN/vCeDdvjFD+s1akD7M50+5W356RU7rCf
         D8B19hBXBeNNlj9rdcYz8UeEm5TaaNj85jq6ZgPVWfbelgVHtXr07XRJc5enQL+lXHgF
         8Gcm37PwtLB2kOoHNh62MkazcaiG8ZT8hG+k/+flz9rWVlsVTZ6oEhudBB+ZjDbbk5WJ
         +OOZwcIc6R2F1ftbBNZy3tfod+VlNkx1bRRk9b2WI74oGrlh4h3hyf2TzglAGvIe/dbQ
         3ySFmhyutM2HbBtMYLSoT6qN8xQwpKuYTa1gdZwpfisqdrekutpy3vNLSESjtpYSbvbX
         XDqA==
X-Gm-Message-State: AOJu0YzFQ7pjTqGDWN5/ULEP6mhAc9zRvMTygCJT+5EQCbMEiA9zEnw6
	AvY4yM8sUbdozUg5tLgB4PxkXBZVADdVjYcLa6s=
X-Google-Smtp-Source: AGHT+IGKownDA4mfkro4cu5rzFhqLlgkNKQlWWqXk9ocl5lvBdywEBVaC92dZcqf5TAFfjHMIEkpunJcbQsrPBeKmYk=
X-Received: by 2002:a05:6000:1148:b0:333:5d14:458 with SMTP id
 d8-20020a056000114800b003335d140458mr1535005wrx.86.1703340789237; Sat, 23 Dec
 2023 06:13:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221130930.32634-1-ruipengqi7@gmail.com> <e9aa311f-6f13-410e-bb35-20320275668c@linaro.org>
In-Reply-To: <e9aa311f-6f13-410e-bb35-20320275668c@linaro.org>
From: ruipeng qi <ruipengqi7@gmail.com>
Date: Sat, 23 Dec 2023 22:12:57 +0800
Message-ID: <CADHLONGLZaZT4Ot56AnxOf=ROrTWvge5=NUx5uqKqJhpJibfOQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] [RFC PATCH 1/7] osdump: Add one new os minidump module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org, bhe@redhat.com, 
	vgoyal@redhat.com, dyoung@redhat.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, zalbassam@google.com, dianders@chromium.org, 
	mark.rutland@arm.com, lecopzer.chen@mediatek.com, maz@kernel.org, 
	arnd@arndb.de, yury.norov@gmail.com, brauner@kernel.org, mcgrof@kernel.org, 
	maninder1.s@samsung.com, michael.christie@oracle.com, samitolvanen@google.com, 
	linux-arm-kernel@lists.infradead.org, qiruipeng@lixiang.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 12:25=E2=80=AFAM Krzysztof Kozlowski <krzysztof.koz=
lowski
@linaro.org> wrote:
> > Osdump is a new crash dumping solution aiming at specific embedded
> > devices within automotive or Industrial.
> >  - limited memory.
> >  - reboot as soon as possible when system fault.
>
> NAK, sorry, work with Qualcomm minidump series to incorporate all your
> needs there.

Sorry, I didn't explain it properly. Will add more descriptions in the
next version. Osdump is a totally different mindump, which aims at
helping to solve kernel issues as easy as kdump/kexec/crash, but
with little costs.

For something like Pstore, you can get where the issue occurs. You can
figure out the problem if it is easy, but sometimes you can't. For example:

<4>[    5.311431]  task_blocks_on_rt_mutex+0x234/0x380
<4>[    5.316166]  rt_spin_lock_slowlock_locked+0xcc/0x2b0
<4>[    5.321257]  rt_spin_lock_slowlock+0x5c/0x90
<4>[    5.325633]  rt_spin_lock+0x60/0x74
<4>[    5.329207]  refill_stock+0x58/0x230

You can find where the issue occurs.
static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex *=
lock)
 {
  struct rb_node *leftmost =3D rb_first_cached(&lock->waiters);
  struct rt_mutex_waiter *w =3D NULL;
  if (leftmost) {
    w =3D rb_entry(leftmost, struct rt_mutex_waiter, tree_entry);
    BUG_ON(w->lock !=3D lock);

But you don't know why w->lock and lock are different, and who is wrong.

Qcom minidump can dump some logs like dmsg, some status like IRQ or
Run queue. This can help to learn some information when the issue occurs,
which will help to find out the root cause. But what it dumps are limited, =
it
doesn't dump w and lock if they are not local data.

For osdump, it dumps objects stored in slab, datas in bss, data segments,
some data alloced with memblock, data stored in local stack, and so on.
In a word, it dumps almost all of the key data in the kernel. Besides, you
can use the crash tool to analyze the dump file.

In a word, I think this toal different minidump should have its own place i=
n
the kernel world. Looking forward to your suggestions!

Best Regards
Ruipeng

