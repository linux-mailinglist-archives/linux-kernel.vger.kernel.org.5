Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B038800096
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjLAA53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLAA51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:57:27 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E2010C2;
        Thu, 30 Nov 2023 16:57:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxArqkr9PasZNZtHbGPUpMjbT0ugnQSWNlAOfHYLKA9U13nFiwUelwJJ29jPup0MqU9vgsWxS4jyFHW9EC+nzgkvGIpB9iM8A+ceu7WRpnBPIQ3FGYYpn5B6QVGu6Pzdac57E2GuaLez331uV7/LTN0mJtYGp/KuXVr6AsnYm7x58TmBTbuQeb8+VLGpUbQGhOHYQbqGV6+twI2sAcVFc6DKKPuwYTLqNnfgSaKJOhiz3/r5+VloGSOpiMAz1HuEA2BMmZsCn65r/VMwy7zUa5efrPaTd7ndJIxEAvdmEAvHFrKLER2d1fxhWuZd8gpFybbDQBFsjtNVQ/0KuijoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZvJbj2da+nbzaBDF0R+2JFoVFu1hrrj1EKbhfpjVdY=;
 b=QQwUEYZqZ3VKWTNuU5oKEKX8uu2l7F8HYo+Tgh5vbxsUAYwcvi3cx8KxhJIz6WTRDXkzMNAVZmKtJYQYc9Dsz/alVzJqAJ5glL9tBSVMNqzLytPrYoquQ4OAs/CgfTFoM2wHS9UE4fGo+Y+kfL2itIB7Szw40B7uAz7s3QbsSiKhCGRoHx/QSabkkTlRZ8fLpih2MgnturNa5CPf81bVv+de+JZWYoqnJp7AvJAnsBCw7KVy4csJa+Kpi7wevEkEZUPGOJ1xvNTjF0Mo/FMtL8M/IPxJgjqs2FeqFuN1t+JUc9uWiZlG/fuDgpgfLQG5MFytUmialGvLLU7gf9WYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZvJbj2da+nbzaBDF0R+2JFoVFu1hrrj1EKbhfpjVdY=;
 b=Kpoi8/gLS6lFXGpuFIz84c9FRvGGTrSCxLQUGxr+gDwbzrw/4DP6rQ0HnKuRDsZz4Tc+VsGfEjGAoO7Iz9qtLeE8wNVkuVBtgH+MH35xbYihJCHHqS3DQL0u717ErjhS9vbNG/Kq0jQENHAz/3SpmBDDOCGwgXHbpflfk88tnro=
Received: from BN7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:408:34::17)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 00:57:29 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:408:34:cafe::10) by BN7PR06CA0040.outlook.office365.com
 (2603:10b6:408:34::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 00:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:57:28 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:57:26 -0600
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
        <eranian@google.com>, <peternewman@google.com>, <dhagiani@amd.com>
Subject: [PATCH 00/15] x86/resctrl : Support AMD QoS RMID Pinning feature
Date:   Thu, 30 Nov 2023 18:57:05 -0600
Message-ID: <20231201005720.235639-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b3a7109-0fa8-4e28-c6d6-08dbf2087dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yoALEAxH/p2J/hNlC1mL+xzaS9064fBL4GuMcRe9wOatsG8vLGC8irdcj2lgzlOPFmw8ZQNXbLWJqh8I9X+wX4C0JksHO2b5wZxv7brk6cw4J21s6lHaNofG9zZYhgxIY2VFeIYfbepp6IMlZa+04ZY+EOG/EODxNZo1GsV5S9CZgOELbH+9gD56TFIAQMiLANcrQp0QO+G/n6iXvVXVWSRduU/vWzG5GYW8utyOdl1+dxwm+Td0KK8PaSLrncQTz77b20ySgm8l4t6KmuPVWXc1u2cEz9V9g4k8KhVxFAHx4whMpfPXTxCcBf+2DFDVQsSou2ZRMo5WX2jK5RtIk82fgoOJmsMSmI2sxupziJfumUGRrKNCv2xlVoP8NS0Rp27mHYMsr6nmVIhoC3gnGSibwg/dX8l3FX4EYeskc9FaJASA0q5xUGPm0QF3wGNvmgZDYkkACUEL9j2kCZ1iPrA85e4bq1EyQ2a+YGS21XQGGRM5y2GvjDzUEKkZdHvE3eWXZJMwzohK5mjKfqdqu2+fcglz4bfWnEJ6LfJqOA5VrOt0RYjGVsPEXmfWfsf0CfyjbqfoPmWl8zip0iVEsbheizEUt5DKOOHjyoCgu3Mg+X9hjIxWWVC/WgKIhspaqRsZm4rn1AKR/wH8LdUW/x7YGfm90wW5sqNamHZeT+n0xGOoOhN83sIdukgktZLWHGyWufiSaaa69I8O55gsolUUpjLvvYcBcfEIfC40QB3WM1LELRAnBPfKpc21dtoQJGxKCds/HEXxZA6/Q2RcM63RTmGckTJps4BCeCApTZU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(356005)(47076005)(41300700001)(4326008)(44832011)(86362001)(2616005)(8936002)(5660300002)(6666004)(8676002)(1076003)(40480700001)(7416002)(2906002)(26005)(110136005)(16526019)(7696005)(81166007)(478600001)(316002)(70206006)(70586007)(54906003)(426003)(966005)(336012)(40460700003)(36860700001)(83380400001)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:57:28.5706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3a7109-0fa8-4e28-c6d6-08dbf2087dbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These series adds the support for AMD QoS RMID Pinning feature. It is also
called ABMC (Assignable Bandwidth Monitoring Counters) feature.

The feature details are available in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC). The documentation is available at
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

