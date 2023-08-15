Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714AD77CE55
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbjHOOmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbjHOOm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:42:29 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7937D93
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:42:28 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37FBeuwA010670;
        Tue, 15 Aug 2023 07:41:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=JsvlHK+amocfSnHm3g/RtZwP7SnQspb5Fe8hyStrUnU=; b=
        DO9OPvmBJuYog/s4K2iwRU0TY3wQHM/8XsmjNaHQ07WOnBFmUzh4EUt+v1ojj7ow
        kbwEvQT+sMRIBd7UXwYusuxooeqwAE+5l9PabLRv5Sns2IJ/Kcz+EBgN2rdscJFU
        ZYrtp1sh0Vna1iehszkEevyxz7YVPbPunbmxaLoK5SE83H3t0uYkXc+wuTF6sFg6
        qIQ5cYn3BvmI907AOp/llpvNXa1/P7VuOjrnr3ziinvuqqo0QRPq5AO/qMT+AXpv
        N/8SbiwZzXRQ9Qg6GUD/xfENZdttfY2Mh9jTTCGhmLy/iYSCwBHxlknwn8dRKOqg
        T/KrG7D0Hj0zkWrYzZIqGw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sg0rrgf7w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 07:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xf8NpKt95Z2XfUP3KMfrAWYKQbLMfsa5xoDyyQCYIJO65i48NPPEwXXLQ834Io2dmR+b15Et/Vs03wn51mtYenF3bsuMOK3gtzQgmE+hf1uRnh+GlD4A1f4WlSJ9H58dqI2lz6tU5J0GGjcYlu06Q9CSAuAvqXf3PbqYogx7LKnqj4LKQmfjT6bDHKCH3mXBtBYFDpSrTk0mLd10ocfHJdr0NOARyDBumDe/2OMPUvGxBTv9FR8KWm4NrA6fbfm9MgyQ52ImIP/0wzFJZ5AnM1rPkd4Cta3vxmM3fT52rYxGinuu4sg8g4PaAUHy2uPbcBiFChjxipJn8dNgjCNJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsvlHK+amocfSnHm3g/RtZwP7SnQspb5Fe8hyStrUnU=;
 b=M4UcqI8LnhVt3huHHYEH1oz05QiWv86A8uH+UYKf1xJRhiXIMkLT3b2evWomTIs3pM1KQnp+jCV6vbYs+eZJT4wV098+N4gIOfuEo5PuHEUuSWjqlY2V4pDWG1F5/xdrl43uBiG4/9n7QUs0HmrWIF0Cd+zq3Izo1AE2jP6x+I8uxvtfRN7PCs/xz2WHPmUZ/u5TZryCbwMDrAfJSMvyQ8kaO4aMM2t2nC4s/7fgC5zIOzmTmJ6hnh+yQf9Q2/VX42STI/mnhJpPABE/wXxldRT4h4/F46GxJ7gfLK+eYAE6xnPyjQAglRAaiEzVcjycC49CwwuMypMF34WxgMGItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 14:41:53 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 14:41:53 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
        glider@google.com, andreyknvl@gmail.com, zhaoyang.huang@unisoc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mm/kmemleak: use object_cache instead of kmemleak_initialized to check in set_track_prepare()
