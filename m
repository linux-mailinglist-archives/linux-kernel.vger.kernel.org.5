Return-Path: <linux-kernel+bounces-97909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA15787716D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E84DCB20F02
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374973C6BA;
	Sat,  9 Mar 2024 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MreaFjVz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8338F97;
	Sat,  9 Mar 2024 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709991510; cv=none; b=ALewSJOfo/jPEMILLBM8DRFwMbDPXEl0Q/Hq5ZRReEyfp/2m4x2RyMZqE2LwDVyDIf254EMctWydYBPQbejJz17epQ2HrNEJXcJw0GQPIZKU41K0IzSQtVoVH8ikBCAs12B32X9PpDj7LMWIEXS2v3emlZqyE/YODub3C15EpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709991510; c=relaxed/simple;
	bh=LJZLWpPMSIn8dh1JkUG1cS5BSZ5kFeQDO1hkDSXzojg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUIEIm5XIxSC9RU2BCYRgdgBTZCZeQ9gfPDgl3EBJoJSO2t6oZ27ZCIJiG4OFqDlrIE73x7BjrJxQeIbb2ioySwnUEZLJMqE++qRYLklqkJKU3EDGk3Brh/IKD8qGpt/Y817oc7fAJ0LB90YKRDkm0J5WW/sCOYAgn+PiCysXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MreaFjVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB36C433F1;
	Sat,  9 Mar 2024 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709991509;
	bh=LJZLWpPMSIn8dh1JkUG1cS5BSZ5kFeQDO1hkDSXzojg=;
	h=From:To:Cc:Subject:Date:From;
	b=MreaFjVzERgzC1DJyk9D02nAQuCvD0WxKjTNyED8mTOcCiuQCcy+6MvGMlgRDGLax
	 6Mp3YZBW82RNm0qirCokhpPjL6inkshCMQ+yA+cDdQt8azb3mAwJ8yrWF9aT60WIzb
	 Nrara0XF/h/MD86pilXcELMp0zoeWN2LkenjJwv/96m8VDs4MAqvSDFQimEsL+M/vv
	 VWQ+OKkTTV4yzSBB4ZVa9KoBWEW4Yf13iYo6ZvD3PKyHBCwtR/KIutN3o9I/Z+BEh3
	 rbayphEYuJ5REzWjyg6E6LxbyoTAJAei4SWeXku6YjRZ8Det8e3gKR67KFdxenW4+T
	 SRd8pHoVpNWmQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust for v6.9
Date: Sat,  9 Mar 2024 14:38:17 +0100
Message-ID: <20240309133817.335439-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

This is the next round of the Rust support.

All the commits have been in linux-next for more than a week.

A small conflict with the arm64 pull expected, as well as a trivial one
with the mm-nonmm. Both are resolved in linux-next in the rust-next
merge. No changes to the C side.

You will likely get Rust support for arm64, the first kselftest for Rust
and a couple improvements for Rust net PHY through their respective
trees as well. LoongArch, RISC-V and VFS pull requests could carry
something too, but probably on the next one.

Please pull for v6.9 -- thanks!

Cheers,
Miguel

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-6.9

for you to fetch changes up to 768409cff6cc89fe1194da880537a09857b6e4db:

  rust: upgrade to Rust 1.76.0 (2024-02-29 22:18:05 +0100)

----------------------------------------------------------------
Rust changes for v6.9

Another routine one in terms of features. We got two version upgrades
this time, but in terms of lines, 'alloc' changes are not very large.

Toolchain and infrastructure:

 - Upgrade to Rust 1.76.0.

   This time around, due to how the kernel and Rust schedules have
   aligned, there are two upgrades in fact. These allow us to remove two
   more unstable features ('const_maybe_uninit_zeroed' and
   'ptr_metadata') from the list, among other improvements.

 - Mark 'rustc' (and others) invocations as recursive, which fixes a new
   warning and prepares us for the future in case we eventually take
   advantage of the Make jobserver.

'kernel' crate:

 - Add the 'container_of!' macro.

 - Stop using the unstable 'ptr_metadata' feature by employing the now
   stable 'byte_sub' method to implement 'Arc::from_raw()'.

 - Add the 'time' module with a 'msecs_to_jiffies()' conversion function
   to begin with, to be used by Rust Binder.

 - Add 'notify_sync()' and 'wait_interruptible_timeout()' methods to
   'CondVar', to be used by Rust Binder.

 - Update integer types for 'CondVar'.

 - Rename 'wait_list' field to 'wait_queue_head' in 'CondVar'.

 - Implement 'Display' and 'Debug' for 'BStr'.

 - Add the 'try_from_foreign()' method to the 'ForeignOwnable' trait.

 - Add reexports for macros so that they can be used from the right
   module (in addition to the root).

 - A series of code documentation improvements, including adding
   intra-doc links, consistency improvements, typo fixes...

