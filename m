Return-Path: <linux-kernel+bounces-123528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DAE890A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1941E1F271D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E5113AA22;
	Thu, 28 Mar 2024 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH6gbo5z"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A284B137C26;
	Thu, 28 Mar 2024 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655715; cv=none; b=le2xP5YTPEt59j8kYrfqtJlN+hgPbWDS/JCmuyQ0C4dBrblWswndSaPs4wsZ5CHYYV/4Mc5yz6NZzylOU/SrhlYW2v23TUJzdpfV9fanDJnINyiYl3rNZe/On454hORaP+IQ23mlPk87vToSV8zSFNkKZnExfeqO9TVFHEMk30o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655715; c=relaxed/simple;
	bh=nZaQEnidgOuWecUtT416/mVD/axNf4qn18t+llX9f5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cK4e87GFq6jhj6yx0Ufbd5ezjXjpBY4B+D/I9MvZzEb6iFV4B2UiuGCz/xud/HDDSER0gTRWkO1SVWWL7a4MKi+8aWqjB0YhindSBm+c6FM6rLEdVLfaokIwReefEKS+CQGd7zUNliNpIhibVQwnlU+PgPmrZZmA2Uaj7uec834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZH6gbo5z; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e21d1e8307so5560255ad.2;
        Thu, 28 Mar 2024 12:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711655713; x=1712260513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uty8UkCKWRel+6ILHWv9WEZYPVQazLXowk/xRzK5PO0=;
        b=ZH6gbo5z3N1WeOw97l9FCM7MhNJPhJL/Rbwanx3Ij+BIdWR1/Q4myqNrZoHnB8uyMq
         H8S1/WKX12gKdGYcz1Gf8n0oFUTEoy7G6ALKxqWd6WeVx3geLdGeB43JZSdxdRG9Nroq
         354M1Vw8kr/7x5R6ZkfTrT/ZutxEs3S/zC57t4CAKuAAgfwIrJ3ha+zjMRCBMzqJiAP/
         0o70CxOqXpnvIwOEefMxRgQKpB/2vuVIF+qoe1UZIQC0MRSqLdSka5+od9k8/BPUqJhc
         y1oAl1s8AzbgyM7a80wKkTK2ZpP8zCCww9cu0Gnbnj8l3z3j9QwTPBR3XQ5ngudcZPF0
         Zrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711655713; x=1712260513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uty8UkCKWRel+6ILHWv9WEZYPVQazLXowk/xRzK5PO0=;
        b=gf3LSXGme5/nQTyEdoKRd7PMdT03kQZF5MCyBxDHnTOdgcGlgOByz411jHAQ4iPnCT
         O8a4fvhXEr/+F4u1Wr7Wuj6CUWYGKysigNTEjmvO3TLLAEfx/8kCvAS/EHNURQF5MFK3
         OLqJDVgxwxCMJuO8NsHaOz/iiQLbK1/tQquHLqF3tSgxgs8rnbS5Bd9rF/GOj62c5pCm
         Fv30u14l6MeqcaCuSQwDWjFH0JWJgniJlK2uh3h1mJBzENbPv3i379SSrWQ4/Wt2H8jX
         013pAhKllOyoSsRCYuF1b6l36nfHGOtbBwRnLNojknJ3rv9U/7fVJA8wxg9j6yy6glbu
         yTfw==
X-Forwarded-Encrypted: i=1; AJvYcCVaA3Btkrj+gQvZ3vEhvX7GyiIQKEAhiAZlsg0T9g+lIfMy9YXXx2v6QfrEfwxPiyAEUVHhpkWaPQQSf96JYZq6cNvJ/sOpbWThF11R
X-Gm-Message-State: AOJu0YywRPZrHaidJKMd/L9UdkzQVpoYVE+GVsDiHMDV/Xt2zNCnqR1/
	9nVRBFb8jarjPRWDtJ/2uOAZpg6PC4mTOCZNx6QBSHbTEo0Szk76TF0ogk0f
X-Google-Smtp-Source: AGHT+IElnhBk7d/VB908EFbFbv6uktbtDvC3+sx5GgszAqs583nTVEUNlKwm5IQm45b6KqgF3nKS8Q==
X-Received: by 2002:a17:902:9a0c:b0:1e0:342b:af6f with SMTP id v12-20020a1709029a0c00b001e0342baf6fmr531706plp.16.1711655712685;
        Thu, 28 Mar 2024 12:55:12 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170902e75000b001dd7a97a266sm2006520plf.282.2024.03.28.12.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:55:12 -0700 (PDT)
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
Subject: [PATCH v2 0/5] In-place module initialisation
Date: Thu, 28 Mar 2024 16:54:52 -0300
Message-Id: <20240328195457.225001-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

Introduce `InPlaceModule`, which allows modules to be initialised
inplace, as opposed to the current state where modules must return an
instance which is moved to its final memory location.

This allows us to have modules whose state hold objects that must be
initialised inplace like locks. It also allows us to implement
registrations (e.g., driver registration) inplace and have them similar
to their C counterparts where no new allocations are needed.

This is built on top of the allocation APIs because the sample module is
a modified version of rust_minimal, which would be incompatible with the
allocation API series because it uses vectors.

---

Changes in v2:

- Rebased to latest rust-next 
- Split off adding `Send` requirement to `Module` into a separate patch
- Prefixed all `core` and `kernel` references with `::` in
  `module!` macro-generated code.
- Calling `__pinned_init` with explicit full path.
- Add `Mutex` to `rust_inplace`  sample.
- Added `Send` implementation for `Registration` in net/phy.
- Link to v1: https://lore.kernel.org/rust-for-linux/20240327032337.188938-1-wedsonaf@gmail.com/T/#t

---
Wedson Almeida Filho (5):
  rust: phy: implement `Send` for `Registration`
  rust: kernel: require `Send` for `Module` implementations
  rust: module: prefix all module paths with `::`
  rust: introduce `InPlaceModule`
  samples: rust: add in-place initialisation sample

 rust/kernel/lib.rs           | 25 +++++++++++++++++++-
 rust/kernel/net/phy.rs       |  4 ++++
 rust/macros/module.rs        | 36 ++++++++++++-----------------
 samples/rust/Kconfig         | 11 +++++++++
 samples/rust/Makefile        |  1 +
 samples/rust/rust_inplace.rs | 44 ++++++++++++++++++++++++++++++++++++
 6 files changed, 99 insertions(+), 22 deletions(-)
 create mode 100644 samples/rust/rust_inplace.rs


base-commit: 453275c66aa4d87c73c5152140b3573ab2435bb7
-- 
2.34.1


