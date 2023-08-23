Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B187851A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjHWHfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjHWHfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:35:48 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFFA1709;
        Wed, 23 Aug 2023 00:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVkzffQSwRhNOVaAH3dYtzxM0P+bwPXweQCVG3Z4TLbjOB14jysICg1WOxw8wiOWNh/HqVOkz+8FBdkMHtkDRS6asXLr9Mz4a+PYgvmxfHPXNgdg0FDkSC70xkgBz+i+gKxQNC0p9BaLOpIf71JSCardiWTju47RZcWaalxWRxbBoQ1yrYiv7OWFg/HZ6ycXQLqGVXDOX5JXRhqZZD2ZtNAiCubB75HbhergnaGE4yM6CQGwBwilPnliAUAvLXaI6mNNdgHiwuXuzjphHYwHhJrWXA1cbwpfPVERWO7Zs83OXSOf2+d1oRriN6f2OBPMTvPZraibIm+v2GRP5I2whQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fpT4dZ7BH+3SKPrhIxn70iRmdJBBzZf+J0bhSTNYV8=;
 b=U6Z3Ba0dubzACC6OqOcoALYBXJ6WZuTXhEmFW21gh7B3XFjM9ritetxGukByrsOn5r4L1bpXW7gFrihBFBzGt1LxTOrBrcFXDk3T97B4jOV1ClQXVv00T5TI9Ltb1wu6o+ZjHlVU6mJTElHlDH33sBaio43yXMyRlt+CrCq5I65hPk3z4FagNU205VAtwCzVebJk3MUadbUuecAMl2u6xbW/Q4EAUkZcjCf3p/4LxNYAq3BjjgoH9GiallLUNUIFKJ14zaMB1vUZ011AxHoX/NW+4Qh8mQFhsXgJCkTnAuIkgGBTorvZAGt2HciHIbpQ5AOuuJRskN/hWplnezcUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fpT4dZ7BH+3SKPrhIxn70iRmdJBBzZf+J0bhSTNYV8=;
 b=nB6bp51epLBhCpXFbN1XI5a7T1JkQwoa9n14e9y5ChUeqg+Qq6NdUrcOanN4QWUm+hc0/a5L4Y5rBpcNh1LfomFlaZfIhHL9fVaCAiRkXilKmU3W3Y10OZZx6f7xTCOd/53wb/DZynr/BaHh4VsdWugBQcppK6NOcCpiTyVj4Os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 23 Aug
 2023 07:35:12 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:35:12 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v5 04/11] arm64: dts: imx93-11x11-evk: added nxp secure enclave fw
