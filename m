Return-Path: <linux-kernel+bounces-92148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2385A871BE2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54761F24C94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E2A60BA2;
	Tue,  5 Mar 2024 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzqPyjKb"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B055C1B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634523; cv=none; b=GMd10bZEuF/utUADQGsZ3hGbX53XICdtA+Msam/b0OogHd/DKcBMaKf9r0XgVGylBzX9gd/giotO2atDsEN7WT9zKZYK+gsg/AliOvYqtudXa4/3UeRL2sDdAoplXCZvZx06Dalh9hTFyfs7dpUrehFhKqurwYI8FS9Ke1qSjjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634523; c=relaxed/simple;
	bh=wXXDbDc6ZFu0KtNPdSjgQJ89yBc5rY7np2jNK4Gh3Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnG7HuqtOIsrf6M1HbRFwoW0q9SPHg/VyUBFsRuY6qjLK+L8KYWuI63iM2V/UjHh2aOiTZx0lEcQTvParqXwsh3UHOZwyvyPqxX3TVzgvMTGrnRLqPoEenIufMgY1JtPbhubQW9sMlaHjaFupNLBFPxlWCLcI9a6HdF5TweekLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzqPyjKb; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7db36dbd474so1004311241.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709634521; x=1710239321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FN77tpG/quuLoYWsibOIr1ogL/zcsrl/LxCdvi8UsMs=;
        b=MzqPyjKbF1Dx8OpbgfaqVvVgDC7EvD2FNH7eEA6ZXhwkGv71VBFtjFAC2goVL0rx23
         DR24VKpFI6jSr/BiAdhL8qXcAHba8Uoozlu+JVgw1Eqf+TEbKI+iaI7TVlsygOlV/fCv
         TfZyZdLYsQs13Fe8F9riGvhxJUVV321Wz3OtEvgnm2ZPR8v0e0Bpj3Xl6hyJMaSZoWIh
         /35r2XAKf2XUXT1/mQCKaf9+eY94FnFLI7ShBk5lYyTHmBQQ4T18nLavAECbSAJWdEFI
         mf7enyd3bYns/vHHXDFSADufeD6NqK/L46K4kV5Jo4ICCPS7yGpMSm64SWRDnXuZbIMI
         YrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709634521; x=1710239321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FN77tpG/quuLoYWsibOIr1ogL/zcsrl/LxCdvi8UsMs=;
        b=EOhwQOVHtv5dpRTMOboc0Qnpczso1J3AyLnkvfUrPkDgR8CVh0wSeHcBh8WRK+mWmt
         QipIpVPqr4Ks+O6QVVDVsOofcAXuYHG0FCGGG6+4VWUUYOMZDcNMK7/M0zdgD2ieRZAz
         svdV9NKovpsBpVtNoxN//F15oMdrVkfbO5nLUFwIRDCyFEXPg2QaJNQk9pQHP7TZHsx9
         P12w1LSlURifvd54ZfbIOQa+H1W1V1nEEVbCUgmrbtHdG61YqPtGkA+3tJcFdqPOh0Ge
         +BGnIuKDEGtCGAGXb3mwIrQDc0dYehO7m5j3vSAZ1KstNNJl5RZ1EtruQbw4zc6hL2+2
         Jl6g==
X-Forwarded-Encrypted: i=1; AJvYcCXK5p5xWlGJZ94qbT7xPKRjJxhFp3r44yhUJrs9DZQcaI35ESxDNu6Jwhxsbe80e143TY8+BXVC/M/dUQjVSth36C3GYmk2G+kDm4L/
X-Gm-Message-State: AOJu0YwwR8WmrUeNSRsAm6x3zLAT2i0mxUZZ6eQOmQjz5JU8lpNi496m
	h1zcSwuRtCL6h2lzmLYA/7UgRSczbIVrYT1hY7EqrzevztnT3paCEKOS578FI/9xPzip8xxX+Rb
	m29OsZapqop33KtVzokOjWao7xdI=
X-Google-Smtp-Source: AGHT+IEp8JxXlndv9uy0AGNOONqWLNFxFTbENb7RZGxpF1laqBG6jfI0UahxVLO2sukcoc6AlZ9ivj5GMuHqAALOzWI=
X-Received: by 2002:a05:6102:2cb:b0:471:f1a2:13c8 with SMTP id
 h11-20020a05610202cb00b00471f1a213c8mr1336080vsh.11.1709634521118; Tue, 05
 Mar 2024 02:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304103757.235352-1-21cnbao@gmail.com> <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
 <37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com> <CAGsJ_4yJ3yCyN_KgBO8W+jFx8RN6_JhS9OwX3FH6X_gpU7g62w@mail.gmail.com>
 <804524c8-772c-42d0-93a5-90d77f13f304@redhat.com> <CAGsJ_4yqUW46xyDtZ4X1wQZ2_0bLM85Euz2BufERa75Rg+gVyw@mail.gmail.com>
 <87r0gp868d.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4xUdqpWaYDrNV3Fbh=3cWyoDJz3AbWa=mfsKbka+MAVag@mail.gmail.com>
 <87il2182nr.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wYVogJD=ROfX195MPZrqK+=ibuycPBeFjrD1i9SvOqrw@mail.gmail.com>
