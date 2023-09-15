Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924C47A2A5D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbjIOWRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbjIOWQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:16:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE0591
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:16:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLuFa1023039;
        Fri, 15 Sep 2023 22:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=HDEIvt03Ie6K7+bZ4EHI6Dnv/+9YtZuhxJ2Q9zE/vFs=;
 b=bKdst1ZOMgWBe5TzpcmNeLwSbJgSVWFJbtMFcc0Q18tl4mVixxtUmvxO1yLjV+bamHqM
 n4Ah0xDFdG3WSWTpKdEEs+e0z7aJmVv1lcYUkX8qfWChfTV5HB1VplumjMx56TWx4O7F
 6RpfyM1umSM1Wjx8aGtxzDQKYupF6LbIUxb6veajr85+iaAaRtbjh1uWWUOaZFHF0OCG
 vPE8RMRGB2gYUqSYK3PMVPvxsLxgzSk6nQwit4fsQvuGdnyCw2uBBLw108qN2cawntWr
 f2YpvcPgt8j4vA7029Q+nKA3DC/mPOTM7rGgA1L2raVn+oZ83V8mLIESfVy3rmdOgmAy DA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7n0k48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:15:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLQxuf036173;
        Fri, 15 Sep 2023 22:15:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5gx8s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:15:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cb0xQeuTdDBk9XJ2YSkBw2RS5aUKOdDU6X9Ej7egnaNo8lr/1upsTh+MFAkRCuRz8e4bbKdyuQhJCJ5iY05Rt3lL64BU0npxPk4zFEB4Ts8F0V6aJWeHGMV75ARtVo+Fq0UO3KOsMkblRVpQx5z/GhYlLlth6tbF+SFUgAw2wIZkHkVtIKmZ61ROSjuFwwEjJ26kKPDEePHxms0T207v88OdR7QU3GT8HtgBkv3Dzudyh/p26+oqxtAkePscPCCeT4akRQPdA+1KIF7L28+kJu5EFz/9oWuDBPN5MHq1jpNUiNaVQoAj7HCz/pVVd8GB1BD5x95wp0337C8c2pQBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDEIvt03Ie6K7+bZ4EHI6Dnv/+9YtZuhxJ2Q9zE/vFs=;
 b=Wg7KXq0a0p4k4PJXrR88sHDOjyscVqKfzSugUNYHYKbMaFzCi4SyKsCxPKLtXMRuEymtIhbN2WvBvjPUUnALfxiWSPh3osJJd/ReBIe8h57cmpS8kgBuR96kcQoHHxRdOY5ZZMoMTKm3fXnBjLPzUs7bljXf06zQB46W7vbJWrJH58RDGt7YHunwtcDiAwm5mGPyvx90Ways6fKqwnQkgoE1XLuGvCJPNPaY7zoLE2Qp7kF4FhlmAnxVKBlH9d/qvRa8X9wqDHX/u5VPvJgrfLXB2tErFNTqiemmecT7hDJs4VN1xTgvL6hYUvaV/8KIa2bBbVVfteaVFDkn1/uEAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDEIvt03Ie6K7+bZ4EHI6Dnv/+9YtZuhxJ2Q9zE/vFs=;
 b=JQ9xccCDZInfaQWwK98vt52yFPXcqvFdlaTqSz1JvDykCvasJYH4/scpe9izWjrDSzlquKrnnGKHoXbohXnyfIYmvKltTrxtXT2jXLgGYC/qzsprqXw6/nY7glm7B7138yKDBliH6qSz+FhpEDhWXb4HHggFiWaANoaU39P+jng=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 22:15:55 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 22:15:55 +0000
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 01/12] mm: page_alloc: remove pcppage migratetype caching fix
Date:   Fri, 15 Sep 2023 15:15:34 -0700
Message-ID: <20230915221548.552084-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915221548.552084-1-mike.kravetz@oracle.com>
References: <20230915221548.552084-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:303:dc::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: b043899b-d920-4566-d9a0-08dbb63954c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ctxyRL+zTQRoubd+1QYu+DyYlW/CkQQU7g3iPS3IDGul9cdBjC8ZfhQhFlmdIbIDHxk8P3LjuptiNOQAymt5NnkXwYNQ9NCfGasOEm7xfrR5hgh2jBZ56vbigUmuVkyZzJWyrBUXXpVAEn5e7jSHRT7IgxTbEFeUNtlAnPPw/1hVZ3lk+uHGoSdhUrLSOuwNezvHZi2x4ipcncIHRdYZtq85tuV9SnnzyiujcBDYvhCYaisCbdgVJpa+mLkDgMneJ/IiewfTghuDGlhYjl1gobDDD8IS7ibw/EUYaOjDRbcuShWRx3wqEDiDrk0BYMUZSuhz5iq8n9v5xEuzXVXXKKVphQ2TEvr0x2YV9xiMZSsKihDVXhMGv0Ob8ckaiYMNUvK+/LGGAJgfN/iRqPRcTYbxzKOMbBGisJkzpJURA0Si2f4812RKHFGRc7K5u3Od4c8X7u4YL48YP3WOy4zzhEAF9T96M93ftGxyFLjzP0TaJL8hLB8QWSL1SSNLOKaRmbpCplYN2oL2OQWp7CyJEXBxCgH6VfzuPUJnsl//hZSqApqFKGyBicQc9Lt83Wtv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199024)(186009)(1800799009)(44832011)(86362001)(36756003)(83380400001)(2906002)(38100700002)(478600001)(1076003)(2616005)(26005)(107886003)(4326008)(6512007)(41300700001)(5660300002)(6506007)(6486002)(8676002)(6666004)(66556008)(316002)(66946007)(8936002)(7416002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?efnAExhU5yLvkr7Toxfeg/Jez9lXg3a7N9jorR9Tro5NgHLdIMAm1Ygh5u7X?=
 =?us-ascii?Q?ianZOr+TxSKx+i6pVaNsqRYsJgHxJi5zp7wiuEQONLPTnbnbPdniYSza3bzI?=
 =?us-ascii?Q?BSTjPBZtJIfK14AdF959hIz2SI8XCL1SDCmKd0cTbSBNyhQoRHkRX4LMF+D5?=
 =?us-ascii?Q?yt3GU21+mas8BtYaVhFvUZlZSM05YqQ9SWS0xE/SQEbo4JMvsVb7tLz6w711?=
 =?us-ascii?Q?hDn74hpxMI+QaUanGwWm58Hm0ckv/7MMXO5nTKFIR8W1PFXuQpOXDIzJldDT?=
 =?us-ascii?Q?/lKXxb67BhEv60baIf8iiQSyfTrdAVpu/bROxV4/1/GavYuG6MT94bSPwYbj?=
 =?us-ascii?Q?zoVsWh+iUOEIIfOQWvGoMrD3WQd0a5GqxnBur52GZZrlNnr82Kr7Epg6f2lI?=
 =?us-ascii?Q?MbbvVySXBFktRFtJiBf42HvHFm0IcD0aiXqH9z9k8R0rLz/vnvFnxUvU3pNC?=
 =?us-ascii?Q?PCgH61EGIjpHYbk12EDKGVgVFIC/soMaHbm+w5hqGf60lHUlUtZkZ0QDQV2h?=
 =?us-ascii?Q?Ij8kKUCWdVMrDwVqXMpQVlWr1FYBxoDnEhFN1C9WQgXZk7aLzX/6qVs1U8Br?=
 =?us-ascii?Q?Xt87tp+tO7m6OuwmD5HK9mWiIsjXLCIjshH5OY/grhqMomwKmxqSLnNPGPBW?=
 =?us-ascii?Q?yPyMeEsH4LnKsEClKWsf0yEirPLP8gMsSMVrbS794eJ1+vo8/pEd4lXf2ogA?=
 =?us-ascii?Q?0QV2Qm1aQppefyLGlw+dk6wvNhFVR5cBulRjybMvnvk5Fl59I9WekJjJqUqi?=
 =?us-ascii?Q?qhkTswXATu7Bop9LX1offVm5lJFQkt0gLdnRK2Lb2d0ilbQFL9c/H87rRYvH?=
 =?us-ascii?Q?563qM5o3DEAGubC5K6pdwGXmuvayPLG4/2cPsjcd0FTp8qo+dNEXpjnk+b58?=
 =?us-ascii?Q?UtvWJrSduNdb9Phn5rqNzPtEVgqrVJnhT/5vvN5ybmAhKKhXM8MpPDVWVC4U?=
 =?us-ascii?Q?hUwF1mZxmZghQO8pHYV0qrqAm3zXdTHUQBaSpGwZxKr0+FOdSim6YbJ3npUg?=
 =?us-ascii?Q?VFgCXgHNbNq7zNKM6fupBCtYpbzp88pYnmGkpUrrAhnwexZC/mR1vB8ENaGr?=
 =?us-ascii?Q?v6SyDg9KBOP09xjyX4OutE/kYL7gAmz+DVDuuTF/agNnf5L4vTrbLLe4o2te?=
 =?us-ascii?Q?QIugzzyIFJYWdW/YxOTXF3VOvNIasUQiGdBaLcBWq7GAWTMAlt0tSzOclSbS?=
 =?us-ascii?Q?w/ErjkslYLqOo6j5Im5InZ2dSJxs5vjjq82SbWPzF7RjuLCpc8sgzQm+c9xC?=
 =?us-ascii?Q?UTATwDwCirQT1IX0l/0+XLiCrv8xcus032krk21gAWJ9TPZXpPOJMbOUu5af?=
 =?us-ascii?Q?BrLYrq9Dpv8ZaXs3vQ8cSPUnz/fJmL8aZTgy4ZR71iNYK1IWqcFHoOwNZHlI?=
 =?us-ascii?Q?GpTvT2+5Wy78L7lRk8Dh09uA8ehh3zo0PV6Hy4qlJQ2kU+vSzL1XbDMsZhTQ?=
 =?us-ascii?Q?u/vlZ301VMAaaeuHCbmv5TM9Olu1+MprsfbwrU+zoSheFzsKaBQAYLC79Hrj?=
 =?us-ascii?Q?VhxTXulVoOQP4EKNfwBfMvxLJF69ysxbDatDp6ck/7w0TlUCIGwQxzPFOc2W?=
 =?us-ascii?Q?LmfeJgTi0JgdR0yQSvDrkpMNw33C3MeQkENyusbGwIxOuDThttrfOeFQWGqT?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tuxkzUNt7i2jfVKEd3L+lScLztyIvhGcnbdS4loeZ4KDSjsjfN9F01iDrjVp?=
 =?us-ascii?Q?vBNyUskCtnEmnHt7toNna4f6yOzTDvQlEh4YS4tt9f6NUMH1hzS1XI1NmpIJ?=
 =?us-ascii?Q?XlPJv1LEhK7VubQMLVqXgZXYTFbXxu+kBZbZSA0bpiwgcj/3+wEXB0xOzIW+?=
 =?us-ascii?Q?rJkGXaIifHiK+8p/gnjEv/ixorKIRW3tiOo8xrjILS8C5Ig5tTq9fOZT6jAk?=
 =?us-ascii?Q?O52cO/XS+l5kqDMBFlMjchZcb40bWypiW4ycDxnmyBWh9e70e7Axgd12L5rV?=
 =?us-ascii?Q?9aIKMOPejiTvajXzlc1iX2Yb4yowEA2XSv3xtbx4QOOYoVCbqau31gvdOxSM?=
 =?us-ascii?Q?Ly7x/isXPsWOqgCN7xjhDAwl+R3TxJdPWj9xM7bfVGRsRSNn3x8f4CzLU63e?=
 =?us-ascii?Q?McGTzhCE8kUedwhoe0KZUX7tWggg8ISzFQ2BXSxGpZDSwb92HevQ8h7zbXfe?=
 =?us-ascii?Q?0nuswjxtpST6naYQwXVhNOLs+jlrAqpPJndE5hnv211WoSx1a6CPRKj9XZMw?=
 =?us-ascii?Q?ITrLWLU+rWTetJnIOWbC0bMscEABpTAPXlGkDBD0dBoeYbQ+kq5vCTz2J0qt?=
 =?us-ascii?Q?STzYwPoBMb8O4AJ2+BzI3/8sPHtFyrM/G3IkmQi1Lx4eOAsOeuAXjbK0NQTO?=
 =?us-ascii?Q?wM7SQPnaq8RUmrsRXblW9n1FntK55VTYkrI3MeG8p223RvLDOTZmimjM6dZq?=
 =?us-ascii?Q?9afnP1N4I16kJMM99u+9QuBs14SEM2Sow+cOe8ls2kWNj53IlIsj9I9jzU6X?=
 =?us-ascii?Q?vRleE2lBzUwbW/qYbMpZHn10KWAvDTbT2fGE7QoZARWkvJohoY+Tmwr2Vhm6?=
 =?us-ascii?Q?T855rCd0P98+6BgNbGteM0aTi5mTwqMSQuZssvlv5h0m+oIYA6oVrCAvpXSd?=
 =?us-ascii?Q?LhFLPwmOXZBYL65lhFdyp2rvbGdDmvwDBybHr5/0MF1/otKhkpxBBojuooyo?=
 =?us-ascii?Q?w5n8jiGKzF2g0kEmCuHQxaBqnX+Q9QqLUrRJo5tTEgKoBdqZMQfi8e08pgeY?=
 =?us-ascii?Q?uVKsZ0i9sW4MK7NbwMeXL7HchwFliPz0GjPOBd0pEFahQGuEc0yLAKAetMzi?=
 =?us-ascii?Q?k+zJGlM8WbCn+S902T0xdwfM4NyX+bzCz08Tfy4vubVZ8rw2RpdXKebw9u3V?=
 =?us-ascii?Q?Ft8b/BpzQAQVvMfuMaDN+YnfMsQq7+i5JFMpmOUPDh2CCL74BbSnjFY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b043899b-d920-4566-d9a0-08dbb63954c2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:15:55.6285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1CSj4+bjK6mmX3L7dVLmWPKCF5algYrOO7qWZbzRVTZMTuxotYwCdHLE86vYBedcE4ulT0WsxbI1DzARs+vzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_19,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150200
