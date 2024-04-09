Return-Path: <linux-kernel+bounces-136882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3C389D95E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E440128465E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE42812DDAD;
	Tue,  9 Apr 2024 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY6p3tJ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0B12D755;
	Tue,  9 Apr 2024 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666700; cv=none; b=fkLScKcDpO+PcLaz5Ez9f9NKAj+Z4yUAWjPbEbGxI8xCSwp0RXQSI69+7ZT/NuqAlEhvFXhCc0uQ9GelXYLGAlmBD0e/Dl+NEmdOg3UFJl3C6jl0opeClZkqb+3azYCM3PJ8FwH2xz3jnQZWECd91QeLUuilelF1AE53OALpjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666700; c=relaxed/simple;
	bh=X7rdsbL7+LXMFqNdb3JPRvZ93H2cU4KFKkX7IKVa+0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpXFdl8sqDbkgyBN136AAY8jYW2F4lt/KtN2wPief6S45fMM1uy3n5429Mcm2x5mPg7XN617FW8rxFoO4xbS9Ttg4+nqMoVoQLDQOpCYkC+PyvXLScHvkC+UsPqJEH50pQRYR+vFx/5vR3r+EfVACw4vDwfxdb6O7BRSPeG1EDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pY6p3tJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77581C433F1;
	Tue,  9 Apr 2024 12:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712666699;
	bh=X7rdsbL7+LXMFqNdb3JPRvZ93H2cU4KFKkX7IKVa+0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pY6p3tJ0VLACzQ+VlxGKbtfCJIg1EdeWyxf17BxhDSP16I7MMXsci8Geyk1z07aWt
	 DvdLzFOhuH4ygHHW7ur5qP1MTUCwqzQAPxZVKq5Mwn1aVi7ty808IveODZsxxRv8EL
	 ZB3eZ3Vecj5qQAsHAb2h3lxXZT2ccMD0hNEyoyZui7BQ63reZ4JY1P/d9QLoTY/nCC
	 UnN6j8+obxLD2xOvaXMS9F367B+dHwsddkIGcociYcnuRNAA5wukd9rlsBoX7QAj47
	 rrdDXHocB1BfRqccT/YBSmqab3rC3FXYGZ7ygpf6t3hrg4EyE4/wt5mZtNqvOHdAmG
	 FjfRgMhzqc+7A==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d8b4778f5fso2593561fa.3;
        Tue, 09 Apr 2024 05:44:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuEwjM8mR89kzTpErVt3cFYOO8DgpciIhQ6LdjSONlpujitn2eeJi4wKAXpMCwkvTJWuK6zFGDM7tqMVTRSIGFWGnu97MvWcPs3ZcC
X-Gm-Message-State: AOJu0YzVueE9nOEZ7Hy7c6RZnrPTeAMWDcaZAn949n1Bsyt5Lz+cUQm8
	4JyTXG2kq6ggcNehDSIA8OxOj+toAoOMapdcbUd/mP1ddCll+gkM6HUoMsmCW9PJbvoeKM7gQFV
	lHzzOfvU+m4qol/gaBd6UTEEBU70=
X-Google-Smtp-Source: AGHT+IGOINgzpnwmK1fmxSh4NVCczyD/4h57b1sn/qDaziODObN5Qqz23WasWbLTlLiGqe2LrJr9nja9YyhiXOqQ4xk=
X-Received: by 2002:a2e:9515:0:b0:2d8:918f:55fa with SMTP id
 f21-20020a2e9515000000b002d8918f55famr3962471ljh.18.1712666697842; Tue, 09
 Apr 2024 05:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409000154.29799-1-ebiggers@kernel.org> <CAMj1kXEhrPo18dwAuzpn7R7ZGpOxr2pwuoAfGRtWwzgSF+mTsA@mail.gmail.com>
 <20240409121141.GA717@quark.localdomain>
In-Reply-To: <20240409121141.GA717@quark.localdomain>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 9 Apr 2024 14:44:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFxYW-45Ns_C0vss+gwoERiT6QX-h_Pgquf7zggUKdUPA@mail.gmail.com>
Message-ID: <CAMj1kXFxYW-45Ns_C0vss+gwoERiT6QX-h_Pgquf7zggUKdUPA@mail.gmail.com>
Subject: Re: [PATCH] crypto: x86/aes-xts - access round keys using single-byte offsets
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	"Chang S . Bae" <chang.seok.bae@intel.com>, Stefan Kanthak <stefan.kanthak@nexgo.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Apr 2024 at 14:11, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Apr 09, 2024 at 11:12:11AM +0200, Ard Biesheuvel wrote:
> > On Tue, 9 Apr 2024 at 02:02, Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > From: Eric Biggers <ebiggers@google.com>
> > >
> > > Access the AES round keys using offsets -7*16 through 7*16, instead of
> > > 0*16 through 14*16.  This allows VEX-encoded instructions to address all
> > > round keys using 1-byte offsets, whereas before some needed 4-byte
> > > offsets.  This decreases the code size of aes-xts-avx-x86_64.o by 4.2%.
> > >
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> >
> > Nice optimization!
> >
> > Do you think we might be able to macrofy this a bit so we can use zero
> > based indexing for the round keys, and hide the arithmetic?
> >
> >
>
> There are two alternatives I considered: defining variables KEYOFF0 through
> KEYOFF14 and writing the offsets as KEYOFF\i(KEY), or defining one variable
> KEYOFF and writing the offsets as \i*16-KEYOFF(KEY).  I think I slightly prefer
> the current patch where it's less abstracted out, though.  It makes it clear the
> offsets really are single-byte, and also index 7 is the exact mid-point so going
> from -7 to 7 still feels fairly natural.  If we wanted to do something more
> complex like use different offsets for AVX vs. AVX512, then we'd need the
> abstraction to handle that, but it doesn't seem useful to do that.
>

Fair enough.

