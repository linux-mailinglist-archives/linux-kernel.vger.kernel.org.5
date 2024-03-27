Return-Path: <linux-kernel+bounces-120540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB32E88D918
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7511C271B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8881438DEF;
	Wed, 27 Mar 2024 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="jU0fSrUq"
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64BD2E851;
	Wed, 27 Mar 2024 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528062; cv=none; b=apeIEPqm/Hyh3vu1/1zttbz7eydOMMmlUpfU6Fv832Hu/0gyAl4L9xV8t2srp2gat3KZ4ru0oGfHYeG3Q1OyqpQ2UUvcv6WI3eRd5YP9yhRmOE3xR9ny+ySBvCjfyTxxZAKqL0OCqChixc3e3yAaV9MiOCtcdGeSqb7ckcrlBvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528062; c=relaxed/simple;
	bh=y6318m75tMM2r/aL8vRV6hgnTQ4paa5ClSRlYghWl34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8d1SHMzK8GN5ig7KA0evYQee4b2jArhj3tmOSs0XOfcRBk/c4O49o8b0mCSkIyimsaHAiSe6RUhKK0utROxYpfdoa61C3j75HmNrDnxSqrzs/cJSPl3ji4j8aQaHNFMApfZiNJhiXSMxlP5zUlLc3wusMs9jiDWodne0zoHZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=jU0fSrUq; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valentinobst.de;
	s=s1-ionos; t=1711528051; x=1712132851; i=kernel@valentinobst.de;
	bh=ZawCX3FYhw9ljz/RNRGvZhidx8kHBRaZ/9eyBcMa4YU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=jU0fSrUqyQ8qiH08Yjrzl4kl20wGRhje2wOPmXZCdWbj6N4jYyQI4eV+GbFAzvI4
	 o5VwdMQPuizmvq1WiSg3Zr+lzaXnaAuy4AfmriggJCO/xsTfgUDGMGhQoOxyKOn4j
	 QTgnoJZVl3Xf39BKnAEzHWbZHULDiIL/i4QkfAdDp32AwOdnwJCZoMHo/VBU2OA9G
	 SEAv9+UpJ9eQ4SsSLCPlwHISEpt2Xx82gF7xZwL5Yoqdwv4fF/OkIeDJxAUl4zfp4
	 1Bnnc+OBD+s1uxpOYDzrELybCjUeoSHQhn2G4IzQxP/exN9HVcTBJ1Ml0jVPLQWjE
	 8vqWmIx52TBlVdoqiA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MdNPq-1sOSB80M0e-00ZSy5; Wed, 27 Mar 2024 09:13:22 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: wedsonaf@gmail.com
Cc: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	walmeida@microsoft.com,
	Trevor Gross <tmgross@umich.edu>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH 1/2] rust: introduce `InPlaceModule`
Date: Wed, 27 Mar 2024 09:13:17 +0100
Message-ID: <20240327081317.45574-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327032337.188938-2-wedsonaf@gmail.com>
References: <20240327032337.188938-2-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JS0Hf9bTiUMbw0GJkzJLXPgktiGy8i7Xfldkkx3j5U6nx9684is
 bGF38LHWXqcBa9je73/vwRY239Qsqgo9cK+HbYTUBCEzNoJ5ciud8C8Ruv6NZDXWb4hnt2P
 s5xNcwnOwPjeItFN6Umwq0/MoOsd4tUhsEgwf0b7PtTEOmEgfSvjKmjpECyrRIPbNZWSB3c
 /fTXNijwmGsnJwiR8Phxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Yr1f17Cn2OE=;0K2wMy6d/77ATITYacg+zpDik+B
 lOiRzlMMWBQNTHOGKbJg0tFPHYEoKATgAx4E4y7KCIQWQ++WhhJXWrSs2uCoiDYNwtR9M51aq
 3Dv6G/23REBETH/6A8+wFSh3aDu4x6kVmfEPxl9sE19wIHodRjWO5IhpUfB8CrDNvKe4f8fqg
 atIxKKBr8YtnJ43ylrlcHeptwRxcGr3/U7vwssFx552MjcicQbmJdkwXEWU2mSa/OHu29KPbF
 WDi2YcunDoKrk0iT4ILWR+NDib3SJqsnf0KffdjBzfPUI8HS8jymVtoCApuL8kVJv9AaTt0G/
 AsMlFYExmhs0/3LAg5ES/6GwYz21H7xkDdoXWUI6Sb7GC2zvgYMUmxubtrT9R8nZGkfXAw/mD
 7e30qpTqmp21CB3uMaeE4iMQ9aOSSua7TVEL9mQ7eA2tVkMFyGTyNjBAcYDOzR7xLuRcQRZXv
 a/fI7X3ntEL2A4vvU2BDsRSnUwtaYAzsAu8y50GHD7x0UUN03Joq4EuP96OZUuk9KmMAgRcXu
 Gsa7f95ZPJfy04Y8PqzodMcfxcQ5514X84soBGixqQzZ1/P+D3qxKVdb/9x6NyAhfE1V2mHNz
 YJIvWeOlKMpw6WUYOmzzt7J3C2LiqpQkXTOCg2t13CZUPIdp9k2S9b/gxkQpAvCzTOxYqwJqP
 cOW3iyz/Xcj5NsJJlJEomH/BkLBcv9Tmwheb1Yj4m1QyBPf0Bgc9XRDxmUtq5N2DMDFPRYzxX
 HoH9rfSNgKkojE+kjlVtckq7qQTpggcsvOjVCv8tkASGLPnDTBEBmI=

