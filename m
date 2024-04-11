Return-Path: <linux-kernel+bounces-141697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50D18A2218
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4751F2350B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9FD481C6;
	Thu, 11 Apr 2024 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVGKuMVg"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3919747768;
	Thu, 11 Apr 2024 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876892; cv=none; b=QHhvzXfF5k+lAWcSHPEFZPbbOKchJi5qXBC8ml+Rxv9icfOwrESfpDs+aw94noyvk7zHRgWz+EUYe3++Tk5RG5yQxndTvLRrHz+R9PSI5WN2Sf7hb0Eq6M180LYErtHDmvGxJLodBrgQlItcbMm5Pgq1X3/jXn/AA4TJdyt8J74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876892; c=relaxed/simple;
	bh=qDhteLf50yECMlgCo5DdnnD4LXN20q1SIVpQkLp52YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9QJoXwv61wOSY71qyuRDBrWSeL7k+M6imVtQeYh/aBQyjoCIvw48agU9A/qG2HsfFiElkFk8xfpOvDCtzU9w/iVmzhxdRygJMoOTWF/FV38ehwApgX4+nIr5JBrDQdCYbxR9GuTxvcGO4SQkiRaQjv3bcFM5nx8/aSwqbsy09g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVGKuMVg; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso367531276.1;
        Thu, 11 Apr 2024 16:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712876890; x=1713481690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BQI2TKoyu8BDgVRKtOJlJn6MKKOUFwvO4itwrjVwbqA=;
        b=FVGKuMVg84Eh+NQpoEQo2OKPiV9Yjfd9mydZGv1MmA+SXEAWNBXvpv9fTeJY+yGae3
         yq5l1SUe9FCBIfbTrtwMdGgVTT9t0PozxS05HNrfuXoKM1qIUXUYl40rDS/szuMzkiO2
         CxAPg/MVHrDQzJOlAOYkircb6Hp3K+65j1axLts4szS/hekv/tsl+zWMyApADFJM1a0F
         J1vhL7lzlCByM0k5bE3arj9llp1N1T7GDMyu3aPiwABXVBGxyoc9/dvM+WEj4rAgOBlf
         3dCF0xsKGKFk8WlpozdDe38l7e5LbT54b9BU2VhIuTPnpb9gwzUgVMmJ8r9KWQptxsw9
         H7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712876890; x=1713481690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQI2TKoyu8BDgVRKtOJlJn6MKKOUFwvO4itwrjVwbqA=;
        b=WoaC8n+rnD4GX61Dlw17ntCP8g3LKQN/xaMGB7gYqdwu9xbp18oCY9+Hx9ssU9J4dM
         Isvd0buAWlvzcwh+RtLP3f5qq4d0TQ7w+KzkuJQ3wD7h0sO0i2k1SxfQ+jz9RESjgrG4
         +5t3/k5edlpMJAPxvoqqnYAsdmLATa+3zVV31khWEPq230FmbIMd2giBx77IBnSUPfe0
         0inwZKctuBZVSMH1JNTYijG21NMlfscxXmrTyj7UOtJ8avYC1tZFq2KPSM83tBpoYbKg
         /fELq9RXSuhJEWrdc3QGVN6xIV1xeMn2fAn/KAbxew9nwaYqpkNVS14Sp0KkMwkX0P9n
         XBcA==
X-Forwarded-Encrypted: i=1; AJvYcCW0XYkMTKHBMeB2xBNDN2MmM51uynfsrmVj+FmLgO4C5PHaRVx5GsLi9jpcgXjgsryquAMLdl4uKE/b1nr74r6XdUpQkG+lmGN64qBFYOPxu4sf0T2X0C3yu6VKhNTwTZoOAlDY33diuMVj2a0=
X-Gm-Message-State: AOJu0YwL7a9VVj27RJM7/d5yqhhNBDFdbqapiXicunjp3JIJ/tkrb1jt
	oVRyG00+pDyzfGSzSvxfmNLNt/i6/EdMiVZrA3jDlwpp4pSMz8/e
X-Google-Smtp-Source: AGHT+IG7487kc7xE3+S4pw61eQvvVZEg83y20evmhUXciSVxn+dwp3BL3crRYPocXeomCfDD5CZkAw==
X-Received: by 2002:a25:8c10:0:b0:dc7:443d:d9da with SMTP id k16-20020a258c10000000b00dc7443dd9damr1056841ybl.4.1712876890082;
        Thu, 11 Apr 2024 16:08:10 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id u7-20020a0cdd07000000b00690c9256676sm1526056qvk.49.2024.04.11.16.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 16:08:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 2B0C11200066;
	Thu, 11 Apr 2024 19:08:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 11 Apr 2024 19:08:09 -0400
X-ME-Sender: <xms:WW0YZgnLJl-pZ3QSTk4oZpao6QpsqG_r725u00V1w18HNuiKSDIcVg>
    <xme:WW0YZv2kMKCwKUIvyZ82nG_0oh0tgEJqb63U3ho7GEES_npvybKTnXK-VJJ38to0n
    _4mVUJdQgi66jx3Lg>
X-ME-Received: <xmr:WW0YZurljV-5pGojl8PozP9-SXzZH1hWtdXxRiAa51-MZgWv9YhYoJJEKtn9sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehledgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:WW0YZsmMllCZMXvUp9K0nJf23eJTp2aVrL300MLJ9ztoB4tP1rYcPQ>
    <xmx:WW0YZu1LJuacucCZddOkWxjnXCnp2TuzMwMWK537v4kyiWkYdniNMw>
    <xmx:WW0YZjve52viMVUBcGgqdEudHFz85u1ftJCRofXhItYQMKCTy-FWdw>
    <xmx:WW0YZqUyZL7Gu8gT8AApT3rbl_9Y3i4RKayTh_BTt2PV63poMldoxA>
    <xmx:WW0YZh2b9uQevxngxVY9gklig-1UD1pWc7DDrnv9al4sonH4VHkLY4Kl>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 19:08:08 -0400 (EDT)
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
Subject: [PATCH 1/2] rust: time: doc: Add missing C header links
Date: Thu, 11 Apr 2024 16:08:00 -0700
Message-ID: <20240411230801.1504496-2-boqun.feng@gmail.com>
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

The definitions related to jiffies are at linux/jiffies.h, and the
definitions related to ktime_t are at linux/ktime.h, since
`kernel::time` provides the functionality dealing with jiffies and
ktime_t, it makes sense to add links to them from Rust's time module.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/time.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 6811d5cadbd4..e3bb5e89f88d 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -4,6 +4,9 @@
 //!
 //! This module contains the kernel APIs related to time and timers that
 //! have been ported or wrapped for usage by Rust code in the kernel.
+//!
+//! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
+//! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
 /// The number of nanoseconds per millisecond.
 pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
-- 
2.44.0


