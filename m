Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED7B755EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjGQIvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQIvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:51:41 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2044E1AE;
        Mon, 17 Jul 2023 01:51:40 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H7Qk79008807;
        Mon, 17 Jul 2023 01:51:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=FYUuDCk44+wFESINSO
        aJvpQBbLlTucOjxg30Pss9f08=; b=G20NmOiSUSwSYX2mlucZT85pV9oOKFZG8S
        1SbJM+AA1eF9ykXm6sjzwxlqgdWTIWfFgu1Kj2nA6EWnBptjawqTCwzdgpFTM04g
        RlocZ0mwiew+5uPRIUb4Q6lJJ84BPNrf261MmMbC5dZGlL5OazD+D2DbW/4FchQn
        fsNPEpbScQTyYrvdLVfyMyDjw7ENwZNTjRKtd8/bsHShk4Xc8CIKGgFC6rxjNnhQ
        1mDduBKss7ROR/9me+9V4FfwCMyTDA1d6qpx8VKti29VgKb5xpafvhsnDjGwuzpC
        93wAQE3RVdBppNDTUNveKlPRfHSa0k6sKLS940pbgyaJBpatlOWQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rupqy9d03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 01:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BF++rBn2k11u39JBKay0/UJtL02oeTvAnMpu1ME1LCydaXnP92kHFTNNgl0kXF8m22F/2nHguEaL1PdNCrF4oZpRG6W0t1HXM68fpTqxWk1GQDVymJXzeY6LzcMhRZUPMrdJncdwgJ2QMqDAQIEiQEKBP0H92NXBO8F/712kh9AUvTXIuVq+Fk2+Png89cOPZHKn45a4uM0uB6DRa1OXkyw7wd51hHGEtdG6ai68/knjesWwhWwK4Fz7QNv7U0jjOoh36v9R/yCswdV0FG9EWEsS5oxcwN5IFPlG7wKbNKgIQPkwfYtkovsqgSfYUAu83n/GO5+RcmMmtQf6EdxWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYUuDCk44+wFESINSOaJvpQBbLlTucOjxg30Pss9f08=;
 b=Nq3d/UwCIOleYTxglhzYTCP1Ffd/4rPSnaTSZMRAJjKFiWI9XHA4cPYh2mA5WQ86JZvywE8qdpTd1jq6o9kNCZQbfeOZVLB6LsyqiPj93imLhOybXcKqyGFfoK/qdiModq3bB6+SlwC+QJpcjmwDUJRC25+RHzRq7kVhzcLBVjXuCynWyVrZbuWEDD47JwiJOsS3seTOJKmSRq9zRVaaEkQpDtNUJ3rAmY4ukL1z+pR1nop7swH3cEqupzG6YjI2hNjcnzBvHdkw5cUDRrNypFT7QiF7Qoi6Jat+jsy0vZUm7KE1V20gSlzreyDFmHl2lHfO78dLfSXy80HflV817w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by IA1PR11MB7776.namprd11.prod.outlook.com (2603:10b6:208:3f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 08:51:18 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::c007:45a0:16f2:8b69]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::c007:45a0:16f2:8b69%6]) with mapi id 15.20.6565.028; Mon, 17 Jul 2023
 08:51:18 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dinguyen@kernel.org, hminas@synopsys.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, meng.li@windriver.com
