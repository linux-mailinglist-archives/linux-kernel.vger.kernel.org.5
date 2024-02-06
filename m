Return-Path: <linux-kernel+bounces-54886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59284B4C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC71A1C2398B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483FD134CC5;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A318135A48;
	Tue,  6 Feb 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221360; cv=none; b=NxpmgoEQw1/FDCVamYN1EiWL+Skkv719a1dB9qySkzNifx1bVcW4kztA9DpCA1ZxvA3NsNKG6nmwi40S6xISzbkyRSlVmxe/eQbt4wPvCDEy9vk0U/Q3zGnW6oAv8tWMxn9dwtvm6cMTtIHPTnhK126izGKUUKIwXP++uJrB8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221360; c=relaxed/simple;
	bh=XeV1VUlwi1FILGXqC+sGicaJJYQTw6C1fAun/XWmlNM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BnX746K1P/68WAxBGvM2OuTecLdSoDH29ZCNN4ZPQ1JwjAq+wBRrlz9BughYX3jG4Iy6Gcp1tKS/75QLgYs0r1/nyFMOMUx50eqA+MgulCyB10p412B1sVjNjcFPeA+/NobXrKRYyofLnV9HRGK9u/6tQD5PpJJYaF+7MFG7VKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E168CC43394;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGq-00000006b6p-1Iig;
	Tue, 06 Feb 2024 07:09:48 -0500
Message-ID: <20240206120948.165080330@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Abaci Robot <abaci@linux.alibaba.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [v6.6][PATCH 11/57] tracefs/eventfs: Modify mismatched function name
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

No functional modification involved.

fs/tracefs/event_inode.c:864: warning: expecting prototype for eventfs_remove(). Prototype was for eventfs_remove_dir() instead.

Link: https://lore.kernel.org/linux-trace-kernel/20231019031353.73846-1-jiapeng.chong@linux.alibaba.com

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6939
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 64bf2f685c795e75dd855761c75a193ee5998731)
---
 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 1885f1f1f339..09ab93357957 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -856,7 +856,7 @@ static void unhook_dentry(struct dentry **dentry, struct dentry **list)
 	}
 }
 /**
- * eventfs_remove - remove eventfs dir or file from list
+ * eventfs_remove_dir - remove eventfs dir or file from list
  * @ei: eventfs_inode to be removed.
  *
  * This function acquire the eventfs_mutex lock and call eventfs_remove_rec()
-- 
2.43.0



