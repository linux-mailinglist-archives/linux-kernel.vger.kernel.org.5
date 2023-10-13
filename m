Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF897C7D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjJMGJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjJMGJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:09:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED56DA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:09:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0krgeOfJOcGlh5GhsMuQYxIZ2NZrzd3lnLiv9d+BAggogOqGBAVEc7+Y0x4YqkmhChZBdI+s2pYvZHAXUydyrXztgNGVNCIK7zEHKli0BsMUq3L9HbLf5hjT0pLEZXudkmAsYfPEw+1E6jowjQJFOmAyCbH7fc8T5+gWkcUpOw8ewy/+vfmNhQ2VOiZfWe7vgy3YvmDYPdNjG5d3xelVmdBVVeiBBY/RS6adelwdxrPVLFRuBrrG1PUjPUuIWv1TI19fL9s7wWlFBAb3nc/J9FbpcIXTpSQtlGBZzT2qDXFNZCLip0PRqGcgt+O6qX6Lyu6ADfHRHqTQKE3EElnng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADDGs3ff5jYOy3F5Q0yOMqrSVnqNm8+80u9lqYakXKo=;
 b=lz8Ps+gAYwFWj3FdfXsvkZT/i8sFuuW3pHZyE2KUNhev9aviN0LEWeldMWFX4Ai+mXLmvr+GKz8IxLcOW/sRxQ+tMxPXn2XRNVq9xUn8FDQ2Y/HTGAawxMWdehmT8FfppXk61ZmeN8oZATR7sen1L2xpjefR7qI0nuf8Lf3MKekuu9MyaP3Pw4x2mzq/r0g46cyyoECndgz/IpivPzjTmUDgXLOUKiyVz8/Muk0bNBqEnJmMSm8VtTL+xhXPl6IoN04h8pfhUk1SAwIeebYq18A/Qeuq0yHb1RACr9P2bvZnGVeRQfLMar3EMK/csS38aaK7oEpkb0N9EAxc7SPr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADDGs3ff5jYOy3F5Q0yOMqrSVnqNm8+80u9lqYakXKo=;
 b=X3OEwgw3s8LLGV1knHLbAXWb9fqSOBMBbgreTtDNrCoTKtLmUQBsKaKvP26p4Fi5o2KHi3W8f4vMmOJiCaXOXfoaL9neKbQs6UztPRqbucPcnT+cvLIoYCHOmoZMnqI1Wr79WLCRkQt5iiVSKNvMsY3BYVT9mcE/T2ho1N3YfjI=
