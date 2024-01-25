Return-Path: <linux-kernel+bounces-38860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1340183C766
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962FA1F25541
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8794E74E05;
	Thu, 25 Jan 2024 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hZUco6hT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kLFp17Yt"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21206E2DB;
	Thu, 25 Jan 2024 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198409; cv=none; b=jK/usk1Cz8kAFZP8h1WhvyaONY1T3+UCf3Ci6ku5bU+QVdcbAfqxDqA9gMD4Rx5kpzlIqV+DTEr4LzIJtjg7ppKTNXF2YRsruL1yPNzByOByUM/pcJCSBTDqWmnhY9JxSDzK6t6mRTN6CXz1ZXGw2S++wmnvaG6WeQTrMeEwc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198409; c=relaxed/simple;
	bh=JhL7YQiPLcm8PQ76uhgv/Ri86FrIlG5VN2oDXHuMbk4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=VZSmKuPIqrRS2E5dulAaDc75dx30tEOj4k5yi7Ou5xeKMll9c0fZmwGB8vFUkPZbpke4tM/UPKj8bDmbvLfZHDQTplGz9AzDKNp34Ej87mPR+QtzL6vkM0rbyAUOhQjbHPyeQdnmrN3xsJa113V9As2y+fDwR02Cfm96WPQCK7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hZUco6hT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kLFp17Yt; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 005105C00DB;
	Thu, 25 Jan 2024 11:00:06 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 25 Jan 2024 11:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706198405;
	 x=1706284805; bh=SqRtybdjact+f0QeQR9azdnQV/iHBEyjbNT4deqFxZo=; b=
	hZUco6hTk7rOkCqcYBakCuKg7hmrOp10Kl7rKZgdg3AtevpRTSE1FNx35WvDHTR3
	1C7FoNO4AoNwonAd2Chx/+UWKiyhmFU2eCeCnBslCiMYNOh/xTT/6M8hCTDPxsfz
	89i84ehFOG8mwCbtzrBv12r4eSH1QZg8tTBBkeJHz1RPqzkzk1xjsOxfOl3oRnTU
	sPr6vb5q46615EIDB1gJQAN8YA0J5/aOiEJZdQQaOAce8GGilRlQZyztp0ZwZTsc
	pFM6+FXy3riyiKtPd0DiquSWJ6oRpJyFvfcZeM5uaBpdXOMGhik9K+cRR86Lxl9j
	yiK2yA9KyAwtsZpPiGf+Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706198405; x=
	1706284805; bh=SqRtybdjact+f0QeQR9azdnQV/iHBEyjbNT4deqFxZo=; b=k
	LFp17YtrpRi6UPiYMjCy1sSkRCu+4ovdGWJglYg38qH4EC9qgTEkBYuLaLEYguEu
	e1XEM9HH3ivgr7ZJK9gNu7vf6g4WOJwlqkMdyt+wf9Wm1zSfCn8WTSbbV537JAtg
	Zd6WuoyJTAhl94CQKpuZNFTyNESGF0Y8bolk8bSWVO3604SjANDQMOdxikiPhGCt
	GG4VfwNqhjNrQam6m5b+aW7zQsOT6MnsQlRnal4Y9WN0hHW0ZVvRNE6SrI13KGaD
	8azmTSTIlo/kQew6erQirnv72LdKvsDMb841+XjVkiHjaAmwa9dQKfuzjCHi/6tV
	nFAlkE9/wgYcr80jMtazw==
X-ME-Sender: <xms:hYWyZdMCnNNDyxgx9e38kTFRO4tfEujPrKnR2VkCPUqn88cu2N07FQ>
    <xme:hYWyZf_hcCBLVbUvHV3e_KHJbCI-TfcDPRjP6gTsyE_SttJMCyPtBq1gvRgdqbZNL
    N1epLMlzAuNUCW3X6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelgedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:hYWyZcSrj6tqxczRhaAAwS9PuouPD2R6FmvYUnShyGwwclXuM4DwAg>
    <xmx:hYWyZZumEbZQfXLv_Ip1F35vHXrTUTB3_mZtrE2r-P9BV3bcAIASdg>
    <xmx:hYWyZVf2Wp44LAJuU-i1pC_p-CdUKQrOUdepDtu0KOLGLRzPMQ6BPA>
    <xmx:hYWyZb8_wzMTLbtbtdIu8WwuPiAC8-Q5bRy-LrLKrXjioeU23oqL7A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4DCDEB6008D; Thu, 25 Jan 2024 11:00:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e69f9b43-39cd-469d-94db-140504df0833@app.fastmail.com>
In-Reply-To: 
 <CAH5fLgi8D18ufma0X49nWhXpnz47t-C=OAtM+wwnYu78hEnwhA@mail.gmail.com>
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-2-d1abcec83c44@google.com>
 <070574cb-8d7f-4fe7-9826-cec6110168ff@app.fastmail.com>
 <CAH5fLgi8D18ufma0X49nWhXpnz47t-C=OAtM+wwnYu78hEnwhA@mail.gmail.com>
Date: Thu, 25 Jan 2024 16:59:42 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 "Todd Kjos" <tkjos@android.com>, "Martijn Coenen" <maco@android.com>,
 "Joel Fernandes" <joel@joelfernandes.org>,
 "Carlos Llamas" <cmllamas@google.com>,
 "Suren Baghdasaryan" <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 "Christian Brauner" <brauner@kernel.org>
Subject: Re: [PATCH 2/3] rust: add typed accessors for userspace pointers
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024, at 13:37, Alice Ryhl wrote:
> On Thu, Jan 25, 2024 at 1:27=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Wed, Jan 24, 2024, at 12:20, Alice Ryhl wrote:

