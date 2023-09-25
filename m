Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95267AE2A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjIYXts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjIYXtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:49:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320E6139
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 16:49:34 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PNDnst014513;
        Mon, 25 Sep 2023 23:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PjGQYnP6GfgFpQZQacG3GP1Mf1Hkr1K9uVvhSO0ZtHk=;
 b=eLykC5xN+L2TYUpniRJIwaJ81qxoDFNvY87MutcHndngFV0mCGVkDJ3zkOH0mant/bPp
 0JlHdWsQjLu0nA9B+HRkuJCYd57TWFOZNB/LKudmk4QvYxUMMOBHls6nJXxvlOhAqcVF
 mDrD0FSjP4QVzLRzaCvgcHL+YigHnhPUiAd2Kw5TexLFwsZM68tI7abBYhGFy1M6LwfW
 jtwzwpbjcsMes1IpAiTmQDQDAEDVxApjEWU4GjxBMjefi9fXag3lA63glqljcSRavORF
 yKd0EaKSeuPdEtUAL8h5PZKP6dJicGdTRFUSKlNXjxn9NhqUZDmXkX4V1lTEBzVJi/vj lA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2dd7db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:49:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PLcn6d030869;
        Mon, 25 Sep 2023 23:48:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbawdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0PeOsgyncNO+pHrsSfdVOZN4VWLoKWXgDbtsg9auvmDke5Fket9mY0cpivZ6e7wpsvLSVFvhUB1mytsW2aOQmjXV3hZIlnooxTHLpnhWTR8gyhdshKxtcYGG98EXYzMm95kQkIqovGo8XFQDqccjstX24YdI/cwo1tgGUbpB9l/dxObUWFGWm/I8f1DmVuJzl3hAw5fyHjTzLYp4PvzW9kKwl+meg0/bg8n6c3n+741SfUUf0Df+FTWkK//NM2S5xS5qeR1YDbHTOO8m7qKBy3+l4MVRwj/tgEOuq+HJ9yQsUDhh8jyAkEcMP8AgCZM14XHZOIr8bh6dLAZBd1OXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjGQYnP6GfgFpQZQacG3GP1Mf1Hkr1K9uVvhSO0ZtHk=;
 b=AbW2iZDJsJl18/0kiKxTdnQ56Ylr5ihb/ZpPGhMdwqbbZPMdpJT/rioqStfbLuge+2yUdQsdlhc/hQ0B+AljACuYHqoFgNHx4qKPaWj8xT0VfwntauMcOsXt2vuAL7qpQMOggnFyX6uZazdZid6e58cbZV5QUuyQe95wkPOSs6yAj6p2Weph//eYlgTrAkCK2sQkLwWoTR1Du2jIEzKGfvo1OoYV4/WP5Nv478tvSDkDUJX58S3Vf2tCovZR1rmafOcTi2xVt/RRBdacd1ppeG24afHjJA5hVq+/dHLLGKpGIxXn/BSC24Tn8A7vSqe812i4MQ4ErkbFrbtC73uWNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjGQYnP6GfgFpQZQacG3GP1Mf1Hkr1K9uVvhSO0ZtHk=;
 b=oiAP4i7XR6wQTP3cx8UMwJz0WpTBzGcD/frSXf5JdY643PQJ6P/5LLxpGfIviWT927izrz+SgdNl7poU9aKSq4tV9AGIiyIex8xMUq35wSTlI0NZueViFCBk/y5EjoZDoomW7fTMYr6TUv3eluMDgirOgnzI75a3Deh9+G3J6F8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6730.namprd10.prod.outlook.com (2603:10b6:930:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 23:48:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 23:48:52 +0000
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
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v6 3/8] hugetlb: perform vmemmap optimization on a list of pages
Date:   Mon, 25 Sep 2023 16:48:31 -0700
Message-ID: <20230925234837.86786-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925234837.86786-1-mike.kravetz@oracle.com>
References: <20230925234837.86786-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0280.namprd04.prod.outlook.com
 (2603:10b6:303:89::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 820338f7-0ccf-4750-a958-08dbbe21f90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMXCN6mr/c8Y1FTiFdSlN+m6rz0cPRvtj7fKh8zlRCNEkg4y4UMmEtcYp0DYUsuX4yYzzk8KcJZLRj49FciNeUT7D0CPkUdz+/PxxFUxwNemh4rSNlgG1k6UzOFMvr0Q2zjoJ3qCarFDa5dgC9KUT/pPmGFTqELP+wAXuZlBYKmpUGv32oABMgo4hg3J3yJyF37ILIE0cY3SJxuvwkS2VCn35cjBlEdVfUZoGtDdyIrwQM99x2l+kX2SXAQR+1wIglHVdMthO/PF9CgZ0XL7f/SPYQsQ/nR5kmlplgCQPp9v8QWjqnBBBRIkvF95O2vqNshyDy9AfOh4ASPY9bnhqZFt9EvVutYfRytPg62mNIx43XeUeVrDz27F4HqywrX4BvnvGeGwqhizrUES5f4M+JCHIEtR70+TYXL2+2oqah8iGbRerw2+YYhm11YTpjHsspO1i6mizG6yaqMiSzaIH4J950py+YYPo8kaL7Jnt5Z99n5IZkZqffe5gK/pM8KFG3yIVPWdF+bCSs43qnvhvAszUhKnZVv/EOq2eEfbD65EVW4+sEKgfwbjqM5OPALR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(478600001)(6506007)(6666004)(6486002)(1076003)(2906002)(2616005)(5660300002)(6512007)(7416002)(54906003)(316002)(107886003)(66946007)(8936002)(66476007)(8676002)(4326008)(41300700001)(44832011)(66556008)(26005)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8cvOHMY6p2QaAhtJFzLpilSHWhzD/iuGIN4tfbtRNg7SXgIq1KOeQEymNsY9?=
 =?us-ascii?Q?c786HOm+MxhJKlU4JFj3xaAT2JDebHFbel4lsNo9XEEIUQZHTLBMMV9P6LSj?=
 =?us-ascii?Q?PphXHZKzDltjbkMg5vT8LY1MItMiPiCRiLcEPHC8k1bAMXo+GTCeTEUweaX2?=
 =?us-ascii?Q?Uiih1VjgrrTqyq7x87hdzDTsDPElSWrifO1TZGOUakuanAZoLlOAuw/9R+HF?=
 =?us-ascii?Q?+Ayu7mXgb0qUt7IpFjlZgladHH4/xE5IXlEW+HBl5Au3VG1N9XKlhkuNhr3L?=
 =?us-ascii?Q?/xlyEaMHiVJJ6XGuLyoxuSFYJ+62ViYGRH/6yabZfMjdgEh2yjmKt6d5KReg?=
 =?us-ascii?Q?hdOyrI0RGzLlPiEdwKFy2LXcp4oOEIqKf0Bo3VPpTKSTHu7Z8KZO7pO1yYOy?=
 =?us-ascii?Q?5yvxK9QXYMgucC5L5utn+fg1KjmnyMjl46SEPOcFhcMNLw40ByqVRMR/g+Tq?=
 =?us-ascii?Q?JZxmWIm2Jv77lnIV39fdLvOxkPOw+X2lkOnSCiidHhR/a1889yMv6AKpJHNH?=
 =?us-ascii?Q?Q/uR/6Xuakvt3qQ9fGq76lLexXoydZvdAuJDv2bPGvquBqfAMVQzUYULTmy2?=
 =?us-ascii?Q?2wUHiO0RGcgJFAFWIsmryOboPoVP7ZGHaCvFzq8EkrZrtk1gELcBedG7jDad?=
 =?us-ascii?Q?W0BvbbHcBoqVtg23AxVnW0DWVSVWee6h6F2HMFcMgppcgkuTyjEKe8LpV2hX?=
 =?us-ascii?Q?ZBG88S+wJ/t2clLWFyy5v6GVa1EY7oiC06F0f/rSL7qon0NSurSTk+s9CCGJ?=
 =?us-ascii?Q?+TDmz5g2Tm+Lpn2LS2rl+vh1BJq213Pdr7vB4SQybGSUBBWuWZgb0Dt1NchY?=
 =?us-ascii?Q?WEgXvXfp2qMEkXEpZlkx1yRjycPd2zTHA40yjoMklSktNk9sIA+BaINopRXG?=
 =?us-ascii?Q?KnHA6kujwx61/v/0ihHazMaXBNkjmUIuX+C0aY9S1qv3dr5R0xXQxX/riv07?=
 =?us-ascii?Q?jYc+84FhY2SZ1wDaQTWNR0OAHbB9bphHCuk8LepeH89coj9MqtF8l10eIBPS?=
 =?us-ascii?Q?QitC4AY1vl1mXTsTvMvlpSFCGUuum2NHJW8koi3acbryyIc+NU6ESqrJshBT?=
 =?us-ascii?Q?U9sSyCjm2wrPa2xxq9Bc3Fv63f/Xld7pwVnc902R/i0XKNzigjIETMPpdauG?=
 =?us-ascii?Q?mhZHGogObsR1IszNHxpDkweo/+Bq7i2CxC0/HNjMnIDZ28o884jm9ImqA81l?=
 =?us-ascii?Q?zDMPLpLDIm36HfZwvCt7PFr8z85LjQZnnZg2J8yXet0xC9OJ4VJTthUODyEq?=
 =?us-ascii?Q?EOuzQUdqNrYlROo/YV0yOTkabbHORt13T9jJhcKrfsnKVkIlzETW4gCz49Av?=
 =?us-ascii?Q?DguXjaz50wyh1gtOe8J88Dxwx1Fx2IDbhKl6GHZM5fLLptY86OzI9XtuewQq?=
 =?us-ascii?Q?y0qYjnFxgKqXP51jLYvvQw81yJe+wTXaAdLeyBFH+lpH/Mb8J4k1KrOZ2rpn?=
 =?us-ascii?Q?GXpsq1xpAtNGJ3p44LfCNA5YmoHfL2bqTko0LhCL/8vH/5beVpV8JTW3l1j2?=
 =?us-ascii?Q?/S5zF8VgvZgVs0xA4j5iMeJ+s3FBexqRbnVeA+2k1m+9jTVX8UhdrWA1pw1r?=
 =?us-ascii?Q?q8s7qdtTlaXmDC9CrWnkU9vsMnO7AejCGcwua3YVH+29gJb2LKFzbGTez/sP?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8SsQhm1nv49V9sQnPlN+LREHFFU8o8z/o0C8AWco7nGO5Ndqu3LHVyR+gaRx?=
 =?us-ascii?Q?omOCH38aqbqhxCiqPaRqGR2t7MbGmvKE+anhUUUcZgyF8N8/MHUtnMOoFORp?=
 =?us-ascii?Q?XkLWx/iZwwB9dZkkk9/xJ7Nj0vY/vWw23secpAScER42/b3Metu5B5TfAlK/?=
 =?us-ascii?Q?tdBSXF6EBuhgAZGCYWDyYRNcjHvkfx+EBV394+ku2gnbKAe9uk9Vt2s1rQ4w?=
 =?us-ascii?Q?5LTDfUansYL7SpaKybxFQHxW74vpzdSPHN7tyxuZ9cedMu/LvvwrC82LdeOp?=
 =?us-ascii?Q?lo9LLfaRFUkLVtXoNVlMRSD0Em326BQee8jqctydGSkWqBqbJHfLkssUyQMn?=
 =?us-ascii?Q?GyR3QqhDqoDgQMoycdqnm393V1VFglDyoKZn93AZZtuE51mrSHXiOjfw4anl?=
 =?us-ascii?Q?2vKbxS5sp5RHea3Dp76OawUmE1CuBDdP4jIFnvWA5Rd2syz0HP9i65+iKhUH?=
 =?us-ascii?Q?aB00wLHaFBwpV9FTMH6x7bTYWhD/s027io/qvBsNarjbTPOJUefrnv7z7Rzz?=
 =?us-ascii?Q?61TmSjffwIa/4tpbNefyWfYFCKauLcgWT+uUGV5PTsZ8XwrkAr5edMkiFkOD?=
 =?us-ascii?Q?aPo9PQOw+sbdO6d+ICndzxyMocuizkBOQdXcWEhoTrmLVsDtyOIQMbRgY0/N?=
 =?us-ascii?Q?fBb1V5kqK68N2DitnUlVUutqBbFq7L9L9TRg0Rtn5Z4ZzQW3vvtds/Dy6dFY?=
 =?us-ascii?Q?TMrZ4yxATMAcbafDYXLq+QIuErtAzocMQfGBbUGe7wOtaMD7BHmKUZYhc6QY?=
 =?us-ascii?Q?g4/6xpYZWvq/WZStZ1R+u/OCSCGvuuos6wQbbi+G0FVii0ZhdanaSdALCxNH?=
 =?us-ascii?Q?FMgdXE/YTtCDR3/I1SE2DBjOFFiQEKm1u+VMpuP9Hyj0+NoC0UdTQJOv1rkv?=
 =?us-ascii?Q?ywBQYi9Et7P3VIPVMj8EvQJYV+mY5oBKU6C/Sgcs2iOrF5MRq+6nPcm8rUsO?=
 =?us-ascii?Q?yViGFEuz1NrmeUq88zKONbikFNp4w/1gZEOAWZlUqT62O4PuSSZkQZHoeCvc?=
 =?us-ascii?Q?6yNViR3agnRLsY6JZZ6eewL6XYwIM4EEsFe6y0y3cmPKUAHcFa3/OJ/Bug0S?=
 =?us-ascii?Q?dVQChPAXYXHmX2H8lYTfmLnjhv4N/3Zi43CkBkEeMYoPqlXyVn2I+BOxYNmw?=
 =?us-ascii?Q?FU8ch/T9UJZX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820338f7-0ccf-4750-a958-08dbbe21f90a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:48:52.5806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIMIYvSVa4LeS0S9p062SgMARxb9CmTLz4qHvMABUFpMtpmTfQOWZp0mJK6FHawykIwI+y289oAIRnwb6F84MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250185
X-Proofpoint-GUID: lhidaK-TB0svHxNh-hlo_QnCpCSAIlyN
X-Proofpoint-ORIG-GUID: lhidaK-TB0svHxNh-hlo_QnCpCSAIlyN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding hugetlb pages to the pool, we first create a list of the
allocated pages before adding to the pool.  Pass this list of pages to a
new routine hugetlb_vmemmap_optimize_folios() for vmemmap optimization.

Due to significant differences in vmemmmap initialization for bootmem
allocated hugetlb pages, a new routine prep_and_add_bootmem_folios
is created.

We also modify the routine vmemmap_should_optimize() to check for pages
that are already optimized.  There are code paths that might request
vmemmap optimization twice and we want to make sure this is not
attempted.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         | 42 ++++++++++++++++++++++++++++++++++--------
 mm/hugetlb_vmemmap.c | 11 +++++++++++
 mm/hugetlb_vmemmap.h |  5 +++++
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 64f50f3844fc..da0ebd370b5f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2269,6 +2269,9 @@ static void prep_and_add_allocated_folios(struct hstate *h,
 {
 	struct folio *folio, *tmp_f;
 
+	/* Send list for bulk vmemmap optimization processing */
+	hugetlb_vmemmap_optimize_folios(h, folio_list);
+
 	/* Add all new pool pages to free lists in one lock cycle */
 	spin_lock_irq(&hugetlb_lock);
 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
@@ -3305,6 +3308,34 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 	prep_compound_head((struct page *)folio, huge_page_order(h));
 }
 
+static void __init prep_and_add_bootmem_folios(struct hstate *h,
+					struct list_head *folio_list)
+{
+	struct folio *folio, *tmp_f;
+
+	/* Send list for bulk vmemmap optimization processing */
+	hugetlb_vmemmap_optimize_folios(h, folio_list);
+
+	/* Add all new pool pages to free lists in one lock cycle */
+	spin_lock_irq(&hugetlb_lock);
+	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
+		if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
+			/*
+			 * If HVO fails, initialize all tail struct pages
+			 * We do not worry about potential long lock hold
+			 * time as this is early in boot and there should
+			 * be no contention.
+			 */
+			hugetlb_folio_init_tail_vmemmap(folio,
+					HUGETLB_VMEMMAP_RESERVE_PAGES,
+					pages_per_huge_page(h));
+		}
+		__prep_account_new_huge_page(h, folio_nid(folio));
+		enqueue_hugetlb_folio(h, folio);
+	}
+	spin_unlock_irq(&hugetlb_lock);
+}
+
 /*
  * Put bootmem huge pages into the standard lists after mem_map is up.
  * Note: This only applies to gigantic (order > MAX_ORDER) pages.
@@ -3325,7 +3356,7 @@ static void __init gather_bootmem_prealloc(void)
 		 * in this list.  If so, process each size separately.
 		 */
 		if (h != prev_h && prev_h != NULL)
