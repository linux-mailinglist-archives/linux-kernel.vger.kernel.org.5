Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E191E7D5979
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbjJXRKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344034AbjJXRK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:10:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE33118
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:10:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5435C433C8;
        Tue, 24 Oct 2023 17:10:25 +0000 (UTC)
Date:   Tue, 24 Oct 2023 13:10:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] eventfs: Fix typo in eventfs_inode union comment
Message-ID: <20231024131024.5634c743@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

It's eventfs_inode not eventfs_indoe. There's no deer involved!

Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 298d3ecaf621..64fde9490f52 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -37,7 +37,7 @@ struct eventfs_inode {
 	/*
 	 * Union - used for deletion
 	 * @del_list:	list of eventfs_inode to delete
-	 * @rcu:	eventfs_indoe to delete in RCU
+	 * @rcu:	eventfs_inode to delete in RCU
 	 * @is_freed:	node is freed if one of the above is set
 	 */
 	union {
-- 
2.42.0

