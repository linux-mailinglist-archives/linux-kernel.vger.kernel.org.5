Return-Path: <linux-kernel+bounces-118442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DB988BAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE7B1F3AAA1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0208D12AAE6;
	Tue, 26 Mar 2024 07:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayIkQGOj"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C414684D12
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436568; cv=none; b=OU6zcNnyfxDIV3VUwz3qIiwALLLgp1dBK9J2/ylMsO4e9Vi5D+M+N7vtw+tiBgpRSzasggS8WEe2bFT1YqssGLxLyjO9grE4lClZocb1pqLlOw/Z8rvBMjG8vfdvGNY7YCJqmM5rUpzibYGqIqeX2aeLTMH2r8rmnR90pK0FQhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436568; c=relaxed/simple;
	bh=PbxCm4ELEs/7jZ383cwY3r/Xo7GQmh+oLfIGvFZZADU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqSkzxsDNRfQ79sTCf5yoET6TaadgZbMVmE6LZVYrZPhtV1jvRUktaryCW//i30kg2LYhCHmsomQMaE99nzhk1FrKkZ/ECG33WDpvATfdxAa7qRNiRAaY0ndFOiSHZ89xE3z2BSzwEQYyroUgGFhZ2ijMRZsADGj/A7NBPBpAj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayIkQGOj; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d68651e253so83771841fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711436565; x=1712041365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTpLeZzLBLjhaQjk1ZXR4863sHmtNUHQuEr5jyyXuSQ=;
        b=ayIkQGOjIgf4a8+mMM/eNLxjrwyewb83J54v2lYGeRmULkrev4k+5sa2/qt270PNc+
         O3O0oVU/bWTS2bxHOXkmOVr3514mFEIGcZegnYutDbMJmDYg3e/vmtqTRHkw07V0cpW1
         1x7HiHUQlJZ3KOjxUW4V48fuW4gzoqiKVSJWSdonGNlBun847RHqH3maDSPwarJ484ec
         fkC+5aTkZF+8SQuEQvSzQmX5n5EX8IXIQnTFxdvh/F8A+BowpR+4UbswhGPZKS6aLlHA
         ScrkyFXkDxNQSoGu1eJ08/xTBzeMpNGt/uG5IrKCljeYK4u9WUqrwNbZO7F7/Zs+jdUR
         ES6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711436565; x=1712041365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTpLeZzLBLjhaQjk1ZXR4863sHmtNUHQuEr5jyyXuSQ=;
        b=RG1Pa9vViYd6fQzIBjsduoYaKDMHcp8jOMnvul1dlJQjBqoKso5+Mp07TEqiNLNLn3
         aWUnLZDkfaC36MqwVb7Uxy9KL17/nZVRQxkOVSrra/Vd9x5/qg8apHfLJIyEVXiWvdD+
         KLiU1z9ccau2aSsiIu0n5ZrVOisYDd0BzLFyXcyG7h3467+m5C9atVDC/8l5g19GLWzf
         FHCIbV4GEkJ2HKaya6UDUJcdygxUbjWSVbnIkZrauGEr0Sc8x3w3rJ7IfikKv4LEHYzn
         dBTF4VHb0uDZvWchy9r64Hca4jYKCqvhNZgdMnEHM9UeAo4BvL2fZUWfgZQG8ySt1sBZ
         3Nhg==
X-Forwarded-Encrypted: i=1; AJvYcCVT1uJ4wJKzy4ZMrNcfcx5NWt6MAhPkcBmkikFOIKDO8bbR4f5r9Fk3ozq2ijmR2eyQx3RyJrQ/7A9h5RCTsiFe4VAK8abT39kgjD1n
X-Gm-Message-State: AOJu0YwfEHf0MpECOlmCG43o4c6WxrRaOfPTh7sgP8ZldN4cuhCBBerc
	ukgLBvtgswXWhEkHeIQhSqtsSmWOq8tvFG8SCoCNEUJtlPw8sCjTJBuk088n5o7mA26lCcHpWxT
	H4o+aS9reYOTkV5EiS3EZway1Z7Q=
X-Google-Smtp-Source: AGHT+IFmIkv2ub5eoOlmFV6tU5T8Va8czYm2ryesHh6CHXuNquBls68KmHlpCdLp0znZUC0voLEGGynfGxDGJFM9260=
X-Received: by 2002:a2e:989a:0:b0:2d2:3fac:5fc7 with SMTP id
 b26-20020a2e989a000000b002d23fac5fc7mr4910030ljj.45.1711436564723; Tue, 26
 Mar 2024 00:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com> <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
 <CAMzpN2gOZEddWUgncaLutVDihcEK-oEUdSVxsgaaX9xiMWfqPw@mail.gmail.com>
 <CAHk-=wi0arqxMFFdM+jGv1YXXhY+ehxsmcfv+iAndD_dmpYjMA@mail.gmail.com>
 <CAHk-=wg0cMa6B6OeTtXjx4R-kqxWVHSJ=6y=stRuzk8WduJTsQ@mail.gmail.com>
 <ef640185-21e2-46a8-839c-d81030fb13f8@app.fastmail.com> <871q7yxrgv.wl-tiwai@suse.de>
 <3e9d1217-edeb-4dee-ad88-971795856776@app.fastmail.com>
In-Reply-To: <3e9d1217-edeb-4dee-ad88-971795856776@app.fastmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 26 Mar 2024 08:02:33 +0100
Message-ID: <CAFULd4biN8FPRtU54Q0QywfBFvvWV-s1M3kWF9YOmozyAX9+ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
To: Arnd Bergmann <arnd@arndb.de>
Cc: Takashi Iwai <tiwai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, mwilck@suse.com, Vlastimil Babka <vbabka@suse.cz>, denis.kirjanov@suse.com, 
	nmorey@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 7:08=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Mar 25, 2024, at 16:26, Takashi Iwai wrote:
> > On Mon, 25 Mar 2024 15:51:30 +0100, Arnd Bergmann wrote:
> >
> >> Not sure if they plan to update the kernel release beyond that,
> >> or how inconvenient it would be for them to require
> >> using the other compiler for future updates, so I've added
> >> the developers that last touched the OpenSUSE kernel RPM
> >> package to Cc here.
> >
> > SLE15-SP6 kernel (based on 6.4.x) is still built with gcc7, currently
> > gcc 7.5, indeed.  openSUSE Leap shares the very same kernel, so it's
> > with gcc 7.5, too.  Even though gcc-13 is provided as additional
> > compiler package, it's not used for the kernel package build.
>
> Ok, so for SP6 there won't be a problem because it won't
> update the kernel.
>
> > AFAIK, it's not decided yet about SP7 kernel.  But since we take a
> > conservative approach for SLE, I guess SLE15-SP7 will be likely
> > sticking with the old gcc, unless forced to change by some reason.
>
> From https://www.suse.com/support/kb/doc/?id=3D000019587, it
> looks like kernel versions are historically only updated for
> even numbered updates (SP2, SP4, SP6), so I guess there is a
> good chance that SP7 won't upgrade either, even if that decision
> is still to be made.
>
> I would assume that if SP7 does get a new kernel, it would
> not be any later than the next LTS kernel (6.12 according
> to phb-crystal-ball), and we could just decide to move to
> gcc-8 only after that is out.

I think that upgrading the compiler to 8.1 after 6.12 LTS is a good plan.

Following that plan also means that the original stack protector
improvement series that includes objtool changes is the way to go
forward. The stack protector specific part can be removed from objtool
after the compiler is upgraded.

Thanks,
Uros.

