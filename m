Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964DB76FA50
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjHDGnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHDGno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:43:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A6BB1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 23:43:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0894F61F43
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F97CC433C8;
        Fri,  4 Aug 2023 06:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691131422;
        bh=4rXtZPtL5oQZoxxNsOTexNzySBfq8KQl2Tp+f+M43vA=;
        h=From:To:Cc:Subject:Date:From;
        b=CdgKgrMr+e779lW8G7zOTJdGrnqImbZkRqYUEQZSNqdDk11RYdf5N7iqWvdfKDS4L
         I51ZJ/HWrZr6LSkwk7xstFAl8gWk7oap6Uykc+qysjOHAqXiI/2KsTTj7NbnfGUW9C
         LDquQBFOzE6OIPi7QppMq6dPE+f9yjPK8EhVAKDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm: no need to export mm_kobj
Date:   Fri,  4 Aug 2023 08:43:37 +0200
Message-ID: <2023080436-algebra-cabana-417d@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Lines:  23
X-Developer-Signature: v=1; a=openpgp-sha256; l=635; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=4rXtZPtL5oQZoxxNsOTexNzySBfq8KQl2Tp+f+M43vA=; b=owGbwMvMwCRo6H6F97bub03G02pJDCln5kkab1xX61B1Jthu+6bgxwxmiar+5n8kl59tbr49c 8UyhsS8jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjID1mGBWvDKor1cw1ndDyP CDxgeEVxZsgjB4b5npMZMkOvesVecLFIOr3yQMz8ihsPAQ==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no modules using mm_kobj, so do not export it.

Cc: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mm_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index a1963c3322af..1c9d6f428906 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -154,7 +154,6 @@ early_param("mminit_loglevel", set_mminit_loglevel);
 #endif /* CONFIG_DEBUG_MEMORY_INIT */
 
 struct kobject *mm_kobj;
-EXPORT_SYMBOL_GPL(mm_kobj);
 
 #ifdef CONFIG_SMP
 s32 vm_committed_as_batch = 32;
-- 
2.41.0

