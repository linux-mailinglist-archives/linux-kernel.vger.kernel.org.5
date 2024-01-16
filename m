Return-Path: <linux-kernel+bounces-28367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8D882FDA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29AD61C266AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB76A1D523;
	Tue, 16 Jan 2024 23:11:00 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90671154A6;
	Tue, 16 Jan 2024 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705446660; cv=none; b=rkkkdxT9h7M2JNGsZRPAt9FHmHBG/kMbhO5NM+tlTCfoxGV+PUCSE+nN/xiIIBY0h1BoprVKUlkLGMBHfAN0YeorufIFpeUCr/PZNx4Fl4k64VcCkywQlc/MDc7ntEJ4x46iV/UeIbDxn9wq4l5H5VaClxkzme7HwKyRhPhNT3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705446660; c=relaxed/simple;
	bh=6kMEVkUtpENf3uILfGmx7CwIEW3QhLIKQG8D4rvGCJA=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport; b=YgE3FkzvVPDFHruHXl+UFWB+fOmyWSgqTvP28zJu/QgxUDxjup+8m9upOGDCeOrykZn40ypDaZDyWUUXxXcmWSM2RoGkY9ykPBKwg4WuDM4Q/JTFvQIpkCO4AvvYA0s9SZqr21fXrr7oKzd1zAIyLf5t6qrPitGWyRDfQCFh3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MfpGL-1qx9X32FpJ-00gF75; Wed, 17 Jan 2024 00:10:44 +0100
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
Subject: [PATCH 09/13] rust: kernel: add blank lines in front of code blocks
Date: Wed, 17 Jan 2024 00:10:35 +0100
Message-ID: <20240116231035.168838-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116160141.165951-1-kernel@valentinobst.de>
References: <20240116160141.165951-1-kernel@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GExkHjC2m4S4YEdTb4SLROcE6xv0Z0T/xFkMhp5M6sKfwUta1y0
 1giNkzmUSLAcASxRgRoxVyGEv1FggmrU2BmMeXd5Vfq2Ly6YBRRXTqHtkmXEpcFtYQMze98
 02rRZFRDA31TwayVtpH676fkJHqGVtE2P9wnQKZKNJ/qLTwII9DWqs/tN/5Mt6VPyNnxOqO
 i4ltBknD5pM9WpO5bcRDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3227nHjRX/A=;k5khFr9FsqthzRRubZhi++CxcZI
 jH4DDASQY7CRx9oNVgdSN2l8eXsrZegC/jMq6BwCDHzVGII0P4VEOtsg62d3H/sR6b5Z/lUp6
 hQDZm2A/MZDSwpc7sdt42v69jbJFGa9W+A9RiB6vIUs7T0QO6MRqaW1lf5gPAAxK3PC5zKCFN
 2A3h39pmnNp4cc1UFIZjWAwCrH5yuV5oJw8dGgSYDQK9F1cclVw2DbxbBPm40QGEVL8sZpXqv
 VkARNvwCto75dplhtA3QEVVYCIDk6YGPy+05xvQ/jVtYzZivtF7GpWe/82U/i7TUuqnRDJNTA
 7oolEiBEw4vObu163oN04U7QUWOBenFlO3eabzMbkvyE0mEjN8KvLA8/d4mSXUIdd0gF7c8ok
 pfXLw1cmrx4OyHrCcJvW+edZWnVVA004PzrYZmrJsZmZQmxHAAvI8UA87hDDV8WY4ySr0PGGC
 LxYPrFdwwcjwqpxObP/ly6dW+pok8sLe2tO/1opRI56FuNxgePMJXTW6x/hPgVOjsWxVadi99
 BcDHcW7qVF5fzdfe2F5+ZMHaZUmQ+yOEHNHB9EQi1Q6+VE5TbNodByMZ5wmgcVUYd9jCdYdxn
 NPqWxax8pulkCShmX53JWXoT5TkLiBSWaRZ6n5Ec4QC+eAM+F70J4AqAbV6XMxQ9CU8+mDktX
 pWZy1OYXe+f5rPjM5Ky6ZD5b1eHSKIjpAQQr0LRFQNDaM6K7H0y31CbMl66Z1HjgEgDL18RFq
 QAq5O+tGh1xEBG2vCyt0RWnVrZTZfZ9RGBa1D4qEIdnJezbTcEsveFI4PyoPecD95jF2ubKmV
 U60dcEOoKY3Hsb8AMj7yHVslk0NP2uyjBTtYULObfzg0/R2fhvA3pg7V+4/g91p2oDLcTaVjd
 4rqbsgGOkgJm0Og==

Throughout the code base, blank lines are used before starting a code
block. Adapt outliers to improve consistency within the kernel crate.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
---
 rust/kernel/types.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index fdb778e65d79..8aabe348b194 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -90,6 +90,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 ///
 /// In the example below, we have multiple exit paths and we want to log regardless of which one is
 /// taken:
+///
 /// ```
 /// # use kernel::types::ScopeGuard;
 /// fn example1(arg: bool) {
@@ -108,6 +109,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 ///
 /// In the example below, we want to log the same message on all early exits but a different one on
 /// the main exit path:
+///
 /// ```
 /// # use kernel::types::ScopeGuard;
 /// fn example2(arg: bool) {
@@ -129,6 +131,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 ///
 /// In the example below, we need a mutable object (the vector) to be accessible within the log
 /// function, so we wrap it in the [`ScopeGuard`]:
+///
 /// ```
 /// # use kernel::types::ScopeGuard;
 /// fn example3(arg: bool) -> Result {
-- 
2.43.0


