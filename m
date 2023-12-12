Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE04880F52C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377078AbjLLSDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377055AbjLLSDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:03:08 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A15BC;
        Tue, 12 Dec 2023 10:03:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz2vQa/3VIJpjdR9pkgXJBLB70aPyJvP/MFHT7wai1xcoPPvANAAA69DHubfTGVh6bfbv+V1JQNfkktzcdjw74NkaT1ybIZgMmy6vBGwM0JLueLKUOm4etx6sZrZn/JwqFTfK4um6FzyDr5jM4KETfB/cpeazlohGD8b9ZKdg31+ezGiX4xaKP/ITvG1qjWNL4En+n0p/2ktOVXD2V05EvazOLf0BFTg+2iAsJx7D24LjCzeW7wNjG5AxBudJAqz3ROWRmtxVIVUCpFh/dd/1zsscGt9IPFQuocrksvNkbI6C3tNZGumkNzZ4s3WHnUyau1H2o1882nrH90AmjWplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nW6IBtwaqzxSxz54Xd8xgCLLSM5Vpt7m3SYoV9TVUI=;
 b=n3qH1QKcrkrF40FX85oJMlGXy2lsXYQviF7PpaL2xJfnmQt77HHNPprxMmd8GzcR4umw1d8vcDb41tIHoIc5TDwI/mpF/CoEPXFncBQFGW47RCxZ7XcUy6uXM9lilTZZidq8aAUWlEM3he+HDDSlWZDln38KPcOMBKijsKCXbl1pXVY6n0l3E9xjMBz9zIyWq7KuPg8+O2/+gcYHz5AxiZ2NSYp4+zkwEFNeYSPdFKAF0uUOh3afWhFRg+0oPM183liYvbReqG6vgBNSO5IH/bQUOMh704hUpDt1YunEPys1t44lmgtFJUV14F2dhVTYMJfFwQLoUwLlGJwjUVeE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nW6IBtwaqzxSxz54Xd8xgCLLSM5Vpt7m3SYoV9TVUI=;
 b=RKz6FMHohgBemifTTbg3ld8dcHDak38+gxj6W1K7wfL7jspc83MoXGds7MAGhPWYJ3p+HwvupA51vvn6sShxMFMn/wFwKTH7BUN5pbJ34fjM2P2p8Ld7rJNwG+0Ghz3cIaSVZX3JqCMpw8PWuPdDwKTO6BSjZ5omlhKS5o+tnXs=
