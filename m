Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1C2785F18
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbjHWSBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbjHWSBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:01:32 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2079.outbound.protection.outlook.com [40.107.247.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE15610CA;
        Wed, 23 Aug 2023 11:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaGlrvGKNyCo/p2qi+AcNwDpO+DILo1w46a72yTp0vhsGudPRPlcBhSzFSp6cCfK/8nWA8jiYXAh6Gmnks/FjuZ059iVD1z+7yFPl5QfL9WAzqPCdWNgFk/aC/jLrrUNH2rDFk3ytOdDGj+eB0l3JgSQpFktzEtL5LQL1uLOATbZPDuUfAhdRr7lg4OUvooOvm0YcvLH05FXRZACkf9LFCHclt36bfQ8sKDlyOG6RAWZ52ITFOuOklKdiICuaJNJFbsYoNzCdH1boLR0lfq9/HwiLQX107HjNUqMAqa2w9BNnV+l24g+0eJpgySQxl/WVmHWFSn8mvvBdp5dy9diQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNHt9j0QipvXYt2hdFba2fOhwk6FrCj+3C04Yh/fvhw=;
 b=afJviXPm/PahQ0jNYv8o2ZyWt6wm2vF212PVBiuz8c+vN0uxS/pZoWBsd+r3AjSbWX7++goxr3jb5uKrj3W83r2WKb8s0D6UaRrkrmIVr2Qfr7qDhjFhCx6iX+NnMFq5oiORLYeinoWYEKJGvpsg+/iVF+f4CBlqh7XpY7moUyhsC+fk0B2emQG3pO+dJBHL31pA7L1gqCzmlBKKfemiAm1EZ+gYZqDJ0KCUDj5NGPOVUnCDVmnetUAuHQIlJtp4Mq5Yk3ScK8mfRIogf8TYtUTkB+Wvfy0ZqYJckN9gKwtB3Svg05fVzxGYAYX5UvBfH0KmOF04NS/cTJW+u+Jldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNHt9j0QipvXYt2hdFba2fOhwk6FrCj+3C04Yh/fvhw=;
 b=UmOCSFTYTbPKiqxq8F7tx3BIC3jtk32ePqE9dC/o0ZCkL50aVWPadN2Q89CzJQx52L2/DrY6cExa1HuM+yFaHYNWlo7zcIhNT9nOjLDq3gwuFaeJAuQMEit8zxmXRXkfUdkJY1bn9artj5k8eHPCHvpxy9HvKhea/XSsIKOld0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 18:01:28 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 18:01:28 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        shenwei.wang@nxp.com, sherry.sun@nxp.com
Subject: [PATCH 3/3] arm64: dts: imx93-evk: add uart5
Date:   Wed, 23 Aug 2023 14:00:55 -0400
Message-Id: <20230823180055.2605191-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823180055.2605191-1-Frank.Li@nxp.com>
References: <20230823180055.2605191-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e7dd7e-b6d2-4b3f-143e-08dba402f93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJGH7HQxsZgCHBJ4VyikMd2Vkkju3pEjiUPk943O6KsyFVY5AmVpLvD0CwODRr95BjKx9+wrHfhUtG+HmijLvOUNF3qXlxgMrToIH3pWT+KCX1wAWXdKKkrV9JUSiRZ8HxYMlk+LQ+R3LTtYVRpM+yd9n+/9b6+vE8Z7No9cbIJxdofANMR4FSP3AjYzFT33VTyra1DmiaUWFbGYpl77b/R0t37Zgzpg8OYi73/sW0lbPadIhoMuBndIo1kvs2x7pFJ/HwtkqrqmicL9qeuNKf0+L79bI1/xww+0zHiBzxiDl37kJAhyuVZcGNu12owvwl73iws2R5PgG0NSGkg4yhojSKjCPc31RMiRTMhHz/PVwEIQpOlKaNeZXOxJLkyA7dzx4Ku7yZMBygClbwHAub8c2PIi7VQFgczFtbyKcY9NOggvKc3RWnBMSCy64F+LFDZb6lSq6ua0pXrzvjzOmDIg7xzE+1qVVWx27VF3DOGIiYTnsSdKWbyG56ZqENm104rkIdQv2Lf9xObsnHqJDCdJ4HCxHw5Vp+0hazjOGDuPonOdw3/eBgOvXKZx5q3u2BpMxmfdN8cBOaoW/ncvIEA7dvkwvxoY7CN4D8/R8cQ5xkhzWaKM5quSM/+dzQ1KGCC5nQrFiJ8+m0vQkPSlKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(1800799009)(186009)(2906002)(7416002)(6506007)(6486002)(52116002)(38350700002)(38100700002)(5660300002)(26005)(86362001)(34206002)(8676002)(2616005)(8936002)(4326008)(37006003)(66946007)(316002)(6512007)(66476007)(66556008)(478600001)(6666004)(36756003)(1076003)(41300700001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c3GoqDQhkGtAK6G37fDORLw/tLTNEy6uAxDuR1+4/a+5oP4SndvwlRDvyXuS?=
 =?us-ascii?Q?Ok8IpMt+D9hMbXvbBPaf3mMLLcQEaBNCZ6Jm/o3ngeh2LRZbHzhxHirSfw2D?=
 =?us-ascii?Q?QT7CyoUs1/5m0Mq0UvMkGo+SzREXfLl4Ut2nAQyU0T/qa9fcFmjv94Yov7Cj?=
 =?us-ascii?Q?0v1umkhlNYsEqh/70gkiw0QBvOOfho/hQhVszm1dEHg/CJb8ppxPVPtkYSVz?=
 =?us-ascii?Q?HrIMsGdNpk4FIFXfBzWKPGmMfUadoBXfBAGM5YwjKO3uS66V2zZNuoGMewQF?=
 =?us-ascii?Q?CE409zEPzL2X2kXbnvuSLRewI8QypoihUNveuLF3u0B70gI/4NUaC3Fzssk9?=
 =?us-ascii?Q?rPx/KiNEfUyUhdl0WJ0Bcni4IkuHCrO30wXLkJKRmMcVRF5Fj7Hw4fLdv0tE?=
 =?us-ascii?Q?bbfW43rblUKdJpQNLdjvUZtTFkP4z7Ij1j5pRJ0tyQSXx7VmoodbKAjvnVY6?=
 =?us-ascii?Q?CSZage7EShbdrkOCx48nMZpxqqHnYgUkb7+rj6CPk6fj1fJ3wHUcWwPL5oVu?=
 =?us-ascii?Q?JY7jLag9Vq9CdWRnxA6+kEtGXxMEE07eJQTkKjL0KqaQ2BehNLKjp+MyjG/t?=
 =?us-ascii?Q?RETFXdEmFJ/M72nW/4AIPqOB3qsN3f7TYQ56r7aBoWUcTTAxCWUhCzpPfZC8?=
 =?us-ascii?Q?IorSUtqlWlKTCiJIyfCnHKX2EOLRCMo9r+JtgZwoBc5qtSVBjeZotM1cmZPM?=
 =?us-ascii?Q?iTEl5pJze9EfX2oZjmVp2L8tZmkn/ncZzj0w7lONYctY+0swsxCDnkGEATHl?=
 =?us-ascii?Q?NE3KjX1x65VNTPVCyHj1jVfhbCjmixEZjMtPbTMFdv94FcSdfRL0ZS6KBouX?=
 =?us-ascii?Q?U4XKS23ew/tgbEsLCM9V7H7ADRX2Hgc3GH1FMjkmfr4QzgMRum4BK/bQzoLa?=
 =?us-ascii?Q?x7b9AiqI95AtwOA0Q23BtY2tbFKr3mtgp/hMEAcAhrXgtwBvUnT8nnajUyV2?=
 =?us-ascii?Q?CrqEV2ktrwwNSZi6k0yU2qvqioJ2O41HPFBJtfSka66zKoT9o1mtdjD19+QM?=
 =?us-ascii?Q?1BJ6CnIwp25ID0sJYC/nx7Aw5ZrQ+DCURbHlREbZQ/P5D5fAFRxPLwbq0R4X?=
 =?us-ascii?Q?w3eUuo/FY0qUN0psZsAwL+cCKGEbtGXlhJwFQHkaIWzIekGdTLq47xnQYruH?=
 =?us-ascii?Q?Pwx+vQd+pdbXHk+sIrwI/fQWux27ewT3LQGTGNnSAsSsiIWUafIJf57fGtNx?=
 =?us-ascii?Q?TvZrm0IRlLAmnRsNGwX2djoOtGYa/PSlKuUcEMI0YdX+PM4uqV3ZXQKffqdE?=
 =?us-ascii?Q?ATLP2hsBMg1nAGSn5hHqmieAaiVHfb1xJLNsZ2iTN5fNEN9iUZecajFlpnp7?=
 =?us-ascii?Q?V9fseNE02mAH/CVThUis/6nTZWJFmFg+Kr5v09kS9YAU+xKeUGEzIdXkMSaU?=
 =?us-ascii?Q?WYrKbgDTgvIrhw8Cu4aV9fXyzLX5Y2R+kQYab+vXZhyh1uw6McWKqVi8nZFx?=
 =?us-ascii?Q?PV8Tt9dQeaNZPtFp89I+SrlyIAr/AoPmAJXKhi421JQeegZFK7vZsKutciJu?=
 =?us-ascii?Q?QpvKS3skujomqy+npNFGn+IIgcNvsKx8Ce/+j5GXkmiheeFjXoefHwEqRzw1?=
 =?us-ascii?Q?Ig9DDm5PJrnkPLFyzvM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e7dd7e-b6d2-4b3f-143e-08dba402f93a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 18:01:28.4353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1LTf5bDNFei1OtSW52VoV4EMimxVFrUnIHafa9nLz6h3feTp816PA+cOOInpNCyeXP/0yBfpgY3FmRrOu/KoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7502
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable uart5 for imx93-evk board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index cafd39130eb8..2b9d47716f75 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -149,6 +149,12 @@ &lpuart1 { /* console */
 	status = "okay";
 };
 
+&lpuart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -222,6 +228,15 @@ MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
 		>;
 	};
 
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX		0x31e
+			MX93_PAD_DAP_TDI__LPUART5_RX			0x31e
+			MX93_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B		0x31e
+			MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B		0x31e
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
-- 
2.34.1

