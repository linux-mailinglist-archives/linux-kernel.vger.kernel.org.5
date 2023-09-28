Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C457B238B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjI1RRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjI1RRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:17:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9851A8;
        Thu, 28 Sep 2023 10:17:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SGi9Hl011469;
        Thu, 28 Sep 2023 17:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=8N9bQT4OfARgJz8z2dDRPsDy+ABDtcJbYYwl5l2osV0=;
 b=HyhqoUlEM4YV1KFprmlJM028Dn4YNPSYFbrk91mUC1zOLwbLulX96NOdcQaJv2FTnIz7
 gfXdPkTUTg+e7I9kOkLVG7N1yw0HhG/lYTeDVBbeVyNJ0UjmJPHkkIuJ/tzcYrnfYbib
 NzAj98G31vwQThgxvPXXVAdXfFONL0IYzIxZI9qTkIqKhW7UlH9rm3bHRHZySn4W3NpD
 Myc8lTYGTAtmxUnxIvLwWIqDvssevI7PY1m6XeGXiRsRSiGWP+0Yn8rqo4ORcjsGlKaq
 PG9eT39uNIkLxMSSAmDMksCcq12vmA8hZHZ3HRGrmQLieQjcZNAjNizRPAl/lvAiFXTX iQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3w2qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 17:16:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SH0WCt015788;
        Thu, 28 Sep 2023 17:16:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pffyuuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 17:16:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFepxrxV47lmzG51OiN/2br7qp6ozweqAzGui1JRmSrO45b1j1hITGa5HiByED6s1Xp66BlVpIEr1TwUf4ov11TLLJJ5UC5w0IxZfJqwk1eKwrVXSv3y+AzMYOOWBdAQ9VtTwcU4Aw+4L3V9KO/dE/h2wuwx7TUEqa4WlEhr96Tg3EkFOdaqvYGmX0LSTeV5j9zOZLD6xFcJ+IVVY9O604lgvRDYpABdulA4q30wbEh2URtQpYWBnGtDNp/LD3POagbRhEQhOxz7Exj6qVwxd0UsTjs0SZS6PoaISAMquAR4baiRDZeCfTviyyTwZQi9S6vuGwxoXuM9nY1qUfLaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8N9bQT4OfARgJz8z2dDRPsDy+ABDtcJbYYwl5l2osV0=;
 b=OC3oZp7KpNh7NA2sXQhXOBptpRX8Ssm54Xzd7hLtIGR/L0hB8lFvzxqSf2SW8MATYiihUtuBwkLokP1NqA/hCiQBQkabARocXucMIXYhpd4bfXVlQBT2UrwhNTNUwPrcO7Eb3ToINvbmRGYx6jARNtU2emakTDsF8CmE381+E3HKNQz10H2V+misDzYOrMF6kP7FGhvdfVYyh0qzRnVVt71STRQQ/xP9RfLxffInTE+lifbekgWtYp2yfdnmwPjG7FH7SEuNEtG9w7Zv49IBeRH0ozbLD0rqiAiG0p9SbrA2HbNvBt95mBK76b9KGezFDHns0vI9mAyW0m3V2PsAyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8N9bQT4OfARgJz8z2dDRPsDy+ABDtcJbYYwl5l2osV0=;
 b=d9Bq+XJ0aaXz4/0I5l6c5Ba9fqBOW9Kg4BPN7XrmKAtx2u4uqbwBaI0bl+D2wvGx2qNE/a32+fnb5J8rDQyzgygyTWiG5ISLS+yZDzMnIo7KELcPIG8i4YE+atCiTXcKitOaLv8yDrbGOQzQsfgS38D7p+TkB1sRxbnvZLUQfOM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 17:16:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 17:16:40 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 0/3] Fixes for vma_merge() error path
