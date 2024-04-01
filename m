Return-Path: <linux-kernel+bounces-127102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857568946B1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A969F1C2161B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034A554FBE;
	Mon,  1 Apr 2024 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LicG1RMm"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC551C2E;
	Mon,  1 Apr 2024 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008005; cv=none; b=eFvTonKSujmvPkCLKJXGJ695nhbMlpcI/avERa+Ba4jWh9FKCgfoxpTTznQZGy+rdRA/0kgONwE9BrzPJzuMgomAompbM2Vpb1EMkbYIbgZFc89a3FrnOdAMaGajt10qbUEG+C0iZmAP3IH4PboerMkbMqi/aPaNhiXpUY39x8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008005; c=relaxed/simple;
	bh=lga2qVC6bx434ILieAy8p2z4iLgehhtKZVAlm+C3omw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4vcTRAXLcRKHuw+x67ze72X7a8LrROPSOwvlRKiECH4dDimIHG9/lzrbFYD2hChZLAkpVxPS/9NjJAhHyLFOc8wUAsi4/CryOV6l07rLS/3OV5P0ox8q2Pc3bw7ZWoQom+exaE61/WHloYvP9ca+xCSqAlg7cFFJXhnOs6NbH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LicG1RMm; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-432fe06d76fso4733761cf.3;
        Mon, 01 Apr 2024 14:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712008003; x=1712612803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J7lSE+wLlV3A/nFCxQIWYeydbyIlsHZV9kGDRSJJqRs=;
        b=LicG1RMmPvJgno746Ls1Yq/b5s4vDKy0isUFXX5/ULCcIvV7iv9Y428yVfVB62mBCa
         eaXzfAkNafaaF8u2ETdsQn/hnsZBagNd/XPD9NKKI5ZLkH5i2dMLRwuoNfSx4zCT1lVQ
         C99ToilLivRZeVF5KDGp80wUoMnbhI7gNHqACKALvhTFIVH2X5jfav8LXvHfBU05mICx
         zvmSOyTo/mQXC6+zhe0dwq8NnwXq9jJ/7VppK6kInJLzvQMf8LUYhwgkCPzVbnkQAMuE
         sGhKKcQyZ8kL/+a8geMv6McY6s4l/KEM7StlnxILegKQDrj+4gIWLD59HC51kJhfwdv5
         WlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008003; x=1712612803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7lSE+wLlV3A/nFCxQIWYeydbyIlsHZV9kGDRSJJqRs=;
        b=q/TBEkCbyC4G2CR8s8MhzoyDYwqe+YXnkbaOX1kveMhzKGRNYcJYYiq3J6TKA8eOAw
         GZqfkEx12HDSH/bZw3boZEn82NcveK5XkLY0YxKCmMYTWzXykJRlZITojc6bpexgB3KA
         fHzQ5DLtEZspXX7OiMww2xtLUf3yYX3Dyl37qox9vQyxfkWaLsXmQURCMAdAxzaiCQkr
         wjq4ZQLkqrTboBubJPNhhCaCozgg1c/bY8YCpBxbCS6PW/1HWR9m1PSfnog/oQfD/do8
         R6fVNXzWr4wW07gADkiTTA36E7c0l4qBPaA0qE0cmCAMnKxfmuyQ7zxkWHC6Tha6Zrub
         bZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCVq9MGuTQqfrt0NfSgFA9aoMKjTfRlo2KSJwBxfDLQ8MsCBcbGdx06PIFiGX/Jkt7xUMfppf8SpFWF08w5fYfpJaJDrQAGYCe74FpiI
X-Gm-Message-State: AOJu0YzYSOaOV9OEXoj5VbXuaRKNqQO7l8JcmOk95umeOoswyXLr4Qr8
	1+g7NIgsMeL/wAh8o6RbKU+8+IRlLTpjBJ6rwGLCSZm87ANpDqjskc1NLUS5
X-Google-Smtp-Source: AGHT+IGkGhitdL0UaeFnAewaTn3YCx6nMm4o7HWPHNpZJ8jr8NSOUIc3RxRlXBlWkTeZIrIkh5OpTg==
X-Received: by 2002:ac8:5e0a:0:b0:431:3fee:9d53 with SMTP id h10-20020ac85e0a000000b004313fee9d53mr13034473qtx.24.1712008002746;
        Mon, 01 Apr 2024 14:46:42 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id et16-20020a05622a4b1000b00430b385f721sm4908999qtb.15.2024.04.01.14.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:46:42 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id DDD321200032;
	Mon,  1 Apr 2024 17:46:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 01 Apr 2024 17:46:41 -0400
X-ME-Sender: <xms:QSsLZvnCN0e55lIsGFseg3oI5CMqArkOyDBC4diS3QAwQMJOJBn6YQ>
    <xme:QSsLZi3Wa1-Z-HkvgnLifSPxZZOjfL6sA9sfg0G5CAsjwcX_-Khr2ztcTdllm7YWI
    maLftBDxA9yfzsHCw>
X-ME-Received: <xmr:QSsLZlr3MvJLiQd726F-kQAk2BcfGnJW0UWE8IluEtDu4d14T29aIwY1IU09fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefgteffhfehjeegtdduieffudetfeehgfegudejudfhieefgfeigfevueduledu
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:QSsLZnmZyUHVKKaIfDDtBTt-F1HnNAVm2A6Iw03ObCVCmhRLOZ661g>
    <xmx:QSsLZt3SiMhUGsdmUBYoF8del72n3v3zZU-swQjA5vcKWKz1mTwhCw>
    <xmx:QSsLZmvyVtro_8RrotE7Vh2V1lCG6oFaoAKQ9Dty9TG7pvMqs9MsZQ>
    <xmx:QSsLZhXrEsxKWNg5yXrRmgNP1YpMXzB7LPZukx2MpoBD2sTo21lO_w>
    <xmx:QSsLZs1rFswAJL8srQsak3IbW8vW1BFqAxa36poAf-5Zjwu-790CU3nLpJQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 17:46:40 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Obei Sideg <linux@obei.io>
Subject: [PATCH] rust: types: Make Opaque::get const
Date: Mon,  1 Apr 2024 14:45:36 -0700
Message-ID: <20240401214543.1242286-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support a potential usage:

    static foo: Opaque<Foo> = ..; // Or defined in an extern block.

    ...

    fn bar() {
        let ptr = foo.get();
    }

`Opaque::get` need to be `const`, otherwise compiler will complain
because calls on statics are limited to const functions.

Also `Opaque::get` should be naturally `const` since it's a composition
of two `const` functions: `UnsafeCell::get` and `ptr::cast`.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/types.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 0949f9971074..25953c8f8acf 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -315,7 +315,7 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> impl PinInit<Self> {
     }
 
     /// Returns a raw pointer to the opaque data.
-    pub fn get(&self) -> *mut T {
+    pub const fn get(&self) -> *mut T {
         UnsafeCell::get(&self.value).cast::<T>()
     }
 
-- 
2.44.0


