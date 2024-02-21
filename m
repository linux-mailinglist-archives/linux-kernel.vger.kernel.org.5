Return-Path: <linux-kernel+bounces-75176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CC285E44B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A381F25063
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D0D83CAF;
	Wed, 21 Feb 2024 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COE6zeRD"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBFE81737
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535765; cv=none; b=h2Vjz/zQTptRqCVqjyDH2L8KdSDAobcbRMoOgSDEpOxeeEGpFHR0UHFlmZ3h3HIrV2rHBmx0PhC+S71wQSeU48sAxLb3zGcAw+2MUgr1RUtdcg+ytPs8vbFm1ZLN1dhdJ0/erv7SxwqcoKoFOXEMsEMMETp3JRlvLztfCELyAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535765; c=relaxed/simple;
	bh=RXmp5LBrNh470eyA/9PolaZXtxVx5YgBsg7qcaw0eTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7rDfVwjkGUOGBiBjRgst6wcwTo86Hgz5WH46hbEMlr/NLo06oW+9+fMhlUMwscWOW7HNFwlwA0SEFOctkEvGnO2Z1fHFpwLANmZbST573kx3TbzY1OVk/rImAiJpv0yVSiHEho+ZwvINc+gUs6WsFP2YTAXGjY3EYh6MUwDdCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COE6zeRD; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607f8482b88so53066637b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708535762; x=1709140562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJQdC7idwulVMBcihj7Q1mmstXpwh/b+WQal363i4yI=;
        b=COE6zeRDvNsWRujldSS4UYvKgTAEMrutNC7PPDX6tYxOKMAIuv4ihyd7wPfGJsPVYr
         RySAvhv2R67iVDWZucm0gxOEKFyD9603O1IPwc+keRdD4GSMI56PKf7cu9RKD9Q5YJNO
         fAzSLRAiaQ0ef4LQ7JDVoUoKot4oHaE30ufEumWmQWIUg4NTPROsg3WG5txp22iuJvwd
         PtRpDruQFpe5xLMTjFnxT5cvFZWw11FyVtEldSPyOEs0EAJuS7i2iHGA9OWlP7wkIyiQ
         /HF52mE6dDlHvlDcNA6/zs3qySgFdYVLTbQXH5gxHsFmS3PdWZR916JnwVNdLRq76unA
         KB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708535762; x=1709140562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJQdC7idwulVMBcihj7Q1mmstXpwh/b+WQal363i4yI=;
        b=FVkSsJWJZHudUNaEpex4/Jmdi7MQDoQTZeJmNtGrgsxgYhG7/nFakoSDeKMNuHO3XC
         B2jOcdjm0lmbKPbMJRLoteDXk+a62ZXtIDK0r/pK1MBACyohWUmN1L9m3i+PkGvUn8zr
         UyNKD9yO2vs3OS+kxHX6jpaJHZzlX4fOpTwXmpe4CqyZYzvvm0U4UJu8CsfS+TGF5cwp
         U+doJ8l+jcY0nJOJSthIBi+elXj2s9PK8qIXeeu+SepjcLEqXs4S8Nch2YWIPbOQgr8/
         0RPlwf5CCuPdkCMBHKjzywvjxyySX6CDsDmCfP2tKRVzGY31jpLRerETP+09Y6ti7ImW
         nATQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFx6u5qbctwQ+nqPHQSYRMB8fKueDo6QlbO2bZ/1o4qMfwXhllVoU2QbEIw/y2O/uN4ryx6V7T5NYYYkwNRznABnFBXiAhroxgwSsv
X-Gm-Message-State: AOJu0YxzyUso/VwQYSLuYo13wkB32nXgOSRi7hLgrvB9Eqk1mHL/1/pp
	LvDGGMGeSnBpRQUhCIEoGTmFwFOItm7/KlO8hBFpcjo2vt5AAU25H4H+b2T+7zu4kKIAgHTsk/J
	p9JMOW2AaKJW6301JCcf4cGGSL3dUZ0mE
X-Google-Smtp-Source: AGHT+IEAwFraNxv2gdyUkWs9AI8tRKZ6QfWhmLXP/8+SdHnZ8j9oEfXqNxxyODBqTs7e1+IEWyyGFcYSAuWRLBcothU=
X-Received: by 2002:a81:a103:0:b0:607:9d63:1a85 with SMTP id
 y3-20020a81a103000000b006079d631a85mr17916533ywg.44.1708535762484; Wed, 21
 Feb 2024 09:16:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220231424.126600-1-vishal.moola@gmail.com>
 <20240220231424.126600-3-vishal.moola@gmail.com> <ZdVx_Jr9tm2lV0Ku@casper.infradead.org>
In-Reply-To: <ZdVx_Jr9tm2lV0Ku@casper.infradead.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Wed, 21 Feb 2024 09:15:51 -0800
Message-ID: <CAOzc2pzLbiEpMuBpX7xXhZqPc0S6ZMnziT2uUFsa0tZe6yJQ0g@mail.gmail.com>
Subject: Re: [PATCH 2/3] hugetlb: Use vmf_anon_prepare() instead of anon_vma_prepare()
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 7:46=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Feb 20, 2024 at 03:14:23PM -0800, Vishal Moola (Oracle) wrote:
> > +++ b/mm/hugetlb.c
> > @@ -5834,9 +5834,15 @@ static vm_fault_t hugetlb_wp(struct mm_struct *m=
m, struct vm_area_struct *vma,
> >       struct folio *old_folio;
> >       struct folio *new_folio;
> >       int outside_reserve =3D 0;
> > -     vm_fault_t ret =3D 0;
> > +     vm_fault_t ret =3D 0, anon_ret =3D 0;
>
> Do we need a second variable here?  Seems to me like we could
> unconditionally assign to ret:

Hmm, looks like we can directly assign to ret without any problems
in both functions, I'll change that for v2.

> > -     if (unlikely(anon_vma_prepare(vma))) {
> > -             ret =3D VM_FAULT_OOM;
> > +     anon_ret =3D vmf_anon_prepare(&vmf);
> > +     if (unlikely(anon_ret)) {
> > +             ret =3D anon_ret;
>
>
>
> >       unsigned long haddr =3D address & huge_page_mask(h);
> >       struct mmu_notifier_range range;
> > +     struct vm_fault vmf =3D {
> > +                             .vma =3D vma,
> > +                             .address =3D haddr,
> > +                             .real_address =3D address,
> > +                             .flags =3D flags,
> > +     };
>
> We don't usually indent quite so far.  One extra tab would be enough.
>
> Also, I thought we talked about creating the vmf in hugetlb_fault(),
> then passing it to hugetlb_wp() hugetlb_no_page() and handle_userfault()?
> Was there a reason to abandon that idea?

No I haven't abandoned that idea, I intend to have a separate patchset to g=
o
on top of this one - just keeping them separate since they are conceptually
different. I'm converting each function to use struct vm_fault first, then
shifting it to be passed throughout as an arguement while cleaning up the
excess variables laying around. In a sense working bottom-up instead
of top-down.

