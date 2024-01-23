Return-Path: <linux-kernel+bounces-35622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4104C839451
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BDC1B287D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE2D664DE;
	Tue, 23 Jan 2024 16:06:56 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586906166E;
	Tue, 23 Jan 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026016; cv=none; b=nyypNh7TNCoZx0MAMBBzlkcAXYE147U5DBGYQggWIlZfq0ZVCtC0bHnqtiiroyKeEEQLNG9OXrX/HzAYfkcDao2X8cUakszzWc7TtCWhZi+MsA/UVCBVIEhzM3SIfD051IFFnnpURADo9s3tuloYk28fD0u18dtb1muRK8NnkNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026016; c=relaxed/simple;
	bh=+hqW3hOQC1UxvdWfn9TZu3+fIZ7vvE+96H8K/qkpMIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2ZGD0GrSHJJFUn8ni6Exea8+KGGBZ6MYZQ079Sfu4utVnknmZfDx8e8cMNVnCESpsT6sb58YUTX/k9pbMeVV5y9W0meJmCkb9frRuEU7lx+7EpPtf8zpW5bNvmvpRp37bbnw8hVpX/K2Is+htwvKTzh2drPZE57u0j0IaeyIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N33ZD-1qy6RS2jwz-013OUg; Tue, 23 Jan 2024 17:06:43 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/12] rust: str: move SAFETY comment in front of unsafe block
Date: Tue, 23 Jan 2024 17:06:41 +0100
Message-ID: <20240123160642.125285-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123150112.124084-1-kernel@valentinobst.de>
References: <20240123150112.124084-1-kernel@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kkN8nkXFa/+Hos8xuVkzUCkfnQm83AX9LM0fqlu6ufKA1n6bf8O
 fDOu/W245ZOO3bxg1ZxOjfH79yvO+QF8AooaTY6iw9PjLiYxTmqyNvNIcn71GYfsNTbsurI
 gd9IazbpuqpzwB3Pi5WruGqT8LUUufy0CK7Vny2rw8uq6ysgNcN6oRf7TVYQI5Syb+YmCAH
 KOcm4J6PT92OtwpvFZj/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UXzJXFTNxhQ=;cigvECPexeR2yYWYYtRlxnddXJ6
 uUuC7zyc0G9/wix6gcrdC7KEtbWMeFKzssrRHli5z4UlFn0UNoJ1WuF98fKFmNlYjMx47bos0
 k1uPNIXPGaHB515jcrN93YXGHA2zlk187NkpHT1zlQbzxPtPkBZZCw/PT006GpZ7oJ17bR3/6
 SrV86T+WRZBjoXxj2JZ8D/9ZrNB3IPeDhNtPVSpZB/m7OmOLK/0b9sr9MgpOl6joC1O/2AEEL
 3i3eWtoWc7KIj3U0NWnyrirRII/JezCsrE48ZYrBvhkMXyGcECKA8pVHjEMuSMqw3+6TMInCl
 3Jvs6f5UdV1eP2g69l7e+uBeug/sRpnNU5BajfEyilkOdkI6TLMoo6EBbivEOValh/CAXnQfY
 TI+Y0ow2u+kXmizqRdSlLU6Zr2o7lnV2cPLL35MxQZbpSXK9ChdyiGu/Lz+r0kGmFXgsO9tNX
 6cwAlJJW2N9EivRWNE7Sug2jmn2l0e+g08cTYi10LUcbJUiysJEsFONBPpNbwkO/BQK+XEeVS
 HIVqW28zSUS6UW/jNRiNTyNirD2F+Ztr86mh44D0wG/l9rQq4JEuoZH2frQ+gP3jnU1nxZjur
 UxuAzcvZ7L4DOTtJkXHfcyR2hnLygWhKtwPwVJ+8vUX/nnNhMVZp0DXza9OYV8Qo+NFSGhAf4
 bjZOiQ9iKN4muNIKJUQaci8r51eDuxu+OE0S3GNFIYRbC37Nr9ROvObaxE1i5zOFl7isjJEXB
 T31yEA5ZcGGg0WFUFMVVGr2jXFJlD15kjmJUF4/YIyO2w6gja72JsQ6vjpThXXGEpR1tC1XNY
 dkrkmGZJ2AVv91Pb2f3Z44cg83hsI/ZVgd6GIuufvk7UkH4swQp5jHLM5Oo0Y1RSnHRT4xVLt
 vc79mNqvYvfN2Pg==

SAFETY comments should immediately precede the unsafe block they
justify. Move assignment to `bar` past comment as it is safe.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
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


