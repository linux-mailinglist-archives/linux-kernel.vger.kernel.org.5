Return-Path: <linux-kernel+bounces-107009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B103887F6AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20A81C21832
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80E3446A5;
	Tue, 19 Mar 2024 05:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="k4dXykRg"
Received: from ms11p00im-qufo17281301.me.com (ms11p00im-qufo17281301.me.com [17.58.38.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF042062
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710826133; cv=none; b=VD6wLun5tZqnoLGN726PRjPER3pQWTk17b9pqcFXN0bdIWmKoPyb5KNzwxsiXXNYkKP7XxRaKe80zpvtXT/tUmWYK5/4OGxiL11AaOwh6vZovbdU+NxlZOPhXqB3MU6bjtrAd5LL1g8JbnBgapXqzgia06bRwzyYoMZiTIdCZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710826133; c=relaxed/simple;
	bh=GQ69sst6KtWZRI9xIfR8OlxbHRzyV2W310g5+1K6fxg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W4Sj3SibBOTbAoUCaUVYlmbZE2n2FhlhvCU65RYmS9OQ7JfYmAowhT8ctrTaEmtyKab2d/3YIS6xF2RooaduPhjg+lNSjMJkj0T/M1bTC3JAvjGsdvt09GyXpQ42EfhAwGU8ABMrvpned9BwGgnBo+J5zII4tWHiOXv4Zvh28hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=k4dXykRg; arc=none smtp.client-ip=17.58.38.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1710826129; bh=jtDAYiiHKEo7z1XIeH+DbE76nJx6PwjxTaWNlxP+9zo=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=k4dXykRgixbyPj5jQHYrHy0Oyj/E+OVV9OpR33I95R43Jtb7zwE4xphgzFNEN5rLK
	 3ZmtWQUzHd6vCOcWexL+Wos3ZV3RzRb4c0OGzuMsY7epNElCLfcCvByXuzDA6zuxZd
	 5MAIRcEDa5u9KE7abEPH7EQA1L9pgvZcInSf1N6S8mFwEz75HkqEO/c/E+jSODuO1p
	 pJSgRWIwzZgWFnHjrFrCFN7A9+tYWtksglCjzHi70XNls9c3uwQ4b25R50hn/lA3dc
	 hP8SkSOr3AmOWaFNXf8mSC6XR18CH6G7BYnQjEcmjPgEPEfy5cUuofm6+QHw6L2C4x
	 eIoCmvXuAuhvQ==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17281301.me.com (Postfix) with ESMTPSA id D0D40CC0180;
	Tue, 19 Mar 2024 05:28:47 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] rust: init: remove impl Zeroable for Infallible
From: Laine Taffin Altman <alexanderaltman@me.com>
In-Reply-To: <ZfkW8rwpdRc_hJBU@Boquns-Mac-mini.home>
Date: Mon, 18 Mar 2024 22:28:35 -0700
Cc: Benno Lossin <benno.lossin@proton.me>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 stable@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3FBC841A-968E-4AC5-83F0-E906C7EE85C3@me.com>
References: <20240313230713.987124-1-benno.lossin@proton.me>
 <Zfh5DYkxNAm-mY_9@boqun-archlinux>
 <93FD9491-7E2D-4324-8443-0884B7CFC6EF@me.com>
 <ZfkW8rwpdRc_hJBU@Boquns-Mac-mini.home>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-Proofpoint-GUID: JV1TEgZWRV4Q51EWUDIrXol7s29j4YsT
X-Proofpoint-ORIG-GUID: JV1TEgZWRV4Q51EWUDIrXol7s29j4YsT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2403190041

On Mar 18, 2024, at 9:39=E2=80=AFPM, Boqun Feng <boqun.feng@gmail.com> =
wrote:
> On Mon, Mar 18, 2024 at 08:17:07PM -0700, Laine Taffin Altman wrote:
>> On Mar 18, 2024, at 10:25=E2=80=AFAM, Boqun Feng =
<boqun.feng@gmail.com> wrote:
>>> On Wed, Mar 13, 2024 at 11:09:37PM +0000, Benno Lossin wrote:
>>>> From: Laine Taffin Altman <alexanderaltman@me.com>
>>>>=20
>>>> It is not enough for a type to be a ZST to guarantee that zeroed =
memory
>>>> is a valid value for it; it must also be inhabited. Creating a =
value of
>>>> an uninhabited type, ZST or no, is immediate UB.
>>>> Thus remove the implementation of `Zeroable` for `Infallible`, =
since
>>>> that type is not inhabited.
>>>>=20
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and =
`init::zeroed` function")
>>>> Closes: https://github.com/Rust-for-Linux/pinned-init/pull/13
>>>> Signed-off-by: Laine Taffin Altman <alexanderaltman@me.com>
>>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>>=20
>>> I think either in the commit log or in the code comment, there =
better be
>>> a link or explanation on "(un)inhabited type". The rest looks good =
to
>>> me.
>>=20
>> Would the following be okay for that purpose?
>>=20
>> A type is inhabited if at least one valid value of that type exists; =
a
>> type is uninhabited if no valid values of that type exist.  The terms
>> "inhabited" and "uninhabited" in this sense originate in type theory,
>> a branch of mathematics.
>>=20
>> In Rust, producing an invalid value of any type is immediate =
undefined
>> behavior (UB); this includes via zeroing memory.  Therefore, since an
>> uninhabited type has no valid values, producing any values at all for
>> it is UB.
>>=20
>> The Rust standard library type `core::convert::Infallible` is
>> uninhabited, by virtue of having been declared as an enum with no
>> cases, which always produces uninhabited types in Rust.  Thus, remove
>> the implementation of `Zeroable` for `Infallible`, thereby avoiding
>> the UB.
>>=20
>=20
> Yeah, this works for me. Thanks!

Great!  Should it be re-sent or can the new wording be incorporated upon =
merge?

Thank,
Laine

>=20
> Regards,
> Boqun
>=20
>> Thanks,
>> Laine
>>=20
>>>=20
>>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>>>=20
>>> Regards,
>>> Boqun
>>>=20
>>>> ---
>>>> rust/kernel/init.rs | 4 ++--
>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
>>>> index 424257284d16..538e03cfc84a 100644
>>>> --- a/rust/kernel/init.rs
>>>> +++ b/rust/kernel/init.rs
>>>> @@ -1292,8 +1292,8 @@ macro_rules! impl_zeroable {
>>>>    i8, i16, i32, i64, i128, isize,
>>>>    f32, f64,
>>>>=20
>>>> -    // SAFETY: These are ZSTs, there is nothing to zero.
>>>> -    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, =
Infallible, (),
>>>> +    // SAFETY: These are inhabited ZSTs, there is nothing to zero =
and a valid value exists.
>>>> +    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, (),
>>>>=20
>>>>    // SAFETY: Type is allowed to take any value, including all =
zeros.
>>>>    {<T>} MaybeUninit<T>,
>>>>=20
>>>> base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
>>>> --=20
>>>> 2.42.0
>>>>=20
>>>>=20
>>>>=20
>>=20


