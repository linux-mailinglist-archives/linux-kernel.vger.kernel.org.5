Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972917771DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjHJHrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjHJHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:47:53 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70D3211C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:47:51 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37A6pGa7011895;
        Thu, 10 Aug 2023 07:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=1AKwDMEuXmBcYBNJs59QytxQu62GZx7vOP8eohKBmGc=; b=
        ffV9KOlwjVgj2z3VEReeLMFXft/UuWLA1I/d5ijLQjxN+qVtHW8S2wScqu4c7AT5
        IWwG67dPeuhkncmhBKB5EwwDpYzZMA+7dtkx6f92HlS1X5epxmSgoBI5Dq3K+87Q
        65zG9ZpUSt+q1RgJing+RxpJK/V8y69fJNawzXwqPqkcXh8SchGBFcroPYaURV+S
        CkfTl3J3GY42awUeYarbDNvvHt/SqYT10nk8JxpYrfd9duLD2xKS5Ep+nxE5w/IW
        5+D7K2kUSMZsd0J5eyn/MKCB0wozdHHHi1Xjb8pgZ1pqP2bW/3Ah14vFBXneRJUm
        LUysNxyTIMpq0zUfbKIUsA==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3schfmgf4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 07:47:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnJtUhncQcgHNeEXd0YsDgL0k7SA6LfHEPkii/K4RDF2G0x9/q5PIBk+0nuJH/v5GXrmDhGsqlOguOiS0b7yQk30B3UkqGVrS1PwENu6c88uEnxVuWfT9BeaAZM4dIQ7FJOStky/3ccMtTvjfho3EwfJuMM2N/OFBklIrl7ZvunjBPWvZIeUvlKnJzOqgVYgbUKBwZCnC4v4JY1eU7Gdvc1MWmzXXCOsUmn08HbKeN/VEP9xgqTO8G6aZvgKJWY+/Rza3K3o1XmRFl2IttNpHrkJX/g+js3hCVcDrXkvI/m0AM5JJwK1+dyCdcp3nw5THocZa6sERleZf0bGtjR7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AKwDMEuXmBcYBNJs59QytxQu62GZx7vOP8eohKBmGc=;
 b=nUyqEj0jY7EEY3NwiP79wXvfWBrJwcCm6ifOA1S4I18XptD9xBLPYyYsN8qr766dL2wGgOO4QH+23bQgO07vE70QngWNuQl3NlBtByQ5NvTkH+EmocFOYPEr7S6773uuouYnWv6J7uOJIOPkl99cxMWbw++YKX+b3kw5VQoCTpKjDBIVc8xq7I1XCTv6C4ACBsZ/emwW0EJhjDoZSpzly3tSvQv1MOjTUXl/AotVDCuDyn5MONHObnsaLzpVoTv8FMAGiEBElsS51DQU0SJFR3g08jzmQjhxUYt3qLnVu6VSCR5gwJkCqRY+bk2JS3Ttg2/8pUuJWFM6tjrpmWfNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8)
 by PH7PR11MB7497.namprd11.prod.outlook.com (2603:10b6:510:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 07:47:29 +0000
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::1b5d:f77d:a3c1:ce4c]) by SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::1b5d:f77d:a3c1:ce4c%4]) with mapi id 15.20.6652.026; Thu, 10 Aug 2023
 07:47:29 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        glider@google.com, andreyknvl@gmail.com, vbabka@suse.cz,
        zhaoyang.huang@unisoc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/kmemleak: No need to check kmemleak_initialized in set_track_prepare()
