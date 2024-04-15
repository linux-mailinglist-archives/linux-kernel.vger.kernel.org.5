Return-Path: <linux-kernel+bounces-144647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D148A48C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F94428233A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232F02C1B8;
	Mon, 15 Apr 2024 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OVngStUU"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297E324B34
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165264; cv=none; b=XZA9K67nso08lkS0qKkj29moKQdlnKPEDru3OS5kLgHEAJpHL2ZKq93Xprcqwr4qdZtEP7e873758m2KB+ZTxizGOCxfn42gA8PPty0Eb6H07eeNn4I6bfUja06CqHcRnDpr4bSoqU0t3q8HP1xJGZGwv9s76cmqwhtVRtWAj88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165264; c=relaxed/simple;
	bh=5mzCVboOZWPxYfdtiYTyIKfNBZ2cYroQgYBj9H4+Av0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u+/jCQY2gEV0dKtSEWjc7Yl8N74KlzDBACkbuS4SGr4uLgitFcUEr+/F/Fj07cukgRk9r61cVl2nkdoWUWwoWCrTaGweZFODS78BjGt0DQRZlwaUgzMMEF9X/+VqoLR7Wo/Wf1icoRoMGSURrAi3my6ndGyDTl5d/9yAifKw+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OVngStUU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6183c4a6d18so45205717b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 00:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713165261; x=1713770061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=622yrrnqj1BqCsmBBgHjaeo0syiJ1Yu6xB3lMWoaVgY=;
        b=OVngStUU7hHAqXrMOknVtptLTSJuH1hWRIQ0B8lyQEblBW2ANHz0IvsiGfCdMOH1Go
         HdYT0h6t1NgDFM5JtBXiwYS+abmGtNyrGr3/1NQwpSnRwoCuEyMiQWPwZlZx2ba2A/Yf
         JZoz5YAKTl9h3x66rOIkHELypRfcFvgS1xu/KihpydgJjLeuxSWJNug2O/+R/kNw0BLW
         YUIHT3sEqiqRIhL0eotgCDZFhbdSFYUc4v9zj0fqK6TXda1hwS4Au7E9/E5P560mfJFd
         +JqMlnoYHZ5nJ0T8At/MSlX+eCRh1Kp9yHFB3gdOiF3f7bnSAqWVdPPVU6KLAUPcc1bf
         uAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713165261; x=1713770061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=622yrrnqj1BqCsmBBgHjaeo0syiJ1Yu6xB3lMWoaVgY=;
        b=kzdoQk+NNKo7X5DSeQk6cWK7Sdiufcf/6P7N/tyZvJJnH5xUxnZT9V487zO55C1I87
         pDHm14XvFrNamWuzCt6oR9M4WaUnVinWySoZqSp1VU3BalsSEFPeIOeNgXT28Hxh5nTS
         rMDVByvcARDW0dmlEuIHsSBNYx2nzcm4UdnBq8EghnZXrusts7/I6N6KOCUl49oDBnDT
         zxa9E9gBN9wuTUfUoElowLWYU09oK2DiqWkFvkoTIEbtLKM9PnXx5Kz64OCKwKl2/Li3
         usk75X9YT4cb6Vjj0mazbA6H3xxLAMrAmtNeJnkFhha5Qba6sZqIMrAKxxUbDnN9LnpG
         qLog==
X-Forwarded-Encrypted: i=1; AJvYcCXPKFINFxPGJIT6MC3UlsUf1eQu6H4uixvuXPqYsI9I0uXVJZEfYBBN68zokDdEGz6vCxHRpJhzGqNQwmu34kn5ZxgZtywIRnYycVeM
X-Gm-Message-State: AOJu0Yz330WkEoKEibThdCGAu+vw/PLe5vyHRo4f8mropkJUjpGcIKxB
	+QubzaR9gOmX+gPKj4X8BDilPPHLlr/b8uk/q+huZ9vluwGJw8yaO+6MBXWK/paYO/cfNMAxeq8
	ReUVZI8URWLfmhg==
X-Google-Smtp-Source: AGHT+IEDy2cmxpL9gABLPqVzqQohAjhb5CWGb1j6O1qtcixaXYYFz1PV+vHzyNZSAuog3D6lnXz1u9jyr1ONoMc=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:380e:b0:61a:bdb1:896e with SMTP
 id jx14-20020a05690c380e00b0061abdb1896emr905088ywb.5.1713165261254; Mon, 15
 Apr 2024 00:14:21 -0700 (PDT)
Date: Mon, 15 Apr 2024 07:13:54 +0000
In-Reply-To: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5074; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=AYyTAq6TYaErSLcGReltlD/lrWoe0YO/q7GJueIPc/E=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmHNPCMZ5vFU68UUZuEzeqiEIJzbZO38/o+JL+b
 QhoXSkxAV+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZhzTwgAKCRAEWL7uWMY5
 RgEND/44B8JnNUin8lR9qqAELaIcTM4HHQAqgjQcaq5vFiabeNWQXj3yhNBDx3J6cwMFPgUmzsW
 F0ScjCrdPGfcNsrfowQWRKjm+fd4/OFEPByQecQrQ5MycDypNU3HBGA5lzfFMXIe7TErrFcRTNO
 +IkzkcixhueU/LQRUXNOZ/sHvLEmrnRqDFo5VrJ4fK+ksJ0PrC4xaP3KP/Yogc8Q6XYcDW8RYAG
 UyMLchf7IioeYhbNjPx0wiQRLhmAYaRoXRAjOLHABj0iPL3DKwTZyAmqxf7oWPFBX9BDtBfzZMA
 BfmaVVex3kI1vFaEzf6Xk77iSatVYVGBKegP8YvulcitWEMufwN/GQtNj0Ju4KBZqwNWIbz2gEj
 ukZ2coclsr6Ri+4Uqi1LJGwc5T9c+iLDcX8oyFLm8fyk74r+831KbSMSbiyczG/OvEyhG9DvgkH
 aNaQJHbYzDbT0dUcBKStl/Tx6FwnQoOmoXdFk2zEW1b1CKVbpRvNnJAQonqojW6N+ztBawG2N4R
 zu57ZDq9xIxB+dOXYzak1KI4q+Ijk9rgfji34kQR49kdRzXfadYHU51Z74+tvdaLaaTtb27p/mk
 8E9/wQjavMJvqcABCML87U94lfB9agMkUrrLIF0pCulOMbJZEC4zHUHtRArxAdAQUeONiFwELOb sM3yhdquYvASE7w==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240415-alice-mm-v5-2-6f55e4d8ef51@google.com>
Subject: [PATCH v5 2/4] uaccess: always export _copy_[from|to]_user with CONFIG_RUST
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
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
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
2.44.0.683.g7961c838ac-goog


