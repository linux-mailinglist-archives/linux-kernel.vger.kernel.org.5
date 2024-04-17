Return-Path: <linux-kernel+bounces-148717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4208F8A868C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495991C20492
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137D013D2AB;
	Wed, 17 Apr 2024 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="EvmIq3wT"
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11011008.outbound.protection.outlook.com [52.101.167.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A483E493;
	Wed, 17 Apr 2024 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365106; cv=fail; b=IbYO0A+ptzWjpHsshv4qIgDYn8peR1/yGQRjy4MgVfZdXFdOEJW0cH8IrJl+w/Rx5aAwkBux9+zBTNg3Pp+3f8aL0WUErJt0Zg1iCE/hLxVWl3iS+i7sOVok+UNSI23ynaU+byK02yKH49WWfQFFVWfNSPJtKNdfGP8SnvbigBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365106; c=relaxed/simple;
	bh=UJHvjWrEdLCDGaGqYcPvjcKFwMXjtPQSK81JFS6xwoo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nNYZVrlD4VDwN5GVVCxQ3vuAbqHyztH5YRS6CkWGs3j9PVzdp0cyHbYKHEIX91FiReF4Oq8bVWopdgAByrUu5qA4Lzu4tPKGHMEFDnY3z7Uj+skbd0HmLNjCEq4PQ1i+NC3YzHiYkrgx7E0Jl83qj9RQ5pGWDalm0xc44EfWeqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softathome.com; spf=pass smtp.mailfrom=softathome.com; dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b=EvmIq3wT; arc=fail smtp.client-ip=52.101.167.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbdxJeV02+HbxTpwPNLtc4t6jaC2xFXJ8oeafXF3U0TEi9asKp01s/vo+bxZxtWsuuL5SJdz/v98x1BfUcrMymKE59nOQUd/bUv09QDTPmWNes9aw9g5iUlpcjj0XBRdWXcAvS/P1xoJ0onIRokl8aAXcnvFo0WUxQ591LSnzyMldfsMsBGP4wFLryebOrlWjO1YxE5qK0Fs8RpvklNAR0BTQfRlO6kjD09Azr2FxPQtylr7qFhpgimeJmoy7ew561AZwhOEX1mm5uaQGWc2W7bmYoc6m2HXZOUm54Te9Su7yIgzbi1DDdYFmxdgBSjaeI9AgdWIePAeyhk5LF2sxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=750BPtaqsFohe4pQU6APOAplOPGeXgrEIk9K7DnOO/k=;
 b=VDTfGwH3sZNHV6No63CUhCXT4jAQ1nSqzmEvjLMH5ifUUqXnWSValYiGNa8azP3+Qe28dnPj3erQexp/x5F4SFmUW7EMOIpIZpFDz18nQyWASTqzW0Q5QlsdJzVCKXFoLAhg4tbnpJF7XZdPzVw0EQ1d1g+WpiJyfsjfENO622FpuYCw6UJZ+CwNBLAaMeCTuujrN2TMbitDMzX315YpmKtDqRtRLdYfRsAE5O3DtoZ35M/ubBizhQfq/XC/aAhq/xgr4m94FCP8E2Et/d07bcOSsCF/zp3fiDtYFTc4PZlSCYxHJEKFlxgNLikt7uHwi+ivsRzFHUa0uQrjKx0yMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=750BPtaqsFohe4pQU6APOAplOPGeXgrEIk9K7DnOO/k=;
 b=EvmIq3wTuNGJ2iJs97GKHkywDGlP7r8PM7nf+95Isc1mYd7p3Mmr8+Ll+wukSklK+6fGAwpczVdE5DLM+ndJ83i9jROEEe3CJLwoFGoj7QaOhAT8XPn+eG+QP7QaIGUMLE8t2/m95ro1etqv6Xv/D4YjAl95sv3YWz6Vz792SlUgKc4XIdgTnfrPmi5DcOZPtP4gzYOcPGSxsMsKSTA+jbDnhNDbuppQSxLW4Z/2uiD/PGeRVZzxZEV8RCk+jJ6Zv3bcMj3oQTTUt0CAtV9PcaHa7Nd0zAJq1KmwToW3O31WSBJLPH4yvjHWe5UcTweBz6w2xRly103SynhZAWq5Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR2P264MB0336.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:c::18) by
 PR0P264MB2373.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Wed, 17 Apr 2024 14:45:00 +0000
