Return-Path: <linux-kernel+bounces-79881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D818627E2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE059281EF4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906874D13B;
	Sat, 24 Feb 2024 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zaan8wra"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB1E4C615
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708811679; cv=none; b=ONU+34ZcKAtruT/CHfprlctCdzr5VAPTqFRWZb5ScTXb7k0W+r128ul8WgfaOAjRh8O6WQOzJXuzS85c6ClZpmlN1aF5EAzLYoaqHHPYY18dUsNvK2oTmNQT70TguXk2BV0FQeYM/S6uW2KItIexgNGbD1BtWLSHluK1xsRlY2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708811679; c=relaxed/simple;
	bh=C7M4IDcO/itpux2RkO408k8t768INtVRRFqA+25EYaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERzN50SQK1dxQb4eZ3QFbEmR6VIC9ubVN/nPq/GY6Mty6nJ1UiPxffGTSe0jlkZuZ861U8QnNBAJZmST1lZnfzujC0LlRW0fc+QfM04v1tvOGkYICks6RP6Hx3TnlEcNdjDvOOMnXDrFGfyJiqYsDfokBuAP2kfU/GBojmc5Ylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zaan8wra; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-595aa5b1fe0so1200903eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708811677; x=1709416477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNOM9oiyBitDobU/S8OlbO7Mx6TfDFV84HlF8D6VIPo=;
        b=Zaan8wraU21AAqBZ+JxPMNv3QIaBbxl4zkSOx8cZGbGIPrRUCqqFnoqrJeubzrpAIa
         EpGytqPRT38H6juzE741S6Or/3OHGAffRCOSulMOlSJF6shSmxHQn8qaVe4J8ycagK6T
         3vvkhi8lK7FTBlfSpwSOYFk8/apISGWMB7ae9bUNb0viTZdpEn9hFqSe+zDxnpJKd88k
         0u/pX+cYPcK2gFDLOJd5vQG98KDVoQTCXCFXqBX2nZduEpT5qiVvnx47zm2ktw2BCq2A
         ZvvQ2M/uhoUDSywzMqLtTyMl4EdEwKn9ULAzWmN/BQDfR661z92PSZd2MHfrjDsWhTAc
         /x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708811677; x=1709416477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNOM9oiyBitDobU/S8OlbO7Mx6TfDFV84HlF8D6VIPo=;
        b=SyunlriOgBlV7ZWl6ohziNsALlHGWpMhF513FNPRCmHep51ZNSld7AgLK/7KJuKIhk
         k32Sv08YpQeVPIBkCchdpLllste4vcc9JEVOMYvucILbqdpLuDPcBZDOs94qFOyYHqBG
         AQPsp2VZjip8C7FI5T7T2fVyUxSIlDpDiKTa0R/ZcG/+wmvmVafuNWafP5/vJpWoS4XT
         5dag3Ohe4swSNRLw4PFL3PQvPCuz7URrf9doHZYivoRPx8VmzmEaQD9qca+FIV0HCExs
         Eeg0zojB4C6FaU8FkDsoOKREt6Pu0KalTJGjgec0/04eS7IG7h3R1DCsZxwN7YNOKLpw
         fTmA==
X-Forwarded-Encrypted: i=1; AJvYcCUeT1EQac2DvepWTBX6y1aEDYMxNcquH81HB8aEfLvJ3bVH98Q689ZoNJjteekuJuvFRoL6/j2VvsXYNoHorB/my5aH9/CsjiqHq9cn
X-Gm-Message-State: AOJu0Yz7jgwJk/WoOaVQXNII7h6MhcpMwc+Y1HlflB160OMpzxbOixXU
	EwQq3Ibal1qsLgXhmbvono2S1f6CeDFdoNmxezToUIkqPS92pkfvRWVSCgKoOg0vgfe1vksjLci
	5goE3H9aJv65cjVjRMNGCzxF3vjo=
X-Google-Smtp-Source: AGHT+IG0sB1MzcqzE2cuAijnJKjDK/eWUOZNo7lYgzsErvz7w9e4P5P+H93n+t7i0y3btQP3MfNnA97f1gq2FTKQbbg=
X-Received: by 2002:a05:6808:1249:b0:3c1:8590:58e3 with SMTP id
 o9-20020a056808124900b003c1859058e3mr4035948oiv.57.1708811676021; Sat, 24 Feb
 2024 13:54:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4w5JF8zjsM=vEiArUpnvN9LjAdnUn98mEUJSAhg4Y9XjQ@mail.gmail.com>
 <20240224205453.47096-1-sj@kernel.org>