Date:   Wed, 23 Aug 2023 13:03:23 +0530
Message-Id: <20230823073330.1712721-5-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS1PR04MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 622f681b-ddc8-415e-b80a-08dba3ab7be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p42FMgU0cEQK78zchs46J6w66Z4c+GmOCIBnOEmW2KvEFlihFdVLQMeE4w35dTHfSgn70t8IpexP3o9etiTjW/pLdaLhHM5GbJbn2tNS3rmXAFG8We7bk5g7zjrvWdLxl/IjU+nh8tl5dmGCuAm58RwCzWDkLNscwwvnI3MRY8chXm1MHPPGTg7C2terdN0+wQ4rXv8Ky1CU8c5d6jBxtPM5ocgYwRaJlHfrBaJV3bJ2ZQH4MLjTUWGftoaW1QVcPm4yFqy/jSHAnBg4MSzGIAfQNM1o8vSKAjLF6wxyCzSKP3ljuu0If8vE8GIu8r+3yPWbf1Mf29D8inERxe4FViPlf5oIAa/3WoJpj4oidX3Infd8ZWAqHP16PQ2gnFHBSzDmydshytlavpz/CsEEVHtHTeqqM1vYM6psLAra1KQ33Xn+zIkhAdm8OnFVgEAz/dT9MgoyjPuCazHrONnt4OufL4HvY5ParlRSqBK+8OtdFxda3louDYHqKf0z1H9OtXTunmswWxb/tFIkew/ieyXwGdmfJhN2dY2dhxO+uADmepSuUw8+6k8hxS41OVQQE/ubZL0IRPjODPdZFeghDf5QbeQKPmWm+9FBj1+ao7Hd/XfCy1mHGS/K6d6aCggUb4SJPUPEqDgY0ok65SAelg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(186009)(451199024)(36756003)(86362001)(921005)(66476007)(66946007)(66556008)(316002)(41300700001)(6636002)(478600001)(38100700002)(38350700002)(6486002)(6512007)(6666004)(6506007)(52116002)(26005)(1076003)(8676002)(2616005)(2906002)(4744005)(5660300002)(7416002)(44832011)(4326008)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hIm+ln4cSnBZlV1/WaZmPjctv1WhOvfjmRj+4BEAFZ1Hx2/LRZb2MawYUX+B?=
 =?us-ascii?Q?8eoVrkGlupQQcXYqtFcmwHzGo3YkeewHzwv8xbc+ccAQ3nEn7fNY6SAozn+p?=
 =?us-ascii?Q?08Kir3XY/9q+LauSu/h/NnqQl7tezet+kRzb2F9WMvbb3X471COsEpKSn7CM?=
 =?us-ascii?Q?qrGWpfgMbxwAzjAfy1w2DOIToqP+Ts51xjHaxABYW2z7wGb/ZlYaQxU9m1lO?=
 =?us-ascii?Q?Q+Epxqm57uoB4V2xEHvaTJUGsHKfz+6QLZ8ddv+NgYiiPE5s4MB5ywNZhS6a?=
 =?us-ascii?Q?swIRIDwbpL7Oi4kddqrSlwBwtzIQhtdRwzHhrsaLBeGPLPwsjLl4z7vtR2Q1?=
 =?us-ascii?Q?hvbzczfRR1G4lFd1pKCc0Bztrkwl8hHkEJzDoDC1BpmEXgXIaCFPqqLpiqR2?=
 =?us-ascii?Q?+P1HOqBwfIKAoebXsih3c9T+glj1WP91lmSipbb3oEbuoF06IZfvieoHIj9c?=
 =?us-ascii?Q?OEPhmDkSn2t3pJJMAIrncnUHU+1CyLfMDLorDnoPzodxTunToMOcW8W4TwCv?=
 =?us-ascii?Q?oPNu0Cxzc/lx7BwF+ryv+Yxcx+IVq/Y6MlQBoTlW/3AP+Xe3syArl4qYGF7y?=
 =?us-ascii?Q?0sNbTk/NzgRqBTuYv8eBmELCopmv8rxt6tcdEgIlOETiCSI9JGN4luzj+RsY?=
 =?us-ascii?Q?Yii2R5MXEl9s0MiQIUfTVGRDClpEKG92Qe8c9/R5vr111xoBnpQ7+7f6Jr09?=
 =?us-ascii?Q?bhobXz1Vu2e79rkktWiKoA+pnKW7R4InIb+VEm68o2Ox3snvH0EI+uWRI4Kq?=
 =?us-ascii?Q?e55pYP0D9cGknECa01jQ8MfaDuM4gic8/UaaBvN+uN6m+tZoJs5K3s7Tu+fV?=
 =?us-ascii?Q?tcIWM/RavcbmM/mtYbjnrjcSsKyvQA0enel5iddbWS6WtVv901D2Jd/6IkvL?=
 =?us-ascii?Q?CduG0nHORIAZ5UYle9c4JV4Bb9WQnYfWwGOQ/j5lqcD6020YauoClJrr9pew?=
 =?us-ascii?Q?fQDaPsNTokD+rTrAkP3lH7O6ri81tG+Wn8rV8NFy0TfCc9js2KrTG8W4/B6p?=
 =?us-ascii?Q?cbnPaUNwOd9eXDe3adbh9ewEnGFN9/zq+IgUeCm6lRDePfSxwdoOwEhdhhUk?=
 =?us-ascii?Q?NoI1tkueOEEb6GvrxX4tHx/Tx957PRQdQMMTqcix5WMAidw9V37Z5QkYCF0F?=
 =?us-ascii?Q?MDCrMEkirMsnx/Fsp8mvOdC25oy0BWHTAJU0kmz0uhLZX/j+FmpGz+zTA0Js?=
 =?us-ascii?Q?Xm+pY2X+sQsbKgf7Mo4glyEk7wFe1G0cC1C9xhHcZ96arLCN5mtv2oyAsqOJ?=
 =?us-ascii?Q?8WiHCc2Jf2oxC0LtuqZy8gei/z2+3E1kRoF1plr963sobExdj+3bLErFF2/T?=
 =?us-ascii?Q?AdlEDoXWsTEq7HdbaNRUNPOhnN39P5lPtMowPe8VdcQ+46jHetgGdvFsx9+b?=
 =?us-ascii?Q?k6GZXP5KSZdW8IEsRIZYqmhv6QCi0YkZUJ17RsYNjrAMjEVHVCNIkcVKbEEK?=
 =?us-ascii?Q?lJ9pzeJJEkqBDMSC/4tICUgXSqCprdNvOMEJeoykLKYafNe4shEdC69HEk8x?=
 =?us-ascii?Q?NISSYk+ZbEpY0QJaBg9p2nDl5x6hz/DXMDpfjva7lUh9kC4MpYd/SOm15tdZ?=
 =?us-ascii?Q?oQe7Rrh/GkovZ6nfsk8Ya5urzVFxApZL2WGt+KTU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622f681b-ddc8-415e-b80a-08dba3ab7be4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:35:11.9955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbcXNenrm1dkNEKxVf8y0iHdESR1w/Ie13JIZ90RB0uh/s9giw60axfH0DmPjzt7cuj4JfFRXq0OehfgXw1yxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9504
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx93-11x11-evk.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8643612ace8c..d482b66c5fa4 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2022 NXP
+ * Copyright 2022-2023 NXP
  */
 
 #include <dt-bindings/clock/imx93-clock.h>
@@ -864,4 +864,12 @@ ddr-pmu@4e300dc0 {
 			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
+
+	ele_fw2: se-fw2 {
+		compatible = "fsl,imx93-se-fw";
+		mbox-names = "tx", "rx";
+		mboxes = <&s4muap 0 0>,
+			<&s4muap 1 0>;
+		fsl,mu-id = <2>;
+	};
 };
-- 
2.34.1

