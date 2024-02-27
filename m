Return-Path: <linux-kernel+bounces-82782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD2286899E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D279285BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF29D53E36;
	Tue, 27 Feb 2024 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw/r4fa+"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B96153E01
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017881; cv=none; b=UJMrHTSf9ABCVTeBL+dKjI3MX5GEZ/bfKtg/XY23gJiWf5jXwyuZnu/wmKygGV9pokGRlyNC/ukNGl2wqjHUPkvgktE1uY5wjRqx+phJLpoCi3aPg8gpwWP6OKMX4/u2ItwUmL1jNiH/5gIztNQsv9q1pyBaICIjh6Qb730pi/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017881; c=relaxed/simple;
	bh=EjlVQu7onZcEXwxgNMGrKHv4T6UuOGtqNK0zDBBJM3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5Zob2Ucqucw6PUyb9zhJ9b5udLRDegGOKxR1evhulfyQsfgbWTcHn5NSHvt63qSczgzokBaCflyroD+geQ9w0oTHNrjARF7nVasDeHhBOnbkBlSwMK1mcEQ8olbwKb/rdY9dD0M6LtmxR2yINfKkvnNxZ/sKCljPqXyo52DP3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fw/r4fa+; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7d6024b181bso1904637241.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709017878; x=1709622678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYQ3hdhddFNYK8GyMhkyIKxBGg92Et2d0tbp94QuLyE=;
        b=Fw/r4fa+fKfd41md/73C9NkJPyFIXTFmyi/WE0iXePRY1iqgjz4W7yXSkhnznXWmaM
         m5yntPWsxjZojhI0626zAP4sb0YoJ9Si/O/x4ZWkosvQBFFqQsa4/MR3WXfMWPyx7z+M
         MV2jiu0x004b3a5xTr6bnfqaL8PC+9vfOsjTPEXi075a0dfSDHmvz5MnREyxSSJIxPvZ
         HyOQbTCN8HSUpU/+9gjRwKRD8mV0KurLCCvFqVt6xd4zUc5wGlEQrDmzz/BtXgHuGg3B
         9wrGWmQaHkd5brQe+hc3SsRzUaZ6z9kR8hXOyUhW+oYbIkEAv/rvn+NfWkYFc5gqpXxB
         3Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709017878; x=1709622678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYQ3hdhddFNYK8GyMhkyIKxBGg92Et2d0tbp94QuLyE=;
        b=gUYM9G2m1AA5f6gaQjFPPwnNWbzAWKgg6bxow5xdi8TIQf4tCCEXqp6+RWYXAN2UTe
         6nSvkGsKRfzmTHkf7SyitJ7l1ZHJxii2ed4hvF1KAc/EeIxKq+QsM+gFcyozbsd4t//Y
         rdJIj6Pv0Y1cybFDi00hmiQ7cUgjo1VibTvnaaZ7Mnqt37xyAkNHvNiTSFCNoT1o8yK4
         ae9rHYQAu+wrdFLjwMsfzozY9qZYn9WFKIIcv3GVJoaH+iHx8U3XSkr64D2duBt1/FzV
         mqcQWW0ZgL3EXODsSoO7hFXXfOJ9m/xFE8shgVLzpfRYvNAXyHMKfkltRlddFFJl6IT+
         /P7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhXVqtWwDSNJtwWukwmuZjrq+GoogjUA+RT+tzLtNVSw3MUrMqFeBMcDxD7Aez9VzejoM+n/D/oSNLSce4FPhz6XMDT+U4HyDvOIwh
X-Gm-Message-State: AOJu0Yz3WrrKsC1crTZrEQIMjzg66om3Xv91pR+Qpprp+3uKnHgU0qJJ
	+OyH3pDVXoDTkJSFk1MCWI3dVzkpHIV5aHO+gvz3uu+zfHk2nUvK6TGCB3PsFO5Dlo6pq6BKVQP
	qVGwvp+Bfu0IpZr2ZYvQfFaoJDzA=
