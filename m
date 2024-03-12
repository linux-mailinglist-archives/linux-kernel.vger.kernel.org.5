Return-Path: <linux-kernel+bounces-100308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF140879569
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A64281AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B847A720;
	Tue, 12 Mar 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fjt5HlMv"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012237A714
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710251769; cv=none; b=OPV+Mu+JTk9DH973gBCir4Y9+cnlCtIjV0IbMILm6e+V4JDE4e9U5X1HvTXLmcKwZ2Nhsul8hzfJ1YIUyyYto8uqk4C4Qqrz+0kHGKJwMOMLkU0uhpnV87sa+cGf+rFKmeM1mb9+t+hsuM8yHMJMm/jSSHLC6Wf/YHTX1CtQk0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710251769; c=relaxed/simple;
	bh=d4WSfFvuGkFn9DXJKI/4g6ZahD8330jonP6toAoB5/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGQ0t01vckpByZXUf9qF+coEtauxV+hJfIELP668Y1N/Zc0en620q0y7Vnjegur4Ph/l8ZFzkDc45uNhsKaakRjOhNedHbXBQuCdAl4wRDuGMqGkM4U3iADY3gaBFkakRb41J+eNjHpFQG9lvdVmlN/So2X9S5xUY6v8Wm86iOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fjt5HlMv; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6098a20ab22so48166387b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710251767; x=1710856567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ObhHYkbotn3YeHlHYrYqfV8bb8V+riZ34qdc2tMCTU=;
        b=Fjt5HlMvXQXHPNNGBiT6ynk6+1CAiGaiFq7p9vc/LFM0W7tVQ4DLOyzFG4v5xkmyi/
         Mkqoxkeh5iFYJ6EFAyMXqDk8qsww0dDLlT7S7vbjRhDEPD0B1hmIH5oGQScBNz3BxK6b
         snWo37mtAqbnkQ2SH0UGrsVt5gPqDSgGsgEM4Org6fa4PNAu1YJd3DRihMBw0MC0UrlY
         Bn5KnjGWLGopwuKQW+a073e2kRWTtrCewg5pwov26StlCj/P12g8ZDVA3TYstAQOTPQ5
         iy3hVu2SE/vByJmXyLz1A52p3Ki3zSNmHIGH/5lG8kfPdN97WrnCALFZVsz+z5WJPVJn
         QIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710251767; x=1710856567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ObhHYkbotn3YeHlHYrYqfV8bb8V+riZ34qdc2tMCTU=;
        b=UPxYjZ4nN+WdDAFy+mB95u2gCosnamV0lEKUYVIT0nFlxkiq1zmnatiSq376CqUsVB
         k0ut8wyVbTNF8qdLK8VZPN567GPOnlTBBUCwAExCColBXy88Exy2aOwA0HGF1qARINpO
         08ndvbBLgL/5XQe81WyXXqkVaKuja0Y7i0bV5mS/GBWD/EMvMrXof61stUh/u/AeE0qe
         k0mPTUAasPWGTdq/VPcKnMRN01xS5V9yE8IN/MyYWZR+hmQP7fOTkjzqz5DFgPylmCNX
         OpaehcwqiMWdVmG3WnQ0Xo+SAzJ5xY76d4Rw1UebAR+1AHqjuvJx2YlQFwNsICG97sE5
         GHUg==
X-Forwarded-Encrypted: i=1; AJvYcCV3n4+JSAuidktEFlViyDIjzQCPOnOLPrA7sF4QPEb0bG6VGg/v46e+vF+KOOkLP+V1LwpvDU4WcWLQXELJ1yGksJAEba/ZPuMOJNWK
X-Gm-Message-State: AOJu0YxfvBZgxAnYwKhtUYzWZEJa+vQoJ0gBe4SE0KiPyl7qXWOLcQpx
	P3apEAHkn23IeJ6/P1DV0CuLH7CUxBo2fkgUTK+wUfSUzyxXt4pT2B1kES7JNwjUV/qlecF69aC
	oBuD19m27TyAXIJCM6QxFN0CuZos=