Subject: [PATCH] usb: dwc2: combine platform specific data for Intel Agilex and Stratix10
Date:   Mon, 17 Jul 2023 16:50:53 +0800
Message-Id: <20230717085053.1075077-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5191:EE_|IA1PR11MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 27370bdb-1b5b-4ca8-bad7-08db86a2fc48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJ9hwhIobxFvulhcVeT3ibAbI6VR+4Cd8XXQNyZrcslVT1rsK5l3BuekppT1cO8crhk8Qh+UFz/KPQfzBcWXSLAW4ZB1HhLdHNtY6KCL2TUen4V8OhN/DHzoDs65rVJ1Q6nETUu33UYvZEQzDlmDqmIsO0WA0pRr8yTfisBuLEulD2HtJkLlbmyq2JqF02jiw95ZNKZUySH/m3tQ7LelBx+MuqR4K20RQJGiIbirXPYzj+/a+a+oRSY/nARjjwKLuCKorEuPi5ganOjQThzKVwNDBDA184DBljS2FmWsI0GzSKI0ZhL6j39s3lvnRMGMFolCeWDKR7mugYIZAoir9T/a6Lac/ADsoqVc2K97BaIrx6Mem85cLUERQHstL2JGRe+q7gEPf9H0jDwmcLz7K2YjQzyjrudxBZ0rsCnNdSoKdFqCOH4+ZvYngv0H+2LS5XkjJAyUaSzMD/lcDkgS4GdXKEPBBAlrskW2eKOV0xXFRgP4C5dwHpmS29OOj0KRa2Op/VJepY6EjuAvi6aMAfKjW9aaqXYgsePEqxjHqODvzzeQojI/uNKxlQm1vSm1pYuRK1R98jdbuLEnlXGDxxcL85wNdNPtzKYgTkXB95GgG4sXsmGjUMcLHqp0PpI/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39850400004)(376002)(136003)(451199021)(107886003)(6506007)(83380400001)(1076003)(38100700002)(186003)(26005)(38350700002)(478600001)(6666004)(6486002)(8676002)(41300700001)(66476007)(2906002)(8936002)(66556008)(66946007)(316002)(4326008)(5660300002)(36756003)(6512007)(2616005)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hQodWfMlFMvIXQNodae0h5KvPeiLoHekXGhZllI4FgjjAfwjKAxZ3GWKW3LX?=
 =?us-ascii?Q?hym7lnncsW4zOX4LVGQw8zOrWUVCLBJ4+QJ2FaAPp1PxMhnUDlSqi1GvHoTh?=
 =?us-ascii?Q?JB6Q5a8tUdz5G8ngDITtYdbZFfZaDZmcWXbBv97R039J/lJtbMRJ4iP6tQd0?=
 =?us-ascii?Q?IrciJMJInpVtUp6JUi4yUxr1ysh5h734P73X6DD1+wD+oqX4Qsm+XqbWqjZK?=
 =?us-ascii?Q?NqJYCFNgCF8DQVv8REacHYje6uvd8euhHqwAIS5x1MRnAWP8RedWqYP6yW2W?=
 =?us-ascii?Q?vBjFg7k80C4HSbxrsi0bkpotUnwCsJbqYW36DsS5vnvonjtEQgotHs6bX3RK?=
 =?us-ascii?Q?l1c2N9rQfDboAQEOGumRGy55e3hKKOyfAjl3oS/Z78ufcKf2UaAmZqVjpPTW?=
 =?us-ascii?Q?PgLiXR3d7FBsBDwr7fe7Wiib0aKNUsmfgMnydRsOKyMhbHkHSdqaAIaJTvpm?=
 =?us-ascii?Q?RxKgloQcUwL9FHSpk6c7m50VU0Q0A3HKN7oFN0fkaoHnTke09qx2trkGTa4q?=
 =?us-ascii?Q?/Qc5RnvhUbnxGsmhEkYEdO/H1+1AGDOiyZ9KN8GXAEH3YKOAG1mZ1UdfajrT?=
 =?us-ascii?Q?43ddq0R6KraZSlhdqImxLNatOKYN2EW9Nuw8jrZoGIv3ALZRW1obhhh3zxam?=
 =?us-ascii?Q?1x+sMjbwHhnFJYKCPTOHpJC75MYxXs8bK12PIS2XI6pshVY6LC77lFyOCu/V?=
 =?us-ascii?Q?aIAST6zTTPOvuhpFcr021AKrzL4mhF8Gc9ZpgqTno/j6/P72eLTncq17x2aS?=
 =?us-ascii?Q?dIM9RIOQHeyGsVAw9vdqXqNqFBVdQEhLYoNZm8JwXR3Vo8kIVPS06GDakGr4?=
 =?us-ascii?Q?biloX4SpGcks4EzxweNEzFtj1V2grqjWYR/kv9YYMkRuM9URE4+Dt6QKUgjO?=
 =?us-ascii?Q?aQhTpjGleuILms2R/871wxXOBYkkbqE5W6jnqEGZLLFJOzmBV2R6xrCIKo0b?=
 =?us-ascii?Q?Xpvli0qhe9GqDtINMyUgUUMh7K2RP1alnUDnQ8EBIQNimyF29Bz9iPC4zW+h?=
 =?us-ascii?Q?X0wG1KTfRI4t/qsef+SrqjVhi/U8H6zWOC2oO3WGEas1OGGUG3W6JNTRu7iW?=
 =?us-ascii?Q?DZ/X3LGCy6kXNRKOv9sfscBP1GZB8uYY2EJ/nonrqUrd+IcoNwW+KqmEgKLV?=
 =?us-ascii?Q?COCX9pNbJWGCG8jrd+Xar0dNtSO+XQtNxZlVdKblLsEQ6bOrdcdwDjsm3HbN?=
 =?us-ascii?Q?dMqTVbUnaUDWRQZrXyrf5bVXW9LufieVb4FoZpcxb0IBkaNMO4J1K2xox0Wv?=
 =?us-ascii?Q?jJgyKK+FKB/Sbm5lnQrXHdNECe2DYEhRAplglzJCNz7GsZqt37IGMT0otudl?=
 =?us-ascii?Q?vsykyrZRTrubNZBBCz7p9dGGeXRK8IQduQehnTlE+OM9RvLFE8VRIp2DKrhB?=
 =?us-ascii?Q?l2u44Ow3K5K7tbSTIwmJJpxG+6dJ1co98kEsQwyug02zSN/mAWzh0fiYYjsb?=
 =?us-ascii?Q?sLcaPLgcu7VA75bGhPFpJA/5fXbGMc3emvPP6nreOe6GJSRSnJ56zNtwL7X4?=
 =?us-ascii?Q?Q7YADAHnoZR2HlNYp5TWGUjNVt6YHok7qo2j6UjwgzjgYVjtQgYh9b7ZLdcd?=
 =?us-ascii?Q?cCsMrbugMBL3U2lHHcKH1HEyZ5VIBi+1PAKTFthd?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27370bdb-1b5b-4ca8-bad7-08db86a2fc48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 08:51:18.1097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIBBBb0XQiCNI2/lh7auJrqvvgczzYQMGtC8aemE8TPyVIo9CV9NbV+xl3RmxKQi2tfT4iMcU79X1kRXmzDumQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7776
