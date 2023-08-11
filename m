Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A596779843
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjHKUJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbjHKUJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:09:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905E230FC;
        Fri, 11 Aug 2023 13:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZXKwQ+o6JoTEB3dmwmEJ25zOc6KtmG7D3RJeBX3QMUXEx5Pyon+V3tjMkLRp3ITL7B4PTEFtaAuU7FjGxGgA8RLx7vsPjSxShMW2+7ZenQ7v9r20lF/AN+x/Lm5nFS3AfCTKMDGxeGQQ7GozKz/0CGFPp65On2JPo/Ec4Llcq9ue0cBrLHmXZk3xhtcxxqNZ03STw4B43NcMy5vDRFxXZrhb7gb6McTx7xKsvSaxeT0RagiWzH/FpiTtqZJTixNA0ymdQD43MCdX1yEuqLQvhZiyFTZdnwMrU0yEGaGR53D9wPSZjtyssrJKXHylHfR13+KE52MlAgjzfcPtjbJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+DSIBfIYdaBQQoN1Aahql3oHTBoBm0oXqwHDD+PRts=;
 b=l0Y9+VoZTclE328xGP2QOrM03dPy+aH6B54dfXKZPDK/gJ48vdyE1qSkmCoromS0UR92aqIEOLgNjNavDvnXAG7DRr84nlvoX3NvOg8SVSa6n8LzmR4yfqNuskPwJwCl5MpZL0GRZ4IyxWUdk7bH5mCSVEzGGnXek7u46yqlchi/xKXt/71MipjTkmDlDozT8AVea9oViIeBgs6BFb0wzA1c3Jv73+YiMVicxsHYru9Pa6bVL2g/naYIofwUHE0q2pMIISyn8ZnqdFAVi+wbiwHunlVsSrykcEKbKgDtE9kbQ/cN8XgUJxZO1++m/rnlL3gzQeWc1XCwbcaQ9N+OzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=csgroup.eu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+DSIBfIYdaBQQoN1Aahql3oHTBoBm0oXqwHDD+PRts=;
 b=ggcPmUjcXT9UBnB0uFRBTReUfM6kfZ0BdDwr4E3orfGV4MiyqEVMddJaRcrW8yzyvZS2Z5ldWiRL8dKmnEqc0cIvDjeGAobhilejVTWTHLZkuUfVR5LXwm8Z/QqTN9Jn3uwl7VFulZdM1KCNn0DMJiAYTUF40/Bcm9vQAxVmhFA=