X-Google-Smtp-Source: AGHT+IGzv+lKZEO35O6m8MkRNlv5HcmXLRTaaRXheWwJB1SR0QtsrhzIbMOmTmygNjfXHEASLfuerLzpKHUgaDPLQkM=
X-Received: by 2002:a0d:d94d:0:b0:60a:16b8:103f with SMTP id
 b74-20020a0dd94d000000b0060a16b8103fmr287298ywe.45.1710251766915; Tue, 12 Mar
 2024 06:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308074921.45752-1-ioworker0@gmail.com> <ef409d5e-5652-4fff-933c-49bda6d75018@redhat.com>
 <CAK1f24k_+qAqxKGMpKziouuds=PQ6kfKyQ8D3SYEyW7cQOAJWw@mail.gmail.com> <75630ba6-79b6-4105-b614-29cfb0331084@redhat.com>
In-Reply-To: <75630ba6-79b6-4105-b614-29cfb0331084@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 12 Mar 2024 21:55:55 +0800
Message-ID: <CAK1f24=vU5kEuJC6x099JGFD7z6FK5q+o1to7QY8Q12jNQzr_g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: reduce process visible downtime by
 pre-zeroing hugepage
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, songmuchun@bytedance.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 9:19=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 12.03.24 14:09, Lance Yang wrote:
> > Hey David,
> >
> > Thanks for taking time to review!
> >
> > On Tue, Mar 12, 2024 at 12:19=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 08.03.24 08:49, Lance Yang wrote:
> >>> The patch reduces the process visible downtime during hugepage
> >>> collapse. This is achieved by pre-zeroing the hugepage before
> >>> acquiring mmap_lock(write mode) if nr_pte_none >=3D 256, without
> >>> affecting the efficiency of khugepaged.
> >>>
> >>> On an Intel Core i5 CPU, the process visible downtime during
> >>> hugepage collapse is as follows:
> >>>
> >>> | nr_ptes_none  | w/o __GFP_ZERO | w/ __GFP_ZERO  |  Change |
> >>> --------------------------------------------------=E2=80=94----------
> >>> |      511      |     233us      |      95us      |  -59.21%|
> >>> |      384      |     376us      |     219us      |  -41.20%|
> >>> |      256      |     421us      |     323us      |  -23.28%|
> >>> |      128      |     523us      |     507us      |   -3.06%|
> >>>
> >>> Of course, alloc_charge_hpage() will take longer to run with
> >>> the __GFP_ZERO flag.
> >>>
> >>> |       Func           | w/o __GFP_ZERO | w/ __GFP_ZERO |
> >>> |----------------------|----------------|---------------|
> >>> | alloc_charge_hpage   |      198us     |      295us    |
> >>>
> >>> But it's not a big deal because it doesn't impact the total
> >>> time spent by khugepaged in collapsing a hugepage. In fact,
> >>> it would decrease.
> >>
> >> It does look sane to me and not overly complicated.
> >>
> >> But, it's an optimization really only when we have quite a bunch of
> >> pte_none(), possibly repeatedly so that it really makes a difference.
> >>
> >> Usually, when we repeatedly collapse that many pte_none() we're just
> >> wasting a lot of memory and should re-evaluate life choices :)
> >
> > Agreed! It seems that the default value of max_pte_none may be set too
> > high, which could result in the memory wastage issue we're discussing.
>
> IIRC, some companies disable it completely (set to 0) because of that.
>
> >
> >>
> >> So my question is: do we really care about it that much that we care t=
o
> >> optimize?
> >
> > IMO, although it may not be our main concern, reducing the impact of
> > khugepaged on the process remains crucial. I think that users also pref=
er
> > minimal interference from khugepaged.
>
> The problem I am having with this is that for the *common* case where we
> have a small number of pte_none(), we cannot really optimize because we
> have to perform the copy.
>
> So this feels like we're rather optimizing a corner case, and I am not
> so sure if that is really worth it.
>
> Other thoughts?

Another thought is to introduce khugepaged/alloc_zeroed_hpage for THP
sysfs settings. This would enable users to decide whether to avoid unnecess=
ary
copies when nr_ptes_none > 0.

>
> --
> Cheers,
>
> David / dhildenb
>

