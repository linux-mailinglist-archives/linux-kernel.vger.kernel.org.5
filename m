Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1FC7A5606
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjIRXDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjIRXDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:03:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337D3A3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:03:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IK3tGp022240;
        Mon, 18 Sep 2023 23:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Tho8Epjh8mRVZoDoy8kl6Pit3DdeYADq24TrqH7Ykds=;
 b=xfH/dLr41eJPlIGv/2v9cb9frZrE5ij6+dFdRTWIA+WlD7bFDNwBcr3f2CbC/Ih4pQaO
 gdU4JkCAhzXE6xD33PU7Hqn490VOQXxeTa3yVaD+hNhIF96Srfhkk+qPI/xgsuIyZ7h+
 bcu91M8zJk7FlNMbqbykjluHDboZqwK0zkg+jGWckMa6rK9VRsQ1BuAUzfnbSkD4NlPc
 qGw1WKmz/k9mWC/Snbgx6kxO8A2ldaL4N3Y5UQZ5nb2MYlittaEBdcCtusavHQ7WCxjV
 /9/XiEy1wkR20uAAV7CpKNz1vrUpPc7jWAgj38c17R9SpyXsU5JQDfFqPVA+qvBqeeqU OA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53yu3m9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38IME546030108;
        Mon, 18 Sep 2023 23:02:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t4w01k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImsJQcVpSPEZ9nMN6C/WQMG3N9M9xMY5Lb/0KlvFoLKU2hrtscIXingi87dkRJ2KKIbSqcabN9+cH6Brg2RHxV0h88eHMcCvtxvAl+qmGLJKVSIsFPKYOagL9eYbK+k0Q1aAp0Q4LtuWcdZ57q/2iSPbNybrRkmSC1oLp6nMBmuUF0Y9PVp/xStR1VDsaTet/AvhX9wTzz0GsxHOh352Q1QphI5rGmaHcibUA/RlEEZ0Vp4QyirpvrJe9QW1JBD/ZezCl5OsQvrRq7qcDcBBdoFzlIJwf9aKF+/rWFgaxX46rU46E9fkn5Jg9fxbb5KXaBj7f2Bm02u3EQilerB5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tho8Epjh8mRVZoDoy8kl6Pit3DdeYADq24TrqH7Ykds=;
 b=fzG5TWBjbuZWFSkwehjU1GRnpLmso6NV8AzAfv/BIQ9xdoHNvMK/PLB7EGGacnioJVodJn96mg0KFZL76TglzjLOgHK+gV8DVKn/0Th6z7Nove5P47gJ+GkhIS+QPz2kk0aO1e5gkQEniGxm/nwmre4vkoiW7l7/CgDt4fZFLpCGgPjMjqnaIjbhMbUxWsutbeEiVYIx5nr4/h1YIkrQA/+FKQnQwV0OIKJplN4LAKWx/CGFbbJ7SbCCISJR5hO+RmYcwx3dXrpA/93oyqTO+NZqoBzdGGYU/Wk82NO0s1wcJvlN/AmmRwH/JlxRxfEQa2Dto4zl+L1Mdhz5u02wWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tho8Epjh8mRVZoDoy8kl6Pit3DdeYADq24TrqH7Ykds=;
 b=LUjmyRYksG6hzcPvab779EeUhkVuXA8Me401sQmvcBH1vzY8b3cY+7vigGxm0PO0OkO+PlMk4SLY5I57m6VOqZtj9kfL8ba3rcPwMMfxnoYGu0sTFc9/vfc+lkpK8V6MzBVs1tSK7XfJaK+9/fa1QExb0Qcqjq3rqAGWvEHeJYg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7494.namprd10.prod.outlook.com (2603:10b6:610:163::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 23:02:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 23:02:30 +0000
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
Subject: [PATCH v4 8/8] hugetlb: batch TLB flushes when restoring vmemmap
Date:   Mon, 18 Sep 2023 16:02:00 -0700
Message-ID: <20230918230202.254631-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918230202.254631-1-mike.kravetz@oracle.com>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:303:b7::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: e119b49b-f7a5-497f-d71d-08dbb89b55da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ww9F8trYswgoyFAbQYH2FZPQljNDVjYBxjSUyvj2PtANnsS1vcX88tj2ZJo3Tg+LIpBirCUM/vx4OED2zqeqP2BFxjTsubg/pHfjLW+uSNYEMaX/8sW/Z5s0NpBSQXyXDcwm9pJT5zcHTBKAL5SQ7KhyTrdGJcCEaeppngtC5iIriSGtT9+NPUwEuI+9CqFmZ6E2OTcOclmvKuxC27m/BUgvoFuriD9f+3XXTZa28jsokVOq7sMQVaTxgw8ZEqZW7GXFHQiAJs/FSyACAV6ucRCEMlU4MzhyzdfeDr8mJhGQeNm4xxd9jM28ba43a/i3lf9Zm9VmkV1ZJgEFLz8EyohhqsZQxR4/h+ldxCaKrE1JRAwxtMSgML6K/Ch7Gl7o5RzcfLt7/judlrNZMJJ6dI9vCpyZBjuhhOTW5EOrblejkdnpYj2cx4K0CkjgamWM4pjMVdc2FWpoUt4EdoI+o+wih1ACX87e8QxOFHbHiNOBHnLMmjdBeyWFGVtuBNmp/AXuEiWielb5fmK7hFPESxkmAzs3q5lPSf9XLaY+6W0Fs2q5ePTQInT+pOJ7x8L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(41300700001)(316002)(66476007)(66556008)(54906003)(66946007)(478600001)(6666004)(38100700002)(7416002)(2906002)(86362001)(36756003)(44832011)(5660300002)(8676002)(4326008)(8936002)(83380400001)(107886003)(2616005)(26005)(1076003)(6512007)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A/3Zq+/zrbCtPuPYIH4+woZ/4ICems1T0AVkiTh7qX5aAIjvCFHxsk9O5f6k?=
 =?us-ascii?Q?vGZ8ngySPN65GqAlNHVW18jI74/vtHUtA4gXjVo4sbu+GXJ4ioPKwYL+sEOy?=
 =?us-ascii?Q?pTcGlWdLA8a6YbJ1qvtyan35QGhJroNbc3nAN+HtgiXSnRNGNEMLmw43IGKi?=
 =?us-ascii?Q?MFXtHE4xHq0v2sbalgZr0+1q/uhOtlrJtI7VBkxRLx1mAASShzNzfSD+Pt4k?=
 =?us-ascii?Q?9TD1LR2mwSutcdH3wVnKxcIYism3rD9qWMBJyejYKvnJDAq3uRxEOu/SuUeL?=
 =?us-ascii?Q?VcRGn1YT14J3+YNPUyJi2w2BjkNH5XLbwfJQxqRrxzDUDJTXHEk7CBlLcwgW?=
 =?us-ascii?Q?Gr2fb2VtmTgNdaPKrlqRdyRfwRkEgMqqviyFs4tPwU9nHqbHmzxWsHF8FY9j?=
 =?us-ascii?Q?/UCiylNorpooYztd1TKJdtPcBdQSIM2SoWoyhez4Rbfs/lgH1NEA9o7gL0UY?=
 =?us-ascii?Q?+GgR/RBKIJ4wnhOUim4s03lZ1BW/zHTPYxDDMWHNtq/DksDwEuhP7jAZsN5D?=
 =?us-ascii?Q?pDGodeJ+G89D1njVIL3y4n01TtAj6TiDSXjwDSMevJYfk2fzlgmMzgTWwVOf?=
 =?us-ascii?Q?AfdoRzYV5IAkQlXZG5otvBA+quIqQ6Ili+qdburF4l59Q3jnDYeR4gk/YJFm?=
 =?us-ascii?Q?5VUvEwJuSgMNzwL+LNibVYcnGKpjGi+nrls6UioNXB5yvx3BnWvU3qYRluEb?=
 =?us-ascii?Q?6NBH6nrrg3P551xpMDC6AYYVtnVYPMTwGUlRsm75k0DYuUBHM2Px+sHbkiFF?=
 =?us-ascii?Q?hOfItyen9oL7sG4CVNKsTkh5xeh9UEASYK5DCy4ssSHrfpMFYcs8VB3dZ+IZ?=
 =?us-ascii?Q?c9TF/lVHBfk7ttFHWMo1nIgmLr1oDUwzT5yTF8osKDJeamc0KAxWviOtdlCm?=
 =?us-ascii?Q?dmmMhohBKZk1vcVAOJFHkwTjzIej8yskd7uaEbQxpVEfqhtqf7Y+TdfigIBv?=
 =?us-ascii?Q?6mzsnbPGCfEJM8UjFvQCMKLnzL8Hr7HxwGSIhSH0uOqUpO+OO2/U4xbU387h?=
 =?us-ascii?Q?NBLeiVTOIN+Am8nC5XkRDrBtaBSRTBL2jUO+GGNDPldu/4oLi2WAoe1Wj7h1?=
 =?us-ascii?Q?0pEXsJuZvE8K/wfiV/0Y4umkCOBLC2FjAbdKUOoBVgV7dYZnmhv2c5OjcDa4?=
 =?us-ascii?Q?6UIiwd1ZBYbXy6vu0SOgEeQ2Klh4KNNE1ee2924R+tvwFdk423Y5hNM/B/d3?=
 =?us-ascii?Q?x5IW83ClCbY3uJmfbiXrblGi5SKzRxJCaCL8uxAQTxVolpz9c1n8AjJSov1v?=
 =?us-ascii?Q?bc8Z+QBWLqEZC30zcblF6cb+JvWTFPSi9dm4QTdiHB9up5wus7Zp0igYfhLN?=
 =?us-ascii?Q?2skL9SsJ0gKogwsu6jxLm0Q5G0dvyqwDvwrJTIdvrS7NNM1hoxxS4uAvtmsD?=
 =?us-ascii?Q?fkTl71PpJptNh+ihF8oPeD/+yiIX6NMg7+DYY7lPK6dA4JtG929a06VF6jkr?=
 =?us-ascii?Q?Wi5aS5X6Fr1IjguCnxAmyVgwIFQTKQ69SHRslcT2Sm8QZeezEPvlV88/Cvyj?=
 =?us-ascii?Q?F5IMXkVF4SCnZwUfzBeg61ErFz8D5W+pAuiXRqLg3WcwCYkFMtxRbrSF5T5n?=
 =?us-ascii?Q?Dl3n79G6wLl0kHmfmkfeeZkgCwjGHJRWUKaCSwCV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?I7tNTb6N7ErbVk9GkwxwdQV62FGwnzrCdiKQ5ptc/s+/Kfd1bq1wMHqIPxyq?=
 =?us-ascii?Q?3FcpvVA90w4AUCqAA4oUA5JD1q/FtPb99qABPap6hLGHtdF7MFCmSgJFzIWF?=
 =?us-ascii?Q?ORwoF4Qorp9sQqvjkowdGjng6KrcDGenpmwkWbqnnuxJt2zL7ymCle2QJlV1?=
 =?us-ascii?Q?I5KTigHLMgqeGJZlDWkdnQCWj8BAZ9hou1zN4f41yKO/ITS974z7wh4fUk+u?=
 =?us-ascii?Q?7OryS80Fz+Vf7mW+Em5nwdVKrsvyLTbad9HmD+eHneg5d6de20RVgdO7bkq6?=
 =?us-ascii?Q?fS4BujxCjR7aC3GC2+TXVDrIjK79No3hpJxvRutIjagKYbTBpHxc2KHTlWzp?=
 =?us-ascii?Q?/rCq45qwWYTBjqMfVoD73jxO0WQygLKZwrVKFwIUpGwq/RHkcijDvp7DE02w?=
 =?us-ascii?Q?kXnOeBg1wukTmfxs5A2zOQqbq6OMTG1ONVUoLg8vzzlYdMJvF+TBMyfWdxMw?=
 =?us-ascii?Q?FIlA3BBcZuX/RWs4MFi5uDAMi7UMpKhFdFzV/6446stPdJBtUorQTbEnHvg5?=
 =?us-ascii?Q?x1N0WTN+MqBW2afW84sAj6POGDfU18fhUEqcjfN3Ro1W2hzL3FXbzA41iMIL?=
 =?us-ascii?Q?Nu5XbtG5MR/OFkGoi5KYDBcaMyq1051KW8S91A3vvW7B7dUQUnfMWc6ZMJHs?=
 =?us-ascii?Q?yWmZ7Nuzq5R/qubIsb1Fca0QR9JjtedbRtADqXqJGK+oTi4ClI9bNT7VruDL?=
 =?us-ascii?Q?JtTNEgdCcDgXj9ZaKq/mjTH/Fu+jlnkvRwUwBIQatZy9fCsXYJVZeICUKiVu?=
 =?us-ascii?Q?wwYeCXobyiO+JhdYU9nLEOPe8iXMkNUYZ7ZivUz5loTlDAY25ff2YnvjoMDw?=
 =?us-ascii?Q?LWG1KSoAEWGwClNXvw0PZVJ00LFKn1i918bm60wfi8qTkQ7uNK43RemnORLl?=
 =?us-ascii?Q?jJ2Y/uaeKQ5S3spF3TU4V1VeIS5CSk42qIenYHh6qqzNnUGdaDBqnnsK+1bC?=
 =?us-ascii?Q?liKrQANfCuc1BS8YzMmCwCRzD0/Gzq7/55Iej6iITQtXuBNWZhL1KW3diKBq?=
 =?us-ascii?Q?ytbIiQfSLwoIvNzd07veE3he/iCLIyPm8rwArBaDMEUbMPJv8vDbaD3z3hHH?=
 =?us-ascii?Q?4biEenXrlLoQcDHYiji20SxcMvEDDtRUw1Zw1312b29U8qtmq/dVtg7eIIZJ?=
 =?us-ascii?Q?AOTfdNwRz2HL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e119b49b-f7a5-497f-d71d-08dbb89b55da
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 23:02:30.4115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFbeR2xTi373hgAEcKQj1fjepMskh0Kxo3h325kLgCnKq00ETBk5Qmf2Jzihvy7Htv1BvW0JPgFN7oCFPwq9Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180199
X-Proofpoint-GUID: dAHMXdPjXbZ81p97ODRhIZBD7Mdw8haq
X-Proofpoint-ORIG-GUID: dAHMXdPjXbZ81p97ODRhIZBD7Mdw8haq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the internal hugetlb restore vmemmap code path such that TLB
flushing can be batched.  Use the existing mechanism of passing the
VMEMMAP_REMAP_NO_TLB_FLUSH flag to indicate flushing should not be
performed for individual pages.  The routine hugetlb_vmemmap_restore_folios
is the only user of this new mechanism, and it will perform a global
flush after all vmemmap is restored.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index a6c356acb1fc..ae2229f19158 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -460,18 +460,19 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
+ * @flags:	modify behavior for bulk operations
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
-			       unsigned long reuse)
+			       unsigned long reuse, unsigned long flags)
 {
 	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_restore_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
-		.flags		= 0,
+		.flags		= flags,
 	};
 
 	/* See the comment in the vmemmap_remap_free(). */
