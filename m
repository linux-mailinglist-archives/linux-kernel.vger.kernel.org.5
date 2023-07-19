Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0743F759322
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjGSKeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjGSKd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:33:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF7A18D;
        Wed, 19 Jul 2023 03:33:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so67087965e9.3;
        Wed, 19 Jul 2023 03:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689762836; x=1692354836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VXj5YGAc3yTaYjQDt+pu+QsTbsvPJHMLueGYcTvQb+0=;
        b=DjurqgxKYZebo4JylN2vIh/fMENaVlf3jotRX8Jg7yXtW/SC4/fmqteKIL5pUDwRT6
         qUiuO9hCCAo7SZpXqJZT6QWZq3rQCFFm3GzgMJkWYYta4tF8BK+NExIKw3RHwNbzV0m4
         aimjZNFIJBteaTAmumlMqFjcDuXPnqDCrRMRFhvKB9DuPSZm5PgGuqGL88ly5WXcSGZO
         u2+zqv2maZfybRpyWkYBTHdEId0lrMrpeG4Hq2SMkCibTL1VcBaE/SMzkFVxZ3cmYEJB
         BKdiLAYb4dt6xD2czd8Gd2uBS0tjfiTZSA2u+5SupPo2nhYUOmkBVvcnvkeKjbt1wX/M
         T3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689762836; x=1692354836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXj5YGAc3yTaYjQDt+pu+QsTbsvPJHMLueGYcTvQb+0=;
        b=gv29pkW9+lno6YiJNecGHrsrNNfRSqBBnkNw0C6K+8KXV/sTWj829d175nmuGHIyE8
         DOpiTV9zxkJG5230nYMkZjk2nuP4pqVj8R1HhG4PaPEZBwc2k8ZDDi8ILuSjO+LKf7Sl
         uGNcdJj3RSn4eZsOGDtA1o7rMGcThol/qnq90FOvxFi2VcBY4XObE5lS/BU8cSJjs6iT
         0pHW3JTOZS7/bkjcA+SxM4CymsIbTUCVndwqR/b8I3e9jaQYd7a+k0CCtwdhXoHV4Rne
         9ifm3dN6XXyKN9HHuCj5yYrFOaxnt3aGn8Da+r890/SxChvQc/yuBHhJDk8jS2oTNBN/
         jq4A==
X-Gm-Message-State: ABy/qLbRS8fGIftUMZmhKqnkVFQu6SJS2FPQqdkSuXjjRYlCoElRB5W1
        pZgjsbu+QygCHXUJCglq2zXP/r/7K6Q=
X-Google-Smtp-Source: APBJJlHb7B53XS1NPP9Kuu6/r1UpBABC4NsUI/V+drBqZJGeIG7P364BxAeqpOf1IQHIWTiJs/QlSA==
X-Received: by 2002:a05:600c:2150:b0:3fa:8fb1:50fe with SMTP id v16-20020a05600c215000b003fa8fb150femr1749513wml.15.1689762835416;
        Wed, 19 Jul 2023 03:33:55 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g8-20020a7bc4c8000000b003fa8158135esm1377185wmk.11.2023.07.19.03.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 03:33:54 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mtdblock: make warning messages ratelimited
Date:   Wed, 19 Jul 2023 11:33:54 +0100
Message-Id: <20230719103354.2829366-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When exercising various dev interfaces with stress-ng the mtdblock drivers
can be (ab)used to generate a lot of warning messages. Make these rate
limited to reduce the kernel log from being spammed with the same messages.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mtd/mtdblock.c    | 2 +-
 drivers/mtd/mtdblock_ro.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
index fa476fb4dffb..9751416c2a91 100644
--- a/drivers/mtd/mtdblock.c
+++ b/drivers/mtd/mtdblock.c
@@ -262,7 +262,7 @@ static int mtdblock_open(struct mtd_blktrans_dev *mbd)
 	}
 
 	if (mtd_type_is_nand(mbd->mtd))
-		pr_warn("%s: MTD device '%s' is NAND, please consider using UBI block devices instead.\n",
+		pr_warn_ratelimited("%s: MTD device '%s' is NAND, please consider using UBI block devices instead.\n",
 			mbd->tr->name, mbd->mtd->name);
 
 	/* OK, it's not open. Create cache info for it */
diff --git a/drivers/mtd/mtdblock_ro.c b/drivers/mtd/mtdblock_ro.c
index 66ffc9f1ead2..ef6299af60e4 100644
--- a/drivers/mtd/mtdblock_ro.c
+++ b/drivers/mtd/mtdblock_ro.c
@@ -49,7 +49,7 @@ static void mtdblock_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 	dev->readonly = 1;
 
 	if (mtd_type_is_nand(mtd))
-		pr_warn("%s: MTD device '%s' is NAND, please consider using UBI block devices instead.\n",
+		pr_warn_ratelimited("%s: MTD device '%s' is NAND, please consider using UBI block devices instead.\n",
 			tr->name, mtd->name);
 
 	if (add_mtd_blktrans_dev(dev))
-- 
2.39.2

