Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78919788F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjHYTGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjHYTGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:06:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CACD3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:06:05 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIEQpJ020689;
        Fri, 25 Aug 2023 19:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=mxd9Mb3jlleYqr6X0jDbIBqXQT27sF2i7EgotUHdG6A=;
 b=xOwe74aAcnCzf64hyZnqxAjcg+AXqq+OeJG+CoDtor7TYnSlOIkkwbPlkuZi0QJaaexe
 3ObSk9ugi9fjyv/O7vLmS4NLyMAckNMbk/8GglSwIZ7Y+tJOS/x8r2NGZy+QgLay1jHi
 cEU2GsYzMfRwaY1ygJnyILz/VB5tG44cmfipLHFUTx/EwF3MNNYt1bF1ApYDfHt1I6H/
 nJYBC3zSr42g3Zn1egdRKSs1a1aFO90bnLUjybpPjhQ7Q4GntzIBMtR8i9HUSWm5Lujn
 o/THO8g888hVHQofzCQcIE26p12XPTK3r478i3JoPYh7tYorIPhySidaz6wcojf468O+ tw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yu779x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PHRtnk005844;
        Fri, 25 Aug 2023 19:05:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yuyadu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaN2eP/2WLk7YjpoOSctnwyKaeNH3sVW1dKcbcqQ2vSkklHDW59kcsVgoSpDlOoQDooZ/J4ZPLBDGcW8ucmDOctjUJDyqnOHwAkH3duRDFTMIwBVAm/zm0hzxG14037EY05jDLJ5txCH0iPGvKx5wFYb9Vs2NVr/oIMIuU9on1vN+ZXxP1aGeUPx2mXOlooaheynVA4gidNJSsG1P0JsQA21z6HAdZKY+0YNmaCHlg3s1EFaquZoCkf5tRvx3YIZG3EfY0zLud8DTxePUHDvy3ZzmBGhW9wQT1WxbdlZw8dZ8BrzY1Xapv3tZOqxWDYarYv7lpmXTjWpTiWhuolZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxd9Mb3jlleYqr6X0jDbIBqXQT27sF2i7EgotUHdG6A=;
 b=C1R9+vDAF0EdvTdlYZCjHQ2wTx/XUpmspAV5fcu13zbgE8MOTac/uQsUxLPkic26crE7YwKVDC71Cka1xlO2knnJrLqDz/ugviO0Rvnjf9dpSQ0C4SoUPwQ2D1NhuCoUQvoNjm5tABbCQkZoaBmmXhj4VseUkrHRuuE/HTAuWJHZAwpsmTDxrdwKsLV8Vv9icQWEcZd4DQctvkXSFtN5fFL9MBIotB3nfOycf/CQEctpfM1ZyQwjkbxUiul3pJceLkeIQUXPoVU/aFjZIxmNXvmr5gaNgMIdShh28ichaBtaQzOjG4Evejwz93kZTWp9T8p1tvcxOseJOLPclbC0dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxd9Mb3jlleYqr6X0jDbIBqXQT27sF2i7EgotUHdG6A=;
 b=LneynFCxOxCJeCTJiCzU05FedLicIJO/YFxNxo4sYKsLMpvhZzb/MAyZ+PHPqIInactm1SWmevBqwW3vuaXF0SikiPOcH0FbNvwsdzbbaC0dSWSNeCoueSSkdnNvUvJlFaFQA39Hcst8tSzihXSaHlPqU5kRWHQEZZJFuwWWIJk=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by PH7PR10MB6580.namprd10.prod.outlook.com (2603:10b6:510:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:05:26 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a%4]) with mapi id 15.20.6699.022; Fri, 25 Aug 2023
 19:05:26 +0000
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
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 12/12] hugetlb: batch TLB flushes when restoring vmemmap
Date:   Fri, 25 Aug 2023 12:04:32 -0700
Message-ID: <20230825190436.55045-13-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825190436.55045-1-mike.kravetz@oracle.com>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0240.namprd04.prod.outlook.com
 (2603:10b6:303:87::35) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|PH7PR10MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: c4099dca-1ec6-45a7-88ba-08dba59e3d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaIVMGTQ5ax/Ee5aBYf85w5lv3QoggNv3UMcKCtofmGzdZwkQZ3BKwjMh7dBkuRdh/yS8qmOFim8OsdsvcYVXsm4A3TrZHQ21zlPuq80nk8SuxPHTaAv4JJqSnJjs/DIrYFU/xpzqH6mhKqcPo2NPqDu9tTEk/Y1jVgvjzpNpeKZWUAx0iUGhZk1P6IMc84koDgnTC6dQOjHGRakZ4G/09APNvA8kctk5mMtFnYpJHq7gWJIHLEIcdOGAjq2TAAQtYFnywrfowaAgTKebXv3vwnxBO3VP1QlI/Va58Dw4VPDQKB9tfeFY6hfcZCdhgqnBk+smqmMfKjwLxd3EZ2QGroVzFqlvadKLh3EoJ6X17t7l7Os4l2sVHPtZbZHByyEbLql9Q0RGhMQVJeOGlfq4+UCzKCSxgwKwmB27hZ3uvx8J8ZUZAogVM+VHdijj7Kqy4lor3JfP9vMyFGH+V0d28KZuc859sgEhD9tTMR1riW2JqzcZfk7XDcY/osiC460qG4B0euxYW02H91gj2Jc64gLDzu1MrAHtTp82l5I/s+eoG/MShngRk8CLlOKLA9G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199024)(186009)(1800799009)(66946007)(54906003)(66556008)(66476007)(316002)(478600001)(26005)(44832011)(6666004)(38100700002)(41300700001)(86362001)(6486002)(6512007)(6506007)(2906002)(4326008)(8676002)(8936002)(1076003)(2616005)(107886003)(5660300002)(7416002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gfHHhv5xJqa+q012OG1KsLGGkJslK5l8SHXdXHzDmBHuIy1BXxs9wm7hyBXL?=
 =?us-ascii?Q?LtPxfQBo5dy1YMVGqnm4qAWsDq73YsZ8iLoUoFpZA/Ce1/LBI9q+jQrtfdFm?=
 =?us-ascii?Q?J4/gb0yTfWVyR9D1wYK889KaoYqZDz2kvf/SZLvIO33OuvBmarf0PzNTqbMb?=
 =?us-ascii?Q?gSoAS0A48qC5oH79xhOOI3iKqVPPLdaKrFuyqPfKKfx21sgQlW15aGSgNSci?=
 =?us-ascii?Q?QlXMGGcRjF1WXjlOlBWY+IsVwyj1FiYu4E0oKPiuz8W6FXoXKpZN8NsKY2jb?=
 =?us-ascii?Q?Ieyh7D1Ikmh/LH5hC/TP1OzVinoqIS2VklfzFcbJtDTYysVLuhZb0GHPpIUR?=
 =?us-ascii?Q?wMjXRP+pb0Z/y1E8zHuw6xDetLrs3zjB//VsQf2mpMKphUjEC5J8YIhBngHo?=
 =?us-ascii?Q?ODWsBmKn6ywGoGXkL0UM8t2fm5yBWXS3wvl0ATAmhEWe6CbM6HaEaqnN28N+?=
 =?us-ascii?Q?Oop4GNXgJi6N5v6FjLJrSNMiB9hj55AV30jqYK3HsiZziK6bAm6HOZ9vWgQY?=
 =?us-ascii?Q?9NueMq8y/dE5RJIvkD6sKcpfGrBPm7HWTbFnLxY+QFoyrIukt9Jk8MdtrbBi?=
 =?us-ascii?Q?jeNB3RjjrKIv13gnzYbqMi2L4n7ZophVg7xH1jkAfTxv2Qndw1g9ZAZEankK?=
 =?us-ascii?Q?bx/xH+QLmrZAdkjUSp20V6lM9JGtnVUQuOg/ibAeYmeh1KKIyeZ/YQnLEmFL?=
 =?us-ascii?Q?5HZbvw5rGPBkEsVjbQAFIB0aNS9VV8A4aLH/irrvJTW7smrnDQF852dFyY7r?=
 =?us-ascii?Q?Sr5hA6V5avwidixT9T7DL0AaDrpyEQ9SHlICsUlCF+rC59Lfe3Lnh+H9hFu5?=
 =?us-ascii?Q?7hhpVZHaJnWQAYZuzaYX6rjEB4b/9YbJKolSD4rZ5rk+Va1HV/MSMeatQPsM?=
 =?us-ascii?Q?bw6F7MWRFsWTleMk8nDTuVrP8X/mlZyvfvRhvLKNi7Fp1dXXUOWf4QP83+dk?=
 =?us-ascii?Q?9uUCAb3KcNZuswlpPwlCP0SAfrFW8EcrdnS/MT0QQZlA8WMe5A2z7a9mGvgf?=
 =?us-ascii?Q?egXp2iMbJzCCBSd4bdVf60EiAwNdGrYH2cSNZXprIwXSNsYMm1wITJzzVy6a?=
 =?us-ascii?Q?mdgdIhxFvIbPUoO72ULs1ur1M8iuJ4NdiI7Tjp9kJBuG01Du+/xyRo0tNHZz?=
 =?us-ascii?Q?nLJSuSRzwMbnDO/xcTnud6WRMksbApEosROUoV7teSJX2OIBiUbzfvBW3JGB?=
 =?us-ascii?Q?3ONu2Md3FbzdlYIiPAWtZBlqOvod/fsXk6jzGsQE1u+GlLAL2geXiaaBfD8I?=
 =?us-ascii?Q?CmgKmhgCwg693ZAU7n7s2jI4KgL6r4yID8UF6dlqdU2UeD8Cz4Qkm77q3Am4?=
 =?us-ascii?Q?+7L21mvk3j44YmXmAnnS8j7HpQGimqIEy1sGXhAjrDoWhv23deXJDLZhZBtm?=
 =?us-ascii?Q?pgAhL4V+LN0kwETD9syf5dNykZmkZT0Jfao24uJ76irjxIuiA1rtQbGn+yU8?=
 =?us-ascii?Q?rMSxXKHRmM+lfhbl8qh5fmYNZWXN6y3BrhD6b/xrejPMeQs7ZfzkvBBjXI/W?=
 =?us-ascii?Q?jb+E8kEfEGSnJz+GBiMoH4mXXC4BfvGGoydL1I5gcWrKV6yyugWwS03WiRmU?=
 =?us-ascii?Q?frDRDg09kMMmDXmZX3+eKCnzZgKvedbBjcaJGIf+CiEevBNC4AlqBFrtK8wz?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/Eg/HPGvi5G2PVpkRR1okJp4pbbIMNOyL37Y6Li75xS0dicYwxkHafTFXTvK?=
 =?us-ascii?Q?6+ek27KKdVv+3Ho5Kj4lpmiS3C/7crzzwUIxC6IL8lUx8thK7etIKYrs0kJV?=
 =?us-ascii?Q?Q4dSVfIpn2UwR67rFTBpzdRm1rAUkPrTIDw6CUtbprbkowH+j6eC1ZJJ7ewS?=
 =?us-ascii?Q?vGR8XcuDHoxC8fmJ8UzUoPYcANkIgvaV0AH1gGVqNmi+5LGuy2PuaE4IKqvY?=
 =?us-ascii?Q?bgRLGk8obrR/3X+Jw8vBpJMVJoZcXS/uNgDgTKWQN0pjXkYsdYfYGiLELTj5?=
 =?us-ascii?Q?bs9/TA9AgpU4zS1Rybc2sRTPnX76A+QszmcHBH5uuq3Ur5WGVS2yjOyf+ULr?=
 =?us-ascii?Q?oaebh5VMUfUidIKf5vtb4McKUBM2E1k0vTEwO26lie4/J/QPcj9ac0Eb20yO?=
 =?us-ascii?Q?KEhcw+U7MYceNSH7EQutTwWSyhGHNaqKiMkZK+d4rA/28HMkw4ug2RqRCFcB?=
 =?us-ascii?Q?iaIMZh4GF78vkkR3tRPBX9944qWH9tIiKc9tSx8WEdlUzYT5X83XeWw+m4sz?=
 =?us-ascii?Q?r7Lh+rq1Oek5C/7Fr0QuBKftrYUHk54YSz5QdOz4U9Czk1ELT1zhl4zysiz2?=
 =?us-ascii?Q?AK6Qzs6fnc5RruKLWK6sNDAXpqJF05yuzfbSjh9rHMo4q/VV73EQZ9mSxaZs?=
 =?us-ascii?Q?aV8zbMArQEhp1cqcw7WYwJUfLdvjJNKaxG18Wu2wICfo74ClZ4UxcK2LyPXX?=
 =?us-ascii?Q?bNm1oEFFG1EUGnGdfGXvvWAnvatgqwAsTqtgnJp9T0m3CnUvx3Qb6EwsotR/?=
 =?us-ascii?Q?RmPe3giHoY9DUGYfid75xmYO3jmj3D9IcDDrxPLtMyEdAKmDXf50gEu7LMWl?=
 =?us-ascii?Q?NXWZZeeSnK254u6kK7xZQOIVlFu1mJlyozSWCZPZRijKTY1yDWQoZ9c/bekL?=
 =?us-ascii?Q?31GflhMj+39UfL5lFVtgbGBaVcHkVwTG1sct2Jwo+G0cORV2vaVQg3dqF00r?=
 =?us-ascii?Q?bE7/2QvodOM36jy3iVtveZnuGzQ/NeVgGYCJOsHIvxwdgj7DuA1CQ/EMDwsi?=
 =?us-ascii?Q?9lrLAwMLijtyOAITcsuCRIk3eupt/4eAFo6gXEyJ0CfzSXBbxYrJzaQJqopx?=
 =?us-ascii?Q?KHkW8eqEciX58a/SN4Y/8gpCdvwP3YX3zxeUW/AmBrFvaKFhA9ew6BHDVYD5?=
 =?us-ascii?Q?4Oh8GsrW2KB0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4099dca-1ec6-45a7-88ba-08dba59e3d97
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:05:26.4302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYn6XHIEJMu4Sx/+dRtxXfeaG9eYX68aEHz+Z4dGfFqXhG3lPnWcZ6LI/UY6BFbiQp4Ci++WmXFmUGUdvr132A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_17,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250171
X-Proofpoint-GUID: 857681GrhwUbjGYotcHlduuiTyZWE8zi
X-Proofpoint-ORIG-GUID: 857681GrhwUbjGYotcHlduuiTyZWE8zi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the hugetlb_vmemmap_restore path to take a 'batch' parameter that
indicates restoration is happening on a batch of pages.  When set, use
the existing mechanism (VMEMMAP_REMAP_BULK_PAGES) to delay TLB flushing.
The routine hugetlb_vmemmap_restore_folios is the only user of this new
batch parameter and it will perform a global flush after all vmemmap is
restored.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index a2fc7b03ac6b..d6e7440b9507 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -479,17 +479,19 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
+ * @bulk:	bulk operation, batch TLB flushes
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
-			       unsigned long reuse)
+			       unsigned long reuse, bool bulk)
 {
 	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_restore_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
+		.flags		= !bulk ? 0 : VMEMMAP_REMAP_BULK_PAGES,
 	};
 
 	/* See the comment in the vmemmap_remap_free(). */
