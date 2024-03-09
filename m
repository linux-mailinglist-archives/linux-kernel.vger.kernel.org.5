Return-Path: <linux-kernel+bounces-97851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA513877077
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799512821CD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8340A383AB;
	Sat,  9 Mar 2024 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="NlC1BB4n"
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EE6381DD
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709980364; cv=none; b=DSilv6dqHoMiCXhCLhEuuSiwi8GmGX6F5pGDC34ADqmaYdZyktkWO28e3m1dGya8cqxKKHiUrw2mJQX8sdYYeJypN6+30PZU7Qw0mGuswiaZlz7cV/BAARYJHGzwciHKDFBA88NCHnAdtOyn45HCLlpIRsvMewP6ArfUj4j1tFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709980364; c=relaxed/simple;
	bh=4Q8Y0s/DZIIeCtVh1+2DKNHiVdkiYLAYibyrXczYUCg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=eIC+REDTPg4IeBqJiYHPH+6nGfzy2HP0srzNqWHKPlZUtzVv7PC7pzqM0fm6HIdnfHWESFLtuzHNZG0l1nor/AHFkf7syPmDVx/cWPVJla7SJFi4E8kaEFCw7t1zUFA/mcPvdSp+/vM9HhuaJW1Tquu5eHn+jfZGZrZAcddXByk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=NlC1BB4n; arc=none smtp.client-ip=203.205.251.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709980355;
	bh=hluYQ3X6fPxKYVqiVUP3UTXquwXzlkOf6HmiAExCtQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NlC1BB4ndYwETnE4X4e4RAcJntT9b4ifI0WV05Nm2WWyEtDguW3nvKOW+W2tNxjT4
	 cPITc8vs+kMDpuJ0i5k5xvqmxLrI79PdGJzjYwFYrav6r5myFMnRs6TXcQR6YUPcZc
	 dGQxtxlbQWWi44a/iIJqCihexUl3c0VBVuGpEzz4=
Received: from localhost.localdomain ([2409:8961:2a0b:4ad8:c972:9bc3:984f:98a9])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 7EF8DC9A; Sat, 09 Mar 2024 18:31:47 +0800
X-QQ-mid: xmsmtpt1709980331tv2e6m911
Message-ID: <tencent_8A661504B57950D1A4423A387393DFD63306@qq.com>
X-QQ-XMAILINFO: OEwe1wxmQPEpANXkgHi6haVwpa29YLB4RBR/9RtiThrN9AG84nUF6jTkijhv6K
	 l7APvLnM2VmhgUrFRJh3XLcOatM5wx0WRl25km5Njc29ZvcIbGGx00w1i0hSXDNcFU/NZ7Nhr2Hv
	 R2EzjL4jJCkcPlwl829RrtdTNriQYF8dqtrTSXCEetLEJZXm617CSY3dKFu7lqwUmgmNY6jUitfL
	 hjAba+wowNY1T5BHXQX5Pe8JvznlyhcPOgKC0ppsevOOXJhodPNUSkKd+1MdPDiLZ1MXkvNcEAWx
	 Dv5Nyz4qI63oxufqFUvoe/2ZhQ7wth/Oaaeg2c7v2kEt0BZdlNYqGpR8lczU2ptR8x909jGrCZ4n
	 bS2Nt6c9OXfbsaNx6aoliSqv3OjmauLyXqfSFhtCHa50I6RhUfo3D6a4Hma2ZbAjrhm1B3O4R0LO
	 Xf7jBpu4RoU1UZYgvncAnzNmwDThqQpXxzcwqcwaUQgtYIEZ2bqfGYk08FiWmSezgrR2jclmXLWZ
	 yqHHCiLPo2BsplMlz6nVlgIgqKcd+nYk4ZUpW0Bj1DIIQ6Z0pFyktrDklwR5vAai+veVMPQC7Zz9
	 yqwRBwFJ2eHjG2ZMOXzKrSk/UZ+JE1OmiQL5hPtufggapHyJ7vkq/V1/lG6NgGIY2oVxkMg16lBT
	 JwOjzK7f0qAMS62llqBlBh9cosqNt0pb4jIjnhw84QhKezYEFMgo7ya40SHRZe1XnW6OIP3wKdfx
	 b7YIAitKJ1I8gd0wsx6f4BvXPeFF4ud5mzBj4NnSGu/e34eSPbShD2OxMiakSmqgBVMSa8zWEugb
	 EmlUin5pwkNZXiKrWOWxoIF/0GNx0oOWz6m6Q9hERyEIzVMX7ZWEVgcN8b2VxjeWfY3+vzBUt8Hq
	 uiWQDOLCduWEwwY6X9yf/DEBYdrmXjJf66vK3M73e7m7MW9hKrv1osD+NTn/VoQEI0X2WtDDAIQW
	 UnRh6axH13SDn4kZeGRzB6mrYtIR0D3eIJqnWiVxCP93+LE25iKe3Mouq4S0UMeHbLw64ABykp9o
	 FBzMFhClAxtUVGLIDEhy7MYWh2AlMhDPKQvKf8GCMR0ktNJeQ2NlPomsfSKMjdSlF2F/lNwUf/om
	 QpgVL0At32CkJjmMYzFxjtrtK02fHuU5VfhLYVLO66ar3ePxQ=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
Subject: [PATCH v2 7/9] epoll: delete these unnecessary static variables long_zero and long_max
Date: Sat,  9 Mar 2024 18:31:24 +0800
X-OQ-MSGID: <946ba0c1970cfc96ebf9ce732d7bb67f237ebfa2.1709978655.git.wenyang.linux@foxmail.com>
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


