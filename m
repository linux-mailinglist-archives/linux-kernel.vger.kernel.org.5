Return-Path: <linux-kernel+bounces-107755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7230888014A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383F2286806
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A884E7FBAC;
	Tue, 19 Mar 2024 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="HnUJQZ3v"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3827E81746
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863929; cv=none; b=qIDWeMFoCC0AYfhs2Pz6/nsHfAzMNbzpMeJPb3dyUAPjVyiixG2OZUmbCntJZdMG5gy+l6tLBvqOcfmdgXBtD/FHJQZnEKP0ZmyY2o5ql145yaMu7MLxySe1IwyenyPaqUqyZCvSa/Oy9pOZTy67V63HkynrhnoZKTCedkQb5Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863929; c=relaxed/simple;
	bh=4Q8Y0s/DZIIeCtVh1+2DKNHiVdkiYLAYibyrXczYUCg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kEZiprjai0mYKIEx6k8xMWUK6oSg719vz9EexT9pOnZ2lOFCcYWz0Ka6/G5OAx9SLmkPXbZZ5NkuMRBKK8FaAV0EDt+c2hLrWEh8+bgOzLHqu03r68wojGMCGH3ASH8LcM9OVjhd14PDsYdt4PZMazm9YvuXxNyw8TSBqxLw5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=HnUJQZ3v; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1710863907;
	bh=hluYQ3X6fPxKYVqiVUP3UTXquwXzlkOf6HmiAExCtQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HnUJQZ3vJyP/muW1f/wkYaPCDNJO9z6eL6xYC2O2jrKu9NhWFhx20wpWt1J1i7OpH
	 mkQS7Xoi3AEBV8IwEcTC7l438QsRR8tUjGPpQfn3wSsgsHpLEkxwnKYwPBvE6nVywD
	 cwk56X42Cldki7SPN3E9ycMutNWnvo0UkVIGPv6o=
Received: from localhost.localdomain ([2409:8a60:2a60:b160:1774:d6f7:f5f5:b6a])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id E8996A1C; Tue, 19 Mar 2024 23:58:09 +0800
X-QQ-mid: xmsmtpt1710863904thfr8mz17
Message-ID: <tencent_1A550AD427417F937FE921CC6E7E5ACF2808@qq.com>
X-QQ-XMAILINFO: N3l5ASPewLWqIr31YICvIFae0y0evmLaOn06+Q5/VjmEVpnNUADgNuVSq0qX/k
	 b9UpwelqSZFkNx7EXH+0f1U3XkKGyR6qxPwbzzeALQOFuHFo1OJ2u7nhjRPppo0X3LejgDDpwXwx
	 mfktIVncvg841fE0Cduweds8FBIUKZnL7v2SeOq7ySYDSRO5m8b+jHko+wzPb4WYFAwO+w12pQIK
	 +9P6VVL549fbShQlz7jr2T62ErjD2tCObwNwh5dCIRrRMTfbseXqXhoepau7VY0R9nS6Lu2NH23Q
	 Zj0hYo3nDIoVfZ3lRtra+ADhwCPeys1hPjKEhLYSCNA0uoqKeqMtpYheEbk0LKLJ4o5C3Bce8Fuy
	 sPp9sbsOy9qxhObM0AvSNKcI9A+KuLiMxoQuJ5nUdV6m0lPkKe4jS6+k6cAatAtVd0t1x2zWWCau
	 sg2PzvAu+XklCSDP82Gze6hZtcix/Cl1l2O+gHvs2utxgSpbrlj5dEE30i76xhnaDMv9kpFoniQn
	 OHWZjkwC0ZEUamyRVjXvFwOhZhKxZv4RQ6USFSnEXM9v8U/O39AL1eFJYrUUU+/Y2KcAptNT5WCK
	 fNlk5vhyEiAshfW1E+eJcfR13Tft63BXMTXfXr7CJP+ejdODkYQHP1+RVUriJp2qDaCxTRo/lwtN
	 nFYHJ+D3YQ/7YbOiGdiDi3hX8QofRJLAbxCpw4C1J8XrgFTyPScvH8mjhyWx4qtr8NFjwFyYFFhw
	 QFxYQU32UKAN1+PaAQdV64z/DgMQQdHiWaVh7sTim4HfotKX52B5DmaPSwHYrUfzUMZcO+w0og5Y
	 gyb1zoFhW1Q0lFGru4ZlgHlv74xj3kAOzsUGtXC/xfXTYFCX+rI4vecqwxMvtQucwLQVE0+U+ZEK
	 19GOv3gP6LG4WGV40G2D49eqqFJs23G9By23WPJDgcMZrgvrdDL3lMThxRg1rjWVIwozOPfdghWL
	 swqFX/fHUaVHk74uNY3yu73wesGpVLyvBFAIQgY+oiODcHcDR2ZXT5yz9YMOmTTv/yxRJmKoMAF0
	 qB9oA4OguiizgQ6lcIrNSeCcozAoizgT8cInkooWmxzigbPlldLfrYTfg99X18CGOO0Ab6G3H8YD
	 BNApE+5Jpkog2Tf3vUxVEOpk8FOA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>,
	Wen Yang <wenyang.linux@foxmail.com>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 7/9] epoll: delete these unnecessary static variables long_zero and long_max
Date: Tue, 19 Mar 2024 23:57:48 +0800
X-OQ-MSGID: <d1cac3c5b1756b82cccd6bcff2043626e2350b1c.1710863674.git.wenyang.linux@foxmail.com>
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

Delete unnecessary static variables (long_zero and long_max)
and encode them directly in the table entry.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3534d36a1474..7cfc4fb0ca3c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -309,19 +309,14 @@ static void unlist_file(struct epitems_head *head)
 
 #include <linux/sysctl.h>
 
-static long long_zero;
-static long long_max = LONG_MAX;
-
 static struct ctl_table epoll_table[] = {
-	{
-		.procname	= "max_user_watches",
-		.data		= &max_user_watches,
-		.maxlen		= sizeof(max_user_watches),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &long_zero,
-		.extra2		= &long_max,
-	},
+	CTL_TABLE_ENTRY_MINMAX("max_user_watches",
+				&max_user_watches,
+				sizeof(max_user_watches),
+				0644,
+				proc_doulongvec_minmax,
+				SYSCTL_NUMERIC_ZERO,
+				SYSCTL_NUMERIC_LONG_MAX),
 };
 
 static void __init epoll_sysctls_init(void)
-- 
2.25.1


