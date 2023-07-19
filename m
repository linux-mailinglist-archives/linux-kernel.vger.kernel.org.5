Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D04758BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjGSC4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGSC4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:56:04 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CC81FC8;
        Tue, 18 Jul 2023 19:55:55 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36J2rh0c000831;
        Wed, 19 Jul 2023 02:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=nnE19wHsIykhFgX4pOMKTwuC3bN5sI3TuYUbpL8WIrU=; b=
        RhdpplUsOWXF1Wxik4y8dZGGpPT9+0aAAeKnY9+qWMju4rKJJGdeXFOgCZHaGNJ+
        nhOQ18inoBewDHxuzNqGrk9nF0KHEYR4CHFIShwzAIhjH9rSXgWi41Qyt+91t0GL
        oQN/5ni7A6AHP0t3xoJO7FGSxd1HQXLvqlNrTo7x7SghRFx4Jme1sTYpbUyAHKgx
        WDs5dzLvgWqdrXUbFeoG2euQyoPtEhfPoo6HgMhC/l4+d6O7RhHsAHz2qWk/XQxX
        kW37Jtgn1qV4rD2m3GNn57zGpuiVHD+We1o5uYwyQn/3cFrgACNFf/JS76O0L01z
        OX16HvbuQ/eGVSN8HqjOVA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3run9ju8mm-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 02:55:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXOlIR8kGLMn4Stxt8Zw3ci9I+mywJZIDW73y+81jWsWI+sa7/75+welWPlP6q4fXds8MTh4Te7LzmNeHy7cgKIpL2SJbWv630f3mdAyihvM8fSpDOhx75Vri3S7q5FKV4Tbsf7fX5jBNmEM9+elsl1kNggoV0T1CWdYmmOE5kjHtF9YJj4yaDiBbtOTOI8GW7JrcKqlHNuJfsv0Iq0TY8U2k8lz5CB25sIMYySJ7xWhSr6aMuKTLpaz/9B1mYRX3KFQUlaAEir//sscxRAAnA+FU2LffOi9vA6UT37lz431sPBEguVqdVQq8ebHQgCq8oLqCEayOtr+DazWdRnB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnE19wHsIykhFgX4pOMKTwuC3bN5sI3TuYUbpL8WIrU=;
 b=niiJG1C+NeTR1OggwO7K+DYt4zfcy+nMHV5wlnOF+/XPT+CGz+LtsPnT+/O5LSJIsW/FmrvzIndsxV1reWrlXLDZVmsbIJcs/zNbScs2pWgtgk8fZhjOwBuAKihMTjvEQKZ38LIZpaa+5kLU51O4XY15UNbxwfG4ZoZZzLK1jew5ru1DT7jPd3n2wk4QESzj0Yr+/Ka3YKUtek4PWfcyKyRKAnodq9j71icbjI4xNqzPv1dHs3QbrXZNYUvYxz1X2BpfYcRScVtNqcw1yIopuqlCw1ir30T3Ms0un6ZMJpjkafg49jqO4c0NuQqvqNMVu/svrrbKAUqWnTUguJbeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by IA1PR11MB7728.namprd11.prod.outlook.com (2603:10b6:208:3f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 02:55:41 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9%3]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 02:55:41 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dinguyen@kernel.org, hminas@synopsys.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, meng.li@windriver.com
