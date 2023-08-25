Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA3F788F26
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjHYTG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjHYTGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:06:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8399F2690
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:06:00 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIESZ0031124;
        Fri, 25 Aug 2023 19:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0ahRRIn0ZNn8lfsDqjwet4c+B7wLB9LxrxIa3Q88Osc=;
 b=bWEj0ckdoCz9QYuzTiKhsyrwYkxPiRSZKmSCHTi+WDNv5P08bLhaNoeXFnR8oGQPVGjC
 Th43vBH5n+6Cmej3jr2Em274tWau3cMeFolIULCUo7V/EbrIH/lY/GAKIEzcprJNRU7B
 0QhOkS1PUxwsCQ+s2ECIYLNvbiCDR0bjpCirh0eBo9QPpBBTQuVGCSghoNDWQNO5lVmq
 y2BT9DEFKRxeyMom9I19z7ecyQPPZd5I3aiUMV7h09QbBfvjMuVpb//+O/yo0+1gEKwP
 VBum4OnalPNBmB73AMpJdzFfu39gP458rJxkQpunG8AsOctY7gdXpRmwrpXiyd5QkVHj 9Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20cq0e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PINm4A036073;
        Fri, 25 Aug 2023 19:05:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yxqsmg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcn6NGYkcVYZpeKZjTGReRDxBUoRAXWqkxWZMQf6EmwXrs53KjnINPbuiuSJUH8AEZcEjpjbDnN5ICRu7OVei6MLoBs1bSjtWPdHKAZpcugfXIMw/tJ1I5GMKjA33YjRrOR5KPV+0XZHgWH94zlKuLHCWRBxlZogF3L/wv175wZo+XYR+I1iTsNVpj9nTFRPis1YYkbCLyP/HGB+aCSVY42fP0gk1KjpLRp69VCK6gRaU+LG8w0rzfHkW5U6p+HeeYTiiIxbGtvj5opSt1Y3yd+S0QJW9isqJUQ0EjK1MLhk2jNINg9XkD0KC24dYqUm2lo+vX26wAi0+I3cl0eXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ahRRIn0ZNn8lfsDqjwet4c+B7wLB9LxrxIa3Q88Osc=;
 b=gwKLHoQTXle6UGGbWPTFAN1uzJECRXyO9A54NsSPw9kk77ZUJaai2wEhXmmnJB35YwLRhbitFofkniTcERBmuyPUy/NQTrHrXzvIE8Wub0im9DtKfDuDChfpa01qqiu9OHaAb2celMPAEjnUeRT5/U3pQqFSi9erani0iYf0y1EGKNyHTS0kpT5avt9MLPuSip4pReHBZiPG75ww5eleExjBn+5ZTBy4WVoPFGoj2WKWaJEmlWIjW/yP3Zyn1UqZMQ09yMHNgX0AA4QLilFUzuScn11W//6geuKuWeE8xrun1xC9s79bPbJskLSsPADQqH37j3gY2cu9/iQkkgjzxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ahRRIn0ZNn8lfsDqjwet4c+B7wLB9LxrxIa3Q88Osc=;
 b=Ryzbc2cmjPfEqj1AbgMeVVvNOga7q7UjZerj0WKU+0OBq0Klr6U8eW9f2DRqQbAr+D6APIKBdcj5HPho7muw2yNMH6/7awft6U5Gi5B9uQ3GLRWZZ7lLQR9MCnuTveiSVHosC6cgkkw0wNg3KXu1lys7xYW9twU4wjv8bj7I2Sw=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by PH7PR10MB6580.namprd10.prod.outlook.com (2603:10b6:510:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:05:16 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a%4]) with mapi id 15.20.6699.022; Fri, 25 Aug 2023
 19:05:16 +0000
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
Subject: [PATCH 09/12] hugetlb_vmemmap: Optimistically set Optimized flag
Date:   Fri, 25 Aug 2023 12:04:29 -0700
Message-ID: <20230825190436.55045-10-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825190436.55045-1-mike.kravetz@oracle.com>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:303:b7::15) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|PH7PR10MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: abedd79b-f5f6-4695-4fc5-08dba59e3785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MAh1hHtCXEfiHswV0+4QMFeu7TMqA/19oyNn6ihMXY8ghVo8ZirDBie4BJ2ywESa4c1KaVct4cog5qWZ2sHtBLmhGD56cfC7At01ATEFtCWLHYWvINeVHIVLVe4T5HBeeIR7qRo6XgIUPHUJ2EnrGmTl4aTRljVlJLNOUTz0byfBEnF3gBJkuEkiv0D+73GbXJaZFXTCXtD5HeAlbIKIZiWYu5LtmRXMdC4BvV56yhHHxTHTXvnf6IIPXrHrKbSRZ81NA+xj2wjLeoGaCv/ovmVeCTRRAKYlyrHV1LikT9wbAR56O15o9vUhYwgHtBHXtCxB34jghBsz0I1ayhXcSbZbACiWUIUUcXFgrews5EATKbHSMAEqtMsf0x/TWtJQfdlx40YDPNxBxKzhWyOQbMORb6/RQQG9rjY0Xn8EXyqz/5YJ1BJOU8r+oXyH38WWJwTVQHj2xZ3c9mtGNZH5j+iHF7pNuix+/b661w26m5va1tUVIBYLb6s1k+L++T9ejycbrM2nOE5uujIoMxkvQuDhVxBkKZTORCLzYPkcJsA05VMb6TOZDEjonTxxasPL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199024)(186009)(1800799009)(66946007)(54906003)(66556008)(66476007)(316002)(478600001)(26005)(44832011)(6666004)(38100700002)(41300700001)(86362001)(6486002)(6512007)(6506007)(2906002)(4326008)(8676002)(8936002)(1076003)(2616005)(107886003)(5660300002)(7416002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?keS5tgsj+yVcQgguZwbppEJXgXrGrv7II7O3LKR/Ul7jgok9W6lAvPshLHmN?=
 =?us-ascii?Q?HVN1CgeUrlN62LxhoLJpFH1qXaRDbV7owVxXnjpsi3sNNjP5yF3LS/D3TUux?=
 =?us-ascii?Q?UmoXcnjRb82Oqu3tQvIFhkczhdAqesIeqJAxaa9aibzJRtcL5CTapOo5ipWh?=
 =?us-ascii?Q?jVjqxJMWYD6ukkjOLu11hAicWB331q3Xb6r3eVat6u4ToxN6gIhBs2aXM48w?=
 =?us-ascii?Q?VyHPKgdhDt+FUbdUOkjuQ+TLccA5QzQPl6/eYhnsQvTHu0U9ikxF15P7NxyY?=
 =?us-ascii?Q?u+2jOvVjI07/kAdEuOSjxJF77dsjfpH+gZmcNpz5LdkANqfjvWCVHFo+bQmy?=
 =?us-ascii?Q?VD2gIU8Cg6XY5kFGAqAUMpfJEOaNFp2CBTMOPvVsYKqeXt1o+ZPzcz4j+z3k?=
 =?us-ascii?Q?fDHS6LWNx2IEMEw9K7Vv2U4rvGQrsqZL1rmBbOq5YQyeMk9x30QZ16T9itDb?=
 =?us-ascii?Q?geoDbeMhGSMF7GXm+5D16MuMzRUkGo0pT9DCJQkOxKO2CkTLt1pKGujihzxb?=
 =?us-ascii?Q?2eY3yOdQczvoXROR14UgGon4hVnr1HHyFNzXZWBpYwibNKvSf6AqyfBN/jxW?=
 =?us-ascii?Q?VLtCqQwC5ofM/hced/m/WAsYAEHqV/DqeP34tXYg6SIPj5ASuQg+xRdunrGf?=
 =?us-ascii?Q?0Pvw+XGfPOJYi5XKQNLjQeU6+5nrV5BrMyGMd5Fs8OlErbO/iuRiO6GmWR+t?=
 =?us-ascii?Q?M6blwPq1IG7bSFN78tZQiUdHBiPkgxfkIVMoUIFqkwrAmKwEKKc4TiJAcXVN?=
 =?us-ascii?Q?ynf2KmJU2H79s95/9pweAA3StJvVq8HEfHw3Z9O4pdH4YQregZESoId7ccz2?=
 =?us-ascii?Q?/UjW2ZYy9HrrpFRd8EtcMZXtpb5OxKWxLKgn5Nq6+HcTMZB0VvwjjC5jfJ9g?=
 =?us-ascii?Q?l+5avBTc+LGJY5Yum1GXZgMOHrk5t5Oqa7CLjpjLRW0NK1Y2jSgs3Wr8PD1c?=
 =?us-ascii?Q?bniqeOBzqvXjlqDGo8Xe377K10BWPgdkTwptcb1+yVQ9Aw0CXai1F2w/850i?=
 =?us-ascii?Q?NopxTlvB7CnPeZO/jZta9Ns+s2G+0ves3PtF3C8FuHofK3VgSrjs3LVRUojZ?=
 =?us-ascii?Q?UFP6tz3XdbpknNlKgvRkTkREPD6DsGc5aiWWcti0dGR+i8O3zseVC1L02Il7?=
 =?us-ascii?Q?91KOIsgfuhli3lxZpX1Qw0L6N+UyX8OD+NgFoRmXzINPxzx7ibgov4m9DaOI?=
 =?us-ascii?Q?ojbOPt77a42V/1oTPfE4rvtMURUPdeDxMBTTqgGcbgn9vFuoqoV5HTDyYiJW?=
 =?us-ascii?Q?h3SsKIRcG9eBiAq5AE25Ye52Lsm/3CJp3xSYJXa78nI3uk1koQ3tQnsLk4bM?=
 =?us-ascii?Q?0InDBDEjIiIDb5WZxebnFpCcIvsLrTfmsLpBABMGOpJSax8dX2m8us5kv4Pu?=
 =?us-ascii?Q?MxHkoNjXkG77OP8t5whuOa0HgDrCSteLkX/A8CNgz7GO6VIIHXLFOmaLnGur?=
 =?us-ascii?Q?o6VUePHbaY5/+hz8nu51xdd90AAgOmNdIJuUxTPFvYyLDxdaAoZ2kTKvGR34?=
 =?us-ascii?Q?785ZOZX83nOzYK7cZ9E/OBzLy4J8CH916onCskK1hUlYrgdESBRd31tPBXTy?=
 =?us-ascii?Q?UnTKV8m/x7s9ZAdbeZll5tqnzuXgLd6AUCevT6+EopYqUOdLyZlhlocC15IU?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EQogqAEtPqEPm1I6NwYwTlnZY/r0cinLfqoD1Ul2d5RDByWzbPJ2z7SyjhwD?=
 =?us-ascii?Q?JqGDQVBczusYTbWXU/DU8DxCV+fOPk848vyu+B+kZpRwUfJ4wz8Sa7Wn2rMy?=
 =?us-ascii?Q?pJEf1PRsYjmt6djK2n1QLoDJ1opfRNes0cfmJ/cFZK1UVlFqcWbQ8rK8wivg?=
 =?us-ascii?Q?cwSflqg5TeCNjwofFz/UNU8vLh6OHqVPA3a+sB/YnU1nlhXSdxT8NB/Mra2v?=
 =?us-ascii?Q?oZ50lNrHk2PHALTkNEwxNINtpqHPWEninTUAOSHiEQxQfMI/RPFsNUlMMwy0?=
 =?us-ascii?Q?rM1rM76uPEhEuItWGVjOidbVdsrf609dh0sfgE15/EeUvDHy7Od7IStOC8vv?=
 =?us-ascii?Q?B7GEFvBBxaoRkgS7iWoaTuUx9AqkQBHCGRuRcLq8rd39zDX+K+suAA0n3izV?=
 =?us-ascii?Q?FS3SzeRpxWs3kndSas7HlVCl54RkpWV2Ysu/+YhpXGtBMOJtdGKDae5NuGcn?=
 =?us-ascii?Q?RFPYzxJRi2X71UZf1nU8d4IonkSSJINcMG1775Z/xWNEmqNVwR7AI/91sBMz?=
 =?us-ascii?Q?25DNjDTQlO7sdoWWDstsC03cUEGrAxPxgABQkZLCbylVqROvoPo3mUmOkehO?=
 =?us-ascii?Q?omO5tborDX6i3x5lbBMc5//IV0+HdC+0j8WYfCn2F8nJKcNRBimBeDWptSIL?=
 =?us-ascii?Q?3nzm+RBkERfiPGtl5Rq4Q9V3pxmvPSqo4WI5RYp5UtUhrJdoSWIQtMM+hje5?=
 =?us-ascii?Q?3btVCq6dmOMjivOL7Vl8dOc7QI5DkXX2EtdORO9c7pD8JjWJyP3C1taFoGPP?=
 =?us-ascii?Q?fKpyzCjj7BcWYw0J2sdoE8wAJBDwG1OEnbXaSkg7a9uP9nMTx5aQjTEJoFBS?=
 =?us-ascii?Q?WH/xDKufFsAQub5lm7WWxT3Q0tuuL1V+jQThoc19hvZ9dx8Rb1o14nUdwNdL?=
 =?us-ascii?Q?EQFpzu8TDYWeGcv5beY4f9viAvd9TOZTe9zDe50zUxau89J62TVwdKdLSkzx?=
 =?us-ascii?Q?7+dm9WESFaKy1jvVOYLEbEsPDywmof2gIQj1YJ7k+mpyhwNhlOZiiw/0aAsQ?=
 =?us-ascii?Q?EnPlfo2u6oWjeXBhORQH5bFjoSNVq0UbLixfHRGMou8X79zQOMFqaJjR9jDh?=
 =?us-ascii?Q?ay45tyYIwjH93pzgtLld/uoa7r+/nGbrbGkdWL0vBRsr0Ap0VPYHpbGSWVyA?=
 =?us-ascii?Q?osTOtBu5fW8o?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abedd79b-f5f6-4695-4fc5-08dba59e3785
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:05:15.9920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yiVlx8AVcL/crN6CQLHEuuXU578cJnz5XmyNZCXeAtewUYg0erIie81AWy0fSOL2jDY0T3ZDNGaWSV0hYjus4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_17,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250171
X-Proofpoint-ORIG-GUID: _6aczlNKQatDKqsWD-YfwE6U4edUiDxf
X-Proofpoint-GUID: _6aczlNKQatDKqsWD-YfwE6U4edUiDxf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the beginning of hugetlb_vmemmap_optimize, optimistically set
the HPageVmemmapOptimized flag in the head page.  Clear the flag
if the operation fails.

No change in behavior.  However, this will become important in
subsequent patches where we batch delay TLB flushing.  We need to
make sure the content in the old and new vmemmap pages are the same.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index e390170c0887..500a118915ff 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -566,7 +566,9 @@ static void __hugetlb_vmemmap_optimize(const struct hstate *h,
 	if (!vmemmap_should_optimize(h, head))
 		return;
 
+	/* Optimistically assume success */
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
+	SetHPageVmemmapOptimized(head);
 
 	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
 	vmemmap_reuse	= vmemmap_start;
@@ -577,10 +579,10 @@ static void __hugetlb_vmemmap_optimize(const struct hstate *h,
 	 * to the page which @vmemmap_reuse is mapped to, then free the pages
 	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
 	 */
-	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, bulk_pages))
+	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, bulk_pages)) {
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
-	else
-		SetHPageVmemmapOptimized(head);
+		ClearHPageVmemmapOptimized(head);
+	}
 }
 
 /**
-- 
2.41.0

