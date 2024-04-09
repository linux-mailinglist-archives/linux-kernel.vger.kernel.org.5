Return-Path: <linux-kernel+bounces-137277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A7C89DFC6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A301C22B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F14813BAEF;
	Tue,  9 Apr 2024 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC2gw7Ny"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF7137C4B;
	Tue,  9 Apr 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678149; cv=none; b=VlUrIEGoxba2LJnfVgS6ToE4j9Tj9u1ft4bJafX9+6w/t/QFOp3Jatg8adL4njjnQvr4uZKuPMl6cFTUR8K4OVQS2eWd6/wn/gK+qheUJDekPsS68eVhAkBS86sGH4aAGJ1C4O0TWw5cHifLeMGrWRclK3kGZikTQi9rJf+ndxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678149; c=relaxed/simple;
	bh=yUKisf+hNaAY9pCVyNA3uiO6miIBAOlujYSfIxr5gac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsHzqe91yC4yo1y5EWA4MXL5HLrGSUaRFpCocAs3uTj3x9PD1UpNQfo7HxTiQFSb2KEOH1Z/3oDGHAdoxWDwFJfLRMM4V1iKLc3h1bcjOZ4NcUj1OfeAwKv7jBdxI6CTtpi4eVAVbwGYcWdCWsBWGlXUjgiF131taCorgqicyLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC2gw7Ny; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a2f82ded89so3051698a91.1;
        Tue, 09 Apr 2024 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712678147; x=1713282947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUKisf+hNaAY9pCVyNA3uiO6miIBAOlujYSfIxr5gac=;
        b=GC2gw7NyMXsWQSwR8Aiz9+URfToJFSLGeI9wDUoqwmhJMajRMukSyBd9PwXkrFhVEN
         TqEadsfXZB/TRlX4SvJiA52C0VEy25O6jPjw3PBxkQXw7+HJoso3Lib8QmCxLxgwjc59
         2KxyUusSpvZAxJ+H4b6QXiMHw9iCjNzvSp+Bc5MG5RbDIk92UWm1HwCkXnbtkdPyq+IV
         9+RgxyWyM7Ai09yXybKKw+Cp6S/qVReSN3ls9hWBlgqQ4MMGYDlbKlkXxCqDjdMyIgGY
         C2uyleVVJ3wwxzpKI8KnJrflNzxc6zXuFN+oKEOguqi4vTj8OVl+knfqdGlCo/15hizf
         Aq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712678147; x=1713282947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUKisf+hNaAY9pCVyNA3uiO6miIBAOlujYSfIxr5gac=;
        b=t6OUUyhQUfKJiD6krTbSjRLEEq84TgZ7S792Q+WDUbMFutifDDgclEX4cJNJuOz2MR
         2XyDfM6uGTjb5EMA+hc3uL3Mio7RCfi6ij/8EEVsmScW8eQvHSbB+mKZB22xx/KlAVl8
         Tcyu6vV3v7KBrZau35OnUWEHyZ5AfrdmqUCdlWagkvphstIdsDw/3ZBnpZIJRoZ5eGXx
         1lKhfFyE++tVXtXTxmsETvjykEmerM5dTbWDUeGPfz39SFObOtmo4NyBsCUFFqMIUKOw
         4B03tXv1FEVc3t7jlNebzXoXopgcZ6nDQVcEHdoXIM3gaK5FCN4CVXTac/dlRVFQmmGZ
         IzrA==
X-Forwarded-Encrypted: i=1; AJvYcCVYHps5BSi5/8GzFKkceiGqav5HOoIWIbAftjL4YdhkL2JxAklwaay9Ctyf1QIN1FEGurAK7kR+Gp0UPxiO4F1o3vKivigvu2Jgnj64yFtqgBKHu1VcrGqv+QJDE5DxO2+1UYvLlxMxhCkInGyJCTzLryRkR9uSTbaTSaFanuKxYxMELu6yykV4yfU=
X-Gm-Message-State: AOJu0YypXcfMxtq0uUlJntWQrcPIHH842o3VPiT4iOfX55k6MxtTVXb6
	KAZ7VAxAdcXoFgpPxBMNfyX7zgrWzyuNFaSOb07BmySca8Z7XYu156RkBMgzPYN6g+ywvjscdAa
	VexlQqZe13/uc5Rej5Gx4mXDsAdA=
X-Google-Smtp-Source: AGHT+IGDusmzO139V37ZKEkzzEmBz+O9TMPBtKoZ3qfSPtaGE0n0s9Aeh1Zn06FGOo4xJEV6zlHHblpSpgdlfNtqRcQ=
X-Received: by 2002:a17:90b:278a:b0:2a2:35e5:f04f with SMTP id
 pw10-20020a17090b278a00b002a235e5f04fmr21722pjb.38.1712678147518; Tue, 09 Apr
 2024 08:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305-shadow-call-stack-v2-1-c7b4a3f4d616@google.com>
 <CANiq72mCzRBW7_H5Q4VQF8PGRFwaKJzQwOe8LOP2NbStz4husg@mail.gmail.com> <20240409103120.GA22557@willie-the-truck>
In-Reply-To: <20240409103120.GA22557@willie-the-truck>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Apr 2024 17:55:04 +0200
Message-ID: <CANiq72mzMBDJnkSW_EDaVdAEHbWtsLL6-unY0R2nOpexhHbfhg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add flags for shadow call stack sanitizer
To: Will Deacon <will@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 12:31=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> I think we have time to do this properly, like we did for the clang
> enablement a few years ago. In hindsight, avoiding hacks for the early
> toolchains back then was a really good idea because it meant we could
> rely on a solid baseline set of compiler features from the start.

Yeah, it sounds fair, thanks!

After the warning is fixed (i.e. `-Zfixed-x18` or similar is
implemented etc.), I would recommend adding support to the kernel for
the `-Z` (unstable) flags, similar to this patch, in order to test
them easily and getting `rustc` to stabilize them. Then the only
change required should be a name change to `-C` or similar.

Cheers,
Miguel

