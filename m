Return-Path: <linux-kernel+bounces-132810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7DA899A86
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D915C1C21EDE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884F7161B43;
	Fri,  5 Apr 2024 10:16:34 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE87216190D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312194; cv=none; b=QccQr/5f9X1VDyzNV0hcTVQlHLEPEJcHZSrQWgKJ7WYRfNJeddjxZOsPNmgi3WD0fNDCLb4OVWjGjxG0p20CQn88Lk+HrrMlIFcdZbADMS4VRpG48GSsJr/Z2kgrXP4t4iOz6FgITkg586uVCyHBQOrGUqcBGzke30ZJJnrwh9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312194; c=relaxed/simple;
	bh=JcY82/C76s0/t6n/adQHbGR8IvfyPU6uK0CJHQnDc3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9Jf+x7+hNK89jYiQaXkePPGIDLMx0PqXnLspmkqYKd0mVB1mUAlnXyZ3yLKgHJlZy2+fGSlkAYP0LFGfk6U0lVeFvzOk2ZuUPj/XbafhJIRtxa12rnNDhOT7RA29Uw2j3QLFmLImma0u4qji5eq2pxurt3mSGy2WTFeJfU8AJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6114c9b4d83so18467467b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 03:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712312190; x=1712916990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+r8oBMZYIdH7mEh+EvZMzslbveSo86ivNfgm6OLNsA=;
        b=g1F1FFxcNIfU7YL1e2K4eTEzYHsxrafN/Qr8Jl5eNAGwQVvBKgRpeWT5wLvkRAOqWT
         Aa2uwFOxX/zSQUm6QJ6bSyPF4W7XateRAkTTCO1bREDBBifcbOUTdDf1QwetmC6qpntv
         pa6nsTsaBU1FL4EqwboO6VbJGe1TfDoleVFE2PNo5LiLT0+iOgYbKI0+3k3X3S3iJRFl
         3memw20vGSA9bdZlvyej/D4T3veYGhMUuACERcbXm/9Ppg5sYgnaa2aNjh++UxSRXStW
         oRXhoAPwGWOGERQVEy/0Nm/nII2pNCKV29f8kUhBgisER7H9Y/U0DQnAerLVzARNAxdO
         uNCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBetTs83iWfRGLp5k6s1T+9kzTw1GPO6QE9XRiW/Yez1fpGSQyFMhW0Ll0arwTKXGQkymifJcHUXEKRXcVBaI20Oy4fQUEMxS9RPeX
X-Gm-Message-State: AOJu0YxrfPdKhpxySqMk+hA8d6FfgF9NJ+kTVSBv4YEHfVvhjGbianoy
	ftUmRere9tBoKfSDdww/HEcsNk2qyjDvn/WflVnXitIO0VibF9PJcnCVwlHk0I4=
X-Google-Smtp-Source: AGHT+IHLKLRFBGgA5sKPcOq9yGSNzXyEuZyJ0kereCLSJ0Mxa6tQq74W332JJ2kghwFmNZ+YSv70kA==
X-Received: by 2002:a25:3083:0:b0:dcb:e432:cb06 with SMTP id w125-20020a253083000000b00dcbe432cb06mr786002ybw.29.1712312190344;
        Fri, 05 Apr 2024 03:16:30 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id l12-20020a25bccc000000b00dccdf447047sm235805ybm.65.2024.04.05.03.16.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 03:16:29 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-617d4797d9bso2551787b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 03:16:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOV/zEjkqCb5zT6q3HpEOnJ7cpDAvtj1i/B/8SHgXIMB83Pp4wNz+GfBlgY+7jARfxg16bnJdw2g7WK0rl6RYK1zoqkapbYfMKVpHG
X-Received: by 2002:a5b:2c2:0:b0:dd9:20d6:fd2 with SMTP id h2-20020a5b02c2000000b00dd920d60fd2mr741410ybp.27.1712312189491;
 Fri, 05 Apr 2024 03:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403122851.38808-1-schnelle@linux.ibm.com>
 <dd55afa6-8cb6-4e25-b720-d2df62dbb5e6@gmail.com> <bf276f98-2712-4fcf-a119-f984a1aedbf2@app.fastmail.com>
In-Reply-To: <bf276f98-2712-4fcf-a119-f984a1aedbf2@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Apr 2024 12:16:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX+M1VuhDVnC9n4hCBDjHywwsByNK1w8ibazc+-8_C53A@mail.gmail.com>
Message-ID: <CAMuHMdX+M1VuhDVnC9n4hCBDjHywwsByNK1w8ibazc+-8_C53A@mail.gmail.com>
Subject: Re: [PATCH 0/1] m68k: Handle HAS_IOPORT dependencies
To: Arnd Bergmann <arnd@kernel.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	linux-m68k@lists.linux-m68k.org, Heiko Carstens <hca@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, Apr 3, 2024 at 8:35=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
> On Wed, Apr 3, 2024, at 20:11, Michael Schmitz wrote:
> > how do you propose we handle legacy drivers that do depend on
> > inb()/outb() functions (_not_ actual ISA I/O) on architectures that map
> > inb()/outb() to MMIO functions?
> >
> > (In my case, that's at least ne.c - Geert ought to have a better
> > overview what else does use inb()/outb() on m68k)
>
> If a machine provides an inb()/outb() set of operations that
> is actually used, it should set HAS_IOPORT.
>
> For the Q40, it may be better in the long run to change the
> drivers to just use MMIO directly though.

Q40 uses ISA.

Michael is worried about non-ISA drivers using inb() and friends.
At some point in time (i.e. eons ago), we were told it was better to
use in[bwl]()/read[bwl]() instead of directly dereferencing volatile
pointers...

Anyway, I don't think we have many users of inb() and friends left, and
I assume the bots should have detected any/most remaining users in Niklas'
branch...

arch/m68k/include/asm/floppy.h on Sun-3x might be the only offender?

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

