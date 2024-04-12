Return-Path: <linux-kernel+bounces-142122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A34C8A27CD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8421F2558D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7582B4A99C;
	Fri, 12 Apr 2024 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKOYWLqs"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D82233997;
	Fri, 12 Apr 2024 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906152; cv=none; b=ZCTyfOkRM2DVA8TjagwnVfcvF+cv+J8+ZDI3ruz2KwN4osy/G8uOtNMfA+Zx0wyM+dPqbgJuU6Ye8II1CZ57RifZAp1MdpNra72rLfczc3fvmhVJ/WFcXRGmmUQK2pQK+RqngI0eKfgXkX+mWCAQgcV23Qk/L6AHh9HV9j1eLgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906152; c=relaxed/simple;
	bh=UjP+u8inUNDeGn6EQjkZzP5Cof1Lxv2OjXKfvLD8OVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGC62nHKfAiNvHBG/Vwk8RuN3wWR82e9xcftLrgLxuIfAV8WWhwnh05vwbNWuQaFivjoEr3nojWeOPKhCXv+fu1Bcs250mqdc941e6W2AlqKChtsqH4GydFoixVbfmc1c0tts5HNYkdky3SoZoX93Yatnd2hL9BR7QZZ86PJU7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKOYWLqs; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a6fa7773d3so164003a91.3;
        Fri, 12 Apr 2024 00:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712906151; x=1713510951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjP+u8inUNDeGn6EQjkZzP5Cof1Lxv2OjXKfvLD8OVs=;
        b=mKOYWLqsZSesXx2hd+cpYCOdwrgbBD29vMzYbfa/VxzmjpH9HTWhoUr/Or7A2Y7ArD
         ZZjC5JTnpvaxKk3zOy1LLcOJ/AToHI/mTjDdNrrTxHPnlrMTNqdJ1ex+y6wg5SwV/V7i
         J3gttC96w+co3mB8ZT7ZRwkV7QxEW8xSUkC+UrAyvKaQwgxvyoJlpRlT59GgG6qlk38r
         h6zwW3Po8R+YkG6WbuubC/5Ln8HipoaEDS55tk3k5tSWkiPJbyIJfHVxofVuVomT/Wgn
         WSnQ6Tek1NFiXc5BbBzdW8ryHGv68uzVGEYdQ3OVRyZ0dDBpnKh0ZYg7zqJROe9lE8m9
         qggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712906151; x=1713510951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjP+u8inUNDeGn6EQjkZzP5Cof1Lxv2OjXKfvLD8OVs=;
        b=jTwsROtOngBqjbBd4rW6ztZ4I3SzQYPpyrrbeEfk4U3wEfHRo/zHZCXSkJynwVhv3w
         6YColM1gZRuUvjI7mnbl7IP65Wmw07YBo32XrUjpWy0cU2a1bobkZRPdcUOc4QLivcMT
         UxzvZP3EnTso8AcoPJZ7JyRVqgDYAs590tEch96Gd/5d0lod4p6PqfgIVQs2I+BEfshm
         tCwkXBhgxI++KbmIs0NeEiRKEKEq7Kau/o1SkZ6FfWJU52UGAeX7ewQ+q3Nkw8hLYYiU
         UpEsgThONUyM9N/y2hxnDgkXXtOhmHxIdkKc5AOsFnhsh0tnHU6yPOctuB7XD9tOmZ/g
         mpMg==
X-Forwarded-Encrypted: i=1; AJvYcCUBLitnrH/Kjzmj1NtkNi5N9f6ujEdOd/FSWFp2SfXfJMlxSJh5MMYvM5rtqFDdr+Fn0zOmgWuhOE2GdJ95J/DEE/x7ipa3sVPShjER/rtXOL3RFLpofrSNrCPvDKn/R///XJdYxSdnjrcZVUc=
X-Gm-Message-State: AOJu0YwOvavKh+3Fp+0/b4VWANBemfZ2zBUudAWZgMm3RCIph0laFI3e
	0QWs40SYMoFcB1SnZ4Vx1X5Nfy7xtlJnzXawv/7X/Id84Q2pijKWtQiEZtUiOhXdQTyCb3pSPnk
	z+tQ85gFKIKdaTxkKe0HJ/igD9+8=
X-Google-Smtp-Source: AGHT+IFt21iC+I+98dYYB0YgyXWL2iQiZOsddukFqRXo3hCJ1kcb9XT34v8rvaaS1nanvJYssP/fN+fAcX3BuT4vluE=
X-Received: by 2002:a17:90b:1a8d:b0:2a2:3223:1930 with SMTP id
 ng13-20020a17090b1a8d00b002a232231930mr1686269pjb.8.1712906150831; Fri, 12
 Apr 2024 00:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411230801.1504496-1-boqun.feng@gmail.com> <20240411230801.1504496-2-boqun.feng@gmail.com>
In-Reply-To: <20240411230801.1504496-2-boqun.feng@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 12 Apr 2024 09:15:00 +0200
Message-ID: <CANiq72kzLfe1=wDboKb8zzz8i5GHQxhohgz22+x4Ut+sqEyc2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: time: doc: Add missing C header links
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	bjorn3_gh@protonmail.com, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 1:08=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> The definitions related to jiffies are at linux/jiffies.h, and the
> definitions related to ktime_t are at linux/ktime.h, since
> `kernel::time` provides the functionality dealing with jiffies and
> ktime_t, it makes sense to add links to them from Rust's time module.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks Boqun!

Cheers,
Miguel

