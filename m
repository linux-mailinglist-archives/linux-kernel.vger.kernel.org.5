Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3F07A8D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjITT6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjITT6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:58:33 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCDAF1;
        Wed, 20 Sep 2023 12:58:23 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bfc1d8f2d2so1846461fa.0;
        Wed, 20 Sep 2023 12:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239901; x=1695844701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2m14abObIwVOTnzzN0qiVIdW0RP4getGDnrkVkhG8M=;
        b=er+jiRnSLIaZaWz08IDJOgHWxhjg79APKuQdD3etvPMEjF60RYzw0rfNM6ldsCVF4q
         nYyaipBVKawDPSsC4FB85n1HmYanLHkMDzAOG//11rvlMwFu4R95jBeB2BJT9710uLRj
         4aKqzbd0bt8fE7iIsxmEx9rBVvQLP6JKSnq1HWiKPyWpnmArh8Eyjtj8DMGdoSG/JGD4
         pqA5Nm80uTWYMSlpkrKstXeFt0WSPI4/NdUJGT7bCbbTBuPxiW6JbngGYcRKSGmFD7O8
         NfRic4AVZox6e6UEn2kUi7pgXL68v5emPMdhBMxL10E6IdpYICm9tCRo7KYjLIEbM8Zb
         kO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239901; x=1695844701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2m14abObIwVOTnzzN0qiVIdW0RP4getGDnrkVkhG8M=;
        b=KpXdNnoqQxQLghnBgR0snetLhdCm47ghe04Rc8XGyG2fzt+xRQKdbsJEmernLa8t1t
         Z329xpR8sxHo42xTKfxw1IAdpeNqUJHeSDMaygWwLsDbI17l3iTiJgVMIM7dLT5b2htn
         a7THBdBLPXfM9goiLcZ5+Ai1bU4sVLY6sW3dCgch9PsLe0EtTZOVA7D5do2hcUcJpUrT
         kW6XMk8p91sssgod5feyvgrB9ZT70WHqkoq5tbFIOBgFoLZlBy5h8bem2eCaoF0QW8zp
         mcRrcpSjQqCmAkkMUEzZEGuEwQytzio+9iwn9SL/qr3Orpx9+FPrsb2l5aw89igOFmlg
         MRKA==
X-Gm-Message-State: AOJu0YyXLKj3h22xkFxcvm7kpY6J8U0MMA8yaZ/btrWrXqRLHVZ/7qMW
        9vRLCb35pW1IeVjoGl1Q9kBYGBJOLTLmEA==
X-Google-Smtp-Source: AGHT+IHCrMsfMt5QfQ0loPlFFm/IKiGzFXuv6BbiZlH2IIqx+sLJ9I//Hq2+6d3lWNiVT6f0EMBp6w==
X-Received: by 2002:a2e:3513:0:b0:2bd:1615:f9f9 with SMTP id z19-20020a2e3513000000b002bd1615f9f9mr1389758ljz.0.1695239901337;
        Wed, 20 Sep 2023 12:58:21 -0700 (PDT)
Received: from localhost ([85.140.0.70])
        by smtp.gmail.com with ESMTPSA id v8-20020a2ea448000000b002c128e45245sm157523ljn.23.2023.09.20.12.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:58:20 -0700 (PDT)
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
Subject: [PATCH v4 11/13] EDAC/synopsys: Add ECC Scrubber support
Date:   Wed, 20 Sep 2023 22:56:42 +0300
Message-ID: <20230920195720.32047-12-fancer.lancer@gmail.com>
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

DW uMCTL2 DDR controller IP-core can by synthesized with an embedded
Scrubber engine. The ECC Scrubber (SBR) is a block which initiates
periodic background burst read commands to the DDRC and further towards
the DDR memory in an attempt to trigger Correctable or Uncorrectable
errors. If a Correctable error is detected the ECC Scrub feature will
execute the Read-Modify-Write (RMW) procedure in order to fix the ECC. In
case of the Uncorrectable error it will be just reported as the
corresponding IRQ event. So it's definitely very useful feature. Let's add
it to the driver then especially seeing the MCI core already has some
infrastructure for it.

