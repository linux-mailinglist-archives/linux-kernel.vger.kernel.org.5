Return-Path: <linux-kernel+bounces-28588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 139FE830064
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0501F21AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F629463;
	Wed, 17 Jan 2024 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bLawHLaH"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2113.outbound.protection.outlook.com [40.107.243.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCB78F47;
	Wed, 17 Jan 2024 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705475638; cv=fail; b=dh78Hj5DHhQDUGqz9dCSor/h1St/5Dv4cQUZl0r2u3/3RtxRpOKbAQBCSr/TSoxVZMKa+bBgXitQlVxlrPA3ikwxAiUpswk5cwBBOtsr3TkWkIe3YJJUcgrg5auyR0SnDdLMJbngnZ25GSkLIHimWCgy0D/nm3oLAeM8QlhG9cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705475638; c=relaxed/simple;
	bh=PYHa70ARcX88SgF6xADOviVTR5Vo6ytYLbm6ZKSaFsk=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=Fuhv5VfV94raxswjFXl0hxll7g0f+uGtDZDTUfHHxMweBrYmdNc35Oy/ko/Fp0qVz9yiyW2owO4csEAxBrV+JTiYl4QkDDLHmHqtfkXehxGWW3dOnYOpPXQrzQAXpo5TPVKSRgzjRfGnyCR/a1gQQoHkIrz8Mbs5E5zX++46pcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=bLawHLaH; arc=fail smtp.client-ip=40.107.243.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMTql2HB/msPBUpZqZJLkMZlCPr8wP/fjdZyzX5zuUmL8JvP3D2ATHlqo6whBNk446tBtqlTUERrrtMMYVPSOw+dKqi69RWC59EcyVBl3if61xRk7Gb/6aE/JUGcZThgzk5xT3d5aANOwhP9ZtkcyK/ib2+QVIfL5QzCpXQQhNzeH7Y4UE+vH215LMK/suzCkDU8IotfrLaCWz7mWoocVMF9km6uIeRNTzInT1LKNK0DwSTOOL82uNkBPOXht5vcn0+GR56uGtUC7QxCEsf0aT1vSleJZKqAw4838YqmHbw9y4o8DSUkOsl8onWHFb1BWX6eR2g1bfk48UlATNrGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFeg4CSmpubQEaLB17QJUwdrRdcUoTtqqlvVEYR/b8M=;
 b=aOUQEEB01m0fq7hT6ztWK8ZaK8ADoUPxfMH+dDth0dghOKl3cQXr68t+Pn6O3NtbIfpzz/ap05d9XjQciLdmXK041XZMMhlvE5P3kZhHMo0K66qLMjtKKxGsmqLvDOWGeQXsLLPeA53UpMBvMaZOe6JeIMXB+dzlHl190HMu8Mq+mWZE8pAi8Z2BYLGsoIW/O7MG+jEwx10JZY8d2Skk1dfBgUbh9rvRPxD8a63irqLPyVEfYY1SLxwkETXSqZ1xcrLz89Yh5JDVDmLjIRuAHSQKtYDFS+PEqT4EXvCQ5TSOqpN6QYcx+uS9tvZLk6PysCABwUoYFyS4dq+AESZP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFeg4CSmpubQEaLB17QJUwdrRdcUoTtqqlvVEYR/b8M=;
 b=bLawHLaH0VyEVpEf6RXTfxwOd0TowRG9rvakV1asvidt+pHb5R1cqRKmDerq9g2PXBIdUWyHFmk2XGJLPBsA/kqxGwmwrZohD/3UTDz56JNVXIZ3lpcsfMudS6WYUeuCalSEl016n1ygz1pezcNdAJfk3mzvEQD8gE8cQrx2YFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) by
 BL1PR01MB7580.prod.exchangelabs.com (2603:10b6:208:390::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.29; Wed, 17 Jan 2024 07:13:52 +0000
Received: from PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::5549:ab3d:70af:8693]) by PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::5549:ab3d:70af:8693%7]) with mapi id 15.20.7181.019; Wed, 17 Jan 2024
 07:13:52 +0000
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
Subject: [PATCH v2] perf data convert: Fix segfault when converting to json on arm64
Date: Tue, 16 Jan 2024 23:13:31 -0800
Message-ID: <20240117071331.59725-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR15CA0015.namprd15.prod.outlook.com
 (2603:10b6:610:51::25) To PH0PR01MB8166.prod.exchangelabs.com
 (2603:10b6:510:293::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB8166:EE_|BL1PR01MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: 6932ff28-8426-41f3-26a0-08dc172bdc25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A9SHno+SOj91hGjkgfz+26VVvl2qRBXN7E+m7mEdpb66/TUGzQMnuJZt7Haa9I276Yk4SnWdpDXS0j8UbjW10jG2yvy4ot/XMVQvwfFIQGg9nVDLi+MJEl0OUnqFaspZN6dFmGRm0rWnxaNSLd3FYKWS6ghMz/64Ps+AMHOXAnwlamU6VH7WasW4hnCVUmiAYtqUjFSWtT9+dYbgF2qFL5uX3rwieClyQt8FzyRGlKT4IoOhR107fJSdyU4E9OgfxsEqYDb9Grrq6Uu94s9zoEsqSZgC+qvlOKwl3UPXICKNadnLF4twjBIeHCaYqrNPtWPnBKUSGbFVTisMtMysOmAjM/duEYqmP5WkJO9jKUycvxeQ2SCIl5sQ5xeJMR7yXDBcS1/K5rtKytplGisZb4H7pOidUfDUTkC5Q/8xuIpHSSuN2vmbh+3blonhAHvBDgLw8TIUeY9h5YnyPfXe/crfXrn5or25zG4/TtCr3TlFthsp8PGPIFlDB+tb5o/3SyP2reelGDwx5YAlNL8ydHeaQzdzhxlW2x6l6UjetgNOma1bVlAKgG0ZpNgzX7fGHPU9ifEjnmIn5Mbo4qvuqb4iUy2Al3wuiaC7iwJFF4MEZs6/wh9RzrV6SKP7O4w3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8166.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39850400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(86362001)(921011)(6506007)(52116002)(6512007)(6486002)(38350700005)(966005)(2616005)(83380400001)(38100700002)(41300700001)(1076003)(26005)(7416002)(5660300002)(2906002)(478600001)(6666004)(4326008)(66946007)(316002)(8676002)(66476007)(66556008)(110136005)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?732PWs8pgCWCyBIb24KpPlfam6Efu0G9e/aioD/5eWXEu4klHT9mMuVg3iNg?=
 =?us-ascii?Q?khsmPO8JP3AHRG7t/meEjodO9IIkTbfdIFhLWNaaT3EDolFU5aHol8JiZc5i?=
 =?us-ascii?Q?Q3Gn3HFsSGSdWBBPdOxHVwuaVweabc+Nn0uz+0YyS15LWo368I2flfcIGtgc?=
 =?us-ascii?Q?5QLGA4CTM2y/DsRPH5OH75fDHpI+fRvt0BBb3S3rHzbU5joKNIViW6PQkCcr?=
 =?us-ascii?Q?WYrPouXl5WeQhTbNrz3ormb9PY/UUwiBsynCjVJQBohrTwt5S+uMjih8j/4r?=
 =?us-ascii?Q?6OYjBjyRRsKMG0lTh/JxtLlVcGWcN/Uubh1JX/QqijQUeUAOm5hnO6G2KUUt?=
 =?us-ascii?Q?p5dFzw7mwsLEr0PWEH+uxSiPeHINvcKO+YfaurQKeDWmoV1MAtz92sibXtt+?=
 =?us-ascii?Q?5aEOrhikfu3F6EiQTotx1q9ExeGQjncZ2EUwkQnQhNjVw+zGEUyOlqsSRLwv?=
 =?us-ascii?Q?bFt+cnDwvH1ZBr2b7LZHLwr4xzvgx9C1dhCIV1qRIq1SZ/g9nMFqhbiQurVx?=
 =?us-ascii?Q?n4ZhQw0iK3eDhYSmxAMAzpfdG7tCSnJbFhwpHILNrTZ5eIFKKgL/KG/QYKEO?=
 =?us-ascii?Q?KEOUayN0wM7k/UPSAncePBNv93/+IUb7CnijccDUYyTl3pcUUin/efq5Brk1?=
 =?us-ascii?Q?E8Fxoy7VFthJe6iuYzP0UIS8fNBQVuRjmR1kfzzwaHbm8zTB34ktI8ulzFwq?=
 =?us-ascii?Q?1r6h93MRkhTl6ElRVmpKR5iJ3jbosyGhIOMvYfvnTIrZOuNueMoaPWpvwv8u?=
 =?us-ascii?Q?81Gx78sEe6aOHfuXLZbF2Zo5Bbr5+64qycQXywynyAU/y4hR4XKW6EsOVe34?=
 =?us-ascii?Q?tRHNsMVNAvZ6FjzqOU65bQWxE/ZJl0t3Yir5vUcSBiPhg8yH/zHaEheUlSJY?=
 =?us-ascii?Q?AoWQSbdao3aRth4PVHrfLMyA1dxJxRh8ZJQyMqGRj2BGbfRgxSO6q2uG4apX?=
 =?us-ascii?Q?jEJuiCetHc4aY2JUD0pTGzfdDzt/uzNA9BB9e4QlU2H2mwhgQXkLyI+0DRVd?=
 =?us-ascii?Q?sQamEtT24Yy66vFXZPYwGej2Xht7EMO7jYWUskLpUkCAJLhMjtvcXf6F9HQb?=
 =?us-ascii?Q?pNatiiQlPDWMmqY+MqUbP351Arug9m2dnZFQuZjx3Mp1GucxJNwo5911Mu+G?=
 =?us-ascii?Q?8b7jOezBHNO2X/8ObRuJ+dYVSSZ707xdoHleKkIBSeAaiaQvC7GeZsIh2tRt?=
 =?us-ascii?Q?HA9Ym67N6Hre73BqXBpaVbYn8Vinndy28gXlxO/SIZtZMrHeuExrdEgpJKlV?=
 =?us-ascii?Q?QLuHr+wbR49fqVGNrgNQIqYiAj2/6RBWaMdeVBAMoRcvIKoPcjACHMBDnOeK?=
 =?us-ascii?Q?ei6wCTrOKMX+N92zxTKGkeBMzgltKD93+gnYFmU9GKGMSUJIAa9shqagoyl+?=
 =?us-ascii?Q?VATBii+4iaEgwZ5dX9UxYry/cG1YQpkun8AAQuNTbEpQOgQb4SIoLtk3zXZq?=
 =?us-ascii?Q?CeD6COwCBmxoPMH5oYEZbO0tI7gs6DB9u7vrNxHYkSLdc74WZ6H+lnOzIPgt?=
 =?us-ascii?Q?Q48i/VD8O1RTHhV86mCiWOjADnCrTsu2TG2x+H+MTO+iLgR3P1YHNgUiA32k?=
 =?us-ascii?Q?An4SeNIz1+cXjkJpvqLrvYS7SQmRkrMXiZ6BGbTzVyFiVHmxBFeyOccqOhuI?=
 =?us-ascii?Q?S79/2rzTDwsHbT3JFpon9N4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6932ff28-8426-41f3-26a0-08dc172bdc25
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8166.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 07:13:52.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ktdQwX1QlEmNUowB2Lgfy65VdBRTcnKVSczHm2P5TqFEE6yG/SlTYFsr/vnfitPTtdL/mMWL34ZIcKrG4j+xr0amr5OPnl1JUgFlCAdUrYeNu8ydu8be7p1A/1eaz9R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7580

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
---
tools/perf/util/data-convert-json.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 5bb3c2ba95ca..e8b006c3581f 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -284,7 +284,13 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
 	output_json_key_string(out, true, 2, "os-release", header->env.os_release);
 	output_json_key_string(out, true, 2, "arch", header->env.arch);
 
+#if !defined(__aarch64__)
+	/*
+	 * arm64 doesn't have Model section in /proc/cpuinfo and, thus, cpu-desc
+	 * is not set.
+	 */
 	output_json_key_string(out, true, 2, "cpu-desc", header->env.cpu_desc);
+#endif
 	output_json_key_string(out, true, 2, "cpuid", header->env.cpuid);
 	output_json_key_format(out, true, 2, "nrcpus-online", "%u", header->env.nr_cpus_online);
 	output_json_key_format(out, true, 2, "nrcpus-avail", "%u", header->env.nr_cpus_avail);
-- 
2.43.0


