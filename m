Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5884F754787
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 10:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjGOIkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 04:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGOIkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 04:40:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45EC1FC4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 01:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3830C60AF9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40A9C433C7;
        Sat, 15 Jul 2023 08:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689410451;
        bh=TJL+zJ7QowC3i6IUIxc6eZfypK8OXu9f9+wS0ChYhF4=;
        h=From:To:Cc:Subject:Date:From;
        b=AkZkMp6kdcQ8YG89P3kDN//PJ0xV+eesGObCKNTdbgLHjZaLjc39La9gfe2fes2vl
         iATPoAcRWzABcBr1JkBCek74n/mzv0PaNKDbvSgY+FAB5fu945ErdOv8+01k1yzcAQ
         wq532h1I3d9u/rrfU0YwJPGSFE2I0sPdfE8dQXJtcYOtaoRenRnlZS+4nhCGuxVQBw
         9X8nFvs0Brm3aLHS9p81Ql0UQcX6y5mTch9QYtHTHL0MgufwwHUY4zX+HsR8RIhk0S
         9tr14z5UOkxQFyOeItJ3hmjokhFBv4aVu9WBiC3L6fwmIAevRkZ+jDL4Pm6JWLC1Yb
         leMqnVbDk7x+w==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] maple_tree: mtree_insert: fix typo in kernel-doc description of GFP flags
Date:   Sat, 15 Jul 2023 11:40:38 +0300
Message-Id: <20230715084038.987955-1-rppt@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Replace FGP_FLAGS with GFP_FLAGS

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8ebc43d4cc8c..92da9c27fbd9 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6339,7 +6339,7 @@ EXPORT_SYMBOL(mtree_insert_range);
  * @mt: The maple tree
  * @index : The index to store the value
  * @entry: The entry to store
- * @gfp: The FGP_FLAGS to use for allocations.
+ * @gfp: The GFP_FLAGS to use for allocations.
  *
  * Return: 0 on success, -EEXISTS if the range is occupied, -EINVAL on invalid
  * request, -ENOMEM if memory could not be allocated.
-- 
2.39.2

