Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0167F9AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjK0H0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjK0H0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:26:33 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212D5182;
        Sun, 26 Nov 2023 23:26:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmlZNXZQakovj9mh6szD5uVXYC2hEmLYd32cC8JX1iWswJA07chSXU4cEiBPw2fNixuTyyw6sWeuRwC020mKWJ9YQJ4rzMxz0CH27bbgbySW5QqxRapSt9AAlIoDS5W0655ixgjgvDQoVufsSCmMzK5m9Fb9gGHf/LrF9sEiD74axMcfodgqt5W8cSNk+x9uB2a2R7HRYxFHart7lqEkjfpmffjGAXLd/ToZub6+LoqHpbeCGjx9HUqlxmhgmMigvkVnaI8wYemYiljGCRKQZUTsu/mLEMAZHI7e95TGmIiU2+Z4eyAATux68Nlg4cAd4xsmgxAPf2DLzlwntGsi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uv/9cDnmlfKOt/BPEzkg5O0jXXVozI3BTZCov2kWSDQ=;
 b=BsBsZnNzEuF2U4MoojzqGhzyCWt5CaxXaq/YUkS643z542bzqhC11Pn1XaAlV1oedq9oefnVFDT1D8Bnu0NqQztZZ5MXjt1IefBE4rYbJXbEjwaqDXB++klYWxWxchuj3E1usOtkf63HGER84WiVPHzfz14OUs3mQO3af5H4WxlhR024yPLSezxz+gEUuXuD5no/6zM6cuV4+Pawuu3fiMzqQxCkYeeFleI2/keagNzuR8OZ6H4K5xJPiDMyNnZWNNKCQMWJyMLyaD4Lb52lrXgB8sxnrIWo2Cam/u26hvXUFiqpfMU140z6eUuo4HQw0BWGpnS0GVy3yU6ohkRJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uv/9cDnmlfKOt/BPEzkg5O0jXXVozI3BTZCov2kWSDQ=;
 b=qEd579d1nwLC0S6LFwSLdTZSRzgGs2t+tDSvLxuIRT6nXskStNYL+paKa7acVx7m/VW7iTfGlAFSfO+I5N01EPYaYeEONeM8z4d9VR0beXgFD68MnSH/00zqdx6quLXEqL8uEPkoCRS97pYOC0LhLc/t8J2EG1kcmKWbjCToZnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com (2603:10a6:10:23::16)
 by PAXPR04MB8157.eurprd04.prod.outlook.com (2603:10a6:102:1cf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Mon, 27 Nov
 2023 07:26:33 +0000
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30]) by DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30%7]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 07:26:33 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     Frank.li@nxp.com, will@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, irogers@google.com,
        namhyung@kernel.org, acme@kernel.org, john.g.garry@oracle.com
