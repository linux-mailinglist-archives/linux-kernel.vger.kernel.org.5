Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241F77851A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjHWHfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjHWHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:35:20 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4831810CA;
        Wed, 23 Aug 2023 00:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTYwFxayguoi+cnYXMNbqN9XetuqbsKEf/z0kTFzqgQKuHXMvgX0OCWfgN8OFiSi9THJhbSmixPYYhnXtMHD1fO0rrImzIXwIWGYAqzOWaM9PRUoqN1WqGFapnWEtyBZjXJzEYXSQ7zpcZ7h9s+a4qFR+YfPLfx6BoAsboJxxq+5V3IQaPyA2QENhmfoLgEYsOgd+ibxZT8o2V+1GTzR0G8unv0BUFfhZQ54jg/CK6HFQJ1rHDAwcZVEi/pZ5JmX6mZ7NMYMMh0+EQbiR5irAhuOhFL7qEwXe+OLknI3XgoVWY8qp6o67GirR/F4zwE9udmKiNuC7NxJpNkNgqNAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPTPJFDdHgCk4TtJjkzcb3vw9Tgs0fv+rUL90pXXdsA=;
 b=iRLHKaUXUnsn6jYbH82A7FqUesT3QcZTIzM5joZ7SgEWqoOjA0WM1weN7FQNSSd1dqiCOsVUCjX5/Nej823QoqBNhwKPtYdvLMlUxgklYFTnR5qrdqT/AVmv24STxzJMsNrP8zpw0Nm1UhDKJWa6msKdF/tnn2sPjIbB3EggzlxVfGCsx4jei94EcUiml6UIUNutFfjatvKlG0LfzawVfG6A9SxVecJNheyJfyEjn8gs5kSlMwSY4Iu2H8OBMUfXzk4yVXVK85xnG3Hx7/nQXbmaooB0i3/EzXr4p4tkkQbwzz4jA9274x1q8ODzndJrihx4XwFNPXVqvX1Vh+l8YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPTPJFDdHgCk4TtJjkzcb3vw9Tgs0fv+rUL90pXXdsA=;
 b=oNKfk7XO7ZT+kqoSrRImXdPdSLkMEY5PBqNj1gK6I2sXvh2ODP2DjoudsviFbU3F5VX9qI4pIniMIZhHlgR0+/esYCt2f4FM3cvx3h0w78s6fNXqQ37Ev1IDCSTVgKos+iMVdfcJlogB9g1BrLgOPtYTFTEaZpbnwVVHz5ROvWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 23 Aug
 2023 07:35:05 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:35:05 +0000
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
Subject: [PATCH v5 03/11] arm64: dts: imx8ulp-evk: reserved mem-ranges to constrain ele_fw dma-range
Date:   Wed, 23 Aug 2023 13:03:22 +0530
Message-Id: <20230823073330.1712721-4-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7582b7b8-36e6-4a63-2fae-08dba3ab77bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZcg7x3e0nsf7BnDGzt7YfU4PtF4uPi1HHKJIMMT4QcuGua19BnVI8R2LMBlZpf5ABcMWsz09FQBX45Hbg6CGnoXjovo2YkCyp34Tpn/7fDvpmMTrSat014Cnhq4ZykCXjBLf30ijRr/jDUGcrZ0waT8r+GEs5m95qY4v5fydxxUF0erK6yp0cR0EpNfFqF3LyEVLRsITIlsRboStqI6RzJ+BKkP4S5FVFGIx6D+GDoAM/rKS92NY1kh6AdVErsSmFLPshmxhZKki220OK4y52OurQza7ITsYvyhfUbAuWJNoCVZ1GMLLtxgP2gFft7BYntv76MXCEZo/bUBUgpsNzLmRLHx6SSbqLl1UL/5XrHYDOKw1J5mi2P2HWuIrWQubiKdf0K6+7XtSIZfn9k4ksXJKpY+Vc2nabggT+5SVRVorPclAB7ScjiPdNXZbT19hRekWNqt6xhu5vS0zxMgga3PwURvjGQZchFzIreJ5gbGxeVSTWDt8VShVdhMwzenzqucLEksXuZZpdC8/61dQcKrEmXFiH5kYwqDHbIUZiFyZzzG52QEITSvPkTjxFNVhNoS+5u24RTszvCVbbgPwf1XVsYNYiaYcGO1nCnKORkKEC0dIfUn92DSI7p4Lc2Ht4LfIGcyAypToNVGV1uVAgdLX5G6asxNjkqeSIKb+q0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(186009)(451199024)(36756003)(86362001)(921005)(66476007)(66946007)(66556008)(316002)(41300700001)(6636002)(478600001)(38100700002)(38350700002)(6486002)(6512007)(6666004)(6506007)(52116002)(26005)(1076003)(8676002)(2616005)(2906002)(5660300002)(7416002)(44832011)(4326008)(8936002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FEs72vIB6MWN0fsmfzT1VigjytbucL12nT4uvBEAxqxftKzQXYIUZSI+kbii?=
 =?us-ascii?Q?VuOtruo53BOs1Q0lh9eIh3p80o/A81bCg8j/K+U4A4qF4soYsWbRrgR8RB2B?=
 =?us-ascii?Q?kY87R/0xVHzXLhkWPdr5zpN6pVj5nZImyjHwA4/M5QLyV4O4YBrhyUbWt8X9?=
 =?us-ascii?Q?iNMLsg9DRWCwXLkNcX1I6z4LMOarbYw8emCik6JixRV4kOXTh231h86gbW3X?=
 =?us-ascii?Q?shyctiR4v3xAHQQwVLSGYlPJ6h/Irvo/djV7FLIvxwKXZJq/H4rv3Af8eiZN?=
 =?us-ascii?Q?2e2FcYpAN/Vof/eurCR5xy+zPvVb/J7olVpNmI7B40gCSFZ4aZKYjPpKb+SV?=
 =?us-ascii?Q?fkXkT2yjI0ay5HQxap6ve/9QwTvMW4Ktw84Cm9WAGZd3j8xFav9IoY61W/EX?=
 =?us-ascii?Q?btf/Ywnyzm7vZ7QJH4MhHdmfSYmE8bWbzdDnR85Zf5nIbWpaIS9dLDk1nx3C?=
 =?us-ascii?Q?UzZ0ZIRSHcPwJsSl3O7Lv78A2at5/4mDtsKWYiTPTjvK/Bk4HJ6jTFQAqCav?=
 =?us-ascii?Q?4afnJT9sYvkEftrv+yVFw39qusHC887XWbadujQy7RFxMm84JDv6LQBWys+3?=
 =?us-ascii?Q?JAe/weQ3Z6RDIZNJZrhNzKVxyhkx12kWdKQztSCKZQScAkUitTeCF5iJanoU?=
 =?us-ascii?Q?EGlg3vxsqG/yRTa3cPOkpxbd4yC2UZr9O2zf+x2roQGr0VtCUseVGSAJsRu1?=
 =?us-ascii?Q?vqMwr1iXcUrwZr+sVAkXXiHKUeMPG6ZMFe9CjKIoU9RiXb+uE55WWcNkQAFV?=
 =?us-ascii?Q?6bHxIJlFC7KQd9QTLOe1h1LAiiUNbObjoDOPCH2kYCG9TTJGaLooYn09387o?=
 =?us-ascii?Q?nukULZp2kQUp8VWwvibu77y0FSHdBAsJvSFSKW/tyyFw03iKzJ6YCOUfU/2F?=
 =?us-ascii?Q?ETmT+IYiFFpeYSUMN+dV5vjMRmAt7OITmDVnCzWWvB20ZMMwKzeukQODSISE?=
 =?us-ascii?Q?ElKD9r1GiYszVDPM3M4lYrvVVZjmkOYY+GHOMM86ZkTHxsGwyYTAW3z7Am/5?=
 =?us-ascii?Q?/THdDgeCViaLpKHuRiZvsIsTl2oASwgNCcrkTEXNDuMFn/flBuL84jptJExh?=
 =?us-ascii?Q?tUVsqSdhtqSOtXDZnQ4RJtSa9FSbIwbFpSRJ3vaQ6AtYB1Ukty4RRltsc5R/?=
 =?us-ascii?Q?kitF7QLpQYdlR1F7i/8zP4h2Ok6HEkt2vr3sM6oaunnMXVcxrYq74Trum8PP?=
 =?us-ascii?Q?MH0PXjzJivm4uPAYKbFAbmh/pZWWUZLWWFYqku1FNThRR+QilH4Vy8cNcXgf?=
 =?us-ascii?Q?B9XOFarNcD5JeQz2JJnXMz6oTz3SS4aGRTkh0saxAalblDgvua4Ym6Pu0vbp?=
 =?us-ascii?Q?bDDRbn+eiZMiOuviOQWocqQ3L9ahnGPCmcuTP95BuIooGT9WuL33xcwpfNQw?=
 =?us-ascii?Q?n5EIeswSczZUC3UZHrfL3zx5bGiPR37adUAi9qaDcF4vMn7ek2SUm8nEVIk0?=
 =?us-ascii?Q?4oyjd7/gDVrRBXVpZyCABf+bXF9haOKJKoXykucY8wYdajyxhCG68J2Jap4n?=
 =?us-ascii?Q?ISrkipFrxDwsiEDwr5mcQWLpvc1VIBCRm29VGoGb8omDQ1z37T6y9QTGefqT?=
 =?us-ascii?Q?zgdQeU9/LmsMcOzWBLdbbQa6LGRoMzeFc05QlK+w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7582b7b8-36e6-4a63-2fae-08dba3ab77bb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:35:05.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esP/3ahGR21FCVtx57nd05t5H447nAn+uFyWZMEPTWRsfiOagDxNG6kahhffqR1pPqg08w+hx7wLGvO1xUFknA==
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

EdgeLock Enclave are has a hardware limitation of restricted access
to the DDR memory range:
- 0x90000000 - 0xAFFFFFFF

ELE-FW driver requireis 1MB of memory. In this patch the we are reserving
1MB of ddr memory region from the lower 32-bit range.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index f1c6d933a17c..747cb9d6b2e9 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -19,6 +19,17 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ele_reserved: ele-reserved@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+	};
 
 	clock_ext_rmii: clock-ext-rmii {
 		compatible = "fixed-clock";
@@ -53,6 +64,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&ele_fw2 {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
-- 
2.34.1

