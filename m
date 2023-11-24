Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDA37F6C45
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343888AbjKXGTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjKXGTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:19:15 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D211BC6;
        Thu, 23 Nov 2023 22:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XeM2/YVnDXfXgpeLQgDEJQeq5XnCf5/d0ww8kuOPva0=; b=jnwrXtUC4/A5GF44GUSmHQGw5y
        B87eufBoAnep4eyZ5Mapdk2iQS0JMfTdTpujwKqPGqZr+56kFMlWvKoO7J/z0KhLvAMpcx1WGhldf
        hT7C1g/woP8GBQoFOlYLRn5w4ZSM0N9s4AlpCaSd65e+qN1EXR9e/aJzJhp0rvl2NonBXk8pOIQDU
        fOssG4Z/t+u/5XEoFrQPqXRdccXoGJV2ZZ7TWGPbk30arsEdO3OfFoAjOHAELwsMwfPmtpOaCSW/a
        ycDyRP1R6oahLp4pYG/Xs8+uoqj1BwQO9VKFFIebzZCWk38Lyae+2Xy4kkWLtgpkTn+Edjf2sZKKD
        SJv/Frlw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PKw-002Q13-0a;
        Fri, 24 Nov 2023 06:06:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/20] kill d_backing_dentry()
Date:   Fri, 24 Nov 2023 06:06:34 +0000
Message-Id: <20231124060644.576611-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

no users left

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/dcache.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index a5e5e274eee0..fa0414cff85c 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -530,21 +530,6 @@ static inline struct inode *d_backing_inode(const struct dentry *upper)
 	return inode;
 }
 
-/**
- * d_backing_dentry - Get upper or lower dentry we should be using
- * @upper: The upper layer
- *
- * This is the helper that should be used to get the dentry of the inode that
- * will be used if this dentry were opened as a file.  It may be the upper
- * dentry or it may be a lower dentry pinned by the upper.
- *
- * Normal filesystems should not use this to access their own dentries.
- */
-static inline struct dentry *d_backing_dentry(struct dentry *upper)
-{
-	return upper;
-}
-
 /**
  * d_real - Return the real dentry
  * @dentry: the dentry to query
-- 
2.39.2

