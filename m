Return-Path: <linux-kernel+bounces-27556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E038682F214
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA6F28347E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8519B1CD14;
	Tue, 16 Jan 2024 16:03:12 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32261CD00;
	Tue, 16 Jan 2024 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1McpeM-1qpt7806QU-00ZyjJ; Tue, 16 Jan 2024 17:02:36 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>
Subject: [PATCH 00/13] rust: kernel: documentation improvements
Date: Tue, 16 Jan 2024 17:01:25 +0100
Message-ID: <20240116160141.165951-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EG1EJQ2T+MxnzM9vXBMa4M0AM2DOg9dyf9PxTLvaxg56lNxMTeY
 Cj7qOqpLZcXWXFWIkVETuZYzQ+4onbXwHf6zkCM7czNRcWo7sX+TMf36MTz+FY2mvKmeLkv
 Z8pk+OpvM5kBp5uEC455JC8Va89DaFXuNSGgyk4NeWJTaB6IEElFXce07L+x4it0ztq6vR7
 yFrOxUU3+57k1Y+zcS8lQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ou0ixQg9zOE=;OR7N+PhTvh/+jbtNr1cIGYu6Xes
 vAKCQjZlsalMqmSuhMi9cPEb/urOLzbunQukJooDwu+onL1U5oMZtIwicpOtLGgB9OEfY47vQ
 DlVORb44I1f/mt/Qxn3DjafYJfbXJ4lyfkqCbGHDrFeqA5iQjJg1a2zmuVxpfnW8AR8chYNsF
 vQsh+HNmlMN/GoAe2gYzSnf76LLSknIOCkCABRohgR3mL6ZrsD8aDJ5rBI6dDgXft7kQLNyO4
 MBnzvt/zgpmsoMhE82URcP1VnDxAA6uWqW0xo/00n9enpPGSDMdA5oMrwUKARs8qaKQpUeVRY
 Fz4Ml/3Ep4Fzrpxw/yMT0vVetXixv01RFItkNGaQRn9knfvpQE7bYFB4CiLXoM9wOUva4otRD
 +z8efttwyr+CLj9S45i7tRKyySrcpuB3i/5LkJYFPJu90Q4ylqvIin/oWfve7wadp9Qg+VrJv
 t/SsIfOniLtwAYhxLWvgcO6er7Fd68fjPRfe5Uiq5DiZJteNzDOtHHta9IzOPxuJItvCod1Vk
 6GFX2wIT4MxoyEGVeAJ9E7et7LC/rVb65F1O2jj3A/zn9m7Hqvl/laxsHKgzYwa/pyo/K81Sm
 +33iNzbyi7cTJpJMsVi3wbOjg0aIenEmsS3s+oFClbt8etKOIrbH4ittlCSZlqS8LUtngFALN
 VqenVzsBNJmo+sEvUWFwegnhpK4hAormGyKx59qHLKkLl+pCDC6lzAiqV/I7NxKCL1WV1HPa/
 ubpnq5KSQu/H0fK+ZkgV+2VmfBYpP+b6JwslQ6ipfUaG5fSV1crDd/E4ZVPT4Sl6BHGJ7jZDW
 GvlzH6lo5F/M9PNIvLBj6urxg9owVTG1V2XuMLbqGZBMdbbqjMZiSzn6QPD7cULW/2Mq1r3om
 xXRoCKxLM22o5KA==

This patch set aims to make small improvements to the documentation of
the kernel crate. It engages in a few different activities:
- fixing trivial typos (commit #1)
- updating code examples to better reflect an idiomatic coding style
  (commits #2,6)
- increasing the consistency within the crate's documentation as a whole
  (commits #3,5,7,8,9,12,13)
- adding more intra-doc links as well as srctree-relative links to C
  header files (commits #4,10,11)

Valentin Obst (13):
  rust: kernel: fix multiple typos in documentation
  rust: error: move unsafe block into function call
  rust: ioctl: end top level module docs with full stop
  rust: kernel: add srctree-relative doclinks
  rust: str: use `NUL` instead of 0 in doc comments
  rust: str: move SAFETY comment in front of unsafe block
  rust: kernel: unify spelling of refcount in docs
  rust: kernel: mark code fragments in docs with backticks
  rust: kernel: add blank lines in front of code blocks
  rust: kernel: add doclinks
  rust: kernel: add doclinks with html tags
  rust: kernel: remove unneeded doclink targets
  rust: locked_by: shorten doclink preview

 rust/kernel/allocator.rs          |  2 +-
 rust/kernel/error.rs              |  7 +---
 rust/kernel/init.rs               | 16 +++----
 rust/kernel/ioctl.rs              |  6 +--
 rust/kernel/lib.rs                |  2 +-
 rust/kernel/str.rs                | 15 +++----
 rust/kernel/sync/arc.rs           | 34 ++++++++-------
 rust/kernel/sync/condvar.rs       |  2 +
 rust/kernel/sync/lock.rs          | 13 ++++--
 rust/kernel/sync/lock/spinlock.rs |  2 +-
 rust/kernel/sync/locked_by.rs     |  5 ++-
 rust/kernel/task.rs               |  6 +--
 rust/kernel/types.rs              |  3 ++
 rust/kernel/workqueue.rs          | 70 +++++++++++++++----------------
 14 files changed, 98 insertions(+), 85 deletions(-)

-- 
2.43.0