X-Proofpoint-GUID: 02HRNtudGl8yEz-wlzUQV5GU1S69oegR
X-Proofpoint-ORIG-GUID: 02HRNtudGl8yEz-wlzUQV5GU1S69oegR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_07,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 bulkscore=0 mlxlogscore=978
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307170080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Stratix10 is very the same with Agilex platform, the DWC2 IP on
the Stratix platform also does not support clock-gating. So, based on
commit 3d8d3504d233("usb: dwc2: Add platform specific data for
Intel's Agilex"), combine platform specific data for Intel Agilex and
Stratix10 together. In additional, in order to avoid breaking the old
device tree, keep compatible string "intel,socfpga-agilex-hsotg" unchanged.

Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml   | 2 ++
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 4 ++--
 drivers/usb/dwc2/params.c                         | 6 ++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index dc4988c0009c..c98ca98d5033 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -51,6 +51,7 @@ properties:
               - amlogic,meson-gxbb-usb
               - amlogic,meson-g12a-usb
               - intel,socfpga-agilex-hsotg
+              - intel,socfpga-hsotg
           - const: snps,dwc2
       - const: amcc,dwc-otg
       - const: apm,apm82181-dwc-otg
@@ -64,6 +65,7 @@ properties:
           - const: snps,dwc2
       - const: samsung,s3c6400-hsotg
       - const: intel,socfpga-agilex-hsotg
+      - const: intel,socfpga-hsotg
 
   reg:
     maxItems: 1
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index ea788a920eab..c5a51636f657 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -490,7 +490,7 @@ usbphy0: usbphy@0 {
 		};
 
 		usb0: usb@ffb00000 {
-			compatible = "snps,dwc2";
+			compatible = "intel,socfpga-hsotg", "snps,dwc2";
 			reg = <0xffb00000 0x40000>;
 			interrupts = <0 93 4>;
 			phys = <&usbphy0>;
@@ -504,7 +504,7 @@ usb0: usb@ffb00000 {
 		};
 
 		usb1: usb@ffb40000 {
-			compatible = "snps,dwc2";
+			compatible = "intel,socfpga-hsotg", "snps,dwc2";
 			reg = <0xffb40000 0x40000>;
 			interrupts = <0 94 4>;
 			phys = <&usbphy0>;
diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 8eab5f38b110..6bb27a24e9e1 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -93,7 +93,7 @@ static void dwc2_set_s3c6400_params(struct dwc2_hsotg *hsotg)
 	p->phy_utmi_width = 8;
 }
 
-static void dwc2_set_socfpga_agilex_params(struct dwc2_hsotg *hsotg)
+static void dwc2_set_socfpga_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
 
@@ -266,7 +266,9 @@ const struct of_device_id dwc2_of_match_table[] = {
 	{ .compatible = "st,stm32mp15-hsotg",
 	  .data = dwc2_set_stm32mp15_hsotg_params },
 	{ .compatible = "intel,socfpga-agilex-hsotg",
-	  .data = dwc2_set_socfpga_agilex_params },
+	  .data = dwc2_set_socfpga_params },
+	{ .compatible = "intel,socfpga-hsotg",
+	  .data = dwc2_set_socfpga_params },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dwc2_of_match_table);
-- 
2.34.1

