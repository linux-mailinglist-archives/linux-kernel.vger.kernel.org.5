Return-Path: <linux-kernel+bounces-17849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C1D82538A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8081C22790
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B632D612;
	Fri,  5 Jan 2024 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="ZaiWlGJe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2104.outbound.protection.outlook.com [40.107.247.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB52D614
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arbbog46fQaMO8DgDcWx+iN/jw31f0omWnOzmETwDmOi0Ttl4UT7xHZtt/fIB+qjcGLvNnx0353q4DIVYH/t2K6KMVpMEFpiIbQw5eRcTxd6O0pN+93rMFPcWvemaJ6B4ICisrcR3XZuNPTusfZeHMgiEg4JOSHFMNF+btEc/ukJLto/2li3uwsb3RrSDJFwF/h0f8dWfBzU7LINlRrlvNIQkgYueerV2wL2+i/qEtpk3r2SSW2YNQkDegHvC8bRA1PFV9d8fjlyrU7+QzWHQdSZdBSNGF9otuuC7ydd33eoiz6P2TzijpWiRG5QKbOen7gdzGjjHAD/wS0VaP0vAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTYjn6ZRFWRT2GcMarkHWIalYyRKHt9eVBV0oXaBeF8=;
 b=X+wAXM/Eai6Cr4kbhla78oE04wve5xup2LPwtPLnQ3fI6j6cpKdO9JD9h08dRk/zTxZxx3Q4MLsf9pfuEIf9P08hEo4LlMt4l8HH9CZ8HStXM/z+u7O5lFeiX7vj8szZyPD2rtD1+mY4zSfL0XcLJUDLFJg9tEi5oKbZ3NpuvsThYcDS0kf4Tw4UQGJD9/6lEvaR1q3+HUkrXhp3OFJC6KRXVGILhQf1zu/LGVLGtiM0wchMn8E9coFz7M56BkfWvXEoc1rc+J5Bas58NcyEmogJpW0WYK1q7EAIaFaV7e4IEfFmbq1deBMUV3C0VQ5ba9EQn1Lg1v89atFIdQwYOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTYjn6ZRFWRT2GcMarkHWIalYyRKHt9eVBV0oXaBeF8=;
 b=ZaiWlGJeWrJa8Z1NYjbxCWWp6Z4JoMx4OCo0Wi4bh/FNxPLvonTSZNAvfDBGf+oXERtB3trTPt5adaKBj4ZPbmxzoZCP3C2qFk1U4dW5zMdfS6ZWyFl+H9+/vW/+1yosPTcVKz0/Um8A2k9GWUejmAzsO3BNczKG7O5HVgVPZqAkEAGI2nr71u+le9X77sZNwmijy9teb+KJ7nngFXg0YD+AaQRMGxMM0DKLyRH8XW8tqGssvM9gTm9rD5zKWgBDxrYLgryahOBRaEu1STrsVt4Tc40EZTFpTL3qv7SSuSKXdZsM1G6EkJuT8axYYF4GE9koy5yUpdrluHostXVHTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com (2603:10a6:20b:1a2::10)
 by DBAPR07MB6552.eurprd07.prod.outlook.com (2603:10a6:10:18d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 13:01:37 +0000
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::67ef:e773:9ef2:a653]) by AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::67ef:e773:9ef2:a653%5]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 13:01:37 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH RESEND] arm: topology: Fix missing clock-frequency property warning
Date: Fri,  5 Jan 2024 14:00:50 +0100
Message-ID: <20240105130114.3499559-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::9) To AM7PR07MB6705.eurprd07.prod.outlook.com
 (2603:10a6:20b:1a2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR07MB6705:EE_|DBAPR07MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef32067-f961-4c10-6d4a-08dc0dee73c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S3uCrqqqTETTD4++f9XB2Q3rh/Ak/TMnDeYcnU9x43Jz3+tP9qow3plmDSmPrmOWjSoaDBXA2Fwg0cHzgO7Fk3BpUUD4rA4f9bNqMfTnbcmRYzcGelaJBi8bRH84ojeSGFnYFRG++kWntCwQpiHbh6UqE7mxbB3Lja2RreY5nJB5J1CN0PiVhHfkijj9Q+VlBvc81prO0DwrE1VUVdhZnba9y0rBhjHY/eYdPkFaKUldnE5wchzG63dycXdN/DQWT6GDvxSaF80gsANWidyHHqm/nuDpcEa7wZc55QAoqgO1aWu4qs/289LoCa+cXLuUsrYX7DcHERGjI8+SwlDaUTq0/z7iWDpSm4RmLUnFmWd+DpAr2pJxJ1cOHjs7AJs20ev0UvyCDlOMBIiSN5TC5Q4xPErznmaGFb7RILPJ7qHNX/cd4vOOUqD/6laUzCyWYAcCYeFrZk3Rif0Cq5a3DQP1EjhMP05gCeU6ajsCouisu0PUFr5wIybO7VLiBz18aXvdQdpkjvjheqcdQqIBKJyyH5FqeHjj29cpKgXVQaWmO7/NDpJw0mP8OE2yG+2c3rSL3SxjnSTrZsslASJfDiXn/WY73Bee90XMuNAzQbZxr7dqPv1fNU3/w2ORI6tKO6TSzxWKTKu69c/9OlDsOJeoEq7lCL3eymI9w/uS4KBEZOBWqHTteJ1SIyeeUE3GuEfJzK8een6LVeVNdkl/Dg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6705.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230273577357003)(230922051799003)(230173577357003)(1800799012)(64100799003)(451199024)(186009)(8936002)(8676002)(44832011)(4326008)(82960400001)(316002)(66946007)(66476007)(66556008)(6916009)(2906002)(36756003)(41300700001)(38350700005)(5660300002)(86362001)(2616005)(83380400001)(1076003)(26005)(6666004)(107886003)(478600001)(38100700002)(6486002)(6512007)(52116002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0ypJ2AyHbLm8lruwpXg1sxkP29jPycmDmcfqb4qc01qRPHDvSgBRciltKLil?=
 =?us-ascii?Q?s9Hsxq9hoKpJIcCvVHDu4PfaBDqpuXttaxh7HJE4/B5g5yLJBwNY3yAMH7l7?=
 =?us-ascii?Q?VMLPxCGtckHPZ+0OYz0PqV8ZouaePaYllJPXaiqY601WXQu1v06nGza0GnZ4?=
 =?us-ascii?Q?+1PWy3VbgBp5XnUOUzn38ZnowvUnznvp+OvMj2xKKnoF/90IvyOdh2NwRskH?=
 =?us-ascii?Q?ILyfFyMZx/QbrOXkrNDM7B0gIR8JcMaXutKmHjDQ3Sed6nUqBPBBaqxBbyEx?=
 =?us-ascii?Q?P1J6pskt+yBAi8GC4q2ALSl9YAF4JcxyBk1JPX+4fu345ta+uQtcxa51nZrb?=
 =?us-ascii?Q?2m1w/ZK00aGdpGRzmVQMnuItW/NlfLTqIaWtDknSU5xo8KBGCkeyCthg/AU3?=
 =?us-ascii?Q?QarhBuQttJKYYzNxLG2UrPD3AwX64gsi3qvNSWpnqjvfMuUXdEkqufP4zAPk?=
 =?us-ascii?Q?43azfmr1Wrh69nNsPwIAfHwmO+bzDPGlg80mofj+O9BG2vMBBVCXfValYiAr?=
 =?us-ascii?Q?+U5/xWW4RXKr53orU5CWQqe2FmqWd9PerwOs1VQ6EoVvs/pC/hK3WClAwW2B?=
 =?us-ascii?Q?5tWlzV21N9WQu7/iyXV8nEheSL68UZDx2NP0NXVo1oXIvtLjOo+5j8rRClyD?=
 =?us-ascii?Q?mRH+FFwr6vGckAnzsKmXGlmGEvJLXfbqSguGEUbv8JuejbALGZpBncQQ5kc5?=
 =?us-ascii?Q?YjLXx/VWnXiPxzKxuHu8vuLxIJGLnGX/CM+BG0DfuZKvfRKdu+A/5UT/Gled?=
 =?us-ascii?Q?/O985oTh3PcU9RmhRnZ1kPz7jxvJTkFHlsjjWV/7xbPtnYI9tHxYuB4LUThs?=
 =?us-ascii?Q?MS9hG01LgFtzHgxGtj5YHQN8YWbAjiUxVgrs5ZC3ELEeDUBIui/tSAMbBdi4?=
 =?us-ascii?Q?TUL59xaBJjueTxS2T3/l+2uVKYEC8iSvfyWnIQDl7NvjzsgN+UYMtLFf9D8m?=
 =?us-ascii?Q?V9SMw1BwjNhPT62dXQ2WE5thK9BG+x3vXvmC1Hnj11iK2bAm7J0YOf8dVaiv?=
 =?us-ascii?Q?PDQXFz5E+EsEVhJ9GAA4WgzTAHpuyaupqWb3P/NuDvyuTsfGLcdUbK86eIwl?=
 =?us-ascii?Q?hlulLi6EVND7942sU7XEoApPijM0SQmBvk595d1eXgI+5aaEClq+gjyLBQXn?=
 =?us-ascii?Q?BIbpVxmBaWhGDePuvRaUauU1moee5/iSCw87NYy3FE8RhYflUaynl95oR7Yy?=
 =?us-ascii?Q?M9tx2naG0ApRrc+81sJgT6N25i8PLxmBJol9ovLRHzQku0o9kXb3rXCQ74HB?=
 =?us-ascii?Q?vqrK0aWfE0CMLUTROoU+ANx5ckqYeJQcgLfR6t5Y/dl3Hlo88BsirzYjgcLM?=
 =?us-ascii?Q?BWdyhsC0G1TW2f6n/SSmjauJcXNrjxOWmMsveJDBoLu+bngzxdhc6h75qW97?=
 =?us-ascii?Q?VQPN5P6CeDcrsqSVEPBpJidQ2V6IYU8YUBY1+a7xRWH9NjDjFIJZRkqEPN2G?=
 =?us-ascii?Q?Im5pvhyHbHwcp8ZsJHoa7UoBlp1r6KMHh7cPJUQsicUNsU1y57B3REpYeR4z?=
 =?us-ascii?Q?J2tp3Rj7gCFjL4Qi9rYK09i8XTyxZfnD00rtNF9U39603HCRofv6NgarvbJA?=
 =?us-ascii?Q?DHtSx7etbaY1pPjPdGqS+vTvc/N9PwqFptAFf1i4pT+li9kqp042gtowspiW?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef32067-f961-4c10-6d4a-08dc0dee73c9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6705.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 13:01:37.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVcm1vLkXj6JKu96VRvLulOfDmSuXAXttu0cfBpzkei6CPvU6Wiez2fDO6tLUHG99e21CaoOsF0NZRoTJqvSFdu0i9fuZawp10tYww4xuX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6552

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
2.42.0