X-Proofpoint-ORIG-GUID: GLjFc5f5vEtIIjGI424KWEp8jFgJuIk2
X-Proofpoint-GUID: GLjFc5f5vEtIIjGI424KWEp8jFgJuIk2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

Mike reports the following crash in -next:

[   28.643019] page:ffffea0004fb4280 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13ed0a
[   28.645455] flags: 0x200000000000000(node=0|zone=2)
[   28.646835] page_type: 0xffffffff()
[   28.647886] raw: 0200000000000000 dead000000000100 dead000000000122 0000000000000000
[   28.651170] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   28.653124] page dumped because: VM_BUG_ON_PAGE(is_migrate_isolate(mt))
[   28.654769] ------------[ cut here ]------------
[   28.655972] kernel BUG at mm/page_alloc.c:1231!

This VM_BUG_ON() used to check that the cached pcppage_migratetype set
by free_unref_page() wasn't MIGRATE_ISOLATE.

When I removed the caching, I erroneously changed the assert to check
that no isolated pages are on the pcplist. This is quite different,
because pages can be isolated *after* they had been put on the
freelist already (which is handled just fine).

IOW, this was purely a sanity check on the migratetype caching. With
that gone, the check should have been removed as well. Do that now.

Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 123494dbd731..1400e674ab86 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1227,9 +1227,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			count -= nr_pages;
 			pcp->count -= nr_pages;
 
-			/* MIGRATE_ISOLATE page should not go to pcplists */
-			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
-
 			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
 			trace_mm_page_pcpu_drain(page, order, mt);
 		} while (count > 0 && !list_empty(list));
-- 
2.41.0

