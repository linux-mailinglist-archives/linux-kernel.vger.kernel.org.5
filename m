Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A8B7A2A5E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbjIOWRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbjIOWQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:16:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A969B9B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:16:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLvpmK026895;
        Fri, 15 Sep 2023 22:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=6WdNctGaCYcEcx93nm9VBTMI1xvm9ngqGmtgPK5aZYY=;
 b=HulXkWT9rIvq0D1cDorZ+ZLmoJKWpu4KcsM9uUdCW1zM4glBwbz8ba2m7p+t6ZuaM9Bs
 kqmLB9CZlJdpHhwz9/laduLnsCwIgcH85Hhs8bwEhBg1DHU/7tAwph8NR/A6fIuAWNyj
 BOCtK8X2OPQnzpJXao8yztWnrFkj9bnjfKKO76hBMSBhvYX5EypASihzgG56omdOCA0j
 saSlftHgRkCtTkgCQNyP2fKQSttK6MvR9AfFeSDvjkbYwsyDdwpkZyVyR3kwt6xtl2E5
 2NKVC1Mpx5BLuAxFw7DoUCTuBmkwsOYE7Vwvc0FRyvgmiU3eXa1ZbQW38iI28HaJhk5s OA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7krpn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLA011007422;
        Fri, 15 Sep 2023 22:16:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5bd5qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioIjP8nPJeBxzzcWWW2bNVEnZRR+7b8f7zETXAVStai6grXiZfC6Sh0NsZVZb74G1TuKdnp9rBguWgRNDoaPWiVtwS/e/XHFnkJWZvs6GznrdjryKbSLgGpfsqMPe/KnoXcKINY2AG57rNkEDvoNdBDBWEK1NBzRSlTRle/J62a3rxUC2o/+F8WgfiLFERLd6UYg5r+scfJHGMGyAJiO5L++IGoNavQ7ttxJz1KhUN0XF49FG/HpkhBfc0prkratcosD6o9PmURxXChbWRwqa8gp4cmi5/d0JRl2SJDie/7uT+NsmxgpmWIT/EToxGDAXOpKrNeKc6Z1ivbZhcXNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WdNctGaCYcEcx93nm9VBTMI1xvm9ngqGmtgPK5aZYY=;
 b=gap/b/CzlIIofeFu3HLTsLqldyimCvEhDOeM3bB/HR+1F3YqUHTwcdzCz5SpN13jX23MynlPN5/F/1HnfQzLSCbd17w0bK1P6dNU4dAycLilE8LmQcOpOjFnbr/d9ci43ZrVHSSev8jZiPGOgOSeac7l496OATmFYyBw0/9RzoA7FweJhlBbQIEcKB7iCOoBZtme4R6xy7y714Hs8maJQ0YeWcRNJxQSxPjsCqiULt6rsEXZezrjnm+2Xuv0CWr/R2uBfsvIEbNeA04YPIKyMqMtjzTolo40YSsUKVeDyoZTWWCRnthiNJXGa5L/i5QGQOXs5wEiC+OQKmtrsoRGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WdNctGaCYcEcx93nm9VBTMI1xvm9ngqGmtgPK5aZYY=;
 b=rNVHRQQU6hYSsJhrnIZuCQGhyEnrs2yVHlHmjtL4finQHzMJvC5N6EhbzRRve4aOExQLAobjEkQG9uT75Nwghj/Lvgb0c3rYERl+31+DVombNv5RnYuj8X6Zt/3PXmGGsHjT8n+xamp37kqJFUKxd8HYIAf3TJWqBHj2XcHS+Hw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 22:16:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 22:16:06 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>
