Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F008007DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378117AbjLAKFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377899AbjLAKF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:05:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8638B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 02:05:32 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bd4fcbde1so1467061e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 02:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701425131; x=1702029931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PuneSa6QbCM1xtUYW7Y3DXlGntPa6QFO347mlxKnDHE=;
        b=mV+fZd7+zK2uX+BR4m4jbMbpjEIac7cKxeMSkaQIQAmPXyxw+3ynzdSHX5nBFO/gnO
         v7L4Mx87wyeO/694fz3kjTPokAzq6zl5Cd1VBqR0razRUH3kvDh2+DF9b+8410VUJDXS
         9GcD+KMWZXAdOWQOkvKfZLFAUa+rCN3qdxiryKa72Xx4BtwkOpMguPgR98ICwPhhjgTc
         yUbjCvg08iZkDoAS9kaAIiPSNLMDriAuSyJb0lCjUEfFoTcNMVj2J0xnUmMp2G8DR/ZF
         hrA26VgsuzKFCZGuYPcgBIwwrb6DgRy1NUUY72RKc4PVfLYmigDl1boNzQtw1cmyQTUd
         0CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701425131; x=1702029931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuneSa6QbCM1xtUYW7Y3DXlGntPa6QFO347mlxKnDHE=;
        b=qckNDMSfagiTrVQAVUTAKyufUqbXY0OG4TUSHn/d2PKSbEj8U5810ktZ9BV/1e+nKo
         tlpfmCpQFGi525qmLRqA4k6k3spKeg6VdNnghDafo0KGu7Bt5qDnqxgxJUwEq//3Oiby
         gRwlSX+FVTDqD5XWwL+Cx3iKaIYgxMgsd2qjZUsR+1+DYsLyGUB04+ZKQw9YVLVBH4st
         P0PBMfGwQtZZYGKGqspeaGAo1fQ5duSAT0Ah/kMK5J19IcGoBcbOy7EGok9R3tjyPQE/
         0ScubKD2qYOeGysezZgdK9IE3yDcUPcWsHPa+T8ykslROLBc0Aty7MBAXdoQjnB1v/eE
         cisw==
X-Gm-Message-State: AOJu0YxJZp2DyZuq4CrT1enVtLr5y+fFgm3eUIFgdqALxIrc26AGUCjp
        G9eosiUboJ0XoRQLINE+AbBKzCd9ON7idivtwrw=
X-Google-Smtp-Source: AGHT+IH0TZ6Fc+ufC5XzTglSQ2dJ28+duooe+E9bpakim9bcU2KfLk/n/0AW7+kUcOs3PCtFnOcHUA==
X-Received: by 2002:ac2:5967:0:b0:50b:d764:8023 with SMTP id h7-20020ac25967000000b0050bd7648023mr539062lfp.86.1701425130583;
        Fri, 01 Dec 2023 02:05:30 -0800 (PST)
Received: from trax.. (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c459000b00406408dc788sm8519199wmo.44.2023.12.01.02.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 02:05:30 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCHv3] mmc: rpmb: fixes pause retune on all RPMB partitions.
Date:   Fri,  1 Dec 2023 11:05:27 +0100
Message-Id: <20231201100527.1034292-1-jorge@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Cc: <stable@vger.kernel.org> # v6.0+
---

  v2:
     fixes parenthesis around condition
  v3:
     adds stable to commit header

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
