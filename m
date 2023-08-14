Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE0877B86A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjHNMMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjHNMMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:12:21 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290DF10D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:12:16 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230814121214epoutp04ab93ed295ce0c0dde305db2157c22740~7PszhLxCP1394913949epoutp04Y
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:12:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230814121214epoutp04ab93ed295ce0c0dde305db2157c22740~7PszhLxCP1394913949epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692015134;
        bh=Swnsn1chzI8f0TpyxK2ztAInnEpSxBH/YZuquN/a17I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jh1ZnCRyoTh5VZdeyEIqFiBspY2wr7CzN023CKV9KR/fpOcLsbSVkVuqCu07IYksM
         fNQvqCsux7Qz36DhwVwS4wvXSwt3D+gtxap6EtNEvUH8IS0A3q0AteFRwxm0oZ4XaM
         bevx6bL/zsefKyE3xJNglYOb0Vjy4bHjQicNCLiA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230814121213epcas5p464fb2bf583429fc26f8f04d37e7fb829~7Psy1q7x_2459824598epcas5p4e;
        Mon, 14 Aug 2023 12:12:13 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RPYDX1snzz4x9Ps; Mon, 14 Aug
        2023 12:12:12 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.B5.55173.C1A1AD46; Mon, 14 Aug 2023 21:12:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230814112625epcas5p1e1d488a590bfc10d4e2a06dcff166037~7PEy-jfo11309013090epcas5p13;
        Mon, 14 Aug 2023 11:26:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230814112625epsmtrp189c8fe2b801fd0b150669709709596a2~7PEy_hBe71862118621epsmtrp1M;
        Mon, 14 Aug 2023 11:26:25 +0000 (GMT)
X-AuditID: b6c32a50-df1ff7000001d785-66-64da1a1c457d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.54.30535.16F0AD46; Mon, 14 Aug 2023 20:26:25 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230814112621epsmtip22379e2036ae72fd7ed5810d780f5ac9f~7PEvOvSrB0830008300epsmtip2N;
        Mon, 14 Aug 2023 11:26:21 +0000 (GMT)
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
Subject: [PATCH v3 4/4] arm64: dts: fsd: Add Ethernet support for PERIC
 Block of FSD SoC
