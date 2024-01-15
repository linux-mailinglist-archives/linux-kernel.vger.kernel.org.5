Return-Path: <linux-kernel+bounces-25839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0B982D68D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C081F235AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA4FEAF8;
	Mon, 15 Jan 2024 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="mB+DYBqN"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2118.outbound.protection.outlook.com [40.107.223.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8534EE568
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dt8tz71UVDl5iYOGnWb//z6YOHCJ33Q0gSxtO7qHvG3ZFYX641wbaMRD8EcYU/8vB8ExxrxotuGfLiZZtIg8BJ5+ezqRqAA75MsFSfLTyXa/TtG38IvZgqY4pWO0pvHvtsl1HSacQBVCU7mGl0RLxN18Ai9sKi95K+Q6xyPO46qx4qCgcRimnKIs9Rw/I5/e4/v0PwZ63uN9aZRO5gaz178LzpSbAH/kYBx3hxuI062CWtgN/11SD03sYnLALA0obIp6VzTDJshB8kqi/Le6g8A4VzogUBOaJBcaKu/v5mirOIGqiEw1HoXMJA+Iop4FiUJdMzwRKnLkQy+7TuPK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4edG5ODxdNR3/w4DRFs6wvWeUoyYhWeNm6G9TwZX3g=;
 b=TCAot1rCT6GH+/cGTR/DTXWaSd5Ov00HSlQvcWqF47K2DwRjcHynhr2tFM9MtLxwxvlJETC2KKJHkDqZqFmk/1VOFleIVHORDBorJMVcevFWYZeCMYQHBwlB40AsRe9xU1s11Vj8w+LM5+RHfXmHK4nynUJOYzS1/J4ecbEtqdm3qIgZz7dsXZqTSef8X12kQHzzWL9bkFs/ulIYeMjqgdLjwXkSXQgW+z8vDmmRoKC5MYILsjafcD4BP7K1tzy+L6+zhvI18VECG05QEK0Jd75YUqrnACxldlS13b3BOxG5vAOf82QKBaJyMz3DontIb/ssT+uu9K6DidfbVUP1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4edG5ODxdNR3/w4DRFs6wvWeUoyYhWeNm6G9TwZX3g=;
 b=mB+DYBqNHBsVOqCl8PQyVEtIX7LsAPoxzJr1i/KQMk2ekjppgr42+JvyYdLBbJRDlbXfL38QYIqWhwQpn6CF6ZN7JuVAclBil1IwehR9N3HiosnRqrwah2gA1ltzyFaeszORvH0nQPzdx0Fpj9TP1quHp8ZQiJKF/WMp8vZKQZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 LV2PR01MB7885.prod.exchangelabs.com (2603:10b6:408:17f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.18; Mon, 15 Jan 2024 09:59:59 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a])
 by PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a%6]) with
 mapi id 15.20.7159.020; Mon, 15 Jan 2024 09:59:59 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com
