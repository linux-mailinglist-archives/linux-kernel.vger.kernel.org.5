Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BD378171E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 05:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245055AbjHSDSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 23:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244797AbjHSDRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 23:17:40 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84CB422C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 20:17:38 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1c4d8eaa8ebso980072fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 20:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692415058; x=1693019858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DQwNNrrtVCT1lLuabGTe5r6Le72ZgleU8XG8wqlJaU=;
        b=KZnsI2frS8f19EqyRQwavdJnykidAx+LH2FzPONwEGalZsPbjh8DDMo6++Bw8p/kWb
         JFunValfCFYRcWIsU4vandkZU7eWr0blqGFSQR8kJJi7LTusS8JkQQH8/N/MGy8P3FDC
         1se/QTLNn7fXOEsrIQc6St1a92WXH54mgQnjTzjzwBmFXD5USVK6ghGkDUhod6hiCnK3
         u++iM22rFYepHpqUMgSx44AevgdbcrhG7gxsyZErip+/NeNCbgCCvLokMOtCOGoRquy8
         E3iixOKDXW4y1S/IEk7hI3a7LYelHPozIIGne2EU0nQJVQXGpXmEf3bhMubPVLm6r62I
         gbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692415058; x=1693019858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DQwNNrrtVCT1lLuabGTe5r6Le72ZgleU8XG8wqlJaU=;
        b=TZgY8Dszuzz/c9ghDkYVXT6kwLivtrN5eMQlR2ggffyE8gK4ms7C7fx3Aq9M/H/4bl
         8BpoykXSCDbfiVirqE6lODpo+/BnW0s3sd0qt4DtLwi0u2R0HXLFmia/RgZK9IfeXACu
         lY8yLl5fpClaQPKXBzX4FmpMBw0hHb8HKYCU+K1Os8EEie2hMxcEHiJ37ovSXPKn4pmF
         c05nVA0sBEnVm2coidTawvPBOkZetpDACx1Gz0xb4Jj1Au/XXHHzn3ricZc2kTAa9QX0
         T0zYS1do3Bhex8g0m9dTunBZWBX8hOIeB8cpZrygaYV4zxH2ERlF4Zha5nZ34IKFSErg
         cx8Q==
X-Gm-Message-State: AOJu0YzUF5LaT0t7Nq70hdu9ijKPIbvxi8YqG0cgwi7JTehRaZR5RRtP
        3ovlAx7cv7Sh//2VRb5qskQMZg==
X-Google-Smtp-Source: AGHT+IG9+tvpUlnk8cAJd8EALh9FR9Ev77lqz1NyZ7whINiZTja6Zelg0JAusKenuNC7JUynVd3GDQ==
X-Received: by 2002:a05:6870:2188:b0:19f:6711:8e0a with SMTP id l8-20020a056870218800b0019f67118e0amr1165180oae.32.1692415058070;
        Fri, 18 Aug 2023 20:17:38 -0700 (PDT)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id r2-20020a056870878200b001c4b473581fsm1725223oam.12.2023.08.18.20.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 20:17:37 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     JaeHun Jung <jh0801.jung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 6/8] phy: exynos5-usbdrd: Add Exynos850 support
Date:   Fri, 18 Aug 2023 22:17:29 -0500
Message-Id: <20230819031731.22618-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819031731.22618-1-semen.protsenko@linaro.org>
References: <20230819031731.22618-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement Exynos850 USB 2.0 DRD PHY controller support. Exynos850 has
quite a different PHY controller than Exynos5 compatible controllers,
but it's still possible to implement it on top of existing
exynos5-usbdrd driver infrastructure.

Only UTMI+ (USB 2.0) PHY interface is implemented, as Exynos850 doesn't
support USB 3.0.

Only two clocks are used for this controller:
  - phy: bus clock, used for PHY registers access
  - ref: PHY reference clock (OSCCLK)

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 169 +++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 41508db87b9b..3f310b28bfff 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -145,6 +145,34 @@
 #define LANE0_TX_DEBUG_RXDET_MEAS_TIME_62M5		(0x20 << 4)
 #define LANE0_TX_DEBUG_RXDET_MEAS_TIME_96M_100M		(0x40 << 4)
 
