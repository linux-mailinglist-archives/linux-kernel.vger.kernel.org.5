Return-Path: <linux-kernel+bounces-28392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B90C582FDF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DBD1F27235
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5768F522D;
	Wed, 17 Jan 2024 00:16:20 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1210EB;
	Wed, 17 Jan 2024 00:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705450579; cv=none; b=hPKlkagP6CspIGiOf819QTawQBc9kS7/XvmZJtShOnKKkgPAkExysm8w3hW+vdT17r4I9Xva62wJhyZPFDPhLOvFEblfobCSj8aLhruNnoyX0TGteaqZ56z3eBks3pkadEM/jp0znRxaUCmOojzJ7KS9Mksb2om37Cb+HCI7xSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705450579; c=relaxed/simple;
	bh=29I8vQfcBLV9mwZoRiepEOKD8CS2T7TWmyPwGLAV5PM=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport; b=rf+0Yc6A+iMBpywfkuvvFA0ZMAx0ZVj4N7nWvoovex3D7PNEYEV1fujNTk3tnS17U8jqaGa/pJ7pUmB+q+1ndYDbAJFy6DawodEQHXywTdyKomRRW+Ap4G/ZXuw4ullBl/yUG3TfgQOjfTbTAmUhk7+MxeulXy4+eLIfFlEHBiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M8Syu-1rUHJq0QJE-004Wpr; Wed, 17 Jan 2024 01:16:02 +0100
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
Subject: [PATCH 12/13] rust: kernel: remove unneeded doclink targets
Date: Wed, 17 Jan 2024 01:15:49 +0100
Message-ID: <20240117001549.169160-1-kernel@valentinobst.de>
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
X-Provags-ID: V03:K1:vKGsVDD4K4O8G0nQOnjmofp4+nIqOjtImagczD6YhwgfOa9ZS0K
 rV8quU1oxXtmNfI51VhLGnGngF55lx7+qIxTZLaYsSg3hjPOu4jdtXD3cCoqjNH+406CRDA
 Wgyvd6R06NJKSDsvdRJmyJReq3nixPvkDwGgwbJrSvOeYDwnM4ld3s1pEzILJH24wIHFAlB
 D1n2qF/b8uNVv4bKpxiZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3OczPoTzmTE=;S9W2oLrRDxGvXikdidPbco6b49/
 iSusBm28Kp+2/S9krGAq/FWrQGGIs20nsXeQlDr+QvLPy1tZRtCQ5Yfg5adWgUi+BsVyM1+UH
 qotwLO6DsBzpuIlpHX7Ah0zYRgEk7H+qseieip9BYHgI7T2jg2T3OGrxXLok3IS+8qpSq6c1a
 t7oLfGyznK8sBC7we2kIcU9X/dKYmPJjTXstM+IZMvruddlJ2QuVe0IXHXIuKF9E03bMBw3Mv
 BRRA4TG9ZrbwIxJaZi2xE5zGytxJbw/Lcxvd/AZ+XHPqyoZN8KNnuQe2C/kgs86wUT1yBqBgu
 D3kDbVyzV38PhJiCvO/HE1+RxH6ONae2YXx1miUdl2UrSBi06jejPskoAhAr+CtlnYP8v9fAs
 PVdZyhCpdqHn681TZjqsRMAcwxYhD2nPpxGBtHitHa9KWUnwgUQYcWVcbaetJbeH6uDYabLmp
 1otc6pYhxA+H6cGBRCGOVqw86hFssHkGUaI3cSpGz2L3qhDLkMZ0DxhLuW+f3MX4fYyfOGt0O
 eqAbIGmsgFo3/3J99SWk+6X8XU46Ir0F04QADjJgm0ADyrOviWzi/AALS4ObAiK20FxAEPFkV
 KubovKd639u8kp+sxkd4C3+oBb4XEc+ii5D8V4mIn9abVGdc//vzxaf2joOHtZieV1mH7yDEH
 lzNsQuRTFNu5DXn0HexkjqjBjy+p2Z57i5tlmi70hSk0O2Rq5HIFYbJU1rm6bCKxqwYFUvQSK
 V8Sn5s6bNkv8nFpwpgOWdBNTn2Qx7cfWbxMFVJ29MmPIGSZRuaVGg8+bpXDpBEpAiV+OBaaL8
 CBZ5Kpp4WVEZSsUJZD3Oz3f/Yj3IFTpNrtVhZjbmfVhBjhbRmQ0c0TQwiV0O1+Q9HE2z5Dj0M
 /yYE8HCuQPWuAcQ==

Remove explicit targets for doclinks in cases where rustdoc can
determine the correct target by itself. The goal is to reduce verbosity
in the source code.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
---
 rust/kernel/workqueue.rs | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index aedf47f258bd..f63190b563d8 100644
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


