Return-Path: <linux-kernel+bounces-103377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 532A487BEBA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEAA4B2121F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6C06FE07;
	Thu, 14 Mar 2024 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRHuOwPv"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC645A10A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425983; cv=none; b=UsVR/8RaWSxK4diXmXvkayV42+kYJ3axqZkOgD3ZIymrfEPf6DekncB1FAmBdL9luMLYLMfA+7tXvHCLGfveEIZG23vJt1FiIWs9edUPOBEfDmAVQxeWa3+ZAmePIYLz0yHFV3bBIlWcLzRVH+Fb4R+NY/RAyE5VRN2AEGLlm0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425983; c=relaxed/simple;
	bh=MZokerWRd6ZnZkXZMrbp85CAsZJCPyifNzLdmDGrqmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2D3YysbFwoqcx3Hv1MsYdUPOJz88DK8egPcFL5zwbbmzYhWe8gAwigI5NdzakV/MB9D+pAcSONVCPlP23Ut2Ao6CRglf34l4TtwSGzcwOq5x6f4ZbMqDOOLSK4tTsfL9Ov1jThM+FjUuB4ZWznBCSi2nAAaS5CMqiPt3ryy7Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRHuOwPv; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-609fd5fbe50so11512407b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710425981; x=1711030781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg2nzRe0L0YtyEcjhyzdyONnHk2DTccF/72el9UJrWg=;
        b=eRHuOwPveGsjRtM0rwq92wvRjAmEGfJDwLA6Lovw0I6PkCBxZdhUUlrchjoqzLSXu8
         M6hRaILM3jFcaR2sPOk0GkM3BOS6trjz5CemY3fXRX/jetQ58KXvk4aHDKNzQVXBFCLa
         CAS0xj98nJfwOQziOK3YxNVJtSdEhijPWNY6Zhwcn9QFrjIbnPLZOFCO8bkQFbdv3bXF
         8hSOwA4l3tHLV2Tv+4MUPkTuica7w5h8znLuWHDdrV5rMQJS775/yLI271kzzuAx6qFG
         pykbC0Mf+j88VLpO6a+zfrI8kr+kU3wU5XkycL1aXR+wArcNEdg9lvZY6l8rr4sFy46Q
         qiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710425981; x=1711030781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gg2nzRe0L0YtyEcjhyzdyONnHk2DTccF/72el9UJrWg=;
        b=JKeqicL80EqzV+Y70Am5qUGywllOXJ3xI3WWPw12kgh3+IPLnWEKFwBdEa2yj+knFs
         wXvCqYEpqJC0p20eOiAh69irGWwj/ONz5cFAY95eo471SYzOPfCe++zHWWwq9Cyc+2zL
         9KLmd8asR6xxYGpsJEo3mWA6ugQrp3zCRG7OpCzFBpVAkW/TcNr5NJL9cl8590o1kY+U
         t/Gpw6qLLRJ3I9bIij8d6e0gkNWFWT9Ss0ay5LLA8ROcMUe0Ietem7kG3Rg36fax3Maz
         hS/6cApI0UC3YDIb3lK5bNvv5YvGWWhb0jfUvfzPQAdVJMnBQ1sM/+5nGLf/SY3RQydk
         logw==
X-Forwarded-Encrypted: i=1; AJvYcCVOqxpeQ7h24e1OqlSdt+bP9dl7RjX69N++SkFchSJzxEvTjvVV/BFUR1w/+DK/x48cIXbf/t3RTSLKCiUonJKUY3yhwA2w1hlyBflD
X-Gm-Message-State: AOJu0YxhrpjhxCYb6C/Pc06oSfmBaK6o9zRnJx6jQsYeMdkzC0ipiTJe
	lHQJCOrrECLXrjcgziXmMjHKz9Pl8wkYCyfgjqeKQKZbdgYELPbwJrOLDPyoEeiD+eeu4pWq7LE
	m96X9d3a7oQIqBIyDUomtYJLlgy0=
X-Google-Smtp-Source: AGHT+IHIs1ObIko8smQY33wEreFY8eUyGblmVsRNQSkdicymVs2+Fy5wx2ybecf64OFdVQWodvsoH2QB2pwgNeQY1+E=
X-Received: by 2002:a0d:fd46:0:b0:60a:3487:6f74 with SMTP id
 n67-20020a0dfd46000000b0060a34876f74mr2123445ywf.7.1710425980805; Thu, 14 Mar
 2024 07:19:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308074921.45752-1-ioworker0@gmail.com> <ef409d5e-5652-4fff-933c-49bda6d75018@redhat.com>
 <CAK1f24k_+qAqxKGMpKziouuds=PQ6kfKyQ8D3SYEyW7cQOAJWw@mail.gmail.com>
 <75630ba6-79b6-4105-b614-29cfb0331084@redhat.com> <CAK1f24=vU5kEuJC6x099JGFD7z6FK5q+o1to7QY8Q12jNQzr_g@mail.gmail.com>
