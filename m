Return-Path: <linux-kernel+bounces-127081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AEE894681
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C591C215A6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569F654BF6;
	Mon,  1 Apr 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RO4Xyl0r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADA855E53;
	Mon,  1 Apr 2024 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006623; cv=none; b=Jb8B9gdvOr85aTZVNLCmMUetFFtCoDL3IQ82OpcDUvBDQUs+PpYvXG+U0Xgoopfh39EJvNKfxBZl8CZXRbPA/pdZvwqfeOZJadc2/gYcl6GkswOi03q7MnyeQ4zyjwgfEQZ0TUm7ZEMCsY9txNm4jfR9df0OkOSajaMyED1kbmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006623; c=relaxed/simple;
	bh=EgrDOpn9PZzkLVfGjgBd1Asx2yeFKC8w6ZZ/S4hov40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P61k8E2hXkbJ86dqMDlbh87XwuW4OmhdoW80XDXWWP7j5prIxqnMf7B3aLWD0dcDkbiFdgvQwK2MCJODqWln+YPxLWJstkZudD46gjNb7VtXf9WdnISAW5yybJToOQ8t7hRt1qJH8a5GyTmrtZPXnOeBhPL6N1/0zDwMBW9RT0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RO4Xyl0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6A0C433C7;
	Mon,  1 Apr 2024 21:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712006623;
	bh=EgrDOpn9PZzkLVfGjgBd1Asx2yeFKC8w6ZZ/S4hov40=;
	h=From:To:Cc:Subject:Date:From;
	b=RO4Xyl0r2rQbWZ0sZIsm05CSkeyrrqxYqOHcCCTxvbnHzEjOWqsKNQ5ZrVajAvVlD
	 R0XnCmuqBRknYQIOSSk03Cx5mj+wE+IpEbbuLnwcDetRXDT1b2Vod+MoYMpjq/JPjc
	 3FIFHeSdmG09We05sY59Z9dzDIWtCU5OnLgf2k4ia9/XfR9gMiyaRDt4OlNh352Xwy
	 5NsUs0shwsTwbvfSAF3vCV6I7FQxtBOYsdky5PSLUJhPjrQgI1JEVXMYJyoFsgd40J
	 S34qf3OgHDNXI+COnExSsOHCkPkxIaNyxAGauyvacNhchGo3Uj+6CE+4LEEUpSi8ow
	 16J6AXfH2w4jQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 0/3] Rust 1.78.0 upgrade
Date: Mon,  1 Apr 2024 23:23:00 +0200
Message-ID: <20240401212303.537355-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the first upgrade without the `alloc` fork.

In other words, it is based on top of Wedson's "Allocation APIs" series
[1], applied on top of the current `rust-next`, i.e. commit 9ffe2a730313
("rust: str: add {make,to}_{upper,lower}case() to CString").

Please note that Rust 1.78.0 will be released in a month (2024-05-02).

Link: https://lore.kernel.org/rust-for-linux/20240328013603.206764-1-wedsonaf@gmail.com/ [1]

Miguel Ojeda (3):
  rust: sync: implement `Default` for `LockClassKey`
  rust: kernel: remove redundant imports
  rust: upgrade to Rust 1.78.0

 Documentation/process/changes.rst | 2 +-
 rust/kernel/alloc.rs              | 1 -
 rust/kernel/alloc/allocator.rs    | 2 --
 rust/kernel/alloc/box_ext.rs      | 1 -
 rust/kernel/alloc/vec_ext.rs      | 1 -
 rust/kernel/error.rs              | 1 -
 rust/kernel/net/phy.rs            | 2 +-
 rust/kernel/print.rs              | 5 -----
 rust/kernel/str.rs                | 5 +----
 rust/kernel/sync.rs               | 6 ++++++
 rust/kernel/sync/arc.rs           | 1 -
 rust/kernel/sync/condvar.rs       | 1 -
 rust/kernel/sync/lock.rs          | 2 +-
 rust/kernel/sync/lock/mutex.rs    | 2 --
 rust/kernel/sync/lock/spinlock.rs | 2 --
 rust/kernel/task.rs               | 2 +-
 rust/kernel/workqueue.rs          | 4 +---
 scripts/generate_rust_target.rs   | 2 +-
 scripts/min-tool-version.sh       | 2 +-
 19 files changed, 14 insertions(+), 30 deletions(-)

--
2.44.0

