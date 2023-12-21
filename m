Return-Path: <linux-kernel+bounces-9043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DDA81BF87
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D241C21934
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BD2745E5;
	Thu, 21 Dec 2023 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/HUI2LY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D77318F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d4bef65786so1098262b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703190158; x=1703794958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJf9nuaR/XCC7BWiN5csd+/5Qq/ivgehUMmQB0WS6r4=;
        b=U/HUI2LY0LwQufOIzfg5Hl6QOcu7ETQgamTuWL/DoRWtK+d05Uj52+oILNfHeJs8TM
         kaoHLB5IXCRZMssK4Z9RcJlbJ31Ydav4JwyXte24YOff+Cy+T0GvZLH5BxblCJcDExNS
         qz2nTqHbgaMhQApdEhi3Hcv/l5OQYQT39AVGvb4RQSOjAspF9oHnq7isxDdYBVd+xd6I
         HGJvFvszK1ZklQsjeZtGygddWq/L38z4WEtyFLaCdpjGv8tEC9Mh3XhFXzJDeGhL7E07
         G06QDjENbssfsdUKNz4t7wZ1HFTRDh0T1o01HHE3KSQH6B33ik/nAAv8tOHB2cpuDWRN
         +H1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703190158; x=1703794958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJf9nuaR/XCC7BWiN5csd+/5Qq/ivgehUMmQB0WS6r4=;
        b=O4NDpfv7ZLmE9BhlVqxcvZxgsfbr3iz8eNRT+bBwzcL4hM9vw3p5Bq2zF5Oo/5aJKj
         sH6HmtcU/c5UnhFvwf+S/N/hjpIia4JYgeEz8qSreYkrbV2MTWOriw3yrayJYs3ctdoX
         YekxivKEq3l5MgkjOryLayRdEMGipJm20feQkvfJ9gJ3/v7Tdr7R/UJ1cyS69HH/9182
         VmPZ82m3u0ehnqiFtW7zssTkY2WV16jPrxL/2dLBdFPZv2p7YaoHK3GsOOa8pV2dZ7vk
         2ZvZdaqoIZ59ISHu6b063Sf9gF9bCuvIJazZBJ1JX9Nt99EXDz9jMt/1ZXUgNvj9R3Qy
         0t5A==
X-Gm-Message-State: AOJu0YxmAEYI8fGiyZdQOdZlSqokwAq68VhW+2BsZhMgNBdQJaIx7cmZ
	HFDkFXVYdjj+qeuUs7fXznMeMpNnuqMFPgEtJys=
X-Google-Smtp-Source: AGHT+IEH5hVzh22rIwbxWBhyTyjJeCwSanEeVGFAP/K0tRx8IwKn1kh1xbcWq7dft2QuQpTODH5edaTU3AkW9xg6y6Q=
X-Received: by 2002:a62:e703:0:b0:6d9:4598:d1f6 with SMTP id
 s3-20020a62e703000000b006d94598d1f6mr236967pfh.18.1703190158185; Thu, 21 Dec
 2023 12:22:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221183540.168428-1-andrey.konovalov@linux.dev>
 <20231221183540.168428-4-andrey.konovalov@linux.dev> <CANpmjNMJM0zp9qmxh0MkAfKTLgzkcxyraGMp6JKSf9YquW4WMg@mail.gmail.com>
In-Reply-To: <CANpmjNMJM0zp9qmxh0MkAfKTLgzkcxyraGMp6JKSf9YquW4WMg@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 21 Dec 2023 21:22:27 +0100
Message-ID: <CA+fCnZdovMDygNE-ACEd++4Q23BAHp5QKaj6YhD929vTAhEDsQ@mail.gmail.com>
Subject: Re: [PATCH mm 4/4] kasan: simplify kasan_complete_mode_report_info
 for tag-based modes
To: Marco Elver <elver@google.com>
Cc: andrey.konovalov@linux.dev, Andrew Morton <akpm@linux-foundation.org>, 
	Juntong Deng <juntong.deng@outlook.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 9:14=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Thu, 21 Dec 2023 at 19:35, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > memcpy the alloc/free tracks when collecting the information about a ba=
d
> > access instead of copying fields one by one.
> >
> > Fixes: 5d4c6ac94694 ("kasan: record and report more information")
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> > ---
> >  mm/kasan/report_tags.c | 23 ++++-------------------
> >  1 file changed, 4 insertions(+), 19 deletions(-)
> >
> > diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
> > index 688b9d70b04a..d15f8f580e2c 100644
> > --- a/mm/kasan/report_tags.c
> > +++ b/mm/kasan/report_tags.c
> > @@ -27,15 +27,6 @@ static const char *get_common_bug_type(struct kasan_=
report_info *info)
> >         return "invalid-access";
> >  }
> >
> > -#ifdef CONFIG_KASAN_EXTRA_INFO
> > -static void kasan_complete_extra_report_info(struct kasan_track *track=
,
> > -                                        struct kasan_stack_ring_entry =
*entry)
> > -{
> > -       track->cpu =3D entry->track.cpu;
> > -       track->timestamp =3D entry->track.timestamp;
> > -}
> > -#endif /* CONFIG_KASAN_EXTRA_INFO */
> > -
> >  void kasan_complete_mode_report_info(struct kasan_report_info *info)
> >  {
> >         unsigned long flags;
> > @@ -80,11 +71,8 @@ void kasan_complete_mode_report_info(struct kasan_re=
port_info *info)
> >                         if (free_found)
> >                                 break;
> >
> > -                       info->free_track.pid =3D entry->track.pid;
> > -                       info->free_track.stack =3D entry->track.stack;
> > -#ifdef CONFIG_KASAN_EXTRA_INFO
> > -                       kasan_complete_extra_report_info(&info->free_tr=
ack, entry);
> > -#endif /* CONFIG_KASAN_EXTRA_INFO */
> > +                       memcpy(&info->free_track, &entry->track,
> > +                              sizeof(info->free_track));
>
> Not sure why the line break is necessary.

Ah, just the old desire to use 80-column line limit :)

Let's keep this as this for now, but I'll fix it if I end up sending
v2 of this series.

Thanks!

