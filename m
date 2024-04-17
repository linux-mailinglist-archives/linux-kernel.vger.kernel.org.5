Return-Path: <linux-kernel+bounces-148798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809EA8A878E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A91B2219A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32401482F5;
	Wed, 17 Apr 2024 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SEuodbfR"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C01474C7;
	Wed, 17 Apr 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367636; cv=none; b=UyyZ7elctML+giJgWeYxgelJ6DQhC7Yag1eDn2YqMZ7gw6bc57aU8UyUmDtaLy1Y1d7n7m1a8MxK9KbNC/JCOg0fzD64y1tW3ztZMRiF75wuY+ksd3qdaf0Przr0awuipsOgLdI/sMNk1kiAVtdj9hRvcjWAc6LlEBXoK0uSrUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367636; c=relaxed/simple;
	bh=9HPTSvA9Vl4MuqVnZmDO/gJ2gS6Uz84Qlx8Z9fvRJU4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czPVvzGb05XZPfJNS08fkVTf0CETc1SuPAJaoUjozWugQrtl7BifTueP0yoOBqw+3GgtAJm5SKhoaf0MZWRejIzVgDwNTxiVCxrmzBD4Up30zxrCsVKl1M5HBbcwqujs+V0h8E+NhlQut23r6pZsFQKj5ClqUBTAz01U6brmbr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SEuodbfR; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1713367632; x=1713626832;
	bh=yE1RsTT/3QhtCokhgtHPH8FIR5On7XGmjEDodbAFAQI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SEuodbfR8tDN1iztrdISMh608nxV7gNjcXC3IkbviYQDqAG/K7kbEYXVYFyVpsZED
	 oTSH49hr/DqRrbM+whOMt8FqBzDbVrhicQLAQ7v3k5ZBc99gTS4EaNQRkemL8/nsRD
	 eEM1WDBbocmVXAvCYGqjAZe4/gqJx0o9XcUfkwS7MqgRJsfb9iO1HHCZjR0/OBu422
	 vTFuAD3XuK/TnkqCwLlu0OUdK/QlEdYjy3hWUjgH27rf87Ma10qYMRAaW9TXb5QzZ5
	 CN3DYniWeLD6vNaOPDLllM7o6ZmTPkA2rfgRtGipuPZkhwu/sF/4qlg6Phoqn4Jv2y
	 Aaw9y+q8TerZg==