X-Google-Smtp-Source: AGHT+IFS8wpr7oLSEHmvMDX9Of/jUOUizc5A3MTc0dl/69EcjCWv8LO+PlGDRRyuypngziSy52encCDWhibD4Yzse5s=
X-Received: by 2002:a1f:4e44:0:b0:4c0:1cc8:8821 with SMTP id
 c65-20020a1f4e44000000b004c01cc88821mr5585018vkb.9.1709017878540; Mon, 26 Feb
 2024 23:11:18 -0800 (PST)
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
 <6ea0020a-8f4b-44d1-a3b2-7c2905d32772@intel.com>
In-Reply-To: <6ea0020a-8f4b-44d1-a3b2-7c2905d32772@intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Feb 2024 20:11:07 +1300
Message-ID: <CAGsJ_4x6Otb9LUvnxAaPLnQ2MPPng0xpG-vJmFL7pNm10FDhZA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Yin Fengwei <fengwei.yin@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>, 
	David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org, peterx@redhat.com, 
	shy828301@gmail.com, songmuchun@bytedance.com, wangkefeng.wang@huawei.com, 
	zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:02=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
>
>
> On 2/27/24 14:40, Barry Song wrote:
> > On Tue, Feb 27, 2024 at 7:14=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.=
com> wrote:
> >>
> >>
> >>
> >> On 2/27/24 10:17, Barry Song wrote:
> >>>> Like if we hit folio which is partially mapped to the range, don't s=
plit it but
> >>>> just unmap the mapping part from the range. Let page reclaim decide =
whether
> >>>> split the large folio or not (If it's not mapped to any other range,=
it will be
> >>>> freed as whole large folio. If part of it still mapped to other rang=
e,page reclaim
> >>>> can decide whether to split it or ignore it for current reclaim cycl=
e).
> >>> Yes, we can. but we still have to play the ptes check game to avoid a=
dding
> >>> folios multiple times to reclaim the list.
> >>>
> >>> I don't see too much difference between splitting in madvise and spli=
tting
> >>> in vmscan.  as our real purpose is avoiding splitting entirely mapped
> >>> large folios. for partial mapped large folios, if we split in madvise=
, then
> >>> we don't need to play the game of skipping folios while iterating PTE=
s.
> >>> if we don't split in madvise, we have to make sure the large folio is=
 only
> >>> added in reclaimed list one time by checking if PTEs belong to the
> >>> previous added folio.
> >>
> >> If the partial mapped large folio is unmapped from the range, the rela=
ted PTE
> >> become none. How could the folio be added to reclaimed list multiple t=
imes?
> >
> > in case we have 16 PTEs in a large folio.
> > PTE0 present
> > PTE1 present
> > PTE2 present
> > PTE3  none
> > PTE4 present
> > PTE5 none
> > PTE6 present
> > ....
> > the current code is scanning PTE one by one.
> > while scanning PTE0, we have added the folio. then PTE1, PTE2, PTE4, PT=
E6...
> No. Before detect the folio is fully mapped to the range, we can't add fo=
lio
> to reclaim list because the partial mapped folio shouldn't be added. We c=
an
> only scan PTE15 and know it's fully mapped.

you never know PTE15 is the last one mapping to the large folio, PTE15 can
be mapping to a completely different folio with PTE0.

>
> So, when scanning PTE0, we will not add folio. Then when hit PTE3, we kno=
w
> this is a partial mapped large folio. We will unmap it. Then all 16 PTEs
> become none.

I don't understand why all 16PTEs become none as we set PTEs to none.
we set PTEs to swap entries till try_to_unmap_one called by vmscan.

>
> If the large folio is fully mapped, the folio will be added to reclaim li=
st
> after scan PTE15 and know it's fully mapped.

our approach is calling pte_batch_pte while meeting the first pte, if
pte_batch_pte =3D 16,
then we add this folio to reclaim_list and skip the left 15 PTEs.

>
> Regards
> Yin, Fengwei
>
> >
> > there are all kinds of possibilities for unmapping.
> >
> > so what we can do is recording we have added the folio while scanning P=
TE0,
> > then skipping this folios for all other PTEs.
> >
> > otherwise, we can split it while scanning PTE0, then we will meet
> > different folios
> > afterwards.
> >
> >>
> >>
> >> Regards
> >> Yin, Fengwei
> >

Thanks
Barry