Received: from BLAPR03CA0116.namprd03.prod.outlook.com (2603:10b6:208:32a::31)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Fri, 13 Oct
 2023 06:09:30 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::a6) by BLAPR03CA0116.outlook.office365.com
 (2603:10b6:208:32a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Fri, 13 Oct 2023 06:09:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 06:09:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 01:09:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 23:09:29 -0700
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 01:09:27 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v6 2/6] cdx: Introduce lock to protect controller ops
Date:   Fri, 13 Oct 2023 11:38:46 +0530
Message-ID: <20231013060850.424929-3-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231013060850.424929-1-abhijit.gangurde@amd.com>
References: <20231013060850.424929-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 240f4e13-18a9-4cb8-2a04-08dbcbb2f694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qH/2csxOGn+vETLMrwzH2EtVur3TI5e9EpBh1G8CpK8gxdVh1g+tmX15KIU18Iq/99rPmR8z56BELBp5Zx3kQNWT8ZmAca9EOQ1LO84+GQqSu+lnhoLu3eaizI77Cm5TwLM0/vNGrr5R4AVo61w9s3k5OSl8S5LNMWRna1ExL2S+npbRSh9NQFcxjLKdJcEZh046sTNxTrBR6j1IUVVaIOpC72H1bvyR8I1LMPktCDhG2RbHUB2Tq5SaMv8+gMTjs3FmLvvq/6LX8s3zEJ/pFzP4IXAyM8nNrHRtlgUF8d2TtaqCkGI+r13AHlEHMeG7jzm2f1xLQIk7CrJKflImltpXZiUUiRcbT7mcKpgD8SD+/O/O/+CmIKCYSKunY+Rroa03lDSyOrfr2IbDV4BMuLKRnjj1/SZiUqYMmoLIBFIAAvGQfyH6LkbI+pGz2ea24xzfUF52StKATG6OXyR4XfftDiXL5zzxWlft6Vk/ko1a1lIhiO/CZrGAQLmpbqgk2c7ez5Z1RdeNPD6ITOXVx3qYDv3RO/xQD/dAG5VtAEHGa06qonOgnzcqw4MK7inPnkcVsL6JmcnUgm/yKjj4UKJdkoUUuvbv4isuQMWXYjkymypOSHm43zr3nZ45BSxee3O4vrZECihvY9fqIMpVRzsPmcS0fnnTTnzScc9OSvuvcGFSWPChxQoLUR8c/b12u3cG5xKYzOYfB6nFRGnAH/NaoTwnxYloKAI1XxtzN3tIGwyt1pB2M9OOGl+LpDN4vqQjmMf5UU25Ni+ETd58g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(47076005)(6666004)(26005)(36756003)(36860700001)(1076003)(426003)(316002)(478600001)(336012)(2616005)(83380400001)(110136005)(40480700001)(70586007)(70206006)(54906003)(41300700001)(356005)(81166007)(44832011)(4326008)(8936002)(8676002)(40460700003)(5660300002)(82740400003)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 06:09:30.4267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 240f4e13-18a9-4cb8-2a04-08dbcbb2f694
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mutex lock to prevent race between controller ops initiated by
the bus subsystem and the controller registration/unregistration.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 Changes in v6:
 - None

 Changes in v5:
 - None

 Changes in v4:
 - None

 Changes in v3:
 - None

 Changes in v2:
 - New patch in the series
 - Introduce new lock

 drivers/cdx/cdx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 0252fc92433d..75760388f5e7 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -72,6 +72,8 @@
 
 /* IDA for CDX controllers registered with the CDX bus */
 static DEFINE_IDA(cdx_controller_ida);
+/* Lock to protect controller ops */
+static DEFINE_MUTEX(cdx_controller_lock);
 
 static char *compat_node_name = "xlnx,versal-net-cdx";
 
@@ -396,6 +398,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
 	if (!val)
 		return -EINVAL;
 
+	mutex_lock(&cdx_controller_lock);
+
 	/* Unregister all the devices on the bus */
 	cdx_unregister_devices(&cdx_bus_type);
 
@@ -415,6 +419,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
 		put_device(&pd->dev);
 	}
 
+	mutex_unlock(&cdx_controller_lock);
+
 	return count;
 }
 static BUS_ATTR_WO(rescan);
@@ -538,12 +544,14 @@ int cdx_register_controller(struct cdx_controller *cdx)
 		return ret;
 	}
 
+	mutex_lock(&cdx_controller_lock);
 	cdx->id = ret;
 
 	/* Scan all the devices */
 	if (cdx->ops->scan)
 		cdx->ops->scan(cdx);
 	cdx->controller_registered = true;
+	mutex_unlock(&cdx_controller_lock);
 
 	return 0;
 }
@@ -554,9 +562,13 @@ void cdx_unregister_controller(struct cdx_controller *cdx)
 	if (cdx->id >= MAX_CDX_CONTROLLERS)
 		return;
 
+	mutex_lock(&cdx_controller_lock);
+
 	cdx->controller_registered = false;
 	device_for_each_child(cdx->dev, NULL, cdx_unregister_device);
 	ida_free(&cdx_controller_ida, cdx->id);
+
+	mutex_unlock(&cdx_controller_lock);
 }
 EXPORT_SYMBOL_GPL(cdx_unregister_controller);
 
-- 
2.34.1