@@ -493,17 +494,7 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
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
+static int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, unsigned long flags)
 {
 	int ret;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
@@ -524,7 +515,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	 * When a HugeTLB page is freed to the buddy allocator, previously
 	 * discarded vmemmap pages must be allocated and remapping.
 	 */
-	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse);
+	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse, flags);
 	if (!ret) {
 		ClearHPageVmemmapOptimized(head);
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
@@ -533,6 +524,21 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore - restore previously optimized (by
+ *				hugetlb_vmemmap_optimize()) vmemmap pages which
+ *				will be reallocated and remapped.
+ * @h:		struct hstate.
+ * @head:	the head page whose vmemmap pages will be restored.
+ *
+ * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
+ * negative error code otherwise.
+ */
+int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+{
+	return __hugetlb_vmemmap_restore(h, head, 0);
+}
+
 /**
  * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
  * @h:		struct hstate.
@@ -557,7 +563,8 @@ int hugetlb_vmemmap_restore_folios(const struct hstate *h,
 	num_restored = 0;
 	list_for_each_entry(folio, folio_list, lru) {
 		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
-			t_ret = hugetlb_vmemmap_restore(h, &folio->page);
+			t_ret = __hugetlb_vmemmap_restore(h, &folio->page,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 			if (t_ret)
 				ret = t_ret;
 			else
@@ -565,6 +572,8 @@ int hugetlb_vmemmap_restore_folios(const struct hstate *h,
 		}
 	}
 
+	flush_tlb_all();
+
 	if (*restored)
 		*restored = num_restored;
 	return ret;
-- 
2.41.0

