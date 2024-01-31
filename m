Return-Path: <linux-kernel+bounces-47074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8723D8448CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3DE1C203BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E738613D519;
	Wed, 31 Jan 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpWpNyXg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35A5C5E3;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732649; cv=none; b=U48ttUFU9lZbBY9I/daRU2rnS+1jcj6LY0GKaK9D6HJgfLAKQ9kj8bcg38D3iIty/rmIZ3xMk3enh7OkL8hvD1zaWVjl8RmsY7qvtxe0vGzcTt6CAnQ1uzy7efuU9OHpwuLACWSAAC68/Upg0iRh1WcqbTqOreM5JYKhBnKWzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732649; c=relaxed/simple;
	bh=ougBeYt6zdCfhQV27TBzSU+Hnds2zUx3wZiZDbZ9RF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2A+2P0X0J93Grpq3Vr87phitkxMkFMwpbClxAHOWsr5Abs1qDB7FEkMmecovKxkDo7SrxJtcpmFssoMZgxKD4UGXNsQtyvvBcrPqZdaazW3/Ug9lKXBRz4AISQpTVhB5zFDEmEpCl/sZDAc2SKwDVyODamnCGqIIRkrn+kIXzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpWpNyXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 351E1C4167E;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732649;
	bh=ougBeYt6zdCfhQV27TBzSU+Hnds2zUx3wZiZDbZ9RF4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LpWpNyXgrA5Y/VwmEXohXMT2FVnx0fpJArCLuYYrbL7iCwpCgJ+J9FYanQT2cZ29G
	 1rGa8LqAhk1VxlJxH2gg1aGunSiD2vKuhMbxW6JsxTyW/4dz06GGENAYOVP/b/QXV1
	 IBywaHsbpttMoT9tehxGz60d2r3NWIqsXauukTsP0UQmdlT4S8z1UF40ijeG484YuY
	 F+5s4sckpoX+Yqd4lI2kFop/tQTelVHTGZqPf+keC7WeHdlgjJcRe0hgYm0huDXjml
	 KUTbFowVRDIaZ8YpMoNSASOADVt+IDR9QRyXj33P/rRoSo+Nj0nrwvV3y6D8l+sFDC
	 aOcfVIbHOtNfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F70C47258;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
From: Valentin Obst via B4 Relay <devnull+kernel.valentinobst.de@kernel.org>
Date: Wed, 31 Jan 2024 21:23:33 +0100
Subject: [PATCH v3 11/12] rust: kernel: remove unneeded doclink targets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-doc-fixes-v3-v3-11-0c8af94ed7de@valentinobst.de>
References: <20240131-doc-fixes-v3-v3-0-0c8af94ed7de@valentinobst.de>
In-Reply-To: <20240131-doc-fixes-v3-v3-0-0c8af94ed7de@valentinobst.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706732646; l=2616;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=BwWMsMRSeC1kKnnmhQv6fYuKaj3M32UFlVEb1WuNzkc=;
 b=wGvATBsFaAo4TY5WjEUO/KspVCL0ZjLBOnY1oLObO9aK45Ya/Q4PX1qIKBNDOAs/Gdt0eTaX4
 wkWoULzhHoiBhoqQzhNokpuv3kiGrC+SwHm+BrqDtAZihlX+0ppEWpR
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Endpoint-Received:
 by B4 Relay for kernel@valentinobst.de/20240131 with auth_id=124
X-Original-From: Valentin Obst <kernel@valentinobst.de>
Reply-To: <kernel@valentinobst.de>

From: Valentin Obst <kernel@valentinobst.de>

Remove explicit targets for doclinks in cases where rustdoc can
determine the correct target by itself. The goal is to reduce unneeded
verbosity in the source code.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/workqueue.rs | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index ed3af3491b47..73d6fa544ca6 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -426,13 +426,10 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
 /// The [`OFFSET`] constant must be the offset of a field in `Self` of type [`Work<T, ID>`]. The
 /// methods on this trait must have exactly the behavior that the definitions given below have.
 ///
-/// [`Work<T, ID>`]: Work
 /// [`impl_has_work!`]: crate::impl_has_work
 /// [`OFFSET`]: HasWork::OFFSET
 pub unsafe trait HasWork<T, const ID: u64 = 0> {
     /// The offset of the [`Work<T, ID>`] field.
-    ///
-    /// [`Work<T, ID>`]: Work
     const OFFSET: usize;
 
     /// Returns the offset of the [`Work<T, ID>`] field.
@@ -440,7 +437,6 @@ pub unsafe trait HasWork<T, const ID: u64 = 0> {
     /// This method exists because the [`OFFSET`] constant cannot be accessed if the type is not
     /// [`Sized`].
     ///
-    /// [`Work<T, ID>`]: Work
     /// [`OFFSET`]: HasWork::OFFSET
     #[inline]
     fn get_work_offset(&self) -> usize {
@@ -452,8 +448,6 @@ fn get_work_offset(&self) -> usize {
     /// # Safety
     ///
     /// The provided pointer must point at a valid struct of type `Self`.
-    ///
-    /// [`Work<T, ID>`]: Work
     #[inline]
     unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> {
         // SAFETY: The caller promises that the pointer is valid.
@@ -465,8 +459,6 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> {
     /// # Safety
     ///
     /// The pointer must point at a [`Work<T, ID>`] field in a struct of type `Self`.
-    ///
-    /// [`Work<T, ID>`]: Work
     #[inline]
     unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
     where
@@ -495,8 +487,6 @@ unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
 ///     impl HasWork<MyStruct, 17> for MyStruct { self.work_field }
 /// }
 /// ```
-///
-/// [`HasWork<T, ID>`]: HasWork
 #[macro_export]
 macro_rules! impl_has_work {
     ($(impl$(<$($implarg:ident),*>)?

-- 
2.43.0


