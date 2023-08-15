Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A58477CE57
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbjHOOms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbjHOOm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:42:29 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD920A8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:42:28 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37FBeuw9010670;
        Tue, 15 Aug 2023 07:41:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=iZa8NZp8fVTId3EZCA
        GIu20Fpr/+oAepwHptHYUY+gg=; b=O4+/oxjd9MKJ7cNyDbLUWCOTi7bkVHS6dO
        Ay3uJZ48yOY0b9AhBzU8LiO3KSluy9ahN6gri2VZNSzRt0LxBXE10lDM/j9P0vq6
        vDqldxuL2pePxV6j2FrWr8i5ctUDbHuXwBjexZV0l7gvZ1xoJSC0se4Nn0YynuQw
        Jyr9be5VrGZfJxUWHX22IUfnEip0+xuC19oDQXkViCdUDETQSM4WLOayCo62dsdY
        duQr6gM2OPiSSekWV2COB7tmK18Om3YQ55G/mV3QjWwB/hXBr/kmFGW0Os1C/mmS
        /MnvBIyWvg1YtSRpb0dbsv9x/SHmCrmS9rnfiIdmjNIOAJtc/qjg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sg0rrgf7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 07:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkpSuxJJfrfn6T9776GIj2aN54GTfLAb7rgTmv36lrNkEOcxlqr3pln7C+pSZP6w84esL8mbFI2rOaPBt4hjJ08VXlj7lmYxSScXqYpeJT3Xxj78qmvq7KdM/gftt6o9u8ej7hpbz5L+pXFOxJPuzfjmed3sgozh1m6/tw7RMv7o2oA8aVCLSAju3SEhP325Gfw9ikBEXrbGGixUWBOq1TafP5H4wAcGUORTAC9okG95b0XbISldkUKDZyE61n7jpH52j9JGJJ21DEQbAIdAKusaxwDBaa+EM+3AhHYcdrAcS+cVOelStevQo/Y7SwEvCdg2+5Y+G4FgCe6i+J64lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZa8NZp8fVTId3EZCAGIu20Fpr/+oAepwHptHYUY+gg=;
 b=F8QKYRCX11U/ECjZFoW4QGpa70RFpxJDYUDFmWifY4MFcMfOSXlufjGt7L+0Vyn4YNaKhhfgY+t1s4JgSxNwEc9mgaq1V4eRBP3jHNAkaU2msWQa5EikEu0dluIolspS7pY2Hz+91qS7tAYF1CqTvEDci6JEP/pngkgrdxb2n14y3Dn2k8CTRPqb0Oz05XeR/mJ1FgLkhrMFZoat34ImyUolX2yMqIrcTIoRA8dIwkdBMH0h3V+KXYxSdB8wLW9nJvUt8c+Tt3YIDxVxqrdNvf/nepjCjFNO7N71eV8LI/e30I4nrMwenzkhHOo28U3/ENlDOHNYNu1zTUTHEfuSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 14:41:50 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 14:41:50 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
        glider@google.com, andreyknvl@gmail.com, zhaoyang.huang@unisoc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] mm/kmemleak: use object_cache instead of kmemleak_initialized
