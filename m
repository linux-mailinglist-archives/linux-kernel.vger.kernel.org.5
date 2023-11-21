Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7867F3A12
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjKUXLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKUXLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:11:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9439FA4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:10:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40055C433C7;
        Tue, 21 Nov 2023 23:10:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
        (envelope-from <rostedt@goodmis.org>)
        id 1r5Ztg-00000002dCq-1TWw;
        Tue, 21 Nov 2023 18:11:12 -0500
Message-ID: <20231121231003.516999942@goodmis.org>
User-Agent: quilt/0.67
Date:   Tue, 21 Nov 2023 18:10:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/4] eventfs: Some more minor fixes
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland reported some crashes from the latest eventfs updates.
This fixes most of them.

He still has one splat that he can trigger but I can not. Still looking
into that.


Steven Rostedt (Google) (4):
      eventfs: Use GFP_NOFS for allocation when eventfs_mutex is held
      eventfs: Move taking of inode_lock into dcache_dir_open_wrapper()
      eventfs: Do not allow NULL parent to eventfs_start_creating()
      eventfs: Make sure that parent->d_inode is locked in creating files/dirs

----
 fs/tracefs/event_inode.c | 24 ++++++++----------------
 fs/tracefs/inode.c       | 13 ++++---------
 2 files changed, 12 insertions(+), 25 deletions(-)
