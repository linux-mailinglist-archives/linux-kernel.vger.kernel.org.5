Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84E57AE79C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjIZIOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjIZIN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:13:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A49911D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:13:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3F2C433CA;
        Tue, 26 Sep 2023 08:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695716033;
        bh=0F0SAeCjM5+ld4tRE0MEkHClEX9ddoIr9GAust7RuEI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qMBDN/Frng2txPZQ96POwkshymQNiZsiNL/eiH2V5nCId37TqlVHUn8Pz3FI+2QxK
         yEU9NXTNJ7VVU+kC49pJ+WQamz0dNHC5CG8xES4R5cHkf+1joqbnX6maskCaWQ4kpg
         A+X88CJaEs6Vpb7wY21nTcOxBICBupwTmcTx99seieegPJY+/WZsST2ghVu9VUP8q9
         pEHGzY0il/8ZfYJjXjaL7UJehwT2lfpglLJbbKRicoAAgpQhMZESqnCa+wIERQKk8Z
         SReIxHFAKaoIFp9mLh7QiE0277sHkQojACm16MdLw3CCw+RJQ2ane+ve+mjd4RcH2O
         1v1zneVVX/Ztg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] accel/habanalabs: change Greco to Gaudi2
Date:   Tue, 26 Sep 2023 11:13:39 +0300
Message-Id: <20230926081345.240927-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926081345.240927-1-ogabbay@kernel.org>
References: <20230926081345.240927-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greco was not upstreamed so no point of mentioning it here.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 include/uapi/drm/habanalabs_accel.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/uapi/drm/habanalabs_accel.h b/include/uapi/drm/habanalabs_accel.h
index dfe47db24ae6..347c7b62e60e 100644
--- a/include/uapi/drm/habanalabs_accel.h
+++ b/include/uapi/drm/habanalabs_accel.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
  *
- * Copyright 2016-2022 HabanaLabs, Ltd.
+ * Copyright 2016-2023 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -885,11 +885,11 @@ enum hl_server_type {
  * @dram_enabled: Whether the DRAM is enabled.
  * @security_enabled: Whether security is enabled on device.
  * @mme_master_slave_mode: Indicate whether the MME is working in master/slave
- *                         configuration. Relevant for Greco and later.
+ *                         configuration. Relevant for Gaudi2 and later.
  * @cpucp_version: The CPUCP f/w version.
  * @card_name: The card name as passed by the f/w.
  * @tpc_enabled_mask_ext: Bit-mask that represents which TPCs are enabled.
- *                        Relevant for Greco and later.
+ *                        Relevant for Gaudi2 and later.
  * @dram_page_size: The DRAM physical page size.
  * @edma_enabled_mask: Bit-mask that represents which EDMAs are enabled.
  *                     Relevant for Gaudi2 and later.
@@ -1425,7 +1425,7 @@ union hl_cb_args {
  *
  * HL_CS_CHUNK_FLAGS_USER_ALLOC_CB:
  *      Indicates if the CB was allocated and mapped by userspace
- *      (relevant to greco and above). User allocated CB is a command buffer,
+ *      (relevant to Gaudi2 and later). User allocated CB is a command buffer,
  *      allocated by the user, via malloc (or similar). After allocating the
  *      CB, the user invokes - “memory ioctl” to map the user memory into a
  *      device virtual address. The user provides this address via the
@@ -1450,7 +1450,7 @@ struct hl_cs_chunk {
 		 * a DRAM address of the internal CB. In Gaudi, this might also
 		 * represent a mapped host address of the CB.
 		 *
-		 * Greco onwards:
+		 * Gaudi2 onwards:
 		 * For H/W queue, this represents either a Handle of CB on the
 		 * Host, or an SRAM, a DRAM, or a mapped host address of the CB.
 		 *
@@ -2227,7 +2227,7 @@ struct hl_debug_args {
  * internal. The driver will get completion notifications from the device only
  * on JOBS which are enqueued in the external queues.
  *
- * Greco onwards:
+ * Gaudi2 onwards:
  * There is a single type of queue for all types of engines, either DMA engines
  * for transfers from/to the host or inside the device, or compute engines.
  * The driver will get completion notifications from the device for all queues.
-- 
2.34.1

