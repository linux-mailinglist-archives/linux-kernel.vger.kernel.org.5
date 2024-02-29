Return-Path: <linux-kernel+bounces-87590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9EC86D63E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D051F260D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E152A6D50E;
	Thu, 29 Feb 2024 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6ajt57F"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131D16FF47;
	Thu, 29 Feb 2024 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709242413; cv=none; b=TpikuBKU2Y3IE7C3HjSLW/e6g7vHQeCYX/nvWvmBicjgvGsa3f2Q1or3PxDCRWm0ynF5E2KqmpJP34uguEcjEAi7Wc/g0HWFsLxbdSTOMHr96ikMCvpPH1tFHRlwgggTI8BgoW754v4JndnXszsZWu9uCwM2lfP52WguZum2+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709242413; c=relaxed/simple;
	bh=BnJoVXU1CaeQbXBgRnIHjar/FV4NrO1c9oIQRiWiPpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRmnQ8rRwLuKPMGiRM5Lh174bp6kZOK5KPCETdzXSeGVK4wIHcRjNK2ti1YhAwYfLS8tsdTaokYOUzhSoHD2JA6+qJvhseMIV2pU6jOfjKB4NsWbzsvMRL43B8rp9DhklOQpM9fIEpstoC+DVTwSNka1xMb3visERnJU1AHHeT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6ajt57F; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-299b92948a6so981103a91.3;
        Thu, 29 Feb 2024 13:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709242411; x=1709847211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnJoVXU1CaeQbXBgRnIHjar/FV4NrO1c9oIQRiWiPpU=;
        b=Z6ajt57F1WSceLYkGweS7MrRdWKj2xFqPlkvjMxKXtei3ZVqpmYHfdmuNceUMakYiT
         Oaj39fT1B89truMMx8OU6v3bhb5L8T/fxMCUJ7ruu9GZ51UhuvYQNISZlUcmlitpP7MF
         rAe029msPQjM3igUt7dzHkGIE6MWtXOlOF5Cy/2L9rXZEbL/vehHsLzjSVQK4qOtJl8o
         bP9X4Y299SHxk0hB0doIc1xGg8iKMAMbVdh9rFmJTzGe9W/gGjVBUnCAMU9zjOooG3Pd
         C661SSum/+00GjD5XAID6lb3mNOaVvKZrjishBCIZslCEKCzlcZ8LaVA4vlFyCICRaWg
         sVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709242411; x=1709847211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnJoVXU1CaeQbXBgRnIHjar/FV4NrO1c9oIQRiWiPpU=;
        b=jRb4/c7kWid1rDDaSBPlqj4L+Yhnw5IxzgXtI7k0tAU3ipRFM9IlI81FTkWJu16AO0
         BOVWY32r1QqHjeUlaaLTQF6kz7D3gYZO2O7dmnc/odonaNB75issuXSebO8ZSq5v+VnM
         heA4Kp9pO8toUmJmq4Bekjdr99YOjrzGT0vsV9Sf1x+H1Yu+2mn09f1Ifae6G9Shsc3k
         lBsOqetrOL2kjSAwGEz4EE3QpUXGAzrzYKQkHEszFAKubrkaFRuSXjj9JHWeIdRXobWq
         v6wwplceezBugFNaAmhDqHflGFPL4vbG5PJndCA0Lxc4LVs1zBTVAbCGQa61/KyOc6Kn
         nvwg==
X-Forwarded-Encrypted: i=1; AJvYcCUhsXI5qScmtkOD90MrCo016Yzl9/fO0Z0q7Zva5vXXE8wiiiusnwOhFwiWIQOHxWSZ0J2DQduZeJXrgox9+iyF2+Qk4VIz298wv90mN5R2IJ2Rc/Pn3gu0s+imrcLP13dY8m3GJg7vjjYSdcqDLTCdFE4/qwBNSEiXoCCvtMMBLnIfdLf/Z1wUn1k=
X-Gm-Message-State: AOJu0YwxVSmbxB22uIkHhz6ZaE17p6LWtcAYdmYl0Xb321ljv5CYc0Vb
	ewaOgQs9FWEkSDzixSkiueCPV51qF8gEA/QepxCGIHXgOO5GDoUIc6iW9wZb1pxd1r3/PMNkXeL
	5fQxYvdCKCCNlol2spJXNWePHers=
X-Google-Smtp-Source: AGHT+IF7bVmqxeMhoRHyZpvokOgbCs4iWKcEFiGPNztP7CIoyae8cJUfmp8uTM3OBZKV4OvFKxKIP+IJE5Ov5jLH6Xw=
X-Received: by 2002:a17:90b:104b:b0:29a:cbfb:5b28 with SMTP id
 gq11-20020a17090b104b00b0029acbfb5b28mr300141pjb.13.1709242411118; Thu, 29
 Feb 2024 13:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217002638.57373-1-ojeda@kernel.org>
In-Reply-To: <20240217002638.57373-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 Feb 2024 22:33:18 +0100
Message-ID: <CANiq72nPiVDV2WY_jCuONz_arWRVyMMiRT5iVb=2xqoXnZYW+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: mark `rustc` (and others) invocations as recursive
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 1:26=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> `rustc` (like Cargo) may take advantage of the jobserver at any time
> (e.g. for backend parallelism, or eventually frontend too). In the kernel=
,
> we call `rustc` with `-Ccodegen-units=3D1` (and `-Zthreads` is 1 so far),
> so we do not expect parallelism. However, in the upcoming Rust 1.76.0, a
> warning is emitted by `rustc` when it cannot connect to the jobserver it
> was passed (in many cases, but not all: compiling and `--print sysroot`
> do, but `--version` does not). And given GNU Make always passes
> the jobserver in the environment variable (even when a line is deemed
> non-recursive), `rustc` will end up complaining about it (in particular
> in Make 4.3 where there is only the simple pipe jobserver style).
>
> One solution is to remove the jobserver from `MAKEFLAGS`. However, we
> can mark the lines with calls to `rustc` (and Cargo) as recursive, which
> looks simpler. This is what is now documented and recommended by `rustc`
> and allows us to be ready for the time we may use parallelism inside
> `rustc` (potentially now, if a user passes `-Zthreads`). Thus do so.
>
> Similarly, do the same for `rustdoc` and `cargo` calls.
>
> Finally, there is one case that the solution does not cover, which is the
> `$(shell ...)` call we have. Thus, for that one, set an empty `MAKEFLAGS`
> environment variable.
>
> Link: https://github.com/rust-lang/rust/issues/120515
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied (i.e. including the upgrade to 1.76.0) to `rust-next` --
thanks everyone!

[ Reworded to add link to PR documenting the recommendation. ]

Cheers,
Miguel

