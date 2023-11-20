Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69FF7F0FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjKTKFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjKTKEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:04:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03673137;
        Mon, 20 Nov 2023 02:04:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A112CC433C9;
        Mon, 20 Nov 2023 10:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700474669;
        bh=fKb+xbBhMRnOedisaQa5Ib04C5HzaEOtuAoHJWCqrGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A13vEMl5j2muy5bu0whO7vyDwEQYG0qgMi+oes9Lv6KYbIRROXKAbx6m6+VA0XnZW
         xcxow9T4QMyyr4/XsDQt7XUYujaLR+nTaRcq+l/MffNXavEdKhlupLOjmOrM8TSkql
         /k4gXlBn3jRxCqoF53wrvwz/s7/xvQEX7oskUQ30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.261
Date:   Mon, 20 Nov 2023 11:04:17 +0100
Message-ID: <2023112017-handwash-replace-72b8@gregkh>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <2023112017-umbrella-defective-234c@gregkh>
References: <2023112017-umbrella-defective-234c@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
index 1a8718f8855d..178fca08278f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
@@ -55,7 +55,7 @@ Required Properties:
 			corresponds to a range of host irqs.
 
 For more details on TISCI IRQ resource management refer:
-http://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
+https://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
 
 Example:
 --------
diff --git a/Makefile b/Makefile
index 24dc30cd2472..e1892469e2c5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 260
+SUBLEVEL = 261
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index ffb4dcdb62d2..8b3eb93ec451 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -82,14 +82,12 @@
 		};
 	};
 
-	regulators {
-		vsdcc_fixed: vsdcc-regulator {
-			compatible = "regulator-fixed";
-			regulator-name = "SDCC Power";
-			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <2700000>;
-			regulator-always-on;
-		};
+	vsdcc_fixed: vsdcc-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "SDCC Power";
+		regulator-min-microvolt = <2700000>;
+		regulator-max-microvolt = <2700000>;
+		regulator-always-on;
 	};
 
 	soc: soc {
diff --git a/arch/arm/lib/memset.S b/arch/arm/lib/memset.S
index 6ca4535c47fb..e36d053a8a90 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -16,6 +16,7 @@
 ENTRY(mmioset)
 ENTRY(memset)
 UNWIND( .fnstart         )
+	and	r1, r1, #255		@ cast to unsigned char
 	ands	r3, r0, #3		@ 1 unaligned?
 	mov	ip, r0			@ preserve r0 as return value
 	bne	6f			@ 1
diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index c57548b7b250..e5331a81249b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -468,6 +468,8 @@
 	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+
+	qcom,snoc-host-cap-8bit-quirk;
 };
 
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index d42f2e091201..872313021eaa 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -50,7 +50,7 @@ static int trace_imc_mem_size;
  * core and trace-imc
  */
 static struct imc_pmu_ref imc_global_refc = {
-	.lock = __SPIN_LOCK_INITIALIZER(imc_global_refc.lock),
+	.lock = __SPIN_LOCK_UNLOCKED(imc_global_refc.lock),
 	.id = 0,
 	.refc = 0,
 };
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 55af0e4cf355..52e466d4a33c 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -522,8 +522,10 @@ static ssize_t vcpudispatch_stats_write(struct file *file, const char __user *p,
 
 	if (cmd) {
 		rc = init_cpu_associativity();
-		if (rc)
+		if (rc) {
+			destroy_cpu_associativity();
 			goto out;
+		}
 
 		for_each_possible_cpu(cpu) {
 			disp = per_cpu_ptr(&vcpu_disp_data, cpu);
diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 3fd086533dcf..05c38da4bbee 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -778,7 +778,7 @@ int xive_native_get_queue_info(u32 vp_id, u32 prio,
 	if (out_qpage)
 		*out_qpage = be64_to_cpu(qpage);
 	if (out_qsize)
-		*out_qsize = be32_to_cpu(qsize);
+		*out_qsize = be64_to_cpu(qsize);
 	if (out_qeoi_page)
 		*out_qeoi_page = be64_to_cpu(qeoi_page);
 	if (out_escalate_irq)
diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
index 71acd3d9b9e8..dfc784f89797 100644
--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -26,6 +26,17 @@ config STACK_DEBUG
 	  every function call and will therefore incur a major
 	  performance hit. Most users should say N.
 
+config EARLY_PRINTK
+	bool "Early printk"
+	depends on SH_STANDARD_BIOS
+	help
+	  Say Y here to redirect kernel printk messages to the serial port
+	  used by the SH-IPL bootloader, starting very early in the boot
+	  process and ending when the kernel's serial console is initialised.
+	  This option is only useful while porting the kernel to a new machine,
+	  when the kernel may crash or hang before the serial console is
+	  initialised.  If unsure, say N.
+
 config 4KSTACKS
 	bool "Use 4Kb for kernel stacks instead of 8Kb"
 	depends on DEBUG_KERNEL && (MMU || BROKEN) && !PAGE_SIZE_64KB
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index fe8c7e79f472..566067a855a1 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -156,8 +156,8 @@ static int create_pnp_modalias(struct acpi_device *acpi_dev, char *modalias,
 		return 0;
 
 	len = snprintf(modalias, size, "acpi:");
-	if (len <= 0)
-		return len;
+	if (len >= size)
+		return -ENOMEM;
 
 	size -= len;
 
@@ -210,8 +210,10 @@ static int create_of_modalias(struct acpi_device *acpi_dev, char *modalias,
 	len = snprintf(modalias, size, "of:N%sT", (char *)buf.pointer);
 	ACPI_FREE(buf.pointer);
 
-	if (len <= 0)
-		return len;
+	if (len >= size)
+		return -ENOMEM;
+
+	size -= len;
 
 	of_compatible = acpi_dev->data.of_compatible;
 	if (of_compatible->type == ACPI_TYPE_PACKAGE) {
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 4f2ff1b2b450..214d19d1337d 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -49,7 +49,7 @@ static ssize_t regmap_name_read_file(struct file *file,
 		name = map->dev->driver->name;
 
 	ret = snprintf(buf, PAGE_SIZE, "%s\n", name);
-	if (ret < 0) {
+	if (ret >= PAGE_SIZE) {
 		kfree(buf);
 		return ret;
 	}
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index b5974cbbe78f..23574c328616 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1495,17 +1495,19 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 	}
 
 	if (!map->cache_bypass && map->format.parse_val) {
-		unsigned int ival;
+		unsigned int ival, offset;
 		int val_bytes = map->format.val_bytes;
-		for (i = 0; i < val_len / val_bytes; i++) {
-			ival = map->format.parse_val(val + (i * val_bytes));
-			ret = regcache_write(map,
-					     reg + regmap_get_offset(map, i),
-					     ival);
+
+		/* Cache the last written value for noinc writes */
+		i = noinc ? val_len - val_bytes : 0;
+		for (; i < val_len; i += val_bytes) {
+			ival = map->format.parse_val(val + i);
+			offset = noinc ? 0 : regmap_get_offset(map, i / val_bytes);
+			ret = regcache_write(map, reg + offset, ival);
 			if (ret) {
 				dev_err(map->dev,
 					"Error in caching of register: %x ret: %d\n",
-					reg + regmap_get_offset(map, i), ret);
+					reg + offset, ret);
 				return ret;
 			}
 		}
diff --git a/drivers/char/hw_random/geode-rng.c b/drivers/char/hw_random/geode-rng.c
index 207272979f23..2f8289865ec8 100644
--- a/drivers/char/hw_random/geode-rng.c
+++ b/drivers/char/hw_random/geode-rng.c
@@ -58,7 +58,8 @@ struct amd_geode_priv {
 
 static int geode_rng_data_read(struct hwrng *rng, u32 *data)
 {
-	void __iomem *mem = (void __iomem *)rng->priv;
+	struct amd_geode_priv *priv = (struct amd_geode_priv *)rng->priv;
+	void __iomem *mem = priv->membase;
 
 	*data = readl(mem + GEODE_RNG_DATA_REG);
 
@@ -67,7 +68,8 @@ static int geode_rng_data_read(struct hwrng *rng, u32 *data)
 
 static int geode_rng_data_present(struct hwrng *rng, int wait)
 {
-	void __iomem *mem = (void __iomem *)rng->priv;
+	struct amd_geode_priv *priv = (struct amd_geode_priv *)rng->priv;
+	void __iomem *mem = priv->membase;
 	int data, i;
 
 	for (i = 0; i < 20; i++) {
diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
index 27a86b7a34db..c82df105b0a2 100644
--- a/drivers/clk/clk-npcm7xx.c
+++ b/drivers/clk/clk-npcm7xx.c
@@ -647,7 +647,7 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 	return;
 
 npcm7xx_init_fail:
-	kfree(npcm7xx_clk_data->hws);
+	kfree(npcm7xx_clk_data);
 npcm7xx_init_np_err:
 	iounmap(clk_base);
 npcm7xx_init_error:
diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index e3cdb4a282fe..d68de3773eb1 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -170,6 +170,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		sclk->info = handle->clk_ops->info_get(handle, idx);
 		if (!sclk->info) {
 			dev_dbg(dev, "invalid clock info for idx %d\n", idx);
+			devm_kfree(dev, sclk);
 			continue;
 		}
 
diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 1ac0c7990392..087170a9b148 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -30,5 +30,6 @@ config CLK_IMX8QXP
 	bool "IMX8QXP SCU Clock"
 	depends on ARCH_MXC && IMX_SCU && ARM64
 	select MXC_CLK_SCU
+	select MXC_CLK
 	help
 	  Build the driver for IMX8QXP SCU based clocks.
diff --git a/drivers/clk/keystone/pll.c b/drivers/clk/keystone/pll.c
index ee5c72369334..6bbdd4705d71 100644
--- a/drivers/clk/keystone/pll.c
+++ b/drivers/clk/keystone/pll.c
@@ -281,12 +281,13 @@ static void __init of_pll_div_clk_init(struct device_node *node)
 
 	clk = clk_register_divider(NULL, clk_name, parent_name, 0, reg, shift,
 				 mask, 0, NULL);
-	if (clk) {
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	} else {
+	if (IS_ERR(clk)) {
 		pr_err("%s: error registering divider %s\n", __func__, clk_name);
 		iounmap(reg);
+		return;
 	}
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
 }
 CLK_OF_DECLARE(pll_divider_clock, "ti,keystone,pll-divider-clock", of_pll_div_clk_init);
 
@@ -328,10 +329,12 @@ static void __init of_pll_mux_clk_init(struct device_node *node)
 	clk = clk_register_mux(NULL, clk_name, (const char **)&parents,
 				ARRAY_SIZE(parents) , 0, reg, shift, mask,
 				0, NULL);
-	if (clk)
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	else
+	if (IS_ERR(clk)) {
 		pr_err("%s: error registering mux %s\n", __func__, clk_name);
+		return;
+	}
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
 }
 CLK_OF_DECLARE(pll_mux_clock, "ti,keystone,pll-mux-clock", of_pll_mux_clk_init);
 
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 695be0f77427..c67cd73aca17 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -675,6 +675,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 								clk_data);
@@ -742,6 +744,8 @@ static void __init mtk_infrasys_init_early(struct device_node *node)
 
 	if (!infra_clk_data) {
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		if (!infra_clk_data)
+			return;
 
 		for (i = 0; i < CLK_INFRA_NR; i++)
 			infra_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
@@ -768,6 +772,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 
 	if (!infra_clk_data) {
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		if (!infra_clk_data)
+			return -ENOMEM;
 	} else {
 		for (i = 0; i < CLK_INFRA_NR; i++) {
 			if (infra_clk_data->clks[i] == ERR_PTR(-EPROBE_DEFER))
@@ -896,6 +902,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
 						clk_data);
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 00920182bbe6..f7b5ec749ab9 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1216,6 +1216,8 @@ static int clk_mt6779_apmixed_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
@@ -1237,6 +1239,8 @@ static int clk_mt6779_top_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 				    clk_data);
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index f62b0428da0e..9bef47161bde 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -392,6 +392,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_factors(top_fixed_divs, ARRAY_SIZE(top_fixed_divs),
 				 clk_data);
@@ -564,6 +566,8 @@ static void mtk_infrasys_init_early(struct device_node *node)
 
 	if (!infra_clk_data) {
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		if (!infra_clk_data)
+			return;
 
 		for (i = 0; i < CLK_INFRA_NR; i++)
 			infra_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
@@ -588,6 +592,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 
 	if (!infra_clk_data) {
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		if (!infra_clk_data)
+			return -ENOMEM;
 	} else {
 		for (i = 0; i < CLK_INFRA_NR; i++) {
 			if (infra_clk_data->clks[i] == ERR_PTR(-EPROBE_DEFER))
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 88279d0ea1a7..3ab7b672f8c7 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -83,6 +83,8 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_ETH_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, eth_clks, CLK_ETH_NR_CLK, clk_data);
 
@@ -105,6 +107,8 @@ static int clk_mt7629_sgmiisys_init(struct platform_device *pdev)
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_SGMII_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, sgmii_clks[id++], CLK_SGMII_NR_CLK,
 			       clk_data);
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index d6233994af5a..1e6abbddf02c 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -581,6 +581,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 				    clk_data);
@@ -605,6 +607,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 			       clk_data);
@@ -633,6 +637,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
 			       clk_data);
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 89c1adeb84d4..40374f3d3d20 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -146,17 +146,11 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
 static unsigned long
 calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 hid_div)
 {
-	if (hid_div) {
-		rate *= 2;
-		rate /= hid_div + 1;
-	}
+	if (hid_div)
+		rate = mult_frac(rate, 2, hid_div + 1);
 
-	if (mode) {
-		u64 tmp = rate;
-		tmp *= m;
-		do_div(tmp, n);
-		rate = tmp;
-	}
+	if (mode)
+		rate = mult_frac(rate, m, n);
 
 	return rate;
 }
diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index ee908fbfeab1..68ea6a846a15 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -250,7 +250,7 @@ static struct clk_rcg2 gcc_cpuss_ahb_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_cpuss_ahb_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -273,7 +273,7 @@ static struct clk_rcg2 gcc_emac_ptp_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_emac_ptp_clk_src",
 		.parent_data = gcc_parents_5,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -299,7 +299,7 @@ static struct clk_rcg2 gcc_emac_rgmii_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_emac_rgmii_clk_src",
 		.parent_data = gcc_parents_5,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -323,7 +323,7 @@ static struct clk_rcg2 gcc_gp1_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_gp1_clk_src",
 		.parent_data = gcc_parents_1,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parents_1),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -338,7 +338,7 @@ static struct clk_rcg2 gcc_gp2_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_gp2_clk_src",
 		.parent_data = gcc_parents_1,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parents_1),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -353,7 +353,7 @@ static struct clk_rcg2 gcc_gp3_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_gp3_clk_src",
 		.parent_data = gcc_parents_1,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parents_1),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -374,7 +374,7 @@ static struct clk_rcg2 gcc_pcie_0_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pcie_0_aux_clk_src",
 		.parent_data = gcc_parents_2,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parents_2),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -389,7 +389,7 @@ static struct clk_rcg2 gcc_pcie_1_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pcie_1_aux_clk_src",
 		.parent_data = gcc_parents_2,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parents_2),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -410,7 +410,7 @@ static struct clk_rcg2 gcc_pcie_phy_refgen_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pcie_phy_refgen_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -432,7 +432,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pdm2_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -455,7 +455,7 @@ static struct clk_rcg2 gcc_qspi_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qspi_core_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -489,7 +489,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s0_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -504,7 +504,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s1_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -519,7 +519,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s2_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -534,7 +534,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s3_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -549,7 +549,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s4_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -564,7 +564,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s5_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -579,7 +579,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s6_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -594,7 +594,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap0_s7_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -609,7 +609,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap1_s0_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -624,7 +624,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap1_s1_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -639,7 +639,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap1_s2_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -654,7 +654,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap1_s3_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -669,7 +669,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap1_s4_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -684,7 +684,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap1_s5_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -699,7 +699,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s0_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap2_s0_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -714,7 +714,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s1_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap2_s1_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -729,7 +729,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s2_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap2_s2_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -744,7 +744,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s3_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap2_s3_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -759,7 +759,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s4_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap2_s4_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -774,7 +774,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s5_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qupv3_wrap2_s5_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -800,8 +800,8 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parents_6,
-		.num_parents = 5,
-		.flags = CLK_SET_RATE_PARENT,
+		.num_parents = ARRAY_SIZE(gcc_parents_6),
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
@@ -825,7 +825,7 @@ static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_sdcc4_apps_clk_src",
 		.parent_data = gcc_parents_3,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_floor_ops,
 	},
@@ -845,7 +845,7 @@ static struct clk_rcg2 gcc_tsif_ref_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_tsif_ref_clk_src",
 		.parent_data = gcc_parents_7,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parents_7),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -869,7 +869,7 @@ static struct clk_rcg2 gcc_ufs_card_axi_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_axi_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -892,7 +892,7 @@ static struct clk_rcg2 gcc_ufs_card_ice_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_ice_core_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -912,7 +912,7 @@ static struct clk_rcg2 gcc_ufs_card_phy_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_phy_aux_clk_src",
 		.parent_data = gcc_parents_4,
-		.num_parents = 2,
+		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -934,7 +934,7 @@ static struct clk_rcg2 gcc_ufs_card_unipro_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_unipro_core_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -958,7 +958,7 @@ static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_axi_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -973,7 +973,7 @@ static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_ice_core_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -988,7 +988,7 @@ static struct clk_rcg2 gcc_ufs_phy_phy_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_phy_aux_clk_src",
 		.parent_data = gcc_parents_4,
-		.num_parents = 2,
+		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1003,7 +1003,7 @@ static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_unipro_core_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1027,7 +1027,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_prim_master_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1049,7 +1049,7 @@ static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_prim_mock_utmi_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1064,7 +1064,7 @@ static struct clk_rcg2 gcc_usb30_sec_master_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_sec_master_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1079,7 +1079,7 @@ static struct clk_rcg2 gcc_usb30_sec_mock_utmi_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_sec_mock_utmi_clk_src",
 		.parent_data = gcc_parents_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parents_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1094,7 +1094,7 @@ static struct clk_rcg2 gcc_usb3_prim_phy_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb3_prim_phy_aux_clk_src",
 		.parent_data = gcc_parents_2,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parents_2),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1109,7 +1109,7 @@ static struct clk_rcg2 gcc_usb3_sec_phy_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb3_sec_phy_aux_clk_src",
 		.parent_data = gcc_parents_2,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parents_2),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index fdd994ee55e2..2db88213f13e 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -553,7 +553,8 @@ static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
 		return -EINVAL;
 	}
 
-	ctx->cdata.key_virt = key;
+	memcpy(ctx->key, key, keylen);
+	ctx->cdata.key_virt = ctx->key;
 	ctx->cdata.keylen = keylen - saltlen;
 
 	return chachapoly_set_sh_desc(aead);
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 28692d068176..b8d277bfbd32 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -639,7 +639,8 @@ static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
 		return -EINVAL;
 	}
 
-	ctx->cdata.key_virt = key;
+	memcpy(ctx->key, key, keylen);
+	ctx->cdata.key_virt = ctx->key;
 	ctx->cdata.keylen = keylen - saltlen;
 
 	return chachapoly_set_sh_desc(aead);
