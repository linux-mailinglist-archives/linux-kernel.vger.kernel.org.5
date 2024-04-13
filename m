Return-Path: <linux-kernel+bounces-143517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF508A3A6F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5610128237D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED8E15E89;
	Sat, 13 Apr 2024 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Efbp56OA"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107ABE40;
	Sat, 13 Apr 2024 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712974665; cv=none; b=dQACvDUx6a7jFEnKzEKJOOc295gyBl9VFQpy09veIqmnBY8MS4xHHc7AyfW17P7IhvFHONqFS/cOuwl2MNY7mn2jI9WToeGe1Bxoyk+i6RXnMQdq4L/05ALfDF06dQhIEaVT7jz8SGgMW+EkpM/l+PVWAfSaGs9ysqRtlL1NRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712974665; c=relaxed/simple;
	bh=8H5mcOiwbA6iWP7BER7hyEiAZ3aCJSzdPSLLamrrlUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xg3tlpye4VEOfkQXTSGCsC9SxMXC/NKVeqGrGw6erp7XJIBpuxGnXVt717e7AgvJLXdCJRLd+4JgeE6q+r5+mDS3MiZMfJPjZt3CLCa7SNMcjMas125wIVGFpVwe6kAOEBt6CkW8n8f9rqOZ3pFXeG54m6f4mOvr5i4tHl4xUTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Efbp56OA; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a52c544077so1084985a91.1;
        Fri, 12 Apr 2024 19:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712974664; x=1713579464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8H5mcOiwbA6iWP7BER7hyEiAZ3aCJSzdPSLLamrrlUU=;
        b=Efbp56OA8wvYldi70to+mUaL38U1sDL9OXCuOlNc50PNy+niflbQ/5FQytkHhtO3vR
         0DBHHUMXg7Dm43xI/FUlVja1FUNsCcFyD7YE21tP46otSlDroIuwp4Ize5B53IQlM5jX
         r4JCzeMONN5NYwF0QMsE6BVYo97qzg9HIZX6kgec8X9qzvGQ8U29xrZUn1jqAFy9vrlE
         SRKF/gsws6S/52JE5f1Bn0VtqDcYPCfxMbAxdPm9RYLBROFpmNfluQaDcX5PxjCGQ/hK
         ZYgMd27ZkfQ0yDCuj1/J5WR+H6l05Kj/mfTcopXndO+lwdVTrI3E2xQ14FP8GQJzZ60K
         tBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712974664; x=1713579464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8H5mcOiwbA6iWP7BER7hyEiAZ3aCJSzdPSLLamrrlUU=;
        b=EfeXbqzw22Jy4IBu/UYHlQ0ApudU4PBRHx/R/CEGwjIoS/makzB1s+gE1MHRNdchLQ
         XrYdmpip67s7uYAM6UGVNlFLP78tsnt+bBtHjbxbFh+LGBMIfATt1eThSftxWMfNxtvj
         MSfmtkaeoh+mvUr/tU/xGSrw375p7/CTgqssrCkskiT2GY6/MnreKippWryetRLfCLFu
         xHiw5q9teV59NBPXxT9Wi4Hbgit+lYusPJc40Xl3KhKQmLPYQb4yRRINe56VYh4uNaJ5
         proGOEXmvtJe6NmGtH8rwYmydb5+7iuLwlBsD5zHRQ6847l+9EBuUrzBSkh2dQvlN24N
         6Yiw==
X-Forwarded-Encrypted: i=1; AJvYcCWnUkOZDk5YPNTVWAEoJJ0BMMKEGUOZ5BmZXBsB/kMej+HBzqOtIFp5KkzPOU3NH23OjYfdHT52weY430MG5Xdjo8vEEUyUN01fhnPdiDNdSujPco+SXZW8k7ie8y8x7L1lCWyJcWCS1b9nuRw=
X-Gm-Message-State: AOJu0YzrjnVf8uB4tSH5iGaAMTRfJxeB3T4lSZMtNdLQWQXcgl8jN06t
	q/p8DADS5+9uAhwSIAm39rE3Qic1xcTLsmQDNZgKyioQOuZjw15muXnpuXyiVl4891FksSMpn5K
	6wn+jqAo/tQLEGhE+zuodUP4+kL4=
X-Google-Smtp-Source: AGHT+IH6mcBye0oMl6nLhuG4Z4sw3LAzzSUksMULw9UmEp/wN5kpVQ/iY0+x5BwzKABNOubsDydvGI4rrlbjNAxKsx0=
X-Received: by 2002:a17:90b:1243:b0:2a5:bf83:8db8 with SMTP id
 gx3-20020a17090b124300b002a5bf838db8mr4003963pjb.4.1712974663770; Fri, 12 Apr
 2024 19:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
 <20240411230801.1504496-3-boqun.feng@gmail.com> <CANiq72nSSAVkynVaAq7bQKoL6N8K2JUXp8AOVvu7vN+siAhk-Q@mail.gmail.com>
 <Zhk4Uqc4LImR2n_r@Boquns-Mac-mini.home> <CANiq72ka4UvJzb4dN12fpA1WirgDHXcvPurvc7B9t+iPUfWnew@mail.gmail.com>
 <ZhngOs7Xze65i9Qy@Boquns-Mac-mini.home>
In-Reply-To: <ZhngOs7Xze65i9Qy@Boquns-Mac-mini.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 13 Apr 2024 04:16:52 +0200
Message-ID: <CANiq72mwx6uA4cWRjpUxu4E1MLZhnofuwXLBnYFn-eUG7-aN3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	bjorn3_gh@protonmail.com, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 3:30=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Based on your reply to Philipp, I take it that
> CONFIG_RUST_CHECK_OVERFLOWS can be enabled in a production kernel,
> right? IOW, it's not a debug-only feature like UBSAN (or maybe I'm way

Yeah, it is intended to be used in production (for those that want it,
i.e. not everybody will want it; and probably we will want to provide
other modes of operation when the check fails as I was mentioning,
e.g. report and continue with wrap).

> wrong, that UBSAN is also a feature that production kernel can or
> already use?). If so, then the current `Ktime::sub()` has a different

Generally userspace sanitizers aren't, but they may be (like the
minimal runtime in Clang).

Not sure about the "status" of each kernel one, Cc'ing Kees (sorry,
you got dropped), but I imagine things like the integer overflow ones
with `UBSAN_TRAP=3Dy` may be fine in production.

> Now I wasn't trying to say substraction overflows shouldn't be checked
> (by default), the thing is that `Ktime` is just a `ktime_t` wrapper, so
> it's natural that it provides as least difference as possible. If it was
> a standalone abstraction, then by all means let's add different APIs for
> different purpose.

Agreed that we should generally avoid surprises, but here the C side
may be actually expecting the same (i.e. no overflows).

But if that is not the case, and then you think we should call this a
different name than `Ktime` to avoid confusion, that is fair.

> If you look at ktime API, ktime_sub() is the only one doing
> substraction between two ktime_t, there is no raw or unsafe or safe API,
> So as a minimal abstraction, it's natural for a user to expect
> `Ktime::sub()` behaves like `ktime_sub()`.

Yeah, but as I was mentioning, in the `add` case, it seems like it is
not intended to overflow. Thus one could assume (perhaps naively) the
subtraction isn't, either.

> Maybe it's wise to just wait for them to reply, I don't think you and I
> have much disagree other than ktime_t API semantics ;-)

Indeed :)

Cheers,
Miguel

