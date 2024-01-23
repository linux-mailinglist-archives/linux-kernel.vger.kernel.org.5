Return-Path: <linux-kernel+bounces-35489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41608391F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD60028109B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA52604AE;
	Tue, 23 Jan 2024 15:01:42 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E605FF19;
	Tue, 23 Jan 2024 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022101; cv=none; b=eg/dGrIu7UyIX1uDIeSrcNXr5mRAByKNv544xITWypEI5ghAeuY3Oh15lod6/XWObizTxi/HwobqeUuwvwolhxo3p/axMOIHS8ZgfzU7B0QHAYJTho+9VhjQda7nPX2ILub5ZWlLL9Iz+9beilcOW9RhHD3qPh9ORgYUOh0DRdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022101; c=relaxed/simple;
	bh=fhb/oh2DjO5i4p0NG4q+kRApXIkNKfH08q5C3C9RYOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVZx+ooQaqhFxRH5B/ni0a5rc6aURYTMXO22LEHPxtqlAZk4yHyqt9qAjsMW/fNQKbhqkE47NiD5Qjg5Gstcp9mhWrJn75A++ui5cnJxVf5QI3o0XVSECTqqmR+Mnu+4O0+y0Vv6qrDhByt5MEoRCcgODAh/AJUB/BWRQG2pTWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MI4cT-1rLz8X3v5r-00F9jd; Tue, 23 Jan 2024 16:01:15 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Valentin Obst <fraunhofer@valentinobst.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v2 04/12] rust: kernel: add srctree-relative doclinks
Date: Tue, 23 Jan 2024 16:00:58 +0100
Message-ID: <20240123150112.124084-5-kernel@valentinobst.de>
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
X-Provags-ID: V03:K1:JNxLmFOZ11mhsC9TPd49E2fYhC9noTIOCRe0QaefZ6t7OyfdHYO
 k6RpdFWbgiybeZUzEbt98mN+SQa3F8eAchgM3etm5HkWQpBMPGosbBU3EuQDx91Xp5BE7YY
 vcsOavOyksbhiM6QDxPRd68CCG47H39jtjOPOI9MkdZaQ1b9LeZlM+bplCvu0OQgEfJCy1e
 yGuIfusl5sXPTiL/42Lrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/peIACBikaQ=;YUH0Mo4Pgui0DLgpUsdRwjU+mFi
 GDpqTkT6icNR2B3R046uoI4cc3VO9Z1jNEgTYPzs0OtS7693C6kROn04grWKQYZmtMu9CrXDG
 wsYhsxoJ9wG4+fm+PeoKMeQfZs8sRj5XM7EOcawu3UUZAUYcw4hBEy6exew80vKIUUXa1RSas
 XxZJVyr9148jZD5Wqp1U9IodzAi190ZowAGkZ8vdEEvzGc0OUdqetPDOOGTXifbRbx/L2BuG2
 I0/R7CI1Ipoyk1GwmzOUrR09vEtMruoYHqlfJqMQn++GW41sVSSHX0WaDlhndcj07od0ieCDr
 PeTd+WuhCARItcuZpshU6i8bqyUgRCd4P3ef3n1w64B+CVtoCAccaJyQCvclAoseZkKw4jM8n
 mzHbat1AeczypXnUYYzoDR6/GH6TJpbewzSIII6VaMOPCxwwDVmrymJPiejSP8q1S+PU0P1g1
 cxhFPhw44g53XTDIw2S8x+oS7ZdRWvg158Jpwwwo8qOJfvD9iHZneBilR0hR4vzczc2Gkygpt
 mD4i3kWOFFMxmYpQDtTd8GITIzPXDuc7+HPDgs9UumQ6iN1ZERXGS95RFmaXDFK+rC4bE9KTD
 aj2eke+hnU8Vhm4h28CVi04h7q6Dc/muwLs50T843+wgWzzR96DiJxQzMw6aroPXPdCBSGOFY
 wtSZ/Se6HXqkanMP2X8wubBJ6zzMh0bpaJTf9es9zp2BMKV2U3yqzQyqjOSzXt/D8XBNNNP+G
 ixB9HQac7TcgKsGrjd8i1r/wi/8XA+lIyDJIV0k+jl532egVSH3FV1Fq6YAinP52cdL5BUIKh
 0/jAvP9gLmNy1rr6GfntaeohE4ZGFI/84FMBwtaRtxKWFulDBqG3ydWsM0iEtY/AJFr7D0jUT
 CZ8UsqLmOyjUntG8RQvwbhc30YLOfKaVXdks=

Convert existing references to C header files to make use of
Commit bc2e7d5c298a ("rust: support `srctree`-relative links").

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
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


