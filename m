Return-Path: <linux-kernel+bounces-120413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE3C88D703
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15B329A214
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87742250E0;
	Wed, 27 Mar 2024 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/fxDGqM"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBE74C9A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711523663; cv=none; b=HtBOvCxnA70d3DdA659IMPrqkUf2EiDA76iYxnogBKK1Glh42xsKSzKc+3VUv/HKcRwymmCCIG5SH/v5R8IiH4i2f2l0kVEqJhBTOIYOjs4admOB+s3lg5EVhYIpZ5z4V7HQ3M4VazSULoO3VpgCqIJhsiUf+IIBD2P9Ok0P0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711523663; c=relaxed/simple;
	bh=AyTRk946bJAOBNNUm2Ved0ZCFIMFiBynmqZ359SU2ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmwWQFWKgMNYyvSZQuW8yMxiZBoxl9dxymGydz8C9PSTyxT1ZIrf6x8LyvA/TfCf751+CEUc81zKv3QVsqGUS2lMSNFYCfIn3dZp6wsGJYRw5dEAmyWphQX2CIKCx0xUsj/Es2oVvLXgCwgBjEzlzdk7XMvWbr+Lw3RO7cDWOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/fxDGqM; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d6dda3adb9so29260391fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711523660; x=1712128460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxe26Pql1ZJJLo/Yz0MpSRJlZcF3hlpO0Bfv+hcO1oY=;
        b=M/fxDGqMPDoVq1W4DDKo8NhhHjXnepBdVjbMmnqtagpSJJlpK5Wk/bpucJGOwF4Dyh
         PAA/FNwZtIHexccMgSI2gjOG4sAJeu1LZtBjnm2jyKS4/af/YeImV6Xrbi524ctYbctR
         C93s+lucXzIRV0EqyfCrzkddJcrlA6v+emSMckg80OOZmlxhSgWHSTJJGtUMqT8rxth0
         0bGCCF15bYMiMcAJCWXALwoYzln92NU4DvCoQkerspeFkUe5Bq62Ij42r6lUydizGfle
         NFRfLqY/tjzRMq0BnLeHi/VD9bI54MtjR9ceeqjklvD6wsg5+kQss7LRPPIfdJlB1s2m
         KQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711523660; x=1712128460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxe26Pql1ZJJLo/Yz0MpSRJlZcF3hlpO0Bfv+hcO1oY=;
        b=NpV86zFGLEOoKkblJRgJYZcO0a/0ok21P8mBQrOHPkPkIAyg2esdGyA0fJyuwOLEDm
         d9uKJ646LUdgx9EfbB8lmyP3twfJwo64Uhk5MBeBkRcWT6DJy9Z6B03Tv9RqXJbUxFyi
         DgKtKB9ZYy4qJYveDTpTMIhd28QjCuifP1AvxspeYKz68/kC747bdsTPV/tdm1rO/Rxs
         /CEcd+JHXSdFbpJUxFVXAVhKG/PGGlg6NhA04NEmRqCDrNrP0j1SzbUIRSoNpBI5eKtp
         nNWgLCbR/WMIdF4ETT+kOuu5uVmu+W5+D+1BH8TFqftp4X622GWA45zu8/dPMOIoo6OI
         aBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm/rtUzmKic0TlXMNKQBtbHNzg23vSc+i1KDGSankWGNc0YXhQbzPKmwYwCTlPSEyMlDJyCUJ4Zd7pA4zZFn1CIrxN90Ky2kdrS3KN
X-Gm-Message-State: AOJu0YzPGQ3/FrcD/AGuUBkz6ytN0iLbKDvoLRIo3XthtSl5kqRZbwSD
	W7sNmtwGh++C5A06wDM4P6kb0zrh3MzvMeYxC3LEgjvtEliytpcXpWk4FwTIdVx4Y+/PbLg9+ME
	pJn3IWPX6aPxEKUbZb41pl/8YGo8=