In-Reply-To: <CAGsJ_4wYVogJD=ROfX195MPZrqK+=ibuycPBeFjrD1i9SvOqrw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Mar 2024 23:28:29 +1300
Message-ID: <CAGsJ_4w49DOycVmCuhJ2jcD+XNP6epT4rZ1YK6DU20DHNEyOdg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
To: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, chrisl@kernel.org, yuzhao@google.com, 
	hanchuanhua@oppo.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
	xiang@kernel.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:21=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Mar 5, 2024 at 10:12=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
> >
> > Barry Song <21cnbao@gmail.com> writes:
> >
> > > On Tue, Mar 5, 2024 at 8:55=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
> > >>
> > >> Barry Song <21cnbao@gmail.com> writes:
> > >>
> > >> > On Tue, Mar 5, 2024 at 10:15=E2=80=AFAM David Hildenbrand <david@r=
edhat.com> wrote:
> > >> >> > But we did "resolve" those bugs by entirely untouching all PTEs=
 if we
> > >> >> > found some PTEs were skipped in try_to_unmap_one [1].
> > >> >> >
> > >> >> > While we find we only get the PTL from 2nd, 3rd but not
> > >> >> > 1st PTE, we entirely give up on try_to_unmap_one, and leave
> > >> >> > all PTEs untouched.
> > >> >> >
> > >> >> > /* we are not starting from head */
> > >> >> > if (!IS_ALIGNED((unsigned long)pvmw.pte, CONT_PTES * sizeof(*pv=
mw.pte))) {
> > >> >> >                     ret =3D false;
> > >> >> >                     atomic64_inc(&perf_stat.mapped_walk_start_f=
rom_non_head);
> > >> >> >                     set_pte_at(mm, address, pvmw.pte, pteval);
> > >> >> >                     page_vma_mapped_walk_done(&pvmw);
> > >> >> >                     break;
> > >> >> > }
> > >> >> > This will ensure all PTEs still have a unified state such as CO=
NT-PTE
> > >> >> > after try_to_unmap fails.
> > >> >> > I feel this could have some false postive because when racing
> > >> >> > with unmap, 1st PTE might really become pte_none. So explicitly
> > >> >> > holding PTL from 1st PTE seems a better way.
> > >> >>
> > >> >> Can we estimate the "cost" of holding the PTL?
> > >> >>
> > >> >
> > >> > This is just moving PTL acquisition one or two PTE earlier in thos=
e corner
> > >> > cases. In normal cases, it doesn't affect when PTL is held.
> > >>
> > >> The mTHP may be mapped at the end of page table.  In that case, the =
PTL
> > >> will be held longer.  Or am I missing something?
> > >
> > > no. this patch doesn't change when we release PTL but change when we
> > > get PTL.
> > >
> > > when the original code iterates nr_pages PTEs in a large folio, it wi=
ll skip
> > > invalid PTEs, when it meets a valid one, it will acquire PTL. so if i=
t gets
> > > intermediate PTE values some other threads are modifying, it might
> > > skip PTE0, or sometimes PTE0 and PTE1 according to my test. but
> > > arriving at PTE2, likely other threads have written a new value, so w=
e
> > > will begin to hold PTL and iterate till the end of the large folio.
> >
> > Is there any guarantee that the mTHP will always be mapped at the
> > beginning of the page table (PTE0)?  IIUC, mTHP can be mapped at PTE496=
.
> > If so, with your patch, PTL will be held from PTE0 instead of PTE496 in
> > some cases.
>
> I agree. but in another discussion[1], the plan is if we find a large fol=
io has
> been deferred split, we split it before try_to_unmap and pageout. otherwi=
se,
> we may result in lots of redundant I/O, because PTE0-495 will still be
> pageout()-ed.
>
> [1] https://lore.kernel.org/linux-mm/a4a9054f-2040-4f70-8d10-a5af4972e5aa=
@arm.com/

I thought about this again, seems we can cope with it even w/o the above pl=
an
by:

+ if (folio_test_large(folio) && list_empty(&folio->_deferred_list))
+              flags |=3D TTU_SYNC;

if a folio has been deferred split, it seems no sense to have the optimizat=
ion
for the corner cases this patch wants to provide. Only while we know this
folio is still entirely mapped, we have this optimization. This should have
reduced the chance to be quite small though we still have a bit.

>
> >
> > --
> > Best Regards,
> > Huang, Ying
> >
> > > The proposal is that we directly get PTL from PTE0, thus we don't get
> > > intermediate values for the head of nr_pages PTEs. this will ensure
> > > a large folio is either completely unmapped or completely mapped.
> > > but not partially mapped and partially unmapped.
> > >
> > >>

Thanks
Barry

