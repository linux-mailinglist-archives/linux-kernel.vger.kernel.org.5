Return-Path: <linux-kernel+bounces-98717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9DA877E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05B41C21445
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437543B2BE;
	Mon, 11 Mar 2024 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WL+V9EGM"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4534374CF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154050; cv=none; b=jgRXkTjz5ZFoCYYbGTLtOmTJSoiyl9e8uwV/XVOAVCKdhiI5ffQKj34uH6MZSiNzLVwqF8nZjVTV7duVQ9uiaOIlNYk9ZZsRAAfdm3Xf+hBzHkuyM5i41AcYsmgvzrgW5sMySN/XycnqTKCFhU/FnH2344PIvygXaOfPxtbssDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154050; c=relaxed/simple;
	bh=wmuCL83UBR6TYf+x9z8Idn6vDuRVMYiqC4cmyq6jAlM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eSl0aHT0uFABHF9PMTRKiqzHtTvNvXUEWqTGWrSKsIhpaGb65XjfU/GlR5SpVRECElje6FvLYQMDMTxiH6A/jldagv7eFxpZNelqjw4FD/7aqSM6SPeyI73gQzUv97sRZQ7FFkZdXauAVvIpbU5+Eiw2WQOuxHH1BsFEx3VuCfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WL+V9EGM; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2d449d2d9bdso498841fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710154047; x=1710758847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QK7N3wvRNuxt3Md31RNENpTO88LXLvO1cHfykZ9Cy8A=;
        b=WL+V9EGMU/KL9yYMO+1+PKIYBfcTrE01/5EE/XYMx9gbIeBhAFeHKDYfMA7gzDGiKq
         ljuwQbFMFHhWjbGIFbODyD+x2lxzTz8QQ1M8VkOCYKsrRtLtc5zT22x1uJrt93D19qvF
         NhgmTnIWNj+88Vbw4xB7YoZX/VEmpot5e2hyPdKF3J9a4naUfLUOZ44RolbvVP3PNRYN
         sah/JwhSS01gZ6PApT8KvfAeIGPtvyHEdE3SYHh/iUsqW+0gC25tBe2s0zoEcVxvpE/x
         RTW9iX6wF1vstdDew+XUk7xL1Aj7+eW4IZh5YsJonKVmR9F79GISLooDW0lqVzOMUkln
         crQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710154047; x=1710758847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QK7N3wvRNuxt3Md31RNENpTO88LXLvO1cHfykZ9Cy8A=;
        b=ANgX1+Z3v3V+wqa1Bed802yx1z6pl6NNZ6j89fo7P/YnJ2HdDDOvkrrNtRFtPAExV5
         Uz9F2zBx8TsNEBBiRgKAvVk8uiBFpSGrlHELI/KiAk58uC6WlS7MeaS4/3ym2jjA2x9Z
         yvtjUelwCj7aosYPW/mLJwQhJsC5cU2SZRxff9RheXCe9eN+ANVxQZ/DmVoomhFhy4N4
         3/vbTxMDVE2XSfWv4ESrKyCB2Y8Je1QsMcvvzXxJx3OIu80Ba7eX/5T03DbahfZ6mp6Q
         rCQeoOXkwG2b7isjmF2iDapjtthBOsYByTQ9hehAiclzcJdwmvVv3RZKavmX9Fr7adZM
         fZGg==
X-Forwarded-Encrypted: i=1; AJvYcCXAHmb1lVoimZULPE2JzMHFQDeYJtqfPo8PChOwUtmHGPDlmj2V8PfJz/p4/RK0GJV1/qOTKDvHbZaVCHA29N2MiNb75riG4/I41hfG
X-Gm-Message-State: AOJu0YxxSqXyT1M32cGNe2XJzn3R2gLnLD9i0xJkPNukyYIqW2qAlM1j
	7HYBhH4ZpglIpqi5iLIwsYFrDTbwcoVBMyDLcW0EMm3jjdHcJS0sov+P4Wx6MFX9uB6S1dvlody
	dIFaRPwAAFvcDBQ==
X-Google-Smtp-Source: AGHT+IHSWDS4ViRws7i/kRXoMZR5WHtv1Oe3C4G9VZj4JBfcdfc7JLVHMzSKn3kJjxqSGhfVqyFOyNajwYd1AbY=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:98d7:0:b0:2d2:39e3:4177 with SMTP id
 s23-20020a2e98d7000000b002d239e34177mr5921ljj.3.1710154046386; Mon, 11 Mar
 2024 03:47:26 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:47:14 +0000
In-Reply-To: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5026; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=pHnbSUxra5e5H6zBKTRnUbpLhZzdUBojHIfp+nyvk+Y=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl7uE0j1KsTCtMubuFNvEOo6APsxvUwA1hJoBnz
 QHXFmedNU6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZe7hNAAKCRAEWL7uWMY5
 Rp+KD/4qOeDNNJqVjqc6H7KB4hwApHbA5wPeaWMEUeFX/cw2NlzyLJPdERRCiqZLQ/cEdsHg7Wz
 gZUXgev5Z21/0QAeen5iqImCU0oknimN4IowfaMXghclnRg6AI95WZr+YSDOfUTInGLsjVeR5X4
 D2yQCZ22UtLTRbmz3aVcRLkUAFDTMyzKjj0uQQysx92PKlM62qwFpJyHgf1VYYl+tU9FOK2prQ4
 X5m6OeKp9sz7tZJ64BNvj9wFCrVHbeYZmu3X1gEIPtj0YuUGtylFF3hNNZX4PWb27YBqgTh/jsv
 uLj1a8kBx+HN66qwceF7EVW40qHUqlJYvF8kByf0Qd6lOo61FxBRRXrfhE+GFkdgK1uRDRenjpJ
 gfIqSvdgqx9JClXUqQgS6U8txVmMCWErdT3wSkzhop3wNLdA4q0eZlTnTHQVtuofBhbnbjr9NvE
 BgApEvdQxYtNmjEDWS3zH/GG18kLfHqArvpraRws98F4n0PVY22Dg1RuifPFihc9um3lqpoto0K
 cdMmSF6mMo4HSZx1wq+r/PURWdB2rlvRbt6q8sLZ5xWK1NorgXqXs8w9gqad76yCV5byjmGMGqC
 ULKm+giotJR8S6iaAvd0PFjxeKoz5R9iOobOCUZFg4UQsrn890ASHToXImx92uLM1+kCe1HYXEH Pw8yHaDClkwD+iQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240311-alice-mm-v3-2-cdf7b3a2049c@google.com>
