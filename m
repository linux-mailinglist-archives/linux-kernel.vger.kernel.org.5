Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8931977C6FC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 07:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjHOFRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 01:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbjHOFO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:14:57 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05B6173F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:14:55 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37F5Apjb013432;
        Tue, 15 Aug 2023 05:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=cJ5AWTgPrJpbBZ71dFy0R5qotClE1dkGyhHip/3Vc0Q=; b=
        pKRFthAq8PPX3Le23L2XxZtqVFAOya5Idog3VhQBu1N+l5U3xVpeuhquJJDsEm/b
        s/iIWe15T9gjCR41w7bjcwiaq9wD7hyAsVAJ8+5U5feosKWsHKw6HtVIqaHk4qhL
        xnXrvyvMSbimvqO+TYj1OlpmqmKk9Vy5wexCn3vLT7I3qjKE9BoQNs7jDpnsUHBS
        eQDGEMBmLs0BOdsevoCngqeP6EBTgJvipo5vuS56zLo3ngYTBh2nEPhYg15/30+p
        JmWq2a9FiZAmU+3t2L5+Gol/V9K5NIE5ZfaXRJdXVp37D0IqLEceQvlyh3zrBU0e
        +pooTbYDFE5utnr4hbxP8Q==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3se125tg56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 05:14:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI7ebqGnCQdGVSc7QFdOdbRLodRnMLAiIyKwznLSPdmYrCT+kF2K359ZYKqStOQtoOA93Qi0Q8fp3zwmxFnwWQ8PjXOoMq85up39QmHcOpXfghGs8WUTflBIj6esLofkFqbosa6EuTrcoFHW4iOXLQhu/UDUZFTuZFAzfL6+JhIcYfgPtFVQSXOOQeXMBQnV71rqydq9goM2kqJnb5jB8ArHamsVZApUyvRiYX7KgA9jl0XGODkxu0QGQ3HOWMX0RVeRvYWEOW1dD4NkAUEuHoL+OFsFu/8n0Aw4GXyirR/5IF502taNpDLKwDsiH1ox/XDWgJqVzpX9tD/ULHDL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJ5AWTgPrJpbBZ71dFy0R5qotClE1dkGyhHip/3Vc0Q=;
 b=Q8KEBau7ulHwErhcb6pb24ZPpdlELgw0BzlgCTc2i0/WfcAQ9NEnIIoWEdArXEFakuHd+s+YuKMWt+NiWDPBoA1fY8TZYCPseEWBiKbwfjgoVtwRKwQX7zbejTXWc++r5heI3PcSID5IlZed65NJ7g/DN0eLk93xKovlqFJ+Px4GkzZHzLkhgDGNuliOPFyT5KRGxFY6Lf+SoN5jep7DgG97rzU1nA8RBbQHslrcqSB+wSPU2HOQpc3bpxwUK0zJbqsrdv4I8BeZ+PN5Ppugn7DouUK7HQyPaYg0QnWQ1FQbM5Y6V7N1rTbxRrTo6x67805AYyak1LbB8Fl8se3iVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SJ2PR11MB7517.namprd11.prod.outlook.com (2603:10b6:a03:4cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 05:14:31 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 05:14:31 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
        glider@google.com, andreyknvl@gmail.com, zhaoyang.huang@unisoc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Rename kmemleak_initialized to kmemleak_late_initialized
Date:   Tue, 15 Aug 2023 13:13:58 +0800
Message-Id: <20230815051358.802035-3-xiaolei.wang@windriver.com>
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
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SJ2PR11MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c3f5b8-fb17-468e-24ba-08db9d4e7e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGOKkaj0es79Ex8vvgxGSaNModW1MAdzNZebNm+1vFvOnlDo6TU06BxgWxuWb2CkEN9jQIrAp5qSvDHFmVYrWfriNaZ64wKdw85YGyY78NZZUTCY1/v3L3ddstzUDys9YBwK94IA06Q59KVJ1R5ctNZyJC+88mn4hGgywsLHV21C0mGrGrjq0h6Qhz5KsgNly/lQTquaxCceLVD5+YBPPtiWPwNVT8nQELXN/r1r0jQVFeafj99ud2PyY5KZw1BJx1Gw6m+KVRNgsH42xI8kKTeN4D3JGdFhMnwYBxqyqd0JJtg/65OZBcPTP5HM2jGv5JuEMaHxGW69ENiYkNQsHc4sv4rJjmL+Oxh6i+v+4rAnQJODzwhLH9NvXeVvi0kGHIlUvDDjW2qeBLfQYqZe1mGwzUFirTvlRUruyJIxYhrL683CMl/s5CTHEflwkZw3AVkyZDxDxYjthKJcLXx9RjkkCcPi5YRmXfWyj1TEOP0HwFKKqxzeCYFvoRSNGUv2LENhArJSDSvlB+Ao5dGePH2uw2xzohBK2hjFWConaFAI8XpFm6QoI32wfibzFQiuRktKgf13mpnJQ6Kc23vkEAQg28Q5FeaEw6Dj8MGJpaoBDcVjCtEDIlPcqwkGuce2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39850400004)(346002)(366004)(376002)(396003)(1800799006)(186006)(451199021)(478600001)(8676002)(6666004)(8936002)(4326008)(41300700001)(316002)(38100700002)(38350700002)(66476007)(66946007)(66556008)(83380400001)(6506007)(6486002)(2616005)(52116002)(1076003)(26005)(6512007)(86362001)(2906002)(44832011)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0+KWyKwdCRmXIa8DM769PNMFrebcX6TRITol6volxnlDCejCwZGy3AN4JytY?=
 =?us-ascii?Q?IrSL7T+VY7sDwWdMEycCGo395pDeXjYMQYgHoQv/xtt8xyCdMLVPDfbccDKs?=
 =?us-ascii?Q?cjqlHNF9ZJ/AAk2HsE/4NV0WsTewf8twm+rnQz16AdH1DyudC9HBkPiZVUSB?=
 =?us-ascii?Q?1plJLB2JYdwTiSsGVBRnG4QOyx7mrcu6iomRkjzLnRqd3slBh2Y25mPP4HJe?=
 =?us-ascii?Q?ydeNTGmj0TJMyL8k+jaIvI8RZ4CKvD5/HfgWyvbsD/Y5iuasNlCFRZ3HO5b2?=
 =?us-ascii?Q?Jq4aeebDr8cE5SpLeUQ6y07+4qxkTbQnx7Pw4QplqzrnKGs15W6j+mOcNmiB?=
 =?us-ascii?Q?Qg3JeBGvNhXPbZe8iayBVQjFBPFGRSnTsqXIhy8PGP1NOm9085PrqJyzxHdC?=
 =?us-ascii?Q?09xxzRku5uIUciK0pQMiHRUq5V1UzSqVXAybYbMFlS5phhxNTsC94Sj80PPf?=
 =?us-ascii?Q?tCojp+g9tQCzTgDotRvoYby/+9+sgV4mqHcnBeL1Mn3P0OLZlKvPTPiEodnz?=
 =?us-ascii?Q?33dDMdSv8JEyVOEkQHes2PqPQRycLRZyzbvaz2ZiARxj1TfKMcUMkMg9IlCZ?=
 =?us-ascii?Q?gTzBVa8LDUp/i97OFe0Njwt9l0nn6CqVOAuapL90+1fQKl7VLOTtyxslYHyV?=
 =?us-ascii?Q?g/ou19UrlO+njPUPmdxWSWwwsmm5EJQBRADktVtsuP+44FQkty/LbiKY8NQl?=
 =?us-ascii?Q?xQRP6NwMu4/0nbfijJ4/B0PtakXeBE5YyEc6rxE9ZzSv96fxoO23jU0F5dA2?=
 =?us-ascii?Q?siif40esstuhP42+TzFtchpjsB2vrE0bqMew5eb8EQwwn6p6BOOJlw/tbp0i?=
 =?us-ascii?Q?VHEwlqzRqtIoiBFDY3ySM+Qg4OJR67IXbkRVqAyUU37O2X+llH+0m8+7KFJK?=
 =?us-ascii?Q?E/uVpONR58z6F0cqButqInF4dzsWnbtDGpiEB8V+JpHYiO3IGAG1gMHvIoEQ?=
 =?us-ascii?Q?UCg6ujsIXhC4TF2rWyhCkLuCPQrj2oAbqTIbw3/WcAXIyYNJcNAhCm5pSa1+?=
 =?us-ascii?Q?y92KmvWEA+yBajH49vpC4TFQp1n0YBCwLmLoOVLYaaPd/J6fxwsbICEvlTpY?=
 =?us-ascii?Q?NaIfCq1DBjP4FYQ63vSiPGHeakrcKMyRLNepXjKvEg9mC8FwdEo2DhsnfkZ6?=
 =?us-ascii?Q?ibVRUifIV9Rr71HDi8nYp3SVpqiGUD5uMe1gNsWIRvEzv+DmRTuFjbs43NP0?=
 =?us-ascii?Q?kl+PA4ojZpqEugA0nSDIqAtIWfNGvnfznGUjE4PfXOmOGModjilGYYREOgCF?=
 =?us-ascii?Q?3OiosM8qAuMwKNQX409Cy8h1+vErRHk//q1IADb7gV35BtVa4JAhCH00T6r3?=
 =?us-ascii?Q?7rW56YwzhFtRRGlhmW3d8bLawewleMzOgKl9tsg1y0d6KnhRzQvU9GOWOxWT?=
 =?us-ascii?Q?QbbmDntiSRGpN2dmmpvWRFU9QLSzOXzZJWmQ5R09oz9Lb9hqsltRLFuk9ypE?=
 =?us-ascii?Q?u19XWIK3nH+fuZtpZQJjMUyfF3Vaf3GgHvfAfZFGo+ZCEp47+rLcsePkLv+z?=
 =?us-ascii?Q?DOtU55Re9xAa2lGvPev/0kXXs1CVH0P2dUOL275NHtsEvesAT9msAh/JHbxz?=
 =?us-ascii?Q?fBJyX72SlyTYvXmGmfPQZXUssXZk3Tq1Kf+lESuuoh9DRgr+hQERDKIFsdm2?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c3f5b8-fb17-468e-24ba-08db9d4e7e48
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 05:14:25.6634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +q97ktLyhhvxijJaikqVBRvYkyGR3capsd8iiFmmp/AxBnqQbyDP5D5lVfFGYciinCKoLyGJFOd4WHYUpXoBbbbMmR9s1z0o9otrCT/MbOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7517
X-Proofpoint-GUID: z7Jkwf6FGLDHRCBTgNAYvJQ2c8zaFR1s
X-Proofpoint-ORIG-GUID: z7Jkwf6FGLDHRCBTgNAYvJQ2c8zaFR1s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_04,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=741 spamscore=0 clxscore=1015 impostorscore=0
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

kmemleak_initialized is set in kmemleak_late_init()
instead of kmemleak_init(), which may cause confusion,
so rename kmemleak_initialized to kmemleak_late_initialized.

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 mm/kmemleak.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 04bb4cdbb402..5c8e5a24b890 100644
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
@@ -2053,7 +2053,7 @@ static void kmemleak_disable(void)
 	kmemleak_enabled = 0;
 
 	/* check whether it is too early for a kernel thread */
-	if (kmemleak_initialized)
+	if (kmemleak_late_initialized)
 		schedule_work(&cleanup_work);
 	else
 		kmemleak_free_enabled = 0;
@@ -2118,7 +2118,7 @@ void __init kmemleak_init(void)
  */
 static int __init kmemleak_late_init(void)
 {
-	kmemleak_initialized = 1;
+	kmemleak_late_initialized = 1;
 
 	debugfs_create_file("kmemleak", 0644, NULL, NULL, &kmemleak_fops);
 
@@ -2126,7 +2126,7 @@ static int __init kmemleak_late_init(void)
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

