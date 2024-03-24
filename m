Return-Path: <linux-kernel+bounces-112882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75F3887F7B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BFD281289
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099663F9FB;
	Sun, 24 Mar 2024 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY25uz8f"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33741A38D3;
	Sun, 24 Mar 2024 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319660; cv=none; b=IdTNCRD4R1MxtGjab6Ht/dJHskgypREta1yBT5Kq6t60z6awZQWgqUu8oN0IzQigLo7X1UuX0C08oMCB60acm0FUagv2BapyqVqUqCImhcQPzbRj2ftZ7IdlVmg+cn+gTQv0AhoykKcpLgi2mT3EjGKzGasmLtwbPZc+pVSK5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319660; c=relaxed/simple;
	bh=T8jE1fNZfbPD7fRxzoZy3IXaoPYSqWA6sjSsFVqxxLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTP2F0KPHRz1ea5P2Pj6HF9H3TXH44yvpeTBVpnoKxbcevCluS5JiEnEU9y0Xp09bDhkwYP5NVyrodbz9rfBPvLQFz8JplwcKsBc9IFI4H7UdKLnGBq7ggXoJsth6k/JgkREmG9qVtK6uKZnkeMlWjagcC7v/Hio49DuCxTf08I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY25uz8f; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78a5580333bso29496985a.2;
        Sun, 24 Mar 2024 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711319657; x=1711924457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8vg6DKo7pmohO9e53wVPKI3PJtqwPw3kiGTVfZV5+Bk=;
        b=OY25uz8fllWafBPnMi/tSTt+NGPNSLNT5/19vxVFszFm8arBv9txzwzG8TRvpSarj5
         vD3yCkC5M3zKz8+wszvviT9fQbH4DoI16zaSXunCcMv86esKMnzuGI6spk0Q41E+xyzj
         FBlq7MsgyiZVsgXOb4soiKi8guO3aD/Sem1BA2B7qDCQNDe4bUWTPuiUf3A1BqD5WnnU
         X+PlaKhmowRhRL0vgxlzyAoBIOsME8GnvwL0LoMq4hCc1t0pqPSI+gysD+nfO0KPz6Lu
         /2rBZm7IXp+Yo244E23Nwa3weDsOjj1ccZj87iYady47n8IaaFPZoynEKkv09zltH3Q3
         /e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711319657; x=1711924457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8vg6DKo7pmohO9e53wVPKI3PJtqwPw3kiGTVfZV5+Bk=;
        b=dwAhYvajDK1qmQbBZKbGAu6bm6fu6LNi3Qwkuetr/CE+ba4YxPx6FoOdzBqt5lrPs8
         gnrG1L/uFJqPuaiCxIyzb2XQ+3KK0ym9FXdFiFcjXcMwQm0Sxuog0IYgp77LO5LEaP8b
         M1D3yIr646g82AqYGN03M+iybtCnuZ4dtfAxvaujnjqMhXh704bTR/lUIafDkFr9jL7R
         9ZRvNr/HyuVdPbfHg6u+WYaUL8gHGKlan29bWOP24EPRiN+QmZOnkyocRBB/shBv15Oy
         xdEAvAK7+COhwMq3bEfsV8FBJlVviCYjHo40NS7z3UeMRSzBq4LU+2qAbBpA9Tqa+Zep
         V+zA==
X-Forwarded-Encrypted: i=1; AJvYcCU+ZPGGngwBVbDKqKa83BgRPWtyWneKt1h8hfDsStW9VtQuxnvZsJtWEbfBA5VbB8WV6lFqfNYPCmwgGWHGbizI+hCB7JgGk6th7lqP
X-Gm-Message-State: AOJu0YxGwtM383GXYQH0zc3GcGPOfx0NcZS8D0WAI9Feh2ov5q/puc+w
	AdG5HHT8jCkhkYG6PBRc7xLCgh39E8eWGZVRP9huqSkQOedtFx0s
X-Google-Smtp-Source: AGHT+IGspEUpnu/ZPsX/qIFQsL6kaiAPPv2KtchS+uvNToGluKWw7BWFObL4Oc4kqlya+VW8yWG6OA==
X-Received: by 2002:a05:6214:f07:b0:696:7ff4:7f09 with SMTP id gw7-20020a0562140f0700b006967ff47f09mr5468198qvb.54.1711319657700;
        Sun, 24 Mar 2024 15:34:17 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id q1-20020a05621419e100b006968077890csm1588628qvc.118.2024.03.24.15.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 15:34:17 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E32DD1200032;
	Sun, 24 Mar 2024 18:34:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sun, 24 Mar 2024 18:34:16 -0400
X-ME-Sender: <xms:aKoAZjls6ARdyUjLUWMH1atcgWAYB7gUEaV6s9EhBIq3HAH56Szpcw>
    <xme:aKoAZm1ms2LD2tSn-ALyZrMFuklul8yvW7igx8P3LnHW2qQHNylooimW5gaOcDC2O
    WiNGycWKkeQ0KA_iA>
X-ME-Received: <xmr:aKoAZpriRB6sIctfGpUs_gYbJ-aQ3v6w1fidrN1oMFmV-qsc2Wv2sEFmjkY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtjedgudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeu
    heeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:aKoAZrlDxn39ZFG1dWd8PyT42H1B0cz8OsrAP-P6xuY4FfmtyBizDA>
    <xmx:aKoAZh3QEsc0GffCh3dxr0ahrYZFKXZS4FaNW4t72RrK4cIrmvOguQ>
    <xmx:aKoAZqtGnyt-HoXGrr_IpRhb_Q5OYQAjgZiPc_ccWT0jP1fdtZoAbw>
    <xmx:aKoAZlVKkI5zp3SUdPt2n1h2PvYsQGOhMM7n3ZAJuy17df7NP2SQuQ>
    <xmx:aKoAZg3m6uigRuY3Pgz__vHFUNLGYYrxIdWifj1-rbFkHspo_Nta3Vb3XNs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Mar 2024 18:34:16 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	benno.lossin@proton.me,
	Andreas Hindborg <a.hindborg@samsung.com>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>
Subject: [PATCH 1/5] rust: time: doc: Add missing C header link to jiffies
Date: Sun, 24 Mar 2024 15:33:35 -0700
Message-ID: <20240324223339.971934-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240324223339.971934-1-boqun.feng@gmail.com>
References: <20240324223339.971934-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The definitions related to jiffies are at linux/jiffies.h, and since
`kernel::time` provides the functionality dealing with jiffies, it makes
sense to add a link to it from Rust's time module.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/time.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 25a896eed468..bbb666e64dd7 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -4,6 +4,8 @@
 //!
 //! This module contains the kernel APIs related to time and timers that
 //! have been ported or wrapped for usage by Rust code in the kernel.
+//!
+//! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 
 /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
 pub type Jiffies = core::ffi::c_ulong;
-- 
2.44.0


