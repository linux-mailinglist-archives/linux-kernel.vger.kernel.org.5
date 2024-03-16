Return-Path: <linux-kernel+bounces-105205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC0A87DA80
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B133281DC2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4491B299;
	Sat, 16 Mar 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="m/VKuASJ"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D235D29B
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710601018; cv=none; b=ieCY1TOSZVbSBqT8dwt4Jf1rlvSRc8Ei26zdsmKN/myacAP7x22mubYuzMjJhZnwZ97iUY7H7zDInMUH+ZdareHp47lpytBaZsCFXcKm+52OlrQ/tqypHI3xXX6ys2qnFPd9ZhTOduFPcDsBCjATae4IfLI2EkisF/W8iUakcuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710601018; c=relaxed/simple;
	bh=aR8hRTDJ4hTgIYaydeSVXJDQzHAYa1X6w7iYETfJq50=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxhxxImmZnmQ/4mT4K6zAHpov7KalwyXfg7aImqIJDTcYg5dM7JffN3HyU5xydKJG9WWhyLXBRomApe92oL993tCsVLUXy/mOMs/kmcg3I2vT4tYegWw3EUr0X1/IDXYU7artgzjqkrsUiTaXlhjHVaQ1ZFGDc0K4aaRPKFRgMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=m/VKuASJ; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1710601009; x=1710860209;
	bh=aR8hRTDJ4hTgIYaydeSVXJDQzHAYa1X6w7iYETfJq50=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=m/VKuASJXwwnVqQACEPvl18cZBFzaSKlB7sM8uH/j5gY4nw5E9hGRK+T0vKQfpu3G
	 6VOvMXwJWTXqW4CamNaSMUey+ourE9ltMlhWEPG1RJSGsAKb9Gyr99Op0/3hW6gTpq
	 C+GnYPz6qtNtXRH6k7E/C9oINuE0zroL3rHy7zK9SqHnOlPdFkIU+X38coCCzs1kmr
	 W0PzA4yIDnvXmq+RgatQ+oykFs+gLlUYE4HAMP+1HEYkjC9SiGFjEGuDXgo3uy7jAc
	 rhR9TyuaUdhtN9Lvu+k/wehKRFRBJ9lX9oeh7RuzM2q7rJA3YwfGjhvvi2gA9z1mWf
	 hziN79QEGz18A==
Date: Sat, 16 Mar 2024 14:56:20 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 3/4] rust: uaccess: add typed accessors for userspace pointers
Message-ID: <d4c6376c-5545-4aba-bd8e-39c7c9a8127d@proton.me>
In-Reply-To: <20240311-alice-mm-v3-3-cdf7b3a2049c@google.com>
References: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com> <20240311-alice-mm-v3-3-cdf7b3a2049c@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/11/24 11:47, Alice Ryhl wrote:
> Add safe methods for reading and writing Rust values to and from
> userspace pointers.
>=20
> The C methods for copying to/from userspace use a function called
> `check_object_size` to verify that the kernel pointer is not dangling.
> However, this check is skipped when the length is a compile-time
> constant, with the assumption that such cases trivially have a correct
> kernel pointer.
>=20
> In this patch, we apply the same optimization to the typed accessors.
> For both methods, the size of the operation is known at compile time to
> be size_of of the type being read or written. Since the C side doesn't
> provide a variant that skips only this check, we create custom helpers
> for this purpose.
>=20
> The majority of reads and writes to userspace pointers in the Rust
> Binder driver uses these accessor methods. Benchmarking has found that
> skipping the `check_object_size` check makes a big difference for the
> cases being skipped here. (And that the check doesn't make a difference
> for the cases that use the raw read/write methods.)
>=20
> This code is based on something that was originally written by Wedson on
> the old rust branch. It was modified by Alice to skip the
> `check_object_size` check, and to update various comments, including the
> notes about kernel pointers in `WritableToBytes`.
>=20
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>


