Return-Path: <linux-kernel+bounces-150476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1E48A9FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C06B284B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F40816FF22;
	Thu, 18 Apr 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bqcMauNu"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4916F29F;
	Thu, 18 Apr 2024 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457403; cv=none; b=CT/5/K73rJgoss6o7euXV/asJj9YXNS496Jj6gLZk5mNQyIH3cDJws5WeSb/4umV/qSpY6h9IZ3czMwis7uf54a2sPBifqTTF3TcbDrCjldxlKUOnjGVJHzfBJnQqDT6FMZE47sVzhwqtn+2JDQqJCl2aKU+w4fXu3Pu54zASMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457403; c=relaxed/simple;
	bh=EoyUGkSRon5me4u477D3F6b2mgkPBf5LCRtyQDMlmIo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtG5GLd9c85+pk/DOjoTrCrw/cW0R22zbvUvqjYqwHjk5wHaMCbMwpqWug86Vw3Gx5Cx2qS38OfR4TQ4VoEC/yiOVsRC66hZV5n08o5SoFeGR+kH2csrV70RLzfzDj7LqEc3e0sqLywaAzep7Sjz7OqbQqKBruutPG/RW9iQJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bqcMauNu; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1713457398; x=1713716598;
	bh=joJLcNdcZBVDplNSaumr4msMoffl415nR/qqHXU34iE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bqcMauNuZz2HzbaAiPbBPEPe4i/D7cTybrt1CNaNuIfE4VMoISgGD0od7h/PLWCep
	 dif+yNtBkoNbt58LRaHswSQCQSd8Hg8E9HSgn52zZZX6BwgSTv7BKyjxsVR8NnOX3C
	 50Jrwfty4DDf5Xf6EiQ07oytt0Ecsy3hkV59MCXtsXUaK68AI7+UL5OVNqTcsoRTF2
	 V5w6uajW1okZXbW+p3N729V965XZmuWojRNfnBylzDza7Wm85xjWqQc6NODpEsIM8i
	 TvP3J/gdXaAV1735aps+DmE/J2b1zFTMMuiJXg/+VC08PV46fI2SsvSEZbC6PgBXc6
	 Se9AlUa2KZoAA==
Date: Thu, 18 Apr 2024 16:23:06 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 3/4] rust: uaccess: add typed accessors for userspace pointers
Message-ID: <c6239407-8410-49e2-a8a1-16be8468ab88@proton.me>
In-Reply-To: <CAH5fLgiMLxmmm0AVX_5HQF61FzzN69GCKabrr-uM_oV-rRMuHw@mail.gmail.com>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com> <20240418-alice-mm-v6-3-cb8f3e5d688f@google.com> <5fd684d8-d46d-4009-bcf8-134dab342322@proton.me> <CAH5fLgiMLxmmm0AVX_5HQF61FzzN69GCKabrr-uM_oV-rRMuHw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e9cdc856a7738c0450991f733d19c0c90cba2cad
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.04.24 15:17, Alice Ryhl wrote:
> On Thu, Apr 18, 2024 at 3:02=E2=80=AFPM Benno Lossin <benno.lossin@proton=
me> wrote:
>>
>> On 18.04.24 10:59, Alice Ryhl wrote:
>>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>> index 8fad61268465..9c57c6c75553 100644
>>> --- a/rust/kernel/types.rs
>>> +++ b/rust/kernel/types.rs
>>> @@ -409,3 +409,67 @@ pub enum Either<L, R> {
>>>       /// Constructs an instance of [`Either`] containing a value of ty=
pe `R`.
>>>       Right(R),
>>>   }
>>> +
>>> +/// Types for which any bit pattern is valid.
>>> +///
>>> +/// Not all types are valid for all values. For example, a `bool` must=
 be either zero or one, so
>>> +/// reading arbitrary bytes into something that contains a `bool` is n=
ot okay.
>>> +///
>>> +/// It's okay for the type to have padding, as initializing those byte=
s has no effect.
>>> +///
>>> +/// # Safety
>>> +///
>>> +/// All bit-patterns must be valid for this type. This type must not h=
ave interior mutability.
>>
>> What is the reason for disallowing interior mutability here? I agree
>> that it is necessary for `AsBytes`, but I don't think we need it here.
>> For example it is fine to convert `u8` to `UnsafeCell<u8>`. Niches also
>> should not be a problem, since eg `Option<UnsafeCell<NonNull<u8>>>`
>> already fails the "All bit-patterns must be valid for this type".
>=20
> If T: FromBytes allows transmuting &[u8; size_of::<T>] into &T, then
> it would be a problem as you could then use it to modify the original
> &[u8].

Ahh that makes a lot of sense.

--=20
Cheers,
Benno



