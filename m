Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B4A77C6FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 07:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjHOFR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 01:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbjHOFO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:14:57 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25E919B4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:14:55 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37F52MFI001655;
        Tue, 15 Aug 2023 05:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=j/dflmHMz3AXlHGYxe
        /h20Yts8hoaPr7UVl/hPf7LGQ=; b=EmAhch1lOpQVGagkxKK64bo5bhvwhwj3p8
        9mtg68WHAx81Nl3koTioxrLyrwjm2iU0C8fdzW156bxIQlIDuubARBAbd0+WIu6r
        p/7z4D5rQfPW0gn7s62NQps4It7jfL3dDnMPWatrbY4Jdbks53QYGELVs2NBvo0Z
        eIPSWL1grP4b/lFZW+9zLB1KFWmZ2evOi5TkRcB3tXsduuCYtXdW7yvPWyWqcfxm
        f6muj1tiBLhZaBEYs7E32FS/ct4m26FKJLfgEM0F2NNr+yJbky2jIJg6KuoYU3iC
        hDsWSV9RvWVf0h3xKXvom2Z79u7O7YQLMtNqx+j/xRpncAlgehOg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3se125tg55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 05:14:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kftJdLVrIJpmNOhecTxe/RaIVPc3lkBHMv9rSKRzQIA6vmTAuj35/0dWww3C4qTZ/kGy4RcrGPlFtk0kt+HBp4gJBODw8yr3a+qDSVUPQGGo48f2g0tY6KHUzwqVyRbaxx3TkQflStBHQ3+I/3zsEt1rsflg7Ey/0mwkw2GfLtSDwmeTzCUK2mpXOl0m9ezjB8JqzEkSVwGxEZ0ggqkaUibsBBC2Xa+Z8b8pke03jIL4Z7dEAy4wY/nLyM4vfmeBMgMFwyXTV/qJLNpirtYk/EAQOeaEv1aOklWYXi2+EG9MI+NFJ/C6EHcH851Cl5AeJDJVjpKXt+/cRJ9eJ2akqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/dflmHMz3AXlHGYxe/h20Yts8hoaPr7UVl/hPf7LGQ=;
 b=al+fLa9nfNfmH3yo7ZlN3tCZ0oSC5Wzsuo/yMVdBljVN0v2M9zJmz7OEkzwLtpT6W9alWEEWfZfNbpaRgYpV4oO6KKqoXZtHt02CwRMefnj/2ISmyYIWwTCpYW+o9wcVLdXXQANtKpFRBFZ+SbqR2c7TKsV+t3xn7Bg6poWqvdQQSpqNKZEJMvni4WdQf6ai+Bi6CE6A+JxGa1xiR0grMS+LXcy83JFOR/irQJ/bi+zcIa6FSVWBGcqi66KAi8Ke8+uDUwQwaL/hvFT8EtBckxiyzbt/M55NflHlVjXQ/KffGvNRdCME34Iad0xS7A/k2PZQB76X5G5z16YvpNeVEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by LV3PR11MB8767.namprd11.prod.outlook.com (2603:10b6:408:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 05:14:20 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 05:14:19 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
        glider@google.com, andreyknvl@gmail.com, zhaoyang.huang@unisoc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm/kmemleak: use object_cache instead of kmemleak_initialized
Date:   Tue, 15 Aug 2023 13:13:56 +0800
Message-Id: <20230815051358.802035-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|LV3PR11MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d5546d-3dc4-46dd-b61c-08db9d4e7aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6N7xmxuy5PC+HD40v8rKqe0obTQsUtzI0sm0bLoimdS7J1VGpFr+6XKztUJXedXx808EweMg/uKgKmWUE+engknZNC0rgBznWZff33mwW5p+JaL87uJbBpudT3V+/FAP9y0s7aBXa6JhvBzayg6LxGr6Gj4+OK2i0IljVXTXQSx6g6XpgXNhKgN9wEhn5D46QT3gIj69CBKN4mpKSYG0A/kVsuIP+KA6s0HLDhTKgZDkVPhQqMWCKw7tKlG4+ZaETXD2rl9HgKnSXjnTuBV5bQkGMd7qPAvPBQ3ZlFOd0QvspwAWPlFKKCGYpvzBvUudV6npMeLqBdgm/WIi0vDEi3vG94R4mmlI1uykRgC3ITiYhFz3ZnEsp8luVeTH3FAIHSk6p5O0qf/1m0LStTj+tOjwthGxKvHAMoILpj1RW3AopXHvOhOu/0UzSsGfKPYEZrPUKkR9ks8pU3ahbPvy5CVditJcLJGt93RuDM8rVLe3ps8fuGStCuW8YGJ1lapLC7HSOBgW562u5yqpnm4HQ7Y3iTJe/LKfF3HWyjvsrBPjzVpwP1NNFws24800f0kAVYUsNLbGXFx3WTtAsLmHfFPlUedWVxsnJR2p9CAkWMP0gzeOOIt83ylrkBEoW1NJs0sOHdzk+7b7j4e9vkiOIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(136003)(39850400004)(1800799006)(186006)(451199021)(83380400001)(36756003)(1076003)(26005)(6506007)(478600001)(6666004)(52116002)(6486002)(2616005)(6512007)(86362001)(38100700002)(38350700002)(5660300002)(66556008)(66476007)(316002)(4326008)(41300700001)(66946007)(2906002)(4744005)(8936002)(44832011)(8676002)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?etvNP47bNQrlo/f9nSLL89aDGmopoC/2u+T48r6yD3cICm1sY0ZbpKoSv0LO?=
 =?us-ascii?Q?xuTzWCqeZjlhFyNE2LR4JyBotImFHulwcv3JNwgbxbHAE5aZdah7fl6Pp0V2?=
 =?us-ascii?Q?YPEYG5Uqo9oyNJSZTu/R4z7z6tB6aERR26jJE9pgs2Ukyr7Jy7IVG2CZ4afF?=
 =?us-ascii?Q?NGtmx8hbpbQ2ysbipZMesfXGjJA0NUUnB1/u2/dAlD8QEjElQcUoac9YEJ35?=
 =?us-ascii?Q?sAs63UATvl/Ve6UiIIjqm6uuT9nSeajtnPWdVhAyFAoxrDLPdpGzGwUog3Zp?=
 =?us-ascii?Q?nTurq+hsiQgOweq4ygtfvD6pVSK2nW3M5lOjSMJr+FoRJdHHRqBoOfOqxr57?=
 =?us-ascii?Q?//Z1ZnAlmhN5EBqlHrXlNpzW6HT1IcEpJjfAo5aiWyOnSShXJlzrYBo4U1Ph?=
 =?us-ascii?Q?6+pzUospmoHR7BSLPTeY+cY4J1Gc5gL2rjmloVcZkwJduxWqy3sV10gaqhr8?=
 =?us-ascii?Q?svIgWWEowAhWlNsWjHsRjT8gij26j2zv6+XdT9F4s6fw6qOuJS7IT9i77Eew?=
 =?us-ascii?Q?loCoY788LvJIdOQ9A++ea4UkXj16zstfJ1Wjv06HTnrEVySqaFvPNV/zGdqg?=
 =?us-ascii?Q?D4oI6YQeZcWxV/rwaqkvbqudTl+n1aUmyya0glubw2q4+3BSEaHKPb5fd+FU?=
 =?us-ascii?Q?3I4jb03ccOFDPce8231Q9/Ge8vJW9c0XnEQWhR4DWgv0R4Rqs+4lG82QZjWB?=
 =?us-ascii?Q?VolyNuZZsfiAbb8qrmYC67jOaKEW7C/rz/Qw5hkXW/IiAlStZ3dK52cpXSAR?=
 =?us-ascii?Q?pI/DdYRJIbZbgD7rAWVzZP18Oyw1dmF1060TXhtlW1XdHrdtzcBo23m2bdsy?=
 =?us-ascii?Q?q21Kzh0ha5aHuiWwMWAUAJd28nap+Ebn/hS4M4/YoJJs3G8KjFfw/F2Jn/LC?=
 =?us-ascii?Q?Y62YuG40+X7z0IL9JqIgBBYN1dN8VZ76OWdpOv0QVReo+vber1PhXO9ojOrN?=
 =?us-ascii?Q?xCxKSptS70vCd3R6cpACnZ9pOjWTrnNbEqbZ+iIUtDUeoZ5bpWjkiYqVoF6n?=
 =?us-ascii?Q?dHwxDCafr7UiISkBHbpu/RYAcLUw8PXxwmuOv7dDT+wAYSGYdhrDRTw+hnsg?=
 =?us-ascii?Q?D4mufHVP1KYNnUIcrba2qbUHV14twjyWy/o+cIMh+R2sFe9M2qMVCMBtnePk?=
 =?us-ascii?Q?Q/fU+uxElKE7vAiF5DOd5p9aOkxeisVbyHfEUwS2xViOpeJ8wVDlzsd5eoUw?=
 =?us-ascii?Q?2/XZax8U53IUrtCovV8Lc5r2/902h1ZU4rTh3SdftnDRssP+BXhrXqnCNQgy?=
 =?us-ascii?Q?FaSkvV2i7BgJup0Ir8gePWc50fyZn97NCaEl7bNSFfb46eAmSFQeCn1jSaG1?=
 =?us-ascii?Q?fkVqFbhhRFyIvBEVHz8j8/zAqo/z7VTVjWplofnpl9Lj6ZL9tvG7j/e5G40r?=
 =?us-ascii?Q?M4RvfYviPIuWkuJqBSFNFtaHavv9Y5CdxLBOJdVZYKKaeH4jDveuxWwhfzi9?=
 =?us-ascii?Q?aKExGuXI25kh9ioRt/S21cHQ6EYcTGVQOw+GXdoU5wnm7jD0p6fheiBWI6Gl?=
 =?us-ascii?Q?R5KuFTU4It/Higj+nciS9MOzCjg+dhtGCWvExn/JiuHYey2IYv1COfnJUYT9?=
 =?us-ascii?Q?FChvHNY8GejgYOouj6CwpQH9g8QETJjPtbWe88p+mKSd+sLVXVjMFNcSg+4b?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d5546d-3dc4-46dd-b61c-08db9d4e7aa1
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 05:14:19.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTrfFJ8xhEdZrY2kK5VyAOGuk39NX+SffBuudGOrd33o/LapWI+XhlKEXsBkBFIyUc+djxLWQQlMdHP/uv3D92OWgczBmbzA7OoT0gJZc38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8767
X-Proofpoint-GUID: hfTA2yXe4rgvYVoRsWcURKMS7_C184C_
X-Proofpoint-ORIG-GUID: hfTA2yXe4rgvYVoRsWcURKMS7_C184C_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_04,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=706 spamscore=0 clxscore=1015 impostorscore=0
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

use object_cache instead of kmemleak_initialized to check in
set_track_prepare(), so that memory leaks after kmemleak_init()
can be recorded and Rename kmemleak_initialized to
kmemleak_late_initialized

unreferenced object 0xc674ca80 (size 64):
 comm "swapper/0", pid 1, jiffies 4294938337 (age 204.880s)
 hex dump (first 32 bytes):
  80 55 75 c6 80 54 75 c6 00 55 75 c6 80 52 75 c6 .Uu..Tu..Uu..Ru.
  00 53 75 c6 00 00 00 00 00 00 00 00 00 00 00 00 .Su..........

Change in V2:
Delete patch1 in v1 version, change patch2, use object_cache instead of
kmemleak_initialized to check in set_track_prepare(), so that memory leak
after kmemleak_init() can be recorded, and rename kmemleak_initialized to
kmemleak_late_initialized

Xiaolei Wang (2):
  mm/kmemleak: use object_cache instead of kmemleak_initialized to check
    in set_track_prepare()
  Rename kmemleak_initialized to kmemleak_late_initialized

 mm/kmemleak.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.25.1

