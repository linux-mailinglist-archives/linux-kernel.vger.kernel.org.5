Return-Path: <linux-kernel+bounces-24134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE2182B80D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30431C239D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B85859B6E;
	Thu, 11 Jan 2024 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="iHwzdN2+"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2127.outbound.protection.outlook.com [40.107.223.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235DD5A0E1;
	Thu, 11 Jan 2024 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lc9FpCvTwLm76MHz3oGQOTx6xoZaFIxuQM4h8laIipnog86oWBXMH5IKYcyfIa/N3CE3aVGUvDjNSfCaD8h0ubqhjXl+s5qJ0zSOPI+7bXIr0b9SqtlSDJJZHpK5ItqMCm3fuFtIWoAtx378MxjF+tfHmel/HRo4D8ucS80dCpTETCQVbDOScoSIhIsRhU9knLYTooVpf4+IW3kHuqEQpBUC2zgbvOHBdFSPvH3Ku8fV5EeL/bA4/gzj0STy+yQVRmqKUMzirt3gowGxMbFjxnTcoFfCGnJ9JEVOQwlHD6pBMzdSUzqXmGZCP/IjuuXNLUZxNMSV7hOD58jNiL+E0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5l2oJHVJEVTgfkSmfZDvgNoUGFAJDlrGmip4VsfC3M=;
 b=PE70fQzGAfV7+RBLxCynYjFeUQKpGwC0McuyuuprVqqm7IKSZOMdNvcfrX+NPZ9t7wD700kcsr2BoGJ3M8IjyKZxo60cTg2DRgIMr9G0g0FIlmMp6FIP+culTl1xOOnLiHFQoFDIRfiJ+6GCLfIcO9IsnJ7ruFT55HMecVDeHHWthpDVn+OiDzw7ibATyDUfqksAosbaWivzfAl3+UnOPRcFs7sReaMQ8vmWUuSgl0OPghhvYhNREGRXmjE45BcBUtXCN363UNbPMCr/yq0DUUyqD+iD071v2v3CdIZK93tIy5ZBpzT0Go+QrQy8T7boy07sOVGjvzYBVOGi82e7Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5l2oJHVJEVTgfkSmfZDvgNoUGFAJDlrGmip4VsfC3M=;
 b=iHwzdN2+TO2LGqe3zpTOMydvTVVcz763oJe8caMAUnz2TRNeAaz0/zKMRIYNpYlWy5op1WJjxpFWTk9UKYb18VJ5q0hh1LVSlTHgGGL/NX6IANQ/1EEQuZym/3tjN1RFjMEkwlcX6pxdE73Vcan6l8gKfyBt2qtWhOpvuxq+mGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) by
 PH0PR01MB6375.prod.exchangelabs.com (2603:10b6:510:17::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.21; Thu, 11 Jan 2024 23:29:54 +0000
Received: from PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::5549:ab3d:70af:8693]) by PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::5549:ab3d:70af:8693%7]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 23:29:53 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf data convert: Fix segfault when converting to json on arm64
Date: Thu, 11 Jan 2024 15:29:23 -0800
Message-ID: <20240111232923.8138-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::24) To PH0PR01MB8166.prod.exchangelabs.com
 (2603:10b6:510:293::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB8166:EE_|PH0PR01MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 400567c1-9668-46e2-e4f8-08dc12fd36d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dxZns6xkB9+5iA9a4wD8QUJVpAp7ZJLcwj85xEn3EfAtkXA7UFzuV8rw+t7sYUEaOCqzZdBSr+LqEo1zWye56+Ybjj0KNhBypC2HFQ+MtC2ljrRuKi/4vXzcb5CWcmmcw9u9CvYi3mmRJfq6YdgIcM+lzZP5zZhxu9xEpcSmpGWseZrgdeqHBewxfdYBvxNxzK09+isd29n6Pzp6VgjIb//ZEgv4z2Kwwpx3ZurLy0rVkqzWUZxwLeK1VYUOI4PbZ/RqWrbm1c+G2x5UdlIzigERv3TizymDsQ+DcE+SUmQ3l87eMSfuTKdjIsC/yHyZ7/CeNlcGaYNXL+c2Q4Md85tN4yvoz553eGfkkAglWo1wRAwLkTR9RmseMk216SER4DbdNdDHnkrvREZ7z5zkwGOVhqlRup7oFZCFwAvPFFYV/+7ud5Kq91qY2Iwkon7cGEMIi+zidnCNoGzHXAGW2NxFX7ClgDlb85hajmAWxAjLTqzKWWssfYvc+3yar/njIjgDKUkGt9KQizXgsirfZYNEsLZBOmGtB2sCN4a66qhIHYhNhWd3ULnvjWX+pLUO6CbPSyXAb+9h+4PfZCkcZzoMgNOj6r2WD26YtInKn4u2DwsHran6VF5WhG4MRGEC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8166.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39850400004)(366004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(4326008)(8676002)(8936002)(2906002)(4744005)(7416002)(5660300002)(86362001)(38350700005)(478600001)(83380400001)(1076003)(2616005)(26005)(6666004)(6512007)(6506007)(38100700002)(41300700001)(52116002)(316002)(66556008)(66476007)(66946007)(6486002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G4JydZ3o4TJquqA393XNaTq9KjmwNq+JWOhVS3B9M7FKqsiavjlddgYyOkpk?=
 =?us-ascii?Q?YTvEQf+gziz28NNfMXkJRFvpGIFtbjgSyK1ILpeXdbg5RHW4+peXT3z67GAB?=
 =?us-ascii?Q?1InQ+oIG3mG4mHDME51C0AJI3ZX/KJQU4pU8/mt1bL/liLdadGMKTr0dgafg?=
 =?us-ascii?Q?yRJQ4+AK+w6zARUzj9eEmgYRxF2TXEBkXXjCN5jrbm4M55tQef/sWJpLCib7?=
 =?us-ascii?Q?EpPsGCtQKBtz1AztVSbPG/4JQK8jeuz09xlU2j2kW78vnOtgflxE/ZkFE86H?=
 =?us-ascii?Q?mJtLnR2flSqzftoi4oOPCSz/KkTuqE6mLZEP6HUbaW76Ix02gboG1fmjfVye?=
 =?us-ascii?Q?Wzib1qtGvjJSj4pQhJXFV+Wg/i4W76x38DkcGx4m1ZEfIsZsYOsE4enofm0c?=
 =?us-ascii?Q?0RBzSRjvR3P24wBsE9EJ2of3SX8Jr4VDROAVDi2sr0RtplHo0zhpe06om6By?=
 =?us-ascii?Q?g5DSbX3YoAwhfsnejfpKyMZf33h1DoaA7uiC0qR1uhyjWtX67cVQeVnc0COm?=
 =?us-ascii?Q?KOL9jVkSKLFqMqrg+C5sU1r7yo/6+aPwKsro1hmWx4gVzURSeQDfWPbUU9v6?=
 =?us-ascii?Q?b6314XcEMC758zuBnChahaVegNz/e+EugZxU4zBj45g/pJPBhJGrD3MD9U88?=
 =?us-ascii?Q?P6lqB74+P9/sP0+F9wMeXTIXX0Ap91tpo4Q6skW5QRhE/UR84q05bcOiA3Hk?=
 =?us-ascii?Q?azOR4KOW313K/qg8FoZ9zBjAOOlKNioLf1toe+8Eda9vGrbodV5r6BAL4mZw?=
 =?us-ascii?Q?k6DAQLv595x6NB7DjkIkBzWrAtG6zb7SgOqKO27RX56qTW5d7BXAM32UAtoH?=
 =?us-ascii?Q?DHEGbOZiELvO8H/uCVFBnICWEr1JOK455U/Dkw2Zv7SJMW91fFzT+GhCqOA6?=
 =?us-ascii?Q?daQYLB+8wKm+SP8f1Ulju2YutEtYQMT6Y0PtmqAHPhf4ZhF/uPMXDg1v59LP?=
 =?us-ascii?Q?HoVXAxOoMFklpSI9MFnq6agyX1Wo/94lIiiGYnXwx48Ujv7NgjeTJzomXEpA?=
 =?us-ascii?Q?cK7mk7c/3Sfq/4vg1pmYIuJNq/7rThr9sAZCqfWDk7PSrvG3iNV7sOv6thVs?=
 =?us-ascii?Q?+qPy8q+s53EQJzUSRMoCxcHUePCTbyihx5dA1aOq2giy6Dgr6M5ojuubsK6P?=
 =?us-ascii?Q?jm73VKRMbWyqJrG1VLa1+XDgbBaRVMWAdi+lFPBIgi3wWIsuiufGWzAvVSw7?=
 =?us-ascii?Q?p3aI5zg9azKcax2pQnJtd0A6wfrMKOMFFhMeIXk0u8OUmLBvEe55v4qvyk05?=
 =?us-ascii?Q?MXP9k592ghvrioIjVsgvcL40pYPJ13GymDlMU2NFBzUM1OMGA88m6cbhmbtX?=
 =?us-ascii?Q?S/qt5B/IrxjSm1TpTLlTX/Pm8GnpZFjqdUdlXKA4D0wBGyzsTFqOSVk+d9TX?=
 =?us-ascii?Q?rWZuOSRaKxE/C8Iugh2ZuyTeVJanSSjIGLokFa5DztAQBmELmetrdxfK3JD3?=
 =?us-ascii?Q?9/YXZfQe+j8xcYM4B/mTKhuXMCqSkPVATokexXHBeCxQuEDAYeDw5xBmwan8?=
 =?us-ascii?Q?s1ie6R0iyPmaK9AMjdV4rJ7wmM5KSvEvm84EhX7ZLoKvSX8kTU6bh6pLEdpj?=
 =?us-ascii?Q?T2Az4aLg6AgSLF1ZyG4Y+nqnChGtt3vLchkaSMf/SKrAOjOyQw3b9V/hAs0R?=
 =?us-ascii?Q?acNNEhWctvNd3CAf0eyUS+I=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400567c1-9668-46e2-e4f8-08dc12fd36d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8166.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 23:29:53.7921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJ/C7V2+2LuOjgCCDbb8OfPaLkFHMMdDtrj4u/sGhpkvkF6HVpj51Cv/WMaudHxSlkKvEiy0kQsK+vNBvC4DCMAXAaUyadSPiD+Nuyquqj1dod7XBD4g0W+tvd7OYIl5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6375

Arm64 doesn't have Model in /proc/cpuinfo and, thus, cpu_desc doesn't get
assigned.

Running
	$ perf data convert --to-json perf.data.json

ends up calling output_json_string() with NULL pointer, which causes a
segmentation fault.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 tools/perf/util/data-convert-json.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 5bb3c2ba95ca..5d6de1cef546 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -97,6 +97,11 @@ static void output_json_format(FILE *out, bool comma, int depth, const char *for
 static void output_json_key_string(FILE *out, bool comma, int depth,
 		const char *key, const char *value)
 {
+	if (!value) {
+		pr_info("No value set for key %s\n", key);
+		return;
+	}
+
 	output_json_delimiters(out, comma, depth);
 	output_json_string(out, key);
 	fputs(": ", out);
-- 
2.43.0