diff --git a/drivers/crypto/chelsio/chtls/chtls_cm.c b/drivers/crypto/chelsio/chtls/chtls_cm.c
index 3b79bcd03e7b..40054731f800 100644
--- a/drivers/crypto/chelsio/chtls/chtls_cm.c
+++ b/drivers/crypto/chelsio/chtls/chtls_cm.c
@@ -2092,7 +2092,7 @@ static void chtls_rx_ack(struct sock *sk, struct sk_buff *skb)
 
 		if (tp->snd_una != snd_una) {
 			tp->snd_una = snd_una;
-			tp->rcv_tstamp = tcp_time_stamp(tp);
+			tp->rcv_tstamp = tcp_jiffies32;
 			if (tp->snd_una == tp->snd_nxt &&
 			    !csk_flag_nochk(csk, CSK_TX_FAILOVER))
 				csk_reset_flag(csk, CSK_TX_WAIT_IDLE);
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 68d9d60c051d..9ce75ff9fa1c 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -723,7 +723,6 @@ static void pxad_free_desc(struct virt_dma_desc *vd)
 	dma_addr_t dma;
 	struct pxad_desc_sw *sw_desc = to_pxad_sw_desc(vd);
 
-	BUG_ON(sw_desc->nb_desc == 0);
 	for (i = sw_desc->nb_desc - 1; i >= 0; i--) {
 		if (i > 0)
 			dma = sw_desc->hw_desc[i - 1]->ddadr;
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 80b780e49971..b570f08888ee 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2361,7 +2361,7 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq < 0 && node)
 		irq = irq_of_parse_and_map(node, 0);
 
-	if (irq >= 0) {
+	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
 					  dev_name(dev));
 		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
@@ -2377,7 +2377,7 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq < 0 && node)
 		irq = irq_of_parse_and_map(node, 2);
 
-	if (irq >= 0) {
+	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
 					  dev_name(dev));
 		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 4126be9e3216..54340869e682 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments System Control Interface Protocol Driver
  *
- * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
  *	Nishanth Menon
  */
 
@@ -208,19 +208,6 @@ static int ti_sci_debugfs_create(struct platform_device *pdev,
 	return 0;
 }
 
-/**
- * ti_sci_debugfs_destroy() - clean up log debug file
- * @pdev:	platform device pointer
- * @info:	Pointer to SCI entity information
- */
-static void ti_sci_debugfs_destroy(struct platform_device *pdev,
-				   struct ti_sci_info *info)
-{
-	if (IS_ERR(info->debug_region))
-		return;
-
-	debugfs_remove(info->d);
-}
 #else /* CONFIG_DEBUG_FS */
 static inline int ti_sci_debugfs_create(struct platform_device *dev,
 					struct ti_sci_info *info)
@@ -3527,43 +3514,12 @@ static int ti_sci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ti_sci_remove(struct platform_device *pdev)
-{
-	struct ti_sci_info *info;
-	struct device *dev = &pdev->dev;
-	int ret = 0;
-
-	of_platform_depopulate(dev);
-
-	info = platform_get_drvdata(pdev);
-
-	if (info->nb.notifier_call)
-		unregister_restart_handler(&info->nb);
-
-	mutex_lock(&ti_sci_list_mutex);
-	if (info->users)
-		ret = -EBUSY;
-	else
-		list_del(&info->node);
-	mutex_unlock(&ti_sci_list_mutex);
-
-	if (!ret) {
-		ti_sci_debugfs_destroy(pdev, info);
-
-		/* Safe to free channels since no more users */
-		mbox_free_channel(info->chan_tx);
-		mbox_free_channel(info->chan_rx);
-	}
-
-	return ret;
-}
-
 static struct platform_driver ti_sci_driver = {
 	.probe = ti_sci_probe,
-	.remove = ti_sci_remove,
 	.driver = {
 		   .name = "ti-sci",
 		   .of_match_table = of_match_ptr(ti_sci_of_match),
+		   .suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(ti_sci_driver);
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index f0d068c03944..57cd04062994 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -6,7 +6,7 @@
  * The system works in a message response protocol
  * See: http://processors.wiki.ti.com/index.php/TISCI for details
  *
- * Copyright (C)  2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C)  2015-2016 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __TI_SCI_H
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index e558381c4c96..8b155e3377cf 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -921,7 +921,8 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 		fence = drm_syncobj_fence_get(syncobjs[i]);
 		if (!fence || dma_fence_chain_find_seqno(&fence, points[i])) {
 			dma_fence_put(fence);
-			if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
+			if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
+				     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)) {
 				continue;
 			} else {
 				timeout = -EINVAL;
diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 1d978a3d9c82..2156590c3d15 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -4819,14 +4819,15 @@ int evergreen_irq_process(struct radeon_device *rdev)
 			break;
 		case 44: /* hdmi */
 			afmt_idx = src_data;
-			if (!(afmt_status[afmt_idx] & AFMT_AZ_FORMAT_WTRIG))
-				DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
-
 			if (afmt_idx > 5) {
 				DRM_ERROR("Unhandled interrupt: %d %d\n",
 					  src_id, src_data);
 				break;
 			}
+
+			if (!(afmt_status[afmt_idx] & AFMT_AZ_FORMAT_WTRIG))
+				DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
+
 			afmt_status[afmt_idx] &= ~AFMT_AZ_FORMAT_WTRIG;
 			queue_hdmi = true;
 			DRM_DEBUG("IH: HDMI%d\n", afmt_idx + 1);
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 2ea672f4420d..df2656471e31 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1147,6 +1147,7 @@ static int cdn_dp_probe(struct platform_device *pdev)
 	struct cdn_dp_device *dp;
 	struct extcon_dev *extcon;
 	struct phy *phy;
+	int ret;
 	int i;
 
 	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
@@ -1187,9 +1188,19 @@ static int cdn_dp_probe(struct platform_device *pdev)
 	mutex_init(&dp->lock);
 	dev_set_drvdata(dev, dp);
 
-	cdn_dp_audio_codec_init(dp, dev);
+	ret = cdn_dp_audio_codec_init(dp, dev);
+	if (ret)
+		return ret;
+
+	ret = component_add(dev, &cdn_dp_component_ops);
+	if (ret)
+		goto err_audio_deinit;
 
-	return component_add(dev, &cdn_dp_component_ops);
+	return 0;
+
+err_audio_deinit:
+	platform_device_unregister(dp->audio_pdev);
+	return ret;
 }
 
 static int cdn_dp_remove(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 1795adbd81d3..20aa93fe9e3f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1291,7 +1291,8 @@ static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
 	if (WARN_ON(!crtc->state))
 		return NULL;
 
-	rockchip_state = kzalloc(sizeof(*rockchip_state), GFP_KERNEL);
+	rockchip_state = kmemdup(to_rockchip_crtc_state(crtc->state),
+				 sizeof(*rockchip_state), GFP_KERNEL);
 	if (!rockchip_state)
 		return NULL;
 
@@ -1316,7 +1317,10 @@ static void vop_crtc_reset(struct drm_crtc *crtc)
 	if (crtc->state)
 		vop_crtc_destroy_state(crtc, crtc->state);
 
-	__drm_atomic_helper_crtc_reset(crtc, &crtc_state->base);
+	if (crtc_state)
+		__drm_atomic_helper_crtc_reset(crtc, &crtc_state->base);
+	else
+		__drm_atomic_helper_crtc_reset(crtc, NULL);
 }
 
 #ifdef CONFIG_DRM_ANALOGIX_DP
diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 340408f8c8ab..648201b6c624 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1156,8 +1156,6 @@ static unsigned int cp2112_gpio_irq_startup(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct cp2112_device *dev = gpiochip_get_data(gc);
 
-	INIT_DELAYED_WORK(&dev->gpio_poll_worker, cp2112_gpio_poll_callback);
-
 	if (!dev->gpio_poll) {
 		dev->gpio_poll = true;
 		schedule_delayed_work(&dev->gpio_poll_worker, 0);
@@ -1240,6 +1238,7 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct cp2112_device *dev;
 	u8 buf[3];
 	struct cp2112_smbus_config_report config;
+	struct gpio_irq_chip *girq;
 	int ret;
 
 	dev = devm_kzalloc(&hdev->dev, sizeof(*dev), GFP_KERNEL);
@@ -1343,6 +1342,17 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	dev->gc.can_sleep		= 1;
 	dev->gc.parent			= &hdev->dev;
 
+	girq = &dev->gc.irq;
+	girq->chip = &cp2112_gpio_irqchip;
+	/* The event comes from the outside so no parent handler */
+	girq->parent_handler = NULL;
+	girq->num_parents = 0;
+	girq->parents = NULL;
+	girq->default_type = IRQ_TYPE_NONE;
+	girq->handler = handle_simple_irq;
+
+	INIT_DELAYED_WORK(&dev->gpio_poll_worker, cp2112_gpio_poll_callback);
+
 	ret = gpiochip_add_data(&dev->gc, dev);
 	if (ret < 0) {
 		hid_err(hdev, "error registering gpio chip\n");
@@ -1358,17 +1368,8 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	chmod_sysfs_attrs(hdev);
 	hid_hw_power(hdev, PM_HINT_NORMAL);
 
-	ret = gpiochip_irqchip_add(&dev->gc, &cp2112_gpio_irqchip, 0,
-				   handle_simple_irq, IRQ_TYPE_NONE);
-	if (ret) {
-		dev_err(dev->gc.parent, "failed to add IRQ chip\n");
-		goto err_sysfs_remove;
-	}
-
 	return ret;
 
-err_sysfs_remove:
-	sysfs_remove_group(&hdev->dev.kobj, &cp2112_attr_group);
 err_gpiochip_remove:
 	gpiochip_remove(&dev->gc);
 err_free_i2c:
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index e232f44f6c9a..0eabad344961 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -41,7 +41,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 #define PKG_SYSFS_ATTR_NO	1	/* Sysfs attribute for package temp */
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
 #define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
-#define CORETEMP_NAME_LENGTH	19	/* String Length of attrs */
+#define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
 #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 6cc71c90f85e..02dc8e29c828 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1469,9 +1469,11 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 			desc->dev->dev.of_node = desc->boardinfo->of_node;
 
 		ret = device_register(&desc->dev->dev);
-		if (ret)
+		if (ret) {
 			dev_err(&master->dev,
 				"Failed to add I3C device (err = %d)\n", ret);
+			put_device(&desc->dev->dev);
+		}
 	}
 }
 
diff --git a/drivers/infiniband/hw/hfi1/efivar.c b/drivers/infiniband/hw/hfi1/efivar.c
index d106d23016ba..75e39e403a58 100644
--- a/drivers/infiniband/hw/hfi1/efivar.c
+++ b/drivers/infiniband/hw/hfi1/efivar.c
@@ -152,7 +152,7 @@ int read_hfi1_efi_var(struct hfi1_devdata *dd, const char *kind,
 		      unsigned long *size, void **return_data)
 {
 	char prefix_name[64];
-	char name[64];
+	char name[128];
 	int result;
 	int i;
 
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index af706a583656..1e3aaff310c9 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -276,11 +276,11 @@ void rmi_unregister_function(struct rmi_function *fn)
 
 	device_del(&fn->dev);
 	of_node_put(fn->dev.of_node);
-	put_device(&fn->dev);
 
 	for (i = 0; i < fn->num_of_irqs; i++)
 		irq_dispose_mapping(fn->irq[i]);
 
+	put_device(&fn->dev);
 }
 
 /**
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 0a35499c4672..94cba5914788 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 Interrupt Aggregator irqchip driver
  *
- * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index 7d0163d85fb9..6b366d98fe3c 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 Interrupt Router irqchip driver
  *
- * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 8b6965a563e9..acc99e01eb4a 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -22,9 +22,8 @@
 struct led_pwm_data {
 	struct led_classdev	cdev;
 	struct pwm_device	*pwm;
+	struct pwm_state	pwmstate;
 	unsigned int		active_low;
-	unsigned int		period;
-	int			duty;
 };
 
 struct led_pwm_priv {
@@ -32,44 +31,29 @@ struct led_pwm_priv {
 	struct led_pwm_data leds[0];
 };
 
-static void __led_pwm_set(struct led_pwm_data *led_dat)
-{
-	int new_duty = led_dat->duty;
-
-	pwm_config(led_dat->pwm, new_duty, led_dat->period);
-
-	if (new_duty == 0)
-		pwm_disable(led_dat->pwm);
-	else
-		pwm_enable(led_dat->pwm);
-}
-
 static int led_pwm_set(struct led_classdev *led_cdev,
 		       enum led_brightness brightness)
 {
 	struct led_pwm_data *led_dat =
 		container_of(led_cdev, struct led_pwm_data, cdev);
 	unsigned int max = led_dat->cdev.max_brightness;
-	unsigned long long duty =  led_dat->period;
+	unsigned long long duty = led_dat->pwmstate.period;
 
 	duty *= brightness;
 	do_div(duty, max);
 
 	if (led_dat->active_low)
-		duty = led_dat->period - duty;
-
-	led_dat->duty = duty;
-
-	__led_pwm_set(led_dat);
+		duty = led_dat->pwmstate.period - duty;
 
-	return 0;
+	led_dat->pwmstate.duty_cycle = duty;
+	led_dat->pwmstate.enabled = true;
+	return pwm_apply_state(led_dat->pwm, &led_dat->pwmstate);
 }
 
 static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		       struct led_pwm *led, struct fwnode_handle *fwnode)
 {
 	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
-	struct pwm_args pargs;
 	int ret;
 
 	led_data->active_low = led->active_low;
@@ -93,17 +77,10 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 
 	led_data->cdev.brightness_set_blocking = led_pwm_set;
 
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to the
-	 * atomic PWM API.
-	 */
-	pwm_apply_args(led_data->pwm);
-
-	pwm_get_args(led_data->pwm, &pargs);
+	pwm_init_state(led_data->pwm, &led_data->pwmstate);
 
-	led_data->period = pargs.period;
-	if (!led_data->period && (led->pwm_period_ns > 0))
-		led_data->period = led->pwm_period_ns;
+	if (!led_data->pwmstate.period)
+		led_data->pwmstate.period = led->pwm_period_ns;
 
 	ret = devm_led_classdev_register(dev, &led_data->cdev);
 	if (ret == 0) {
diff --git a/drivers/leds/trigger/ledtrig-cpu.c b/drivers/leds/trigger/ledtrig-cpu.c
index 869976d1b734..f19baed61502 100644
--- a/drivers/leds/trigger/ledtrig-cpu.c
+++ b/drivers/leds/trigger/ledtrig-cpu.c
@@ -2,14 +2,18 @@
 /*
  * ledtrig-cpu.c - LED trigger based on CPU activity
  *
- * This LED trigger will be registered for each possible CPU and named as
- * cpu0, cpu1, cpu2, cpu3, etc.
+ * This LED trigger will be registered for first 8 CPUs and named
+ * as cpu0..cpu7. There's additional trigger called cpu that
+ * is on when any CPU is active.
+ *
+ * If you want support for arbitrary number of CPUs, make it one trigger,
+ * with additional sysfs file selecting which CPU to watch.
  *
  * It can be bound to any LED just like other triggers using either a
  * board file or via sysfs interface.
  *
  * An API named ledtrig_cpu is exported for any user, who want to add CPU
- * activity indication in their code
+ * activity indication in their code.
  *
  * Copyright 2011 Linus Walleij <linus.walleij@linaro.org>
  * Copyright 2011 - 2012 Bryan Wu <bryan.wu@canonical.com>
@@ -126,7 +130,7 @@ static int ledtrig_prepare_down_cpu(unsigned int cpu)
 
 static int __init ledtrig_cpu_init(void)
 {
-	int cpu;
+	unsigned int cpu;
 	int ret;
 
 	/* Supports up to 9999 cpu cores */
@@ -145,7 +149,10 @@ static int __init ledtrig_cpu_init(void)
 	for_each_possible_cpu(cpu) {
 		struct led_trigger_cpu *trig = &per_cpu(cpu_trig, cpu);
 
-		snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
+		if (cpu >= 8)
+			continue;
+
+		snprintf(trig->name, MAX_NAME_LEN, "cpu%u", cpu);
 
 		led_trigger_register_simple(trig->name, &trig->_trig);
 	}
diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index 6441e7d63d97..a0be1ca89b29 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -4258,6 +4258,7 @@ static void bttv_remove(struct pci_dev *pci_dev)
 
 	/* free resources */
 	free_irq(btv->c.pci->irq,btv);
+	del_timer_sync(&btv->timeout);
 	iounmap(btv->bt848_mmio);
 	release_mem_region(pci_resource_start(btv->c.pci,0),
 			   pci_resource_len(btv->c.pci,0));
diff --git a/drivers/media/platform/s3c-camif/camif-capture.c b/drivers/media/platform/s3c-camif/camif-capture.c
index 2fb45db8e4ba..d24ef08633ab 100644
--- a/drivers/media/platform/s3c-camif/camif-capture.c
+++ b/drivers/media/platform/s3c-camif/camif-capture.c
@@ -1132,12 +1132,12 @@ int s3c_camif_register_video_node(struct camif_dev *camif, int idx)
 
 	ret = vb2_queue_init(q);
 	if (ret)
-		goto err_vd_rel;
+		return ret;
 
 	vp->pad.flags = MEDIA_PAD_FL_SINK;
 	ret = media_entity_pads_init(&vfd->entity, 1, &vp->pad);
 	if (ret)
-		goto err_vd_rel;
+		return ret;
 
 	video_set_drvdata(vfd, vp);
 
@@ -1170,8 +1170,6 @@ int s3c_camif_register_video_node(struct camif_dev *camif, int idx)
 	v4l2_ctrl_handler_free(&vp->ctrl_handler);
 err_me_cleanup:
 	media_entity_cleanup(&vfd->entity);
-err_vd_rel:
-	video_device_release(vfd);
 	return ret;
 }
 
diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index 66dd1bdf6440..c5f6af5debaf 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -322,8 +322,10 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
-			if (msg[0].len < 3 || msg[1].len < 1)
-				return -EOPNOTSUPP;
+			if (msg[0].len < 3 || msg[1].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto unlock;
+			}
 			/* demod access via firmware interface */
 			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
@@ -383,8 +385,10 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
-			if (msg[0].len < 3)
-				return -EOPNOTSUPP;
+			if (msg[0].len < 3) {
+				ret = -EOPNOTSUPP;
+				goto unlock;
+			}
 			/* demod access via firmware interface */
 			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
@@ -459,6 +463,7 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 		ret = -EOPNOTSUPP;
 	}
 
+unlock:
 	mutex_unlock(&d->i2c_mutex);
 
 	if (ret < 0)
diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 80952237e4b4..707f4287ab4a 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -797,7 +797,6 @@ static int dln2_probe(struct usb_interface *interface,
 	dln2_stop_rx_urbs(dln2);
 
 out_free:
-	usb_put_dev(dln2->usb_dev);
 	dln2_free(dln2);
 
 	return ret;
diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 7d9e23aa0b92..c19460e7f0f1 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -15,6 +15,7 @@
 #include <linux/skbuff.h>
 
 #include <linux/ti_wilink_st.h>
+#include <linux/netdevice.h>
 
 extern void st_kim_recv(void *, const unsigned char *, long);
 void st_int_recv(void *, const unsigned char *, long);
@@ -423,7 +424,7 @@ static void st_int_enqueue(struct st_data_s *st_gdata, struct sk_buff *skb)
 	case ST_LL_AWAKE_TO_ASLEEP:
 		pr_err("ST LL is illegal state(%ld),"
 			   "purging received skb.", st_ll_getstate(st_gdata));
-		kfree_skb(skb);
+		dev_kfree_skb_irq(skb);
 		break;
 	case ST_LL_ASLEEP:
 		skb_queue_tail(&st_gdata->tx_waitq, skb);
@@ -432,7 +433,7 @@ static void st_int_enqueue(struct st_data_s *st_gdata, struct sk_buff *skb)
 	default:
 		pr_err("ST LL is illegal state(%ld),"
 			   "purging received skb.", st_ll_getstate(st_gdata));
-		kfree_skb(skb);
+		dev_kfree_skb_irq(skb);
 		break;
 	}
 
