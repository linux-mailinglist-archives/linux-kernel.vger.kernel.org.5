Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF45D7B757E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbjJCXzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbjJCXy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:54:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE783AC;
        Tue,  3 Oct 2023 16:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxEk0Ch1mpg1lwsDgrMSuXXLt9eRmZ1vDW6LJqx4UT8QlzNuIJqRR6+XSbNwTCEuaurIZn2kVy6WwNDLgqtwlv1RWTS5X6Mw0BAvuNpws6o4JNMU8AOq28OFVzYC1eX9bn4r7k5QedBbAA3A6s/bip6GG/g1/sFcN65giOFkqRcFr2TmItDJaij2p7/YZlOc/nfCgdXbL7uVxIa4BaIVu/Ke2d3VCO2VxJPMBZ1AAx5M1D/zYmORJ/+IYAXBqygO5aKXLAcGrGZdAM6hmgtc6HbDK+CYuYDBUSoGGdYzC52mZ+ii4gdZOwY47VxPTsa1esB3r0EWbLvWLg4vpsC5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5bAhVhL44d5lXnrKca3CBF2AA2u3p0vGMxt60L5ecI=;
 b=HBffq5Ge2zyPb76j5aEzLGz/uoZg2yKA6UUi1xYc+v8eFx3ZQBY1qIu1STDRj0u/ln2pWB0TU6FCJfqN97Q0DV8cGsqOEBYSR0RwijTC6DPZm6mPRqKrvkBKeIBLUY2/rGSGY1tCu2Tvr4qBQTjZL8zX4+gDMw8l4RHS4aiR94XUfExEOzm68if7TFn/aOMaRwgAAt9TfUqG1pUB4cUfRDz8vUsSGob8TfwzWFdml5atuPV2QUnOZVhDGtUq/g79d20WjG6AJIwEECjq59+qm/ycboEiNFKl682i3qgSE57C1lhoTkcsohG+rDHl7bx0KLy43YdXZqM6GsjIzBespg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5bAhVhL44d5lXnrKca3CBF2AA2u3p0vGMxt60L5ecI=;
 b=PL7/ol3t5F3j7z0qdm0XHR2bLCYi7QrkYCgOYXOS7m7KP+48ycVqy9U2nPykif1ZravbI0HCfijK449Q1OsX+LSrBevzNzfbvP7Cr7X7fNNhxrp8ma7PZNeG/8Ri1O36PiWf21KZrDYzW4/dkrVUMyOWipdmYPIKJE4VLVd09BQ=
