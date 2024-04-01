Return-Path: <linux-kernel+bounces-126962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F1C894505
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81C21F21B58
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B426C4F88B;
	Mon,  1 Apr 2024 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TGP2zhoV"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958429CFA;
	Mon,  1 Apr 2024 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711997588; cv=none; b=Ok6+Au0fax5A5bNFLCsWRnyulnqeWijkmaR6ZV63uPHNHDZzR/LfGoEaGpw6LPGfDIXF0O5EqubqvIVuw/gKET+zQXN9kf2M2QmLOumL7WPKarC57TNY2npExyF3BUo7Vs06suimLOwv39bO3AzQnV+jKs0kqXJGW1GTo5QSZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711997588; c=relaxed/simple;
	bh=mn160bmbr3ihc6WOyXRTXI6Q6xdrsjP28TsGkpAWmiU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CLwsAs7KHRZ4Lb+h6VX4fdlM1lMm0aITqgpQ6LbqCpWK+9pNK20X+RuZn14D9o/nGbjzPrhbke/9eFDq1vvNuWBubm77/6sAC42fxrssIX0dpxUj2UBeEc0id4RAgswLGW55zSUtJStwvvmiAX5mXTR/34GCeIcDLQCINfIoaLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TGP2zhoV; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711997577; x=1712256777;
	bh=bzkClClBfGXbwanM0n075DqRUXgckA/1kUMPbrP5+0k=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TGP2zhoVKJ2pFdgE3cZohsvtKd0r3YW1GJyZ4Wp5BiS+Ex9aLQcy9enT5nsKYopyE
	 JIsOSv5S24otrhu+XY2syV/l9DurUsCUZNOts2Z+keMvkhnjzTHC7LEcOezcQ+C16U
	 667Dq/7DWdisMbO6VjZ4oqg5MBROXmx3VOLhaXzthQL1muBZJOuHL55NDqQPi+mv06
	 3VieUNZrsI0B1Zl4WKkhp3QTNfynPIa/CVPCaLYkuq8V5/fqgS8WMFRNAFmDBGgHB3
	 WV9vfhTvmtSn7icXSiOLSzWb4LRfi7OJQ0Zx3Jw9wgOSx+PeSWJBXIbVr0Fl2uKnDB
	 yBKeVlHYQo2bw==
Date: Mon, 01 Apr 2024 18:52:50 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, Sumera Priyadarsini <sylphrenadin@gmail.com>, Neal Gompa <neal@gompa.dev>, Thomas Bertschinger <tahbertschinger@gmail.com>, Andrea Righi <andrea.righi@canonical.com>, Matthew Bakhtiari <dev@mtbk.me>, Adam Bratschi-Kaye <ark.email@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: stable@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, Wedson Almeida Filho <wedsonaf@google.com>, Finn Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust: macros: fix soundness issue in `module!` macro
Message-ID: <20240401185222.12015-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The `module!` macro creates glue code that are called by C to initialize
the Rust modules using the `Module::init` function. Part of this glue
code are the local functions `__init` and `__exit` that are used to
initialize/destroy the Rust module.
These functions are safe and also visible to the Rust mod in which the
`module!` macro is invoked. This means that they can be called by other
safe Rust code. But since they contain `unsafe` blocks that rely on only
being called at the right time, this is a soundness issue.

Wrap these generated functions inside of two private modules, this
guarantees that the public functions cannot be called from the outside.
Make the safe functions `unsafe` and add SAFETY comments.

Cc: stable@vger.kernel.org
Closes: https://github.com/Rust-for-Linux/linux/issues/629
Fixes: 1fbde52bde73 ("rust: add `macros` crate")
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v1: https://lore.kernel.org/rust-for-linux/20240327160346.22442-1-benno.los=
sin@proton.me/
v1 -> v2:
- wrapped `__init` and `__exit` calls in `unsafe` blocks and added
  SAFETY comments,
- fixed safety requirement on `__exit` and `__init`,
- rebased onto rust-next.

 rust/macros/module.rs | 213 +++++++++++++++++++++++++-----------------
 1 file changed, 127 insertions(+), 86 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 27979e582e4b..293beca0a583 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -199,103 +199,144 @@ pub(crate) fn module(ts: TokenStream) -> TokenStrea=
