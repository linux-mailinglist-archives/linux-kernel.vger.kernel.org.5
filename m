Return-Path: <linux-kernel+bounces-29636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1625183111E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A917D2812E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEFC28FD;
	Thu, 18 Jan 2024 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feF3//t4"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F4F2115
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542705; cv=none; b=jxOX59yNm6w3YIPcJ68f3GfXGPyMb8P2iVmzcv8AKUaY5Bqows6Q1l2k6h7o7cXX7VS6wBFQLWfxbRV4Mh3xBuMYfIx5sdEwVjLgL7tEmGsqMxXF1JiIiPnj2rH7hLGRmT6hozpXZ3WPJdR6bRThWsSR0ZlVRLlWN1geUOEj/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542705; c=relaxed/simple;
	bh=gk+szIGCHDF1m7poSrWRwT4feXRQMAk4Aji7T4mqASo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=HC4POM7xp/5YprQqPKErwjVhsptfBd4rBIlO3dYWV+urKQD8X0iLYuRo1NreXIDeKWARMATQUPeB+ivT1fx9WFRRa4SF5iEUGorp+pscD2sWLpaLoOheD8w655AVp7tLpqlzwhsGONhDHUNL9aYEFsg5Mgt+XRsc9iXGj6VAlUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feF3//t4; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbed179f0faso205293276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542703; x=1706147503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFlUvRLLxU9Bh03SHU8Xlmb6p9OjF1f1q03v5iks3yk=;
        b=feF3//t4NHRn9AlzgJ6r1dD3KlmX+6ScpbWYxdI1UMxz7To61z/0b0s9w+sQ9/GRuV
         7pJStWgkTlZn1qNGSpc+6fXAYkOcX/ZYCJakB9F0i40ciJuWmV0hlN1OYlMMWeAmR0mq
         Px73FBlVJkgWnkFfDnWDqKbvElMFKbEATuHg20in/blhMse7WpfUUNpWNXJwQzE7qD7Z
         WJLl8OHq4sBRTvjG0PmcFKbeSPCpj5CAYPO4Jg7xDEls1UzsVlX6L4S2uCXwcgFEvEWF
         pu+YB+clDkEzW1Cf+9wLC6sm7iBoSw/6W5Ce4bxPq7sEejj9QEAuqaX+VESdZaMu34Il
         nfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542703; x=1706147503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFlUvRLLxU9Bh03SHU8Xlmb6p9OjF1f1q03v5iks3yk=;
        b=FHmTBp0nJdljUr+Ltgv/uZtmPjNc0W+cAYRRNIfhGyBhvLtHumwagESIfLclVQEQDA
         9V6GueECbAa3ejMHJjxBnqi5I04TT5bZSl2h+WnBgms0MLS7+XvWyNFc9HfdoKc8GKup
         JqySfq5PbpGYChIpjbFUB6/g7B1fOKae8UOJUCbbUNPSCg2tO3SMnkES/0s3LummO9o+
         c+iIl0IBSJQwCIbXv2pfMdhwUqNHFHQCrvFx5R9P4oW2Hk+voHdXYCE855CVUsmwEcYD
         Re0CLxpRINyzZquZJ1mLeY1LokOLY7/OvAkEOx2TXDaSIqzxpJvMvVpSgaBC08kvy4Bc
         dDNQ==
X-Gm-Message-State: AOJu0YwkH60vVcvl8RADLTlnfLswOYa760ObR8UKKJnNO9/6x8eh4mXJ
	VSnf47HcOSQg0GqNu2JJcf2aG7cdHms5awrIUWKtdknrCk/mBQTRgpuCfrnp4IZZQORKjaT+5QC
	93k0s4az+PD1nlj6TH1r1AOBAip4=
X-Google-Smtp-Source: AGHT+IFrT7OEBcIDMjRqPmGgW8mNOdR276PugYkRYkwNXrye37KQTXmHBLX1+yeql3TzZczi/5Mx6ookRj33c2smh0E=
X-Received: by 2002:a25:b40a:0:b0:db9:84c4:151a with SMTP id
 n10-20020a25b40a000000b00db984c4151amr150239ybj.34.1705542703095; Wed, 17 Jan
 2024 17:51:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117050217.43610-1-ioworker0@gmail.com> <CAAa6QmR0rcdk_rJOzc88ZA4jm9K5LwxT4dSHiBX+nPyd6E3Ddw@mail.gmail.com>
 <22b24ce9-d143-4b5f-87da-bf68e4fa46d3@redhat.com>
In-Reply-To: <22b24ce9-d143-4b5f-87da-bf68e4fa46d3@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 18 Jan 2024 09:51:32 +0800
Message-ID: <CAK1f24=MbVMrxWO2xa+9bJiqEKJ=DG68WQ5bE_LgW9=oTk6GwQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm/madvise: introduce MADV_TRY_COLLAPSE for
 attempted synchronous hugepage collapse
To: David Hildenbrand <david@redhat.com>
Cc: "Zach O'Keefe" <zokeefe@google.com>, akpm@linux-foundation.org, songmuchun@bytedance.com, 
	linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>, 
	Peter Xu <peterx@redhat.com>, Michael Knyszek <mknyszek@google.com>, 
	Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey David,

Thanks for taking the time to review!

