Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93A87EC8D2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjKOQjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjKOQj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:39:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B44AB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:39:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B26EC433C9;
        Wed, 15 Nov 2023 16:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700066366;
        bh=O/lr4P1EsL7YBuHracXPErJjSaguLam5N+lR2mNBaRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HloXa8yfi2b8+zalpwQqL7zMe2cDWjk3K16Qu3i1dSW5lnc3nTXjYE+Jeco7gTwPF
         QFdW9p28kq86x5Kf/alAeyE4tW5CzZ5g0XJ4+eDT0wP9whbbzvfw7P6S3oeMpTNOSR
         qnVmmB+ZhRgR7quZL+8hkHs3XAx7EWRmv4cuiuvZfQbhi00Ksw2966oNpDIbGSJT/C
         ndxjkOJZNv0CG0ai5a+kuDri42Gv0KvbyrVmFup51ZvPkKW3dBn17zaViLe4e4X05P
         wvpsBQf3MUThIlbMtFVLIoa6JhkLd/U87bdhY7hvNcvoSiwQnOSSCC6RSV6S7tjzeg
         lFCtprQEDNgww==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 06/10] accel/habanalabs: remove 'get temperature' debug print
Date:   Wed, 15 Nov 2023 18:39:08 +0200
Message-Id: <20231115163912.1243175-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115163912.1243175-1-ogabbay@kernel.org>
References: <20231115163912.1243175-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

The print was added long back for a specific debug and can
now be removed.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/hwmon.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/accel/habanalabs/common/hwmon.c b/drivers/accel/habanalabs/common/hwmon.c
index 8598056216e7..1ee2ee07e9ed 100644
--- a/drivers/accel/habanalabs/common/hwmon.c
+++ b/drivers/accel/habanalabs/common/hwmon.c
@@ -578,10 +578,6 @@ int hl_get_temperature(struct hl_device *hdev,
 				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
-
-	dev_dbg(hdev->dev, "get temp, ctl 0x%x, sensor %d, type %d\n",
-		pkt.ctl, pkt.sensor_index, pkt.type);
-
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 						0, &result);
 
-- 
2.34.1

