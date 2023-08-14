Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D0E77B869
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjHNMM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjHNMMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:12:15 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1299B10D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:12:10 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230814121208epoutp04ef3e172ef10d6b8e70c741d8e4747c8d~7Pst1RFYZ1473114731epoutp04B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:12:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230814121208epoutp04ef3e172ef10d6b8e70c741d8e4747c8d~7Pst1RFYZ1473114731epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692015128;
        bh=Yt8aeFtvj8RBIiFEZAHOORINuFCPLtv7/UQIZ9mjqfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W6MQFNyitQLzIQbDr/OkPUqIpg18ruXsiCZPLhOUgTRfdPhio4aHseXbmgCAMnwDU
         LqIHyj9yrw31/sRHAhNA6rLb2sP+seJEL3Aa23L1PmGmld0R8CBVp5HJJKws7XnqOA
         uXjsqm1PUIBBqrrp6iaika2gnCg46FNeq7yzYXCs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230814121208epcas5p171e8078cf4fac54dbe1c2717ee332725~7Pstbv7Gi1932619326epcas5p1Z;
        Mon, 14 Aug 2023 12:12:08 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RPYDQ438fz4x9Pw; Mon, 14 Aug
        2023 12:12:06 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.45.06099.61A1AD46; Mon, 14 Aug 2023 21:12:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230814112617epcas5p1bc094e9cf29da5dd7d1706e3f509ac28~7PEr22lzI0846108461epcas5p1B;
        Mon, 14 Aug 2023 11:26:17 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230814112617epsmtrp16c05658d5ca9d52ca053f549714f649d~7PEr0SJHL1862118621epsmtrp1G;
        Mon, 14 Aug 2023 11:26:17 +0000 (GMT)
X-AuditID: b6c32a4b-d308d700000017d3-e3-64da1a16b865
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.C5.64355.95F0AD46; Mon, 14 Aug 2023 20:26:17 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230814112614epsmtip261ca8640136d92023569d408c59fd627~7PEo5uJMl0830008300epsmtip2M;
        Mon, 14 Aug 2023 11:26:14 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        richardcochran@gmail.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        alim.akhtar@samsung.com, linux-fsd@tesla.com,
        pankaj.dubey@samsung.com, swathi.ks@samsung.com,
        ravi.patel@samsung.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sriranjani P <sriranjani.p@samsung.com>,
        Jayati Sahu <jayati.sahu@samsung.com>
