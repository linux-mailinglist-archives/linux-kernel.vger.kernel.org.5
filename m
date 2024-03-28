Return-Path: <linux-kernel+bounces-123531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 643AF890A63
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFBB29BBF7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC57346BF;
	Thu, 28 Mar 2024 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQe1+o/L"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E6A13B5B5;
	Thu, 28 Mar 2024 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655729; cv=none; b=m8ImBDwlRFr3i+S0Jko7QcHgHihdtWdxS5RwXALc+lD3diZDgjaXzb0Ubh/0YPKCHeuQyKTeibf7PlEkOKWm/Zf1xdk/7PiX/19+11keQ+VpMHtO+3cVLcr6rct/mIjIQ23LvGLxK8wbly3SyABGCMm/Kcgo/Xy5TnRTUr7InX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655729; c=relaxed/simple;
	bh=fwHF+9VfvjyLijiOuriTU4phk/vNv1/uaYRVz+QNv7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=isvx6wr31I4dyPVQSUzuwotnTz5MYxZDQdt4ZY3P+90+//9inmpM9PVspibp6yFmkFB/7ztaNT0PdE4l380Jfa699t/4eMIpNzplBMzfD2jWUC+n/Vblqv8GxW1S1IQ/tCri6iMty3OnEYEH+bCdfZaaLJ2NFGxBrcJUMXHHjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQe1+o/L; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e04ac4209eso11812105ad.1;
        Thu, 28 Mar 2024 12:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711655727; x=1712260527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaV84KT2HRtfO0aaQj0mOFU/al8Iv6el5mE2P2C4AwY=;
        b=OQe1+o/L32zVC66/Yf0xaT18an0+S8chAJIN1F2YZ+5iphBaWjraL0WCFMi8MDDeke
         9n8i3yHsP8C5Ghcq/irjQYrHs8juzuvqw3YU49DkD/QMPUHI6CoSOFqmYL1i37D2H2Ei
         y8y02yfZvQS5ePuvVrwo0yU3uHD74Z/UZgSQ2SRpferKXyNn0zdv29BiT6vhbgMsdXGw
         t2T7aITcJGPSfBlLGAIKY2VSExq6VdnwCxtRtCV5pXv+s4q64nx9WSKOM9bZdJE0B1tH
         hdOMpIoELl03EL2HKd26OIyZ4+cFnH1Sr0AnKQ+BeHUjGGB86r6OQ6LdVc9+ePnCQVRF
         EgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711655727; x=1712260527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaV84KT2HRtfO0aaQj0mOFU/al8Iv6el5mE2P2C4AwY=;
        b=arZhbnjLiJrcOYhIm9qwxcuJyiTg8/2V3smv2oUDBDTgxxlUcehz/jHGWux0jujD9+
         yDZ443k9R+PDDoy/1kKE3aacvVjToGWOsyW7T/4mAQ17+HdtfkCv/6yWU7+poA5N7fK0
         VdXWJrSLsAP+pF9usNGZTKBFW0bx5QL5EB03blDUzYNtNxcatGnLis//6TJWfNbspGs6
         fpIhha7yDL5HvXBJ5/sO754deFjANii7Pgspr9Bzy89FJAqLEfp4QElnC9S06VDZeisr
         /fD8Kcd2jfulPE0HdOhaCA/X2nqHXEbzPB0Zffg1IY3ymRXGKm4mWbeay+qQwfxl1Uq4
         P1CA==
X-Forwarded-Encrypted: i=1; AJvYcCUVXNpv2wK1t9BpCXbfgcZsmQtBPD34/Cbas90LaJXCC7kTaI2yqnWG5dawHjezIgStlw5Moyq4YMuy64/GeuFYVL2a2zozeT+glzrw
X-Gm-Message-State: AOJu0YzmjjJsk2/883NiMewotDhn0hsq+IHCc2pB/e1QWCIQ31f1Hh7M
	1ik52yQeHuPVj/+maYKLnBtVe8KkdiDbZfjM8VvtUc7xJoM4lNvUDLBJo3Dy
X-Google-Smtp-Source: AGHT+IHtnVuR83rlRhJFX22O35yxSF4w2PJlJYzX7KvTLxFR+XM7g0omTJVVf70kwzut9sZDcrSPXg==
X-Received: by 2002:a17:903:555:b0:1e0:af99:819e with SMTP id jo21-20020a170903055500b001e0af99819emr478073plb.20.1711655726788;
        Thu, 28 Mar 2024 12:55:26 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170902e75000b001dd7a97a266sm2006520plf.282.2024.03.28.12.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:55:26 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v2 3/5] rust: module: prefix all module paths with `::`
Date: Thu, 28 Mar 2024 16:54:55 -0300
Message-Id: <20240328195457.225001-4-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195457.225001-1-wedsonaf@gmail.com>
References: <20240328195457.225001-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

This prevents the macro-generated code from accidentally referring to
the wrong symbol if the caller's code happens to have submodules called
`core` or `kernel`.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/macros/module.rs | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 27979e582e4b..6da1246742a5 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -213,12 +213,12 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
             // freed until the module is unloaded.
             #[cfg(MODULE)]
-            static THIS_MODULE: kernel::ThisModule = unsafe {{
-                kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
+            static THIS_MODULE: ::kernel::ThisModule = unsafe {{
+                ::kernel::ThisModule::from_ptr(&::kernel::bindings::__this_module as *const _ as *mut _)
             }};
             #[cfg(not(MODULE))]
-            static THIS_MODULE: kernel::ThisModule = unsafe {{
-                kernel::ThisModule::from_ptr(core::ptr::null_mut())
+            static THIS_MODULE: ::kernel::ThisModule = unsafe {{
+                ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
             }};
 
             // Loadable modules need to export the `{{init,cleanup}}_module` identifiers.
@@ -230,7 +230,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             #[doc(hidden)]
             #[no_mangle]
             #[link_section = \".init.text\"]
-            pub unsafe extern \"C\" fn init_module() -> core::ffi::c_int {{
+            pub unsafe extern \"C\" fn init_module() -> ::core::ffi::c_int {{
                 __init()
             }}
 
@@ -248,11 +248,11 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             #[doc(hidden)]
             #[link_section = \"{initcall_section}\"]
             #[used]
-            pub static __{name}_initcall: extern \"C\" fn() -> core::ffi::c_int = __{name}_init;
+            pub static __{name}_initcall: extern \"C\" fn() -> ::core::ffi::c_int = __{name}_init;
 
             #[cfg(not(MODULE))]
             #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
-            core::arch::global_asm!(
+            ::core::arch::global_asm!(
                 r#\".section \"{initcall_section}\", \"a\"
                 __{name}_initcall:
                     .long   __{name}_init - .
@@ -263,7 +263,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             #[cfg(not(MODULE))]
             #[doc(hidden)]
             #[no_mangle]
-            pub extern \"C\" fn __{name}_init() -> core::ffi::c_int {{
+            pub extern \"C\" fn __{name}_init() -> ::core::ffi::c_int {{
                 __init()
             }}
 
@@ -274,8 +274,8 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
                 __exit()
             }}
 
-            fn __init() -> core::ffi::c_int {{
-                match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
+            fn __init() -> ::core::ffi::c_int {{
+                match <{type_} as ::kernel::Module>::init(&THIS_MODULE) {{
                     Ok(m) => {{
                         unsafe {{
                             __MOD = Some(m);
-- 
2.34.1


