Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A17AE2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjIYXtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjIYXtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:49:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E486FB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 16:49:29 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PNGK1E001276;
        Mon, 25 Sep 2023 23:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=E/x7mTYtq0AK43XWU8sgezCXfY3I6f53AD910fUr/7c=;
 b=VkXTZyRGhaWD+cqPKuqRdxfPZITI176yi9ODgFpjq8/YGqPlkHd0J72QRe/1xBHUhk2c
 eUTnmhyKSf7F01RzEPaaVea4IzFSNDKN4jlB4AOHl1+efpbrMQxd170yq/Mzz1Hrr0Ox
 8DuYdqwex7ysNxd/H8RA7mKdWa5HgF0MiXHV7FM5Gxw8OLlbz0hXvxxcp4tp8EMAjES9
 WrMuLIcFc52KjbUsxZe+w02u8Q2RO+ZO8f47t+rD6yoegkmg/YTm/FIl7B0FwGFjekpS
 edhhAyO02drUMKbPIDXJh/0IT2lnsiO3OGWW3qjyzutwnFVXsz8yxSs17unKzfhpwnPM iA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3n62t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:48:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PMe1QR021229;
        Mon, 25 Sep 2023 23:48:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf5f8n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:48:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFzVaHiXfwHUpolBY0R+SVsgTRg9V8Y9fRJm6e86nK34zSnvpvnFjY2iuDhwUUgaq2OBxS7Zp1tZ97DUDT6xyWhJPjpf748fOD8YjqQnKRWnV6O78/9n5nnWY6m9FOTrk47g9K461T/7+32dp6sl30rNUTRE61DVLoHJCZ7Dx7d+VBt2gqYMKaSP1dpEq/k090IEcKNMZEHXFCz0GaRKK4nsU5BMC9Qw7sn0THDylxHA5TAigb0BuCHjmtmj017JuBB2yQD0rL3EhhcLAc9HK/MN28lJ0VXz9nqfxsZ8gOv7YZ8xvzoqu3CknWSOg1qKXLzQSuIz3FgE78FScbq2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/x7mTYtq0AK43XWU8sgezCXfY3I6f53AD910fUr/7c=;
 b=PdP2xUyAwbps+acZK7YbBeRLN9Sx02Flw6F68kyDkND28tOsoYmMny9pAtyIYbfYdiMr35vLwhcxm/uT8xsOon/mxldwCPA5MMQJKI2tHPDsL7MQTWqeRPfcPvOHLnifxWZh6YyR2utNc+F3KKz2nyjtXI95f2zQXYO8/ppgByt7IKw9iak7Vc6MxtJNk7K8u6rHojtErzZ7KTyYGF+pGQEMX4OcaSdU5uckXw1f/aOQl9Zj2perOHzuKFRs/XuLlL6otMxnTz+K9ZfXRC8Xe/s/EHmiKc6z6nIf519dxLa/BqzFJ2tFHCGT+ndNX4zwtJx7cE72UrzTOQsxU0QOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/x7mTYtq0AK43XWU8sgezCXfY3I6f53AD910fUr/7c=;
 b=TJC8KxsQvaCQKC0b0Tfx9D9Hkr469Kbq9vJkk5MLWjiR7BoeAsVrtho130W+Ton1NHVvFHyj6dIGPAuJPJFbhEJWRv82RUojTyyywWe8qcEZAdpF1jguFUW1YlXH+WSqLtN6Qe3cNb/mtEGPd7KSUN93UpTO7rhl7U/f3o9aXfI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4523.namprd10.prod.outlook.com (2603:10b6:806:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 23:48:47 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 23:48:47 +0000
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>
Subject: [PATCH v6 1/8] hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
Date:   Mon, 25 Sep 2023 16:48:29 -0700
Message-ID: <20230925234837.86786-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925234837.86786-1-mike.kravetz@oracle.com>
References: <20230925234837.86786-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0348.namprd04.prod.outlook.com
 (2603:10b6:303:8a::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: 24bd1c18-adc4-4215-35d4-08dbbe21f5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dY2q7nngGuQN/OyaC/XPBPR1JTwa9z39ncmR6J++35agu+Xn37qRIkswY9rUic/huPf3JQaLKle88ovqicVlu9cq/mLVEfrGwbQMh+9I5/tXOI7fdokiTtSIx58u2fOKwlQgAJxeTqryZ/Xs2tjwEXPe1DsQ6q2WbGq1Z1C8fPYHzr8A9SPwdvvBZFrYB1jaJyYFMHX6V5kTL8KEHqjo3HTDlG+1On8TCl1WhXeG0u3U+/B3K4VliNAjrEZ67YuPZkpFt1uijZd7FOQ4+6iksRepul6QQYnUUZOrpg+8Xulpr5PNDGttUDGEZvU/a6XoUeoHChCVkNEZKGUTH/n1nkLv8kLAxZcvWIHzhQrj/jecNaqvgcOaliAewFRbUhEnAtq7wy8OPB143FKPWKIH0PaaLcSubrRSRCVBoDhiOhjND/PN8rfsUp/LCWixsxWHzjpIVovMI0pXiocgxNrKRd8fIvouUctZYXl9SRUKj+BO4QY6qt83NNbqYcUxcloihaZuCCayrlVtVHv+1E21yUJ+Kti9SodGWFjnBZQ4J/oht7ryK5FKWF1IWV2BXTF8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(2906002)(7416002)(1076003)(6666004)(6506007)(66476007)(6486002)(5660300002)(316002)(44832011)(15650500001)(36756003)(8676002)(4326008)(66556008)(41300700001)(54906003)(8936002)(2616005)(66946007)(86362001)(6512007)(26005)(83380400001)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bdyTOjSqjSRUF3X4KcAkyBSVqrHd+mwl6Q+B/+KbRhPopm1SZ7CoTorcWwjp?=
 =?us-ascii?Q?klUbdU3H9NBeVR50Hrx9BjA3ObEpaqVwzt67El+u7A27JcPUYBj5mdGIjotT?=
 =?us-ascii?Q?ja0GLRgL9E36zhAPnYQSqkYk1bDEGIFze+VIExzAEgZ6xNdwA7imK0iu5uUn?=
 =?us-ascii?Q?Xpk/59tjLJRuxX2VcXuodNQtckDcuVQW6q5R801ndBi6va9pHkc8et0vzCh0?=
 =?us-ascii?Q?IhCfql8v87dU+6g1mRUnMVHDnqcFBE5ETzlcZR8byhF2LOh/9Y3wFx0gjMn8?=
 =?us-ascii?Q?20tf8qjH9LlqeHQz+qF0JjnyOg/j/aeUdJj55iYE9IkjbrR4mjKX4PNzA3za?=
 =?us-ascii?Q?rsFOb7EdGZ58llrh/4IW2dE0+/aogwLwDmJGhhlU7hh++x2k4SHYj11GXJeh?=
 =?us-ascii?Q?uml2khSnP481Gac7hbi0+4rSfzzgWub7lsfZFyFY5b7baIYbpcmA7kK143JJ?=
 =?us-ascii?Q?jllwpwHqCS8EYv1p8iXncj2SYoWXqciqwBtpV8oy0YNmkHbbC6vmtj3urebp?=
 =?us-ascii?Q?PydPDPZ1iaAXYlegwpYu/rKQCwxopWW2dKFlZ6j/wiSiySS5+YxhbyBXN8xx?=
 =?us-ascii?Q?bcFUYVPDeQU6ErUgbr7a9Ts7gonYBiDAu5azZaBciHpVPCHqiyE45AP5wK8R?=
 =?us-ascii?Q?zvsdtTzNm9NVzGP9sf+o3LmRlP+De1TFViArQFQEnTsW/1FR7WJgK3aXLbTf?=
 =?us-ascii?Q?cYybh08bB5Z3cH8fTGN+dj2tsvCobehHlZPRztapNF2uLKX9KGh1PR9ZjTRT?=
 =?us-ascii?Q?wmjkqMXgg/EuXAD3jYBW1O1jZg3oO3K0HR+3hOKpwFtl4FyEGthMbz4HvdxE?=
 =?us-ascii?Q?ZO1OMwqTDcL8q9lf2UEXVuBXnYBXGcvKqS4IpRkIhSt1vHsald0vxS5H/reG?=
 =?us-ascii?Q?KAYVLQAt9uIyhfa8fLyQCdPxFzHWDeGng+FEyqIvLU1tXna9Vk4N1lzw+I1r?=
 =?us-ascii?Q?Nf5huJ2OsHpKW7rIIxS8elsm7KZtirQwkkfs9E8J8bhRDAZVdMHGjPc7HPIa?=
 =?us-ascii?Q?FDntXDwaOS/+ppVng4hK03M1CpfzN8wgJHMH/Pd8G71PC0OiqQek8ti2um+8?=
 =?us-ascii?Q?7VcIAF6uG40mgenaWUK2FIQEekeJGmEM7xNniXN1MFBO8ObgVJBVv7KfCBS4?=
 =?us-ascii?Q?qx1oCZxvEzBFCH8x7HjDX/fIfoK0im+iqzzuRPAOw/FTgRfCSNd4vWVy3qB5?=
 =?us-ascii?Q?CAurSanAFuuDxnwHGNpiNQZcT6giUOxpqaEcvHCMUrbaYgeTepNm70TUd1IL?=
 =?us-ascii?Q?y2f7VX0Y4JPWCp+ZXVv+ZFehH5dH6CFfQFib5Ww1OcztUVaJEnXbPzgvjUDs?=
 =?us-ascii?Q?x5Y43sRIJI/DQjSJCVMV5DjQmWwI+mRWNYY6+1mYjEirPd+d7hC2q61QJZ80?=
 =?us-ascii?Q?f9oOT/SDaDdVWNt5XbJlwn6JjnUo+lK1hfi715FTlQa5yo3m+Y5bFrhf7pGl?=
 =?us-ascii?Q?xeAtsuuF8fRfFoSluJA1TZkm5DMhCORd1NR7xfnFbVCUzV196x2u0gUElANT?=
 =?us-ascii?Q?pHappgTJ/j5Umm9a6HLW8tbWp4kI94w3O0qNHcHPu9km2l9DtMWdtAb4Gpi8?=
 =?us-ascii?Q?yFYCfOPXm36wsFjxAMXo0hM9rEazc/w8p1n3B9r7u0mVYYtWOvimLuPzxrs2?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bItTguq9BnuIX5yDdDvPmkcBM8UPfU9ZGs1xZx7GKShaBvKFsgNCz0rwFNI0?=
 =?us-ascii?Q?jubKubfzdCsmXtbEeo8V1xxHOfEMjqZPwjJ93ZRLnWLGoRAuRie+H7M+QM6X?=
 =?us-ascii?Q?Ol0duNXPnn1Oyaj7oLk4ds8O5+a/Iww/+x47IaMHL9mDIRSCNP8iSfdAVvoT?=
 =?us-ascii?Q?F7A9Ci3oC2vpy1Js1/FEdmfGkdbE4Y2d+ppxZxRh4v769IEAmYP0MWoO4XF/?=
 =?us-ascii?Q?BlVmPCVN05lYUnQcHtL5a7Hv1+uLjKrrzgrSi29gbF+GaYr8GcDfCDQNkhwS?=
 =?us-ascii?Q?zKvSa2N3dJTfv15mHwkJuNmPCzBK9p0S9S7efugyVho/Q4Y4lfrzmZy40zko?=
 =?us-ascii?Q?Wuaa9jutNqbw7NbhhTrvoqSA46p7Hw6cDDmJhhZUKrbcGHIJF00Pk29V42uW?=
 =?us-ascii?Q?IMx9iXIgc48+mv2iJR4MZCyTuWdjdzDS/RNP0TZ02Y3/Q/Ik4KRsb5PKZTkI?=
 =?us-ascii?Q?U96aJrr+a5Ab6TYu07Ixh0IPA532uZgcciMr8glL9leWDUAD5dqRkEH37/So?=
 =?us-ascii?Q?MWgsbf87f0igpCmvDE3NG3WsQwCf/TI8fsDLQgpr5GSew9Ij9HTdHWSeG5gR?=
 =?us-ascii?Q?KiGO9HhBAxqTQGguNjUyK0d/f0lNQoFNYKtqGZ4/sLbZXmu/8ujrYlkNx+dp?=
 =?us-ascii?Q?hyBTuCX1IkOxQg/GbbPiZ4mvWBkfcB6gBpGBFzfTb2UpxhsUnIayUMje/HTV?=
 =?us-ascii?Q?xOYLCVngbzDH5pSbCsBls2N/WNgAo8+A5drXs/E1Mv9cco3YmXHcKjZ5BC01?=
 =?us-ascii?Q?9C24mI+LVTN1zgpTOVvqPJFR+dios26Bk2sI8nWCRwD6C3tPtn7Vbko2+cXT?=
 =?us-ascii?Q?hiZDuZRkZ30bg2zuCHPCLBm3cPh7WTzsglFI8eWPXDyx/tOqX7gtUETlJvnZ?=
 =?us-ascii?Q?En6kDiaqzp+xEBQA6KXGywjriWdrXJSlOt7cIbw6ah0ZykECetH+1zRLHDYc?=
 =?us-ascii?Q?SuNskXmnwXhL28YmHh3zbTswyyLadhR5CuIJZxyKrB+vScEltSbMG6RAW+Jr?=
 =?us-ascii?Q?gUk7GP2NR0IEZeGnnmmq85DAccEcJ/UCsotW16RlVdoOkZakfzj5E7MOVVHI?=
 =?us-ascii?Q?MmE3ePUuZWuOsblI6joUtsFcD2id9WJ3lRDWxJ3q0JKs8RV96tOHai1GKAbZ?=
 =?us-ascii?Q?WNDKY1Jf9jhW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24bd1c18-adc4-4215-35d4-08dbbe21f5c1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:48:47.0513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bFZi8Z+n1XiV3zFRDAKYyzk5aBk6YgM+0aMkktTNUb/EG35qr5lwmbPu8tk0VH7mW3v32gQwjzrAtSK+LZMrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250185
X-Proofpoint-ORIG-GUID: C89YP67kEzTSF99YpOTpKviXctZOhN0Q
X-Proofpoint-GUID: C89YP67kEzTSF99YpOTpKviXctZOhN0Q
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_and_free_pages_bulk is designed to free a list of hugetlb pages
back to their associated lower level allocators.  This may require
allocating vmemmmap pages associated with each hugetlb page.  The
hugetlb page destructor must be changed before pages are freed to lower
level allocators.  However, the destructor must be changed under the
hugetlb lock.  This means there is potentially one lock cycle per page.

Minimize the number of lock cycles in update_and_free_pages_bulk by:
1) allocating necessary vmemmap for all hugetlb pages on the list
2) take hugetlb lock and clear destructor for all pages on the list
3) free all pages on list back to low level allocators

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index de220e3ff8be..47159b9de633 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1837,7 +1837,46 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
 	struct folio *folio, *t_folio;