Cc: patches@amperecomputing.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] arm64: implement arm64 specific cpu_to_node
Date: Mon, 15 Jan 2024 17:59:31 +0800
Message-Id: <20240115095931.53765-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::8) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|LV2PR01MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b49947-bd7c-42d5-ada6-08dc15b0bb9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DZZ1D0JxaDbz8JPc1rpjSJgk0+xBFn7SBHDs+z3OFQ3U3FoVI9OpUTfjttjnOPPrncY+o6qqb6GO7hZ1LMvB0QA0NP61HNReuaEZrmk2LVjeG5LiJ+fFUbmBDWUrQ8cimZoVEjO/6oYT5qtIhccZjH9jUleGS148SOU2l+kPWfTLFWWeOw+Mu1sCtJj5sCw3K1YXFy24PUY3L20OBEMVTwDTQqMFmjcW83InLc0syy5WMxxx9I+cz47iQrd4QowuG+J29tHlasRZ9/Ii+A9ss4YUh4BRe20hpw2+Buvym8ELmzUvm+XEMSWkeRrdveA2mod+pd0msOn5n646NQyLZ7Oe8C8919hHry54KEI0FFQbYNXpO3yXTTLZhEdvfs9IZIdrTyEjk7aNaORK2NhxEuQUuKpGEW9HR7il7gs3K1quwyinxxhaZor1K29hJsU1lCKrQ1Q/TWK7+2DbbcCVg/2O4bRAw480VMiWYbKLnOeiopHpAffayDszHNZaKp0vWsBv9YiJ9SYyzbL7EyQnVA4knwon7VbAEz5Mm4SQW3QIB5AT25gGa02al8QjpqAlxaLYbIQ7ueJ0dgfr6DE2CgEMS7vznyxi0mZBITjjFh8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(366004)(39850400004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38100700002)(66556008)(83380400001)(2906002)(5660300002)(6666004)(6512007)(52116002)(6916009)(6506007)(316002)(66946007)(86362001)(41300700001)(66476007)(38350700005)(478600001)(966005)(6486002)(8936002)(8676002)(4326008)(107886003)(1076003)(26005)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JjwzJLmpnfuiR6E66+9lE4ORoyfMTcB60AcXdQjY2mkVl27DBBKbmST9JaU5?=
 =?us-ascii?Q?5zCSkY7GwStlU563YhpKY5CvBvZr+cXf50TGv+NzdoIxPH1Y3aPj6dGgsGH0?=
 =?us-ascii?Q?hw/9tdhxA+coFMfgYSoQrRgg0xqOQMpKdX+otjaou0C/AHtZmZ0Yky5Im+w0?=
 =?us-ascii?Q?FStCMPHz3Q0SLkdrC24nQf17WUXASHNkB4gD2zDcOplKY0Xu55hnrFUZmwCk?=
 =?us-ascii?Q?pW50QDrlDgnF2vn+4FcqcAntpi1l8fUEl5TQiqV5VsmNZ807az2v1AoitAIa?=
 =?us-ascii?Q?pob1bMWZ2rU6KNFjaI1Z7DGVLqUTUX+x94aBMZYq677oQ4vp2BFUjiG8H+sL?=
 =?us-ascii?Q?+It+B3ZxvRxNvnb2W5tv8YtbLjkRgmRbh8EZO/kj0yUCu22X6qZW5TfNKOkK?=
 =?us-ascii?Q?IvgPfnR9iuYK1kOBw3LMOaWAiNG1CyDts0KFsD+ZNnjSBicAT2bwvKu7jrlv?=
 =?us-ascii?Q?qO6JMDezseHvSlZS7W53an197squFSrHDnp1reeNu9dJjMNmSJoatVAMuT8o?=
 =?us-ascii?Q?Sud6+FUxJJoLfB/6O4ls/vOHVkaDkbpl/7JLCo19SCGLPpyNt6dORK3iU8Ip?=
 =?us-ascii?Q?KNuxjHo8PJj8tSuJrN5XbjgLtj22+LMS6brfoLSRBCZGp9WUB3BaKC32S3vs?=
 =?us-ascii?Q?X9Q3LfPJRCevlNw4U2gC1quvZcp5yOK26noR3hysREWGl939aZyR1muex4wY?=
 =?us-ascii?Q?KMFKr1OIckN3tzh2aQlMNua4FFJ1dQlK74oDh81EkLhPN7SSgeDnOjk0JAH3?=
 =?us-ascii?Q?jlH2mNh0ThuWuUgdAHmjpojuJkmYsd9qo1IqfFSaN9XRWZoccGq4P4h7xw3w?=
 =?us-ascii?Q?5Rc1YGiyOYpe5nay+U/hRq/SYnVfiu2ADCuZJs2AodpT6x84At/UFKWhqUyx?=
 =?us-ascii?Q?KPVRdWN/csVVtmMLG6czTSrkTILhQnn44kJl7RLjkximOEtBVggtztz19RCg?=
 =?us-ascii?Q?0rmsWYLYmNU3jnvFp7tNw69ZzFsC9WD1aNmZ0e+ugqOifZw1LIEDXdDyuNeq?=
 =?us-ascii?Q?ACDzei3bV3Z6LlI14nQ4kXWO2qzZgEzerfN35m1zeacV18LmCrjbEdeiDkov?=
 =?us-ascii?Q?+ojFk5SqG2nh/7+hFwb0W7znrOrBQ3xh552UmNgLw89o6c42D4aLbRp8jSQL?=
 =?us-ascii?Q?RqQJhVj4OuMOKL8YBWIB2ugREZAUvx9eUMr+8MKnMhZ3nzUpe4sRrhSLtfos?=
 =?us-ascii?Q?EVk7CE/tLrp7cPNI97BB5Td8hUujnvYw0tEiRoBb8/Pzi9d1X0JrGhImqCTa?=
 =?us-ascii?Q?vEoVszGNnQZ6hK2IWnickuQwiXAZyh/x9l6oBJtAgc7RMitFwTx32QQCBGlk?=
 =?us-ascii?Q?jFgXBRXWdbLiWRQS/1R+i21OX/FS/PImak+/0rUO08OULGWGaJp2RwcRz8up?=
 =?us-ascii?Q?I/v1tW83YsPkVKUAxfHKaHqwNROouQV+5gIaghz1Wv0EN262VLizHlmBa2rj?=
 =?us-ascii?Q?r2j3Agi4cbj9VcYpyYh6FAFhrMeF3zSW9KjMQXPHO4H1lSL7iziOiFSAKdiW?=
 =?us-ascii?Q?xaiCtTHpTUPexZ6w7ywN45opl9tuNhlgMzIJ58LSIHp14iATLbJTka2Wt7rf?=
 =?us-ascii?Q?yE+SzMCOOKpDSQ8fVJRzSzEwljepNzjCSZB9xaY10hTTPleHEZKINSz9MPLb?=
 =?us-ascii?Q?IYXR0mZRKYslxX/oCmzAYkM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b49947-bd7c-42d5-ada6-08dc15b0bb9b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:59:58.8728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tx+WIeDaz6M6CbTcdmgJ9dQ2pz5AK3LkyHHI9wpIloy3GpPQizCThgXlpTz+9kHqZFbEBinEyHIuB/RqjjNV9Mr/plHFqxJz8SJBor2xv9NyKtI3LJcFyGNS65GbMtzb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7885

