Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4817E592D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjKHOed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344345AbjKHOeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:34:19 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3A41FD7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:34:06 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507ad511315so10059557e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 06:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699454045; x=1700058845; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78GU8j4+SoSSNRmxCZnZFjlRCHFt/xGux/FgF9FARuk=;
        b=BA5E9/N+hjkCBkXNo2GSEYWwgGb4ioYhqdzF7T0DzpCReIDP/433BPXtvE85AJrAkz
         GN3ACgC45g1C15b6V/fsatzmsaGVpEKBCeZcG5faFhyGLkzC2Wrk104ejAn4EopzQ5ZR
         dHgyH+FM8KHQ/MjXLxt3mGYxpF0OVPMniExqnVf4+ggq44GGKiNTa74brIbsTRO70ZX+
         jaGEjzu8gA5stmVsYCvAkPDka+SrXLJfGGLrl5PdRccl+Q+rFLWJLV+kz4XZm/wiECH1
         yuL0WY6JFltpZj8rBkG0vv+romuVYkHpPbKQGfje959be4/CUncvxAQsrbL2+hevnkhh
         OaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699454045; x=1700058845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78GU8j4+SoSSNRmxCZnZFjlRCHFt/xGux/FgF9FARuk=;
        b=AnQcvECwvp7XaEeWLSI3S6eV0/yzx9nMWoAnJ2sfygdngl6eR1yhc2hrOY641oqXQG
         DXMBnVxIPgEzKgaVsthTL7Q+CZbClvyxxgz8dGE2HNlzPxzq8bsTzs/6KNklzUjUj0te
         dE6BfCRDYjT9BgFcOPz2z9eKPNlTPvHHE6xvl5iyvEyAtAJw96ryS05ePUtMafe/4Enq
         2GbKRK37Uzv1va0Nr3XeJ1F2kZebW4Ee/KMCIofqMLr4pOtMsumIHwmRemK2/PyCup7Z
         FmoOMSP4xxORwpakXGzbUdaTljH9m1kXrjlYvmtbZXhSzDQhXqmRY+FbwaOPYsWlPrzu
         jZ8A==
X-Gm-Message-State: AOJu0Yw5b3pXd5RIgMsc9cuzN70HZffDv3P4WvBxXC0GCx6OyJm4bSPE
        FsNU8I/FXbe4svTNOrOUlQfmuw==
X-Google-Smtp-Source: AGHT+IH6IcpUsu8l3iZ6cm3VeKSRvHVjWLm4/aWcEw/O+09FccupiAh8GMMm2qcpdhgkIocbk45f1A==
X-Received: by 2002:a19:9110:0:b0:507:b935:9f5f with SMTP id t16-20020a199110000000b00507b9359f5fmr1441210lfd.24.1699454044974;
        Wed, 08 Nov 2023 06:34:04 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q10-20020ac24a6a000000b00507a3b8b007sm686773lfp.110.2023.11.08.06.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 06:34:04 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 08 Nov 2023 15:33:54 +0100
Subject: [PATCH 6/6] mtd: rawnand: gpio: Rename file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231108-fix-mips-nand-v1-6-5fc5586d04de@linaro.org>
References: <20231108-fix-mips-nand-v1-0-5fc5586d04de@linaro.org>
In-Reply-To: <20231108-fix-mips-nand-v1-0-5fc5586d04de@linaro.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation of the GPIO NAND controller is just "gpio"
with the usecase for NAND implied from the folder nand/raw.

This is not so great when the module gets the name "gpio.ko".
Rename the implementation to nand-gpio.c so the module is
named nand-gpio.ko which is more reasonable.

We put "nand" first instead of "gpio" because the order is
usually <subsystem>-<driver>.c, cf ls drivers/gpio/

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/Makefile                | 2 +-
 drivers/mtd/nand/raw/{gpio.c => nand-gpio.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 25120a4afada..f0e377332812 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_MTD_NAND_NANDSIM)		+= nandsim.o
 obj-$(CONFIG_MTD_NAND_CS553X)		+= cs553x_nand.o
 obj-$(CONFIG_MTD_NAND_NDFC)		+= ndfc.o
 obj-$(CONFIG_MTD_NAND_ATMEL)		+= atmel/
-obj-$(CONFIG_MTD_NAND_GPIO)		+= gpio.o
+obj-$(CONFIG_MTD_NAND_GPIO)		+= nand-gpio.o
 omap2_nand-objs := omap2.o
 obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2_nand.o
 obj-$(CONFIG_MTD_NAND_OMAP_BCH_BUILD)	+= omap_elm.o
diff --git a/drivers/mtd/nand/raw/gpio.c b/drivers/mtd/nand/raw/nand-gpio.c
similarity index 100%
rename from drivers/mtd/nand/raw/gpio.c
rename to drivers/mtd/nand/raw/nand-gpio.c

-- 
2.34.1

