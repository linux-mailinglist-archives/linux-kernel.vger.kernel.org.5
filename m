Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB01759E56
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjGSTSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjGSTST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:18:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE02199A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+h0arUEgtYDiCkdFt7RnVkzjsoQ3tFpgzv8rHjagJwpObywSOxeuDf+1vCnUDLAQFjXCs057E+upuJtlhrRxSljXR2C8F7/E5wDc+QYnTeWmg+1PI7MtfkKKUVdMIJlEn6e9j8gycyZ7GUu9dvhcbTajCVOM7HIUAAVpaQbr0vSHxgchUPsJC/yrMH9dHnqBcPjKTGLqERUmIELlTrDZLOQmgH1vwoynNSmBpGaR8mkLWVgwRvuwR0CUMG5spzjxsDTr4rbyiErZE9MijKcA4ZY3R+mTPzA1mHh7M4mSyIoOYltpScC73C2kayTyACTl/Us5euNFxyViJYugOAI4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lo6l2EI5iLcH4XaXjDLw3/fP8Q2ymBD+LRd+XFoHojs=;
 b=J/YjgnFekqDkwk8oLKFpel45OYBHvDy1t5n23PEQk6O5EydMu1Qlfegpto5DAPMyHLveKfKDUnYuN/3Qe3ZJgbdDuSG9nShey6t2nKfHQqhGu5LBXDqgGit45eGbFsrsGBSGvHqCOhX1EHT6e3h/qU/DdZJoGLXEQ1PyZUpbKSPgKNIdq2TzhDwOQhkSTqtt3lgFm5gmRIDSXdCdwQcs2z0lzcR3sG9N1YzIKPhvV/G64zihhTeKk0zXxcDnC3+pDWnmFu8w2/q2YrKTFCpY2flzm1CqO2HPzQAPIsNu9eZgqmKzZ7w2O1Cv7kZ94qGkxRaWn8RVIydwy4huuEZkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lo6l2EI5iLcH4XaXjDLw3/fP8Q2ymBD+LRd+XFoHojs=;
 b=WZtmM+cCatjZHT34pcwbYWuLQCr2oiPxFpMqcLedI6LNqxmFDUo5goIyf/Cm5xJcpW9NOfH4pIVVny6H3BVVwNg+aR13mv/25/qzlzFa3PAXldi5w6hDyEOYucZLpeTwx8c4AotzrTgke4Lp4kLvn7kV5hj9wnmEmP8UwhQvxD8=