Date:   Mon, 14 Aug 2023 16:55:39 +0530
Message-Id: <20230814112539.70453-5-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230814112539.70453-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmpq6M1K0UgzPv2C1+vpzGaPFg3jY2
        izV7zzFZzDnfwmIx/8g5Vounxx6xWxw5tYTJ4t6id6wWfS8eMltc2NbHarHp8TVWi4evwi0u
        75rDZjHj/D4mi3l/17JaHFsgZvHt9BtGi0Vbv7BbPPywB6j9zAtmi9a9R9gtbr9Zx2rxZeNN
        dgdxjy0rbzJ5PO3fyu6xc9Zddo8Fm0o9Nq3qZPO4c20Pm8fmJfUe7/ddZfPo27KK0WPL/s+M
        Hv+a5rJ7fN4kF8ATlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
        4hOg65aZA/S1kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8v
        tcTK0MDAyBSoMCE74+2NDewFE9QqOjbcZGpg3CffxcjJISFgIjHvTidLFyMXh5DAHkaJFb2r
        GEESQgKfGCUWbvGASHxjlHiy/xYjTMeUwxeZIRJ7GSWWLbzFDNHRyiSxsIEfxGYT0JVovfaZ
        CaRIRKCNWWLNpylgHcwCnxkl1nxYDjZKWCBKYm/zZDCbRUBV4s//yWCTeAVsJbqW32KFWCcv
        sXrDAbA4p4CdxIfre1gg4m84JK7fc4GwXSQm/3gDFReWeHV8CzuELSXxsr8Nyk6X2HxkM9TM
        HImOpmZmCNte4sCVOUC9HEDHaUqs36UPEZaVmHpqHROIzSzAJ9H7+wkTRJxXYsc8GFtNYvGj
        TihbRmLto09Q4z0kLuzaAQ2UiYwSl47ETmCUm4WwYQEj4ypGqdSC4tz01GTTAkPdvNRyeKwl
        5+duYgSnbK2AHYyrN/zVO8TIxMF4iFGCg1lJhLeH91aKEG9KYmVValF+fFFpTmrxIUZTYPhN
        ZJYSTc4HZo28knhDE0sDEzMzMxNLYzNDJXHe161zU4QE0hNLUrNTUwtSi2D6mDg4pRqYGjxK
        L+ZezNXWft3fExAa6DdPW+iqwq1dDdXnO3/u2n711KKm2FcZf2cIflSNL74v0rx4rcWS+Vkb
        3qptlFqy9N/E9HL5yYctM+Qv3pg8Yb5jqOgJrfSLTA5yvvOXalh6itxVDPm4kOvTsbdd2968
        mJdmmWW2Zk6CpMo0ic/XpPX4vr+UjNkaG/Qy0qdg5wIzrafKmQffrXpfK36aeXVI20X7tuen
        2rw/n5246ID7Lv6HhRtEvM4+9BLT82wNkuO9Ke306+JN/kwh/eC93SX3YqYWLZK4qtlyTNmj
        15kp4J28npPr7FptgbczD1v72vx8WdN0Vdr8u/fUGVWCu1in1O/x+7RsfjLDRNs1OtUHlViK
        MxINtZiLihMBW/nmGmIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXjeR/1aKwZwHXBY/X05jtHgwbxub
        xZq955gs5pxvYbGYf+Qcq8XTY4/YLY6cWsJkcW/RO1aLvhcPmS0ubOtjtdj0+BqrxcNX4RaX
        d81hs5hxfh+Txby/a1ktji0Qs/h2+g2jxaKtX9gtHn7YA9R+5gWzReveI+wWt9+sY7X4svEm
        u4O4x5aVN5k8nvZvZffYOesuu8eCTaUem1Z1snncubaHzWPzknqP9/uusnn0bVnF6LFl/2dG
        j39Nc9k9Pm+SC+CJ4rJJSc3JLEst0rdL4Mp4e2MDe8EEtYqODTeZGhj3yXcxcnJICJhITDl8
        kbmLkYtDSGA3o8SJ9qcsEAkZiZMPljBD2MISK/89ZwexhQSamSTuN6eA2GwCuhKt1z4zgTSL
        CMxilpg3eQVYA7PAT0aJDYclQWxhgQiJpadOgw1lEVCV+PN/MlgNr4CtRNfyW6wQC+QlVm84
        ABbnFLCT+HB9DwvEMluJXV+Xsk5g5FvAyLCKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93
        EyM4qrS0djDuWfVB7xAjEwfjIUYJDmYlEd4e3lspQrwpiZVVqUX58UWlOanFhxilOViUxHm/
        ve5NERJITyxJzU5NLUgtgskycXBKNTCdWamudytNsd9tY7rE9R/vpE6ctBCabKLTsTvVlHXW
        5Nj6klADd8XQ23vKJ8TtezRvck1ztOSmwK68BXm58yauyzWM5l26av2N6qPX8rxzJszh+yW1
        /PxEvnNPj4t2ngv+scQyuOnV06Dow2qaMksi9OzDAhJ/T40vSOy89k/Qr3f577+hv3WM7eOz
        8p4zsZ/oX8ju9+jVTf+Nj2Otaxj6n7wQ7rTJbesUO3B3lbztUVGn0ufZKlsCO5/2OFnfvbph
        jpyWRA+H287y7gtnTupuPGSzTq1z1yqn6w+DTnr4Ou/gsF2WK3TI5d+2NRVPN/1QY+hd4TUn
        aavItwdNmrvKZQ/fWPz1duexK/MmRqUrsRRnJBpqMRcVJwIAul+XghkDAAA=
