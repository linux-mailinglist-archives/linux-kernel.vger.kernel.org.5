Return-Path: <linux-kernel+bounces-158488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D00C8B20D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446891F24E01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6519C12B151;
	Thu, 25 Apr 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vl6wdiT9"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD312AAF3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046438; cv=none; b=NQSjMQropsDiv0Z8QkTrRId4nrIAXFWqjj95gd40p+W88vHI1VmC9/HGmt3sOMFxtRtP8o1Aw06JDEUDIRzBWrlFr/KeTRIRDEA1r0x69jWg3VQG6mM66wRZFOkzyEnZYEoeDmj/gCmInMgbJUj8Zsk35P8zIxmV/mzKVkK2Lng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046438; c=relaxed/simple;
	bh=yz3reNGqZHR64SfzCcPbognzfBDQMj6j27eguea4rPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnz9CEuALxdYcEaxd8sKBLRWGyAZ47qRcTqiqR8FctYjhu2dQ9gpD78eTAVIpNCz6yfG8NdrywIzUpg0y2xuf0d26X0Gu2quWrlMeSsidp16fG4FAoP7eGx3dtag7Wu97YI6tKy+I8Q9cgW45DUZKiQFLZSzV7utuhpn0nj9IqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vl6wdiT9; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2dd6c160eaaso10617111fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714046435; x=1714651235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yz3reNGqZHR64SfzCcPbognzfBDQMj6j27eguea4rPg=;
        b=Vl6wdiT9DmxI+oz7X/IE5LGmi/qch0JzxiqdDCag5Fpy7sFVd1kblxxmr1AJWeNa3e
         6izXKX5m4sWsUDmoIoi/zS5WSqFnp0n7F932R8uFWQ14czbleKQarZIRZg+2Axr+T7nG
         fzGKuwv5z4tmcNgL/SOTCv//TwFfaE7HbJLMWA2VQU0y/0BN9DjFkOxECe5mstGrlrrI
         JWtltlY/ehNN3sz9x5emo+Q4XbQ84K3vye5BJOJXNHggrocAkmb4CG/gqr2vVm1LNILc
         M9PPbNU/xqSl/IuEdFo/Uyg5efUm6IJUciidc250ZWHNt2EIWm9YrbaOfVb5DQjjXSKO
         sGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714046435; x=1714651235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yz3reNGqZHR64SfzCcPbognzfBDQMj6j27eguea4rPg=;
        b=u7+kEhgjqS3zOv1sPuoJ6gwhd/Z/ZLlH4bDD/UjyC5Ysq8JnYRmtKgAqqLdO0K6WLP
         f3DzCEDNvPNYWgn0zsTqYSnnVIgZ7VhzC6Oy5JwleFV/rDxGDhjr/NOK0pmhoi8juzoH
         r/V+IKA3fN/1T+qNGx97JsprC2YfQm9QuWU4IoyWbFIpXS6dSIhtu9MXKxzuq1PXoWfE
         4b2uX4BtHP7IJokwAwRL9gczXH4TDIJOlznXw7n+gJ9TgFJcl92WyeY2kxdAL/i646mn
         VRtx0uZemip+R8cAqB3LiNtgv+JoBL4KZYGe2cWWt9Mj7faG+TcMw5jyHd0w/RJLYmzK
         MQZA==
X-Forwarded-Encrypted: i=1; AJvYcCURh3GQQOhEdvfKkjcA0Y5bEG8AuODI+z79EJa2WRYQ6FHdNiO3YQjAY/IK3JIwgVpKNz+0RA7kkkDvsdaPNiZGm1T+WHabF+1/IrD5
X-Gm-Message-State: AOJu0YzxyrlBV9FRvQlbAOLeQ/p4WoYxSWX5YzflLwRSk7CntE6zlgov
	YCMhNBlTCl74Y2lgv5admQRzUzyDv+52u7HItfG373MzHQ0inuXQT4JzisMaPiUaVLkPUilOEAG
	KJLiuXKxFEerzA0GpKq3GDSiHI3w=
X-Google-Smtp-Source: AGHT+IGuFQ8p1l3INQCxTz34lQfNbPhf0hEa7Wzdg8HrAjVcVf0cpVwmvELoG50FznFjTLAg335EOYp6IP7GorGuaEs=
X-Received: by 2002:ac2:5dcc:0:b0:519:5a60:5fe7 with SMTP id
 x12-20020ac25dcc000000b005195a605fe7mr4594534lfq.66.1714046434863; Thu, 25
 Apr 2024 05:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK1f24nb6FkipH3OZa0uwbBWkefS3f2BrJ_GTxkS2j6+6bgODQ@mail.gmail.com>
 <20240425085051.74889-1-ioworker0@gmail.com> <49394660-8455-48ec-8ae1-fbd2d590d27a@redhat.com>
 <CAK1f24kaphS9Gz4Nxe-+=iHs_+CpA1Qk7q=pdzUJKc5u-0_qXw@mail.gmail.com> <e75b509a-bf4f-418c-a921-cf3383fc5929@redhat.com>
In-Reply-To: <e75b509a-bf4f-418c-a921-cf3383fc5929@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 25 Apr 2024 20:00:23 +0800
Message-ID: <CAK1f24njK_=FFTZyCCcZYPosop=WU8WGZHZRtPOk6zJDp2SdCQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/vmscan: avoid split PMD-mapped THP during shrink_folio_list()
To: David Hildenbrand <david@redhat.com>
Cc: ziy@nvidia.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	fengwei.yin@intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	maskray@google.com, mhocko@suse.com, minchan@kernel.org, peterx@redhat.com, 
	ryan.roberts@arm.com, shy828301@gmail.com, songmuchun@bytedance.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiehuan09@gmail.com, 
	zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:25=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> >> I was wondering if we can better integrate that into the pagewalk belo=
w.
> >>
> >> That is, don't do the TTU_SPLIT_HUGE_PMD immediately. Start the pagewa=
lk
> >> first. If we walk a PMD, try to unmap it. Only if that fails, split it=
.
> >
> > Nice. Thanks for the suggestion!
> > I'll work on integrating it into the pagewalk as you suggested.
> >
> >>
> >> Less working on "vma + address" and instead directly on PMDs.
> >
> > Yes, some of the work on "vma + address" can be avoided :)
>
> Doing the conditional split while in the pagewalk will be the
> interesting bit to sort out (we temporarily have to drop the PTL and
> start once again from that now-PTE-mapped page table). But it should be
> a reasonable thing to have.

Yep, it's an interesting challenge for me, but definitely worth tackling ;)

>
> Please let us know if you run into bigger issues with that!

Thanks, I'll do my best to sort it out and reach out for help if needed :p

>
> See walk_pmd_range() as an inspiration where we call split_huge_pmd().

Thanks for your suggestion! I'll take a closer look at it.

Thanks again for clarifying!
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

