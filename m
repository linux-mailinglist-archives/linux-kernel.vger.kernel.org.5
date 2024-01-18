Return-Path: <linux-kernel+bounces-30481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D70B831F33
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BAF21F235D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A242E2E3F5;
	Thu, 18 Jan 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px9IcXXj"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62E32E3E8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603347; cv=none; b=JvXCcDY4+iA66B67wKmwAJekDvhg6pSwliB+f35ZpTWzXvQt+kCTPqi/alppszXZO6nP0gJukudB0MPhM3O1oYAdnZ3xJ3rhm8BKgBeTfl/I5TTUOqX7d4ziT9s29QyQbpo+KBabv8AAUW7Q6bWx8btfkZo4AKT7EoH52aFlVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603347; c=relaxed/simple;
	bh=s8QsDhFRsh8DglOmLSND+a6y1fAQnER+SPuaqhSLtGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4jh+cvO8iIvyNUjoP6aTsQ70fD4bPdj/oIkqZdmgYgLcMFawPejD1MlNOT0k3Epy2EgL6sTeHpJzXlMi7kkbs/1SBq7uvWtETH6buW79u36GJgOruoJ3RrSEoOGuHEzttmW7M/qVLBXYNcANPntdR2ET4Xtt5yNPe4lkAj/q5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px9IcXXj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d70696b6faso8537555ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705603345; x=1706208145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhZ/dFhXJNNurB9wu0lnJIATao3bMZW6Ig6WKQMp+aU=;
        b=Px9IcXXjnKq+8fo9N3s3nUQHar1Punj9wFq96R+/h8d5g1kpxSk1WCPWnuQPNxP8Il
         XQtkVdgIcLl3fATyc9y38B1GBzVX09QPkGyr+QvqZ7QqmOF3tuhCY5hYvLGEqwkXIstM
         awgJIgpLYwahafn9lPoCNZxTxHyVtWOLQSSLNPJ1uUx7jxNn84KoTUOPBokfEdJ6Lva4
         9jqKO+k9uGium9NlO6XzKvG6jXyBPLj06n10qRe9IuvUYyU9ayvSCzYsfChOSI2CHIOA
         IGuFR8F5ALiLJyrqra5llsBBznofp6Cxv7Z5KwKKjEOWwApYWVA81bO/r20W2cyrVgLN
         2W7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705603345; x=1706208145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhZ/dFhXJNNurB9wu0lnJIATao3bMZW6Ig6WKQMp+aU=;
        b=E7kHS7YxW0hR0z2XPtv3pCLubtdVKcp5g+y10b7rvNadxVNHQX/kqSUHQtj4GqYUpm
         CGeeJgrd+rRXIr8eCjohUP7hHw8bJJkIdfK437ERxZxsBxedKDwkpVnXtd/x4UWktMZh
         DkjnVKVfP1r48tH4OJuNzFkB3RquxmKKOKgCqebvOrjLZwQgq1QSqWtF9CP1kKvlOdyb
         cJwMb02EL4sb6Cv/1IcyesKi131uGmRCxFd0DHjwoQ/sblXBJRV9QozGOCj2TLmLeiAr
         rj7fRTeVa4XATId4BO3ShC4lODPDD92XcOeO7HE1IDUySNSv6Kw8+Ca6sZS05rKfMi5Z
         ObuQ==
X-Gm-Message-State: AOJu0YxTWdqLjPG05HXwlgNylxknn2n67aIbF66HONWnrOVObRZEPvan
	yrljXitdvsEyIVz0yzzt+PLFkRAsnRAL1/Tl0pinFIilC1HAvYHhscOhipCtcnYuKUhDLgiTIJJ
	5DQ9AF7xUXkgECTA0HD1hX2OwvWo=
X-Google-Smtp-Source: AGHT+IFTXjkgH8H3vsPwHkEwD+kQenVF4YhtyJ08Gx7zvlaUrYIgZXcv2KFOL9EX7kfrC6jFYmlwVAav8q9ry4WKJUk=
X-Received: by 2002:a17:90a:744c:b0:28c:cec8:cfe0 with SMTP id
 o12-20020a17090a744c00b0028ccec8cfe0mr1164567pjk.94.1705603345045; Thu, 18
 Jan 2024 10:42:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org> <CAHbLzkoL6sCDciHqVMJga288853CHdOTa5thOPQ9SHKSqjGGPQ@mail.gmail.com>
 <7103dfea-0db3-44b7-9b2e-e89d4edd19d7@kernel.org> <CAJuCfpFKLfMM16VbzdaEHaMELgB2pAo6_t1OKsRO80BL2iAzsg@mail.gmail.com>
In-Reply-To: <CAJuCfpFKLfMM16VbzdaEHaMELgB2pAo6_t1OKsRO80BL2iAzsg@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 18 Jan 2024 10:42:12 -0800
Message-ID: <CAHbLzkq_ZSoA-DT=qtENMNpU1cgVacXsyWDjLxGFHzsn7bFXNg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Suren Baghdasaryan <surenb@google.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 9:48=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jan 17, 2024 at 11:05=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org=
> wrote:
> >
> > On 18. 01. 24, 1:07, Yang Shi wrote:
> > >> This works around the problem, of course (but is a band-aid, not a f=
ix):
> > >>
> > >> --- a/mm/mmap.c
> > >> +++ b/mm/mmap.c
> > >> @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsigned =
long
> > >> addr, unsigned long len,
> > >>                    */
> > >>                   pgoff =3D 0;
> > >>                   get_area =3D shmem_get_unmapped_area;
> > >> -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > >> +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > >> !in_32bit_syscall()) {
> > >>                   /* Ensures that larger anonymous mappings are THP
> > >> aligned. */
> > >>                   get_area =3D thp_get_unmapped_area;
> > >>           }
> > >>
> > >>
> > >> thp_get_unmapped_area() does not take care of the legacy stuff...
> > >
> > > Could you please help test the below patch? It is compiled, but I
> > > don't have 32 bit userspace or machine to test it.
> >
> > Yeah, for x86_64, it's semantically the same as the above, so this work=
s
> > too:
> >
> > Tested-by: Jiri Slaby <jirislaby@kernel.org>
>
> With the addition of  #include <linux/compat.h> it builds and passes
> our tests as well. Thanks!
>
> Tested-by: Suren Baghdasaryan <surenb@google.com>

Thanks for checking the test case and testing the patch. I will fix it
and post the formal patch.

>
> >
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -811,6 +811,9 @@ static unsigned long
> > > __thp_get_unmapped_area(struct file *filp,
> > >          loff_t off_align =3D round_up(off, size);
> > >          unsigned long len_pad, ret;
> > >
> > > +       if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> > > +               return 0;
> > > +
> > >          if (off_end <=3D off_align || (off_end - off_align) < size)
> > >                  return 0;
> >
> > thanks,
> > --
> > js
> > suse labs
> >
> >