Date:   Tue, 15 Aug 2023 22:41:26 +0800
Message-Id: <20230815144128.3623103-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|MW4PR11MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 717c50d1-1693-4fff-38c7-08db9d9dc2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FpT86TNQJ/ywl2AJ2hBiZbx/24cPNfqpX/0JPilWDUqyRSNvakFoQ/MqGwofXkN2IS6ZhtGfrEqmXMG9IBpq1C4YGD/3ZpgR6qCyxij1vpZZLF+tLgQ9KxChepli9z2X5UxQwA1ZtgSXrIxdVL3TpVnH7fo7vqOu/anl5PP5EAJ2xWA0wZY666CM4OCUmKBKWIz9CM9SQHa7I5M8F7beqBquqpcRf6p7tB+ZRFcTRm3SfE5vHtXn16CstZ22e9hDPdX3JQ09EHdIngdA3ILsYNUTE4O02S00yAl6nvP85eVUYWb7dqrlsugqVGYIdc/kB8mzS1cO10u91wEeIYUIG1PWl/mIA0/53pEpxlyduVDnoOhAafc7LBVCAXZyLQIPgD7W2W+pcdj+kj7qkEXkXdO+L0mnW47Gdw4Ctfb8R1Yi7XG01ljkve5sFCVJqt+B3/HoHzUUG20SeqkJNYTDnOIQY4aBn3BaFql8xuMEy4Q6m9Y6eS47Ot/fXJQBiDz1Hi1mU0YgGZ9NKLucj9/COu86ikGGrbFa6bIxdxvoaiKLWKzljcj4CKXR12Uv4yMIeRG4eZ1+xUZ5EYoygsCG1Yv+k6dWyRMzReBJj8P8nY2d/fBDPNwQki6bKjsx+2aaQB47GpKkdIsURsgcRyGr7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(8936002)(4326008)(36756003)(1076003)(26005)(6486002)(2616005)(52116002)(86362001)(5660300002)(83380400001)(44832011)(316002)(6512007)(38100700002)(66946007)(66476007)(6506007)(66556008)(6666004)(2906002)(38350700002)(478600001)(41300700001)(8676002)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Cf2i/CjqpLd30smJTNEj/eH6SDPAM8weszHNmJHIZ+LJYC18fLEMbkrGhP6?=
 =?us-ascii?Q?lX7v+UVkyBF+VRrjMwmEBV74P7aRFtZ3na+3cvizTgkMkB7kS4qDBSwKvXzY?=
 =?us-ascii?Q?SKyL7dUomjYu0CPvXY+mesIvnpVXINAiPtw+r0INwBQj/AUw5geR0cvko8Yi?=
 =?us-ascii?Q?ZcLVD63W+ifnuhjWDmz718anCiHypX/mbw7X70JuJqbalAoCygWiOshzqUFo?=
 =?us-ascii?Q?nClBqj1Q5Y2LKLrgY13bOiZSykwVOLIa0Eno/nxl9yujRE2B5gdUl+zBHyXI?=
 =?us-ascii?Q?IrT23pBM3xYJezzWMZX6trIADKy6mn4hv3hj2Mzr69dssCt1KE3tFmlILNma?=
 =?us-ascii?Q?noEoYpOQr2UfV01z8UToQgEAQSJOO7/mf3Kd+drPvQawGaFyMMChbB3iR0CN?=
 =?us-ascii?Q?eneBhbcHhtJ4VYzafGCmPNUD7K0dlg6wLthAxm39mKzk5O4O8ZPLg9ww/bFp?=
 =?us-ascii?Q?E5hrY7lbRe9/8LhBIsyiLkb8Ac5WkH42bohl9gv0OstWXjDbx/mJjVZ/LVL+?=
 =?us-ascii?Q?S33a8M9SF8ziw6fvcVMTAugk1387eCX99IRswzDrL0g4vlVGSJggPLaUFX9U?=
 =?us-ascii?Q?5EbhcsLR0s0aY69BvMfHH4hU2KxY3K1wsFc/oH16MHn6IUGuX76WubMxkyHQ?=
 =?us-ascii?Q?Qeu3tZ2imLic0B1CNJR9umW/K6S8IIY557yfdx7bjNVH0OeKOQaBMZybdtkT?=
 =?us-ascii?Q?teRVNn2/uunr3yBBeuVSiaTJimErSX8mj+4vfW3iQ1DvgTS14drnRmJn2ftm?=
 =?us-ascii?Q?IvuyyBhdHtdNQisB8tke1uiJmTruKWpsgX+dDV8Wpwq8JlAQWeUPme5qSYL9?=
 =?us-ascii?Q?x6GeYXu+RLRYM+k/9hC8xeXRSR5UGznbOKNAc4iSr2jTppt1ZUnyOgXRrsK8?=
 =?us-ascii?Q?lbxUr7rWxF3EMH98E28BL6gnPXQDJz2Of666hAWg8u1zHiFOs4xO6KrcZGMk?=
 =?us-ascii?Q?1UAh8wOffRE+65tp374RMYuPh0tfnaWBHTYtjasE7mQP0Tis/8mt6JUo0k9c?=
 =?us-ascii?Q?YWypC7msegHccvYT9KnMIuzOHx1Wx4TS8G063nL8COKm/gOaATjXX+3NrIX3?=
 =?us-ascii?Q?8kQLkqW4xlFrIEnE6inXOdTPfhk2JtXDwZE8TO7IrAcQFsnULuStyPHzHKzd?=
 =?us-ascii?Q?mh44rtjzROLuu3yVDPmplzVJrA/xNqnxTkWFlWYWFRsAAeWGHy7aMb9edEGp?=
 =?us-ascii?Q?rnsayH1EYmK0KnRsm6PrFRbbegHJ7FGrV4q+4vQsnX4nxGIq3VhHG5BftsgJ?=
 =?us-ascii?Q?5ScVbC6N+lPkdEPBfJJCzjWBr1pBmK5/uK2hDVuDHttmWVwsVzpPxCKAYO60?=
 =?us-ascii?Q?QqgHJOg8Dnws93d2TYaCrABgX0FU5afOhhiT2wrEIGQxdYTiyWQ215QSbjmR?=
 =?us-ascii?Q?WDTrBGJUq+cK0r69vaDkCPs/6LJkGgoKr8fyk12urVsFsymP9CY45/X9yRoT?=
 =?us-ascii?Q?tjB7A8EH6KiqvZpuJI/yIolctEmMHx65uUG5QAmho8tjHBdbez26RA0jtuxh?=
 =?us-ascii?Q?Yl0V2WrEFvhzjrgyRUSRGkeLBm+cg5GEpkN2e89Hu36Uz+9IJIWl+11vccEY?=
 =?us-ascii?Q?vhSHPIWRfCtuLcXYcUdpk1sRAoifWsN8jGtQDyLEcHc8EmyXnXEFXJ0g0oJ2?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717c50d1-1693-4fff-38c7-08db9d9dc2ad
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 14:41:50.6692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkNQqPT0FyhJVlNWh258Zp5f5X5yzp0ccKMve5Lyf1fWbNZ4FAVDq1HdOwdi1es5hmdMqnx2hijb58OvXPEEtaLipPNMKBtu5bilxINd1zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5936
X-Proofpoint-ORIG-GUID: E4MNeyXEDI2E4gbYlqBlp6WYd5Hx4t9A
X-Proofpoint-GUID: E4MNeyXEDI2E4gbYlqBlp6WYd5Hx4t9A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxlogscore=944 classifier=spam adjust=0 reason=mlx scancount=1
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

