Return-Path: <linux-kernel+bounces-141698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F88A2219
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC43B2092B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29084AED7;
	Thu, 11 Apr 2024 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc0LHZjH"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B328D47F51;
	Thu, 11 Apr 2024 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876894; cv=none; b=DQUTwoZdPq4Q/pl5tYqKDZ2d2zvbUe5/H+WSJHI8xWpqwCDYR9n74dMVGND9qQx/wnQXnf/hLxjmsfxdkka7LCYj/eCkEROFIDanVSPTAXdtc3gThOi5EaF9JRN9CpvSdHrKKTsUiBOZN38El9aUebTGKTMXw5Ey+eRnClXjYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876894; c=relaxed/simple;
	bh=YGi08gU0thy2xo5L/Jd2ML51rJYD3cHypCbeOJyorH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtTHJL4IZ/mMEQiR1w9O8wDt3p+JK2B0ysnkonvbNEv2etGUzE1l0GVA0VSfCOqLCqM+V3NmRHQCHLHPC5K9k6CEW2bCAr3JKIGMBdrdmlo2eIXUnrv05HKyhtNGqPFmk8DUzaNHgU4hp1FpZycinH6azm8ovaz4iUvnTx4nIl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc0LHZjH; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-434832aa162so1246851cf.1;
        Thu, 11 Apr 2024 16:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712876891; x=1713481691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1cp6Y65O98WYlbmp5ogw9D72luMzjnNhAIcpF72RIPQ=;
        b=gc0LHZjHgdfkz3zXH1No0O7X+blRnls3JAsJtxUo8cHZGuOTjQSbnVp5x5Xz6oHbRV
         0NVmKrgf8s567991xYwlQXrHR2EO0AAQWlgLc3RIjea2ndIcy8sQ06f2M+srnNIDabtQ
         KmVkhm0qKIHiAXcY7Gg7DdTF7OItpkuP/ZzOtbInB22LCZC0LRyZEysEIniCcS5CW3x0
         8tzLkdDWnnfBbiRYdU4pOyaGMMZNepk7AkFlSy2s9kFXxk1JBQbpGp04d8LK9SZtfloz
         7y2yg0eZIVt8AgZF6mSbjQbst1wyVuFOZ7PHwRmSsbDg/tCBta8pLlQ5O0ReJUE+6kkA
         Gt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712876891; x=1713481691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cp6Y65O98WYlbmp5ogw9D72luMzjnNhAIcpF72RIPQ=;
        b=Q0iM5PXTqbEM5vePQW4Lm6pjsXzciKDmydxs9ad/BfXpyq8vbsihB6r5VSuZfXouvT
         Wyl3svPLQoOVN6h3RUjf1ASNvLX6CtxUur6tdoTO4nwtnsU6rBT/Y9uRIpj07V32HkY0
         +DlQbifEULsITgEQdi7md5AOLzBUJgmUZD+nphNQEVR5AbVb7riy5od5NaFQBDepIP1e
         uKaZScZNug+K/uKqHrMMsWvaD3nTCO2y+cceNBMckbt3BdHL0i8XZRSxywhHxxHQ75bC
         Z/QuGeZrtQgg4jizRQj6aV6eqnTo4Rt1q8F4M+BRATNJDAx7pEVdzVjXaQ0HX7TMAOyy
         KXGw==
X-Forwarded-Encrypted: i=1; AJvYcCV//Hda/nqd2bW0n/IBgvwky3f6GQRcrrTmhveIhcI+91m+GIevINds7dUoF1uS/+L19GsUZVm6bQvoqFZ5M4BGw27p1i2LD/smMqUhZylLIFk1Vi/LIrOCj2hE81G1A6S/YrZleW+WTX/J1gs=
X-Gm-Message-State: AOJu0YyPwH94mARV4qvQOXX6+GgsERF0PXkAHLej0bAbwwHSihhfnM9A
	/F9iR2PEbiDqEhgMd9bIU25ebmKpbqLlgeGRybSNNfXRMl8XgNZjlf9fmg==