@@ -511,17 +513,7 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
 core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
 
-/**
- * hugetlb_vmemmap_restore - restore previously optimized (by
- *			     hugetlb_vmemmap_optimize()) vmemmap pages which
- *			     will be reallocated and remapped.
- * @h:		struct hstate.
- * @head:	the head page whose vmemmap pages will be restored.
- *
- * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
- * negative error code otherwise.
- */
-int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, bool bulk)
 {
 	int ret;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
@@ -541,7 +533,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	 * When a HugeTLB page is freed to the buddy allocator, previously
 	 * discarded vmemmap pages must be allocated and remapping.
 	 */
-	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse);
+	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse, bulk);
 	if (!ret) {
 		ClearHPageVmemmapOptimized(head);
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
@@ -550,12 +542,29 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore - restore previously optimized (by
+ *			     hugetlb_vmemmap_optimize()) vmemmap pages which
+ *			     will be reallocated and remapped.
+ * @h:		struct hstate.
+ * @head:	the head page whose vmemmap pages will be restored.
+ *
+ * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
+ * negative error code otherwise.
+ */
+int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+{
+	return __hugetlb_vmemmap_restore(h, head, false);
+}
+
 void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
 
 	list_for_each_entry(folio, folio_list, lru)
-		hugetlb_vmemmap_restore(h, &folio->page);
+		(void)__hugetlb_vmemmap_restore(h, &folio->page, true);
+
+	flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
 }
 
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
-- 
2.41.0

