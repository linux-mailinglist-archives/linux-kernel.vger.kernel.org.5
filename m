Return-Path: <linux-kernel+bounces-24922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9485A82C4B9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96771C21C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB5C2262D;
	Fri, 12 Jan 2024 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yfU83nNg"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8316A175A3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5fc2e997804so5853417b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705080702; x=1705685502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pz+3iGhrnb+ZuxKUBKuJ2apXdm0vVIBrk/mh4QD2xmU=;
        b=yfU83nNgrNLEQk2fNZ44QuzSiUb5jEYpegauz5gs5fSJblPFEpB2DWpcKEKj6WccVT
         Ni7zJMiKyLheksYYwaGhi3XmG/njSXjMyS8ETeKr2hhmXnKBVGFrZj4jetWH530l/rbs
         vtjL5sxEnOL8PrblQzuCuBFB0a+5NHtzR0Ql1gUrQ4dSKTAQwIcQhuGsQ1RxLWFoQhjZ
         Pny5zavW6jmonL5l3h/aURKg4s2jiaZsHLeHuqEeke/iCYfj8AvZv5IwlRL/hgInCvFK
         QLt9eMzNaFhyfswuyVAOFrxFhywbk+zZU9VgymtnPB22xiPHKazbsVgitJQI3VssA5zP
         6WFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705080702; x=1705685502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pz+3iGhrnb+ZuxKUBKuJ2apXdm0vVIBrk/mh4QD2xmU=;
        b=Ls8CCjE2FGMITn6gm2W2wmtbhznLDMPwg8/aaCiHm9aRXKT3oGvej2WRkjpYa4Bt6r
         EAgI3JxKHNvT4KjuY/zRQQxIO+uQNI4hUGGk2U/qfPjQ67Cn0sWekWrYV7OQeHJ+hyaF
         6s5wYg2dWI4DEvJWjQXa6Vf/laBl0P0JUtHx7e4lfc/XPqrOPVBG4dyMnfUr3gEKQW/3
         FA0x6GnxEMybaoQHwSAZRKfJ5yzk98pouYGcrfukp17ys33NfPbrnOeems6D2U7MzKyB
         x/ectg/YuneiBqwxBrGyJWN0fQBe/f0RRyPzPQuHz9posH2mTNs46x1MDujEMeg6wiEE
         UxSQ==
X-Gm-Message-State: AOJu0YxGs0BQS4zKStzwwob8P2OrsZaQhcLnTZTdRVVVrHsvfVhOrb55
	oB/Rz4HhKlKoBHAX1GSPb8YHSqGxYUbUcZn5PfvA58UY40yQ+yxFKp02OiCqtg==
X-Google-Smtp-Source: AGHT+IHBb5mDw+d8Tra+UVvOzbfRUJqQK71uVqt24u7gwAq0b8xOdU2w+foZ0OV0Oz970+U0g8un3UIE1MrduUh832k=
X-Received: by 2002:a81:5291:0:b0:5f9:d44:2fd9 with SMTP id
 g139-20020a815291000000b005f90d442fd9mr1628503ywb.93.1705080701888; Fri, 12
 Jan 2024 09:31:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112013935.1474648-1-surenb@google.com> <511e07da-9b34-4707-8f5a-f1e534c4445a@redhat.com>
In-Reply-To: <511e07da-9b34-4707-8f5a-f1e534c4445a@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 12 Jan 2024 09:31:28 -0800
Message-ID: <CAJuCfpHQn1ruQy_L073bMDaeohsXrpAQnxc7rrKJ43d5wZUt3Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: avoid huge_zero_page in UFFDIO_MOVE
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, sfr@canb.auug.org.au, peterx@redhat.com, 
	aarcange@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzbot+705209281e36404998f6@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 12:57=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 12.01.24 02:39, Suren Baghdasaryan wrote:
> > While testing UFFDIO_MOVE ioctl, syzbot triggered VM_BUG_ON_PAGE caused
> > by a call to PageAnonExclusive() with a huge_zero_page as a parameter.
> > UFFDIO_MOVE does not yet handle zeropages and returns EBUSY when one is
> > encountered. Add an early huge_zero_page check in the PMD move path
> > to avoid this situation.
> >
> > Reported-by: syzbot+705209281e36404998f6@syzkaller.appspotmail.com
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> > Applies cleanly over linux-next, mm-stable and mm-unstable branches
> >
> >   mm/userfaultfd.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 216ab4c8621f..20e3b0d9cf7e 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1393,6 +1393,12 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, =
struct mm_struct *mm,
> >                               err =3D -ENOENT;
> >                               break;
> >                       }
> > +                     /* Avoid moving zeropages for now */
> > +                     if (is_huge_zero_pmd(*src_pmd)) {
> > +                             spin_unlock(ptl);
> > +                             err =3D -EBUSY;
> > +                             break;
> > +                     }
>
> As an alternative (and more future proof?) just reject anything that is
> not an anon folio as well?

Yes, but I'm going to remove this check shortly, once zeropage
movement patch is ready.

>
> Anyhow, this should handle the issue at hand.
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

>
> --
> Cheers,
>
> David / dhildenb
>