Received: from BYAPR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:40::38)
 by SA1PR12MB7040.namprd12.prod.outlook.com (2603:10b6:806:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 20:09:51 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::69) by BYAPR04CA0025.outlook.office365.com
 (2603:10b6:a03:40::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Fri, 11 Aug 2023 20:09:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 20:09:51 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 15:09:46 -0500
Subject: [PATCH v7 4/8] x86/resctrl: Add comments on RFTYPE flags hierarchy
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
        <pawan.kumar.gupta@linux.intel.com>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>, <babu.moger@amd.com>
Date:   Fri, 11 Aug 2023 15:09:45 -0500
Message-ID: <169178458575.1147205.16331131496340363561.stgit@bmoger-ubuntu>
In-Reply-To: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SA1PR12MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ef6f07-2d4c-4b0d-bdea-08db9aa6ebd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHxqMyMD2TTB9H4BOc/NHLiiWk87PIiZ4izraOSNKOykEiA2IzUp++w548om+e4D99zFEnOPjKRNRwHzDA5vVjoy6uOgIRcmlgyGkeIrSO50f+LQPqL8k1+MkfF9V6MMsv9SrIcdDJFUPFpgX5xfyz3aEwdBXuhsiqWG/QOUWfma+4EF6GMWB9533NblXNiHoS1EiDE2SMt8ZmdT/eJ9q8WtGb10JWU8Wv68EQjqkIzTWPOITG6ElWb3I5XPlG1QKB3odWm+SCK+ueVz/IC+DbRYC7Rp/LWW7hNyynZmgp8cbB0MnGbFnTKLLzOgsJ8ClbzooYG0gQ+uMBGZDlXibyv9Yo10eNYE3HPfTkvFU7PTx137V/RskZHOEVIWwoCNcMsKLe7xiMDuS4oKtj5KPtejJcvW2STbiO1c7R7OZFsZhVKF3uwS+ftNT+WF/T/4MIW7YEUi90O7dGptdtg1i4J+4Bms+984uLtcVpbbWV89mkcjQ3s2s5SqIcaLGGmyeTrICFOdyYKtOsAuumZk1kMX3EbTDsDhIavRAJdeY0RQzGvmfnwv7KwDU9HfKf7IaDIH/y6ylBEMezT3B4iKgxmxfXeUImRO6XK11acomJFFvmqdX3q1d2o4aT2gXNE1HUJznxhcn2y3ROxEOcvJT4BRPYdMbC+1463wXZVYWKuKrs0WjTdbvlAUziAvvv78hR9pnXCoo4ZKRLPqorCRWriIAGcP3hB2nuz0PRsLuc9sFGgTbULiIUCzWf3gxIQVd4y6rdMWC4T+UlSS0FDHJgR93x8aP23eQCEOxv6Rlm4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(136003)(346002)(376002)(396003)(186006)(82310400008)(1800799006)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(9686003)(54906003)(110136005)(4326008)(5660300002)(70586007)(70206006)(316002)(16576012)(478600001)(41300700001)(40460700003)(82740400003)(8676002)(26005)(8936002)(44832011)(86362001)(7416002)(33716001)(336012)(7406005)(16526019)(103116003)(47076005)(36860700001)(356005)(81166007)(2906002)(426003)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 20:09:51.3396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ef6f07-2d4c-4b0d-bdea-08db9aa6ebd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7040
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl uses RFTYPE flags for creating resctrl directory structure.=0A=
=0A=
Definitions and directory structures are not documented. Add=0A=
comments to improve the readability and help future additions.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |   49 ++++++++++++++++++++++++++++=
++++=0A=
 1 file changed, 49 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 2051179a3b91..37800724e002 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -240,6 +240,55 @@ struct rdtgroup {=0A=
 =0A=
 /*=0A=
  * Define the file type flags for base and info directories.=0A=
+ *=0A=
+ * RESCTRL filesystem has two main components=0A=
+ *	a. info=0A=
+ *	b. base=0A=
+ *=0A=
+ * /sys/fs/resctrl/=0A=
+ *	|=0A=
+ *	--> info (Top level directory named "info". Contains files that=0A=
+ *	|	  provide details on control and monitoring resources.)=0A=
+ *	|=0A=
+ *	--> base (Root directory associated with default resource group=0A=
+ *		  as well as directories created by user for MON and CTRL=0A=
+ *		  groups. Contains files to interact with MON and CTRL=0A=
+ *		  groups.)=0A=
+ *=0A=
+ *	info directory structure=0A=
+ *	------------------------------------------------------------------=0A=
+ *	--> RFTYPE_INFO=0A=
+ *	--> <info> directory=0A=
+ *		--> RFTYPE_TOP_INFO=0A=
+ *		    Files: last_cmd_status=0A=
+ *=0A=
+ *		--> RFTYPE_MON_INFO=0A=
+ *		--> <L3_MON> directory=0A=
+ *		    Files: max_threshold_occupancy, mon_features,=0A=
+ *			   num_rmids, mbm_total_bytes_config,=0A=
+ *			   mbm_local_bytes_config=0A=
+ *=0A=
+ *		--> RFTYPE_CTRL_INFO=0A=
+ *		    Files: num_closids=0A=
+ *=0A=
+ *			--> RFTYPE_RES_CACHE=0A=
+ *			--> <L2,L3> directories=0A=
+ *			    Files: bit_usage, cbm_mask, min_cbm_bits,=0A=
+ *				   shareable_bits=0A=
+ *=0A=
+ *			--> RFTYPE_RES_MB=0A=
+ *			--> <MB,SMBA> directories=0A=
+ *			    Files: bandwidth_gran, delay_linear,=0A=
+ *				   min_bandwidth, thread_throttle_mode=0A=
+ *=0A=
+ *	base directory structure=0A=
+ *	------------------------------------------------------------------=0A=
+ *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)=0A=
+ *	    Files: cpus, cpus_list, tasks=0A=
+ *=0A=
+ *	--> RFTYPE_CTRL_BASE (Files only for CTRL group)=0A=
+ *	    Files: mode, schemata, size=0A=
+ *=0A=
  */=0A=
 #define RFTYPE_INFO			BIT(0)=0A=
 #define RFTYPE_BASE			BIT(1)=0A=
=0A=

