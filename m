Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3D0793137
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjIEVqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbjIEVqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:46:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7127ACEF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:45:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385Le63d021124;
        Tue, 5 Sep 2023 21:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=yVlaMs/R0uxiUc/o8fO35CIz9nL9E3sdhKpFc0sSIK8=;
 b=RkolEh496gTipOdun4pnsqw1P65/IK5KOUq6kH8XpQXuTE3OzDrZ1BGRDK8dz3t6wpj9
 I2nZGSwoEJhz/iMjOQixzJ/VEpCpGfGSVGebpYAYiQcBfEknRgx45gZfhzvO8tQ15hQv
 vOY55eUr9sTzukPIh8HGCE4j6d4sfHU+LjR48IDrJ7bqKStI5aVyps1LfYNzHKappmqP
 Ar6PBR+A79is5PQyRdLXmDCKp2D9CH4WwjrmHGXz5BmoNo/+1P+clX4FKEVgpHxJm66E
 j5xH2N2EQQSbB4auCZ59wzOSGtww/NV4bcrxWMJBuMD+nUrbLW8Xnnn1GpHiaZ/cOIQA XQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxcem8073-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385KQKu5029067;
        Tue, 5 Sep 2023 21:44:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5b7hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9qzwMH43TCzdpxVvNzxpM5oTBSW6nuncQW9iQ2XzpaNQpp9DjoxQb9X99D6j/YejpD2AQPZiA6YHQ7l8Y/IWXrAKm5xL650XUbAimZ8GY0+ACHq5RSWtJH9MocQs1WOLxtYZrXHRlnPmTzH7MAO9XBFGh8nZ/dJFHBiF/oKnZV/Tv1D9DvkKqKM86Dtd8htN3jf18lZDwvla4iGPoFDnlXmOu1ukIrr/JI803r/Ys2S9BmA4LF5b+5M8c1ejupfull7zZkZl91QPk7hv1kUEZNn0DOcjXQP5BSEhBYqBiuvL5e5rn/Pc+JgVVeEPJ/HxVQkWwRCxs1xkBLElMYObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVlaMs/R0uxiUc/o8fO35CIz9nL9E3sdhKpFc0sSIK8=;
 b=JlXIccaC/nI6POnztrhsR/36R3Q268ENb7rTQp+OcUoo88EX2esyWLBYJV252lQYXfoNZxbdyoEEDx+BZ0EsH8n0NML1b6w4EmJvhU5mDn4x45mJw6Dgy1sT4rno6ofcUjAk+AX4ygC4HfUEXE7kxU868GjcQVwFJuBrgHCiUNIk+U18I81ea7wZFqQ8TY+ZIOpz06SD34OHsAiBMhI2sA+RE+x5bq50BRIyG+iB1eOO/2ZilhOteY3kZtSQtGsLt9kN4xHB6I1bt1cYKr9dCtamAEzc1QEjFuwbysA39gr3DtWufpi9pL9AsO7sKUlkeLeq1rwHsmrHQpDEdi+WyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVlaMs/R0uxiUc/o8fO35CIz9nL9E3sdhKpFc0sSIK8=;
 b=VVBk3cnEF5aT3xlkJ/Dsy3SjMQhxjp9QCvgf5hXoQDllCCcAwvIxqXlHTwTdHw+ja4vYy5NOdKnZust3hP/i5XeXb+HBi79pyUMT6GFGv1wGraXXXJiAIX3XMie3CVPgPgLdTjX09yO7iC88G7jw7GEU3rWA44Yn+5/l2wHiOdk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 21:44:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:44:25 +0000
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
Subject: [PATCH v2 02/11] hugetlb: Use a folio in free_hpage_workfn()
Date:   Tue,  5 Sep 2023 14:44:01 -0700
Message-ID: <20230905214412.89152-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214412.89152-1-mike.kravetz@oracle.com>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe4361c-fa70-4091-9ad9-08dbae5945d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AB2w0estCYVBlRwZOtCaqFE/wR8a9kqMwre5CEmjluwBvXK+TbqrWRumdO8AQEMma8Bvp1o85BIcA2RRpUZ+nQDY5ab/xFU/6jeiTHkBKengO8dyT3REOwLbBiN9AaubgBKUfDcPfL7o7ZDY1/L3PwPimtupJLA+s5iXtaitFmuhl7zqkZaDuJ1UttjPiyo8PBHIE2fSGriGZDlR/D8VihVuW1wRSt+Arud8Q9Ihl6cPmv5uoPNAsLXYJSuBm9ndx7/i48aT7TAytFKQPK4V0Bwd/Onth2uPzCqW0mgSZyTjhyIV8QHIuBZx/Ey+hRf23C5KfARAInBIp9xOLsnWtfLSCRthwELUaYzhXB5HGk2pwjE4kIMmJUd+NfiATUk1va6PQIH9p3yoWtxa3BtfvlNNvDPRXGnkvF6DRI/EmZzV9vSBKcLxhOqTq2mz+bKRuONfURu3yAETrVxR68KVsPWA1brm8zsXRN6uRw5mmlXWp5SJURBOrUzRrc0+05ps1FEGo9UF9kDFdHBs62Sn1x8pRs/93QUfXIPvYDjTADF/VSxSf0iYKediX5CBaa6p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(186009)(1800799009)(451199024)(6666004)(6486002)(6512007)(6506007)(478600001)(38100700002)(2906002)(7416002)(107886003)(1076003)(2616005)(26005)(83380400001)(86362001)(36756003)(66946007)(5660300002)(54906003)(66476007)(66556008)(316002)(44832011)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w7fTVelco3+AE82ISS7lyIm55XYbUTUKbsGLt7dWl8d1u8txtJ/fI0p2+2dH?=
 =?us-ascii?Q?AjfVAQY7V1wjrUGhsoa1aVWYbPZ6bTYGxoTIQvFszRViG2QIExxmP/mNjq49?=
 =?us-ascii?Q?DmP/hpdECZf5ARA+87TOPCPCwTA4g7FPZjFiPfQFucWp+IHwmfuvjk588ncE?=
 =?us-ascii?Q?ZJ0ft35w/OhPA/OqbylaUZxnC4AOzx0OajjUVkdoUus2FwtcxSCXzXttOzWT?=
 =?us-ascii?Q?2A2610+oGyEtPk7WXJIROHbiEC8gIrHEfK6eX42M6Ml1AFCoCh81odxVbtnb?=
 =?us-ascii?Q?4dRHbquwvW5B5gfq0Ba/Bb8vpRaa9TSSLj4kXS2l97PUQtwlQmuhvUOmaz81?=
 =?us-ascii?Q?7WS6nV2aSq0zqxXdCeL6uZCUGH/lp6mOMHD0L26MrN2O7VB5ydG3SypLxUKf?=
 =?us-ascii?Q?FwPhar3b5KhFyqlBGWbmOtE636+JoS/wj0YIUPqR1eK8BAjvSf8Qdcvo9T8j?=
 =?us-ascii?Q?5GYLcI/v/5qfnGk5P+b3otV1ZW/5MMtGatBtUIaWzmQEBJxCWLkDNBGmPPn4?=
 =?us-ascii?Q?R8wrxViA8ZB5dmL8j7vGsvh67ON2QnZ9o3Gm+Rzlc2LghCFdIiaXdnzc36a5?=
 =?us-ascii?Q?LTyLdPglwW8rgr8/8o/ROl+Wv45X9tfiZjGlFr5MiK1uF6B17LRvCEnKqgas?=
 =?us-ascii?Q?XC1ygxcN6kuia+8XPmfFmZbsMLSPxJXFn3FkB0AXQv3QAPGsB0MiUxtdrJ8c?=
 =?us-ascii?Q?ySOPN5kUnwQOAAFW9uRwM6U7apGyZc4sih8wXWLtEPt7qY3P7LN4NXJuRzkC?=
 =?us-ascii?Q?08BrTKGl4SSV4KpitUuCBZULozaJvgNeZ/9ZC9x9gSd9X/YMO47NVom2wj1H?=
 =?us-ascii?Q?xEU3C7euO0xq2PaUvQaSmwGIneGsBLy3r954glmYjr/Sh9AUoZB9f7Muc8yI?=
 =?us-ascii?Q?+rQOxMw8Rw/+cte0QdqT7FJByuBLghU4K3lBIszUnMQ16X6YgVyiYU0pr7BE?=
 =?us-ascii?Q?QqW613c++uSwJZBg2Ik4NT+2eU7ArYsefDBprkEY9AEHQvIJeCnkYTHe5Fn6?=
 =?us-ascii?Q?VAsLC3yQKqZRW5yMmaA/Kl6nnl/74SVDFOFKDuOaEmyfwEPcMDTvf5GGRXx/?=
 =?us-ascii?Q?ldIaHs96KW+RCeFrCNz+cXq4pK61rVcs1ZQEl7Tgf5TgzdMH/8J9X/aVyltU?=
 =?us-ascii?Q?NHiW/TjlzvxJQN+VC0+txwuqRRO+g5vVe5zlBHhAPYeAi2+Uq/c7cfIQyM5k?=
 =?us-ascii?Q?7B+7+09OfyXyrDajsH0jXc0RThYsRi7oVXs70E36iAH2bni1ufXSiwA2HC6M?=
 =?us-ascii?Q?igcq5etIoRI+AEjD4hOqT+5lV1WSwDHsuAdKj/rL1wDhPCsItV4YIfCS1Cle?=
 =?us-ascii?Q?hsJs6Rl5CHo61epsa/DqgypTo0aAFKR8AJaMm5xU4rfMrmhByPE2DqKoh6HN?=
 =?us-ascii?Q?xiVALI1DZm5ElsA1URYSFEf6jawm6U5of8BnWrIUswS8MzH1W9+AvBweWvch?=
 =?us-ascii?Q?QNEDuwfOVeokCwq6gYlc1elP7Hg1Yy2s7/7c0Ag9PB9TrLOHnQQaypAbBEm4?=
 =?us-ascii?Q?Fwdh34FWNmSx/AhQ9i3+lLSXZPkDNnBL1UIAo+ANCOXmwKvXLnRW+vNXGxos?=
 =?us-ascii?Q?nAibVPcd6IIERgtAlthViTSVNr27EzZrEHoqEa2MpwTwxscVkqpHtYGp7I72?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2ChgqEdGdpo2p6cFzd6zENYWseDfHHmb5NRzNLOAqQeLCIW+ERjMg6EI9nUq?=
 =?us-ascii?Q?wybw6oEQHMrbeLLZj2n14G8Zjof7YEbdILvQEhUHILa+lvLxD7y/C8fj7oHG?=
 =?us-ascii?Q?H1uCELjvTzpzBOuOHLuHoQNRsX4ZY7f7UAOYtn56VpTFOCbQFXLpZvXEZ6JO?=
 =?us-ascii?Q?TmgQ/THjNZUc7Eh6acyohp1QiokBuCi3lTmxl2N6aOCKwm5bj5z2WQUx3+Yb?=
 =?us-ascii?Q?xpXcDyuV8uY0OYCqg5Rlc+5a70ZVS4i5em3G7iXigAK+BiXmsZAaesL1qP21?=
 =?us-ascii?Q?5Re11TC71ezZSDy2mwn/JMk9hpmOTuq7RoWE4fY5aaK1H4EsEeTMv+pqB7GY?=
 =?us-ascii?Q?m5pUS1FynsMUDusUgdXn5p25zaWjN1T1XDL9k/KJg6HSorsTdiOBQkbT2/9q?=
 =?us-ascii?Q?TX7EXqv3HDA7vO2hQ9RF/YZrzK83MHa7BhaxDF5AilABOwXSQdAM6Zh/gT1J?=
 =?us-ascii?Q?C1wu2R9IAz+liRNWzyhcacut1agqpjZATMYKFEFa0BDnH46J8SS/n51wTNSK?=
 =?us-ascii?Q?572o2+dhZXIpvONYtEIpJWaBc4t3n5UP80FIkvVd9oxhE+568WU3JyYHwUu0?=
 =?us-ascii?Q?s8MsvkP9bMSXxk9ZAH83T+Eo+Y6kKKd0gEU41Artavu2ckronVLd6Ltnfs2F?=
 =?us-ascii?Q?pRbaNlMuOIQMrzktP9zLiunye4UJIJ5pxrlYAUiO48ojaJbk2kjKXH8FNvX6?=
 =?us-ascii?Q?XJOCH+mzVLKsha4m9X3giSid3OQ2qExaM80Xoql6wfZbCGGjQzExYz34rAm9?=
 =?us-ascii?Q?96qNY3sLmoTPmciZS3tH/aFde8a8mVDcMlvpp73pQqa1ka7TLr/M7B6oj/qv?=
 =?us-ascii?Q?qepoa1ymjIF/xAuxV1ug1iUU+yn4n5nmkt1zOApdhn/EDN1Hg7CH5BqDVud4?=
 =?us-ascii?Q?6uxwqSbPAGFxEqTTtptlqB9/SYlOhJUQUm7WbCIWd+yH1Da1fcGGsDK+rpI6?=
 =?us-ascii?Q?jWkLnzb8CSY4DmzQnwvWo6v0/azltAKeKt3Bl3GLiggx5583vZelh5i/r2PG?=
 =?us-ascii?Q?taEdRlVgg0NOQzdjM7JKmuSGgKqvlrCOQVmV7wtSsuDr+oVsG6aobtcIzKQv?=
 =?us-ascii?Q?xjqUXDGTzHNxhf5wMg2yUKZ9Vfcmr3vO/JT4ytQ6TokV+AErGUZeVzg+jLoM?=
 =?us-ascii?Q?gNlZ5X1iboVe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe4361c-fa70-4091-9ad9-08dbae5945d9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:44:25.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0RwKQA+y28CsnC4Y1ZFPxONYZcwP4nuebOgWhxQWbsSXJJzFEjUXVrLBkpmehp4hZ1mHl1iclPszYQhbPYZ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050189
