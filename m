Return-Path: <linux-kernel+bounces-51352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43874848A13
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D988DB23F3E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84B3168DE;
	Sun,  4 Feb 2024 01:18:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E6C2FE;
	Sun,  4 Feb 2024 01:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009487; cv=none; b=hYoxle+rixhdxqYAtSbL1iQneRPwfoD7CsO7HrS1l+Gl58qINl5on2F65Q8q0PYdqGr2nNSwqMebFK0HAQpzG7/lL/dtk1xHB4JdbHmu3pVNaIRecycgJLUcb3SdtBapLadtLwnpIunsTg6tnO6LpRwpiX3bQvEHI7VEK4sisQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009487; c=relaxed/simple;
	bh=6ZjGB20lu+D72LkOxZozH0kq/zHvSI+SlGbD2+KSFzM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jywflouJluNoBvjaa5btLXQNm+7e3cQHiwbv+EhX8rdJla46pl4MpWj38Fevz4zT148sURU/U083KVs7syZqBbVMWpUN+N9rhH1SpozbWMuewvGpTtuNyz9T6iF9PVILLwBYFW4Pil+bP0dpFwgt1E6XRHDdI2LzBjOYEbMCBnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D72DC32788;
	Sun,  4 Feb 2024 01:18:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rWR9R-00000006Oss-3KkG;
	Sat, 03 Feb 2024 20:18:29 -0500
Message-ID: <20240204011829.656627126@goodmis.org>
User-Agent: quilt/0.67
Date: Sat, 03 Feb 2024 20:16:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>
Subject: [v6.7][PATCH 17/23] eventfs: Remove unused d_parent pointer field
References: <20240204011615.703023949@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Linus Torvalds <torvalds@linux-foundation.org>

It's never used

Link: https://lore.kernel.org/linux-trace-kernel/202401291043.e62e89dc-oliver.sang@intel.com/
Link: https://lore.kernel.org/linux-trace-kernel/20240131185512.961772428@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: c1504e510238 ("eventfs: Implement eventfs dir creation functions")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 4 +---
 fs/tracefs/internal.h    | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 04c2ab90f93e..16ca8d9759b1 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -680,10 +680,8 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	INIT_LIST_HEAD(&ei->list);
 
 	mutex_lock(&eventfs_mutex);
-	if (!parent->is_freed) {
+	if (!parent->is_freed)
 		list_add_tail(&ei->list, &parent->children);
-		ei->d_parent = parent->dentry;
-	}
 	mutex_unlock(&eventfs_mutex);
 
 	/* Was the parent freed? */
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 09037e2c173d..932733a2696a 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -36,7 +36,6 @@ struct eventfs_attr {
  * @name:	the name of the directory to create
  * @children:	link list into the child eventfs_inode
  * @dentry:     the dentry of the directory
- * @d_parent:   pointer to the parent's dentry
  * @d_children: The array of dentries to represent the files when created
  * @entry_attrs: Saved mode and ownership of the @d_children
  * @attr:	Saved mode and ownership of eventfs_inode itself
@@ -51,7 +50,6 @@ struct eventfs_inode {
 	const char			*name;
 	struct list_head		children;
 	struct dentry			*dentry; /* Check is_freed to access */
-	struct dentry			*d_parent;
 	struct dentry			**d_children;
 	struct eventfs_attr		*entry_attrs;
 	struct eventfs_attr		attr;
-- 
2.43.0



