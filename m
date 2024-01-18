Return-Path: <linux-kernel+bounces-30334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFBE831D40
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7382D1F246A6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BCF2C1A0;
	Thu, 18 Jan 2024 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmNLol1R"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF632C18D;
	Thu, 18 Jan 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594194; cv=none; b=idD7omE58vf/SwKGKveQMQvnhLc2QHv5yMz5y5KJ2PfXKgLghrYFvtpx8SeB6f0RlQWWPDkG99GMD+AnloU9MnBPqY4m2K85fskjQ5ZAEC14z7NjQlAssBf+m90nTchHEXfEiPaWOAF+8C6Y/8fFkwrRfC+2xyd5JhOa6+8YKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594194; c=relaxed/simple;
	bh=sat5XVJBaEElPICy/YsSs9yFT4hHkFR3P2GPDCmg8WA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Yq7ML1POWOiC8wJKYDSkF7UsCLLEPJ8WRMIvnZfJjHqGFc9qVjxzoOB/UV2zpMFUtp+zIJM0kTTye/R/PYFFzmStFZmk+yuDQbW+83aGxerWL6rPRojraNYoLdYbgLEWfOSms8FHpDN3aE3bsaBi0u+bM1FgF+o2m/A/HigPlCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmNLol1R; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dc36e501e1so8956259a34.1;
        Thu, 18 Jan 2024 08:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705594192; x=1706198992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sat5XVJBaEElPICy/YsSs9yFT4hHkFR3P2GPDCmg8WA=;
        b=nmNLol1RMxQK9iu5sy4g7PWZVTWXUNfv2wQZq04p/uzW+0u3Vc8Jl57wa2bM57oLMP
         mOxk7u+kCEezhmaKLGfe6+dpE8ptM/m4OUbbhK+Rg1K4xaj9R1dLtkeLeulKZsLzfKX2
         ZpgwQUl5NyBajcX1SsoKGLzlkz7hP5FDBcwkoZqJZhcoWQlLZKu581jzv6xVdzwmxBUi
         kdbwQSweWbt47SYdZYmJGkiL+hCQlyovRYorZ60iOMHXAVENyLU1pWeEqLafHaSllBCC
         i2KsObBw+C76IOnwOdNzxuN3M2nUBnFT0mU/Nq9w9lNjx7dS/d6Vw9toe9X2TekfyBsZ
         C5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705594192; x=1706198992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sat5XVJBaEElPICy/YsSs9yFT4hHkFR3P2GPDCmg8WA=;
        b=kwM7UxB54QU+j1BZG+qKUjrh+iZhtxNZkYkYvqs3LLrJ61dZS70lczQoHQiSdlfQc+
         43n6OMx9WDordfLDevraY7kDsLWvuQblEzRuB5wuj46VUVpkoxo6+L7Xj2y+3sY3wbVd
         qZeAb6jWAhwISy5SkbFt4x7+helPlrDTjYFOGho0veuGohxqOFDyDxt8zyGMJx1rCHrH
         XqcUGSxmBEOGmR07g2Gw2gIkAu9rKz+YiZWYM04SA+IbNfZzfV9XoTFq6gnGN0aBn+Ms
         YwIZegSgnMmoJKMP+HIiDDP8kXKrcBnZrCsLsnS5viE7kFiz50QWx83yYlWqTmkKpDQQ
         xF1A==
X-Gm-Message-State: AOJu0Yy/DQ4Rzf1qzTReXD4W+DFpC00WRLbvEqwPh3cptcm0CEBkjX6H
	R5Bke7y68lMEE0kmXVknAB0OyZRhu+9wzI7RZTgJFHawAvsH32XDIzfumGlo3Wfxjhl3R3lVl8/
	cIi/9jgSIaoIgtCLZi9m6A9BNxbg=
X-Google-Smtp-Source: AGHT+IE8BxWk8xSUOVo/9OK4svfp7Z2O77w7n+F5xbpJMja3d2YxFrdU7cRXJ7Wmp+b8zwZAJyZxdCAh53nVnb00V48=
X-Received: by 2002:a05:6830:1e38:b0:6dd:eb6c:8c7 with SMTP id
 t24-20020a0568301e3800b006ddeb6c08c7mr1066678otr.40.1705594192185; Thu, 18
 Jan 2024 08:09:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230307102441.94417-1-conor.dooley@microchip.com>
 <20230608-dispatch-sneer-aa09bd7b2eb8@wendy> <CANiq72nnph7LS1fLRtHz8NJ91PWXPaUnm0EuoV3wrbvK398AnA@mail.gmail.com>
 <20230608-spiritism-gonad-5f5aff4c3a24@wendy> <20240117-swiftly-parasail-618d62972d6e@spud>
 <CANiq72mVKCOAuK4Qe+8AHmpkFwyJsVfx8AqB7ccGi3DYpSSWcw@mail.gmail.com> <20240118-implode-delirium-eefdd86e170e@spud>
In-Reply-To: <20240118-implode-delirium-eefdd86e170e@spud>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 18 Jan 2024 17:09:40 +0100
Message-ID: <CANiq72nx1s_nyvPW86jL7eiOxROr18LfOJqNtw8L42CP+gkhRg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 4:49=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> The bit that worries me most is bindgen, and in particular detecting the
> version of libclang used. I mentioned to Nathan or Nick about needing a
> buildtime test for the version of LIBCLANG being used.
> I'm less worried about this for LLVM=3D1 builds, since while I think it i=
s
> possible to provide a LIBCLANG path to the build system, I suspect that
> for LLVM=3D1 builds it's almost always going to match the LLVM toolchain
> in use.

`scripts/rust_is_available.sh` tests whether `libclang` is at least
the minimum LLVM supported version; and under `LLVM=3D1` builds, it also
tests whether the `bindgen` found one matches the C compiler. Do you
mean something like that?

For `bindgen` under GCC builds, we will eventually want a "proper" way
to use GCC instead (or possibly other approaches like querying the
information): https://github.com/rust-lang/rust-bindgen/issues/1949.
Recently, there has been a thread in our Zulip and a couple people are
experimenting: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-G=
eneral/topic/Bindgen.20--.20GCC.20backend.20port

> I'll do another rebase and resend after the merge window closes I
> suppose :)

Thanks!

Cheers,
Miguel

