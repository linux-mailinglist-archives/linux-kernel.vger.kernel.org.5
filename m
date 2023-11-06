Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7D87E1BB0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjKFIIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjKFIIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:08:22 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2105.outbound.protection.outlook.com [40.107.104.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509A7DB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:08:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jABnNf5cr3gnnXwfCcnpXYQtZnwVkS+8SCj6xoBWAacgtmXtR68L2oD+OSnIAN6jiNPX0nqpzW4Oq1otb11ZcWUgTzyofSDecIb91u3zxH9AbwFnUYxX5/UyzUN2nMopSnHsrwFc+/AkTTothY9bzxKMAF1cKGcEuVTTFH8AjEqZuM/fs2bfgzgImuThVs0awwLzRIk5Z8idr/Egp4yHyq3dUtanju+5/dUAKusPRjxo6+FUMtSq4MqdzgtAwyc0M6hS2bdTdy0swSA4Zk0sqTLFZ670DamkiAYDPyI/LdEYmC9i2cCUi0Nq/QED4l2qmCkYTQGnXGC7f+3bcjIRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnN4oJmgV8AQzjnmkTCKGAkwbd2OzxkbjPRfXusZ2/8=;
 b=lp6LHNSfjxwXKqmPgXkWPBgPG6z4zND5Vm+Stx9AvHuki0JGab2I/pxvZhHDl/2X5raA0HIwPTUXhsABYRpREWwkfTu8TZmK5oWwgSJMk/xyjPl5/haz+h40W3HeIYP9k/1B4DLkW+cNid0gWpVjr0Z9vPug55cHKWyQIAPFQQoiEgthuGWWaVACnxwgqoRhSpLdx/hssowZAdAc10Hs7Z219Zwr0Hqxy7ELVImpUyMGPAnemTKnsGOCmlD51GTzlm9yInCQiVN/eJkzv1D2DeQ2eZMGd7bA86TU2tjWjpnq2aE/05WjWq1QLA2m8BEZnBQ9oGvcdgD4AD0QY5pU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnN4oJmgV8AQzjnmkTCKGAkwbd2OzxkbjPRfXusZ2/8=;
 b=MDV+HGhnIPxrDO1MqHJVH/jGcqSVckdpOTBVKumEkdDKNlj9gYRTS3AiIuMPbwKvkvCcbPj2wu8XUOg6FYwj4AiLH6uS83W2spJ/I6KYrbcqAEHtiQ/XC85lrU06JegIXlTXEs9zl2HAdvtESQ8gIgqwCPvfaBf7a0rsn6DlO/uOvG4yHv0fEzy9eyKpF4U/KPkcigXZXSVzLLyO9xlaRbSefygEvxD0yHCVFbMWclqcRgnF4y12VQnPwH05COorbRmQIvyH8Ac74+SO939P7GQ0sIm8+J1sk1T8CN5Rim48UyVZy9Hl9Opsr8o3F5BVdmT17NSjk0TBH9hREgOe9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com (2603:10a6:20b:1a2::10)
 by AS1PR07MB8565.eurprd07.prod.outlook.com (2603:10a6:20b:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 08:08:15 +0000
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::bd44:ff70:6237:b6ea]) by AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::bd44:ff70:6237:b6ea%4]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 08:08:14 +0000
From:   Stefan Wiehler <stefan.wiehler@nokia.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH] arm: topology: Fix missing clock-frequency property warning
Date:   Mon,  6 Nov 2023 09:06:21 +0100
Message-Id: <20231106080621.12452-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.31.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0301.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::13) To AM7PR07MB6705.eurprd07.prod.outlook.com
 (2603:10a6:20b:1a2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR07MB6705:EE_|AS1PR07MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9684ae-b26d-45e6-8c67-08dbde9f86ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LGe2+y4PR/JE1SeBTrufz0eP+3XB1WwIU7aq/WwhHI/JlBdjmbSalHOBaWbYdWqJKuWKvaNiObPtvjoRb1BnmoLeTQs79CGK7CaUQwkKJhRqu2JvbP5roetovhRx99VLB/NRnPsytIAV0/JgPwJ1Z/4fl213UvzWAIE3NOf2OaldDAIpJ+stYbsoVoLxuunG13alOKnTZ4cEu5tVgjcJZIW5AoR/rm45/8L2AU8snfaudUwqj6G6lOfSpcgz9LmQKATb/fYlLtY6M2cibrwiYoQak8yBgFsb9V1pmis6z7mCx0QkYlUPRVOKqJ8ksdX35jjp2z77quFtlQMMN5WXb33mQuEzQxL4/7UBKrVvwxRNOGwWzXymCG0/WD8vRVpAq+IamkhpaAw3cWAnIqxhl84Hd1YwQeirpLgCcapK3rsHvWePauw+dhtTFnIR2ymqbj8MTqXj7qT+T0YZf6/6ZQs29ymgqmhTtELWn/W00QvwVCdfTgFWQPLBShni2sz+SVGnB65/E5TiCUaKsC2Ngdga0J7jZMwzWUYxTRrVaETBVR0NopVAoyVqSpHKuJDSNLlxf1zu//XZuFeZe1EiJ/3B8a6A/RShsovp30IP6tp23e7SmZZuVnO7zPqxvKnuiBM+wfDoBJ+IWq1YAAiP/6je8iyQqwyAChwupeiC/v91msFpxuilj4rySYcQOWpr7LfFivQinqOWh9fMD4Ac/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6705.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6512007)(2616005)(6486002)(6506007)(478600001)(52116002)(6666004)(38100700002)(36756003)(86362001)(82960400001)(5660300002)(44832011)(66556008)(66946007)(66476007)(83380400001)(2906002)(41300700001)(107886003)(26005)(1076003)(38350700005)(8936002)(6916009)(8676002)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tgHhpSeVuQiq52JiplZImkwrhXmjq8fqDt2kb4l/n61X117P9h0BzlLuyE1Q?=
 =?us-ascii?Q?4zcwF96VGuVSDBKacbZ402pJjF90cidMi/QtPiLovusTZ6LE7J+fWWF0bZpw?=
 =?us-ascii?Q?isD4yKRuj1sD1N+HOSsud6C16OV8/xtWx1xVgTyigbHMmOg5s/qhZPklk8nI?=
 =?us-ascii?Q?Xoy+TJ8VdiovERXM9YjxNQ94sj9VUUhLZMVepugYfz6+TQZCGRlgHaqEUCJ5?=
 =?us-ascii?Q?67rctuTXxu50bPcUg4cjSWx6bmVZXTJrEeKB1Yn+7qh6WdbON/+6HU+nfxPB?=
 =?us-ascii?Q?TtQf3HZTveA2oCu1MgPyUh9oGsJYEe+9vFkTrAVQAxGIuSCB7+PwYuL6p/mV?=
 =?us-ascii?Q?neMkwtvrAEfIHuYHwwswjr4F3jdMVFjcBOQe/VKalbPrmI5Lhbz1RoG8pjCW?=
 =?us-ascii?Q?tVd0/9V0u1vZrq9UfmI7WkXOW+glZ0bhHD/jBDv2d1kZMcqROLBBuOiuYziO?=
 =?us-ascii?Q?20g4Nbmciy3UyJm7imjjWtr8LfWqHSoQSOjVpjjwF2+Y1JtSqnPh6iNwzXuw?=
 =?us-ascii?Q?nPEnXnRhAphOcsfVEzi7Ho7MbfEDLm9L0ijELiIZDi/WncbU2H85+Wv5ifs7?=
 =?us-ascii?Q?ugO/nS26z/ROeYgsiVBsn0dlnM+pADX+SN9Id2UAYlwWX4u2zsBvLImfVFgt?=
 =?us-ascii?Q?EXw9+EBpmCcWk8nAJEF23+h2J1/CVk+KuQ4zH30533RUhSSIoYX0gE67Focz?=
 =?us-ascii?Q?l1s7cp2C2yQ+4LOAIzL29KkcTS60/z6oqEO2Wg8ZxRlgyZ67/s7NFaIGSHWW?=
 =?us-ascii?Q?rVlJTuGzNnJdYla2RpBA1OsO+FBQ6RAdV+m/1g/bQYahF37gjrQ213CKUfYP?=
 =?us-ascii?Q?SfzJ53wCLe9BErFUqoLvIAuaHzICvJzw1I3/UqEjYf6nYP9OUkTiXUKE0yHt?=
 =?us-ascii?Q?U3QgQ3p2jajFD5RQAa8RUc6t+qjznPHpIIVDZ20/FAVfL7dPfJ0Xzb8M+huA?=
 =?us-ascii?Q?muLeURPcQMeN+h0of9X4N058MwUE2+dzookN+bwWHTLVeG4N4tT8PavkJAwf?=
 =?us-ascii?Q?g5f3oxj+u8m/Q+Snk9l92lGf6Endv72ZeaUIeL6lCvalvJsSmgwIn/Sov08C?=
 =?us-ascii?Q?/TxnWx1s2iV2m3+TGgICpW9l/o3h4xhDKV3/2awyLaNqxdyBS7Uqn6awG8yq?=
 =?us-ascii?Q?QofvDgCc+lKXr9NgSr9K0/2HIZn8hxTJjnDeNM7Pj+Wf3hPGriOddvNJCm7U?=
 =?us-ascii?Q?wBsvL60XgtalYLnDzdrXoikAjfZlegqUZ5MvdlH6S0/eeHckmmSL0uIvD2UP?=
 =?us-ascii?Q?QInHoN2bnyoBb7wxvJTs7685vzxmfUVs0T/h3C2246NtERR4eFBc5cI4LKHA?=
 =?us-ascii?Q?84PhtU2AemOSXvx0xIKveuBUjoBo2a90mCsC8ZeG9JkMxqVm+SHk1DuEz8SY?=
 =?us-ascii?Q?rSW0Wogi8TgCX/NU/hwNyok+RVTC97u05yTGYWEYA6NTjC/UveGC320IjqDz?=
 =?us-ascii?Q?hpmmWHB3qvCth++pAneXuj9EaYTB/3WQzJAKko0QmuPiSHbS0o8iHWJEeVB7?=
 =?us-ascii?Q?b5ec9RYXxWO954wWPMOw2qBdf+RitYxjgf31noDCuMQLJ3s+z+mh/8XIRPWY?=
 =?us-ascii?Q?j7sIbFi36QjOZ5H/PKXIWkOHmp+QMdvJpNHWqrjzNV8A39H49VFSq87sro4W?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9684ae-b26d-45e6-8c67-08dbde9f86ec
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6705.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 08:08:14.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDjLL3SWtJ1jgQE8chSrnkHLRlT8KT368Qney6net7huWJBb3t7p7aA8W+0Kict46MsPm7fuDXy0cBOeTV9WiHrLWLvazTFpSXEtFLRLxVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8565
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the clock-frequency property is not set in the cpu node but in the
parent /cpus node, the following warning is emitted:

  /cpus/cpu@X missing clock-frequency property

The devicetree specification in section 3.8 however specifies that
"properties that have identical values across cpu nodes may be placed in
the /cpus node instead.  A client program must first examine a specific cpu
node, but if an expected property is not found then it should look at the
parent /cpus node."

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 arch/arm/kernel/topology.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ef0058de432b..32fc1c8d9d11 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -85,15 +85,24 @@ static bool cap_from_dt = true;
 static void __init parse_dt_topology(void)
 {
 	const struct cpu_efficiency *cpu_eff;
-	struct device_node *cn = NULL;
+	struct device_node *pcn = NULL, *cn = NULL;
 	unsigned long min_capacity = ULONG_MAX;
 	unsigned long max_capacity = 0;
 	unsigned long capacity = 0;
 	int cpu = 0;
+	const __be32 *common_rate;
+	int common_rate_len;
 
 	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
 				 GFP_NOWAIT);
 
+	pcn = of_find_node_by_path("/cpus");
+	if (!pcn) {
+		pr_err("missing CPU root device node\n");
+		return;
+	}
+	common_rate = of_get_property(pcn, "clock-frequency", &common_rate_len);
+
 	for_each_possible_cpu(cpu) {
 		const __be32 *rate;
 		int len;
@@ -121,8 +130,12 @@ static void __init parse_dt_topology(void)
 
 		rate = of_get_property(cn, "clock-frequency", &len);
 		if (!rate || len != 4) {
-			pr_err("%pOF missing clock-frequency property\n", cn);
-			continue;
+			if (common_rate && common_rate_len == 4) {
+				rate = common_rate;
+			} else {
+				pr_err("%pOF missing clock-frequency property\n", cn);
+				continue;
+			}
 		}
 
 		capacity = ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
@@ -154,6 +167,8 @@ static void __init parse_dt_topology(void)
 
 	if (cap_from_dt)
 		topology_normalize_cpu_scale();
+
+	of_node_put(pcn);
 }
 
 /*
-- 
2.31.0