After setting the right NUMA node for VMAP stack,
  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=75b5e0bf90bf

I found there are at least four places in the common code where
the cpu_to_node() is called before it is initialized:
   0.) early_trace_init()         in kernel/trace/trace.c
   1.) sched_init()               in kernel/sched/core.c
   2.) init_sched_fair_class()    in kernel/sched/fair.c
   3.) workqueue_init_early()     in kernel/workqueue.c

We cannot use early_cpu_to_node() for them, since early_cpu_to_node()
does not work for some ARCHs, such as x86, riscv, etc.

So we have to implement the arm64 specific cpu_to_node().
This patch
   0.) introduces the __cpu_to_node function pointer,
       and exports it for kernel modules.

   1.) defines a macro cpu_to_node to override the
       generic percpu implementation of cpu_to_node.

   2.) __cpu_to_node is initialized with early_cpu_to_node() before
       numa_node is initialized.

   3.) __cpu_to_node is set to arm64_cpu_to_node() when numa_node is ready.
      arm64_cpu_to_node() is a clone of the generic cpu_to_node().

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 arch/arm64/include/asm/topology.h |  4 ++++
 arch/arm64/kernel/smp.c           | 21 ++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index a323b109b9c4..3e99b40b5f9f 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -12,6 +12,10 @@ int pcibus_to_node(struct pci_bus *bus);
 				 cpu_all_mask :				\
 				 cpumask_of_node(pcibus_to_node(bus)))
 
+/* override generic percpu implementation of cpu_to_node */
+extern int (*__cpu_to_node)(int cpu);
+#define cpu_to_node(cpu) __cpu_to_node(cpu)
+
 #endif /* CONFIG_NUMA */
 
 #include <linux/arch_topology.h>
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4ced34f62dab..8a3bc101eaed 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -90,6 +90,21 @@ static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
 
 static void ipi_setup(int cpu);
 
+int (*__cpu_to_node)(int cpu);
+EXPORT_SYMBOL(__cpu_to_node);
+
+#ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
+static int arm64_cpu_to_node(int cpu)
+{
+	return per_cpu(numa_node, cpu);
+}
+#else
+static int arm64_cpu_to_node(int cpu)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_HOTPLUG_CPU
 static void ipi_teardown(int cpu);
 static int op_cpu_kill(unsigned int cpu);
@@ -613,6 +628,7 @@ static void __init acpi_parse_and_init_cpus(void)
 
 	for (i = 0; i < nr_cpu_ids; i++)
 		early_map_cpu_to_node(i, acpi_numa_get_nid(i));
+	__cpu_to_node = early_cpu_to_node;
 }
 #else
 #define acpi_parse_and_init_cpus(...)	do { } while (0)
@@ -674,6 +690,7 @@ static void __init of_parse_and_init_cpus(void)
 next:
 		cpu_count++;
 	}
+	__cpu_to_node = early_cpu_to_node;
 }
 
 /*
@@ -733,7 +750,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	 * secondary CPUs present.
 	 */
 	if (max_cpus == 0)
-		return;
+		goto out;
 
 	/*
 	 * Initialise the present map (which describes the set of CPUs
@@ -758,6 +775,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		set_cpu_present(cpu, true);
 		numa_store_cpu_info(cpu);
 	}
+out:
+	__cpu_to_node = arm64_cpu_to_node;
 }
 
 static const char *ipi_types[NR_IPI] __tracepoint_string = {
-- 
2.40.1