> This allows modules to be initialised in-place in pinned memory, which
> enables the usage of pinned types (e.g., mutexes, spinlocks, driver
> registrations, etc.) in modules without any extra allocations.
>
> Drivers that don't need this may continue to implement `Module` without
> any changes.
>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/kernel/lib.rs    | 25 ++++++++++++++++++++++++-
>  rust/macros/module.rs | 18 ++++++------------
>  2 files changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 5c641233e26d..64aee4fbc53b 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -62,7 +62,7 @@
>  /// The top level entrypoint to implementing a kernel module.
>  ///
>  /// For any teardown or cleanup operations, your type may implement [`D=
rop`].
> -pub trait Module: Sized + Sync {
> +pub trait Module: Sized + Sync + Send {

This does not compile with `CONFIG_AX88796B_RUST_PHY=3Dy || m` (or the
phylib abstractions' doctests) since the module `Registration` is not
`Send`.

I remember Trevor raising the question whether we want to require modules
to be `Send`. I am not aware of any examples of `!Send` modules but I gues=
s
it would be possible to write code that is only correct under the
assumption that it is loaded/unloaded in the same context.

@Trevor: Are you aware of any modules with that requirement?

I have been using this patch for quite a while with my TCP CCAs now
(without the `Send` bound) and did not experience any other issues; thus
offering:
	Tested-by: Valentin Obst <kernel@valentinobst.de>

	- Best Valentin

>      /// Called at module initialization time.
>      ///
>      /// Use this method to perform whatever setup or registration your =
module
> @@ -72,6 +72,29 @@ pub trait Module: Sized + Sync {
>      fn init(module: &'static ThisModule) -> error::Result<Self>;
>  }
>
> +/// A module that is pinned and initialised in-place.
> +pub trait InPlaceModule: Sync + Send {
> +    /// Creates an initialiser for the module.
> +    ///
> +    /// It is called when the module is loaded.
> +    fn init(module: &'static ThisModule) -> impl init::PinInit<Self, er=
ror::Error>;
> +}
> +
> +impl<T: Module> InPlaceModule for T {
> +    fn init(module: &'static ThisModule) -> impl init::PinInit<Self, er=
ror::Error> {
> +        let initer =3D move |slot: *mut Self| {
> +            let m =3D <Self as Module>::init(module)?;
> +
> +            // SAFETY: `slot` is valid for write per the contract with =
`pin_init_from_closure`.
> +            unsafe { slot.write(m) };
> +            Ok(())
> +        };
> +
> +        // SAFETY: On success, `initer` always fully initialises an ins=
tance of `Self`.
> +        unsafe { init::pin_init_from_closure(initer) }
> +    }
> +}
> +
>  /// Equivalent to `THIS_MODULE` in the C API.
>  ///
>  /// C header: [`include/linux/export.h`](srctree/include/linux/export.h=
)
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 27979e582e4b..0b2bb4ec2fba 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -208,7 +208,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream=
 {
>              #[used]
>              static __IS_RUST_MODULE: () =3D ();
>
> -            static mut __MOD: Option<{type_}> =3D None;
> +            static mut __MOD: core::mem::MaybeUninit<{type_}> =3D core:=
:mem::MaybeUninit::uninit();
>
>              // SAFETY: `__this_module` is constructed by the kernel at =
load time and will not be
>              // freed until the module is unloaded.
> @@ -275,23 +275,17 @@ pub(crate) fn module(ts: TokenStream) -> TokenStre=
am {
>              }}
>
>              fn __init() -> core::ffi::c_int {{
> -                match <{type_} as kernel::Module>::init(&THIS_MODULE) {=
{
> -                    Ok(m) =3D> {{
> -                        unsafe {{
> -                            __MOD =3D Some(m);
> -                        }}
> -                        return 0;
> -                    }}
> -                    Err(e) =3D> {{
> -                        return e.to_errno();
> -                    }}
> +                let initer =3D <{type_} as kernel::InPlaceModule>::init=
(&THIS_MODULE);
> +                match unsafe {{ initer.__pinned_init(__MOD.as_mut_ptr()=
) }} {{
> +                    Ok(m) =3D> 0,
> +                    Err(e) =3D> e.to_errno(),
>                  }}
>              }}
>
>              fn __exit() {{
>                  unsafe {{
>                      // Invokes `drop()` on `__MOD`, which should be use=
d for cleanup.
> -                    __MOD =3D None;
> +                    __MOD.assume_init_drop();
>                  }}
>              }}
>
> --

