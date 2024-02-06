Return-Path: <linux-kernel+bounces-54888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F9084B4CA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7C71F22E21
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F85137C35;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B824135A61;
	Tue,  6 Feb 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221360; cv=none; b=WumV4EodnpFHY+lkv7miLHPAF3NsybNJEOu34aOCgtQklZ+N5zgcZMNOUIglSITEvYQXPXLiCdmZosGKVyKEpdIXpycN49FVVaylfoxbM2j9FnzdUEB/RDa8hfS1LYE+wupGyDABjkT5MEPLfMNo6DFizY7RzmUxOFF6PNjFFEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221360; c=relaxed/simple;
	bh=22GR3qyx19RyNEnG9roHdEAwdkUh1gVC4hPoWy80m34=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jp0kJzQCX9qHL3r8zrEM2BaXNdtVn73o/PMLdp5/n+NbSdy+LkwgE2NvsY3OK7bwfE4FdH6SyeIMa+JcHI4nra2s3ZhhnUKvGRdJr7THEMrRVDWLdr1fLL2H1Hcx9CezDFNEMWGUWyFTDBrgJyj08OSvDJvuufHacJ7g6acQ1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86588C43394;
	Tue,  6 Feb 2024 12:09:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGq-00000006b8p-41Lr;
	Tue, 06 Feb 2024 07:09:48 -0500
Message-ID: <20240206120948.816153049@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 kernel test robot <lkp@intel.com>
Subject: [v6.6][PATCH 15/57] eventfs: Fix kerneldoc of eventfs_remove_rec()
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The eventfs_remove_rec() had some missing parameters in the kerneldoc
comment above it. Also, rephrase the description a bit more to have a bit
more correct grammar.

Link: https://lore.kernel.org/linux-trace-kernel/20231030121523.0b2225a7@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode");
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310052216.4SgqasWo-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 9037caa09ed345b35325200f0e4acf5a94ae0a65)
---
 fs/tracefs/event_inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5536860eb2ff..9f612a8f009d 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -796,9 +796,11 @@ static void free_ei(struct rcu_head *head)
 /**
  * eventfs_remove_rec - remove eventfs dir or file from list
  * @ei: eventfs_inode to be removed.
+ * @head: the list head to place the deleted @ei and children
+ * @level: prevent recursion from going more than 3 levels deep.
  *
- * This function recursively remove eventfs_inode which
- * contains info of file or dir.
+ * This function recursively removes eventfs_inodes which
+ * contains info of files and/or directories.
  */
 static void eventfs_remove_rec(struct eventfs_inode *ei, struct list_head *head, int level)
 {
-- 
2.43.0



