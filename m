Return-Path: <linux-kernel+bounces-117861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB3288B094
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DB91FA53FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F7946435;
	Mon, 25 Mar 2024 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXAPgAvf"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF54654D;
	Mon, 25 Mar 2024 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396488; cv=none; b=ijti8HpfAuwXZEBxN52b+d+5UqcbxYftjaSYoyl6Wveq1ITW2XgFJyJe+ZaC5Bx/a9eZoCuLJPQ2b4yMLASlvg+DXQZGWab9LDl9K5bg4lMRaW/djvoKtG734ggpLxFeJvD/mDdchYy2xpDuVGUePqttlLW17Bnvl9DLS3Hzrw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396488; c=relaxed/simple;
	bh=PDJS0LCKHcVBTSHdWND99CZ76nchhOVLaj+dCz8+awU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uNkl6Je4PUkzz37M7T6iCmTX3uLxuwxpdpwUZsSJt3jjsjkaxsQSaNe/+rtyT/QHBy3QEYadhM7LtJJEEtPxezZP7V8zwnn0hxvxVdmIrdBtlmZPxz5eEW2CM7aH2e5EXqr6J8UAQ0b8TLRjvK5UjlmEhw8Ydha32/hyvwqy700=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXAPgAvf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e704078860so3321196b3a.0;
        Mon, 25 Mar 2024 12:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711396485; x=1712001285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TKGh+mBJ4bSqQkNDxYsl6/3gDdvQ9dd9H+apbAhd0cg=;
        b=WXAPgAvfdwvM8MCCwCr2PT3f1Ax5nw9BCwhdLZLHVhYQgLSzpRPZlmIz21W6sFUT0A
         H0Z+Zvw/dix0uUgEGIQtEcwAl926rw595kg58/2aWr+BJnzlhICyVUQioR2QGIdQ1zf/
         jXLTZuD9INyYXZ6z3P7xfsjFWWGISoVUMNP7ithspbCgwkLwFrC4n0gQqbQKNFbbZyOE
         rf8YVZTXdswWz2FBkgTGpF43SIgRdxoe8aV0H8ngD3sW23ZM4qzjRptouDVqAUXdyyvN
         ++bNEi6eluKurnZ7yMsAqRYj72wj75k/NW7pf7+iKgD87vR9CULCnmhhTtX/CZd9YkBA
         kQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396485; x=1712001285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKGh+mBJ4bSqQkNDxYsl6/3gDdvQ9dd9H+apbAhd0cg=;
        b=kzeo8xSBKu7eaveYOQERoIMDlxvRQ6nIk/555Ig4qAKLfy+1zbRkBBayo22xsNiSxL
         vcLyfYvBd+54cjNrb50aHJUajs6De0g+6rb04mWuv5NShpEwFcvaSa5kwsq25WjUoVwk
         cGgVqFOeqX4GvKH5m+OaifpaZhOrTvG8TKsnl0VfOFaRkbZQFjWe6ZzSGrJG+XrYoGcr
         hfL/78tAJUUjwwcnoe1QoHQB4wmNAQwvZ2bhzCDUrB6EwaK1yA6Q/p4VSU11Nk7PJRck
         drPbxVH1wyc4fRSva401+HYeyBsivchUApMcjW+Jkfudzj78QL1BDMFWduNeMr6TnKE2
         BghA==
X-Forwarded-Encrypted: i=1; AJvYcCUmDSS3g2yXnKdpfywfjn/DR+jwK4j8O5tDcA9YLS1Sh/yU5/G5WqZvddE46Kb5PPU6UkGRdcTGmVlDPS6B4SYYqP2+Cq4teT6oUHZp
X-Gm-Message-State: AOJu0YwQQKmoEG3/LFoHZIKghcdFqK6DEbVhe1eeBD29+xPNC0ojFJat
	lZPKRf5a/u8Go6tsoHFF8C9+T3a0nB/pxitLy/iMlttiKGtuNuBpkAjgN0WF
X-Google-Smtp-Source: AGHT+IENhWGbwBxi2k1Je3D+EGHuHF2yKXZPWGntwgjaXQahs1ZLLIScPpEVGH+NO1qhHy9E5t4ohw==
X-Received: by 2002:a05:6a21:3945:b0:1a3:d406:4344 with SMTP id ac5-20020a056a21394500b001a3d4064344mr773058pzc.32.1711396484747;
        Mon, 25 Mar 2024 12:54:44 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id q1-20020a170902dac100b001e06c1eee22sm5099585plx.74.2024.03.25.12.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:54:44 -0700 (PDT)
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
Subject: [PATCH 00/10] Allocation APIs
Date: Mon, 25 Mar 2024 16:54:08 -0300
Message-Id: <20240325195418.166013-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

Revamp how we use the `alloc` crate.