'macros' crate:

 - Place generated 'init_module()' function in '.init.text'.

Documentation:

 - Add documentation on Rust doctests and how they work.

----------------------------------------------------------------
Alice Ryhl (6):
      rust: sync: add `CondVar::notify_sync`
      rust: time: add msecs to jiffies conversion
      rust: sync: add `CondVar::wait_timeout`
      rust: sync: update integer types in CondVar
      rust: kernel: add reexports for macros
      rust: kernel: stop using ptr_metadata feature

Charalampos Mitrodimas (1):
      rust: sync: `CondVar` rename "wait_list" to "wait_queue_head"

Dirk Behme (2):
      docs: rust: Move testing to a separate page
      docs: rust: Add description of Rust documentation test as KUnit ones

Miguel Ojeda (3):
      rust: upgrade to Rust 1.75.0
      kbuild: mark `rustc` (and others) invocations as recursive
      rust: upgrade to Rust 1.76.0

Mika Westerberg (1):
      rust: bindings: Order headers alphabetically

Obei Sideg (1):
      rust: types: add `try_from_foreign()` method

Thomas Bertschinger (1):
      rust: module: place generated init_module() function in .init.text

Valentin Obst (12):
      rust: kernel: fix multiple typos in documentation
      rust: error: improve unsafe code in example
      rust: ioctl: end top-level module docs with full stop
      rust: kernel: add srctree-relative doclinks
      rust: str: use `NUL` instead of 0 in doc comments
      rust: str: move SAFETY comment in front of unsafe block
      rust: kernel: unify spelling of refcount in docs
      rust: kernel: mark code fragments in docs with backticks
      rust: kernel: add blank lines in front of code blocks
      rust: kernel: add doclinks
      rust: kernel: remove unneeded doclink targets
      rust: locked_by: shorten doclink preview

Wedson Almeida Filho (1):
      rust: add `container_of!` macro

Yutaro Ohno (1):
      rust: str: implement `Display` and `Debug` for `BStr`

 Documentation/process/changes.rst          |   2 +-
 Documentation/rust/general-information.rst |  24 ----
 Documentation/rust/index.rst               |   1 +
 Documentation/rust/testing.rst             | 135 ++++++++++++++++++++
 Makefile                                   |   4 +-
 rust/Makefile                              |  48 +++----
 rust/alloc/alloc.rs                        |  12 +-
 rust/alloc/boxed.rs                        |  34 +++--
 rust/alloc/collections/mod.rs              |   1 +
 rust/alloc/lib.rs                          |   9 +-
 rust/alloc/raw_vec.rs                      |  77 +++++++++---
 rust/alloc/vec/into_iter.rs                |  16 ++-
 rust/alloc/vec/mod.rs                      |  81 +++++++++---
 rust/bindings/bindings_helper.h            |   5 +-
 rust/kernel/allocator.rs                   |   2 +-
 rust/kernel/error.rs                       |  10 +-
 rust/kernel/init.rs                        |  22 ++--
 rust/kernel/ioctl.rs                       |   6 +-
 rust/kernel/lib.rs                         |  37 +++++-
 rust/kernel/str.rs                         | 193 +++++++++++++++++++++++++++--
 rust/kernel/sync.rs                        |   5 +-
 rust/kernel/sync/arc.rs                    |  30 +++--
 rust/kernel/sync/condvar.rs                | 110 ++++++++++++----
 rust/kernel/sync/lock.rs                   |  19 ++-
 rust/kernel/sync/lock/mutex.rs             |   3 +-
 rust/kernel/sync/lock/spinlock.rs          |   5 +-
 rust/kernel/sync/locked_by.rs              |   7 +-
 rust/kernel/task.rs                        |  24 +++-
 rust/kernel/time.rs                        |  20 +++
 rust/kernel/types.rs                       |  22 ++++
 rust/kernel/workqueue.rs                   |  78 ++++++------
 rust/macros/module.rs                      |   7 +-
 scripts/Makefile.build                     |   8 +-
 scripts/Makefile.host                      |   2 +-
 scripts/min-tool-version.sh                |   2 +-
 35 files changed, 809 insertions(+), 252 deletions(-)
 create mode 100644 Documentation/rust/testing.rst
 create mode 100644 rust/kernel/time.rs

