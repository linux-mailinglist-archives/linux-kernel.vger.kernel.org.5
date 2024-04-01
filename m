Return-Path: <linux-kernel+bounces-127118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12487894726
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F9C1C219A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C6856440;
	Mon,  1 Apr 2024 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="M7YwW7N2"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826DB53814;
	Mon,  1 Apr 2024 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008905; cv=none; b=SOlbILNcCq2KoA3bOhVodJ67+RevGaXJjF61gjHAupte/cFGtdOQ6pRAngyL0hYhaqPSzdh/8p7Hll1Su+o4mWVKMN5QqUO3lRcSyZ0JhRKEXjoG28bPGqUSZA4SAl/ZTgmHSw8Ybk+xLQ91ucdoqMJ3MntUa8MiCvDi9wZkaRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008905; c=relaxed/simple;
	bh=8vXG12fvbvKQwoT6Od/Q4JR+28AixGCeVdIJLD1KP1w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnWBz9InjrAqKKuzER46085Jofh7fgDLUaIximNCtw6S4di/W2soflUtCOpP9ooHhlX+cXiEtQeN/KLYCPJ4SCpHpQ0DO+dYSsXSrsFfFuub3ZTqMh91jj0nQhmWL4Sx5iLYSwrp4CIQfGg79CsyEgOwcX7hwoSzOB7NtXyRbMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=M7YwW7N2; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712008900; x=1712268100;
	bh=fCpVJzb7a5fIyG0vdKN2cT5x5fpMk91PsLEh8JmpbLk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=M7YwW7N28CQzWE9px+Kgd3YIaME7NuyGoF1F8TB02+f1Af+USlw6cSS05RpVDQkj6
	 s4J2RyFiB+pT0oxidrm/nWU86iAdpH29HpIh2zI2ope2A8YzoO0dKn/bYKQsRtgv/b
	 PgNHc6yUa8p5Jv5lSEZSZDU+X/qePqd29rUzD6GUagvfuDjit/hyU+ykRTxyCiKNzv
	 02d2xc95SJaWdINMESiQr0OVUKa7U1sPwz15W2yKbkZFY2E+K8Oxnc8I1O5CMTlIxU
	 nm2nOCHIBulBZfe5V4RF2AZPnKXA7yjvG+GJls8txJZKqCB9YHNlgBQgNPsGoZoe/9
	 eGwde2q/a/7Fg==
Date: Mon, 01 Apr 2024 22:01:34 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, Sumera Priyadarsini <sylphrenadin@gmail.com>, Neal Gompa <neal@gompa.dev>, Thomas Bertschinger <tahbertschinger@gmail.com>, Andrea Righi <andrea.righi@canonical.com>, Matthew Bakhtiari <dev@mtbk.me>, Adam Bratschi-Kaye <ark.email@gmail.com>, stable@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, Wedson Almeida Filho <wedsonaf@google.com>, Finn Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: macros: fix soundness issue in `module!` macro
Message-ID: <20fcbbd0-4a7a-49b1-a383-f8b388153066@proton.me>
In-Reply-To: <Zgsiumknfshjbi9J@boqun-archlinux>
References: <20240401185222.12015-1-benno.lossin@proton.me> <Zgsiumknfshjbi9J@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.04.24 23:10, Boqun Feng wrote:
> On Mon, Apr 01, 2024 at 06:52:50PM +0000, Benno Lossin wrote:
> [...]
>> +            // Double nested modules, since then nobody can access the =
public items inside.
>> +            mod __module_init {{
>> +                mod __module_init {{
>> +                    use super::super::{type_};
>> +
>> +                    /// The \"Rust loadable module\" mark.
>> +                    //
>> +                    // This may be best done another way later on, e.g.=
 as a new modinfo
>> +                    // key or a new section. For the moment, keep it si=
mple.
>> +                    #[cfg(MODULE)]
>> +                    #[doc(hidden)]
>> +                    #[used]
>> +                    static __IS_RUST_MODULE: () =3D ();
>> +
>> +                    static mut __MOD: Option<{type_}> =3D None;
>> +
>> +                    // SAFETY: `__this_module` is constructed by the ke=
rnel at load time and will not be
>> +                    // freed until the module is unloaded.
>> +                    #[cfg(MODULE)]
>> +                    static THIS_MODULE: kernel::ThisModule =3D unsafe {=
{
>> +                        kernel::ThisModule::from_ptr(&kernel::bindings:=
:__this_module as *const _ as *mut _)
>=20
> While we're at it, probably we want the following as well? I.e. using
> `Opaque` and extern block, because __this_module is certainly something
> interior mutable and !Unpin.
>=20
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 293beca0a583..8aa4eed6578c 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -219,7 +219,11 @@ mod __module_init {{
>                       // freed until the module is unloaded.
>                       #[cfg(MODULE)]
>                       static THIS_MODULE: kernel::ThisModule =3D unsafe {=
{
> -                        kernel::ThisModule::from_ptr(&kernel::bindings::=
__this_module as *const _ as *mut _)
> +                        extern \"C\" {{
> +                            static __this_module: kernel::types::Opaque<=
kernel::bindings::module>;
> +                        }}
> +
> +                        kernel::ThisModule::from_ptr(__this_module.get()=
)
>                       }};
>                       #[cfg(not(MODULE))]
>                       static THIS_MODULE: kernel::ThisModule =3D unsafe {=
{
>=20
> Thoughts?

I am not sure we need it. Bindgen generates

     extern "C" {
         pub static mut __this_module: module;
     }

And the `mut` should take care of the "it might be modified by other
threads".
The only thing that sticks out to me is the borrow, it should probably
be using `addr_of_mut!` instead. Then we don't need to re-import it
again manually.

I think it should be a separate patch though.

--=20
Cheers,
Benno

>=20
> Note this requires `Opaque::get` to be `const`, which I will send out
> shortly, I think it's a good change regardless of the usage here.
>=20
> Regards,
> Boqun
>=20