Received: from PR2P264MB0336.FRAP264.PROD.OUTLOOK.COM
 ([fe80::480f:c9cf:874a:3f91]) by PR2P264MB0336.FRAP264.PROD.OUTLOOK.COM
 ([fe80::480f:c9cf:874a:3f91%7]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 14:45:00 +0000
From: Olivier Blin <olivier.blin@softathome.com>
To: linux-perf-users@vger.kernel.org
Cc: Olivier Blin <olivier.blin@softathome.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf kmem: Report net allocation bytes per entry
Date: Wed, 17 Apr 2024 16:44:39 +0200
Message-Id: <20240417144439.3566267-1-olivier.blin@softathome.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: PR0P264CA0219.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::15) To PR2P264MB0336.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:c::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR2P264MB0336:EE_|PR0P264MB2373:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d3c0e3-bf65-4825-a205-08dc5eecf528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+KI06xDi8qRz+62tRm663yZrDpPK0TnbqDGgFjBYR8zCx5S0NHdaHjMMGN8ulvKP1Pj05sLR7pPwtIjTQ8tQPLCI18kdxuie4WwAXWPzodwWbWBZRJfy4jIc7TZMjlWspEiM8twgwrim2phV3Ph1h5VlOkkHSnjVJOSHudjeR/KR2SZlin4XJHs0fQx+bYWWdDC4ECc2zI2eZylvQGazwUfmKzC5hCL+zQpEZwPQzc7sxhSue5+szHI8KpWehiLs4S0V8QRehn6tEPXpA/zc3LvZADGW1hxNkWQBo7bwrZjPnLDGm60ecaYTFxDTlxrc4VSKrTB/clJOuwM6jzvN0ueJJdaGDuqVK2d+qOTnpY9+SiBONuQUsP5yDi51ntjpT7rR2l0+/51WGIB+9z+Xi07V39rLIksjZXGIZOigfx5xz18S/Kt1z5aB9IBjhbbkAb3Ff+1gVnznZttVV5XBJFSf7OEKQwqLhCcNIpSUHMJWCAdupntGaIaO0h7gPY0BH/SXJv4DicvBRs7rTDXm18NWImyQ+WV3BsAkdV3WTJ3dJ4hPV/WlaUfmpMt7hnkCTqsz6z0Lj38FULGkv8y8qN2vBJQ7/Egfpf7sp/H6L+21UmRYi4/6yDpN1icp8naFLogpKEDpwrANhz1z0+lGhba8eubNUFVCmZJUnxS8ERo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR2P264MB0336.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RqgGH8zY6L+R2vBXyyKrP1dkBe2nMVjUL1rt39ywcp0hZ5kwXL6UO+i4WFt7?=
 =?us-ascii?Q?fDTucMMZC2xYzTaXxuRriCqmcfTMOgurPhPsyQWQRku5Xo4TnMhiKmm9tlsE?=
 =?us-ascii?Q?zRLkCdAdURLBSyuqPm9WZhi3vWTTJbnAF8kvN9LrUR8xnKiCWGtQ/XsG7gJ7?=
 =?us-ascii?Q?Du4aPmCxyDuXzGGiBzXNbLujXvSBxM6z2KTDKs2io11nKQar6ODt0kpg9Eio?=
 =?us-ascii?Q?TnPQJsZ5HZ0KNmOsO+OGQgLwpSiGrUVKRdWcNXHXJ9EGKg6tlWHcVcM1Wz97?=
 =?us-ascii?Q?SxDeOgFNsZvA12LGiNR3NcVxWNGZyBOLaEgJdat6G4NzhhTIOyEXGyHXE0Y/?=
 =?us-ascii?Q?tmDsFH4a/KuRuhk2/+gF4ayeIc+IXIFQQiAIuEisy3J9aJtG0msF0/Z8vkGL?=
 =?us-ascii?Q?yZ5zBtQ2BI5TKBCP45ASvWscT89LorhR+PDCeUYVZgJD3mMk8l5Kknd47kVo?=
 =?us-ascii?Q?w7StJl/1u4ybBhJScsI8hKnsonZSNPse0KcFUHOg5q5vOrzct0FIBg1+MKnB?=
 =?us-ascii?Q?OtVZz4oZcwcqG6x/BraGy0/bwEd7RUTqqBc9z727AsHI9xNZzra5JFmv94eG?=
 =?us-ascii?Q?Xx/cnPmIjEJt7tse/LFpKuFkQWqbHOa2Dbwfh0ZOU+1iltgcaWi+BNT1rhbu?=
 =?us-ascii?Q?qupbB8jkil2asei45ZoTWE29hGZNmAI+tZEls9RgMzoidSeEwtWVb8b/D9dT?=
 =?us-ascii?Q?0DcArFfSd3I53S2g4HSnUPHaXHQ22cGTPpYuczJCAJmwctWqWYwUvPRD1CDT?=
 =?us-ascii?Q?bxYOrG/K1rLUsT0WicMpjKrI7fTT3QgbqAEmIq/VdcgrB7PhV7sTvSSVF5gU?=
 =?us-ascii?Q?gVkHjbIMbZGKf4YXZK8RvlcjiS1y0emrEvB1wtXkpdoEOhc3jW7IoHCcipi4?=
 =?us-ascii?Q?7GuwZftve6du58/7p+9m7KSvXUe+2RbS7FnylILTqKpfHcK+x7D9VfnT/umT?=
 =?us-ascii?Q?p2iuDhNyKmtRAxEOd7TrvyY29Dwk6GepQetXjW0YWtqCdbb1ew1hMDhN1OH5?=
 =?us-ascii?Q?0KrNcYVSJntbZBz/p38LF3xezQXBgv1ydochKriH6p/KbpLjxGQ9U+q+CGeN?=
 =?us-ascii?Q?bDbYj6Ycj9DGKvCiSmXEf/i07hBha9a+fzbOEh5nEcBeqlh4uF7yOwsGS3Bo?=
 =?us-ascii?Q?2em2RHasOzSNLAg0dcXuY74FAKSq61M6t6nAcHONb5pg7GToNdpGn4U0iDBq?=
 =?us-ascii?Q?hnFN1HDCQW4CNBW/CAjPOhVyFLiwavjQB+0V/faB9ZPs3r0ZZZq2eDYiJFKJ?=
 =?us-ascii?Q?ywlLKHBRB/kMyAtXDKwgudZOmQDATqNCUuXhl4upY/LGuHrR2zdhFBxgksxr?=
 =?us-ascii?Q?50GCYXSAMxpab5PqZ/KBiZEfyIwxZ130OBB35kBg9X3cVjLzzA29EzV0k5/w?=
 =?us-ascii?Q?zjBX7hUe45vKhr3+ajPwd+Yutgruk3RSmGDRAsTPIVqJg6KQZ7ePMQYBQi72?=
 =?us-ascii?Q?0zW2mbL+0KDibGoTfZu/ELmFSE8CpAL09hWRzUhQBN8QEkg2YD36uJprJsIM?=
 =?us-ascii?Q?C5CQc3jVEao9iuKIY1uLEqC0Wg90gXE3Yfo3Del6ChrnQGxq0e9VbV9mJ99S?=
 =?us-ascii?Q?foMO4qFoi16yOh2jDAdfklIaBzpcCRIi1dXWuON6u8k31PZ9hnG9kE7FGvbo?=
 =?us-ascii?Q?T0xhVIhng+t1jq7Z60jV2j/lcejTsv8G4VvjomOq1EQW5gi3fNzfXPBrfnVi?=
 =?us-ascii?Q?HKpbSA=3D=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d3c0e3-bf65-4825-a205-08dc5eecf528
