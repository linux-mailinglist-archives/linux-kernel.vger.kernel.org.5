Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA633758B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGSCz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSCz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:55:56 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260851BCF;
        Tue, 18 Jul 2023 19:55:53 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36J2rh0a000831;
        Wed, 19 Jul 2023 02:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=1Ez3OLL5p9xiaqudM5iGbm0H2UPCjbrhyOxt1Kkazuo=; b=
        nFREIl9CCoFKR2U9zKC+slnZ/HAQ30YlY0ANsp7EO13Nmw+DjrjVLLsaEftINoec
        7s+B8LTMerC1KpRBP/1drpMHWovdN0No1rwjFNKp0u0CzqpbZFe1h7aPrAFgNuzb
        0WrefS85czgagg6o37mjPTABfyS6uHggbecWwaRjo6JnCVZWc2qqgig0EfHsIjkx
        cdC3nSB/2l8h1jf+VFy0vOfL+oajX7hNA1VuHKfA01HG3j9TAbyiaN0OkYp1yOUO
        BF59GxPPf5qHyWy1iM+3jvX5kOoZ+G4Z6KN6opGktET4szHpiXF2H0szGlT0gMFl
        NcddYwhzT9BHyv9CCytSWQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3run9ju8mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 02:55:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3m6bZ9o36Pm1sWQ29b2i8AJzdf0a6elXEgoI8mUOivbFHZ9TMYodp6p/N4vkOvPR4lTZ9JotDa/ijMEjWfoq9DtX7+IaYMjgg/mGeiROUQhaPoJMKLr+VTIg0m9lwmsqPEzgx23WLeQ7LyyROQYRwgQYfeRgThQOBAIXcaxKPPhBRWvUOIY/PyE8dJ9VUi6OTt6LgUnN7KZcwbqXnlhHAEQ1uuPtyC7LyzXgPOMZz516bcujnGs2lb5IMsv5d1z5XDL4j5iOfH9q7WJyyxjAQTOy5dIDJnLW1L4ybqEKbQ/ylDYk+8/TXgsJWF4lhbk9yVHB0zkSCooArcPHvbgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ez3OLL5p9xiaqudM5iGbm0H2UPCjbrhyOxt1Kkazuo=;
 b=A1XdnSkJoQ58pMIZOD0DqE/RSXY3aT31mDGBX9NjIHgcjbOZXJRUTyKjB4BKcbJ6kNU8mXW9Pcgfl9SHZ02MlgSYmAjS6uzEQ7+olGzzHO/cXh3anL74sCbKvIh4LL585ZzXSDTtE8xhQKXlw8VLzQEWNruZoz5U76TVJf3tQlR2fsIE4r87VSO7YKa6DnQx8y2NMsdv0vOp2W13HpwcDprT34tNHhleTqwpmPWrbwHlZzh3qA0kN7//4dNvuPCPLKQahc8Jbgqo34h3k61oGEXvaZfZgxq1RwPW4RTiQIij6G9o7nCX4KJGg3C/VqEXaZUl5X9mIa4JVikC7FEJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by IA1PR11MB7728.namprd11.prod.outlook.com (2603:10b6:208:3f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 02:55:33 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9%3]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 02:55:33 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dinguyen@kernel.org, hminas@synopsys.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, meng.li@windriver.com
