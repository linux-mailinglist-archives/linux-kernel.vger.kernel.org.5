Return-Path: <linux-kernel+bounces-97853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C78877079
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABCD1C20C18
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC94C3FB87;
	Sat,  9 Mar 2024 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="EsTq3fiY"
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968138F97
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709980368; cv=none; b=kUbpKqIqRQQjj7/RSe7vuGijtc+VOqAclWXuj8uBXMxfpQy6CY1+SJfCjq0bXndC4hEf4tlEEwNxbajZ2CpXl3ykcFw/dtkTdk9yDpf2ixi+hvEwH5fq5iWk2RBOw7iKT+VEjNwi6fVVcK0oQs9M46NSoOEl47VdRRFrFsUeReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709980368; c=relaxed/simple;
	bh=NJKqmOHNR07G45d4NVjLLw9EdzmYl7F7Ce1i+WlWE7s=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TtWgC7K2b0ZnhK9WseLZpYZKmMXRmUuykewnRmRpAYGLh5GO51idVO+r6tHF0/7terkijrK/UUnLojVVGcM7weWhlJDsI++32CpjgHk7pxkEWX8HniyLaY4o2znfheWaBMb7H5dB8dq2EubZWpwoLm1BbMP4wBb2X1ocpLHLJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=EsTq3fiY; arc=none smtp.client-ip=203.205.251.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709980358;
	bh=SSRgMEacKlRgTzt0buSQ6sVgqkbUDUraShL6rUZA97w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EsTq3fiYUUdB3E6GBmvLkkX06DKgHdkDfm9UHKdXotIYPg0JHDHYWqZGQUh7SAJh4
	 cYPNacjSTC1Yu5TpO+JJBE5RjbfeQ3exOb/DjcmFhOvFEKFCHjq2dGej1rg3rexBzr
	 0WCCaCFe9LxNHmELdI0/ndKKnCI/xsgas+uWEzE0=
Received: from localhost.localdomain ([2409:8961:2a0b:4ad8:c972:9bc3:984f:98a9])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 7EF8DC9A; Sat, 09 Mar 2024 18:31:47 +0800
X-QQ-mid: xmsmtpt1709980334t1sqlvol2
Message-ID: <tencent_08629E71ABB6A973832226A1D3D999DFFC09@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85No5ibEFZnXtcXauqggPA/99tpCySGtWw0DWp2iq6fMwdi+qOmNZ0
	 peu5GmZWfSllRYVpW8LkBdNJh2Q4XGO7wmOdECpCjpCm9XR+n+0YmiokJlRGs9x6zZRFw8lPt9oF
	 m9VOdyap7zti44H3JfYpXrfyWeKD4lFT7Iy7i+Q+/wZ1stoDpwWEzMI6wuGmFZYh/6jet6Q6twVi
	 ZwO/BW0fch4c1z3Ldb2/g053+tfNWYh+Qzqz/BPPGugH+vE45qRHwzU64AtHNdSiNVarbQxOWtKi
	 srSFD4Z+GSi0ecZG5fTgjafCbWND0cnoqVM/Q42IOhSYBX6K+VH+uLOn44y4p/8s/pT0Gbj33PZw
	 oZIGabI7uL45sknYbKTmauFBGz7IN443knkQr5VuXTHcDYLpkUhDQn77d7SwCnxtnCmlASqE/Ap6
	 DSP8lzAIh1Tsj2SCchJ9cmTecnJJDTe9CYKnDYsPkk4WVs7t/3RbNNkRkZkSazZVY3bKa6A1Gp6V
	 H793wGhGJz78Mnjik08IaQUYAMR4u/Y62+BiiL6ROEMqnUaCFc840kmwlh6phVpDfBupGZXNwJwn
	 FQQdH551Va+To7x8uBstP1jtEeiVskjoVxWMS6BhMpb6rjPCuDe1OassjiQcoAU9Tt84eQtykybc
	 mcy2VnYfV8OnMGEcco731zmR5x2O4g8PkLO+xE2V+wP6I8EMgTi6sdSHO7XJvCvQhykjeWWC9RH0
	 Eko7FXZRwB4V0y2P6dHqtSxdJRt6t1SjmskiSFq+l3hgpZAqndUeC5T2wYyyk3rjULkO3zdVzscC
	 RlRtq36QHVWlaU4QH54tWoxhXcOSX0TKjfPktDHsqHzOU1qFyZ787FBmYkRkezv87hCx99TVbme1
	 rZiZ8fjUTzOZvOER2cFZjfMuY9TQ1KIm/+ES3NK+FGg06qoB+XtBehiQEQ06v+z7WhEzqBPwCMUf
	 HHdpGwtBX7c5Kr6y5R65OvZ4ZHSoFI2wkQAJ3zuIgaU5X9FMrEeEdPIqVQr+kUDTSHjdgnxL5pjH
	 FGcZN3vRHFUG5b26ttb6TkbPLh/GGAH1qsL6/yHEC/ScZW/apv2Sy4li9UsFzCzxbHXB2ZTw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] fs: inotify: delete these unnecessary static variables it_zero and it_int_max
Date: Sat,  9 Mar 2024 18:31:25 +0800
X-OQ-MSGID: <ba4f1a1a2f4341994f4e91cecf1df3686428c013.1709978655.git.wenyang.linux@foxmail.com>
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


