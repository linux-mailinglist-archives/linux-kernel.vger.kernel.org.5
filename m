Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732B3809332
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443969AbjLGVUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGVUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:20:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0D11708
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xzKe6CRMX3Udapn1KlVr0K9e9qpGO8OItUpNbpghOYc=; b=i1gCC/C1dfxZmSQb5Ez+SP5XhK
        zmAay0U82p2wC0y4rIpsP6MkdGLlyGKiWydn2jZpbfznTUsmx5jjedcNBVTyXUVvsKfjcHjLOSlZl
        lVx2U7kEkR5ywt0oQ5wgB08Xop0uMUWpEJtinMrRdJw10/WuBqLSH1hyBdH2GtLAym1H0PF/vu2CF
        gzvr2BYas7Uq46SNawLIWhJn/q0dU3vGb+eg+a0GP0pCRE/wHsDXUQaLWAfLABYn46fJswCjcUnCz
        xgEIiAXq54pbaNay8Eze20tcyhiFmqBifa1aiyvtwLqXezem/ejw1z81cQSrx3oX/0v3v4zeQnPLJ
        Msr55c4w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rBLnQ-00Dwiu-1i;
        Thu, 07 Dec 2023 21:20:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/3] freevxfs: immed: fix kernel-doc param name
Date:   Thu,  7 Dec 2023 13:20:34 -0800
Message-ID: <20231207212035.25345-2-rdunlap@infradead.org>
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

Correct the function parameter name to prevent kernel-doc warnings:

vxfs_immed.c:32: warning: Function parameter or member 'fp' not described in 'vxfs_immed_read_folio'
vxfs_immed.c:32: warning: Excess function parameter 'file' description in 'vxfs_immed_read_folio'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/freevxfs/vxfs_immed.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/fs/freevxfs/vxfs_immed.c b/fs/freevxfs/vxfs_immed.c
--- a/fs/freevxfs/vxfs_immed.c
+++ b/fs/freevxfs/vxfs_immed.c
@@ -15,7 +15,7 @@
 
 /**
  * vxfs_immed_read_folio - read part of an immed inode into pagecache
- * @file:	file context (unused)
+ * @fp:		file context (unused)
  * @folio:	folio to fill in.
  *
  * Description:
