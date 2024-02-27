Return-Path: <linux-kernel+bounces-82753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6AC86891A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D502E1F24C02
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B255753379;
	Tue, 27 Feb 2024 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG8gPfBk"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF011DFD0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016038; cv=none; b=me6VoksXEAWxJxaxnPgN9LpmUdjTf6ynF9ZcsafDnv7yXut8/h6Twcg3B+qNQ9e3jmr2u7WXmxUV0VzyEyEoYkK9VqiaZR1KQE0N3Eu1jf1bvn3JZrnfhtJItX3S2tQkchZflpl2ZukU1ymhMNDi7iG/Jpd3nbENSJgGUhex7NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016038; c=relaxed/simple;
	bh=8zFtO+REgm5aIYoml2GIkD0pKOYEuz+nNRzmAfEQF7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgFRGom8CSWpEv0i9s5jeye0wgWSBg6pMrpszVzQYKVuybgVnTRr/zYd5NzsZf5zQtBieEthe5PyYY9ksqPKVrZDgiOo4tSGKygs7gXUKbuZmR21iElIdTCgyGsSsxeNTT6qYzrH4dddfjH2GOpzEwfbqBTSFDKQlElWjWShF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lG8gPfBk; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-471c3d23d28so1901527137.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709016035; x=1709620835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlPT3rui0lg3J1n1cZSVOnotxwJ0BTmY9ECblEb2NZg=;
        b=lG8gPfBk1TPUuLyzCQ6Jz6WNXwru7V0tWgFXKMMj3CniaWEFY+cy+VamI5gTV2aLoL
         JzdB6vh8Awc5u7i3AOAYxmKY7o8kdCA3foSwze9vkgrBahH3AhZMWHd7dT+bSUsYz5qL
         CGZJ+4PNF/WQixQIV8uAaD+K24oK1m0xpFzNx3oWGcDIYcaqNDykDhaRVgh60bXBTbxq
         baZ3TRSjMlQYHKKJdEzsHbpUisjcaLgJ7txZJJDM2jMOy2uMYJoGwzypbltJhT3hKlsy
         V10P2jfIMmNPahk8Etz1peoFN1L6TnJ4pxkGTeVkYMUBj3y12woYReCNhUzr/VUwuVug
         H95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709016035; x=1709620835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlPT3rui0lg3J1n1cZSVOnotxwJ0BTmY9ECblEb2NZg=;
        b=q54OGPANVqHu3GizUMhswA+IzBAVmf2dsl4w2GdaC0lsqy5R/pTQ9SKbpyS5O1r5/r
         bFYIoBEtHXYgTQOu3D7DwKG88jaH0MezXJiMW60TirllPE3/pfKXivApSNclsjBqP156
         7kSsOVKjXGUeUEOLN/4Yt7ElDVLJYdH8cfzypYuhDV1O7kY9eYKP5Q38vr/YL6nNhw0P
         yjaI8Hvfd3dlH5QEbjJu7hgrYqAVq7h8ckWweg5BFS7Dm8RnR/KZg3MaYMXwJc9/2pfs
         XpmTLCN+OiLvHnIkirbhKzBBz/2tggzaENqn7FXw5jXqgoL2VLUxcmW+FRzreiLn5iJT
         5Z+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOMofiCAxlPwWxiOMmV8PcUUdjZG4oMU/s8hn5NEUfzWIAiKnVQMdv0c8Bhh4pUWG2dY8VOcmgKJIc2em426QZBYATU8aWC9ejLUNh
X-Gm-Message-State: AOJu0Yy8PXu+GmJg1lr5QjQtGKXplrM1JtsD03S6Em/rQZOdCDGcdnpU
	hmV6nS2WvX5mzrtKYblDBacJowDHulmRMrkLUI+LEcNgSYBfOh9BwkmDtp+GIz1V24s6fcFA5Pn
	3mGR6Gjug56mJrwmFssiWjWtIO14=
X-Google-Smtp-Source: AGHT+IGNmasMUiU8u0R9GrqNZbHg+Jkwg695WNU+dfnKUWYK3yfWjShC+JRtoU9FT1VLYAZubDqgpeqmYvD6cxFIJq8=
X-Received: by 2002:a05:6102:a4d:b0:471:fb75:b92b with SMTP id
 i13-20020a0561020a4d00b00471fb75b92bmr2730752vss.3.1709016035387; Mon, 26 Feb
 2024 22:40:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
 <20240226083714.26187-1-ioworker0@gmail.com> <9bcf5141-7376-441e-bbe3-779956ef28b9@redhat.com>
 <CAK1f24mdwjz2J5VmeYSDwb4jMbrXUVCSF_0pOcWSVt1cfa0FhQ@mail.gmail.com>
 <318be511-06de-423e-8216-af869f27f849@arm.com> <CAGsJ_4z+0yXUDYwxKNAqYwxAAYpfKpKd2u_dVTDP3b-KPOQT1g@mail.gmail.com>
 <19758162-be5f-4dc4-b316-77b0115d12ce@intel.com> <CAGsJ_4wx72KOazANBvnGcjdZse8W9+PW5_fspP9=QuX3X_7msg@mail.gmail.com>
 <3c56d7b8-b76d-4210-b431-ee6431775ba7@intel.com>
In-Reply-To: <3c56d7b8-b76d-4210-b431-ee6431775ba7@intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Feb 2024 19:40:23 +1300
Message-ID: <CAGsJ_4xu1kz5VD-CcNFvP0A1nPKDojV8Gy1HPvNKuQ_RAw=26g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Yin Fengwei <fengwei.yin@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>, 
	David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org, peterx@redhat.com, 
	shy828301@gmail.com, songmuchun@bytedance.com, wangkefeng.wang@huawei.com, 
	zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 7:14=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
>
>
> On 2/27/24 10:17, Barry Song wrote:
> >> Like if we hit folio which is partially mapped to the range, don't spl=
it it but
> >> just unmap the mapping part from the range. Let page reclaim decide wh=
ether
> >> split the large folio or not (If it's not mapped to any other range,it=
 will be
> >> freed as whole large folio. If part of it still mapped to other range,=
page reclaim
> >> can decide whether to split it or ignore it for current reclaim cycle)=
.
> > Yes, we can. but we still have to play the ptes check game to avoid add=
ing
> > folios multiple times to reclaim the list.
> >
> > I don't see too much difference between splitting in madvise and splitt=
ing
> > in vmscan.  as our real purpose is avoiding splitting entirely mapped
> > large folios. for partial mapped large folios, if we split in madvise, =
then
> > we don't need to play the game of skipping folios while iterating PTEs.
> > if we don't split in madvise, we have to make sure the large folio is o=
nly
> > added in reclaimed list one time by checking if PTEs belong to the
> > previous added folio.
>
> If the partial mapped large folio is unmapped from the range, the related=
 PTE
> become none. How could the folio be added to reclaimed list multiple time=
s?

in case we have 16 PTEs in a large folio.
PTE0 present
PTE1 present
PTE2 present
PTE3  none
PTE4 present
PTE5 none
PTE6 present
...
the current code is scanning PTE one by one.
while scanning PTE0, we have added the folio. then PTE1, PTE2, PTE4, PTE6..=
.

there are all kinds of possibilities for unmapping.

so what we can do is recording we have added the folio while scanning PTE0,
then skipping this folios for all other PTEs.

otherwise, we can split it while scanning PTE0, then we will meet
different folios
afterwards.

>
>
> Regards
> Yin, Fengwei

Thanks
Barry

