Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C925D767025
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbjG1PIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjG1PIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:08:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD3810CB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:08:38 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fdd31bf179so3839263e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690556916; x=1691161716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DfYppoEpQrdUrZuOGiowedMyBgvAOJ+ROPmkKgYzwvo=;
        b=IncjLpyAsMyhYXLXrcSkFxluXG/sIm1wuQkDW7iAUjHCV6FTUN7yNYPMhrg5uSx8L3
         NZSN/YAyR1Nvh/cNuOlsxE62MuzKXEh1f+gC3gUv6drzlzCYNUAMzlNgRNo5Dl2qmuPZ
         vleE24eIb6XO34+TN4fX5Z4LXL6o2Sk+/uKJCfozzLrZlKx5j7mmszk9R17X2aYqkTVD
         AEf9Z8e7iYW/XJy4BxayLvX7BqELsSG0Ss1OHuo2EkdljOU95qQaNbDqJUzATuCPd9VP
         A57DERbToV9r/IKybcwlp2VsM/+6bHxYuOV0yaq55lp17O/Sj4CJW+PniXr4uvdEk0uf
         cI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556916; x=1691161716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfYppoEpQrdUrZuOGiowedMyBgvAOJ+ROPmkKgYzwvo=;
        b=KN25kvWj/p6bKlJrTocmwbaf/F+Ii5vY9D5NE1/qr6OovGgMXnmmLY+RrlYWgPxmer
         /Cvwp4yLBW2cqy58GXPB7LxR1Q80U4FXlieufMoleGjEbiOX71UhXC4JitzMjQEMKL6k
         PBFBmKIexKH+VarqOZahaZ/aUfdEMmIKOT6saEbWsTIbbcd+uzv3jZ7OEAz/X8AphBYE
         /3cxYNfpBzD1sqK2hS4GeqLDUYBb+lna7SeyZDcnpPxSxvVfrWU2MQYHRgrlo0bYkmsS
         Dq8+SMuwJXYCWvNuRo/76YKpFAIqgmrh3Nv/ml2WX5TBGgck5HSrubwW2pcRhU2lCqbj
         3+LA==
X-Gm-Message-State: ABy/qLYhZHQ/fIoBgGBvg7tjIaehpuDWFhBcKHkHSOsWzoKX6RWpeag5
        VnuYgctQb8T/39D/DfzM+b8=
X-Google-Smtp-Source: APBJJlEB3CA5YQpmX6srbtFzn4YGXvD+B9oLPIkTdmYsmHE1AqdrEWucPzpSv2fQp0u+v6KWXxWNGg==
X-Received: by 2002:a2e:2e17:0:b0:2b0:297c:cbdf with SMTP id u23-20020a2e2e17000000b002b0297ccbdfmr2224696lju.1.1690556916294;
        Fri, 28 Jul 2023 08:08:36 -0700 (PDT)
Received: from bhlegrsu.conti.de (ip-037-201-119-179.um10.pools.vodafone-ip.de. [37.201.119.179])
        by smtp.googlemail.com with ESMTPSA id f5-20020a1709064dc500b0098669cc16b2sm2158016ejw.83.2023.07.28.08.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:08:35 -0700 (PDT)
From:   Wadim Mueller <wafgo01@gmail.com>
X-Google-Original-From: Wadim Mueller <wadim.mueller@continental-corporation.com>
Cc:     Wadim Mueller <wafgo01@gmail.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] SPI-NOR: Add support for Micron mt35x01g
Date:   Fri, 28 Jul 2023 17:08:09 +0200
Message-Id: <20230728150810.205656-1-wadim.mueller@continental-corporation.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wadim Mueller <wafgo01@gmail.com>

Currently only the mt35xu512aba and mt35xu02g are supported,
support for the 1G version is missing. This patch adds
the corresponding entry in the micron_parts structure.

Verification and tests were done on a custom NXP S32G2 board with the
mt35xu01g qspi nor populated

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 drivers/mtd/spi-nor/micron-st.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 4b919756a205..fe97583547fe 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -166,6 +166,11 @@ static const struct flash_info micron_nor_parts[] = {
 		MFR_FLAGS(USE_FSR)
 		.fixups = &mt35xu512aba_fixups
 	},
+	{ "mt35xu01g", INFO(0x2c5b1b, 0, 128 * 1024, 1024)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_READ)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		MFR_FLAGS(USE_FSR)
+	},
 	{ "mt35xu02g", INFO(0x2c5b1c, 0, 128 * 1024, 2048)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
-- 
2.25.1