In-Reply-To: <CAK1f24=vU5kEuJC6x099JGFD7z6FK5q+o1to7QY8Q12jNQzr_g@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 14 Mar 2024 22:19:29 +0800
Message-ID: <CAK1f24ktQMYogUETyu04KahC1YAdrY1XwCNNrYUQXN4tSEPKsQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: reduce process visible downtime by
 pre-zeroing hugepage
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, songmuchun@bytedance.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	libang.li@antgroup.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Another thought suggested by Bang Li is that we record which pte is none
in hpage_collapse_scan_pmd. Then, before acquiring the mmap_lock (write mod=
e),
we will pre-zero pages as needed.

What do you think?

Thanks,
Lance

On Tue, Mar 12, 2024 at 9:55=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> On Tue, Mar 12, 2024 at 9:19=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 12.03.24 14:09, Lance Yang wrote:
> > > Hey David,
> > >
> > > Thanks for taking time to review!
> > >
> > > On Tue, Mar 12, 2024 at 12:19=E2=80=AFAM David Hildenbrand <david@red=
hat.com> wrote:
> > >>
> > >> On 08.03.24 08:49, Lance Yang wrote:
> > >>> The patch reduces the process visible downtime during hugepage
> > >>> collapse. This is achieved by pre-zeroing the hugepage before
> > >>> acquiring mmap_lock(write mode) if nr_pte_none >=3D 256, without
> > >>> affecting the efficiency of khugepaged.
> > >>>
> > >>> On an Intel Core i5 CPU, the process visible downtime during
> > >>> hugepage collapse is as follows:
> > >>>
> > >>> | nr_ptes_none  | w/o __GFP_ZERO | w/ __GFP_ZERO  |  Change |
> > >>> --------------------------------------------------=E2=80=94--------=
--
> > >>> |      511      |     233us      |      95us      |  -59.21%|
> > >>> |      384      |     376us      |     219us      |  -41.20%|
> > >>> |      256      |     421us      |     323us      |  -23.28%|
> > >>> |      128      |     523us      |     507us      |   -3.06%|
> > >>>
> > >>> Of course, alloc_charge_hpage() will take longer to run with
> > >>> the __GFP_ZERO flag.
> > >>>
> > >>> |       Func           | w/o __GFP_ZERO | w/ __GFP_ZERO |
> > >>> |----------------------|----------------|---------------|
> > >>> | alloc_charge_hpage   |      198us     |      295us    |
> > >>>
> > >>> But it's not a big deal because it doesn't impact the total
> > >>> time spent by khugepaged in collapsing a hugepage. In fact,
> > >>> it would decrease.
> > >>
> > >> It does look sane to me and not overly complicated.
> > >>
> > >> But, it's an optimization really only when we have quite a bunch of
> > >> pte_none(), possibly repeatedly so that it really makes a difference=
.
> > >>
> > >> Usually, when we repeatedly collapse that many pte_none() we're just
> > >> wasting a lot of memory and should re-evaluate life choices :)
> > >
> > > Agreed! It seems that the default value of max_pte_none may be set to=
o
> > > high, which could result in the memory wastage issue we're discussing=
.
> >
> > IIRC, some companies disable it completely (set to 0) because of that.
> >
> > >
> > >>
> > >> So my question is: do we really care about it that much that we care=
 to
> > >> optimize?
> > >
> > > IMO, although it may not be our main concern, reducing the impact of
> > > khugepaged on the process remains crucial. I think that users also pr=
efer
> > > minimal interference from khugepaged.
> >
> > The problem I am having with this is that for the *common* case where w=
e
> > have a small number of pte_none(), we cannot really optimize because we
> > have to perform the copy.
> >
> > So this feels like we're rather optimizing a corner case, and I am not
> > so sure if that is really worth it.
> >
> > Other thoughts?
>
> Another thought is to introduce khugepaged/alloc_zeroed_hpage for THP
> sysfs settings. This would enable users to decide whether to avoid unnece=
ssary
> copies when nr_ptes_none > 0.
>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

