Return-Path: <linux-kernel+bounces-134632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C634889B3E3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5151F213C7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C6D3FE36;
	Sun,  7 Apr 2024 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKnuCAY2"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F53FBA6;
	Sun,  7 Apr 2024 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712520201; cv=none; b=cuFDWZmLvXzfdQIvopMnc/boMoQcbRSVerfUF9xWmn7RRIduwd2OELtSZuSxZG1G0CMEuM126r2jFPlhNTqO8gSpgeMj4HvQwpmQ4cW+Ehcpau7T62rTnT1yN4zu/8k8zv6mPBj/XklzsA6GX7C3arzoDUKV3BkoudI46Tf9Gpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712520201; c=relaxed/simple;
	bh=nkz3V1KnJRU4OVxZTLpNwOjleUUcWRpMJl+ozZfP2W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShuCEoXGh/Srln99OkztnSD4c8FTX4qIVvd7SSA7UoM/cc4WAZYwvwfA49GrcQoSsOmTgwTryT6TRPnwedTy34nBfIdRbr0g93zff3Ny4b6ROczwWbmTvyTK6rBICSqjqv0+sw3ufSWxzAaEN/Axf+slsxHtOA/1k2I+mRenVrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKnuCAY2; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2691050a12.2;
        Sun, 07 Apr 2024 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712520199; x=1713124999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB+pCgMJeT4HJ3tkJqRN6FhCakVW1xLtQCZILiBA4o0=;
        b=VKnuCAY265HIr1RkUS0OPWh77AE3bZXqKsOOu10bg4khDnF22cvuHOEJcH0qxHNZYA
         GzufhCCPy0WpOXWMpFVoV8/x6RMjVeQrC8rhgTWaWFaz5GxPE0/KJPt/nAjhgzPrQlfo
         L1yfyH6j4EeqC5gTqNOobjZHGlC4o7+HS2Q7YrojoPIF2ht2X0UOKzxCNXbW4M6qLWIp
         HHIhmSEUTAvjDd9JN6ZGxXyCJp/L82BfXsBybijpiSPXtuMHE4sxAsLxoBysyPAXK8UW
         /gJSltCIpTLFlvxRgZP8SUq/79ZhhgOimV3HKoVfSRDoUeWUaZIvlJOXY5402zdCx307
         KZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712520199; x=1713124999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VB+pCgMJeT4HJ3tkJqRN6FhCakVW1xLtQCZILiBA4o0=;
        b=CRsJLzFKD0eeFpGhDuYik6uAlwAM0BVoScdjcNbBheT7OlRF8Zu9XRrcZsvL97NB4t
         3GRDWfgecNKvgzYU2GaJYv4z0NsRBZt+LqcJKX6jyvoAWsSxLzWvAtIqm6mJ3QZ+pTjY
         kzG80OXy5HaJSz2PhgJb/vZqdY+p+kc6bDGVpPz/gXgQOzUQ8N+s/Gl8RDZBuHzu8qZi
         OGIKPTKOpXKZipAn+JPhsgB8kEWLchZNMU7GPNBMRRpIqqck8ZgbVX9V7XuE/NS7Mj9T
         nwbu/LFO2gxZ00T4qepf8Iay0HlgYXntz8q5zAHCBfy7M7mimZZgTAp5nhbsDRNx8gXA
         selg==
X-Forwarded-Encrypted: i=1; AJvYcCXtA64UgK9vxJ/54/aI5XYHvDv1r+pVuQvfu5cCqNJ8L65n4Amk1gVdEIJlZDpQ9TF4qUmpzAhGCw38AN11rBD3SFAqbSOtOQNr2dNFXrrvcmrRwtzGXqd35w9rh3CWqWMHHLEij08lNtyoUDf5HDQ9Nzt4GX/eyz4G2DEwRiNBZSrT5iE=
X-Gm-Message-State: AOJu0Yyvo6eDVcavE++qpajp4Tv29q4L5BTWmvAXKyX28+J7cv4HdzpR
	kwmGlLQ5QakPqM9X3HbmQNMTzOUTKsT0hXDFuUb5OezBbEoSA2b5JNZK5LQWsiLC9oLKpqAh1qT
	yOy3j/tUuLpkl7jcmlAgEwiZeO+w=
X-Google-Smtp-Source: AGHT+IF7TZyQOhtPwpbAJHeWULkLO56UWnBYQO7dp+kN2Xtnf2cGiSkKTtgaF3dO0S0E9x8sBshO5W1GD0QnNBZ5j1w=
X-Received: by 2002:a17:90a:fb4c:b0:2a4:8706:ed44 with SMTP id
 iq12-20020a17090afb4c00b002a48706ed44mr4614220pjb.19.1712520199108; Sun, 07
 Apr 2024 13:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401185222.12015-1-benno.lossin@proton.me>
In-Reply-To: <20240401185222.12015-1-benno.lossin@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 7 Apr 2024 22:02:35 +0200
Message-ID: <CANiq72=M0L+RG6v701ThedXgYj4SUgotx-BcVoWbMxOcKY5--w@mail.gmail.com>
Subject: Re: [PATCH v2] rust: macros: fix soundness issue in `module!` macro
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, 
	Sumera Priyadarsini <sylphrenadin@gmail.com>, Neal Gompa <neal@gompa.dev>, 
	Thomas Bertschinger <tahbertschinger@gmail.com>, Andrea Righi <andrea.righi@canonical.com>, 
	Matthew Bakhtiari <dev@mtbk.me>, Adam Bratschi-Kaye <ark.email@gmail.com>, stable@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Wedson Almeida Filho <wedsonaf@google.com>, Finn Behrens <me@kloenk.dev>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 8:53=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> The `module!` macro creates glue code that are called by C to initialize
> the Rust modules using the `Module::init` function. Part of this glue
> code are the local functions `__init` and `__exit` that are used to
> initialize/destroy the Rust module.
> These functions are safe and also visible to the Rust mod in which the
> `module!` macro is invoked. This means that they can be called by other
> safe Rust code. But since they contain `unsafe` blocks that rely on only
> being called at the right time, this is a soundness issue.
>
> Wrap these generated functions inside of two private modules, this
> guarantees that the public functions cannot be called from the outside.
> Make the safe functions `unsafe` and add SAFETY comments.
>
> Cc: stable@vger.kernel.org
> Closes: https://github.com/Rust-for-Linux/linux/issues/629
> Fixes: 1fbde52bde73 ("rust: add `macros` crate")
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

[ Capitalized comments, avoided newline in non-list SAFETY comments
  and reworded to add Reported-by and newline. ]

Applied to `rust-fixes` -- thanks everyone!

Cheers,
Miguel

