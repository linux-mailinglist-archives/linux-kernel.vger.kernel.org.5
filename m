Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076B8785659
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjHWK7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjHWK7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:59:07 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA7919A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:59:03 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id B5B2C120009;
        Wed, 23 Aug 2023 13:58:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B5B2C120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1692788339;
        bh=Jhlhui1u6bMKkD+jQX9ubOwaBqanSrcPAZGkwyaedVA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=l9vqnGDPIf9enBfApcY6Q4z3ebwBXMuV9Ag6KmVWaQUUgXPudmK6VBRy2ioA5CtER
         EnVCZYJbju4bXGvHUO7fUBYPMe4aoTrn7rzVWBlHkJ/SCN9RNyZzvkg8VRW0U6ZmlY
         rE+vFiMOB8lXHIqkf4FZeoX4nYY9qma/gWU3q1F3Jvhu+iIjvDc22aa1stOy/W1zsc
         g88IUqd3iuJUvWlO8hgQQMycg3ZurEoOSj/ZCxEdW1QymCXu5P0aqgToFhfEPmeSUG
         lzsBNFq6VmYRq1LOqsiBYEONxyxe6JMCxU/p+AkMAbRFeD6XvToG7OD1+F4v3zjcCB
         DBgrXK9wW2fgA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 23 Aug 2023 13:58:59 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 23 Aug 2023 13:58:52 +0300
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Johan Jonker <jbx6244@gmail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] mtd: rawnand: remove 'nand_exit_status_op()' prototype
Date:   Wed, 23 Aug 2023 13:52:31 +0300
Message-ID: <20230823105235.609069-1-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179398 [Aug 23 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 527 527 5bb611be2ca2baa31d984ccbf4ef4415504fc308, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;sberdevices.ru:5.0.1,7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/08/23 04:58:00 #21681850
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is exported and its prototype is already placed in
include/linux/mtd/rawnand.h.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/internals.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
index e9932da18bdd..b7162ced9efa 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -106,7 +106,6 @@ int nand_read_page_raw_notsupp(struct nand_chip *chip, u8 *buf,
 			       int oob_required, int page);
 int nand_write_page_raw_notsupp(struct nand_chip *chip, const u8 *buf,
 				int oob_required, int page);
-int nand_exit_status_op(struct nand_chip *chip);
 int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
 			    unsigned int len);
 void nand_decode_ext_id(struct nand_chip *chip);
-- 
2.35.0

