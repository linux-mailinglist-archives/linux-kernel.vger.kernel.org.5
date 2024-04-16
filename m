Return-Path: <linux-kernel+bounces-147280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC98A71EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D271C212AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE443132493;
	Tue, 16 Apr 2024 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPTXOQq9"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6012E1E8;
	Tue, 16 Apr 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713287267; cv=none; b=NOmnJ7MMZfSwVXrtifAIWyOo6ky7ewrMDAtvCOi9k+6m9mGVIGJGBzQfPYt2eO/SkX1YsvhOq9/KHtxhwg/UnhYRlL58ceo/ejjgiqIZqd/7MRx6xcweBuL2LXeY5G2lxlCTWSrdNpiEDqa8GkfrMalfSpcc83qUXmSDnexqYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713287267; c=relaxed/simple;
	bh=f/fnrdxNCDGyBxu0Cw8TMeUPmrR90+CCa02nHl4h05Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7zWmGL+stjEsph69KqxOK/zx+Deh7xHX5A+GzdrqxyMswnSAScBSoYcm+JnkXKU48E7cbNPQRQEunkHHhsoNtsr26UAYPPXF3wkxU3D9APdN5ydCE6wJk+Rb4gDPukJibij/7udRZ5qs2pVxb33aY6yX+l+bdLYrzaktFcmLqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPTXOQq9; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-434d12e9662so21108881cf.2;
        Tue, 16 Apr 2024 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713287265; x=1713892065; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ORGQ4FpFUr8CNMJ8nGMv1TvXQGc9fladS7kaSrCMW9A=;
        b=dPTXOQq9kXN8Ntvs4v9lI4U1T2+EFtP6Q1/mgZNYooHD975V/e8AqZkGexMMf5dB20
         zjVY0HLXDMUpCqDnwVm1etmuZnvxP3nrnFJtFcTodHrIPLZHzkRNcVIxAcJBKN/mDfni
         AsX785qwK9/6e8k1SyEOlxkEDciZJ9PFsoHl3VoE0qaZYntPA4un+Ua9nBZzuW7LGYKH
         Z2BYGLSJMKqhsP7eXCl2iFUxiDCKfEsO1z2DuqGRJBtmiOgv8Ry2ka1ZLHoSRng/roTJ
         7xYFHsHo1OeJdMAk+ol/mEvGfg00uBlOKGHE52kII7OccI+XF/dx/uESwGxXFwcW67dQ
         SlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713287265; x=1713892065;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORGQ4FpFUr8CNMJ8nGMv1TvXQGc9fladS7kaSrCMW9A=;
        b=ma6JSDxOJ9PoPvpZzaSymz7Q5TgFaproGLymfmviSzvyuwD+scEQ2KgVPUHqnE5Yum
         RKdDa5r/k2QK/ohZ4QdWzx5N3SGiqT7kssNSbM0HFbybXFDArucx9SBhL9cBACedwKnu
         ktiC0vlmBDJiVIPrpXHNPAGpIXC+I5eVIQtHA0A7gmzzHbaPTu+5QSwM7qHDUn4eYKdK
         rS6HSand7+azxyE2LXEgbZVURZkpupuDxZNrlV57BpQhW2jEdKeZZUXXAP5ciG22bkGd
         Me3SVBZGeRoqPI3hHUCRFmj+dmXWkmlmgPDiw2P76HI+5ZAmkPzAZ7cKqx8CRrI8sb/V
         LT2A==
X-Forwarded-Encrypted: i=1; AJvYcCVrrrwwuMKRRSyXpvhKR/ec2CHPcWp3C0y/RiyD0+0DYdiirUSFSewdsFW+Xlff566eYw0yRyA57d5CAGlMLvggekfHk68sjWzlqULFZFShfJPSJAB3c+YrpPj5z7g/b85vNCBjwMITmsEIC0h6tdH6D7H0KbYhuGpRX/YZ7VvhBxWgcUs=
X-Gm-Message-State: AOJu0Yzq1oh4VfH9HbBU2rjG3fi/gJASRvPIiwS4ShVkxBcxYNEuYZ4X
	53NHvZWcZJZuc8xJWRGUWHc0grhOoYsV+ETZ2E6rIO0+UIHNq1J5
X-Google-Smtp-Source: AGHT+IH4K1C8oUNKr5v3XEp6bWsc4NZ9GBMoBMOkM/9G+fGLZvPAXtNsSr4sY5xa7gudhKIFSR3AKQ==
X-Received: by 2002:ac8:58d0:0:b0:436:73ac:8129 with SMTP id u16-20020ac858d0000000b0043673ac8129mr19448010qta.61.1713287265180;
        Tue, 16 Apr 2024 10:07:45 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id i9-20020ac860c9000000b004343d542598sm7328319qtm.62.2024.04.16.10.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:07:44 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 3D4501200066;
	Tue, 16 Apr 2024 13:07:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 16 Apr 2024 13:07:43 -0400
X-ME-Sender: <xms:X7AeZmCDxp6AsgYautBwC_DXlCFkgQ6Laxu_AgglfwplvhVCWyFq_g>
    <xme:X7AeZghMBJm5BuId6WpUW6HbhBYegfnFfSkdWcc4bn0NUbxrTGUmp-ola0a5mtepr
    mRIrdod-NhGu6iMww>
