Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2984C7B0405
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjI0M1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjI0M1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:27:12 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5431AC;
        Wed, 27 Sep 2023 05:27:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ev5NVq03NFDhRoMb1B/Kgvn4RXlDPmA0DJ9YyoD0dgBRw6csUiorFFYsbaX/8KOoHQYKQ9TcxiUo2GlNqU3Myg7fFKsZK7kvx5e4Kr1fuRag9C1aNL9VuCKz7nwWpxbEiEok9TC9DC9IFWdq0cWyKGFjZuwt+bXr+OrS6oR9nGLbgsukOI01Xprh7HmknDbZo9XEh416hi/D3B3Y7frEeJxcYlQLG814XH8WHCpTrsOT3QR0MDxDhYVJ7S5tkp0ltOu0A8siiVHZRY98adAJkucVIMbUneKM3nZ1GbRdWtqMUHVvHdoL0oXLpfXJnbgM0JnI/uRBZcKbygrF8ZFnbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkxK78kc0GzJ1PAmyygOuLjTJ7Q7J4gC8xHgZpVpz5g=;
 b=imxQ0nH9ryKEmWO6/uZZQ/dA7bGdEacblU1APmQMrIycFe5vPVZtt96rkNeZrbjUInFAu18MsxjI+mo/SMjvp8a6cF2NH7YXt7KHHhI1ctfIwG0pBaCMoKIdScXLxsrW+pUIV3hNGbc8gh/Gl4j1xn7qQ6V90uXNQabA95n+4dha6fVeLNjOPye2Fjk3zO106nbhELfrzF6aE/zPRCrGaUeMhKU0k2a4HAxyCB/+UuwjcpK+ZWa0OoX/N3TRbZv4EKXCXxBH2/lgoqe6bGnpbPb4kBPzLBb3Hqg1MG58ylb6nDPNN5XEFX7QrLJ0am1CCF2z03QtVG4zfkd1oiWdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkxK78kc0GzJ1PAmyygOuLjTJ7Q7J4gC8xHgZpVpz5g=;
 b=VoepL0SI2hjYtjz5E0y4u9U7gFcYCmJ9+GvS8VHvNq981ok0FtSe3pqk97YG3f6qwOyzrYs8HSYOImrwcClMmZK4sZFqkPIE5QZJiXwg0LYCHmfN4qDWSNdazJ+yUSZEqKx0k+el4SJwrjTkM2v4e7tdI8/Ak6+s/m5UaT/giFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8181.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 12:27:00 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 12:27:00 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH v6 06/11] arm64: dts: imx93-11x11-evk: reserved mem-ranges