use object_cache instead of kmemleak_initialized to check in
set_track_prepare(), so that memory leaks after kmemleak_init()
can be recorded and Rename kmemleak_initialized to
kmemleak_late_initialized

unreferenced object 0xc674ca80 (size 64):
 comm "swapper/0", pid 1, jiffies 4294938337 (age 204.880s)
 hex dump (first 32 bytes):
  80 55 75 c6 80 54 75 c6 00 55 75 c6 80 52 75 c6 .Uu..Tu..Uu..Ru.
  00 53 75 c6 00 00 00 00 00 00 00 00 00 00 00 00 .Su..........

Change in V3:
The comment in set_track_prepare() in patch1 is updated to

  	/*
	 * Use object_cache to determine whether kmemleak_init() has
	 * been invoked.stack_depot_early_init() is called before
	 * kmemleak_init() in mm_core_init().
	 */

Updated the commit log in patch2, Rename kmemleak_initialized to
kmemleak_late_initialized indicates that kmemleak_late_init() is complete

Change in V2:
Delete patch1 in v1 version, change patch2, use object_cache instead of
kmemleak_initialized to check in set_track_prepare(), so that memory leak
after kmemleak_init() can be recorded, and rename kmemleak_initialized to
kmemleak_late_initialized

Xiaolei Wang (2):
  mm/kmemleak: use object_cache instead of kmemleak_initialized to check
    in set_track_prepare()
  Rename kmemleak_initialized to kmemleak_late_initialized

 mm/kmemleak.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.25.1

