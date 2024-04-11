Return-Path: <linux-kernel+bounces-141696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF868A2217
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58901F22A94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE43E47A64;
	Thu, 11 Apr 2024 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cct4EbrX"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82B117548;
	Thu, 11 Apr 2024 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876891; cv=none; b=raodqTsAOVMz7qg+sbFYilgHXdlP3x0hk8HKBQg1tfd9XLoJwAhwvt/sCw7k/eDPVhwvep+BaRR/y0dU7Sr1wzy2KAC3Pw7DARlRUMoUMOam1hHA9N/cwvZxYpvtnxT9ZxOE03f5/0khQG5qJLFkxc17bm7UAK1BzJp1ES/DgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876891; c=relaxed/simple;
	bh=yyEXYPze8uZ5thnia/9sxtO7LfchZZwIldq33a09W+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DOws3wa3QaITra9aGfB7rEHwDr4hl/TR9Xj2pYTJbd+XdT++/kiDpv6EC4JPyJsURuo5y6U5xfLTFv2xgBPZpR3xQaX5vly0nAdjSSx1kwZuN/VR6PB8/xgWZ9WEP9+C/X58nD21q5n0NVn+BwUTwZH2egvXQAfrPQ49qQzapjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cct4EbrX; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c60019eecaso135935b6e.0;
        Thu, 11 Apr 2024 16:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712876889; x=1713481689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z4VD5/9zo7KV17BZvJcdbOVBBYiGlJUDhdbd0e1T+qM=;
        b=cct4EbrXh8Aeg6xljif1oJHoRO02uyO5vnJcP9DYddW9i/2axxfS2NcuE72ic2uYzx
         3tsDhwmLChu+nh8j3qv+TVNoOrHLLPta+nEppFf503dKe3JhEUvvlRXeUcZ+4oU7EivG
         EAxhGSGEyCcjoyelh3E8hdNfZdP4kE7pHw2ZfLKwEy/DmMi/keWo00eIV8pxWY8rceAg
         H2XdFSzX7cF6xL+HxRSQ0loCVtulhnJy76UAaik7eyRhTW/+QJmSyAewe8MHzljG7sfw
         nJhU+OCQwg9R1b7hUVe9AJtlHfBpOK3gWQHEh85iTIqta6/JublOiQcMcV7YxfWXtG2B
         jo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712876889; x=1713481689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4VD5/9zo7KV17BZvJcdbOVBBYiGlJUDhdbd0e1T+qM=;
        b=EGrDDjYHadIXjAAX8kuq3rLQ5trZP3OLamBYd+tRuf11tdK2KjZKIhf8btkUOVi6fB
         GGq9yEroiy+l7penNEaomPVBtRxZJEprudFEgIJK10oW11qOJzjYHUhQz7A1dK886OFU
         +i4HUrfSVWyrOLn8XZlJpE4wZx1Iy6S4/UDuB38oRhXmlQ3ICDZKSEiZCNSIxyCr8ar8
         CMWNEbuHSAPGMOBDRdjM8KrjJ/mGGayeFE8gIR780ozgiAZafFlkBRfz8iRVNv0vwhwm
         4clbsPuRQ5GpgrDr9P3zl1+Y7EJno1gKMz4iRQRXH2ndN4XXAAykJR1BCU111oqEIdMi
         lNjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU49GC4tEvqmVm2MoSzo6S8Q5uncKP++8Nq3okt6SHqbIDS2349ClzOFtlUw9tKU6Tmrv0CbU/qa6y4sV/ORQGNfQPnFWDplJOTbBZEbmTsSwox/iB4VGNXIzJgbf/dpLJOq10W5pdDalAsh9s=
X-Gm-Message-State: AOJu0YwZbq1Bxa6SO7qTRzN2BN5HtZpGNe0IbvggnzGSnQzi5R0clhpF
	HPBfP+RkQQhyw5P8IoOaafztBtWcbqnCbIoUzSk7Jeeb9p/PKd3w
X-Google-Smtp-Source: AGHT+IEd6cnBDzdJeL2s2EGC1QEEHG2ZpVJOjxQXUZkSZ9PmDlkgx1ZX1Bb/98aQ3JeG8EY/K5SeWQ==
X-Received: by 2002:a05:6808:4342:b0:3c3:e0a3:8042 with SMTP id dx2-20020a056808434200b003c3e0a38042mr803769oib.40.1712876888727;
        Thu, 11 Apr 2024 16:08:08 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id j16-20020ac84c90000000b004343f36ab58sm1478992qtv.81.2024.04.11.16.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 16:08:08 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id AB25F1200066;
	Thu, 11 Apr 2024 19:08:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 11 Apr 2024 19:08:07 -0400
X-ME-Sender: <xms:V20YZvKaRTlpysiYtjzPFwi4ZF7NACDCaQsMQ9FV5bJQ1v1LKJQu6w>
    <xme:V20YZjKB5uYU41M7izWRE8behpnDg1cH4G2JWxq6hDUubffbJ5xVGhK3JRkYgQPjo
    fYXkkCzMJl-iU7aZA>
X-ME-Received: <xmr:V20YZntGsNVP_1a0FHtmWhSZtPM9wlosJPqGAfTjXFgF8j-lo4SHsmDdiF_pVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehledgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefgteffhfehjeegtdduieffudetfeehgfegudejudfhieefgfeigfevueduledu
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:V20YZobwp0PQZr3eTKAWxqe6MCOYcySswAZLUOH593I12uny0EPB6g>
    <xmx:V20YZmaRZdw9qEvQav-h482lnfLCuZb5fsKYOh7cG05XR9zsSRw6oQ>
    <xmx:V20YZsAozxa7tX_BLqqgImip4aLwmAH6ey7wFvRJV1MkLGJNQCaTEA>
    <xmx:V20YZkZrbliLdurgwRb1-AAdCoenu5bs9dPZEoOHnbc4USM5m0eYuA>
    <xmx:V20YZqpdnXyCUznJCkoe5Qy-Md3VGcgMSbAj9ly6i-4TL82pNgpXRd6h>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 19:08:07 -0400 (EDT)
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
Subject: [PATCH 0/2] rust: time related cleanup
Date: Thu, 11 Apr 2024 16:07:59 -0700
Message-ID: <20240411230801.1504496-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas & Miguel,

These are two tiny fixes/cleanup for the kernel::time, the first one is
adding missing links to C header files, and the second one is switching
to use wrapping_sub() for `Ktime::sub()`. The series is based on today's
tip/timers/core.

Thanks!

Boqun Feng (2):
  rust: time: doc: Add missing C header links
  rust: time: Use wrapping_sub() for Ktime::sub()

 rust/kernel/time.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.44.0


