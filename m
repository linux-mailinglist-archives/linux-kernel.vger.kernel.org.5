Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5FF7A5605
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjIRXDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIRXDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:03:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA3191
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:03:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IK3xs7031273;
        Mon, 18 Sep 2023 23:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=aGyfKWmz6L5+jK4Oa5XR9qAiw4qVE4/FVGtZT6ufHEc=;
 b=H/2MiC8t2yAXPqKgu5r5jjRUgDy/WJLA0V1y0TzCx++s8Ef1crtwNY2PzKpedYr8CXH0
 BeACQkZM5lle23qp7JLwBTvu2osgdAu/uQ5M0EOh1OuA3FDSxD7aZCfhgezpXnlaU0uY
 /7tC/8v7sM829+wS1KfJLtPzzbRzPWpDyIK/xbq3lvmxVBKVLCkiGCuvOVx+S66x3i4q
 N5EqSBC2h5+jehEZdhRGRHq/jz0l1sB14vzSF9lhWZJDHPbtjvZNOkjK6UPEZxu4B+Rk
 tG2ajwER+aD5zWPLdV4TfpdbwV8Ja14yK3scHKxRaqydcX5/VUmMX5CHo3nV4MKpDStL 8w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t5352upry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ILV2Hj002042;
        Mon, 18 Sep 2023 23:02:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t4nvs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2eVagItC1t6taDapo+wBiH/fJOOgFc9ijxF4DbZ0F0nrtjDiqY3iw4YWWuuxYdtODW6izMQ4Lm43ooCcDOHzMq6dZq0qr9F7OTqOJb8S//vA5zZZTdcn93EjK1oka4mgcW1ik9W3Q/aES4pfO5kKZH8hjY3hMgyQ6qClh7j/b/6oOHMiy7ebza1416zKh/w4QiZMwVmddrVJQJG1Ntc8viX7/ocz2pfAOeb2Pj0LLUSIaAOnh851tYutRV1R+95rfoJJJZ4HU+2BQLJfx+TJ6nSiUsQpKLF6cEfViktAnuFZptRYYI4IC+Y9ji/DzQ3IdsYgex2qBZyT8EgyY3GFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGyfKWmz6L5+jK4Oa5XR9qAiw4qVE4/FVGtZT6ufHEc=;
 b=fo7AffVd0B69gwRti465K2Ls7BQVoEL0eybIciERbDHQ5cDMRa3YhuwXwFXZewyXFbOZ+j0Vx0zxTj0JKEq+Xv8NTNt1VHl7eCa217JuxyIm96dn+nivHbyNbXXogzZl5KmNsa3EXDtfIYwKkdIubOUxFYns3A3WivfB2+zj9Gi+6ZrlQyRKFxMkDWdzEVLoHzQw7gueC8MDp/6k/sU59lyjK54SFJbAcVKOuizeODrDuZhaAvQqm7cTChbY68Jn1KxpVRG0SxbLiZ4THUYguQ/xpRuWfx6ULxdqZ3nadGypIHUQX3g4+Nvm/K6MD9+pIbafi/J722a2+f6xfgPycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGyfKWmz6L5+jK4Oa5XR9qAiw4qVE4/FVGtZT6ufHEc=;
 b=ro9iDMxEqtmzqV2tG+f3REUu2cHIPmQjdJYVQFIkBMfXH4DSZK5mKIKp2Nkbetui4Huu6N3xmg4wKyydkR4GOjjS4K1XogWIomLR0lFdBYtYl+QziwvY88l69gtqFdaOeHOCVlpugptCj+HEEy8/OQvtzNzLZSB1nOkKzYdZsXo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7204.namprd10.prod.outlook.com (2603:10b6:8:f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 23:02:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 23:02:14 +0000
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
Subject: [PATCH v4 3/8] hugetlb: perform vmemmap optimization on a list of pages
Date:   Mon, 18 Sep 2023 16:01:55 -0700
Message-ID: <20230918230202.254631-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918230202.254631-1-mike.kravetz@oracle.com>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:303:2b::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4c3a7d-1c99-46e9-dc3c-08dbb89b4c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FuKXB8Zs31XdTsAKVrof9dhZl/6e4NvWEaAK/badTca5Q6q0BYnBtq+QdLlQYaunDMOnIl8W432ctcm7FDVp8LanDbO3BaMvXuh90KNpCMtx8DAmCSS8csI09THh5Bs7uEltO38uMLoVFBeRePhAa4pJN6nyP3+KIMQ+LlxgoOkhUR8TFzxnrmyXQhtxMeywhEIOO+/8lLHEl3au21xgUZ7o9fz4gq33t3HNFnVoLFdrr/mLY2rM/r6Nfy+rBteiftiCIuMBuZCDKGwYc7nfYfd8KdEjEfR4ZPYdLQ0fepJN9cqg/EPIV+eRtIt4qEhG3GDjTyRJ4vm5sNQkgpfuEOcuMWgm4o/EyhWQ/xzzux6o7Ekj1nXCHjetVIf8JD4p0GgydHpVin/zX4hqjR/7gLyhsKm1v1GcIGu+TDyALuN8b8JwBVL77jea/7WTyIE0rgU/gkXiCZxt+NA9tPyGN6UmIuyIHptRB23xieoCKniRPObLR/FibXk3xnCK4lGujNsP+zvpSJ+qTtt7qXCyluYUiFRKkwTU8zFmdKqLZsolyvAUkYWKqqI9WB3C9w2X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199024)(1800799009)(186009)(6486002)(5660300002)(44832011)(6506007)(86362001)(6512007)(54906003)(316002)(38100700002)(66946007)(66556008)(41300700001)(66476007)(6666004)(478600001)(8936002)(2616005)(26005)(2906002)(36756003)(107886003)(8676002)(1076003)(4326008)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eSKkpDq7NJZ4bvnqsFWMSIO7S4oL2wMHn6qIyxcpJfBHiIj0Z1991Yffpy/R?=
 =?us-ascii?Q?6bLOOi109vK+5oWUnHcRS9QqWQQ77G4lxdYtdfCz6PWCkX580fVQ7LiVrQoq?=
 =?us-ascii?Q?7Fpo2Ke16SdrV74DCoEvAUDVYemzpXOaG7yXqMGldFSpEMvRgWMHzABpG5bO?=
 =?us-ascii?Q?ief45E/GY9fa/+83Eoa3V3eEHCExq0Q5biS90rm301dCW0S6W3zTTJ8FXv/Q?=
 =?us-ascii?Q?0vZWKSSqPD/btmRRd3gdYxgBIj0+hhWH/Bq2WKV/VAR2M6C+Ky3B3NH9XUVc?=
 =?us-ascii?Q?JiXY3HY5x1nC4EH+r77wZTi4SWQp4F1MADXiJbe2K4gZKsrxrg0Pp50yq1yt?=
 =?us-ascii?Q?Yz3O0R82Gspn0usK9p36A0j1WSYPVGmWw2DSyfwzd3GjXM43R7wFlfB9wULF?=
 =?us-ascii?Q?0aNNk1bk+d0XehlFXryBQPPCJSE5qe8fzyH67mUybpMVvXWoo3IT1IsWMB04?=
 =?us-ascii?Q?GJqQ4S2tG2Em2sGK3gr27jG1zsuHz50q/7uLY7Zn/4W2UJlviCUR2XQucYJz?=
 =?us-ascii?Q?LKWhIHIyUC3Kh1uSRW+rQxQKRRQ5BOkoNlbko8YgEQsSKXRGDQvfHoYnSRCk?=
 =?us-ascii?Q?H1ZHr+d16/pL3sQv2eSArXRnKGsGxtKjZKgVg3CP4O56C7OjQy1jA1tjbewU?=
 =?us-ascii?Q?baEYkzvKMZJYk2Zbu+tkRYz2q5U6Wuq3L0x809+D3uAqJ95eyt7BRWTXB63D?=
 =?us-ascii?Q?GRAcTQdODoQ7KG0PMiwrgHRPwV+QqLGUmMp7qOVZ56J55bKwaTmdvBth2YYz?=
 =?us-ascii?Q?NydRlXDUuMKjbAhyEcNBu5Gq8Mv1FMGKbZxkuNxJQ5zw+pZLh3bCRoM+nsvk?=
 =?us-ascii?Q?OaI2U0zu0R950RW/yTLurQ4nlub6E/0cJGaefOBf6YSr8momZ1lo7VfWfjvq?=
 =?us-ascii?Q?tyKeCmRiMXh1pLgsiTrbcOAjhHbvKfDs83DKkvLrKoTSwX3M1DBQoSybs7bp?=
 =?us-ascii?Q?HvWS7iMKLXNo+4rmlDfAsHkty+OQgdXY+Rf69EhkVBdFgmnsNeOcnToi8YzF?=
 =?us-ascii?Q?l9kf3wftMlSf9pyn7gyEoZLk70Wi6FAs0rd+CJ40CWZTIH/JLZ7wsalDu4MB?=
 =?us-ascii?Q?EE5INlmCpH1EMG4Zc9gKjvHDot1sN62bC45J9fH8MkLroWCNdNQV44BDXtQD?=
 =?us-ascii?Q?sJHsxl+RpArssaDROO1Ai2JImRcGx7GYG4be2EWLkvSeVsGWORD6bY3luz8V?=
 =?us-ascii?Q?/5t84UMVwfwH0xCMuwB0WH4D9N2NIqzNAghq6AHU4AAFnjiPoDd8BXU0Dg4s?=
 =?us-ascii?Q?gnCeTTCeSaLYFUOQLAhgB/5fep/MWXkYnEglBD9+5KetpVtSsEP4F7e3i3BQ?=
 =?us-ascii?Q?L85M0we4dlSBSUqZYQjp6JFCvqoI9vy3Owy8hLGm5EC2Ks6z0qk9BGQdmBcu?=
 =?us-ascii?Q?AuBz3mAiNJ8c6IKA7kOHV3t8yPu4SmIYYpE/kQwur5DVzFRQDhrQIkOTlYiU?=
 =?us-ascii?Q?PNIArB5u4ZZ1sEQdkc7jGu1TfK0rxD6iO4CGslD/sO7Yh8hEP9/19ziiStSA?=
 =?us-ascii?Q?lXFNe72yNcSunPq/etfjmhlw0xDb8V7xnxmGiwuc0LPMj4lRIXIn8Cu0efoy?=
 =?us-ascii?Q?PFwCB0+SPNMgtbawwDUs2iJGHKuMWOPJMvGL+tsM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/OXf8B4pm+LE1lDf+QICMnVvhZIiKBqdO4AHwo52mys4yqpEOSKRtX5Hvj0p?=
 =?us-ascii?Q?Gk/pbeQqzISpIMpwk/c+o9IpEo5fUVAdqIx/o+frDchsRFIoBehtpepqNcGu?=
 =?us-ascii?Q?M9RbXJraKU3FYdxjO9DGSxZkMViNLezBDmcEKcPz5i7nr2Q8t7AlMWw5T4Oe?=
 =?us-ascii?Q?HJrQDgkgKxLSfXFAtD8VRYmRALZ5i6Hl1/xxG5pnyMmP20rhKdp2VTviuqU0?=
 =?us-ascii?Q?sPKg3OfI8USM83Sc8IM7TdCXnuARwaZg591AnsC+Pwaoay2mfHNnILVo4k1Y?=
 =?us-ascii?Q?Yyj7gWG2sz/mnTeUygSVvmjLbbKg5VgfUARHoiCNFjMcHrBio7L1Rmyhix8f?=
 =?us-ascii?Q?elomBY5FB1jg7Dkfw/zyPA2yOTIZGmY5i0qc3+TRxIeY+KlCYFjDYKM6+Uuz?=
 =?us-ascii?Q?5ANtLDDqTrWMGH/hj6uLthpMagXDIum/oyL3ylamzgM+drOC3ilsaOVBRZVE?=
 =?us-ascii?Q?LsrdV+gPaW+xiYR8QDzWKMCxnRedWKQfvYY3CBbK8Xm7BS3IY1VIoARvIoDs?=
 =?us-ascii?Q?kyPmwvibShU46cUZ/mZ6Tt6EBPD5oisk2OrjIc0iLwp17t8RQi4j5tAvSA7B?=
 =?us-ascii?Q?R7gqOSshbjxqfZEzk9IKFTn7blHsJ0IeaW2EjGwipCUPcP3EM2Q2R+MSVhWT?=
 =?us-ascii?Q?/d47iJe7YuF5vEkJ6SkdxJYN9j6U/ZOKRQfLI8luZQgCCm9tPLZXB0/8Jkrp?=
 =?us-ascii?Q?HlXQqc9R6BqXGJ+3wA6KhMi6bnhLbATRMQo+PY5FPzHIhcSHpNAY5EKzQEyA?=
 =?us-ascii?Q?YRLZoqckPDXopStZ3eL8e9L0I+wUgrdYjqrMiX5JIWQw65FhYPfUpMkIDnbb?=
 =?us-ascii?Q?/0dtsX10OJTWTRqhB/hhwF0Y0jOextURHdPF8faxh/qXvsM/H7Aw/IhXHuox?=
 =?us-ascii?Q?vZm4i8qLfZr89IBc/bbHK4q7W9EtMNbovI9kwjLWRu9HUwK218jDabjDa18d?=
 =?us-ascii?Q?e+MlNGs5mAu6syFjgWk86G4xTFLWNUKtFqKkbfwLdD8eUesozOlarxwQFKTk?=
 =?us-ascii?Q?lfIL/PlWsmUD1YKWQQHSdvU2RBLd0Trgs3zMY/ySLuye35LqQ0NtOwpri6bZ?=
 =?us-ascii?Q?fweO+v6exakdXSuirQi8VnjpmdWORlnW+cAnRlO6rCYGQrzBI6vNqYa4YbyE?=
 =?us-ascii?Q?a8gjnu7w+5a1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4c3a7d-1c99-46e9-dc3c-08dbb89b4c8f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 23:02:14.8375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqMO9WmiE9jboqjbZET893o76n1IfVpoe0NRkFgmbfNYt+APNYll5eSe+7dSPS5yfSUyw/KkSNzYIfrn5ygNUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180199
