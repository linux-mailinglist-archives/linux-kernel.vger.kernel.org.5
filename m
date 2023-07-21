Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E125975C1D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGUIiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjGUIit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:38:49 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1079F271E;
        Fri, 21 Jul 2023 01:38:47 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36L5goVL013154;
        Fri, 21 Jul 2023 08:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=HxlpFOn7ygYlx7xkr9
        Gm+xHGAz1L5zEQ/G07dDAfc2o=; b=RZzrx991V3HPJa/aKYJcM10ntcOAkpvO/D
        +BSmQvrl8b7qC0CqgFU+c/Tktw3MkRJa6sYHQqUi6w9g0si7DlXclpWWe+rmJxb5
        qwY6BnKyd2TFgl93A842DGvD0cs1yYTDsEUXZf3++UKAZgxBM66Aqu/4XRX17Wm2
        u2vOXHza6CtGIJ0q5YBI8TKBpXC4jAdUVcUIwAX4Xpr/PVhFNCI1qYhJNOM2tMdy
        Zn10ueGIa37Sus4GdLSnvRgr8sIS7FnzClR5sJGy6xOphiAB/C1Az8fpe6iikzNP
        DUxYUqjLmo2HZm40MoMtiwyXuDaWLv4MHw9UICYBxvja/LJnjGkQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3run9jwfr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 08:38:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbLzUTf/5/BU3qlvIXCyHdnMUQQMz6bcXOhaa4H+rg7DRm5+8xKxdlK0iVgXHSxXUgDue/F4ulw7XabnkE5IOa073eXQZajRzbtsI4HHBDijo9uGGX1XtlU9ZbgTQq+SXBag3mZUfbIFmdhlZCyJAJAqCOcq/ThhUeunU6ghmQf4Flsy2USeOLCrmwXK3nLqDRJ0kKnhacpBgBbToN9BdTACu4vGkGDfhbARUL0yLgJaDxuVYAwvaSeXGATwgDeKw7lgiu8bdo7ByFgdkpyHPetPknfheQCPA4LuqBZarKTh+qoAnkFACZEHSRc8Wx1qt7SWFrE9qeVVxm2OZtsJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxlpFOn7ygYlx7xkr9Gm+xHGAz1L5zEQ/G07dDAfc2o=;
 b=EQ8j7l7YHxemo3NexYpj8/ulxmvRcOsqcD1JOvtfAeN4hm52tu1lisckdsErHo+McpXnClc+rUMD3aw87IjExQjiPG2nn3vO5yVmhEji7pINk/aZQCIMGdrpLjR9jNKWP50c3kBBQz/90xtekWRsftbr8sk60cN6xhz5OT4G6nzOqRerFW5dBW5nE/ttMmGt7btYrePtpXTiXjDttm5WcfnfpjEyWZPC9sJUaRWnr4dQKook5H8s+mIjcgmM89tSiAA68wxTdzpIJG9tkU4nWHuj0DKVMgb0O/MWaMRKPccDTVa7UeEX2nxWo7BBTsiIjsEGriXSbCNMn79BnmJdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by IA1PR11MB7918.namprd11.prod.outlook.com (2603:10b6:208:3ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 08:38:41 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9%3]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 08:38:40 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     dinguyen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, meng.li@windriver.com