m {
             /// Used by the printing macros, e.g. [`info!`].
             const __LOG_PREFIX: &[u8] =3D b\"{name}\\0\";
=20
-            /// The \"Rust loadable module\" mark.
-            //
-            // This may be best done another way later on, e.g. as a new m=
odinfo
-            // key or a new section. For the moment, keep it simple.
-            #[cfg(MODULE)]
-            #[doc(hidden)]
-            #[used]
-            static __IS_RUST_MODULE: () =3D ();
-
-            static mut __MOD: Option<{type_}> =3D None;
-
-            // SAFETY: `__this_module` is constructed by the kernel at loa=
d time and will not be
-            // freed until the module is unloaded.
-            #[cfg(MODULE)]
-            static THIS_MODULE: kernel::ThisModule =3D unsafe {{
-                kernel::ThisModule::from_ptr(&kernel::bindings::__this_mod=
ule as *const _ as *mut _)
-            }};
-            #[cfg(not(MODULE))]
-            static THIS_MODULE: kernel::ThisModule =3D unsafe {{
-                kernel::ThisModule::from_ptr(core::ptr::null_mut())
-            }};
-
-            // Loadable modules need to export the `{{init,cleanup}}_modul=
e` identifiers.
-            /// # Safety
-            ///
-            /// This function must not be called after module initializati=
on, because it may be
-            /// freed after that completes.
-            #[cfg(MODULE)]
-            #[doc(hidden)]
-            #[no_mangle]
-            #[link_section =3D \".init.text\"]
-            pub unsafe extern \"C\" fn init_module() -> core::ffi::c_int {=
{
-                __init()
-            }}
+            // Double nested modules, since then nobody can access the pub=
lic items inside.
+            mod __module_init {{
+                mod __module_init {{
+                    use super::super::{type_};
+
+                    /// The \"Rust loadable module\" mark.
+                    //
+                    // This may be best done another way later on, e.g. as=
 a new modinfo
+                    // key or a new section. For the moment, keep it simpl=
e.
+                    #[cfg(MODULE)]
+                    #[doc(hidden)]
+                    #[used]
+                    static __IS_RUST_MODULE: () =3D ();
+
+                    static mut __MOD: Option<{type_}> =3D None;
+
+                    // SAFETY: `__this_module` is constructed by the kerne=
l at load time and will not be
+                    // freed until the module is unloaded.
+                    #[cfg(MODULE)]
+                    static THIS_MODULE: kernel::ThisModule =3D unsafe {{
+                        kernel::ThisModule::from_ptr(&kernel::bindings::__=
this_module as *const _ as *mut _)
+                    }};
+                    #[cfg(not(MODULE))]
+                    static THIS_MODULE: kernel::ThisModule =3D unsafe {{
+                        kernel::ThisModule::from_ptr(core::ptr::null_mut()=
)
+                    }};
+
+                    // Loadable modules need to export the `{{init,cleanup=
}}_module` identifiers.
+                    /// # Safety
+                    ///
+                    /// This function must not be called after module init=
ialization, because it may be
+                    /// freed after that completes.
+                    #[cfg(MODULE)]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    #[link_section =3D \".init.text\"]
+                    pub unsafe extern \"C\" fn init_module() -> core::ffi:=
:c_int {{
+                        // SAFETY: this function is inaccessible to the ou=
tside due to the double
+                        // module wrapping it. It is called exactly once b=
y the C side via its
+                        // unique name.
+                        unsafe {{ __init() }}
+                    }}
=20
-            #[cfg(MODULE)]
-            #[doc(hidden)]
-            #[no_mangle]
-            pub extern \"C\" fn cleanup_module() {{
-                __exit()
-            }}
+                    #[cfg(MODULE)]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    pub extern \"C\" fn cleanup_module() {{
+                        // SAFETY:
+                        // - this function is inaccessible to the outside =
due to the double
+                        //   module wrapping it. It is called exactly once=
 by the C side via its
+                        //   unique name,
+                        // - furthermore it is only called after `init_mod=
ule` has returned `0`
+                        //   (which delegates to `__init`).
+                        unsafe {{ __exit() }}
+                    }}
=20
-            // Built-in modules are initialized through an initcall pointe=
r
-            // and the identifiers need to be unique.
-            #[cfg(not(MODULE))]
-            #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
-            #[doc(hidden)]
-            #[link_section =3D \"{initcall_section}\"]
-            #[used]
-            pub static __{name}_initcall: extern \"C\" fn() -> core::ffi::=
c_int =3D __{name}_init;
-
-            #[cfg(not(MODULE))]
-            #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
-            core::arch::global_asm!(
-                r#\".section \"{initcall_section}\", \"a\"
-                __{name}_initcall:
-                    .long   __{name}_init - .
-                    .previous
-                \"#
-            );
+                    // Built-in modules are initialized through an initcal=
l pointer
+                    // and the identifiers need to be unique.
+                    #[cfg(not(MODULE))]
+                    #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
+                    #[doc(hidden)]
+                    #[link_section =3D \"{initcall_section}\"]
+                    #[used]
+                    pub static __{name}_initcall: extern \"C\" fn() -> cor=
e::ffi::c_int =3D __{name}_init;
+
+                    #[cfg(not(MODULE))]
+                    #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
+                    core::arch::global_asm!(
+                        r#\".section \"{initcall_section}\", \"a\"
+                        __{name}_initcall:
+                            .long   __{name}_init - .
+                            .previous
+                        \"#
+                    );
+
+                    #[cfg(not(MODULE))]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    pub extern \"C\" fn __{name}_init() -> core::ffi::c_in=
t {{
+                        // SAFETY: this function is inaccessible to the ou=
tside due to the double
+                        // module wrapping it. It is called exactly once b=
y the C side via its
+                        // placement above in the initcall section.
+                        unsafe {{ __init() }}
+                    }}
=20
-            #[cfg(not(MODULE))]
-            #[doc(hidden)]
-            #[no_mangle]
-            pub extern \"C\" fn __{name}_init() -> core::ffi::c_int {{
-                __init()
-            }}
+                    #[cfg(not(MODULE))]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    pub extern \"C\" fn __{name}_exit() {{
+                        // SAFETY:
+                        // - this function is inaccessible to the outside =
due to the double
+                        //   module wrapping it. It is called exactly once=
 by the C side via its
+                        //   unique name,
+                        // - furthermore it is only called after `__{name}=
_init` has returned `0`
+                        //   (which delegates to `__init`).
+                        unsafe {{ __exit() }}
+                    }}
=20
-            #[cfg(not(MODULE))]
-            #[doc(hidden)]
-            #[no_mangle]
-            pub extern \"C\" fn __{name}_exit() {{
-                __exit()
-            }}
+                    /// # Safety
+                    ///
+                    /// This function must only be called once.
+                    unsafe fn __init() -> core::ffi::c_int {{
+                        match <{type_} as kernel::Module>::init(&THIS_MODU=
LE) {{
+                            Ok(m) =3D> {{
+                                // SAFETY:
+                                // no data race, since `__MOD` can only be=
 accessed by this module and
+                                // there only `__init` and `__exit` access=
 it. These functions are only
+                                // called once and `__exit` cannot be call=
ed before or during `__init`.
+                                unsafe {{
+                                    __MOD =3D Some(m);
+                                }}
+                                return 0;
+                            }}
+                            Err(e) =3D> {{
+                                return e.to_errno();
+                            }}
+                        }}
+                    }}
=20
-            fn __init() -> core::ffi::c_int {{
-                match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
-                    Ok(m) =3D> {{
+                    /// # Safety
+                    ///
+                    /// This function must
+                    /// - only be called once,
+                    /// - be called after `__init` has been called and ret=
urned `0`.
+                    unsafe fn __exit() {{
+                        // SAFETY:
+                        // no data race, since `__MOD` can only be accesse=
d by this module and there
+                        // only `__init` and `__exit` access it. These fun=
ctions are only called once
+                        // and `__init` was already called.
                         unsafe {{
-                            __MOD =3D Some(m);
+                            // Invokes `drop()` on `__MOD`, which should b=
e used for cleanup.
+                            __MOD =3D None;
                         }}
-                        return 0;
                     }}
-                    Err(e) =3D> {{
-                        return e.to_errno();
-                    }}
-                }}
-            }}
=20
-            fn __exit() {{
-                unsafe {{
-                    // Invokes `drop()` on `__MOD`, which should be used f=
or cleanup.
-                    __MOD =3D None;
+                    {modinfo}
                 }}
             }}
-
-            {modinfo}
         ",
         type_ =3D info.type_,
         name =3D info.name,

base-commit: 9ffe2a730313f27cebd0859ea856247ac59c576c
--=20
2.44.0