First of all the Scrubber clock needs to be enabled if one is supplied
otherwise the engine won't work.

Secondly the Scrubber engine support needs to be detected. Alas there is
no any special CSR indicating whether the DW uMCTL2 DDRC IP-core has been
synthesized with one embedded. Instead implement the detection procedure
based on the Scrubber-specific CSRs writability. So if the SBRWDATA0 CSR
is writable then the CSR exists, which means the Scrubber is available,
otherwise the capability will be considered as absent.

Thirdly the MCI core provides two callbacks utilized for the Scrubber
tuning: set the Scrubber bandwidth in bytes, which can also be used to
disable the periodic scrubbing; get the Scrubber bandwidth (zero if
disabled). Both of them can be implemented by using the Scrubber CSRs the
controller provides. In particular aside with the back-to-back periodic
reads the Scrubber provides a way to delay the next read command for the
predefined set of 512's Core/Scrubber clock cycles. It can be used to
change the Scrubber bandwidth from the DDR maximal bandwidth (no delay) to
up to (0x1FFF * 512) Core/Scrubber clock cycles (see the inline comments
for details and utilized formulae). Note the Scrubber clock must be
synchronous to the Core clock by the controller design so use the Core
clock rate for the calculations. Pleas also note if no Core clock
specified the Scrubber will still be supported, but the bandwidth will be
used directly to calculate the Scrubber reads interval. The back-to-back
reads mode in this case will be indicated by the INT_MAX bandwidth.

Fourthly the back-to-back scrubbing most likely will cause the significant
system performance drop. The manual says that it has been added to the
controller for the initial SDRAM initialization and the fast SDRAM
scrubbing after getting out of the low-power state. In anyway it is
supposed to be enabled only for a single SDRAM pass. So preserve that
semantic here to avoid the system lagging and disable the back-to-back
scrubbing in the Scrubber Done IRQ handler after the Scrubbing work is
done.

Finally the denoted scrub-rate callbacks and the SCRUB_FLAG_HW_PROG and
SCRUB_FLAG_HW_TUN flags will be set to the MCI descriptor based on the
detected Scrubber capability. So no capability - no flags and no
callbacks.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v4:
- Use div_u64() instead of do_div().
- Use FIELD_MAX() instead of open-coding the bitwise shift to find
  the max field value.
---
 drivers/edac/synopsys_edac.c | 299 +++++++++++++++++++++++++++++++++++
 1 file changed, 299 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index ab4c7cc2daf5..e589aa9f7876 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -12,12 +12,14 @@
 #include <linux/edac.h>
 #include <linux/fs.h>
 #include <linux/log2.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/pfn.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
 #include <linux/sizes.h>
 #include <linux/spinlock.h>
+#include <linux/units.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -34,6 +36,7 @@
 
 /* DDR capabilities */
 #define SNPS_CAP_ECC_SCRUB		BIT(0)
+#define SNPS_CAP_ECC_SCRUBBER		BIT(1)
 #define SNPS_CAP_ZYNQMP			BIT(31)
 
 /* Synopsys uMCTL2 DDR controller registers that are relevant to ECC */
@@ -102,6 +105,12 @@
 #define DDR_SARBASE0_OFST		0xF04
 #define DDR_SARSIZE0_OFST		0xF08
 
+/* ECC Scrubber Registers */
+#define ECC_SBRCTL_OFST			0xF24
+#define ECC_SBRSTAT_OFST		0xF28
+#define ECC_SBRWDATA0_OFST		0xF2C
+#define ECC_SBRWDATA1_OFST		0xF30
+
 /* ZynqMP DDR QOS Registers */
 #define ZYNQMP_DDR_QOS_IRQ_STAT_OFST	0x20200
 #define ZYNQMP_DDR_QOS_IRQ_EN_OFST	0x20208
@@ -242,6 +251,18 @@
 #define DDR_MAX_NSAR			4
 #define DDR_MIN_SARSIZE			SZ_256M
 