X-Google-Smtp-Source: AGHT+IGxLwz69pNIBHeq2xD+Wt5oG7jqgryyLf/L1g+Szbe4KnmD14+MAzru6+M0Tgl9TXZF5pTcDw==
X-Received: by 2002:a05:622a:11d3:b0:434:3c23:d84b with SMTP id n19-20020a05622a11d300b004343c23d84bmr1201401qtk.31.1712876891595;
        Thu, 11 Apr 2024 16:08:11 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d19-20020ac86693000000b00434f6c1458bsm1477812qtp.17.2024.04.11.16.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 16:08:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 8CD801200066;
	Thu, 11 Apr 2024 19:08:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 11 Apr 2024 19:08:10 -0400
X-ME-Sender: <xms:Wm0YZl29q8sE-ehJWfvleLl_6Xh3ZxDUxQK4yewCCbawV_ttl62GTQ>
    <xme:Wm0YZsFK84Nu90f-19soVqTZCZaiVGDkFVAiA1jPxRoOjDRVtoBCSIN_pkWY5O4R4
    TRpml0NtXH7GdPEWw>
X-ME-Received: <xmr:Wm0YZl6SDAPPgvRoXDeNRKheW9NiqTxL8CPc2LBSoTtETsdcU9fPiZuNrebBsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehledgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeevueehlefhiedvgeffjefgteeu
    gfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Wm0YZi0yZk8Zc_XNr7hJtypXnnNJ1IR_hbBytERqQBNyHjIx7Osptw>
    <xmx:Wm0YZoGPVyP3tAKwWIE-fFikyOeBTfat8x1Rn8MSHbxWo3iHK7wTlA>
    <xmx:Wm0YZj-cCGHqmezwqPk5t52F7Tqa1Hd0p7UjlM-PVHhU9slVlk4k5Q>
    <xmx:Wm0YZlmyvCvbz5nh-YpAWKYfTNpWavURlF3d6Wy_2i67U62PhDU2jg>
    <xmx:Wm0YZsGyUMgBMhdu9Hqy8cfGaiPhEUps7z120uXYuOBL-TRhoaLlWNjU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 19:08:10 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
Date: Thu, 11 Apr 2024 16:08:01 -0700
Message-ID: <20240411230801.1504496-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411230801.1504496-1-boqun.feng@gmail.com>
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently since Rust code is compiled with "-Coverflow-checks=y", so a
normal substraction may be compiled as an overflow checking and panic
if overflow happens:

        subq    %rsi, %rdi
        jo      .LBB0_2
        movq    %rdi, %rax
        retq
LBB0_2:
        pushq   %rax
        leaq    str.0(%rip), %rdi
        leaq    .L__unnamed_1(%rip), %rdx
        movl    $33, %esi
        callq   *core::panicking::panic::h59297120e85ea178@GOTPCREL(%rip)

although overflow detection is nice to have, however this makes
`Ktime::sub()` behave differently than `ktime_sub()`, moreover it's not
clear that the overflow checking is helpful, since for example, the
current binder usage[1] doesn't have the checking.

Therefore make `Ktime::sub()` have the same semantics as `ktime_sub()`:
overflow behaves like 2s-complement wrapping sub.

Link: https://lore.kernel.org/lkml/5ac8c0d09392290be789423f0dd78a520b830fab.1682333709.git.zhangchuang3@xiaomi.com/ [1]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/time.rs | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index e3bb5e89f88d..3cb15d3079f4 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -77,7 +77,9 @@ impl core::ops::Sub for Ktime {
     #[inline]
     fn sub(self, other: Ktime) -> Ktime {
         Self {
-            inner: self.inner - other.inner,
+            // Mirrors `ktime_sub()`, kernel defines signed overflow to behave like 2s-complement,
+            // hence `wrapping_sub()` is used.
+            inner: self.inner.wrapping_sub(other.inner),
         }
     }
 }
-- 
2.44.0


