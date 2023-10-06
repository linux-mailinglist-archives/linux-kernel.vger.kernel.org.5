Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF8E7BB081
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjJFDWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjJFDVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:21:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09212E4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 20:21:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3962O7cs004502;
        Fri, 6 Oct 2023 03:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=FiLgl5+dGvdhCQpbuKeyP18InceJB4CZHOC4Sn8wCck=;
 b=TdlnLAflYg8Ww39hJKCavLByw8jIZFZ5pzPpXfOB81aUORbhk2TIXUwPpt0QlevR6j3U
 +NUgDo0/R/kCpfMoaEvh4ZVhIssjH125Pfo4yaFdtBEUJVNUzm5M9clqdwHC0X2IjNKQ
 EwvFZUN1v2KwilFHik9yXiCe/FrrBWegQgdT8VY1i5jDSSylx39EzabtbYzAN9rbt/jK
 nGhMPBYDlnXOmd3YPeOiHbAB9fDmPpJmJvq8HZIIUy4RcHllS3JfYeghR9hZDQyh3HvQ
 58w3JyLtqHhCBT7irCdCRXpSqeYhJVJrO7pnopuRttjgSA6J66Y6qDVHtP/mPYTxzzcq fA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9uk15c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3963Isvi008714;
        Fri, 6 Oct 2023 03:20:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4ahawt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZQCOZQpUhHHjDDkHVRv2pYljcsenKpzvi9+l7P35DgJJNyoaCN30RuIf7NpmgJWg/WKOyP9nIbK6GmPJwaGmBjIw7mFQUXyFaTLOb5iwo6wEF8i23GCZYjKFPh2M9ANk6SoF/X3MfnCCYfhtH+6BdDpL2vl5+MIcxJgve1b95wgd2Fd4swYs3k8+j0k1yFq7zSdb2fqBA02/NkB4q/e6me2O/DCJUpa5DQclT5/7DPCp9JLk72BbFkRhstJVNY1blfSq56Le6/XG1L9wkEIAc4io44QA2nZHxDUxN3Z4XNh2ZU6f6hmjJVDqpIhS6FMbW+eN7IRTw6aEN5k1G34/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiLgl5+dGvdhCQpbuKeyP18InceJB4CZHOC4Sn8wCck=;
 b=Z15LA5QrLuD+d1XU1OxM7CKWJ3t5sMcCa2Axii4U0ZOzhaAHBuN5ho7l5jSVeSKIgMbD8rVeCny6fmlj032d2n2wwj7f/4GKhPBmqDWTdHxBhqP8Z/INdDWuXKFM7QxalMnPh6hBxetpuuml3Ivh9XHzI9wMQ4xRhKzbkLCH47HOdxZCIF5FnUO9AvHXNDyc8aXknkyQAo1ux1zRLkOqtSL8+zXCXbiPC1sH3D2gtuoTGiGZVUGAUgXCifiRAGa/veunaATPj+M9ATimAzzwDBjjviAARhVZiKPYp8TWjDJvnO9gFtyhCmNim0vn4UI4Lroa3IH37MumnYkIxfgwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiLgl5+dGvdhCQpbuKeyP18InceJB4CZHOC4Sn8wCck=;
 b=E30BDezBkl0iroS/3DvHkHaJ7Dwc3tTbg27YZcercRDHA3dVEwjFR0XYjtULOcMbNiliqGR9YzTTiXYIIdRXhqWJfSbSM/IabgjFl5T7x13itQeA7QAStAFiFel6+f298UY9nkd4C00fiElZcvTAWiZLLVc2wH9AyrCwcI7+7S8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB6615.namprd10.prod.outlook.com (2603:10b6:806:2b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 03:20:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 03:20:30 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
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
Subject: [PATCH v7 3/8] hugetlb: perform vmemmap optimization on a list of pages
Date:   Thu,  5 Oct 2023 20:20:05 -0700
Message-ID: <20231006032012.296473-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006032012.296473-1-mike.kravetz@oracle.com>
References: <20231006032012.296473-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:303:6a::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c44c973-ba7d-4d91-687c-08dbc61b3188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8Qf8pT81GSXXkYF2F5YwBrYEY0of5pFJuzAIGys5eCoIv/WCQx0umZ20nFahqL9hXTN0/L1SseS0kZOqaIDhML93THcFEJg2/i91sOUO02IAbnkxflEtarve8x4kzMe47bzcqzW12gcv0rY+Sq3DtgjAzZaXpric+r7xBZtnLZrA0l9hf40IT6MqvG3tutNiQjmB/0gITjhgrlb6OPaTwpI++PfWARuQBAAEC/XvcfEazwBmMJOnDHNxGoYUPrJCM7FwhWWjpKO0FnJWnzFsqqD7HRKOKB8Tb0c9Ezyc/g1Ljv+Yb6fZ6Ce9xfCqsLoidvXC4mT5FG02dDy32hX4rfjDMW/2SwDjP6rKL8Gpn5d70iMGZ/6gQKsfFGYY4udC3SD8Me56BjX15G0aEDh4fmKKEPq/GHm9nsoxleIF2w/WGGsODy3fhKNPQEEcKenRTe1Yhq4okBHlpXSZUjhX+HHul3dPcOwbRNFfeqHrgrqFct31ZDRVapd0BbkSINOfgYv68bhzblLgDZogxdqUxOlvcDHLOkKIVc8YY9IT4J3WGNQTDuQjlAsTlfkTu6O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(316002)(54906003)(66946007)(66476007)(66556008)(41300700001)(1076003)(2616005)(86362001)(6512007)(107886003)(6506007)(26005)(6666004)(36756003)(6486002)(478600001)(38100700002)(83380400001)(44832011)(7416002)(2906002)(4326008)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FRTkTxz3gm90NtwPK7Nsq7Unn5wzfugGjK4veGra0BSBZ7zxXiATvg8YbT06?=
 =?us-ascii?Q?5YDGShCOL9J+86qRuSS62FdMQP3qKQGyCxUbUL9sfRxrkgYQ1qPp3uTnE9sl?=
 =?us-ascii?Q?xLEVRmtLtmgdhN8qpX5SvmTNqlotXiBmpLlkU9hQf/BxSi2ubHoDdYOszQ4R?=
 =?us-ascii?Q?zM+hWbL4qUg/uPRW7W9b0hYu4SG+hb+QOV2cE5Cu65DH8ZaRIIjoLw4tN/Kz?=
 =?us-ascii?Q?G8juY5yqedUjG1HXKKR48wuc0/88ANzKOyjFPgf2ItrxKixjCe7HKyYyFm1g?=
 =?us-ascii?Q?m8IzJxmalOHqE0+lSWmsJRc1qsApuX2jfP33JUerfKegUp0QSXIAhdD+n69w?=
 =?us-ascii?Q?E6PtopNXdRuJUocBCHAp92G9xkR1uKWach3H6Cu0bqjvFI4oYrhE03TCmdCS?=
 =?us-ascii?Q?ZKJFewe7VDRhXY0pmNh5EzNhaXY5RRX32P05kwROwza4r+nLYjyNXoXaxZl2?=
 =?us-ascii?Q?H7Wrp3LE9FsL8/WDMcXfx4GhlbcujaNDF/r4ODhvD6KDlZkD1BRkHeDfPbxW?=
 =?us-ascii?Q?4LZf5QCT2JQMvXDWl8ZMUyqr4OnZ21g22ygV8b1Zqm+sGfOgoyadPYYSmwwk?=
 =?us-ascii?Q?JIUXwekjednMWXHj+uG2Tx+dwRTG1rCyQ1mNLWqkdqAJiGCrapzRMHXiQInq?=
 =?us-ascii?Q?9um3UNrV0UrktJVUZhMvf2R1JFlFPrPz7ymWZ312dGNmNYqpYRW8uwQKZxwh?=
 =?us-ascii?Q?W/Z+kBf7WA5ts8B5UwXFyy03ypMpozd1iMZTU2M1wKwwrKb/FbSL36e6Hxoz?=
 =?us-ascii?Q?BCcMuzVCNt+3BC8UEocRvK0hNymTdrwalTDfN/ToOjRMkLsIc+kJCX8oCKdu?=
 =?us-ascii?Q?07EzJD925860m72BcVPmqMITrvnv3bP4m2Dggqjb5zWSvK9fzh/Zt9/1/OU6?=
 =?us-ascii?Q?4+fBvrQ7Kem1oZlLijOplhPbV0FL73HWoSgAFEQyOfKQfYzeyPWZzO8DrBmx?=
 =?us-ascii?Q?Zf4f4MTTz8tNJJWGFuj6bgupfQ+WgE7nLqTYyrhA4/c813A6tzLDGokBoqfF?=
 =?us-ascii?Q?08nW9xTOjjsBf8nKlc3CtYNSa6c+mbxySjf5Cf6fJSwzdXQbbMNI/6wpbcBw?=
 =?us-ascii?Q?nu0gtzYfpJBn9vC27KcItyyAEhWZUNXYnH4dlHCu0wvOmFY2+XFZ08y00QiN?=
 =?us-ascii?Q?c+32WG0gWcSNhIMAQiaz2dd+h2Tbw6eKVuKVVanDlOB3uPnwkCU3o/f11GGV?=
 =?us-ascii?Q?Lppih/xzqSsv/+XbJO/J/CoJNPneTzqRferChbTptpMzcv4YOf9AK4XrNL9Q?=
 =?us-ascii?Q?6xySZVgv95WhBZhUd+8hkAF1/Ulv+SgH2FbpcT/8BCwxFqLZAoPQ/zdpxzxN?=
 =?us-ascii?Q?adCAXvp/TAahNqS64kW2/PMs/w8OpsZ26ixw09VM1N/ewYEB16maP3+xK4EX?=
 =?us-ascii?Q?/SHxxpemRRT5jT1+dZqIhIPZMQAEt9HAo7fuzyP8EsfI6mZcJZEP3a9eoQcM?=
 =?us-ascii?Q?myGovmlyB2e5ACDb6uoxb/DqYl58os9wzA/wJaUI43o/FwGJScWG2CVSI/bb?=
 =?us-ascii?Q?YuPrh/VorxVzfblcwQLQeR0dRQBhk9pYwdfikcnKIK+YnmJaVgTZRsxsU1Ga?=
 =?us-ascii?Q?w3wcCGwdbrT+jc/T8n2ptNK2t3ddIVLG7z5j3s19?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QHXCsKytGmI/APSq/c++lAA2f2V7cnUUEM1GzUgEFlKjvD0rxjT17crxRXZi?=
 =?us-ascii?Q?fMc15hFiV6t4msRckYMvkRvLkzlb03IBXXSyjp2sKjBlkLi62uAQdKldfBvj?=
 =?us-ascii?Q?IypI4AlhMPred/jFbugJ6ih2qUAyOHMh1+Vyd5tjQZp9ngUTax2S+uqcPL33?=
 =?us-ascii?Q?1Mwlvwr/kt631zuqGdxE5NPatfV5YDlV0oyIJan8e+jjhF5J3Jx+wp+f1bPo?=
 =?us-ascii?Q?2yMpoNfUZnIDD7QeagH5pKcrTe6bDEbuTPCkBARLcweJlEngGXIkqpKSb0ez?=
 =?us-ascii?Q?hjl7JKN+B2xsDo5MijwHqfH5ICIFqmqKFUvM/oRiLcFiF74VWInGCkaBsQXJ?=
 =?us-ascii?Q?U6foBCGtEdLNDH8CnDhYg5y4zo6lQdMMVKahkyTHOty0FZI071ZH3USramFs?=
 =?us-ascii?Q?HPB44kjSA85hnA2ROy2Vn834A//hUm3dY2xSWQDEMd/tEfPmCCVeVhxAmnF2?=
 =?us-ascii?Q?l6ecAMj78ShEfmP+6W5R7arIXVNy6q+xLs008ygdNh9842d5rPoTO+E1TA5E?=
 =?us-ascii?Q?2/WwAJS2JZlluL36124RrRjlCH1M94hSrmcQ6D+ABm0xMxtiwr3SXU6/sjeH?=
 =?us-ascii?Q?9nWuXU3u1V9KvoF6dbRxNYaAbHq88ldC7i9w6mbGRaHQnzmxmvNcfgKlo+UZ?=
 =?us-ascii?Q?WfTyFCMMm1fmgubGqfRNwBoIK5a5YGNSok5nkQiWE9yzmM48Qawd0evtwgd1?=
 =?us-ascii?Q?02dUjF3VbQMp4nVGnwCOwglzsEVKCoqts+cCw1pprKih6yZlcaF9pvbTBpcR?=
 =?us-ascii?Q?k4Leokh0ACrO8jS8dhxwxLznO5NQKrouZLlQhi5oKxss1iOi1r2vYAikcQ98?=
 =?us-ascii?Q?b36w9P7Ul5acVomjEpKmuI7uvK6r1F0/uOZr7bbaN3Icy888ax7g4mU+329W?=
 =?us-ascii?Q?9m0WGMkZwY/xLQUFVUs1ilDnUzX/QMen4UHxh+evvSa8EP/FV9Y3BxwjDvQG?=
 =?us-ascii?Q?O2f9BuK9jfDbhl/oRf+9Q5mDQSzZkH9mzYHuO+OeS4aBGNvO67rY4KYIBwCk?=
 =?us-ascii?Q?3YEgc44e3P4D2dSPmIDkkNJCiOrf/GDeYfbnfp0gCiWVHNyHkGCjPsl2EGlz?=
 =?us-ascii?Q?hDiFAC0Afvh5IKXq397M1jTrEkSXuqlhtT18bW6rJMN0YQjc2gY3RC/g4FYS?=
 =?us-ascii?Q?irDJc5OfsUjoEp8rlaaxwkof5i8u2GozYA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c44c973-ba7d-4d91-687c-08dbc61b3188
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 03:20:30.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMUbCMxxC+h7Un2yLot5dzYblEotCo47rUDWcQf2blekbtkPa/q4Imzg5W6km39qbyRTvUR/i/UcSGDHkK5r9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_18,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060024
X-Proofpoint-ORIG-GUID: nE8fvQnH6Hbh3Ti7U5BawZ3ypMOM8UWy
X-Proofpoint-GUID: nE8fvQnH6Hbh3Ti7U5BawZ3ypMOM8UWy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
index 4ccb54824daa..2df9435afa48 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2249,6 +2249,9 @@ static void prep_and_add_allocated_folios(struct hstate *h,
 {
 	struct folio *folio, *tmp_f;
 
+	/* Send list for bulk vmemmap optimization processing */
+	hugetlb_vmemmap_optimize_folios(h, folio_list);
+
 	/* Add all new pool pages to free lists in one lock cycle */
 	spin_lock_irq(&hugetlb_lock);
 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
@@ -3287,6 +3290,34 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
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
@@ -3307,7 +3338,7 @@ static void __init gather_bootmem_prealloc(void)
 		 * in this list.  If so, process each size separately.
 		 */
 		if (h != prev_h && prev_h != NULL)
-			prep_and_add_allocated_folios(prev_h, &folio_list);
+			prep_and_add_bootmem_folios(prev_h, &folio_list);
 		prev_h = h;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
@@ -3315,12 +3346,7 @@ static void __init gather_bootmem_prealloc(void)
 
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
@@ -3332,7 +3358,7 @@ static void __init gather_bootmem_prealloc(void)
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

