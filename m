Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D6B7D1DCE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjJUPIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjJUPIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:08:39 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 Oct 2023 08:08:34 PDT
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B3DE3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:08:34 -0700 (PDT)
Received: from Vostro-3710.lan (unknown [58.61.140.248])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 3D042800015;
        Sat, 21 Oct 2023 23:02:16 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] mtd: rawnand: add support for TH58NYG3S0HBAI4 NAND flash
Date:   Sat, 21 Oct 2023 23:02:12 +0800
Message-Id: <20231021150212.20509-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGE5LVk8ZGExJHRgZGEIfHlUTARMWGhIXJBQOD1
        lXWRgSC1lBWU5DVU1KVUpPS1VJT0NZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a8b52c2226db03akuuu3d042800015
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PSo6KSo*IjwxGEM1HzNICzgU
        DiEwCQtVSlVKTUJMQktLTkhNQk9IVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VU1KVUpPS1VJT0NZV1kIAVlBSkJCSDcG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Toshiba TH58NYG3S0HBAI4 is detected with 128 byte OOB while the flash
has 256 bytes OOB. This adds a static NAND ID entry to correct this.

Tested on Arcadyan AW1000 flashed with OpenWrt.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 drivers/mtd/nand/raw/nand_ids.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index 650351c62af6..2b871dfd1d09 100644
--- a/drivers/mtd/nand/raw/nand_ids.c
+++ b/drivers/mtd/nand/raw/nand_ids.c
@@ -58,6 +58,9 @@ struct nand_flash_dev nand_flash_ids[] = {
 		{ .id = {0xad, 0xde, 0x14, 0xa7, 0x42, 0x4a} },
 		  SZ_16K, SZ_8K, SZ_4M, NAND_NEED_SCRAMBLING, 6, 1664,
 		  NAND_ECC_INFO(40, SZ_1K) },
+	{"TH58NYG3S0HBAI4 8G 1.8V 8-bit",
+		{ .id = {0x98, 0xa3, 0x91, 0x26, 0x76} },
+		  SZ_4K, SZ_1K, SZ_256K, 0, 4, 256, NAND_ECC_INFO(8, SZ_512) },
 	{"TH58NVG2S3HBAI4 4G 3.3V 8-bit",
 		{ .id = {0x98, 0xdc, 0x91, 0x15, 0x76} },
 		  SZ_2K, SZ_512, SZ_128K, 0, 5, 128, NAND_ECC_INFO(8, SZ_512) },
-- 
2.25.1