X-Google-Smtp-Source: AGHT+IGn29++H1s36pYWPuwmuhYyG+ecT3VIG72udl5R+aEEWNe2A9t2E5ezL2nNvcqhReWwS0bNTHVBDikEFZRWM3I=
X-Received: by 2002:a05:651c:1a09:b0:2d4:3e82:117e with SMTP id
 by9-20020a05651c1a0900b002d43e82117emr3461865ljb.32.1711523660182; Wed, 27
 Mar 2024 00:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326185032.72159-1-ryncsn@gmail.com> <20240326185032.72159-11-ryncsn@gmail.com>
 <87zfukmbwz.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7A-TxWkNKz0wwjaf0C-KZgps-VdPG+QcpY9tMmBY04TNA@mail.gmail.com>
 <87r0fwmar4.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87r0fwmar4.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 27 Mar 2024 15:14:03 +0800
Message-ID: <CAMgjq7D9-6JXOzpd18t8MSBAotHgEG2YZbi4efNkJiwiSJyJmw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] mm/swap: optimize synchronous swapin
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, Minchan Kim <minchan@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Yu Zhao <yuzhao@google.com>, SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 2:49=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > On Wed, Mar 27, 2024 at 2:24=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Kairui Song <ryncsn@gmail.com> writes:
> >>
> >> > From: Kairui Song <kasong@tencent.com>
> >> >
> >> > Interestingly the major performance overhead of synchronous is actua=
lly
> >> > from the workingset nodes update, that's because synchronous swap in
> >>
> >> If it's the major overhead, why not make it the first optimization?
> >
> > This performance issue became much more obvious after doing other
> > optimizations, and other optimizations are for general swapin not only
> > for synchronous swapin, that's also how I optimized things step by
> > step, so I kept my patch order...
> >
> > And it is easier to do this after Patch 8/10 which introduces the new
> > interface for swap cache.
> >
> >>
> >> > keeps adding single folios into a xa_node, making the node no longer
> >> > a shadow node and have to be removed from shadow_nodes, then remove
> >> > the folio very shortly and making the node a shadow node again,
> >> > so it has to add back to the shadow_nodes.
> >>
> >> The folio is removed only if should_try_to_free_swap() returns true?
> >>
> >> > Mark synchronous swapin folio with a special bit in swap entry embed=
ded
> >> > in folio->swap, as we still have some usable bits there. Skip workin=
gset
> >> > node update on insertion of such folio because it will be removed ve=
ry
> >> > quickly, and will trigger the update ensuring the workingset info is
> >> > eventual consensus.
> >>
> >> Is this safe?  Is it possible for the shadow node to be reclaimed afte=
r
> >> the folio are added into node and before being removed?
> >
> > If a xa node contains any non-shadow entry, it can't be reclaimed,
> > shadow_lru_isolate will check and skip such nodes in case of race.
>
> In shadow_lru_isolate(),
>
>         /*
>          * The nodes should only contain one or more shadow entries,
>          * no pages, so we expect to be able to remove them all and
>          * delete and free the empty node afterwards.
>          */
>         if (WARN_ON_ONCE(!node->nr_values))
>                 goto out_invalid;
>         if (WARN_ON_ONCE(node->count !=3D node->nr_values))
>                 goto out_invalid;
>
> So, this isn't considered normal and will cause warning now.

Yes, I added an exception in this patch:
-       if (WARN_ON_ONCE(node->count !=3D node->nr_values))
+       if (WARN_ON_ONCE(node->count !=3D node->nr_values &&
mapping->host !=3D NULL))

The code is not a good final solution, but the idea might not be that
bad, list_lru provides many operations like LRU_ROTATE, we can even
lazy remove all the nodes as a general optimization, or add a
threshold for adding/removing a node from LRU.

>
> >>
> >> If so, we may consider some other methods.  Make shadow_nodes per-cpu?
> >
> > That's also an alternative solution if there are other risks.
>
> This appears a general optimization and more clean.

I'm not sure if synchronization between CPUs will make more burden,
because shadow nodes are globally shared, one node can be referenced
by multiple CPUs, I can have a try to see if this is doable. Maybe a
per-cpu batch is better but synchronization might still be an issue.

