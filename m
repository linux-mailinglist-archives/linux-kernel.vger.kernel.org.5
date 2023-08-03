Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E130E76E136
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjHCHYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjHCHYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:24:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1401F0;
        Thu,  3 Aug 2023 00:24:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li5KFHE+amYZwxAoWUSzKaHBDC2SEeQS5qOZZVDbEeDDe+eJ+iv3U9hrjpA0nRyW6nI5r1rD1iPFTdoxC/AZfbiD4EqEEPqq6HUYd4ewsZ3djsk6yuGaiBWfsJMvYuCMEXq5F0HkNHSRQL+qrbuznY9BmfrJHDZTTog6fRrCswzLwGTf+vsrvj6Yr6ly2rxVtcahZvpJyKYKpscQ9MjR7MpnKTJWVGdu2v3bPbjRaoF/rK5nlo5QaYxU91hMjL8YuFN10HlCYYzNOrgyu2kSHZ7Cp33w+kxOA1DtSAU5t5bNJ9KOBDXdY/NMhNdc842upvQ7OOMawXKomttrNiVR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/o00EMYOWqaADv96pY6PxagvOt13i7BauPUmqKpHDM=;
 b=XR4sCIYKWhPboabkDYrsZ98859yZcxxklE44aY8odLcmZdNl/rSjlqMu1Wcgf+4SGIwQHbHYk51YsySyrPtN1u9f17aUu9ty5NL0qLOgEdulg9jA57GMbshkE5/hBp3llanCGSRFa4nny+hQSY+TxGx+Plnuoo7me2ZtjjArWad1axgthaTXn/uWoZ0/3bKI9B+kOvYvOqb/8F5qVwjoyLWccxpZTD+IhSU1DihYUJhK5QxSYrYsMPLsNQAEH/1/AKT6hn2SESN3lS+2txNFR31uCNqCpqAvDsSmzO67aIuOsmSyYEI+H74ldK5LLeowzK0bOouwkCouM7R402BSWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/o00EMYOWqaADv96pY6PxagvOt13i7BauPUmqKpHDM=;
 b=BYHORa8OoGqBE+0IyK17gCoq7YBASD17dBBew6ULhfmpuKl8ngSEsRVXAQUS9JZza8pNzOYKjv2WpXD7s7wVQAVQ4e131yl9pVDbG1ztZqFETVoAqI6p/sAK6g+w2PZp1sUWSPw/GBdoOyFbYWvmB17ju+YqmxRIEJSyVGKOsrc=
Received: from SJ0PR03CA0164.namprd03.prod.outlook.com (2603:10b6:a03:338::19)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 07:24:30 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::10) by SJ0PR03CA0164.outlook.office365.com
 (2603:10b6:a03:338::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 3 Aug 2023 07:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 07:24:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 02:24:28 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: spi: spi-cadence: Describe power-domains property
Date:   Thu, 3 Aug 2023 09:24:24 +0200
Message-ID: <987430ee905fd299fe962663d94f848b341c87df.1691047461.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=712; i=michal.simek@amd.com; h=from:subject:message-id; bh=eWcfB2POQJE1YDVVhuN3GtfiXdAIJr2egVku/XMPK94=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTTYWrSE9f++MSz4UT0AS1Olnke0xweev710J0Q8bHUc 9GSuffWdcSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJMHQyzHdf3aVgx7pN4CGH 2iKHi1IaUuxKbgzzY2qj9tZs8xOcdKfqRtnhFbVa553FAQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9276de-80b4-4530-32c6-08db93f2ad76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zl0N5r47xKyFWkC/7YCkKLGzno4Uc8mMdsvMmxqVzFS6RAOo1UbSKT5v+7Qe5OrXDFlGQKWY57x75pyNyDfrP+9E39+n9nmhgdnMq0+tLKBr+3xcX8eLUKDBvu3up4iwvVatLeZ8EFB/ZWkU8zUjGGMCeSg9nQjZ/zprA/YcbZlI2aSF3S8XKkU9q3tSOUL6sM5IQUbyrSENPRMjqWJTR5FrXdI2mogesYKN5IFc7mhIe2JCAc5JdafvqWloPmP2hJiiqB+blbVJPnTUfeZ5KZ1zeHrdyV2VFYBvrWyAOIncDAidtfBBtVgM+2tHzoMs2K5DEOi+3MmhmGGBa++WtiEiScoj2OFVoVX4PJr/arV+3AMunCxDsfZL9Z/lTlJSAWdzm/dtD8C87XhPXzBVFfkOL8JqolfuwBvcQbCsmSBryh3weMeffSafKS3ANow/Kex1nPjIFmjOPN6WA4drHHtksZot5MElPt5NUkwuw0Hbse5X74eJgvcNd2qr3C43iERbaWhs16TvoVlncYO6Ez+wfxMOjNyxXGjPmXIfafKm7Y1H4988D/4hO5AoG+cYKNLWEHQjVatqVwJm9Y83nV3R6R+yivQsxCzdPTrMpTf6agVp1qINJ0Ret1DPS4XpjKW3d/rpaGhJsXXzF9ddUZ9CrPtccC5hlLD6Ou1LSJXWh26IEl/Acp9ZeChD7LlI9Iab9SewUXUX6yjln3GUwCx8aKvyERAytdQcu3uC5woSZMfv59iih5RP4GTpQnYV8AqoAGKcqn0QteA98pH9iWIeKTKXTYoVpGugrtCK9Ok=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(36756003)(86362001)(82740400003)(16526019)(40460700003)(40480700001)(54906003)(478600001)(110136005)(356005)(81166007)(47076005)(336012)(426003)(2616005)(186003)(26005)(41300700001)(8676002)(8936002)(44832011)(6666004)(316002)(36860700001)(4744005)(5660300002)(4326008)(70206006)(70586007)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 07:24:30.3067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9276de-80b4-4530-32c6-08db93f2ad76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZynqMP Cadence SPI IP core has own power domain that's why describe it as
optional property.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/spi/spi-cadence.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
index b7552739b554..9eda7f0d2869 100644
--- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
@@ -49,6 +49,9 @@ properties:
     enum: [ 0, 1 ]
     default: 0
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.36.1