-			prep_and_add_allocated_folios(prev_h, &folio_list);
+			prep_and_add_bootmem_folios(prev_h, &folio_list);
 		prev_h = h;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
@@ -3333,12 +3364,7 @@ static void __init gather_bootmem_prealloc(void)
 
 		hugetlb_folio_init_vmemmap(folio, h,
 					   HUGETLB_VMEMMAP_RESERVE_PAGES);
-		__prep_new_hugetlb_folio(h, folio);
-		/* If HVO fails, initialize all tail struct pages */
-		if (!HPageVmemmapOptimized(&folio->page))
-			hugetlb_folio_init_tail_vmemmap(folio,
-						HUGETLB_VMEMMAP_RESERVE_PAGES,
-						pages_per_huge_page(h));
+		init_new_hugetlb_folio(h, folio);
 		list_add(&folio->lru, &folio_list);
 
 		/*
@@ -3350,7 +3376,7 @@ static void __init gather_bootmem_prealloc(void)
 		cond_resched();
 	}
 
-	prep_and_add_allocated_folios(h, &folio_list);
+	prep_and_add_bootmem_folios(h, &folio_list);
 }
 
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 76682d1d79a7..4558b814ffab 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -483,6 +483,9 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
 static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
+	if (HPageVmemmapOptimized((struct page *)head))
+		return false;
+
 	if (!READ_ONCE(vmemmap_optimize_enabled))
 		return false;
 
@@ -572,6 +575,14 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 		SetHPageVmemmapOptimized(head);
 }
 
+void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
+{
+	struct folio *folio;
+
+	list_for_each_entry(folio, folio_list, lru)
+		hugetlb_vmemmap_optimize(h, &folio->page);
+}
+
 static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 	{
 		.procname	= "hugetlb_optimize_vmemmap",
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 4573899855d7..c512e388dbb4 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -20,6 +20,7 @@
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
+void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
 {
@@ -48,6 +49,10 @@ static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page
 {
 }
 
+static inline void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
+{
+}
+
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
 	return 0;
-- 
2.41.0