@@ -486,7 +487,7 @@ void st_tx_wakeup(struct st_data_s *st_data)
 				spin_unlock_irqrestore(&st_data->lock, flags);
 				break;
 			}
-			kfree_skb(skb);
+			dev_kfree_skb_irq(skb);
 			spin_unlock_irqrestore(&st_data->lock, flags);
 		}
 		/* if wake-up is set in another context- restart sending */
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6609acf27923..ed939bb2f700 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -95,7 +95,7 @@ static int mmc_decode_cid(struct mmc_card *card)
 	case 3: /* MMC v3.1 - v3.3 */
 	case 4: /* MMC v4 */
 		card->cid.manfid	= UNSTUFF_BITS(resp, 120, 8);
-		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 8);
+		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 16);
 		card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
 		card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
 		card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 322da89cb9c6..05a2c873af56 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -552,7 +552,8 @@ static void can_restart(struct net_device *dev)
 	struct can_frame *cf;
 	int err;
 
-	BUG_ON(netif_carrier_ok(dev));
+	if (netif_carrier_ok(dev))
+		netdev_err(dev, "Attempt to restart for bus-off recovery, but carrier is OK?\n");
 
 	/* No synchronization needed because the device is bus-off and
 	 * no messages can come in or go out.
@@ -577,11 +578,12 @@ static void can_restart(struct net_device *dev)
 	priv->can_stats.restarts++;
 
 	/* Now restart the device */
-	err = priv->do_set_mode(dev, CAN_MODE_START);
-
 	netif_carrier_on(dev);
-	if (err)
+	err = priv->do_set_mode(dev, CAN_MODE_START);
+	if (err) {
 		netdev_err(dev, "Error %d during restart", err);
+		netif_carrier_off(dev);
+	}
 }
 
 static void can_restart_work(struct work_struct *work)
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index b16517d162cf..90bfaea6d629 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18164,7 +18164,8 @@ static void tg3_shutdown(struct pci_dev *pdev)
 	if (netif_running(dev))
 		dev_close(dev);
 
-	tg3_power_down(tp);
+	if (system_state == SYSTEM_POWER_OFF)
+		tg3_power_down(tp);
 
 	rtnl_unlock();
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 351d4c53297f..3ccc248b1a8a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15553,11 +15553,15 @@ static void i40e_remove(struct pci_dev *pdev)
 			i40e_switch_branch_release(pf->veb[i]);
 	}
 
-	/* Now we can shutdown the PF's VSI, just before we kill
+	/* Now we can shutdown the PF's VSIs, just before we kill
 	 * adminq and hmc.
 	 */
-	if (pf->vsi[pf->lan_vsi])
-		i40e_vsi_release(pf->vsi[pf->lan_vsi]);
+	for (i = pf->num_alloc_vsi; i--;)
+		if (pf->vsi[i]) {
+			i40e_vsi_close(pf->vsi[i]);
+			i40e_vsi_release(pf->vsi[i]);
+			pf->vsi[i] = NULL;
+		}
 
 	i40e_cloud_filter_exit(pf);
 
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index fca2dbdd37af..28e2cd9c386a 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4288,9 +4288,13 @@ static void rtl_set_rx_mode(struct net_device *dev)
 		/* Unconditionally log net taps. */
 		netif_notice(tp, link, dev, "Promiscuous mode enabled\n");
 		rx_mode |= AcceptAllPhys;
+	} else if (!(dev->flags & IFF_MULTICAST)) {
+		rx_mode &= ~AcceptMulticast;
 	} else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
 		   dev->flags & IFF_ALLMULTI ||
