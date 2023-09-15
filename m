Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1AD7A2A61
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbjIOWRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbjIOWRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:17:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE5791
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:17:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLu271027077;
        Fri, 15 Sep 2023 22:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=oDZlE4S/P8gMy5+qqWQXiX898yEOVoj4504q4XjHrvY=;
 b=mKt1cFDXMM3bX/MOtmFd2+pfZcx8bJ6GVvIcv/H5BRhqDahR1YIACPUmdz9ayx20xvZS
 nBdlAZMZ1lxao2kbLNskeO2CXq9OPyBwNrFo5dXNyP6TTZ/uZHLnnhhH/9C4PO7XbMDa
 Y05xW/b2XWU0PvmpSSm/0GhVsH1KSWwkMrJlr//QNxrcXxcIE1aJ2Z61gEU2sLwQhVIG
 HLhVhtf7DpKZ6xO4Q7u0yKGa9TeCWMlhLKN2Q16o7Pf5YIK5gSgHDBnKH0K+y+y2NO9N
 x4hvIAOoOQ+9uWbMQY1h82Se1Xcy6b0l3whbgVrqj7NB45fufbGGH3adTVi9b1beou4A 4A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7prp00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FJkubT036245;
        Fri, 15 Sep 2023 22:16:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5gx906-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzAGC7o1JrV0jbbWIkfX5afd5Rq+5FWocmprUQ+1XPkQS0TcKRoyIIVq+eNZOQfkLcf/tB+uoEnzZyc6+qOsWTxpjaZHXQRTsDAI9aJ4Ywzgyt/TF8wdK6uQd2qCeEd25eHACuM30T/SqFGY8zkmn8YWn90dOn3TBQ6kM3mxv5vGgLLOlVuTCF8y+xzCknw1K2XbQ6NRQpw+3TQ4A0A8YOXOYgQ9xMuBtjR8x0aDIgRgEbnCXXHduKiToqGu4O9D+Cw40wad3frGZNKizlBIHQpM36Os3ufWeJIbrH9lGvQ1QBMWVBvhCeKWGXj5OWeFtbsv0c/LPCT2+YBrKggvkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDZlE4S/P8gMy5+qqWQXiX898yEOVoj4504q4XjHrvY=;
 b=M04lL7M70r6xL1rQDM0gLzso/xnE5wlT+LHRk69y3fCDUWLR4YGYHN0Y15t3Wyma3N7W8AVUjEYPGfgWkso5v9LWKDX6jvQ64QnMXiTi7GcacOg5CU9nDUR/xbP+jzPmSYlYJhi/lES3c9MxBkM1baDlsOkH6vKVjn1+DQO0HaRtilxnGQlxZfwUr4CEtqyssrETtys9fIxa2RzQwAWMjmk4WLk6ZmYxqjJrUvSfeG/bMPb0w1oJR8hAO204tsmQWYmHr7CqV/ePRCpeFDvXeS7rBq3LsPCLNpMjRjVuPQ2NMKuSGUI/8azlqWMytzl4uimZYCPvuXHpub8p/AZ8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDZlE4S/P8gMy5+qqWQXiX898yEOVoj4504q4XjHrvY=;
 b=k6YUlS3xhC5+3QWiCGxy+0ERPfQpLzvmKmMoBbHD4dzYkdwf+Dh5UOUMKcAPKuHYLaKYJfnB3vy8K8zMm1wweShowIx+OVE9ThPOyUOlotRlju94WzKjITF4Tu3KyP9o1YOU5ef+OVQ9Va6GfYGrel8h8Okz6Wn7WgGgEZwyE4U=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 22:16:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 22:16:14 +0000
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
Subject: [PATCH v3 08/12] hugetlb: perform vmemmap restoration on a list of pages
Date:   Fri, 15 Sep 2023 15:15:41 -0700
Message-ID: <20230915221548.552084-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915221548.552084-1-mike.kravetz@oracle.com>
References: <20230915221548.552084-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:303:8f::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2649fa-a489-4861-b9b6-08dbb6396010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4ZwTQVhXh9lCE5/f+eot+ZjOENl061bUSIa+DFnKR7MbtGK+Pz7dAQPw7sTS9rXN+BlgWYUpBjjRxi8TYa1Zn6iOCtgYOHIo7oYbTtfDKarUmX1c3aJ7EDI/UbtLejoCSAqixxF4hDtw/l/W8JCg16OntcZIW9fWz9EKR1duPJQmNlqEg8GM2bTObbsRdyRzkle2Q/PxJF4I6LMJCSB3oyiuo7eq2FjI3iIfrLRU/osxFohSsXWbLBcMomwEXeR+9BX8YUUmXA3C/o0auHgxqORgPwWMr2Qf+EbHjAwzQek4bmxkytElLN5wzh73fE9Qv8g+BrtOT3iBxdC6AV7fRtGdoiVs628ozoSCZgY6C3c0IolFW1FE6klOYMTjlN1OtgkpFX7e28tARlyq4/GWOSVwDhFw4z2pNV8kBZAMTclJw9B6hK6Hf4G6+C8bGL3h3wRfrj5DaqXIL8KmJz8mtMHeNKbX+vIhCZFmwdnw9ORhaIebbISnHJ2aNa5xcumOKW12TVoLUyMLn51ZRO7c1s0/LdQzMt3LKkNTKyf1t+nTnRPjyddOeRZoKMQcRkL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199024)(186009)(1800799009)(44832011)(86362001)(36756003)(83380400001)(2906002)(38100700002)(478600001)(1076003)(2616005)(26005)(107886003)(4326008)(6512007)(41300700001)(5660300002)(6506007)(6486002)(8676002)(6666004)(66556008)(316002)(66946007)(8936002)(7416002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dIzXfKaNi7kSWYx/yPd1aQd9JWjL5MdHxSmORWf+T2qwzSB9finOeKdQC81a?=
 =?us-ascii?Q?DT/lA6SeSSRUyDj+5uRZY8KMQmY983PJwF9mm0DfooGG3zDKCyZkJUF4rW9m?=
 =?us-ascii?Q?PIXecqZnHOa9HyR0xooeqXWKFRxWAamduJqK9B6yh1caclqYkUb8wzVHOE2+?=
 =?us-ascii?Q?CMoYeol1BuSQOY7XXVs3jEquVAEXKA/92jYj5tZXwzAMhym7sTJMqaw8SWEC?=
 =?us-ascii?Q?Ze8bjqLpYur2LxmqAQk+wKSxcBLtdTDeX2/CZuVrKYPD2yKTUSLtraZ9Rnmt?=
 =?us-ascii?Q?InQC8lzN1nySTSLXgLIof0qr2zoKw2wkiGuLen9Kyrcm17/CkoE5EYW7uYIj?=
 =?us-ascii?Q?GQITqaE7cVt6XbSRs1CZ3+OUU9UxvdmDjIqtmaqCtpZtMIgtyV7TK/ssMrPr?=
 =?us-ascii?Q?DUNyoJhvNjmBHK9+zZbH2fXQqJp1oDkKyTds7wC41BjKrhffbJSfJYezetZa?=
 =?us-ascii?Q?Nx9UgHYSsd0KuxMC5ouGsLcIUjvhv4iB4Guj2QzkvFqeVtG4GkmhsfSEJ8Ik?=
 =?us-ascii?Q?0M2mE1KK6xnIOnSUGD0vw6DqPy7K4k3f70rphhSM2tyjSgVPRj5RuVR8Z1Oh?=
 =?us-ascii?Q?5opFMATIvrwYEZP6W0A7ARxjvqPVWoBBG0gPh5I4ntTtms4ib+42S5Bv+C4s?=
 =?us-ascii?Q?4cL4GIKwdbOl301Le6GMQlL7YdazViI1FbN0WOQQJK8N+iPt8nheLQCl+ob1?=
 =?us-ascii?Q?Y06+Fs5NmQIKBCX1fa+3AmYQFECufP+0x7knDke5BmCPV/62qCPMx0jBHFyk?=
 =?us-ascii?Q?UMWSaCP91Pbeu84qdN5wJuuwHayndIonT73e5u3wsZTf3+WdgDmvq0M/+JS3?=
 =?us-ascii?Q?6Bv6FeiC3Ot2V3K9fSYB10hvCOfSrFrFOc3trRpqdyGiuIfAsAJ8biKGvHQM?=
 =?us-ascii?Q?XkL8MlBuxlGgw3oQcoHSCWsh9HSaHFeIvYiU+d+MbINj9ml8WT0g/GQtTb11?=
 =?us-ascii?Q?vKfXunfww/A9yFiFxItfXrIwEeH3O2mTXdiYCbVfaj2GweQjIPN1exlz/+rL?=
 =?us-ascii?Q?B2Y6L6wN5QTBYnWKbnaBJLh3DceibWWEqdSm1lsbhjbeJ838hvkh5a4GZp4T?=
 =?us-ascii?Q?7h0iYE6TkTCfPPPi/1xDIF7qJ1rslk+GMRwqrqIM/XpX2/uaJAk9zk5ifwtR?=
 =?us-ascii?Q?nLklfvg4jBJyAJNXsbq1uHbD1EahPkW/MpZzrVpyVfUoTM5+cn/9DBW1tQZV?=
 =?us-ascii?Q?vzayjVKtHmgyVyrhJbKhRUEh8CGrONspZmOccZHbTCo9U1hQHwaVF9IRcrYP?=
 =?us-ascii?Q?ynHoG6C+87L48Q+QEjQG3/L8hG3UbDtwpW/98NMmUvosVaE/StXQkOKspw3E?=
 =?us-ascii?Q?WMKIDR5ElfPFvD7P3anWQtqB6aVSpfWqsEQedEy81y8Y4j8At2SOTE4py3gE?=
 =?us-ascii?Q?FQGpQYPrqX3Wwj6OJNL1UsS5tmgxLUx7ZGxWzN3PeN0XDbUUttbmKqfTJGQ0?=
 =?us-ascii?Q?B9KuCGqtGT5AdbI6blpTFmQvuKjpTIGwZ4Kkhqp3QjtRVPtMTewhrNcFihhs?=
 =?us-ascii?Q?KSQ/fiQrB9PCMxwnk8J8TnfHu3c/RRoC+22eGIyfyhlW9kuXgEisHgzjWW4c?=
 =?us-ascii?Q?esWbvCRmzpCUWmOtVOkKVtfCkrvmQsbbJ9FEYfeZplfBEWgTAX7A+7o5Cvh5?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?oZIHqSeKh9vKbPteDEfHfjF+U7AWyoF/CYzgfEXXtkbewjbL7IeCMH1WbVqy?=
 =?us-ascii?Q?ebFiNMGxy+aCM/UCQnzicO+dA9LJx2JEN1daqMeFdqSi12mXz4NwDInuQfKB?=
 =?us-ascii?Q?UAyXU/Hp1u++CZDaAQoQIYT7bdtysdUB5/T6ul/B8FFdijZwaOR+FsGYO+Io?=
 =?us-ascii?Q?OIBHP6FjWLkVeknzAjIJP0TUY/3Abaiqf78/gGOPKxn9Wg7rQ8SnUXZOPrYM?=
 =?us-ascii?Q?T+RBc0zA3lzdlBECVCsup0pW/6FEnzB7UK6FVXYU4h+HX3rkZLNWgzZSj/eT?=
 =?us-ascii?Q?KutGLz5v3CIReADQHALh4Rc07XefBCWBhlJ/g8yCUVsf/FG2MiZfy5yzaiNY?=
 =?us-ascii?Q?J5FL6XVbRCNovgwKDIfd6ymevIc8cZa4FPgg6CfojAXUNNyDw2apQum0SfmS?=
 =?us-ascii?Q?ZACpNwg2zti9h7Kb4GnxcuxhVRO5F40roucKHelwGdHiENxdCGanwsIs2X1+?=
 =?us-ascii?Q?YWbSx81GccPe5aUVDCReTmxxcUJLr+J/QhM3x2G3cx19L0uku0HZ1UdtJsxz?=
 =?us-ascii?Q?efhE37jUR2Kw06GQHeY79domJgGYj0/7Q5JqYAFqB1sVCa171kwSxcvjoxBk?=
 =?us-ascii?Q?HyKHBfLlnzsoHWv7r9zbYFfL9lwJQcnUGXu234blJhav/klyCU6TgE2YEAYk?=
 =?us-ascii?Q?j3iFHdjeN4GR646HlumAr0xxWSqGS9VulJl3a0p0myaNxcY4RIkTvSmWc8GJ?=
 =?us-ascii?Q?n2GLYH6dFzOBC8nHjd2NWos6YTJ9o7/p7QUyrBGii+7KoapPv9UhGQ02WMac?=
 =?us-ascii?Q?efE6fX6s9ieTRJjoC6iOegQDoxK/VYtlxI0W0OHKqYzlHF6mDd7K5va3GlJd?=
 =?us-ascii?Q?QIYyRnXwPC65DrQkFUyiQ7EoH9bEA5prZgcDVkl6v2OHRKF83K64/CQARp5H?=
 =?us-ascii?Q?RGXGuXlgc81RcVe/D4pa86Zkwa7CV1NCoZVO1KxZZkPWJ7Ox1s3a2mBqn5DU?=
 =?us-ascii?Q?aHggHcric3i6K0ABLK+kjBh/bG1vI011j2x/qtRVHguSCN4nzeD62Mb5kn7F?=
 =?us-ascii?Q?85gBjmRSSeiERONh6KPEsypP06dh5XuQvMpkscQz1wH0kLtQK1XToj+DvRZZ?=
 =?us-ascii?Q?c217LswQR9d8/od9rITAq3lOwqD83jQ0o0/LVjAa4XbDlyLSHXULTT9wwHNV?=
 =?us-ascii?Q?rITOo3nRiHPL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2649fa-a489-4861-b9b6-08dbb6396010
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:16:14.6150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVflspdx53e/Yve1leD8OpzAhG3ScWSztSflE04Mzf0pEBtZcvKXWsANcPj86611TOJ6druBWWGmlApZfylf6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_19,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150200
X-Proofpoint-GUID: HX_rZgjwfQoMcw1znlN5y-AMmK6nOOF-
X-Proofpoint-ORIG-GUID: HX_rZgjwfQoMcw1znlN5y-AMmK6nOOF-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routine update_and_free_pages_bulk already performs vmemmap
restoration on the list of hugetlb pages in a separate step.  In
preparation for more functionality to be added in this step, create a
new routine hugetlb_vmemmap_restore_folios() that will restore
vmemmap for a list of folios.

This new routine must provide sufficient feedback about errors and
actual restoration performed so that update_and_free_pages_bulk can
perform optimally.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 36 ++++++++++++++++++------------------
 mm/hugetlb_vmemmap.c | 37 +++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h | 11 +++++++++++
 3 files changed, 66 insertions(+), 18 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 214603898ad0..ccfd0c71f0e7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1829,36 +1829,36 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 
 static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
+	int ret;
+	unsigned long restored;
 	struct folio *folio, *t_folio;
-	bool clear_dtor = false;
 
 	/*
-	 * First allocate required vmemmmap (if necessary) for all folios on
-	 * list.  If vmemmap can not be allocated, we can not free folio to
-	 * lower level allocator, so add back as hugetlb surplus page.
-	 * add_hugetlb_folio() removes the page from THIS list.
-	 * Use clear_dtor to note if vmemmap was successfully allocated for
-	 * ANY page on the list.
+	 * First allocate required vmemmmap (if necessary) for all folios.
 	 */
-	list_for_each_entry_safe(folio, t_folio, list, lru) {
-		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
-			if (hugetlb_vmemmap_restore(h, &folio->page)) {
-				spin_lock_irq(&hugetlb_lock);
+	ret = hugetlb_vmemmap_restore_folios(h, list, &restored);
+
+	/*
+	 * If there was an error restoring vmemmap for ANY folios on the list,
+	 * add them back as surplus hugetlb pages.  add_hugetlb_folio() removes
+	 * the folio from THIS list.
+	 */
+	if (ret < 0) {
+		spin_lock_irq(&hugetlb_lock);
+		list_for_each_entry_safe(folio, t_folio, list, lru)
+			if (folio_test_hugetlb_vmemmap_optimized(folio))
 				add_hugetlb_folio(h, folio, true);
-				spin_unlock_irq(&hugetlb_lock);
-			} else
-				clear_dtor = true;
-		}
+		spin_unlock_irq(&hugetlb_lock);
 	}
 
 	/*
-	 * If vmemmmap allocation was performed on any folio above, take lock
-	 * to clear destructor of all folios on list.  This avoids the need to
+	 * If vmemmmap allocation was performed on ANY folio , take lock to
+	 * clear destructor of all folios on list.  This avoids the need to
 	 * lock/unlock for each individual folio.
 	 * The assumption is vmemmap allocation was performed on all or none
 	 * of the folios on the list.  This is true expect in VERY rare cases.
 	 */
-	if (clear_dtor) {
+	if (restored) {
 		spin_lock_irq(&hugetlb_lock);
 		list_for_each_entry(folio, list, lru)
 			__clear_hugetlb_destructor(h, folio);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c17784f36dc3..0eeb503d8a4c 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -480,6 +480,43 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
+ * @h:		struct hstate.
+ * @folio_list:	list of folios.
+ * @restored:	Set to number of folios for which vmemmap was restored
+ *		successfully if caller passes a non-NULL pointer.
+ *
+ * Return: %0 if vmemmap exists for all folios on the list.  If an error is
+ *		encountered restoring vmemmap for ANY folio, an error code
+ *		will be returned to the caller.  It is then the responsibility
+ *		of the caller to check the hugetlb vmemmap optimized flag of
+ *		each folio to determine if vmemmap was actually restored.
+ */
+int hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					unsigned long *restored)
+{
+	unsigned long num_restored;
+	struct folio *folio;
+	int ret = 0, t_ret;
+
+	num_restored = 0;
+	list_for_each_entry(folio, folio_list, lru) {
+		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+			t_ret = hugetlb_vmemmap_restore(h, &folio->page);
+			if (t_ret)
+				ret = t_ret;
+			else
+				num_restored++;
+		}
+	}
+
+	if (*restored)
+		*restored = num_restored;
+	return ret;
+}
+
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
 static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 036494e040ca..c8c9125225de 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -12,6 +12,8 @@
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
+int hugetlb_vmemmap_restore_folios(const struct hstate *h,
+			struct list_head *folio_list, unsigned long *restored);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
@@ -44,6 +46,15 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
 	return 0;
 }
 
+static inline int hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					unsigned long *restored)
+{
+	if (restored)
+		*restored = 0;
+	return 0;
+}
+
 static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 }
-- 
2.41.0

