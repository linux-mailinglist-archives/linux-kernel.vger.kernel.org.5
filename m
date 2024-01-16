Return-Path: <linux-kernel+bounces-28329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B252A82FCFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4936B289B73
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B595B4645E;
	Tue, 16 Jan 2024 22:05:35 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7120B02;
	Tue, 16 Jan 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442735; cv=none; b=uEttqz2Mv17plhfb5+D+6IkuMQAg4U09vCyfRRxRMApR+rwfv9ZRUd6eTBJX3C8O6jGMLSbfuOJNMKsMvjfC7WdeLzZfH6ABihelpvqDOB61PQZqjAx5MFjNBd9rTD4E4ScTtGMR/+a3ItP9y590NaXxHiFVThksJyoIQoJHrBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442735; c=relaxed/simple;
	bh=v3W324I3SJN5eST/f93Ey55QMVR0yTzOUMu2onl9OUo=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport; b=QYmLgj2niyxc646i/ZbLp4CdddHgj/Ait9nsV2p7dK75xXvbrmjMNGzvhVAXLiMpmhJ6wn8KD941lDMnJ7dWrBXd6m6mIp6mdbWTDPpimG/4VyPV2JK95OSKjCJLFCkNhS+EbY9v4ivjSDEQ2hJPPcrvcntDyeo4+5A2hpBiROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MTREY-1rZe9L2Zf2-00TjKy; Tue, 16 Jan 2024 23:05:11 +0100
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
Subject: [PATCH 04/13] rust: kernel: add srctree-relative doclinks
Date: Tue, 16 Jan 2024 23:04:10 +0100
Message-ID: <20240116220411.168016-1-kernel@valentinobst.de>
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
X-Provags-ID: V03:K1:0M/3h7s7GfvVM/sxSkwa13j4UXMw4UFVXCpvMlk36g4VyCdY5Av
 OpuLrkYGR2CTa0uchs9tvp44C5cLONl9yZzzNKwRHjmSOVtWZWANmcrllTypzFRDeC9bYy5
 njtvU/C/HW3BH0Qv97g5SubpLt62cTWKHLvOYrsj5G+USM8b5tZ0yZsfH0BPBMmGdTSLApM
 uc2SC1Dq7y+yHtEsN4IGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:karToRGKwJs=;uQ8K1v7C/+Wu1/QtFmFaiddcSo0
 7aM4nFV9VR1/HqQilEl5s21ew29uEuaIZfn72dP0+1Ql5lZ4O3pzFDwx55RG4hdMMqAMeNJlC
 pHuad1+d5GhhOdD6OCNEELTmfJ2e8BFceTWDV9IIc0K4ZZ0nV8MpUD4FV9lPVEH1XQBDvJWEt
 DE/UM2Gva7O2WiTuUkRE9BqHbC1K2PPgA63kCzOA0HX2JYLZglrGZTrF85lBBgKrKxqgHWpXE
 H7DQymgZoVRNeHTT4L4b5Uu46fFnGF3qRuDLCmCc/sel3RvWXltCilfu/3KziGC+X1mhBS4xZ
 4SAMUd47/IWQRD/dJrMX5VvHUDMi6e0mubSrpLiBvvhZlyUmHVYZdqQfEsnxsvx76ydQgF+jc
 lZ1Khpr7rkdxyJcX5Ovf4j+52OBmADhGHtBgTcBoofLU9R6YzGnkhxAyXZ87EaSB02bgEPMcw
 /q/eTZv+FFGRqdh6zo517pW5ELsKzsVyLqmO7JqKD9FtpU/4sxDkd/r0hSV25iZYaptT5h/x+
 SgBydIBhJ8fWxELgbDU94LtayPlJL3SkRkiiJ3mO4eZrK6CVCP69lXSZlojirpvrko2BrydUV
 iEMxOLo5kULu3dG5l2umGK0LJQY5bCk0Na+nF/4bYSP4XMTQGotvC1fQEMKNACRH4jLpKCkNw
 +jLPiuzsXC9Huq+bocJTiKQAFwpn9LMd3txpda2EgO1i/N20SbicY19TLE5M+FWHKnKxmTr3v
 PKUephOrwVcWwW8v6gaO+N+oUZy1FoAE1OIDwNWTkAGlOIjV65mb8eC6CF3Cr1CfytNEyL0/P
 Us/BhLxoyldPeH3Uto60ujLd7TBh45sfxLIGiwePrK2a0zkH8Y9QErSBahAEFDM7ZB+5CwKq+
 NAewvcPu8JiJXiQ==

Convert existing references to C header files to make use of
Commit bc2e7d5c298a ("rust: support `srctree`-relative links").

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
---
 rust/kernel/lib.rs          | 2 +-
 rust/kernel/sync/condvar.rs | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e6aff80b521f..0d365c71cae2 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -75,7 +75,7 @@ pub trait Module: Sized + Sync {
 
 /// Equivalent to `THIS_MODULE` in the C API.
 ///
-/// C header: `include/linux/export.h`
+/// C header: [`include/linux/export.h`](srctree/include/linux/export.h)
 pub struct ThisModule(*mut bindings::module);
 
 // SAFETY: `THIS_MODULE` may be used from all threads within a module.
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index f65e19d5a37c..0bb76400efd9 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -77,6 +77,8 @@ pub struct CondVar {
 
     /// A condvar needs to be pinned because it contains a [`struct list_head`] that is
     /// self-referential, so it cannot be safely moved once it is initialised.
+    ///
+    /// [`struct list_head`]: srctree/include/linux/types.h
     #[pin]
     _pin: PhantomPinned,
 }
-- 
2.43.0


