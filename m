Return-Path: <linux-kernel+bounces-28332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF3182FCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D651F2B739
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77134F61E;
	Tue, 16 Jan 2024 22:06:38 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883C482C5;
	Tue, 16 Jan 2024 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442798; cv=none; b=ncLpNUDP6rVBA7je8M67ZQTVg8omVdLPoziGLSyX90r/VpwOWxt3s6mqvmgHzhp0h8/RkXKc/57DoI/OWjgTM/t0zLvvt0qDCRVuDXdF2s0xPt0p3BLH/tI8sd5OydaR7/oYC/0Kag4lytsj+VYUOEwh/8vZ8mbt3kJ/cBVFPlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442798; c=relaxed/simple;
	bh=qk5bZBH+v41bJbF9eA7PUNh+z+ew2nxhcrsQeadaNNY=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=HxBuy0+K+r3q8eiBESNUBRDIZ60i7EYGZb4IIUpwsSyDiMDyxH+VUDFWwZU371urm5vaqqC+K2mrmuzZuMCWxNnjGE+plE6rQ8w7OP0PsnjDf0v2zQxaXk9NIdvQiwO8ciGgJXmqVwHBFA3WotFalX6FHkCQe+MEkssbwgrkROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MTRAS-1rZe8B0H0e-00TkmV; Tue, 16 Jan 2024 23:06:23 +0100
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
Subject: [PATCH 06/13] rust: str: move SAFETY comment in front of unsafe block
Date: Tue, 16 Jan 2024 23:06:08 +0100
Message-ID: <20240116220615.168083-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116160141.165951-1-kernel@valentinobst.de>
References: <20240116160141.165951-1-kernel@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:92bNKdsjs75qSuvDF2FfcB++cPal267HLhMmtY/xJxJoC3ADGN1
 Q0SezTBfAlV6TObTXq/zXit0+qvLYh5/dYlHlk1bPM2kICVcDSNmVON061S5cgGZpoknMuR
 a2yEumtbq/wshozvCHePnlTDJGeXEJGfhNEevVJRwW1ruSQWCtm32mt7xQq3WCo1NvzPaih
 rL/R6VUX7Dn8WKCH7eupQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IDkEWhURD7c=;ReOjbrZ1lRUgApOj8G512ld2rTl
 aQs7HB5kgSZXS6lHwfPaeXaHxoZ2OpWlmXyb04o8nQo8QtRcdjzvERRCOyv6t2vpknYmWf/Rh
 z9cjszLazIMHfX4PE5pQssyfLVD5v4XaTzMazV2Voo9juG8U/oOATNg2uwGnvlGjlxo6YUR9K
 Hb9o53W2yCkumbzLM3gqrtGJZeJVO8cmcwwl28KDQBXh/YEWWWAtiWp41rHq2auHVAlVSyIZo
 YrHjJpgOa1g7+Qr06o4UMyHj3/SNxEe77QCwCrHy0FTttlRPh3fS1DLmW4P5ai83VHK2IOnRP
 YoB0iJ1eHGHwfgIvPfqrd/j6EJUm0aKjPlyXdY86kh+YUk6OZhYv7hLvUCoNxbAiDxu8zJeSM
 SQzQw1wPlP6Ktlpl4eCCw2yAoCk8POJN0lWSlPRFDxldxkzDiCHLXQ/V8Vay6S/kQRWz9mt6e
 ibwo6WzLSqYg4x4WxPAfZJhMUamd7ige1FWWYijTTUJazH0nJiSTVWfYipaul6+e1wPq/S6rv
 NUuT+PUF+cAKZlvqx5/pF1uad1auLfgdtawVH+4sAyT6TljbD6aBEJ8Whcbn37FyjjRH0T4XI
 Z0tjlVKjGzxAnFEClmooSG3Yrosh3gr26aA8nxichmw1Cbd3MppzpmSmZJc1P0mB5RZ4m7rmK
 JURAwDyOG/0fz/jgwCz6LaU7Op+TqtRNIk9byzpOz2o8eeOGVpECgUaUOIz0ANaLiWWHzRq6S
 1pcMfC5HUmvEM/NY2UkCoN9rPpZwFAJ9Yr1E4O1RTClipec0ViW3v7qWABY1vbUSRcitcOx2n
 wvIt3M4HoHMTJxrcOS+j/f6nbFt1Q5rtZGR9er3yrixeDnKbelUM+SUYtu1z+qPzHV3sMnpqF
 r50BBcY5rmvXpBw==

SAFETY comments should immediately precede the unsafe block they
justify. Move assignment to `bar` past comment as it is safe.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
---
 rust/kernel/str.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 843ffeec9b3e..fec5c4314758 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -191,9 +191,9 @@ pub fn to_str(&self) -> Result<&str, core::str::Utf8Error> {
     /// ```
     /// # use kernel::c_str;
     /// # use kernel::str::CStr;
+    /// let bar = c_str!("ツ");
     /// // SAFETY: String literals are guaranteed to be valid UTF-8
     /// // by the Rust compiler.
-    /// let bar = c_str!("ツ");
     /// assert_eq!(unsafe { bar.as_str_unchecked() }, "ツ");
     /// ```
     #[inline]
-- 
2.43.0


