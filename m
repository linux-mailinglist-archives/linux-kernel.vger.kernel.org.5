Return-Path: <linux-kernel+bounces-949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 769A5814866
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88C31C234EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E47E2C6B9;
	Fri, 15 Dec 2023 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGAGxiS3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8D2C6A3;
	Fri, 15 Dec 2023 12:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FCDC433C7;
	Fri, 15 Dec 2023 12:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702644481;
	bh=KmFWeYKbRRsOcz7786bdIgRCmbbEy4sqix2mUbhzS80=;
	h=From:To:Cc:Subject:Date:From;
	b=GGAGxiS3ZCe4EXhYSpVHvqYTkOw3Z386azCItWPdkTjxFrzm8ZqPY9UjfzvCeinuz
	 6jmYiIIQqHLE40yIO4N1DYTARwzirmk10jykV2FqlnzKNu+t9iqdE+Bvu83vyKQew3
	 L+8aJElN9JCebXatAwB6QXwulLd2YRSkhDsIy3C8H7S5aZ4caFU/94H/arFWIlNkNG
	 InG2ZBszprtTaM/bwJKSEtVyZpOTivoZdu7zmfoLoUBrlmXOjB0hwEgGCh7JOvAVQi
	 OEL67H3rMdcIkxOmUyQL7MOp/PBz5dAcRtKqnVpfsNFuo4IvfwuZwaN5OlBUotz0Z0
	 QkdqOpp0AaYyw==
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
	patches@lists.linux.dev,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] docs: rust: remove `CC=clang` mentions
Date: Fri, 15 Dec 2023 13:47:51 +0100
Message-ID: <20231215124751.175191-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nowadays all architectures except s390 recommend using `LLVM=1` instead of
`CC=clang`, and since commit a3c6bfba4429 ("Documentation/llvm: refresh
docs") the Kbuild LLVM documentation makes `LLVM=1` the way to go:

    We want to encourage the use of ``LLVM=1`` rather than just
    ``CC=clang``. Make that suggestion "above the fold" and "front and
    center" in our docs.

In particular, that commit removes the examples with `CC=clang`.

Thus do the same in the Rust Quick Start guide, i.e. remove the `CC=clang`
mentions, especially since the architectures that have had their Rust
support upstreamed (or soon to be upstreamed) are all `LLVM=1` ones
anyway. And perhaps by the time Rust is supported for s390 (or new
architectures), it may have moved to `LLVM=1` anyway. Otherwise,
this can be added back if needed (or perhaps an extra link to
Documentation/kbuild/llvm.rst).

This should also help avoiding potential confusion around `CC=clang` [1].

Link: https://lore.kernel.org/rust-for-linux/6df6e8e5-8d5b-4d3d-91b5-bc0e90c424ea@nvidia.com/ [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/quick-start.rst | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index f382914f4191..75faa987079a 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -76,7 +76,7 @@ libclang
 
 ``libclang`` (part of LLVM) is used by ``bindgen`` to understand the C code
 in the kernel, which means LLVM needs to be installed; like when the kernel
-is compiled with ``CC=clang`` or ``LLVM=1``.
+is compiled with ``LLVM=1``.
 
 Linux distributions are likely to have a suitable one available, so it is
 best to check that first.
@@ -229,10 +229,6 @@ at the moment. That is::
 
 	make LLVM=1
 
-For architectures that do not support a full LLVM toolchain, use::
-
-	make CC=clang
-
 Using GCC also works for some configurations, but it is very experimental at
 the moment.
 

base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
-- 
2.43.0


