Return-Path: <linux-kernel+bounces-91364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404BD871013
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E3F1C20EC5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3517BAEF;
	Mon,  4 Mar 2024 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOQJgDIM"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30358F58
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591386; cv=none; b=cUaprgEt+t3M7qfyOmEZNni8tGBpOILt5fOLPWHLfvvap1VFybhYTLLwxVdzPJFulKoqwEBjU1S7ektPt7Zy4vfadA4VEZuMPGGDjQF7x0JlmJizDSHWrLsKeyYIynNhmSr5fQmfNfkF1j/WEMt7dstCAIv0EtmTDruu4jf/6io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591386; c=relaxed/simple;
	bh=3NF7mMoktBFxBF80bacY2+8paBK1GDHPIOT027+cEuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cdolop/5hZ7153w6iTwSfFxaLuJEqd9YArQhh4vmar1ZutRyLhDRZeiIHMzQn9beQ8CiV/NiZjM+YdKJEEKFEAgudm/lSRmd4MH1Tc3u7zsyIc4lZXUrU61UDfKeF3HkZ3vmiMCIMkbRT/+ANFUYWsKfKB0KWKWqxFf4T2kgb+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOQJgDIM; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4d355374878so6998e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 14:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709591383; x=1710196183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jirSeDVxTZlyRe9zYTwADzzdMh/h01z9Up/58VyB0jI=;
        b=DOQJgDIMvXyUjW9gw7b87GSEOwDRSJx9u5z+rKNVApV2BWGjCioXpLhVLdpXpVjSGq
         H4pTE0arJWiK9dlym0EW/Jbt6muNZcXoGCcW/DsWMOfIbY5Dls3Uvt9tUlDDh1FTwWob
         S1AbeWbTnubNyButOFDZItzbGI3+tkJ7pnG1qbAVlFjPgBt4SaYL6dlv4mZtWrC7/MPO
         CEMK4U2rm1pj9gOqN79s0DXU9iORWsqyDcw0j9fqCXNNJw+ML3oju+7oAI8a+h2jqi5v
         iLSYMK4iLxAuK8hiE9cp93FlWDlQowp7GeK3rvEJj7h9TbLTbl8sd9ZnvaF/gSq0vOWY
         G7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709591383; x=1710196183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jirSeDVxTZlyRe9zYTwADzzdMh/h01z9Up/58VyB0jI=;
        b=VkJoZyR3idU80RNMWT5QAR6ABjv7R7VTerWr3itDmPpDq++8iAY+zZ1uvTeyNYtR0Z
         PgyM+Wa1yKx5U188B2VUhg+dEJParA9u3n1m4vFhF5rWc39sGYIc3DdRpjpl9f1VLj7S
         JqEY66wSS5kWB/8BNF0i35fVJtkFam2tp3xM2uye5/4hozwBIe98PGi6ENTAtd5+jN8C
         x2e56UpATBAzSplLQf75cMlB11UV4xYxChqCJsEcWUZ8N0KlQ+eLWHUpf4MRWTMKJZH8
         PVYSNZ1UmFNGez1dXrmYmZqi81wcRCQ/DwaRCH0hwmekMChY1QnWHNV7qLS3ahC9q2+C
         SpoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/o0k7zZzzgoDC6fnOaIHU7VXCTfwsivT5KeSFG4LPJvVJ3HxKgvVxbI4WNYxB6maIOPr3xqgQtJqGEn4Uvj6kyFuee5gjpYZ8jFT8
X-Gm-Message-State: AOJu0Yz0x7Bxwu+E7PBXPZC7jEIDn4wuA9jI5fDY0KInr7L/lT+rQ6M9
	M/8AeNaf4EfbEatyKKuFFXrkYp/htFrV2U78AYdrtorq8ivq2PLToamJp4YOFjpOQ4dGVesyBtY
	vuYGLsONL5GTdTlt5BHqbQVArXtw=
