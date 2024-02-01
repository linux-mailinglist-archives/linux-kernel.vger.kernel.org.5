Return-Path: <linux-kernel+bounces-47426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01484844DC5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02304B23076
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809CE7F4;
	Thu,  1 Feb 2024 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zgredder.pl header.i=@zgredder.pl header.b="mlUTHJCp"
Received: from mail1.hosting.lp.pl (mail1.hosting.lp.pl [194.1.144.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF050374
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.1.144.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746989; cv=none; b=U63oflzy3JiNORdvLL9NTTGjywmh5/96tTqFN6cOH8JOnHGao6+uQzSFaPlOeHYhcvlMBDWE5coKWRJbOFfsS+n/jVG6GGJAM0PvX7uSeYg8c+z8Wnq5VAjfFOoZpriSeJjbKvg9xIGqHLtCn41GtayqigXaXJKEg9I6D8OEK0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746989; c=relaxed/simple;
	bh=8EQCJ0zRWIJAH4B7S7rBKKBSElX4FaQmCDWO7VGXYbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z6CoCDYqIe+bIgTG0atz6L746wXSzT6JR2bkQeC2/Cv1p6iI2ojEKcAcDF8t6B4NW5DpqrxKw2zQC251rz4swuFtEIWPI4+fMPeq6DJBkQocRj9yFKF2Q4D3s4KCBEgauGu6u0tXg0F1tWINqq/gANyVMnJ6b9w5qGyWoU8DHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zgredder.pl; spf=pass smtp.mailfrom=zgredder.pl; dkim=pass (2048-bit key) header.d=zgredder.pl header.i=@zgredder.pl header.b=mlUTHJCp; arc=none smtp.client-ip=194.1.144.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zgredder.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zgredder.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail1.hosting.lp.pl (Postfix) with ESMTP id EA55C88B69;
	Thu,  1 Feb 2024 01:15:12 +0100 (CET)
Authentication-Results: mail1.hosting.lp.pl (amavisd-new);
	dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
	header.d=zgredder.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zgredder.pl; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from; s=default; t=1706746511; x=
	1708560912; bh=8EQCJ0zRWIJAH4B7S7rBKKBSElX4FaQmCDWO7VGXYbY=; b=m
	lUTHJCpwmkpihcMCOMRM5IQmeGl0jDsHesvRAiesKDRIC9pH4HTv5mgDS2e/fYnj
	pM2tVoCHwtCZtzR84W47Qi4I4+rCNMJKUgp+IKaefSWi0upzZSilmUCYwlmyLjKI
	5jtA7eDZHY4KFgPxay+twisDkOwOfvq2LN7UG08ckGjzn/WFljNLT8wKFibfOhQA
	LercHP6fDtfP3+qHaEB7D/4GQe+F71sbXZHj9iCXm2bU2jxu8z4sclbvC+aOXEKe
	t2Xq2FZaT6HD7IG5rU6R7UBQ4vgEk1DKZ50kP6Y4PRQKIEMk9ulDfj+e14ps4Ibn
	c8RdGfMSXGsseyTq3FCaQ==
X-Virus-Scanned: Debian amavisd-new at mail1.hosting.lp.pl
Received: from mail1.hosting.lp.pl ([127.0.0.1])
	by localhost (mail1.hosting.lp.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FBzgoY_-3Q_q; Thu,  1 Feb 2024 01:15:11 +0100 (CET)
Received: from localhost.localdomain (31-178-92-228.dynamic.chello.pl [31.178.92.228])
	(Authenticated sender: zgredder@zgredder.pl)
	by smtp.lmail.pl (Postfix) with ESMTPSA id B693788A5C;
	Thu,  1 Feb 2024 01:15:11 +0100 (CET)
From: Bartosz Szreder <zgredder@zgredder.pl>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	colin.i.king@gmail.com,
	linux-kernel@vger.kernel.org
Cc: Bartosz Szreder <zgredder@zgredder.pl>
Subject: [PATCH] x86/lib: Avoid undefined behavior on sign flip
Date: Thu,  1 Feb 2024 01:10:33 +0100
Message-ID: <20240201001033.9483-1-zgredder@zgredder.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If argument to function num_digits() is equal to INT_MIN, the sign change
operation results in undefined behavior due to signed integer overflow.

Avoid that issue by converting to unsigned type.

Signed-off-by: Bartosz Szreder <zgredder@zgredder.pl>
---
 arch/x86/lib/misc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/misc.c b/arch/x86/lib/misc.c
index 40b81c338ae5..778ab6d27372 100644
--- a/arch/x86/lib/misc.c
+++ b/arch/x86/lib/misc.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/misc.h>
+#include <linux/limits.h>
=20
 /*
  * Count the digits of @val including a possible sign.
@@ -9,14 +10,17 @@
 int num_digits(int val)
 {
 	long long m =3D 10;
+	unsigned int tmp =3D val;
 	int d =3D 1;
=20
 	if (val < 0) {
 		d++;
-		val =3D -val;
+
+		if (val !=3D INT_MIN)
+			tmp =3D -val;
 	}
=20
-	while (val >=3D m) {
+	while (tmp >=3D m) {
 		m *=3D 10;
 		d++;
 	}
--=20
2.43.0