-		   tp->mac_version == RTL_GIGA_MAC_VER_35) {
+		   tp->mac_version == RTL_GIGA_MAC_VER_35 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_46 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_48) {
 		/* accept all multicasts */
 	} else if (netdev_mc_empty(dev)) {
 		rx_mode &= ~AcceptMulticast;
@@ -6293,12 +6297,17 @@ static void rtl8169_rx_missed(struct net_device *dev)
 static void r8169_phylink_handler(struct net_device *ndev)
 {
 	struct rtl8169_private *tp = netdev_priv(ndev);
+	struct device *d = tp_to_dev(tp);
 
 	if (netif_carrier_ok(ndev)) {
 		rtl_link_chg_patch(tp);
-		pm_request_resume(&tp->pci_dev->dev);
+		pm_request_resume(d);
+		netif_wake_queue(tp->dev);
 	} else {
-		pm_runtime_idle(&tp->pci_dev->dev);
+		/* In few cases rx is broken after link-down otherwise */
+		if (rtl_is_8125(tp))
+			rtl_reset_work(tp);
+		pm_runtime_idle(d);
 	}
 
 	if (net_ratelimit())
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index ff751ab3d765..5efb9cf99b52 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -212,7 +212,7 @@
 	((val) << XGMAC_PPS_MINIDX(x))
 #define XGMAC_PPSCMD_START		0x2
 #define XGMAC_PPSCMD_STOP		0x5
-#define XGMAC_PPSEN0			BIT(4)
+#define XGMAC_PPSENx(x)			BIT(4 + (x) * 8)
 #define XGMAC_PPSx_TARGET_TIME_SEC(x)	(0x00000d80 + (x) * 0x10)
 #define XGMAC_PPSx_TARGET_TIME_NSEC(x)	(0x00000d84 + (x) * 0x10)
 #define XGMAC_TRGTBUSY0			BIT(31)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 070bd7d1ae4c..06fe2f185e0b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1101,7 +1101,19 @@ static int dwxgmac2_flex_pps_config(void __iomem *ioaddr, int index,
 
 	val |= XGMAC_PPSCMDx(index, XGMAC_PPSCMD_START);
 	val |= XGMAC_TRGTMODSELx(index, XGMAC_PPSCMD_START);
-	val |= XGMAC_PPSEN0;
+
+	/* XGMAC Core has 4 PPS outputs at most.
+	 *
+	 * Prior XGMAC Core 3.20, Fixed mode or Flexible mode are selectable for
+	 * PPS0 only via PPSEN0. PPS{1,2,3} are in Flexible mode by default,
+	 * and can not be switched to Fixed mode, since PPSEN{1,2,3} are
+	 * read-only reserved to 0.
+	 * But we always set PPSEN{1,2,3} do not make things worse ;-)
+	 *
+	 * From XGMAC Core 3.20 and later, PPSEN{0,1,2,3} are writable and must
+	 * be set, or the PPS outputs stay in Fixed PPS mode by default.
+	 */
+	val |= XGMAC_PPSENx(index);
 
 	writel(cfg->start.tv_sec, ioaddr + XGMAC_PPSx_TARGET_TIME_SEC(index));
 
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index ab09d110760e..b5a61b16a7ea 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -442,12 +442,12 @@ static int ipvlan_process_v4_outbound(struct sk_buff *skb)
 
 	err = ip_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out;
 err:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out:
 	return ret;
@@ -483,12 +483,12 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 
 	err = ip6_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out;
 err:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out:
 	return ret;
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 5fea2e4a9310..4edec38437d0 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -320,6 +320,7 @@ static void ipvlan_get_stats64(struct net_device *dev,
 		s->rx_dropped = rx_errs;
 		s->tx_dropped = tx_drps;
 	}
+	s->tx_errors = DEV_STATS_READ(dev, tx_errors);
 }
 
 static int ipvlan_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index c16688327753..d5f2d895dba2 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2995,9 +2995,9 @@ static void macsec_get_stats64(struct net_device *dev,
 		s->tx_bytes   += tmp.tx_bytes;
 	}
 
-	s->rx_dropped = atomic_long_read(&dev->stats.__rx_dropped);
-	s->tx_dropped = atomic_long_read(&dev->stats.__tx_dropped);
-	s->rx_errors = atomic_long_read(&dev->stats.__rx_errors);
+	s->rx_dropped = DEV_STATS_READ(dev, rx_dropped);
+	s->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
+	s->rx_errors = DEV_STATS_READ(dev, rx_errors);
 }
 
 static int macsec_get_iflink(const struct net_device *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/core.c b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
index e5af4f3389cc..47e36937a6ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
@@ -39,11 +39,13 @@ irqreturn_t mt7603_irq_handler(int irq, void *dev_instance)
 	}
 
 	if (intr & MT_INT_RX_DONE(0)) {
+		dev->rx_pse_check = 0;
 		mt7603_irq_disable(dev, MT_INT_RX_DONE(0));
 		napi_schedule(&dev->mt76.napi[0]);
 	}
 
 	if (intr & MT_INT_RX_DONE(1)) {
+		dev->rx_pse_check = 0;
 		mt7603_irq_disable(dev, MT_INT_RX_DONE(1));
 		napi_schedule(&dev->mt76.napi[1]);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index ff3f3d98b625..5cfea0d8c776 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1416,20 +1416,29 @@ static bool mt7603_rx_pse_busy(struct mt7603_dev *dev)
 {
 	u32 addr, val;
 
-	if (mt76_rr(dev, MT_MCU_DEBUG_RESET) & MT_MCU_DEBUG_RESET_QUEUES)
-		return true;
-
 	if (mt7603_rx_fifo_busy(dev))
-		return false;
+		goto out;
 
 	addr = mt7603_reg_map(dev, MT_CLIENT_BASE_PHYS_ADDR + MT_CLIENT_STATUS);
 	mt76_wr(dev, addr, 3);
 	val = mt76_rr(dev, addr) >> 16;
 
-	if (is_mt7628(dev) && (val & 0x4001) == 0x4001)
-		return true;
+	if (!(val & BIT(0)))
+		return false;
+
+	if (is_mt7628(dev))
+		val &= 0xa000;
+	else
+		val &= 0x8000;
+	if (!val)
+		return false;
+
+out:
+	if (mt76_rr(dev, MT_INT_SOURCE_CSR) &
+	    (MT_INT_RX_DONE(0) | MT_INT_RX_DONE(1)))
+		return false;
 
-	return (val & 0x8001) == 0x8001 || (val & 0xe001) == 0xe001;
+	return true;
 }
 
 static bool
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
index 333e355c9281..1ade4bea1d3f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
@@ -805,7 +805,7 @@ static void rtl88e_dm_check_edca_turbo(struct ieee80211_hw *hw)
 	}
 
 	if (rtlpriv->btcoexist.bt_edca_dl != 0) {
-		edca_be_ul = rtlpriv->btcoexist.bt_edca_dl;
+		edca_be_dl = rtlpriv->btcoexist.bt_edca_dl;
 		bt_change_edca = true;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
index f2908ee5f860..17680aa8c0bc 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
@@ -640,7 +640,7 @@ static void rtl92c_dm_check_edca_turbo(struct ieee80211_hw *hw)
 	}
 
 	if (rtlpriv->btcoexist.bt_edca_dl != 0) {
-		edca_be_ul = rtlpriv->btcoexist.bt_edca_dl;
+		edca_be_dl = rtlpriv->btcoexist.bt_edca_dl;
 		bt_change_edca = true;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
index d8260c7afe09..9afe6aace942 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
@@ -578,7 +578,7 @@ static void rtl8723e_dm_check_edca_turbo(struct ieee80211_hw *hw)
 	}
 
 	if (rtlpriv->btcoexist.bt_edca_dl != 0) {
-		edca_be_ul = rtlpriv->btcoexist.bt_edca_dl;
+		edca_be_dl = rtlpriv->btcoexist.bt_edca_dl;
 		bt_change_edca = true;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 5a906101498d..12d81ad8b702 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -658,9 +658,9 @@ static struct rtw_debugfs_priv rtw_debug_priv_rsvd_page = {
 #define rtw_debugfs_add_core(name, mode, fopname, parent)		\
 	do {								\
 		rtw_debug_priv_ ##name.rtwdev = rtwdev;			\
-		if (!debugfs_create_file(#name, mode,			\
+		if (IS_ERR(debugfs_create_file(#name, mode,		\
 					 parent, &rtw_debug_priv_ ##name,\
-					 &file_ops_ ##fopname))		\
+					 &file_ops_ ##fopname)))	\
 			pr_debug("Unable to initialize debugfs:%s\n",	\
 			       #name);					\
 	} while (0)
diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 97187d6c0bdb..d84776b1497f 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -42,7 +42,13 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->bus_desc.attr_groups = bus_attr_groups;
-	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
+	priv->bus_desc.provider_name = devm_kstrdup(&pdev->dev, pdev->name,
+							GFP_KERNEL);
+	if (!priv->bus_desc.provider_name) {
+		kfree(priv);
+		return -ENOMEM;
+	}
+
 	priv->bus_desc.module = THIS_MODULE;
 	priv->bus_desc.of_node = np;
 
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index b8236a9e8750..bfa310ab52e7 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -898,7 +898,8 @@ unsigned int nd_region_acquire_lane(struct nd_region *nd_region)
 {
 	unsigned int cpu, lane;
 
-	cpu = get_cpu();
+	migrate_disable();
+	cpu = smp_processor_id();
 	if (nd_region->num_lanes < nr_cpu_ids) {
 		struct nd_percpu_lane *ndl_lock, *ndl_count;
 
@@ -917,16 +918,15 @@ EXPORT_SYMBOL(nd_region_acquire_lane);
 void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane)
 {
 	if (nd_region->num_lanes < nr_cpu_ids) {
-		unsigned int cpu = get_cpu();
+		unsigned int cpu = smp_processor_id();
 		struct nd_percpu_lane *ndl_lock, *ndl_count;
 
 		ndl_count = per_cpu_ptr(nd_region->lane, cpu);
 		ndl_lock = per_cpu_ptr(nd_region->lane, lane);
 		if (--ndl_count->count == 0)
 			spin_unlock(&ndl_lock->lock);
-		put_cpu();
 	}
-	put_cpu();
+	migrate_enable();
 }
 EXPORT_SYMBOL(nd_region_release_lane);
 
diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index f70197154a36..820cce7c8b40 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -605,6 +605,7 @@ static int pccardd(void *__skt)
 		dev_warn(&skt->dev, "PCMCIA: unable to register socket\n");
 		skt->thread = NULL;
 		complete(&skt->thread_done);
+		put_device(&skt->dev);
 		return 0;
 	}
 	ret = pccard_sysfs_add_socket(&skt->dev);
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 09d06b082f8b..103862f7bdf1 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -518,9 +518,6 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
 	/* by default don't allow DMA */
 	p_dev->dma_mask = DMA_MASK_NONE;
 	p_dev->dev.dma_mask = &p_dev->dma_mask;
-	dev_set_name(&p_dev->dev, "%d.%d", p_dev->socket->sock, p_dev->device_no);
-	if (!dev_name(&p_dev->dev))
-		goto err_free;
 	p_dev->devname = kasprintf(GFP_KERNEL, "pcmcia%s", dev_name(&p_dev->dev));
 	if (!p_dev->devname)
 		goto err_free;
@@ -578,8 +575,15 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
 
 	pcmcia_device_query(p_dev);
 
-	if (device_register(&p_dev->dev))
-		goto err_unreg;
+	dev_set_name(&p_dev->dev, "%d.%d", p_dev->socket->sock, p_dev->device_no);
+	if (device_register(&p_dev->dev)) {
+		mutex_lock(&s->ops_mutex);
+		list_del(&p_dev->socket_device_list);
+		s->device_count--;
+		mutex_unlock(&s->ops_mutex);
+		put_device(&p_dev->dev);
+		return NULL;
+	}
 
 	return p_dev;
 
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 67c4ec554ada..66cfc35e4e3d 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -184,7 +184,7 @@ static int get_subobj_info(acpi_handle handle, const char *pathname,
 
 static acpi_status wmi_method_enable(struct wmi_block *wblock, int enable)
 {
-	struct guid_block *block = NULL;
+	struct guid_block *block;
 	char method[5];
 	acpi_status status;
 	acpi_handle handle;
@@ -258,8 +258,8 @@ EXPORT_SYMBOL_GPL(wmi_evaluate_method);
 acpi_status wmidev_evaluate_method(struct wmi_device *wdev, u8 instance,
 	u32 method_id, const struct acpi_buffer *in, struct acpi_buffer *out)
 {
-	struct guid_block *block = NULL;
-	struct wmi_block *wblock = NULL;
+	struct guid_block *block;
+	struct wmi_block *wblock;
 	acpi_handle handle;
 	acpi_status status;
 	struct acpi_object_list input;
@@ -306,7 +306,7 @@ EXPORT_SYMBOL_GPL(wmidev_evaluate_method);
 static acpi_status __query_block(struct wmi_block *wblock, u8 instance,
 				 struct acpi_buffer *out)
 {
-	struct guid_block *block = NULL;
+	struct guid_block *block;
 	acpi_handle handle;
 	acpi_status status, wc_status = AE_ERROR;
 	struct acpi_object_list input;
@@ -419,8 +419,8 @@ EXPORT_SYMBOL_GPL(wmidev_block_query);
 acpi_status wmi_set_block(const char *guid_string, u8 instance,
 			  const struct acpi_buffer *in)
 {
-	struct guid_block *block = NULL;
 	struct wmi_block *wblock = NULL;
+	struct guid_block *block;
 	acpi_handle handle;
 	struct acpi_object_list input;
 	union acpi_object params[2];
@@ -817,21 +817,13 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 }
 static int wmi_char_open(struct inode *inode, struct file *filp)
 {
-	const char *driver_name = filp->f_path.dentry->d_iname;
-	struct wmi_block *wblock = NULL;
-	struct wmi_block *next = NULL;
-
-	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
-		if (!wblock->dev.dev.driver)
-			continue;
-		if (strcmp(driver_name, wblock->dev.dev.driver->name) == 0) {
-			filp->private_data = wblock;
-			break;
-		}
-	}
+	/*
+	 * The miscdevice already stores a pointer to itself
+	 * inside filp->private_data
+	 */
+	struct wmi_block *wblock = container_of(filp->private_data, struct wmi_block, char_dev);
 
-	if (!filp->private_data)
-		return -ENODEV;
+	filp->private_data = wblock;
 
 	return nonseekable_open(inode, filp);
 }
@@ -851,8 +843,8 @@ static long wmi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	struct wmi_ioctl_buffer __user *input =
 		(struct wmi_ioctl_buffer __user *) arg;
 	struct wmi_block *wblock = filp->private_data;
-	struct wmi_ioctl_buffer *buf = NULL;
-	struct wmi_driver *wdriver = NULL;
+	struct wmi_ioctl_buffer *buf;
+	struct wmi_driver *wdriver;
 	int ret;
 
 	if (_IOC_TYPE(cmd) != WMI_IOC)
@@ -1154,8 +1146,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 	struct wmi_block *wblock, *next;
 	union acpi_object *obj;
 	acpi_status status;
-	int retval = 0;
 	u32 i, total;
+	int retval;
 
 	status = acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
 	if (ACPI_FAILURE(status))
@@ -1166,8 +1158,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		return -ENXIO;
 
 	if (obj->type != ACPI_TYPE_BUFFER) {
-		retval = -ENXIO;
-		goto out_free_pointer;
+		kfree(obj);
+		return -ENXIO;
 	}
 
 	gblock = (const struct guid_block *)obj->buffer.pointer;
@@ -1188,8 +1180,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 
 		wblock = kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
 		if (!wblock) {
-			retval = -ENOMEM;
-			break;
+			dev_err(wmi_bus_dev, "Failed to allocate %pUL\n", &gblock[i].guid);
+			continue;
 		}
 
 		wblock->acpi_device = device;
@@ -1228,9 +1220,9 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		}
 	}
 
-out_free_pointer:
-	kfree(out.pointer);
-	return retval;
+	kfree(obj);
+
+	return 0;
 }
 
 /*
diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index fea612c45f20..fd8479cd6771 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -298,7 +298,7 @@ static int brcmstb_pwm_suspend(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
 
-	clk_disable(p->clk);
+	clk_disable_unprepare(p->clk);
 
 	return 0;
 }
@@ -307,7 +307,7 @@ static int brcmstb_pwm_resume(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
 
-	clk_enable(p->clk);
+	clk_prepare_enable(p->clk);
 
 	return 0;
 }
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 1508616d794c..9b2174adab3d 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -79,6 +79,7 @@ struct sti_pwm_compat_data {
 	unsigned int cpt_num_devs;
 	unsigned int max_pwm_cnt;
 	unsigned int max_prescale;
+	struct sti_cpt_ddata *ddata;
 };
 
 struct sti_pwm_chip {
@@ -314,7 +315,7 @@ static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
 	struct sti_pwm_compat_data *cdata = pc->cdata;
-	struct sti_cpt_ddata *ddata = pwm_get_chip_data(pwm);
+	struct sti_cpt_ddata *ddata = &cdata->ddata[pwm->hwpwm];
 	struct device *dev = pc->dev;
 	unsigned int effective_ticks;
 	unsigned long long high, low;
@@ -417,7 +418,7 @@ static irqreturn_t sti_pwm_interrupt(int irq, void *data)
 	while (cpt_int_stat) {
 		devicenum = ffs(cpt_int_stat) - 1;
 
-		ddata = pwm_get_chip_data(&pc->chip.pwms[devicenum]);
+		ddata = &pc->cdata->ddata[devicenum];
 
 		/*
 		 * Capture input:
@@ -593,61 +594,55 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (!cdata->pwm_num_devs)
-		goto skip_pwm;
-
-	pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
-	if (IS_ERR(pc->pwm_clk)) {
-		dev_err(dev, "failed to get PWM clock\n");
-		return PTR_ERR(pc->pwm_clk);
-	}
+	if (cdata->pwm_num_devs) {
+		pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
+		if (IS_ERR(pc->pwm_clk)) {
+			dev_err(dev, "failed to get PWM clock\n");
+			return PTR_ERR(pc->pwm_clk);
+		}
 
-	ret = clk_prepare(pc->pwm_clk);
-	if (ret) {
-		dev_err(dev, "failed to prepare clock\n");
-		return ret;
+		ret = clk_prepare(pc->pwm_clk);
+		if (ret) {
+			dev_err(dev, "failed to prepare clock\n");
+			return ret;
+		}
 	}
 
-skip_pwm:
-	if (!cdata->cpt_num_devs)
-		goto skip_cpt;
+	if (cdata->cpt_num_devs) {
+		pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
+		if (IS_ERR(pc->cpt_clk)) {
+			dev_err(dev, "failed to get PWM capture clock\n");
+			return PTR_ERR(pc->cpt_clk);
+		}
 
-	pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
-	if (IS_ERR(pc->cpt_clk)) {
-		dev_err(dev, "failed to get PWM capture clock\n");
-		return PTR_ERR(pc->cpt_clk);
-	}
+		ret = clk_prepare(pc->cpt_clk);
+		if (ret) {
+			dev_err(dev, "failed to prepare clock\n");
+			return ret;
+		}
 
-	ret = clk_prepare(pc->cpt_clk);
-	if (ret) {
-		dev_err(dev, "failed to prepare clock\n");
-		return ret;
+		cdata->ddata = devm_kzalloc(dev, cdata->cpt_num_devs * sizeof(*cdata->ddata), GFP_KERNEL);
+		if (!cdata->ddata)
+			return -ENOMEM;
 	}
 
-skip_cpt:
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
 	pc->chip.base = -1;
 	pc->chip.npwm = pc->cdata->pwm_num_devs;
 
-	ret = pwmchip_add(&pc->chip);
-	if (ret < 0) {
-		clk_unprepare(pc->pwm_clk);
-		clk_unprepare(pc->cpt_clk);
-		return ret;
-	}
-
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
-		struct sti_cpt_ddata *ddata;
-
-		ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
-		if (!ddata)
-			return -ENOMEM;
+		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
 
 		init_waitqueue_head(&ddata->wait);
 		mutex_init(&ddata->lock);
+	}
 
-		pwm_set_chip_data(&pc->chip.pwms[i], ddata);
+	ret = pwmchip_add(&pc->chip);
+	if (ret < 0) {
+		clk_unprepare(pc->pwm_clk);
+		clk_unprepare(pc->cpt_clk);
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, pc);
diff --git a/drivers/reset/reset-ti-sci.c b/drivers/reset/reset-ti-sci.c
index bf68729ab729..b799aefad547 100644
--- a/drivers/reset/reset-ti-sci.c
+++ b/drivers/reset/reset-ti-sci.c
@@ -1,7 +1,7 @@
 /*
  * Texas Instrument's System Control Interface (TI-SCI) reset driver
  *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
  *	Andrew F. Davis <afd@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 3450d615974d..bb962dce3ab2 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -407,7 +407,7 @@ static int pcf85363_probe(struct i2c_client *client,
 	if (client->irq > 0) {
 		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
 		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
-				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
+				   PIN_IO_INTAPM, PIN_IO_INTA_OUT);
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, pcf85363_rtc_handle_irq,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 9d13226d2324..363adf489079 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3265,7 +3265,7 @@ int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
 		 */
 		ret = utf16s_to_utf8s(uc_str->uc,
 				      uc_str->len - QUERY_DESC_HDR_SIZE,
-				      UTF16_BIG_ENDIAN, str, ascii_len);
+				      UTF16_BIG_ENDIAN, str, ascii_len - 1);
 
 		/* replace non-printable or non-ASCII characters with spaces */
 		for (i = 0; i < ret; i++)
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 31c44ea139ef..ddcbeb8d05b6 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -59,17 +59,9 @@ config QCOM_LLCC
 	select REGMAP_MMIO
 	help
 	  Qualcomm Technologies, Inc. platform specific
-	  Last Level Cache Controller(LLCC) driver. This provides interfaces
-	  to clients that use the LLCC. Say yes here to enable LLCC slice
-	  driver.
-
-config QCOM_SDM845_LLCC
-	tristate "Qualcomm Technologies, Inc. SDM845 LLCC driver"
-	depends on QCOM_LLCC
-	help
-	  Say yes here to enable the LLCC driver for SDM845. This provides
-	  data required to configure LLCC so that clients can start using the
-	  LLCC slices.
+	  Last Level Cache Controller(LLCC) driver for platforms such as,
+	  SDM845. This provides interfaces to clients that use the LLCC.
+	  Say yes here to enable LLCC slice driver.
 
 config QCOM_MDT_LOADER
 	tristate
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 162788701a77..2559fe948ce0 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
 obj-$(CONFIG_QCOM_SOCINFO)	+= socinfo.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 obj-$(CONFIG_QCOM_APR) += apr.o
-obj-$(CONFIG_QCOM_LLCC) += llcc-slice.o
-obj-$(CONFIG_QCOM_SDM845_LLCC) += llcc-sdm845.o
+obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
 obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
 obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
new file mode 100644
index 000000000000..431b214975c8
--- /dev/null
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/llcc-qcom.h>
+
+#define ACTIVATE                      BIT(0)
+#define DEACTIVATE                    BIT(1)
+#define ACT_CTRL_OPCODE_ACTIVATE      BIT(0)
+#define ACT_CTRL_OPCODE_DEACTIVATE    BIT(1)
+#define ACT_CTRL_ACT_TRIG             BIT(0)
+#define ACT_CTRL_OPCODE_SHIFT         0x01
+#define ATTR1_PROBE_TARGET_WAYS_SHIFT 0x02
+#define ATTR1_FIXED_SIZE_SHIFT        0x03
+#define ATTR1_PRIORITY_SHIFT          0x04
+#define ATTR1_MAX_CAP_SHIFT           0x10
+#define ATTR0_RES_WAYS_MASK           GENMASK(11, 0)
+#define ATTR0_BONUS_WAYS_MASK         GENMASK(27, 16)
+#define ATTR0_BONUS_WAYS_SHIFT        0x10
+#define LLCC_STATUS_READ_DELAY        100
+
+#define CACHE_LINE_SIZE_SHIFT         6
+
+#define LLCC_COMMON_STATUS0           0x0003000c
+#define LLCC_LB_CNT_MASK              GENMASK(31, 28)
+#define LLCC_LB_CNT_SHIFT             28
+
+#define MAX_CAP_TO_BYTES(n)           (n * SZ_1K)
+#define LLCC_TRP_ACT_CTRLn(n)         (n * SZ_4K)
+#define LLCC_TRP_STATUSn(n)           (4 + n * SZ_4K)
+#define LLCC_TRP_ATTR0_CFGn(n)        (0x21000 + SZ_8 * n)
+#define LLCC_TRP_ATTR1_CFGn(n)        (0x21004 + SZ_8 * n)
+
+#define BANK_OFFSET_STRIDE	      0x80000
+
+static struct llcc_slice_config sdm845_data[] =  {
+	{ LLCC_CPUSS,    1,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 1 },
+	{ LLCC_VIDSC0,   2,  512,  2, 1, 0x0,   0x0f0, 0, 0, 1, 1, 0 },
+	{ LLCC_VIDSC1,   3,  512,  2, 1, 0x0,   0x0f0, 0, 0, 1, 1, 0 },
+	{ LLCC_ROTATOR,  4,  563,  2, 1, 0x0,   0x00e, 2, 0, 1, 1, 0 },
+	{ LLCC_VOICE,    5,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0 },
+	{ LLCC_AUDIO,    6,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0 },
+	{ LLCC_MDMHPGRW, 7,  1024, 2, 0, 0xfc,  0xf00, 0, 0, 1, 1, 0 },
+	{ LLCC_MDM,      8,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0 },
+	{ LLCC_CMPT,     10, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0 },
+	{ LLCC_GPUHTW,   11, 512,  1, 1, 0xc,   0x0,   0, 0, 1, 1, 0 },
+	{ LLCC_GPU,      12, 2304, 1, 0, 0xff0, 0x2,   0, 0, 1, 1, 0 },
+	{ LLCC_MMUHWT,   13, 256,  2, 0, 0x0,   0x1,   0, 0, 1, 0, 1 },
+	{ LLCC_CMPTDMA,  15, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0 },
+	{ LLCC_DISP,     16, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0 },
+	{ LLCC_VIDFW,    17, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0 },
+	{ LLCC_MDMHPFX,  20, 1024, 2, 1, 0x0,   0xf00, 0, 0, 1, 1, 0 },
+	{ LLCC_MDMPNG,   21, 1024, 0, 1, 0x1e,  0x0,   0, 0, 1, 1, 0 },
+	{ LLCC_AUDHW,    22, 1024, 1, 1, 0xffc, 0x2,   0, 0, 1, 1, 0 },
+};
+
+static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
+
+static struct regmap_config llcc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+};
+
+/**
+ * llcc_slice_getd - get llcc slice descriptor
+ * @uid: usecase_id for the client
+ *
+ * A pointer to llcc slice descriptor will be returned on success and
+ * and error pointer is returned on failure
+ */
+struct llcc_slice_desc *llcc_slice_getd(u32 uid)
+{
+	const struct llcc_slice_config *cfg;
+	struct llcc_slice_desc *desc;
+	u32 sz, count;
+
+	if (IS_ERR(drv_data))
+		return ERR_CAST(drv_data);
+
+	cfg = drv_data->cfg;
+	sz = drv_data->cfg_size;
+
+	for (count = 0; cfg && count < sz; count++, cfg++)
+		if (cfg->usecase_id == uid)
+			break;
+
+	if (count == sz || !cfg)
+		return ERR_PTR(-ENODEV);
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return ERR_PTR(-ENOMEM);
+
+	desc->slice_id = cfg->slice_id;
+	desc->slice_size = cfg->max_cap;
+
+	return desc;
+}
+EXPORT_SYMBOL_GPL(llcc_slice_getd);
+
+/**
+ * llcc_slice_putd - llcc slice descritpor
+ * @desc: Pointer to llcc slice descriptor
+ */
+void llcc_slice_putd(struct llcc_slice_desc *desc)
+{
+	if (!IS_ERR_OR_NULL(desc))
+		kfree(desc);
+}
+EXPORT_SYMBOL_GPL(llcc_slice_putd);
+
+static int llcc_update_act_ctrl(u32 sid,
+				u32 act_ctrl_reg_val, u32 status)
+{
+	u32 act_ctrl_reg;
+	u32 status_reg;
+	u32 slice_status;
+	int ret;
+
+	if (IS_ERR(drv_data))
+		return PTR_ERR(drv_data);
+
+	act_ctrl_reg = LLCC_TRP_ACT_CTRLn(sid);
+	status_reg = LLCC_TRP_STATUSn(sid);
+
+	/* Set the ACTIVE trigger */
+	act_ctrl_reg_val |= ACT_CTRL_ACT_TRIG;
+	ret = regmap_write(drv_data->bcast_regmap, act_ctrl_reg,
+				act_ctrl_reg_val);
+	if (ret)
+		return ret;
+
+	/* Clear the ACTIVE trigger */
+	act_ctrl_reg_val &= ~ACT_CTRL_ACT_TRIG;
+	ret = regmap_write(drv_data->bcast_regmap, act_ctrl_reg,
+				act_ctrl_reg_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
+				      slice_status, !(slice_status & status),
+				      0, LLCC_STATUS_READ_DELAY);
+	return ret;
+}
+
+/**
+ * llcc_slice_activate - Activate the llcc slice
+ * @desc: Pointer to llcc slice descriptor
+ *
+ * A value of zero will be returned on success and a negative errno will
+ * be returned in error cases
+ */
+int llcc_slice_activate(struct llcc_slice_desc *desc)
+{
+	int ret;
+	u32 act_ctrl_val;
+
+	if (IS_ERR(drv_data))
+		return PTR_ERR(drv_data);
+
+	if (IS_ERR_OR_NULL(desc))
+		return -EINVAL;
+
+	mutex_lock(&drv_data->lock);
+	if (test_bit(desc->slice_id, drv_data->bitmap)) {
+		mutex_unlock(&drv_data->lock);
+		return 0;
+	}
+
+	act_ctrl_val = ACT_CTRL_OPCODE_ACTIVATE << ACT_CTRL_OPCODE_SHIFT;
+
+	ret = llcc_update_act_ctrl(desc->slice_id, act_ctrl_val,
+				  DEACTIVATE);
+	if (ret) {
+		mutex_unlock(&drv_data->lock);
+		return ret;
+	}
+
+	__set_bit(desc->slice_id, drv_data->bitmap);
+	mutex_unlock(&drv_data->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(llcc_slice_activate);
+
+/**
+ * llcc_slice_deactivate - Deactivate the llcc slice
+ * @desc: Pointer to llcc slice descriptor
+ *
+ * A value of zero will be returned on success and a negative errno will
+ * be returned in error cases
+ */
+int llcc_slice_deactivate(struct llcc_slice_desc *desc)
+{
+	u32 act_ctrl_val;
+	int ret;
+
+	if (IS_ERR(drv_data))
+		return PTR_ERR(drv_data);
+
+	if (IS_ERR_OR_NULL(desc))
+		return -EINVAL;
+
+	mutex_lock(&drv_data->lock);
+	if (!test_bit(desc->slice_id, drv_data->bitmap)) {
+		mutex_unlock(&drv_data->lock);
+		return 0;
+	}
+	act_ctrl_val = ACT_CTRL_OPCODE_DEACTIVATE << ACT_CTRL_OPCODE_SHIFT;
+
+	ret = llcc_update_act_ctrl(desc->slice_id, act_ctrl_val,
+				  ACTIVATE);
+	if (ret) {
+		mutex_unlock(&drv_data->lock);
+		return ret;
+	}
+
+	__clear_bit(desc->slice_id, drv_data->bitmap);
+	mutex_unlock(&drv_data->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(llcc_slice_deactivate);
+
+/**
+ * llcc_get_slice_id - return the slice id
+ * @desc: Pointer to llcc slice descriptor
+ */
+int llcc_get_slice_id(struct llcc_slice_desc *desc)
+{
+	if (IS_ERR_OR_NULL(desc))
+		return -EINVAL;
+
+	return desc->slice_id;
+}
+EXPORT_SYMBOL_GPL(llcc_get_slice_id);
+
+/**
+ * llcc_get_slice_size - return the slice id
+ * @desc: Pointer to llcc slice descriptor
+ */
+size_t llcc_get_slice_size(struct llcc_slice_desc *desc)
+{
+	if (IS_ERR_OR_NULL(desc))
+		return 0;
+
+	return desc->slice_size;
+}
+EXPORT_SYMBOL_GPL(llcc_get_slice_size);
+
+static int qcom_llcc_cfg_program(struct platform_device *pdev)
+{
+	int i;
+	u32 attr1_cfg;
+	u32 attr0_cfg;
+	u32 attr1_val;
+	u32 attr0_val;
+	u32 max_cap_cacheline;
+	u32 sz;
+	int ret = 0;
+	const struct llcc_slice_config *llcc_table;
+	struct llcc_slice_desc desc;
+
+	sz = drv_data->cfg_size;
+	llcc_table = drv_data->cfg;
+
+	for (i = 0; i < sz; i++) {
+		attr1_cfg = LLCC_TRP_ATTR1_CFGn(llcc_table[i].slice_id);
+		attr0_cfg = LLCC_TRP_ATTR0_CFGn(llcc_table[i].slice_id);
+
+		attr1_val = llcc_table[i].cache_mode;
+		attr1_val |= llcc_table[i].probe_target_ways <<
+				ATTR1_PROBE_TARGET_WAYS_SHIFT;
+		attr1_val |= llcc_table[i].fixed_size <<
+				ATTR1_FIXED_SIZE_SHIFT;
+		attr1_val |= llcc_table[i].priority <<
+				ATTR1_PRIORITY_SHIFT;
+
+		max_cap_cacheline = MAX_CAP_TO_BYTES(llcc_table[i].max_cap);
+
+		/* LLCC instances can vary for each target.
+		 * The SW writes to broadcast register which gets propagated
+		 * to each llcc instace (llcc0,.. llccN).
+		 * Since the size of the memory is divided equally amongst the
+		 * llcc instances, we need to configure the max cap accordingly.
+		 */
+		max_cap_cacheline = max_cap_cacheline / drv_data->num_banks;
+		max_cap_cacheline >>= CACHE_LINE_SIZE_SHIFT;
+		attr1_val |= max_cap_cacheline << ATTR1_MAX_CAP_SHIFT;
+
+		attr0_val = llcc_table[i].res_ways & ATTR0_RES_WAYS_MASK;
+		attr0_val |= llcc_table[i].bonus_ways << ATTR0_BONUS_WAYS_SHIFT;
+
+		ret = regmap_write(drv_data->bcast_regmap, attr1_cfg,
+					attr1_val);
+		if (ret)
+			return ret;
+		ret = regmap_write(drv_data->bcast_regmap, attr0_cfg,
+					attr0_val);
+		if (ret)
+			return ret;
+		if (llcc_table[i].activate_on_init) {
+			desc.slice_id = llcc_table[i].slice_id;
+			ret = llcc_slice_activate(&desc);
+		}
+	}
+	return ret;
+}
+
+static int qcom_llcc_remove(struct platform_device *pdev)
+{
+	/* Set the global pointer to a error code to avoid referencing it */
+	drv_data = ERR_PTR(-ENODEV);
+	return 0;
+}
+
+static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
+		const char *name)
+{
+	struct resource *res;
+	void __iomem *base;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
+	if (!res)
+		return ERR_PTR(-ENODEV);
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+
+	llcc_regmap_config.name = name;
+	return devm_regmap_init_mmio(&pdev->dev, base, &llcc_regmap_config);
+}
+
+static int qcom_llcc_probe(struct platform_device *pdev,
+			   const struct llcc_slice_config *llcc_cfg, u32 sz)
+{
+	u32 num_banks;
+	struct device *dev = &pdev->dev;
+	int ret, i;
+	struct platform_device *llcc_edac;
+
+	if (!IS_ERR(drv_data))
+		return -EBUSY;
+
+	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
+	if (!drv_data) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	drv_data->regmap = qcom_llcc_init_mmio(pdev, "llcc_base");
+	if (IS_ERR(drv_data->regmap)) {
+		ret = PTR_ERR(drv_data->regmap);
+		goto err;
+	}
+
+	drv_data->bcast_regmap =
+		qcom_llcc_init_mmio(pdev, "llcc_broadcast_base");
+	if (IS_ERR(drv_data->bcast_regmap)) {
+		ret = PTR_ERR(drv_data->bcast_regmap);
+		goto err;
+	}
+
+	ret = regmap_read(drv_data->regmap, LLCC_COMMON_STATUS0,
+						&num_banks);
+	if (ret)
+		goto err;
+
+	num_banks &= LLCC_LB_CNT_MASK;
+	num_banks >>= LLCC_LB_CNT_SHIFT;
+	drv_data->num_banks = num_banks;
+
+	for (i = 0; i < sz; i++)
+		if (llcc_cfg[i].slice_id > drv_data->max_slices)
+			drv_data->max_slices = llcc_cfg[i].slice_id;
+
+	drv_data->offsets = devm_kcalloc(dev, num_banks, sizeof(u32),
+							GFP_KERNEL);
+	if (!drv_data->offsets) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	for (i = 0; i < num_banks; i++)
+		drv_data->offsets[i] = i * BANK_OFFSET_STRIDE;
+
+	drv_data->bitmap = devm_kcalloc(dev,
+	BITS_TO_LONGS(drv_data->max_slices), sizeof(unsigned long),
+						GFP_KERNEL);
+	if (!drv_data->bitmap) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	drv_data->cfg = llcc_cfg;
+	drv_data->cfg_size = sz;
+	mutex_init(&drv_data->lock);
+	platform_set_drvdata(pdev, drv_data);
+
+	ret = qcom_llcc_cfg_program(pdev);
+	if (ret)
+		goto err;
+
+	drv_data->ecc_irq = platform_get_irq(pdev, 0);
+	if (drv_data->ecc_irq >= 0) {
+		llcc_edac = platform_device_register_data(&pdev->dev,
+						"qcom_llcc_edac", -1, drv_data,
+						sizeof(*drv_data));
+		if (IS_ERR(llcc_edac))
+			dev_err(dev, "Failed to register llcc edac driver\n");
+	}
+
+	return 0;
+err:
+	drv_data = ERR_PTR(-ENODEV);
+	return ret;
+}
+
+static int sdm845_qcom_llcc_remove(struct platform_device *pdev)
+{
+	return qcom_llcc_remove(pdev);
+}
+
+static int sdm845_qcom_llcc_probe(struct platform_device *pdev)
+{
+	return qcom_llcc_probe(pdev, sdm845_data, ARRAY_SIZE(sdm845_data));
+}
+
+static const struct of_device_id sdm845_qcom_llcc_of_match[] = {
+	{ .compatible = "qcom,sdm845-llcc", },
+	{ }
+};
+
+static struct platform_driver sdm845_qcom_llcc_driver = {
+	.driver = {
+		.name = "sdm845-llcc",
+		.of_match_table = sdm845_qcom_llcc_of_match,
+	},
+	.probe = sdm845_qcom_llcc_probe,
+	.remove = sdm845_qcom_llcc_remove,
+};
+module_platform_driver(sdm845_qcom_llcc_driver);
+
+MODULE_DESCRIPTION("QCOM sdm845 LLCC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/qcom/llcc-sdm845.c b/drivers/soc/qcom/llcc-sdm845.c
deleted file mode 100644
index 86600d97c36d..000000000000
--- a/drivers/soc/qcom/llcc-sdm845.c
+++ /dev/null
@@ -1,100 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/soc/qcom/llcc-qcom.h>
-
-/*
- * SCT(System Cache Table) entry contains of the following members:
- * usecase_id: Unique id for the client's use case
- * slice_id: llcc slice id for each client
- * max_cap: The maximum capacity of the cache slice provided in KB
- * priority: Priority of the client used to select victim line for replacement
- * fixed_size: Boolean indicating if the slice has a fixed capacity
- * bonus_ways: Bonus ways are additional ways to be used for any slice,
- *		if client ends up using more than reserved cache ways. Bonus
- *		ways are allocated only if they are not reserved for some
- *		other client.
- * res_ways: Reserved ways for the cache slice, the reserved ways cannot
- *		be used by any other client than the one its assigned to.
- * cache_mode: Each slice operates as a cache, this controls the mode of the
- *             slice: normal or TCM(Tightly Coupled Memory)
- * probe_target_ways: Determines what ways to probe for access hit. When
- *                    configured to 1 only bonus and reserved ways are probed.
- *                    When configured to 0 all ways in llcc are probed.
- * dis_cap_alloc: Disable capacity based allocation for a client
- * retain_on_pc: If this bit is set and client has maintained active vote
- *               then the ways assigned to this client are not flushed on power
- *               collapse.
- * activate_on_init: Activate the slice immediately after the SCT is programmed
- */
-#define SCT_ENTRY(uid, sid, mc, p, fs, bway, rway, cmod, ptw, dca, rp, a) \
-	{					\
-		.usecase_id = uid,		\
-		.slice_id = sid,		\
-		.max_cap = mc,			\
-		.priority = p,			\
-		.fixed_size = fs,		\
-		.bonus_ways = bway,		\
-		.res_ways = rway,		\
-		.cache_mode = cmod,		\
-		.probe_target_ways = ptw,	\
-		.dis_cap_alloc = dca,		\
-		.retain_on_pc = rp,		\
-		.activate_on_init = a,		\
-	}
-
-static struct llcc_slice_config sdm845_data[] =  {
-	SCT_ENTRY(LLCC_CPUSS,    1,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 1),
-	SCT_ENTRY(LLCC_VIDSC0,   2,  512,  2, 1, 0x0,   0x0f0, 0, 0, 1, 1, 0),
-	SCT_ENTRY(LLCC_VIDSC1,   3,  512,  2, 1, 0x0,   0x0f0, 0, 0, 1, 1, 0),
-	SCT_ENTRY(LLCC_ROTATOR,  4,  563,  2, 1, 0x0,   0x00e, 2, 0, 1, 1, 0),
-	SCT_ENTRY(LLCC_VOICE,    5,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
-	SCT_ENTRY(LLCC_AUDIO,    6,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
-	SCT_ENTRY(LLCC_MDMHPGRW, 7,  1024, 2, 0, 0xfc,  0xf00, 0, 0, 1, 1, 0),
-	SCT_ENTRY(LLCC_MDM,      8,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
-	SCT_ENTRY(LLCC_CMPT,     10, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
-	SCT_ENTRY(LLCC_GPUHTW,   11, 512,  1, 1, 0xc,   0x0,   0, 0, 1, 1, 0),
-	SCT_ENTRY(LLCC_GPU,      12, 2304, 1, 0, 0xff0, 0x2,   0, 0, 1, 1, 0),
-	SCT_ENTRY(LLCC_MMUHWT,   13, 256,  2, 0, 0x0,   0x1,   0, 0, 1, 0, 1),
-	SCT_ENTRY(LLCC_CMPTDMA,  15, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
-	SCT_ENTRY(LLCC_DISP,     16, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
-	SCT_ENTRY(LLCC_VIDFW,    17, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
-	SCT_ENTRY(LLCC_MDMHPFX,  20, 1024, 2, 1, 0x0,   0xf00, 0, 0, 1, 1, 0),
-	SCT_ENTRY(LLCC_MDMPNG,   21, 1024, 0, 1, 0x1e,  0x0,   0, 0, 1, 1, 0),
-	SCT_ENTRY(LLCC_AUDHW,    22, 1024, 1, 1, 0xffc, 0x2,   0, 0, 1, 1, 0),
-};
-
-static int sdm845_qcom_llcc_remove(struct platform_device *pdev)
-{
-	return qcom_llcc_remove(pdev);
-}
-
-static int sdm845_qcom_llcc_probe(struct platform_device *pdev)
-{
-	return qcom_llcc_probe(pdev, sdm845_data, ARRAY_SIZE(sdm845_data));
-}
-
-static const struct of_device_id sdm845_qcom_llcc_of_match[] = {
-	{ .compatible = "qcom,sdm845-llcc", },
-	{ }
-};
-
-static struct platform_driver sdm845_qcom_llcc_driver = {
-	.driver = {
-		.name = "sdm845-llcc",
-		.of_match_table = sdm845_qcom_llcc_of_match,
-	},
-	.probe = sdm845_qcom_llcc_probe,
-	.remove = sdm845_qcom_llcc_remove,
-};
-module_platform_driver(sdm845_qcom_llcc_driver);
-
-MODULE_DESCRIPTION("QCOM sdm845 LLCC driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
deleted file mode 100644
index 4a6111635f82..000000000000
--- a/drivers/soc/qcom/llcc-slice.c
+++ /dev/null
@@ -1,413 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
- *
- */
-
-#include <linux/bitmap.h>
-#include <linux/bitops.h>
-#include <linux/device.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/of_device.h>
-#include <linux/regmap.h>
-#include <linux/sizes.h>
-#include <linux/slab.h>
-#include <linux/soc/qcom/llcc-qcom.h>
-
-#define ACTIVATE                      BIT(0)
-#define DEACTIVATE                    BIT(1)
-#define ACT_CTRL_OPCODE_ACTIVATE      BIT(0)
-#define ACT_CTRL_OPCODE_DEACTIVATE    BIT(1)
-#define ACT_CTRL_ACT_TRIG             BIT(0)
-#define ACT_CTRL_OPCODE_SHIFT         0x01
-#define ATTR1_PROBE_TARGET_WAYS_SHIFT 0x02
-#define ATTR1_FIXED_SIZE_SHIFT        0x03
-#define ATTR1_PRIORITY_SHIFT          0x04
-#define ATTR1_MAX_CAP_SHIFT           0x10
-#define ATTR0_RES_WAYS_MASK           GENMASK(11, 0)
-#define ATTR0_BONUS_WAYS_MASK         GENMASK(27, 16)
-#define ATTR0_BONUS_WAYS_SHIFT        0x10
-#define LLCC_STATUS_READ_DELAY        100
-
-#define CACHE_LINE_SIZE_SHIFT         6
-
-#define LLCC_COMMON_STATUS0           0x0003000c
-#define LLCC_LB_CNT_MASK              GENMASK(31, 28)
-#define LLCC_LB_CNT_SHIFT             28
-
-#define MAX_CAP_TO_BYTES(n)           (n * SZ_1K)
-#define LLCC_TRP_ACT_CTRLn(n)         (n * SZ_4K)
-#define LLCC_TRP_STATUSn(n)           (4 + n * SZ_4K)
-#define LLCC_TRP_ATTR0_CFGn(n)        (0x21000 + SZ_8 * n)
-#define LLCC_TRP_ATTR1_CFGn(n)        (0x21004 + SZ_8 * n)
-
-#define BANK_OFFSET_STRIDE	      0x80000
-
-static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
-
-static struct regmap_config llcc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.fast_io = true,
-};
-
-/**
- * llcc_slice_getd - get llcc slice descriptor
- * @uid: usecase_id for the client
- *
- * A pointer to llcc slice descriptor will be returned on success and
- * and error pointer is returned on failure
- */
-struct llcc_slice_desc *llcc_slice_getd(u32 uid)
-{
-	const struct llcc_slice_config *cfg;
-	struct llcc_slice_desc *desc;
-	u32 sz, count;
-
-	if (IS_ERR(drv_data))
-		return ERR_CAST(drv_data);
-
-	cfg = drv_data->cfg;
-	sz = drv_data->cfg_size;
-
-	for (count = 0; cfg && count < sz; count++, cfg++)
-		if (cfg->usecase_id == uid)
-			break;
-
-	if (count == sz || !cfg)
-		return ERR_PTR(-ENODEV);
-
-	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
-	if (!desc)
-		return ERR_PTR(-ENOMEM);
-
-	desc->slice_id = cfg->slice_id;
-	desc->slice_size = cfg->max_cap;
-
-	return desc;
-}
-EXPORT_SYMBOL_GPL(llcc_slice_getd);
-
-/**
- * llcc_slice_putd - llcc slice descritpor
- * @desc: Pointer to llcc slice descriptor
- */
-void llcc_slice_putd(struct llcc_slice_desc *desc)
-{
-	if (!IS_ERR_OR_NULL(desc))
-		kfree(desc);
-}
-EXPORT_SYMBOL_GPL(llcc_slice_putd);
-
-static int llcc_update_act_ctrl(u32 sid,
-				u32 act_ctrl_reg_val, u32 status)
-{
-	u32 act_ctrl_reg;
-	u32 status_reg;
-	u32 slice_status;
-	int ret;
-
-	if (IS_ERR(drv_data))
-		return PTR_ERR(drv_data);
-
-	act_ctrl_reg = LLCC_TRP_ACT_CTRLn(sid);
-	status_reg = LLCC_TRP_STATUSn(sid);
-
-	/* Set the ACTIVE trigger */
-	act_ctrl_reg_val |= ACT_CTRL_ACT_TRIG;
-	ret = regmap_write(drv_data->bcast_regmap, act_ctrl_reg,
-				act_ctrl_reg_val);
-	if (ret)
-		return ret;
-
-	/* Clear the ACTIVE trigger */
-	act_ctrl_reg_val &= ~ACT_CTRL_ACT_TRIG;
-	ret = regmap_write(drv_data->bcast_regmap, act_ctrl_reg,
-				act_ctrl_reg_val);
-	if (ret)
-		return ret;
-
-	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
-				      slice_status, !(slice_status & status),
-				      0, LLCC_STATUS_READ_DELAY);
-	return ret;
-}
-
-/**
- * llcc_slice_activate - Activate the llcc slice
- * @desc: Pointer to llcc slice descriptor
- *
- * A value of zero will be returned on success and a negative errno will
- * be returned in error cases
- */
-int llcc_slice_activate(struct llcc_slice_desc *desc)
-{
-	int ret;
-	u32 act_ctrl_val;
-
-	if (IS_ERR(drv_data))
-		return PTR_ERR(drv_data);
-
-	if (IS_ERR_OR_NULL(desc))
-		return -EINVAL;
-
-	mutex_lock(&drv_data->lock);
-	if (test_bit(desc->slice_id, drv_data->bitmap)) {
-		mutex_unlock(&drv_data->lock);
-		return 0;
-	}
-
-	act_ctrl_val = ACT_CTRL_OPCODE_ACTIVATE << ACT_CTRL_OPCODE_SHIFT;
-
-	ret = llcc_update_act_ctrl(desc->slice_id, act_ctrl_val,
-				  DEACTIVATE);
-	if (ret) {
-		mutex_unlock(&drv_data->lock);
-		return ret;
-	}
-
-	__set_bit(desc->slice_id, drv_data->bitmap);
-	mutex_unlock(&drv_data->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(llcc_slice_activate);
-
-/**
- * llcc_slice_deactivate - Deactivate the llcc slice
- * @desc: Pointer to llcc slice descriptor
- *
- * A value of zero will be returned on success and a negative errno will
- * be returned in error cases
- */
-int llcc_slice_deactivate(struct llcc_slice_desc *desc)
-{
-	u32 act_ctrl_val;
-	int ret;
-
-	if (IS_ERR(drv_data))
-		return PTR_ERR(drv_data);
-
-	if (IS_ERR_OR_NULL(desc))
-		return -EINVAL;
-
-	mutex_lock(&drv_data->lock);
-	if (!test_bit(desc->slice_id, drv_data->bitmap)) {
-		mutex_unlock(&drv_data->lock);
-		return 0;
-	}
-	act_ctrl_val = ACT_CTRL_OPCODE_DEACTIVATE << ACT_CTRL_OPCODE_SHIFT;
-
-	ret = llcc_update_act_ctrl(desc->slice_id, act_ctrl_val,
-				  ACTIVATE);
-	if (ret) {
-		mutex_unlock(&drv_data->lock);
-		return ret;
-	}
-
-	__clear_bit(desc->slice_id, drv_data->bitmap);
-	mutex_unlock(&drv_data->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(llcc_slice_deactivate);
-
-/**
- * llcc_get_slice_id - return the slice id
- * @desc: Pointer to llcc slice descriptor
- */
-int llcc_get_slice_id(struct llcc_slice_desc *desc)
-{
-	if (IS_ERR_OR_NULL(desc))
-		return -EINVAL;
-
-	return desc->slice_id;
-}
-EXPORT_SYMBOL_GPL(llcc_get_slice_id);
-
-/**
- * llcc_get_slice_size - return the slice id
- * @desc: Pointer to llcc slice descriptor
- */
-size_t llcc_get_slice_size(struct llcc_slice_desc *desc)
-{
-	if (IS_ERR_OR_NULL(desc))
-		return 0;
-
-	return desc->slice_size;
-}
-EXPORT_SYMBOL_GPL(llcc_get_slice_size);
-
-static int qcom_llcc_cfg_program(struct platform_device *pdev)
-{
-	int i;
-	u32 attr1_cfg;
-	u32 attr0_cfg;
-	u32 attr1_val;
-	u32 attr0_val;
-	u32 max_cap_cacheline;
-	u32 sz;
-	int ret = 0;
-	const struct llcc_slice_config *llcc_table;
-	struct llcc_slice_desc desc;
-
-	sz = drv_data->cfg_size;
-	llcc_table = drv_data->cfg;
-
-	for (i = 0; i < sz; i++) {
-		attr1_cfg = LLCC_TRP_ATTR1_CFGn(llcc_table[i].slice_id);
-		attr0_cfg = LLCC_TRP_ATTR0_CFGn(llcc_table[i].slice_id);
-
-		attr1_val = llcc_table[i].cache_mode;
-		attr1_val |= llcc_table[i].probe_target_ways <<
-				ATTR1_PROBE_TARGET_WAYS_SHIFT;
-		attr1_val |= llcc_table[i].fixed_size <<
-				ATTR1_FIXED_SIZE_SHIFT;
-		attr1_val |= llcc_table[i].priority <<
-				ATTR1_PRIORITY_SHIFT;
-
-		max_cap_cacheline = MAX_CAP_TO_BYTES(llcc_table[i].max_cap);
-
-		/* LLCC instances can vary for each target.
-		 * The SW writes to broadcast register which gets propagated
-		 * to each llcc instace (llcc0,.. llccN).
-		 * Since the size of the memory is divided equally amongst the
-		 * llcc instances, we need to configure the max cap accordingly.
-		 */
-		max_cap_cacheline = max_cap_cacheline / drv_data->num_banks;
-		max_cap_cacheline >>= CACHE_LINE_SIZE_SHIFT;
-		attr1_val |= max_cap_cacheline << ATTR1_MAX_CAP_SHIFT;
-
-		attr0_val = llcc_table[i].res_ways & ATTR0_RES_WAYS_MASK;
-		attr0_val |= llcc_table[i].bonus_ways << ATTR0_BONUS_WAYS_SHIFT;
-
-		ret = regmap_write(drv_data->bcast_regmap, attr1_cfg,
-					attr1_val);
-		if (ret)
-			return ret;
-		ret = regmap_write(drv_data->bcast_regmap, attr0_cfg,
-					attr0_val);
-		if (ret)
-			return ret;
-		if (llcc_table[i].activate_on_init) {
-			desc.slice_id = llcc_table[i].slice_id;
-			ret = llcc_slice_activate(&desc);
-		}
-	}
-	return ret;
-}
-
-int qcom_llcc_remove(struct platform_device *pdev)
-{
-	/* Set the global pointer to a error code to avoid referencing it */
-	drv_data = ERR_PTR(-ENODEV);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(qcom_llcc_remove);
-
-static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
-		const char *name)
-{
-	struct resource *res;
-	void __iomem *base;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
-	if (!res)
-		return ERR_PTR(-ENODEV);
-
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return ERR_CAST(base);
-
-	llcc_regmap_config.name = name;
-	return devm_regmap_init_mmio(&pdev->dev, base, &llcc_regmap_config);
-}
-
-int qcom_llcc_probe(struct platform_device *pdev,
-		      const struct llcc_slice_config *llcc_cfg, u32 sz)
-{
-	u32 num_banks;
-	struct device *dev = &pdev->dev;
-	int ret, i;
-	struct platform_device *llcc_edac;
-
-	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
-	if (!drv_data) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	drv_data->regmap = qcom_llcc_init_mmio(pdev, "llcc_base");
-	if (IS_ERR(drv_data->regmap)) {
-		ret = PTR_ERR(drv_data->regmap);
-		goto err;
-	}
-
-	drv_data->bcast_regmap =
-		qcom_llcc_init_mmio(pdev, "llcc_broadcast_base");
-	if (IS_ERR(drv_data->bcast_regmap)) {
-		ret = PTR_ERR(drv_data->bcast_regmap);
-		goto err;
-	}
-
-	ret = regmap_read(drv_data->regmap, LLCC_COMMON_STATUS0,
-						&num_banks);
-	if (ret)
-		goto err;
-
-	num_banks &= LLCC_LB_CNT_MASK;
-	num_banks >>= LLCC_LB_CNT_SHIFT;
-	drv_data->num_banks = num_banks;
-
-	for (i = 0; i < sz; i++)
-		if (llcc_cfg[i].slice_id > drv_data->max_slices)
-			drv_data->max_slices = llcc_cfg[i].slice_id;
-
-	drv_data->offsets = devm_kcalloc(dev, num_banks, sizeof(u32),
-							GFP_KERNEL);
-	if (!drv_data->offsets) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	for (i = 0; i < num_banks; i++)
-		drv_data->offsets[i] = i * BANK_OFFSET_STRIDE;
-
-	drv_data->bitmap = devm_kcalloc(dev,
-	BITS_TO_LONGS(drv_data->max_slices), sizeof(unsigned long),
-						GFP_KERNEL);
-	if (!drv_data->bitmap) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	drv_data->cfg = llcc_cfg;
-	drv_data->cfg_size = sz;
-	mutex_init(&drv_data->lock);
-	platform_set_drvdata(pdev, drv_data);
-
-	ret = qcom_llcc_cfg_program(pdev);
-	if (ret)
-		goto err;
-
-	drv_data->ecc_irq = platform_get_irq(pdev, 0);
-	if (drv_data->ecc_irq >= 0) {
-		llcc_edac = platform_device_register_data(&pdev->dev,
-						"qcom_llcc_edac", -1, drv_data,
-						sizeof(*drv_data));
-		if (IS_ERR(llcc_edac))
-			dev_err(dev, "Failed to register llcc edac driver\n");
-	}
-
-	return 0;
-err:
-	drv_data = ERR_PTR(-ENODEV);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(qcom_llcc_probe);
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Qualcomm Last Level Cache Controller");
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 5bf754208777..8570f7386a09 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -865,6 +865,7 @@ config SPI_XTENSA_XTFPGA
 config SPI_ZYNQ_QSPI
 	tristate "Xilinx Zynq QSPI controller"
 	depends on ARCH_ZYNQ || COMPILE_TEST
+	depends on SPI_MEM
 	help
 	  This enables support for the Zynq Quad SPI controller
 	  in master mode.
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f4490b812017..450a1eb90af5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -740,7 +740,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	if (result)
 		goto release_ida;
 
-	sprintf(dev->attr_name, "cdev%d_trip_point", dev->id);
+	snprintf(dev->attr_name, sizeof(dev->attr_name), "cdev%d_trip_point",
+		 dev->id);
 	sysfs_attr_init(&dev->attr.attr);
 	dev->attr.attr.name = dev->attr_name;
 	dev->attr.attr.mode = 0444;
@@ -749,7 +750,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	if (result)
 		goto remove_symbol_link;
 
-	sprintf(dev->weight_attr_name, "cdev%d_weight", dev->id);
+	snprintf(dev->weight_attr_name, sizeof(dev->weight_attr_name),
+		 "cdev%d_weight", dev->id);
 	sysfs_attr_init(&dev->weight_attr.attr);
 	dev->weight_attr.attr.name = dev->weight_attr_name;
 	dev->weight_attr.attr.mode = S_IWUSR | S_IRUGO;
diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 813be2c05262..c4bf741533ab 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -290,12 +290,7 @@ void disassociate_ctty(int on_exit)
 		return;
 	}
 
-	spin_lock_irq(&current->sighand->siglock);
-	put_pid(current->signal->tty_old_pgrp);
-	current->signal->tty_old_pgrp = NULL;
-	tty = tty_kref_get(current->signal->tty);
-	spin_unlock_irq(&current->sighand->siglock);
-
+	tty = get_current_tty();
 	if (tty) {
 		unsigned long flags;
 
@@ -310,6 +305,16 @@ void disassociate_ctty(int on_exit)
 		tty_kref_put(tty);
 	}
 
+	/* If tty->ctrl.pgrp is not NULL, it may be assigned to
+	 * current->signal->tty_old_pgrp in a race condition, and
+	 * cause pid memleak. Release current->signal->tty_old_pgrp
+	 * after tty->ctrl.pgrp set to NULL.
+	 */
+	spin_lock_irq(&current->sighand->siglock);
+	put_pid(current->signal->tty_old_pgrp);
+	current->signal->tty_old_pgrp = NULL;
+	spin_unlock_irq(&current->sighand->siglock);
+
 	/* Now clear signal->tty under the lock */
 	read_lock(&tasklist_lock);
 	session_clear_tty(task_session(current));
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index a412ef67af18..7b8dee3087f3 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4684,8 +4684,8 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 	if (qh_allocated && qh->channel && qh->channel->qh == qh)
 		qh->channel->qh = NULL;
 fail2:
-	spin_unlock_irqrestore(&hsotg->lock, flags);
 	urb->hcpriv = NULL;
+	spin_unlock_irqrestore(&hsotg->lock, flags);
 	kfree(qtd);
 fail1:
 	if (qh_allocated) {
diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index 3c6d452e3bf4..4104eea03e80 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -462,8 +462,13 @@ static void stub_disconnect(struct usb_device *udev)
 	/* release port */
 	rc = usb_hub_release_port(udev->parent, udev->portnum,
 				  (struct usb_dev_state *) udev);
-	if (rc) {
-		dev_dbg(&udev->dev, "unable to release port\n");
+	/*
+	 * NOTE: If a HUB disconnect triggered disconnect of the down stream
+	 * device usb_hub_release_port will return -ENODEV so we can safely ignore
+	 * that error here.
+	 */
+	if (rc && (rc != -ENODEV)) {
+		dev_dbg(&udev->dev, "unable to release port (%i)\n", rc);
 		return;
 	}
 
diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index d19f58263b4e..d4c2a6b3839e 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -490,7 +490,7 @@ static enum fsl_diu_monitor_port fsl_diu_name_to_port(const char *s)
  * Workaround for failed writing desc register of planes.
  * Needed with MPC5121 DIU rev 2.0 silicon.
  */
-void wr_reg_wa(u32 *reg, u32 val)
+static void wr_reg_wa(u32 *reg, u32 val)
 {
 	do {
 		out_be32(reg, val);
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 9670e5b5fe32..3155424cca6b 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1489,8 +1489,8 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (!request_mem_region(addr, size, "imsttfb")) {
 		printk(KERN_ERR "imsttfb: Can't reserve memory region\n");
-		framebuffer_release(info);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto release_info;
 	}
 
 	switch (pdev->device) {
@@ -1507,34 +1507,39 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			printk(KERN_INFO "imsttfb: Device 0x%x unknown, "
 					 "contact maintainer.\n", pdev->device);
 			ret = -ENODEV;
-			goto error;
+			goto release_mem_region;
 	}
 
 	info->fix.smem_start = addr;
 	info->screen_base = (__u8 *)ioremap(addr, par->ramdac == IBM ?
 					    0x400000 : 0x800000);
 	if (!info->screen_base)
-		goto error;
+		goto release_mem_region;
 	info->fix.mmio_start = addr + 0x800000;
 	par->dc_regs = ioremap(addr + 0x800000, 0x1000);
 	if (!par->dc_regs)
-		goto error;
+		goto unmap_screen_base;
 	par->cmap_regs_phys = addr + 0x840000;
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	if (!par->cmap_regs)
-		goto error;
+		goto unmap_dc_regs;
 	info->pseudo_palette = par->palette;
 	ret = init_imstt(info);
-	if (!ret)
-		pci_set_drvdata(pdev, info);
-	return ret;
+	if (ret)
+		goto unmap_cmap_regs;
+
+	pci_set_drvdata(pdev, info);
+	return 0;
 
-error:
-	if (par->dc_regs)
-		iounmap(par->dc_regs);
-	if (info->screen_base)
-		iounmap(info->screen_base);
+unmap_cmap_regs:
+	iounmap(par->cmap_regs);
+unmap_dc_regs:
+	iounmap(par->dc_regs);
+unmap_screen_base:
+	iounmap(info->screen_base);
+release_mem_region:
 	release_mem_region(addr, size);
+release_info:
 	framebuffer_release(info);
 	return ret;
 }
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 775245b148bb..1575992d1f14 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2110,7 +2110,7 @@ static noinline int key_in_sk(struct btrfs_key *key,
 static noinline int copy_to_sk(struct btrfs_path *path,
 			       struct btrfs_key *key,
 			       struct btrfs_ioctl_search_key *sk,
-			       size_t *buf_size,
+			       u64 *buf_size,
 			       char __user *ubuf,
 			       unsigned long *sk_offset,
 			       int *num_found)
@@ -2242,7 +2242,7 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 
 static noinline int search_ioctl(struct inode *inode,
 				 struct btrfs_ioctl_search_key *sk,
-				 size_t *buf_size,
+				 u64 *buf_size,
 				 char __user *ubuf)
 {
 	struct btrfs_fs_info *info = btrfs_sb(inode->i_sb);
@@ -2314,7 +2314,7 @@ static noinline int btrfs_ioctl_tree_search(struct file *file,
 	struct btrfs_ioctl_search_key sk;
 	struct inode *inode;
 	int ret;
-	size_t buf_size;
+	u64 buf_size;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -2348,8 +2348,8 @@ static noinline int btrfs_ioctl_tree_search_v2(struct file *file,
 	struct btrfs_ioctl_search_args_v2 args;
 	struct inode *inode;
 	int ret;
-	size_t buf_size;
-	const size_t buf_limit = SZ_16M;
+	u64 buf_size;
+	const u64 buf_limit = SZ_16M;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 478c35d45378..98e1b1ddb4ec 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1036,6 +1036,11 @@ static int ext4_ext_insert_index(handle_t *handle, struct inode *inode,
 		ix = curp->p_idx;
 	}
 
+	if (unlikely(ix > EXT_MAX_INDEX(curp->p_hdr))) {
+		EXT4_ERROR_INODE(inode, "ix > EXT_MAX_INDEX!");
+		return -EFSCORRUPTED;
+	}
+
 	len = EXT_LAST_INDEX(curp->p_hdr) - ix + 1;
 	BUG_ON(len < 0);
 	if (len > 0) {
@@ -1045,11 +1050,6 @@ static int ext4_ext_insert_index(handle_t *handle, struct inode *inode,
 		memmove(ix + 1, ix, len * sizeof(struct ext4_extent_idx));
 	}
 
-	if (unlikely(ix > EXT_MAX_INDEX(curp->p_hdr))) {
-		EXT4_ERROR_INODE(inode, "ix > EXT_MAX_INDEX!");
-		return -EFSCORRUPTED;
-	}
-
 	ix->ei_block = cpu_to_le32(logical);
 	ext4_idx_store_pblock(ix, ptr);
 	le16_add_cpu(&curp->p_hdr->eh_entries, 1);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8d4e66f36cf7..2330600dbe02 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3117,6 +3117,7 @@ int f2fs_precache_extents(struct inode *inode)
 		return -EOPNOTSUPP;
 
 	map.m_lblk = 0;
+	map.m_pblk = 0;
 	map.m_next_pgofs = NULL;
 	map.m_next_extent = &m_next_extent;
 	map.m_seg_type = NO_CHECK_TYPE;
diff --git a/include/linux/idr.h b/include/linux/idr.h
index ac6e946b6767..bbfd934cab22 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -200,7 +200,7 @@ static inline void idr_preload_end(void)
  */
 #define idr_for_each_entry_ul(idr, entry, tmp, id)			\
 	for (tmp = 0, id = 0;						\
-	     tmp <= id && ((entry) = idr_get_next_ul(idr, &(id))) != NULL; \
+	     ((entry) = tmp <= id ? idr_get_next_ul(idr, &(id)) : NULL) != NULL; \
 	     tmp = id, ++id)
 
 /**
@@ -224,10 +224,12 @@ static inline void idr_preload_end(void)
  * @id: Entry ID.
  *
  * Continue to iterate over entries, continuing after the current position.
+ * After normal termination @entry is left with the value NULL.  This
+ * is convenient for a "not found" value.
  */
 #define idr_for_each_entry_continue_ul(idr, entry, tmp, id)		\
 	for (tmp = id;							\
-	     tmp <= id && ((entry) = idr_get_next_ul(idr, &(id))) != NULL; \
+	     ((entry) = tmp <= id ? idr_get_next_ul(idr, &(id)) : NULL) != NULL; \
 	     tmp = id, ++id)
 
 /*
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a3ade51bd9e2..a6bb64dccb88 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4966,5 +4966,6 @@ extern struct net_device *blackhole_netdev;
 #define DEV_STATS_INC(DEV, FIELD) atomic_long_inc(&(DEV)->stats.__##FIELD)
 #define DEV_STATS_ADD(DEV, FIELD, VAL) 	\
 		atomic_long_add((VAL), &(DEV)->stats.__##FIELD)
+#define DEV_STATS_READ(DEV, FIELD) atomic_long_read(&(DEV)->stats.__##FIELD)
 
 #endif	/* _LINUX_NETDEVICE_H */
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index bbb68dba37cc..bc3f1aecaa19 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -322,4 +322,34 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 
 #endif
 
+/**
+ * migrate_disable - Prevent migration of the current task
+ *
+ * Maps to preempt_disable() which also disables preemption. Use
+ * migrate_disable() to annotate that the intent is to prevent migration,
+ * but not necessarily preemption.
+ *
+ * Can be invoked nested like preempt_disable() and needs the corresponding
+ * number of migrate_enable() invocations.
+ */
+static __always_inline void migrate_disable(void)
+{
+	preempt_disable();
+}
+
+/**
+ * migrate_enable - Allow migration of the current task
+ *
+ * Counterpart to migrate_disable().
+ *
+ * As migrate_disable() can be invoked nested, only the outermost invocation
+ * reenables migration.
+ *
+ * Currently mapped to preempt_enable().
+ */
+static __always_inline void migrate_enable(void)
+{
+	preempt_enable();
+}
+
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index eb71a50b8afc..d5cad6f7953c 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -39,18 +39,27 @@ struct llcc_slice_desc {
 
 /**
  * llcc_slice_config - Data associated with the llcc slice
- * @usecase_id: usecase id for which the llcc slice is used
- * @slice_id: llcc slice id assigned to each slice
- * @max_cap: maximum capacity of the llcc slice
- * @priority: priority of the llcc slice
- * @fixed_size: whether the llcc slice can grow beyond its size
- * @bonus_ways: bonus ways associated with llcc slice
- * @res_ways: reserved ways associated with llcc slice
- * @cache_mode: mode of the llcc slice
- * @probe_target_ways: Probe only reserved and bonus ways on a cache miss
- * @dis_cap_alloc: Disable capacity based allocation
- * @retain_on_pc: Retain through power collapse
- * @activate_on_init: activate the slice on init
+ * @usecase_id: Unique id for the client's use case
+ * @slice_id: llcc slice id for each client
+ * @max_cap: The maximum capacity of the cache slice provided in KB
+ * @priority: Priority of the client used to select victim line for replacement
+ * @fixed_size: Boolean indicating if the slice has a fixed capacity
+ * @bonus_ways: Bonus ways are additional ways to be used for any slice,
+ *		if client ends up using more than reserved cache ways. Bonus
+ *		ways are allocated only if they are not reserved for some
+ *		other client.
+ * @res_ways: Reserved ways for the cache slice, the reserved ways cannot
+ *		be used by any other client than the one its assigned to.
+ * @cache_mode: Each slice operates as a cache, this controls the mode of the
+ *             slice: normal or TCM(Tightly Coupled Memory)
+ * @probe_target_ways: Determines what ways to probe for access hit. When
+ *                    configured to 1 only bonus and reserved ways are probed.
+ *                    When configured to 0 all ways in llcc are probed.
+ * @dis_cap_alloc: Disable capacity based allocation for a client
+ * @retain_on_pc: If this bit is set and client has maintained active vote
+ *               then the ways assigned to this client are not flushed on power
+ *               collapse.
+ * @activate_on_init: Activate the slice immediately after it is programmed
  */
 struct llcc_slice_config {
 	u32 usecase_id;
@@ -154,20 +163,6 @@ int llcc_slice_activate(struct llcc_slice_desc *desc);
  */
 int llcc_slice_deactivate(struct llcc_slice_desc *desc);
 
-/**
- * qcom_llcc_probe - program the sct table
- * @pdev: platform device pointer
- * @table: soc sct table
- * @sz: Size of the config table
- */
-int qcom_llcc_probe(struct platform_device *pdev,
-		      const struct llcc_slice_config *table, u32 sz);
-
-/**
- * qcom_llcc_remove - remove the sct table
- * @pdev: Platform device pointer
- */
-int qcom_llcc_remove(struct platform_device *pdev);
 #else
 static inline struct llcc_slice_desc *llcc_slice_getd(u32 uid)
 {
@@ -197,16 +192,6 @@ static inline int llcc_slice_deactivate(struct llcc_slice_desc *desc)
 {
 	return -EINVAL;
 }
-static inline int qcom_llcc_probe(struct platform_device *pdev,
-		      const struct llcc_slice_config *table, u32 sz)
-{
-	return -ENODEV;
-}
-
-static inline int qcom_llcc_remove(struct platform_device *pdev)
-{
-	return -ENODEV;
-}
 #endif
 
 #endif
diff --git a/include/linux/soc/ti/ti_sci_inta_msi.h b/include/linux/soc/ti/ti_sci_inta_msi.h
index 11fb5048f5f6..e3aa8b14612e 100644
--- a/include/linux/soc/ti/ti_sci_inta_msi.h
+++ b/include/linux/soc/ti/ti_sci_inta_msi.h
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 TI SCI INTA MSI helper
  *
- * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 9531ec823298..0fc452dd96d4 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments System Control Interface Protocol
  *
- * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
  *	Nishanth Menon
  */
 
diff --git a/include/net/flow.h b/include/net/flow.h
index d058e63fb59a..21e781c74ac5 100644
--- a/include/net/flow.h
+++ b/include/net/flow.h
@@ -39,8 +39,8 @@ struct flowi_common {
 #define FLOWI_FLAG_SKIP_NH_OIF		0x04
 	__u32	flowic_secid;
 	kuid_t  flowic_uid;
-	struct flowi_tunnel flowic_tun_key;
 	__u32		flowic_multipath_hash;
+	struct flowi_tunnel flowic_tun_key;
 };
 
 union flowi_uli {
diff --git a/include/net/netfilter/nf_nat_redirect.h b/include/net/netfilter/nf_nat_redirect.h
index 2418653a66db..279380de904c 100644
--- a/include/net/netfilter/nf_nat_redirect.h
+++ b/include/net/netfilter/nf_nat_redirect.h
@@ -6,8 +6,7 @@
 #include <uapi/linux/netfilter/nf_nat.h>
 
 unsigned int
-nf_nat_redirect_ipv4(struct sk_buff *skb,
-		     const struct nf_nat_ipv4_multi_range_compat *mr,
+nf_nat_redirect_ipv4(struct sk_buff *skb, const struct nf_nat_range2 *range,
 		     unsigned int hooknum);
 unsigned int
 nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4fcae463ba19..af67e19eba39 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -553,7 +553,7 @@ static inline u32 tcp_cookie_time(void)
 u32 __cookie_v4_init_sequence(const struct iphdr *iph, const struct tcphdr *th,
 			      u16 *mssp);
 __u32 cookie_v4_init_sequence(const struct sk_buff *skb, __u16 *mss);
-u64 cookie_init_timestamp(struct request_sock *req);
+u64 cookie_init_timestamp(struct request_sock *req, u64 now);
 bool cookie_timestamp_decode(const struct net *net,
 			     struct tcp_options_received *opt);
 bool cookie_ecn_ok(const struct tcp_options_received *opt,
@@ -775,10 +775,16 @@ static inline u32 tcp_time_stamp(const struct tcp_sock *tp)
 	return div_u64(tp->tcp_mstamp, USEC_PER_SEC / TCP_TS_HZ);
 }
 
+/* Convert a nsec timestamp into TCP TSval timestamp (ms based currently) */
+static inline u64 tcp_ns_to_ts(u64 ns)
+{
+	return div_u64(ns, NSEC_PER_SEC / TCP_TS_HZ);
+}
+
 /* Could use tcp_clock_us() / 1000, but this version uses a single divide */
 static inline u32 tcp_time_stamp_raw(void)
 {
-	return div_u64(tcp_clock_ns(), NSEC_PER_SEC / TCP_TS_HZ);
+	return tcp_ns_to_ts(tcp_clock_ns());
 }
 
 void tcp_mstamp_refresh(struct tcp_sock *tp);
@@ -790,7 +796,7 @@ static inline u32 tcp_stamp_us_delta(u64 t1, u64 t0)
 
 static inline u32 tcp_skb_timestamp(const struct sk_buff *skb)
 {
-	return div_u64(skb->skb_mstamp_ns, NSEC_PER_SEC / TCP_TS_HZ);
+	return tcp_ns_to_ts(skb->skb_mstamp_ns);
 }
 
 /* provide the departure time in us unit */
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 8e586858bcf4..d25edbb87119 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -466,16 +466,16 @@ unsigned int irq_matrix_reserved(struct irq_matrix *m)
 }
 
 /**
- * irq_matrix_allocated - Get the number of allocated irqs on the local cpu
+ * irq_matrix_allocated - Get the number of allocated non-managed irqs on the local CPU
  * @m:		Pointer to the matrix to search
  *
- * This returns number of allocated irqs
+ * This returns number of allocated non-managed interrupts.
  */
 unsigned int irq_matrix_allocated(struct irq_matrix *m)
 {
 	struct cpumap *cm = this_cpu_ptr(m->maps);
 
-	return cm->allocated;
+	return cm->allocated - cm->managed_allocated;
 }
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
diff --git a/mm/readahead.c b/mm/readahead.c
index 2fe72cd29b47..95fbc02cae6a 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -592,7 +592,8 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
 	 */
 	ret = -EINVAL;
 	if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
-	    !S_ISREG(file_inode(f.file)->i_mode))
+	    (!S_ISREG(file_inode(f.file)->i_mode) &&
+	    !S_ISBLK(file_inode(f.file)->i_mode)))
 		goto out;
 
 	ret = vfs_fadvise(f.file, offset, count, POSIX_FADV_WILLNEED);
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 249beb41ff89..944cc34f707d 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -611,9 +611,6 @@ int dccp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	if (dccp_parse_options(sk, dreq, skb))
 		goto drop_and_free;
 
-	if (security_inet_conn_request(sk, skb, req))
-		goto drop_and_free;
-
 	ireq = inet_rsk(req);
 	sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
 	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
@@ -621,6 +618,9 @@ int dccp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	ireq->ireq_family = AF_INET;
 	ireq->ir_iif = sk->sk_bound_dev_if;
 
+	if (security_inet_conn_request(sk, skb, req))
+		goto drop_and_free;
+
 	/*
 	 * Step 3: Process LISTEN state
 	 *
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index a7e393902253..c3a378ef95aa 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -349,15 +349,15 @@ static int dccp_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 	if (dccp_parse_options(sk, dreq, skb))
 		goto drop_and_free;
 
-	if (security_inet_conn_request(sk, skb, req))
-		goto drop_and_free;
-
 	ireq = inet_rsk(req);
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
 	ireq->ireq_family = AF_INET6;
 	ireq->ir_mark = inet_request_mark(sk, skb);
 
+	if (security_inet_conn_request(sk, skb, req))
+		goto drop_and_free;
+
 	if (ipv6_opt_accepted(sk, skb, IP6CB(skb)) ||
 	    np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
 	    np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim) {
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 3f6c9514c7a9..3cc22f776a31 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -43,7 +43,6 @@ static siphash_key_t syncookie_secret[2] __read_mostly;
  * requested/supported by the syn/synack exchange.
  */
 #define TSBITS	6
-#define TSMASK	(((__u32)1 << TSBITS) - 1)
 
 static u32 cookie_hash(__be32 saddr, __be32 daddr, __be16 sport, __be16 dport,
 		       u32 count, int c)
@@ -62,29 +61,24 @@ static u32 cookie_hash(__be32 saddr, __be32 daddr, __be16 sport, __be16 dport,
  * Since subsequent timestamps use the normal tcp_time_stamp value, we
  * must make sure that the resulting initial timestamp is <= tcp_time_stamp.
  */
-u64 cookie_init_timestamp(struct request_sock *req)
+u64 cookie_init_timestamp(struct request_sock *req, u64 now)
 {
-	struct inet_request_sock *ireq;
-	u32 ts, ts_now = tcp_time_stamp_raw();
+	const struct inet_request_sock *ireq = inet_rsk(req);
+	u64 ts, ts_now = tcp_ns_to_ts(now);
 	u32 options = 0;
 
-	ireq = inet_rsk(req);
-
 	options = ireq->wscale_ok ? ireq->snd_wscale : TS_OPT_WSCALE_MASK;
 	if (ireq->sack_ok)
 		options |= TS_OPT_SACK;
 	if (ireq->ecn_ok)
 		options |= TS_OPT_ECN;
 
-	ts = ts_now & ~TSMASK;
+	ts = (ts_now >> TSBITS) << TSBITS;
 	ts |= options;
-	if (ts > ts_now) {
-		ts >>= TSBITS;
-		ts--;
-		ts <<= TSBITS;
-		ts |= options;
-	}
-	return (u64)ts * (NSEC_PER_SEC / TCP_TS_HZ);
+	if (ts > ts_now)
+		ts -= (1UL << TSBITS);
+
+	return ts * (NSEC_PER_SEC / TCP_TS_HZ);
 }
 
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c3f227c4c356..fe5ef114beba 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6176,22 +6176,23 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 
 static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
 	struct request_sock *req;
 
 	/* If we are still handling the SYNACK RTO, see if timestamp ECR allows
 	 * undo. If peer SACKs triggered fast recovery, we can't undo here.
 	 */
-	if (inet_csk(sk)->icsk_ca_state == TCP_CA_Loss)
-		tcp_try_undo_loss(sk, false);
+	if (inet_csk(sk)->icsk_ca_state == TCP_CA_Loss && !tp->packets_out)
+		tcp_try_undo_recovery(sk);
 
 	/* Reset rtx states to prevent spurious retransmits_timed_out() */
-	tcp_sk(sk)->retrans_stamp = 0;
+	tp->retrans_stamp = 0;
 	inet_csk(sk)->icsk_retransmits = 0;
 
 	/* Once we leave TCP_SYN_RECV or TCP_FIN_WAIT_1,
 	 * we no longer need req so release it.
 	 */
-	req = rcu_dereference_protected(tcp_sk(sk)->fastopen_rsk,
+	req = rcu_dereference_protected(tp->fastopen_rsk,
 					lockdep_sock_is_held(sk));
 	reqsk_fastopen_remove(sk, req, false);
 
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index e89e19a6852c..627e3be0f754 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -466,11 +466,15 @@ void tcp_init_metrics(struct sock *sk)
 	u32 val, crtt = 0; /* cached RTT scaled by 8 */
 
 	sk_dst_confirm(sk);
+	/* ssthresh may have been reduced unnecessarily during.
+	 * 3WHS. Restore it back to its initial default.
+	 */
+	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	if (!dst)
 		goto reset;
 
 	rcu_read_lock();
-	tm = tcp_get_metrics(sk, dst, true);
+	tm = tcp_get_metrics(sk, dst, false);
 	if (!tm) {
 		rcu_read_unlock();
 		goto reset;
@@ -484,11 +488,6 @@ void tcp_init_metrics(struct sock *sk)
 		tp->snd_ssthresh = val;
 		if (tp->snd_ssthresh > tp->snd_cwnd_clamp)
 			tp->snd_ssthresh = tp->snd_cwnd_clamp;
-	} else {
-		/* ssthresh may have been reduced unnecessarily during.
-		 * 3WHS. Restore it back to its initial default.
-		 */
-		tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	}
 	val = tcp_metric_get(tm, TCP_METRIC_REORDERING);
 	if (val && tp->reordering != val)
@@ -903,7 +902,7 @@ static void tcp_metrics_flush_all(struct net *net)
 			match = net ? net_eq(tm_net(tm), net) :
 				!refcount_read(&tm_net(tm)->count);
 			if (match) {
-				*pp = tm->tcpm_next;
+				rcu_assign_pointer(*pp, tm->tcpm_next);
 				kfree_rcu(tm, rcu_head);
 			} else {
 				pp = &tm->tcpm_next;
@@ -944,7 +943,7 @@ static int tcp_metrics_nl_cmd_del(struct sk_buff *skb, struct genl_info *info)
 		if (addr_same(&tm->tcpm_daddr, &daddr) &&
 		    (!src || addr_same(&tm->tcpm_saddr, &saddr)) &&
 		    net_eq(tm_net(tm), net)) {
-			*pp = tm->tcpm_next;
+			rcu_assign_pointer(*pp, tm->tcpm_next);
 			kfree_rcu(tm, rcu_head);
 			found = true;
 		} else {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 16e0249b11f6..010743686017 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3349,7 +3349,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	now = tcp_clock_ns();
 #ifdef CONFIG_SYN_COOKIES
 	if (unlikely(req->cookie_ts))
-		skb->skb_mstamp_ns = cookie_init_timestamp(req);
+		skb->skb_mstamp_ns = cookie_init_timestamp(req, now);
 	else
 #endif
 	{
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 816275b2135f..d3455585e6a8 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -177,7 +177,13 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 		int err;
 
 		skb_mark_not_on_list(segs);
-		err = ip6_fragment(net, sk, segs, ip6_finish_output2);
+		/* Last GSO segment can be smaller than gso_size (and MTU).
+		 * Adding a fragment header would produce an "atomic fragment",
+		 * which is considered harmful (RFC-8021). Avoid that.
+		 */
+		err = segs->len > mtu ?
+			ip6_fragment(net, sk, segs, ip6_finish_output2) :
+			ip6_finish_output2(net, sk, segs);
 		if (err && ret == 0)
 			ret = err;
 	}
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 7e5550546594..8c3beffbaf06 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -180,14 +180,15 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	treq->af_specific = &tcp_request_sock_ipv6_ops;
 	treq->tfo_listener = false;
 
-	if (security_inet_conn_request(sk, skb, req))
-		goto out_free;
-
 	req->mss = mss;
 	ireq->ir_rmt_port = th->source;
 	ireq->ir_num = ntohs(th->dest);
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
+
+	if (security_inet_conn_request(sk, skb, req))
+		goto out_free;
+
 	if (ipv6_opt_accepted(sk, skb, &TCP_SKB_CB(skb)->header.h6) ||
 	    np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
 	    np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim) {
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index f9e801cc50f5..f4fb309185ce 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -127,8 +127,14 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 	skb->transport_header += llc_len;
 	skb_pull(skb, llc_len);
 	if (skb->protocol == htons(ETH_P_802_2)) {
-		__be16 pdulen = eth_hdr(skb)->h_proto;
-		s32 data_size = ntohs(pdulen) - llc_len;
+		__be16 pdulen;
+		s32 data_size;
+
+		if (skb->mac_len < ETH_HLEN)
+			return 0;
+
+		pdulen = eth_hdr(skb)->h_proto;
+		data_size = ntohs(pdulen) - llc_len;
 
 		if (data_size < 0 ||
 		    !pskb_may_pull(skb, data_size))
diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
index 9fa3342c7a82..df26557a0244 100644
--- a/net/llc/llc_s_ac.c
+++ b/net/llc/llc_s_ac.c
@@ -153,6 +153,9 @@ int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb)
 	int rc = 1;
 	u32 data_size;
 
+	if (skb->mac_len < ETH_HLEN)
+		return 1;
+
 	llc_pdu_decode_sa(skb, mac_da);
 	llc_pdu_decode_da(skb, mac_sa);
 	llc_pdu_decode_ssap(skb, &dsap);
diff --git a/net/llc/llc_station.c b/net/llc/llc_station.c
index c29170e767a8..64e2c67e16ba 100644
--- a/net/llc/llc_station.c
+++ b/net/llc/llc_station.c
@@ -77,6 +77,9 @@ static int llc_station_ac_send_test_r(struct sk_buff *skb)
 	u32 data_size;
 	struct sk_buff *nskb;
 
+	if (skb->mac_len < ETH_HLEN)
+		goto out;
+
 	/* The test request command is type U (llc_len = 3) */
 	data_size = ntohs(eth_hdr(skb)->h_proto) - 3;
 	nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U, data_size);
diff --git a/net/netfilter/nf_nat_redirect.c b/net/netfilter/nf_nat_redirect.c
index f91579c821e9..5b37487d9d11 100644
--- a/net/netfilter/nf_nat_redirect.c
+++ b/net/netfilter/nf_nat_redirect.c
@@ -10,6 +10,7 @@
 
 #include <linux/if.h>
 #include <linux/inetdevice.h>
+#include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
@@ -24,81 +25,104 @@
 #include <net/netfilter/nf_nat.h>
 #include <net/netfilter/nf_nat_redirect.h>
 
+static unsigned int
+nf_nat_redirect(struct sk_buff *skb, const struct nf_nat_range2 *range,
+		const union nf_inet_addr *newdst)
+{
+	struct nf_nat_range2 newrange;
+	enum ip_conntrack_info ctinfo;
+	struct nf_conn *ct;
+
+	ct = nf_ct_get(skb, &ctinfo);
+
+	memset(&newrange, 0, sizeof(newrange));
+
+	newrange.flags		= range->flags | NF_NAT_RANGE_MAP_IPS;
+	newrange.min_addr	= *newdst;
+	newrange.max_addr	= *newdst;
+	newrange.min_proto	= range->min_proto;
+	newrange.max_proto	= range->max_proto;
+
+	return nf_nat_setup_info(ct, &newrange, NF_NAT_MANIP_DST);
+}
+
 unsigned int
-nf_nat_redirect_ipv4(struct sk_buff *skb,
-		     const struct nf_nat_ipv4_multi_range_compat *mr,
+nf_nat_redirect_ipv4(struct sk_buff *skb, const struct nf_nat_range2 *range,
 		     unsigned int hooknum)
 {
-	struct nf_conn *ct;
-	enum ip_conntrack_info ctinfo;
-	__be32 newdst;
-	struct nf_nat_range2 newrange;
+	union nf_inet_addr newdst = {};
 
 	WARN_ON(hooknum != NF_INET_PRE_ROUTING &&
 		hooknum != NF_INET_LOCAL_OUT);
 
-	ct = nf_ct_get(skb, &ctinfo);
-	WARN_ON(!(ct && (ctinfo == IP_CT_NEW || ctinfo == IP_CT_RELATED)));
-
 	/* Local packets: make them go to loopback */
 	if (hooknum == NF_INET_LOCAL_OUT) {
-		newdst = htonl(0x7F000001);
+		newdst.ip = htonl(INADDR_LOOPBACK);
 	} else {
 		const struct in_device *indev;
 
-		newdst = 0;
-
 		indev = __in_dev_get_rcu(skb->dev);
 		if (indev) {
 			const struct in_ifaddr *ifa;
 
 			ifa = rcu_dereference(indev->ifa_list);
 			if (ifa)
-				newdst = ifa->ifa_local;
+				newdst.ip = ifa->ifa_local;
 		}
 
-		if (!newdst)
+		if (!newdst.ip)
 			return NF_DROP;
 	}
 
-	/* Transfer from original range. */
-	memset(&newrange.min_addr, 0, sizeof(newrange.min_addr));
-	memset(&newrange.max_addr, 0, sizeof(newrange.max_addr));
-	newrange.flags	     = mr->range[0].flags | NF_NAT_RANGE_MAP_IPS;
-	newrange.min_addr.ip = newdst;
-	newrange.max_addr.ip = newdst;
-	newrange.min_proto   = mr->range[0].min;
-	newrange.max_proto   = mr->range[0].max;
-
-	/* Hand modified range to generic setup. */
-	return nf_nat_setup_info(ct, &newrange, NF_NAT_MANIP_DST);
+	return nf_nat_redirect(skb, range, &newdst);
 }
 EXPORT_SYMBOL_GPL(nf_nat_redirect_ipv4);
 
 static const struct in6_addr loopback_addr = IN6ADDR_LOOPBACK_INIT;
 
+static bool nf_nat_redirect_ipv6_usable(const struct inet6_ifaddr *ifa, unsigned int scope)
+{
+	unsigned int ifa_addr_type = ipv6_addr_type(&ifa->addr);
+
+	if (ifa_addr_type & IPV6_ADDR_MAPPED)
+		return false;
+
+	if ((ifa->flags & IFA_F_TENTATIVE) && (!(ifa->flags & IFA_F_OPTIMISTIC)))
+		return false;
+
+	if (scope) {
+		unsigned int ifa_scope = ifa_addr_type & IPV6_ADDR_SCOPE_MASK;
+
+		if (!(scope & ifa_scope))
+			return false;
+	}
+
+	return true;
+}
+
 unsigned int
 nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
 		     unsigned int hooknum)
 {
-	struct nf_nat_range2 newrange;
-	struct in6_addr newdst;
-	enum ip_conntrack_info ctinfo;
-	struct nf_conn *ct;
+	union nf_inet_addr newdst = {};
 
-	ct = nf_ct_get(skb, &ctinfo);
 	if (hooknum == NF_INET_LOCAL_OUT) {
-		newdst = loopback_addr;
+		newdst.in6 = loopback_addr;
 	} else {
+		unsigned int scope = ipv6_addr_scope(&ipv6_hdr(skb)->daddr);
 		struct inet6_dev *idev;
-		struct inet6_ifaddr *ifa;
 		bool addr = false;
 
 		idev = __in6_dev_get(skb->dev);
 		if (idev != NULL) {
+			const struct inet6_ifaddr *ifa;
+
 			read_lock_bh(&idev->lock);
 			list_for_each_entry(ifa, &idev->addr_list, if_list) {
-				newdst = ifa->addr;
+				if (!nf_nat_redirect_ipv6_usable(ifa, scope))
+					continue;
+
+				newdst.in6 = ifa->addr;
 				addr = true;
 				break;
 			}
@@ -109,12 +133,6 @@ nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
 			return NF_DROP;
 	}
 
-	newrange.flags		= range->flags | NF_NAT_RANGE_MAP_IPS;
-	newrange.min_addr.in6	= newdst;
-	newrange.max_addr.in6	= newdst;
-	newrange.min_proto	= range->min_proto;
-	newrange.max_proto	= range->max_proto;
-
-	return nf_nat_setup_info(ct, &newrange, NF_NAT_MANIP_DST);
+	return nf_nat_redirect(skb, range, &newdst);
 }
 EXPORT_SYMBOL_GPL(nf_nat_redirect_ipv6);
diff --git a/net/netfilter/nft_redir.c b/net/netfilter/nft_redir.c
index 81a191eb5c36..7179dada5757 100644
--- a/net/netfilter/nft_redir.c
+++ b/net/netfilter/nft_redir.c
@@ -64,6 +64,8 @@ static int nft_redir_init(const struct nft_ctx *ctx,
 		} else {
 			priv->sreg_proto_max = priv->sreg_proto_min;
 		}
+
+		priv->flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
 	}
 
 	if (tb[NFTA_REDIR_FLAGS]) {
@@ -98,25 +100,37 @@ static int nft_redir_dump(struct sk_buff *skb, const struct nft_expr *expr)
 	return -1;
 }
 
-static void nft_redir_ipv4_eval(const struct nft_expr *expr,
-				struct nft_regs *regs,
-				const struct nft_pktinfo *pkt)
+static void nft_redir_eval(const struct nft_expr *expr,
+			   struct nft_regs *regs,
+			   const struct nft_pktinfo *pkt)
 {
-	struct nft_redir *priv = nft_expr_priv(expr);
-	struct nf_nat_ipv4_multi_range_compat mr;
+	const struct nft_redir *priv = nft_expr_priv(expr);
+	struct nf_nat_range2 range;
 
-	memset(&mr, 0, sizeof(mr));
+	memset(&range, 0, sizeof(range));
+	range.flags = priv->flags;
 	if (priv->sreg_proto_min) {
-		mr.range[0].min.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_min]);
-		mr.range[0].max.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_max]);
-		mr.range[0].flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
+		range.min_proto.all = (__force __be16)
+			nft_reg_load16(&regs->data[priv->sreg_proto_min]);
+		range.max_proto.all = (__force __be16)
+			nft_reg_load16(&regs->data[priv->sreg_proto_max]);
 	}
 
-	mr.range[0].flags |= priv->flags;
-
-	regs->verdict.code = nf_nat_redirect_ipv4(pkt->skb, &mr, nft_hook(pkt));
+	switch (nft_pf(pkt)) {
+	case NFPROTO_IPV4:
+		regs->verdict.code = nf_nat_redirect_ipv4(pkt->skb, &range,
+							  nft_hook(pkt));
+		break;
+#ifdef CONFIG_NF_TABLES_IPV6
+	case NFPROTO_IPV6:
+		regs->verdict.code = nf_nat_redirect_ipv6(pkt->skb, &range,
+							  nft_hook(pkt));
+		break;
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
 }
 
 static void
@@ -129,7 +143,7 @@ static struct nft_expr_type nft_redir_ipv4_type;
 static const struct nft_expr_ops nft_redir_ipv4_ops = {
 	.type		= &nft_redir_ipv4_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_redir)),
-	.eval		= nft_redir_ipv4_eval,
+	.eval		= nft_redir_eval,
 	.init		= nft_redir_init,
 	.destroy	= nft_redir_ipv4_destroy,
 	.dump		= nft_redir_dump,
@@ -146,28 +160,6 @@ static struct nft_expr_type nft_redir_ipv4_type __read_mostly = {
 };
 
 #ifdef CONFIG_NF_TABLES_IPV6
-static void nft_redir_ipv6_eval(const struct nft_expr *expr,
-				struct nft_regs *regs,
-				const struct nft_pktinfo *pkt)
-{
-	struct nft_redir *priv = nft_expr_priv(expr);
-	struct nf_nat_range2 range;
-
-	memset(&range, 0, sizeof(range));
-	if (priv->sreg_proto_min) {
-		range.min_proto.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_min]);
-		range.max_proto.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_max]);
-		range.flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
-	}
-
-	range.flags |= priv->flags;
-
-	regs->verdict.code =
-		nf_nat_redirect_ipv6(pkt->skb, &range, nft_hook(pkt));
-}
-
 static void
 nft_redir_ipv6_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
 {
@@ -178,7 +170,7 @@ static struct nft_expr_type nft_redir_ipv6_type;
 static const struct nft_expr_ops nft_redir_ipv6_ops = {
 	.type		= &nft_redir_ipv6_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_redir)),
-	.eval		= nft_redir_ipv6_eval,
+	.eval		= nft_redir_eval,
 	.init		= nft_redir_init,
 	.destroy	= nft_redir_ipv6_destroy,
 	.dump		= nft_redir_dump,
@@ -196,20 +188,6 @@ static struct nft_expr_type nft_redir_ipv6_type __read_mostly = {
 #endif
 
 #ifdef CONFIG_NF_TABLES_INET
-static void nft_redir_inet_eval(const struct nft_expr *expr,
-				struct nft_regs *regs,
-				const struct nft_pktinfo *pkt)
-{
-	switch (nft_pf(pkt)) {
-	case NFPROTO_IPV4:
-		return nft_redir_ipv4_eval(expr, regs, pkt);
-	case NFPROTO_IPV6:
-		return nft_redir_ipv6_eval(expr, regs, pkt);
-	}
-
-	WARN_ON_ONCE(1);
-}
-
 static void
 nft_redir_inet_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
 {
@@ -220,7 +198,7 @@ static struct nft_expr_type nft_redir_inet_type;
 static const struct nft_expr_ops nft_redir_inet_ops = {
 	.type		= &nft_redir_inet_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_redir)),
-	.eval		= nft_redir_inet_eval,
+	.eval		= nft_redir_eval,
 	.init		= nft_redir_init,
 	.destroy	= nft_redir_inet_destroy,
 	.dump		= nft_redir_dump,
diff --git a/net/netfilter/xt_REDIRECT.c b/net/netfilter/xt_REDIRECT.c
index 353ca7801251..ff66b56a3f97 100644
--- a/net/netfilter/xt_REDIRECT.c
+++ b/net/netfilter/xt_REDIRECT.c
@@ -46,7 +46,6 @@ static void redirect_tg_destroy(const struct xt_tgdtor_param *par)
 	nf_ct_netns_put(par->net, par->family);
 }
 
-/* FIXME: Take multiple ranges --RR */
 static int redirect_tg4_check(const struct xt_tgchk_param *par)
 {
 	const struct nf_nat_ipv4_multi_range_compat *mr = par->targinfo;
@@ -65,7 +64,14 @@ static int redirect_tg4_check(const struct xt_tgchk_param *par)
 static unsigned int
 redirect_tg4(struct sk_buff *skb, const struct xt_action_param *par)
 {
-	return nf_nat_redirect_ipv4(skb, par->targinfo, xt_hooknum(par));
+	const struct nf_nat_ipv4_multi_range_compat *mr = par->targinfo;
+	struct nf_nat_range2 range = {
+		.flags       = mr->range[0].flags,
+		.min_proto   = mr->range[0].min,
+		.max_proto   = mr->range[0].max,
+	};
+
+	return nf_nat_redirect_ipv4(skb, &range, xt_hooknum(par));
 }
 
 static struct xt_target redirect_tg_reg[] __read_mostly = {
diff --git a/net/netfilter/xt_recent.c b/net/netfilter/xt_recent.c
index 3469b6073610..6fc0deb11aff 100644
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -561,7 +561,7 @@ recent_mt_proc_write(struct file *file, const char __user *input,
 {
 	struct recent_table *t = PDE_DATA(file_inode(file));
 	struct recent_entry *e;
-	char buf[sizeof("+b335:1d35:1e55:dead:c0de:1715:5afe:c0de")];
+	char buf[sizeof("+b335:1d35:1e55:dead:c0de:1715:255.255.255.255")];
 	const char *c = buf;
 	union nf_inet_addr addr = {};
 	u_int16_t family;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b398d72a7bc3..e070b0e2a30c 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -136,7 +136,7 @@ static int __smc_release(struct smc_sock *smc)
 
 	if (!smc->use_fallback) {
 		rc = smc_close_active(smc);
-		sock_set_flag(sk, SOCK_DEAD);
+		smc_sock_set_flag(sk, SOCK_DEAD);
 		sk->sk_shutdown |= SHUTDOWN_MASK;
 	} else {
 		if (sk->sk_state != SMC_CLOSED) {
@@ -928,7 +928,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 		if (new_clcsock)
 			sock_release(new_clcsock);
 		new_sk->sk_state = SMC_CLOSED;
-		sock_set_flag(new_sk, SOCK_DEAD);
+		smc_sock_set_flag(new_sk, SOCK_DEAD);
 		sock_put(new_sk); /* final */
 		*new_smc = NULL;
 		goto out;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 878313f8d6c1..8c46eaf014a7 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -265,4 +265,9 @@ static inline bool using_ipsec(struct smc_sock *smc)
 struct sock *smc_accept_dequeue(struct sock *parent, struct socket *new_sock);
 void smc_close_non_accepted(struct sock *sk);
 
+static inline void smc_sock_set_flag(struct sock *sk, enum sock_flags flag)
+{
+	set_bit(flag, &sk->sk_flags);
+}
+
 #endif	/* __SMC_H */
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index d0b0f4c865b4..68e1155126cf 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -298,7 +298,7 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 		smc->sk.sk_shutdown |= RCV_SHUTDOWN;
 		if (smc->clcsock && smc->clcsock->sk)
 			smc->clcsock->sk->sk_shutdown |= RCV_SHUTDOWN;
-		sock_set_flag(&smc->sk, SOCK_DONE);
+		smc_sock_set_flag(&smc->sk, SOCK_DONE);
 		sock_hold(&smc->sk); /* sock_put in close_work */
 		if (!schedule_work(&conn->close_work))
 			sock_put(&smc->sk);
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 543948d970c5..a704234c1a2b 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -164,7 +164,7 @@ static void smc_close_active_abort(struct smc_sock *smc)
 		break;
 	}
 
-	sock_set_flag(sk, SOCK_DEAD);
+	smc_sock_set_flag(sk, SOCK_DEAD);
 	sk->sk_state_change(sk);
 }
 
diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
index e9bbf4a00881..5c58aff4d4fa 100644
--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -87,7 +87,7 @@ const struct nla_policy tipc_nl_net_policy[TIPC_NLA_NET_MAX + 1] = {
 
 const struct nla_policy tipc_nl_link_policy[TIPC_NLA_LINK_MAX + 1] = {
 	[TIPC_NLA_LINK_UNSPEC]		= { .type = NLA_UNSPEC },
-	[TIPC_NLA_LINK_NAME]		= { .type = NLA_STRING,
+	[TIPC_NLA_LINK_NAME]		= { .type = NLA_NUL_STRING,
 					    .len = TIPC_MAX_LINK_NAME },
 	[TIPC_NLA_LINK_MTU]		= { .type = NLA_U32 },
 	[TIPC_NLA_LINK_BROADCAST]	= { .type = NLA_FLAG },
@@ -118,7 +118,7 @@ const struct nla_policy tipc_nl_prop_policy[TIPC_NLA_PROP_MAX + 1] = {
 
 const struct nla_policy tipc_nl_bearer_policy[TIPC_NLA_BEARER_MAX + 1]	= {
 	[TIPC_NLA_BEARER_UNSPEC]	= { .type = NLA_UNSPEC },
-	[TIPC_NLA_BEARER_NAME]		= { .type = NLA_STRING,
+	[TIPC_NLA_BEARER_NAME]		= { .type = NLA_NUL_STRING,
 					    .len = TIPC_MAX_BEARER_NAME },
 	[TIPC_NLA_BEARER_PROP]		= { .type = NLA_NESTED },
 	[TIPC_NLA_BEARER_DOMAIN]	= { .type = NLA_U32 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 8c0d1c191d55..7b845483717b 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1302,13 +1302,13 @@ static int do_typec_entry(const char *filename, void *symval, char *alias)
 /* Looks like: tee:uuid */
 static int do_tee_entry(const char *filename, void *symval, char *alias)
 {
-	DEF_FIELD(symval, tee_client_device_id, uuid);
+	DEF_FIELD_ADDR(symval, tee_client_device_id, uuid);
 
 	sprintf(alias, "tee:%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
-		uuid.b[0], uuid.b[1], uuid.b[2], uuid.b[3], uuid.b[4],
-		uuid.b[5], uuid.b[6], uuid.b[7], uuid.b[8], uuid.b[9],
-		uuid.b[10], uuid.b[11], uuid.b[12], uuid.b[13], uuid.b[14],
-		uuid.b[15]);
+		uuid->b[0], uuid->b[1], uuid->b[2], uuid->b[3], uuid->b[4],
+		uuid->b[5], uuid->b[6], uuid->b[7], uuid->b[8], uuid->b[9],
+		uuid->b[10], uuid->b[11], uuid->b[12], uuid->b[13], uuid->b[14],
+		uuid->b[15]);
 
 	add_wildcard(alias);
 	return 1;
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index d43cbf4a71ef..d4db64d72b2c 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -299,6 +299,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 		module->instance_id = devm_kzalloc(ctx->dev, size, GFP_KERNEL);
 		if (!module->instance_id) {
 			ret = -ENOMEM;
+			kfree(module);
 			goto free_uuid_list;
 		}
 
diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index 8e2fb81ad05c..84cbd7446b1e 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -303,7 +303,7 @@ static int cx81801_open(struct tty_struct *tty)
 static void cx81801_close(struct tty_struct *tty)
 {
 	struct snd_soc_component *component = tty->disc_data;
-	struct snd_soc_dapm_context *dapm = &component->card->dapm;
+	struct snd_soc_dapm_context *dapm;
 
 	del_timer_sync(&cx81801_timer);
 
@@ -315,6 +315,8 @@ static void cx81801_close(struct tty_struct *tty)
 
 	v253_ops.close(tty);
 
+	dapm = &component->card->dapm;
+
 	/* Revert back to default audio input/output constellation */
 	snd_soc_dapm_mutex_lock(dapm);
 
diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 34d63bcebcd2..2fd10eab75b5 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -49,12 +49,15 @@ enum autochan {
  * Has the side effect of filling the channels[i].location values used
  * in processing the buffer output.
  **/
-int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
+static unsigned int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 {
-	int bytes = 0;
-	int i = 0;
+	unsigned int bytes = 0;
+	int i = 0, max = 0;
+	unsigned int misalignment;
 
 	while (i < num_channels) {
+		if (channels[i].bytes > max)
+			max = channels[i].bytes;
 		if (bytes % channels[i].bytes == 0)
 			channels[i].location = bytes;
 		else
@@ -64,11 +67,19 @@ int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 		bytes = channels[i].location + channels[i].bytes;
 		i++;
 	}
+	/*
+	 * We want the data in next sample to also be properly aligned so
+	 * we'll add padding at the end if needed. Adding padding only
+	 * works for channel data which size is 2^n bytes.
+	 */
+	misalignment = bytes % max;
+	if (misalignment)
+		bytes += max - misalignment;
 
 	return bytes;
 }
 
-void print1byte(uint8_t input, struct iio_channel_info *info)
+static void print1byte(uint8_t input, struct iio_channel_info *info)
 {
 	/*
 	 * Shift before conversion to avoid sign extension
@@ -85,7 +96,7 @@ void print1byte(uint8_t input, struct iio_channel_info *info)
 	}
 }
 
-void print2byte(uint16_t input, struct iio_channel_info *info)
+static void print2byte(uint16_t input, struct iio_channel_info *info)
 {
 	/* First swap if incorrect endian */
 	if (info->be)
@@ -108,7 +119,7 @@ void print2byte(uint16_t input, struct iio_channel_info *info)
 	}
 }
 
-void print4byte(uint32_t input, struct iio_channel_info *info)
+static void print4byte(uint32_t input, struct iio_channel_info *info)
 {
 	/* First swap if incorrect endian */
 	if (info->be)
@@ -131,7 +142,7 @@ void print4byte(uint32_t input, struct iio_channel_info *info)
 	}
 }
 
-void print8byte(uint64_t input, struct iio_channel_info *info)
+static void print8byte(uint64_t input, struct iio_channel_info *info)
 {
 	/* First swap if incorrect endian */
 	if (info->be)
@@ -167,9 +178,8 @@ void print8byte(uint64_t input, struct iio_channel_info *info)
  *			      to fill the location offsets.
  * @num_channels:	number of channels
  **/
-void process_scan(char *data,
-		  struct iio_channel_info *channels,
-		  int num_channels)
+static void process_scan(char *data, struct iio_channel_info *channels,
+			 int num_channels)
 {
 	int k;
 
@@ -238,7 +248,7 @@ static int enable_disable_all_channels(char *dev_dir_name, int enable)
 	return 0;
 }
 
-void print_usage(void)
+static void print_usage(void)
 {
 	fprintf(stderr, "Usage: generic_buffer [options]...\n"
 		"Capture, convert and output data from IIO device buffer\n"
@@ -257,12 +267,12 @@ void print_usage(void)
 		"  -w <n>     Set delay between reads in us (event-less mode)\n");
 }
 
-enum autochan autochannels = AUTOCHANNELS_DISABLED;
-char *dev_dir_name = NULL;
-char *buf_dir_name = NULL;
-bool current_trigger_set = false;
+static enum autochan autochannels = AUTOCHANNELS_DISABLED;
+static char *dev_dir_name = NULL;
+static char *buf_dir_name = NULL;
+static bool current_trigger_set = false;
 
-void cleanup(void)
+static void cleanup(void)
 {
 	int ret;
 
@@ -294,14 +304,14 @@ void cleanup(void)
 	}
 }
 
-void sig_handler(int signum)
+static void sig_handler(int signum)
 {
 	fprintf(stderr, "Caught signal %d\n", signum);
 	cleanup();
 	exit(-signum);
 }
 
-void register_cleanup(void)
+static void register_cleanup(void)
 {
 	struct sigaction sa = { .sa_handler = sig_handler };
 	const int signums[] = { SIGINT, SIGTERM, SIGABRT };
@@ -343,7 +353,7 @@ int main(int argc, char **argv)
 	ssize_t read_size;
 	int dev_num = -1, trig_num = -1;
 	char *buffer_access = NULL;
-	int scan_size;
+	unsigned int scan_size;
 	int noevents = 0;
 	int notrigger = 0;
 	char *dummy;
@@ -613,7 +623,16 @@ int main(int argc, char **argv)
 	}
 
 	scan_size = size_from_channelarray(channels, num_channels);
-	data = malloc(scan_size * buf_len);
+
+	size_t total_buf_len = scan_size * buf_len;
+
+	if (scan_size > 0 && total_buf_len / scan_size != buf_len) {
+		ret = -EFAULT;
+		perror("Integer overflow happened when calculate scan_size * buf_len");
+		goto error;
+	}
+
+	data = malloc(total_buf_len);
 	if (!data) {
 		ret = -ENOMEM;
 		goto error;
