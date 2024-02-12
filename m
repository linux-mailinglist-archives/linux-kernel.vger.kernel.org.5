Return-Path: <linux-kernel+bounces-61726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0258A8515B7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1394281339
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00103D0C1;
	Mon, 12 Feb 2024 13:44:03 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA53CF7E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745443; cv=none; b=nqrLKN6NQPJAiRdAIuOyZsBGFW/qtw/2rgrh4K0JSY5rrp8KXbm2rla07X4dNandPeZx3BOf24OtIFiDVbrfKI+ENBC4k/Sgd5ucuQ7Tlkvq8I+IKAcGGFfD55c8XgzQ46WWX8X50Tl2txUi4IkuD/Tbw+EGs3WAKXF/5uK+3Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745443; c=relaxed/simple;
	bh=Y+oWpdVP4KIxwkjcA9JOBMID67f3fKYDpMI6I5C8C5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pxadzeinc48Z/3TV672huL7iBKL8SBsXhomOVMgz0miA+rV+UVeN3hGpPbua16Vi4HFmyefiFU0jLYxbFeUEtBOj2/pPAm+U/kUS1EbLf+wqrq6hRTjE585OWMPVboBdUNPcqFE9jddOOI71OFsNe8J7UoYYnFAAkLBRjdrZyHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-607754a6298so2205057b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707745440; x=1708350240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nt0mP6yrOMcEPHaPnk/8W0ESIR1FuzksbltcgTisI8=;
        b=P0WjQDftkydkgw0eyhDYoW+FHlXkHrkre4Zh3rDpbSlBPhLgccNmy7tFpGT55TWPai
         HkusKhfw5oFHFRxGl8YuR+FlXjxoUq1kaRkNYPCtvFsALPHFgt+bUdBBRKZgFVHyTWzQ
         25hOMgqk/1DzIXgLva8rTkKbnb+hgoUkoAOpakF4AKuEcP1hgK/mrZf9C4dcfBWSPaHg
         dU1d6jtqLx+2LDPPcGjhi3/OyOrpviFqrZQ4MDyPy2R5mwSBNYtzQVRvj8yOzVJbQNdR
         p1d58MqPjHteYKWyhGx7fSp00VL9A4+svES9WwxHYVVNuJV7ptPYA8ygcdjlY5hYezRI
         uO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCViC1FYwOKJH6c4Ml3U4NTSfksCuZ8XaPoEiReMkEvFelZXlVfqOjtvkzdDZ20vs5gddL/ZHY//W3bYI2Jz+E0jqsL8sU/GRqDFrNJU
X-Gm-Message-State: AOJu0YzZV9uvQmitmeZJo57DyleNoq9oxyFyw83f96R7JzBHMsPkfR8I
	t8Hq5es6x1DVdlPx3HjOsKNfU8ZPtj8F+IE2EJnxgAIGuFUi3kcPj/2iFMMmuaE=
X-Google-Smtp-Source: AGHT+IEykx/auhWkYcgOzZ1Xr+Bv/5ESFwZRTVvVyXzslgHJ6QT7/T8SjeQy9bWEBl6NpqbGFLM0AQ==
X-Received: by 2002:a0d:d555:0:b0:5ff:481b:b7e2 with SMTP id x82-20020a0dd555000000b005ff481bb7e2mr4986580ywd.23.1707745439713;
        Mon, 12 Feb 2024 05:43:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmE69GKM7lEir3wWji63+wxyl9VO9pDLNYKmFsrgrRbqW2DadEEbF+slCqPqlEQ0QIeKRXXtGIPZKnQFz9LWni1pJjyqAsGRpdjzP2
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id z19-20020a81a253000000b00604d60609d9sm1146330ywg.121.2024.02.12.05.43.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:43:59 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc755832968so2342818276.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:43:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZGBXMc/xNI+Kysb/iD3XIq6iN6enroMf+27lb74MyYUMCGE/Ug8wJHPgea1QfvTM5oBJrQcrZwPpoYExRezzGL3h70d4U7DTuiMzO
X-Received: by 2002:a05:6902:1b93:b0:dc6:9c51:760f with SMTP id
 ei19-20020a0569021b9300b00dc69c51760fmr5835849ybb.56.1707745439274; Mon, 12
 Feb 2024 05:43:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com> <ZcoezKt4zKvO8jOf@smile.fi.intel.com>
In-Reply-To: <ZcoezKt4zKvO8jOf@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 14:43:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVeSMavAdZxCxh7wFLcXQu-wE_vvDvpA1WV-R3mrZ2-DQ@mail.gmail.com>
Message-ID: <CAMuHMdVeSMavAdZxCxh7wFLcXQu-wE_vvDvpA1WV-R3mrZ2-DQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 2:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Feb 12, 2024 at 03:23:53PM +0200, Andy Shevchenko wrote:
> > I have no time for this, but since it looks like I'm the main
> > contributor for the last few years to the subsystem, I'll take
> > it for now. Geert agreed to help me with as a designated reviwer.
>
> The typo ("reviewer") has been fixed locally.

Please drop the "with" before "as", too.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

