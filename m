Return-Path: <linux-kernel+bounces-110181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFB4885B35
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E19AFB21863
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C02185945;
	Thu, 21 Mar 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax44H9x5"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E761E534
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032936; cv=none; b=AmKapdcuORU2T6rdNuT6RoaGjNWpty3rQbL5HZ/icIJTWIVWzK2pR2z4N0Ky1cao7xUkE3e2CZPuwoPA9egOfojfE1Jt4zRRmYVNx8/CElzT0dP6b9glxqLNIJX6EEold7N4/x/1RzYMnBS0wEOvK4aDZD6kZZpLbVHiSL8FXJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032936; c=relaxed/simple;
	bh=yOqGDMtSEY8gSbHLjKji+nvAzofh7Ih4vZCwoz+o0Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/XnHAcs40j9BV1XyBzc51k4j1efhGjN4rd/9FBnXZqgesPeDbzAzQLMW5jkErRImZTkWlGqXNKNd3OagXkLqc0nvaxA4JK42GiGJ+XnPqGRErN4WofhZEHS1pvFSyHRenp0Co9qoqRnlJUDSQVV7fmHZ+7OYfw/T98DKgdrgns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ax44H9x5; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso1022715276.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711032933; x=1711637733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9okbR8OL96sSf2IB4vvfZKNVvRdwRzTGD+ZoPzW3rc=;
        b=ax44H9x5z1bzc4aHvINVDl2eYH6rju3lv0PROw+M80AlJ15X8EB/i8zpzvMshcaeww
         HZU7T+NBgYqXZKHo8PGirgGmYBiSQYMamT5AlPKn1sQeLFsdEg7arbI2J8qo1tzWEbWL
         4tQFbQI7D2DfAq8s/iHjpnCGetmV/ieJjt4Txgfn9HjL0ZUcTgtN7QYby0wz8QX0vOzK
         Xb/8K/wFCfymbnIwaleTNhg1w+sK1RvSjy92+9QWWkfrp/sr5ciN5J4ECMhGvnVdfOgz
         SldDhJD0kXSS/KyIVDIRQ2Tt8bEibliaLw2GJlEQUOQwN1W5wIj9EAEaWhdK6oyIWvYX
         oKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711032933; x=1711637733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9okbR8OL96sSf2IB4vvfZKNVvRdwRzTGD+ZoPzW3rc=;
        b=ZKPfPVVS5hU83K5Vp8MzQVJeWTpTwNxA+Wm0AjNAhTzvnvrb29tSfxIeI4kOD45hVJ
         9yrX6tBgQCY6qbzw+k04MPDJYj/Yt9PdqNaPzV8/BfWWBHUxfj8xCesIxSAwsnnL0lxm
         Hm58e844DolD/p0bl3lrOmjpzbzD25NKpMZ+U2/pDSDLNog1aF79qlc9xJ9TUMq/HEt+
         SncGVLOMOaw19cv4g8qMd/yki/3PQ0bVO+m3AQ4siG8JGjLGSPyvfDRJc/Rld15qNVxp
         uQRlX91N9BSIlErii6BazDSl7x3xwluUSdmNE5k59PiWg16P8unuyv9dPDFU4b5gFPLj
         FBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ13srG6C+CE77JbjtqLQQBICZrx/AyXBDYF8DaviFjyPb/fWIaX4+c0bBByivrOFsQQE+fgz/kU1Acij61fnwHll+kVucsPGr6+Sz
X-Gm-Message-State: AOJu0YxxspUMDET42xnFFuhDfmxYcEvSnDbtC9DLT8q2Tiw7f7vS8fDc
	XLGaNaxcI/jBQIpI2Gr5W1yer1y4v8872wtG/MCUU/vjG1lss9M5cNrmfF4TTJrUG+rxJPExoA2
	FnFK6HPxg/r83HoLBZbI+6j7Mz3A=
X-Google-Smtp-Source: AGHT+IHJvcwqqVXTtvQyBSUp28DwTVgCQkYFl2W4XIt5+pd5oRbNxiwwujUARlkIt7BMX3SDfNCgMzs2G/n87mYiRI0=
X-Received: by 2002:a25:c504:0:b0:dc2:279f:f7e with SMTP id
 v4-20020a25c504000000b00dc2279f0f7emr1975834ybe.10.1711032933307; Thu, 21 Mar
 2024 07:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-7-ryan.roberts@arm.com> <CAGsJ_4wpjqRsn7ouO=Ut9oMBLSh803=XuSPX6gJ5nQ3jyqh3hQ@mail.gmail.com>
 <a75ec640-d025-45ee-b74d-305aaa3cc1ce@arm.com> <CAK1f24k1AuHDdrLFNLvwdoOy=xJTVkVdfY4+SN+KW5-EiMSa9Q@mail.gmail.com>
 <7ba06704-2090-4eb2-9534-c4d467cc085a@arm.com> <CAK1f24=yDVwOC31sNMaoZ6K2q1X8vA7p4CtS7nW5WXCm19iEdg@mail.gmail.com>
 <add3b9fc-f08a-4bd4-b01e-4409e81d5a2d@arm.com> <CAK1f24kRXZtKckRFxJfQCNSHJOHy4_nv67T+BfWeWyVtEggdNQ@mail.gmail.com>
 <269375a4-78a3-4c22-8e6e-570368a2c053@arm.com>
