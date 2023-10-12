Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35237C7055
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343993AbjJLOat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347301AbjJLOao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:30:44 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C83B8;
        Thu, 12 Oct 2023 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1697121039;
        bh=o1kg+AGvKdB61U4poXd0za0hN5gEmhGNi+P9Mbfn6eg=;
        h=From:Date:Subject:To:Cc:From;
        b=jUQ27btT8YKJCuioIZSEDXbZBsXqxhwNXLkT4ykSVnwwoAF3vdbcJMc5QV3r7x0z2
         YGVeRBw12o2yq+bEyH8DM+KSibg8MQ8FSRK3TOPTpf5G2Kf8uHL1WCQVtxkY71Fnom
         IbnMMzuvb2KSdH1IftvhoBtNf/RJcSlXMyFwZJl0=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 12 Oct 2023 16:30:38 +0200
Subject: [PATCH] const_structs.checkpatch: add xattr_handler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231012-vfs-xattr_const-v1-1-6c21e82d4d5e@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAA0DKGUC/x3MTQqAIBBA4avIrBPU/qCrRITZWLPRcCSE6O5Jy
 2/x3gOMiZBhEg8kvIkphgrdCHCnDQdK2qvBKNNqpY28Pctic06ri4GztH7vlOnVuA0ItboSeir
 /cV7e9wNhjrUJYQAAAA==
To:     Christian Brauner <brauner@kernel.org>
Cc:     Wedson Almeida Filho <walmeida@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697121038; l=904;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=o1kg+AGvKdB61U4poXd0za0hN5gEmhGNi+P9Mbfn6eg=;
 b=AhaVBR9UW982Byqh7WkLNRE4oNV1ZYqKwiBMQtMwWsvezWr6GcNPcEsuQsAsIpdy9cCs2/lif
 zacngGK2pz4ApJDG3AYjtDUo2sJUQTMHJlAMhfnNGIwsPnxHYc21u5C
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the vfs can handle "const struct xattr_handler" make sure that
new usages of the struct already enter the tree as const.

Link: https://lore.kernel.org/lkml/20230930050033.41174-1-wedsonaf@gmail.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
This should be applied on top of the vfs.xattr branch of the vfs tree.
---
 scripts/const_structs.checkpatch | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index dc39d938ea77..188412aa2757 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -94,3 +94,4 @@ vm_operations_struct
 wacom_features
 watchdog_ops
 wd_ops
+xattr_handler

---
base-commit: 295d3c441226d004d1ed59c4fcf62d5dba18d9e1
change-id: 20231012-vfs-xattr_const-afd402507b6e

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