X-CMS-MailID: 20230814112625epcas5p1e1d488a590bfc10d4e2a06dcff166037
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814112625epcas5p1e1d488a590bfc10d4e2a06dcff166037
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
        <CGME20230814112625epcas5p1e1d488a590bfc10d4e2a06dcff166037@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP, one in
FSYS0 block and other in PERIC block.

Adds device tree node for Ethernet in PERIC Block and enables the same for
FSD platform.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
Signed-off-by: Swathi K S <swathi.ks@samsung.com>
Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts      |  9 ++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 56 ++++++++++++++++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 29 +++++++++++
 3 files changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 2c37097c709a..80ca120b3d7f 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -73,6 +73,15 @@
 	};
 };
 
+&ethernet_1 {
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
index cb437483ff6e..6f4658f57453 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -437,6 +437,62 @@
 		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
+
+	eth1_tx_clk: eth1-tx-clk-pins {
+		samsung,pins = "gpf2-0";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth1_tx_data: eth1-tx-data-pins {
+		samsung,pins = "gpf2-1", "gpf2-2", "gpf2-3", "gpf2-4";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth1_tx_ctrl: eth1-tx-ctrl-pins {
+		samsung,pins = "gpf2-5";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth1_phy_intr: eth1-phy-intr-pins {
+		samsung,pins = "gpf2-6";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	eth1_rx_clk: eth1-rx-clk-pins {
+		samsung,pins = "gpf3-0";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth1_rx_data: eth1-rx-data-pins {
+		samsung,pins = "gpf3-1", "gpf3-2", "gpf3-3", "gpf3-4";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth1_rx_ctrl: eth1-rx-ctrl-pins {
+		samsung,pins = "gpf3-5";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth1_mdio: eth1-mdio-pins {
+		samsung,pins = "gpf3-6", "gpf3-7";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
 };
 
 &pinctrl_pmu {
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index 9a991f021711..ce5d5f8546b9 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -33,6 +33,7 @@
 		spi1 = &spi_1;
 		spi2 = &spi_2;
 		eth0 = &ethernet_0;
+		eth1 = &ethernet_1;
 	};
 
 	cpus {
@@ -1006,6 +1007,34 @@
 			phy-mode = "rgmii";
 			status = "disabled";
 		};
+
+		ethernet_1: ethernet@14300000 {
+			compatible = "tesla,dwc-qos-ethernet-4.21";
+			reg = <0x0 0x14300000 0x0 0x10000>;
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I>,
+				 <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_ACLK_I>,
+				 <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_HCLK_I>,
+				 <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_RGMII_CLK_I>,
+				 <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_RX_I>,
+				 <&clock_peric PERIC_BUS_D_PERIC_IPCLKPORT_EQOSCLK>,
+				 <&clock_peric PERIC_BUS_P_PERIC_IPCLKPORT_EQOSCLK>,
+				 <&clock_peric PERIC_EQOS_PHYRXCLK_MUX>,
+				 <&clock_peric PERIC_EQOS_PHYRXCLK>,
+				 <&clock_peric PERIC_DOUT_RGMII_CLK>;
+			clock-names = "ptp_ref", "master_bus", "slave_bus", "tx", "rx",
+				      "master2_bus", "slave2_bus", "eqos_rxclk_mux",
+				      "eqos_phyrxclk", "dout_peric_rgmii_clk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&eth1_tx_clk>, <&eth1_tx_data>, <&eth1_tx_ctrl>,
+				    <&eth1_phy_intr>, <&eth1_rx_clk>, <&eth1_rx_data>,
+				    <&eth1_rx_ctrl>, <&eth1_mdio>;
+			local-mac-address = [00 00 00 00 00 00];
+			fsd-rx-clock-skew = <&sysreg_peric 0x10>;
+			iommus = <&smmu_peric 0x0 0x1>;
+			phy-mode = "rgmii";
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.17.1

