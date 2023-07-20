Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A5375AED6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGTMzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjGTMzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:55:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF01426B7;
        Thu, 20 Jul 2023 05:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Td8rawbLu40n3a6j9G5cVhV0lTOjn+49uR2EeBT9fur0+EVBhSKYVb+4cDp/7uCjupqIkTc1U0RLOOZ/LBdGFgmV0bZ6wf3rvEpcMmp8vuvwWmOpENj12Nkt7lsX2G28q90xiMkSEiiYQ/26A3Fy8b0tWC56fpVMAO4+wrknGCTzqlKsDk8yaOV6F9AXrP0uuQ50VfJ+IPg9TM9U0eICbqOdFl5JE77ayYpQDPwmErLLT2BPpBUeDLspxop07jj0V13phzPc/lu3EzZ+Fr0qlm3qYBRDH0pu2YFBzExutVoCt+J5CkdBgpXkycpK3sE/fK5GoqaOITrUQTAZEedMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7sCBkrm39wGlaeEusXYI2a6fbO/pAqwdlGXo95aV4U=;
 b=ayC9wjBMaHt/K7yoRkM0Pfjyvfj4x4OOEqqHvokW5XDGDyw8AKgmdXi2SGiGzh0xvPUS78eANsYBSz9MDTGC6SEPmpr/32P91fjq8wQlGus4zIaiAf6G/yDgAKMszQoHaq2XaGvi8jihyQo5p6Mg0KmUQtuGqu5CHZ3Vqux3smFSAjSPYIMtbCvAXy+97NEQHU0gZOlw9pkxVWytkyhA2ro+TXg3AiwsuL7fUK61GE+abmd2Q45Q5z/el6QbDCuA+wjb/47cSaqGBLajBhmrT5igXU1e/RpQj54hMjHJjvmfFaZoUO5IX6zrcvG9wo5yzg5GFW8CqHsWZ5zIpsTEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7sCBkrm39wGlaeEusXYI2a6fbO/pAqwdlGXo95aV4U=;
 b=VXpKQIvmoCFxnr+zFrtV+E9PQHJct5TO6M639qAUMrh6prs9K7LwUuit9uwiqIxxrC1+MFSybte2+LQ8VIPTcKu4XgcixQqHpThopRIteHaWo0qs+MjlFsJhjrjnGdRZVRpofrcOVad+guxH/CHIZ0SHLgEmxWUQbbcbG6CK93c=
Received: from BN9PR03CA0318.namprd03.prod.outlook.com (2603:10b6:408:112::23)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 12:54:54 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::b1) by BN9PR03CA0318.outlook.office365.com
 (2603:10b6:408:112::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Thu, 20 Jul 2023 12:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.25 via Frontend Transport; Thu, 20 Jul 2023 12:54:54 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 07:54:51 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <nchatrad@amd.com>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 4/7] EDAC/mc: Add new HBM3 memory type
Date:   Thu, 20 Jul 2023 12:54:22 +0000
Message-ID: <20230720125425.3735538-5-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720125425.3735538-1-muralimk@amd.com>
References: <20230720125425.3735538-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: e259f821-eee5-46bf-649f-08db892083b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: foBJb5egt1t8tTnk7u7osWSTBNy96soLj+EDCxa60TpxMD3iUZyhuUbYxRLtQxjf/wwVyMSzABrAvuSqYHps6RHGw0gaop3y4QMVYKJ0sRRXIu9CFO6Azr5cUgT4ofg4Nh4ZqODgSSXDw86wzf2L29T9hhKLq8BevUO46WpIkJNDsxw4IuaEMlqNL7hB/3wyfmuFL4HSjLn0/hKzhSuCEnqK72bwY57p58S3jGM9O3a+vGg3+WofSkuuRBs0UKLLeBlOumlI6weauasxKOYzo5yMP3ur+pOpz0DV53l7MTNlBqrh2a9whf78oKYCeuchEruVCUaPAzRrtF62A/BZcyAnYIeJANyfd8JwtgzgFF6QxCeJwUE1FRTQOX6WKdL7as4R47D+Y5OedLgTcBqeNu25dCE4nRlhRmNg6npV23cWBu3gpJ6Hy2QMPVDppoPd8epm0w2asabE2W/womE7U3occlqVZzIHt6Am6nB+zv1dYEEKFofGup9urWJDDSWKLRpx81qZYesgsXM9/Pdy4xbPFoJo+/i/AJaWjA8EFXmi4BM6Qml7TdDDEfYhCU6IDBI8KbR5N3dqiZYUGkYmx0Q3+kE9pyHOaNTDlkkRLcSc9P5qE1aF+dsb2xeI+/tFjn53no25vySlvBCeR/wRjZqTkli74y6Vkl2ZR+ecOy9jPiMMi6O+YZ2aQzh/NppWNBKiwSqHKPrts5scbAwGsBY57S4L7TMXvtkfO6G9AisdE/WXy86XJSUL65V9TZN80/dDVbOqVD1bgYOvsK3EeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(36860700001)(36756003)(426003)(2616005)(316002)(4326008)(82740400003)(81166007)(47076005)(83380400001)(6666004)(7696005)(16526019)(336012)(26005)(1076003)(186003)(356005)(40460700003)(54906003)(110136005)(478600001)(2906002)(5660300002)(70206006)(70586007)(40480700001)(8936002)(8676002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 12:54:54.3988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e259f821-eee5-46bf-649f-08db892083b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Add a new entry to 'enum mem_type' and a new string to 'edac_mem_types[]'
for HBM3 (High Bandwidth Memory Gen 3) new memory type.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/edac/edac_mc.c | 1 +
 include/linux/edac.h   | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 6faeb2ab3960..d6eed727b0cd 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -166,6 +166,7 @@ const char * const edac_mem_types[] = {
 	[MEM_NVDIMM]	= "Non-volatile-RAM",
 	[MEM_WIO2]	= "Wide-IO-2",
 	[MEM_HBM2]	= "High-bandwidth-memory-Gen2",
+	[MEM_HBM3]	= "High-bandwidth-memory-Gen3",
 };
 EXPORT_SYMBOL_GPL(edac_mem_types);
 
diff --git a/include/linux/edac.h b/include/linux/edac.h
index fa4bda2a70f6..1174beb94ab6 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -187,6 +187,7 @@ static inline char *mc_event_error_type(const unsigned int err_type)
  * @MEM_NVDIMM:		Non-volatile RAM
  * @MEM_WIO2:		Wide I/O 2.
  * @MEM_HBM2:		High bandwidth Memory Gen 2.
+ * @MEM_HBM3:		High bandwidth Memory Gen 3.
  */
 enum mem_type {
 	MEM_EMPTY = 0,
@@ -218,6 +219,7 @@ enum mem_type {
 	MEM_NVDIMM,
 	MEM_WIO2,
 	MEM_HBM2,
+	MEM_HBM3,
 };
 
 #define MEM_FLAG_EMPTY		BIT(MEM_EMPTY)
@@ -248,6 +250,7 @@ enum mem_type {
 #define MEM_FLAG_NVDIMM		BIT(MEM_NVDIMM)
 #define MEM_FLAG_WIO2		BIT(MEM_WIO2)
 #define MEM_FLAG_HBM2		BIT(MEM_HBM2)
+#define MEM_FLAG_HBM3		BIT(MEM_HBM3)
 
 /**
  * enum edac_type - Error Detection and Correction capabilities and mode
-- 
2.25.1