Received: from MW4P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::16)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Tue, 3 Oct
 2023 23:54:52 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::fb) by MW4P221CA0011.outlook.office365.com
 (2603:10b6:303:8b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Tue, 3 Oct 2023 23:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.9 via Frontend Transport; Tue, 3 Oct 2023 23:54:52 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 18:54:50 -0500
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
Subject: [PATCH v11 04/10] x86/resctrl: Add comments on RFTYPE flags hierarchy
Date:   Tue, 3 Oct 2023 18:54:24 -0500
Message-ID: <20231003235430.1231238-5-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003235430.1231238-1-babu.moger@amd.com>
References: <20231003235430.1231238-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: cc51d60c-bd02-4e65-1f46-08dbc46c230d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oq3Y/RTSaO17afieRdO0ru3VNkrsXKp3SrhouRy0CKmNXhJuFxNTbmXuzNqMUPV+a+SURkFermbCi2NkC0vIY5TIOhCfropJimrbW83c9dVdE1MXCkObESpBknCEIDtUJ1Ni5kr+/5CVA8bZgvgyG2ZNz6swVgfvujTYxL29IhDTJHm28woveUKjC0z0IgOmRSjfy7ULt6QHMJAGuGJk6hXZriUGR8Hd9+rNlfdwP1Bv7x/qW+fIi2HyjjjnrAINVfrGj2uE6aQ3YkvnqXN8T0oAKM5fA2WlK+A7W/xH/yJOCfLgIbQFdfbWqeyzltDoSrb/LjryEdZy6+hnZRkteDa6OLunz+JcZOA+v54lDDLpUsx/6+rRZfqM4w2S5FKvvJ2m9Fc+govLrgSURfiACwmvDgGKSodopDaI6TG9M84q82NEoEa2awPObLlZQcy1LAdlMP1+11V9IoRDOtekXzmQM0fJZ44p1CjOy9eBzekJP2c+s9+2npMhSUnkp+ERDqvwnTS9tdRPAbkRpkBXzwPM0vXruDA4KHD8+EWF1eV6irRpbPBoXRX4a3pr6o00zvHlycEgczOQKA0/jh0bHIr6AW/r768z354dOQgUuuncdq771xfRVg1FYx78/Ntnkf+9Iwp7HXE7OGEUFmMvCkDhDlHB/LqK7bcTSj2spkvyAvg2vFtHmG7hxsGeulq5qvO3fnAD3NgQ867ZO6pXdbGVFnQHPRn2U+n6diMvyh/dF0lwlI/q+TUGd/wp67ETzdHw9DzNFbDeh6e3t5Szsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(46966006)(40470700004)(36840700001)(36756003)(6666004)(82740400003)(7696005)(86362001)(478600001)(81166007)(356005)(110136005)(70206006)(54906003)(316002)(70586007)(41300700001)(2616005)(1076003)(26005)(16526019)(8936002)(4326008)(8676002)(426003)(336012)(5660300002)(44832011)(40460700003)(47076005)(36860700001)(2906002)(7416002)(40480700001)(7406005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:54:52.4913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc51d60c-bd02-4e65-1f46-08dbc46c230d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl uses RFTYPE flags for creating resctrl directory structure.

Definitions and directory structures are not documented. Add
comments to improve the readability and help future additions.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f71bc82c882f..b47a5906f952 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -240,6 +240,64 @@ struct rdtgroup {
 
 /*
  * Define the file type flags for base and info directories.
+ *
+ * RESCTRL filesystem has two main components
+ *	a. info
+ *	b. base
+ *
+ * /sys/fs/resctrl/
+ *	|
+ *	--> info (Top level directory named "info". Contains files that
+ *	|	  provide details on control and monitoring resources.)
+ *	|
+ *	--> base (Root directory associated with default resource group
+ *		  as well as directories created by user for MON and CTRL
+ *		  groups. Contains files to interact with MON and CTRL
+ *		  groups.)
+ *
+ *	Note: resctrl uses flags for files, not for directories.
+ *	      Directories are created based on the resource type. Added
+ *	      directories below for better understanding.
+ *
+ *	info directory structure
+ *	------------------------------------------------------------------
+ *	--> RFTYPE_INFO
+ *	    Directory: info
+ *		--> RFTYPE_TOP (Files in top level of info directory)
+ *		    File: last_cmd_status
+ *
+ *		--> RFTYPE_MON (Files for all monitoring resources)
+ *		    Directory: L3_MON
+ *		        Files: mon_features, num_rmids
+ *
+ *			--> RFTYPE_RES_CACHE (Files for cache monitoring resources)
+ *			    Directory: L3_MON
+ *			        Files: max_threshold_occupancy,
+ *			               mbm_total_bytes_config,
+ *			               mbm_local_bytes_config
+ *
+ *		--> RFTYPE_CTRL (Files for all control resources)
+ *		    Directories: L2, L3, MB, SMBA, L2CODE, L2DATA, L3CODE, L3DATA
+ *		           File: num_closids
+ *
+ *			--> RFTYPE_RES_CACHE (Files for cache control resources)
+ *			    Directories: L2, L3, L2CODE, L2DATA, L3CODE, L3DATA
+ *			          Files: bit_usage, cbm_mask, min_cbm_bits,
+ *			                 shareable_bits
+ *
+ *			--> RFTYPE_RES_MB (Files for memory control resources)
+ *			    Directories: MB, SMBA
+ *			          Files: bandwidth_gran, delay_linear,
+ *			                 min_bandwidth, thread_throttle_mode
+ *
+ *	base directory structure
+ *	------------------------------------------------------------------
+ *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
+ *	    Files: cpus, cpus_list, tasks
+ *
+ *		--> RFTYPE_CTRL (Files for CTRL group)
+ *		    Files: mode, schemata, size
+ *
  */
 #define RFTYPE_INFO			BIT(0)
 #define RFTYPE_BASE			BIT(1)
-- 
2.34.1