Subject: [PATCH 3/3] dt-bindings: usb: dwc2: add compatible "intel,socfpga-stratix10-hsotg"
Date:   Wed, 19 Jul 2023 10:55:09 +0800
Message-Id: <20230719025509.3007986-4-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719025509.3007986-1-Meng.Li@windriver.com>
References: <20230719025509.3007986-1-Meng.Li@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0119.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::23) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5191:EE_|IA1PR11MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fecc9d1-a6ab-4a84-5c77-08db8803a327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2UPg2Nv+yGSTeBRGAOcfrhKhCj2eiSdJX7FAhCWaVETvq/CcdR79GoT4csHfqY9D60HESpQOLUt5AW5W8K1UzO/1Pd/KJG2JcHEqo5iLZVeMmiZGQ9Y9lQfS+nT1M2uCOXPrr5iTpXrcIOuD9LbqCxhdkS8dZYr5LzFCKxI/qVY5qaAzGWZHgdOgshEB+0p1qrExESXzRAuPxqBo/dx/2Z6orlLRhstd0psL7geftW2cvFRl1EClxzl0jzH5cQiOmF1Ws1HDpAZH0EPaznUMR248SfMsY47AghbT7DMcqmqdO9BQOcq++nxRV1UFnDnoLIWHFWn3ZSqnVVMwpt29Ogg+K1sITUBXVW4vVNAdMLy7BwLdyjjI4LQDVvFkjW5K0smzAnNsK4BgrrzprI6pfi9MG5ztyQe4gOlV5nVVxuLsT47hoXi1/QP4aWriqRzLniTZPOtnHvXfKQfwXVgThjpp03an7SrhLtxr6YDKwNXTbBGuXCFhPOAvIZjAJlhsj2Zpo4JMSYZanxCtvMoRf9KaFXMTR90M3A7CrEH1YFy/lBeSTpUjkLhe8dCD1SSfqRUdJZQnn/xOxcJdTo3OG2LtgytVUk7u324tKodY9aF8nJruaVYhdgmGzQLQl2x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(136003)(39850400004)(451199021)(478600001)(52116002)(6666004)(6486002)(2616005)(83380400001)(86362001)(36756003)(4744005)(2906002)(1076003)(186003)(6506007)(107886003)(26005)(6512007)(38350700002)(38100700002)(316002)(4326008)(41300700001)(66476007)(66946007)(5660300002)(66556008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SqlN8ZGQr+7sbfydcWmz/Y0cR8y/F4AXiX4Rssx2FmtHdpOgSP+kXH3zc0br?=
 =?us-ascii?Q?fxxbM+ZKehO+9ouzca3Vw62+Hx8rHeKL4Pns7LcwZbLdmALG5HTLptkAo1WW?=
 =?us-ascii?Q?FUizZ55HYgfLlhkfAegWucTPtCkxZnLAwpma4AuueWUghhZEApnnscl7vvsM?=
 =?us-ascii?Q?sov3NzaFbQ9C+EHW9Dc+r2DbO4bG7gy7HiYlnS8gWGnA6j39crJ5DoI1Rbp7?=
 =?us-ascii?Q?vr3WZZqRl+EAwbP7tnp78wLSLArIeFWZP41/WdKq33L+JqVu0Fqak+i4FrWO?=
 =?us-ascii?Q?t5sSXPijjF4fCby0ubJy6J/6KdtMWyko0mCoW1f4aEjmK6zykjCx7z1JqLkN?=
 =?us-ascii?Q?Kzz9VxChwodUJ28SQdvnXRYfhwp8jz6IWrOi+nS+cWuWOxFA5atrJZjjcw+v?=
 =?us-ascii?Q?JiA9v3G3rQX+qEzrJTxK69yAh+Ub1w30lmKPPmaGsJDdptWKSgirQiEG7HuN?=
 =?us-ascii?Q?zfw/I+pKRhF0fCVqHIDdWz8dzebCncgEeRv6s8zND8ssf9RQAqK67moJ5Q7K?=
 =?us-ascii?Q?O8255nDjbZ3cpZUkhoLyqaOkpOcTQwyy+9oVlkej81aqJRVD4ZvsQfM0cG1l?=
 =?us-ascii?Q?pArNy1wOTYmBA2D5AzygtWPOgYSOG6DUy1Q5f3DfPnCBVhmROJgYTT+QZsJs?=
 =?us-ascii?Q?nuZwq41U5sjQ5NJARAY67VggdClVJahD4bfwWDlq7SXHY4QDaXWD0pS/PJeo?=
 =?us-ascii?Q?2TMQ0rrTPLTye7rwBXAvSYo1S2HgCKTmdVWRP4L1eKp4hcicYzYGQFJTn9y2?=
 =?us-ascii?Q?7VcLxaL4SAUqGTt/VMWpGH8HFlHVMO9StQJKiQRE1BZFVTJTUPoJEVxTtwSS?=
 =?us-ascii?Q?mQPzPfliv1RwECyRdDVj/FobU+9qU21AOoS3z9dbtUXXIfX86EGh+aPE1GMt?=
 =?us-ascii?Q?rOMyUYO3wgbPR9Wg3ggpdiXjmSYRD4GBGxaGQVTxEozT1zeQqxvKNpzsz358?=
 =?us-ascii?Q?DxLut5Uj950F0JjkCUTHj8gB6A2VEJG8/XZWrOOjRxoNAzMrizFEAMGhf5mp?=
 =?us-ascii?Q?TS1UvOs9y8s9TsE7kB1ncRFynYpv0lXwnRtMO4w5WfrWWZ8SJBe3STrGXCzV?=
 =?us-ascii?Q?cB0UBqC+/1NWvdYg+rQbp4xQ0KmZeYCZkvnkgMuzLTUcpAe3+VbX3OAFjdvJ?=
 =?us-ascii?Q?13rQsXQoApszakQ6fDRYho+382wrA8jG8p1MGdebj8RyMQuXFKfjTYZxzDTF?=
 =?us-ascii?Q?F7iCPfsbXwzlHSDahfbgT4zkkBD34wvff2Qy8b351zqT02m983BKXIslo5Sn?=
 =?us-ascii?Q?gbozBwVvYX9gywOsEf6ryqR6jYJik203ETtIKhzyrkw5sBGqQwn4AtiRmSji?=
 =?us-ascii?Q?r2rCKfG3nNJc+Z9mDNaztON6UQjCCGo3M1Z5KgCSUNdWM6MG8Xul7sTwFo3R?=
 =?us-ascii?Q?MYu6abOeWOHe2zaDZaaiyyGsYTjRBLF/vJYPKXJIrywVFwZdvd2YxJNuRJRD?=
 =?us-ascii?Q?ljgCigZXFFhXZgVXSKzNAkA00WTriQVohbAq8iVOZEjBYq48gDMDpdBt48o+?=
 =?us-ascii?Q?D8EEWKQI+olsTNXrZbA6iXbhRjBF5psdws99OiAsIxdjv/BZrDs262miodpP?=
 =?us-ascii?Q?sSyZAlsKyRFRMm8bWSW6AQrRI5DW6J4UlI1MsVNq?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fecc9d1-a6ab-4a84-5c77-08db8803a327
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 02:55:40.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ztiyd0sP3eEltv9fkU1LoWybTHu4MlmC+uYV6H7+S2CjcbcsLHbh0K/QnlvPU0tA308oiHvaGt+mXPHZZQAtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7728
X-Proofpoint-GUID: L5Wt1UJZgaS46YnY2N39hjqr6qqpWJKn
X-Proofpoint-ORIG-GUID: L5Wt1UJZgaS46YnY2N39hjqr6qqpWJKn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_19,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=673 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307190027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible "intel,socfpga-stratix10-hsotg" to the DWC2
implementation, because the Stratix DWC2 implementation does
not support clock gating. This compatible is used with generic
snps,dwc2.

Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index dc4988c0009c..f90094320914 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -51,6 +51,7 @@ properties:
               - amlogic,meson-g12a-usb
               - amlogic,meson-a1-usb
               - intel,socfpga-agilex-hsotg
+              - intel,socfpga-stratix10-hsotg
           - const: snps,dwc2
       - const: amcc,dwc-otg
       - const: apm,apm82181-dwc-otg
-- 
2.34.1

