Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF979315D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244557AbjIEVw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241006AbjIEVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:52:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A369E9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:52:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385Le64a021124;
        Tue, 5 Sep 2023 21:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=e7JmAFpN0aQBgHF7jZBKMPSyY+ViT4J/qMJefAZX8As=;
 b=JUkq20M9Z/PG85y5aDNZGaWkSiQvvjvyKilvjul+qewCY5KBOWJAliAtFpcTjyIQRRfG
 XGGu7KFj0Tiu3eNp1oI3JYoGxTFLSwdZ9VirdYFi/sEjeeW8ksLQzlgxLqg/SrICeXcK
 X/AcOi5bsPPyuNoGkP6C0Cea6f3pwIvQouUGb1uqr5XqcwiFVSl6oGctZpnVE3zOmTIV
 5DWqrfIT4HfYb9T0HsXb5NuOO5i8iVrY2/KqYUMSET9SdPiY+ZEjS1rtmkpve3gcGfI3
 R2T/wepGB/bHYBn80QMoL9h0s3k0EWhEppGbCkidMnojbtZmcrWSdAzpltlyBc0YORK7 6g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxcem80mg-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:52:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385KHWWC006563;
        Tue, 5 Sep 2023 21:44:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5u9b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gur55vx/uX1sroM709/Xjjk8AafjVoWaCGEiGducSlpPXxcoDyyjn7j387DFqXfb/9ZoKt1TQJj8AyYHyJ1Xqhx9s0C2kDj65v1y1KI4kivov88Gc9rxunfUKRt6oTuhDrWw3HkLZw2dErjKjQYQgr6fvf4AR+mqLB1UPlknxuA6IAzyVZqTc6puXo+9q/80mfQGjaKtKQjNVG9EgnpiGpbBGLKlFIJtLpVsFnZjD/SmIQylcFleDMe3oNkJgwHcNAZLIg5X3s03JSW3XbtkN2winIaHuoDan3442IMsQiVUPTnfJZ0L7u7Mngi1jciCg/xZBRhGX9N5A/wKaxevqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7JmAFpN0aQBgHF7jZBKMPSyY+ViT4J/qMJefAZX8As=;
 b=YuoithHQh9L2A4+kkWyX70ou/NyflIK8tuh0+4FOkgAO61ojATXcp9FnbZxLGLANWirx+XIDL3PQAxyvnIL2t+TAZ7mjV5pRYHw4Y7oXLePNaO6VnHVHhXsIgTdjIphtEpHAPE7fOcLBxxRpu0lmp6Am2bh0xiOaw7Vm6BueFo6WTYR2eMn869KtHYRIWp2pFbRh3YEmwLr8RrmeL8n252wuX+JJEjrqe/tVyjy1qUzPOw/BNeggpw4rmIG5WSeFldCuB6DbUBqC35R7kjHe/h+7anTmi4zVM64vNX0e3gZV4q4CQ6FYVrHD/WrFt03pb6JwFm9vTOZIP0j22qKmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7JmAFpN0aQBgHF7jZBKMPSyY+ViT4J/qMJefAZX8As=;
 b=xaRoojgLm49ElUTnzOHjmNO+tdawBGRiNwBjmH7hqRn2Bdrib4yIsW548oKkoDmh59J1cd5sodCpM8eKDqFIfiokQkbiE7sBEhNrPZcsnZBeKclEwUFT64vuRgioHSCeCnY8MmIeYh8OrNg2BL2G8KqIZ/Sm2RGtmqUAYtW0StM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 21:44:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:44:41 +0000
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
Subject: [PATCH v2 07/11] hugetlb: perform vmemmap restoration on a list of pages
Date:   Tue,  5 Sep 2023 14:44:06 -0700
Message-ID: <20230905214412.89152-8-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214412.89152-1-mike.kravetz@oracle.com>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:303:8c::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf5c1d3-30a9-4357-6258-08dbae594fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9KgQ8y7zZjaHL5vIn/DfUJrU2V80EFDrVY91ttiGaQY2UMsjUPztg2uSHfzr3tf9YVEjFis2afwvNJJGkhspIM/ssiWrfcZt8vuYK1U4z8Gs8Jg8XD9TlDvxnDwPQqDsrtfRxVk5y+UPJivEp5qV/oVT2xBmkSUxHGxB7MMzg3HqZYzq6F5AxH0GxUtyf/SnKp9o4cGQo/BD2cZ+OtVlQiRTt9nTzrODfn6DxZtNbFJcKlJbg4ZvaEVEh/IkcsEcIf+vXT85x/Xk5XxEFQSOonlrtSwnNCWiuS8IES48OaXYWbBnUNPofCpGDIDwjpNUsHyJP+tVoPcR2Sy+ks8G1SELEsvEsPvCBbKpXHEGdVyf7/viwgYShUOK8PwlWuhEXJcMh4dhfGoAIhoA6ZWDzURlPqEN1zqN8oLBEmqASluCpI/dxQcUiMtAO0YVmWvipum0yi9VdXd1UvR3nVGdXJgEwsHSGxyHxoRmi0FTWKtGxSZe5gkFxNAZQLniZG0sVYGIyudVsRtAYMczyHU8Vl9P4gtPoIThBKsUNjbWvyTfSv5QXBHTill82TXxxPD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(186009)(1800799009)(451199024)(6666004)(6486002)(6512007)(6506007)(478600001)(38100700002)(2906002)(7416002)(107886003)(1076003)(2616005)(26005)(83380400001)(86362001)(36756003)(66946007)(5660300002)(54906003)(66476007)(66556008)(316002)(44832011)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Py39vyL4NOo4znmyxkrIZmc25O5FXwqheGlQb+iBn3eHQl7fzeSjAUvcvDvy?=
 =?us-ascii?Q?/Sm6DaCa/lOo0Gfi4QkRg8s1aw6dDxJ0CxGuy+B1tKmMlEGjrbDihrHM5EL9?=
 =?us-ascii?Q?0k74GKMHMGpS3T7s/NMPtRG7mD2K63lu5lrcu6NLrvICiQzvFHrZv5Y3oo1p?=
 =?us-ascii?Q?lH9mQ/hju1nHJ31zLZaKlruwvrLyIkOSIHpNN0WMtaxlaIYoaOputnz6otET?=
 =?us-ascii?Q?uN5m2En9qY4PVuoLpBHaYomcAxH9C6PpRq+5gMYdxLlMr1tLC2zA7cIFdVKR?=
 =?us-ascii?Q?tq7uylomT+qd6oTJtsMr671N81lyoKWwfj0Vz8AGpUJAfOhF9/UIywihiA67?=
 =?us-ascii?Q?+ne6dEdoetImJmJC2YPPEy2dcgeXy2bflaoKa2nbaJQpB+vW4qG8nhGmZtX7?=
 =?us-ascii?Q?yXDRmyoTYNA36wTJOX5VKHJzB0po6aqdjMnTbE4VDEaEXrzBXJ6W570Mx7Rp?=
 =?us-ascii?Q?VX/eZ9mnOlcKOrclhYaRzv8eXhWBZLkhYaTxyEiMtsQRKMj/BRlEdPLpnR78?=
 =?us-ascii?Q?y95aeqEkDtlX42+jvx+Pfs3isYMLe56pTGeUhWks8YSJ0i1wz8rlAquxQ4yY?=
 =?us-ascii?Q?4McmLrRqCBh33PJ4zxZ1oghn32sjwtrQtRoO7trYTYLb+JQ9mRUFXsJk/FEP?=
 =?us-ascii?Q?qdncp8nAHo/EFs+kOjlDYadbsVUw4/cp6RIS0/MdRye8ABcLq4hVxbEC625y?=
 =?us-ascii?Q?Nois+N6rW3FgwT5yHQW10I+FwSPRUiBShPfq9h1wcv9gvW2ZC+2Xv1ixMG/k?=
 =?us-ascii?Q?5lYUeiH5z35kUnWLLcY8Whqd/bNFO8uENWW7gM4e1MFJNrPtk/q4mD3wcKJY?=
 =?us-ascii?Q?Na3goEMfk3pF409af6cn+iUa2Cz+YO/gLu7YRXsy4p78H7KHlGWKFCvwf8A6?=
 =?us-ascii?Q?1f1X66iSayLGplLZ0g6ejVVHl1WeysZ/+AfmyASz+njLZiKisR8M/F4vqWwT?=
 =?us-ascii?Q?T3FQ6MPXWZOJAJPqAUWjeWayLquy/D49XaprC5YEp+j4zF3KqNEW77GOhat6?=
 =?us-ascii?Q?JLcKZLuiTK/hDzdynV+lJ7yFyDXezsINDfLsMBQZvVnyY1lgVJLTnua8OBlq?=
 =?us-ascii?Q?beNHnOVQZh/d15iLq3SFEn/QPO0CLwfvp9hZ5kEKSUVXbh5caIFino7CAqa3?=
 =?us-ascii?Q?WZQKHSOSGHILZn2cHUdbQY8CXcyo5f49m14TgLa/AhZNc1icpwutQZdr/kds?=
 =?us-ascii?Q?bFL4dfkMpPQE2LnmIl/IJWO3dgzUXwg0xw0bnNjR6Y4qgjxCWdrp8xKE6src?=
 =?us-ascii?Q?HjxfNgF3qiaKPhbFfsoeqhISRRM8OOGpZCJs04jlq/+CisgAsx1vKeP+p+dZ?=
 =?us-ascii?Q?6to2yyfmctrgxuSASfVRyIz1UyuqoEKX1lZeC60kGgc41Y9cdDQ+1U98ky8u?=
 =?us-ascii?Q?20Rk+A8eLSB53d3eqNjp50FdE6kB62nNGrlawBTbvxGCu7xAnXM5OYcSFbKh?=
 =?us-ascii?Q?kLS4EnfFhwdMHEi5yETT7232FW/GkeoVwQi4GKdqiFK1i/lP96vhwBT90OLZ?=
 =?us-ascii?Q?RlU2ZMRirIONvGxkiD8VkdhWhQumH3M3uVJc6jgduxAFVZdOMWQPloY2HGGP?=
 =?us-ascii?Q?62n+iydzugjYnvk+ECV+Gfo/ApSqkiY0PzG7UER7mlx1IiXtO7Lk3DjA9MCa?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9jb6KEefcsU69GM5vdb26/qZwbV4lcp/URyWMRKO5Q1th+xXuSma/Kc2gGU2?=
 =?us-ascii?Q?a+l7CByfF7XMBPVd2QL2pybHPrjuHcYkMvoq4vhrWQNEvQDitspLXtc2W3Uu?=
 =?us-ascii?Q?yL/GDehApbk7udecBWOFWPAYHIItJwNZLkmvp43GXwPPMPzQPUsqT4Suwpuw?=
 =?us-ascii?Q?mRHggAx8mV5A1KTX81h89JkcaBPcOGGyar+YnF1lwpJWewejNZn64E1Ccuz9?=
 =?us-ascii?Q?5LL4lKyd/vxOvctBJHYiQrASTj0fKI7X6/kfAc4OgxZk9TQMDDng6hzdjiwX?=
 =?us-ascii?Q?eWBkB26sBVnKZYlfYFgsDN3cN9BFqp0l7ByA81L4XfqgxQgfZ4NB5Rkc13uk?=
 =?us-ascii?Q?uKmh5fLqWpKxTtSeNdO/4VatXoeYxzM/cebeMBDiSlLHli0snB3udM1ZDjqt?=
 =?us-ascii?Q?nOOkbANeRLQHFRPQK74cNbrhAN3gogiIFN/RMrCMuqq8o6WdAYGvXNqkL2S8?=
 =?us-ascii?Q?UKRxj2vxEU6a2SQrVKq78Y6+2j1T+QfnptoiSnXYtBl/ZaWkYVk+5O2yVS1Y?=
 =?us-ascii?Q?cC+ccxNsOmW1cWjgXvlpE6sOziRUjN6LnFBA7FWS0xxkBs9UC3+NvhJWu01m?=
 =?us-ascii?Q?Xz3IHwe/3bkxITM2cO7AKvz7FB5bE2yKCnBuSq9E6jsL5ZSN+mQPsX034NGt?=
 =?us-ascii?Q?lFxOj+SfNr9NmaYHCSMDSToI06SXGHQ0C8+2nn3kQzE6IV37z0vRqYbUoYNX?=
 =?us-ascii?Q?JDwSQAfklNTZBAu4FgQgMFHBdLWn+q5n2R01xd6NV8V1r5oWD1B+GKNUVzHL?=
 =?us-ascii?Q?YizxuroEXdw+N4Qz8zeK2y7f9cwPk0PbZT74zggttA04MFR7aPlF8f+d75z3?=
 =?us-ascii?Q?F8lSeBNWUwTXXqSTMWHxsXn3xt94/iwr9V3VCt7AJZfHdA5oEvLKCAIkndKr?=
 =?us-ascii?Q?0t1582fjWmIqFaMwLKmIoDhqUFeSWZUzkStmz6yYJLbk8SV8kFp/8XJ/fE3+?=
 =?us-ascii?Q?BjYgaEGB0Ew6lV8fDP9ezRAnHKm5vvP2Q43fk6A3HKZrtFaNDw046L5ZIWts?=
 =?us-ascii?Q?KHGgi71qSAVyX05l5jn4A1oowPS7K0TNeRXFMSrJoT8c8IbzDq/Kf/+HUcWw?=
 =?us-ascii?Q?d4xTz2+KL88BsEwhfiKlg/L/ypes8xIrO6kHTLHCfR+1TqQnN/u7POAxNj6n?=
 =?us-ascii?Q?BDdxb1e67ZL2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf5c1d3-30a9-4357-6258-08dbae594fb8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:44:41.7277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Evl8rM0NiprtqoxV4BYPYMXVuXRgcOvDLr/lBwGX+CMtMONLGIEZHc1ihZ+yPxArLCpHZCIlXeTsJje2bERHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050189
