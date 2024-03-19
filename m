Return-Path: <linux-kernel+bounces-107757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAE488014C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801291F245A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4697823B8;
	Tue, 19 Mar 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="fG3zPby4"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D186981751
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863938; cv=none; b=MSJv0hNcZqlansqDLvJNNy5oFBny2T4pd+JK74YXf7+9WkZIXRylq6107/pkn2SLqkqty7IgxhgYlQYUsFh3Ivj9dNAEW+9SmcEblUe6wxWcyapWKWMunORD9Bisf8U/ou5ulFaPfjmbmXXkAFDNy8oDb58v03+csoSWHdcvjSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863938; c=relaxed/simple;
	bh=7UKzrWG8Ihaae65NIIDTFYHHZUF/qzUeTBE7PxmmGmE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uVQR1mmSQgY3Fd+9sI2jlcB0A0eUfD1yZftXKnxkZXhjxEN0fgoPjcYE3nDgpjnzrGhaReJmGOvzzOgswd76XU9WsOHZQUEeOIguXOAMZZlrMqgPianu/INuVJHNl2lveezSQSxmBjAfaroQOICGu6PFweg7/zg187eZtuSkGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=fG3zPby4; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1710863932;
	bh=Ouz5Tp2AWgO33XyZ8LV/WRAebZU4cotdGkPEacGY5bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fG3zPby40Dx0eIfOFhoP2fVP8yZ3LnHmqKwqWfZo/ko96ZYh9m0c+qs/ecj8GD9Dk
	 0bmhdpOMfVA0jwgwo0RPslZ0UcJEzQp3qGX+nystCSIsCiH5DPXyW1HZs8XECgtzK/
	 l2AdhuhUEteVBsComjWzypr8WAxffh4KIjqD4GyI=
Received: from localhost.localdomain ([2409:8a60:2a60:b160:1774:d6f7:f5f5:b6a])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id E8996A1C; Tue, 19 Mar 2024 23:58:09 +0800
X-QQ-mid: xmsmtpt1710863909tff4xyr5i
Message-ID: <tencent_1FBC930BE9F1CC5E7E0BCF7955BFD4E54108@qq.com>
X-QQ-XMAILINFO: M4JyzWMRFsOyhWPvwEsMdXIpXG1TLEWG5CFL3qGzs/CMyvJHlUojFWcCHhN04k
	 S32NgkTKBdzuuuTE/4uHeTkPEt2ITOLJqee3udNpI5WGbV3mPZF0RxAnTkM3uA2pAFjQmUl1YgMD
	 X43WThIpc8vgJbJqpekBLYTH7CBQkaPYQscTjF7pw+MT32C5nF33s+z88svO4YbAPTQGIapRzhVq
	 KUyMcSJPoHPdiq8uQsMxSc0dDc8wMouy5X37h5FgNcAUZsMSjo/IOLBZAC2p8CU8QjoQtX+tTMss
	 0+S1FBW8vjsGuilg9G6fn2v/av/oIb5VsjfSRHfcJ2hjLCgzsTCGo6AJk3geHw8kFnTpK03Cvzx5
	 97bjjB6fCL20Bd5ohOF+yvJ7b28Ji5epFOQIV1j1cDN0KdHCTFxfn/KpLhFPArKETmtfQQMx7JFz
	 xtuYKmUR7OIepRoIaTgBcH3gocRoXedXPlUfTA74tijq7vZsJNhyuk3ZzjA7WP9cmlbT4AVbDtFd
	 MFKYn6fS+Xz/89bsRQTs1w5OWJGYIFRR51P3Ft57w3VYvIWw7eOilbvXfTYUkML7EU39qSYa/m5E
	 sop5y/4eeF2wjw3W/rhhyLV39KQbhvxfkcdWtOtKZfKgj60v8FzdGU7uqxT6LwCmP0SO1ClcqDbn
	 KinvEc+oXvL+7w/A3CscCObbvbcy5/+sJbZspONzEBunyk5mLXeYYJvXl5Wt6egcCpFAJ0XV17iA
	 WwxEr0IqUba+FYUnNdhBKXt/zqxJmnk6kPNTDFWlACbEYPqMhXHu241EXb6YVeYEwaAYWKXqXKY/
	 +Ks723h6Oxfzx4bYqeiwmMAsBoCwV6F6BzpLkUMX8Uodch6/IvMYCY4ls3niOhxu9fN97uH+fvk0
	 cpAy9EYmu/Ll8QseUhJkhMyTppOTY0xOFwOcD5RSwfq1mMh4mEBRtSgXaj7NsUqTYM1MbH+a/onx
	 d9n0TLL4FBfXdnBhHwqkpovn6PaLkMy5zBgNiGumJpjVh5m8p5oAb+W6Iy0pjGD+CIMilj9DRukG
	 PS1HF48S5Vnk/mhkrgTKLPhTbBG+4KNR05F2lz0FcX1rNO8AnoFNH97Y6rn+zCcyLVuI3DXKxGT2
	 HvCwhRKtGbkoV50FU=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>,
	Wen Yang <wenyang.linux@foxmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 9/9] ucounts: delete these unnecessary static variables ue_zero and ue_int_max
Date: Tue, 19 Mar 2024 23:57:50 +0800
X-OQ-MSGID: <8dde20421374b7da2d449896b5612b3a6fa72920.1710863674.git.wenyang.linux@foxmail.com>
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

Delete unnecessary static variables (ue_zero and ue_int_max)
and encode them directly in the table entry.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/ucount.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 4aa6166cb856..f1c7a160f361 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -58,17 +58,15 @@ static struct ctl_table_root set_root = {
 	.permissions = set_permissions,
 };
 
-static long ue_zero = 0;
-static long ue_int_max = INT_MAX;
-
 #define UCOUNT_ENTRY(name)					\
 	{							\
 		.procname	= name,				\
 		.maxlen		= sizeof(long),			\
 		.mode		= 0644,				\
 		.proc_handler	= proc_doulongvec_minmax,	\
-		.extra1		= &ue_zero,			\
-		.extra2		= &ue_int_max,			\
+		.min		= SYSCTL_NUMERIC_ZERO,		\
+		.max		= SYSCTL_NUMERIC_INT_MAX,	\
+		.extra_flags	= SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX \
 	}
 static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_user_namespaces"),
-- 
2.25.1


