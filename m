Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F352B7D7A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjJZB2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjJZB15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:27:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8F7186
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:27:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37908C4339A;
        Thu, 26 Oct 2023 01:27:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qvpAA-00CqUd-0k;
        Wed, 25 Oct 2023 21:27:54 -0400
Message-ID: <20231026012754.043877861@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 25 Oct 2023 21:27:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 4/4] eventfs: Fix typo in eventfs_inode union comment
References: <20231026012734.358814002@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Link: https://lore.kernel.org/linux-trace-kernel/20231024131024.5634c743@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
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
