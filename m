Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D3280079B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378039AbjLAJ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377899AbjLAJ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:56:07 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A476910D7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:56:13 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b595bf5d2so15002755e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 01:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701424572; x=1702029372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=imgzYGiqQhIIN9pgZ0mud47x5443YmKclZtZpKeB2ec=;
        b=GGFpYQ25N72u8lCbtYsLxrIiSTXFWvgnp4ewKQNg1p+Z8/II5IcafVWofDjrRRr3cY
         Cr0aaKGYvro+psN8Hfw9LeUOPWPHHXTo6Hm+l8zel77Da8EobdIPPSAmDzH6qiAbhRim
         8kU2r4cNKkCIJbOd8ZfuL/0dRiDOg695Unz0s9NwVGTgOrtv1f/wHOiG9Ktl9TQwv7ma
         N1LcHn/sf1UjHuowtq7Q1Px3qbMZHOzKVHQxI7ZrfSxREuhlQxnTY2qMCPUXlL95v7Kg
         iAtWJUPplgnxCJZFJ8LcdU/kUHlIctcnPSkxNqhFjylDprJDGhWnXJBHtcx1uX/UifbC
         2iuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424572; x=1702029372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imgzYGiqQhIIN9pgZ0mud47x5443YmKclZtZpKeB2ec=;
        b=siVFULy3yYrI4IIbakbHmXDHmHk4u8LlAD/buWUcr6v78qEYk30oGgwFvU7MckjD3b
         DeXqI0iUb3Xd3OmCcWytOrH+gOkHr0jcAPerpF0NCI2O+96q/31G7PO2bvYAgaTeYoVl
         e16TVzs6VcEeONQBgYMPPhzrTXHKO4L1hjT6NShWbLUmIYahap+prkMTFwWGehS1b0wr
         GxUhMa32oIEwdsi23kxuH5ypx7Z0who4Vj3WAWtygK63yXoyzV+U6tR0kgVHyoB62tLi
         IBBOHJ2PNE6FboQc/zSATVzbJI28UgzVW5qDMQbSq6wAuZZPl57zztATLgr6pHcO7MH5
         6lLA==
X-Gm-Message-State: AOJu0YwY3Wa9LrxUFnI6UDMAkrkW/Y++wdaLKmXCVbInXkDMUk2HUx8n
        Yr5c46GNMN2m0AkUv4fPQqcdew==
X-Google-Smtp-Source: AGHT+IFnbhz99eZMpManLr6PpXpUYiNXssmncvB7WIe5Pd7fQ9Q9gc+blj35njaOP99Xp0fGTyYNEQ==
X-Received: by 2002:a05:600c:1f91:b0:40b:5433:17ef with SMTP id je17-20020a05600c1f9100b0040b543317efmr196223wmb.30.1701424572074;
        Fri, 01 Dec 2023 01:56:12 -0800 (PST)
Received: from trax.. (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id h7-20020adf9cc7000000b0032d8eecf901sm3802982wre.3.2023.12.01.01.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:56:11 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, ulf.hansson@linaro.org,
        linus.walleij@linaro.org
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCHv2] mmc: rpmb: fixes pause retune on all RPMB partitions.
Date:   Fri,  1 Dec 2023 10:56:08 +0100
Message-Id: <20231201095608.1022191-1-jorge@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RPMB was converted to a character device, it added support for
multiple RPMB partitions (Commit 97548575bef3 ("mmc: block: Convert RPMB
to a character device").

One of the changes in this commit was transforming the variable
target_part defined in __mmc_blk_ioctl_cmd into a bitmask.

This inadvertedly regressed the validation check done in
mmc_blk_part_switch_pre() and mmc_blk_part_switch_post().

This commit fixes that regression.

Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
---
 drivers/mmc/core/block.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 152dfe593c43..13093d26bf81 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -851,9 +851,10 @@ static const struct block_device_operations mmc_bdops = {
 static int mmc_blk_part_switch_pre(struct mmc_card *card,
 				   unsigned int part_type)
 {
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;

-	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+	if ((part_type & mask) == mask) {
 		if (card->ext_csd.cmdq_en) {
 			ret = mmc_cmdq_disable(card);
 			if (ret)
@@ -868,9 +869,10 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
 static int mmc_blk_part_switch_post(struct mmc_card *card,
 				    unsigned int part_type)
 {
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;

-	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+	if ((part_type & mask) == mask) {
 		mmc_retune_unpause(card->host);
 		if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
 			ret = mmc_cmdq_enable(card);
@@ -3143,4 +3145,3 @@ module_exit(mmc_blk_exit);

 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
-
--
2.34.1