We currently have a fork of the crate with changes to `Vec`; other
changes have been upstreamed (to the Rust project). This series removes
the fork and exposes all the functionality as extension traits.

Additionally, it also introduces allocation flag parameters to all
functions that may result in allocations (e.g., `Box::new`, `Arc::new`,
`Vec::push`, etc.) without the `try_` prefix -- the names are available
because we build `alloc` with `no_global_oom_handling`.

Lastly, the series also removes our reliance on the `allocator_api`
unstable feature.

Long term, we still want to make such functionality available in
upstream Rust, but this allows us to make progress now and reduces our
maintainance burden.

In summary:
1. Removes `alloc` fork
2. Removes use of `allocator_api` unstable feature
3. Introduces flags (e.g., GFP_KERNEL, GFP_ATOMIC) when allocating

Wedson Almeida Filho (10):
  rust: kernel: move `allocator` module under `alloc`
  rust: alloc: introduce the `VecExt` trait
  kbuild: use the upstream `alloc` crate
  rust: alloc: remove our fork of the `alloc` crate
  rust: alloc: introduce allocation flags
  rust: alloc: introduce the `BoxExt` trait
  rust: alloc: update `VecExt` to take allocation flags
  rust: sync: update `Arc` and `UniqueArc` to take allocation flags
  rust: init: update `init` module to take allocation flags
  rust: kernel: remove usage of `allocator_api` unstable feature

 rust/Makefile                        |   16 +-
 rust/alloc/README.md                 |   36 -
 rust/alloc/alloc.rs                  |  452 ----
 rust/alloc/boxed.rs                  | 2463 -----------------
 rust/alloc/collections/mod.rs        |  160 --
 rust/alloc/lib.rs                    |  288 --
 rust/alloc/raw_vec.rs                |  611 -----
 rust/alloc/slice.rs                  |  890 -------
 rust/alloc/vec/drain.rs              |  255 --
 rust/alloc/vec/extract_if.rs         |  115 -
 rust/alloc/vec/into_iter.rs          |  454 ----
 rust/alloc/vec/is_zero.rs            |  204 --
 rust/alloc/vec/mod.rs                | 3683 --------------------------
 rust/alloc/vec/partial_eq.rs         |   49 -
 rust/alloc/vec/set_len_on_drop.rs    |   35 -
 rust/alloc/vec/spec_extend.rs        |  119 -
 rust/bindings/bindings_helper.h      |    3 +
 rust/kernel/alloc.rs                 |   68 +
 rust/kernel/{ => alloc}/allocator.rs |    6 +-
 rust/kernel/alloc/boxext.rs          |   60 +
 rust/kernel/alloc/vecext.rs          |  120 +
 rust/kernel/error.rs                 |   13 +-
 rust/kernel/init.rs                  |   57 +-
 rust/kernel/lib.rs                   |    5 +-
 rust/kernel/prelude.rs               |    2 +
 rust/kernel/str.rs                   |    6 +-
 rust/kernel/sync/arc.rs              |   44 +-
 rust/kernel/sync/condvar.rs          |    2 +-
 rust/kernel/sync/lock/mutex.rs       |    2 +-
 rust/kernel/sync/lock/spinlock.rs    |    2 +-
 rust/kernel/types.rs                 |    4 +-
 rust/kernel/workqueue.rs             |   14 +-
 samples/rust/rust_minimal.rs         |    6 +-
 samples/rust/rust_print.rs           |    4 +-
 scripts/generate_rust_analyzer.py    |    2 +-
 35 files changed, 340 insertions(+), 9910 deletions(-)
 delete mode 100644 rust/alloc/README.md
 delete mode 100644 rust/alloc/alloc.rs
 delete mode 100644 rust/alloc/boxed.rs
 delete mode 100644 rust/alloc/collections/mod.rs
 delete mode 100644 rust/alloc/lib.rs
 delete mode 100644 rust/alloc/raw_vec.rs
 delete mode 100644 rust/alloc/slice.rs
 delete mode 100644 rust/alloc/vec/drain.rs
 delete mode 100644 rust/alloc/vec/extract_if.rs
 delete mode 100644 rust/alloc/vec/into_iter.rs
 delete mode 100644 rust/alloc/vec/is_zero.rs
 delete mode 100644 rust/alloc/vec/mod.rs
 delete mode 100644 rust/alloc/vec/partial_eq.rs
 delete mode 100644 rust/alloc/vec/set_len_on_drop.rs
 delete mode 100644 rust/alloc/vec/spec_extend.rs
 create mode 100644 rust/kernel/alloc.rs
 rename rust/kernel/{ => alloc}/allocator.rs (96%)
 create mode 100644 rust/kernel/alloc/boxext.rs
 create mode 100644 rust/kernel/alloc/vecext.rs


base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
-- 
2.34.1


