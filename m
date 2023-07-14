Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658CA753E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbjGNPIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbjGNPII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:08:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FB82700
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:08:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31441dfbf97so2247792f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689347283; x=1691939283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+25fSkkJ3LOx6seKX0QJU9kNSlEQwPNGN+WO1mhMvMI=;
        b=Lf90t73uKJmeeFq5uN4YHnr9sJ71rIEIK/flZU3SzfncDcf5OwbX1IaNvEqwOAb0b4
         xxBqFUEq3Uvnb+D3x4Cmp3x2N7XiE/ZXnI8W6ewz470ZtlQhqCrMmFr5mkPEBi4Zovuv
         YyA6fYsteZdMYHNGRhOWZc3PGOLjbcPE6uA5sYy29ZuMIhjRnBhHi0I7HXtdhfS1WBRH
         fwTfS2a842D87CKIquzHGJEyYYf8m4TMSD/8AZxD/T729gSgHZBJ4TCWookk3nD25VBr
         HsmBlJlGLwXekkIBJJtgDtBsvxi14OrKIvSjJddff0QUOHO7TwMS9UYllSLjShIU3DAr
         klVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689347283; x=1691939283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+25fSkkJ3LOx6seKX0QJU9kNSlEQwPNGN+WO1mhMvMI=;
        b=fcXzWqiUkcOq2R2IBE3KrXvGwWx12rzujPBkbcqgO6kPNgcS/gVsG04i+53zp7cpiz
         eNw7C/XSr7oepBLkq+4JeoYvAbY2DaJS7pJwubFLw9uWAQUia7zmqz1JshoFh5VRQyut
         CdD2D268DlqoNsyqYBs9hFLL/C1HDKcKPF2O/D3fTM1ifAtpV3Pj2q5Fm6TrP71fi03z
         vpab7vgOJAObsVTsaWSeudMbI9NMvBlEjMaUoTec5CxNrGfJMr8nFjtfQXf2xSGu0ECt
         nxHmZGmoN6kzkp5JsjqYlrsxCjY03/jTEQKgRlv8vCjLzULLKADjtMKPLSb4teVsvrMq
         xVxQ==
X-Gm-Message-State: ABy/qLYX1mApexuUahcwH+nWWVi3FJn1xFj8VmNk9n664dO9kPxfN3Lc
        uFqJkU/3iQ7/4iD8xHURUq21Jg==
X-Google-Smtp-Source: APBJJlENLcXufqPBumnSElb/7yqarWmZ3bKOHd1czA+a4aXqy+wlPkXkuyE3vtePDt+0cIIXJ8eC7w==
X-Received: by 2002:a5d:458c:0:b0:313:fcea:db06 with SMTP id p12-20020a5d458c000000b00313fceadb06mr4289774wrq.12.1689347282918;
        Fri, 14 Jul 2023 08:08:02 -0700 (PDT)
Received: from 1.. ([37.251.220.221])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d5188000000b00314172ba213sm10977274wrv.108.2023.07.14.08.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 08:08:02 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc, pratyush@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        bacem.daassi@infineon.com, miquel.raynal@bootlin.com,
        richard@nod.at, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] mtd: spi-nor: rename method for enabling or disabling octal DTR
Date:   Fri, 14 Jul 2023 18:07:57 +0300
Message-Id: <20230714150757.15372-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616050600.8793-1-Takahiro.Kuwano@infineon.com>
References: <20230616050600.8793-1-Takahiro.Kuwano@infineon.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6006; i=tudor.ambarus@linaro.org; h=from:subject; bh=Rd74k6/QPhZmiMzGtR06LDfyT/mYAR29wo1NOzFjRio=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBksWTNz/EGzj0cHtiJIYyXZ4exREnj4SDl/Q9FT GGzygf5bVOJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLFkzQAKCRBLVU9HpY0U 6WgmCACrK7IsyE77GiKfhN8ImYbHHgmWbi18hweYOW2aPSjKrtHkmWJwE+b/s2V2vZavXfhagXi u+zvw2Y5P0OXJJ+HNZ6xNZD+F5Io3DDJRVoKz0yGs+LQsdTC1rraNGMWlNDR91be+atg7TTP4We K1/GGVYbO/39Z4M8DOdA0O5HtKPxJFl6AbDAwHy+H4AH4qd5u2k2RH+4w44Lt2GzlkOMG5QW3OU tOWIfBPTs2utM+7jMf7QljZBxdiJlqT1aIlAr/MQCuOZiqtw0jJBj+2sHm1OkfPKUNeUGaeYavL Gn7VNmAPU5gKwscH0Jh84D7pajVOo/BnH7Kh6qx7hSMiNlDX
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having an *_enable(..., bool enable) definition was misleading
as the method is used both to enable and to disable the octal DTR
mode. Splitting the method in the core in two, one to enable and
another to disable the octal DTR mode does not make sense as the
method is straight forward and we'd introduce code duplication.

Update the core to use:
int (*set_octal_dtr)(struct spi_nor *nor, bool enable);

