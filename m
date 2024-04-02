Return-Path: <linux-kernel+bounces-127969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE5A8953C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FD9283B81
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB887A13A;
	Tue,  2 Apr 2024 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TG+kzr3T"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DBA77F15;
	Tue,  2 Apr 2024 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062064; cv=none; b=PjE4dOKzrmy7CPZP9CLo0aWZNkQxq2qKhpGVW4Mws16cT9XbnkbcN3YhKxHKM9nUlCYe0F0SqgQHDFqMVO/DRf4uog6eOAUfRshx2F292gv59djitX1Ak3xryby2MBarQGm3zVx+QnrXOmHIQvVaGq2xYbrYJ8nrCXKlExS5XhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062064; c=relaxed/simple;
	bh=tv77wEY2gXIZxwexHBZDtQXMh//LD9JALwsTToG42s0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8T7ZtUXEYjxXHjYy1YivlldfV56+1JYEVItdgIfv0ZBytb6nKPjNKo1BGO6/F3I5xsqVReCyqd9FjXBlxL6u/xtBqv0p97rRxHWTUjIuOiUAv2O9oCuJfsCvjP1RIFlzyZObMHOW+Jy5fjJ0zOWtKksUV8MOvZCJ3TgNiukPZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TG+kzr3T; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712062059; x=1712321259;
	bh=9xyuTCGaaAe31ycaYB+ZYD6nsgUvzbGxycpDYEU663s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TG+kzr3TwsqWUcLbtWZ6PfdIh3iPg/oJ5W4qWGbI0K5IiRAjwggyJuXOQnxm+8hSL
	 YmiNT9OyPZGO61rWBLv+7aeZWLe5yrw373XGF4ufEKO5MCANKNmiu6wDwEvg6w8/h6
	 a6djz9Ga2cVYRPd3PuVtvchroM2sSLb9HWbwCqqaFivjh9zgp1B2OZtxlbo2AlO9uU
	 Wbzo6C/viRR8gBHPlTcknRsSdec9oJQssEV2hAeCtjb2eXtqxiZRUkbcgTTVQpTabK
	 AEQzqdoESVFRa8ccs+00opCqXH2EQfYMEJQB0scv77yNeh5HQN0g0vMkjCeHyHVhTW
	 l2mEfF8g2ZdaQ==
Date: Tue, 02 Apr 2024 12:47:34 +0000
To: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, Sumera Priyadarsini <sylphrenadin@gmail.com>, Neal Gompa <neal@gompa.dev>, Thomas Bertschinger <tahbertschinger@gmail.com>, Andrea Righi <andrea.righi@canonical.com>, Matthew Bakhtiari <dev@mtbk.me>, Adam Bratschi-Kaye <ark.email@gmail.com>, stable@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, Wedson Almeida Filho <wedsonaf@google.com>, Finn Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: macros: fix soundness issue in `module!` macro
Message-ID: <bcbc1c4c-1e26-4afc-86ad-5cefa3dd26e0@proton.me>
In-Reply-To: <ZgsykVwMBsULtxce@boqun-archlinux>
References: <20240401185222.12015-1-benno.lossin@proton.me> <Zgsiumknfshjbi9J@boqun-archlinux> <20fcbbd0-4a7a-49b1-a383-f8b388153066@proton.me> <ZgsykVwMBsULtxce@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.04.24 00:17, Boqun Feng wrote:
> On Mon, Apr 01, 2024 at 10:01:34PM +0000, Benno Lossin wrote:
>> On 01.04.24 23:10, Boqun Feng wrote:
>>> On Mon, Apr 01, 2024 at 06:52:50PM +0000, Benno Lossin wrote:
>>> [...]
>>>> +            // Double nested modules, since then nobody can access th=
e public items inside.
>>>> +            mod __module_init {{
>>>> +                mod __module_init {{
>>>> +                    use super::super::{type_};
>>>> +
>>>> +                    /// The \"Rust loadable module\" mark.
>>>> +                    //
>>>> +                    // This may be best done another way later on, e.=
g. as a new modinfo
>>>> +                    // key or a new section. For the moment, keep it =
simple.
>>>> +                    #[cfg(MODULE)]
>>>> +                    #[doc(hidden)]
>>>> +                    #[used]
>>>> +                    static __IS_RUST_MODULE: () =3D ();
>>>> +
>>>> +                    static mut __MOD: Option<{type_}> =3D None;
>>>> +
>>>> +                    // SAFETY: `__this_module` is constructed by the =
kernel at load time and will not be
>>>> +                    // freed until the module is unloaded.
>>>> +                    #[cfg(MODULE)]
>>>> +                    static THIS_MODULE: kernel::ThisModule =3D unsafe=
 {{
>>>> +                        kernel::ThisModule::from_ptr(&kernel::binding=
s::__this_module as *const _ as *mut _)
>>>
>>> While we're at it, probably we want the following as well? I.e. using
>>> `Opaque` and extern block, because __this_module is certainly something
>>> interior mutable and !Unpin.
>>>
>>> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
>>> index 293beca0a583..8aa4eed6578c 100644
>>> --- a/rust/macros/module.rs
>>> +++ b/rust/macros/module.rs
>>> @@ -219,7 +219,11 @@ mod __module_init {{
>>>                        // freed until the module is unloaded.
>>>                        #[cfg(MODULE)]
>>>                        static THIS_MODULE: kernel::ThisModule =3D unsaf=
e {{
>>> -                        kernel::ThisModule::from_ptr(&kernel::bindings=
::__this_module as *const _ as *mut _)
>>> +                        extern \"C\" {{
>>> +                            static __this_module: kernel::types::Opaqu=
e<kernel::bindings::module>;
>>> +                        }}
>>> +
>>> +                        kernel::ThisModule::from_ptr(__this_module.get=
())
>>>                        }};
>>>                        #[cfg(not(MODULE))]
>>>                        static THIS_MODULE: kernel::ThisModule =3D unsaf=
e {{
>>>
>>> Thoughts?
>>
>> I am not sure we need it. Bindgen generates
>>
>>       extern "C" {
>>           pub static mut __this_module: module;
>>       }
>>
>> And the `mut` should take care of the "it might be modified by other
>> threads".
>=20
> Hmm.. but there could a C thread modifies some field of __this_module
> while Rust code uses it, e.g. struct module has a list_head in it, which
> could be used by C code to put another module next to it.

This still should not be a problem, since we never actually read or
write to the mutable static. The only thing we are doing is taking its
address. `addr_of_mut!` should be sufficient. (AFAIK `static mut` is
designed such that it can be mutated at any time by any thread. Maybe
Gary knows more?)

--=20
Cheers,
Benno


