Return-Path: <linux-kernel+bounces-127071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D93789466A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69841F21BFA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D2354BF4;
	Mon,  1 Apr 2024 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No47/9B4"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8354780;
	Mon,  1 Apr 2024 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005876; cv=none; b=R8r4cqpJ0dfkGk2VxBuS4wepW9KpLJ6opLuqKWNN4hseV6fEr4WpKdHbxdLfLcKOoNEjDCx716feei9yGdGTUECexbchvdRpfd8HXfLt19nx0Kp19jg0+0PCFBcY9zKcRcVdd1NB7M6exzC3dvejGkhF3NT8O2mAI3J1w/a8YVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005876; c=relaxed/simple;
	bh=gJl1jhUoKN3I83hZ1w+NN+ttN5UGtoQtIQL6QlBnQNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7s0rvJN7fD8zGW5J0Wg9HD3uXEqLXtYnNn3VQdi86aCDerT+slFzEdw58V4877xiwq+1bLGY7DoHWFviKulVYdY4EFkrj5S2R2UwC1VOn8jC3t8Glp7u50QOT2Dy/SzV42htTUIx0Ek+V4WUJPACOIPWIKjmzEa8sv0Waq1xJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No47/9B4; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6969388c36fso25623726d6.1;
        Mon, 01 Apr 2024 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712005873; x=1712610673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkhnvWHhVL6JHXVbv5PuUQPIXTyetrYiX4MyEXYBe+I=;
        b=No47/9B4bcB6cq27NQQ59WaD7AyQaIFrR74f3DtNTtUlVif9Qhf7s31cyNwN4x/1ma
         u2t3Q8LR6e+4P/lnw2XfPA4S38EUCspO0RGgZb+d8ofnQmllRzj6/Pozev+N6ArJc85f
         OA1jcehy44pSLDK2lRHVpx9HQc8/D8TQuyLVgFLqEcLn7+l7mRtfdfdcZq63yy32OQ6+
         Sa0L46tG5kKMc5j4xt/NrNjBhB0kaTrC3KgrZzkbcPR2SauD3ApJ6ZQxrDmf/Xz46g/r
         jg84CCVL0tkYxsi7U/MLQbtammeHMBk9iDYsHv+tLZ1ZLMQe7149+M3TFbwpTYw80HFz
         PntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712005873; x=1712610673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkhnvWHhVL6JHXVbv5PuUQPIXTyetrYiX4MyEXYBe+I=;
        b=rZnnqvXRrRP3/ChHMgC2V2b42InonOUq+LgCvnzaTRr//mVhuoDa366MBNGsR9hjSo
         kKbIjcYcjnPv+O6vB5V4uyKJnFmlcSzHswwf+kWd+/TcLKyYTK0Fe/BBhIV24sfT3NSD
         iQUXdsEi0rd4g0gMiWcAfg6f/ZITsgbA4FitJMCviQ0iS6Bs2qLLdXWH3hz5YV04nDNN
         znEcmJVR/1G1j/yntzvXklNLE0mBEV2j2U1P7sXGDqrA0Bi8D3ILcYLGByoQoe2nriRq
         CW4lRb03uiLQWt1Jqq3M6jWx59inSXnej43BZ8U+wCYbx3j+81vdO8ndtj6rHGRvb1bS
         gkmA==
X-Forwarded-Encrypted: i=1; AJvYcCXzBSaWDaPx2HT/gYvtXTQvHPIpcKCDJR01Ra+TZMjdI4lmwBbu309IfuBheeffmNsk9KS9REtovSgdhH+eEGTtxk8wH+ZziFAriNyfxt1X0o9D/ji+6MXpPalSn8wHSO4Se9QGCFuH/nBXycmUWNJymp4ZYLuw2v/ZxyF6/twzEP/LgwQ=
X-Gm-Message-State: AOJu0YzXvRpCvuPQdLRE+aVaPFqCbhKWqtkTmut93nNItscypze6SZ3O
	Ro0vpX6/DeVZvJBV+IEbAFHfEbqH0Uinnfpc93JVV+b5oL315v+R
X-Google-Smtp-Source: AGHT+IEI1pa9Cn8u5iUlH/1lz7Kk5D2iJ7tR3ZtNokhvych9OhM/KVht0/hJAYYawgJhL8KUzHUtUg==
X-Received: by 2002:ad4:4f88:0:b0:696:b0ba:c3b with SMTP id em8-20020ad44f88000000b00696b0ba0c3bmr9823601qvb.36.1712005873459;
        Mon, 01 Apr 2024 14:11:13 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id g12-20020a0562141ccc00b0069915b47bf4sm120705qvd.146.2024.04.01.14.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:11:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id DB4E31200032;
	Mon,  1 Apr 2024 17:11:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 01 Apr 2024 17:11:11 -0400
X-ME-Sender: <xms:7iILZmL_DCYpWhK6Qdn0NOOCy_J91o6mgR8e1LTHCSQxeDl8zld9ig>
    <xme:7iILZuLkSJP1eqGpK2S5rGvtR5picmSBSPQzcdG6TLkt94j9W3dHgc6JCiCdU6FOT
    BuguMZyghyh8MvBWA>
