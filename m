Return-Path: <linux-kernel+bounces-107756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EAC88014B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9AAA28681F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCC2823A6;
	Tue, 19 Mar 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="H42Oog3J"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E781751
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863932; cv=none; b=TMKShGYQ6+N2UjocKi8/4q5gSJSqV6wrKnrd5TNYBSAx57pFqRuWkF3jlYCBPwYkjD5d/VO+gtJG5dGgEDrL6zdWq/uoC24OnYu9tbUVZ5aJgUaoCABag9ZjIEiQquOroB+fLMLnYGK0zHgk3ekl3yQOR57BC7/BgDgM4q28gHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863932; c=relaxed/simple;
	bh=NJKqmOHNR07G45d4NVjLLw9EdzmYl7F7Ce1i+WlWE7s=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Fz2lDevgSUkgBnNnX/F+N9BqKYbIakTIPJXTU4TaZgwquDlksbdwHr0UXLcy+cC3Z32P9Z3LoaQfH1+woa9n/VGOr56FSLyjv/WkP2gU06kQOj/skeRJyTf75yTdGorONPxjwL+HRGpN+dJGFlT1oG8MR/P90mhrPDYdbQyblqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=H42Oog3J; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1710863910;
	bh=SSRgMEacKlRgTzt0buSQ6sVgqkbUDUraShL6rUZA97w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H42Oog3JZmOUyYo2WXUBTd/BJuVV61TmmkX8p2AmX3p7OH1llUVnfFdJR+3quTg3J
	 mGpj89hHnImApMBMWFSgUSp0jeP/nV/E2unD4EAa+fZol9v7uQdzabcbGDUQs1T43A
	 5zaWM5ROGqRX2pR4DMPCJPY1kHjFtO3dC+dUn4hg=
Received: from localhost.localdomain ([2409:8a60:2a60:b160:1774:d6f7:f5f5:b6a])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id E8996A1C; Tue, 19 Mar 2024 23:58:09 +0800
X-QQ-mid: xmsmtpt1710863907tkw3j3e32
Message-ID: <tencent_3066A7AB308FF9F53E3B5639514306914D0A@qq.com>
X-QQ-XMAILINFO: N4r4IakIsd1kT79Um3d7vf7jax0oEV0tm7D+7SWORBgZarpWSs1xKpq8xqUxID
	 QilmcOQNQBVY/A4GbqBajlE4fEwG0F+dK448aQWSuq4LENMtXO24FMdzu6s8US10ayWJKoB4f2RS
	 acZpD3ndYE9zZ/GEjrHSVB1p5YPMEqs1rICAQ3B0MIxXUCOoYW3/ilkrH+5ZThPKR6k7h01wkBvP
	 xZfd9nBIvxHkcrmJpj9EVRkTq3TeeHFjdNfSYsNV9EMs9RKCAOGUToJmYCroG1KKM7QnwxwcpngI
	 17+RG9Pbc2lR1Ue1Aj0u+MG4YzsLdm5/IwkXTUvrJcKWnQ/nl1Ab0nWvoFjhn2W1wMYuIrag2VLX
	 Rb2/Ua+KqUfyeB6+nz6wdRs8iXobZUFIfRF2PVAZi2K2247HJLXJvif6Us0j/2KC3s9AdJKHNNsE
	 wv51ALQ5XBvh8wf9JSf5ruNBsBsUEDAKEXfe8WdXSrSjB5a6y95EEV6+cryW5qIpPjCHsj+wEn2Y
	 bUqUwyAQNNmaYzRM2Tg4+p9yZLRyv/A2pP1QFt8sAYuD214VQ0OKdpZi7cCGX+tqMm++XkUTthnN
	 FJDnDl47g920geZNORXomKCPzkyfbeVWK/bCI3LBvmlBQlRr31aeLwYCioJCOIaBLoze8ZF2rGH2
	 U8ViUdG99nKESdy8bdpqGiOQe62HUX1fCyqgiArb6nllnPIXcVfeJ1w4B+EKfR08l43/FIQHnSEF
	 7ygvsY/IRELuGWzMbQ9LmcXMAiBlL9pK46pALXCOT3/TrQrOQDWWx5rh1jjrW2O/NX5eAx3rOVOI
	 jLXhIv925nHhcJA4Z1pDmqEIOfeSfOAjxoBwlM15S7aLeJmmhpyBps50uAKrlPV4W/rDzZVQcBl9
	 WEwUmtEkFAE68eGn8RCeqC0mc5MF26TsSxk7iLj6KNhBq+QidA/5ElyK1t1UIWjzqXoNJOfqpMvu
	 VqCdBmmK8qp8KochYL0f5HgArenVzPAA2cegdbMyGpI8TlIb7hx3zhQRZ0rznpgKLCoYaqfdRA2u
	 KPCgu4cEStin74PpIhtJZQkx+bPPLpphj9s9KbL7ASkYot7+8IXJHSENwux21PJTH5AcHsKLHaWE
	 8KC5To5XJQbVr61GE=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
Subject: [RESEND PATCH v2 8/9] fs: inotify: delete these unnecessary static variables it_zero and it_int_max
Date: Tue, 19 Mar 2024 23:57:49 +0800
X-OQ-MSGID: <5d22ef6abad560669516fcb0bba943455499ce58.1710863674.git.wenyang.linux@foxmail.com>
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

Delete unnecessary static variables (it_zero and it_int_max)
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
 fs/notify/inotify/inotify_user.c | 49 +++++++++++++-------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 85d8fdd55329..b346d61179ea 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -55,36 +55,27 @@ struct kmem_cache *inotify_inode_mark_cachep __ro_after_init;
 
 #include <linux/sysctl.h>
 
-static long it_zero = 0;
-static long it_int_max = INT_MAX;
-
 static struct ctl_table inotify_table[] = {
-	{
-		.procname	= "max_user_instances",
-		.data		= &init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES],
-		.maxlen		= sizeof(long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &it_zero,
-		.extra2		= &it_int_max,
-	},
-	{
-		.procname	= "max_user_watches",
-		.data		= &init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES],
-		.maxlen		= sizeof(long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &it_zero,
-		.extra2		= &it_int_max,
-	},
-	{
-		.procname	= "max_queued_events",
-		.data		= &inotify_max_queued_events,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO
-	},
+	CTL_TABLE_ENTRY_MINMAX("max_user_instances",
+			       &init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES],
+			       sizeof(long),
+			       0644,
+			       proc_doulongvec_minmax,
+			       SYSCTL_NUMERIC_ZERO,
+			       SYSCTL_NUMERIC_INT_MAX),
+	CTL_TABLE_ENTRY_MINMAX("max_user_watches",
+			       &init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES],
+			       sizeof(long),
+			       0644,
+			       proc_doulongvec_minmax,
+			       SYSCTL_NUMERIC_ZERO,
+			       SYSCTL_NUMERIC_INT_MAX),
+	CTL_TABLE_ENTRY_MIN("max_queued_events",
+			    &inotify_max_queued_events,
+			    sizeof(int),
+			    0644,
+			    proc_dointvec_minmax,
+			    SYSCTL_NUMERIC_ZERO),
 };
 
 static void __init inotify_sysctls_init(void)
-- 
2.25.1


