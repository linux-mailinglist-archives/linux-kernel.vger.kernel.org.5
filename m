Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A525801549
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379657AbjLAVYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAVYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:24:48 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvacalvio01.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA5310D0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 13:24:53 -0800 (PST)
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1F4DFC0026F7;
        Fri,  1 Dec 2023 13:24:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1F4DFC0026F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1701465893;
        bh=vrVkTfIsWsT8Eahag1TdS0Wt98iSbiCsHD0P4PcYheg=;
        h=From:To:Subject:Date:From;
        b=mfy+ovjXTbcYsnjF66uv7gotQKR7IeIFXWg/HwaDebtRzMYRl1lnXxxBPBje7HyOE
         5zLANU4AhEk2UeCoRsHkASAjSzGDWVtv0vKzGPu5VY1ebpHkR5uwGVujV62kLXBrGP
         RptI+77X8FoexGaX4hndVzSFkXMfTNSoMeohJxbk=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 0F1F318728D;
        Fri,  1 Dec 2023 13:24:53 -0800 (PST)
From:   dregan <dregan@broadcom.com>
To:     dregan <dregan@broadcom.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH v2 1/1] mtd: rawnand: Add deassert_wp comment
Date:   Fri,  1 Dec 2023 13:24:46 -0800
Message-Id: <20231201212446.189491-1-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Regan <dregan@broadcom.com>

Add deassert_wp description comment

Signed-off-by: David Regan <dregan@broadcom.com>
---
Changes in v2: removed Boris Brezillon as author and SOB
---
 include/linux/mtd/rawnand.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index fcad94aa0515..3049b05d8a20 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1001,6 +1001,8 @@ struct nand_op_parser {
 /**
  * struct nand_operation - NAND operation descriptor
  * @cs: the CS line to select for this NAND operation
+ * @deassert_wp: set to true when the operation requires the WP pin to be
+ *		 de-asserted (ERASE, PROG, ...)
  * @instrs: array of instructions to execute
  * @ninstrs: length of the @instrs array
  *
-- 
2.37.3