Subject: [PATCH v3 2/4] uaccess: always export _copy_[from|to]_user with CONFIG_RUST
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Arnd Bergmann <arnd@arndb.de>

Rust code needs to be able to access _copy_from_user and _copy_to_user
so that it can skip the check_copy_size check in cases where the length
is known at compile-time, mirroring the logic for when C code will skip
check_copy_size. To do this, we ensure that exported versions of these
methods are available when CONFIG_RUST is enabled.

Alice has verified that this patch passes the CONFIG_TEST_USER_COPY test
on x86 using the Android cuttlefish emulator.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/uaccess.h | 38 ++++++++++++++++++++++++--------------
 lib/usercopy.c          | 30 ++++--------------------------
 2 files changed, 28 insertions(+), 40 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 3064314f4832..2ebfce98b5cc 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -5,6 +5,7 @@
 #include <linux/fault-inject-usercopy.h>
 #include <linux/instrumented.h>
 #include <linux/minmax.h>
+#include <linux/nospec.h>
 #include <linux/sched.h>
 #include <linux/thread_info.h>
 
@@ -138,13 +139,18 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
 	return raw_copy_to_user(to, from, n);
 }
 
-#ifdef INLINE_COPY_FROM_USER
 static inline __must_check unsigned long
-_copy_from_user(void *to, const void __user *from, unsigned long n)
+_inline_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	unsigned long res = n;
 	might_fault();
 	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
+		/*
+		 * Ensure that bad access_ok() speculation will not
+		 * lead to nasty side effects *after* the copy is
+		 * finished:
+		 */
+		barrier_nospec();
 		instrument_copy_from_user_before(to, from, n);
 		res = raw_copy_from_user(to, from, n);
 		instrument_copy_from_user_after(to, from, n, res);
@@ -153,14 +159,11 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
 		memset(to + (n - res), 0, res);
 	return res;
 }
-#else
 extern __must_check unsigned long
 _copy_from_user(void *, const void __user *, unsigned long);
-#endif
 
-#ifdef INLINE_COPY_TO_USER
 static inline __must_check unsigned long
-_copy_to_user(void __user *to, const void *from, unsigned long n)
+_inline_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
 	if (should_fail_usercopy())
@@ -171,25 +174,32 @@ _copy_to_user(void __user *to, const void *from, unsigned long n)
 	}
 	return n;
 }
-#else
 extern __must_check unsigned long
 _copy_to_user(void __user *, const void *, unsigned long);
-#endif
 
 static __always_inline unsigned long __must_check
 copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	if (check_copy_size(to, n, false))
-		n = _copy_from_user(to, from, n);
-	return n;
+	if (!check_copy_size(to, n, false))
+		return n;
+#ifdef INLINE_COPY_FROM_USER
+	return _inline_copy_from_user(to, from, n);
+#else
+	return _copy_from_user(to, from, n);
+#endif
 }
 
 static __always_inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	if (check_copy_size(from, n, true))
-		n = _copy_to_user(to, from, n);
-	return n;
+	if (!check_copy_size(from, n, true))
+		return n;
+
+#ifdef INLINE_COPY_TO_USER
+	return _inline_copy_to_user(to, from, n);
+#else
+	return _copy_to_user(to, from, n);
+#endif
 }
 
 #ifndef copy_mc_to_kernel
diff --git a/lib/usercopy.c b/lib/usercopy.c
index d29fe29c6849..de7f30618293 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -7,40 +7,18 @@
 
 /* out-of-line parts */
 
-#ifndef INLINE_COPY_FROM_USER
+#if !defined(INLINE_COPY_FROM_USER) || defined(CONFIG_RUST)
 unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	unsigned long res = n;
-	might_fault();
-	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
-		/*
-		 * Ensure that bad access_ok() speculation will not
-		 * lead to nasty side effects *after* the copy is
-		 * finished:
-		 */
-		barrier_nospec();
-		instrument_copy_from_user_before(to, from, n);
-		res = raw_copy_from_user(to, from, n);
-		instrument_copy_from_user_after(to, from, n, res);
-	}
-	if (unlikely(res))
-		memset(to + (n - res), 0, res);
-	return res;
+	return _inline_copy_from_user(to, from, n);
 }
 EXPORT_SYMBOL(_copy_from_user);
 #endif
 
-#ifndef INLINE_COPY_TO_USER
+#if !defined(INLINE_COPY_TO_USER) || defined(CONFIG_RUST)
 unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	might_fault();
-	if (should_fail_usercopy())
-		return n;
-	if (likely(access_ok(to, n))) {
-		instrument_copy_to_user(to, from, n);
-		n = raw_copy_to_user(to, from, n);
-	}
-	return n;
+	return _inline_copy_to_user(to, from, n);
 }
 EXPORT_SYMBOL(_copy_to_user);
 #endif

-- 
2.44.0.278.ge034bb2e1d-goog


