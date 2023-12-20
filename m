Return-Path: <linux-kernel+bounces-6735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8DC819CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E062EB22779
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AB820DDD;
	Wed, 20 Dec 2023 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re+mpk6B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844120DC5;
	Wed, 20 Dec 2023 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cc7ba7d12eso22968931fa.3;
        Wed, 20 Dec 2023 02:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703067706; x=1703672506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjP4BivF3NvMA8KjGdZtlr0xWlFt2nGJ42O2nCWwR7A=;
        b=Re+mpk6Bn2Ki8ALDmFy7/s3InY7LwBvPSH0ChiZBlIb8BlPIWL9BN++0i8w0JElPdZ
         RygXUo3JYCXJmHznvejg5PydK5UhFBzk0o6yTWcmeBqrLJRNaUVkvNUxKgsoRXsu1M07
         6C0O/rVvCo6XH8VV04GjEpseCFU4KmbXPvaMjTJtpSRuOOGQPkLhdm1HQ+njwffr7U/L
         UFXJ59or1q8A/XgloRGqxPqNiuDHpfH1paoeWSA0KPTIiZNtM2kzvy5t0WBOI8dO0kxv
         AGuXuHLvguTQItvM4EwdJVu45V4MHIeiYlIEY+FzZvQUzlsaueFuAkKdpaZp57ySeAAj
         OgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703067706; x=1703672506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjP4BivF3NvMA8KjGdZtlr0xWlFt2nGJ42O2nCWwR7A=;
        b=KdolsF/XM3lp4g1ub78GGbE+BStBLr0XkfA2dZyf1SB44dVnhcA/hvtMspv9UY/QoK
         Z4oZnp2Iqent7U0PaCBRDsUXLSNIwOBEBOh3oxaD0Fz1S+EtIXahmur6ibN+vY5JGZv8
         C2VsAW1NWF+7dLoRzse+Cu95e+81/4XuOLmh7Z3avobM4B6PHoG0V/0tln1QU8I5N4Qy
         6C4upG0jgomS9rOOjJ5DNDxPCE0gySVR+IGfahN4fOS+WSuJjj3u1TXzhH3qWKg43yct
         YAyDXlw+eAG0uWLyj0v58zVCzgzxpGVYMH6H0TU7TYup4R4SNKnL4HoMvD8Ja0zFdNfb
         hR3w==
X-Gm-Message-State: AOJu0YwfkrfBtu/gMQ0Iu4zvHzjA/XmDmu1tI382OfS1ZE8hJfxxXSk3
	hSE+O6EeakUedKnlepI+PmsM9DZkeK+hdjXM0qY=
X-Google-Smtp-Source: AGHT+IHAeWZiDakq7KAXRyOAa2WwdZ/7tMmIYpc1yJtLL44QdSxo63hpyp7uSyhltJOH/voGvf6b3wES+bo5VcSeCBk=
X-Received: by 2002:a2e:9ec4:0:b0:2ca:1a1:c286 with SMTP id
 h4-20020a2e9ec4000000b002ca01a1c286mr6138374ljk.74.1703067705684; Wed, 20 Dec
 2023 02:21:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
 <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
 <CAMgjq7AjO=Z4Wa3DYaOJdWA+8aNQ1JHZQYKYOm5-SvvgPPOGKg@mail.gmail.com> <CAF8kJuN=E0RA_JyVnAVraYSyHx5sk=znM2A-JKnAfDc4M2BYGg@mail.gmail.com>
In-Reply-To: <CAF8kJuN=E0RA_JyVnAVraYSyHx5sk=znM2A-JKnAfDc4M2BYGg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 20 Dec 2023 18:21:28 +0800
Message-ID: <CAMgjq7BXXSHKJXijpB_FfNA9N=dh5uWHBJmHrJKoLOShrqvDYA@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To: Chris Li <chrisl@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, tj@kernel.org, 
	lizefan.x@bytedance.com, hannes@cmpxchg.org, cerasuolodomenico@gmail.com, 
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeelb@google.com, muchun.song@linux.dev, hughd@google.com, corbet@lwn.net, 
	konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, david@ixit.cz, Minchan Kim <minchan@google.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=B8=89 07:39=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Kairui,
>
> Thanks for sharing the information on how you use swap.

Hi Chris,

>
> On Mon, Dec 11, 2023 at 1:31=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> > > 2) As indicated by this discussion, Tencent has a usage case for SSD
> > > and hard disk swap as overflow.
> > > https://lore.kernel.org/linux-mm/20231119194740.94101-9-ryncsn@gmail.=
com/
> > > +Kairui
> >
> > Yes, we are not using zswap. We are using ZRAM for swap since we have
> > many different varieties of workload instances, with a very flexible
> > storage setup. Some of them don't have the ability to set up a
> > swapfile. So we built a pack of kernel infrastructures based on ZRAM,
> > which so far worked pretty well.
>
> This is great. The usage case is actually much more than I expected.
> For example, I never thought of zram as a swap tier. Now you mention
> it. I am considering whether it makes sense to add zram to the
> memory.swap.tiers as well as zswap.
>
> >
> > The concern from some teams is that ZRAM (or zswap) can't always free
> > up memory so they may lead to higher risk of OOM compared to a
> > physical swap device, and they do have suitable devices for doing swap
> > on some of their machines. So a secondary swap support is very helpful
> > in case of memory usage peak.
> >
> > Besides this, another requirement is that different containers may
> > have different priority, some containers can tolerate high swap
> > overhead while some cannot, so swap tiering is useful for us in many
> > ways.
> >
> > And thanks to cloud infrastructure the disk setup could change from
> > time to time depending on workload requirements, so our requirement is
> > to support ZRAM (always) + SSD (optional) + HDD (also optional) as
> > swap backends, while not making things too complex to maintain.
>
> Just curious, do you use ZRAM + SSD + HDD all enabled? Do you ever
> consider moving data from ZRAM to SSD, or from SSD to HDD? If you do,
> I do see the possibility of having more general swap tiers support and
> sharing the shrinking code between tiers somehow. Granted there are
> many unanswered questions and a lot of infrastructure is lacking.
> Gathering requirements, weight in the priority of the quirement is the
> first step towards a possible solution.

Sorry for the late response. Yes, it's our plan to use ZRAM + SSD +
HDD all enabled when possible. Alghouth currently only ZRAM + SSD is
expected.

I see this discussion is still going one so just add some info here...

We have some test environments which have a kernel worker enabled to
move data from ZRAM to SSD, and from SSD to HDD too, to free up space
for higher tier swap devices. The kworker is simple, it maintains a
swap entry LRU for every swap device (maybe worth noting here, there
is currently no LRU bases writeback for ZRAM, and ZRAM writeback
require a fixed block device on init, and a swap device level LRU is
also helpful for migrating entry from SSD to HDD). It walks the page
table to swap in coldest swap entry then swap out immediately to a
lower tier, doing this page by page periodically. Overhead and memory
footprint is minimal with limited moving rate, but the efficiency for
large scaled data moving is terrible so it only has very limited
usage. I was trying to come up with a better design but am currently
not working on it.

