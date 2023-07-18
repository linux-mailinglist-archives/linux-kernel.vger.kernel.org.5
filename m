Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A36757213
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjGRDJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGRDJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:09:37 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC38E51;
        Mon, 17 Jul 2023 20:09:36 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36I2lQRl009333;
        Tue, 18 Jul 2023 03:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=cDJIJmWyy7/i5lMyao
        bJmVe9CyXrEA/cteiDeMpud58=; b=RbwJs6qDvKhuyd8iGFMs6OLYjYLsOkP80S
        i1a7bBfYOut7MyaYx9i0mnKJKXmRAHDLSRXqy6A7o432IvS01JBclu+XMEoG2N1j
        pluw24bS1ehCa/g/Kapb8VuhWarhrESsLdK3qKV/WxCp1DsoA9PWlt85nTA1ADgM
        vhLRxrpNf6eb59tSQI/A8GqDfxJgGhCzbnvVcR+zKLyXONdhhff95hksVKZyVz3u
        9ZJX50BmcHdpVOskrXbahcFWoUe9EgIOarjfmjKvmmnn3qKVclks30yGVEuRD/5Y
        fNTK7mJqJP/e8Qx67fNUiZkC0XD8TSB9mvvGJtAZyUj80IreaiQQ==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3run8aa5hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 03:09:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwxOrSzbav2oj+43kBv4gScfJug5uBJS9bC6PERj5KytTELmkFJKWgKISrzXlw7FVTWG5BtRm3yuGIUHeaom30S80E7TMpjJ1hHhg6E0IazHSqt8rRhXjW+dbc4fm/LeFudmQ1BJd71VzRb5klnhs8zHkr3WpRXlQeEt4WItSe2ZAP84h7rUnuLzNp39VcxUmNA5/zsPc4mNnw3Ads05RS4WGq5/lD+fqA651Dilu7slTJ8mkNbk1uCLPGb8w/ao/b5NWHXB4RQri6YDk9w68P4XJVbXxlQNm24ito/Y/QaarjgiNal1cnO2ED8I96Bhtz+ToGEQwydU6FHu6f8iBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDJIJmWyy7/i5lMyaobJmVe9CyXrEA/cteiDeMpud58=;
 b=Trea98BfJ83TZvOgsefcPx/L2vsoZzciGGxjqJ7hpY2jSiTBVXkuI2yrwV/MKCfyq+XKkeBeca352dTWhwIPZxPdVlzS1QV4xQE/y8qsloak3amDrbTcC+SZ2AU8v243UAk9WJHfogY2ITYG9X/+ze3DdNFArMlVTI5WMdEooF5t1q1cR+4KKzenzHGEmpnaB5BhNrlysz88LPIfIEEssG19ocyYJRNPHs5mL3wGEbP5SnJJmOdA0EZ1bvGigGb/igAGu0iLIAdtdnxVdBXHaSmCt0jto8NXTKpcHaRfGZjsY7eO11NfH5+6m9BSYMAjBdTTRMkkxkXe1/uJVe5gGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5188.namprd11.prod.outlook.com (2603:10b6:303:95::16)
 by IA0PR11MB7212.namprd11.prod.outlook.com (2603:10b6:208:43e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 03:09:16 +0000
Received: from CO1PR11MB5188.namprd11.prod.outlook.com
 ([fe80::b4bf:44bf:5e7d:f292]) by CO1PR11MB5188.namprd11.prod.outlook.com
 ([fe80::b4bf:44bf:5e7d:f292%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 03:09:16 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     dinguyen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, meng.li@windriver.com
Subject: [PATCH] usb: dwc2: add new compatible for Intel SoCFPGA Stratix10 platform
Date:   Tue, 18 Jul 2023 11:08:51 +0800
Message-Id: <20230718030851.2014306-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::23) To CO1PR11MB5188.namprd11.prod.outlook.com
 (2603:10b6:303:95::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5188:EE_|IA0PR11MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: ce850e6c-950a-4e97-8aee-08db873c5e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWAin6V+/SO42gBsBKZjePtKCYIwfaKLhJfqCN3k4Fzw/YJ/pLYUeS3AatQWy5PilKVoOevXnZhW+1sUnwhvPRoS3Ang6gBBu9q9v9g1MZXJirEN/PRffvB9SM0tAE0kC/+Wkw0s6DGKlircO64Vivi8xq+/P1xJIX/KX6CMxz8m1QepBddOgrLwoeis2vzHwFPiu4/vBYQ99uxacJKbXt4qZkiO1GcQ6vV7wSBZIpgGZH21k99uU7j6xNgkJM8iqJSyCQwHfH8uTnfrLtuQIKxfcpJRma37JIEFRQWm276onaHNqGJPfLCldaP6Q53P63HRQa3RQrrfz3n8gfBwSmCX/u2oztDixYyxP8eZwZToItHgozDAlT19SzlduolGfnoWzmoIU34L9mitmMOfZL57Ziwt/E85kkEVy8SUmDA/5xACoKc6ZE3SWAZbTQ7/SfUO7hsTHcKXsSc8+gtPA4YPTR0+HLRyl72kgZbgAvwUrWyM65Mr4QBlpVuY42GBMhFZ792PfZru4vn1BTsVIKoMv9njAdwYaOG3JhfptiLjgVo8i1/vhS7Wswe2JJBOlWqBEI9Ev1ENLlQ26JY7ZIIEf0zJoIMXo61mOwMtHnTuybAL5fSf9fzsg3UR5ZWb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5188.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(39850400004)(136003)(451199021)(2906002)(478600001)(52116002)(6666004)(6486002)(36756003)(8676002)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(38100700002)(83380400001)(86362001)(8936002)(38350700002)(6512007)(2616005)(5660300002)(107886003)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P2vMl4Zh9oIlN0giso6BhkJmOYyTpqFDZIlzKJeCNsrksf09q0Mh2KCciMmC?=
 =?us-ascii?Q?mSxP/kDGQlEZS/fbXrxB2t4V7bc7eZQgAMjIB/h/p5UKAkZFeijJrwE7bX64?=
 =?us-ascii?Q?gppvgBSMlOk5tPowWGjhlFg0BZpbGkFu2aIajCeWMH4a9nWsf35posuWo3mi?=
 =?us-ascii?Q?k78B8VAvMBI9MqGjydJO3dWWTkdYYM7+FNKpaCTAe0sG3Cb9mrpxuCpSe8zL?=
 =?us-ascii?Q?dT4M9lFQNGncBYDgLo0+qYIlyXaA9yfQCotUwBHlWFlx1PqL01mWbJniDojY?=
 =?us-ascii?Q?vhNKSER/+kr7QecUkFfvlRMaLHSliVfEtNv1RPX6KqANSv0UZb+aDe8vqNUQ?=
 =?us-ascii?Q?UejgHUTfzboLpmV1sLHlmeyaT5vI/SMbbouzr4Uep8unDl98wHr0eeGJOqZ5?=
 =?us-ascii?Q?Li7EmtVj2KT6OExVpcX9HjtwvmbINfC18aO/PwfW6bj1rZrT7E4QMWXDn/m/?=
 =?us-ascii?Q?8E6zP9Td/5buNKMIgfXqH2qCLm19/5DtL8tiFpRSqiGUeOzwSNO19z1/Vlz+?=
 =?us-ascii?Q?PRiXr6Lo2Zpl4SJ6/2OrO0ECzr/oW59kw0a4wiu+C6Jl/dfShwpMBZlAocfO?=
 =?us-ascii?Q?LT+FjPtmkRnIzhOMGqdRFPEbwg0I4RGdP+qvdEe/zlsnH5E1ReKisyiB0uHR?=
 =?us-ascii?Q?IeEJSu48zM1l1mPoZN8vXoT6UqnK77RpJQtC2A4rUQJTKiKbauhUm5GEO/VY?=
 =?us-ascii?Q?EB3G3qJAKkTWFr6k9fAoGV7yoI1eHz+7PgymPqxyXu96EA5YqlSzY8qvIcuw?=
 =?us-ascii?Q?c65QP/y2ipsjBaf3pvSdPWALZJVhCYV4vuMrMaedTCf4wYJ8ASP0tpes4iqR?=
 =?us-ascii?Q?SiQQ/qxyTgjOm3Wcm3/Uj1b805d4P7q4fnc2XTR52QAVGDFn2W9YLYFiptWG?=
 =?us-ascii?Q?JlTWYOswoiJNwnNOChK6eymAD0cNI8nsp1nUDi8pPBUdlTSvPLFCclYkbAhZ?=
 =?us-ascii?Q?nNgzev8m/BpsHs7RAHKq7JaS1XYXqigUE2Y08Ejv6w380tFjWkS5ltyVgwOB?=
 =?us-ascii?Q?yWvabim5FRwGMuJqWSDSbEa83dS8J9NIufVAlbnRDfy1iBk5Sl3RnflpaPKp?=
 =?us-ascii?Q?3GzFPRwaD/4CWCJFi7N8DhMLNKfMDxgqt9GZ9UGAD5LCF407apagbDosXbIo?=
 =?us-ascii?Q?R01a5PdHP5T7HYyVwIb/fFXd6lKPDq0tkgEASslQF0KtfVaNhCi7UlMQ4yOt?=
 =?us-ascii?Q?gXsNH7fMQrm6yJ/54CbyoP1yFCvdpaxKH407GiAjDEMYOyTiqf57l7Pvo17j?=
 =?us-ascii?Q?qBodugSyiDoWweQAnQ4ap6djz/7+8SIRlUPONPNvwoUCMhRiTmtIY4EjbVaE?=
 =?us-ascii?Q?wMM4stmT6yn9i1nXltwelHKYU/J/osu5DiVcEg6Tr1r3IVIJgLH4aUBn0Tdb?=
 =?us-ascii?Q?vCkBnpLSzmYbSpNmciyH7T6L+Xmw0GSDl2E6RDvJsOpvXktSiPcvERuVQ36W?=
 =?us-ascii?Q?RNCTW1v6NL/YFJkMjcz0bYtFvLBuATv9RM2LX+xO8EjGUhCEJpZZ82O5DqjH?=
 =?us-ascii?Q?rHdsV4o2DD+59TTu10nknZRuOF1g0yrYKT3lPB6pDs8jU48Xmn/NdUs6E9lt?=
 =?us-ascii?Q?KTLANW/nZPcsy2V7P/QvSCFNb83Y4+upKKIeBwLo?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce850e6c-950a-4e97-8aee-08db873c5e5d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5188.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:09:15.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpVCuvNncvc9JzrZ8w/UIrEnjFVf0A3nPiqbpKDikSVKzRhNM2ORuBlkNIL0vS9zy2b3YcpzWqwHjpmp69ZtFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7212
X-Proofpoint-GUID: 2GZYKpEJWEHDErExqBxgS0rcr-Z9O9Em
X-Proofpoint-ORIG-GUID: 2GZYKpEJWEHDErExqBxgS0rcr-Z9O9Em
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=754 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307180028
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

Intel Stratix10 is very the same with Agilex platform, the DWC2 IP on
the Stratix platform also does not support clock-gating. The commit
3d8d3504d233("usb: dwc2: Add platform specific data for Intel's Agilex")
had fixed this issue. So, add the essential compatible to also use the
specific data on Stratix10 platform.

Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index ea788a920eab..b8dd5509c214 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -490,7 +490,7 @@ usbphy0: usbphy@0 {
 		};
 
 		usb0: usb@ffb00000 {
-			compatible = "snps,dwc2";
+			compatible = "intel,socfpga-agilex-hsotg", "snps,dwc2";
 			reg = <0xffb00000 0x40000>;
 			interrupts = <0 93 4>;
 			phys = <&usbphy0>;
@@ -504,7 +504,7 @@ usb0: usb@ffb00000 {
 		};
 
 		usb1: usb@ffb40000 {
-			compatible = "snps,dwc2";
+			compatible = "intel,socfpga-agilex-hsotg", "snps,dwc2";
 			reg = <0xffb40000 0x40000>;
 			interrupts = <0 94 4>;
 			phys = <&usbphy0>;
-- 
2.34.1

