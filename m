Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17693800FA0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379454AbjLAPbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379398AbjLAPbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:31:44 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D2619E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:31:48 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b595bf5d2so18439265e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701444706; x=1702049506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zrDqyx6agu66CFsaEwAwGPFt5h6we10bOzm7YE4XX+0=;
        b=gxNGJ2jeuQGtb1QsJNITbFf+iT3QGZAmiMpR9SqfX5Wr7+Jcb5dSpHE/2YFUv5+ikx
         3AJAVFGpuDmiSPIWSNkDWF39estfYTg9jwGvy1OZDDbqOXIwqZA7fnWMhFmxyYqTE+W/
         XCmSvwEYH6oZWB4uZb1rXLmgXAV8++KVLMdoyTOCUXcFdwwhWP3K1hii3yWZl1Q9EGjf
         rLUiwwYCPW6Om2jfV0iZE29/tSBoeyR7PGRFpeLjdA8arORSBrdCyShfCBC4T821UYQ0
         RS3ZHP9VFFwFPbRyQK8+75CCqubs1deteehyrhSSo3mlxRx0/KSnY1/e8wGABSBdTBwj
         AOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444706; x=1702049506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrDqyx6agu66CFsaEwAwGPFt5h6we10bOzm7YE4XX+0=;
        b=wVF4HGUaTFx2F6E2zFyHWfHj+HDGGN8VWF3cO3Su+F0SQkhYOgS7DBIEkjvhGDN1JF
         srP8U84baKfBxR45xX5QGSTOv3yb0Webc46df17PKG5/zMUIufMIonwosTn8FqvSdvS6
         K8EEbiUFvMhpnnzvKK2teMLYOhxkHM1+HnlX3z3jvLY6OR4WHaqeJIn6zZHpSrytGzbV
         uYXeopULSTyN7KC8NIFEcAz8DgOPyKmFM9/c/X64IXxp+5FBYioapoW8nHIJEDVLzP76
         T1AFSrhLT/27JmSb9XkR736UXIPMFHRmrcZsB+eW2WRZGrdNg94+FPbSjXiVLMLvVUJF
         vXNA==
X-Gm-Message-State: AOJu0Yxh5f5WVzR9KWQPdYwsWw1o1NjM1V96M7DWPC28ANrht1udjFIC
        YwbKuWf4D948L4iuIJfdsuPF6g==
X-Google-Smtp-Source: AGHT+IF4yZefDhQfkn3bHpMubMuak5XxvCL7T38seWdW+e8Eg9jNLWcrCT1ET5ZnEZ3m4aGk9V5qkA==
X-Received: by 2002:a05:600c:468f:b0:40b:5e59:99ca with SMTP id p15-20020a05600c468f00b0040b5e5999camr346457wmo.234.1701444706433;
        Fri, 01 Dec 2023 07:31:46 -0800 (PST)
Received: from trax.. (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id l5-20020adffe85000000b0033331b248acsm1771415wrr.91.2023.12.01.07.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:31:45 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCHv4] mmc: rpmb: fixes pause retune on all RPMB partitions.
Date:   Fri,  1 Dec 2023 16:31:43 +0100
Message-Id: <20231201153143.1449753-1-jorge@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: <stable@vger.kernel.org> # v4.14+
---

  v2:
     fixes parenthesis around condition
  v3:
     adds stable to commit header
  v4:
     fixes the stable version to v4.14
     adds Reviewed-by

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