In-Reply-To: <269375a4-78a3-4c22-8e6e-570368a2c053@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 21 Mar 2024 22:55:21 +0800
Message-ID: <CAK1f24m+oQgBYdxUaTASMtJpnUEQvWh-t_kVw7CJzVM4Siddcg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and MADV_COLD
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 9:38=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> >>>>>>>> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> >>>>>>>> -
> >>>>>>>> -               if (!pageout && pte_young(ptent)) {
> >>>>>>>> -                       ptent =3D ptep_get_and_clear_full(mm, ad=
dr, pte,
> >>>>>>>> -                                                       tlb->ful=
lmm);
> >>>>>>>> -                       ptent =3D pte_mkold(ptent);
> >>>>>>>> -                       set_pte_at(mm, addr, pte, ptent);
> >>>>>>>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> >>>>>>>> +               if (!pageout) {
> >>>>>>>> +                       for (; nr !=3D 0; nr--, pte++, addr +=3D=
 PAGE_SIZE) {
> >>>>>>>> +                               if (ptep_test_and_clear_young(vm=
a, addr, pte))
> >>>>>>>> +                                       tlb_remove_tlb_entry(tlb=
, pte, addr);
> >>>>>
> >>>>> IIRC, some of the architecture(ex, PPC) don't update TLB with set_p=
te_at and
> >>>>> tlb_remove_tlb_entry. So, didn't we consider remapping the PTE with=
 old after
> >>>>> pte clearing?
> >>>>
> >>>> Sorry Lance, I don't understand this question, can you rephrase? Are=
 you saying
> >>>> there is a good reason to do the original clear-mkold-set for some a=
rches?
> >>>
> >>> IIRC, some of the architecture(ex, PPC)  don't update TLB with
> >>> ptep_test_and_clear_young()
> >>> and tlb_remove_tlb_entry().
>
> Afraid I'm still struggling with this comment. Do you mean to say that po=
werpc
> invalidates the TLB entry as part of the call to ptep_test_and_clear_youn=
g()? So
> tlb_remove_tlb_entry() would be redundant here, and likely cause performa=
nce
> degradation on that architecture?

I just thought that using ptep_test_and_clear_young() instead of
ptep_get_and_clear_full() + pte_mkold() might not be correct.
However, it's most likely that I was mistaken :(

I also have a question. Why aren't we using ptep_test_and_clear_young() in
madvise_cold_or_pageout_pte_range(), but instead
ptep_get_and_clear_full() + pte_mkold() as we did previously.

/*
* Some of architecture(ex, PPC) don't update TLB
* with set_pte_at and tlb_remove_tlb_entry so for
* the portability, remap the pte with old|clean
* after pte clearing.
*/

According to this comment from madvise_free_pte_range. IIUC, we need to
call ptep_get_and_clear_full() to clear the PTE, and then remap the
PTE with old|clean.

Thanks,
Lance

>
> IMHO, ptep_test_and_clear_young() really shouldn't be invalidating the TL=
B
> entry, that's what ptep_clear_flush_young() is for.
>
> But I do see that for some cases of the 32-bit ppc, there appears to be a=
 flush:
>
> #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
> static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
>                                               unsigned long addr, pte_t *=
ptep)
> {
>         unsigned long old;
>         old =3D pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
>         if (old & _PAGE_HASHPTE)
>                 flush_hash_entry(mm, ptep, addr);   <<<<<<<<
>
>         return (old & _PAGE_ACCESSED) !=3D 0;
> }
> #define ptep_test_and_clear_young(__vma, __addr, __ptep) \
>         __ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep)
>
> Is that what you are describing? Does any anyone know why flush_hash_entr=
y() is
> called? I'd say that's a bug in ppc and not a reason not to use
> ptep_test_and_clear_young() in the common code!
>
> Thanks,
> Ryan
>
>
> >>
> >> Err, I assumed tlb_remove_tlb_entry() meant "invalidate the TLB entry =
for this
> >> address please" - albeit its deferred and batched. I'll look into this=
.
> >>
> >>>
> >>> In my new patch[1], I use refresh_full_ptes() and
> >>> tlb_remove_tlb_entries() to batch-update the
> >>> access and dirty bits.
> >>
> >> I want to avoid the per-pte clear-modify-set approach, because this do=
esn't
> >> perform well on arm64 when using contpte mappings; it will cause the c=
ontpe
> >> mapping to be unfolded by the first clear that touches the contpte blo=
ck, then
> >> refolded by the last set to touch the block. That's expensive.
> >> ptep_test_and_clear_young() doesn't suffer that problem.
> >
> > Thanks for explaining. I got it.
> >
> > I think that other architectures will benefit from the per-pte clear-mo=
dify-set
> > approach. IMO, refresh_full_ptes() can be overridden by arm64.
> >
> > Thanks,
> > Lance
> >>
> >>>
> >>> [1] https://lore.kernel.org/linux-mm/20240316102952.39233-1-ioworker0=
@gmail.com
> >>>
> >>> Thanks,
> >>> Lance
> >>>
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>> Lance
> >>>>>
> >>>>>
> >>>>>
> >>>>>>>> +                       }
> >>>>>>>
> >>>>>>> This looks so smart. if it is not pageout, we have increased pte
> >>>>>>> and addr here; so nr is 0 and we don't need to increase again in
> >>>>>>> for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE)
> >>>>>>>
> >>>>>>> otherwise, nr won't be 0. so we will increase addr and
> >>>>>>> pte by nr.
> >>>>>>
> >>>>>> Indeed. I'm hoping that Lance is able to follow a similar pattern =
for
> >>>>>> madvise_free_pte_range().
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>>                 }
> >>>>>>>>
> >>>>>>>>                 /*
> >>>>>>>> --
> >>>>>>>> 2.25.1
> >>>>>>>>
> >>>>>>>
> >>>>>>> Overall, LGTM,
> >>>>>>>
> >>>>>>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> >>>>>>
> >>>>>> Thanks!
> >>>>>>
> >>>>>>
> >>>>
> >>
>

