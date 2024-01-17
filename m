Return-Path: <linux-kernel+bounces-29473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D4830EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E021C21F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C932562B;
	Wed, 17 Jan 2024 21:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="WH46o9Sw"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2090.outbound.protection.outlook.com [40.107.220.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E222556A;
	Wed, 17 Jan 2024 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528291; cv=fail; b=UturpwfGTDOh+EXDXVayQsqZ65UKcmNXuc+II+OTf1yrO1BFHhv5zSU2ULanjF2Kkhiwkf9+Z+8ZqnQSFs6aJH87RhdlzHFdzWqB1YNw8d6jGWSotcnxSPeG2xxmy0e2unx+NFqFwjRZTjMzQ0jq3cwSN/i1fKthJ3+EmVHzoqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528291; c=relaxed/simple;
	bh=GQcy7fXBTTuz2mfvpUemgXWMNmfnLBREMsrp7fzk0is=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=N5m5/vTZAB1jiBd17ZCii3ZQxYHbk3WX5WzgD3NFrdVa6fOayUtOvM7ZsHFFl3pcEJpfNNzhtgblygKlO0IiQ/bdNQZV6xF9g5ulwH68vnean9lu0D1Axt35E7tbhlyAc6+9/63o6XBR/c2iyns6RSYLBxbUeBaeGgSPwFnxJWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=WH46o9Sw; arc=fail smtp.client-ip=40.107.220.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHE8rRXOtEO0yuFHggOsO3Qlhb5/r5MviJLG55nqJddJObyN7+Kt+jXxp5972d6mj27gBgI2KUHBddoVIThDVQ4WPOyDu75Zgn3yl2ks6LwJNu5fqH+jbAxlojM3pbP7wRVsBPxpikvDkb0lOq5v2gQ3weERCAZw1q66O6NjkRQScXjbHQRa/LVUzYfZc6t7awam9ltPIjiFo0cq+6NuWBs442OgnDqRG9fqIkdgfyNAAg1auFBKI5En1QuKVWIKob0uQR+uJp2dxvjoKp9+YRlUQITnIfeFheCth7Sm61o01uux84drkXdROVtD7x8MoVoOYKE9/EWmEzO+RsOpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPAkaxhBIIxC64id3dS4Pt3wucoC52AkWTWmcR9gmYI=;
 b=bgmOs4OlFnedxAJfWyqStR0qGMKbiU2kuZe/NteYmfR2Vf+oxU+/oiLfuLV6Per9hYzl0wVum9Ru4Eiip0hhXMl6Myx74F8sMvU4dbgfg/GGjNWalHdZUPOh03tGEFhMrcPPHNWDWmckqJNP0posSe+22jTbqRvZIBlLL0kvAgJ6Shthvw5lU5OTn2DqDbEiKPA0ufQTI+2n6ZNVqlkEk8zUhwYB/E1rvqX4EdDrJ+DQIMMZBcRTFDuq9JUi1EYHvMJFfZpESbeqoy6gaWF3y5u3czWBvbVrsaE9YP+N1CrPnNI5YNlFbM4Dx+kaE5Eh9W6zrcXjB/Cn4FCjw3Zszw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPAkaxhBIIxC64id3dS4Pt3wucoC52AkWTWmcR9gmYI=;
 b=WH46o9SwxGct1jatfTwmNFu418h+ETWMlzEFnjTSBKO7ZjS7NZj2/OCRBdfVcYKie1BF5WNCcLg8ADlakvbYRWpf3kmpwHrWCMSpFj5e2K1BdR8KNTqQUyKzgM7u4MEZ77csFHtFL1rhsHIe4gER+cta3JhWAiIe3UHrBJKbA4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) by
 DM8PR01MB7029.prod.exchangelabs.com (2603:10b6:8:17::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Wed, 17 Jan 2024 21:51:24 +0000
Received: from PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::5549:ab3d:70af:8693]) by PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::5549:ab3d:70af:8693%7]) with mapi id 15.20.7202.024; Wed, 17 Jan 2024
 21:51:24 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] perf data convert: Fix segfault when converting to json on arm64
