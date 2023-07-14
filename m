Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DD6753EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbjGNPVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbjGNPV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:21:27 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEE135AB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:21:24 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b741cf99f8so31649051fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689348083; x=1691940083;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gPMTtJDX93p+W2FMfeS5+8MLkFLKqGSV2IPU3Bw5eBc=;
        b=Dx5hMByGBB/m9B2iGSmDZSWhmM8Ums69yPuNOxVHlFmd+0A09Oo3DyQyLh8Yistme2
         lwVnQi4orsB+auNTwB8ssQ1jd5w/qSl78LrvaNQos4m0d0uxvu23/J9Q1XWB3J74uwb2
         +qcryvpRQoRW5Rs5UCnavMVw0vEZa7coTmLVR7lcH07UoXyF93WIfZEzvU10MrMoAXcw
         XLpZgFFlABrILlnQGzpUJBtuJz8X1NVWt7R1A8lsnCFw3JXkR9d9tbksjiGlYBidwSFw
         FdvWellQG2Uu9bedikNNmkxch051mSDSOQrp+KGw5Oqiun386ImyiV5HPHgluoQcDatB
         iA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689348083; x=1691940083;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPMTtJDX93p+W2FMfeS5+8MLkFLKqGSV2IPU3Bw5eBc=;
        b=ZZDZAOgR4Ln9kvl4mi7PAjXWlbtv8RSn4740wivkZl5R8kYlIKMEiBk8EDHzBU+OUT
         miiM3Pgklli5eiwXFpA5z/cT8QWruskgzipfrbZe9N9rPsPDrVcpMAca1z5lypBDsdKY
         YgLrY4ctBFHLH/23ALrKV/RnklmJge6QpmMZSvWxrG8z/n5zgqDlbrzMFTJDlpv5nFsA
         ZR4hYSF96YyzDtD2IQlHb36QVPbOKNLCzeKUQme9arEW7wOwgjmqt+Y7XXYp6MasYO14
         dyPD1hev9cREVx+b3/3e2As/oTkh33FzgpNKIDZFXF3kYJYVhl1ZDMOt2HPIv8ZI0+aM
         kwWw==
X-Gm-Message-State: ABy/qLbJcHXV3zs81Zq7+Hwxpe7p1RXDzodgGFCg6LoB5uHoGpcByOHj
        dshH3LjK67ZaCEY4Ee24zFeTU1gO1GE=
X-Google-Smtp-Source: APBJJlFqQ/SVKroJjMa1fZUCbpjfJrfXjWNcU9vIvwPdVdWNMyGwxyl9FyNl3vx/l6m4g01N4AVLRQ==
X-Received: by 2002:a2e:321a:0:b0:2b6:9b2e:e352 with SMTP id y26-20020a2e321a000000b002b69b2ee352mr4122408ljy.9.1689348082785;
        Fri, 14 Jul 2023 08:21:22 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n25-20020a17090695d900b009927d4d7a6dsm5576536ejy.192.2023.07.14.08.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 08:21:22 -0700 (PDT)
Message-ID: <5e782c08-862b-51ae-47ff-3299940928ca@gmail.com>
Date:   Fri, 14 Jul 2023 17:21:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 2/2] mtd: rawnand: rockchip: Align hwecc vs. raw page
 helper layouts
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
References: <273ad871-9050-7851-9973-5545b88bf43b@gmail.com>
Content-Language: en-US
In-Reply-To: <273ad871-9050-7851-9973-5545b88bf43b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, read/write_page_hwecc() and read/write_page_raw() are not
aligned: there is a mismatch in the OOB bytes which are not
read/written at the same offset in both cases (raw vs. hwecc).

This is a real problem when relying on the presence of the Page
Addresses (PA) when using the NAND chip as a boot device, as the
BootROM expects additional data in the OOB area at specific locations.

Rockchip boot blocks are written per 4 x 512 byte sectors per page.
Each page with boot blocks must have a page address (PA) pointer in OOB
to the next page. Pages are written in a pattern depending on the NAND chip ID.

Generate boot block page address and pattern for hwecc in user space
and copy PA data to/from the already reserved last 4 bytes before ECC
in the chip->oob_poi data layout.

Align the different helpers. This change breaks existing jffs2 users.

Fixes: 058e0e847d54 ("mtd: rawnand: rockchip: NFC driver for RK3308, RK2928 and others")
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V5:
  Reword

Changed V4:
  Reduce subject size
  Add 'Fixes:' tag
  Fix abbreviation
  Reword

Changed V3:
  Change prefixes
  Reword
---
 .../mtd/nand/raw/rockchip-nand-controller.c   | 34 ++++++++++++-------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 37fc07ba57aa..5a04680342c3 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -598,7 +598,7 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
 	int pages_per_blk = mtd->erasesize / mtd->writesize;
 	int ret = 0, i, boot_rom_mode = 0;
 	dma_addr_t dma_data, dma_oob;
-	u32 reg;
+	u32 tmp;
 	u8 *oob;

 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
@@ -625,6 +625,13 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
 	 *
 	 *   0xFF 0xFF 0xFF 0xFF | BBM OOB1 OOB2 OOB3 | ...
 	 *
+	 * The code here just swaps the first 4 bytes with the last
+	 * 4 bytes without losing any data.
+	 *
+	 * The chip->oob_poi data layout:
+	 *
+	 *    BBM  OOB1 OOB2 OOB3 |......|  PA0  PA1  PA2  PA3
+	 *
 	 * Configure the ECC algorithm supported by the boot ROM.
 	 */
 	if ((page < (pages_per_blk * rknand->boot_blks)) &&
@@ -635,21 +642,17 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
 	}

 	for (i = 0; i < ecc->steps; i++) {
-		if (!i) {
-			reg = 0xFFFFFFFF;
-		} else {
+		if (!i)
+			oob = chip->oob_poi + (ecc->steps - 1) * NFC_SYS_DATA_SIZE;
+		else
 			oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
-			reg = oob[0] | oob[1] << 8 | oob[2] << 16 |
-			      oob[3] << 24;
-		}

-		if (!i && boot_rom_mode)
-			reg = (page & (pages_per_blk - 1)) * 4;
+		tmp = oob[0] | oob[1] << 8 | oob[2] << 16 | oob[3] << 24;

 		if (nfc->cfg->type == NFC_V9)
-			nfc->oob_buf[i] = reg;
+			nfc->oob_buf[i] = tmp;
 		else
-			nfc->oob_buf[i * (oob_step / 4)] = reg;
+			nfc->oob_buf[i * (oob_step / 4)] = tmp;
 	}

 	dma_data = dma_map_single(nfc->dev, (void *)nfc->page_buf,
@@ -812,12 +815,17 @@ static int rk_nfc_read_page_hwecc(struct nand_chip *chip, u8 *buf, int oob_on,
 		goto timeout_err;
 	}

-	for (i = 1; i < ecc->steps; i++) {
-		oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
+	for (i = 0; i < ecc->steps; i++) {
+		if (!i)
+			oob = chip->oob_poi + (ecc->steps - 1) * NFC_SYS_DATA_SIZE;
+		else
+			oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
+
 		if (nfc->cfg->type == NFC_V9)
 			tmp = nfc->oob_buf[i];
 		else
 			tmp = nfc->oob_buf[i * (oob_step / 4)];
+
 		*oob++ = (u8)tmp;
 		*oob++ = (u8)(tmp >> 8);
 		*oob++ = (u8)(tmp >> 16);
--
2.30.2