X-Proofpoint-GUID: 4O-z_C99ESvs9HZN75xT3N3kckjoy8SA
X-Proofpoint-ORIG-GUID: 4O-z_C99ESvs9HZN75xT3N3kckjoy8SA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing hugetlb pages from the pool, we first create a list
of removed pages and then free those pages back to low level allocators.
Part of the 'freeing process' is to restore vmemmap for all base pages
if necessary.  Pass this list of pages to a new routine
hugetlb_vmemmap_restore_folios() so that vmemmap restoration can be
performed in bulk.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         |  3 +++
 mm/hugetlb_vmemmap.c | 13 +++++++++++++
 mm/hugetlb_vmemmap.h |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 554be94b07bd..dd2dbc256172 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1838,6 +1838,9 @@ static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
 	struct folio *folio, *t_folio;
 
+	/* First restore vmemmap for all pages on list. */
+	hugetlb_vmemmap_restore_folios(h, list);
+
 	list_for_each_entry_safe(folio, t_folio, list, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ac5577d372fe..79de984919ef 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -481,6 +481,19 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/*
+ * This function will attempt to resore vmemmap for a list of folios.  There
+ * is no guarantee that restoration will be successful for all or any folios.
+ * This is used in bulk operations, and no feedback is given to the caller.
+ */
+void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list)
+{
+	struct folio *folio;
+
+	list_for_each_entry(folio, folio_list, lru)
+		(void)hugetlb_vmemmap_restore(h, &folio->page);
+}
+
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
 static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 036494e040ca..b4ee945dc1d4 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -12,6 +12,7 @@
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
+void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
@@ -44,6 +45,10 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
 	return 0;
 }
 
+static inline void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list)
+{
+}
+
 static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 }
-- 
2.41.0

