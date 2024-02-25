Return-Path: <linux-kernel+bounces-79975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B30862913
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 05:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD6F1F21868
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674EF7476;
	Sun, 25 Feb 2024 04:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="oyUQ3gDV"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D748D9454
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 04:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708834150; cv=none; b=keh7kaCG/K25lrd6D7FKqV6ZUSXN+CFhPz4rCvkEPmEtD8vaZuG813TbvW+x4GOWyQzm2mOK1esjG9+YT+tvMcmUGm9heDMhnSyEDB8X1wq6Jspl+gsgXeeemg/RKn53Mq6VLqzV+j/urB/4gjXU5o1EnRFhXUUKVBMRkLCADTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708834150; c=relaxed/simple;
	bh=gT6pHr6ol4g0hx+y0gQX0e1TRgLEPuqhV8V1nhgaMgA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tFJU0OfgdxE9Cgf4ttuVyawRVU3e0XkNAdQxxS5dHk99Z1FA9M2AIo+LGUT6KH4hGuidefKS23bJFPf7zaVQjiidcMPAbkqCcdG9DyhSCRGF8EOVi9GU7MtkHsKbbQlDzz+2+U6UwagPeE6S4rhOemlUjJ3d4U/rHJREcDKRqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=oyUQ3gDV; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708834138;
	bh=l13WUrrxIXOx/AaiCG+3OUvZIiXniioY9+G9KsMVcKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oyUQ3gDVXZqLC+mm+glQXeLGd2mBN5zhCnDssLa46I17MHluFC/p2fremH5tdbFRC
	 MwhuB7RWXYFslE/yiLZvCABoLGcZ1I7wxXsGk7js2wdZRfWwpLt81GVml/nr7u5L+u
	 CaL5eotO3ADvzwa0RH2E2fBeTUuKek5HafTy/gHo=
Received: from localhost.localdomain ([2409:8a60:2a61:ef40:480f:5c56:cca3:1b20])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 18993038; Sun, 25 Feb 2024 12:06:09 +0800
X-QQ-mid: xmsmtpt1708834055t1cx1lrd7
Message-ID: <tencent_F557F83D3C175625528B06194C3EA4A3320A@qq.com>
X-QQ-XMAILINFO: MJf3YPW6EzbKUsrbZkpQUE6MXr2IXIV0tvZ+QcMyNSn5ZT/4QOJ7wpjMG1q0s6
	 10vK0cUOqOQThBAVtOzashjbIT0JRqmohIXkV7J+Z8/csouKvsuzs9JCDDoj1DnCk6dbnR9TfAMv
	 TELPb9QdwK4RQ6cNnLlVQKsw+7v8LfjwamHE/S1aLwJG77Y+79mPpP6fczsDSlMEsDwyN5Q6J9K+
	 IYM6OAZtmY8rZOWnKbXbf/i4CdhTC6px1uIoFOSbN08HAX9509U5CiO/egVXejmNVPg030G+Pgjc
	 uQw9YDqKZIwCPNOSCp2R27In4bbNnEup2m+q3kiJo4lCeVOlHIQ0G0NVAm5qJ43DAR8BJgX8xJtc
	 fHOygHZp+5O0LrcDRnkg/Zn9vpcWO292UgiX1TRbqvW45Iz0IgMVmo9evc53r46sJxH6slmySaSW
	 ciMhufPAJhZsj/ds3Q6kZJOGbHiH28DgdUOvx2FbQN2JKh/Q2Zq6Pr2N1nCsJp2az7R+QXZlsH/p
	 bkY4EssZzzN0hRojC/IAhLLiC1sT2PPdoL8xTFINGNyNkyjd6j9E4tYuLd5EKmznZHSw3JtwJLxt
	 vp/PlsJYcKKY4q3khH4ubWsICMqoR/Gnp1Q0my5n5SIMdePcfHRGcOef0quQJ/5fyHmcU1D1iC+l
	 VSPiLA2q67faI3V4hRgxnW5b6/EzVrk6m6MTYq4EnzAPizuRhGHaV1nWl7LYaNjliO6sPuin6pJb
	 Jno3V/+ZZnOLujOSNdPMxIS6Th/+/GpYi8eKTSHDBfMSob+jx/K+FDkPpULzTMrn+Z9dZqRJO7XN
	 7X801YgTnzbfCwUc700yb7mkhDxuPm2vCXNUIQkCoyuxrXXFByfT1gFsyrR5lO/dLavzk3DsJI+F
	 9zPT6Rvsga5PI3+hoUG+71umaxh47x6O9TzSVdHVSAdDC10RwJB2oMzSToL+p663c+YI1fKQWk2Z
	 cd/jvKlZKiWRAJmyO/T9rCKJ5n59rTYYc8e7XHSQy1VrYGcoWXxDPyjnDlWK904QRKhW0kJm9WqX
	 Iei45zWSuJpWXZioOWIflbhFIOvboc5MtotZs8OtUyHY4JT5SElWPzm0WYqkKQqBVO6ee+8PMK1N
	 Yt9zN43z57hgjMz8c=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: wenyang.linux@foxmail.com
To: Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>,
	davem@davemloft.net,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] fs: inotify: delete these duplicate static variables it_zero and it_int_max
Date: Sun, 25 Feb 2024 12:05:37 +0800
X-OQ-MSGID: <20240225040538.845899-8-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240225040538.845899-1-wenyang.linux@foxmail.com>
References: <20240225040538.845899-1-wenyang.linux@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

Since these static variables (it_zero and it_int_max) are only used for
boundary checks and will not be changed, remove it and use the ones in
our shared const array.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 fs/notify/inotify/inotify_user.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 85d8fdd55329..fd5c00ed8559 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -55,9 +55,6 @@ struct kmem_cache *inotify_inode_mark_cachep __ro_after_init;
 
 #include <linux/sysctl.h>
 
-static long it_zero = 0;
-static long it_int_max = INT_MAX;
-
 static struct ctl_table inotify_table[] = {
 	{
 		.procname	= "max_user_instances",
@@ -65,8 +62,8 @@ static struct ctl_table inotify_table[] = {
 		.maxlen		= sizeof(long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &it_zero,
-		.extra2		= &it_int_max,
+		.extra1		= SYSCTL_LONG_ZERO,
+		.extra2		= SYSCTL_LONG_S32_MAX,
 	},
 	{
 		.procname	= "max_user_watches",
@@ -74,8 +71,8 @@ static struct ctl_table inotify_table[] = {
 		.maxlen		= sizeof(long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &it_zero,
-		.extra2		= &it_int_max,
+		.extra1		= SYSCTL_LONG_ZERO,
+		.extra2		= SYSCTL_LONG_S32_MAX,
 	},
 	{
 		.procname	= "max_queued_events",
-- 
2.25.1


