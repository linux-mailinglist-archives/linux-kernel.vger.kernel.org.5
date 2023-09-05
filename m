Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E6B79315F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjIEVxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244666AbjIEVxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:53:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564581BE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:52:59 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385LB2Wf029608;
        Tue, 5 Sep 2023 21:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=S0ppY54OPBFldkJJgVsH20gQesPTIK8uqEJvN7NBREw=;
 b=G2ASeublQqKek6yxL+x9Cw+MclL9XHbORzM6PZJCrA4FQgQ3zFZ6cDa6Qb93Bst1ma2p
 Wd5H5CPrr5miEdR5SQ5wx8DNrO7Xe6vwcFeCegN79z7ztZtSRhDcbBf0dX566izHfxJz
 v0lFPfCml3nKo0KMCFRHvR9eFR2fMkka7pAvg67aveyygJOXRUkWYt1OzUAUW0iIw9H9
 wVs8wAWCIlsi2ClUmKHpjo3kLpcnb0ZCulp2a55Z/kRgh+f31iU5l+7/t1hwHsAm5jz5
 6M0PyZWzdnf4xDcDdRndWObfcM+5Fk/wdnmHNSlzIzN3y800+nL5MRlQrYQyRtMqAD5a WQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxc0sr27r-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:52:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385KKIJr007701;
        Tue, 5 Sep 2023 21:44:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5c6ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V18DeOYJgXMNXYtek4h9RElCvDMa5B4rU7tjRxWTHLyxs54d6B7ihJE/DkuK/6AqmtE74BNJRHxCU8vd7hsgeSb1hGdlMF6a5q1RGxj7KGu9P58koRXC+KAsuaPfG1B8vX/wivygaibW0by98JwrqoSW6TdMjV2cZ6iO4o5MNGVg87ZYqnB9n0yQWtX3BhRkMi32x5SRMcARfCcXuj8VzKxLrBzpsaTkOpvUHmMcVVm9HofrFaGHKQLTsy+Vtkyw5gvA7SuOZq+CeY0JJ78QJV+K8VK6F+lOioupb8DwbqzRCQRpGkGIXMepYxvM1QpTtoRz9oGdMPaElMK8B9eaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0ppY54OPBFldkJJgVsH20gQesPTIK8uqEJvN7NBREw=;
 b=ZXfbhtJ7K0fgEO/+JyIyxeVDIDGGO0RWbufd27h9IcrwoNRkrSKeCJkFdBNuw/79e74nlkMOLxf9zmYHep0nxZ0rx3j618AyO0kDxtr65XChue1qG308WhMT4JoNC8v41BB/B7BIn+ZhUKVbbqDpUNN0R1ZX/l0bakkP+HKMRKTpV4rLDLG9m6KAKjhYBNM7P2QQWP09yBwnJdU4DLJ7LWIVG5181rneKCT8HtUi+Ln5McOVOk4XALMWxePhctrr4NMkwwPJbEa53OAjop1D9Um3cV51OgtsdhAmQo7UHoaMaaGBEJKgyrp9tsAYFPmYhNiF2ajLro5YTP6FIlWZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0ppY54OPBFldkJJgVsH20gQesPTIK8uqEJvN7NBREw=;
 b=PURaWeCoNdzd/56iUbqbAbbmqMpxlEWgs29PSbjTD62PvYT458atVUCePuQK5jtI/jFSX2cjHMXEzG24TmKl7JMk0vpYw9FgRZLhG3MBqNl2Ch8b8ogd2aO8tEu3MfjeAwj6AHNh/qSo0WcdffYKPmWVA6V+bBcYJZb4tENdWq8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 21:44:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:44:28 +0000
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
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 03/11] hugetlb: Remove a few calls to page_folio()
Date:   Tue,  5 Sep 2023 14:44:02 -0700
Message-ID: <20230905214412.89152-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214412.89152-1-mike.kravetz@oracle.com>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:303:8d::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5c52d0-8587-4bab-b4bc-08dbae594815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kF4FzkRUx2gxS6JiHld2jV1kYzT4NIh3PXUrcDlPev6YmeY/CHZXErZSVsZ/PasI8a9IPxz4VVG4BrxnzSBBrqeTMWqfgR2gA1Y95oyT16Xq2lEquhOpVAV70wwwo+FUwVkjzAGym8w9hHjbbWIlL7AdK8nyMndWaGawB8rJDoOKWr0upqUOWsc35oR9LO0Cvoh+PfyxZCc3KvZVL2qN9bPrgJN2J7tmGWXltD1uDc43rGE2IQqHp7zd5FKUsYAHRZ0idxNsXyoXpAIYY5B5DBms8Oa8Rc+xfEBAePK0An6l1BcY0E911eKp7qCQuGGolGPIIswIuGwsSGjhV10pbQtMFifBk9UshtjnYpPTDhHXY5YI1bqTsA8F/gIAl8vtYJXieWC3MwMtWOrXgNUJkJGZW/m9ePhcoMZBvoAAyrpNkwC+IJVikaZ0DMW23fAZOE4SZznPcpzHL6hfVKkHRs1QzD6iWCHbBXhVmGqcKaLTNbHIxI/T24HCe/e7QC47heFZfybGSxIP7OyrjNuGajAY671ZZmVHnbPpEukovL1PUsoPIX0hcWR4pGSWpNDq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(186009)(1800799009)(451199024)(6666004)(6486002)(6512007)(6506007)(478600001)(38100700002)(2906002)(7416002)(107886003)(1076003)(2616005)(26005)(83380400001)(86362001)(36756003)(66946007)(5660300002)(54906003)(66476007)(66556008)(316002)(44832011)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JZjZe4NPDHQB12n1mBZBytIOo5QArd0sniMMIjCHh5JF+krhKRHSMzxInQIh?=
 =?us-ascii?Q?zD1nyDvgbo5M/yexL8lElndGws2fhdUyx3CM75OKjka7z8sv3fOgZPkeJwqr?=
 =?us-ascii?Q?XLt8lWLsTfZDuqPJvisQPbkd/pAF/xIg69915zXCX/KwOS0+QaHCQgW9D6D9?=
 =?us-ascii?Q?iXQ5NLugWil3a43jrCYzBbxzRrQnCzN9aLsPXhEsrYqEE1XMs6PROFr0Myhd?=
 =?us-ascii?Q?7ZzruS58MxjcApwPDLAwixq0/W7ds1pzEr078TihhE8u/1O4aLrhKhnM4eIN?=
 =?us-ascii?Q?EcEpnGxioh5SR1qIMppfKAFrG9HbSLR22pvIGKozw4qH7nPFy07DOFU33QPz?=
 =?us-ascii?Q?z2vq1vJqaUkYELQqIiNRbwiPfTqDaDXONS2tbftRDeyWgvnrI/QALKzhHRAo?=
 =?us-ascii?Q?QJM30HeJ4D9DfXGmQWB4vt9SVp9jRNm/VUbutwKfF5hhqJfnbi+NaqcOcqjY?=
 =?us-ascii?Q?aiCpXDohkoT/i5gkEzIx+4lM1W8wija7OPLCQSfdLPYbqpFmlfZRGSzTGjSc?=
 =?us-ascii?Q?JjMq8vJ8r3zRj4DrMZ86FDuWlTPkUDkem+5E12WEOdGGhR7MqAVunVpgBxw4?=
 =?us-ascii?Q?jAlMO4a95o5yLAtFqxUyDl5GC8vg0R1g0XkvqtyTkkOKRG017eEQlfMyUoNW?=
 =?us-ascii?Q?Lu/1bAyAvstR/EGwH2huVF6YQrZA/f+L7U2j3c+RBa2j/i9Vr6dRa+Rs/rL1?=
 =?us-ascii?Q?DogSaMmuC81OrTnl3e0S+gw+FvltJXdCUenvONvf14HUIKFagrxdnivfR5Vy?=
 =?us-ascii?Q?1v9imDgx5p4SBc3R10c/sbdVyqMpHWJvuHfkHKCSJ4UUZyHnbgf5CEsEXLux?=
 =?us-ascii?Q?KM+yAPaNDRnA9Ng9cY+2NXeqguAUbbBHK7S/tV1qrs6BZK2wt2TxLLMSYhq8?=
 =?us-ascii?Q?7vJJr2PacnncjLHOf5Ao2VDyoR4cNUAL64Kz9efPSGd2oRB1z7tjOF3DdgKO?=
 =?us-ascii?Q?8L29hY3jttd/K8yUXThklvoJc7gbb09TmFZH3/IwKBwvzksJWteEYNsO9Dsw?=
 =?us-ascii?Q?8xokiguZBQ+yhqFvg9uRlnqbR8RIzxPTtcnWNMa8/qGHiAha2MXBEVO3nuqy?=
 =?us-ascii?Q?HA2lzZhPf4IjCrXOR90L79JQVEEQCwPOOBQv1sMjqomq+HogudzLlwGPtc8y?=
 =?us-ascii?Q?nV/KisF7+8Vy3uK3kfqgTNBPJrSemXP0xRGVV/L4gNZh7elzG4vNJxqdwqde?=
 =?us-ascii?Q?2/qZi5KJRgN6cyUEUa7YpVD+eAHvjVaiUWaHSRpTLJV9RfJLcse9PouWm0Zh?=
 =?us-ascii?Q?Y8FmDMpG8uSZInsp1GErX5Z2EKBzvnRMDMZhlnHndwmgs0stLu2/ODLKTOXP?=
 =?us-ascii?Q?2y7SD0fEjAybDjlszfI5dKVv/oaw33Jn65La/txbQXRO/K4ZAZt8Yjr4BEOU?=
 =?us-ascii?Q?fwN7T5bVDGgf8wjlrr10WIVRg+CEKkkJS11oX5SL0kNhkvPHGu3EklyBxzzH?=
 =?us-ascii?Q?wK4KulD53ksvrscO56oTAL9trzOmmSVXCThcWzX/bSW+Wfa2ofncSv9XztUz?=
 =?us-ascii?Q?APEHbMRHrsvrpwcPyoqosOVWoS9svVoFcOXVUHaFORbd98faG6YrF0R/Alxj?=
 =?us-ascii?Q?G5v6ykmqEpiPf3KCr4T3+j5fPCuTOJoWXrfLj2NbhLxABXBIFD2tDBxRKkMi?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Smk82Nyr/uL2CkzUoqSOXXpY9gfPg5ZgqL7rHSzJJtt0q2wTHK7FWkZa/I/E?=
 =?us-ascii?Q?ek+yNjwr2z5T6omSot61VGHpaPwxD62pcd16lIu8lViPk6IBGmX9uHtbpkwc?=
 =?us-ascii?Q?mAraz1caf4buXeEh7BK9wynDtSlavmYS8+0oCOFot0TpWo6ekME4r5ptMJUF?=
 =?us-ascii?Q?hm+dOj6ukK7HWb+WLLFzj38n1+wo71cma8Z0SZTbm+VKSftxwalPTY8qPafU?=
 =?us-ascii?Q?YWEabZ5GWqvPGsqMeJQHJhb9C5m9Xz9Ts7/VOXKK4k/EkaS/0xBAnd0rx/Iw?=
 =?us-ascii?Q?8NnojVlI9WU7p6hctddLzE2Oa++2leC49rd0FUMVLixTWfUuorxoGHPBAbGe?=
 =?us-ascii?Q?HE3TjS+72rf0zQ6K+Sa1HSzC6/jmdjsExVzx46S8BXcpY3Gk54zVqDGHRBij?=
 =?us-ascii?Q?LqYj1mkeM4RABOK2+4aufshS9+A8mWlL/fUkRStbNcVFuDra9qVb6d1SlymW?=
 =?us-ascii?Q?v2z3Il75FQyjhm0Y2lkELQ5aK4zKGmTnvwEIWtuYsiwAXQoG5qbWgKQXCYbZ?=
 =?us-ascii?Q?58jC4Smti9AwaBO27Dr5BjYxzy1PNmH0JObNrEl0Juik6Ooojeug88TuVxxu?=
 =?us-ascii?Q?xU629Q6vCodAddlKZoiAJVuXxVUwVJ5reNcEoJ8/vMjFni08G7VS9LigRhgU?=
 =?us-ascii?Q?Cpa6sF2fa8RrQ0bci3JjS5wfK/BJ8hP9E+oQ/LCKGIsC7Pz3O4o8274B5L5d?=
 =?us-ascii?Q?T6hd9KLXbg5wqmZJU5QAOZDXDZUu8VvVKSypsOgzVyo4iKgf75lvzJgPQ+JV?=
 =?us-ascii?Q?0EizpGH2hOnd/lFEFrieB92H4Zo6BRba6B/M86FiP3TplaZbitr2EQOqRcl8?=
 =?us-ascii?Q?tUC9kV7tsy0Lc6/wCaA5X4JPXnU6oTQv1vibxiu6nbV1/11aR6YJy6Vhll74?=
 =?us-ascii?Q?k6e1Vo4lpHux5jILz99KPdanh7Xmz3LiQRPQpb1wJLHd862xXZUouoetcqpX?=
 =?us-ascii?Q?xqFr9Bv4R9tixfV5QK8chPXpmXZk85a7MDQ0cgLhk5B6lZ9hzEVvsKvdqPop?=
 =?us-ascii?Q?5+javPDEmzmVhcZznTTUPh/xoUkH0NhUvHcwWVH/PKioiT4x3TCfApU81I5Z?=
 =?us-ascii?Q?6b4haBLseyRxddXv2sBC8fLE4W+3eOwkmd7nuwEExhGYm2bi0QyWdOEue6Xh?=
 =?us-ascii?Q?BV3ErMLEeEny?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5c52d0-8587-4bab-b4bc-08dbae594815
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:44:28.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euQP1sJItdXaHzpnawJilBFf/F/ihWgIX+LKSA2PxTbtqChC0CVTdOyPZvmlb7/MREywPAK4VBPyIeqx4lOCZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050189
X-Proofpoint-ORIG-GUID: bajyeeLebRXH2TAma_jZXhTUxp2Nm5OZ
X-Proofpoint-GUID: bajyeeLebRXH2TAma_jZXhTUxp2Nm5OZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Anything found on a linked list threaded through ->lru is guaranteed to
be a folio as the compound_head found in a tail page overlaps the ->lru
member of struct page.  So we can pull folios directly off these lists
no matter whether pages or folios were added to the list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a27fcff3350f..f768fe9aebad 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1836,11 +1836,9 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 
 static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
