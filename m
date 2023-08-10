Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B465F776CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 02:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjHJAHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 20:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHJAHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 20:07:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB19FE74
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 17:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=a/tB3igPuPQPji9bDIFLD+1I0YTlmH4t0wSv4ROhmQ8=; b=NKpTDiSMQJK6r+Bsyq5FrF+HGJ
        TN3EMlTqGVYTZ0qA5y9OkRtw6f2iOA+7EnXdvP0F37OO8DCe2bR5eOUs3AcLtJZ23D4dLe5oZxAmA
        xhsJJF615AjipHFE7uqeFqP25u1InxFqjg27XtzTrxpSfaNCfbgCbauESACVpE3Z9eb0gzB2ht/Yd
        H0ubeX2Dk55c4bVTZA5qFygDDZLaKEBthp8VRvr/5XfZho7X3Mf3671haHzWu0sNzVbkQrt15r5La
        QYrazHH+D/5mNHIsKf9gGOTesMaqbkXrsY+4HkRBnAHff+VZUGUFb75j+t28JJrVYBaA09eKQ3z9F
        JQYj3sig==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTtDJ-00686R-1F;
        Thu, 10 Aug 2023 00:07:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: PLPKS: undo kernel-doc comment notation
Date:   Wed,  9 Aug 2023 17:07:40 -0700
Message-ID: <20230810000740.23756-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use kernel-doc "/**" comment format for non-kernel-doc comments.
This prevents a kernel-doc warning:

  arch/powerpc/platforms/pseries/plpks.c:186: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  * Label is combination of label attributes + name.

Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202308040430.GxmPAnwZ-lkp@intel.com
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/pseries/plpks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -194,7 +194,7 @@ static struct plpks_auth *construct_auth
 	return auth;
 }
 
-/**
+/*
  * Label is combination of label attributes + name.
  * Label attributes are used internally by kernel and not exposed to the user.
  */
