Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EC77A8D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjITT6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjITT6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:58:14 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C6BEC;
        Wed, 20 Sep 2023 12:58:00 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b962535808so3225221fa.0;
        Wed, 20 Sep 2023 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239878; x=1695844678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSjOv/gy0GrWM9KNB610Bni0nvt6VKfuUzLES6DifmE=;
        b=dp9aCL5jBUQymaJ/D3murwD75YyumXblDxQNTL2AA+QxuSnqqC/JX9JMVdZj4aIkxh
         886Uf+04MVCs7kFdj0xcfrWlh/SxMBmNz19c3XhuYkWnVHHwuqw6HROaSibWFyZeuEh0
         jVVI+6/2ppWJNmdqSkJZVowUYJQX7zQAlcZz24JYrLfhXDjHUyoFzqE5hWFS38TRKjVK
         +GS9s0VJq4zbsTbIquOFk04mpyN3eJ+yFtUDU8AzEgh9dfuRsG1BL9TXgCxzg9eTP2c9
         z/30PTMr+JGNrI4FT9Gopx7V6j1p7ijFIdUvKqs/w5dF+68u7NeBqk3TGw3aAdS+p8+x
         7lPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239878; x=1695844678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSjOv/gy0GrWM9KNB610Bni0nvt6VKfuUzLES6DifmE=;
        b=W16/2xc8I/mviV5G3IlRx1aQLL50s9NTDY2EZnMtqNc6W/LS5kiPzQssvyrVWJe+Td
         q3HIvC5KOJ3I3WGW2ANJbNtqsqgwc943blEce5cp4UFt6gYQioLE4hRXYTLCYt6wKvv0
         1ZEii0IWomd6t7gfk+VnElKKU1Yp90Ott4IHLAzKzA/ZAIhX6YebBvvVSJCbLadPf4Oy
         eDRg1C0z7r86w20PFHWTtcf3qx2KVsSrfGJB2Jctoy7BtVqiD0//y9zzzu+29bK2GS6I
         o/A8GbHQIz54vkuDnz2LqqXCxWmH/fQ9UV68ftNEwrnIaOanaUaLKCAIMG68noLwp1R1
         HOxQ==
X-Gm-Message-State: AOJu0Yy4Cw8J3ow2HoRbeCJLRbVpDWFo55DxCnr04/YD/suEBYX3WvQh
        VvjjgnU4pBXUCSiyzyF/J7Y=
X-Google-Smtp-Source: AGHT+IEM94ueN6ISp1Uin8pGHj3TNnHZWOhr2rpB5ApTgb37ngBAYvDDoCEgLObR9kad0OEHMZH5nQ==
X-Received: by 2002:a2e:9111:0:b0:2bc:d09c:853a with SMTP id m17-20020a2e9111000000b002bcd09c853amr3288500ljg.6.1695239877975;
        Wed, 20 Sep 2023 12:57:57 -0700 (PDT)
Received: from localhost ([85.140.6.205])
        by smtp.gmail.com with ESMTPSA id s29-20020a05651c049d00b002c128e4524dsm158821ljc.116.2023.09.20.12.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:57:57 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/13] EDAC/synopsys: Add optional ECC Scrub support
Date:   Wed, 20 Sep 2023 22:56:35 +0300
Message-ID: <20230920195720.32047-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920195720.32047-1-fancer.lancer@gmail.com>
References: <20230920195720.32047-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DW uMCTL2 DDRC ECC has a so called ECC Scrub feature in case if an
single-bit error is detected. The scrub is executed as a new RMW operation
to the location that resulted in a single-bit error thus fixing the ECC
code preserved in the SDRAM. But that feature not only optional, but also
runtime switchable. So there can be platforms with DW uMCTL2 DDRC not
supporting hardware-base scrub. In those cases the single-bit errors will
still be detected but won't be fixed until the next SDRAM write commands
to the erroneous location. Since the ECC Scrub feature availability is
detectable by means of the ECCCFG0.dis_scrub flag state use it to tune the
MCI core up so one would automatically execute the platform-specific
scrubbing to the affected SDRAM location. It's now possible to be done
since the DW uMCTL2 DDRC driver supports the actual system address
reported to the MCI core. The only thing left to do is to auto-detect the
ECC Scrub feature availability and set the mem_ctl.info.scrub_mode mode
with SCRUB_SW_SRC if the feature is unavailable. The rest will be done by
the MCI core when the single-bit errors happen.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 001553f3849a..4ee39d6809cc 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -32,6 +32,7 @@
 #define SNPS_EDAC_MOD_VER		"1"
 
 /* DDR capabilities */
+#define SNPS_CAP_ECC_SCRUB		BIT(0)
 #define SNPS_CAP_ZYNQMP			BIT(31)
 
 /* Synopsys uMCTL2 DDR controller registers that are relevant to ECC */
@@ -119,6 +120,7 @@
 #define DDR_MSTR_MEM_DDR2		0
 
 /* ECC CFG0 register definitions */
+#define ECC_CFG0_DIS_SCRUB		BIT(4)
 #define ECC_CFG0_MODE_MASK		GENMASK(2, 0)
 
 /* ECC status register definitions */
@@ -1014,6 +1016,10 @@ static int snps_get_ddrc_info(struct snps_edac_priv *priv)
 		return -ENXIO;
 	}
 
+	/* Assume HW-src scrub is always available if it isn't disabled */
+	if (!(regval & ECC_CFG0_DIS_SCRUB))
+		priv->info.caps |= SNPS_CAP_ECC_SCRUB;
+
 	/* Auto-detect the basic HIF/SDRAM bus parameters */
 	regval = readl(priv->baseaddr + DDR_MSTR_OFST);
 
@@ -1490,8 +1496,14 @@ static struct mem_ctl_info *snps_mc_create(struct snps_edac_priv *priv)
 			 MEM_FLAG_DDR3 | MEM_FLAG_LPDDR3 |
 			 MEM_FLAG_DDR4 | MEM_FLAG_LPDDR4;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
-	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
-	mci->scrub_mode = SCRUB_NONE;
+
+	if (priv->info.caps & SNPS_CAP_ECC_SCRUB) {
+		mci->scrub_mode = SCRUB_HW_SRC;
+		mci->scrub_cap = SCRUB_FLAG_HW_SRC;
+	} else {
+		mci->scrub_mode = SCRUB_SW_SRC;
+		mci->scrub_cap = SCRUB_FLAG_SW_SRC;
+	}
 
 	mci->edac_cap = EDAC_FLAG_SECDED;
 	mci->ctl_name = "snps_umctl2_ddrc";
@@ -1584,6 +1596,8 @@ static int snps_ddrc_info_show(struct seq_file *s, void *data)
 
 	seq_puts(s, "Caps:");
 	if (priv->info.caps) {
+		if (priv->info.caps & SNPS_CAP_ECC_SCRUB)
+			seq_puts(s, " +Scrub");
 		if (priv->info.caps & SNPS_CAP_ZYNQMP)
 			seq_puts(s, " +ZynqMP");
 	} else {
-- 
2.41.0

