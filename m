Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D0C7DCEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjJaOO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbjJaOOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:14:54 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FDFF5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:14:52 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CD47F404AC
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698761690;
        bh=XnEjgTb1m78EWwQDGRYEFN4m8CDZaDkjNTK8j9cPE/A=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=mItblL9pX0fK7i/haCqp1ZhI0w6m5P2X5dTDZRLPqiikTeRIiCtnGH4LflRTKikmv
         go+iqOABl5qCintjSQXjTzZcd+SJAZvvPKEIRMnle2Kn7wHxsqtgLUjwNwpzViezE7
         5A1FAi1y1NXLLx/TxnfqwHmlo5sPHYD+x98wDQ96b0p2Poc8CifPs5ThbqmhQZ6+UV
         FxmbedNiJtxUP6VpmPPyqOqh7Q4z3dvvzB+TlN8wCuug6blatlh1XdYrr4V7ETE2Ox
         T5hQ2HwtaUYac9KYvVyIgKctEB333F0rTFryxola0gmTOWQN4OYzBNcc2S0+POkcPH
         ihCi/hOb4Bydg==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c7558b838aso395247966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698761690; x=1699366490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnEjgTb1m78EWwQDGRYEFN4m8CDZaDkjNTK8j9cPE/A=;
        b=H4tCePhpF0wMI/xSPc5jhXsobwq+kQevvaQ0rRf0XywCWmez33OmCWkDD6VPUvexNp
         sNKiihTIhcYwcphaJvO8JFtflXP95XO+22iQbBFG3obs+nTUAGaVmx+3C8p8ODjlJBMF
         aM08Sooavy0CNfLuAA0lOdweHGfqKppfVHP1UEEtCcgAu4CZ9fHploje0BtbgkgMx+H0
         VMuXwr7qvvltaf08iIRSGRbcqexNvxy/g9LxGfrAMXEngd3t3dwD2Tu/PtMEBPmW1QDr
         q03v4EWvmSLtNutOYJ4m+TxmHFCzm+XcIHkz4qDfD6IxbyTdKJb4CluRno6/xc5Y8qjk
         1GpQ==
X-Gm-Message-State: AOJu0YwEWgXCoLwL0W40Leh97kKs7an1z3LF5QziRToLmC4I1lhRn0zb
        5ZRgn27i5YWE1z8F4oyqHKzKWFslCgDJFoj0AUdotZqUghdnISYSoo+BBjCL6GjCQrID2Lkca+L
        wmV0S37YyNjcG7Nt6VI34KNdt/Jm7KRN0xgA80gmryA==
X-Received: by 2002:a17:907:3184:b0:9c5:844f:a7f4 with SMTP id xe4-20020a170907318400b009c5844fa7f4mr10802103ejb.35.1698761690435;
        Tue, 31 Oct 2023 07:14:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfXx1RuCQtYqjPRoFL8zYiifdddYy2acqzq59Ogj9Q205dxFWWWX8UcYcvHsioLJG5MGwW2w==
X-Received: by 2002:a17:907:3184:b0:9c5:844f:a7f4 with SMTP id xe4-20020a170907318400b009c5844fa7f4mr10802092ejb.35.1698761690172;
        Tue, 31 Oct 2023 07:14:50 -0700 (PDT)
Received: from stitch.. ([2a02:aa7:4003:190e:bd47:7b6e:876:4bdc])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709061b4500b009d23e00a90esm1037395ejg.24.2023.10.31.07.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 07:14:49 -0700 (PDT)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 2/2] soc: sifive: ccache: Add StarFive JH7100 support
Date:   Tue, 31 Oct 2023 15:14:44 +0100
Message-Id: <20231031141444.53426-3-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231031141444.53426-1-emil.renner.berthing@canonical.com>
References: <20231031141444.53426-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

This adds support for the StarFive JH7100 SoC which also features this
SiFive cache controller.

The JH7100 has non-coherent DMAs but predate the standard RISC-V Zicbom
exension, so instead we need to use this cache controller for
non-standard cache management operations.

Unfortunately the interrupt for uncorrected data is broken on the JH7100
and fires continuously, so add a quirk to not register a handler for it.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/soc/sifive/sifive_ccache.c | 62 +++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index 3684f5b40a80..0da3d1bd0866 100644
--- a/drivers/soc/sifive/sifive_ccache.c
+++ b/drivers/soc/sifive/sifive_ccache.c
@@ -8,13 +8,16 @@
 
 #define pr_fmt(fmt) "CCACHE: " fmt
 
+#include <linux/align.h>
 #include <linux/debugfs.h>
 #include <linux/interrupt.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/device.h>
 #include <linux/bitfield.h>
+#include <asm/cacheflush.h>
 #include <asm/cacheinfo.h>
+#include <asm/dma-noncoherent.h>
 #include <soc/sifive/sifive_ccache.h>
 
 #define SIFIVE_CCACHE_DIRECCFIX_LOW 0x100