Date:   Thu, 28 Sep 2023 13:16:31 -0400
Message-Id: <20230928171634.2245042-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: f17fec8f-08bf-4606-86f9-08dbc046ae40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGzn1YrNTZ8tp4QbQAoMgcPg7oa+s0eJTwyIvNIlGr/PTG9mXtxj/0GKXsYZNSoAQ9D/0pw2HxXLjXYtqbXDUYcptH9nZT9/XsZ4zqoLtIbSGe4xr1mag6+UM/7oxkBdeyQjVo8qNWwQggk221H8o1CkzE4Lk/xtlMTC0SdkruiBpH1uLLFC0JJ76zbEQ8yQ3xy04QBt15salH6QCtSzrRaVOxJKo4DPdoriPZE1Z6ow7FqAMYwHRPEov9ORcPR4/iiHuwEfnnfkJcnki9gywn77TdPT1IMS9P7yka34mfJa4RPhCwq/N/7k5FuMBueMJf9dxA/H1IQL6lRrgYbY7oPNX1Qw0H5BoZB7x6BqAbyqKUGgO0brpIFggfkF2PAb1GpYGfynmklE/x/kOTSUVIvjpl1+wEmxcAMR0RpXoNqJ2AS5PfMI9G6qyXC5VDrGydAy1JCLYdiWKmkff4yy/TY4cjw9rg0vRZVdFwsh8Wka7yzJ67eV89LGx1nYgMsZ9rxpwe++6Dy7bHGiEJzbvjRw67TkP05CxHnhpG+pOPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4326008)(5660300002)(107886003)(66556008)(26005)(83380400001)(1076003)(66476007)(8936002)(54906003)(316002)(478600001)(66946007)(2906002)(2616005)(6916009)(966005)(41300700001)(6486002)(6666004)(8676002)(6512007)(7416002)(6506007)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Tjlrh97fXfeZDl3dbqXq2+aejpmM/A6TwQ8CMa3VG56DyHVVoT6LTTBSkfq?=
 =?us-ascii?Q?OQWjn9FGLDhBSKDhK5R6Jdo+uXKH+L0goIezvdfnS+QQNNtJE4SrcEyT0wpS?=
 =?us-ascii?Q?5hBtG7KjKz9REYXNijiBRGJvSHtC/qoTft4MOEc5mpt7nk4CMTOsBg6Zl0MW?=
 =?us-ascii?Q?PhJlmcJ3HEWykGszSWdAtlcJa6cZNoIPUzfLgumCvUZhMltU3mF+oMG0STZz?=
 =?us-ascii?Q?ukKQ2IQkRlpoOD3OcmXaawChk6OH/+kjn3+7ja9qHiEuEpOcYUw2m8uezWTy?=
 =?us-ascii?Q?mIkHD1qPCeS3IoASs8UnBbI3yON8cHCUC8TNdB5K6m8jMJENxha2k1aVL1RU?=
 =?us-ascii?Q?vS/FWebJlugDRpkpHrDLxSwZ0T6RiHFmj9d/Lkxxz/ocw9Vp6XUf6S9YQ1Zl?=
 =?us-ascii?Q?v5hOTin6m+/JeHBAtDPoJebkRjDqMAjgfL64I16R5dwsAdn9hTgKPtxhcnDf?=
 =?us-ascii?Q?sCXtnl5fb1ZwX31f8WitILh3T9jzFP7AhMLfgJyAQ/MrqwCtTBqfmJstUjrs?=
 =?us-ascii?Q?7ec7xSwU9EVrZJUeD1xDYc9Kqfv53sYrTqPAzNv6tFm5SC+SQ8g++PE4epiC?=
 =?us-ascii?Q?QMYfxUUrZsl/GQyNYfdUfa5gP37YT8XWIPYkqMu00mjlDi5j2ON/w9ObmXSp?=
 =?us-ascii?Q?dHkZDBGOITQFIJkKQPzMWTYR4e4nYoWP5hbaF3LbitPR3XtgE+NFSngt9oyh?=
 =?us-ascii?Q?eri3B2KshZ9rwC1fsuqLrBeWF90e5XqvkozLM8AWoZDsfsuLNXNSFpGH7cPa?=
 =?us-ascii?Q?3z3nZAlro+mHrTeEcBiGZ3D0uZXTVuKwPXMeCF8iSxEaxVuknW8YVLX8DFku?=
 =?us-ascii?Q?6sa7/Rfh1cBAyKWpwxl0Y/SJOQB3K77ci5C7njGodpZ4JEK8qITWu/leOn/g?=
 =?us-ascii?Q?Qzo8ZMhwmo2UTwOjBW+dnkoXt7AKlew9Z87+VCgF3/xd1XA7Gw4RmFTWq18g?=
 =?us-ascii?Q?f50Z3NWsEi/+cRzDm1E5p0ZMB0lunurYtjc/7SwtVIvT/00Drhl9m3id16Sq?=
 =?us-ascii?Q?Q83Dsp8PZKbzxphyl3iDGFsxoIFXkkbhwcS0B1aDpobD+ceDc5d8GzsfIqk6?=
 =?us-ascii?Q?isjBNLDDYNAbocYtLj+iLwhv/M+UrfVdf9FiVMRhVOzLC7ujsWToQI07iGYd?=
 =?us-ascii?Q?cyeDNZTitJSIlAM6Y13jIymjXN4BK4ua1OTLXIeSNcUlQgWsxvOGxr9ED+eH?=
 =?us-ascii?Q?NiEBpaBJ+gXzS+SDFeZd0+xR7EkyAxhrcxB3fa8NgUCGpE7D+2DAcbxMbRD1?=
 =?us-ascii?Q?Uel7A83u4bVYT7mbhs768k0zSu0UEBS0FrJhCRoklA2BLYQPIn9P5zvF7R3b?=
 =?us-ascii?Q?zIKp3W4LusjLOJrcgTMxKvG2YDvU0rVM7N0JQDeBYIooCtVkSI0tnT/rKRDM?=
 =?us-ascii?Q?vwx/Lp5xgPvhZHa6g83ZNLg/bT0YrYNQIzzRhAgU9ASPBgEeRWNVtR7EAKDL?=
 =?us-ascii?Q?LoY4wbKWNEni9WJXwNEsXcsJxx4LTH21ntrbUBW3z22HBJQXkXwhAuTHbotP?=
 =?us-ascii?Q?5KXBxa/eA44cW3d2qtu9pnoe5UXGjPIUssBZ5p4iriRG7rtabkpReTXj00+W?=
 =?us-ascii?Q?mcbUeO3SDGo5VzAABag1wUVHoKOUjKxxwY+YzG5H?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?aZI33zM1wAXZae+Y8qolrMHJ9ik/KbJa2PkrmJKYteQerUyfQTSEGPBAF0/1?=
 =?us-ascii?Q?cTUBClEqvKjFfJQ2GTi+syi0g7ivHwdtEPTLHfz+IPtAXzCZTzGTE4ZePyo/?=
 =?us-ascii?Q?v3f9vOzVhMcTAMB0dv24PCSbR0A1Ir0dYyAOqDacGfsgoJz36061qFxqqt8l?=
 =?us-ascii?Q?vcAp1xWPJiLywAxpDhHe1Pez0OwkVnfhcgeSOsSFVbtdlNfwRyTRcxHg3PHq?=
 =?us-ascii?Q?/x6NoJLgQb4znAPV/LydKsYp/9i6sB5MewE3oKHlG5wupbrP/2p6F1jLmHXI?=
 =?us-ascii?Q?AVh+62/5HYx6Edz6mIzgUl4KVU/DQZFoJX0ZbqSEnR3UPOzaz7m5XLIk0/KY?=
 =?us-ascii?Q?4GmcE5ouwwGKftbjAd4tysF7QXOSWpTAjDqTxN0/gvkgpUA9ROjdvNsAin19?=
 =?us-ascii?Q?mnfoFA7NQKk9ogFVJqiZlMkuyyDZRom8GTyleeSVtUi8BQPcHiWjZOmppa8M?=
 =?us-ascii?Q?owTMPm6Fg4Kh+W9jzdJWJLErC5nlQrf+za8lpZFyb8lhcTDHh7C4skKtllzZ?=
 =?us-ascii?Q?WcVDxY5/F+2gfvzvhT7/bED34J89glBUKz2AkFVJwLELT6WsrcYa2Ih5aCUz?=
 =?us-ascii?Q?55vPD3pF7MRpBaqRuNMyMZL+DoXh2rStGSzHSoRtoN9npczUe5c1dg33O/VJ?=
 =?us-ascii?Q?nE7xG+IsBvRlWMgy/uo7KeZnf5ABTMqOIu5hZE+Rds7reveKFi+hKy+Ijmur?=
 =?us-ascii?Q?a3Sh1hgsM/pwbkaOENVpTSEpzBznIsCNGIY9dKbYXy5Umcpe4XdJmWqygYyV?=
 =?us-ascii?Q?Toz/fGncHHdkMxt+PkZr0TSewdoeJTCjsyF1C5F88k8j9LZy97TE7t8czYpU?=
 =?us-ascii?Q?cHkvHrlK19A+o3ZqIVaFzqV7dpxUmakeQGwSiPAybLi74ku9UDRx2JvY15p6?=
 =?us-ascii?Q?C8lVl0lKvBrBy9UHEhjJ5FNRbPStxakjoB2g+3oUnDl+qA/G+YnJq0ah3RBv?=
 =?us-ascii?Q?e6IBQL3MXuVcCBnIsuZ7uoLcR00CuLScHusO1YllVUK54qPgGl7g2ZvFXuhR?=
 =?us-ascii?Q?7wxH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17fec8f-08bf-4606-86f9-08dbc046ae40
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 17:16:40.7552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOyakHA5CxGg5TjUcBeqvsP6FBbARqWXg4DT2NVW67lZZki1KuDmRLBDzmvCCobtmYyvCzfLEcMH9u4tyYsBnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=550 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280150
X-Proofpoint-ORIG-GUID: f2zBmCU_cijtLLXm_pTwn1yJvNESit2X
X-Proofpoint-GUID: f2zBmCU_cijtLLXm_pTwn1yJvNESit2X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn reported a potential vma iterator issue in the failure path of
the vma_merge() code.  After examining the interface, it seemed the best
course of action is to simply add an undo path in the unlikely case of
an error.

On examining the vma iterator issue, another issue was discovered that
would increase the memory usage during failure scenarios, so this is
addressed in patch 2.

Since it is unclear in the code, another patch adds comments to the
vma_merge() function on why dup_anon_vma() is safe in 'case 6'.

Changes since v1:
 - Moved dup_anon_vma() call update from patch 1 to patch 2 - Thanks
   Matthew Wilcox
 - Changed comment on patch 1 - Thanks Andrew Morton

v1: https://lore.kernel.org/linux-mm/20230927160746.1928098-1-Liam.Howlett@oracle.com/

Liam R. Howlett (3):
  mmap: Fix vma_iterator in error path of vma_merge()
  mmap: Fix error paths with dup_anon_vma()
  mmap: Add clarifying comment to vma_merge() code

 mm/mmap.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

-- 
2.40.1

