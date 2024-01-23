Return-Path: <linux-kernel+bounces-35630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B718283945B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596E21F2149E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F66664CD;
	Tue, 23 Jan 2024 16:10:23 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C876A612ED;
	Tue, 23 Jan 2024 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026222; cv=none; b=fCctp7mbn0xsPfwEPhMxtY5P8xnA7xWDr2Fqbr+frHPIVDwMqb5w7ep0TZQy/3lVs0hCpIm6asDCz1OxHGBl1fBugsq6t2UrvoR75NJB3q1cHqgcz9GOfs2/wqNzC13/oHCGecqdd2Go2zQn8WbF3pbl1OhIYve9c7in6fanYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026222; c=relaxed/simple;
	bh=ynU1HC6VgcbU8Mv8I9+BJ3zkWxcifHhQZBpm4nI9Iuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hj4D3N+gopZIpY22hR3MkKvObnfT9eCqAASuMLEUk2hgt0lf9X4MU3nzlky27xxr44hSYVd6tTAh1BcJ7nq51j1pLKTmPu7+JIKx4o81/gjthi0xG74Y239Solc2peLBQeMEXQOS9IGw+Bh1JTuMo5yQz+WQ+4VEsN/t8vpnPbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MFbFW-1rK3DM0aNS-00H9qe; Tue, 23 Jan 2024 17:10:14 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/12] rust: kernel: remove unneeded doclink targets
Date: Tue, 23 Jan 2024 17:10:13 +0100
Message-ID: <20240123161013.125396-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123150112.124084-1-kernel@valentinobst.de>
References: <20240123150112.124084-1-kernel@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:d+sLc+PnG3T50bn0EmkGevLMD15rUA9+7Q5nmFP3P/4bKtDtMgu
 2jEOFVLIx5k9tL2TPLO11K22kuvE7QfpW/ZAEl/Aih0apm1QlHcAC1Wxd6g4J87lDj+4iNW
 N+VKzKZiibMXqAZr1TCa0XOdgqkxbzTZsbIOLNwPCsnZwgxSP3/c6uARsqOAFcqQJQdFBOS
 BYhUmU3S6EVf2w9j/L3fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NPRaYtHirQw=;U3Bgv/YyqM1QWg7UpR6MKa4p2G9
 WVMKbmDIz6F4zDIZZ//JzAx1peWR88NWxKI1KTrnymNWsiLxPDj4Y3enG7pRVOTAi430TFRnB
 QWAVXBdOrw6ajJx1aPXULQqZMXrxdYjWmFZeQPfmPl/KQpZkmD/uCyngUQUpGxQyWAE3Phbqs
 p0Qe60KZXOPQcRU/3zU9LEncjI7aP6BqZZRDZo8MmRNExWcrTBex9B+cC3oMDpDeq/+F99jd6
 qx8d96nlfONhUZikJHfT8aBYwW/VufhJB5cVFc1ZcgMlua/iL70TQ+REDBnoLkzgBhIXjsvUM
 Ben/tKiH0HUGg2sDXuuLgbBnOeZE9cOih6X4tnRhiFdhCUofflFJ+/t+zewGDm/5t/ajLD7f+
 v8TO1AYPe3efn5zxsZP16586fr+NXKeGP84AqjCh14A6PHECpL2g2I84I0CMFn6qLifvTdVXm
 +d1OJKW40ZZjAjYHU4/0lGiCxPVWESxHI54CUej+E1aEMv+ZB1Nel0C5A3WnkDYyqV/JKTV1m
 264sdXZUjHK24vfEEkj34ZYHKpYDL7W/740uxUJsyS0PzeS4OoyvQSF4oxPUDLvbPhkGadlqr
 AgKexFwD4UUBQoTCmY6zF8Pje6VLMwiJzYThyKLWEYqLS43HEhHhtP8oxBKMBqXtV+yWCfQfd
 1voe+u2RDGHWHR9KvyGYkB+Ahw0N/2DRchyYSKJmXZAkqFTHNy/emWwOPGAoLP3i+XIpxTkhH
 BshqTTs+NVh4uaY1W3YAZ04UZpacHRUQbU4LX73QIOQJbKU1eNk4zbTIrE/zqn0EQqZzF+/bV
 sGMVEeglbRqJ9BIR69RkSfua/cgxm/zvVA2T/Y074hVsHXtRhmCNyCwpO2SfI3if5W2CGrrvG
 uBf+lISYdm1zCGQ==

Remove explicit targets for doclinks in cases where rustdoc can
determine the correct target by itself. The goal is to reduce unneeded
verbosity in the source code.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
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