X-ME-Received: <xmr:X7AeZpnn4wG--Ad9jQMfXtylQ6mYGnNyoJLKYHT8Ow3EVzJEAfDbQG3WgQDOUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejiedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepffdvudegieehffdvtdeivefhgfehgedtffdugfekffeuheevheffieek
    tedujeejnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpiihulhhiphgthhgrthdrtg
    homhdpihguvghnthhifhhivghrshdrshgrfhgvthihnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhph
    gvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdr
    fhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:X7AeZkx-DATjGs_MOBhrBCqZdjQ26sAwl-rTbPKI9W65iPbVL3cdrA>
    <xmx:X7AeZrTSHYW5YWZX_8VfqPJfQd86OPJAueRQ7ejTGTLamq8AhHJxNg>
    <xmx:X7AeZvYK1096IPo8NfsO6GWVkXFJuUbsOuBwlRUnjc-fjHtxUcvy6A>
    <xmx:X7AeZkRAzhO8GWG4vo-h7Sjy9pqnw5fzr1vM49LuuPuE2-HgqJlyYg>
    <xmx:X7AeZtBB7_viBL6XxlqnEdeO_9_XamuixjGZLymcXKVetYwNELi2Z79p>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 13:07:42 -0400 (EDT)
Date: Tue, 16 Apr 2024 10:07:24 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
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
Message-ID: <Zh6wTDoMgvjJZ7T9@boqun-archlinux>
References: <20240401185222.12015-1-benno.lossin@proton.me>
 <CANiq72=M0L+RG6v701ThedXgYj4SUgotx-BcVoWbMxOcKY5--w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=M0L+RG6v701ThedXgYj4SUgotx-BcVoWbMxOcKY5--w@mail.gmail.com>

On Sun, Apr 07, 2024 at 10:02:35PM +0200, Miguel Ojeda wrote:
> On Mon, Apr 1, 2024 at 8:53 PM Benno Lossin <benno.lossin@proton.me> wrote:
> >
> > The `module!` macro creates glue code that are called by C to initialize
> > the Rust modules using the `Module::init` function. Part of this glue
> > code are the local functions `__init` and `__exit` that are used to
> > initialize/destroy the Rust module.
> > These functions are safe and also visible to the Rust mod in which the
> > `module!` macro is invoked. This means that they can be called by other
> > safe Rust code. But since they contain `unsafe` blocks that rely on only
> > being called at the right time, this is a soundness issue.
> >
> > Wrap these generated functions inside of two private modules, this
> > guarantees that the public functions cannot be called from the outside.
> > Make the safe functions `unsafe` and add SAFETY comments.
> >
> > Cc: stable@vger.kernel.org
> > Closes: https://github.com/Rust-for-Linux/linux/issues/629
> > Fixes: 1fbde52bde73 ("rust: add `macros` crate")
> > Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> 
> [ Capitalized comments, avoided newline in non-list SAFETY comments
>   and reworded to add Reported-by and newline. ]
> 
> Applied to `rust-fixes` -- thanks everyone!
> 

As reported by Dirk Behme:

	https://rust-for-linux.zulipchat.com/#narrow/stream/291565-Help/topic/How.20to.20use.20THIS_MODULE.20with.20.22.20rust.3A.20macros.3A.20fix.20soundness.20.2E.22/near/433512583

The following is needed to allow modules using `THIS_MODULE` as a static
variable. That being said, maybe we can merge this patch as it is, since
it doesn't break mainline, and the following change can be done in a
separate patch.

Regards,
Boqun

----------------------------->8
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 293beca0a583..0664b957a70a 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -199,6 +199,17 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             /// Used by the printing macros, e.g. [`info!`].
             const __LOG_PREFIX: &[u8] = b\"{name}\\0\";
 
+            // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
+            // freed until the module is unloaded.
+            #[cfg(MODULE)]
+            static THIS_MODULE: kernel::ThisModule = unsafe {{
+                kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
+            }};
+            #[cfg(not(MODULE))]
+            static THIS_MODULE: kernel::ThisModule = unsafe {{
+                kernel::ThisModule::from_ptr(core::ptr::null_mut())
+            }};
+
             // Double nested modules, since then nobody can access the public items inside.
             mod __module_init {{
                 mod __module_init {{
@@ -215,17 +226,6 @@ mod __module_init {{
 
                     static mut __MOD: Option<{type_}> = None;
 
-                    // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
-                    // freed until the module is unloaded.
-                    #[cfg(MODULE)]
-                    static THIS_MODULE: kernel::ThisModule = unsafe {{
-                        kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
-                    }};
-                    #[cfg(not(MODULE))]
-                    static THIS_MODULE: kernel::ThisModule = unsafe {{
-                        kernel::ThisModule::from_ptr(core::ptr::null_mut())
-                    }};
-
                     // Loadable modules need to export the `{{init,cleanup}}_module` identifiers.
                     /// # Safety
                     ///
@@ -301,7 +301,7 @@ mod __module_init {{
                     ///
                     /// This function must only be called once.
                     unsafe fn __init() -> core::ffi::c_int {{
-                        match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
+                        match <{type_} as kernel::Module>::init(&super::super::THIS_MODULE) {{
                             Ok(m) => {{
                                 // SAFETY:
                                 // no data race, since `__MOD` can only be accessed by this module and