>> > +EXPORT_SYMBOL_GPL(rust_helper_copy_to_user_unsafe_skip_check_objec=
t_size);
>>
>> These functions are almost identical to the ones in
>> lib/usercopy.c for !defined(INLINE_COPY_TO_USER).
>>
>> That version has an extra memset() after a partial
>> copy_from_user(), and you probably want to have the
>> same thing here for consistency.
>>
>> I think ideally we should only have one out-of-line copy
>> of these two functions and have that one shared between
>> rust and architectures that want the C version out of line
>> as well.
>
> I had a bit of trouble figuring out all of the copy_[to/from]_user
> methods that are available. I was hoping that a better solution would
> be available, and it sounds like one is. Is _copy_from_user always
> available as an exported symbol? If it's always available and skips
> the check, then I can just use that. I don't think the memset matters
> for my case.

At the moment, it appears that it's available on the few architectures
that don't #define INLINE_COPY_FROM_USER: alpha, csky, powerpc,
riscv and x86. On the other architectures it is always an inline
function.

> Otherwise, I can add a helper in rust/helpers.c that wraps
> _copy_from_user only when INLINE_COPY_FROM_USER is defined, and call
> the helper in those cases, and otherwise call the exported symbol
> directly. (I need an exported symbol to call into C from Rust.)
>
> Would that make sense?

I don't think we can have a perfect abstraction here, but rather
than putting knowledge of INLINE_COPY_FROM_USER into the rust
wrapper, I would suggest putting a bit of information about
rust into lib/usercopy.c.

I've tried to come up with an idea below, see if that works
for you.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 3064314f4832..835aa175d0ee 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -138,13 +138,18 @@ __copy_to_user(void __user *to, const void *from, =
unsigned long n)
 	return raw_copy_to_user(to, from, n);
 }
=20
-#ifdef INLINE_COPY_FROM_USER
 static inline __must_check unsigned long
-_copy_from_user(void *to, const void __user *from, unsigned long n)
+_inline_copy_from_user(void *to, const void __user *from, unsigned long=
 n)
 {
 	unsigned long res =3D n;
 	might_fault();
 	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
+		/*
+		 * Ensure that bad access_ok() speculation will not
+		 * lead to nasty side effects *after* the copy is
+		 * finished:
+		 */
+		barrier_nospec();
 		instrument_copy_from_user_before(to, from, n);
 		res =3D raw_copy_from_user(to, from, n);
 		instrument_copy_from_user_after(to, from, n, res);
@@ -153,14 +158,11 @@ _copy_from_user(void *to, const void __user *from,=
 unsigned long n)
 		memset(to + (n - res), 0, res);
 	return res;
 }
-#else
 extern __must_check unsigned long
 _copy_from_user(void *, const void __user *, unsigned long);
-#endif
=20
-#ifdef INLINE_COPY_TO_USER
 static inline __must_check unsigned long
-_copy_to_user(void __user *to, const void *from, unsigned long n)
+_inline_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
 	if (should_fail_usercopy())
@@ -171,25 +173,32 @@ _copy_to_user(void __user *to, const void *from, u=
nsigned long n)
 	}
 	return n;
 }
-#else
 extern __must_check unsigned long
 _copy_to_user(void __user *, const void *, unsigned long);
-#endif
=20
 static __always_inline unsigned long __must_check
 copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	if (check_copy_size(to, n, false))
-		n =3D _copy_from_user(to, from, n);
-	return n;
+	if (!check_copy_size(to, n, false))
+		return n;
+#ifdef INLINE_COPY_FROM_USER
+	return _inline_copy_from_user(to, from, n);
+#else
+	return _copy_from_user(to, from, n);
+#endif
 }
=20
 static __always_inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	if (check_copy_size(from, n, true))
-		n =3D _copy_to_user(to, from, n);
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
=20
 #ifndef copy_mc_to_kernel
diff --git a/lib/usercopy.c b/lib/usercopy.c
index d29fe29c6849..503a064d79e2 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -7,40 +7,18 @@
=20
 /* out-of-line parts */
=20
-#ifndef INLINE_COPY_FROM_USER
+#if !defined(INLINE_COPY_FROM_USER) || defined(CONFIG_RUST)
 unsigned long _copy_from_user(void *to, const void __user *from, unsign=
ed long n)
 {
-	unsigned long res =3D n;
-	might_fault();
-	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
-		/*
-		 * Ensure that bad access_ok() speculation will not
-		 * lead to nasty side effects *after* the copy is
-		 * finished:
-		 */
-		barrier_nospec();
-		instrument_copy_from_user_before(to, from, n);
-		res =3D raw_copy_from_user(to, from, n);
-		instrument_copy_from_user_after(to, from, n, res);
-	}
-	if (unlikely(res))
-		memset(to + (n - res), 0, res);
-	return res;
+	return _inline_copy_from_user(to, from, n);
 }
 EXPORT_SYMBOL(_copy_from_user);
 #endif
=20
-#ifndef INLINE_COPY_TO_USER
+#if !defined(INLINE_COPY_TO_USER) || defined(CONFIG_RUST)
 unsigned long _copy_to_user(void __user *to, const void *from, unsigned=
 long n)
 {
-	might_fault();
-	if (should_fail_usercopy())
-		return n;
-	if (likely(access_ok(to, n))) {
-		instrument_copy_to_user(to, from, n);
-		n =3D raw_copy_to_user(to, from, n);
-	}
-	return n;
+	return _inline_copy_to_user(to, from, n);
 }
 EXPORT_SYMBOL(_copy_to_user);
 #endif

