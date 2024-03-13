Return-Path: <linux-kernel+bounces-101317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E69087A57A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FD5282D44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DFF38DCC;
	Wed, 13 Mar 2024 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2QzWLmD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B7125CF;
	Wed, 13 Mar 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324260; cv=none; b=i4SWM8C6EcxDFfFgdWHG394DiRC7zEXoL5mShv2JJPDCCrgyq1S0xNcNG6Z418WkMVGatOXR72SDtUV2lMGuPFMkFjjgkDhJkdCzGxtxI/+rk/rMsHVR2bwkvOKyaXGiGnHcAQv0Dy0MwO0jdVvcSWknc4umQQOFa0hcuVCpgQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324260; c=relaxed/simple;
	bh=s2Xi/Ss3yhJ3DH+e0boShl6sVUgNgQ6/KO0wp7CwR+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HYf1nD7XuhcLqr96/VKu7ZawAyoEwLf/yur/JNGGtCUmAg6MBSiGl3nh0Xdqc6jgBAM3At3A8M7wNhwj5XEYDVPsLSgLc+YDQt+S4ppZ9ocGJNBhyhnZTs3I6jYycN0zwnlLhqmfI2LdqKtksabz/HyeGjWMSpDsCYcCgRJw5eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2QzWLmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1529FC433F1;
	Wed, 13 Mar 2024 10:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710324259;
	bh=s2Xi/Ss3yhJ3DH+e0boShl6sVUgNgQ6/KO0wp7CwR+U=;
	h=From:To:Cc:Subject:Date:From;
	b=Q2QzWLmDqq+tuKW5dGk50mrqXuXJT+m+HkBoOKyDQF5XMzyDqHCUNlZZRD/hEX479
	 4raJgiCuiPjLBKiCLtjydYzEqT+2+GK32Qqj7WSUit3gubZk5EcqChleZ4/02Fbha6
	 uuqiXmXhgvm0U+BdCmSsHa5mYosUZYkWR5RXBMyWuSBGAjEOwkSpLThr99uDnv80t2
	 5v3N5evK3cr8YYtFs6z8eoZ6luraXyCF/aaZG5ET2cU3TcM8DcmB/fnFLCNoE2m1Vt
	 YJ4hm+JPp154B7LawBomQ4VyVTjw25n8+49XDZMsXEABSazzCBjeZGx/JJ8R79n36V
	 7tKLYD8De2B5g==
From: Arnd Bergmann <arnd@kernel.org>
To: William Hubbs <w.d.hubbs@gmail.com>,
	Chris Brannon <chris@the-brannons.com>,
	Kirk Reiser <kirk@reisers.ca>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] speakup: devsynth: remove c23 label
Date: Wed, 13 Mar 2024 11:04:03 +0100
Message-Id: <20240313100413.875280-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-16 and higher warn about a c23 C extension that is also a GNU extension:

drivers/accessibility/speakup/devsynth.c:111:3: error: label at end of compound statement is a C23 extension [-Werror,-Wc23-extensions]

clang-15 just produces an error here:

drivers/accessibility/speakup/devsynth.c:111:3: error: expected statement

This is apparently the only such warning in the kernel tree at the moment,
so just convert it into standard C code using the equivalent 'continue'
keyword.

Fixes: 807977260ae4 ("speakup: Add /dev/synthu device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/accessibility/speakup/devsynth.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/accessibility/speakup/devsynth.c b/drivers/accessibility/speakup/devsynth.c
index da4d0f6aa5bf..76b5e942dc1b 100644
--- a/drivers/accessibility/speakup/devsynth.c
+++ b/drivers/accessibility/speakup/devsynth.c
@@ -68,7 +68,7 @@ static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
 			case 7: /* 0xfe */
 			case 1: /* 0x80 */
 				/* Invalid, drop */
-				goto drop;
+				continue;
 
 			case 0:
 				/* ASCII, copy */
@@ -96,7 +96,7 @@ static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
 					if ((c & 0xc0) != 0x80)	{
 						/* Invalid, drop the head */
 						want = 1;
-						goto drop;
+						continue;
 					}
 					value = (value << 6) | (c & 0x3f);
 					in++;
@@ -107,7 +107,6 @@ static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
 				want = 1;
 				break;
 			}
-drop:
 		}
 
 		count -= bytes;
-- 
2.39.2


