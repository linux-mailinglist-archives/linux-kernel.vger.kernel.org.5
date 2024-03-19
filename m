Return-Path: <linux-kernel+bounces-107754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB55880148
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1F71F243FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830BD80020;
	Tue, 19 Mar 2024 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="vsSl7AFO"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1DA65BA1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863921; cv=none; b=fwGOeIKlHq4KIf+ItdT4lT4BNZreNEPAWeGaoHS1zOMlEL8vVIpWHPYtPknywg/83hsEWb0rKah9bZu4SkzrVBOs6e6zQp1GBg3FqCKD8sErQpyyacvQVekw1B/rzvovKOySQ77OjjkKZUR1AagyNi5EarwD71Tb6q9brA7veRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863921; c=relaxed/simple;
	bh=QR8o9Mcgvrzherax7/FJrNBWYgpyY+GvlXzWcNGeXh8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Nws8v541ynl3uQK/3RN+aC0Z/gHGOv4gYjDl81V2wKRrWiZ4IZ//VkWQUIWU1yX/p7lBewYRVnP4Ihn1HEYcuekWHQ8/YP4Dl08quGzw9s3lpE+iHJTyVsESnUt52os5bCgLOcgcNmlOe5IB1WWWf2bjsEOrBFYo5stf7pAIB3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=vsSl7AFO; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1710863905;
	bh=MsTIA1SBG/LU6BZyGBZ5+mArLqd1qw6l69p4VmMQUDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vsSl7AFOQIBhe/6SeK44HaIka7rlnjnPG+9D6i1PYl+Pb7F+XrmSA3xM6C9TdIm15
	 wuJfiFmlpn6aPT0BdmSnj3WLQ3g3wPY460GwdZaLUN45PxGVt/nqR2Qg8OHE10628D
	 unt3H9sEwGQk/r2CZofFK/02mZZcJgCc4bG8AwVA=
Received: from localhost.localdomain ([2409:8a60:2a60:b160:1774:d6f7:f5f5:b6a])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id E8996A1C; Tue, 19 Mar 2024 23:58:09 +0800
X-QQ-mid: xmsmtpt1710863902twgqkc2dz
Message-ID: <tencent_BB02D44B41929365E965CCEB7EE3CF795508@qq.com>
X-QQ-XMAILINFO: NojR6Ao/DkED9z/fky6Dw7j6n8B/YtGJB/CdSLxXUqVVbKY9yiO5UHeC8sv8iG
	 vy9DXTMfldhIiaRlSb8jSI8DPXUp0HFEHGkjzh+/pU8YWrQu9TN7sFdtt/lIPXw70cY93gT88KEY
	 F6lZvc45qHssg4iq/Hy/NGdPAezXC1G3zVsuDl3AYZlY4Fv+SR84DsNu1e99jUAw5SA3WULwfmQ7
	 6GNyJbbaG/3hR1uzNAkM1yn+S+xOqLLS2koGwXogm+inw3lfACIfgU0OE0EXe/5kAnwcWpyLogdH
	 AePgWg2lrKOdI23eltiur3SBg2Qur5DVTyLTaVbU+0KoRUaDKNjoN5ft/haXt1aDPUktkUb4RLZm
	 2PBkRGCjGxPDs7sFj3wbEy15ZRQyXucLv6fz62SmVJjcsOgFmx8jbSQ+3705x4HSYnkwzmIemJFq
	 1TeSvyDscaMloig692HBUb3rNj80OAjrqWFYekMD1a/xZjwBCRSGrJ+JFvZgyCNl+1pohfneV1xU
	 p2ysIIcMO/ckY3ZNLluAk/K4DF0BOABKtjcRLVvi4Y3m0r4BOfvUFbeGDAcwBtXraA7vlFkrvId1
	 t4xcLKNC1i1uC/Z8s5dSw8VbvKFwGBVSO5Ari51awNy48UeWrJbyDiOl2y5CV/bp8o1ClB4Y+Og9
	 u14h/DNQ31mSpI3ijBbmrM0LOT7/W8FfV5xr4n5NizKQFz+ILlnYpLJvKGmcExM3INahBOy93YVv
	 GH7tfxJh/XKdw4XOJqQL6WePdSyVL1N5IdJ45MfLNgJXt/DRE7nr8fblGP9jR07hb8HC0Bprg5Nh
	 ejSpeS0mQ0nF/jIsNcIa98er3PJbDABNObVxyQ4DtqxJkTX/vSkI4TNO3X0lUr2PxJ4gHTS5H98l
	 NPWlviKH4akOXKKgNyP6AQNyzDUVv0sBW2FYPR4tuONcjVMGDHtOhrPXoePvOBj3skgaPMkRYxDs
	 YU5qTu5d3BSmPaBYhBaM+YmDMBPMbNpPcqDyujXd3m8owIFgUdrjRfuWa7RMiugG2yrqb9CmhVIN
	 9HuYqaZDfCEMxxsI22+FCsuOrNOLQImmd3wqW2FAqRiMHtYvkn
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>,
	Wen Yang <wenyang.linux@foxmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 6/9] sysctl: delete these unnecessary static variables i_zero and i_one_hundred
Date: Tue, 19 Mar 2024 23:57:47 +0800
X-OQ-MSGID: <beb7c4bbe6e2aa968e16490850a7d24af2fbcd4a.1710863674.git.wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com>
References: <26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com>
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