Subject: [v2 PATCH] arm64: dts: stratix10: add new compatible for Intel SoCFPGA Stratix10 platform
Date:   Fri, 21 Jul 2023 16:38:21 +0800
Message-Id: <20230721083821.1820881-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5191:EE_|IA1PR11MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 624d318e-6d78-45e9-f586-08db89c5e276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IK/2FRQdm4M5KsUk2GPtZNgFWMUdSAYzWvEnRG0g/jajoMrMEVo9kzc26RULL6nvUE6MrfDN5y/mAzc394BLZmcws7vJrBog1Vp+PjX23feafC3m5XC5vZLYAvlqYaD68RQDV0y4LJvPtyWFAVoNl05FL+DG06tbTHyXM9xuJpCFM9ua1S+UEx9COo7KKRTyT03LKHz5OOfrxVjzwxRpNdypTNWlAIGx4fqdTLtJFzwKrY9bspSnBpVGv2qzWEuMsxubZtFGTQjNIdWQck+GM5c0VvtbuFUXxZ234AA+AkvoQIvc4y9EjRpQCTwalNxVAfw0Ztb4eMeiBJom0MY5nrpj6qmw8PY6Z/57+4XBqXaufu67pbbEYyBbJGE2w+RXswbGKpDFy0dbNkxyIg+92mjT6k31TrwYeBDLGreC1Wg1JwPRrMxnxrww789TiBxLru//aqo4zVHBluBA/03QxnZ0x+cIUSmFcnAyWZOpzn6JyQIg3BONJF3L+H85WAOMhJmh7FnvdRYhMqr5k9hdIdbirHmPFS26VMv+JK6Jk/wKnG6m9or+7bC/Gzsjf+awlU0f+j2ZLXXJIs8rUS0xUw4YfIwWhbeGe3ssyK4lxuQCi1CzwQS0k3cAWmoblHqD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(366004)(39850400004)(451199021)(66476007)(66556008)(66946007)(4326008)(5660300002)(41300700001)(316002)(2906002)(8936002)(6486002)(6666004)(1076003)(26005)(6506007)(8676002)(186003)(86362001)(107886003)(6512007)(36756003)(2616005)(478600001)(83380400001)(52116002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EF+xvCGWIEXF1hgF5x/0QgUJjYk9FjgPkHtdpHHY4YKBBsBB37DdT0awU3JT?=
 =?us-ascii?Q?EbBFF7KDPQTaT4I1yrjfl42HyLaKxjdbC818X661nG6w79KZAQyyoxntQavc?=
 =?us-ascii?Q?rrLnlU66iX4a8nE74l56AwSTz9IKa4xFNcZK/+ndDQ6L/HU5d0mvrA9M/DAu?=
 =?us-ascii?Q?tN6ODxMP5HYmWgQOXcTSN5v0LP4G8+Y7XVjabcjvDhmywVoPlxG0M68b95XK?=
 =?us-ascii?Q?JwXE/UotXHnjZ+gFnTQbb7lDrMkzdone6/XL/QZCfIB2h+3Z1A8eYkscMzid?=
 =?us-ascii?Q?aH6WsjQkYSpAU/4jr/RTMSmvrSKAImnU4hEbNt0JgzHWVgNhIcHCi4nce253?=
 =?us-ascii?Q?uGiCSQg+/I9HXHPYPtW2tzMEQaXk/YoLj/hi8htKBtyeWpwlZLaSwqGDzdU2?=
 =?us-ascii?Q?HGPBb+71ZaJ4nrsWfIZRgwYCtt7iW4DXgmc3MhbSI2lSDILQz85zT3RewJkx?=
 =?us-ascii?Q?qLdARUmQPDpO50vc1iqkcnirDr1ONWvRPJu8CtDCk9y4xMuwJRpuK5l97k//?=
 =?us-ascii?Q?6/VSjZ9y5WoUdfcmhvhZCVhQO2on+t+fTeoUzPvLjjL7pBB57E2YsMlljyFj?=
 =?us-ascii?Q?54URzsE7eyHAjCr6IBfGhhnXXcOZjfK3P4qwxyuukhM5yqO2kEvQ/xfd7QY1?=
 =?us-ascii?Q?O39fclKWeDHqpMKyzNGewV8VEwUCAiKfPtcHBGau5Fxod5P9RI3uLyDjLRD3?=
 =?us-ascii?Q?cuh4qrYcLeVaHj3U+0kpt1blxxbUKcwLLV2kC4rf/XpB3mMesONiusfy1qW1?=
 =?us-ascii?Q?eoHmdHRdxe9eULUsPyJg3Aup+wGZ6GyhnSRGvyp0VEqcgtXgmQN11WkLlwKl?=
 =?us-ascii?Q?hfH6xsOaxviELz1qVCTu3LFlUP8+0AMdtxo0y67pRDCiaIsWAGDBbCJkCIO1?=
 =?us-ascii?Q?tZCNxorNxeRIR9MY4cW5f4f2WQX+8bqaW8NAnxO+OS+szG5bM7LizuoXB/HV?=
 =?us-ascii?Q?lBD369HQW7RpyPYxc3AmfQN27JXNl9HCdIjSjeyY7ksHQSVW9HrTSqHnB7jX?=
 =?us-ascii?Q?On7BZ2LBQIBe7xUU3i02DJCLUl/zQpflP8BpAQx9EEpWdBzLKphtpjnLHOid?=
 =?us-ascii?Q?DbPj8n+WcU3NPfI2wxet5ITlMlE9h9zgQasNhZjWywT2atJW8lUa22uroaVC?=
 =?us-ascii?Q?4yQKeF41DoztZeolTFDzHmp2AJGhgdoJriQwJspGXBrvKlffVuOaTjerDbXl?=
 =?us-ascii?Q?fKsbbY18J3D0meBCXYcKtdhsB0bTXxvB2LFyxHh83+KGPSS6uuYytWSTLNXI?=
 =?us-ascii?Q?qCRHVYLcIFUpYQvjGpwi1shgE0bZrK7b6NoGg4L+AcT+gNQbDjTO0kQntjyX?=
 =?us-ascii?Q?8j8A/Yk6n2uXI2gWxoNjUJXkiVHLlm1nA3l+09tpVKm42gQ/MWIIhPZkrbhu?=
 =?us-ascii?Q?/hz16mlXd7WOAk+HQ6u04ky5rneRJFhYsHV/TpUiTgbjv0ing9wc7XnDoRAw?=
 =?us-ascii?Q?LpZvcQ8rftzOVmaO4G1MzL04evQ9NmUiSE/KX2fiG0RUSdM50lPsWCHFCyMw?=
 =?us-ascii?Q?Pxz+miuyopPRUj2N8k48UwbW81STDH1NPmOe2C9ytnqiBLF0XQ2iHFCMZ+W9?=
 =?us-ascii?Q?uUUfQc5N3MBSVPjeasJKi1OaiVQFoGkS28sBZu5P?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624d318e-6d78-45e9-f586-08db89c5e276
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 08:38:40.6281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGmu7OGQsdYarXAYwYsctDL5vwzkWSQAZIf0NZGzdV70zs3hWRrwzaclufvo93TzjfWSeNl6vjbkaKh+ymzm1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7918
X-Proofpoint-GUID: F_cA4xtnJnCb5VBdysMsnr0Vt6AvCIHg
X-Proofpoint-ORIG-GUID: F_cA4xtnJnCb5VBdysMsnr0Vt6AvCIHg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=864 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307210074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Stratix10 is very the same with Agilex platform, the DWC2 IP on
the Stratix platform also does not support clock-gating. The commit
3d8d3504d233("usb: dwc2: Add platform specific data for Intel's Agilex")
had fixed this issue. So, add the essential compatible to also use the
specific data on Stratix10 platform.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Meng Li <Meng.Li@windriver.com>
---

v2:
 - Add SoC specific compatible as per Krzysztof comment

---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 41c9eb51d0ee..46691e72f46b 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -491,7 +491,7 @@ usbphy0: usbphy@0 {
 		};
 
 		usb0: usb@ffb00000 {
-			compatible = "snps,dwc2";
+			compatible = "intel,socfpga-stratix10-hsotg", "intel,socfpga-agilex-hsotg", "snps,dwc2";
 			reg = <0xffb00000 0x40000>;
 			interrupts = <0 93 4>;
 			phys = <&usbphy0>;
@@ -505,7 +505,7 @@ usb0: usb@ffb00000 {
 		};
 
 		usb1: usb@ffb40000 {
-			compatible = "snps,dwc2";
+			compatible = "intel,socfpga-stratix10-hsotg", "intel,socfpga-agilex-hsotg", "snps,dwc2";
 			reg = <0xffb40000 0x40000>;
 			interrupts = <0 94 4>;
 			phys = <&usbphy0>;
-- 
2.34.1

