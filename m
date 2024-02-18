Return-Path: <linux-kernel+bounces-70568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18F785993C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F941F21650
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A7C71B5F;
	Sun, 18 Feb 2024 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji4hFOo1"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E1D9442;
	Sun, 18 Feb 2024 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708287842; cv=none; b=IE430Lysdqa6cC8XOCyCxHlJXgx+ZllJ/zq+9YRWxF0unhuHYm+Mh1H41eef+kSZruiez91+up7JT4V5bvweHX0RQsQuiIU6HLNao88WGiT+KQv5jK2h+dZ8rC3aA8JbRyKpLsk8f/BgOOTflUhbUI4VwEI3/rKop6b7NReCcB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708287842; c=relaxed/simple;
	bh=9UBfPdAWitarenQUufc1/5ESRfkihBXS17Px9w7uiQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlHLKcJXnDm2QO9s/rpcdgAlOWEsjiEMvkCz/KK6Xr78VSuZI7rG+F7ZFPWgNK6kXHmdnJMiHgtsPYIAYA0RQPh8ko096xTBw4Ypt2ErAuYF5ug5iRr+pNEqEiPr2uAWO5Gi+f9Ea/DEVTQiGwRKswABlQDbVJyiRtOnLN/gHhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji4hFOo1; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbed179f0faso3275374276.1;
        Sun, 18 Feb 2024 12:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708287840; x=1708892640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UBfPdAWitarenQUufc1/5ESRfkihBXS17Px9w7uiQA=;
        b=Ji4hFOo1Adn3ZTcPy+zOmAH9g6qYzLvvKWWjvblGdN9nUibLZ3BUzGbYFCtxFMkB60
         8eCFmoINRJMYmgXqBbxt8unD/0eHvE9UkNsT+1Doj3ETl2efW+mkUrHb8WIFtsLxSPpr
         nhmKGEnMZ/N5g5sOj0rXTB4+L1kSqvNnc7AzaYubIes2DMjL0waETTq/Qn2d3aPOnVWU
         nxjDf09KtMhSigz8GruBoHmoLkXmbQIz1yxL28nBunv7AQXMNJewNJpK6p1CqguG8JzX
         yOZaX9JKjoaYlS0SZImlpNvxUMikkJmNXuw/AM7VZBWSZfc4IJL7q1a3KmwtjL7MqfFx
         bw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708287840; x=1708892640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UBfPdAWitarenQUufc1/5ESRfkihBXS17Px9w7uiQA=;
        b=FNqOgEYYLYoo88mHOXKpIE7v3Kw9B7oZ2FX4Wou6EJCqbkGi13RCmllASIB4+g5tD7
         /uA6vrsdsORTQk787GzTNtmOrSJoVUyF0y8wSSkhZwvYyIBmG0mEraHg1tsgf1Fvs2NO
         N9tLlW+Q6aDtyTfbTywFXoGRs4ulpsBYuk/HZPSt7/CSSfWbOIikGkdv/AHCE8CIJNUH
         s/6hhBfW4K6DFz08lDNba3tB8EVVKRLEwuvydLMcGhpqXOPCCnrfnHtxzQ16Wz/pRzgj
         Cg5q9Y8f85FphYa9cYN/uMpNnEHviVHdz4wDi/fegfii8JAZ73bdqJtxkHVv6mGXH5ZE
         upig==
X-Forwarded-Encrypted: i=1; AJvYcCWSoIHXUzQzTxBL1xNzBSKCAbDtn3H9QR4N5lUrIi6IQXYlCGlsT9V5Z6kXoDbMxV6OwwShghjTTjA3P6fQmyQpxCi3Yp//RXyA3D2aT13JzwRAcsSVVUildI5fMoyLMIh4+ScIN3yIVLTVaYU=
X-Gm-Message-State: AOJu0YyQDy7N7hyrd2Ipx6uOV3GZuYb/mXpaWacxZBSBncwdnufmlbIm
	QlV+J+NX5kEKcnugkCorxLl3vr+C/c0pT1BEjo5XGxCMnlzRwnUyCjETlKPZO8kzKGXCj/7+cLu
	iKmG9zqye7aEFHbSQigdkcPdz0rg=
X-Google-Smtp-Source: AGHT+IFPA86Sg6poJ5InepEXndgx08qX43Wiq9FWZXRqzBqj+a48BuOT7vgAy0rQJPMOn29WzFUwRgKOydPYoqiSYiw=
X-Received: by 2002:a25:c1c7:0:b0:dc7:3362:4b2f with SMTP id
 r190-20020a25c1c7000000b00dc733624b2fmr9400368ybf.13.1708287839987; Sun, 18
 Feb 2024 12:23:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129145837.1419880-1-aliceryhl@google.com>
In-Reply-To: <20240129145837.1419880-1-aliceryhl@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Feb 2024 21:23:49 +0100
Message-ID: <CANiq72niWTCTF=X=MYEe5xbF_N9-En=Uq5Jt_b2LvLRC7yKjLg@mail.gmail.com>
Subject: Re: [PATCH v1] rust: add reexports for macros
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 3:58=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Currently, all macros are reexported with #[macro_export] only, which
> means that to access `new_work!` from the workqueue, you need to import
> it from the path `kernel::new_work` instead of importing it from the
> workqueue module like all other items in the workqueue. By adding
> reexports of the macros, it becomes possible to import the macros from
> the correct modules.
>
> It's still possible to import the macros from the root, but I don't
> think we can do anything about that.
>
> There is no functional change. This is merely a code cleanliness
> improvement.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` with the new `prelude`s removed and a slightly
reworded title -- thanks everyone!

(I also created a "good first issue" about other `prelude`s that can
be removed: https://github.com/Rust-for-Linux/linux/issues/1064)

Cheers,
Miguel

