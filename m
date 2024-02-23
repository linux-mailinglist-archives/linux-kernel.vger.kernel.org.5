Return-Path: <linux-kernel+bounces-78509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 549EA86144E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C141C22DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361487FBA5;
	Fri, 23 Feb 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqhINM5k"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E45DF00;
	Fri, 23 Feb 2024 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699202; cv=none; b=V1wUf5MBVGbo+G1l6bN4ov6V9xDgMiS6wdS/HJbrc5IF5xnwYNs8jGLipv2uudybUOrU2sBqm4d4kn93fSR4qC/ZZSE/m7KZ11opO66BhInFfkape4AcmODrH/mqzhHekJWTFiWny7JPsQK2vhhvVSNGkrzhOQY+Byso+Ozjjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699202; c=relaxed/simple;
	bh=F8ArNbtydFiL0D6k2+Q831xONNh/JINNubofnCWr6EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j59otzoiD3MoXlyaAT9Z4BqJHQoSuhlh4i+wO5VrClLIfDy8gDHexr+CSEta71KEQVpAY4Vhyd+HNfePaZC27SJwJYJ6tikK+GMlJVGfkHwlF6EXFiy8GpGazoSndBh6wd4CO7qRpWrnjA0Z8qg5WR7p/dRV+6eoUkGtIifizWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqhINM5k; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e4ca46ab04so251045b3a.3;
        Fri, 23 Feb 2024 06:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708699200; x=1709304000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KymCeXAdOwhnbLLu7sHJyesb6UapRJI/5wmiDLXWjq8=;
        b=CqhINM5kO2385xqPlWcnx5GAVjd9DTVvfeFA+oy1PHmG8Gan5yQJnNLdpK1CONCgtO
         P2ln1LjAFGEOmm6TFAH1aWzo+ssjRcQwfCiZRN8u+8fKFYGjJwkKSctlulptxqdalwG5
         1xQ54aLX4s187D7DlkHjBvdeBwTwP/z/EWOoLtc3pzrznK5RTEERz/FsrrQ+qKjQpsTS
         DYesOz9Xx/fH2zR+493mQOHigNQHUSCqwsFWrwFInE1/wG1k4sQJPQ3JTfPZ1akMAEi4
         osQ/PCFDcmNYwIgW0Wv0HPYZaGzcU2et62TpBum7DT5ff/j2N97fLWfKQYms1lzX3lHH
         d2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708699200; x=1709304000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KymCeXAdOwhnbLLu7sHJyesb6UapRJI/5wmiDLXWjq8=;
        b=CqKUt7jTVW8rbhuf+rOO/UatjWjDfYFNDYI0iEm9vWOXbE2kdQHIJpe9XPMfOobl/a
         nhhRI4rihIkvH4XZ2OBEEHM/fREptlTbiafzFJnT6S5fZrZy8K0D/OFJ/bOuzo/5GZfB
         1UOCggXTccsq15f9jjXYI9VkB29nQR4w4XXBbQe1qNMjrsqgGpOZz3vlbhoBjCliL3EN
         NlMtlSBM+AG2Xv+ot2g51dVhy46gnlDS3GotUZ80P89BinmZk9s+71ghch98hqFMbPif
         gFQiKGM9xQoOT6z8nk6s4EQ6QK5WzARPRx6xN7QBk6P2ZnIPvX2YeELDhBHoRzNwmM7h
         KRtA==
X-Forwarded-Encrypted: i=1; AJvYcCVPlC2mzZLyMPB2FNaDnKAgjKpETp52FU35JlwqjR4VXb5vAbDHzulUvsiYUfMUx6HgGqKxhPcZTrIP/q+fAjBNb+o8Ic3jQapYtnP2xV0z05o2YKStq36McjGaN51BRCl6ZD2XKBQocagoDCuqihHmfpMk42BwXtVo50jw7kgT0T9hLb53CTw=
X-Gm-Message-State: AOJu0Yy38Va8C+steOMDc0zR34jK/5h1Elh3kt2H31BbJGed9P40XBRB
	mT42pOZrqyOCI0PlIrXCp7hyamwIFbAMZ4tHQoFTVgAgz7Of+orSA9DiOElg8tub0aQ+QfY2A/l
	8Iy0gjDC68AvlLV4sj8rsKfbXWpM=
X-Google-Smtp-Source: AGHT+IHwDwRlHf/VCvl3JY5KZpo2YjDUVeb5So1ID2OBba3Z4WVPb5UzKpoEEDoA/9Zp+8R5HJYMwh7wafY2OKOm9SM=
X-Received: by 2002:a05:6a21:3943:b0:1a0:5841:6756 with SMTP id
 ac3-20020a056a21394300b001a058416756mr81570pzc.4.1708699200297; Fri, 23 Feb
 2024 06:40:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-leverage-walmart-5424542cd8bd@spud> <20240223-employee-pessimism-03ba0b58db6b@spud>
In-Reply-To: <20240223-employee-pessimism-03ba0b58db6b@spud>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 23 Feb 2024 15:39:47 +0100
Message-ID: <CANiq72ngEZskjH0f=8+cJuQsFTK227bGCxe5G0STMHuPbZYnXg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] scripts: generate_rust_target: enable building on RISC-V
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>, 
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

On Fri, Feb 23, 2024 at 2:38=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Add the required bits from rust-for-linux to enable generating a RISC-V
> target for rust. The script, written by Miguel, was originally a
> config file contributed by Gary.

Thanks for this Connor!

arm64 is sending these for 6.9:

    https://git.kernel.org/arm64/c/f82811e22b48
    https://git.kernel.org/arm64/c/724a75ac9542

So it would be nice to see if it may be already possible to enable it
via a builtin target + flags instead of the custom target, e.g. arm64
does:

    KBUILD_RUSTFLAGS +=3D --target=3Daarch64-unknown-none -Ctarget-feature=
=3D"-neon"

and so on.

If it does not work, it would be good to know what would be needed for
RISC-V and put it into the unstable features / wanted features list
for Rust.

Either way, it is not a blocker (although you will need a rebase after
arm64 lands to use the `target.json` in the right places).

Cheers,
Miguel

