Return-Path: <linux-kernel+bounces-159086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B134E8B291F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D582E1C21716
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471FC152531;
	Thu, 25 Apr 2024 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMgrpv+K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820B938FB6;
	Thu, 25 Apr 2024 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714074337; cv=none; b=bKWN30dCuT8XCu9IZadgJEx39TUxsmsUwK03YryMVppvqBmmp/0AmPEI3jWSoq5X4Xg9bRiqUF34CR5lA20OMLQ+ZfMCL5HyzNIh6u+FDdP9IcOivxES4QYF1lYo6vSwY1A7T0Ti14k9DvEHe5z91zPGxvtPEUhQwiX+wFbK8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714074337; c=relaxed/simple;
	bh=ii5cdCmylSrCYuAbjnq23PCiMMHhvORNNb2ZdSUJH64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIEm3wofRcsKj5hxDuB/A1nlF5K5zU/xdwzx5E/qWCn5fKgFoXhXfveiANFAwIWi1Zgw6ZGA15FfyAXlcgxoXXXdVIf8AoeCHIwkV+OOOlrHuRaTcZsU0q8Q1lurAO+x5sVnrr1Aquc5GXO4myr4mwhgBk0IyFC78T9+E4TqIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMgrpv+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553C0C113CC;
	Thu, 25 Apr 2024 19:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714074337;
	bh=ii5cdCmylSrCYuAbjnq23PCiMMHhvORNNb2ZdSUJH64=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DMgrpv+Kf3nsvrblhKu8VsgYRAyRPmTW64jjD5rLF2diiiIzhJssj1a9nB5c8D0hw
	 DOIsOdirt2STnNGPU+fjAupf7X3Q8LTjgs1NxHPC43clhNkyf3XayU8QVYJL3e1rX6
	 u+Z4MG/NV1sg4WTNXSAyvBwLWRKcpbjy+a14qupyddby6jO0z5GGmRlt5nJGE8OgbN
	 ZfxpkHOvXO2+NsFULVEM4+gigs4OAlTyHLG3cA/9+FIVa2YF0FY1SDxLI0bUmIUOHr
	 HnFmisAnqwrxGiQHvtS8rFJmQspNEsmr1z9csfNojq0PG7v4DOHeclaMX+45mVOteZ
	 RFYOJJJMfsFzA==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6eba841d83cso303993a34.2;
        Thu, 25 Apr 2024 12:45:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWankNtAt05l6L3ldIumLgzgvUDTMzcFDPQHYrimyRbKLqBLVYdJBe4EpX9mU3dgBs4zeVsGQeypNEhCtd4fhIRMkAI3yXKUMRpjtoaKC76DWWYNAkYBuB+F4CEb5XXuiroQ3RiqF0ivqzfXH+gld5r/vRDoFEv69zLkfnwSgvjUItk
X-Gm-Message-State: AOJu0Ywat8tr+F9atp0ZyR8emR1SNo0b7kjHzJ/FZUsJlUibdRkMojn4
	rfskSN1ya21qzEK0fnHTCol+kKkJ44nl/1lRD95kgfmHslEKwcBvAr9vUJmOLgHvXOlOIZ/wa85
	sYw1tOTl5HnciVORhIxB75ajYVrM=
X-Google-Smtp-Source: AGHT+IFxIDxbGkjQJjrh2p4HmiS3BMkC2fEIM3VrbMZA6XO7VFQQpL3NyCDuzrN3UZFVr6EJs2EN84BZ/GiY2Gx3Nb8=
X-Received: by 2002:a4a:ba07:0:b0:5aa:14ff:4128 with SMTP id
 b7-20020a4aba07000000b005aa14ff4128mr816756oop.1.1714074336594; Thu, 25 Apr
 2024 12:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
 <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com> <CAHk-=wj52PUZ0xtoLs79B9uar6h7FVaKC0gbD-a_wZxDjH2ViQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj52PUZ0xtoLs79B9uar6h7FVaKC0gbD-a_wZxDjH2ViQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Apr 2024 21:45:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j7Do94XvUQrLgA_mFFyxdeb2RO08JwUzL0_QErOOrrAQ@mail.gmail.com>
Message-ID: <CAJZ5v0j7Do94XvUQrLgA_mFFyxdeb2RO08JwUzL0_QErOOrrAQ@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v6.9-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jarred White <jarredwhite@linux.microsoft.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 9:18=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 25 Apr 2024 at 11:58, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And maybe this time, it's not a buggy mess?
>
> Actually, even with MASK_VAL() fixed, I think it's *STILL* a buggy mess.
>
> Why? Beuse the *uses* of MASK_VAL() seem entirely bogus.
>
> In particular, we have this in cpc_write():
>
>         if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
>                 val =3D MASK_VAL(reg, val);
>
>         switch (size) {
>         case 8:
>                 writeb_relaxed(val, vaddr);
>                 break;
>         case 16:
>                 writew_relaxed(val, vaddr);
>                 break;
>         ...
>
> and I strongly suspect that it needs to update the 'vaddr' too. Something=
 like
>
>         if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>                 val =3D MASK_VAL(reg, val);
>   #ifdef __LITTLE_ENDIAN
>                 vaddr +=3D reg->bit_offset >> 3;
>                 if (reg->bit_offset & 7)
>                         return -EFAULT;
>   #else
>                 /* Fixme if we ever care */
>                 if (reg->bit_offset)
>                         return -EFAULT;
>   #endif
>         }
>
> *might* be changing this in the right direction, but it's unclear and
> I neither know that CPC rules, nor did I think _that_ much about it.

This is a very nice catch, thank you!

> Anyway, the take-away should be that all this code is entirely broken
> and somebody didn't think enough about it.
>
> It's possible that that whole cpc_write() ACPI_ADR_SPACE_SYSTEM_MEMORY
> case should be done as a 64-bit "read-mask-write" sequence.
>
> Possibly with "reg->bit_offset =3D=3D 0" and the 8/16/32/64-bit cases as =
a
> special case for "just do the write".
>
> Or, maybe writes with a non-zero bit offset shouldn't be allowed at
> all, and there are CPC rules that aren't checked. I don't know. I only
> know that the current code is seriously broken.

In any case, this needs to be taken care of (Jared?).

Thanks,
Rafael