+/* Exynos850: USB DRD PHY registers */
+#define EXYNOS850_DRD_LINKCTRL			0x04
+#define LINKCTRL_BUS_FILTER_BYPASS(_x)		((_x) << 4)
+#define LINKCTRL_FORCE_QACT			BIT(8)
+
+#define EXYNOS850_DRD_CLKRST			0x20
+#define CLKRST_LINK_SW_RST			BIT(0)
+#define CLKRST_PORT_RST				BIT(1)
+#define CLKRST_PHY_SW_RST			BIT(3)
+
+#define EXYNOS850_DRD_UTMI			0x50
+#define UTMI_FORCE_SLEEP			BIT(0)
+#define UTMI_FORCE_SUSPEND			BIT(1)
+#define UTMI_DM_PULLDOWN			BIT(2)
+#define UTMI_DP_PULLDOWN			BIT(3)
+#define UTMI_FORCE_BVALID			BIT(4)
+#define UTMI_FORCE_VBUSVALID			BIT(5)
+
+#define EXYNOS850_DRD_HSP			0x54
+#define HSP_COMMONONN				BIT(8)
+#define HSP_EN_UTMISUSPEND			BIT(9)
+#define HSP_VBUSVLDEXT				BIT(12)
+#define HSP_VBUSVLDEXTSEL			BIT(13)
+#define HSP_FSV_OUT_EN				BIT(24)
+
+#define EXYNOS850_DRD_HSP_TEST			0x5c
+#define HSP_TEST_SIDDQ				BIT(24)
+
 #define KHZ	1000
 #define MHZ	(KHZ * KHZ)
 
