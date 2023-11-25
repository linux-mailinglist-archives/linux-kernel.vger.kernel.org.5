Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796247F8ACD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjKYMfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjKYMfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:35:42 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A595E19D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:35:48 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a049d19b63bso383653966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700915747; x=1701520547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRVqX+0ahP3hP/THbaHoTXImqdkW4hzKFigoAdVJ+tc=;
        b=PB5ovGiV2y7YQkgEsNP1DbR1KEROfEDC/jQvRmGBBSZMwFGIKNKSoLbURHArrWMk7Z
         uN0NT/AMETmdjpKV6BZOneRAqxwialECSRf56OVaccvah0j0FxFoRzzBJ+OMIh4tpHw4
         K4qAXluYUjbElfFMrqs1pTaEHDnNus39urW3eB9zxYmprNTnHxSpdtPAxePKItMxJI2O
         rq0APR3HwVYQSqUSuOZTcd/VSusWbuA3Ypc3PZVS83QEUgkgxSkQTm7oDWjv4ZHygJpV
         CM/7UWkQrHjOcEBkhr6kmNSNc3VpU9ZsNHy83NRVCCnR/D5rY3GUfmSE3MNFp4TmLbaX
         jkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700915747; x=1701520547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRVqX+0ahP3hP/THbaHoTXImqdkW4hzKFigoAdVJ+tc=;
        b=UZitGJYXMU6U4zLVJJl2dKgeylDKq7RmMMKV9roJIE2kDWR82g71m+FVDkdinI0smB
         SoG3gLr1SCEZ7tcwrYbsJ5L09useA64IttqWJC/4n8NVezwjYsVAX8ziV4r3342vPokI
         Me1RV9tmz3s3BIQCJpbEKnHaV6NZrN7dZWg1Kx2LiH6TQyeKGgshaMfvH2k3x3o07WzZ
         JhdD7bmhYP0+SHaGqzBe/9oD8UwNe2H07LHEGvPIiZ3greTkXaCOt9iN8yyJnnrRScm7
         xbaLr0nurdhv1ZkWbEuIUOLyCNVuR9ZiFRON1cPANKEiR59djtBWMCbqaMQ1xfyOoV8/
         6+jw==
X-Gm-Message-State: AOJu0Ywl4as9msGLRNGPZVH76Q8h8OGIkFRtbNwWscienZAlLbA7itYv
        xQrXOKzp4iDMpaWR5kzMhN6HPQ==
X-Google-Smtp-Source: AGHT+IGCzZkHJ01zddYYZyY7G1FynXO7V/Sr1FyMQrUeiJnGt2U+RhocZAE4ny7OjDOfx0vGfKUaBQ==
X-Received: by 2002:a17:906:583:b0:9d3:ccf0:761e with SMTP id 3-20020a170906058300b009d3ccf0761emr4438046ejn.49.1700915747228;
        Sat, 25 Nov 2023 04:35:47 -0800 (PST)
Received: from 1.. ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id lv23-20020a170906bc9700b009f28db2b702sm3390163ejb.209.2023.11.25.04.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 04:35:46 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     pratyush@kernel.org, michael@walle.cc, fastevam@denx.de
Cc:     linux-mtd@lists.infradead.org, takahiro.kuwano@infineon.com,
        bacem.daassi@infineon.com, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v3 2/5] mtd: spi-nor: spansion: enable die erase for multi die flashes
Date:   Sat, 25 Nov 2023 14:35:26 +0200
Message-Id: <20231125123529.55686-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231125123529.55686-1-tudor.ambarus@linaro.org>
References: <20231125123529.55686-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697; i=tudor.ambarus@linaro.org; h=from:subject; bh=2CCTjENYaOp4KjdgQLpG9dbq/tdNpT2/M9c0IJnNCs4=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlYeoRWECU8zlwpkWjK8Gxq1ZVckDE6TznyRPi0 dovpaLFBOuJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZWHqEQAKCRBLVU9HpY0U 6XxvCAC5nwYsSD43zvsYNX9DI8fXGcVIgYDaFnE7sgVaKHBcsP+navdzFbNzaixLSs6xu3Razg2 fipVsEMjGz1hx2pZHh5zNksOAw/nrpFelt4ZyGA/6jCsdK6OVBinSAxb76HheGfKfvlBsEXrSc9 TzNNwHdUvz1VmjF4SY27xBNk+9np0pGbvjdCJgt+0xzfWlLjHqqjiUqqEdu9Q3mKtg1i2hmItb3 S4qQ+7r6farjgZkubIIsIKqKJBustVSGU98TS6vuQnsFUuPxsRSr1fLxIQruNI46y1GdbH1DFEf IF72cHhC2L3vf9xnBeXqmI3xhoj/sRuz1H+zBDldgyAsHdMX
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable die erase for spansion multi die flashes.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Tested-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/spansion.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 12921344373d..6cc237c24e07 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -17,6 +17,7 @@
 
 #define SPINOR_OP_CLSR		0x30	/* Clear status register 1 */
 #define SPINOR_OP_CLPEF		0x82	/* Clear program/erase failure flags */
+#define SPINOR_OP_CYPRESS_DIE_ERASE		0x61	/* Chip (die) erase */
 #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
 #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
 #define SPINOR_REG_CYPRESS_VREG			0x00800000
@@ -644,6 +645,7 @@ static int s25hx_t_late_init(struct spi_nor *nor)
 	params->ready = cypress_nor_sr_ready_and_clear;
 	cypress_nor_ecc_init(nor);
 
+	params->die_erase_opcode = SPINOR_OP_CYPRESS_DIE_ERASE;
 	return 0;
 }
 
@@ -933,7 +935,6 @@ static const struct flash_info spansion_nor_parts[] = {
 		.id = SNOR_ID(0x34, 0x2a, 0x1c, 0x0f, 0x00, 0x90),
 		.name = "s25hl02gt",
 		.mfr_flags = USE_CLPEF,
-		.flags = NO_CHIP_ERASE,
 		.fixups = &s25hx_t_fixups
 	}, {
 		.id = SNOR_ID(0x34, 0x2b, 0x19, 0x0f, 0x08, 0x90),
@@ -954,7 +955,6 @@ static const struct flash_info spansion_nor_parts[] = {
 		.id = SNOR_ID(0x34, 0x2b, 0x1c, 0x0f, 0x00, 0x90),
 		.name = "s25hs02gt",
 		.mfr_flags = USE_CLPEF,
-		.flags = NO_CHIP_ERASE,
 		.fixups = &s25hx_t_fixups
 	}, {
 		.id = SNOR_ID(0x34, 0x5a, 0x1a),
-- 
2.34.1