X-Proofpoint-ORIG-GUID: I1HVvo5hbKKAlkoc8CyrG-Rl11FwEtQr
X-Proofpoint-GUID: I1HVvo5hbKKAlkoc8CyrG-Rl11FwEtQr
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
---
 mm/hugetlb.c         | 50 +++++++++++++++++++++++++++++++++++++-------
 mm/hugetlb_vmemmap.c | 11 ++++++++++
 mm/hugetlb_vmemmap.h |  5 +++++
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8624286be273..d6f3db3c1313 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2269,6 +2269,11 @@ static void prep_and_add_allocated_folios(struct hstate *h,
 {
 	struct folio *folio, *tmp_f;
 
+	/*
+	 * Send list for bulk vmemmap optimization processing
+	 */
+	hugetlb_vmemmap_optimize_folios(h, folio_list);
+
 	/*
 	 * Add all new pool pages to free lists in one lock cycle
 	 */
@@ -3309,6 +3314,40 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 	prep_compound_head((struct page *)folio, huge_page_order(h));
 }
 
+static void __init prep_and_add_bootmem_folios(struct hstate *h,
+					struct list_head *folio_list)
+{
+	struct folio *folio, *tmp_f;
+
+	/*
+	 * Send list for bulk vmemmap optimization processing
+	 */
+	hugetlb_vmemmap_optimize_folios(h, folio_list);
+
+	/*
+	 * Add all new pool pages to free lists in one lock cycle
+	 */
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
+
+	INIT_LIST_HEAD(folio_list);
+}
+
 /*
  * Put bootmem huge pages into the standard lists after mem_map is up.
  * Note: This only applies to gigantic (order > MAX_ORDER) pages.
@@ -3329,7 +3368,7 @@ static void __init gather_bootmem_prealloc(void)
 		 * in this list.  If so, process each size separately.
 		 */
 		if (h != prev_h && prev_h != NULL)
-			prep_and_add_allocated_folios(prev_h, &folio_list);
+			prep_and_add_bootmem_folios(prev_h, &folio_list);
 		prev_h = h;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
@@ -3337,12 +3376,7 @@ static void __init gather_bootmem_prealloc(void)
 
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
@@ -3354,7 +3388,7 @@ static void __init gather_bootmem_prealloc(void)
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