Date: Wed, 17 Apr 2024 15:27:02 +0000
To: Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 1/4] rust: uaccess: add userspace pointers
Message-ID: <b7305f21-3e0b-4bfe-8902-5fc9367c2291@proton.me>
In-Reply-To: <CAH5fLgjcO0mrQ=X2QG1qS+sTpWDnBfGxXGWn-3wBQzn3MP8pQQ@mail.gmail.com>
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com> <20240415-alice-mm-v5-1-6f55e4d8ef51@google.com> <20240417152802.6b7a7384@eugeo> <CAH5fLgjcO0mrQ=X2QG1qS+sTpWDnBfGxXGWn-3wBQzn3MP8pQQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.04.24 16:40, Alice Ryhl wrote:
> On Wed, Apr 17, 2024 at 4:28=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
>>
>> On Mon, 15 Apr 2024 07:13:53 +0000
>> Alice Ryhl <aliceryhl@google.com> wrote:
>>
>>> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>>>
>>> A pointer to an area in userspace memory, which can be either read-only
>>> or read-write.
>>>
>>> All methods on this struct are safe: attempting to read or write on bad
>>> addresses (either out of the bound of the slice or unmapped addresses)
>>> will return `EFAULT`. Concurrent access, *including data races to/from
>>> userspace memory*, is permitted, because fundamentally another userspac=
e
>>> thread/process could always be modifying memory at the same time (in th=
e
>>> same way that userspace Rust's `std::io` permits data races with the
>>> contents of files on disk). In the presence of a race, the exact byte
>>> values read/written are unspecified but the operation is well-defined.
>>> Kernelspace code should validate its copy of data after completing a
>>> read, and not expect that multiple reads of the same address will retur=
n
>>> the same value.
>>>
>>> These APIs are designed to make it difficult to accidentally write
>>> TOCTOU bugs. Every time you read from a memory location, the pointer is
>>> advanced by the length so that you cannot use that reader to read the
>>> same memory location twice. Preventing double-fetches avoids TOCTOU
>>> bugs. This is accomplished by taking `self` by value to prevent
>>> obtaining multiple readers on a given `UserSlicePtr`, and the readers
>>> only permitting forward reads. If double-fetching a memory location is
>>> necessary for some reason, then that is done by creating multiple
>>> readers to the same memory location.
>>>
>>> Constructing a `UserSlicePtr` performs no checks on the provided
>>> address and length, it can safely be constructed inside a kernel thread
>>> with no current userspace process. Reads and writes wrap the kernel API=
s
>>> `copy_from_user` and `copy_to_user`, which check the memory map of the
>>> current process and enforce that the address range is within the user
>>> range (no additional calls to `access_ok` are needed).
>>>
>>> This code is based on something that was originally written by Wedson o=
n
>>> the old rust branch. It was modified by Alice by removing the
>>> `IoBufferReader` and `IoBufferWriter` traits, and various other changes=
.
>>>
>>> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
>>> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>> ---
>>>   rust/helpers.c         |  14 +++
>>>   rust/kernel/lib.rs     |   1 +
>>>   rust/kernel/uaccess.rs | 304 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>>   3 files changed, 319 insertions(+)
>>>
>>> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
>>
>>> +/// [`std::io`]: https://doc.rust-lang.org/std/io/index.html
>>> +/// [`clone_reader`]: UserSliceReader::clone_reader
>>> +pub struct UserSlice {
>>> +    ptr: *mut c_void,
>>> +    length: usize,
>>> +}
>>
>> How useful is the `c_void` in the struct and new signature? They tend
>> to not be very useful in Rust. Given that provenance doesn't matter
>> for userspace pointers, could this be `usize` simply?
>>
>> I think `*mut u8` or `*mut ()` makes more sense than `*mut c_void` for
>> Rust code even if we don't want to use `usize`.
>=20
> I don't have a strong opinion here. I suppose a usize could make
> sense. But I also think c_void is fine, and I lean towards not
> changing it. :)
>=20
>> Some thinking aloud and brainstorming bits about the API.
>>
>> I wonder if it make sense to have `User<[u8]>` instead of `UserSlice`?
>> The `User` type can be defined like this:
>>
>> ```rust
>> struct User<T: ?Sized> {
>>     ptr: *mut T,
>> }
>> ```
>>
>> and this allows arbitrary T as long as it's POD. So we could have
>> `User<[u8]>`, `User<u32>`, `User<PodStruct>`. I imagine the
>> `User<[u8]>` would be the general usage and the latter ones can be
>> especially helpful if you are trying to implement ioctl and need to
>> copy fixed size data structs from userspace.
>=20
> Hmm, we have to be careful here. Generally, when you get a user slice
> via an ioctl, you should make sure to use the length you get from
> userspace. In binder, it looks like this:
>=20
> let user_slice =3D UserSlice::new(arg, _IOC_SIZE(cmd));
>=20
> so whichever API we use, we must make sure to get the length as an
> argument in bytes. What should we do if the length is not a multiple
> of size_of(T)?

We could print a warning and then just floor to the next multiple of
`size_of::<T>()`. I agree that is not perfect, but if one uses the
current API, one also needs to do the length check eventually.

> Another issue is that there's no stable way to get the length from a
> `*mut [T]` without creating a reference, which is not okay for a user
> slice.

Seems like `<* const [T]>::len` (feature `slice_ptr_len`) [1] was just
stabilized 5 days ago [1].

[1]: https://doc.rust-lang.org/std/primitive.pointer.html#method.len-1
[2]: https://github.com/rust-lang/rust/pull/123868

--=20
Cheers,
Benno