Date:   Tue, 15 Aug 2023 22:41:27 +0800
Message-Id: <20230815144128.3623103-2-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815144128.3623103-1-xiaolei.wang@windriver.com>
References: <20230815144128.3623103-1-xiaolei.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|MW4PR11MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 70822afa-9fa9-4f5a-fbe1-08db9d9dc46a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1z9miHaxkCipfIsMxLd5Sw8fDiEsKYAwz/5vh6B/8jS2XuMcANyRgt9Ts/ZQg1NLTJY3rU76jwO8O4IytlhiVqIwOh7N7BMcnA0j8xVnzC7TnzooQsbx02VMWOj+2YsqQeabbLcAHyQbJQNzweNcqzmcJ1notavRsbdhLGFjhZFCDxEVlqtz5EAwFfS7GubIz6XK39U4wElQSBNEG/nVGCWNpkJJvJttjK44hS0ib9jlDd6bk50BsKlEsDUWYT0wJT5AOlrmOLs7yxh9TNJ1FWpwCp1NAWmTv2+373+MPbkk4rOFoaWX7euQLKVKHa4Ae3mCMUXmJ/el0heVT5Q3PAPM0orC6miulQ3SwJdYMo7BVG+3NW8q2DpN1bBJoO2M2mZU8qM83cpBM4GdYqxKwl4yZmsqfIAdgrS4z+nNGWLIy9ptIIWh8FpBPMr4/DRVmBWyhXrj4Ap97U2tJ8ttyL/eGuJmpCbDX3LaMvkniucnBlhbsjtFcaoQFFKUV3EyzLaGU5mAkg0p4wU8LmRSFV3PoCiYl8DrI63of5OtEzdes2/vBrDcNE+ncrHXU1glwXYWR+Ep0H0BRdg6SJuVanslX/IfQSmAYVcEEpzoYcDbfB5QivZslHmkPLWVQneXIfp0jBVoKs8hFN1XwOt1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(8936002)(4326008)(36756003)(1076003)(26005)(6486002)(2616005)(52116002)(86362001)(5660300002)(83380400001)(44832011)(316002)(6512007)(38100700002)(66946007)(66476007)(6506007)(66556008)(6666004)(2906002)(38350700002)(478600001)(41300700001)(8676002)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wLnkoEiJ6xeUvfv5HZl2BPlxQ65dRwTLsAuVGceclY/mYNKvPcDSwE7QdSIG?=
 =?us-ascii?Q?j5llY45dRdgFW602ep7MYTJNE1daJvWCRIfiv+iuVOTJ6HZeMgvp5Ceno29d?=
 =?us-ascii?Q?hKwHnLZwYTJfFptRmUHtEY7ftmGMCvZUdyQBBu2x5Y33RNCwQM+7L47ObJRf?=
 =?us-ascii?Q?tuUNd+AvgRfCQB98/3vCq9A8vN5T/v3/a1ha5voZc3lmEeR6line2cd1gae4?=
 =?us-ascii?Q?q8FxDx80cN0qhWxVCskWtp2jhxZG7v4WD6X2YirhR+5yBfHBvSKhcGdVNWEW?=
 =?us-ascii?Q?dc9OursRmK2phJTqrVOZ9vHhgSyGZJ3EPS+X+jc3cL9o0Af9kZQ1MT0UcQV5?=
 =?us-ascii?Q?emtEcQwwRucTzyIKT1Quyt5cCvzwQHl9eBRn480X2Mvhfk5rY/v3Pmf/14YJ?=
 =?us-ascii?Q?9nu2trW9luRWqImJ7Wuz2TlCg/AqN4O6DWE8wXyNyDMpxQU05taPz4WiUBqy?=
 =?us-ascii?Q?KvkRh0X1dzzsgNtOGVAOY6XS+4byOUkYJYZd4/Wv7eApi9givFHFLnhEtDYA?=
 =?us-ascii?Q?PagXCYvHFKoBzyYxaChSA80Ost46W+1c58GCoIMG2hkcXZr2aWo/YBtkJDTB?=
 =?us-ascii?Q?Iqi3mrXdghApRcXpyT8kM/qoMtl0Mru0Zjqo2q8a13DDYhJwykLHfV/Uchb/?=
 =?us-ascii?Q?xq0KN2eHEg77L+pmdmRjkZ8cfVI8W7w/PmMSjpOE0Fgxs3JBJk4EXlXFza33?=
 =?us-ascii?Q?bzIHZHzORpZbhi5TpXTeWVBNVtCz7gCm9O8dJsnBEwqVHeatwk5RgoRcS2X/?=
 =?us-ascii?Q?GqGx8evr+HzwdxqcQVNhxnnVIsAoD47jOm0RFzV2yTuIAHmHBRx7GeZFMg0e?=
 =?us-ascii?Q?tRXuFifV39fGfFsLdewQr9yMFxKLSdwLCyZ647nXdSP9Om2JkMM6hJFtjdcM?=
 =?us-ascii?Q?pVhS5jO6jObzUo2Yp8oAwpl4UEHlGUozmgHppmmGq2o1GiAQBzhw1Gm/Ao15?=
 =?us-ascii?Q?zxb+svuUNJSXAPTbIgQIRdUeX/+DDGdCj1ZrD2ODcezei2QPafrNEPHqKDG+?=
 =?us-ascii?Q?LZtm2Sz1H8fVzjHrLG9BmGDqBFvXfjE8kIr7Zc+LiGYAx+/jMQWKhG+fbLSz?=
 =?us-ascii?Q?Vk1/F4gPX59s6TgfsLDbgZEMMMgZv31CyZSEu+E20pfNuzk8d7CxswdnEECc?=
 =?us-ascii?Q?suN4LLW/7c2dauKDzt7H/4RrO+8nR9wzrfbndMnrI4eqHbRc9cB3fdDeJljh?=
 =?us-ascii?Q?AfiXUvhjYQtjOhhHf3eM6dJdx/yh6kqOk3OHKg3tupHvnKrG6dpLfp7ySBtC?=
 =?us-ascii?Q?A0I/Fzf4n7RJJqI45wCYDWlLfsxWeczPiYsys5/NkspU4XgEkk5zX+UgcUT8?=
 =?us-ascii?Q?CMyWZMYS8kQueoC8rJshIFu1kOwbi1mlHFeu2UFtQ+DYm4ZdqxQkXUYt4+/t?=
 =?us-ascii?Q?qxIO47rtDWewnmiyVBaR5VfEXijTtUaR4pOkJH3gSpeFascDW58u2YMHxH42?=
 =?us-ascii?Q?rlCVsUyzAz5R0EgaGp+V7jDXkO+5o+zH4Q9t3+6nrp64v7QaRn7pTJPpheH6?=
 =?us-ascii?Q?xLGAJXvLhuKEHY6AQ9RYbuolYRoLqKnyI10wZvZe1Cqf557opoKTuiBgQS66?=
 =?us-ascii?Q?22NpgYbzujj05tl7RBbfD8w+2ZYoea+1gFRSHS4V/bVDu3iQENxn4NkXjnkR?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70822afa-9fa9-4f5a-fbe1-08db9d9dc46a
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 14:41:53.6103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjT0TgaZphAx6nnAILIJk+1KSSUfVKHJjQ0MppcPrVZpcudBObqO6zfk7oSiL1L7IiDWOZkCx9W3wDvyEDu1pZvPUHq3zX9P5iPiXAz72FY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5936
X-Proofpoint-ORIG-GUID: E7L5jATNtc9gJykcfoRp2juTnCMMZQ4H
X-Proofpoint-GUID: E7L5jATNtc9gJykcfoRp2juTnCMMZQ4H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxlogscore=743 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308150131
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/kmemleak.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index a2d34226e3c8..16fc7b0984b9 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -610,7 +610,12 @@ static noinline depot_stack_handle_t set_track_prepare(void)
 	unsigned long entries[MAX_TRACE];
 	unsigned int nr_entries;
 
-	if (!kmemleak_initialized)
+	/*
+	 * Use object_cache to determine whether kmemleak_init() has
+	 * been invoked. stack_depot_early_init() is called before
+	 * kmemleak_init() in mm_core_init().
+	 */
+	if (!object_cache)
 		return 0;
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
 	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
-- 
2.25.1