Date:   Wed, 27 Sep 2023 23:23:56 +0530
Message-Id: <20230927175401.1962733-7-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
References: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f9ea1b-2a15-4d66-ee6b-08dbbf550bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yis4HJnmv7UMirAYJzBNlkH7QUteBZX3rEeVXvsDF6/ytMv6+DjJMTUf1fJTHyWVZmlTekKw/RMgd6aK18nwnu96+fGREe4+/ZrDw6Y4LG5crdTA80zwP0iUa3p0fQ9Rzp5r2CBUiSV+rRZHkzkm6JkTlOZFef7aG/kHESsprYav7Dj1Eb16qkJN3uy4797vdqSrplcu8SNBMUlQYAnCL9QA5MBnNkoG49YBzG9rHScDlO8J3u8uzrB1k3okNdDeWM13wj4IFNIGnQl6kzMXumZvSETcjI8+K/YgptZzBNaaf6jtVUTtmMbIPruIZPBklWTGn8Xl+EeWVo9Ji3uryl4Xy0zY1JAA5H9AyBjpgp+NrTevwL0MmltasN5Z3vC/xuu+hiImmxZPSZgyDBffYYL3TjC0H4kOitIh2pxUDWsg4SxDHiTp9gX7s9nRbQuOSSdjnOdKWveDem76k6iNMp5WFJnxRFRDfkjv5tLFF3weuIps34DK9dqkVkoQ+VePd4GVEKNb0fJr2UWqFNgY8cjmMDoI57tZwof10Z6YfS1q1KheAI66lMoS0rxa383CCOvOrotZPfd2dewBx31y+KaCCr5A04d2/xZAL3FCAHpJZpgMbv1D/5t49fG75KxC2XYptXxHVgLbabAHCWkv0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(7416002)(5660300002)(316002)(54906003)(921005)(83380400001)(44832011)(41300700001)(6636002)(8676002)(8936002)(36756003)(2616005)(66946007)(4326008)(86362001)(1076003)(6666004)(6486002)(6512007)(52116002)(6506007)(66476007)(66556008)(26005)(2906002)(38350700002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zXD2BJU07DU+XmIp/i38v5JBNq/OzWFQuNnp5/xFppFpl8eziSACnRaVMqLP?=
 =?us-ascii?Q?wqcAuPJqxNNUNxkn3oRIe/yJ8wHsG5HxlAFRM8PQdrGf8fKyjpDinI+BZPX2?=
 =?us-ascii?Q?CWHgH997ttbJrMvVsBkL1c6VFVaO75oJFZzald/OcZk9I3If8MUrB+r9ssHu?=
 =?us-ascii?Q?k+55nfyy0wIdm7L8YQolA59lPWU46W/9D3fE4rEQGDyqCzea3NWSl015o/FJ?=
 =?us-ascii?Q?bZRmZ6a+L5/GUDoT2arrekmVJQSMiqB5eUwT/lxh7K9FL8CKZT+pCI4fLY2I?=
 =?us-ascii?Q?tcN1/2/pBNNgCegjMeci/B/UHTyDX+qcxd4mv3QTEei/iyVhDcdOb5G0LUcf?=
 =?us-ascii?Q?Lc+8eA17GVxQujO75Y1aBiHn1BGmFBdkHoT/7O9thYyJ4P988NjAXFwngdhu?=
 =?us-ascii?Q?23C9tf2ltm2xobpNOR4AsfyRh3qg7LwHCsR1AM0tRsjZX23JkzTMHYPMfFSN?=
 =?us-ascii?Q?IWX6ZJnRRamOAEOLvoxsJK74lwgit6a/uJ7Ua/+7x3iNKQSLTZJkm8z8mTgT?=
 =?us-ascii?Q?eMHeAIg+qjEVqAIrkyar3J/C1gkXqdyiQLsLNjj9z+pstgr7SvggIoNNQQwC?=
 =?us-ascii?Q?aEnr4gw6yD7uo/zLtcB5wxI/IduhGt3HtqM7M4vtTc4yLeqbWwRbzR41o8DJ?=
 =?us-ascii?Q?KugMaIh/MiMtmEc2SwLmIirEmwo77S/hu+2IdkzhMEqcb6xHalO3s2NzsBZq?=
 =?us-ascii?Q?iI3dC3rLf1OQAlLSBcvddFOTxslVGXxLjqjsx+5U0RyOs5u92DIUIw5Xoz3t?=
 =?us-ascii?Q?8KVBFpSVd5BKPBD1hTsOL0YTG9iIvk302xOjLPjjh+u0SW9oGEZBOxeWuOIf?=
 =?us-ascii?Q?0Ctlq5d6jGkOQLiWM4wx34j2ZQcRsvDgHrP7WvV5pFoaMg2tTQUeWjTRqbQv?=
 =?us-ascii?Q?VholfJQm0uXH7vYGFVkAJ4H8zvlDhQjnJa97NYjlWc8oIJmn1UMxKGHFSRsY?=
 =?us-ascii?Q?SZ1HWHZl5NB3xLq9O2jI7wWaioUM53rGj/tp1V0GeJIWnhxV5rHA1AfwMKE8?=
 =?us-ascii?Q?LnhL8w05nsbiVICC5rIcUmJcUxT/Hgbsv61P9MVfbVbRwiZfC8Kl9TID4fjf?=
 =?us-ascii?Q?oTdFkzJyPc568NS+3nVJtECm2UiuRdLYl41+JhQOxH19uJrBXHr0Omv/x8Si?=
 =?us-ascii?Q?S10QUxg062Dnl0BUbI2b4oCqM2pvVxLW5mGgcFAzF9hzN7cFOiHacHgW6Iha?=
 =?us-ascii?Q?n2BBTRFjN1fWjPGt7Wm+m8RnvphSvMlgzjmj3QMMyXyscyI5wsGhwOJ97KkW?=
 =?us-ascii?Q?adu1KTSzuANgKaBpf+cUE3HqNbqfKtU8s4aHK95MGZKh1abGffWponRDfUGN?=
 =?us-ascii?Q?5XEinn1bYk0JbgDKwYapzrwSYkG3Urrnn6Ac3yvaUlm2n8qPT8dzUkM5eIEk?=
 =?us-ascii?Q?1AubaBuDO1/uScwp8+FJA5+rU17FJxQmIeHcaGnHoAZnlPYpKq9s83fxUdM9?=
 =?us-ascii?Q?dta1vjX5mC+6+Tqt/PHeSisF9j1x2Qvs6HgdkvGS7D39zCdXzN573iGiS71j?=
 =?us-ascii?Q?mq3KgIY4ZLCqUaB5aPNiVdFDmi9ANmE3zkdXf9e1aBZRSiKqntfNUlhWnxE5?=
 =?us-ascii?Q?tk/+nDi+vfCj+89CBD+/QAOxu1sUW414+ZJHPyNu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f9ea1b-2a15-4d66-ee6b-08dbbf550bd7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 12:26:59.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keYilByZmuEbtODY/9+wWVIF3eGehk1CA4B+v4JIZTv1d9Q7I1V+oCMIxBWiwR2Ds55nbuSZ96OIBCAoLGFmUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8181
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EdgeLock Enclave are has a hardware limitation of restricted access
to the DDR memory range:
- 0x80000000  0x9FFFFFFF

ELE-MU driver requireis 1MB of memory. In this patch, reserving
1MB of ddr memory region from the lower 32-bit range.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index cafd39130eb8..bcb4ae931c64 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -7,6 +7,10 @@
 
 #include "imx93.dtsi"
 
+&ele_fw2 {
+	memory-region = <&ele_reserved>;
+};
+
 / {
 	model = "NXP i.MX93 11X11 EVK board";
 	compatible = "fsl,imx93-11x11-evk", "fsl,imx93";
@@ -68,6 +72,17 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		ele_reserved: ele-reserved@a4120000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4120000 0 0x100000>;
+			no-map;
+		};
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-- 
2.34.1

