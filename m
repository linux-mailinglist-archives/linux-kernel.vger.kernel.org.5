Return-Path: <linux-kernel+bounces-82754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EE586891B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68737B2200F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1F653388;
	Tue, 27 Feb 2024 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVv2flGc"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF08A52F9F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016141; cv=none; b=iVU9EPnILqy4il3bCR0tRcJN8pjpONRdm2JPXvruZ732Bm+I6bH6sVFt/Oal+R7Q9G01LYqi5e8vxPYhxkfRUyKNXZrHUHB6n8ubXyhOruhJQoo2koCjZnSEh+lKhFWuDCvtyMGhMR5lbld4GEGUxJE1P940e/b5fAiXVJglBfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016141; c=relaxed/simple;
	bh=Uib/1OUtvJBqORrJxaK4n1l7PpWQm5dI5eVX4VwcOds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCXlS5nqla8zmeJmT5MeXD5pUJrrzGmSISi67nD9TxCaNcOieUg6tNgfb3rJXF5hofyNoRv2iFTKWNZGZXueyDckHiUorCOWFJm77aN/1p+f8FtsW8B9ukbfLYkSTAIPimuSJfXEzOwLO8TWHuoEGJNbVtrK1krOkPLiv98akeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVv2flGc; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4d16e766fb0so339647e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709016139; x=1709620939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMU9qADzbYYxkLIXU2ki+0Gre6TmTJY0ABFyENCubko=;
        b=PVv2flGc8FiRszZouSYnD2BWfLJIRnnzK59hjp634VhFjtX6Lyu67czcDjBgq3gLIY
         Y8wy5zsOuMusL6uwz1rf0wH1Z5KOCIxf8cB6sn+pEx6wKiyArC2tOaUbyJsHnjtCD3a3
         lx7WP5A3SJ3qP4CFNkBVP8Q7YYGLQEJNehVTjKT2OBe1ZRgNm9opfD0e9NlenqAy0q7l
         88AVd884X23euY5bPE+yfdr8Twb0akDe7ufmL2DFv8TwYV2ny7mVD18tS3NbaG+J/4E/
         X+/6gMSQNEu00xjNTnuf2VNhSBHAQCLDgyU/9sfqdo2473lPYAYF7gc8gQQVECYkWiOl
         w4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709016139; x=1709620939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMU9qADzbYYxkLIXU2ki+0Gre6TmTJY0ABFyENCubko=;
        b=Bfhb94TL5XPa6p/lFxF5YTQdAMDS1tt0nHBhxpt6LGwnLFkDsliNvcROkOz6q/P9Lx
         ebmkrdxRJZsNqKsugTu37G0cRNLNHPwgcCkOQP8th2uZosckz4dWo9uzMiBEQ3UUgqQ3
         O8DyOGB4SSZsEJYPe0+07A5qF6ptSE16ZBgNMGhQOVT32afcBqiRClDTg0JzlCYbrD2Y
         1zROUcRgyT7a9lwL+RP9d7fn56kJ+2zFDKygOenROA7peESILTW9st3Xiy0voLw32Drh
         oDxEm80nYkWrwlBcs0x0/mXjDeKKeQluUeyOtvrTQe7jM05APoBmyj6Q9s3hVjWDzJt8
         5PiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3DXe/ndMsHZ+rxRDTdh2gd/4F6bRmd4jt0DouGnzIk2PyY6l5IqbDG8lli9GtFLb+MmPSFnzNQ3q31bcRyWdN5CoPmFZFdtPHR4I9
X-Gm-Message-State: AOJu0Yzyd+GW55DZSmppHmr9B+Ko6g1JMXpBEcsWebiUwgkdk1Y7XvMa
	QmiOm0KIRrNECOR1b7yXOI3pzwqOXqb9NlMw5jq7rYTDSb11eckHBEpLVuCU+h10i4ed1/YCZbC
	NLfZSOqqRM6cYH5wQByXCUEFvGu8=
X-Google-Smtp-Source: AGHT+IH3nWgTZlwiHtzk+iQibAStqjW8Pp9ieq6LHUZrwCOg1URru80WCQL+F7gaFu7RIzEbjqYZLX/SPGHtFvtIexY=
X-Received: by 2002:a1f:48c3:0:b0:4c9:98f8:83d7 with SMTP id
 v186-20020a1f48c3000000b004c998f883d7mr5516735vka.0.1709016138630; Mon, 26
 Feb 2024 22:42:18 -0800 (PST)
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
 <3c56d7b8-b76d-4210-b431-ee6431775ba7@intel.com> <CAGsJ_4xu1kz5VD-CcNFvP0A1nPKDojV8Gy1HPvNKuQ_RAw=26g@mail.gmail.com>
In-Reply-To: <CAGsJ_4xu1kz5VD-CcNFvP0A1nPKDojV8Gy1HPvNKuQ_RAw=26g@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Feb 2024 19:42:07 +1300
Message-ID: <CAGsJ_4yAu-m_gYZUSWEGbW4ZMiAPayuZacPN2fYAYXk4Ts_6eg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Yin Fengwei <fengwei.yin@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>, 
	David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org, peterx@redhat.com, 
	shy828301@gmail.com, songmuchun@bytedance.com, wangkefeng.wang@huawei.com, 
	zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 7:40=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Feb 27, 2024 at 7:14=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.co=
m> wrote:
> >
> >
> >
> > On 2/27/24 10:17, Barry Song wrote:
> > >> Like if we hit folio which is partially mapped to the range, don't s=
plit it but
> > >> just unmap the mapping part from the range. Let page reclaim decide =
whether
> > >> split the large folio or not (If it's not mapped to any other range,=
it will be
> > >> freed as whole large folio. If part of it still mapped to other rang=
e,page reclaim
> > >> can decide whether to split it or ignore it for current reclaim cycl=
e).
> > > Yes, we can. but we still have to play the ptes check game to avoid a=
dding
> > > folios multiple times to reclaim the list.
> > >
> > > I don't see too much difference between splitting in madvise and spli=
tting
> > > in vmscan.  as our real purpose is avoiding splitting entirely mapped
> > > large folios. for partial mapped large folios, if we split in madvise=
, then
> > > we don't need to play the game of skipping folios while iterating PTE=
s.
> > > if we don't split in madvise, we have to make sure the large folio is=
 only
> > > added in reclaimed list one time by checking if PTEs belong to the
> > > previous added folio.
> >
> > If the partial mapped large folio is unmapped from the range, the relat=
ed PTE
> > become none. How could the folio be added to reclaimed list multiple ti=
mes?
>
> in case we have 16 PTEs in a large folio.
> PTE0 present
> PTE1 present
> PTE2 present
> PTE3  none
> PTE4 present
> PTE5 none
> PTE6 present
> ....
> the current code is scanning PTE one by one.
> while scanning PTE0, we have added the folio. then PTE1, PTE2, PTE4, PTE6=
..
>
> there are all kinds of possibilities for unmapping.
>

not to mention we have all kinds of possibilities like

PTE0 present for large folio1
PTE1 present for large folio1
PTE2 present for another folio2
PTE3 present for another folio3
PTE4 present for large folio1
..

> so what we can do is recording we have added the folio while scanning PTE=
0,
> then skipping this folios for all other PTEs.
>
> otherwise, we can split it while scanning PTE0, then we will meet
> different folios
> afterwards.
>
> >
> >
> > Regards
> > Yin, Fengwei
>
> Thanks
> Barry