@@ -716,6 +744,129 @@ static const struct phy_ops exynos5_usbdrd_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static void exynos850_usbdrd_utmi_init(struct exynos5_usbdrd_phy *phy_drd)
+{
+	void __iomem *regs_base = phy_drd->reg_phy;
+	u32 reg;
+
+	/*
+	 * Disable HWACG (hardware auto clock gating control). This will force
+	 * QACTIVE signal in Q-Channel interface to HIGH level, to make sure
+	 * the PHY clock is not gated by the hardware.
+	 */
+	reg = readl(regs_base + EXYNOS850_DRD_LINKCTRL);
+	reg |= LINKCTRL_FORCE_QACT;
+	writel(reg, regs_base + EXYNOS850_DRD_LINKCTRL);
+
+	/* Start PHY Reset (POR=high) */
+	reg = readl(regs_base + EXYNOS850_DRD_CLKRST);
+	reg |= CLKRST_PHY_SW_RST;
+	writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
+
+	/* Enable UTMI+ */
+	reg = readl(regs_base + EXYNOS850_DRD_UTMI);
+	reg &= ~(UTMI_FORCE_SUSPEND | UTMI_FORCE_SLEEP | UTMI_DP_PULLDOWN |
+		 UTMI_DM_PULLDOWN);
+	writel(reg, regs_base + EXYNOS850_DRD_UTMI);
+
+	/* Set PHY clock and control HS PHY */
+	reg = readl(regs_base + EXYNOS850_DRD_HSP);
+	reg |= HSP_EN_UTMISUSPEND | HSP_COMMONONN;
+	writel(reg, regs_base + EXYNOS850_DRD_HSP);
+
+	/* Set VBUS Valid and D+ pull-up control by VBUS pad usage */
+	reg = readl(regs_base + EXYNOS850_DRD_LINKCTRL);
+	reg |= LINKCTRL_BUS_FILTER_BYPASS(0xf);
+	writel(reg, regs_base + EXYNOS850_DRD_LINKCTRL);
+
+	reg = readl(regs_base + EXYNOS850_DRD_UTMI);
+	reg |= UTMI_FORCE_BVALID | UTMI_FORCE_VBUSVALID;
+	writel(reg, regs_base + EXYNOS850_DRD_UTMI);
+
+	reg = readl(regs_base + EXYNOS850_DRD_HSP);
+	reg |= HSP_VBUSVLDEXT | HSP_VBUSVLDEXTSEL;
+	writel(reg, regs_base + EXYNOS850_DRD_HSP);
+
+	/* Power up PHY analog blocks */
+	reg = readl(regs_base + EXYNOS850_DRD_HSP_TEST);
+	reg &= ~HSP_TEST_SIDDQ;
+	writel(reg, regs_base + EXYNOS850_DRD_HSP_TEST);
+
+	/* Finish PHY reset (POR=low) */
+	udelay(10); /* required before doing POR=low */
+	reg = readl(regs_base + EXYNOS850_DRD_CLKRST);
+	reg &= ~(CLKRST_PHY_SW_RST | CLKRST_PORT_RST);
+	writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
+	udelay(75); /* required after POR=low for guaranteed PHY clock */
+
+	/* Disable single ended signal out */
+	reg = readl(regs_base + EXYNOS850_DRD_HSP);
+	reg &= ~HSP_FSV_OUT_EN;
+	writel(reg, regs_base + EXYNOS850_DRD_HSP);
+}
+
+static int exynos850_usbdrd_phy_init(struct phy *phy)
+{
+	struct phy_usb_instance *inst = phy_get_drvdata(phy);
+	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
+	int ret;
+
+	ret = clk_prepare_enable(phy_drd->clk);
+	if (ret)
+		return ret;
+
+	/* UTMI or PIPE3 specific init */
+	inst->phy_cfg->phy_init(phy_drd);
+
+	clk_disable_unprepare(phy_drd->clk);
+
+	return 0;
+}
+
+static int exynos850_usbdrd_phy_exit(struct phy *phy)
+{
+	struct phy_usb_instance *inst = phy_get_drvdata(phy);
+	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
+	void __iomem *regs_base = phy_drd->reg_phy;
+	u32 reg;
+	int ret;
+
+	ret = clk_prepare_enable(phy_drd->clk);
+	if (ret)
+		return ret;
+
+	/* Set PHY clock and control HS PHY */
+	reg = readl(regs_base + EXYNOS850_DRD_UTMI);
+	reg &= ~(UTMI_DP_PULLDOWN | UTMI_DM_PULLDOWN);
+	reg |= UTMI_FORCE_SUSPEND | UTMI_FORCE_SLEEP;
+	writel(reg, regs_base + EXYNOS850_DRD_UTMI);
+
+	/* Power down PHY analog blocks */
+	reg = readl(regs_base + EXYNOS850_DRD_HSP_TEST);
+	reg |= HSP_TEST_SIDDQ;
+	writel(reg, regs_base + EXYNOS850_DRD_HSP_TEST);
+
+	/* Link reset */
+	reg = readl(regs_base + EXYNOS850_DRD_CLKRST);
+	reg |= CLKRST_LINK_SW_RST;
+	writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
+	udelay(10); /* required before doing POR=low */
+	reg &= ~CLKRST_LINK_SW_RST;
+	writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
+
+	clk_disable_unprepare(phy_drd->clk);
+
+	return 0;
+}
+
+static const struct phy_ops exynos850_usbdrd_phy_ops = {
+	.init		= exynos850_usbdrd_phy_init,
+	.exit		= exynos850_usbdrd_phy_exit,
+	.power_on	= exynos5_usbdrd_phy_power_on,
+	.power_off	= exynos5_usbdrd_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
 static int exynos5_usbdrd_phy_clk_handle(struct exynos5_usbdrd_phy *phy_drd)
 {
 	unsigned long ref_rate;
@@ -782,6 +933,14 @@ static const struct exynos5_usbdrd_phy_config phy_cfg_exynos5[] = {
 	},
 };
 
+static const struct exynos5_usbdrd_phy_config phy_cfg_exynos850[] = {
+	{
+		.id		= EXYNOS5_DRDPHY_UTMI,
+		.phy_isol	= exynos5_usbdrd_phy_isol,
+		.phy_init	= exynos850_usbdrd_utmi_init,
+	},
+};
+
 static const struct exynos5_usbdrd_phy_drvdata exynos5420_usbdrd_phy = {
 	.phy_cfg		= phy_cfg_exynos5,
 	.phy_ops		= &exynos5_usbdrd_phy_ops,
@@ -812,6 +971,13 @@ static const struct exynos5_usbdrd_phy_drvdata exynos7_usbdrd_phy = {
 	.has_common_clk_gate	= false,
 };
 
+static const struct exynos5_usbdrd_phy_drvdata exynos850_usbdrd_phy = {
+	.phy_cfg		= phy_cfg_exynos850,
+	.phy_ops		= &exynos850_usbdrd_phy_ops,
+	.pmu_offset_usbdrd0_phy	= EXYNOS5_USBDRD_PHY_CONTROL,
+	.has_common_clk_gate	= true,
+};
+
 static const struct of_device_id exynos5_usbdrd_phy_of_match[] = {
 	{
 		.compatible = "samsung,exynos5250-usbdrd-phy",
@@ -825,6 +991,9 @@ static const struct of_device_id exynos5_usbdrd_phy_of_match[] = {
 	}, {
 		.compatible = "samsung,exynos7-usbdrd-phy",
 		.data = &exynos7_usbdrd_phy
+	}, {
+		.compatible = "samsung,exynos850-usbdrd-phy",
+		.data = &exynos850_usbdrd_phy
 	},
 	{ },
 };
-- 
2.39.2