+/* ECC Scrubber registers definitions */
+#define ECC_SBRCTL_SCRUB_INTERVAL	GENMASK(20, 8)
+#define ECC_SBRCTL_INTERVAL_STEP	512
+#define ECC_SBRCTL_INTERVAL_MIN		0
+#define ECC_SBRCTL_INTERVAL_SAFE	1
+#define ECC_SBRCTL_INTERVAL_MAX		FIELD_MAX(ECC_SBRCTL_SCRUB_INTERVAL)
+#define ECC_SBRCTL_SCRUB_BURST		GENMASK(6, 4)
+#define ECC_SBRCTL_SCRUB_MODE_WR	BIT(2)
+#define ECC_SBRCTL_SCRUB_EN		BIT(0)
+#define ECC_SBRSTAT_SCRUB_DONE		BIT(1)
+#define ECC_SBRSTAT_SCRUB_BUSY		BIT(0)
+
 /* ZynqMP DDR QOS Interrupt register definitions */
 #define ZYNQMP_DDR_QOS_UE_MASK		BIT(2)
 #define ZYNQMP_DDR_QOS_CE_MASK		BIT(1)
@@ -912,6 +933,47 @@ static irqreturn_t snps_dfi_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/**
+ * snps_sbr_irq_handler - Scrubber Done interrupt handler.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
+ *
+ * It just checks whether the IRQ has been caused by the Scrubber Done event
+ * and disables the back-to-back scrubbing by falling back to the smallest
+ * delay between the Scrubber read commands.
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
+ */
+static irqreturn_t snps_sbr_irq_handler(int irq, void *dev_id)
+{
+	struct mem_ctl_info *mci = dev_id;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	unsigned long flags;
+	u32 regval, en;
+
+	/* Make sure IRQ is caused by the Scrubber Done event */
+	regval = readl(priv->baseaddr + ECC_SBRSTAT_OFST);
+	if (!(regval & ECC_SBRSTAT_SCRUB_DONE))
+		return IRQ_NONE;
+
+	spin_lock_irqsave(&priv->reglock, flags);
+
+	regval = readl(priv->baseaddr + ECC_SBRCTL_OFST);
+	en = regval & ECC_SBRCTL_SCRUB_EN;
+	writel(regval & ~en, priv->baseaddr + ECC_SBRCTL_OFST);
+
+	regval = FIELD_PREP(ECC_SBRCTL_SCRUB_INTERVAL, ECC_SBRCTL_INTERVAL_SAFE);
+	writel(regval, priv->baseaddr + ECC_SBRCTL_OFST);
+
+	writel(regval | en, priv->baseaddr + ECC_SBRCTL_OFST);
+
+	spin_unlock_irqrestore(&priv->reglock, flags);
+
+	edac_mc_printk(mci, KERN_WARNING, "Back-to-back scrubbing disabled\n");
+
+	return IRQ_HANDLED;
+}
+
 /**
  * snps_com_irq_handler - Interrupt IRQ signal handler.
  * @irq:        IRQ number.
@@ -921,6 +983,8 @@ static irqreturn_t snps_dfi_irq_handler(int irq, void *dev_id)
  */
 static irqreturn_t snps_com_irq_handler(int irq, void *dev_id)
 {
+	struct mem_ctl_info *mci = dev_id;
+	struct snps_edac_priv *priv = mci->pvt_info;
 	irqreturn_t rc = IRQ_NONE;
 
 	rc |= snps_ce_irq_handler(irq, dev_id);
@@ -929,6 +993,9 @@ static irqreturn_t snps_com_irq_handler(int irq, void *dev_id)
 
 	rc |= snps_dfi_irq_handler(irq, dev_id);
 
+	if (priv->info.caps & SNPS_CAP_ECC_SCRUBBER)
+		rc |= snps_sbr_irq_handler(irq, dev_id);
+
 	return rc;
 }
 
@@ -983,6 +1050,200 @@ static void snps_disable_irq(struct snps_edac_priv *priv)
 	spin_unlock_irqrestore(&priv->reglock, flags);
 }
 
