Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C1F809331
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbjLGVUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjLGVUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:20:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6771715
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EYltEHtIz8xO9yvngaiPcNxVvhsK8fVHZNELQTxLX4c=; b=P0PUY8he2Fbu0agW/8Tsx7C+4X
        CNkW7F30JS7/R4TXIfyGi6Gv2qQvUdKKZA17+P3/rqNXbr483Dz+xommnZ5b1k09vY1puPzO2boeD
        Ya4aGw0S1gnkJyl9oITuMzSHKe5cjDPUSIhYHnCGbUUc4SitfMuCLYO6G4leZ9nfBtBcjnndnZiHh
        sPicJSNdkAv5Ps8xnmXCBjZyhtD8W1wxKlZPbPNJe2Y+2ICmW3GpPj5mMOBnYW4aBKo66SR71bHEs
        IIT/dUtnLphxW2/R7UrqMIyRn4ePdVahx6H4AR9R+KqhyG6C8VD9PhGp0ozGvVEePgDoWKIvKmUBu
        J6lZ2v4A==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rBLnQ-00Dwiu-2I;
        Thu, 07 Dec 2023 21:20:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/3] freevxfs: lookup: fix function params kernel-doc
Date:   Thu,  7 Dec 2023 13:20:35 -0800
Message-ID: <20231207212035.25345-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207212035.25345-1-rdunlap@infradead.org>
References: <20231207212035.25345-1-rdunlap@infradead.org>
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

Correct the function parameter kernel-doc notation to prevent warnings:

vxfs_lookup.c:192: warning: Function parameter or member 'ctx' not described in 'vxfs_readdir'
vxfs_lookup.c:192: warning: Excess function parameter 'retp' description in 'vxfs_readdir'
vxfs_lookup.c:192: warning: Excess function parameter 'filler' description in 'vxfs_readdir'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/freevxfs/vxfs_lookup.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -- a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
--- a/fs/freevxfs/vxfs_lookup.c
+++ b/fs/freevxfs/vxfs_lookup.c
@@ -177,8 +177,7 @@ vxfs_lookup(struct inode *dip, struct de
 /**
  * vxfs_readdir - read a directory
  * @fp:		the directory to read
- * @retp:	return buffer
- * @filler:	filldir callback
+ * @ctx:	dir_context for filldir/readdir
  *
  * Description:
  *   vxfs_readdir fills @retp with directory entries from @fp
