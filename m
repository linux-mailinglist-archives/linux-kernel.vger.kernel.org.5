Return-Path: <linux-kernel+bounces-105201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306AC87DA72
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190821C20D4B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824151BC20;
	Sat, 16 Mar 2024 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CM93QCfd"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12B81AAC4
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710598596; cv=none; b=qi2M6+vW2UMpYyx5lzn6yPoEiH1fTRf98OrGL52gMUjPClOj3KjCpKMTl/I2r6YLlSjCKZuHqVBu47G/6eHIJttqzcIJC12TYq41wfR7/DPfQkpGLBd5ua8PNnf9hun6HJWCjXwX6jAOoMSCJJMd7MRAKEFptsECGRbvWkcmJ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710598596; c=relaxed/simple;
	bh=mJ30TjJevPsvaLmDSaXPLq8e51apoHgFwkUiNnGZb2Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qb5IeLYVb7qmDHFuVWWaViZFdQO0ae9lNXMAseXIl6+5XSIAMfZf+3RaHdUqsVN1OhLWOqQaT1Pa5FXBaydOsJzZcI1F4r3X/pF4l44rldFGJGTVzIFPh4AiomEAY+KX+iyAnXOpGhdg1zPvcpeR12RzzWDhaSoGJVshB3tXI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CM93QCfd; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1710598585; x=1710857785;
	bh=mJ30TjJevPsvaLmDSaXPLq8e51apoHgFwkUiNnGZb2Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CM93QCfdmepzajlDwRdrBx35pjQDO5CM1XRroIcXqUBwtmz9WPbXz8w/K/x+D8lfn
	 WtoOEiqfLKXaOs9MFX+bVheTQwKuGb0Il/Q0LY1YWRel7Yc2NO63qLGAb9lR6RXpZT
	 b9z34hxT8eX/PyWyB2U6oM2WXXz/6kRD+3+YJB2+ec7qsQ6hCo0IOqkLaDdp3d6p5f
	 RbZtqDvMGwAQLl3FLLY/ECx3Bf6K2f5zd5JvGItQv/eoAYENSy6P0pg2aH0921dlua
	 iKvrCCLMR4P9xUubQ/DON9Gn+QWn2XWDV/lMj8SKLbw5Ribfd1XKmsTtLA1fQTW88L
	 xNgmEBXzNgPHw==
Date: Sat, 16 Mar 2024 14:16:11 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 1/4] rust: uaccess: add userspace pointers
Message-ID: <a0605a13-a738-4c2a-8eaf-2c4f2f17dacd@proton.me>
In-Reply-To: <20240311-alice-mm-v3-1-cdf7b3a2049c@google.com>
References: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com> <20240311-alice-mm-v3-1-cdf7b3a2049c@google.com>
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
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>=20
> A pointer to an area in userspace memory, which can be either read-only
> or read-write.
>=20
> All methods on this struct are safe: invalid pointers return `EFAULT`.
> Concurrent access, *including data races to/from userspace memory*, is
> permitted, because fundamentally another userspace thread/process could
> always be modifying memory at the same time (in the same way that
> userspace Rust's `std::io` permits data races with the contents of
> files on disk). In the presence of a race, the exact byte values
> read/written are unspecified but the operation is well-defined.
> Kernelspace code should validate its copy of data after completing a
> read, and not expect that multiple reads of the same address will return
> the same value.
>=20
> These APIs are designed to make it difficult to accidentally write
> TOCTOU bugs. Every time you read from a memory location, the pointer is
> advanced by the length so that you cannot use that reader to read the
> same memory location twice. Preventing double-fetches avoids TOCTOU
> bugs. This is accomplished by taking `self` by value to prevent
> obtaining multiple readers on a given `UserSlicePtr`, and the readers
> only permitting forward reads. If double-fetching a memory location is
> necessary for some reason, then that is done by creating multiple
> readers to the same memory location.
>=20
> Constructing a `UserSlicePtr` performs no checks on the provided
> address and length, it can safely be constructed inside a kernel thread
> with no current userspace process. Reads and writes wrap the kernel APIs
> `copy_from_user` and `copy_to_user`, which check the memory map of the
> current process and enforce that the address range is within the user
> range (no additional calls to `access_ok` are needed).
>=20
> This code is based on something that was originally written by Wedson on
> the old rust branch. It was modified by Alice by removing the
> `IoBufferReader` and `IoBufferWriter` traits, and various other changes.
>=20
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>