+/**
+ * snps_get_sdram_bw - Get SDRAM bandwidth.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * The SDRAM interface bandwidth is calculated based on the DDRC Core clock rate
+ * and the DW uMCTL2 IP-core parameters like DQ-bus width and mode and
+ * Core/SDRAM clocks frequency ratio. Note it returns the theoretical bandwidth
+ * which in reality is hardly possible to reach.
+ *
+ * Return: SDRAM bandwidth or zero if no Core clock specified.
+ */
+static u64 snps_get_sdram_bw(struct snps_edac_priv *priv)
+{
+	unsigned long rate;
+
+	/*
+	 * Depending on the ratio mode the SDRAM clock either matches the Core
+	 * clock or runs with the twice its frequency.
+	 */
+	rate = clk_get_rate(priv->clks[SNPS_CORE_CLK].clk);
+	rate *= priv->info.freq_ratio;
+
+	/*
+	 * Scale up by 2 since it's DDR (Double Data Rate) and subtract the
+	 * DQ-mode since in non-Full mode only a part of the DQ-bus is utilised
+	 * on each SDRAM clock edge.
+	 */
+	return (2U << (priv->info.dq_width - priv->info.dq_mode)) * (u64)rate;
+}
+
+/**
+ * snps_get_scrub_bw - Get Scrubber bandwidth.
+ * @priv:	DDR memory controller private instance data.
+ * @interval:	Scrub interval.
+ *
+ * DW uMCTL2 DDRC Scrubber performs periodical progressive burst reads (RMW if
+ * ECC CE is detected) commands from the whole memory space. The read commands
+ * can be delayed by means of the SBRCTL.scrub_interval field. The Scrubber
+ * cycles look as follows:
+ *
+ * |-HIF-burst-read-|-------delay-------|-HIF-burst-read-|------- etc
+ *
+ * Tb = Bl*[DQ]/Bw[RAM], Td = 512*interval/Fc - periods of the HIF-burst-read
+ * and delay stages, where
+ * Bl - HIF burst length, [DQ] - Full DQ-bus width, Bw[RAM] - SDRAM bandwidth,
+ * Fc - Core clock frequency (Scrubber and Core clocks are synchronous).
+ *
+ * After some simple calculations the expressions above can be used to get the
+ * next Scrubber bandwidth formulae:
+ *
+ * Bw[Sbr] = Bw[RAM] / (1 + F * interval), where
+ * F = 2 * 512 * Fr * Fc * [DQ]e - interval scale factor with
+ * Fr - HIF/SDRAM clock frequency ratio (1 or 2), [DQ]e - DQ-bus width mode.
+ *
+ * Return: Scrubber bandwidth or zero if no Core clock specified.
+ */
+static u64 snps_get_scrub_bw(struct snps_edac_priv *priv, u32 interval)
+{
+	unsigned long fac;
+	u64 bw_ram;
+
+	fac = (2 * ECC_SBRCTL_INTERVAL_STEP * priv->info.freq_ratio) /
+	      (priv->info.hif_burst_len * (1UL << priv->info.dq_mode));
+
+	bw_ram = snps_get_sdram_bw(priv);
+
+	return div_u64(bw_ram, 1 + fac * interval);
+}
+
+/**
+ * snps_get_scrub_interval - Get Scrubber delay interval.
+ * @priv:	DDR memory controller private instance data.
+ * @bw:		Scrubber bandwidth.
+ *
+ * Similarly to the Scrubber bandwidth the interval formulae can be inferred
+ * from the same expressions:
+ *
+ * interval = (Bw[RAM] - Bw[Sbr]) / (F * Bw[Sbr])
+ *
+ * Return: Scrubber delay interval or zero if no Core clock specified.
+ */
+static u32 snps_get_scrub_interval(struct snps_edac_priv *priv, u32 bw)
+{
+	unsigned long fac;
+	u64 bw_ram;
+
+	fac = (2 * priv->info.freq_ratio * ECC_SBRCTL_INTERVAL_STEP) /
+	      (priv->info.hif_burst_len * (1UL << priv->info.dq_mode));
+
+	bw_ram = snps_get_sdram_bw(priv);
+
+	/* Divide twice so not to cause the integer overflow in (fac * bw) */
+	return div_u64(div_u64(bw_ram - bw, bw), fac);
+}
+
+/**
+ * snps_set_sdram_scrub_rate - Set the Scrubber bandwidth.
+ * @mci:	EDAC memory controller instance.
+ * @bw:		Bandwidth.
+ *
+ * It calculates the delay between the Scrubber read commands based on the
+ * specified bandwidth and the Core clock rate. If the Core clock is unavailable
+ * the passed bandwidth will be directly used as the interval value.
+ *
+ * Note the method warns about the back-to-back scrubbing since it may
+ * significantly degrade the system performance. This mode is supposed to be
+ * used for a single SDRAM scrubbing pass only. So it will be turned off in the
+ * Scrubber Done IRQ handler.
+ *
+ * Return: Actually set bandwidth (interval-based approximated bandwidth if the
+ * Core clock is unavailable) or zero if the Scrubber was disabled.
+ */
+static int snps_set_sdram_scrub_rate(struct mem_ctl_info *mci, u32 bw)
+{
+	struct snps_edac_priv *priv = mci->pvt_info;
+	u32 regval, interval;
+	unsigned long flags;
+	u64 bw_min, bw_max;
+
+	/* Don't bother with the calculations just disable and return. */
+	if (!bw) {
+		spin_lock_irqsave(&priv->reglock, flags);
+
+		regval = readl(priv->baseaddr + ECC_SBRCTL_OFST);
+		regval &= ~ECC_SBRCTL_SCRUB_EN;
+		writel(regval, priv->baseaddr + ECC_SBRCTL_OFST);
+
+		spin_unlock_irqrestore(&priv->reglock, flags);
+
+		return 0;
+	}
+
+	/* If no Core clock specified fallback to the direct interval setup. */
+	bw_max = snps_get_scrub_bw(priv, ECC_SBRCTL_INTERVAL_MIN);
+	if (bw_max) {
+		bw_min = snps_get_scrub_bw(priv, ECC_SBRCTL_INTERVAL_MAX);
+		bw = clamp_t(u64, bw, bw_min, bw_max);
+
+		interval = snps_get_scrub_interval(priv, bw);
+	} else {
+		bw = clamp_val(bw, ECC_SBRCTL_INTERVAL_MIN, ECC_SBRCTL_INTERVAL_MAX);
+
+		interval = ECC_SBRCTL_INTERVAL_MAX - bw;
+	}
+
+	/*
+	 * SBRCTL.scrub_en bitfield must be accessed separately from the other
+	 * CSR bitfields. It means the flag must be set/cleared with no updates
+	 * to the rest of the fields.
+	 */
+	spin_lock_irqsave(&priv->reglock, flags);
+
+	regval = FIELD_PREP(ECC_SBRCTL_SCRUB_INTERVAL, interval);
+	writel(regval, priv->baseaddr + ECC_SBRCTL_OFST);
+
+	writel(regval | ECC_SBRCTL_SCRUB_EN, priv->baseaddr + ECC_SBRCTL_OFST);
+
+	spin_unlock_irqrestore(&priv->reglock, flags);
+
+	if (!interval)
+		edac_mc_printk(mci, KERN_WARNING, "Back-to-back scrubbing enabled\n");
+
+	if (!bw_max)
+		return interval ? bw : INT_MAX;
+
+	return snps_get_scrub_bw(priv, interval);
+}
+
+/**
+ * snps_get_sdram_scrub_rate - Get the Scrubber bandwidth.
+ * @mci:	EDAC memory controller instance.
+ *
+ * Return: Scrubber bandwidth (interval-based approximated bandwidth if the
+ * Core clock is unavailable) or zero if the Scrubber was disabled.
+ */
+static int snps_get_sdram_scrub_rate(struct mem_ctl_info *mci)
+{
+	struct snps_edac_priv *priv = mci->pvt_info;
+	u32 regval;
+	u64 bw;
+
+	regval = readl(priv->baseaddr + ECC_SBRCTL_OFST);
+	if (!(regval & ECC_SBRCTL_SCRUB_EN))
+		return 0;
+
+	regval = FIELD_GET(ECC_SBRCTL_SCRUB_INTERVAL, regval);
+
+	bw = snps_get_scrub_bw(priv, regval);
+	if (!bw)
+		return regval ? ECC_SBRCTL_INTERVAL_MAX - regval : INT_MAX;
+
+	return bw;
+}
+
 /**
  * snps_create_data - Create private data.
  * @pdev:	platform device.
@@ -1049,7 +1310,18 @@ static int snps_get_res(struct snps_edac_priv *priv)
 		return rc;
 	}
 
+	rc = clk_prepare_enable(priv->clks[SNPS_SBR_CLK].clk);
+	if (rc) {
+		edac_printk(KERN_INFO, EDAC_MC, "Couldn't enable Scrubber clock\n");
+		goto err_disable_pclk;
+	}
+
 	return 0;
+
+err_disable_pclk:
+	clk_disable_unprepare(priv->clks[SNPS_CSR_CLK].clk);
+
+	return rc;
 }
 
 /**
@@ -1058,6 +1330,8 @@ static int snps_get_res(struct snps_edac_priv *priv)
  */
 static void snps_put_res(struct snps_edac_priv *priv)
 {
+	clk_disable_unprepare(priv->clks[SNPS_SBR_CLK].clk);
+
 	clk_disable_unprepare(priv->clks[SNPS_CSR_CLK].clk);
 }
 