Manufacturer drivers use different sequences of commands to enable
and disable the octal DTR mode, thus for clarity they shall
implement it as:
static int manufacturer_snor_set_octal_dtr(struct spi_nor *nor, bool enable)
{
	return enable ? manufacturer_snor_octal_dtr_enable() :
			manufacturer_snor_octal_dtr_disable();
}

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c      | 12 ++++++------
 drivers/mtd/spi-nor/core.h      |  4 ++--
 drivers/mtd/spi-nor/micron-st.c |  4 ++--
 drivers/mtd/spi-nor/spansion.c  |  6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 434c545c0ce4..273258f7e77f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3090,17 +3090,17 @@ static int spi_nor_init_params(struct spi_nor *nor)
 	return 0;
 }
 
-/** spi_nor_octal_dtr_enable() - enable Octal DTR I/O if needed
+/** spi_nor_set_octal_dtr() - enable or disable Octal DTR I/O.
  * @nor:                 pointer to a 'struct spi_nor'
  * @enable:              whether to enable or disable Octal DTR
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
+static int spi_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
 {
 	int ret;
 
-	if (!nor->params->octal_dtr_enable)
+	if (!nor->params->set_octal_dtr)
 		return 0;
 
 	if (!(nor->read_proto == SNOR_PROTO_8_8_8_DTR &&
@@ -3110,7 +3110,7 @@ static int spi_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 	if (!(nor->flags & SNOR_F_IO_MODE_EN_VOLATILE))
 		return 0;
 
-	ret = nor->params->octal_dtr_enable(nor, enable);
+	ret = nor->params->set_octal_dtr(nor, enable);
 	if (ret)
 		return ret;
 
@@ -3171,7 +3171,7 @@ static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
 
-	err = spi_nor_octal_dtr_enable(nor, true);
+	err = spi_nor_set_octal_dtr(nor, true);
 	if (err) {
 		dev_dbg(nor->dev, "octal mode not supported\n");
 		return err;
@@ -3273,7 +3273,7 @@ static int spi_nor_suspend(struct mtd_info *mtd)
 	int ret;
 
 	/* Disable octal DTR mode if we enabled it. */
-	ret = spi_nor_octal_dtr_enable(nor, false);
+	ret = spi_nor_set_octal_dtr(nor, false);
 	if (ret)
 		dev_err(nor->dev, "suspend() failed\n");
 
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 55b5e7abce6e..f2fc2cf78e55 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -364,7 +364,7 @@ struct spi_nor_otp {
  * @erase_map:		the erase map parsed from the SFDP Sector Map Parameter
  *                      Table.
  * @otp:		SPI NOR OTP info.
- * @octal_dtr_enable:	enables SPI NOR octal DTR mode.
+ * @set_octal_dtr:	enables or disables SPI NOR octal DTR mode.
  * @quad_enable:	enables SPI NOR quad mode.
  * @set_4byte_addr_mode: puts the SPI NOR in 4 byte addressing mode.
  * @convert_addr:	converts an absolute address into something the flash
@@ -398,7 +398,7 @@ struct spi_nor_flash_parameter {
 	struct spi_nor_erase_map        erase_map;
 	struct spi_nor_otp		otp;
 
-	int (*octal_dtr_enable)(struct spi_nor *nor, bool enable);
+	int (*set_octal_dtr)(struct spi_nor *nor, bool enable);
 	int (*quad_enable)(struct spi_nor *nor);
 	int (*set_4byte_addr_mode)(struct spi_nor *nor, bool enable);
 	u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 4b919756a205..f79e71d99124 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -120,7 +120,7 @@ static int micron_st_nor_octal_dtr_dis(struct spi_nor *nor)
 	return 0;
 }
 
-static int micron_st_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
+static int micron_st_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
 {
 	return enable ? micron_st_nor_octal_dtr_en(nor) :
 			micron_st_nor_octal_dtr_dis(nor);
@@ -128,7 +128,7 @@ static int micron_st_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 
 static void mt35xu512aba_default_init(struct spi_nor *nor)
 {
-	nor->params->octal_dtr_enable = micron_st_nor_octal_dtr_enable;
+	nor->params->set_octal_dtr = micron_st_nor_set_octal_dtr;
 }
 
 static int mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 36876aa849ed..6d6466a3436e 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -607,7 +607,7 @@ static struct spi_nor_fixups s25hx_t_fixups = {
 };
 
 /**
- * cypress_nor_octal_dtr_enable() - Enable octal DTR on Cypress flashes.
+ * cypress_nor_set_octal_dtr() - Enable or disable octal DTR on Cypress flashes.
  * @nor:		pointer to a 'struct spi_nor'
  * @enable:              whether to enable or disable Octal DTR
  *
@@ -616,7 +616,7 @@ static struct spi_nor_fixups s25hx_t_fixups = {
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int cypress_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
+static int cypress_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
 {
 	return enable ? cypress_nor_octal_dtr_en(nor) :
 			cypress_nor_octal_dtr_dis(nor);
@@ -667,7 +667,7 @@ static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
 
 static void s28hx_t_late_init(struct spi_nor *nor)
 {
-	nor->params->octal_dtr_enable = cypress_nor_octal_dtr_enable;
+	nor->params->set_octal_dtr = cypress_nor_set_octal_dtr;
 	cypress_nor_ecc_init(nor);
 }
 
-- 
2.34.1

