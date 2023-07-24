Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC3B75FC37
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGXQcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjGXQcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:32:41 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBDC1990;
        Mon, 24 Jul 2023 09:32:21 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O9Mjxv006879;
        Mon, 24 Jul 2023 08:00:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=uemTWM5GCBchfaoKmKvtPOCdYY6GmDasBY9OTXq16ds=;
 b=QRfc4/P6lJzY74xpRiGnhfkMYuJ3frnbMXuVgL0cYq4DY9fGYYX2B6OYrHNGu/ACuLJv
 zr43/nxThhF2OyYVZ+hPGcruJJKbK7pKqwW1HdGkyHiweKGqR/nwfJa+QbhSmVuA6/Ti
 He56YElS8f3cvgyd25sHIHQJAjXaUrKG4oJkPyqOPOB+jhuUcyq5lZfhQUYz6OH+0n93
 +I9IXJHq7W+cHkm1lRu9i4x2AofF8t7TPJbH9nUukgVolAMLIamk08DiJy/RpSkGdW6b
 R5rFfFfGk2bNuxACt0JoTe4vJhNbqiKcCMtDDyMoTBX886xv0W6hCxLBJkB7/FDWCcpw ng== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3s0apxe0ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 08:00:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXExxxUEynaxWXdSEda37Za8P5ZmD2OsRPyOwIHyJ1hHOxzWmd3vUGNqnqT5VtwUT7O5kKF+S1wWBAF+2DjhlNDJZ2Tzadq9is8g8Clqsm8rWlWgrfTjgXeNRflGfBlClhFKeBUV9nFBFOenf1mOBt+WQauCFrq59Kg+ruLiFwMbvww7cYsDQwDb+njkPMtsqMtd6frmk5ze8winj4HhYp+rVvK05Zl4XzH/MSMiyNkiWClFvT7Z+kDcbNuNEqMmiV2ByHpWkx4rS/RL10h8821CvZgX2MRKDeoIvV791KqxJu+bQiqOlM/zIywQ22QkQJ6Waa6dMwR3+00Iau9gSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uemTWM5GCBchfaoKmKvtPOCdYY6GmDasBY9OTXq16ds=;
 b=RlQQ4aoRPqLaYPhNwUrP4IXsLBXUoCrxrQs9JcwDRLGU+GeCB0b6kRc+XCZ9fCsD+vpT6GNfbPc8qEhnz+v5VLc7EFoufrDT9TWLR2RvhxQwYtAkMK78eBxXtxPcr564Vsv5Onr6qE/OfSy2QCj7PD0fRIYoMj+G5Ic7YUo2HpFFFCZ9YuJNAy6XWJJ4RPWMNFBxrKjNqGpmKNoBsCwgVPoYN5v/ps07k78vZ3Pk96SUU+BJWnWyNht6QQ4HW9BG941lDKpKLmd7Mi2wsetQenDDmF4mgLrs+38T83mD28BsVp5vx2dT/MtvW0gQT9lrFOopYVlxgy8WIS8sPt3tYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uemTWM5GCBchfaoKmKvtPOCdYY6GmDasBY9OTXq16ds=;
 b=IY/YbfXmUAdD2qEf/apyW6dKKDmFPj6sa7vX040W0ptqcrRbdKFrFnoEAEc3LwtHlxM1BuJP32xxwAfi+4/bNfCafS8aJAQzHE5x89H7hoIzzie6A5nGmUCNjIJ6yp5cuKjn8BQ+XOdB1dSu3RJNGsHJzskks5PlxZ9rGu3gQUo=