The patches are based on top of commit 
346887b65d89ae987698bc1efd8e5536bd180b3f (tip/master)

# Introduction

AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
feature only guarantees that RMIDs currently assigned to a processor will
be tracked by hardware. The counters of any other RMIDs which are no
longer being tracked will be reset to zero. The MBM event counters return
"Unavailable" for the RMIDs that are not active.

Users can create 256 or more monitor groups. But there can be only limited
number of groups that can be give guaranteed monitoring numbers. With ever
changing system configuration, there is no way to definitely know which of
these groups will be active for certain point of time. Users do not have
the option to monitor a group or set of groups for certain period of time
without worrying about RMID being reset in between.

The ABMC feature provides an option to pin (or assign) the RMID to the
hardware counter and monitor the bandwidth for a longer duration. The
pinned RMID will be active until the user unpins (or unassigns) it.  There
is no need to worry about counters being reset during this period.
Additionally, the user can specify a bitmask identifying the specific
bandwidth types from the given source to track with the counter.

# Linux Implementation

Hardware provides total of 32 counters available for assignment.
Each Linux resctrl group can be assigned a maximum of 2 counters. One for
mbm_total_bytes and one for mbm_local_bytes. Users also have the option to
assign only one counter to the group. If the system runs out of assignable
counters, the kernel will display the error when the user attempts a new
counter assignment. Users need to unassign already used counters for new
assignments.

# Examples

a. Check if ABMC support is available
	#mount -t resctrl resctrl /sys/fs/resctrl/
	#cat /sys/fs/resctrl/info/L3_MON/mon_features 
	llc_occupancy
	mbm_total_bytes
	mbm_total_bytes_config
	mbm_local_bytes
	mbm_local_bytes_config
	abmc_capable ←  Linux kernel detected ABMC feature.

b. Mount with ABMC support
	#umount /sys/fs/resctrl/
	#mount  -o abmc -t resctrl resctrl /sys/fs/resctrl/
	
c. Read the monitor states. There will be new file "monitor_state"
   for each monitor group when ABMC feature is enabled. By default,
   both total and local MBM events are in "unassign" state.
	
	#cat /sys/fs/resctrl/monitor_state 
	total=unassign;local=unassign
	
d. Read the event mbm_total_bytes and mbm_local_bytes. Note that MBA
   events are not available until the user assigns the events explicitly.
   Users need to assign the counters to monitor the events in this mode.
	
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	Unavailable
	
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
	Unavailable
	
e. Assign a h/w counter to the total event and read the monitor_state.
	
	#echo total=assign > /sys/fs/resctrl/monitor_state
	#cat /sys/fs/resctrl/monitor_state 
	total=assign;local=unassign
	
f. Now that the total event is assigned. Read the total event.
	
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	6136000
	
g. Assign a h/w counter to both total and local events and read the monitor_state.
	
	#echo "total=assign;local=assign" > /sys/fs/resctrl/monitor_state
	#cat /sys/fs/resctrl/monitor_state
	total=assign;local=assign
	
h. Now that both total and local events are  assigned, read the events.
	
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	6136000
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
	58694
	
i. Check the bandwidth configuration for the group. Note that bandwidth
   configuration has a domain scope. Total event defaults to 0x7F (to
   count all the events) and local event defaults to 0x15
   (to count all the local numa events). The event bitmap decoding is
   available in https://www.kernel.org/doc/Documentation/x86/resctrl.rst
   in section "mbm_total_bytes_config", "mbm_local_bytes_config":
	
	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	0=0x7f;1=0x7f
	
	#cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config 
	0=0x15;1=0xi15
	
j. Change the bandwidth source for domain 0 for the total event to count only reads.
   Note that this change effects events on the domain 0.
	
	#echo total=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
	0=0x33;1=0x7F
	
k. Now read the total event again. The mbm_total_bytes should display
   only the read events.
	
	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
	6136000
	
l. Unmount the resctrl
	 
	#umount /sys/fs/resctrl/

NOTE: For simplicity these examples are run on a default resctrl group.
Similar experiments are can be run non-defaults groups.
---

Babu Moger (15):
  x86/resctrl: Remove hard-coded memory bandwidth limit
  x86/resctrl: Remove hard-coded memory bandwidth event configuration
  x86/resctrl: Add support for Assignable Bandwidth Monitoring Counters
    (ABMC)
  x86/resctrl: Add ABMC feature in the command line options
  x86/resctrl: Detect ABMC feature details
  x86/resctrl: Add the mount option for ABMC feature
  x86/resctrl: Add support to enable/disable ABMC feature
  x86/resctrl: Introduce interface to display number of ABMC counters
  x86/resctrl: Add interface to display monitor state of the group
  x86/resctrl: Initialize ABMC counters bitmap
  x86/resctrl: Add data structures for ABMC assignment
  x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg
  x86/resctrl: Add the interface to assign a ABMC counter
  x86/resctrl: Add interface unassign a ABMC counter
  x86/resctrl: Update ABMC assignment on event configuration changes

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/arch/x86/resctrl.rst            |  52 +++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   2 +
 arch/x86/kernel/cpu/resctrl/core.c            |  23 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  49 ++-
 arch/x86/kernel/cpu/resctrl/monitor.c         |  22 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 415 +++++++++++++++++-
 arch/x86/kernel/cpu/scattered.c               |   1 +
 include/linux/resctrl.h                       |   2 +
 11 files changed, 562 insertions(+), 9 deletions(-)

-- 
2.34.1