-	struct page *page, *t_page;
-	struct folio *folio;
+	struct folio *folio, *t_folio;
 
-	list_for_each_entry_safe(page, t_page, list, lru) {
-		folio = page_folio(page);
+	list_for_each_entry_safe(folio, t_folio, list, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
 	}
@@ -2229,8 +2227,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 						 bool acct_surplus)
 {
 	int nr_nodes, node;
-	struct page *page = NULL;
-	struct folio *folio;
+	struct folio *folio = NULL;
 
 	lockdep_assert_held(&hugetlb_lock);
 	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
@@ -2240,15 +2237,14 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 		 */
 		if ((!acct_surplus || h->surplus_huge_pages_node[node]) &&
 		    !list_empty(&h->hugepage_freelists[node])) {
-			page = list_entry(h->hugepage_freelists[node].next,
-					  struct page, lru);
-			folio = page_folio(page);
+			folio = list_entry(h->hugepage_freelists[node].next,
+					  struct folio, lru);
 			remove_hugetlb_folio(h, folio, acct_surplus);
 			break;
 		}
 	}
 
-	return page;
+	return &folio->page;
 }
 
 /*
@@ -3364,15 +3360,15 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	 * Collect pages to be freed on a list, and free after dropping lock
 	 */
 	for_each_node_mask(i, *nodes_allowed) {
-		struct page *page, *next;
+		struct folio *folio, *next;
 		struct list_head *freel = &h->hugepage_freelists[i];
-		list_for_each_entry_safe(page, next, freel, lru) {
+		list_for_each_entry_safe(folio, next, freel, lru) {
 			if (count >= h->nr_huge_pages)
 				goto out;
-			if (PageHighMem(page))
+			if (folio_test_highmem(folio))
 				continue;
-			remove_hugetlb_folio(h, page_folio(page), false);
-			list_add(&page->lru, &page_list);
+			remove_hugetlb_folio(h, folio, false);
+			list_add(&folio->lru, &page_list);
 		}
 	}
 
-- 
2.41.0