Cc:     james.clark@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
Date:   Mon, 27 Nov 2023 15:32:06 +0800
Message-Id: <20231127073208.1055466-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DB7PR04MB5146.eurprd04.prod.outlook.com
 (2603:10a6:10:23::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5146:EE_|PAXPR04MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: de7fe9a9-b4ce-46da-fa96-08dbef1a2ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E60DFYYjJclQ7kXkx5LSNKGqk2TWKMNSTKi2/DP52EdatC2h8eSOxxIujxue33v2x6G9kzQheCANbeLQq4QvnO9q2qNS49HX69Ke/XkQAP4erdzhwHG/cZoe9TNuRJuKdpcaTs6cj+17kxBn/Okb+p5p0vB6ODaBLQ/nKJtlZAeoib0oU5c9J60+tEYHp4RcRyCdf1hDYXl7SfUoDVULaIh6xK4woh22357yeL/0zhgMisOsTl9iZ0X5tSJNXaWuXp24R0dCHwHrda0VNAWImcS/2Yfg7Dmvs6qHKPLtPS/Xf8QOyVo8KeLQ97WhttUGY7XCLIRUMvwSWoFP4PzEdmwTF5KCC/F92r+V22HtVMzeBXERFuTAXWjqqWiB+XSboE3ARoXSqPl1zl62dR+Vw2yEHPBAa574W5PhXfGJZDX8ajI4nOpBpyVPOvmUuUDSnoe2ZyHHa1+ZGz0PtIyP/mARXEc300/cr0G6/y3vMy2T6lImf33mkZb6B9rjuMZuNFb4LQIjFnWhiB5ynRzLIP1Ye+a6Vc6ZpfiXGcmn45eh4aD7NIzNn4v1sejJSw67QBabQwMvjRtkf4C7gqJEiROz3qVMDgZsA3mKJuIQ8TwoMt1UfdSL2A7BBOAa54gyhLdFe2X2oqXe4Ltr9PWd4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5146.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6512007)(6506007)(1076003)(2616005)(6486002)(478600001)(52116002)(6666004)(4744005)(2906002)(7416002)(41300700001)(5660300002)(66946007)(66476007)(66556008)(316002)(8676002)(8936002)(4326008)(36756003)(38100700002)(38350700005)(921008)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dJ5Wht+wPfXr/DmSjG11VHZOSAoBw6M0OOg0yLCFuQ3FdbPdXKnKAeX6zk8t?=
 =?us-ascii?Q?3P7h3yl3RsWCRMJEXC0i50y6ZquF1rik6SDncbJE4X6zEna4DaJordj3rAJ4?=
 =?us-ascii?Q?GAj34m7U8umlxh0dYY3CIQLMGTeR8IY3cy3iA0qmEK25HK2VeXkZLt2zvMPT?=
 =?us-ascii?Q?1XgtQPvMvd1ISlWWLnHIFbkxnAs7rZ5cyV4Pff/10FpEa6ZMJsPDyH9RR2zt?=
 =?us-ascii?Q?WO6jzG2SWaEqMR+UFNohKTVIhowOu5EjEuj3HbbKKGi4TPJbXHpKKnPz2lux?=
 =?us-ascii?Q?+LZruAxob5UExUB081FMcnby8Xqdcn3UOiZOAHVtHgvlX772lkQHIvwXYECF?=
 =?us-ascii?Q?RxVmIdWLZ419mmZf3ErDqClBr7q9ley5epivMUX51NSBxVvHLLKS7Bl4FEfn?=
 =?us-ascii?Q?NEUuEgYzQu+iAIUukCieA4Jh6MqNbO3qaMmZBofbdW23ARCfL2l8S9GyU+3K?=
 =?us-ascii?Q?TL9r1wIXqHivzlokxdRKYG7/Lspo2Y9MRd4c1HvzCbSpFpa229ZOlh/YYzkP?=
 =?us-ascii?Q?XMCDl+dwIoEPLRGk48ELHkibY2K05wvfXiRekt27e/s0OJhidXd0yhsN1uAe?=
 =?us-ascii?Q?PBO+tjAVIn4uzFqSFJPXaMww+6CN9uIrtjUv7fJDLm+1RDyhHYqMTGfcx1LJ?=
 =?us-ascii?Q?6dEuQyz7/6wE64//jhycLEF/1ArXAjagqaZcvPMFgefOfaaSungpoUHXlIBO?=
 =?us-ascii?Q?Y40tk+dzqEgt7kHJxeHRpnpdaaVphSzk8XDsuNqbZ6B3mwdx+FqCjZZx+sye?=
 =?us-ascii?Q?N3vD7jJQT0ZclCjF/pbiCz4xMKa2vXzTYwrHenqGJ2Y5iJRFE0fnqd0h3icj?=
 =?us-ascii?Q?dK/aKgulrRO/odgbgF3vBsoVgcqwjg+4BsiGE/9b1MU6wxtQ8MMMTu0fYt4y?=
 =?us-ascii?Q?DA0ix6F9jK43zIEpAlKw/Ha420QLdskc0emIL4VsSaCPUurYTSpAGROqNSXm?=
 =?us-ascii?Q?6lv2pnY+L3+V5TNc8B7h9Xsm5lN/ggTXPhmMPxfpka38/C+CHj1O8pLhLmVp?=
 =?us-ascii?Q?8I2D+CQFmQEBZr9qjM5g9hQ7Rxpp5XdozZSg1VPxr7oBWSEHm4Rd3LBy1+Jr?=
 =?us-ascii?Q?QtrhMzVKtbowquR7WTVSJH1fqVgUloIchWHfnO0zqchAoXPM9mDIKaYDUu1D?=
 =?us-ascii?Q?4QzjbZt+cf3bFAnDD7bwMi/pTGIYcZzkH7FjsIzjNEgcGxkkWtFvgYG/Ulyk?=
 =?us-ascii?Q?0o1G5RU6JekzDMvpEA8pVgxmw78exN/+nTu1WodYSe/YNImErPHr5ciINvmq?=
 =?us-ascii?Q?OQj2bk39s0GF6exnBDZP3LNb4ZIVTtfJMCKvhdJBZWLKwOgFTTFQd+6UFPIC?=
 =?us-ascii?Q?fmCy9CAsLvC+XV/osXpnfe8ahnug2O5epC06jPQlyiP3sFWqV6Zugy9ARsqm?=
 =?us-ascii?Q?JAXJRlcTsNvDHzZpQBjHtQXrGopq92ygr8tXxaZ1UY1gsZ4uBiHc8ezdW3zq?=
 =?us-ascii?Q?k9cR3M/3S1GYYXqUqADNSmIfZOZdXux6QXUxwFpJ11Vkpcjp9189c/cuQFDE?=
 =?us-ascii?Q?bbnM7PC6Kk7ogR+udV9wPLNTvn33e9q9s3RQNTxtaPK8Ax+n2/PyELopwg1O?=
 =?us-ascii?Q?C87b7dvAKn06QWmv4Mrw6+KPZeT2UorTTHBixAOq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7fe9a9-b4ce-46da-fa96-08dbef1a2ea2
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5146.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 07:26:33.6957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p86zWFHMy2bkpQvI+q0yIeskieszBPRq07aGMwoXX00V+umcBupSYIiSalcr+hSpOI159Z5R2BFTPgJfV3pkPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX95 has a more precise counting capability than i.MX93. This will add
a compatible for it.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
index e9fad4b3de68..1bc7bf1c8368 100644
--- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
@@ -20,6 +20,7 @@ properties:
           - fsl,imx8mn-ddr-pmu
           - fsl,imx8mp-ddr-pmu
           - fsl,imx93-ddr-pmu
+          - fsl,imx95-ddr-pmu
       - items:
           - enum:
               - fsl,imx8mm-ddr-pmu
-- 
2.34.1

