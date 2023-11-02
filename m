Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0B47DF716
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377083AbjKBPxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377060AbjKBPw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:52:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA70185;
        Thu,  2 Nov 2023 08:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE0u4dxS3qTDApjBWqlkfHAuqLVC6N4Tb1rORwll5UeWCmyrjLU9yXm+cKNoYBfUADTsEdPuoytEsS61A0+DKbWUzBzPJjMUxUCsp0EzsEGOT4DI71VEWbmvNisAQZJ6Nu3ShSdf357oaXWy2cESk/aqhV9LF2rwNVUABsCGWQjbxqflgoH0gkGfqXfckZfoHdxkieST7FSRtlLLPjVdnZ5w54XWsFUA7eV+//3GfduhQ8mVy5j2PVzcQ51wkp3FBImZiiONl6PToq2F3IGbibWpDIUXq3v1M1hbOueuCvf/d5JSrMhAGn0Jw4cnFIc9hppTmn6YOAPft03vh6Ru2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6/nRVwpHhaZbEXYAtB7TcSXzk/2ayIoRRMXztS292I=;
 b=WwMcOXepyIflEfY7khbMv+CXM8OaqOR1mMJRQtHJEPLbG62eCDd9ZA+gw48mGIMrUh5Sw6Rq+S4QhkvkMmVBtDFFYoSPz70DJ8+SPYcj5YwDneG0HyyIo9uwXz4KyKIYg0P4L/bhwleL3GX8olM/44d+LrgxjV/yJsMj8Wi7oaUcRDjxSMbsikOR6SdcAD5Esx1Xjgydv4FcDQZX8gilGXEqaFeC5bFQgqYA/I9Wes2DZ7dkk9DZVR0/2xWRKtKyHsZTwgFNTYIHj16eF5dYrNYBq6uqU8a1AAGDJD1ijszbccv54+LoqmRi6GhONqc5frUN2OGqrmnoTr9ORJZrIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6/nRVwpHhaZbEXYAtB7TcSXzk/2ayIoRRMXztS292I=;
 b=n8WhzNNamTRy9rYGAliJ/D6MsEhWgcRLRXX5Nv6T8d4ChonwQjCukiuvxfUP7zK9BkQvXV44bXHLu4la9ITtUQhPZlLY3QidKK/nd9yZIeG3seBBjhb4z9+FA5RY6xvQ1A75ixscZ09GpNDu0XQ1UNlz3FzCIHGHOVrcHxOWwXo=
Received: from MN2PR20CA0021.namprd20.prod.outlook.com (2603:10b6:208:e8::34)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 15:52:42 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::23) by MN2PR20CA0021.outlook.office365.com
 (2603:10b6:208:e8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Thu, 2 Nov 2023 15:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.20 via Frontend Transport; Thu, 2 Nov 2023 15:52:38 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 10:52:37 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
        <rrichter@amd.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cxl/pci: Change CXL AER support check to use native AER
Date:   Thu, 2 Nov 2023 10:52:32 -0500
Message-ID: <20231102155232.1421261-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 18322f65-bd35-4f24-6127-08dbdbbbbf3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16m/cH4mPzwof7SXTyKXBQRb03+v3Pcbp+s7qu4pRv9Pn14hnGMc/D++Jlg8D5wC4vTcyhwRp9kBKkLuqt/zb/VfmcAX5VIF6AYWSP38KThru9TRVRpb1rABCZ54cx4uxm/NY1wzhB0G0ylo80EkvJ6il95oaaIrMGfQ0SHQPoa4M+Jb7ug7gohqV4xF5ES6m8CvrOmGyXIdjLFm2CL0YXIHNl+JfD4f7t0yOmLhuxa9Abf9PAjJ1OVY1fjp5gZDOpa1DStA/EsXblg5v+eDOic04Z1UYQxzVfutOlvtkhCX3A2ydvzdAOoTO/WAE6t+5POlge5QeM7V5z8r23uQvtbIkNjXl4AyIMB6ZTitb88B6RxeJ3kgjhf8f2CuuRhjsLtlWxVQHEEojiDp/Fl2dA5TV75+Z9iTJ5fOivKWOMnReMflN4/kgK4cSoDZDnWG54BbSPrtpo5/XtWrTCE/oyU0JTfhvRJXHkhjiH2e3hFhXNaKCKTSpKVWO/gNGUMEl3GE+yUeUBk04ppTMeIZnij3FSYWMZBw+0myrVHMXEK8i03tsu8GSA3FW2uTGGIQYHc5BM6UO6c6WFkfgJd1mGjBOKgoKf9YhziqPtLkby2ARoFSWuMlj5bfd0fxvPo7YzX7BBKzLB7HrOvZVtMaNhdug7e4w953H6f3fb99NNp4zpgdmyofIju6iUrxLLQNQo5btdScZO0V5m8Q6RCGwE+hm0ysp+0cRmwePPy4F4k1LPFlvD7MNwiWB8MATr/AtABbykGWEewyK21szJd6bQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(47076005)(40480700001)(40460700003)(36860700001)(4326008)(316002)(70206006)(110136005)(54906003)(478600001)(70586007)(6666004)(7696005)(44832011)(8676002)(41300700001)(8936002)(86362001)(5660300002)(2906002)(1076003)(2616005)(426003)(336012)(356005)(26005)(16526019)(81166007)(82740400003)(36756003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:52:38.8548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18322f65-bd35-4f24-6127-08dbdbbbbf3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
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

Native CXL protocol errors are delivered to the OS through AER
reporting. The owner of AER owns CXL Protocol error management with
respect to _OSC negotiation.[1] CXL device errors are handled by a
separate interrupt with native control gated by _OSC control field
'CXL Memory Error Reporting Control'.

The CXL driver incorrectly checks for 'CXL Memory Error Reporting
Control' before accessing AER registers and caching RCH downport
AER registers. Replace the current check in these 2 cases with
native AER checks.

[1] CXL 3.0 - 9.17.2 CXL _OSC, Table-9-26, Interpretation of CXL
_OSC Support Fields, p.641

Fixes: 5d2ffbe4b81a ("cxl/port: Store the downstream port's Component Register mappings in struct cxl_dport")
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/core/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 01c441f2e25e..b29f6d09744b 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -812,7 +812,7 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	 * the root cmd register's interrupts is required. But, PCI spec
 	 * shows these are disabled by default on reset.
 	 */
-	if (bridge->native_cxl_error) {
+	if (bridge->native_aer) {
 		aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
 				PCI_ERR_ROOT_CMD_NONFATAL_EN |
 				PCI_ERR_ROOT_CMD_FATAL_EN);
@@ -828,7 +828,7 @@ void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 	struct pci_host_bridge *host_bridge;
 
 	host_bridge = to_pci_host_bridge(dport_dev);
-	if (host_bridge->native_cxl_error)
+	if (host_bridge->native_aer)
 		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
 
 	dport->reg_map.host = host;
-- 
2.34.1

