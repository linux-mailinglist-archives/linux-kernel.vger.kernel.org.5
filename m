Return-Path: <linux-kernel+bounces-35501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C508283920C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0379CB2344E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EE15FDAF;
	Tue, 23 Jan 2024 15:06:49 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181A12E5F;
	Tue, 23 Jan 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022409; cv=none; b=uTklm1Xt6HWjJLTX5oWZTaIT3FA/FgLmMYJSCFl0dkZpSLPof2SHg2OYEIo16hza+c4BZFheAnB1UI8EDFS+N4mwUjSBTWUExk1b97w7oW88w6uVvMUdYeLArIB5kHN5UCzBJ7e7aTDW/ry2KjEpQzXKJZUTuL9eE1o4mb+6+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022409; c=relaxed/simple;
	bh=GJpHxUZgsNOhfmPXN34zV/Q98aBhZ3HJz6NyPTVit38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkXuRXvImUebQZ6n42eebEJNsFYRTrM2GK0i9Ce/mf3GwIErZST4ZIA0ab16I/pltSVHrdvy1BxDaPljxcdC8VJrWFKt5RHx+3dXdpoDaU6mWMhAvETvWDQrXf29uaLq1oVfbvsjKeYpL6TlF3LSC1hYYzZPThwy0ngQlOKhk6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M58SY-1rRBoU0iHs-0019EA; Tue, 23 Jan 2024 16:01:14 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Valentin Obst <fraunhofer@valentinobst.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/12] rust: error: improve unsafe code in example
Date: Tue, 23 Jan 2024 16:00:56 +0100
Message-ID: <20240123150112.124084-3-kernel@valentinobst.de>
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
X-Provags-ID: V03:K1:Q+PbWlm7KEzwAudMeK/POSxJ0Gg1YImwqbrj7gPCT82nZXIj3fG
 7AfXr+IptD0Cih9eO5OzAntJyQIZgBwtDaJCuRzPjMpsXmTWNjeXf8Fs2+rYCTnHmWxZzD+
 FTHZ1Yuqo/2KmNQxlVQ0X8T72noWnsC0uUR9D4xk2zB7Tda3wxwCg/svSWAPw1KseRtN+F6
 X5bdASho0EGGX1Ixtvf+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nZMX7QKu8RM=;9wg1LjzrIzOfvtQl6NTqB5t+lrV
 gnjeJjD4gZJCPDuJQeVBuJrQBtA9H41Tk4bE9JB0E/o1PwDUzyGuWZCzv0nnIR9ZN6Iq9yL1m
 31mZ3WuRKfSjBs/jtwUXPhMeg55BEfFAoaO1ehsRxI3v+nZ8aa9KEP9sMvuP8hwHl6NaXBIsI
 ZYCHWmdyh8xX8bUNuKqeIcErqriGfaB3zByDrOxQOWkirbDw1KeP1KGApqq86LFgzVKxcmbqg
 cJAvG2INIV9Y0BRGGnGGcM6PNUfSKumr49w2lMxNSyRLxGthcv5Zj8bfo2hpsHhgZ23lgeH2E
 V38a2lEdv/DcqIz8xilIqWGqFrdyz8v7pI8d4+Ut4p7QNaCDhER8Lo/xomz+5kK1i5chDo6Vj
 qDnp38VP4Hsa/w3ozeY2+gj1EDcs0qUiSxxq0FiMWkzyJSy/NHeKWHpNsy+e3A27KNFYt97Vl
 dTu6sWqv1JmFbzBoJsXE3etHdtQOA9gD6qt3D3VK6o1ED4seIHAXLYNmheeannXgDuFLa/yCH
 3spWjbVo1qgglqi+2CvNf18f5t65o0wDMj5rR8FW0eRAGfqXaSCj2CqW7qeeJkYjXeVtVdS5t
 TlYz55bnuajLjCM6Df2Gzj5Dt9gU9PQjU6Ar0TQSWwiDV83MSEDvd+a2rNzL1TNxoK3HD4LZe
 w+KPhA9PZP2n/yNP3x93wGbAGsIqoIGP1A8ur0MoJTt7p2QpakEGidfEoqGYFlc9yaXqyysuC
 8ZEGHiU3PecJ2lZapfZi8i/bQqRa+3AOg/zHYi3UltuLGSTauHpfn7dlb5c0SB+duc9Fd+mEK
 s2C/e0/H1ReFSISRe78mEIyrXbU1wZj0wVxSpcVSBsaloNN4XilijjeO2Bctzdtva2Z8p0wUS
 ArN1lES3KKjg3rQE+EbPLyEGISKvQ+0mNFyo=

The `from_err_ptr` function is safe. There is no need for the call to it
to be inside the unsafe block.

Reword the SAFETY comment to provide a better justification of why the
FFI call is safe.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
---
 rust/kernel/error.rs | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 4f0c1edd63b7..4786d3ee1e92 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -264,13 +264,9 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
 ///     pdev: &mut PlatformDevice,
 ///     index: u32,
 /// ) -> Result<*mut core::ffi::c_void> {
-///     // SAFETY: FFI call.
-///     unsafe {
-///         from_err_ptr(bindings::devm_platform_ioremap_resource(
-///             pdev.to_ptr(),
-///             index,
-///         ))
-///     }
+///     // SAFETY: `pdev` points to a valid platform device. There are no safety requirements
+///     // on `index`.
+///     from_err_ptr(unsafe { bindings::devm_platform_ioremap_resource(pdev.to_ptr(), index) })
 /// }
 /// ```
 // TODO: Remove `dead_code` marker once an in-kernel client is available.
-- 
2.43.0


