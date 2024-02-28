Return-Path: <linux-kernel+bounces-85605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC4A86B835
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EFD1F247B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61239151CC5;
	Wed, 28 Feb 2024 19:33:36 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2287443F;
	Wed, 28 Feb 2024 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148816; cv=none; b=FhBf965dlHugGj1K4TYL4SZC4jBYpSXzFIosgoc2guUrYDMu//A02QE/poELNUdWD83q/nwKgWvNxmwdgbbytFJqDcc65ZnphmScS/zJa5q4eQFg7n+k4BxEhugzCtbtaUlFJwZw5eeuk4Iujuaa9uB45+KOmwewoQcWf0HbrpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148816; c=relaxed/simple;
	bh=hOjFWoZbxrFdA+rwwfrBms8eKIvJB1aS6GPidS1vNv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjYimGUXBUjR1gLtARbGVkQV7aO6xQjB5nmP0fZ4HkSMg0izEOJ5EEmfJ2jM1VD74xB00/v0JJuJoeEnFtco+7RvPhsF2yqYhPEZ6LhEveWurMPFnicZCru97K4L6X8wzupbQsb8XvLwpDr/n7voZRdzCQVM+bpegCSrrkaMiTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60821136c5aso989397b3.1;
        Wed, 28 Feb 2024 11:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709148812; x=1709753612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OApY0QCLUmTQsqBh2p8x8Zl1dC3sTRcZPzaJjGxX2jY=;
        b=gDfYT54KCnFpQ8uJVSIbaAS+CMJxc+pC/mR06/SdBfy/yRF2zJVwgeya8gVGYNcpH6
         lDtcX5jZI/5JjiUeNGWgntOMNMjQilvj/SbEFhq0R3ylw0V7z6TXOvPPFvcRNwaTGNrh
         fJY6a2Fct+1v6qm05502RiMSZFyTe45hqDhttl+9iV8JmEFTxJbujkVujxm3DHnw4BMK
         rkmftrZ9LB9cJTYGH8FQ/Us+bDT3ezlvN26v3wukFiptjmQwoh9QYyo7GU7LFSzyQbFT
         Wqt5AYqiLyQ5ulFWcZ0T24L4ioaKU+80eUYhziEsYKkiKj3DC6CzK9dYonRJ6pTuys1A
         LHLA==
X-Forwarded-Encrypted: i=1; AJvYcCXO3MpmgHFIbyIaekIT53qPMtOB1zYbsvBOls29qdM8KCSTe+4SXmAt54EbD5wR2mPhJiCu/lS9IFIeDE4O7dEe+U+icD9uCYAmtHbIMYztw93YB05BxsiFpcxqr/r7pgRzQf5Yl+Ru7A==
X-Gm-Message-State: AOJu0Yy6Dgqp3HVNAjCpVSNeb8TN/zKcKOXbBrsH/z5ZqcgfpAPxU4YI
	dOksnAboS/pI3pnTDMEW2m8Y/vpcjt8tNYWD10HWW1lw9lL2corTh1lkuxci/B4=
X-Google-Smtp-Source: AGHT+IEb8IgLPaLvVoTJIFTy7tKAEuQZpEPDUlNU0co2Orj2Kb0iqWaprZfw67A7DHAjgks76l0sJg==
X-Received: by 2002:a81:4983:0:b0:607:8196:9d69 with SMTP id w125-20020a814983000000b0060781969d69mr26116ywa.30.1709148812293;
        Wed, 28 Feb 2024 11:33:32 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id q13-20020a81e30d000000b00607bfa1913csm15375ywl.114.2024.02.28.11.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 11:33:31 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60915328139so1796567b3.0;
        Wed, 28 Feb 2024 11:33:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDiaptTF2fVnl82xP4QDYcJ8zlaZP7iWfGRoSnSi2vMVosJKpYZMdsEXQlxI8VUMXsFdmaImoL+LGWPZE6EGvt40hW7onEBWP5UsYKmlgRKmRINCmTUwZU21Wcmuy3/ODtP/EwGqf6Vg==
X-Received: by 2002:a05:6902:569:b0:dc7:3165:2db1 with SMTP id
 a9-20020a056902056900b00dc731652db1mr157063ybt.49.1709148811491; Wed, 28 Feb
 2024 11:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709127473.git.geert+renesas@glider.be> <8583d54f1687c801c6cda8edddf2cf0344c6e883.1709127473.git.geert+renesas@glider.be>
 <Zd9vx2pM3Ds9-dzk@smile.fi.intel.com>
In-Reply-To: <Zd9vx2pM3Ds9-dzk@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Feb 2024 20:33:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVL0_8At_V7yRecZ5wk4RytaDXpRm2rNr+T+QMCU80tzw@mail.gmail.com>
Message-ID: <CAMuHMdVL0_8At_V7yRecZ5wk4RytaDXpRm2rNr+T+QMCU80tzw@mail.gmail.com>
Subject: Re: [PATCH 2/4] dev_printk: Add and use dev_no_printk()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Chris Down <chris@chrisdown.name>, Petr Mladek <pmladek@suse.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jessica Yu <jeyu@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jason Baron <jbaron@akamai.com>, 
	Jim Cromie <jim.cromie@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Wed, Feb 28, 2024 at 6:39=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Feb 28, 2024 at 03:00:03PM +0100, Geert Uytterhoeven wrote:
> > When printk-indexing is enabled, each dev_printk() invocation emits a
> > pi_entry structure.  This is even true when the dev_printk() is
> > protected by an always-false check, as is typically the case for debug
> > messages: while the actual code to print the message is optimized out b=
y
> > the compiler, the pi_entry structure is still emitted.
> >
> > Avoid emitting pi_entry structures for unavailable dev_printk() kernel
> > messages by:
> >   1. Introducing a dev_no_printk() helper, mimicked after the existing
> >      no_printk() helper, which calls _dev_printk() instead of
> >      dev_printk(),
> >   2. Replacing all "if (0) dev_printk(...)" constructs by calls to the
> >      new helper.
> >
> > This reduces the size of an arm64 defconfig kernel with
> > CONFIG_PRINTK_INDEX=3Dy by 957 KiB.
>
> ...
>
> > +/*
> > + * Dummy dev_printk for disabled debugging statements to use whilst ma=
intaining
>
> dev_printk()

I fully agree.  But the surrounding comments don't, so I gave in.

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

