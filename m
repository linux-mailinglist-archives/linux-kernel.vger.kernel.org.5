Return-Path: <linux-kernel+bounces-25235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B7482CAC9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C680F28329D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29D9A38;
	Sat, 13 Jan 2024 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vn5YEivO"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BB57E8
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7ce9defc4c2so917275241.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 01:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705137849; x=1705742649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mG8ngPgKidpc6DG7VcOonL9w+Hnp78zOGjk/tfdl9Tw=;
        b=vn5YEivOcF8tWeywC6GM7xeJ9UkzFwXVY3EBfbU6t+Jntvf83lg3G19hn1y+vDMgoZ
         c2EM8RshJsdMvlvFOFt9z28m5zeKGwxQR+uTUWNEU72bRdUpLLEpxb+7g95TkKo7rtfg
         C+OY1qvnhha8jhBz1HkZ7WCob4pkBCvfYaciC2OEsYhjvjXAYQxnR4u9MOi4lton4fYC
         o/V5dAbxb1WgrqW/9fSvdzeNDcf8bmHfPpqp0i/O29/VgoaZeYrzt8Tk1yimZz4p+v7Z
         BlbfgUZNZBRjkaMSgalfi3+yvvAMmDgGDqK3z2dO0Hy5BSl9uS154jilYuIY8GYlBv3F
         wo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705137849; x=1705742649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mG8ngPgKidpc6DG7VcOonL9w+Hnp78zOGjk/tfdl9Tw=;
        b=arzTqOzR/gsMXnr0lYsAeiaO+4z+TVzgMNDoy2YAu6dAx052QSgCJBYTYLmUIg0LgZ
         GEBRBu7SKsyvDzVTxYAXrVsR9bzrRSoGNFo/6ms6ycQLOdUHR19Y/O9j4/hzbc9hfoia
         YGqdncf3oN3MNGYpttLNaZ1asF4Kt3/JaIvohZbxptQMcO3Cso4EmH9QKhoLNNb6ljeO
         P/3CuENUNJnSL32cm9Hjtrdsxw+hyR6Q68RPsTBI5DNW0BJy+vTwQxTxEQ4RnatoaoZz
         d8zAmyrK9sE4sCJud1rxTKrorWCuFUFfRd5T9Y4ubXFKetKIjg32MIKm8NAF6e9qiXou
         htrw==
X-Gm-Message-State: AOJu0YwDuhzoCt5mjfzD6ldqmQOhQ4TVTQ1RXagXAR2GaZlJp3hMiKE4
	HOyr9U7uZDz/RtElWk1omMRFz8bGWSGAmb+vrMVyFrafjXMf
X-Google-Smtp-Source: AGHT+IHQmzh1pZteKXgvH8dJwsS4sgNEfW4HehyT02ehbFX36vyKPNHczzlDSgTkhiJtalxLJyxvkky7vwxMGQoFV4s=
X-Received: by 2002:a05:6122:4308:b0:4b6:f1e0:956 with SMTP id
 cp8-20020a056122430800b004b6f1e00956mr1346224vkb.17.1705137849491; Sat, 13
 Jan 2024 01:24:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZUlgs69iTTlG8Lh@localhost.localdomain> <87sf34lrn3.fsf@linux.intel.com>
 <CANpmjNNdWwGsD3JRcEqpq_ywwDFoxsBjz6n=6vL5YksNsPyqHw@mail.gmail.com>
 <ZZ_gssjTCyoWjjhP@tassilo> <ZaA8oQG-stLAVTbM@elver.google.com>
 <CA+fCnZeS=OrqSK4QVUVdS6PwzGrpg8CBj8i2Uq=VMgMcNg1FYw@mail.gmail.com>
 <CANpmjNOoidtyeQ76274SWtTYR4zZPdr1DnxhLaagHGXcKwPOhA@mail.gmail.com>
 <ZaG56XTDwPfkqkJb@elver.google.com> <ZaHmQU5DouedI9kS@tassilo>
 <CANpmjNO-q4pjS4z=W8xVLHTs72FNq+TR+-=QBmkP=HOQy6UHmg@mail.gmail.com> <ZaJVqF-_fJ_O3pJK@tassilo>
In-Reply-To: <ZaJVqF-_fJ_O3pJK@tassilo>
From: Marco Elver <elver@google.com>
Date: Sat, 13 Jan 2024 10:23:31 +0100
Message-ID: <CANpmjNOz7tBMK-HoyZNVR2KcgxEBY1Qym=DRa9gHLFkaNHLmVw@mail.gmail.com>
Subject: Re: [PATCH v4 12/22] lib/stackdepot: use read/write lock
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Oscar Salvador <osalvador@suse.de>, andrey.konovalov@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Jan 2024 at 10:19, Andi Kleen <ak@linux.intel.com> wrote:
>
> On Sat, Jan 13, 2024 at 10:12:21AM +0100, Marco Elver wrote:
> > On Sat, 13 Jan 2024 at 02:24, Andi Kleen <ak@linux.intel.com> wrote:
> > >
> > > On Fri, Jan 12, 2024 at 11:15:05PM +0100, Marco Elver wrote:
> > > > +             /*
> > > > +              * Stack traces of size 0 are never saved, and we can simply use
> > > > +              * the size field as an indicator if this is a new unused stack
> > > > +              * record in the freelist.
> > > > +              */
> > > > +             stack->size = 0;
> > >
> > > I would use WRITE_ONCE here too, at least for TSan.
> >
> > This is written with the pool_lock held.
>
> ...which doesn't help because the readers don't take it?

This function is only refilling the freelist. Readers don't see it yet
because it's in none of the hash table buckets. The freelist is only
ever accessed under the lock.

Once an entry is allocated from the freelist, its size is overwritten
with something non-zero (since it then contains a stack trace). Those
updates are released into the right hash table bucket with
list_add_rcu() (which implies a release).

Am I missing something else?

