Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50FA77CE56
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbjHOOmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbjHOOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:42:24 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC5FA8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:42:22 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37FDwEl5015022;
        Tue, 15 Aug 2023 14:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=cIEEJeJi323gmINp9jiVcSV3gAmCQ+eiaZrrevZNBxc=; b=
        Xyat8SSa/PyA6y6JUe9IpIDETVXq/m1q0WpGGWD26RlCQzLtjwr0Dp5ZKeKqZNx5
        UK+sUOa7QEA8411gFkP6lnFyTVZeeBzaIaYjoPPC+YAil/zk/reHqmOq/sBFXFe9
        fakJFjKh1O0O22MF/Fgn0Qx53HcnpxieINW+1eiV719+vub1L+fgqjBlJrcHH3K2
        DterIoCB26tsHLRWPlWZrm5Xs7JzoYsqUU1XVXhVArjyhzTz3Gez6SA0uyH6xf2X
        BWorYTiiPyK1LBPmaSBTmF2m+dXgJfJKBg/MQqpuC9PRLlQlsEeUnjMhc7jYqhsg
        xXLkNUnXK3K4qO1+H54Z6Q==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3se125tvd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 14:42:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRQhMHHg/8XcI975f+qanxgTPiu4SajwpqbL22Kr5ZKDgzAWKY/keooMaFboS7Ic1evW6cFDshiiXNWn0QlANower7RMxIO3XmdBTZvYOPQbNJmkDuAhyIUjhnfeF/ghbP440x60PAB/sDKnRqe7S+sP6PwvxOKSxp2yexB7Dt9xpnGKTMBLM/xIew2RRrV2npPNrPReHz5XI7MWrqGogyvS/wneTQkCwLmQsEpetqaHdihrdFab5QXSFwtIBmKWPv9YBjdt7Eq5nYyhv5LfimMS6AFjD3UX2i0lne2zPsDalQQPfkenpHNSU/RPq71pj63AlEznoBzbbW/Be62RRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIEEJeJi323gmINp9jiVcSV3gAmCQ+eiaZrrevZNBxc=;
 b=eB1GGf/IHTI8iohpz80ZWqgomb9vPDyIk3GZhKx38hI7s/zJYyFaa09so1sG6YTxdYJhoE0s4IEAI0U2LVZf8uuljh/R18VJbLtEUczSMF3t7XnbY+qqGHPA4eCMW8MSYlXowuAtWDCRpu7hsK7w/0upE40wIjluo6yHVOTYe0BBaXLCm9ilxnBndEM6OKWrs4wjRn/U9Yx/4pGvitwdimGBrVQXPJyFMF5o5BDbknIdGL5nl2dQxAf5+qDrK+pIlSmOGuzD4x7SRefU+5JkW6l0c5EW/1CeV2UeozDv5/cZCWJMPVIO5Z8gQP2vH0rJRwO5X9CkIqKdoQHifYTNIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 14:41:56 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 14:41:56 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
        glider@google.com, andreyknvl@gmail.com, zhaoyang.huang@unisoc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] Rename kmemleak_initialized to kmemleak_late_initialized