Received: from BN0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:e7::21)
 by DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 19:18:14 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::26) by BN0PR03CA0046.outlook.office365.com
 (2603:10b6:408:e7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 19:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 19:18:14 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 14:18:13 -0500
From:   John Allen <john.allen@amd.com>
To:     <linux-firmware@kernel.org>, <jwboyer@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
        "John Allen" <john.allen@amd.com>
Subject: [PATCH] linux-firmware: Update AMD fam17h cpu microcode
Date:   Wed, 19 Jul 2023 19:17:57 +0000
Message-ID: <20230719191757.3210370-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718231959.3163407-1-john.allen@amd.com>
References: <20230718231959.3163407-1-john.allen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|DM4PR12MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbf7f9e-791d-44ba-2353-08db888ce641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r4XHrC7Nviaqo/B0ngOGFTO+ucGAi6ePPgPh7UT8s/jx6SIjxOwKBmdFCJ+ZEJRODllzOSj3IYW1M4oRX/orUZbcPnGUfh+7SxczOLgpwWUXI1+Z7x9U/bGxXpRUmWXkZ2evztXlZZV4Zv6ZFadWciG5/7VEhXSvBP0ffcNFU3y983LPezZFhBF6jdzmlAwQ+kCzSXZcPFI5zstdUnF0EJ/VyNoECDbbhzpuABFm2WXwfMvgYTyjyroet66GFCOMI5l3uhDDG/jU6JpGHemirgXqMj9sBZ+RbiY4sk/sS+sQYeT2nxH29nQth22Q5V/p8zgQT+xoDbmFJUFIVwGVAx1Kux1hharOdweMDfpN9slFqaszvJV6w9X+LGCgDf1tlyiBIlmLyuCHGOCFXR7s+kgg+HVb70VQK3r/rhqxqlVehpkqi6c0/1pTEO8Tqd70j/BB2PszU1fJtcw9U03wFlBmuWz6RS+rqd2X7W5jiCBUomMg51BkCkxj5xYiFtHEoM5z3eJB+wEWhxPXN6sDvGgQCScOSdHv+zw6/YjjkkU5V5azlcUNwISW7uV7PgJL6SFQoMqLPZbnq0/z7wfqImGEIQEpvzb8pJIsBjQn1ZyIdHYICAeWvlCTrWOsKD4+P4j6uTQXwLg3RbiroYXyAUzHYzip4KNfhttSqMyRGFELMYxOKeDkmcJrpSG/h5I/BLPBo5mEiUYQVvXaqRXN7wDGZq2AOreuvebGyzpZ72Bs/k0xWcox8dCUUkzjiBooPrqYs143K2OUd6EhL+kbdl5egyC5GDbKX2ZoGYW6cXg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(70206006)(40460700003)(44832011)(7696005)(6666004)(81166007)(2906002)(356005)(316002)(8676002)(8936002)(4326008)(4001150100001)(36756003)(5660300002)(82740400003)(47076005)(16526019)(70586007)(2616005)(426003)(186003)(1076003)(336012)(40480700001)(26005)(15650500001)(41300700001)(86362001)(478600001)(83380400001)(54906003)(110136005)(30864003)(474154002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 19:18:14.2415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbf7f9e-791d-44ba-2353-08db888ce641
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Update AMD cpu microcode for processor family 17h

Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
Key ID          = F328AE73
Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

Signed-off-by: John Allen <john.allen@amd.com>
---
Hi Josh,

Apologies, I didn't think this one would be going out so soon after the family
19h patch from yesterday. This patch applies on top of the family 19h patch.
Please let me know if you would prefer if I resent these as a single patch.

Thanks,
John
---
 WHENCE                                 |   2 +-
 amd-ucode/README                       |   3 ++-
 amd-ucode/microcode_amd_fam17h.bin     | Bin 9700 -> 12924 bytes
 amd-ucode/microcode_amd_fam17h.bin.asc |  16 ++++++++--------
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/WHENCE b/WHENCE
index bab6cc9a..15a8645c 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3909,7 +3909,7 @@ Raw: amd-ucode/microcode_amd_fam16h.bin
 Version: 2014-10-28
 File: amd-ucode/microcode_amd_fam17h.bin
 Raw: amd-ucode/microcode_amd_fam17h.bin
-Version: 2023-04-13
+Version: 2023-07-19
 File: amd-ucode/microcode_amd_fam19h.bin
 Raw: amd-ucode/microcode_amd_fam19h.bin
 Version: 2023-07-18
diff --git a/amd-ucode/README b/amd-ucode/README
index 4308fe2d..1d39da3b 100644
--- a/amd-ucode/README
+++ b/amd-ucode/README
@@ -32,8 +32,9 @@ Microcode patches in microcode_amd_fam16h.bin:
 
 Microcode patches in microcode_amd_fam17h.bin:
   Family=0x17 Model=0x08 Stepping=0x02: Patch=0x0800820d Length=3200 bytes
+  Family=0x17 Model=0x31 Stepping=0x00: Patch=0x0830107a Length=3200 bytes
+  Family=0x17 Model=0xa0 Stepping=0x00: Patch=0x08a00008 Length=3200 bytes
   Family=0x17 Model=0x01 Stepping=0x02: Patch=0x0800126e Length=3200 bytes
-  Family=0x17 Model=0x31 Stepping=0x00: Patch=0x08301072 Length=3200 bytes
 
 Microcode patches in microcode_amd_fam19h.bin:
   Family=0x19 Model=0x01 Stepping=0x01: Patch=0x0a0011d1 Length=5568 bytes
diff --git a/amd-ucode/microcode_amd_fam17h.bin b/amd-ucode/microcode_amd_fam17h.bin
index 37d899cd534789e461a5cf3ad666fcd587b8ab93..f9841b65b8d6ea156a402f45bba17f0e31eaf4ea 100644
GIT binary patch
delta 5515
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
F{{gHxepLVf

delta 2769
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
XI8~N^f?XgDZsTXPhi>+WOwD$}@;OgK

diff --git a/amd-ucode/microcode_amd_fam17h.bin.asc b/amd-ucode/microcode_amd_fam17h.bin.asc
index 27da52c8..34a40245 100644
--- a/amd-ucode/microcode_amd_fam17h.bin.asc
+++ b/amd-ucode/microcode_amd_fam17h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 
-iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmQeEvgACgkQ5L5TOfMo
-rnPOpAf/dYhPqq/ktg1muI/khV4EhDiguX6OXib3fmfSZdvPIAI0cRI77M3Lvf0b
-nlV8D67e5HOQ5foJbix5tunz0sZjqr2QU8U9dNk/ut0KC7UiCRc8VH40aSi/OQBG
-Y8c7tb6IJ+N+jyJ6Ii6koUuRO2Lk2MckcrWLRuLRV4bB+osyJrGjc/X54Z6UJ/Ma
-VDg13Yxy5WvC7sMmlmnY42JLeLBKDVUvg0zDvJ4aOLLxRE2l3eiAKE+TV122LmxN
-ca5WA/ESYQ9BjxHYIrpTd9nQaWa/TIZ+rOmJGLMtnQ1gGlW97zQuJR7zh+8vdLzC
-iwVlS1cu7kcV7KYDytTkWJ+2gwb3uQ==
-=lP2S
+iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmS4Mm4ACgkQ5L5TOfMo
+rnN35wgAkllCunxE6J5hQyLMx5o4WTHZkbNvXmu6nV1Y3vjiL1oeaK+pmx8BlkPt
+fGZJCe/068kqmp3N4EtOZLxXn55t3jNBYectPr0RmFqpjMsEJEcfXfuXROA4N9Ti
+Zd/o6X21eHEsm0kK0q4YfppfgTd5Ze7k1jTkUuuU6/yh6uRk1MiFreEzkPO3Aayh
+iEWlYx33vq3HccTPgdY3D64Zr8gmgKG+8mdEvqb1jK4SVZ1/9vy4OKIIpUZB/eqx
+46h9Ejwn9pktnYkHi/A/zCREEcIQ10HXFF5bjxJTFQkM5S46/QEO7uuvnpMb+6Yy
+4V1/QIWMG6ixqCRx9GqbBK7GHdYODw==
+=+IsI
 -----END PGP SIGNATURE-----
-- 
2.25.1