X-ME-Received: <xmr:7iILZmvYZCekUvf6gcEwfxzyJEIAJzeN8LB5ZOfiBDOut6XtnfxHJLy9iO0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeftddgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:7iILZraz5_Hh6fH9CCDAC1e82jMrxfq1jx7cCmkAcy9k2qsff73yGQ>
    <xmx:7iILZtbMKOe_9jTp8le1JUXN73e_ldUAwAj_PjCC7ePgvENeuf4nmg>
    <xmx:7iILZnAXlv73NWzKT5C55DKJzGamjPEPsVA-Zlf6sjXnHUZusL-HhQ>
    <xmx:7iILZjYs1GwLHdAtA7ikUSO8By9D_ZZwlTQ98BNsttllk7-G7qnZnA>
    <xmx:7yILZtrtmycj0vxDzl3nSQp1-GVIfxIHFNA0Do3cm3qBPgkCVMrjCv9kt-I>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 17:11:10 -0400 (EDT)
Date: Mon, 1 Apr 2024 14:10:18 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Asahi Lina <lina@asahilina.net>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	Neal Gompa <neal@gompa.dev>,
	Thomas Bertschinger <tahbertschinger@gmail.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	Matthew Bakhtiari <dev@mtbk.me>,
	Adam Bratschi-Kaye <ark.email@gmail.com>, stable@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Wedson Almeida Filho <wedsonaf@google.com>,
	Finn Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: macros: fix soundness issue in `module!` macro
Message-ID: <Zgsiumknfshjbi9J@boqun-archlinux>
References: <20240401185222.12015-1-benno.lossin@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401185222.12015-1-benno.lossin@proton.me>

