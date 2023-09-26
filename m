Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAB67AE79A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjIZIOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjIZIN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:13:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4493126
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:13:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D96C433C8;
        Tue, 26 Sep 2023 08:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695716030;
        bh=Y3Kww83IPJHuqjpVOClGOuciaIoTdLgIMjwrVTvKf5M=;
        h=From:To:Subject:Date:From;
        b=Rn5a+7AspmfXtoTSHXsUAzLzVE3YayWoPPQWyhlOx5inRPFJ7GARtANtPTanzv3ez
         PJFYWbji1Of41+wCUrv2iDqD77AMMP8A/cywW/coreI1znXQub64I5YRG9jHeZdeg2
         BgtYBPbAxeC9Fn3Caab/s3AYdYmS8rTwJZdtZ2TWzDkj8xHXrPPLh53pEa/M2USDu5
         +EksIkmCgaZafY2oynlt9bjgM7i9igGIvGf6vhlWZP6QLrxB+E2T5i0IbtqcTOcXWA
         z3bLxKDJbUbhyzpu/yFffCdnUlFy0mu2WG/Dswz3K0JPxd8UohqXDWnwo9BtxKWRrv
         FKD7PSFRYG3lA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] accel/habanalabs: minor cosmetics update to cpucp_if.h
Date:   Tue, 26 Sep 2023 11:13:37 +0300
Message-Id: <20230926081345.240927-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Update copyright years
- Align comments

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 include/linux/habanalabs/cpucp_if.h | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/linux/habanalabs/cpucp_if.h b/include/linux/habanalabs/cpucp_if.h
index 84d74c4ee4d3..86ea7c63a0d2 100644
--- a/include/linux/habanalabs/cpucp_if.h
+++ b/include/linux/habanalabs/cpucp_if.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2020-2022 HabanaLabs, Ltd.
+ * Copyright 2020-2023 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -668,18 +668,15 @@ enum pq_init_status {
  *       Obsolete.
  *
  * CPUCP_PACKET_GENERIC_PASSTHROUGH -
- *      Generic opcode for all firmware info that is only passed to host
- *      through the LKD, without getting parsed there.
+ *       Generic opcode for all firmware info that is only passed to host
+ *       through the LKD, without getting parsed there.
  *
  * CPUCP_PACKET_ACTIVE_STATUS_SET -
  *       LKD sends FW indication whether device is free or in use, this indication is reported
  *       also to the BMC.
  *
- * CPUCP_PACKET_REGISTER_INTERRUPTS -
- *       Packet to register interrupts indicating LKD is ready to receive events from FW.
- *
  * CPUCP_PACKET_SOFT_RESET -
- *      Packet to perform soft-reset.
+ *       Packet to perform soft-reset.
  *
  * CPUCP_PACKET_INTS_REGISTER -
  *       Packet to inform FW that queues have been established and LKD is ready to receive
@@ -750,9 +747,9 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_RESERVED11,		/* not used */
 	CPUCP_PACKET_RESERVED12,		/* internal */
 	CPUCP_PACKET_RESERVED13,                /* internal */
-	CPUCP_PACKET_SOFT_RESET,                /* internal */
-	CPUCP_PACKET_INTS_REGISTER,             /* internal */
-	CPUCP_PACKET_ID_MAX                     /* must be last */
+	CPUCP_PACKET_SOFT_RESET,		/* internal */
+	CPUCP_PACKET_INTS_REGISTER,		/* internal */
+	CPUCP_PACKET_ID_MAX			/* must be last */
 };
 
 #define CPUCP_PACKET_FENCE_VAL	0xFE8CE7A5
-- 
2.34.1