+	bool clear_dtor = false;
 
+	/*
+	 * First allocate required vmemmmap (if necessary) for all folios on
+	 * list.  If vmemmap can not be allocated, we can not free folio to
+	 * lower level allocator, so add back as hugetlb surplus page.
+	 * add_hugetlb_folio() removes the page from THIS list.
+	 * Use clear_dtor to note if vmemmap was successfully allocated for
+	 * ANY page on the list.
+	 */
+	list_for_each_entry_safe(folio, t_folio, list, lru) {
+		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+			if (hugetlb_vmemmap_restore(h, &folio->page)) {
+				spin_lock_irq(&hugetlb_lock);
+				add_hugetlb_folio(h, folio, true);
+				spin_unlock_irq(&hugetlb_lock);
+			} else
+				clear_dtor = true;
+		}
+	}
+
+	/*
+	 * If vmemmmap allocation was performed on any folio above, take lock
+	 * to clear destructor of all folios on list.  This avoids the need to
+	 * lock/unlock for each individual folio.
+	 * The assumption is vmemmap allocation was performed on all or none
+	 * of the folios on the list.  This is true expect in VERY rare cases.
+	 */
+	if (clear_dtor) {
+		spin_lock_irq(&hugetlb_lock);
+		list_for_each_entry(folio, list, lru)
+			__clear_hugetlb_destructor(h, folio);
+		spin_unlock_irq(&hugetlb_lock);
+	}
+
+	/*
+	 * Free folios back to low level allocators.  vmemmap and destructors
+	 * were taken care of above, so update_and_free_hugetlb_folio will
+	 * not need to take hugetlb lock.
+	 */
 	list_for_each_entry_safe(folio, t_folio, list, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
-- 
2.41.0