X-MS-Exchange-CrossTenant-AuthSource: PR2P264MB0336.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 14:44:59.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TfNJgbAO1YnO5Lcx5zMUpBuQSzj+x0uAAGmEpE+KHeXqsMqk7mMW4va7xv7Dr3cBYA38qbtXAr4d0cDCdlyt0iU6eqNBo2njJGOrdgVTpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2373

This allows to detect memory leaks more easily, by reporting net
allocation bytes per caller or pointer in a new column.

This also adds a "net" sort key, so that "perf kmem --caller -s net stat"
reports the main leakers first.

Signed-off-by: Olivier Blin <olivier.blin@softathome.com>
---
 tools/perf/builtin-kmem.c | 54 ++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 6fd95be5032b..59bdca64b22b 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -64,6 +64,7 @@ struct alloc_stat {
        u64     bytes_req;
        u64     bytes_alloc;
        u64     last_alloc;
+       s64     net_alloc;
        u32     hit;
        u32     pingpong;

@@ -118,6 +119,7 @@ static int insert_alloc_stat(unsigned long call_site, u=
nsigned long ptr,
                data->hit =3D 1;
                data->bytes_req =3D bytes_req;
                data->bytes_alloc =3D bytes_alloc;
+               data->net_alloc =3D 0;

                rb_link_node(&data->node, parent, node);
                rb_insert_color(&data->node, &root_alloc_stat);
@@ -125,6 +127,7 @@ static int insert_alloc_stat(unsigned long call_site, u=
nsigned long ptr,
        data->call_site =3D call_site;
        data->alloc_cpu =3D cpu;
        data->last_alloc =3D bytes_alloc;
+       data->net_alloc +=3D bytes_alloc;

        return 0;
 }
@@ -163,11 +166,14 @@ static int insert_caller_stat(unsigned long call_site=
,
                data->hit =3D 1;
                data->bytes_req =3D bytes_req;
                data->bytes_alloc =3D bytes_alloc;
+               data->net_alloc =3D 0;

                rb_link_node(&data->node, parent, node);
                rb_insert_color(&data->node, &root_caller_stat);
        }

+       data->net_alloc +=3D bytes_alloc;
+
        return 0;
 }

@@ -254,14 +260,19 @@ static int evsel__process_free_event(struct evsel *ev=
sel, struct perf_sample *sa

        total_freed +=3D s_alloc->last_alloc;

+       s_alloc->net_alloc -=3D s_alloc->last_alloc;
+
+       s_caller =3D search_alloc_stat(0, s_alloc->call_site,
+                                    &root_caller_stat,
+                                    slab_callsite_cmp);
+       if (!s_caller)
+               return -1;
+
+       s_caller->net_alloc -=3D s_alloc->last_alloc;
+
        if ((short)sample->cpu !=3D s_alloc->alloc_cpu) {
                s_alloc->pingpong++;

-               s_caller =3D search_alloc_stat(0, s_alloc->call_site,
-                                            &root_caller_stat,
-                                            slab_callsite_cmp);
-               if (!s_caller)
-                       return -1;
                s_caller->pingpong++;
        }
        s_alloc->alloc_cpu =3D -1;
@@ -1010,10 +1021,10 @@ static void __print_slab_result(struct rb_root *roo=
t,
        struct rb_node *next;
        struct machine *machine =3D &session->machines.host;

-       printf("%.105s\n", graph_dotted_line);
+       printf("%.117s\n", graph_dotted_line);
        printf(" %-34s |",  is_caller ? "Callsite": "Alloc Ptr");
-       printf(" Total_alloc/Per | Total_req/Per   | Hit      | Ping-pong |=
 Frag\n");
-       printf("%.105s\n", graph_dotted_line);
+       printf(" Total_alloc/Per | Total_req/Per   | Hit      | Net_alloc |=
 Ping-pong | Frag\n");
+       printf("%.117s\n", graph_dotted_line);

        next =3D rb_first(root);

@@ -1039,12 +1050,13 @@ static void __print_slab_result(struct rb_root *roo=
t,
                        snprintf(buf, sizeof(buf), "%#" PRIx64 "", addr);
                printf(" %-34s |", buf);

-               printf(" %9llu/%-5lu | %9llu/%-5lu | %8lu | %9lu | %6.3f%%\=
n",
+               printf(" %9llu/%-5lu | %9llu/%-5lu | %8lu | %9lld | %9lu | =
%6.3f%%\n",
                       (unsigned long long)data->bytes_alloc,
                       (unsigned long)data->bytes_alloc / data->hit,
                       (unsigned long long)data->bytes_req,
                       (unsigned long)data->bytes_req / data->hit,
                       (unsigned long)data->hit,
+                      (long long)data->net_alloc,
                       (unsigned long)data->pingpong,
                       fragmentation(data->bytes_req, data->bytes_alloc));

@@ -1052,9 +1064,9 @@ static void __print_slab_result(struct rb_root *root,
        }

        if (n_lines =3D=3D -1)
-               printf(" ...                                | ...          =
   | ...             | ...      | ...       | ...   \n");
+               printf(" ...                                | ...          =
   | ...             | ...      | ...       | ...       | ...   \n");

-       printf("%.105s\n", graph_dotted_line);
+       printf("%.117s\n", graph_dotted_line);
 }

 static const char * const migrate_type_str[] =3D {
@@ -1496,6 +1508,23 @@ static struct sort_dimension bytes_sort_dimension =
=3D {
        .cmp    =3D bytes_cmp,
 };

+static int net_cmp(void *a, void *b)
+{
+       struct alloc_stat *l =3D a;
+       struct alloc_stat *r =3D b;
+
+       if (l->net_alloc < r->net_alloc)
+               return -1;
+       else if (l->net_alloc > r->net_alloc)
+               return 1;
+       return 0;
+}
+
+static struct sort_dimension net_sort_dimension =3D {
+       .name   =3D "net",
+       .cmp    =3D net_cmp,
+};
+
 static int frag_cmp(void *a, void *b)
 {
        double x, y;
@@ -1667,6 +1696,7 @@ static struct sort_dimension *slab_sorts[] =3D {
        &callsite_sort_dimension,
        &hit_sort_dimension,
        &bytes_sort_dimension,
+       &net_sort_dimension,
        &frag_sort_dimension,
        &pingpong_sort_dimension,
 };
@@ -1951,7 +1981,7 @@ int cmd_kmem(int argc, const char **argv)
        OPT_CALLBACK_NOOPT(0, "alloc", NULL, NULL,
                           "show per-allocation statistics", parse_alloc_op=
t),
        OPT_CALLBACK('s', "sort", NULL, "key[,key2...]",
-                    "sort by keys: ptr, callsite, bytes, hit, pingpong, fr=
ag, "
+                    "sort by keys: ptr, callsite, bytes, hit, net, pingpon=
g, frag, "
                     "page, order, migtype, gfp", parse_sort_opt),
        OPT_CALLBACK('l', "line", NULL, "num", "show n lines", parse_line_o=
pt),
        OPT_BOOLEAN(0, "raw-ip", &raw_ip, "show raw ip instead of symbol"),
--
2.34.1

-- This message and any attachments herein are confidential, intended solel=
y for the addressees and are SoftAtHome=E2=80=99s ownership. Any unauthoriz=
ed use or dissemination is prohibited. If you are not the intended addresse=
e of this message, please cancel it immediately and inform the sender.

