Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C057801261
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379104AbjLASQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLASQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:16:00 -0500
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7A4F9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:16:06 -0800 (PST)
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A6970C0000D4;
        Fri,  1 Dec 2023 10:16:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A6970C0000D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1701454565;
        bh=oOit/4rL2wvddJb+2fxKmDWbNk0f7jYnHz9/Hr/bK+c=;
        h=From:To:Subject:Date:From;
        b=C4tDQY8EKcPwDOkiiufmRVq8/AV+fmjWbbxXz9rWjYHsRquZSCpJtqNOXCJpwi7gO
         /LztMBDdDSpGUScW6K3X0vre14j350zSWmAK2+ukeBiZrMV67+1Jtmx/PwuKpUy0LZ
         GX+49kybcRVrRovdTPAh0ufSlwFx07Hbr/K6F+/8=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 6C42F18728D;
        Fri,  1 Dec 2023 10:16:05 -0800 (PST)
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
Subject: [PATCH 1/1] mtd: rawnand: Add deassert_wp comment
Date:   Fri,  1 Dec 2023 10:15:42 -0800
Message-Id: <20231201181542.421077-1-dregan@broadcom.com>
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

From: Boris Brezillon <bbrezillon@kernel.org>

Add deassert_wp description comment

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: David Regan <dregan@broadcom.com>
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