In-Reply-To: <20240224205453.47096-1-sj@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 25 Feb 2024 10:54:24 +1300
Message-ID: <CAGsJ_4x5JcpsdobM88ZnZA4B9nHBEdAfpNcdyqxa5fMDqEMrHQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than
 clearing young
To: SeongJae Park <sj@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>, akpm@linux-foundation.org, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	hannes@cmpxchg.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 9:54=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Sun, 25 Feb 2024 04:01:40 +0800 Barry Song <21cnbao@gmail.com> wrote:
>
> > On Sun, Feb 25, 2024 at 3:07=E2=80=AFAM SeongJae Park <sj@kernel.org> w=
rote:
> > >
> > > Hi Barry,
> > >
> > > On Sat, 24 Feb 2024 12:37:59 +0800 Barry Song <21cnbao@gmail.com> wro=
te:
> > >
> > > [...]
> > > >
> > > > BTW=EF=BC=8C
> > > > Hi SeongJae,
> > > > I am not quite sure if damon also needs this, so I have kept damon =
as is by
> > > > setting ignore_references =3D false.  MADV_PAGEOUT is an explicit h=
int users
> > > > don't want the memory to be reclaimed, I don't know if it is true f=
or damon as
> > > > well. If you have some comments, please chime in.
> > >
> > > Thank you for calling my name :)
> > >
> > > For DAMON's usecase, the document simply says the behavior would be s=
ame to
> > > MADV_PAGEOUT, so if we conclude to change MADV_PAGEOUT, I think same =
change
> > > should be made for DAMON's usecase, or update DAMON document.
> >
> > Hi SeongJae,
> >
> > I don't find similar clearing pte young in damon_pa_pageout(), so i
> > guess damon's
> > behaviour is actually different with MADV_PAGEOUT which has  pte-cleari=
ng. damon
> > is probably the best-effort but MADV_PAGEOUT isn't .
> >
> > static unsigned long damon_pa_pageout(struct damon_region *r, struct da=
mos *s)
> > {
> >         unsigned long addr, applied;
> >         LIST_HEAD(folio_list);
> >
> >         for (addr =3D r->ar.start; addr < r->ar.end; addr +=3D PAGE_SIZ=
E) {
> >                      struct folio *folio =3D damon_get_folio(PHYS_PFN(a=
ddr));
> >                      ....
> >
> >                      if (damos_pa_filter_out(s, folio))
> >                                 goto put_folio;
> >
> >                     folio_clear_referenced(folio);
> >                     folio_test_clear_young(folio);
> >                     if (!folio_isolate_lru(folio))
> >                          goto put_folio;
> >                     if (folio_test_unevictable(folio))
> >                           folio_putback_lru(folio);
> >                     else
> >                           list_add(&folio->lru, &folio_list);
> > put_folio:
> >                folio_put(folio);
> >          }
> >          applied =3D reclaim_pages(&folio_list);
> >          cond_resched();
> >          return applied * PAGE_SIZE;
> > }
> >
> > am i missing something?
>
> Thank you for checking this again.  You're right.
>
> Technically speaking, DAMON's usage of MADV_PAGEOUT is in vaddr.c.  paddr=
c is
> using not MADV_PAGEOUT but reclaim_pages().  Usage of reclaim_pages() fro=
m
> paddr is different from that of MADV_PAGEOUT since paddr doesn't clear PT=
E.  I
> was confused from the difference between vaddr and paddr.  I actually wan=
ted to
> document the difference but haven't had a time for that yet.  Thank you f=
or
> letting me remind this.

Hi SeongJae,

thanks! I bravely had a go at fixing the damon's doc[1]. as it seems
the fix is anyway needed
no matter if we have my patch to optimize MADV_PAGEOUT.

[1] https://lore.kernel.org/linux-mm/20240224215023.5271-1-21cnbao@gmail.co=
m/

>
> So, your change on MADV_PAGEOUT will make an effect to vaddr, and I think=
 it's
> ok.  Your change on reclaim_pages() could make an effect to paddr, depend=
ing on
> the additional parameter's value.  I now think it would better to make no
> effect here.  That is, let's keep the change for paddr.c in your patch as=
 is.

thanks! it seems everything is quite clear now.

>
>
> Thanks,
> SJ
>
> >
> > >
> > >
> > > Thanks,
> > > SJ
> > >
> >

Thanks
Barry

