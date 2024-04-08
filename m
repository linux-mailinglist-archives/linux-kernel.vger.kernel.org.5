Return-Path: <linux-kernel+bounces-135021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274EB89BA0B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7C81F21DE8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877A7383A1;
	Mon,  8 Apr 2024 08:20:07 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC0D381B1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564407; cv=none; b=PxgLTKKbF1gy+UOMcaSoqZVKEszWHCD6h/1/sn0OQO258QSdZDLM9ZrVGBYF4qf6ZSd8Frt+/v9I/32fyBK7tiMWRkdR3y09+b92+aDu4YLV0eZCVVSVso/ULpFdzo5k3QXVVcdgg7Mxce5SFCW3WXDfTh9ssvphfIYS6ROID18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564407; c=relaxed/simple;
	bh=FECalRfsPYMgUnHnR9uK33bW2Ie9uw1bxEOLdNNFhTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwteC9HUO/7sKxPhhlqZz34WlaFfmLSzdlku9xeoUsxTwyiPWKZ6STQbtpQ/VsSwG91Sm+px5icLrQ7/CvKN3yQcUTijLIC7/E9by/2PgnHaakpu+zwXQ7M8XpJTuqLLARHrusO966XtBFaByvzan6bLO1SEaqaz9VKRM/Lcb4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61428e80f0cso29134997b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712564403; x=1713169203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DVx4gd97DdgVJM34xzjKUIJDxKQktsSHSSvIhLo0M4=;
        b=NKMsOreGde3ws/ZU1HwT+xnFlh5EQtcfhKed398IcdT5RfAwVAcpeHGjAzoGD7NoRy
         Bl73DXK0j56X6gj8B2QSJLLh5/c8s5YyRQZ8yNPgYbeUt+TZt6yrbvgltU9gOZKHceGF
         bgH3w8L6Vd6DZ+7qY/cHuZut7l4axSl/bnOdPTuuvVOWBHRjLt4EMCfzjmgb2I0TXtBv
         LziMgf/iCJQJVSRsnhVg66lyVxKama+LbeERhvDK+XRwhGKQE403Z7sO7wswLPeuIdkf
         98krFVccjOcU1+osHb1u1lBdLNivO/4sSf7fc+5eXZnmk9KFgIt1BPalOQCDJWXAXLYu
         w1Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVoeDlwQaRHxdOXmGjHQJJD15r2m03HR3KMRPoHdBAMFo4Z8mAHJTKIcrUPf7UT4oj25zUtWX1vV2fj7zra9svazqiKsfYS7SKqbFym
X-Gm-Message-State: AOJu0YzFqUTtohYPiuiVcBzzDFxiFry8NYk/cfU6864+OjyePix1By6h
	aEjBy4KGFe/ZP6qWPI+tvVqsEKdA4oo9IQXrNGrVzH8b1DXsG1HAGU/vvXGKYVM=
X-Google-Smtp-Source: AGHT+IH4ciVYFwKpZIZhTMraDWptYB23K5ZzeWDfu2jn+KuN7jCr/6xQFOHGHfdzqQ9K/xfA5vj2Kg==
X-Received: by 2002:a81:6fd7:0:b0:617:c9b0:e12c with SMTP id k206-20020a816fd7000000b00617c9b0e12cmr5941311ywc.38.1712564403077;
        Mon, 08 Apr 2024 01:20:03 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id g68-20020a81a947000000b00617cf273030sm1523269ywh.82.2024.04.08.01.20.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 01:20:02 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so4291928276.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:20:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBwtO5b0woc01TPA6wO1c6284A/w1RO8GqqrXkHGaEqoxzTFiklUYt46QlPXtfN7StUVK7VTsVXCXx3pWrjcCkYl9rRmNja1dn76Eo
X-Received: by 2002:a25:9cc3:0:b0:dc7:43fe:e124 with SMTP id
 z3-20020a259cc3000000b00dc743fee124mr5474927ybo.11.1712564402349; Mon, 08 Apr
 2024 01:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403122851.38808-1-schnelle@linux.ibm.com>
 <dd55afa6-8cb6-4e25-b720-d2df62dbb5e6@gmail.com> <bf276f98-2712-4fcf-a119-f984a1aedbf2@app.fastmail.com>
 <CAMuHMdX+M1VuhDVnC9n4hCBDjHywwsByNK1w8ibazc+-8_C53A@mail.gmail.com> <d9bdfa48-572a-caa1-229b-44565690d9e6@gmail.com>
In-Reply-To: <d9bdfa48-572a-caa1-229b-44565690d9e6@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Apr 2024 10:19:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWVRSneRLU6OpXGKZMG5azXn_81eeS8vA8pvBvQPYnexQ@mail.gmail.com>
Message-ID: <CAMuHMdWVRSneRLU6OpXGKZMG5azXn_81eeS8vA8pvBvQPYnexQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] m68k: Handle HAS_IOPORT dependencies
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	linux-m68k@lists.linux-m68k.org, Heiko Carstens <hca@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 8:36=E2=80=AFPM Michael Schmitz <schmitzmic@gmail.co=
m> wrote:
> Am 05.04.2024 um 23:16 schrieb Geert Uytterhoeven:
> > On Wed, Apr 3, 2024 at 8:35=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> =
wrote:
> >> On Wed, Apr 3, 2024, at 20:11, Michael Schmitz wrote:
> >>> how do you propose we handle legacy drivers that do depend on
> >>> inb()/outb() functions (_not_ actual ISA I/O) on architectures that m=
ap
> >>> inb()/outb() to MMIO functions?
> >>>
> >>> (In my case, that's at least ne.c - Geert ought to have a better
> >>> overview what else does use inb()/outb() on m68k)
> >>
> >> If a machine provides an inb()/outb() set of operations that
> >> is actually used, it should set HAS_IOPORT.
> >>
> >> For the Q40, it may be better in the long run to change the
> >> drivers to just use MMIO directly though.
> >
> > Q40 uses ISA.
> >
> > Michael is worried about non-ISA drivers using inb() and friends.
> > At some point in time (i.e. eons ago), we were told it was better to
> > use in[bwl]()/read[bwl]() instead of directly dereferencing volatile
> > pointers...
> >
> > Anyway, I don't think we have many users of inb() and friends left, and
> > I assume the bots should have detected any/most remaining users in Nikl=
as'
> > branch...
>
> All the 8390 based ethernet drivers still use inb() and friends.
>
> That is the main reason for the terrible hacks in
> arch/m68k/include/asm/io_mm.h ...
>
> The last time I tried to add support for a different PCMCIA ethernet
> adapter to apne.c _without_ adding to the hacks in io_mm.h, I wasn't
> getting anywhere with the netdev crowd. That was ages ago, and I doubt
> their enthusiasm for a rewrite of the 8390 code base to avoid using
> inb() on MMIO architectures will be any better now.

As Arnd already discovered later in this thread, AMIGA_PCMCIA
(sort of) selects ISA, so APNE can be considered a "real" ISA. driver,
so it can keep on using inb() and friends.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

