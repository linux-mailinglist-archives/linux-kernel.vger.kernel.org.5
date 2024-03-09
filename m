Return-Path: <linux-kernel+bounces-97852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D280F877078
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642F0282242
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6B038FA6;
	Sat,  9 Mar 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="EZNVLxyi"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D581383A3
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709980365; cv=none; b=t3ujrCchhjDJiV4Cm1JlNMTo1DH6Esg34YNeVtE82I/c6c+G2a00d4xcRSxSGXeb0jR348ihQCvfv05mNIwoHjnY04VCMg71BRASZTw53tIVdK9FDLMWFCAoLFpTDg4HFCQdSNQG0ftThukiPRONpO1pH1drWzRv1FLuxJwBK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709980365; c=relaxed/simple;
	bh=DwJjdzLWTdy7zHQSUizyTlpqFQDQGh0V02APNGDv+k4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Xe5nuehKpLvsSAQ/SON4oVYTe+r9018fIiBQlolZFDEkzuYO8/Pg1piTHisnSnnJ+XMr4GrdeGrpumAfBppjRAWxvDgTc+sl+nuIpRQNuPRTMkXSV0Zz17d2EWIk9lLlsGQXfVEt6B9CTsJlI7p2oMmxnjE99xJJJcV6xygwe7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=EZNVLxyi; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709980361;
	bh=SV0D+oK1MX6meAdGdKYTlAQjz3oU6hTNix963jYalS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EZNVLxyiSpcGQHjxsadY0v93IBOjUlMJLCvys7vTLY8ax0Q7kSQu1OpdQaJ4Q+9pN
	 gD6b1BkmL97ULuAGidULGlHtAYKGlJVADPBAp6A5yvGZdT8EG/c3AEZAof03ITkILI
	 7thf/CWPUT+rjCqXTY+g2+LBAdnXI34zCON7tz+8=
Received: from localhost.localdomain ([2409:8961:2a0b:4ad8:c972:9bc3:984f:98a9])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 7EF8DC9A; Sat, 09 Mar 2024 18:31:47 +0800
X-QQ-mid: xmsmtpt1709980337tsi0ibzpo
Message-ID: <tencent_45CCE47EB1CFC75550D4E541199388E96D08@qq.com>
X-QQ-XMAILINFO: NYWR1JZzYCQ4xv4uZjKN0JLdmSyQedCCtV75m7IwjVFZHKvk3wxoPzFnNT93se
	 cQG9cPNP+CR0Hui9RCMWhr3hfaiQKEGLgO2h+Zz9DSz/Vrp4r0r418S2SpskcGsyG2/BTDDaddKv
	 e0bXMvB4GiAbpEF+emF9mrko/mOIrAnNVzPErkvNqCb9rnsEr9sgf4LskiUYlpnm+9NDxet/UXYs
	 H+WhD3M+B+/l/jjMmV43LqQTz/kMLtqICRlM/7/r4p9HnE1KmX8LpwgnYg0RVBYMlKmEaTIQQlhh
	 AYKuKxbY9qicr9V2eU08bOcjdPOFfjtbIkazUMZWAWVBre9DlG5PHpyBCfbjifxo78fRug3ySe2E
	 kamS/0JMqj0lOY64ZIyS6Abhmllg8Q/mdPGWh6I3BPpg73/MbNzt1XM2nhQG/s3tQQ/E/PMUJfJS
	 Oawr+T80C6vpukgxDRDHLJ6TuN0zhuXyy56RosXRC4VdCKvGRV1+kq+fYniFAh3H01VpkX3DoOoy
	 iBkuICoJqVgZm4jCYkGLsop75fwg1YxcdUtEecslbM9knYmGN8VqEzoPipqONm1NyRS9cEuCzKte
	 DWhdojbOB7u20kwacMPkSriygOyVhYrh6XXDELOtR2uGz2ggwo8jEkam3lT3L/KtrVfxDr1XHfKu
	 HBDiCtve9i6Bd2bWyZvJEgOhCnVhoPd+h7p8UxI1a287+HYu9P8pkp1QW+QGxfhd1wlgMIkub/3b
	 8qcMO0mzCEHE328TZkGwKGkfxk+D6YjiogfwAWoT23THTcws5LPWqxYisgHxVfGGbmC3jj0cghek
	 63weIPV52Abwb+cUkk0v8/Arkp8Mj3s8TqlkgtHlVSKKkZ+/Ihhd1FggkAFStZUGBz1O1XMwv5Ks
	 56r/UmRqlu6ZtmgbkjVCrMlQPcIzoRuoS0z1YCrkLGgdRrnXb7fesY7BPYq/K7hnQTztLWfGVaMo
	 k2s6Prkaz++sLepqKg4mOnZ8vsd63sAzPF84rzvQIfaK4xDn6S6eIdEF2fYCj2dk/HPGdripKMK9
	 wNrYiTqOiPvpnVnBFPrZ823srLa5C+3jtpRC41Z+mr8xnJyP4h/oOxSGyOkR3iYD4td5fm4w==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] ucounts: delete these unnecessary static variables ue_zero and ue_int_max
Date: Sat,  9 Mar 2024 18:31:26 +0800
X-OQ-MSGID: <6a8977d8eded041a822d7255ddb90e7b2863d549.1709978655.git.wenyang.linux@foxmail.com>
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
index e188c25ed2b3..53d96cb27309 100644
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