Date:   Tue, 15 Aug 2023 22:41:28 +0800
Message-Id: <20230815144128.3623103-3-xiaolei.wang@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 64f04b5d-39f2-49fc-0c89-08db9d9dc637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykV7DqLo9+WAgrD0kcJGAOrkvVdQC2RIGi+rScnMLJVGr0RLIo1NmX4dRdTPu20YyipRkJa2QUsKJcJltqyzMK+PZcfUUGqqANiLCxJBJONKLM52Xd9eCWJrCxONeez6Xcz2OZJHBl3VgZ5OlhhNRq6Mhn2906STg0v59f5kdPo+PLhjhIFLZA/6+g5YY6YgkfFThh/Y9CJE7c/ImOBmijl+EkowWD4OieaZHqxrwuqBts5/ul/4F5vKHGJC0nAZreM+2dSbZ5rJJJeWk/Ot1F+mt5VdKnEK5cAbyG6hKUeCVzSX2f2l+gcekFaSMxo8FLe4JwPMHELigEg0sPpujJIdO7iOlsc/s4RqCrm4BnQV/Fn2JY2nXifsM7fvR9rhkJbAWskPWbfKqSyQ8+qaKfnsco6XO1K8m32tMMc5AOxK7qkQ611EJLGCxQVY9zK27IooA+Gpt0t7DPCvsI6DLSI8N/g8nZUWtWUGotgPTUMACrlp2zfueUd/6VjdOOxZvnSofMtnU5ILo/YrML4m+scKLCwRJLMgurrfvNPocWqmW18SuxG05KuonWejxEv6+lpGL/sk0Ucj0KHbD6YJKUQGCpr2HnqTwy+VtbvDbdGlutfUe3fjc5lun6OlRgMG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(8936002)(4326008)(36756003)(1076003)(26005)(6486002)(2616005)(52116002)(86362001)(5660300002)(83380400001)(44832011)(316002)(6512007)(38100700002)(66946007)(66476007)(6506007)(66556008)(6666004)(2906002)(38350700002)(478600001)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NNxffy8xvTBTXodCzzbD5KZOP+xoyqHF3GzctxcW8Lt52rJ4cqE4Q/nXtvZp?=
 =?us-ascii?Q?5uvifYgw7RpYQw62SrRDSqPH9JWIIieVE2Dom6O/bHFSEnpEO1bptKZamZ3U?=
 =?us-ascii?Q?1OZ4Bj2u7da/6O021zcnrMSV2kHUsmdEiqBflKfkoost1ZwG+V5LnM6gX2QC?=
 =?us-ascii?Q?utdR8SXFZx+Oaxdoq++ozGE6cN49nZnlLS5sFyBAjjYM+appCc74cvODJ5N4?=
 =?us-ascii?Q?sbhWpF45lw/fIdwgp7aQA4k1wiOAQOa1IQJLNnKGcO9/J/CRSTujouhA3qjp?=
 =?us-ascii?Q?DDJJ/jQ14jnMUFlvrN63D+FFhG3IQIVRxWPEeQY/R4virDpgNONFWAoAntBs?=
 =?us-ascii?Q?5pcAuajBFP8l3ylhvB8S/Ruj3vMFEJGF18OzFgQDRAbLvZhX4cMDghtJbNDz?=
 =?us-ascii?Q?VPNryO15ewXJuVedj3E8lQQPDIJ5S5E45JKINZbM8Y4gQ95PhLBOXFUx5Ew1?=
 =?us-ascii?Q?pfLvomd5QLpAukZ93CKONFVfQVXCDXgnyT+Fx10wl9OHdIDt+q3Y0StzjQww?=
 =?us-ascii?Q?ggJNF250VVyJnPyquIpBMb8wNj8Cp2hM87RPNDY1r7q6M/146dZF3iB/rOHY?=
 =?us-ascii?Q?RSs1uRlgVd2ofuJSdo3pal8MwJ93DT04K2F/KoLfAj4kOo7xavbyrr7Yfpji?=
 =?us-ascii?Q?1oNwOh5rWzd3rs2ignfcKtLQywX+TEh7NsD3JDbyHPng1Ls2fu540HbV6Kau?=
 =?us-ascii?Q?QZOokqXkbNE9jWWzoADV/ez3KjJB4M9V/pVj6P9IuWwxJLgB8pYdrBcsHaZ1?=
 =?us-ascii?Q?2b05Wrbu9PSHtZ0BL6NJbg0CvWEbUEdZVWEjNZMUBtPhVREUTBIdfOmXsQ1A?=
 =?us-ascii?Q?H9hW4Pw5/8gzKCQWXFFAiFDE+5DNAqQFecf/5Lzx1WbG822KViSc2dWDm1m/?=
 =?us-ascii?Q?Jsa1wROw3g4mt5wadBh0h/xOrrH29xSXCNmzrRsy1gWDVLk3Rxxqxb6MhFAd?=
 =?us-ascii?Q?6EsANNaPBMTjRfzO2Bgqi7jqCTO0dcxfDtFD72bWCA/DehUy9EypmVar6Nar?=
 =?us-ascii?Q?e8rULfWaW9ny/PMxR5axbKcH0M6OeQ0CcK4IEUxqJ+r84PlZIHaQkeLlWVs3?=
 =?us-ascii?Q?l23JxV0Isd2hZlI2ReeTDf0ZoR58Bqc2rDxpLGUyHvEA3jLYagKrahNW0v3S?=
 =?us-ascii?Q?X+o0edlH7GejONgwS9warOjqqfhjQ7pk/uniSM5JGuMvbroG9RVv0KHUvZWc?=
 =?us-ascii?Q?krdCEaety2S1SzVskBXguVbIHwtVVQLo6wwND8KPQyLlNHV90+R+GGy+b6Qm?=
 =?us-ascii?Q?voQZsVGH4NmLpJsJDQjMHenHhM46GziHg8+lpDal2iiAOJBpDLaCmuX/Lsnj?=
 =?us-ascii?Q?S+7dtOU7YSfKnOJ9fN2p0prP+lL94xVu/W0MV3RZzorp/3MzzpCpvgIrtnOK?=
 =?us-ascii?Q?0brxfSuyOxHHrBj+ELwBbsMbBObRnKUqa3diUCGa5Yz/6Sobv0ww+jdRxsKn?=
 =?us-ascii?Q?bwNIwZO4iCriUGdmplrxapNanby2aL6xrVMVHrfeM0Yo9dpsRmgduJrt0NQO?=
 =?us-ascii?Q?xyvRfqdoS/K/GmKuXdEwUOx+i3CzOOVzs85YVJbfZligtNEJk9KVcGdg7fUn?=
 =?us-ascii?Q?AGWzmRF/vzOqGmZj95y6aCjz1hkKOeXud5kA2iRrs+SZbXXkOe0x58dGBy6W?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f04b5d-39f2-49fc-0c89-08db9d9dc637
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 14:41:56.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPQBWqkwOFnjEWNNQSa0sGIvSK3JW2bfnWB9lvSJuXrIUmW8X2I0fIFIYnz2jTpCeLBSCZnFMM5IKfSB9wEyLeizAbNxqZtX+ml2KPX/JNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5936
X-Proofpoint-GUID: vg6kmdoe8wYR4lxjAuL0O-YkNtTbWysD
X-Proofpoint-ORIG-GUID: vg6kmdoe8wYR4lxjAuL0O-YkNtTbWysD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_15,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=524 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2306200000 definitions=main-2308150129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old name is confusing because it implies the
completion of earlier kmemleak_init(), the new name
update to  kmemleak_late_initial represents the completion
of kmemleak_late_init().