Subject: [PATCH v3 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Date:   Mon, 14 Aug 2023 16:55:38 +0530
Message-Id: <20230814112539.70453-4-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230814112539.70453-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRmVeSWpSXmKPExsWy7bCmlq6Y1K0Ug5MvZS1+vpzGaPFg3jY2
        izV7zzFZzDnfwmIx/8g5Vounxx6xWxw5tYTJ4t6id6wWfS8eMltc2NbHarHp8TVWi4evwi0u
        75rDZjHj/D4mi3l/17JaHFsgZvHt9BtGi0Vbv7BbPPywB6j9zAtmi9a9R9gtbr9Zx2rxZeNN
        dgdxjy0rbzJ5PO3fyu6xc9Zddo8Fm0o9Nq3qZPO4c20Pm8fmJfUe7/ddZfPo27KK0WPL/s+M
        Hv+a5rJ7fN4kF8ATlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
        4hOg65aZA/S1kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8v
        tcTK0MDAyBSoMCE7Y+vnPUwFh5Urvux7wNLAuFm2i5GTQ0LAROLdqltsXYxcHEICuxkl5m6/
        zgLhfGKU6DgygRHOebt8OitMy5a5J6CqdjJKTD58lAkkISTQyiQxc38OiM0moCvReu0zE0iR
        iEAbs8SaT1OYQRxmgc+MEms+LGcEqRIWiJJY8uc8G4jNIqAqsWrzI7A4r4CtxMM9r6DWyUus
        3nCAGcTmFLCT+HB9D9hqCYEXHBJHbnYxQxS5SOx+vJYNwhaWeHV8CzuELSXxsr8Nyk6X2Hxk
        M9TQHImOpmaoXnuJA1fmAA3lALpOU2L9Ln2IsKzE1FPrwD5jFuCT6P39hAkiziuxYx6MrSax
        +FEnlC0jsfbRJ6jxHhJ3X1+DBtFERonzt+4yT2CUm4WwYgEj4ypGydSC4tz01GLTAuO81HJ4
        vCXn525iBKdtLe8djI8efNA7xMjEwXiIUYKDWUmEt4f3VooQb0piZVVqUX58UWlOavEhRlNg
        AE5klhJNzgdmjrySeEMTSwMTMzMzE0tjM0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGpii
        ntgsEF02x0nuu9nLw54/5TaaXP7fyOKr9kux62LYrMfa6xJYE5b3crIe1CrRfnqHTXrRip6I
        TRcrxT9NlL5y6qP24gdKt1Vv7t/YmrM53vBppqP3N3FBniyhpSs3Gv9b/NfvhnBMsNP0ozXS
        C+pS8iLvqc2uWuCR/XlRl8z9m8n2NqxTAniVViyflBT+sr2odnu05+k/11q3L7QVPXc3dRtr
        soWfxne1muTFV/g//5lrfkH98ny27IrQp6llC5MvlPG+KwjbnvftxEKdWQfU5j75MvWC2e5o
        76o/S7Q5W81jE/IDO+fUCsi9C7Ra3eodtGDCM4nq3FtfFmzNuBkrqnC/3tCz/tIUFr3/gROV
        WIozEg21mIuKEwFWCPDfZAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXjeS/1aKwcV9ihY/X05jtHgwbxub
        xZq955gs5pxvYbGYf+Qcq8XTY4/YLY6cWsJkcW/RO1aLvhcPmS0ubOtjtdj0+BqrxcNX4RaX
        d81hs5hxfh+Txby/a1ktji0Qs/h2+g2jxaKtX9gtHn7YA9R+5gWzReveI+wWt9+sY7X4svEm
        u4O4x5aVN5k8nvZvZffYOesuu8eCTaUem1Z1snncubaHzWPzknqP9/uusnn0bVnF6LFl/2dG
        j39Nc9k9Pm+SC+CJ4rJJSc3JLEst0rdL4MrY+nkPU8Fh5Yov+x6wNDBulu1i5OSQEDCR2DL3
        BEsXIxeHkMB2Romd/yczQyRkJE4+WAJlC0us/PecHaKomUmi7/s3dpAEm4CuROu1z0wgCRGB
        WcwS8yavAOtgFvjJKLHhsCSILSwQIbF3djcTiM0ioCqxavMjRhCbV8BW4uGeV6wQG+QlVm84
        ANbLKWAn8eH6HhYQWwioZtfXpawTGPkWMDKsYhRNLSjOTc9NLjDUK07MLS7NS9dLzs/dxAiO
        J62gHYzL1v/VO8TIxMF4iFGCg1lJhLeH91aKEG9KYmVValF+fFFpTmrxIUZpDhYlcV7lnM4U
        IYH0xJLU7NTUgtQimCwTB6dUA1Puia0MO1TbWF2n26i03VnaKRNUu0TvmKL5zMVxfp8VBR+s
        D9+UVBR8PCL35pfUj/WnX2/vdWef2Z7g8KhK6HAQb/mRaxuctzcYXbPyilpu4vaDy+2Mk3/2
        8zW6X+7PryrcpZyxR+zAZRVehtRlIiKP20Xlz8yewHpBZOqiA2ebdu2cbZE+m33Jq3qnwPvn
        Spz0FzZf5f20Pf1/vPOXyJKpK+7N+135a+Fb38IPO41MtA37ToQ0F2/ZluF3oWOt96MVkp83
        73G4PlVNdP/OJxvVpv9yPaCkb6V3yC/4c9j0C803zk/peDwzb3NMzMUQzQ9h5U93+DzI6DrB
        +zW8sdppIW/qvfb9d9ZenjuxI4FFiaU4I9FQi7moOBEA2UhC1hYDAAA=
X-CMS-MailID: 20230814112617epcas5p1bc094e9cf29da5dd7d1706e3f509ac28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814112617epcas5p1bc094e9cf29da5dd7d1706e3f509ac28
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
        <CGME20230814112617epcas5p1bc094e9cf29da5dd7d1706e3f509ac28@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP, one
in FSYS0 block and other in PERIC block.

Adds device tree node for Ethernet in FSYS0 Block and enables the same for
FSD platform.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
Signed-off-by: Swathi K S <swathi.ks@samsung.com>
Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts      |  9 ++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 56 ++++++++++++++++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 22 +++++++++
 3 files changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 8d7794642900..2c37097c709a 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -64,6 +64,15 @@
 	};
 };
 