Subject: [PATCH v3 05/12] hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
Date:   Fri, 15 Sep 2023 15:15:38 -0700
Message-ID: <20230915221548.552084-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915221548.552084-1-mike.kravetz@oracle.com>
References: <20230915221548.552084-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0378.namprd04.prod.outlook.com
 (2603:10b6:303:81::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: db473531-2370-4800-dc52-08dbb6395b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OU4JdLrwrCxYsXATQaERkEcoBI3vVVSOleH/pOwMDTqLvRWJE/N/AyrHQ6JXbsSzKfJoKNDvj4qB3+B9rEYgPljnfsMLXbCzMgg0QGIFstWMWkgeI28LI/KONwIy/JVwRYTZwuGX3sSoWETn9faJ2YeQiOdT9fUj7DHE83647c7COAb35ZQ986YbUSurk06calwCpO3fdRSN4IqrjEIuPE6oqaRCVW+FHhO+8P80ek6rZNMEjD8XOBCGNayLeygy/Yhv7nrAmLyaL/UE+wQuX6FntNFQm2eciBG60KIp/gsQPIISCSIlji+c/NWJQ1IJrs2iqnndJvYHnwQVOrjuyEpZa05zaaaMVoJ3ZXd0tWqiqdZor1E8H0JfzBpUofeNgqDz/QacYTibrl3njcEP/4kxlMp73Fe1MzOOlCU7YoxENatHBaKUa8oyhm4ZloSbbg1ZAUugyiOV9NPGjPMx7ICFu2b5yaF39XAWOYVhzVLBYdJJAyBB6KIPsfTFh9uG3Kb1Zjbic1VFmVncSLymhjtOp3pQaQWEvLrhSsDZzLDe9WUofCWbd6wtn8Lq76Va
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199024)(186009)(1800799009)(44832011)(86362001)(36756003)(83380400001)(2906002)(38100700002)(478600001)(1076003)(2616005)(26005)(15650500001)(4326008)(6512007)(41300700001)(5660300002)(6506007)(6486002)(8676002)(6666004)(66556008)(316002)(66946007)(8936002)(7416002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?86O3UTS3vzhe9ZIdLpgLJBakHwtBmXMF8J6sTRAhhs6mEJAhXJW6PT+5cMcB?=
 =?us-ascii?Q?SogdqpNGTHsYCK9Ij5BaUvIdT2EZ1J9m8o4O9FVLD5yByEjcEnA5LmNld1na?=
 =?us-ascii?Q?aOL/Ppk0dby6Ogyxe5i9oKVrnsD+ZE5cqBgexazflWtDpSJO/voXw3CRGgbW?=
 =?us-ascii?Q?2KKIsGd0aIu3/edCD8wNly7fC+KlSlkC6xhJA3eL6B774iehJjc9szbJniqT?=
 =?us-ascii?Q?EmZmwl49ycKmc1i0tODfvt1HXMo2hQfukPXn+Yjlf1BLLi7R+YMtXs3Bzd2Q?=
 =?us-ascii?Q?DBjeGjh6Nq/oPsiklUMlwBx6cDL/OKFtlO4ygSuR0t30z7YP/1GmDzWR9HLE?=
 =?us-ascii?Q?68WBdGsHi83Ogh8p2gvnnTb57IvuQygLrh9NQFlfrpPE5Z5+rvw0WWF8P4Pk?=
 =?us-ascii?Q?ilAhP5uwbZ5zjzmgj19SOJHmo60eQV83/iu9X2Tp6CGMgMOnoSBMMZOx1YeF?=
 =?us-ascii?Q?vGGvIztPArvdL6P+VB8pzqTmB5TGl6WiW9lwRGeD4O5pCEa+8SHCe9FRvB7M?=
 =?us-ascii?Q?LjpXxvETi1F+AsyldB10cc3O5GoEQ+0x78WuiDUOfdb2ELrpeoAtunH+9k4i?=
 =?us-ascii?Q?IX1xz3TzYEmUD5tf8WN78vNe56UDpzqqgQVQuK3qPnMOicfRRU5T9GD1CJlL?=
 =?us-ascii?Q?yV3csqLqTBrKKZLlVO2LBvEwdQewmImfWcRHfhtcAfitQJUPh1JD/MxR3/wE?=
 =?us-ascii?Q?F4oD/oyvCSojqpdIOaT/cXbDnw04ZTR4YG5WisfQMz3H4lLZbw3rxw2gfjz5?=
 =?us-ascii?Q?lqeZrOj1BcabzieXcp8Hfq6lEeh99DB3JeUhOBdw86duhOggA5c2h5kMLz8F?=
 =?us-ascii?Q?3Bwm/XtZFLM6SI0HKYY/pAPvxrfdyZXUDYq/AZHighqqv+TmFL7E84hA+gkY?=
 =?us-ascii?Q?wBvlHhv//xazQBPsJrI/vc1k1eAwVwSisnAefK01tM82zSq0FCpV/8aYTxus?=
 =?us-ascii?Q?C2yb7SDUIw/jRfZnt4HAeENVK4xJlXLMDLbF4+StRaHbOnUCXsFx0jZHjjk4?=
 =?us-ascii?Q?IOiRODWtv9+BImQ8sPYVrZ8CxQmirsGmQUojhRf2xAPJphyxjjpdBDk6kCG7?=
 =?us-ascii?Q?qKFlOcaJj5yEQeKV5eILFC6zm8NHbXGD9FSGM7/ohVBQVZA+SCR4p3ILE0Au?=
 =?us-ascii?Q?fazWkm27RFW03gJF3ckSJIrJl70jNRaM1sumJa6iI6GYhuTUPIKOg1SG7UJN?=
 =?us-ascii?Q?R77qWs7Fvckid/kih5Btezh3ymdMUD0dFAAdWAI7Mdcblwit7N7Xgi2HQojx?=
 =?us-ascii?Q?dtuzeg7+IKCzwSIkNuMnUpwwtvwI/frKH1/mRlj1bBd092CZ9UVcROB+wfYU?=
 =?us-ascii?Q?8ectrDDl86+u1RSv4gG3AkUPm0qQ3eoCKwg5SptjrdzZIZ463hSKLJ1KN7dI?=
 =?us-ascii?Q?HrCAkq7xeaK7C9KSV2UZu6I3SNBaYSnJgt5BBkoSr/X6BYpPtDmD2MSC17Vz?=
 =?us-ascii?Q?ZKD8FWaZo9MeL40N5G80esT4t0sNknM+8RAU8+JmP0lXXA9gbyHXYeOIB0RF?=
 =?us-ascii?Q?4F+WA9dQ0nKf0HYWK3C6HrrNu9pPzm+pUHsxxh+gYKvlpZdVYLdmLEBU1Vfw?=
 =?us-ascii?Q?Kqcrg8NbG2Tbze3l3RnCGJAiXZTKjcnIH9rRCny0fByycg7MvSy5OFQI0o5p?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PthCyh8nsiDOzGkG7as6+tShOlpIHgB0q31ApQZ2Xaq8B+e0GA8gxqx8fNpE?=
 =?us-ascii?Q?r1YdMTJzMfT5YF04uZ1vWwM0Wz2b/LMDwrZIadX6K+PPQJZfMPzHEK0cRdr1?=
 =?us-ascii?Q?XqfiCjCttFcsfrQLMCrTe2C6NvbV+O5RwY/tL+A21k5oIfVa57xNjGnv+3dw?=
 =?us-ascii?Q?NQK36+n9A/wU6qny9PyZ4vb+UUz0+fO1ElT8XlgLoJeLjndCDQd8/yJTd8ZO?=
 =?us-ascii?Q?h9G1jOymuTwiFd1ALtMJfGSxgJVZ7Aa5d5lbM/gtOxxs5HeybQn4iPsHzMRw?=
 =?us-ascii?Q?6B9U39tIqRIWQdj26tR3TRuZdMGNGF0IiBmptROHre3uw84e7oVk+oOTbbM1?=
 =?us-ascii?Q?t6p6/lCRLgzD38m+WK/GmhJSlKmCADz/gl+yZvQidRu4j63XqBFjRODh04W6?=
 =?us-ascii?Q?mR9bljctBVOc1yOmDGsg2XinXMkvWup65/pwvnaDYEWbWqeJeXbpzvEit/Tb?=
 =?us-ascii?Q?tldAc4QcjC1QFz4qPhfIVwBx3MmYfKVC0bl0stq7Bp2WyU01Pl8Zlki7As4s?=
 =?us-ascii?Q?qqAMd/kZ3VtAYJdR+HVUj8+uoGBBKzOQoOD1WE8HVLitd7gbCJ/AZSm8qzLj?=
 =?us-ascii?Q?qyctO8vGDUA6p/QFjuB5X5en7gMsSG5hpoLFXAgcDsBDaItqXoATjqK6QeEy?=
 =?us-ascii?Q?IS/qQuYB786rjXysnGy6lGTnCwCmQNBGPSm7y3Qy+5MiBug8xpS2Tj+jDtD9?=
 =?us-ascii?Q?DyQiWyGagxlO19y9sMgeUZQ0gkrF98fv2yUWBvHP4P+/GtUJ9XVG8aY0HvCy?=
 =?us-ascii?Q?gtNW9Ji7H11chQbtW6R/pJiDtJGN5liQJmz9mhB1BRk7bTSNGbwxGCkSBCSZ?=
 =?us-ascii?Q?m5/2kimJxKKQfGNAk7tRIhOYha5T1MMLLqbbWe7YV/hliYmpwWeNhyr1EhVV?=
 =?us-ascii?Q?73g3wtu1p9Jzb2OCyXe/MvYwoiw7Bb21U7xu7KMNoUSv/lNcJ/eVMa4tBBhk?=
 =?us-ascii?Q?CojA/X40kwqO/2m4IBgk/3ELq4624UCuWdtFolWLLuanHaogiX6jrhIPLHLK?=
 =?us-ascii?Q?3UpnDnInYEPjN3uR9BgeIsGveuLi6Qs/ZndegSdpfSIuKFpaougpdAQTRmei?=
 =?us-ascii?Q?j6h9GDH2Tcj63ohOTGc466/VghNbjWXQ1ieJRPPGaKSTjLvpQTbq7AHAOksM?=
 =?us-ascii?Q?5afh76Eikp2U?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db473531-2370-4800-dc52-08dbb6395b49
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:16:06.5426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lw9WLHjOAZFxUyrcepf6pskcjt5yktHzIfo0N2vVf0qcodeMX6TN+zKllZMGIDNUrW8/uxLCvVPeD2UbGsCwfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_19,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150200
X-Proofpoint-GUID: tszrv8NPMR4A70xj1-3LxstI4rhn6i8U
X-Proofpoint-ORIG-GUID: tszrv8NPMR4A70xj1-3LxstI4rhn6i8U
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_and_free_pages_bulk is designed to free a list of hugetlb pages
back to their associated lower level allocators.  This may require
allocating vmemmmap pages associated with each hugetlb page.  The
hugetlb page destructor must be changed before pages are freed to lower
level allocators.  However, the destructor must be changed under the
hugetlb lock.  This means there is potentially one lock cycle per page.

Minimize the number of lock cycles in update_and_free_pages_bulk by:
1) allocating necessary vmemmap for all hugetlb pages on the list
2) take hugetlb lock and clear destructor for all pages on the list
3) free all pages on list back to low level allocators

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 744e214c7d9b..52f695222450 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1830,7 +1830,46 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
 	struct folio *folio, *t_folio;
