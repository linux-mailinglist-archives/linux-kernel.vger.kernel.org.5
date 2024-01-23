Return-Path: <linux-kernel+bounces-35485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391428391EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46811F21E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA6C5FDA3;
	Tue, 23 Jan 2024 15:01:35 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0685FBAB;
	Tue, 23 Jan 2024 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022094; cv=none; b=CBHcyXxnddfH4wWmBky4zavHT3bNxK5ClAL8OCa6Mj36zMpD2A/NUvodjhDzdXW35j3rn32UX2F3iYhgMmEu+ou/L94G8s1Tq0G8OfB/PDBOfvUswDdmzd9vZwsTJYDWcQZYlUmGzHa221Ged9fIbDRN7Ky1WjWwQmhi5U4tRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022094; c=relaxed/simple;
	bh=INayTwD1ihwrn2gMXD/3DYgPRqCbHJa4Q0GkN//KHLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6aZuKqvYTKCQ0rhV0Fqv9qOdnveqeEjHVcgy61/0tc6oIvARhlGasyfo++D1KxazBAvnkRLyaMZJR9qIThJSJ8HajSc8XfL8eheClvtDCgJE9jWjkCA2y+GuD3Bj36f4LtYblTj4tGm2uRoCAy+RAPPUsi6TWenLNsfh+gy2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MJW5G-1rhdIX2QC8-00Ju22; Tue, 23 Jan 2024 16:01:13 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Valentin Obst <fraunhofer@valentinobst.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/12] rust: kernel: documentation improvements
Date: Tue, 23 Jan 2024 16:00:54 +0100
Message-ID: <20240123150112.124084-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JTlGRyQ9QcSD9VzmvRJaiasIWI2N03y5WZrTr9en2/ApzBgQPnU
 OHgIo1TxF+RML5jK5RvnSKnf63waQF7UzigNP+ep2VuvyBWLuaK99BZ6rhZXPexTiukBZfr
 F+z2jaS0DvnsTY0E+Y6G9oGGs+/233ELOTMQLtC2NUJzNonMklJ2HeCCcrfL4IwcBHkKhW7
 LENnmRiHl24au854qGBjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JKMwDlkILMs=;zwH/XDKpH9DoDb5R2VRayJs59I+
 ci1Si+3/RuqmgBOhv041VaO11OrV61338fR0wEYyU7S9T7QW+/rNF6wj1X9FqeGyusEUQ6SNC
 +yEUV13ztw5uwVB8SbZjGj3q8CizlWertmbATrmYi0oKHfbKQyzjiFZF72Ov3f0eZ02sZV1nk
 YwnXfZVWfN0zwk8pd7v1l6yMJ8L74gcopGb9bx8oAzX6QSQKl4LwGRcURtOX2vvuI1nGiYX2/
 86kqmshFrnFwCa+PVeypAL3F+D1PUw6jwt/1hx1BFPyPyjZxdDcJ5RMrT8Vu6/wqWesXPvwli
 zTQIYJoDh7RliEMAk1uzh94eXcL5mAUFJ2DTWiiEO5/W+vfbHBuWMwp78BEO0X+IIYtByAiB/
 e6JVcFuO8RLkTiTnBmq/P3wqH5f/lLlXMcD3Yzpr1BDlYQBFn1PKavhYDq3qFMmNHV+U0Ftf3
 EC68X3buN2Okorxrpdkb9L7eHnzANZP65Sr3X5CDTSyaoChkM5D4Mo/E82l9d9WNedxg8TIE0
 g6Ae14KaXi2/LiIQTsPq2rOBmYWXHydpP+dc8gUPQT6ZAz8Lop1DKmUBJ+nCFepLlRqZwscJp
 mg577D+Pc78y0WtCnhxoXdWcqpNaiTpspo02rV1iNii6hdEpoRoRXKTsU6P0glyxOFiZt44Nx
 z27S/5xsk272VzkM299gJWFspxnnHubJ9PeBEZDOTArRVmM0oKFdoSQ8dTBxV9WyWJ4bQiFS+
 H0moMU3YYnhqeLMHKVCu5twc1oqJQEQRWmwgS3Gd4O+87++47MfxxV0FdcdLAp5ATJ9lkQncf
 Oc/MD9iDKSnDRJ1KsQuIcSiW59v4P/pWhep5zEsM77Cs31WyS9kw5czeqJS98rrmoG8ulNNgu
 dA1FxKkyZXK/9pw==

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
 rust/kernel/error.rs              | 10 ++---
 rust/kernel/init.rs               | 16 ++++----
 rust/kernel/ioctl.rs              |  6 +--
 rust/kernel/lib.rs                |  2 +-
 rust/kernel/str.rs                |  8 ++--
 rust/kernel/sync/arc.rs           | 14 +++----
 rust/kernel/sync/condvar.rs       |  2 +
 rust/kernel/sync/lock.rs          | 15 ++++++--
 rust/kernel/sync/lock/spinlock.rs |  2 +-
 rust/kernel/sync/locked_by.rs     |  5 ++-
 rust/kernel/task.rs               |  6 +--
 rust/kernel/types.rs              |  3 ++
 rust/kernel/workqueue.rs          | 64 +++++++++++++++----------------
 14 files changed, 83 insertions(+), 72 deletions(-)

-- 
2.43.0