David Hildenbrand <david@redhat.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=8818=E6=
=97=A5=E5=91=A8=E5=9B=9B 02:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On 17.01.24 18:10, Zach O'Keefe wrote:
> > [+linux-mm & others]
> >
> > On Tue, Jan 16, 2024 at 9:02=E2=80=AFPM Lance Yang <ioworker0@gmail.com=
> wrote:
> >>
> >> This idea was inspired by MADV_COLLAPSE introduced by Zach O'Keefe[1].
> >>
> >> Introduce a new madvise mode, MADV_TRY_COLLAPSE, that allows users to
> >> make a least-effort attempt at a synchronous collapse of memory at
> >> their own expense.
> >>
> >> The only difference from MADV_COLLAPSE is that the new hugepage alloca=
tion
> >> avoids direct reclaim and/or compaction, quickly failing on allocation=
 errors.
> >>
> >> The benefits of this approach are:
> >>
> >> * CPU is charged to the process that wants to spend the cycles for the=
 THP
> >> * Avoid unpredictable timing of khugepaged collapse
> >> * Prevent unpredictable stalls caused by direct reclaim and/or compact=
ion
> >>
> >> Semantics
> >>
> >> This call is independent of the system-wide THP sysfs settings, but wi=
ll
> >> fail for memory marked VM_NOHUGEPAGE.  If the ranges provided span
> >> multiple VMAs, the semantics of the collapse over each VMA is independ=
ent
> >> from the others.  This implies a hugepage cannot cross a VMA boundary.=
  If
> >> collapse of a given hugepage-aligned/sized region fails, the operation=
 may
> >> continue to attempt collapsing the remainder of memory specified.
> >>
> >> The memory ranges provided must be page-aligned, but are not required =
to
> >> be hugepage-aligned.  If the memory ranges are not hugepage-aligned, t=
he
> >> start/end of the range will be clamped to the first/last hugepage-alig=
ned
> >> address covered by said range.  The memory ranges must span at least o=
ne
> >> hugepage-sized region.
> >>
> >> All non-resident pages covered by the range will first be
> >> swapped/faulted-in, before being internally copied onto a freshly
> >> allocated hugepage.  Unmapped pages will have their data directly
> >> initialized to 0 in the new hugepage.  However, for every eligible
> >> hugepage aligned/sized region to-be collapsed, at least one page must
> >> currently be backed by memory (a PMD covering the address range must
> >> already exist).
> >>
> >> Allocation for the new hugepage will not enter direct reclaim and/or
> >> compaction, quickly failing if allocation fails. When the system has
> >> multiple NUMA nodes, the hugepage will be allocated from the node prov=
iding
> >> the most native pages. This operation operates on the current state of=
 the
> >> specified process and makes no persistent changes or guarantees on how=
 pages
> >> will be mapped, constructed, or faulted in the future.
> >>
> >> Return Value
> >>
> >> If all hugepage-sized/aligned regions covered by the provided range we=
re
> >> either successfully collapsed, or were already PMD-mapped THPs, this
> >> operation will be deemed successful.  On success, madvise(2) returns 0=
.
> >> Else, -1 is returned and errno is set to indicate the error for the
> >> most-recently attempted hugepage collapse.  Note that many failures mi=
ght
> >> have occurred, since the operation may continue to collapse in the eve=
nt a
> >> single hugepage-sized/aligned region fails.
> >>
> >>          ENOMEM  Memory allocation failed or VMA not found
> >>          EBUSY   Memcg charging failed
> >>          EAGAIN  Required resource temporarily unavailable.  Try again
> >>                  might succeed.
> >>          EINVAL  Other error: No PMD found, subpage doesn't have Prese=
nt
> >>                  bit set, "Special" page no backed by struct page, VMA
> >>                  incorrectly sized, address not page-aligned, ...
> >>
> >> Use Cases
> >>
> >> An immediate user of this new functionality is the Go runtime heap all=
ocator
> >> that manages memory in hugepage-sized chunks. In the past, whether it =
was a
> >> newly allocated chunk through mmap() or a reused chunk released by
> >> madvise(MADV_DONTNEED), the allocator attempted to eagerly back memory=
 with
> >> huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPSE)[=
3]
> >> respectively. However, both approaches resulted in performance issues;=
 for
> >> both scenarios, there could be entries into direct reclaim and/or comp=
action,
> >> leading to unpredictable stalls[4]. Now, the allocator can confidently=
 use
> >> madvise(MADV_TRY_COLLAPSE) to attempt the allocation of huge pages.
> >>
> >> [1] https://github.com/torvalds/linux/commit/7d8faaf155454f8798ec56404=
faca29a82689c77
> >> [2] https://github.com/golang/go/commit/8fa9e3beee8b0e6baa733374099618=
1268b60a3a
> >> [3] https://github.com/golang/go/commit/9f9bb26880388c5bead158e9eca3be=
4b3a9bd2af
> >> [4] https://github.com/golang/go/issues/63334
> >
> > Thanks for the patch, Lance, and thanks for providing the links above,
> > referring to issues Go has seen.
> >
> > I've reached out to the Go team to try and understand their use case,
> > and how we could help. It's not immediately clear whether a
> > lighter-weight MADV_COLLAPSE is the answer, but it could turn out to
> > be.
> >
> > That said, with respect to the implementation, should a need for a
> > lighter-weight MADV_COLLAPSE be warranted, I'd personally like to see
> > process_madvise(2) be the "v2" of madvise(2), where we can start
> > leveraging the forward-facing flags argument for these different
> > advice flavors. We'd need to safely revert v5.10 commit a68a0262abdaa
> > ("mm/madvise: remove racy mm ownership check") so that
> > process_madvise(2) can always operate on self. IIRC, this was ~ the
> > plan we landed on during MADV_COLLAPSE dev discussions (i.e. pick a
> > sane default, and implement options in flags down the line).
>
> +1, using process_madvise() would likely be the right approach.

Thanks for your suggestion! I completely agree :)
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