No functional changes.

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/kmemleak.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 16fc7b0984b9..2918150e31bd 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -218,7 +218,7 @@ static int kmemleak_enabled = 1;
 /* same as above but only for the kmemleak_free() callback */
 static int kmemleak_free_enabled = 1;
 /* set in the late_initcall if there were no errors */
-static int kmemleak_initialized;
+static int kmemleak_late_initialized;
 /* set if a kmemleak warning was issued */
 static int kmemleak_warning;
 /* set if a fatal kmemleak error has occurred */
@@ -2057,7 +2057,7 @@ static void kmemleak_disable(void)
 	kmemleak_enabled = 0;
 
 	/* check whether it is too early for a kernel thread */
-	if (kmemleak_initialized)
+	if (kmemleak_late_initialized)
 		schedule_work(&cleanup_work);
 	else
 		kmemleak_free_enabled = 0;
@@ -2122,7 +2122,7 @@ void __init kmemleak_init(void)
  */
 static int __init kmemleak_late_init(void)
 {
-	kmemleak_initialized = 1;
+	kmemleak_late_initialized = 1;
 
 	debugfs_create_file("kmemleak", 0644, NULL, NULL, &kmemleak_fops);
 
@@ -2130,7 +2130,7 @@ static int __init kmemleak_late_init(void)
 		/*
 		 * Some error occurred and kmemleak was disabled. There is a
 		 * small chance that kmemleak_disable() was called immediately
-		 * after setting kmemleak_initialized and we may end up with
+		 * after setting kmemleak_late_initialized and we may end up with
 		 * two clean-up threads but serialized by scan_mutex.
 		 */
 		schedule_work(&cleanup_work);
-- 
2.25.1