@@ -1158,6 +1432,14 @@ static int snps_get_ddrc_info(struct snps_edac_priv *priv)
 	if (!(regval & ECC_CFG0_DIS_SCRUB))
 		priv->info.caps |= SNPS_CAP_ECC_SCRUB;
 
+	/* Auto-detect the scrubber by writing to the SBRWDATA0 CSR */
+	regval = readl(priv->baseaddr + ECC_SBRWDATA0_OFST);
+	writel(~regval, priv->baseaddr + ECC_SBRWDATA0_OFST);
+	if (regval != readl(priv->baseaddr + ECC_SBRWDATA0_OFST)) {
+		priv->info.caps |= SNPS_CAP_ECC_SCRUBBER;
+		writel(regval, priv->baseaddr + ECC_SBRWDATA0_OFST);
+	}
+
 	/* Auto-detect the basic HIF/SDRAM bus parameters */
 	regval = readl(priv->baseaddr + DDR_MSTR_OFST);
 
@@ -1644,6 +1926,12 @@ static struct mem_ctl_info *snps_mc_create(struct snps_edac_priv *priv)
 		mci->scrub_cap = SCRUB_FLAG_SW_SRC;
 	}
 
+	if (priv->info.caps & SNPS_CAP_ECC_SCRUBBER) {
+		mci->scrub_cap |= SCRUB_FLAG_HW_PROG | SCRUB_FLAG_HW_TUN;
+		mci->set_sdram_scrub_rate = snps_set_sdram_scrub_rate;
+		mci->get_sdram_scrub_rate = snps_get_sdram_scrub_rate;
+	}
+
 	mci->ctl_name = "snps_umctl2_ddrc";
 	mci->dev_name = SNPS_EDAC_MOD_STRING;
 	mci->mod_name = SNPS_EDAC_MOD_VER;
@@ -1718,6 +2006,15 @@ static int snps_request_ind_irq(struct mem_ctl_info *mci)
 		}
 	}
 
+	irq = platform_get_irq_byname_optional(priv->pdev, "ecc_sbr");
+	if (irq > 0) {
+		rc = devm_request_irq(dev, irq, snps_sbr_irq_handler, 0, "ecc_sbr", mci);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_MC, "Failed to request Sbr IRQ\n");
+			return rc;
+		}
+	}
+
 	return 0;
 }
 
@@ -1824,6 +2121,8 @@ static int snps_ddrc_info_show(struct seq_file *s, void *data)
 	if (priv->info.caps) {
 		if (priv->info.caps & SNPS_CAP_ECC_SCRUB)
 			seq_puts(s, " +Scrub");
+		if (priv->info.caps & SNPS_CAP_ECC_SCRUBBER)
+			seq_puts(s, " +Scrubber");
 		if (priv->info.caps & SNPS_CAP_ZYNQMP)
 			seq_puts(s, " +ZynqMP");
 	} else {
-- 
2.41.0

