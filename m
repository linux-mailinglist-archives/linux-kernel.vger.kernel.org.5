Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910667DF17A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjKBLn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjKBLnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:43:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0E91AA;
        Thu,  2 Nov 2023 04:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPId9NN6e/V6jrd/EVzwxeP1yCUxaEn1tS4tfmj0pamMr7am/22S4bwM1SJ42bfLNioiAZg+tS5I+lxtQ+e/9HBNxYaA68MlipJJq2lzjQsuMqgUH7L6Rp0c6pn9m56D6ua739thHJ4tcxp4DGdTACrFMMtF77rTbMCzZ/Xd9NsAejpMwTEBjVhxgQXf1Ugjwovu9SxrtmREGx7junhDcRegYKCAQVbVLilFvCUYyL668pxoGApg/18Ldwwg7qrIjJHaLwiaw+GAqH7yBHAErwGjNSOQaHre4JIQReVlqDuI2tPws+kJTBQNQuR+YKgAG37z6RGk1Yqqc+ML3Y5R0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9nB6j/uzMbpJXSZbgbkJD3cinSEsG7LKBpkyd9F+kY=;
 b=cjszDj0oIYt1jJVBA9v0QQqGCglIj20OLRfPakZ3Gc/yfpQSeY6P2JuexiliTkIb56SJYooevTVf/pWYMhLH84XxI4s3+u17BrYtr72YQn8mQdghRiA9ZaOAK4nlAdfcbXQVCRvUzt9BH3ZbqaAPIn+ctVsoxvzErIze2yD4EQmpcCl8mmoAL6dipUnj50wqnsE6G4vlvBBVYQXIBFJxmrYQwi2TMoaCWuXfhvGbfQ9rGO6jn8HICqpxDnZJC4T7oyCEXR+5hN6kjGan21uwHvrSnhU0bRCxbjWf2wjB4CJOyD2PATNhh/2cHDNwJ48/hmk0KBd+lY0K7FkJFfKV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9nB6j/uzMbpJXSZbgbkJD3cinSEsG7LKBpkyd9F+kY=;
 b=kqus5Lp7Zccznb61765Gj+gEl65iLKZtdJJkI+wKA1P8cac6CnKO8HDIhRkM0bqz3hpPInUe7VLkj4J7Ocv/Eaa8NEln9ucF4BVf7HpkOifo+ZWhqUolbsEFHuQd5MplI4sG7/ZQVhwQD+NnMwOjauZUQZXYJkIHkcLAKfTSqVw=
Received: from CH0P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::8)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 11:42:55 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::57) by CH0P221CA0027.outlook.office365.com
 (2603:10b6:610:11d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21 via Frontend
 Transport; Thu, 2 Nov 2023 11:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 11:42:54 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 06:42:52 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH v3 3/4] EDAC/mc: Add support for HBM3 memory type
Date:   Thu, 2 Nov 2023 11:42:24 +0000
Message-ID: <20231102114225.2006878-4-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231102114225.2006878-1-muralimk@amd.com>
References: <20231102114225.2006878-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SA0PR12MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: a10198d4-757f-41d4-df11-08dbdb98da72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XAa0Wv1+0BuZmIG0ZswdVbiD23pDiRc/2hob6tlhCGzeHj/Koqd3rEvWB60q1T3+1uN2CFffPQzDccnirnnFE/BDCXTFcqMdr6z+bAKk/fd6rCrRYG1VsbIbStn3BlAyJkX7PoNMcpdY5+ZaZ7KdyZJcpZ7SQLp8Ib4RMXTkt9iw5qWqr9xcUd5YKpctVUNbdDA2vOl6hLNBSsdMrpaUvCPHixaexU8luAtzAC1Rao/7ZMC/V5qnRi74nEMVwB1vVtjtDoezLXA0qHcxdAqXGKYdO9SSoboCUN7Bna6lmnNx4NIW4Q/YPd8HV8rkVDrRoblNmCBFEonkajZO0VLJodEtb1UX70Foo7ZVX/WKZpL4bcTIQrLiyS9z6QpzqS7zeXFqVWvd/hTZpx0QJjpGIg+sgtanYDle1oScfxS9wVaN8V120oMDFXDsNQ80xWoeXUXD68Nq98RG4Mp1hL+rauKllg1EfyGmM9E+vFvxUDQe73QyQMZGbq434UyyvmcFkZQjkF8COqyzWOCC2u6TnKOAX/4MV438TOrpquJYH2UcFryopd/HsQqqrRzd9gwR9qLTOHiySaQ5C+odx43LHJVxG6W3+r7LUTyz8oJpVEdAHtDYgVEZboqbSjyu4z6mXuf6jzwHgQkVN8BDIKs726rnRsTWRNUANB38+cBet8fe16iArJvPlc8jL7lf9Lz1icM5q1KTiBLLpJrDAnSaYbkqyI6/wrk/1onfTTZ5bTotFxJuX6sVcH0nMZnGOlVGZzzz2jU8M1tvDyVyVMc0iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(26005)(41300700001)(7696005)(16526019)(40460700003)(1076003)(2616005)(47076005)(81166007)(356005)(36756003)(82740400003)(36860700001)(83380400001)(426003)(336012)(8936002)(6916009)(316002)(70586007)(8676002)(54906003)(70206006)(5660300002)(4326008)(2906002)(40480700001)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:42:54.8749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a10198d4-757f-41d4-df11-08dbdb98da72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

AMD MI300A models use HBM3 (High Bandwidth Memory Gen 3) memory.
HBM is a high-speed computer memory interface for 3D-stacked synchronous
dynamic random-access memory (SDRAM).
Add support for this memory type by adding a new entry to 'enum mem_type'.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
Changes:
v2->v3: Modify commit message

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

