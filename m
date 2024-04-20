Return-Path: <linux-kernel+bounces-152312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE028ABC3E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 17:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCAE3B21032
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E838374C1;
	Sat, 20 Apr 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edA4XVGT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4E3168CC;
	Sat, 20 Apr 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713628276; cv=none; b=W6NboAhFz/N0zrwQUuwJKv8LMYkp20sE18A357AaAdzYjxia3ijUIq+KU55d6DA2bJ1DQzIe+K2cFO5wJVFM6o1VCP3Ksj34yPFVIZRgxPWZgnf7J/Pb6HQ3J1Hj1TSo0C0OFad/xmU0F65gOlgx8wA0wfAvATXv28LFdOfT9B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713628276; c=relaxed/simple;
	bh=1y9ReD3omOttKuEU/pbgVso8baWmO6raIsoII56FCTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNpiO0+MGuY+UrsaAlaa6UMjN3DH90xVWXRY/lNbM79jT6RiYXldT0IN1fbRAvC+4tKjKfqKJy7df3vAln4orMzEsq2xUtNQ0a0NFdsYK5QYMvoFCe+u2krVc6ePcf/1JxF1zGgxkdw5owND/IkH+9DNJS39qSY20aT5S/O/eRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edA4XVGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E8AC072AA;
	Sat, 20 Apr 2024 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713628275;
	bh=1y9ReD3omOttKuEU/pbgVso8baWmO6raIsoII56FCTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=edA4XVGTqIapcjhD4vqhl7D+6qCgdunFCkFnar3fvqFDhMp3LyS/5BVAddlZuzOo9
	 181OqFibd3eKCvgTVCWJpQByBBD/Cxao/g6wpQ4M+O2chpN9p6ClKdwzObCb/18sTe
	 SzayZy5wJgEb1EZKImzCjy2Xa01pwZSH+uTMZNhGPQ6459oR+jSk9nx62rwE7Reepy
	 kWTS5DdgYka0QQvLh8GUHeh4vAxulr9Pe2CkpjtfgRyoyYXJnnn5dEsg7HY5BB1/ls
	 httcZZdk9kUqKx2wl23dB3AQwwJ+Bz7rAKE73hd+3H3au0d9sKfAOv6w9631u0wvnk
	 I7U9iEl7+8M8g==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so3632607e87.2;
        Sat, 20 Apr 2024 08:51:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUb5hJYXtT2tTGoTmEEUsBj5wHRKEGu1BqEwjneI2aYEy8HkVzAYcrWrrO4aXnFaLi28qRtppdJ40qxBNkp3IVJigM86tUOvtluchpQq3fg99aO8n5688j/vpm/ZsRktHgPlCRh
X-Gm-Message-State: AOJu0YzeFsPEw/xGuoUF6hw05PovNlooGaXD6EBMfBlW6LhDx4g13V3F
	1aJm/AqhFZSno260O/inZBteSldxZPBZu/epbgrzDMsIgXZcoJutTZwLwocUjS22LgHsOy3GJ/3
	UHguaICvct8HBI5InC/iRgsD+/Rg=
X-Google-Smtp-Source: AGHT+IEDoq9iwxFclFtovzyfMv+BQvN+kusnl28/i1FMGJ35LKYWR3ndwLVhaQcDxlGWAMsvh3/0tfqRqPGS3ZBR7+k=
X-Received: by 2002:a05:6512:475:b0:516:d17f:3c30 with SMTP id
 x21-20020a056512047500b00516d17f3c30mr3446274lfd.3.1713628273772; Sat, 20 Apr
 2024 08:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418201705.3673200-2-ardb+git@google.com> <CAKwvOdnNurTJNb7iOVW4dpkV-rZGWg2t3HuLkL+B5sNOin39WA@mail.gmail.com>
 <20240420152938.GDZiPfYl9iIgJw6_ux@fat_crate.local>
In-Reply-To: <20240420152938.GDZiPfYl9iIgJw6_ux@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 20 Apr 2024 17:51:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF-U=WUg_+nC1RojLa8FWdx+dOuq8zUyTLJ5u290fFv8Q@mail.gmail.com>
Message-ID: <CAMj1kXF-U=WUg_+nC1RojLa8FWdx+dOuq8zUyTLJ5u290fFv8Q@mail.gmail.com>
Subject: Re: [PATCH] x86/purgatory: Switch to the position-independent small
 code model
To: Borislav Petkov <bp@alien8.de>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Song Liu <song@kernel.org>, 
	Ricardo Ribalda <ribalda@kernel.org>, Fangrui Song <maskray@google.com>, 
	Arthur Eubanks <aeubanks@google.com>, stable@vger.kernel.org, 
	Steve Wahl <steve.wahl@hpe.com>, Vaibhav Rustagi <vaibhavrustagi@google.com>, 
	Andreas Smas <andreas@lonelycoder.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Apr 2024 at 17:30, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Apr 18, 2024 at 01:36:22PM -0700, Nick Desaulniers wrote:
> > Reported-by: ns <0n-s@users.noreply.github.com>
>
> I don't know what the goal with this tag is but this'll keep bouncing:
>
> <0n-s@users.noreply.github.com>: Host or domain name not found. Name service
>     error for name=users.noreply.github.com type=AAAA: Host not found
>
> Maybe use a non-void email...?
>

Let's just drop that.

If people cannot be bothered to use their real name, I don't think
they care about being credited either.

