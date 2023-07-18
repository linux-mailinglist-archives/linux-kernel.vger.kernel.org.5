Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1611A757705
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjGRIsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjGRIsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:48:14 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBDBF7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:48:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fdb3f66fd6so4598251e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689670090; x=1692262090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKQrnAAXrxm+V/7/n+4Qloa2USS24OYRqHFta7qvgAQ=;
        b=AeVsisMeDdKDMuBy4M5Ao2mQiTv19RMdqCBe8cETcF3jf7dsgpNOWeHswgA5cAJXuA
         n0lCzW9TLN7VFYDPpK0/ghORSyAZpNKOMAaPri84J9v6cpns3G0n+W2MToiOZc7lQR+G
         AqlqA8fx3uZJShWIFkzAYUhM7qISpYN2mfqjgpBm6NyxUKfai5rpGcip/aX7BAUm6bdf
         1Y1HeLl6CJyRJvoOBLI5RdZ6zgv3TuOFyZghIMH4atj3W7ZgH63MnoByoApnTrFSqcJT
         zhe/DXazrYsDJxRSr19dFQFpwRW0ANPsRulC3HIjfYjdTaW0tnK5dPfJ1wC4Wn3kVYyD
         0prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689670090; x=1692262090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKQrnAAXrxm+V/7/n+4Qloa2USS24OYRqHFta7qvgAQ=;
        b=A3RvBTJ02ePsAuOXlWfhIedNQMK1+riDozNEiz+z9twUSzykLHA7fcMQGh9rJ7yDs7
         5II56I4oH+LfKm9jT3wJxXhLYBXrsphuY3+fESA5nGPpt/6nybt4jYtEiS05/n/+6UGT
         ge/AAnubMBT1Al1EiNR/rjAvNRLCovaZt341yUK6h96dXE51DVAS3acgAhqUYKky32Ld
         9Fo3j6hD42K9GRRdBJP/k6XLqPmoUCMVA21Lw8U/191TR26JJVavXrj/ZoXB2n0SrMxH
         tTh11VBs1H8eCzODVcJa7//fJukTc0pJo4JvpFz0NBC3r8Qa+o2BDOI+7DWs9usTbsje
         RXNw==
X-Gm-Message-State: ABy/qLb/3xP3ZRlIHcTrV/K+dIskLLsHEg2q2Q2kRd3/TYG4zYWx8Y+f
        IoWOL0hs5DisUMnyw2sg5WY=
X-Google-Smtp-Source: APBJJlGLMz1ucd/cArxQa8D7T8E7JyE0jbBpbHOfVBFkSY3iVue31sdUVun4qUGBLZL/AtmlKuRdCg==
X-Received: by 2002:a05:6512:3b0a:b0:4fb:9595:15e9 with SMTP id f10-20020a0565123b0a00b004fb959515e9mr11844227lfv.22.1689670090272;
        Tue, 18 Jul 2023 01:48:10 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id m15-20020a056512014f00b004fb85ffc82csm340944lfo.10.2023.07.18.01.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 01:48:09 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alban Bedel <albeu@free.fr>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] Revert "nvmem: add new config option"
Date:   Tue, 18 Jul 2023 10:48:04 +0200
Message-Id: <20230718084804.20139-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This reverts commit 517f14d9cf3533d5ab4fded195ab6f80a92e378f.

It seems that "no_of_node" config option was added to help mtd's case.

DT nodes of MTD partitions (that are also NVMEM devices) may contain
subnodes that SHOULD NOT be treated as NVMEM fixed cells. To prevent
NVMEM core code from parsing them "no_of_node" was set to true and that
made for_each_child_of_node() in NVMEM a no-op.

With the introduction of "add_legacy_fixed_of_cells" config option
things got more explicit. MTD subsystem simply tells NVMEM when to look
for fixed cells and there is no need to hack "of_node" pointer anymore.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
Important: this is based on top of the
[PATCH V4] nvmem: add explicit config option to read old syntax fixed OF cells
---
 drivers/mtd/mtdcore.c          | 1 -
 drivers/nvmem/core.c           | 2 +-
 include/linux/nvmem-provider.h | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 9db8d7853639..3d781ffb8c32 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -554,7 +554,6 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	config.read_only = true;
 	config.root_only = true;
 	config.ignore_wp = true;
-	config.no_of_node = !of_device_is_compatible(node, "nvmem-cells");
 	config.priv = mtd;
 
 	mtd->nvmem = nvmem_register(&config);
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 58d8919e6682..a0c9153cda28 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1027,7 +1027,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->nkeepout = config->nkeepout;
 	if (config->of_node)
 		nvmem->dev.of_node = config->of_node;
-	else if (!config->no_of_node)
+	else
 		nvmem->dev.of_node = config->dev->of_node;
 
 	switch (config->id) {
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 1b81adebdb8b..e3930835235b 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -89,7 +89,6 @@ struct nvmem_cell_info {
  * @read_only:	Device is read-only.
  * @root_only:	Device is accessibly to root only.
  * @of_node:	If given, this will be used instead of the parent's of_node.
- * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
  * @reg_read:	Callback to read data.
  * @reg_write:	Callback to write data.
  * @size:	Device size.
@@ -122,7 +121,6 @@ struct nvmem_config {
 	bool			ignore_wp;
 	struct nvmem_layout	*layout;
 	struct device_node	*of_node;
-	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
 	int	size;
-- 
2.35.3

