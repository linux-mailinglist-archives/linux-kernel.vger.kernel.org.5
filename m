Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655F975FB12
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjGXPqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGXPqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:46:00 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6048F10D;
        Mon, 24 Jul 2023 08:45:59 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36OClRHx001926;
        Mon, 24 Jul 2023 15:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=rFjUI43TpX/JmSVtoD
        CGGHSG0jq9dTprZRNFzo5Ic5Q=; b=McGmLpv0wZ44qdxwBokUF/Ii7gV20XzpQP
        PSMpfgOG5P3STfUQJIfDZmEw81NmlA7gsjGiS9R8uAMbQIyNteLdAuttW7uoK99H
        5o3RERxQNnvLrLEIvC0+Iuc2sBYmFTS0puqw8G5sTrsLpLPiSDeSVmWnOkIdlRyg
        osRxjO7UCkDjJJnbaxN/oyvaaCnddmZ2M6AbbodZZcO6PsXskMO/soPgamS10e/f
        uJxAM/Cj6q5YOP3m8LaTw+/7thFkl09j0xFZr6kmqIASCdVhal5J5RqxMR1IxyO9
        kKLVzpe+Pq0v20kmuDPVfTYll4rcPTJxZCLfcETD4/MHXXBjQYHQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s06369myn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 15:45:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9xYyefHPuiWUu4tGaWbs/3nBvA/G3YM8SB6ZcGrEfgOfkn1Me1RAftWEiuSzjd02RwB4bl5RQ/tFFrhTQlxiPjSuC+yAz1NJykilC91NuoyXminyViypbI0IbdCcFw7Aa9QRMLyI8jRuOPrxTUGkR22TCr6OVgZoPndBArnjJbCYBOudlW0NQWNE4jyGSlN/iVisOVQS2pJyZa2RxM2pIteXn9jvPuqCUA0UBeuoI4szX1LRQKVGmArdjgH4jxtf8MFypZdIOi5ZhSWhQbaL9XVODLZQ38rEMFyofgEr1eY8GwIgZ6NVPBv3bl8lcM5/Z+gnvTPN/jRB0iC8E3sGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFjUI43TpX/JmSVtoDCGGHSG0jq9dTprZRNFzo5Ic5Q=;
 b=EF1+8kZPe36K062ycIdzDU2Oj4bbgrjgX2kq5MBrf/GJ619wm6hq/QnVMYRRpLG9lAcyDH3JZM+z0vLtynrakWlMcoP3V8UOqofDpdDae2db9iCkXF6A9kJvccQ9L+nqnoeI8z/Thj76vOrJ6O0nvnTtaPhZOauPS5XaVGxRhKAY29uk6tHo9xz+T75N5wuVvUsV5qlgFYbYdm+uY4N3kz9O5dA730P1I54iQurareKV16CELRmyM8SHOLw/V3zrdjeednm/mj5I2GHFvQaagbTKeWkVJHk7NKHuxT7l8M91iFpOqY6UrdExw/7M+fAj1cBMuMZ5YE+dgx7C/Hr0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by IA0PR11MB7933.namprd11.prod.outlook.com (2603:10b6:208:407::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 15:45:30 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 15:45:30 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        richardcochran@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] ARM: dts: imx: Set default tuning step for imx7d usdhc
