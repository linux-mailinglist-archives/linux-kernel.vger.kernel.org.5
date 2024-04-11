Return-Path: <linux-kernel+bounces-141691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D5B8A2208
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E3B1F23E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD1F47772;
	Thu, 11 Apr 2024 23:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnDl1vKP"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43DA1DFE3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876516; cv=none; b=bj1O1rrleDvUvAsM1LiR4QPhYt9H/JuuRs6uO1S+cqKwtHuJw3gVnvkbxMLUi3Wk4M+uIhZKvwOXACR7Yoy8X1CTtsds3GRJ6qKFCMm46zeEln6rufRq9X9PQseeomh/SEcQy+7VaTNYdoVzil6AOzLlwtERP+/eNQrOJG1/wUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876516; c=relaxed/simple;
	bh=/FXQYGQ1E38Ij0P4S0Ll5PqxzGiDcW6Q1n13UfK+R9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kq/7hIA+UNepuxUD0FV/4HQ+mxBXyVlcWeg+rHwG4DyEuINF0AvITTGT3tE8gjwEuES+nf7cht0OjIrMQyQFXUqIZ+llhn8fvEWO2oGlw70SlHdhp4QVtH8T959ciNKMOX/Ffukriwbf/ixxdJkVWk1A5V4qPAR3lWeKl9q3JMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnDl1vKP; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c61101874eso115816b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712876514; x=1713481314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7Gsq+XB7X2BWSBlXn7jraeh3YIIGyWH+QFowQBTq94=;
        b=EnDl1vKP7ILnn9din6avfWIle4xJ5o6zenm86F20ak0JRZWBPPDwktT2mHL+JnhOfJ
         DuGK1Pbc0Pk47mFAD+kWZTSVXXAhEbNTb+ZtWbmnKvlQvmSKIi+3PCnEeZmqHdvuj7XX
         Ho30Qw1HC5p3MuqgpZo67LqJQobGR+vCNNr//EVuggxlee70HkX1B/cX+5edMnyw/d7B
         b/EQB9b5AO1IXmuik2frjU8UuvBJLdxuGDEKyp6d0F59TTWhtnNH3h1aKAL6Ue0DkYkR
         SLhEku3PiqEuUc4dQZ5qBmCKoxksOqTYMh6Sg85V1yeAgsULBhm0T/Ts0uAZpfyLJWSp
         S2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712876514; x=1713481314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7Gsq+XB7X2BWSBlXn7jraeh3YIIGyWH+QFowQBTq94=;
        b=qsTy/Mowy1NK9T5LqC+FRHxt93h1AoO9VSnbPdyU5sUdY6mN+5A8OeM49PV1/w+bZ5
         r0/70EnlTQwbaKWDlF1ZsBzjmnE98a79E1Ktj7vG1kwhGkE1xy/cDKHApCMLj1Xu09oO
         wVlZ0ZEfNMPuFigJQHCDgdL+PZ0mtuISizNs5ZygJhGPyGA5oRkyoccj5npNbWi4vTGL
         FYFHE+Si97FqH8Z2HHW8Hl21ZAFcEGtZCnox3YVkSbS8DyO/qdlyFqKU4QjbxO/ox7g6
         berDOGTykUilE/49kSuv21R9pem9Q2xuJNY4+9quSjpS6qmVClLEjc3OU8VMImVPPrQm
         5jIg==
X-Forwarded-Encrypted: i=1; AJvYcCUJFn104ZdENCEbqytarp2uCbN81ogDtACifVJuOoHnKMDjsJRzZEfZ/4gMjU1QXg5bmCg/sOagk3HMaaQzXuAU90kkdMODA4BJMBbo
X-Gm-Message-State: AOJu0YyyoqVPaZ5IpeYkOZQYYiRXH8GoAvzfrlnHabIZWnmb1TVrAtWa
	BuQZ7QVTnPLfPK9tH5WanzV4tW6n9jtg/OtEHZI69U+KIsITpxUgpu5il7VceoOxgDNFwGvtb7N
	Xc9u9RkctqXhtCp3tpu8r9QVP+D0=
