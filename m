Return-Path: <linux-kernel+bounces-148784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5644C8A8762
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0421F225E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEFD146D6D;
	Wed, 17 Apr 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hmZWA4cy"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905D146D54
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367253; cv=none; b=tsjY66qnb8vJZc4ZqHgOpSK9pQ1otOdiQLJ6j6d9x+1cMDhlzY6VVC0Ezzg5f9+g8DyymPucPHviFRE2JN0M+A05czzvxcZ1MPGQNv+GcKsiHPViIiBmwK9E7/IxhcRSAGc6QJmPHDA6GkggJUcRH1OllIesGN6jYMlnml+XWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367253; c=relaxed/simple;
	bh=UPBih86VwhYA999zRYFTWuXSTMQT7D7fNy+bP56pCiA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6iT/uNkCmpwdsc3fXci49SHeYBOoCKOaQWXb6o4AQ2RFZo7/E7wS8s+v+W2qDaw6SN853gaeCsNuDgO9aRXc4t5530fgVZ7V7W0SNq48rH7C2rmJ+tjl2IdHHf1TmcshHC78z/TmjdVj9Xwwk2GyBCz26nIYELZnq6hknOuwls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hmZWA4cy; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1713367248; x=1713626448;
	bh=YWyxuaF5Ni3EMSqmk2O91LAhe4Gw3wdUrmkeI2YFMFo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hmZWA4cy+e2OIIPIyuSEmU3oRMgzgatK5jfeklNaNCTWZ4Cuh2lDy2gxdszV2K+hQ
	 gCCil2rQq9I6zl/M/J6NRT8GcUd+IZS0bIAgVCKnYUD5O0UHMpkYVIcZULKJc5e9Oq
	 LkylIL2rKrnN6sLH9q6DW42YajeJU62UBzfUyt/VGgFktfGVcPipH3ASrFQfHrt52a
	 KjUR/o9Y01NDsYemSrBdpiRmESEKiTNDcDXhR4J0wS6VcBmtgNBhcjgb0VaIVhopg3
	 SoUwNym0BkUtmIWxhjwKm2TdOTB4mafz2MYC5NVAUsP/eVTvQA6O2IzrdD85FdsExt
	 lkzUynDPJc1Zw==
Date: Wed, 17 Apr 2024 15:20:37 +0000
To: Gary Guo <gary@garyguo.net>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: init: change the generated name of guard variables
Message-ID: <bb23edeb-7a0b-4bb7-8df7-92b2c9701ec6@proton.me>
In-Reply-To: <20240417160636.0e649b68@eugeo>
References: <20240403194321.88716-1-benno.lossin@proton.me> <Zg3IHZfYVEOh7nc4@boqun-archlinux> <ef1400ae-ba9e-4656-98db-a882ac720c1e@proton.me> <20240417160636.0e649b68@eugeo>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.04.24 17:06, Gary Guo wrote:
> On Wed, 03 Apr 2024 22:09:49 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> On 03.04.24 23:20, Boqun Feng wrote:
>>> On Wed, Apr 03, 2024 at 07:43:37PM +0000, Benno Lossin wrote:
>>>> The initializers created by the `[try_][pin_]init!` macros utilize the
>>>> guard pattern to drop already initialized fields, when initialization
>>>> fails mid-way. These guards are generated to have the same name as the
>>>> field that they handle. To prevent namespacing issues when the field
>>>
>>> Do you have an example of this kind of issues?
>>
>> https://lore.kernel.org/rust-for-linux/1e8a2a1f-abbf-44ba-8344-705a9cbb1=
627@proton.me/
>>
>=20
> Here's the simplified example:
>=20
> ```
> macro_rules! f {
>      () =3D> {
>          let a =3D 1;
>          let _: u32 =3D a;
>      }
> }
>=20
> const a: u64 =3D 1;
>=20
> fn main() {
>      f!();
> }
> ```
>=20
> The `a` in `f` have a different hygiene so normally it is scoped to the
> macro expansion and wouldn't escape. Interestingly a constant is still
> preferred despite the hygiene so constants escaped into the macro,
> leading to the error.
>=20
> Would your change regress error message when `pin_init!` is used
> wrongly? Personally I would say this kind of error is niche enough
> (given the casing of constants and variables differ) that we probably
> don't really need to care. So if error message would be affected then
> we'd better off not making the change.

For all the tested error messages (see [1]) there is absolutely no
difference in the diagnostic.

[1]: https://github.com/Rust-for-Linux/pinned-init/tree/main/tests/ui/compi=
le-fail

--=20
Cheers,
Benno


