Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A774C7F6C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjKXGSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjKXGSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:18:05 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1472E4C0D;
        Thu, 23 Nov 2023 22:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=b67XXezi8D0BTSowOzcQquBWhyTnsh7PP3xPQOygkAs=; b=PLXKkqw8JYL5uXZaf3TozCm0S5
        nrbCI/ZsDhTz7x8g1ELYTNNqolR5wou0tW5O6x0p1VGzbinqux37wNzEb48aGLIxdkShE0uA0aF6G
        XnZz5PG8M4cTazcirNi4UxmnT7CttB/fuFF/DauprzqmpqEuHzFFABE116IxNiFcwirZTGwRODNsL
        +HLpsFMB0xqqHX89U98HqDInn0PRpBGXO/AtN5OyEb+uaCDXfenB2+xCe9ZgFokiJYtnd90A95DBP
        mTjNmHxWtOX7RdJM3cRLZLWwnOxTCE7l+YWzCY0mHbUibN0lTwy/hSB4TQT4avoNmkhjb+oFLzrDW
        oviZr5hQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PKv-002Q0h-1r;
        Fri, 24 Nov 2023 06:06:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/20] DCACHE_COOKIE: RIP
Date:   Fri, 24 Nov 2023 06:06:30 +0000
Message-Id: <20231124060644.576611-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the last user gone in 2021...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/dcache.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index d9c314cc93b8..92c0b2a1ae2e 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -181,7 +181,6 @@ struct dentry_operations {
 #define DCACHE_NFSFS_RENAMED		BIT(12)
      /* this dentry has been "silly renamed" and has to be deleted on the last
       * dput() */
-#define DCACHE_COOKIE			BIT(13) /* For use by dcookie subsystem */
 #define DCACHE_FSNOTIFY_PARENT_WATCHED	BIT(14)
      /* Parent inode is watched by some fsnotify listener */
 
-- 
2.39.2

