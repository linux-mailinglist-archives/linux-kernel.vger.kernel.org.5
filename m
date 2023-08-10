Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582E9777A69
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbjHJOUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbjHJOUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:20:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35737273E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBEEC65D8A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C10FC433C9;
        Thu, 10 Aug 2023 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691677239;
        bh=8zFFozZqwHjDHxSeDLIPA6Rg04SxjAKI0J794c4W9/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rR+PmONwXVxISTA+O63YKwhBGOYwh5OPz78zISGZDuab6xF6eHSAL+F22MIYdArvw
         qQoV2aV6XaSBVR9iUw1QknspPIZwgFMTWLwnhA7+maILnEQA+61h3WbCHR6FZs+9Xs
         uQH2kl7R/Mfh7MQZR41pvdCq9cUQo1CAW3GR21jXjlomutG5k4mob8wvd8ocSxHlPy
         ZWonHu6Ad3ixk1TvPTohlX8sGNP2Wh7z8wVwdSQVfbq0iBAZJQ22yMmAoweeck07X9
         Id/vADSfk5+cI90SFFFLkutV43A4bCkouEvAdsF4oO4dMpUPKHsmVOv62c1BY+byQY
         fmeA/4lyT4a8A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 01/17] [RESEND] jffs2: mark __jffs2_dbg_superblock_counts() static
Date:   Thu, 10 Aug 2023 16:19:19 +0200
Message-Id: <20230810141947.1236730-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This function is only called locally and does not need to be
global. Since there is no external prototype, gcc warns about
the non-static definition:

fs/jffs2/debug.c:160:6: error: no previous prototype for '__jffs2_dbg_superblock_counts' [-Werror=missing-prototypes]

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/jffs2/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jffs2/debug.c b/fs/jffs2/debug.c
index 9d26b1b9fc014..0925caab23c4b 100644
--- a/fs/jffs2/debug.c
+++ b/fs/jffs2/debug.c
@@ -157,7 +157,7 @@ __jffs2_dbg_prewrite_paranoia_check(struct jffs2_sb_info *c,
 	kfree(buf);
 }
 
-void __jffs2_dbg_superblock_counts(struct jffs2_sb_info *c)
+static void __jffs2_dbg_superblock_counts(struct jffs2_sb_info *c)
 {
 	struct jffs2_eraseblock *jeb;
 	uint32_t free = 0, dirty = 0, used = 0, wasted = 0,
-- 
2.39.2

