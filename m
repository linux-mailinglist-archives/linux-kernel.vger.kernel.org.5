Return-Path: <linux-kernel+bounces-47066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7D18448C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438B0B21935
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1871B12BF3B;
	Wed, 31 Jan 2024 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCqS+aDt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0C9405FE;
	Wed, 31 Jan 2024 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732649; cv=none; b=MYpycJVKgDCeHUXWgsyBLmixXRYq5NGaeutDIbxD/7SYF6cwXzki9A21rVcS5sSREaYqay2MT768E6gTGYN99QOQ3y4qUqSCeTcjK6kzSeVbt8+dZ3qWB+8+uol4kFyZpczfF9lQaMTSrgXQuzc19+QV9qUIHF/LJ3vrGsuccbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732649; c=relaxed/simple;
	bh=hC2mjadfbWNTXdCp+iDgEDDn3h44Sq3ssmfR5EiK618=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R6lhGhK4bzsfwyllXccs1qbn8pYoCBdESbX6zSOPmjcvqs6bRZh2yx9fmoS+bpG1jBbEn0JYN3AFw/i83XbsXw2eBXFCJfG10KLWTW19XwwXj34NrUGJBXKedQJultddQQb6BNVGHGNprVB1+VAqLnUq2x/NgztXETMLVgF+P8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCqS+aDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9AAAC433C7;
	Wed, 31 Jan 2024 20:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732648;
	bh=hC2mjadfbWNTXdCp+iDgEDDn3h44Sq3ssmfR5EiK618=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=XCqS+aDtQuBGKjuV/srdOQZuQEJ6K4UzArIZT0PG85r1yQsIcNAWrCWhxuGGDRr76
	 YpzUoJYJWTVZcptysvv2a8u2b0lTwm2A9P4GcGUUYI9gAm2/rnfcB5nihDlAwYlVmG
	 TGEP77pcPURgXOC7timEt2za55776xhb3T+l1TzqV2aDS7NePrlOZTlu9gpRIYB2js
	 XnlldDsADjJFjEOjCN0zBW8fhrjbnCk5K6GMQFKBomKgPk14C3bbnFNQXvHWAcP5J4
	 3WOlDJ7/45ttdshamUh0OUKh/Hf7T3pJYFn0jOVTnvGwj7N23YRYHI5LLLFU9huUrC
	 WsnLug2St2SHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F93CC47258;
	Wed, 31 Jan 2024 20:24:08 +0000 (UTC)
From: Valentin Obst via B4 Relay <devnull+kernel.valentinobst.de@kernel.org>
Subject: [PATCH v3 00/12] rust: kernel: documentation improvements
Date: Wed, 31 Jan 2024 21:23:22 +0100
Message-Id: <20240131-doc-fixes-v3-v3-0-0c8af94ed7de@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADqsumUC/03MQQ7CIBCF4as0s3YaBqoQV97DuEAYLLGCgYaYN
 L27xJXLLy//26ByiVzhPGxQuMUac+pQhwHcbNODMfpukEJOghShzw5D/HDFptAYG07OONJaQ0/
 ehX9bL6637lDyC9e5sP07kYqOgkiO1GUmJHxySbxcml04rTHle11Hz7DvXxnpvLOfAAAA
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@samsung.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Valentin Obst <kernel@valentinobst.de>, Trevor Gross <tmgross@umich.edu>, 
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706732646; l=2912;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=hC2mjadfbWNTXdCp+iDgEDDn3h44Sq3ssmfR5EiK618=;
 b=pjeD6O87EU/R9JZ4wGfJiVtnCZ1taFiqeJwfEpkF7kfmfd7ldXLcsHwS+yxW0OzOBqb0CRUY3
 mXewAIRUDKsD1RkswDY54GjOAJ64IUno5EstWR3bxBzni/XpHqXMVzm
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Endpoint-Received:
 by B4 Relay for kernel@valentinobst.de/20240131 with auth_id=124
X-Original-From: Valentin Obst <kernel@valentinobst.de>
Reply-To: <kernel@valentinobst.de>

This patch set aims to make small improvements to the documentation of
the kernel crate. It engages in a few different activities:
- fixing trivial typos (commit #1),
- updating code examples to better reflect an idiomatic coding style
  (commits #2,6),
- increasing the consistency within the crate's documentation as a whole
  (commits #3,5,7,8,9,11,12),
- adding more intra-doc links as well as srctree-relative links to C
  header files (commits #4,10).

---
Changes in v3:
- Adjusted word wrapping in "rust: locked_by: shorten doclink preview"
  to make use of the gained space.
- Rebased with `rust-next`.
- Link to v2: https://lore.kernel.org/lkml/20240123150112.124084-1-kernel@valentinobst.de/
Changes in v2:
- Drop commit "rust: kernel: add doclinks with html tags" in response to
  review.
- Fix another list item alignment issue pointed out during review of v1.
  Was added to commit "rust: kernel: fix multiple typos in
  documentation".
- Commit "rust: error: move unsafe block into function call" is now
  "rust: error: improve unsafe code in example" and also rewords the
  SAFETY comment of the code example.
  - Did not add 'Reviewed-By' tags offered in v1 tags due to changes.
- Link to v1: https://lore.kernel.org/lkml/20240116160141.165951-1-kernel@valentinobst.de/

---
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

 rust/kernel/allocator.rs          |  2 +-
 rust/kernel/error.rs              | 10 ++----
 rust/kernel/init.rs               | 16 +++++-----
 rust/kernel/ioctl.rs              |  6 ++--
 rust/kernel/lib.rs                |  2 +-
 rust/kernel/str.rs                |  8 ++---
 rust/kernel/sync/arc.rs           | 14 ++++-----
 rust/kernel/sync/condvar.rs       |  2 ++
 rust/kernel/sync/lock.rs          | 15 ++++++---
 rust/kernel/sync/lock/spinlock.rs |  2 +-
 rust/kernel/sync/locked_by.rs     |  7 +++--
 rust/kernel/task.rs               |  6 ++--
 rust/kernel/types.rs              |  3 ++
 rust/kernel/workqueue.rs          | 64 +++++++++++++++++++--------------------
 14 files changed, 84 insertions(+), 73 deletions(-)
---
base-commit: f090f0d0eea9666a96702b29bc9a64cbabee85c5
change-id: 20240131-doc-fixes-v3-88af6c8c1777

Best regards,
-- 
Valentin Obst <kernel@valentinobst.de>


