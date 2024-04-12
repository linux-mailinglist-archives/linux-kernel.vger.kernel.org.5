Return-Path: <linux-kernel+bounces-142725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980438A2F68
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A6A282E11
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C1182899;
	Fri, 12 Apr 2024 13:29:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F85824A8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928572; cv=none; b=HC1eNa1jR9ZHWjYG7TtF6+EC9fIUYeP/6ujKkAlz2RzWmI2DRMC4bGn7oGlw5l8eeeyFInxj5WUfUiXuF/2zS08IJKKpEJud2hjrYy2XNqn/paTlXqbveUw2zvKHTFM9/esxFC+QaEHakVC0ux48Fzmwdrwdgk1NtPRriyUzr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928572; c=relaxed/simple;
	bh=ANIJRUlQz6LQ5jbf92Mbu1AsZcgEwSE3Z9aKa1ZENwQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eIxFOhPNv5enKx+utBLljNLKoJIwuSi5Nl3GdBMIEeJLqPzLkslAOP8k3nAC1KHeet0v/7hoeZ9MLq1jTjQiP+yAY2q/En8mg0sgYyhSXQK2hAIjH/u+A8vBHxX3gk11DUEs1uPf+fpTpT2Dpcp33zL4tU1F8wi7Wy26iMrIovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE99C3277B;
	Fri, 12 Apr 2024 13:29:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rvH0n-000000012pR-45QV;
	Fri, 12 Apr 2024 09:32:13 -0400
Message-ID: <20240412133213.834390718@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 12 Apr 2024 09:31:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yang Li <yang.lee@linux.alibaba.com>
Subject: [for-linus][PATCH 1/4] eventfs: Fix kernel-doc comments to functions
References: <20240412133152.723632549@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Yang Li <yang.lee@linux.alibaba.com>

This commit fix kernel-doc style comments with complete parameter
descriptions for the lookup_file(),lookup_dir_entry() and
lookup_file_dentry().

Link: https://lore.kernel.org/linux-trace-kernel/20240322062604.28862-1-yang.lee@linux.alibaba.com

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index dc067eeb6387..894c6ca1e500 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -336,6 +336,7 @@ static void update_inode_attr(struct dentry *dentry, struct inode *inode,
 
 /**
  * lookup_file - look up a file in the tracefs filesystem
+ * @parent_ei: Pointer to the eventfs_inode that represents parent of the file
  * @dentry: the dentry to look up
  * @mode: the permission that the file should have.
  * @attr: saved attributes changed by user
@@ -389,6 +390,7 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 /**
  * lookup_dir_entry - look up a dir in the tracefs filesystem
  * @dentry: the directory to look up
+ * @pei: Pointer to the parent eventfs_inode if available
  * @ei: the eventfs_inode that represents the directory to create
  *
  * This function will look up a dentry for a directory represented by
@@ -478,16 +480,20 @@ void eventfs_d_release(struct dentry *dentry)
 
 /**
  * lookup_file_dentry - create a dentry for a file of an eventfs_inode
+ * @dentry: The parent dentry under which the new file's dentry will be created
  * @ei: the eventfs_inode that the file will be created under
  * @idx: the index into the entry_attrs[] of the @ei
- * @parent: The parent dentry of the created file.
- * @name: The name of the file to create
  * @mode: The mode of the file.
  * @data: The data to use to set the inode of the file with on open()
  * @fops: The fops of the file to be created.
  *
- * Create a dentry for a file of an eventfs_inode @ei and place it into the
- * address located at @e_dentry.
+ * This function creates a dentry for a file associated with an
+ * eventfs_inode @ei. It uses the entry attributes specified by @idx,
+ * if available. The file will have the specified @mode and its inode will be
+ * set up with @data upon open. The file operations will be set to @fops.
+ *
+ * Return: Returns a pointer to the newly created file's dentry or an error
+ * pointer.
  */
 static struct dentry *
 lookup_file_dentry(struct dentry *dentry,
-- 
2.43.0