Received: from MW4PR04CA0093.namprd04.prod.outlook.com (2603:10b6:303:83::8)
 by MW4PR07MB8393.namprd07.prod.outlook.com (2603:10b6:303:ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Mon, 24 Jul
 2023 15:00:11 +0000
Received: from MW2NAM12FT068.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::e9) by MW4PR04CA0093.outlook.office365.com
 (2603:10b6:303:83::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 15:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com; pr=C
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT068.mail.protection.outlook.com (10.13.181.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 15:00:10 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 36OF06KM167842
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 24 Jul 2023 08:00:07 -0700
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 24 Jul 2023 17:00:05 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Mon, 24 Jul 2023 17:00:05 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 36OF0530005725;
        Mon, 24 Jul 2023 17:00:05 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 36OF05Tm005724;
        Mon, 24 Jul 2023 17:00:05 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH 1/5] dt-bindings: phy: cadence-torrent: Add second optional input reference clock
Date:   Mon, 24 Jul 2023 16:59:58 +0200
Message-ID: <20230724150002.5645-2-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230724150002.5645-1-sjakhade@cadence.com>
References: <20230724150002.5645-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT068:EE_|MW4PR07MB8393:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e014f2-11c6-4d5e-235b-08db8c56ad3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43HpGOfFiazhLhIJ/LOTNz62y4C3H5v94obnEYMwXTBo6FH37h5P2DmXjqTRd/OYvkC5SR9C/Cn+rSWpvRu6hfj2u1sNruDyAKzeBuF/qa1Vweey3XTQoOSSITk4nvpqjYNtFvq/D+3Sc8jFTf3WoGTtrLH69eagag0uROzmnTHpOKKMK5w2eHNBC1JEbrtmI/ElJA5yQQiaiz9KXPJH6kJVvmDcAhIytUqQTmm/WUKxn5pNEw1wCrerb9YTRi9UaC/u1m2KbJBeouEifC6puYHt9DZGGWBVZjJ/5MJUgNjJqRbLqG1ZQ5ih28nRDBOwelpjJLIOb51/fl0cT82Oofwv/Ka8WTrg/eDL4Y+ClD9WOAh63EM4gF7gSB0LMxf/ktbt1NqynUEonMIGDl18gcOSO062hrxQHG1gzoCiGM//dwAilCZzkeuU7ysvBd9EcmeLE/9fYWCeejhY8l77hkJPZOEswkGpmACC6aY+Hbh55rQEe0tqxzhk114RrkLk5IqPlEv+w3BGTYlYdSMzOVFGdffmp9Qx9Kivw4xids2yHNFjF7caOoXN6L3BsaT60QrjG3N2CYw++PIEZI+5T/YkRdLgSdIOfhjLZdFMIiIrwCQZs1VfhJMtNVNVuYnq9mBdUaYB8+l6GYWAfsEouqaJw4D/q2WyN/9mXFMgafRuOK2keDKdTQkhVqIWj/kTtbjRCL+Yazvx/jgXESMTga/+s4ErTLGMmQO4oFmpw7P+vriz3lxBgwcILpmbL032wi0cBGmeB6FxTYKJPSZGMB8qT23TXw9QSTifTlojPnQ=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(36092001)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(110136005)(54906003)(40480700001)(6666004)(81166007)(356005)(40460700003)(82740400003)(478600001)(7416002)(8676002)(8936002)(5660300002)(2906002)(36756003)(86362001)(4326008)(70206006)(70586007)(41300700001)(42186006)(316002)(186003)(336012)(26005)(1076003)(83380400001)(47076005)(2616005)(36860700001)(426003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 15:00:10.3126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e014f2-11c6-4d5e-235b-08db8c56ad3c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT068.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB8393
X-Proofpoint-GUID: 9vTB-FaOuinohlPhW6EWZoZ5lvRsXwRY
X-Proofpoint-ORIG-GUID: 9vTB-FaOuinohlPhW6EWZoZ5lvRsXwRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_11,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307240133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Torrent(SD0801) PHY supports two input reference clocks. Update bindings
to support dual reference clock multilink configurations.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 .../bindings/phy/phy-cadence-torrent.yaml     | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index dfb31314face..ddb86ee0cebf 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -33,16 +33,25 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
     description:
-      PHY reference clock for 1 item. Must contain an entry in clock-names.
-      Optional Parent to enable output reference clock.
+      PHY input reference clocks (refclk & refclk1).
+      Optional Parent to enable output reference clock (phy_en_refclk).
 
   clock-names:
-    minItems: 1
-    items:
-      - const: refclk
-      - const: phy_en_refclk
+    oneOf:
+      - items:
+          - const: refclk
+      - items:
+          - const: refclk
+          - const: phy_en_refclk
+      - items:
+          - const: refclk
+          - const: refclk1
+      - items:
+          - const: refclk
+          - const: refclk1
+          - const: phy_en_refclk
 
   reg:
     minItems: 1
-- 
2.34.1