+	bool clear_dtor = false;
 
+	/*
+	 * First allocate required vmemmmap (if necessary) for all folios on
+	 * list.  If vmemmap can not be allocated, we can not free folio to
+	 * lower level allocator, so add back as hugetlb surplus page.
+	 * add_hugetlb_folio() removes the page from THIS list.
+	 * Use clear_dtor to note if vmemmap was successfully allocated for
+	 * ANY page on the list.
+	 */
+	list_for_each_entry_safe(folio, t_folio, list, lru) {
+		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+			if (hugetlb_vmemmap_restore(h, &folio->page)) {
+				spin_lock_irq(&hugetlb_lock);
+				add_hugetlb_folio(h, folio, true);
+				spin_unlock_irq(&hugetlb_lock);
+			} else
+				clear_dtor = true;
+		}
+	}
+
+	/*
+	 * If vmemmmap allocation was performed on any folio above, take lock
+	 * to clear destructor of all folios on list.  This avoids the need to
+	 * lock/unlock for each individual folio.
+	 * The assumption is vmemmap allocation was performed on all or none
+	 * of the folios on the list.  This is true expect in VERY rare cases.
+	 */
+	if (clear_dtor) {
+		spin_lock_irq(&hugetlb_lock);
+		list_for_each_entry(folio, list, lru)
+			__clear_hugetlb_destructor(h, folio);
+		spin_unlock_irq(&hugetlb_lock);
+	}
+
+	/*
+	 * Free folios back to low level allocators.  vmemmap and destructors
+	 * were taken care of above, so update_and_free_hugetlb_folio will
+	 * not need to take hugetlb lock.
+	 */
 	list_for_each_entry_safe(folio, t_folio, list, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
-- 
2.41.0

