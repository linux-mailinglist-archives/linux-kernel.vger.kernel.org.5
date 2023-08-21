Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C6C782143
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjHUBzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjHUBzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:55:44 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6055C9C;
        Sun, 20 Aug 2023 18:55:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vq9G.uy_1692582938;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vq9G.uy_1692582938)
          by smtp.aliyun-inc.com;
          Mon, 21 Aug 2023 09:55:39 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, shannon.nelson@amd.com, brett.creeley@amd.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH net-next] pds_core: Fix some kernel-doc comments
Date:   Mon, 21 Aug 2023 09:55:37 +0800
Message-Id: <20230821015537.116268-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some kernel-doc comments to silence the warnings:

drivers/net/ethernet/amd/pds_core/auxbus.c:18: warning: Function parameter or member 'pf' not described in 'pds_client_register'
drivers/net/ethernet/amd/pds_core/auxbus.c:18: warning: Excess function parameter 'pf_pdev' description in 'pds_client_register'
drivers/net/ethernet/amd/pds_core/auxbus.c:58: warning: Function parameter or member 'pf' not described in 'pds_client_unregister'
drivers/net/ethernet/amd/pds_core/auxbus.c:58: warning: Excess function parameter 'pf_pdev' description in 'pds_client_unregister'

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 8ff21d36ea42..e0d4b8d5159f 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -8,7 +8,7 @@
 
 /**
  * pds_client_register - Link the client to the firmware
- * @pf_pdev:	ptr to the PF driver struct
+ * @pf:	a pointer to the pdsc structure
  * @devname:	name that includes service into, e.g. pds_core.vDPA
  *
  * Return: positive client ID (ci) on success, or
@@ -48,7 +48,7 @@ EXPORT_SYMBOL_GPL(pds_client_register);
 
 /**
  * pds_client_unregister - Unlink the client from the firmware
- * @pf_pdev:	ptr to the PF driver struct
+ * @pf:	a pointer to the pdsc structure
  * @client_id:	id returned from pds_client_register()
  *
  * Return: 0 on success, or
-- 
2.20.1.7.g153144c