Date:   Thu, 10 Aug 2023 15:47:04 +0800
Message-Id: <20230810074704.2042664-3-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810074704.2042664-1-xiaolei.wang@windriver.com>
References: <20230810074704.2042664-1-xiaolei.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To SJ0PR11MB5769.namprd11.prod.outlook.com
 (2603:10b6:a03:420::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5769:EE_|PH7PR11MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f03e3fe-dcfb-45f0-ca62-08db99760bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6UH5Ho/H5vbMwneRR/W/ovImbywRmfvn4PFNAhZP/DPR6q+QBKWPaZqZGfZuRm0hLzG3AFGKm95ySSH8hv6LuOsTWXZql4ub4vzZZ35aCtivvSdLMvj7v6XETkjj2W30N1zb0nq4N/Qfm8OPVxg960/+RSKVbGpl19zpV9vT5kmPmntuehbol2AXYVIBfEug7wC/Gfe48Sw+h/aZec1by6eru4AvIR0TdnkSR3uYn6GYBywaRSt374OmgbsgWCNt9dRe1YrlFNABhXKdTC5st/0/D9KWes6aYnv6PXfKu2KfUdGXND/3M2SS7ZOFVtm+w3xdmwHMsKY7rHRlQh9DGh/C6ErW2FebHkJqEA32oyoH0wvLXYXVCeDS3vUW7UdU743HEug0/Btxot5VGCH7JCziwlRAtP5jU774A+zNuiWs15nShFq5yFP7ygiB7l5FMRLB127+nmhVpU0NV8UtiAaD4zCqV8Fun0W7TG3G7zdk1Lu//k84ZNO3dfaYxgFHdY7VUYAPBrXmRkcnU1uJgePtC44SiGW7Ave/3Qn24gstC3NtGP+Q9YmeSKqw4WGLro+Wbkzr14hozUW0f92IdzeCI3KX+302V+wLl68yTKHPuZnLe6oHm/jBlZph4xq10rda40+ILonTe98E6bVDQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39850400004)(186006)(1800799006)(451199021)(2616005)(316002)(86362001)(478600001)(6666004)(6506007)(26005)(1076003)(36756003)(5660300002)(8936002)(8676002)(44832011)(6486002)(41300700001)(6512007)(52116002)(4326008)(2906002)(38350700002)(38100700002)(83380400001)(66476007)(66556008)(66946007)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?clKAeswkRpOgZG09A2/0hYWRDPzptEa9kK279DXCfG8ftj1aIkKGwCbHTJpA?=
 =?us-ascii?Q?Rc9zDI3K0wuI+t9sMerAb7ZY9dOhXtQfStBpnNMibkYseR3kxTHgfDJasZqc?=
 =?us-ascii?Q?+AAy0VM7yzOZFosLZeZMlOz0VSUFkubtWW/CuIqvask2bj+Y1V3ITAUqLm82?=
 =?us-ascii?Q?v4Eomxet5l0FpW0hXbIje5BWqFU6DflgKXrSnuucZ0fNkSlsyeNmbcq4nXUA?=
 =?us-ascii?Q?SfXXGveJEN3DFTbJ2VIr2+caXexIo84tHrS+2SbbOuxkIRvRLktSI0iOYnak?=
 =?us-ascii?Q?ZBUWhSV9KYrfx/izrrL97K6jYzhRL6RugzcTxZpyS22IF3jof8cNRbR71Kez?=
 =?us-ascii?Q?+Y4BJNT068IRhlFKhzhgeKihpA8d2YHb4wiv6rHvKQwW2YNd+s1YJSIbxzQO?=
 =?us-ascii?Q?Rs41vYQg4DS71E/aWJ74eppQY8e73B7TAtkU9Obr5eDkrpirhddp+M2izYTq?=
 =?us-ascii?Q?WTbyrgb74b4JFfDMUfn7TxPh7kUewo9NdDeZIJvX7XT3CsLxVZ6nGMF+NTET?=
 =?us-ascii?Q?rsRW9ZnXgVvaB0DLf6AwZSkv3mzV9f+YAZmFlSYWNATWSOrPTOx1KV/ihCsm?=
 =?us-ascii?Q?VV3PzY3yCCoQ85MYQSQ/dtwJnSh3G/YsDJDW321q0btHP6KgWB+X/3vEtpxa?=
 =?us-ascii?Q?VBvPeduMT4Xze0Ju7USvIGI+d94y7cvLGeELhcMs05cr6Go+ZIU04JINv+8i?=
 =?us-ascii?Q?0cc8EOOHPuC/hCJPrdZD5i90i+RT+wmsHcC5RjL3qNZ4wU2t50N33uRfwdfP?=
 =?us-ascii?Q?gBgjHBXkf3mc9wuIt/CSRbOUWCwCkZ+faIBD0kZobpK1AbTlRrDgbAV+2spN?=
 =?us-ascii?Q?KlvjKRwxb8AlXPSN7H1RzBh+GMwtlxHPspK5BtY6+VFsytiDamM1UO5Jby5W?=
 =?us-ascii?Q?5NkxHUUnVcRoF98QALFptXHIVtBAsh1bWWKMKi+a27EPFegrpSSmE4/OStJR?=
 =?us-ascii?Q?M4iB+MMwFLb1qCmULsG6wYF2KBxPUzQ6Y4g1pf9ZOjoKR61sPmSw9NY8VRtV?=
 =?us-ascii?Q?lZv9HFRWYcH7apcIzBjwGZebzCzYBJLf9xLBEWns0vqM86KJ7I5h3oqb2rgf?=
 =?us-ascii?Q?l3gI3+wjma3fYfrr3PcpfwNczRiawbDnTFf2w8XGVLUr2VwmvWGgjO78HqmG?=
 =?us-ascii?Q?t5DfqjLyNreKN7j0Uo78xf6uy8/2c0PSXO7objYIFBNFSRVhHzIB4acLKyHZ?=
 =?us-ascii?Q?DeRRGxsU/E2aHIpHR+Su9nVRXEnDU9zvcPZH3gMp5FBO5J2B0cs9G2MCSeBF?=
 =?us-ascii?Q?YvYJ4UeulLOFtD8DGpyVmB+1lX71itq6QOqp+iUmyneTL8Sc8KtEH/pTp0on?=
 =?us-ascii?Q?Phlmhq+GIHNlwyjkbmI/L7Qinseb8VrK5xwyEsaJZvaRxJ+uS6mJGu8eTxDz?=
 =?us-ascii?Q?awUuwAc3vRiK9P086MDIKVrvi7wkXXvHRNxLHSGYIuPmxzvLirOMu/hESCK8?=
 =?us-ascii?Q?B0zQOfe93EkXFM51TbtJHHAbHxdb87na+EHtttBj9QQiof/QWVUrEy/prTW9?=
 =?us-ascii?Q?piNrsecs92GfD5KfB5EUv4oZJYuSgBtmMMrF6UlKP8AL6HAOBqnoCiLoykw5?=
 =?us-ascii?Q?PR/+YznRyqszYY9pbTxObnrpH1Bs3M5Edvyj9cIf/UlXOIHTAKS4Kv6kd3Rj?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f03e3fe-dcfb-45f0-ca62-08db99760bd8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 07:47:28.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6+3MACJ+vZiYVgDlY20LeF2bT7YK7hRRtcsXHjWPNXGBqT/ZHELxSJbboyCayMiVoeMaICrKEJ9HAWsGguiAeeUlUswhT63bPq+z5AEVy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7497
X-Proofpoint-GUID: Yc2pXsIeBXjHWopBqFppm6UGCUQoORty
X-Proofpoint-ORIG-GUID: Yc2pXsIeBXjHWopBqFppm6UGCUQoORty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_07,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=674 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2306200000 definitions=main-2308100064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kmemleak_late_init() is defined as a late_initcall. The current
implementation of set_track_prepare() depends on the kmemleak init.
That also means there is no call trace for the memory leak which object
is created before the kmemleak_late_init().



In a previous patch, we have fixed a bug in stack_depot_save() so that
it can be invoked even before stack depot is initialized. So there is
no reason to check the kmemleak_initialized in set_track_prepare().
So delete the kmemleak_initialized judgment in set_track_prepare()

unreferenced object 0xc674ca80 (size 64):
  comm "swapper/0", pid 1, jiffies 4294938337 (age 204.880s)
  hex dump (first 32 bytes):
    80 55 75 c6 80 54 75 c6 00 55 75 c6 80 52 75 c6 .Uu..Tu..Uu..Ru.
    00 53 75 c6 00 00 00 00 00 00 00 00 00 00 00 00 .Su..........

Fixes: 56a61617dd22 ("mm: use stack_depot for recording kmemleak's backtrace")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 mm/kmemleak.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index a2d34226e3c8..c9f2f816db19 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -610,8 +610,6 @@ static noinline depot_stack_handle_t set_track_prepare(void)
 	unsigned long entries[MAX_TRACE];
 	unsigned int nr_entries;
 
-	if (!kmemleak_initialized)
-		return 0;
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
 	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
 
-- 
2.25.1

