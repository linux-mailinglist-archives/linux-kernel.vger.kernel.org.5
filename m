Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF47B1706
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjI1JUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI1JUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:20:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A38C8E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:20:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DB0C433C8;
        Thu, 28 Sep 2023 09:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695892801;
        bh=9e29ZnhPKlU/RRKb54lBCqFLUcPtDveR1H2fkbEg0Mw=;
        h=From:To:Cc:Subject:Date:From;
        b=sxZosAONQP0lCPkBzlF1Si/T9gAVuSwvT2UYa38Fr4lHYbVjJMOBuN42Xnqcb2Zid
         23LGgKhjtUoqQR/9vWtPpCdnOicoNQSC/VfEe9s4BLtow8WcrPtbOD129Y1xgENvuw
         WNpdabr3e1tz5Xxb1j4m9Fwyx1wRr81EOBQpmyasDe4m8LBov2r19m1lZWInqqRSw+
         PKtq7XBjf0i3syZQ9PysfLeFP+QArk+Trdgg02++goSRXbKSXWSDMq8JeaAUM3juWD
         p9LxjVJzxMPNyvj2Nww2lkeYMd0j7N1hfKkH2WPcGzLfB+RvR7ODzjCGRWVIf75Z0h
         YDSWEE6sXZKOQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 1/3] accel/habanalabs: remove wrong doc for init_phys_pg_pack_from_userptr
Date:   Thu, 28 Sep 2023 12:19:54 +0300
Message-Id: <20230928091956.47762-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
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

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

The function does not pin the pages so remove that from the inline doc.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/memory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/memory.c b/drivers/accel/habanalabs/common/memory.c
index ba59e921236e..0b8689fe0b64 100644
--- a/drivers/accel/habanalabs/common/memory.c
+++ b/drivers/accel/habanalabs/common/memory.c
@@ -832,7 +832,6 @@ int hl_unreserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
  *                      physical pages
  *
  * This function does the following:
- * - Pin the physical pages related to the given virtual block.
  * - Create a physical page pack from the physical pages related to the given
  *   virtual block.
  */
-- 
2.34.1