+&ethernet_0 {
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
 &fin_pll {
 	clock-frequency = <24000000>;
 };
diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
index 3f898cf4874c..cb437483ff6e 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -64,6 +64,62 @@
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
+
+	eth0_tx_clk: eth0-tx-clk-pins {
+		samsung,pins = "gpf0-0";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth0_tx_data: eth0-tx-data-pins {
+		samsung,pins = "gpf0-1", "gpf0-2", "gpf0-3", "gpf0-4";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth0_tx_ctrl: eth0-tx-ctrl-pins {
+		samsung,pins = "gpf0-5";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth0_phy_intr: eth0-phy-intr-pins {
+		samsung,pins = "gpf0-6";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	eth0_rx_clk: eth0-rx-clk-pins {
+		samsung,pins = "gpf1-0";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth0_rx_data: eth0-rx-data-pins {
+		samsung,pins = "gpf1-1", "gpf1-2", "gpf1-3", "gpf1-4";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth0_rx_ctrl: eth0-rx-ctrl-pins {
+		samsung,pins = "gpf1-5";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth0_mdio: eth0-mdio-pins {
+		samsung,pins = "gpf1-6", "gpf1-7";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
 };
 
 &pinctrl_peric {
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index 1c53c68efd53..9a991f021711 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -32,6 +32,7 @@
 		spi0 = &spi_0;
 		spi1 = &spi_1;
 		spi2 = &spi_2;
+		eth0 = &ethernet_0;
 	};
 
 	cpus {
@@ -984,6 +985,27 @@
 			clocks = <&clock_fsys0 UFS0_MPHY_REFCLK_IXTAL26>;
 			clock-names = "ref_clk";
 		};
+
+		ethernet_0: ethernet@15300000 {
+			compatible = "tesla,dwc-qos-ethernet-4.21";
+			reg = <0x0 0x15300000 0x0 0x10000>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock_fsys0 FSYS0_EQOS_TOP0_IPCLKPORT_CLK_PTP_REF_I>,
+				 <&clock_fsys0 FSYS0_EQOS_TOP0_IPCLKPORT_ACLK_I>,
+				 <&clock_fsys0 FSYS0_EQOS_TOP0_IPCLKPORT_HCLK_I>,
+				 <&clock_fsys0 FSYS0_EQOS_TOP0_IPCLKPORT_RGMII_CLK_I>,
+				 <&clock_fsys0 FSYS0_EQOS_TOP0_IPCLKPORT_CLK_RX_I>;
+			clock-names = "ptp_ref", "master_bus", "slave_bus", "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&eth0_tx_clk>, <&eth0_tx_data>, <&eth0_tx_ctrl>,
+				    <&eth0_phy_intr>, <&eth0_rx_clk>, <&eth0_rx_data>,
+				    <&eth0_rx_ctrl>, <&eth0_mdio>;
+			local-mac-address = [00 00 00 00 00 00];
+			fsd-rx-clock-skew = <&sysreg_fsys0 0x0>;
+			iommus = <&smmu_fsys0 0x0 0x1>;
+			phy-mode = "rgmii";
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.17.1

