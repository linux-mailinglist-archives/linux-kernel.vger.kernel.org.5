Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F07B7C88A8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjJMP2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjJMP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:28:07 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52555CA;
        Fri, 13 Oct 2023 08:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIcwiw+MPca+BVxMbsdKI/+zSFbWu35E0No22pCkNIyw5Rje2wfPgD2X7LPA3wIi5u8wEooyZSnTHCVScehpFdA/C/dpbLQtCKe5spjaHiYtKpTlZsfAEmGKZxKqIFDB0ztmx4rHrvYZx6akg24eZ6e1y6i2OOOs2E2olN+7dVBqT/quCfLaFY/eB2cJLY4aUgIBjxh8UYMMKaO8vjNcm9vdQdxGqK2OnyMpYSW5tyI7XXtPTH+Y405oZcuvZwurnPPTFOCys00663mMubhdtSCavTYJmZvX1z3G35rdT9cbVK+HaPHXc9fYkBWMwiB1tRLvlWH/LwzMjQcM4ozCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JlwTBvjHWnfDZtdXRJZPG9Z7tWbMG4+Vp9g+IEW0Tk=;
 b=kS7ReELnsDEaZXfcGePklr8XLZUSfXrEQxMGALoKFET0XMWjmfj/edd9OufnxhIQTdvQ++yBB0PHtqckhprhTvTdnsz/PcmX1mCkEShVAXdse8t4ESmYCGn4aZIt5R5fKdgicVpxt/hhz1zPOW612Tns97DG/bqqxFFFdBvVaR1bjBfYnGnxsEnEcoIfE2Xcrctf/L0wTbVUbB1urJ9nL4hbZduXcxHaCFsL3+geOlK3HXJHdm+BxtFbhSpA1TNGB8IR+sePGb0h7+RX9+XurEJxivvGJ7ndl+KaAGqv5PsGdZTmbUey0SSKJWutxZdh8Lo+ZAoVhDhsRQJGXtTt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JlwTBvjHWnfDZtdXRJZPG9Z7tWbMG4+Vp9g+IEW0Tk=;
 b=jojQ1SjqpllxCV7OiwJvRYtl1I7gZqC93MYPqkVnkeuro5wJgCvdcCD7yBnJk8ZUdionQSWGQJMLxcNi4LQI0Hqqre+9ItqyjeBLBryvEBIzWSodWws8NbMDiQfHQ3jyjZrkCss8KOWlLkZrbASfcWkSaUHImx6KiKCt9kjfQaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by PA4PR04MB7711.eurprd04.prod.outlook.com (2603:10a6:102:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 15:28:01 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 15:28:01 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        alexander.stein@ew.tq-group.com,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: [PATCH v4 2/2] arm64: dts: imx8mp: add reserve-memory nodes for DSP
Date:   Fri, 13 Oct 2023 18:27:31 +0300
Message-Id: <20231013152731.23471-3-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231013152731.23471-1-iuliana.prodan@oss.nxp.com>
References: <20231013152731.23471-1-iuliana.prodan@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0169.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::6) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|PA4PR04MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 434364a1-53a9-44ab-fc35-08dbcc00fca9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgfyZSNWS4UVA3wwelZK54hNkeRl/0pghW59CunPZ1dwM8zo2NeqnGKKcndwPIQg+TPxkAc0ltLGvaPC/YHpbwrYyD107PA/UsiAuTsdDsFhHOZO03fEKmp3QPBJbAB5F4fIpIs3RTyQNJJkPdkU0REKCuxUMGNKP58G1ksjBKTmEvnLC8LwIaGV4KiK3/oicqKOLrFHDXd+67drCFY74k96B0GgPBbzQ6F7qgxrL3kPNk9b4CRzEMJdfuKfIVwzd87v4EgsefEq+zm36LgOexyVgmsZkmv4aPPU1FLI9yYNo/v9RWPM4Je7wcAjGWYq450mr1MYSpSKNpGXMFJkR3/4T4/5EUZhd0tFmnFrFHt+gqM2Bj9HKj96vumK4mqCkm6hLw8Er0aP+1DSp1FBd+ugbnyRPE/kWmkb0dFlCVkxusvqp2UMosil74M1pcwsHsMUepVDDaxNnH2bdj0APw6uVJUlLVSTs+6rGWNzPoe/+V2xO38n8BukQcfDdoGKRicWx28Lni/6Y0PfOf2HO2i+fJaoOqQxe26RPHwhLRCnF8ijsazV39sIf2ncTmYweCm5f/0GoeytN7pIGy7E0pECFt2UsKxMEFq6xjTBgra+pVDydjfYa7feU0c5nO7jTHMLmjO42LAaXtei7FUuUQ/gxTZJExms472791U8Wp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(26005)(2616005)(1076003)(86362001)(6486002)(478600001)(41300700001)(8676002)(5660300002)(4326008)(8936002)(316002)(4744005)(7416002)(2906002)(54906003)(110136005)(66556008)(66946007)(66476007)(6512007)(6666004)(6506007)(52116002)(38100700002)(38350700002)(921005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wIn2mGZ+HGz3BF2jG2U2fmHDuIrKtGedwiZ6KajvTp4Xz+q4k7SlhCqL75Oy?=
 =?us-ascii?Q?qPbPs1xUh5jaUlBBiNFX5N8c8qK1cAeJonShftX6FKHbO2k/U0wZSaEAYssm?=
 =?us-ascii?Q?H1u15s3KttnB7bYILAC2s6Gbe7GMCHzySShFs5Ttb1j7EXUnr2NWbRpCOpfs?=
 =?us-ascii?Q?PSF/isqNn8vb/1Nd9Ysb7QN0zKOBpxDLVMjckcXBe9i88DI3/JgWmnS1EuWu?=
 =?us-ascii?Q?UsUKUUHK3MQbtSbCHotzVnhcH4Zn5HSWMwLzMBGtpku/WVC644viABitOKc1?=
 =?us-ascii?Q?v30Q8lzaGejn6UcgWhwYiER5kzDZ+45HHOQz+Q9l6P5ENlmM2WIFY3k+73wP?=
 =?us-ascii?Q?JLoTFSGRaNLTTIpxRsrGiS+vJwhQK2bJEL89Q+rclzSxOhveiCx6TDTJcU6M?=
 =?us-ascii?Q?khzw6A+3BJzvjBzbBZWh1ZptNntqxYkFRJrCNElmp7yAKVzSXyaUfzD6OkQn?=
 =?us-ascii?Q?SYf7xO4EnAGYmdGfK76PJqNlHzvVTvuXZwo96KnExpBkZWDolnssn2AFsypK?=
 =?us-ascii?Q?zJIt1sxnkzvMYSgO5g+K5u6yOnyR15uSYR0qMRYWmwwf3RZNcVZJx5t7+4am?=
 =?us-ascii?Q?Glom5Aed6EXDWK4N2Ps75ccBF6C6nSyF8ynxzqCmKmwY83kKPPv/l9S3hNQ5?=
 =?us-ascii?Q?qUJkY8PRr1LYsff+68V2BggYCF3fDmjrKXiS13ftgSjuLpjZ0mie8NQQ7P7X?=
 =?us-ascii?Q?3V+U3Z/Z3QZJvgfaPzfiTPBnOD1ip1tehfbi171czp2vNdv8JBYUP5kBQQgD?=
 =?us-ascii?Q?/I3GFISZbBIc9zaqz6+rzW/U+2dG4GevoSjfSFHsu4HZeNZTI0Fa7w4KL+Hr?=
 =?us-ascii?Q?8dQUtSp7TG35TiaVmonDEzfz1G1i1a122veqQamf5iK7UZPv3h4nVlKKIJwi?=
 =?us-ascii?Q?zxWYw1IwJ0YeQiIf+FXojjh+pkArdl0CPqnLripcWmCNlSdyw48AseQTC9Cr?=
 =?us-ascii?Q?6iXTrtpAF6YRfY4/hZwV2WklhBTZ+48qUIKNO1JCnFZLcaSVfE2y7Q/bloDx?=
 =?us-ascii?Q?REegK3HpCuGuvoZddoOwLFAnbe77WvYtlnK9IaAbTsIAFFXg5Qwcb1uCV0br?=
 =?us-ascii?Q?efs55WCE5qKLjgD7v84K/tw40ytV9cKS4ARP2WpLw+zBoPV3jhRsrLML5IO3?=
 =?us-ascii?Q?KVx7UrV0oDPF2s6FfFXs2NOMf8vvJzXwfpFGeNKc/vp4iM1G7457QKu/vEsx?=
 =?us-ascii?Q?qcCN1SXASH0W753b8HIh6Wraf4HXFwb7aTQzI6d6FMfFgIQ5j5VosEa16OMt?=
 =?us-ascii?Q?3o9tniwqXkXT0q4VN2LD1fLSO1XLyhy3OCa+8ekX65VrsHxEElOrq1/WtpD6?=
 =?us-ascii?Q?7nuJLNcvw8T+tXqL8gBdfl8meuOChTopWD0IDoFOjHSTGk42VgjmC1bOjXde?=
 =?us-ascii?Q?UbRnkLfqqlI6rZDITc4uSBhKDtqqZb4rE7DOZPf8bQ8YnvhP1PMOQ3ilD5FY?=
 =?us-ascii?Q?x+HE6ygd1SiJKJQ9A/m/BbEQw4uYGIaMf2phOBNCVUoSw+KdUJpmOdu1ClQf?=
 =?us-ascii?Q?/t4p07f0BkoLcaEXAh14VlW9OUjMjammuXdGAQNo69dvKXLgYSzFwtJFDPSJ?=
 =?us-ascii?Q?76AQQB+c9P4+ogQ3YJ4unLwjxWoWIL6aPOCQW+7h8jRFEVEwo92to8flOtiP?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434364a1-53a9-44ab-fc35-08dbcc00fca9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:28:01.5691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ztJkPO8XzPrTH0AoeRjxpNZyAgQbTqZnk2/w7gaMidUsExf2bkTZPQv08egM3I2WIq0fHMWtDrWGxR82V0Fgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7711
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

Add the reserve-memory nodes used by DSP when the rpmsg
feature is enabled.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index fa37ce89f8d3..b677ad8ef042 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -125,6 +125,28 @@
 		};
 
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		dsp_vdev0vring0: vdev0vring0@942f0000 {
+			reg = <0 0x942f0000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0vring1: vdev0vring1@942f8000 {
+			reg = <0 0x942f8000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0buffer: vdev0buffer@94300000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x94300000 0 0x100000>;
+			no-map;
+		};
+	};
 };
 
 &flexspi {
-- 
2.17.1

