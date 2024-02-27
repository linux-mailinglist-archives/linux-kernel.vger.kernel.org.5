Return-Path: <linux-kernel+bounces-83121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75698868EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8132832D5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E2A13959D;
	Tue, 27 Feb 2024 11:24:49 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC31386CF;
	Tue, 27 Feb 2024 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033088; cv=none; b=QMuZQSRotj2mZYYuaCIkNy2yNmJ7Xl5NBZKL5xCWauIS5ZmudQIcl5OriBCDX3c7zf236h+ZczXqpvjQStKirM1DqSfQUngstL0MWa0RO+/vpL5wJEM9YGQ//Z7M85992wvssMKWoLsgjfnGUZdD7hWxWVKURbHAw/eRwRzSF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033088; c=relaxed/simple;
	bh=GVuMBdQqkgWQcbGGoSTLXWpS7LUUBUPbnmMli3sXPcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aV2C0xjRbveuozXcpod4g5T02d/JsmLIwz9OzCFgBvnP4wACgS6iuz1rH8CgMYxHkP/f5ZL+M6iXkSGmxLrAQ/8HvBxayjvM0FXjy0dUsclWq/gglemice6ryThvVuYmgjRsfA7rP9O6qqoERfeyzLvXhN4AQ/IpAX8ibpZ4QF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60925d20af0so5881587b3.2;
        Tue, 27 Feb 2024 03:24:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709033085; x=1709637885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgPevVmoAKj0DGuT65JWL0siEdc3m+Qb/SY/mrF/WhA=;
        b=hKez+5s7KHdI2/CxbWsrwUTaS+n4g0OFJn3q1ns3oF5Q0FwssLGr9jNKfYoAolCOHc
         0uiLBpLOnHwDqYjYu1hJmBlptoMcn2fpcJ7SuvG42/MQ6D7iDu9zNA6xfiI8y0PlBbtd
         GhzH87+wHJnvp+p4fnO4cgKLXqFtRGpEYZ4XHyHL9kOv0PKad6SjrZQwvfrlaWMJc0jE
         5Y4Qqxga7rdVsHBXggHdBRYSjWJc3N7KddTJ9aUJqlja5YKWrraAxSGfoJTeW6fziwFj
         n15frq+wfqqWSUD5xQ0w6iJ46befR0Km3zeQm1K9n3JP8KuAgLFYo12udLznEFx06OtN
         cs2g==
X-Forwarded-Encrypted: i=1; AJvYcCUpkJmU1CSj3LzJDrtn7WSEFGDbx9x61rNDa3+V+oENjcHJucJaPGQ/rc+r2w8aJ31cRQNpf8bJLsG1t8lSr1t6DuY2QNcpxwZ/b0l3NwEyGqO7YtgaHh8oHdkPdAm/iHLc0XeCM6CBtjh1sZvAjRUMVW1JlCEDuJRY+ENiX5/gIarVrG3FWdpaDVhuKHaXuDxGTJh/Q7zzcf6TN10frU2MRmrc
X-Gm-Message-State: AOJu0Yzs/AT4QPTIG661fL1P0dYKaxIbQJKS8BFZs8DLDUdqD6EWhFE6
	776cQ2tbt5ZCBve1UZX2/pSlRJSBgGSmblvvgdSPK+8txE4rLhsOHXs+UGqzMNE=
X-Google-Smtp-Source: AGHT+IF6qZXhkh31/FL9NWIWiaWNbs75azxaLQr+q0HbfoJAOi5esIyA3/0S3GFWa2NY/xosW0awAg==
X-Received: by 2002:a81:af14:0:b0:608:d1f:1088 with SMTP id n20-20020a81af14000000b006080d1f1088mr1716762ywh.17.1709033085558;
        Tue, 27 Feb 2024 03:24:45 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id s132-20020a81778a000000b00607f86fa184sm1715590ywc.99.2024.02.27.03.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 03:24:45 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso3965991276.3;
        Tue, 27 Feb 2024 03:24:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVJ7xa8M3RUqQkjMQuIs6vqZOPftr7CjDdBfQisOSUZySBmc57Vd+/azmelXnVxPjs/+K3CFTOVzydfxwZkQO2iIfRXggH2eccDhhLw+Cby0XLQtuX3H9tfk3n78DhURjWFF7VGeE9YriB6AJsBDqnyGd/+TNKo/iKKtMzLCuujYG3hBkKa3qHQimKapbP6uz/prROSso9CPCS+Xt0+aFLL2y4
X-Received: by 2002:a25:ef41:0:b0:dc6:9c51:760f with SMTP id
 w1-20020a25ef41000000b00dc69c51760fmr1490502ybm.56.1709033085185; Tue, 27 Feb
 2024 03:24:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226104653.54877-1-lukas.bulwahn@gmail.com>
 <43df625f-bd32-4dd9-a960-6d0f5c0304c7@infradead.org> <CAMuHMdUD94XuE_7UK3TEWbeZ2eMOPimDi-xoo9+43FhY3O2aDA@mail.gmail.com>
 <CAKXUXMz66AzotSqzVHvXivdwhh0d34_GWqLu-hBgEq46AOOFSg@mail.gmail.com>
In-Reply-To: <CAKXUXMz66AzotSqzVHvXivdwhh0d34_GWqLu-hBgEq46AOOFSg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 12:24:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV_s=moOpSpdrOaMqxJXcV4af_7RL_2++ZPmHYZKF72oQ@mail.gmail.com>
Message-ID: <CAMuHMdV_s=moOpSpdrOaMqxJXcV4af_7RL_2++ZPmHYZKF72oQ@mail.gmail.com>
Subject: Re: [PATCH] docs: submit-checklist: structure by category
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukas,

On Tue, Feb 27, 2024 at 12:04=E2=80=AFPM Lukas Bulwahn <lukas.bulwahn@gmail=
com> wrote:
> On Tue, Feb 27, 2024 at 9:57=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Tue, Feb 27, 2024 at 1:41=E2=80=AFAM Randy Dunlap <rdunlap@infradead=
org> wrote:
> > > >   - Concerning checking with tools, checkpatch probably still makes=
 sense;
> > > >     it pointed out in several places. If sparse and checkstack are =
really
> > > >     the next two tools to point out, I am not so sure about.
> > >
> > > I doubt that ckeckstack is important since gcc & clang warn us about
> > > stack usage.
> >
> > True, but that would leave you without a tool to get figures when
> > there is no excess stack usage detected by the compiler.
>
> possibly, we can configure the compiler to report/warn on any stack
> usage from every invocation and then turn all those warnings into a
> readable format or some format that further visualization and analysis
> tools can process.

"possibly"

> If that works, we can remove the checkstack tool. It is not a
> massively large script, but it is certainly written with a very
> special purpose. I mean it basically does object-code
> reverse-engineering with a magic set of regular expressions in Perl.
> If our current compilers can emit the same information, we are
> probably better off just using the output from a compiler and
> postprocessing that.

I'm fully aware how it works.
And I have used Linux' checkstack.pl tool for non-Linux projects, too.

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

