Return-Path: <linux-kernel+bounces-35487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3D58391EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6319F2895E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2260253;
	Tue, 23 Jan 2024 15:01:40 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8EC5FF16;
	Tue, 23 Jan 2024 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022100; cv=none; b=Gi/XSYRJ6Oai7qaerdcPxQS4/EKnyARQzLFMCqpFFhMLi4hf6eDbdBPfW2IqoRYhSwJF/RT/89zat6gQ32UK/0y5gUsaZ/QQ488FWfkS38H17vpe/qDNtt/so//4Zm7/J4W1vTbb21mGQNOk2L8xkIF6lxeUb4qNpZ+tHbyVeKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022100; c=relaxed/simple;
	bh=Yce6LCNFDfufjjVUpemLuje6pflWFyy3AoidicX0E+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJdv2tt0s8zMVypnggV0Gero2gdWaaA1tJ1NWRmHWbgdFXCw+odmHX3jfsjyUm20OIEpdmIn8D0CFdD/Mx+2TOZ8pRLzxLg+BLzt67pdPLa3mm9dtrk9n3YIyC0JG0u0Gb3ij7tDw0efMu3oKDeFBo9cJGMj1Iu8qPBt2Os5vMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MOiU5-1rk5bQ16kh-00QFYf; Tue, 23 Jan 2024 16:01:15 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Valentin Obst <fraunhofer@valentinobst.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v2 05/12] rust: str: use `NUL` instead of 0 in doc comments
Date: Tue, 23 Jan 2024 16:00:59 +0100
Message-ID: <20240123150112.124084-6-kernel@valentinobst.de>
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
X-Provags-ID: V03:K1:7j0l2qt/TSnuqOa+GwuIUPP/dYlzl9VnPmzTtN8FvIpOyJQrZAt
 fUKSM+gBxFb7RA1W/WkXJRtapNg99rjwnXfxgMMhX+2dtcJ0UQvmMk8dbcp+q2L3en28pYf
 +vhxt+IbuZGsJ+k8gXb8w7x2swjGm10rHMU4JvmbtcO1LeD/xP/0XDcEraDijaVFLOMsDqi
 WMvfdWTBCdQU8BUSH1a5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Yr+uxGb4l8k=;C+NMWIt5EaNZLPyAyx4zeSzwfLH
 fWU6XjGepXUvADbSHAkGWOMUT1LxkFgeMtm1FuMnW3vCA5jiNbnFyJ89wUJTqKHnIHascQ/x/
 Ks7FWqs7Ul8zyfSKx5wOXwL0BxgWgH36vE/PIsmWciuGB3VWKLu3qA9LHqCkbH3L3JReLxDn3
 C0reOZG0LwFFVsePCwwdcwpssBzProYYfweOz3cpPh5sqXno0u2NfE3AmXSxFTyaXLtwnc/73
 094LMjN3SxfQwssIPrXoPaGvX8SspJCjLXCeFSBcmAcTGgTAsd2kU2BWg4oTBYvlehQQ1PhLJ
 VWjh/q0fs0ByyLJyH/8RDCb74GuwAeYdMFPxrC4nPXVfeoyfEoQcVLt6qPEcxqtKweNXP9QRG
 PerZdcYv3cj1eAeQ+znMxLhkxAGsMJVVn+7LZP9whD9VlaqujWmSAO6FLeK4N9XfQXsCNGONx
 mKOOhtqCP9bhMnzxsQQtnl29iI+/LBFAbBEjdRfxdaoUiJCuwL3/p1T6qQAjxgrvWGdnPzE7L
 xTEOlWPKGy0FI23dz/u3vEmH08uvJbBMZyu5joRrR7W0mwrBtQZIo1D6lS1ikvq1KHBuq4/cF
 YQX/GGOLnKfh7tQ+HzOf6m0i5VcW4bfswEPpiPBZ5rjXbJuJpWS6fn6I0aXj6aBiQoJshL8VE
 jbVxrSYTc9+gowf0NpMr68jBTK3pBP7a+ktAq8mDXRvkOu7cHzZ+sWjXpFVzGEOTHKAJXWQ7f
 JeVoqzfsJxKvrVY0GKhJqJewCpGOsUgjzlqp4SeRXiGZn4QA9r8VQN/eE4VVezKt+Lt7P6bet
 4MuyRdmaAGsyuezzxo3FU8YgsMZizniMauJFrRZA90yBTK8PsZFSrs2e83x1r0Zn7UV+d4UUs
 UjKJIOVDL2wFyEiFkgpbUUMWa6h4v/vyPaXk=

Throughout the module, bytes with the value zero are referred to as
`NUL` bytes. Adapt the only two outliers.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 rust/kernel/str.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 0a8569594fc3..843ffeec9b3e 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -149,13 +149,13 @@ pub const fn as_char_ptr(&self) -> *const core::ffi::c_char {
         self.0.as_ptr() as _
     }
 
-    /// Convert the string to a byte slice without the trailing 0 byte.
+    /// Convert the string to a byte slice without the trailing `NUL` byte.
     #[inline]
     pub fn as_bytes(&self) -> &[u8] {
         &self.0[..self.len()]
     }
 
-    /// Convert the string to a byte slice containing the trailing 0 byte.
+    /// Convert the string to a byte slice containing the trailing `NUL` byte.
     #[inline]
     pub const fn as_bytes_with_nul(&self) -> &[u8] {
         &self.0
-- 
2.43.0