X-Google-Smtp-Source: AGHT+IG8wmZYba6rzxIb/ffT5ygiK4Pd5xPj9Vx2Dfekrl+jvEdQnfMM3W0iGyOC9zFAyIOSha/ihfyImXVapcbJuQw=
X-Received: by 2002:a05:6808:1a07:b0:3c6:573:bf3f with SMTP id
 bk7-20020a0568081a0700b003c60573bf3fmr1458975oib.27.1712876512555; Thu, 11
 Apr 2024 16:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-6-21cnbao@gmail.com>
 <226c4935-def2-4d72-b0bb-308578d1e0b1@arm.com>
In-Reply-To: <226c4935-def2-4d72-b0bb-308578d1e0b1@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 12 Apr 2024 11:01:41 +1200
Message-ID: <CAGsJ_4y07BjVQRG01jEVg3Guc8rxSWFhSO7fzSAZ8XD0YWusLQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mm: add per-order mTHP swpin_refault counter
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 3:53=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 09/04/2024 09:26, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Currently, we are handling the scenario where we've hit a
> > large folio in the swapcache, and the reclaiming process
> > for this large folio is still ongoing.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  include/linux/huge_mm.h | 1 +
> >  mm/huge_memory.c        | 2 ++
> >  mm/memory.c             | 1 +
> >  3 files changed, 4 insertions(+)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index c8256af83e33..b67294d5814f 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -269,6 +269,7 @@ enum mthp_stat_item {
> >       MTHP_STAT_ANON_ALLOC_FALLBACK,
> >       MTHP_STAT_ANON_SWPOUT,
> >       MTHP_STAT_ANON_SWPOUT_FALLBACK,
> > +     MTHP_STAT_ANON_SWPIN_REFAULT,
>
> I don't see any equivalent counter for small folios. Is there an analogue=
?

Indeed, we don't count refaults for small folios, as their refault
mechanism is much
simpler compared to large folios. Implementing this counter can enhance the
system's visibility to users.

Personally, having this counter and observing a non-zero value greatly enha=
nces
my confidence when debugging this refault series. Otherwise, it feels like =
being
blind to what's happening inside the system :-)

>
> >       __MTHP_STAT_COUNT
> >  };
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index d8d2ed80b0bf..fb95345b0bde 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -556,12 +556,14 @@ DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_ANON_=
ALLOC);
> >  DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLBA=
CK);
> >  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
> >  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALL=
BACK);
> > +DEFINE_MTHP_STAT_ATTR(anon_swpin_refault, MTHP_STAT_ANON_SWPIN_REFAULT=
);
> >
> >  static struct attribute *stats_attrs[] =3D {
> >       &anon_alloc_attr.attr,
> >       &anon_alloc_fallback_attr.attr,
> >       &anon_swpout_attr.attr,
> >       &anon_swpout_fallback_attr.attr,
> > +     &anon_swpin_refault_attr.attr,
> >       NULL,
> >  };
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 9818dc1893c8..acc023795a4d 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4167,6 +4167,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               nr_pages =3D nr;
> >               entry =3D folio->swap;
> >               page =3D &folio->page;
> > +             count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN_=
REFAULT);
>
> I don't think this is the point of no return yet? There's the pte_same() =
check
> immediately below (although I've suggested that needs to be moved to earl=
ier),
> but also the folio_test_uptodate() check. Perhaps this should go after th=
at?
>

swap_pte_batch() =3D=3D nr_pages should have passed the test for pte_same.
folio_test_uptodate(folio)) should be also unlikely to be true as we are
not reading from swap devices for refault case.

but i agree we can move all the refault handling after those two "goto
out_nomap".

> >       }
> >
> >  check_pte:
>

Thanks
Barry

