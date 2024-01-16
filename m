Return-Path: <linux-kernel+bounces-28330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0538682FCFC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C390B265EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D14482CB;
	Tue, 16 Jan 2024 22:06:03 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED28520B06;
	Tue, 16 Jan 2024 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442763; cv=none; b=k/ilOKYBDnjkICxlvBi2psIWE7JHxjtxOSg9UaIaMQK/2xOsiSZEmbqpYpWlD0w7ydJQQL1qbNDe5PVrQKXcF/Vp5p41TIxi/kA0wDIWlHVEbBZHNE/6OVkyKQ1wGykj22yODixTNwZRzHhqgpehiEaztefbHmV0K/qQo5efLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442763; c=relaxed/simple;
	bh=MvyFTKEIKMUi/DveRQH714RaRZQ4hMyEjMvMk9I2Kc4=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport; b=nGyESQEZgCVCMydIQIu4G0Qy/EUmBbQYr0iu5IH+DdFfrfLv0FGJjIPFReRifPep4ECDxEQfsqLygmw42dk2cmkpzMjVKoRUWMzKKTD6z41vZz748EXmj9U1/2DeNzz1OXCeHpDPi7DPNLNqFu+OYCaY/hdCLsByMu/IHTK43KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MQ5jC-1rlmA60xtI-00M2Ho; Tue, 16 Jan 2024 23:05:46 +0100
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
Subject: [PATCH 05/13] rust: str: use `NUL` instead of 0 in doc comments
Date: Tue, 16 Jan 2024 23:05:37 +0100
Message-ID: <20240116220537.168057-1-kernel@valentinobst.de>
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
X-Provags-ID: V03:K1:fQ/n+K82znhGVU06WPCL16qfSsnfY7jriAWKz19BeTo/jchs9x2
 jj2Cevp5lAEpIIYImIjab/lXFlPzmiQQUHAJZHW1o9INn06euHr+OuxP+pXxtVRpunF3ZVm
 qHD//ro97BAS9SRU5YNCi7MDgDu9/0ydJehlB4Oahb44L0aHjT9FP330/I/9lu2MXHvtsaB
 9K2Y50PZaFM57fB1MjCDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v6zN5nHqZvI=;w2vTl94Fb9dj+FV+Lczts64wvK2
 3P/qtnHf66kv75rVrJLkpnsDbDy4+rM+dwtc8S3+q9yn0Znzcd2uKsfT6DvTRU9nfDYRizYXR
 DhEdqYL/BeCiWDmnUpd+uE4Xmz2zkCw7Ky3lyOW+fBXcQDcz+sLNHJyq5c0LNXdvRyvuYkkmM
 f+18Tu52QFVD26ITkI/fN0pKlv38JmuPPiDvFZQaa3Si4wWYRcTV1IRJ7Sb4uox7bcQHZOb3J
 sJ0UqIEOqJDuSMZLDiTVnSIPa4GB7qiCx/Ouf/6dGmcK0gaaYqCCIZod48xx6rL0juJZLpAt9
 EtxDasdoE8rINUWmjJ8g7wHFCOw8qkEHWQxPeyL+HvGPZpiS/uRMBh4uneyauNb/pGjvntUmk
 ArIiv6m5ffd6gJaHrbcOmZhKUmlcPnt9MTmmj0IcD2Twk6XTeP8/81bmGnWUDqJk0tKj/8BgY
 56gt18Uu02UI662vLN0d3lU5ZT0SEuBlSjmYY78Q75eFVJsTieWPWwGVwGJgTt3aBj0Uar77V
 m6orRB3WglfXaOVSKovYX/BuslJcU5Qg/LmVVn2IhyKYOocIAIuWi0gyCzKxVc3MYeHWrMJQt
 7pmoLWNRddfDOCoNJhfFw5ZW7lZ22yE8NWxrSIUwRR2VA87paKre5wmw8h7Z38/uq9m9U/Hq0
 OXDdtnRmY2QPz9jz80yRUEzIxqKj/R1Ogo80K3zd8Db35psnxGjKZ/Do9O+qrxjfcrpnXTSx4
 jR2TZshVhcmNDO12InKP6bv6ac0devVSIFsMQGLbU7SaPkybsn2R/U1PsCZ7Q/5YsmRoe5+/E
 qwYk7w5Y48I2btBYKCrulCPYTU8FTH1gvEjCVaQ43/0/pUDcHKQtDMYTfZjR3sgLKh+ytsIt5
 60FBjwlj+lgjjjQ==

Throughout the module, bytes with the value zero are referred to as
`NUL` bytes. Adapt the only two outliers.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
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


