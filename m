Return-Path: <linux-kernel+bounces-97850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 311B0877076
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6164E1C20CB0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2889E364DC;
	Sat,  9 Mar 2024 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ggmmh192"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4B364D2
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709980351; cv=none; b=f22f3lZn8I3ntOoHoEkNWSxZ08LJW1YROY9JmkFW3N2475sS7IXWUTQckLaHv2dwuGPcbhqwQU8SA1uZTyTt49NQJ5sMlqGZs8xnahKgyKYqM8sXnpJdx4D0+QOu0svXlOJWlA2UDdL/ud19KHx+bJzb/0wG1t4D37su1Ad4xz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709980351; c=relaxed/simple;
	bh=QR8o9Mcgvrzherax7/FJrNBWYgpyY+GvlXzWcNGeXh8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=t4jMHqSR/e8mtnlLygKMD1FMeSIGmeASsrhYiQGwP6Q8J2jpKzYPyVE/94Waf4PhUPLaVIU3d67gJfeHj2iJFwi0t7PDgBRp/kngHJqB6i82TdT7xIxga/5u5DMzxCks7WWIM9/ZQRayRbUdKVEcVy2Uw8DUz80cx8OVpdkYDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ggmmh192; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709980332;
	bh=MsTIA1SBG/LU6BZyGBZ5+mArLqd1qw6l69p4VmMQUDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ggmmh192r35eDTqOMtw4xoQ3Cj6wRstFIi9ANaI4MKaVFqkEwaqdXpU+0wzB6gHlc
	 3z/kln79oGYIIGg/Nf1vNQTOqhgl21T7ZBq6bKvKYrpC2icGeR1h941cFobUktQjMp
	 /IQfL5fALUVWuYgVcjihQaJqnIxGFVQkEk0rsh00=
Received: from localhost.localdomain ([2409:8961:2a0b:4ad8:c972:9bc3:984f:98a9])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 7EF8DC9A; Sat, 09 Mar 2024 18:31:47 +0800
X-QQ-mid: xmsmtpt1709980328tgnbh093x
Message-ID: <tencent_397E9514756A90C62460BA00F3801FF9F306@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uJulMZ083zhfPdJS1+llPuecrFAJnWrGhtr6Hl86UVITqWN33zn
	 DDtNL4r7PI2c3bcOP31XATKjo2HADax8ahG25Fe+oEw963Mve5F8VOzshDzFa64IqUNA0jt+mlpe
	 wCWZXZ9xb2YAHk4PBqvczwg1ccSlcDaVpuKPSYe8PW7JkGwMdClTWelXRGswTl8rpxK5ojc0l0k1
	 bEemxs9OnXnnXvqMDFjj+4/J6I2sC8T5Hsr6hrI5fg7aDShjaeLVPwZi30jkHRCpSe18Ol+ArBL4
	 4TRfY3HJPzDNS0Gkv1KjdtibQnzWT/VxGVvt3TbDxHFr/BtUcuVFC6yzzKNpuapknRbGVIIxPlbq
	 KPl6tbQlqO9ILQkNSGSz54kTTRVxsYCx/2C/fxTIqJzIKD8SGnRFM/6hw5IdMfaM4ZB2vJc20dcv
	 nRhpWAh32v4u/jls0SODZWegSizH7tCEUFTHIoMWeC/kdeIxGcnOs4jwHm5BcR34qwDqDsks937V
	 L4UGnguQ/zR9qCXgr9ivpuk9lMXLnG6Mc0VhCRyQ1/BB3iIBIrh1Yotxc8f2ody/BLh+JrpB9jOw
	 CEa4P+QzkBngo9csPUzwXNmCjQ5+zIobepKoGs6QDLpFKjRZu3T4+TBFfg4OtUgG2g/5zap+5GOl
	 mE9bEV1y2Sg7SQNXBUwgr+byxjzWH4LbcmV5US/1CtPxucVloWlJFQyiFGzn0HYlxeI24omlxKpM
	 i2KovRFHR5v/5mc4kpHmyogTqAN7rhRAG1gtBmHBdEXD+nbzV4KKEzJ9tg9L7ikDM+0nt1PRwBuh
	 1+8aqECRwbJoNdzgVlvBX0kUUOJ/twBHkx6XssSmGD46Hfft+Oo9wg51Rd+RW286zN0aTGfs93cg
	 iLhVCW2oz1Dm+AGwsMen/h0VnctO1EEYXWjsLyuTstI/wtq37dteWQHp2Mai7R0beIKelQmQtUkC
	 qyCuh/HToHCEkKiUGWQx7RgcCgBWF3lQ6KaN4ACjBDZ6jOmTeMTSoqTr+/9V572halu29cuclCWC
	 5CSZ3JlhjsP2xpRUYKBhvFdcFUeVNWtt/MdVqpfqw8C9RuMPnMSryi8hAVU4nBUwGBNmq7xDswPS
	 xwyJyjf8X2If32nqSC9RgtptzJxQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] sysctl: delete these unnecessary static variables i_zero and i_one_hundred
Date: Sat,  9 Mar 2024 18:31:23 +0800
X-OQ-MSGID: <785ff7de640d74184ed74908b832f5abcc11964c.1709978655.git.wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1709978655.git.wenyang.linux@foxmail.com>
References: <cover.1709978655.git.wenyang.linux@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

Delete unnecessary static variables (i_zero and i_one_hundred)
and encode them directly in the table entry.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 lib/test_sysctl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 9321d850931f..cf298f25d686 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -26,8 +26,6 @@
 #include <linux/delay.h>
 #include <linux/vmalloc.h>
 
-static int i_zero;
-static int i_one_hundred = 100;
 static int match_int_ok = 1;
 
 
@@ -78,8 +76,9 @@ static struct ctl_table test_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &i_zero,
-		.extra2         = &i_one_hundred,
+		.min		= SYSCTL_NUMERIC_ZERO,
+		.max		= SYSCTL_NUMERIC_ONE_HUNDRED,
+		.extra_flags	= SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX,
 	},
 	{
 		.procname	= "int_0002",
@@ -108,8 +107,9 @@ static struct ctl_table test_table[] = {
 		.maxlen		= sizeof(test_data.boot_int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
+		.min		= SYSCTL_NUMERIC_ZERO,
+		.max		= SYSCTL_NUMERIC_ONE,
+		.extra_flags	= SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX,
 	},
 	{
 		.procname	= "uint_0001",
-- 
2.25.1