Date:   Mon, 24 Jul 2023 23:45:10 +0800
Message-Id: <20230724154510.2532561-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::19) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|IA0PR11MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8afbac-be92-4175-f261-08db8c5d0262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0wd6Hjy99dIqJSb4v5iePejiOmVHJa8AvHiuqdZo+7med/5cmFPCTyocwc0E8Hqn3E2VVMWUIlNTM/ReH3RvBilpDaTnI5FXd/V8sNWiPTe2SZT8VdByamXyYsNPecG0Iw83GhFLY7CpBM6kruhtHzXTahXi4TJV4qEE+yTk2K6VycniyK51Fz5KAbb18hR5iMvPYYALnNpIyYIwSqG5Rd25ltYMS+BPkdvjxw3ZkQRxIHXyrbpAU8L7helJfKCfs0YLEILpCuZb7798ah7SZf68Xb5FYJMJmk91F5g6yvhnnd0Dotcb42r7ovfcy3sC4z53tTmyca2wyTwkxxH06kJYFj8qGjmaZfGvAcP7Ao6BL4qekzhPqDWnsVijBAtVfGG+g5PAYjgPe5sBvp6fA8CmZD6MJAlYR/ubUQGM9lVHT+QoYfRNnBzQTqo+B1TQtndNjzaz5HXsWiXR9esHQzYN56RrU/+LHFTo/y4sPXVutx2A5XGS+oJv6jSwdEcAIUu1V/oGSI9pJ2TIuvzXAYksXweIKoaT1v2BWy+dKSGIcLWbQbNIC8Dz4nCReLwJXpg0KyHvRqRQZ0zJC0nMohvYDQx6kyfZ6kU+J5/gL/h2sA//3x7XzKwcP2npX/Xp7jOZhGwNbRYcNWx3AgZH7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(376002)(396003)(346002)(136003)(366004)(451199021)(966005)(6512007)(6486002)(52116002)(6666004)(478600001)(186003)(2616005)(1076003)(6506007)(26005)(44832011)(2906002)(41300700001)(66556008)(4326008)(5660300002)(7416002)(316002)(8936002)(8676002)(66946007)(66476007)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zFC68bE8x7Xoe5Fa23yTPFt/8JgpO6yOqhVHUN7l9zRK+d1nYdkpqMSJVkqd?=
 =?us-ascii?Q?b8L7JPizCwhGvokW+jkOTwd7VyiK+YBqBRj24BNY3V3q+uvf/V2ozcVipbxT?=
 =?us-ascii?Q?1aa0kv9TIH+w236Z8ib/C6Z5Wa5AoULomKRBP6ep9uZnkHjZ2haQito2ZsgY?=
 =?us-ascii?Q?J1vZBHwZqLKbeDTenSqQ4PrL6bcZB+1zCwWj89Ky53btpthzcrfnoSdUqZLE?=
 =?us-ascii?Q?Lgw7aJsLIGHrp1hvwNIOntP8WMBSclB/vaDdgxywcwqh/Qs04jhafJL2V+N4?=
 =?us-ascii?Q?dxOjP7DjDT2svpIL/kSw8yApKJnxitHJxLEnURa7yrYOwZI/gzR2QOP5v2lt?=
 =?us-ascii?Q?1bCwi1B01TyafdeXmJ2YYpU+M11EK4t5tHf5d2B/eND0WC08T+DfWJOjfw1P?=
 =?us-ascii?Q?7A1jfuJbUwRq/KaIWTKgjJZag+ZLNrdpEirHCHy2LX/FjvK8c6qXT4bXQivK?=
 =?us-ascii?Q?Lp8o0uKgizx/DHoDkrQmQO1Eg/Lkw4cij+JIuonDFreguN7MRZteWMOBjDgH?=
 =?us-ascii?Q?O4rvSMOZF8+p61TWfEhWjTqDktWi97vePNFLxWwDXNfuxvgoaoqbKqIr1Ts3?=
 =?us-ascii?Q?vMyBM9hsUfAded3pFRbTD/rc5UVq1+Dp/YB3nB+5MHxYwtjFH0EpKvPNRH8E?=
 =?us-ascii?Q?0FDNfLweOyuGbb5aab1fyw5cbQIrO6kV0Au1/i2C4FQyYyzd5ind7CXl/Mk0?=
 =?us-ascii?Q?3NoLSLcYddq3w6gmtU2sX20XYPEVxAHH/1OwO1sMunxW7F2CZ3pZIuKBDqBA?=
 =?us-ascii?Q?ecYJI6JvV2Q5kywRlAy7tLDqletzLr/hYEhoAm+9M5I2/Wm56KxUvOKN9oJ7?=
 =?us-ascii?Q?UcNcHbC/60GQXgW4AiQDBAsOojRhH1tjbg5rGUZaoganP4ACjv6k8Xd0SLlE?=
 =?us-ascii?Q?vz7e0FnU8+woZzgk6daQKf/c93OJElid87aqjSX1ID7YRK8+Ll5qxNR8LPag?=
 =?us-ascii?Q?Wv+0dV0PpPDrcx9JpUridrM1JK63Xy6CvsYvN23yqJMnsF9hp5h+KC9l8+tJ?=
 =?us-ascii?Q?KsfNkpEs8VO78cVKrgcYOUX6RCsQxvent607i6/35x8ya1cnXrwyDNCGODe4?=
 =?us-ascii?Q?UtOzvpjMc+/v8JCAdcn7zyMkIsTqkRoppKUkbQsogpgYbGmI/6+ClfpLoBS4?=
 =?us-ascii?Q?yrBn7HXJwmfJ3Iq1/YwXgzmAUielqtrdqLqcPE5zj/NxYFUzzaSdPYmW0WmI?=
 =?us-ascii?Q?ZY5Dm25UItGnP5FM8z3/flR5PQU4LOc3HVBNYYQ6WnuHKo1QVBIRJbSE6HUy?=
 =?us-ascii?Q?IE6g0HIGNalJORAf13k5kpRKmZbmA4f3M68ZlvuFvJJuOUiL+DYtKg6A/lEn?=
 =?us-ascii?Q?dpcmN4CNzzDJs4qrwhQSewKfBnUU31Ud8KcP/EE7dxDgMNIXOUOhXPRCOWUB?=
 =?us-ascii?Q?xPmg8FUwvqz7oGZnpLWj8zGTOvA2ePYkI8rENC8YAjMh7elSdsfciC7J0IYT?=
 =?us-ascii?Q?NpcjdP0PiWE/y3rtueifLz2mjE48iJf59YMesvb+JdOSCPlRyC6yHDpVUvGi?=
 =?us-ascii?Q?+Vhs2gmFo6ExwaEagp4zXCue1In88gJR1Mlti5vvjnI+T8MlR8suNcxm+le6?=
 =?us-ascii?Q?nqzLUUXEfXKlCd/75otP/kopXcVpIlUAmNSeJBn+/rTx1YvRCIa9ziQj6Xp1?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8afbac-be92-4175-f261-08db8c5d0262
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 15:45:30.4959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGFuZYDGysPx2FKVBT4b9s0uY5BeqwRByGPFYUoir1lY/I8jLpR+O3etNFIUUnP8jaO2kYzFLqw7fxYsILzLgECC2FW4FqI7MMB+Wyd8dD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7933
X-Proofpoint-GUID: PrVQlSCw8MNQvZYbOk0j56MuzYp1wloE
X-Proofpoint-ORIG-GUID: PrVQlSCw8MNQvZYbOk0j56MuzYp1wloE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_12,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307240140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the tuning step is not set, the tuning step is set to 1.
For some sd cards, the following Tuning timeout will occur.

Tuning failed, falling back to fixed sampling clock
mmc0: Tuning failed, falling back to fixed sampling clock

So set the default tuning step. This refers to the NXP vendor's
commit below:

https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/
arch/arm/boot/dts/imx7s.dtsi#L1216-L1217

Fixes: 1e336aa0c025 ("mmc: sdhci-esdhc-imx: correct the tuning start tap and step setting")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---

v3:
  * Add the timeout message to commit log

v2:
  * Refer to https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/arch/arm/boot/dts/imx7s.dtsi#L1216-L1217
    and add the following attributes for all usdhc of imx7:
      fsl,tuning-step = <2>;
      fsl,tuning-start-tap = <20>;

 arch/arm/boot/dts/nxp/imx/imx7s.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
index 54026c2c93fa..6ffb428dc939 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
@@ -1184,6 +1184,8 @@ usdhc1: mmc@30b40000 {
 					<&clks IMX7D_USDHC1_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -1196,6 +1198,8 @@ usdhc2: mmc@30b50000 {
 					<&clks IMX7D_USDHC2_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -1208,6 +1212,8 @@ usdhc3: mmc@30b60000 {
 					<&clks IMX7D_USDHC3_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
-- 
2.25.1

