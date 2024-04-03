Return-Path: <linux-kernel+bounces-130605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ACD897A63
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F41283153
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC4815665D;
	Wed,  3 Apr 2024 21:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="xErRji5z"
Received: from mr85p00im-ztdg06021701.me.com (mr85p00im-ztdg06021701.me.com [17.58.23.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BFC154C03
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178435; cv=none; b=tmlCPAJXWZuUMcrs9PQ8v7dVauSuSr78t4MPYedMxJeD+dAjkVtLYyl+s61L4CO/H+6lfLyqvsW5k1TagbMHtJO7fhUm+YoJBIOeGOx4Z6/ulglau0XLSByNSZJSO/99N061QUaSLtaeUI0VS2YeTratwuLiNlIhpqCuYEraqlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178435; c=relaxed/simple;
	bh=0AiZM6PiLalckeV63JNhtHUusQZnUdQA6buUd7aeJDk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=d+7T1RJJWys3dgILWGzBLtRq/F4HJIWbd6omWrsNG1l93/CmEuZNuGwd6ftsKfcdX7VaYrDUzeyLpldwgLGvJV6UKJ0dG7VAoGFUN00sFLiZzm0b1+LmMuP/qf/S6hgHfcZPBlutu0QwL6OKMfkqhGa/km/6JJKCUec2q2GtNmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=xErRji5z; arc=none smtp.client-ip=17.58.23.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1712178433; bh=AY0YVT2/pYp771gvWdGaXCfqZ7KgXeM1P5FSEBqw7YA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
	b=xErRji5zX/NvKMQXFwcPYZhTN9qkg6tJPFvY6PX5I/0F+sgx8NG0zyQFlJznXCvkQ
	 WpCgF3C/PJOga/QRYZ4GJgLmZ94IcGMQOtVsJwVOUwGo1UFeYrVxr/cAhmQXfIMH6U
	 bN3Qzbv+Do8UPEd6BiG3wAC4ccO/nADUAWNh+oxT7wF0b5Pz13dUvilASFejaCZv0E
	 niketQZbu3RTE/WSO4xbpV3Q+CqO930sZrm/tsa/uLTVIpPkvW7Ef/X5nrZSlf5eJ/
	 5sVZb0DBHac+AHoeU04c4xWtxOYhF2fKkIGogV0kAPiXRaO88d03NmTIHs7Q3W4DQR
	 hKNW4lQhzgZRQ==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021701.me.com (Postfix) with ESMTPSA id 6E37E26335A3;
	Wed,  3 Apr 2024 21:07:11 +0000 (UTC)
From: Laine Taffin Altman <alexanderaltman@me.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: [PATCH v4] rust: init: remove impl Zeroable for Infallible
Message-Id: <CA160A4E-561E-4918-837E-3DCEBA74F808@me.com>
Date: Wed, 3 Apr 2024 14:06:59 -0700
Cc: stable@vger.kernel.org
To: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 rust-for-linux@vger.kernel.org,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 lkml <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-Proofpoint-ORIG-GUID: 8aN3UzxcWvmPcgHFin2Utvi_e7K1jNVI
X-Proofpoint-GUID: 8aN3UzxcWvmPcgHFin2Utvi_e7K1jNVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_22,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2404030144

In Rust, producing an invalid value of any type is immediate undefined
behavior (UB); this includes via zeroing memory.  Therefore, since an
uninhabited type has no valid values, producing any values at all for it =
is
UB.

The Rust standard library type `core::convert::Infallible` is =
uninhabited,
by virtue of having been declared as an enum with no cases, which always
produces uninhabited types in Rust.

The current kernel code allows this UB to be triggered, for example by =
code
like `Box::<core::convert::Infallible>::init(kernel::init::zeroed())`.

Thus, remove the implementation of `Zeroable` for `Infallible`, thereby
avoiding the unsoundness (potential for future UB).

Cc: stable@vger.kernel.org
Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and =
`init::zeroed` function")
Closes: https://github.com/Rust-for-Linux/pinned-init/pull/13
Signed-off-by: Laine Taffin Altman <alexanderaltman@me.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
V3 -> V4: Address review nits; run checkpatch properly.
V2 -> V3: Email formatting correction.
V1 -> V2: Added more documentation to the comment, with links; also =
added more details to the commit message.

 rust/kernel/init.rs | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 424257284d16..3859c7ff81b7 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1292,8 +1292,15 @@ macro_rules! impl_zeroable {
     i8, i16, i32, i64, i128, isize,
     f32, f64,
=20
-    // SAFETY: These are ZSTs, there is nothing to zero.
-    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, =
Infallible, (),
+    // Note: do not add uninhabited types (such as `!` or =
`core::convert::Infallible`) to this list;
+    // creating an instance of an uninhabited type is immediate =
undefined behavior.  For more on
+    // uninhabited/empty types, consult The Rustonomicon:
+    // =
https://doc.rust-lang.org/stable/nomicon/exotic-sizes.html#empty-types =
The Rust Reference
+    // also has information on undefined behavior:
+    // =
https://doc.rust-lang.org/stable/reference/behavior-considered-undefined.h=
tml
+    //
+    // SAFETY: These are inhabited ZSTs; there is nothing to zero and a =
valid value exists.
+    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, (),
=20
     // SAFETY: Type is allowed to take any value, including all zeros.
     {<T>} MaybeUninit<T>,

base-commit: c85af715cac0a951eea97393378e84bb49384734
--=20
2.44.0


