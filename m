Return-Path: <linux-kernel+bounces-61205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D84850EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15246B21418
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49E1101C1;
	Mon, 12 Feb 2024 08:34:19 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA16F9F6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726859; cv=none; b=LeOD5LTNzHUrIVQ3bYX/Ttgvu8nw2RuFQDrzvgt9jjDjz37fGGn7wcGDe+MeBaGRtNrOW+SVLt98OLPrGcqahrAYwVQf6GuYbAbpibfZ5AKUkgcxy49CGGAfrFB7Z8f0QiFlglILlwjSEmgurP8V+XWnUm0um/G0HN51pCB+HcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726859; c=relaxed/simple;
	bh=TC7YkIUu5KcxgTcQjkswqfPLExSnc8VDRJFLg3B3zu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcozkOWpi3rmW12Vrvv/XwlHSTrgGY9UCM/tMG+WLSLwpW1l1eFdd8hMUfBzfimDSuAV9lh60rU/urtEBWDTYpe3RRbfn/BOV/cklw+wpiuUAM1k4Ex0RJAsdnfFlANV9XPODCtM/iOt1j4lRbRWH3iGifu4NSslmU2jnhsUlyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-604b2c3c643so23506597b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 00:34:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707726855; x=1708331655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQCv0JdYx3KO7ENBhTEo9fPqiTJK6xJp0dwgojv3j0A=;
        b=vU4eVQMP4GEBBTwX5L/HBpTcwyr4m6BgEsO2n7WW8oVv4ACcX/3yv8RFIHnkpG2Zd/
         eJeUv4pSn2ZDUm3x6tuaRwg8J0QXPrsIUvYyyLoscnOzltQGX8rP3u0ueqljYRmRIBn+
         3M52ly0knNdUjW2g+hyqh2EdavwLYDtehA1Ydv9Of1EkkK/TbEHWzb6b6f0jHjRFajKt
         bbWYdM8lUvJWRBKvSLqQICa0Fo3EmOtkjAOz4ydTjzhMUWXXc5AFN9zK6TQhkf1bDOC2
         21hHSZsct9YPBDTxBigOsezk8u2k/K44J2riSYcM5k1rPSJiz3fhfJcKDrbsD2tyZ2Cr
         C7gw==
X-Forwarded-Encrypted: i=1; AJvYcCV3rWTIyn2+Dby/ViAO5/GUvbl+SznLXaBRW5LJoIWia4RoeJOrQw13XN2CjWwvKK3ReQ/0P3WdDiH2LeLJVHTNyP3W62zYH3rmRErV
X-Gm-Message-State: AOJu0YxPRO+eevnANB+0AUYHmfRGL4q6qd7IrKw3SUz0nFb6JkyfRIVT
	5u+IuoYqOfkX/Epy9sbmRDxPi3LhnvFZK73mCEyGP1qLE83qcd0Qsq4zOTOq3u0=
X-Google-Smtp-Source: AGHT+IG5Dkc3CDAWA6/Ty6pj2QZYqkSVswDFQuneNS9GtI964Rh00fNy0dLBkmJwSNOV6trAjgWOxA==
X-Received: by 2002:a81:48c5:0:b0:5df:4993:4371 with SMTP id v188-20020a8148c5000000b005df49934371mr2970075ywa.39.1707726855436;
        Mon, 12 Feb 2024 00:34:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXx6hJ+F1pm5AwiJDn6Op1GXMAuTK9TGPlzA5YdoO+QbFd320w22vY7H1200FLc1DXc4nENfbuYnYAwtc7FyRUfNpimFMBaWwY/fBN5
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id n204-20020a8172d5000000b005ff98d9a7b8sm1092213ywc.19.2024.02.12.00.34.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 00:34:15 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso2390659276.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 00:34:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+fepGNweZpD+h6OfdJnRq6/4FJTlDtpc/bMeXp1dxioxjH67wTZArFJbHkCi9pSkKGf8c9KtJZGPOvsdC7cKJKq7G3RA8U20xMP5h
X-Received: by 2002:a25:b1a1:0:b0:dc3:71da:35b0 with SMTP id
 h33-20020a25b1a1000000b00dc371da35b0mr2937501ybj.16.1707726854983; Mon, 12
 Feb 2024 00:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65@roeck-us.net>
In-Reply-To: <a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 09:34:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXMsxRRMV8g6+9vTy_4o8HF49SUh2deNdFjgKwDLEWrxQ@mail.gmail.com>
Message-ID: <CAMuHMdXMsxRRMV8g6+9vTy_4o8HF49SUh2deNdFjgKwDLEWrxQ@mail.gmail.com>
Subject: Re: stackinit unit test failures on m68k
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi G=C3=BCnter,

On Mon, Feb 12, 2024 at 12:06=E2=80=AFAM Guenter Roeck <linux@roeck-us.net>=
 wrote:
> I see the following stackinit unit test failures on m68k when running
> the q800 emulation.
>
>     # test_char_array_zero: ASSERTION FAILED at lib/stackinit_kunit.c:333
>     Expected stackinit_range_contains(fill_start, fill_size, target_start=
, target_size) to be true, but is false
> stack fill missed target!? (fill 16 wide, target offset by -12)
>
>     # test_char_array_none: ASSERTION FAILED at lib/stackinit_kunit.c:343
>     Expected stackinit_range_contains(fill_start, fill_size, target_start=
, target_size) to be true, but is false
> stack fill missed target!? (fill 16 wide, target offset by -12)
>
> Do you happen to know if this a problem with the test, with m68k, or mayb=
e
> with the configuration ? My configuration is based on mac_defconfig with
> various test options enabled. I use gcc 11.4 to build the image. I tried
> with qemu v8.1 and v8.2.

Thanks, I see the same failures in the logs of my last testrun on ARAnyM, t=
oo.
I haven't looked into the details yet.

Only two failures does look like a nice improvement, compared to the
previous time I ran that test ;-)

https://lore.kernel.org/all/CAMuHMdX_g1tbiUL9PUQdqaegrEzCNN3GtbSvSBFYAL4Tzv=
stFg@mail.gmail.com

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

