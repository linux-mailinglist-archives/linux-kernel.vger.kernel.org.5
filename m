Return-Path: <linux-kernel+bounces-127273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9808C89490F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C956B1C21E41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0074DF42;
	Tue,  2 Apr 2024 01:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="LgB4cNhQ"
Received: from mr85p00im-zteg06022001.me.com (mr85p00im-zteg06022001.me.com [17.58.23.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3133DDBE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712023012; cv=none; b=YqzJr2q2iJwC4gYu51s4mAoT1sSkhLOdwzKm4g27MZCdQMC+YT3iNgUXI5fhtW9e6sANUqfXthWFuvrBBLPz2xk9pOIt7fYvyw0EPdVxMaMC3IeDcygfWbWuzX/OFY5CPuYc7ex7VfcTMUWlyzD93zdSQlBBZ+piwwNhuANn7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712023012; c=relaxed/simple;
	bh=SLxVoKQ8W/CIb7gSAjcDevngby0P9BhE8XGKgfK59PE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NphFh07E1kQ7TR3hWx7HzQqNUXZZCf+Dnw4MS352WyPMkYuCQiemSOjBBCIkOyyr3tG6TNSLnCrzGJVtcLrgMa9lwpAuqRugkO6NOVvIC9/z2gWdXi6jmoFBmKC2Pv9KBVBVaQcPuqYCnC7Xl5mdUL3KrntwZ5y8rNUo/7e9ZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=LgB4cNhQ; arc=none smtp.client-ip=17.58.23.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1712023010; bh=Njez89+Ibcju87zrE0tWsNjYC0NXQyyQ7jWSyc2vYyw=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=LgB4cNhQwJ4H2FQY/dnsVuB4jew1MYoYHcYCvpYjJbXn3TCct6O1YBxdqSaF3MJsJ
	 urZqQdYl/l9/fR60rqmwxnbW0H/8jVRhFto/MSP6E52Z20PSS6uIgrnQ29ZT2Mm+10
	 Pk1D2fHEYZUuqOm/OHpOnBCBrs/aTCvtb5+LY9+Rub/d2esc4GK0PqdS3Ev6KqrIoi
	 Vvl3tdVlTBICwiSunfm3sojIokQt3E7BlrkiNjbvyzb7rpD9Wd86k/xeMvkS80ZiEC
	 xeCqQcSpc6KJ7sdizOVv6N2wZk4+/gCCgR5M7KJmF+crZzekQvLZzg8cT1xMPjJ+zX
	 Xg44k5p1Lc+AA==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06022001.me.com (Postfix) with ESMTPSA id 2C7B480048F;
	Tue,  2 Apr 2024 01:56:47 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v2] rust: init: remove impl Zeroable for Infallible
From: Laine Taffin Altman <alexanderaltman@me.com>
In-Reply-To: <9D0C95D2-6239-4A3B-B9DD-66299B9911EF@me.com>
Date: Mon, 1 Apr 2024 18:56:23 -0700
Cc: stable@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <08AD88C6-0054-4DF9-96BE-8213655FAAB1@me.com>
References: <9D0C95D2-6239-4A3B-B9DD-66299B9911EF@me.com>
To: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-Proofpoint-GUID: QsK0E2W6x8tIV-NiESJZIoD1xdU1U2d4
X-Proofpoint-ORIG-GUID: QsK0E2W6x8tIV-NiESJZIoD1xdU1U2d4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_18,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2404020013

Oops!  Formatting issue; ignore this one.

Thanks,
Laine

> On Apr 1, 2024, at 6:53=E2=80=AFPM, Laine Taffin Altman =
<alexanderaltman@me.com> wrote:
>=20
> A type is inhabited if at least one valid value of that type exists; a =
type is uninhabited if no valid values of that type exist.  The terms =
"inhabited" and "uninhabited" in this sense originate in type theory, a =
branch of mathematics.
>=20
> In Rust, producing an invalid value of any type is immediate undefined =
behavior (UB); this includes via zeroing memory.  Therefore, since an =
uninhabited type has no valid values, producing any values at all for it =
is UB.
>=20
> The Rust standard library type `core::convert::Infallible` is =
uninhabited, by virtue of having been declared as an enum with no cases, =
which always produces uninhabited types in Rust.
>=20
> The current kernel code allows this UB to be triggered, for example by =
code like:
> `pr_info!("{}=E2=80=9D, =
Box::<core::convert::Infallible>::init(kernel::init::zeroed())?);`
>=20
> Thus, remove the implementation of `Zeroable` for `Infallible`, =
thereby avoiding the UB.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and =
`init::zeroed` function")
> Closes: https://github.com/Rust-for-Linux/pinned-init/pull/13
> Signed-off-by: Laine Taffin Altman <alexanderaltman@me.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> =E2=80=94
> V1 -> V2: Added more documentation to the comment, with links; also =
added more details to the commit message.
>=20
> rust/kernel/init.rs | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 424257284d16..9353c9919fd4 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -1292,8 +1292,11 @@ macro_rules! impl_zeroable {
>     i8, i16, i32, i64, i128, isize,
>     f32, f64,
>=20
> -    // SAFETY: These are ZSTs, there is nothing to zero.
> -    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, =
Infallible, (),
> +    // SAFETY: These are inhabited ZSTs; there is nothing to zero and =
a valid value exists.
> +    // Note: do not add uninhabited types (such as ! or Infallible) =
to this list; creating an instance of an uninhabited type is immediate =
undefined behavior.
> +    // For more on uninhabited/empty types, consult The Rustonomicon: =
https://doc.rust-lang.org/stable/nomicon/exotic-sizes.html#empty-types
> +    // The Rust Reference also has information on undefined behavior: =
https://doc.rust-lang.org/stable/reference/behavior-considered-undefined.h=
tml
> +    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, (),
>=20
>     // SAFETY: Type is allowed to take any value, including all zeros.
>     {<T>} MaybeUninit<T>,
> --=20
> 2.44.0


