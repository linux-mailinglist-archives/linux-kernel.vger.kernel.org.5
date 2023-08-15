Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8625A77C6FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 07:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjHOFSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 01:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbjHOFO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:14:57 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0499173B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:14:55 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37F52MFJ001655;
        Tue, 15 Aug 2023 05:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=4uOg7bpgHdN9pHZigWzGdbD8p9LfdsRWobca9q/iW+I=; b=
        NALBNX6lYaZe6DbESzwOkkaeJTT4Ey/KuwBD8op2IH7Lr0xAYNo/W0E44aGVJzZ4
        S40uBS+r2csNcwZN4FehqhLY96Hg6wpWbHu8r58M4qIR5W8BYt8Q8WsrrLDi2Hwe
        qBsTmTM3/oSNHmWCPK00KVlUPHH+liE/FHaszgQYfhRZSAZes77rIdQ2oES8bilG
        tZlukaiNT6NbZ6lXtAYbG591FoNgA6HNb3zunj3onLCoVho6uRH4OZX/Y+2mUJI6
        4vw19rr6bUffIpoFPCYIP93/O1dk/JzPsUhIWcZrHi9JZjvgp3aFY70pjauGSIuz
        CT0DUVwqozHaphPLJNPogA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3se125tg55-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 05:14:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZx3PFskNAUjFImELZg8Js8BcYAbACiaziiR7OimJL29NhYZjiB+LPUSCeydivNesirVQNc1o/jb/szyRsqHLt6edZsEARUFjvymevrYmKTn6fzSEz5pkFH4DB4kNhsj1BOmF6h/F6R5nfPXJJCGPqgLxh+n6yrO5MMJueO4CY+zC/OLiF4qE0u3z/bq7IDVkH6X7T9eO0sI/wWFJGuEDP8zpv4owLkTrLS6Z35s7B29XvtYFHAgyxIY388hpoB4K39R8+iaO1PM47tR59y/D/OQlqDn77gJs7H/WxJOYPrCNvoi4Bh0rnJpiH4RYcc8m1mcoHTKbf/nyZ6KPgmV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uOg7bpgHdN9pHZigWzGdbD8p9LfdsRWobca9q/iW+I=;
 b=TB0bgy13H02duEba+QUkVnh9o5iIDE6fhCnKoH3/im8zJl88rYsWbfIpOTq6lu0uXtG8BJUi4AmByKHAHjr0SCnaI7Kye6yx8ylqay9AxXHKaL56icpxiMcVbuddmUT7R/35/2XbkCbROE/9uf3P9VDO7nKG1lLBeNHGd79LPABssykbh/gVlUib3KO8WlDX0YoLED4al++BKfOdm07k8MNyWZlk1U6zz+/8Nu81tyI8Bg8wyi/hKJH5uxpvfMDALtSpMjZA/zWwmfMUEEszggVHTxNgEYByDHiQKSoAVt/95NrTfPXTT3WGLfniyliBU4nk9dRiuzWis7ezQLmfCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by LV3PR11MB8767.namprd11.prod.outlook.com (2603:10b6:408:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 05:14:30 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 05:14:30 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
        glider@google.com, andreyknvl@gmail.com, zhaoyang.huang@unisoc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm/kmemleak: use object_cache instead of kmemleak_initialized to check in set_track_prepare()
Date:   Tue, 15 Aug 2023 13:13:57 +0800
Message-Id: <20230815051358.802035-2-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815051358.802035-1-xiaolei.wang@windriver.com>
References: <20230815051358.802035-1-xiaolei.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|LV3PR11MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 084ae137-24c9-4272-4ce7-08db9d4e7c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1wlY5RhVRQvjaPFd+Q069mU4fSKWbvRLWRKanK4iRMrNBJtdG3kUR/uk8wtM2ZmItq9LZAzwWyt8/G0dkytvzG0uyk/MNwZTLrUAl9Br09gwNOaJDQon0ds3Eg3WTj4zVeP8V94gS7DPE5eVkVM7ilQ9T0WGWLsU71PUDxTrWM9FqXgkhGl/rdwKa5kWvcrQqWtmP2MFgQR1QXlFi+GRrgq7ozFUai2sTa/jf5PlUczLfyP598/V0cE6ZIOuFhXJFkysmn4VGioTrrj4PZYJ2smlsp2vw2q4sNnlr9aAwmI1PxqDHfsLW3tCpXVysHYlP59wmLTh3JVhrubcRT2Afo3yEVt7SocK02sDpp7y0il7njdjuBlPXt9/ZNp9V3ywd8Xs5HtJGvuqShbkT6C1irYPHLiNT45VRKfACkXbPqvxCL5FmAfZJUoZP2VtMMvvFkK/dr95RU/fVzIteu5fSJqjsNg0F6YQoD2CP/vcMmTBs47mnaIdFq7+NdlTSWLZkVFwBu+4mAaT/exi/BmjqNelg3Ox+L7HRy8MdfwruFEX8IA1DnGz1Qeu7Cgy+Nyyx3dYXi4FYecKe2nUeWcq0teYKbedtFPqGJfwU5XYfhiQwt9Yg5rjiNnW6OFHmP6264lWFPlwPDqoxwwjw3wmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(136003)(39850400004)(1800799006)(186006)(451199021)(83380400001)(36756003)(1076003)(26005)(6506007)(478600001)(6666004)(52116002)(6486002)(2616005)(6512007)(86362001)(38100700002)(38350700002)(5660300002)(66556008)(66476007)(316002)(4326008)(41300700001)(66946007)(2906002)(8936002)(44832011)(8676002)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tlp3svJrTIgsLEI26OOokcZFExzX373XrOgEAZtLeRY2TH7Cok6pcRFEYGLM?=
 =?us-ascii?Q?/vgyx5qD0LXo51bfX73S9nE35vymCIp85vuQo3cgLuu2wCWfJHHN/3FVuvXD?=
 =?us-ascii?Q?YJd5QOGYeI+T6kqCIEA81wsZaKGMragFSn/TVGPSQzzU9DZ6Jf62gHAUsYgu?=
 =?us-ascii?Q?IQBMlKOh7/qop/P0G5G8w1nRHBA+mOSrQci/d8jGUGZ3nqIU/NmyxXxuDIX2?=
 =?us-ascii?Q?pURB4Bqaz6Zgi+3n0phN3itkjz+QTPemV/vj6FsxX3b3QelVCrQ3i/bxypLP?=
 =?us-ascii?Q?VNhoFzA0Do32mALzNBFhY3iE9zDYIQPBwy47o+XjMw2AJlTKDBpoCcswc01w?=
 =?us-ascii?Q?wCPrt0I5ZvoT/FtQbhhj6VYgytdtNdSPIQJFIJHhJ4DMabToHwUvk5+ir3Va?=
 =?us-ascii?Q?Vf9B/Jg6LWCKiVZGzMPSaCKOJfixP+k/+1HpXRLI/POb5IVkP7/biqE+4/PW?=
 =?us-ascii?Q?E18q+vVBzbF8rhSPembrYtp5iLWd0+sArjSwZOGl79ebsSGsVcU4gRuW2JZR?=
 =?us-ascii?Q?ByxIATeiFrTwk8OYNFatVaexMli8XeGZ8b6Xtz1kCGywuba7QnpmdQcjekwv?=
 =?us-ascii?Q?+KInUY0/G5EIuEishP39TKkU86l44h+wBe6/wprBUiYKGkSXXrXpPHewdnBD?=
 =?us-ascii?Q?Xl7p2+AP4WKaMBslyurv3OTiaWWkXYjRrVjfZX9ZEJukSF3ESkM7SUp5tl9N?=
 =?us-ascii?Q?uS0QkqYezDJZwY3/f4aGkH4E4F2LiJW5OVvmpBY7HaYq3Ty94q8S/1vJMhPU?=
 =?us-ascii?Q?S/IDXvhLcMD1UdlLcG7Eh+ckWYGpe8LNUQAamSY3McUMu4zTMUnDx62Yew4e?=
 =?us-ascii?Q?qZQhC7nrHdYnJJdAKranNyZ6Di/S7EqJBfT2R5GaomhaEKG8x19YeC9GbDda?=
 =?us-ascii?Q?tub70tIjIF+aq/nUSct03LJ7p16oVsRztH0FU2PD49C7Vf9+0uqTLrFw674e?=
 =?us-ascii?Q?7UGvbMfb2DebOxPqCSfI0B+cEj/HAJGw3gipfX3zibI2j2lWNCVP1h4JC5x3?=
 =?us-ascii?Q?hdCl7Rid/RY7viiYyiwBWxQobzGzXeAqvFugQSHIoLuwGy111WX/UDTX0HeV?=
 =?us-ascii?Q?6/UD25grISirSWloPrfUMKXDM26LLKbliS/b88TtAOPLOqs5UQDszMJLfshl?=
 =?us-ascii?Q?Phcg6bXY8Ur43Pbe50aPvtKsFIrJFAteBR0oaa6nBO9mq45Igpzy3uHrv/BD?=
 =?us-ascii?Q?BAUumT6W7bVWx9NWlvRYg+O3ZNDYELf9G0Vsamb6vONv8BFKaKdL4A+n6EuN?=
 =?us-ascii?Q?YHpq936qrMy50CCAchX5bhD04znp0SPouleJF2KI1qz+ofAJPqd2KuWLxYrG?=
 =?us-ascii?Q?Xt+RdOQsmuM897JDoDtQ3Lt7jF/FhUGz3a7VDBflIoVlJ70cJLNgGtZqWoEN?=
 =?us-ascii?Q?hW6k891MCuhBv9lvnCvWSNUphTeJQgo/qr/1Xejsj4f0I3qyU/+VfCL5D/q9?=
 =?us-ascii?Q?FHD0U8M9NeC8XtmK0RSVHp3xj//pwlqHFNm2BuxSd7ZJAGrNB5xYXLRp1FZQ?=
 =?us-ascii?Q?29SPx3ErQY7SYzAswUIdr9a2J1a1G1S+1bnjL0aMZSL4SugWQ7BBpPxlhBRD?=
 =?us-ascii?Q?wVxm2yXu90bu/wmN2lQOUNof0V23HvliXH4aZVWfpQUuc7BVc+voFAh5/aZl?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084ae137-24c9-4272-4ce7-08db9d4e7c96
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 05:14:22.8135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYQndKWjRCIMie95LlDMCfOn/egrT0a/owNuh4J5SvKvXrp77H3QTYsdg8x6SV83qRJz7Hnn97rNFMfaAwCGPL/Xoja1cztdHDrq1foOJBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8767
X-Proofpoint-GUID: 8i3Ucapkl1BjXQ1N5dV934UxvOWNqA2M
X-Proofpoint-ORIG-GUID: 8i3Ucapkl1BjXQ1N5dV934UxvOWNqA2M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_04,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=793 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2306200000 definitions=main-2308150045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak_initialized is set in kmemleak_late_init(), which
also means that there is no call trace which object's memory
leak is before kmemleak_late_init(), so use object_cache instead
of kmemleak_initialized to check in set_track_prepare() to avoid
no call trace records when there is a memory leak in the code
between kmemleak_init() and kmemleak_late_init().

unreferenced object 0xc674ca80 (size 64):
 comm "swapper/0", pid 1, jiffies 4294938337 (age 204.880s)
 hex dump (first 32 bytes):
  80 55 75 c6 80 54 75 c6 00 55 75 c6 80 52 75 c6 .Uu..Tu..Uu..Ru.
  00 53 75 c6 00 00 00 00 00 00 00 00 00 00 00 00 .Su..........

Fixes: 56a61617dd22 ("mm: use stack_depot for recording kmemleak's backtrace")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 mm/kmemleak.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index a2d34226e3c8..04bb4cdbb402 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -610,7 +610,8 @@ static noinline depot_stack_handle_t set_track_prepare(void)
 	unsigned long entries[MAX_TRACE];
 	unsigned int nr_entries;
 
-	if (!kmemleak_initialized)
+	/*Use object_cache to determine whether kmemleak_init() is complete*/
+	if (!object_cache)
 		return 0;
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
 	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
-- 
2.25.1

