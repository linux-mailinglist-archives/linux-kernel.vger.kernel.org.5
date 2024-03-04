Return-Path: <linux-kernel+bounces-90587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361648701BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDB0B25C81
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5752F3D0D0;
	Mon,  4 Mar 2024 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="b53s5xwR";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="PMadgrlJ"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ADF1E506
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709556178; cv=none; b=kdSfjKtgSzlmT57ogPGV3JLUJ6aglF2Upiie8WnBVfhWpcDegN9cUki9RmCqnrYjCSqxMCHe64ME5X79Gy7tJZT8eypBu2k7OmuZvrmw+LOFnfwwr46yRjtBCk2cT6QQFAqB4wy9Tk7bzwrNYp/cuTjKP2gIaEnsre0YbEM0N4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709556178; c=relaxed/simple;
	bh=+hujHs+7EBrpHk40I5s72FcX8yh8/hdC95mjaXksO4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mDlRpOjNLQDPg1hQdNfzFTFYa1RZAIRDc1OzbgstY+J03u43wFnGuRVbXXAbMS3jif0CjRJ5wEqrjNFX5uwh/x8+tdOdpa1B64L842kD2h9XMG4m6R+24MlZCO8u55dI8rufa3YkxyTX4vvqlA9k5GI3G9Z9bvZFKW88A0fXoPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=b53s5xwR; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=PMadgrlJ; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 66340C01E; Mon,  4 Mar 2024 13:42:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709556173; bh=8aBOOIIaXB7mSy6KnJSdEoauIVy6vL3YOuH0QNrbJhE=;
	h=From:Date:Subject:To:Cc:From;
	b=b53s5xwRzi9mAoO9lmXv2O1ROzeNnMKvRENzWI8EnWDGg7WKmaIaU60QziEN5IZ53
	 KQSuUwn5iD8eT1mDfRFHAMcpP32hV2D2XG/GL7qWt+/I6WmrTaeshMX8Lh04oYcUiU
	 Ux4vc9WCnlKdVA44VRudqPXYFk7wOrcuvxOJUzTN23ROG4oajzhI/8oKx2qlQ7FF1V
	 7SolzEiy/SXqJSXEBruX4cJ5VQ/lsbLV8mKsreTvI7NBGHdWbnIDkJ9+M5IFQ+qVO/
	 DjQsc11FJQO6CP5pQk6QHArhSXTlhaD0n8Y3teXQMPpoPYN0QAVHBCUEn1Zzx/y+G7
	 sao8DEnDaSXfg==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 3084CC009;
	Mon,  4 Mar 2024 13:42:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709556172; bh=8aBOOIIaXB7mSy6KnJSdEoauIVy6vL3YOuH0QNrbJhE=;
	h=From:Date:Subject:To:Cc:From;
	b=PMadgrlJzbFA9i3Rkuk6St86jcdxLD/FT+AmZSpKpxxjQUBEPm/NbfuclpA0fliTu
	 wxNk5sY/YDBmlEK01V/6E5D8lMCzxNPuoFKuehzKYYR2zRZV2MSC6sLwUsKCcZ0M+V
	 09Y42Eanr7Z/6DK0SLS8AwR+5qksVvw+lV8PcEbkXkD08b+Zl9fP9YGdbwgdxaTuE6
	 si58J+sz1JOOf23NgY9FaL+ay5e/fZZ7G0v/tqKU/9wbyeOAMut7CBTBC3BLA/eTCX
	 TUgprzwG7zcjLgpd6oexiN0QCza4s49PywyEid25JEJXFD6OWaJOzsXYnRK8G11/l6
	 JO0TGSb7c/NxA==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 829f78a6;
	Mon, 4 Mar 2024 12:42:44 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Mon, 04 Mar 2024 21:42:43 +0900
Subject: [PATCH] 9p: cap xattr max size to XATTR_SIZE_MAX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-xattr_maxsize-v1-1-322357ec6bdf@codewreck.org>
X-B4-Tracking: v=1; b=H4sIAMLB5WUC/x2NQQqDMBBFryKzbiBaF9WrFClj/OosTGUmlFDx7
 o1d/MXj83gHGVRg1FcHKT5i8o4F6ltFYeW4wMlUmBrftP7uW5c5JX1tnE2+cJjm7hFqLuuoOCM
 b3Kgcw3pZG1uCXseumCX/Q8/hPH/9+NFFeAAAAA==
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, xingwei lee <xrivendell7@gmail.com>, 
 sam sun <samsun1006219@gmail.com>, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.13-dev-f371f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=+hujHs+7EBrpHk40I5s72FcX8yh8/hdC95mjaXksO4o=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBl5cHE/0ea6TmgtUFEjqGEny8AWhAJGGe2/3mie
 epoJ2OfUUmJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZeXBxAAKCRCrTpvsapjm
 cMk+EAC83BGlUNsxCfQmiZDAaXLZRYLjM4nYuMGfxwetm4guefs4Gk/vgVAfCAeJXDi343uewlZ
 RCcmMQj15kbOLMD48CYs1qt/ITKCKE7a64p3BdXHIe8xxbUCis80n3n0vWtUXO99jHluGDLw8+d
 iM1/4YVEjYJV+HtN1ps69ZWe4wxFRRrRshgToVcyUHn54j20urPm+WHgGHuuXowVyBcEWJWrUhg
 qy+HslsIxsVkRAafuJYHAdGTGlWJLIRhb8FImDJx0l5qZaP6xm/1o5b+Wk4D9d7T9HoSH8glurR
 x9nvy4rxsid8X92hZKZoTjmvuPG5hDnWR0/kF43T6dXiKBFQYbu2ZEc+Gh5pe+XHxVLltBJyd0k
 wGdz6nFPBKwIAavm1zr295LzBL8LB2Y7ulZUAVGAYbpDC6MEJBykMwSd+KLKdKpG5AAsO8cOkKZ
 vx3CcPslRWB7DeK+BF8R3W0j7lXGSiGtInrF2I2zZVATajG0UXZTFPx/7LwYofF6m7mpZJX3EsY
 E8yukU4P2kXFVSGm4c49/J56LeCa2VNuXH+5NT5IZbGYzqRCV5jyEeZR2WO62hckrfFiqU8pbrp
 Z9MTq/Bm2SD5CBm4UovzxxkI2XZpjEfSWifizx+t9dIRS+Eu2a+80z+vXZWcxEB2N0OpfJVy/lC
 6r7AU78GbRA0HTA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

We probably shouldn't ever get an xattr bigger than that, and the current check
of SSIZE_MAX is a bit too large.

Cc: Christian Brauner <brauner@kernel.org>
Cc: xingwei lee <xrivendell7@gmail.com>
Cc: sam sun <samsun1006219@gmail.com
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/9p/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index 8604e3377ee7..97f60b73bf16 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -37,8 +37,8 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
 	if (attr_size > buffer_size) {
 		if (buffer_size)
 			retval = -ERANGE;
-		else if (attr_size > SSIZE_MAX)
-			retval = -EOVERFLOW;
+		else if (attr_size > XATTR_SIZE_MAX)
+			retval = -E2BIG;
 		else /* request to get the attr_size */
 			retval = attr_size;
 	} else {

---
base-commit: be3193e58ec210b2a72fb1134c2a0695088a911d
change-id: 20240304-xattr_maxsize-edf98c1a8c19

Best regards,
-- 
Dominique Martinet | Asmadeus