X-Google-Smtp-Source: AGHT+IEnmR9SSBt0Nu6nkL0livb/Wk+Stg5tA9Fjmnn32Rhz1c1Qu6OXcx9tIVyT4JfRhKcSOochQjpnpH+9s55RCVU=
X-Received: by 2002:a05:6122:999:b0:4d3:4ac2:29f4 with SMTP id
 g25-20020a056122099900b004d34ac229f4mr63078vkd.2.1709591383601; Mon, 04 Mar
 2024 14:29:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304103757.235352-1-21cnbao@gmail.com> <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
 <37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com> <CAGsJ_4yJ3yCyN_KgBO8W+jFx8RN6_JhS9OwX3FH6X_gpU7g62w@mail.gmail.com>
 <804524c8-772c-42d0-93a5-90d77f13f304@redhat.com>
In-Reply-To: <804524c8-772c-42d0-93a5-90d77f13f304@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Mar 2024 11:29:31 +1300
Message-ID: <CAGsJ_4yqUW46xyDtZ4X1wQZ2_0bLM85Euz2BufERa75Rg+gVyw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	chrisl@kernel.org, yuzhao@google.com, hanchuanhua@oppo.com, 
	linux-kernel@vger.kernel.org, willy@infradead.org, ying.huang@intel.com, 
	xiang@kernel.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:15=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
>
> >>> Do we need a Fixes tag?
> >
> > I am not quite sure which commit should be here for a fixes tag.
> > I think it's more of an optimization.
>
> Good, that helps!
>
> >
> >>>
> >>
> >> What would be the description of the problem we are fixing?
> >>
> >> 1) failing to unmap?
> >>
> >> That can happen with small folios as well IIUC.
> >>
> >> 2) Putting the large folio on the deferred split queue?
> >>
> >> That sounds more reasonable.
> >
> > I don't feel it is reasonable. Avoiding this kind of accident splitting
> > from the kernel's improper code is a more reasonable approach
> > as there is always a price to pay for splitting and unfolding PTEs
> > etc.
> >
> > While we can't avoid splitting coming from userspace's
> > MADV_DONTNEED, munmap, mprotect, we have a way
> > to ensure the kernel itself doesn't accidently break up a
> > large folio.
>
> Note that on the next vmscan we would retry, find the remaining present
> entries and swapout that thing completely :)

This is true, but since we can finish the job the first time, it seems
second retry is a cost :-)

>
> >
> > In OPPO's phones, we ran into some weird bugs due to skipped PTEs
> > in try_to_unmap_one. hardly could we fix it from the root cause. with
> > various races, figuring out their timings was really a big pain :-)
> >
>
> I can imagine. I assume, though, that it might be related to the way the
> cont-pte bit was handled. Ryan's implementation should be able to cope
> with that.

I guess you are probably right. Ryan's implementation decouples CONT-PTE
from mm core. nice to have it.

>
> > But we did "resolve" those bugs by entirely untouching all PTEs if we
> > found some PTEs were skipped in try_to_unmap_one [1].
> >
> > While we find we only get the PTL from 2nd, 3rd but not
> > 1st PTE, we entirely give up on try_to_unmap_one, and leave
> > all PTEs untouched.
> >
> > /* we are not starting from head */
> > if (!IS_ALIGNED((unsigned long)pvmw.pte, CONT_PTES * sizeof(*pvmw.pte))=
) {
> >                     ret =3D false;
> >                     atomic64_inc(&perf_stat.mapped_walk_start_from_non_=
head);
> >                     set_pte_at(mm, address, pvmw.pte, pteval);
> >                     page_vma_mapped_walk_done(&pvmw);
> >                     break;
> > }
> > This will ensure all PTEs still have a unified state such as CONT-PTE
> > after try_to_unmap fails.
> > I feel this could have some false postive because when racing
> > with unmap, 1st PTE might really become pte_none. So explicitly
> > holding PTL from 1st PTE seems a better way.
>
> Can we estimate the "cost" of holding the PTL?
>

This is just moving PTL acquisition one or two PTE earlier in those corner
cases. In normal cases, it doesn't affect when PTL is held.

In normal cases, page_vma_mapped_walk will find PTE0 is present, thus hold
PTL immediately. in corner cases, page_vma_mapped_walk races with break-
before-make, after skipping one or two PTEs whose states are transferring,
it will find a present pte then acquire lock.

> --
> Cheers,
>
> David / dhildenb

Thanks
Barry