On Mon, Apr 01, 2024 at 06:52:50PM +0000, Benno Lossin wrote:
[...]
> +            // Double nested modules, since then nobody can access the public items inside.
> +            mod __module_init {{
> +                mod __module_init {{
> +                    use super::super::{type_};
> +
> +                    /// The \"Rust loadable module\" mark.
> +                    //
> +                    // This may be best done another way later on, e.g. as a new modinfo
> +                    // key or a new section. For the moment, keep it simple.
> +                    #[cfg(MODULE)]
> +                    #[doc(hidden)]
> +                    #[used]
> +                    static __IS_RUST_MODULE: () = ();
> +
> +                    static mut __MOD: Option<{type_}> = None;
> +
> +                    // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
> +                    // freed until the module is unloaded.
> +                    #[cfg(MODULE)]
> +                    static THIS_MODULE: kernel::ThisModule = unsafe {{
> +                        kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)

While we're at it, probably we want the following as well? I.e. using
`Opaque` and extern block, because __this_module is certainly something
interior mutable and !Unpin.

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 293beca0a583..8aa4eed6578c 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -219,7 +219,11 @@ mod __module_init {{
                     // freed until the module is unloaded.
                     #[cfg(MODULE)]
                     static THIS_MODULE: kernel::ThisModule = unsafe {{
-                        kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
+                        extern \"C\" {{
+                            static __this_module: kernel::types::Opaque<kernel::bindings::module>;
+                        }}
+
+                        kernel::ThisModule::from_ptr(__this_module.get())
                     }};
                     #[cfg(not(MODULE))]
                     static THIS_MODULE: kernel::ThisModule = unsafe {{

Thoughts?

Note this requires `Opaque::get` to be `const`, which I will send out
shortly, I think it's a good change regardless of the usage here.

Regards,
Boqun

> +                    }};
> +                    #[cfg(not(MODULE))]
> +                    static THIS_MODULE: kernel::ThisModule = unsafe {{
> +                        kernel::ThisModule::from_ptr(core::ptr::null_mut())
> +                    }};
> +
> +                    // Loadable modules need to export the `{{init,cleanup}}_module` identifiers.
> +                    /// # Safety
> +                    ///
> +                    /// This function must not be called after module initialization, because it may be
> +                    /// freed after that completes.
> +                    #[cfg(MODULE)]
> +                    #[doc(hidden)]
> +                    #[no_mangle]
> +                    #[link_section = \".init.text\"]
> +                    pub unsafe extern \"C\" fn init_module() -> core::ffi::c_int {{
> +                        // SAFETY: this function is inaccessible to the outside due to the double
> +                        // module wrapping it. It is called exactly once by the C side via its
> +                        // unique name.
> +                        unsafe {{ __init() }}
> +                    }}
>  
> -            #[cfg(MODULE)]
> -            #[doc(hidden)]
> -            #[no_mangle]
> -            pub extern \"C\" fn cleanup_module() {{
> -                __exit()
> -            }}
> +                    #[cfg(MODULE)]
> +                    #[doc(hidden)]
> +                    #[no_mangle]
> +                    pub extern \"C\" fn cleanup_module() {{
> +                        // SAFETY:
> +                        // - this function is inaccessible to the outside due to the double
> +                        //   module wrapping it. It is called exactly once by the C side via its
> +                        //   unique name,
> +                        // - furthermore it is only called after `init_module` has returned `0`
> +                        //   (which delegates to `__init`).
> +                        unsafe {{ __exit() }}
> +                    }}
>  
> -            // Built-in modules are initialized through an initcall pointer
> -            // and the identifiers need to be unique.
> -            #[cfg(not(MODULE))]
> -            #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
> -            #[doc(hidden)]
> -            #[link_section = \"{initcall_section}\"]
> -            #[used]
> -            pub static __{name}_initcall: extern \"C\" fn() -> core::ffi::c_int = __{name}_init;
> -
> -            #[cfg(not(MODULE))]
> -            #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
> -            core::arch::global_asm!(
> -                r#\".section \"{initcall_section}\", \"a\"
> -                __{name}_initcall:
> -                    .long   __{name}_init - .
> -                    .previous
> -                \"#
> -            );
> +                    // Built-in modules are initialized through an initcall pointer
> +                    // and the identifiers need to be unique.
> +                    #[cfg(not(MODULE))]
> +                    #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
> +                    #[doc(hidden)]
> +                    #[link_section = \"{initcall_section}\"]
> +                    #[used]
> +                    pub static __{name}_initcall: extern \"C\" fn() -> core::ffi::c_int = __{name}_init;
> +
> +                    #[cfg(not(MODULE))]
> +                    #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
> +                    core::arch::global_asm!(
> +                        r#\".section \"{initcall_section}\", \"a\"
> +                        __{name}_initcall:
> +                            .long   __{name}_init - .
> +                            .previous
> +                        \"#
> +                    );
> +
> +                    #[cfg(not(MODULE))]
> +                    #[doc(hidden)]
> +                    #[no_mangle]
> +                    pub extern \"C\" fn __{name}_init() -> core::ffi::c_int {{
> +                        // SAFETY: this function is inaccessible to the outside due to the double
> +                        // module wrapping it. It is called exactly once by the C side via its
> +                        // placement above in the initcall section.
> +                        unsafe {{ __init() }}
> +                    }}
>  
> -            #[cfg(not(MODULE))]
> -            #[doc(hidden)]
> -            #[no_mangle]
> -            pub extern \"C\" fn __{name}_init() -> core::ffi::c_int {{
> -                __init()
> -            }}
> +                    #[cfg(not(MODULE))]
> +                    #[doc(hidden)]
> +                    #[no_mangle]
> +                    pub extern \"C\" fn __{name}_exit() {{
> +                        // SAFETY:
> +                        // - this function is inaccessible to the outside due to the double
> +                        //   module wrapping it. It is called exactly once by the C side via its
> +                        //   unique name,
> +                        // - furthermore it is only called after `__{name}_init` has returned `0`
> +                        //   (which delegates to `__init`).
> +                        unsafe {{ __exit() }}
> +                    }}
>  
> -            #[cfg(not(MODULE))]
> -            #[doc(hidden)]
> -            #[no_mangle]
> -            pub extern \"C\" fn __{name}_exit() {{
> -                __exit()
> -            }}
> +                    /// # Safety
> +                    ///
> +                    /// This function must only be called once.
> +                    unsafe fn __init() -> core::ffi::c_int {{
> +                        match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
> +                            Ok(m) => {{
> +                                // SAFETY:
> +                                // no data race, since `__MOD` can only be accessed by this module and
> +                                // there only `__init` and `__exit` access it. These functions are only
> +                                // called once and `__exit` cannot be called before or during `__init`.
> +                                unsafe {{
> +                                    __MOD = Some(m);
> +                                }}
> +                                return 0;
> +                            }}
> +                            Err(e) => {{
> +                                return e.to_errno();
> +                            }}
> +                        }}
> +                    }}
>  
> -            fn __init() -> core::ffi::c_int {{
> -                match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
> -                    Ok(m) => {{
> +                    /// # Safety
> +                    ///
> +                    /// This function must
> +                    /// - only be called once,
> +                    /// - be called after `__init` has been called and returned `0`.
> +                    unsafe fn __exit() {{
> +                        // SAFETY:
> +                        // no data race, since `__MOD` can only be accessed by this module and there
> +                        // only `__init` and `__exit` access it. These functions are only called once
> +                        // and `__init` was already called.
>                          unsafe {{
> -                            __MOD = Some(m);
> +                            // Invokes `drop()` on `__MOD`, which should be used for cleanup.
> +                            __MOD = None;
>                          }}
> -                        return 0;
>                      }}
> -                    Err(e) => {{
> -                        return e.to_errno();
> -                    }}
> -                }}
> -            }}
>  
> -            fn __exit() {{
> -                unsafe {{
> -                    // Invokes `drop()` on `__MOD`, which should be used for cleanup.
> -                    __MOD = None;
> +                    {modinfo}
>                  }}
>              }}
> -
> -            {modinfo}
>          ",
>          type_ = info.type_,
>          name = info.name,
> 
> base-commit: 9ffe2a730313f27cebd0859ea856247ac59c576c
> -- 
> 2.44.0
> 
> 