Received: from CY5PR03CA0016.namprd03.prod.outlook.com (2603:10b6:930:8::37)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 18:03:09 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:8:cafe::e5) by CY5PR03CA0016.outlook.office365.com
 (2603:10b6:930:8::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 18:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 18:03:09 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 12:03:03 -0600
Subject: [PATCH v2 2/2] x86/resctrl: Remove hard-coded memory bandwidth event
 configuration
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <fenghua.yu@intel.com>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
        <seanjc@google.com>, <kim.phillips@amd.com>, <babu.moger@amd.com>,
        <jmattson@google.com>, <ilpo.jarvinen@linux.intel.com>,
        <jithu.joseph@intel.com>, <kan.liang@linux.intel.com>,
        <nikunj@amd.com>, <daniel.sneddon@linux.intel.com>,
        <pbonzini@redhat.com>, <rick.p.edgecombe@intel.com>,
        <rppt@kernel.org>, <maciej.wieczor-retman@intel.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eranian@google.com>, <peternewman@google.com>, <dhagiani@amd.com>,
        <babu.moger@amd.com>
Date:   Tue, 12 Dec 2023 12:02:25 -0600
Message-ID: <170240414535.760665.1609957728181418569.stgit@bmoger-ubuntu>
In-Reply-To: <20231201005720.235639-1-babu.moger@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 63379046-8f51-4837-2ce5-08dbfb3c996a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jOtkfbmmOKwwOZyYUfUDpfHOxxoc3UNC1Mly85k7F/1i/5R0KQCm3jYY/VgcckL1trwShOzZU2UFIlvOMFTKaL2yZEBIXPBrtyVyuFdaMWFJBGGh0BjQYfRPBAjqWk/awJtu51BaUmYfwTpBZeTUGXGu4v83vi5zaitIg5NV1KEbK5cFgSnNvYo02wu1A9dpf6hIpYLIScW9ZW9/WYv4U6utwpj0P9jdCjJhRGNT7hoeeMIZLU17BVnfG3mH0ajNmVyPYB8tyLeZDeJD3AxUIRvwL+4zVgKM2PfZc2GDKzKp5sJoDlmHqzm5sXRoaep+N4uK9Uhm98/vH9tcAIRPy//3U3EORrJX7T9CVdKK9FfE7b+txkdvvjutaGHBC5V6tOvd2uKBUaCEjDLGXIsVLH+aDV2Yg25/3cCWuEFzF/ks6m82lZv27O/PuTaYe19gbz5OTVhlK5tipbU+ol0UwA/FCitpJS7CMmI1EvRCvveQbZ5rJH3kbsz/4uBwArlEtXyC7s3yexVmNdX0qEfZ7m+suCiqJfDqFvoa3cUrAUfpvoEGiHoVO3z/pJxZd5O6zWwf7SEUAt+llfmxDordBJZPqoBM4MawNexMItbMMtPs5beOQb7MwkZo01GegGcUuqpQOreVLA1CqQpGRrhE+RQ68c9b2/D04AKxLgGI/9m34zz75oI5sBQKN7W96WHvuqtrFXQjP/bDMjmmec2nDHkrlFpr5YcJJnRpn4xLW7xEG//7bbDgAUfdJHk0EbX+siEZ3uEAQRR8JClW4ocp0+XYEhlegdO4/N1hIkwBdu440r70itRY0uimBRPmTRmj/ercRGcjaOQr+6zrFNLJYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(7916004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(36840700001)(40470700004)(46966006)(8936002)(8676002)(41300700001)(2906002)(4326008)(44832011)(5660300002)(7416002)(33716001)(478600001)(36860700001)(966005)(103116003)(16526019)(426003)(83380400001)(26005)(336012)(40480700001)(47076005)(6666004)(9686003)(82740400003)(54906003)(110136005)(16576012)(316002)(70586007)(70206006)(86362001)(81166007)(356005)(40460700003)(71626019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 18:03:09.2289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63379046-8f51-4837-2ce5-08dbfb3c996a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the BMEC (Bandwidth Monitoring Event Configuration) feature is=0A=
supported, the bandwidth events can be configured. The maximum supported=0A=
bandwidth bitmask can be determined by following CPUID command.=0A=
=0A=
CPUID_Fn80000020_ECX_x03 [Platform QoS Monitoring Bandwidth Event=0A=
Configuration] Read-only. Reset: 0000_007Fh.=0A=
Bits	Description=0A=
31:7	Reserved=0A=
 6:0	Identifies the bandwidth sources that can be tracked.=0A=
=0A=
The bandwidth sources can change with the processor generations.=0A=
Currently, this information is hard-coded. Remove the hard-coded value=0A=
and detect using CPUID command. Also print the valid bitmask when the=0A=
user tries to configure invalid value.=0A=
=0A=
The CPUID details are documentation in the PPR listed below [1].=0A=
[1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model=
=0A=
11h B1 - 55901 Rev 0.25.=0A=
=0A=
Fixes: dc2a3e857981 ("x86/resctrl: Add interface to read mbm_total_bytes_co=
nfig")=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
=0A=
---=0A=
v2: Earlier Sent as a part of ABMC feature.=0A=
    https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com=
/=0A=
    But this is not related to ABMC. Sending it separate now.=0A=
    Removed the global resctrl_max_evt_bitmask. Added event_mask as part of=
=0A=
    the resource.=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    5 ++---=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c  |    6 ++++++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   18 ++++++++++--------=0A=
 3 files changed, 18 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index d2979748fae4..3e2f505614d8 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -50,9 +50,6 @@=0A=
 /* Dirty Victims to All Types of Memory */=0A=
 #define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)=0A=
 =0A=
-/* Max event bits supported */=0A=
-#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)=0A=
-=0A=
 struct rdt_fs_context {=0A=
 	struct kernfs_fs_context	kfc;=0A=
 	bool				enable_cdpl2;=0A=
@@ -394,6 +391,7 @@ struct rdt_parse_data {=0A=
  * @msr_update:		Function pointer to update QOS MSRs=0A=
  * @mon_scale:		cqm counter * mon_scale =3D occupancy in bytes=0A=
  * @mbm_width:		Monitor width, to detect and correct for overflow.=0A=
+ * @event_mask:		Max supported event bitmask.=0A=
  * @cdp_enabled:	CDP state of this resource=0A=
  *=0A=
  * Members of this structure are either private to the architecture=0A=
@@ -408,6 +406,7 @@ struct rdt_hw_resource {=0A=
 				 struct rdt_resource *r);=0A=
 	unsigned int		mon_scale;=0A=
 	unsigned int		mbm_width;=0A=
+	unsigned int		event_mask;=0A=
 	bool			cdp_enabled;=0A=
 };=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c=0A=
index f136ac046851..30bf919edfda 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
@@ -813,6 +813,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *=
r)=0A=
 		return ret;=0A=
 =0A=
 	if (rdt_cpu_has(X86_FEATURE_BMEC)) {=0A=
+		u32 eax, ebx, ecx, edx;=0A=
+=0A=
+		/* Detect list of bandwidth sources that can be tracked */=0A=
+		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);=0A=
+		hw_res->event_mask =3D ecx;=0A=
+=0A=
 		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {=0A=
 			mbm_total_event.configurable =3D true;=0A=
 			mbm_config_rftype_init("mbm_total_bytes_config");=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 69a1de92384a..8a1e9fdab974 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1537,17 +1537,14 @@ static void mon_event_config_read(void *info)=0A=
 {=0A=
 	struct mon_config_info *mon_info =3D info;=0A=
 	unsigned int index;=0A=
-	u64 msrval;=0A=
+	u32 h;=0A=
 =0A=
 	index =3D mon_event_config_index_get(mon_info->evtid);=0A=
 	if (index =3D=3D INVALID_CONFIG_INDEX) {=0A=
 		pr_warn_once("Invalid event id %d\n", mon_info->evtid);=0A=
 		return;=0A=
 	}=0A=
-	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);=0A=
-=0A=
-	/* Report only the valid event configuration bits */=0A=
-	mon_info->mon_config =3D msrval & MAX_EVT_CONFIG_BITS;=0A=
+	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);=0A=
 }=0A=
 =0A=
 static void mondata_config_read(struct rdt_domain *d, struct mon_config_in=
fo *mon_info)=0A=
@@ -1557,6 +1554,7 @@ static void mondata_config_read(struct rdt_domain *d,=
 struct mon_config_info *mo=0A=
 =0A=
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32=
 evtid)=0A=
 {=0A=
+	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);=0A=
 	struct mon_config_info mon_info =3D {0};=0A=
 	struct rdt_domain *dom;=0A=
 	bool sep =3D false;=0A=
@@ -1571,7 +1569,9 @@ static int mbm_config_show(struct seq_file *s, struct=
 rdt_resource *r, u32 evtid=0A=
 		mon_info.evtid =3D evtid;=0A=
 		mondata_config_read(dom, &mon_info);=0A=
 =0A=
-		seq_printf(s, "%d=3D0x%02x", dom->id, mon_info.mon_config);=0A=
+		/* Report only the valid event configuration bits */=0A=
+		seq_printf(s, "%d=3D0x%02x", dom->id,=0A=
+			   mon_info.mon_config & hw_res->event_mask);=0A=
 		sep =3D true;=0A=
 	}=0A=
 	seq_puts(s, "\n");=0A=
@@ -1617,12 +1617,14 @@ static void mon_event_config_write(void *info)=0A=
 static int mbm_config_write_domain(struct rdt_resource *r,=0A=
 				   struct rdt_domain *d, u32 evtid, u32 val)=0A=
 {=0A=
+	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);=0A=
 	struct mon_config_info mon_info =3D {0};=0A=
 	int ret =3D 0;=0A=
 =0A=
 	/* mon_config cannot be more than the supported set of events */=0A=
-	if (val > MAX_EVT_CONFIG_BITS) {=0A=
-		rdt_last_cmd_puts("Invalid event configuration\n");=0A=
+	if ((val & hw_res->event_mask) !=3D val) {=0A=
+		rdt_last_cmd_printf("Invalid input: The maximum valid bitmask is 0x%02x\=
n",=0A=
+				    hw_res->event_mask);=0A=
 		return -EINVAL;=0A=
 	}=0A=
 =0A=
=0A=

