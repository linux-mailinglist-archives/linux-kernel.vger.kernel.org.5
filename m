Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F205805B69
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345538AbjLERcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjLERcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:32:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73614188
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OrfTo/Owz4NrJFfbfU9QR1N7TorNMwrOqn5rTcm+KvY=; b=ardZfDHdXsZ8ibLlXJF8/V9Djg
        3jt+g2oQseqBarq9O1OBc0vya59u9N0gSJf6sgwjjlVfbY0UdBW0ZfEph4W1R+7RJfpLZaXefIEKf
        jxiiNQIv99KM42Ki2xXCEk2YNQXfvAQEYI5xMc8k0YXuoRn0a5Hvo2r1vlgJ1s7+g5ydkqfLv7jdJ
        X0dSqSKl0HMNtDmLtSYDeSkHD8kUsdwqgdG4aWWaKR2FS2IUoWeyodP2hCXVOEB7hXb1knozzsqsi
        SED+OP20BcV9JG4QbyeolxljsLYsRt/LdBR1AdmEAghuxzrt/Am5dk/edTj13d5+XarXFZS7q91lI
        hXyIT/zQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAZHS-0082ez-1z;
        Tue, 05 Dec 2023 17:32:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] jffs2: nodemgmt: fix kernel-doc comments
Date:   Tue,  5 Dec 2023 09:32:22 -0800
Message-ID: <20231205173222.12575-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the end of one sentence where a comment was truncated. (dwmw2)

Fix a bunch of kernel-doc warnings:

nodemgmt.c:72: warning: Function parameter or member 'sumsize' not described in 'jffs2_do_reserve_space'
nodemgmt.c:72: warning: expecting prototype for jffs2_reserve_space(). Prototype was for jffs2_do_reserve_space() instead
nodemgmt.c:76: warning: Function parameter or member 'sumsize' not described in 'jffs2_reserve_space'
nodemgmt.c:76: warning: No description found for return value of 'jffs2_reserve_space'
nodemgmt.c:503: warning: Function parameter or member 'ofs' not described in 'jffs2_add_physical_node_ref'
nodemgmt.c:503: warning: Function parameter or member 'ic' not described in 'jffs2_add_physical_node_ref'
nodemgmt.c:503: warning: Excess function parameter 'new' description in 'jffs2_add_physical_node_ref'
nodemgmt.c:503: warning: No description found for return value of 'jffs2_add_physical_node_ref'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org
---
 fs/jffs2/nodemgmt.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff -- a/fs/jffs2/nodemgmt.c b/fs/jffs2/nodemgmt.c
--- a/fs/jffs2/nodemgmt.c
+++ b/fs/jffs2/nodemgmt.c
@@ -49,28 +49,31 @@ static int jffs2_rp_can_write(struct jff
 	return 0;
 }
 
+static int jffs2_do_reserve_space(struct jffs2_sb_info *c,  uint32_t minsize,
+				  uint32_t *len, uint32_t sumsize);
+
 /**
  *	jffs2_reserve_space - request physical space to write nodes to flash
  *	@c: superblock info
  *	@minsize: Minimum acceptable size of allocation
  *	@len: Returned value of allocation length
  *	@prio: Allocation type - ALLOC_{NORMAL,DELETION}
+ *	@sumsize: summary size requested or JFFS2_SUMMARY_NOSUM_SIZE for no summary
+ *
+ *	Requests a block of physical space on the flash.
  *
- *	Requests a block of physical space on the flash. Returns zero for success
- *	and puts 'len' into the appropriate place, or returns -ENOSPC or other 
- *	error if appropriate. Doesn't return len since that's 
+ *	Returns: %0 for success	and puts 'len' into the appropriate place,
+ *	or returns -ENOSPC or other error if appropriate.
+ *	Doesn't return len since that's already returned in @len.
  *
- *	If it returns zero, jffs2_reserve_space() also downs the per-filesystem
+ *	If it returns %0, jffs2_reserve_space() also downs the per-filesystem
  *	allocation semaphore, to prevent more than one allocation from being
- *	active at any time. The semaphore is later released by jffs2_commit_allocation()
+ *	active at any time. The semaphore is later released by jffs2_commit_allocation().
  *
  *	jffs2_reserve_space() may trigger garbage collection in order to make room
  *	for the requested allocation.
  */
 
-static int jffs2_do_reserve_space(struct jffs2_sb_info *c,  uint32_t minsize,
-				  uint32_t *len, uint32_t sumsize);
-
 int jffs2_reserve_space(struct jffs2_sb_info *c, uint32_t minsize,
 			uint32_t *len, int prio, uint32_t sumsize)
 {
@@ -488,13 +491,16 @@ static int jffs2_do_reserve_space(struct
 /**
  *	jffs2_add_physical_node_ref - add a physical node reference to the list
  *	@c: superblock info
- *	@new: new node reference to add
+ *	@ofs: offset in the block
  *	@len: length of this physical node
+ *	@ic: inode cache pointer
  *
  *	Should only be used to report nodes for which space has been allocated
  *	by jffs2_reserve_space.
  *
  *	Must be called with the alloc_sem held.
+ *
+ *	Returns: pointer to new node on success or -errno code on error
  */
 
 struct jffs2_raw_node_ref *jffs2_add_physical_node_ref(struct jffs2_sb_info *c,