Subject: [PATCH 1/3] usb: dwc2: Add platform specific data for Intel Stratix10 platform
Date:   Wed, 19 Jul 2023 10:55:07 +0800
Message-Id: <20230719025509.3007986-2-Meng.Li@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: e508dfb3-5610-4220-d872-08db88039ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMmEpxjfWRr1z3SKoI8+FMqEvG/x5mGvIpw7c21NsovAbcJxLxOg4f20K4eQeOImvUVZLJp9CYSNZC8C3Xq4v2V37xwGfoQ7CEFF06qsMpy6Gqbz+TmaccmB5iNv0hNx5a/47pWyMuvFJmeeG89+0lroHLOx3Kcc4ryGVz5gpoBN4SIUT3nKKiU3tbF8ntICezf3daDjy0ghXFoCRVCgvNzaiMHSw8jC8OJJ/sFAbqMkdPOE+r120zT6FqPyrKeMnRHlbsRTPhSL+V+UUDTuQ6b/3EfBuxasVBPkpvDDEEdBjuLGmlZ+F560JNmXUvCgOyeXIn5sJqy4rh2quJgDWoF7hgYkLTRqVwV/4K9xGQa5nXlOm0s8yF50dSTFsC4Z0ljwp5qgyJCTfW2UEjmMIK5l674NxDjEAR/ssV5rcj5HIcXxJG231N7TjgCvnPVXPpLG144PxCqWs/lckb5k6iL3XiNr+JpSLM1f2TmZ/KidNDJJXe8YI/ES2eRblIcbnMhN4t5AxshjrfUCkSrSDxDkAfA9XirxLPjkrKAjaAyJYOSfXn5juKh2bZnhsbeSVO+QkN5KTJzvVTp/KwNDjTudL/nVF22mgSLsSFs8K8YJDNvLpyPcKYT4MMU+oixR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(136003)(39850400004)(451199021)(478600001)(52116002)(6666004)(6486002)(2616005)(83380400001)(86362001)(36756003)(4744005)(2906002)(1076003)(186003)(6506007)(107886003)(26005)(6512007)(38350700002)(38100700002)(316002)(4326008)(41300700001)(66476007)(66946007)(5660300002)(66556008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sNzTzYIHSNpZWSO/DZDTmCEoFCMTJLh/N5gpiHgkYZ8fk7HkQBDZvf9Ii89L?=
 =?us-ascii?Q?nB+yS2dk+JIp9jymRyitHffp9JnlEkIFHEnuzbZ9ckPAGz9s0gb6V0Z/Sdu+?=
 =?us-ascii?Q?VQ8ABmojtQrINhBwoTAcF21jJjSGdEe5wsO9+O+grjUeP/L3g48+ybOMHm26?=
 =?us-ascii?Q?jxbER6UxlmtKKvLVrLkLckh9OWUdb03kwm5gAoEdUYDpvvFvO22SPIuKO6fF?=
 =?us-ascii?Q?4ZgLbAEQm2KFgQ9oUkfGJWATL5ze3+SgsvybTao7KraSHHcmEMtcYQDJKNzD?=
 =?us-ascii?Q?12gtqcP+M/HJ57dbvJAuBq/bcRwd9ZxxkPIDGlXZ6qo9bq8qtWEcHFDpwjnk?=
 =?us-ascii?Q?tQcHXOsj03iR3qBkHJgvk23xQVip0fV45EBuMlIf0ZOwJU1bTfj4CKbDd1Am?=
 =?us-ascii?Q?7gUR6iYzuwwVG+bAq7gkmNC7eZAtmOcy1JCsEiklM7EcPqCuxMCZ8JVHTa8y?=
 =?us-ascii?Q?+3p1i0NxWffy1SthgNqR/0q9sRLwcD5vF4pE4wKEXUzH6gZJCsCKxZAQIGcL?=
 =?us-ascii?Q?NenKzu8LexLBNMkLH8zCw8A1ex0CD1jKJ52Wu6Lh8P0UjSaApQZ01kPaU9jX?=
 =?us-ascii?Q?hnLkTyuGoN/d57UjVwq4bYWOLg4D8hG6v9e5uOGYJFnv4mhjVH3sn0VWYs7T?=
 =?us-ascii?Q?nwJ87NsCRdiqXxFiBrtbKHHyth7U1HdexawM9m/NGjBv8RBJr7M3dEqLE3JC?=
 =?us-ascii?Q?2MHAVpJiVupu0bR3r2ipolNflVGxWI0r9sKwv1J1R6+4KbqguBAjUf+2NG1u?=
 =?us-ascii?Q?VuvVVcAouy5xXSERgnpWMmzclJTHC6lSYMvuRQQpPrT1CrOhSF6emQhBt5m+?=
 =?us-ascii?Q?RhV1JvNS93gapAd3QPIgks3OoUbD2TxGM/r2lEiQL3VyjtGz46bNT51ACOh1?=
 =?us-ascii?Q?DvsjWDFR+36BYhTR12gQq9rGBZqybiqsclcGUIdgTCtcV0tcCAJaAw7yc9Qa?=
 =?us-ascii?Q?Ci7HIPGgwpYajmzSgVEXLDjEDQsH4lUYJrTStlJHIBleqRVNO24KfXCRR6Ai?=
 =?us-ascii?Q?G/ZIsZ8AISj80hTnSZuf0geWOuYrEVZnK/3c04gwkQ1pjZQ9CS3qvJ9DsAXX?=
 =?us-ascii?Q?lkrPefxgDZ2W5qbTdDGvGPczP/0NZYfGWWLfRKnOJ9gVQVQtfE0SNI+3BYc9?=
 =?us-ascii?Q?iUANoIK6hXcqM92A249RjuE0lZmXNBPQsycY02fSRImwlfKbyRNbyL+iZEhC?=
 =?us-ascii?Q?eKOL738mOp6etJI0jymVfss915t19iM5qTezAgtYr+NKAYE9USEwEiPFnsCG?=
 =?us-ascii?Q?Cub3Qrroya7HwZ9G/+9V0xncoc7QbrxmrS9V5ktQiBB58wh4N/aKtEGq9Gex?=
 =?us-ascii?Q?yDoKS8pQR91zKYT6qqKzxbQX2xPdA/xcZLplfC5QlRaWX5wFprW7WGSh4Vmq?=
 =?us-ascii?Q?89Yu4T5A8K7hQEPK+zlkcQseAWtRMKCyRdR227MuNKw/keiUTDds5YbrYsIm?=
 =?us-ascii?Q?OQ9ZO93BSxlBmUMPpxe662VnHWyIxCXo9v8ykDMViD2Ge95QTUhBjnmfcwf+?=
 =?us-ascii?Q?lK1oFLkqTuwNRFRGMR1qDViC8/CQP5e4Ow5QQr7H8rxLCKB/G7FlvNQam1v2?=
 =?us-ascii?Q?ZVAxBW4IRalbMQ0HlxBL1+Xmf4zD3Y7HQr2LDf5x?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e508dfb3-5610-4220-d872-08db88039ede
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 02:55:33.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fw05B8QcxNYWjfsyw+E0V2Z1CpsgK2VSRQ+aKuyeJtBfQi1VuU3ScBNQgMga2j6ey9xj4GGddK5t6VemXx60WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7728
X-Proofpoint-GUID: -of1UU42KUrytjBq0yWTITm2PQR7LRwC
X-Proofpoint-ORIG-GUID: -of1UU42KUrytjBq0yWTITm2PQR7LRwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_19,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=803 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
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

Intel Stratix10 is very the same with Agilex platform, the DWC2 IP on
the Stratix platform also does not support clock-gating. So, refer to
commit 3d8d3504d233("usb: dwc2: Add platform specific data for
Intel's Agilex"), add platform specific data for Intel Stratix10 platform.

Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/usb/dwc2/params.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 8eab5f38b110..3d085ae1ecd8 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -267,6 +267,8 @@ const struct of_device_id dwc2_of_match_table[] = {
 	  .data = dwc2_set_stm32mp15_hsotg_params },
 	{ .compatible = "intel,socfpga-agilex-hsotg",
 	  .data = dwc2_set_socfpga_agilex_params },
+	{ .compatible = "intel,socfpga-stratix10-hsotg",
+	  .data = dwc2_set_socfpga_agilex_params },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dwc2_of_match_table);
-- 
2.34.1