X-Proofpoint-GUID: Qe1AYxgpq0jfqvl4WZgFn_p4iQrR9aZl
X-Proofpoint-ORIG-GUID: Qe1AYxgpq0jfqvl4WZgFn_p4iQrR9aZl
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

update_and_free_hugetlb_folio puts the memory on hpage_freelist as a folio
so we can take it off the list as a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c32ca241df4b..a27fcff3350f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1787,22 +1787,22 @@ static void free_hpage_workfn(struct work_struct *work)
 	node = llist_del_all(&hpage_freelist);
 
 	while (node) {
-		struct page *page;
+		struct folio *folio;
 		struct hstate *h;
 
-		page = container_of((struct address_space **)node,
-				     struct page, mapping);
+		folio = container_of((struct address_space **)node,
+				     struct folio, mapping);
 		node = node->next;
-		page->mapping = NULL;
+		folio->mapping = NULL;
 		/*
 		 * The VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio) in
 		 * folio_hstate() is going to trigger because a previous call to
 		 * remove_hugetlb_folio() will clear the hugetlb bit, so do
 		 * not use folio_hstate() directly.
 		 */
-		h = size_to_hstate(page_size(page));
+		h = size_to_hstate(folio_size(folio));
 
-		__update_and_free_hugetlb_folio(h, page_folio(page));
+		__update_and_free_hugetlb_folio(h, folio);
 
 		cond_resched();
 	}
-- 
2.41.0