@@ -39,10 +42,14 @@
 #define SIFIVE_CCACHE_CONFIG_SETS_MASK GENMASK_ULL(23, 16)
 #define SIFIVE_CCACHE_CONFIG_BLKS_MASK GENMASK_ULL(31, 24)
 
+#define SIFIVE_CCACHE_FLUSH64 0x200
+#define SIFIVE_CCACHE_FLUSH32 0x240
+
 #define SIFIVE_CCACHE_WAYENABLE 0x08
 #define SIFIVE_CCACHE_ECCINJECTERR 0x40
 
 #define SIFIVE_CCACHE_MAX_ECCINTR 4
+#define SIFIVE_CCACHE_LINE_SIZE 64
 
 static void __iomem *ccache_base;
 static int g_irq[SIFIVE_CCACHE_MAX_ECCINTR];
@@ -56,6 +63,11 @@ enum {
 	DIR_UNCORR,
 };
 
+enum {
+	QUIRK_NONSTANDARD_CACHE_OPS	= BIT(0),
+	QUIRK_BROKEN_DATA_UNCORR	= BIT(1),
+};
+
 #ifdef CONFIG_DEBUG_FS
 static struct dentry *sifive_test;
 
@@ -106,6 +118,8 @@ static void ccache_config_read(void)
 static const struct of_device_id sifive_ccache_ids[] = {
 	{ .compatible = "sifive,fu540-c000-ccache" },
 	{ .compatible = "sifive,fu740-c000-ccache" },
+	{ .compatible = "starfive,jh7100-ccache",
+	  .data = (void *)(QUIRK_NONSTANDARD_CACHE_OPS | QUIRK_BROKEN_DATA_UNCORR) },
 	{ .compatible = "sifive,ccache0" },
 	{ /* end of table */ }
 };
@@ -124,6 +138,34 @@ int unregister_sifive_ccache_error_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_sifive_ccache_error_notifier);
 
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+static void ccache_flush_range(phys_addr_t start, size_t len)
+{
+	phys_addr_t end = start + len;
+	phys_addr_t line;
+
+	if (!len)
+		return;
+
+	mb();
+	for (line = ALIGN_DOWN(start, SIFIVE_CCACHE_LINE_SIZE); line < end;
+			line += SIFIVE_CCACHE_LINE_SIZE) {
+#ifdef CONFIG_32BIT
+		writel(line >> 4, ccache_base + SIFIVE_CCACHE_FLUSH32);
+#else
+		writeq(line, ccache_base + SIFIVE_CCACHE_FLUSH64);
+#endif
+		mb();
+	}
+}
+
+static const struct riscv_nonstd_cache_ops ccache_mgmt_ops __initdata = {
+	.wback = &ccache_flush_range,
+	.inv = &ccache_flush_range,
+	.wback_inv = &ccache_flush_range,
+};
+#endif /* CONFIG_RISCV_NONSTANDARD_CACHE_OPS */
+
 static int ccache_largest_wayenabled(void)
 {
 	return readl(ccache_base + SIFIVE_CCACHE_WAYENABLE) & 0xFF;
@@ -210,11 +252,15 @@ static int __init sifive_ccache_init(void)
 	struct device_node *np;
 	struct resource res;
 	int i, rc, intr_num;
+	const struct of_device_id *match;
+	unsigned long quirks;
 
-	np = of_find_matching_node(NULL, sifive_ccache_ids);
+	np = of_find_matching_node_and_match(NULL, sifive_ccache_ids, &match);
 	if (!np)
 		return -ENODEV;
 
+	quirks = (uintptr_t)match->data;
+
 	if (of_address_to_resource(np, 0, &res)) {
 		rc = -ENODEV;
 		goto err_node_put;
@@ -240,6 +286,10 @@ static int __init sifive_ccache_init(void)
 
 	for (i = 0; i < intr_num; i++) {
 		g_irq[i] = irq_of_parse_and_map(np, i);
+
+		if (i == DATA_UNCORR && (quirks & QUIRK_BROKEN_DATA_UNCORR))
+			continue;
+
 		rc = request_irq(g_irq[i], ccache_int_handler, 0, "ccache_ecc",
 				 NULL);
 		if (rc) {
@@ -249,6 +299,14 @@ static int __init sifive_ccache_init(void)
 	}
 	of_node_put(np);
 
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (quirks & QUIRK_NONSTANDARD_CACHE_OPS) {
+		riscv_cbom_block_size = SIFIVE_CCACHE_LINE_SIZE;
+		riscv_noncoherent_supported();
+		riscv_noncoherent_register_cache_ops(&ccache_mgmt_ops);
+	}
+#endif
+
 	ccache_config_read();
 
 	ccache_cache_ops.get_priv_group = ccache_get_priv_group;
@@ -269,4 +327,4 @@ static int __init sifive_ccache_init(void)
 	return rc;
 }
 
-device_initcall(sifive_ccache_init);
+arch_initcall(sifive_ccache_init);
-- 
2.40.1

