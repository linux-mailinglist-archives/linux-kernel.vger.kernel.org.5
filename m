Return-Path: <linux-kernel+bounces-9086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A09481C04D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC61B21E72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D4E77635;
	Thu, 21 Dec 2023 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3q+iUQ4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83B976DDD;
	Thu, 21 Dec 2023 21:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbdb124491cso1068694276.1;
        Thu, 21 Dec 2023 13:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703194740; x=1703799540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXU/wSqHvT5f9DP/nkZcmoPPi2e4LA2mSngSGEQpvNg=;
        b=K3q+iUQ4u+gHvM8f5spT0IYwGWoTLL0oy3G6BAVJAjuqMsOUFaMA7QGvGgTzLh24xS
         rNMMFEwhorVJxvkYYqYgbioj31r7KKLE5N73o3FU/AeUL2neCAlp5sTVi//ChYav5fJT
         6dgVOlWWToxULU369unxCnQGBz0ntMXwwLrAKY8zO/k1/nBwAo4E9wmLmlhXAlXhClbu
         sKRbFb9eeFdqIRFN9cJO01iOPAkdOvGWVG/dumkDKYLOSHlQBGMfNQz9lmxPnSae2Ms5
         ACsA1d1oDNGtxtloIbXpYpoQByMAqVAHFK2BKvewu+iK4+Gkhesu2bIqgc06XjRPnoxY
         nyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703194740; x=1703799540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXU/wSqHvT5f9DP/nkZcmoPPi2e4LA2mSngSGEQpvNg=;
        b=AxTYOX8e49csFJ39IUZ+op668RpCcanQXH3RIY2AE2M0fQ8aeTU7Xpnlt3nO7Lrvh2
         lsvCHWGdlamHs9kXLLmjz8t6zbb11GrQ7P7mkZtWqFjBqaSxw731havKxC0cK6ELq8Xp
         WOo1oqeG3AwXm9maNrOWITxy7bUuQXFezG7g4zsavbuhCzD4PCK/pvC9mHdC+mPw8uFM
         OZ4ZXpkdtqiBSn7ZDniRsQo2g8BK18rYDR1BYQHCqd9DsOKX93OHmds+BKD8D0Fgrvnf
         FM+VKa+sVrr7li3eZO24RAclglqv5tAL3d4B81gLqsctrTq3hywm9DfRFTwmJ6V6/E7Z
         mQOQ==
X-Gm-Message-State: AOJu0YzYj+fw/Rbvq2ml5MKZL5CQ+cHsZNpxaxx57CPmQB9N+ajZkh0c
	fPDm1gzxWrBHkUyWwQxwLpHumRLpFP3Pv3iumHI=
X-Google-Smtp-Source: AGHT+IEhMe74JI+7lQZDzUiCsOMUeUyAr8WAul676bT3WI7OIr6gqXdlQpGTwTIT/+hE3RCkjK+kJGE8F59mVr5xOFU=
X-Received: by 2002:a05:6902:604:b0:dbd:c25f:972b with SMTP id
 d4-20020a056902060400b00dbdc25f972bmr372437ybt.56.1703194740681; Thu, 21 Dec
 2023 13:39:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215235428.243211-1-ojeda@kernel.org>
In-Reply-To: <20231215235428.243211-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 21 Dec 2023 22:38:49 +0100
Message-ID: <CANiq72kfpdNdCXtxFM-YVLuOp34u_edieX0q_a94-5kAxdGRWg@mail.gmail.com>
Subject: Re: [PATCH] rust: support `srctree`-relative links
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 12:54=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Some of our links use relative paths in order to point to files in the
> source tree, e.g.:
>
>     //! C header: [`include/linux/printk.h`](../../../../include/linux/pr=
intk.h)
>     /// [`struct mutex`]: ../../../../include/linux/mutex.h
>
> These are problematic because they are hard to maintain and do not suppor=
t
> `O=3D` builds.
>
> Instead, provide support for `srctree`-relative links, e.g.:
>
>     //! C header: [`include/linux/printk.h`](srctree/include/linux/printk=
.h)
>     /// [`struct mutex`]: srctree/include/linux/mutex.h
>
> The links are fixed after `rustdoc` generation to be based on the absolut=
e
> path to the source tree.
>
> Essentially, this is the automatic version of Tomonori's fix [1],
> suggested by Gary [2].
>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Reported-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Closes: https://lore.kernel.org/r/20231026.204058.2167744626131849993.fuj=
ita.tomonori@gmail.com [1]
> Fixes: 48fadf440075 ("docs: Move rustdoc output, cross-reference it")
> Link: https://lore.kernel.org/rust-for-linux/20231026154525.6d14b495@euge=
o/ [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks everyone!

By the way, since I didn't mention it: this obviously requires the
source tree to be available at its path, so we may want to improve on
that later (e.g. exporting the needed files in the output folder), but
it is a strict improvement since it fixes the immediate issue, it
cleans the paths already reducing the maintenance burden (i.e. we can
keep the syntax even if we change the rest) and is a smaller change if
we decide to send it to stable later.

Cheers,
Miguel