Date: Wed, 17 Jan 2024 13:51:01 -0800
Message-ID: <20240117215101.77713-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:610:33::12) To PH0PR01MB8166.prod.exchangelabs.com
 (2603:10b6:510:293::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB8166:EE_|DM8PR01MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b59f901-1704-428f-fded-08dc17a6734c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1xSnAmfsQRYc7Mt9yXatpL6qVOejjnanlzlcZMb+eEo684FffgxNQjOmEQsPCFkXVIaulc7vunFy11BegpmMQhP8X2ZaxgPkH9vFn2aBAZfIGF8jLix8je36UCkTgfpQcauUzRIqUiMp5RgBmj54iELzkxMVRfiFPsETNgCRHO39i2cOoY+M0RRofyfxjKwkUpxLqtcjOXWLTXHAwuL27V21pP/sJcuclAoeChY2Dc/8CEtkA3n7Y0kvpFqCIhkzM/9Ds+FCFQwdgmSlEm1bC9/qIZ87YFF8xILGBUrH0CPIuMTYmDHiZvJd6AJkn/hAAG0H6JiZGSTdD+dAmG8l9h0/CRxAK0KBYGkeIs2pziOlXcAiVdvz3tY1NHJaysCoTuPprSKb2lPIhY/FF96axgvhZW/U17fmVJz4KuH/C+s0cYsS40gbrIA4qn2+udrFmglCLZkyspMD8xnCSDIw8c7VF0VSM6hHlmFFRJMXejH/yS6yc8RFqwdrmMqsYHj2C4PbQsqX7oMdbUR4OAIKh8FYLMx9N4xexhgjzWV/14vLI8TfZEglovPa5xeR9YO5BwhA7/jeDsVHIMkCv8cDwWO2DnZpzDhLMsj5ihW9cuHXFpC68o40UTiVx+HPl4k0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8166.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39850400004)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(921011)(86362001)(38350700005)(52116002)(8676002)(8936002)(4326008)(1076003)(2616005)(38100700002)(26005)(6666004)(6506007)(6486002)(6512007)(966005)(110136005)(66946007)(66556008)(66476007)(316002)(5660300002)(478600001)(2906002)(7416002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7KyxE+UXQBptR/amvFt80vfj+FfdOaWnlR7mYzdaVb9TxI4dMAeJFB0U5K+w?=
 =?us-ascii?Q?m85rGHNH7jWWIzIQdIb+Yi8/f+bNHH1YZMl3v+rubGhF2tUo+90DftK/UN6u?=
 =?us-ascii?Q?vwtYhKjKlMOeF9A92bFGmN/SrrSNe1j53t6J/Kzmfkbv3qHjmhxgMf+BBBBb?=
 =?us-ascii?Q?zTVQmZGsC29g7HtYZq5g73qFZ6epGgq0j7InnAtAa9fnAinylvJuPtEG3Gpw?=
 =?us-ascii?Q?77d9wIHBEqQlX2u1jjQ4iI47Nd2+OPKZk4lJSmpWhWsdJUiT3YEwKTMi4PwE?=
 =?us-ascii?Q?LKX86qUr7E6Uq9CXfe2mfPyV/p7Sl+FK4JnlYHEJ9u3rj7kwlXsBl1iI+pJj?=
 =?us-ascii?Q?L4oi7rAiZh0BlLyhnFhyr69FaoMSwZZH5KzFxEVcfc1AHo6nH9q26/F5LfAx?=
 =?us-ascii?Q?YAP58pNyPuwmpBBCHR7oRK7ctipW4PGUwmcXrR9ehH37E8OGzab6OHqmlFKH?=
 =?us-ascii?Q?nCcyCc3IJBb491gINU1gU2l07LxLsyVVDEPJR36ZfElNcyNEsbGtAOJPC586?=
 =?us-ascii?Q?QaJv6pS84PyDbQP6oIXf5lmqa5EaraJRVK/ojMBQHBGVOMEFZC/3WclPFehr?=
 =?us-ascii?Q?7yKTbIRfW9lUAyVpEYG+O/FWBBFIJkr7CE1J/9l02JDVkVirD5xl4A/sjKbK?=
 =?us-ascii?Q?xqoqVEtkv4BQB4oVQ4iY9m0fDwvURPvEiWFem5d6sFDVHSiHrz7uQBNLqowC?=
 =?us-ascii?Q?QX4rT8HXaS02Jz5RJutEGrDfJvUiVrvc3TmoilOXcu9e+rm14WQOLppXTcw4?=
 =?us-ascii?Q?zjddZ7x2knA0a9Ci1UVKe5rGlJKesKL+mkkbbEMxb2hD8S8o2HIwJ1MEgBIA?=
 =?us-ascii?Q?fAeFickfG6szEPSLJ5Lt3OlUKTGCUmTdsa/HlVigAbpTmOLJb0BWG8ju39wE?=
 =?us-ascii?Q?+ZguzUqAxNJeu1GRWR7pyJM93cC4qkA6xHdMOAW9/FgBZgmR7iTLGLm+6D4c?=
 =?us-ascii?Q?v0s9cUpSjPMg/JbjdiNG9q0+eQMtNwoBCENlU4cSsl6Lo0cq9HZMz7Gd1iSG?=
 =?us-ascii?Q?9lFQ0uxDw6lcX4yrXeqIcUsYtNneIDfcwsvCFXP//SryTbO7Jf0RZerJRIeO?=
 =?us-ascii?Q?ZyCFxBw76XZ6ZCNnmQLCG+WEUBLC8oSrUaqBCOB8ImXE9EC2s3jgA6bU3Utb?=
 =?us-ascii?Q?8rS8SBGXoU4dM/lnQ1RB6fthOuX5UUMC4ebeBaGD9QOsM8nWELmmHs+2Lm7V?=
 =?us-ascii?Q?cc2HWmrseunR7bxne/UnmQF2zkCBj0wwLYnWEm4RNeqpDwLq6wIVJKvMGIQZ?=
 =?us-ascii?Q?znT04atQE0Jwm+Jr2GwhBzadwsJbOo20kd3WGpGYb/ctarGOPT/aqxx9HDl3?=
 =?us-ascii?Q?7xZgPk5TTCs2npvGtr0N29oRjd17Sa1Lcxi9owdwdMfSe6i1zI0t1tUn90fO?=
 =?us-ascii?Q?3MAXDH66CF1C64Py7nDEG8HKmDZO7wiF4q+lohVoYCl2qQaeC6sVpdOBUs4I?=
 =?us-ascii?Q?T6V2Cn/vt1Gpr0xCDGkeqICPV7gVibWtHSeM3AmACT2XPllmWI/zc344Mi41?=
 =?us-ascii?Q?K+/rPe012NUTGnl3cUQJAbb3E9SwBeaq6pmqFIbTJ+anKcm43VBRhb81iELT?=
 =?us-ascii?Q?rtErBPCBnz+vG7vmyyhrvf3MSn6Tm3fLs+i6MI3I/QiGUAS5O4fcfEOgujGF?=
 =?us-ascii?Q?iUmkldEzyqGXx+V/pqFNQBA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b59f901-1704-428f-fded-08dc17a6734c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8166.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 21:51:24.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnVCk7bZL07Mlsk0E8Z3/VtvLGnMCRGRi/pJW5wPkTL3wOUc6V29ODyXnjTFQYr+IOY1wZFJiqdNn1jleIH6sx3On7uxAUaG3uiuwQVJ+IAUHz4lD5eUhkiZK+VPZZUV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7029

Arm64 doesn't have Model in /proc/cpuinfo and, thus, cpu_desc doesn't get
assigned.

Running
	$ perf data convert --to-json perf.data.json

ends up calling output_json_string() with NULL pointer, which causes a
segmentation fault.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
v1:
    - https://lore.kernel.org/all/20240111232923.8138-1-ilkka@os.amperecomputing.com/
v2:
    - Changed the patch based on James's comments.
v3:
    - The architecture is checked from the actual data file to allow one to do
      conversion on another system. (thanks to James for the feedback)
---
tools/perf/util/data-convert-json.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 5bb3c2ba95ca..405c38371870 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -284,7 +284,13 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
 	output_json_key_string(out, true, 2, "os-release", header->env.os_release);
 	output_json_key_string(out, true, 2, "arch", header->env.arch);
 
-	output_json_key_string(out, true, 2, "cpu-desc", header->env.cpu_desc);
+	/*
+	 * Arm64 doesn't have Model section in /proc/cpuinfo and, thus, cpu-desc
+	 * is not set.
+	 */
+	if (strncmp(header->env.arch, "aarch64", 7))
+		output_json_key_string(out, true, 2, "cpu-desc", header->env.cpu_desc);
+
 	output_json_key_string(out, true, 2, "cpuid", header->env.cpuid);
 	output_json_key_format(out, true, 2, "nrcpus-online", "%u", header->env.nr_cpus_online);
 	output_json_key_format(out, true, 2, "nrcpus-avail", "%u", header->env.nr_cpus_avail);
-- 
2.43.0


