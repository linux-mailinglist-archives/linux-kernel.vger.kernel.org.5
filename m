Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BE87E19EE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjKFGHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKFGHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:07:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2283100
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 22:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=f4oEJcN7tu7cszr0XCp5uXw/+bxFXjFvZY5/3ntOFSI=; b=HV03tB2NPM/4Ou1NgJkJ9Q2mza
        r/frmObyK8sMoyBba+Fq+8w2rZjNidyRfxwuhbxTzhMDRpsx2Wbj/5gX2CDGr80NaieTK0+v59zT/
        wNEKKOQNEHC6NWDyCiQs3n50NU1wbbJfrJTf4hPTRi1uamJkSXTTqWKG3VRzfa/3qFLMC6EGNSytk
        zLtvcj51w8jCdTjQSQR/WXCs8X2RG0LD+GXFZQFHMDpfdqusSidVQuC1Qtpr3zvUsdUzQ+MDD2cvi
        rKxWivsWUe1QzLCs89uSZurFqOZhSpJnIotVGNIwOTqZrKrTpt3Xs3MkHcXVOSMgp1BgToFm8C5a5
        55+Xd5dQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qzsm1-00FvQq-1O;
        Mon, 06 Nov 2023 06:07:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] ubifs: auth.c: fix kernel-doc function prototype warning
Date:   Sun,  5 Nov 2023 22:07:44 -0800
Message-ID: <20231106060744.10847-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
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

Use the correct function name in the kernel-doc comment to prevent
a kernel-doc warning:

auth.c:30: warning: expecting prototype for ubifs_node_calc_hash(). Prototype was for __ubifs_node_calc_hash() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: lore.kernel.org/r/202311052125.gE1Rylox-lkp@intel.com
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org
---
 fs/ubifs/auth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/fs/ubifs/auth.c b/fs/ubifs/auth.c
--- a/fs/ubifs/auth.c
+++ b/fs/ubifs/auth.c
@@ -18,7 +18,7 @@
 #include "ubifs.h"
 
 /**
- * ubifs_node_calc_hash - calculate the hash of a UBIFS node
+ * __ubifs_node_calc_hash - calculate the hash of a UBIFS node
  * @c: UBIFS file-system description object
  * @node: the node to calculate a hash for
  * @hash: the returned hash
