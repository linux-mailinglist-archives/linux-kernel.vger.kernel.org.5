Return-Path: <linux-kernel+bounces-70716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0EC859B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C262818F0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7F41CF81;
	Mon, 19 Feb 2024 05:00:24 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2121.outbound.protection.partner.outlook.cn [139.219.17.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F8B28F7;
	Mon, 19 Feb 2024 05:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708318823; cv=fail; b=l9EeYj+EA6am23gXiKMg/S3zfzwFEI9XpkiQs75ho6PCdGrKjaLIwEqIKfMnLVEAmPXElhpJc1S/06g/1EIdJ+kFlpL2F7wMXQ7NoCjJRDPrh+RlTppiJaljsm0bqU3FGalzcpzKESrfaK7le/4Lax/4F1qZ+ERDFczhkkt4AMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708318823; c=relaxed/simple;
	bh=mjv6HIUOfGkwSuoDmhWh1tayN/1Y7pMomHm9lm4ISeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=U+DuyIrFM4HGJVQNziEcS7pPg4MkAzwieGA1u3eZEoO0Kt4BE7WtuT/sD0U53SjkOgFV1wrIXZZTiz1KBna6kI6gCy2rSlJ0Dt+yftz2Kxe+kMiTJdq6X3M6s4Sv//N9MjWr7u+Me6Rqdw2Na7hYcsMT2DgKR2wrC+640JYKeQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bdf9pyM5MvAVSfJ1R2WxZnTCvWzUtErkwo3KHN4S1FVYUZdAvmp2UtYl56HUQYxA2DfJ9DMY+Dt6nTC+mn6owWEU2Z7khU9sEH4TEcIEqgYJH7eKtySNzwxyEqZAuPm3FCwrtZXRzba2O24zMucQYSnQ2NuD92GH1fMizwO9OQwiHcjsyvh63CweZpOrVlVo5r8VbA1VlD4H154IhC9cZE3VzMjteQIhf6zP9N93LqDkolTwyEXfzCgwOwtnegaJ6fbWrkhG1PH5wktMn/FY/yEMQetu2BlT8JLlXsz9T/XIY0eG3DNymIdxgruImyof8B3Yqci0pGHaQxuZJs/3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWiVTDcDCc8gvbe3WMo+WgFGdZhkOntSuRCk5fEPzzw=;
 b=Z6QDsBq+HgUmwU5K7HKy5Fl393S79EjpIk/OOj9Ccuxv8DRp7shAf9HXzYVW1XdaDZXx93874syvB0FTRxkDhqFkIaTCaEyrGa2MPKRWtmCnPEJ+9q0dHN6PQnhw7nqhy8xszea8xgyZ5HgBCjs43lnRgDrxdZwOEsDgc2E87E+s6QO8MYvR6/sbObfm5UP8ifSrm+JJ7zJ3IsCQEQTSWwU3rjVXbcJpmOtNHCn7hB3g4eATbmj0yq5y1kbCeYNekp6lfQzkxvBJh1XSgT+zwP5egMD8a7L3YQfhYF1pkOAvHQkuzPAlhdn56DmYRObwmKZRidQWd9nbBf5XxP/xUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Mon, 19 Feb
 2024 03:27:48 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Mon, 19 Feb 2024 03:27:48 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [v3] riscv: dts: starfive: jh7110: Add camera subsystem nodes
Date: Sun, 18 Feb 2024 19:27:41 -0800
Message-Id: <20240219032741.18387-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::30) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0623:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0d8f27-f8b9-4da8-ffb5-08dc30fabf01
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VbRVG26ZP3emFPEUBIQ/xWGZeAWbwLPlHvKzmOi9BBDIahl9+7GAA1euOOO6flP0mGEFiMpqBv5Q3gMNTxGlbVeuYZV7KcvIvM7PSVMvfYhUW1O8YT2O7sFZyhtWEPeQQvq6PPDB2KwiU7wIcpSxh7b1C/4AglDlhGEHZDfwQKLhKZxIDSIb03nGkwiUOBzD1lY1GMxlPEZSKFDr/ssnebt/qMVITGlS7K26Q2zG+iU04GR4UDR9nOidJn9iOR+csLpgTGoV0Vrxo9Pyx6g2bJe4twXnkRSpQx9KnO+Rb43WvJxWV/RA0DDVM7E1H7Sx+12pBzYcUTU66OFg6KJqljbbEM22oXGOz7MobhV4z1jCt8Rx4+TvR1h0Ym7tvKvvMCLShReT74l+AndLE5RyHqTfsCj3xhaDwhouVl2yANudIKND3a+zJMHAkVXI911JGSVh+Bp8P5k0zBPZNCvgrR/WgHK5IUZSIStFk0MJgY9xgQ+oHs+BgPxqf0y5HtHAJeYcam5PQattibMF8Nu1+v2/P09LmSjwT//CEe8IOeR82t696M8Z3jbI3XHSUckQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39830400003)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(7416002)(5660300002)(2906002)(44832011)(41320700001)(38350700005)(2616005)(36756003)(40180700001)(1076003)(26005)(508600001)(52116002)(40160700002)(38100700002)(83380400001)(86362001)(8676002)(4326008)(66946007)(66556008)(8936002)(66476007)(41300700001)(110136005)(54906003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0yI4TFsH/6QwNcdQ8FKSyeiQjczEfjpZFxD9h6r2M/g8AOtFknkiIwvqWfz6?=
 =?us-ascii?Q?nERasLVF2d8UbJGt/gYAEymfR/Rb8LVDayfzyIrYMbWS3y22uLlq1PQqeE3A?=
 =?us-ascii?Q?7SfwC3LFI1IcF+Qxoicinq4iq7B7Jnai9t5TmnBchDpu0v/XFk8pMKKcVh9B?=
 =?us-ascii?Q?qsNYws9HkjaZgjzmpYpc2QsBUBQAgRgULoQ01F73MfX5l8LHdvWZz1SBRoZW?=
 =?us-ascii?Q?irX4+7msmz8UKKb7BNjuT/Dvh2iv8sK6txyHHhLbDCNkStMG/R+F3EvojiZ1?=
 =?us-ascii?Q?/nciO0Vm+j82GID+2/3UCOURpdMqU23DmlyhaQrNKvA5hz5v9Y1tP2kRUzoa?=
 =?us-ascii?Q?mP6rtqvX1ufYsyZUsT5Lp5FtaCgFDe0XNBCUJllbX14CkSbjUaXjqvDW8UB6?=
 =?us-ascii?Q?i4D5KF4VWC7DQNlgHzMG0/7MxbEjjoLq1JDTIwrtSFn0NDReam0cAu3fm5pa?=
 =?us-ascii?Q?Fxy24eTTSRyS+PrPmJzSmhHZ/dmBej0yJy3k+qJUI6SSyYAqAB0qZA53NdbG?=
 =?us-ascii?Q?o6TWHlMMQJ3iT2C7ng+2nwbW6qNP6bb8Gf3HmQKdh5Yb1PeL675B3ro14b23?=
 =?us-ascii?Q?WRzhJvGFHcYZ/ctySZpROKvN8ft+/vZ+jZlX3+2yp0Q/MVPQT/CqKIzgOWdM?=
 =?us-ascii?Q?3h7ISaFTUw4jOEcanBeUeitSde/bprPQAzrxBxFRN1FA4nDWxjdWr7J99OQu?=
 =?us-ascii?Q?wFEll378+y+EFFH/pTklKcc744b4ZYAFNQmcA36WsydW8INkpaF78DZmAx0Z?=
 =?us-ascii?Q?RPOtOr9h7OLOM3FEuZIiJLEWGSyecypgvk0ptL4dsYiFYbU9mn5trHxzJO8G?=
 =?us-ascii?Q?0AuuxIwPDhAGdcAtlag3K23AVBmHxjuuk0vV+W55nxswRcsVK13rgrq0y+dL?=
 =?us-ascii?Q?dd1hHbA/qlxBfgaeVAtU+OyWplBroCObcIGfkYf0qzbdrkE9TP95wKXGv0Xj?=
 =?us-ascii?Q?SbPphFoAa3HFbchwP6IvjqFr/o85aau72TRFuRRP3RwuVyliZbwOEnFNAzuf?=
 =?us-ascii?Q?mh2pxqk/f/mFSoeCeTXc3RU7FGjI/NAbz2EPbgDcXAVEc28IsHt8IhEjSEyL?=
 =?us-ascii?Q?V5rLulXwRkOOx01k9y6ey7n1ncelaRVzDa9rs3BqadI4IS3ZjUJt/DCQJDix?=
 =?us-ascii?Q?TherEGZJ6Mi1SO0TPmOMjfoJ/gGTsZOd9d1StgMbKWcHsV+yC+KyxSUxs7V8?=
 =?us-ascii?Q?DnGwFLCfJz0uKS0iZoX5NZ3Ki+PzFc7wvw2qDjDNZSSn1KQSxrStapcm/XKp?=
 =?us-ascii?Q?fWI+a7zyQrIcoCtc5IPnEIGvpYR1S0QNL4OcttbkgEJvBm4UW2fI04Zu7t0r?=
 =?us-ascii?Q?kjuzgq2JJPpH+RQJA3T/vXxXyOgQ8gByQ/xZtDUb3NNvYoMttKZ9uyu8yP2E?=
 =?us-ascii?Q?fIT5/lOy6efP/DgSUcmOqJsGuxMOXkvD4vNGDxJrgrZO3XsOAZyTW/W87bAn?=
 =?us-ascii?Q?L3yEMCpAwzxToVmIgxDjjWCjZGmG7ctO0MdwXQpIvVkigw76/GFqIu1QzxYP?=
 =?us-ascii?Q?qaYfmjjvgRMvmqsaJLRm7IMwX1s30NCZtJb/nA/ZgctOCtW1ai1yVxFY2pCJ?=
 =?us-ascii?Q?w29P0/ksV55GTjw/iIRtgrLd1ofg94brQzC6XPcgLtAdqdVWI7ED12Ua9YUm?=
 =?us-ascii?Q?t4s98xcsF/q8I3zDGEglE6U=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0d8f27-f8b9-4da8-ffb5-08dc30fabf01
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 03:27:48.5347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zrwS6fvvO0Ze5OLm3FcZmoql3xzvmKDlp+Irm526TiHW3LBwx0AcMIrNqqDUzdBPGIWyXnuoj+cwLD8THov4ZOBnL0Dd57wtkl7zXq745rrMNl42IzFaWF9t46+4O3J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0623

Add camera subsystem nodes for the StarFive JH7110 SoC. They contain the
dphy-rx, csi2rx, camss nodes.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 49 ++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 67 +++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index b89e9791efa7..737ee97a3577 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -125,6 +125,55 @@ &tdm_ext {
 	clock-frequency = <49152000>;
 };

+&camss {
+	assigned-clocks = <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
+			  <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>;
+	assigned-clock-rates = <49500000>, <198000000>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+		};
+
+		port@1 {
+			reg = <1>;
+
+			camss_from_csi2rx: endpoint {
+				remote-endpoint = <&csi2rx_to_camss>;
+			};
+		};
+	};
+};
+
+&csi2rx {
+	assigned-clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>;
+	assigned-clock-rates = <297000000>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			/* remote MIPI sensor endpoint */
+		};
+
+		port@1 {
+			reg = <1>;
+
+			csi2rx_to_camss: endpoint {
+				remote-endpoint = <&camss_from_csi2rx>;
+			};
+		};
+	};
+};
+
 &gmac0 {
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 45213cdf50dc..6ea1c3f5dded 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -1104,6 +1104,32 @@ pwrc: power-controller@17030000 {
 			#power-domain-cells = <1>;
 		};

+		csi2rx: csi@19800000 {
+			compatible = "starfive,jh7110-csi2rx", "cdns,csi2rx";
+			reg = <0x0 0x19800000 0x0 0x10000>;
+			clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>,
+				 <&ispcrg JH7110_ISPCLK_VIN_APB>,
+				 <&ispcrg JH7110_ISPCLK_VIN_PIXEL_IF0>,
+				 <&ispcrg JH7110_ISPCLK_VIN_PIXEL_IF1>,
+				 <&ispcrg JH7110_ISPCLK_VIN_PIXEL_IF2>,
+				 <&ispcrg JH7110_ISPCLK_VIN_PIXEL_IF3>;
+			clock-names = "sys_clk", "p_clk",
+				      "pixel_if0_clk", "pixel_if1_clk",
+				      "pixel_if2_clk", "pixel_if3_clk";
+			resets = <&ispcrg JH7110_ISPRST_VIN_SYS>,
+				 <&ispcrg JH7110_ISPRST_VIN_APB>,
+				 <&ispcrg JH7110_ISPRST_VIN_PIXEL_IF0>,
+				 <&ispcrg JH7110_ISPRST_VIN_PIXEL_IF1>,
+				 <&ispcrg JH7110_ISPRST_VIN_PIXEL_IF2>,
+				 <&ispcrg JH7110_ISPRST_VIN_PIXEL_IF3>;
+			reset-names = "sys", "reg_bank",
+				      "pixel_if0", "pixel_if1",
+				      "pixel_if2", "pixel_if3";
+			phys = <&csi_phy>;
+			phy-names = "dphy";
+			status = "disabled";
+		};
+
 		ispcrg: clock-controller@19810000 {
 			compatible = "starfive,jh7110-ispcrg";
 			reg = <0x0 0x19810000 0x0 0x10000>;
@@ -1121,6 +1147,47 @@ ispcrg: clock-controller@19810000 {
 			power-domains = <&pwrc JH7110_PD_ISP>;
 		};

+		csi_phy: phy@19820000 {
+			compatible = "starfive,jh7110-dphy-rx";
+			reg = <0x0 0x19820000 0x0 0x10000>;
+			clocks = <&ispcrg JH7110_ISPCLK_M31DPHY_CFG_IN>,
+				 <&ispcrg JH7110_ISPCLK_M31DPHY_REF_IN>,
+				 <&ispcrg JH7110_ISPCLK_M31DPHY_TX_ESC_LAN0>;
+			clock-names = "cfg", "ref", "tx";
+			resets = <&ispcrg JH7110_ISPRST_M31DPHY_HW>,
+				 <&ispcrg JH7110_ISPRST_M31DPHY_B09_AON>;
+			power-domains = <&aon_syscon JH7110_AON_PD_DPHY_RX>;
+			#phy-cells = <0>;
+		};
+
+		camss: isp@19840000 {
+			compatible = "starfive,jh7110-camss";
+			reg = <0x0 0x19840000 0x0 0x10000>,
+			      <0x0 0x19870000 0x0 0x30000>;
+			reg-names = "syscon", "isp";
+			clocks = <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
+				 <&ispcrg JH7110_ISPCLK_ISPV2_TOP_WRAPPER_C>,
+				 <&ispcrg JH7110_ISPCLK_DVP_INV>,
+				 <&ispcrg JH7110_ISPCLK_VIN_P_AXI_WR>,
+				 <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>,
+				 <&syscrg JH7110_SYSCLK_ISP_TOP_CORE>,
+				 <&syscrg JH7110_SYSCLK_ISP_TOP_AXI>;
+			clock-names = "apb_func", "wrapper_clk_c", "dvp_inv",
+				      "axiwr", "mipi_rx0_pxl", "ispcore_2x",
+				      "isp_axi";
+			resets = <&ispcrg JH7110_ISPRST_ISPV2_TOP_WRAPPER_P>,
+				 <&ispcrg JH7110_ISPRST_ISPV2_TOP_WRAPPER_C>,
+				 <&ispcrg JH7110_ISPRST_VIN_P_AXI_RD>,
+				 <&ispcrg JH7110_ISPRST_VIN_P_AXI_WR>,
+				 <&syscrg JH7110_SYSRST_ISP_TOP>,
+				 <&syscrg JH7110_SYSRST_ISP_TOP_AXI>;
+			reset-names = "wrapper_p", "wrapper_c", "axird",
+				      "axiwr", "isp_top_n", "isp_top_axi";
+			power-domains = <&pwrc JH7110_PD_ISP>;
+			interrupts = <92>, <87>, <90>, <88>;
+			status = "disabled";
+		};
+
 		voutcrg: clock-controller@295c0000 {
 			compatible = "starfive,jh7110-voutcrg";
 			reg = <0x0 0x295c0000 0x0 0x10000>;
--
2.25.1

