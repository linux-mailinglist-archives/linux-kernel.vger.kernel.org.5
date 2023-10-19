Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39497CEE16
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjJSCcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjJSCcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:32:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD8E125
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:32:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIn3Cn027685;
        Thu, 19 Oct 2023 02:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=aj9XYBvc1umDA4dSHKq8Dgaza9nvmhLjC3NH0H6MDKA=;
 b=e9YEpOuccwTjeZWuQ1t3MT5hXeGQMLPTfONh/qmXjzwXA1hqm1Jnq7L1VCznDFent1DN
 ZUNRmUSzeRzcn5Q2AZzm7wYLHIUokQoFIKIrWft7BkBVfDPXZqWKrlCHr/Z6l8i81En0
 Sl5MAOVFrSpx9Z45rlwm5llvdiRMQXgeeEsMcYgxZgDWKdQz0CyjSEVrlrQlcDmfmxet
 aSwXS+jxELMuOsMqxb21FWzRTIMcnFcOmLTuwgzFtZkbbVkSs7DW7IOyEtwPEZwOpTdf
 trTZTu8eqYjGD96+Kc3QYyMj+3vqI0MY0s01tBjeJ6T5h+b773WhsNQW8TJf2/ozd6ir 6A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1bs38e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J1r0c0040448;
        Thu, 19 Oct 2023 02:31:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfypjxg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1KBugUHc2dqKT3skjw0iTR5kvxNa9vUvVOizhCJmK6tcfGuFXfs8oiSFnmUUgx4/mZN9rwKr8C+bw92CaWUeP7UT3rtZMcFfiV20PDpJpGUsNuSfY6GUPpnuj2/mNthLqg6eD1vpU4xqh9zFjbe/rQYPWdevSbV+nW2/wiO40Sw8yze33KuPykK2mwat16WCf9YlE7vFgHtSeIPZF4BFLY50DCeAVOaTLhTyh68sBoLWnqDEEja5SiT75iUoP66BDfJXptE3yRxA3xJtNn0/cYnwY+kzLymtJEhOb0xRyxAG6IeTfLmNlJhKUPqXXzT5eWrRK9XVIH7jL0w1i9eFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aj9XYBvc1umDA4dSHKq8Dgaza9nvmhLjC3NH0H6MDKA=;
 b=aUzUQGyg5EnH8vjtgyBJAwTFTKpP8JVQMdO3Yy3dSjqEZh3DZd7VrXnQMNqzhOkb76Noc6etKyvTgJR6foOYt0kPaMvhy3emBNzZ6+lPo2+lCQgFSYlBCAKCUkNyRwkKbTMuWUYXcAekuLOdSM/aU8dr+3Fy5P1Qchh5geaqa7SEWIOtG3YE/c1mSykPviionqdaqE6M0TrBf4UR+KtgGdpX0zplreWy6IJYAssQyLKsoXzf3DlxFpJOAUKspZLeYSB6oNIqV/dgdwc8t4CuNEprcImc5YoLIRd3V7825QrdDIy10f4w8iHM+aesk9ToNpMJkVF61OKztggrrJ3TjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj9XYBvc1umDA4dSHKq8Dgaza9nvmhLjC3NH0H6MDKA=;
 b=VcQCFtKW4NsanTqwEm6ZfCfG9AI1qkuivUrX4HA7zuVm+qMrQ7zIwDNGJem+9ADm83qZC0slUz2fIlBp089N6G/yrTneP0N4c+78LSSJSF+RoRtzZvNtyisWVDl74LKk4zJ+IVb8kx4P47pQkfhe3nGFjfxTSMqfEVg6pYnNxQw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB7123.namprd10.prod.outlook.com (2603:10b6:930:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 02:31:20 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Thu, 19 Oct 2023
 02:31:20 +0000
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
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>
Subject: [PATCH v8 1/8] hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
Date:   Wed, 18 Oct 2023 19:31:03 -0700
Message-ID: <20231019023113.345257-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019023113.345257-1-mike.kravetz@oracle.com>
References: <20231019023113.345257-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:303:b7::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 3497091d-d510-4766-32d6-08dbd04b7a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCBmrf6FWGXnnDYsdXozTxR5k4OK2ZxgIhBrJ3FW41L34aAa5ooKgOUAnrJ7StqROYXGkh13gqVVs+LYd92/kUpRkpTNdsu4/7F76TfA6+x/KeX47A1lFmqyPVAhAMskubQxKagE30MIzvavNrCbqNaMNy/7GCe1CQwkGT0TRYsKtH28SEoVyzR9dI1RRBbNt4Ah8nH81eV9O91w/E1nZ8BtXuFsTx48t/11qi0jhSF0ebbyBZ/MQ1FeQlCxrqi4+lWh0Qi/5trG6jabOUyLoKAzwVzyAs0WnR+1eVFQZMwy/70H0qQu6p6pgligr/ocPsijAh4pNLA9N/44qwxh1n3X1orTj1PDoNA9VHmUDcFD8P+KMaJa84tZX7tonForh689luxqWpzdf98ZquAb9w+vd8csxKKP/PTZMf/+CyNXUMMEKd3HFVTSfNMxLXb6os/ji33fZHQNKfQisyr5QBzh9I79NvN2k5q475a+TGiS3rd6T9kTSUAEXRnsvzwWNvkKH4Pybx+6nBDQPi75sQKdjhWBxO+1BKSlGzX8I29XY2OeKHCSMoMQWUrANjfy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(54906003)(316002)(66946007)(66476007)(6486002)(66556008)(6666004)(1076003)(86362001)(2616005)(26005)(6506007)(36756003)(6512007)(8936002)(2906002)(4326008)(15650500001)(8676002)(7416002)(44832011)(41300700001)(83380400001)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fDX8WngwI5tItkRa0jsEXfz2RznQjt4vANh2q3dj8ewmTU7d/aj6aB9CNdRg?=
 =?us-ascii?Q?mmCgenBkSxEY/elEnJh0faJBn/w1RUZkG+evHtHcLCPAcAJ/RZdAfOqctvUC?=
 =?us-ascii?Q?Epg0wmUhY7ME/RocfUb0Y2KmPLfMODXQ9KvAPhhvxiIYrCk7tNxjWYPBarOk?=
 =?us-ascii?Q?HMte00sBQQ7BAA+jfeHw7v8Siplr0hZ8rvWr8Vi9cjXPNdlkASrQPTv4uW+a?=
 =?us-ascii?Q?8SHr6ooS2gw32EHP01lOTfdqBHIReiRdu1PKav6aBLd0jr92GR1b+I1W6+0r?=
 =?us-ascii?Q?oLkxDDaLWHcDqxGmggR1HAYUxpZOfBnxe71KAx6ZcvoYAdTH3DRKPFufaWNc?=
 =?us-ascii?Q?zcCBX8wApPi2yO5gfqprAy3Zq/VqMCJE6tRWwcYuxge/yKz/Q7Y3i0w/1xdd?=
 =?us-ascii?Q?RnWdRUFwWfUae+FViDStOzSYtouXeNyJC4CI09XRA+FZlZ5Ku/w2Lm+kH4vE?=
 =?us-ascii?Q?UFoBFFqP6cliwc3iwF3rzulGPfkCTM6/DEdLpfrUGaQp5EJyhQqSvCzhJc+b?=
 =?us-ascii?Q?VQ92+tm5d+ybFQmYqKtYaLN0ug3ekjgo9IhMn0FYIED2z1ud5JIvM96RVC2T?=
 =?us-ascii?Q?CBA39xDcKB+pbTU7eK4Hd15mb4Wb1afSsRqIyVaKDlgNA/RYFffLFbkK/Wtv?=
 =?us-ascii?Q?pKq4WM91RsmyO7IbyVpXxzIRCJOS/esReAMayde0PnWY1iMo8q6VyBvukbaE?=
 =?us-ascii?Q?t3XkC2o3C7uKZxdJHugVDt06EFMsMbBg7HsYrXHBNVfTowYd/XtkJHCNvTS7?=
 =?us-ascii?Q?/3h0DG1N39X4OLP/4PHQBxAoCSinZklAR230mJaYv+90YSrQ4+dX6nKwwA0F?=
 =?us-ascii?Q?beOLPYsp/jQJTvoPfPRK9BR1nbLWNga7Y4MgJc9z4FUA4lz2kpliEs8Zg1rB?=
 =?us-ascii?Q?9vqvPMXaDbLC6MmEXdHXMWR1YWUgk1/pqiQqthitTnYf+4YQz5OuOKn4j+xT?=
 =?us-ascii?Q?RVyqO9uFP8B69pjp4ySJLdcyYaoU3KBCKABNx54Ay8VxastoGlwGHOhOgB9h?=
 =?us-ascii?Q?AhI1+NZAXzSkShq28ujZCLhHZ/3DMOuYyknYjJVfyLVByjpBGh6fdpcZUmz9?=
 =?us-ascii?Q?mbnP/hedF5s/D84yD6d/HG1awcPkX8nLCGhYl4EFCmJwu3gN1D/4B1Z4Tw+J?=
 =?us-ascii?Q?NVubrwC43B5jqLnXmvelEU6tUgZaDAB5FuASdJnU1VzNXXxclkamL0chSuGJ?=
 =?us-ascii?Q?AKY6Dc19x2wNDfTUD+Vu4+X275yWIFlq/EdG/3flt5/D9mnXgKPPaO934adf?=
 =?us-ascii?Q?yN1O5jZSxqfuXXn0bpzjHBKsur8gCsQwqs8xAy6OkAT6tJDajdWw18phNe0N?=
 =?us-ascii?Q?sOT9KLSJYXfOYInlahIYw7F3xXYm8152xmE0qcW93hiLrIxAyjFGPlNUtT0l?=
 =?us-ascii?Q?kHghMwNc1EVoVkh7vcZiaAjUeDbDP/zHsjJ2etT1fWxrMDQb4ZDdkhZf9Yst?=
 =?us-ascii?Q?CyvkDpbSknMUapHxkwbpUcjVatVKVjsI06x7RCOKwggdEty5yN1y79BlWac1?=
 =?us-ascii?Q?2CA8gXbKg7kq7GLk8ETUu+RPFKo03LfQMHMUCKlXEC6fBOFw3I/XQuf8KqlU?=
 =?us-ascii?Q?QRIE46+MK41cQ08aa+AeNNGo2PUb5FUxg7KvzI/Wr0+HSX/xE1Ch8Y99QcIH?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?u05OtFiN+b2Z/V5/d6o9tBg2EYRGdopbGya8sv3u8cowCnNv03RIqY8C2KDG?=
 =?us-ascii?Q?kF7Sw52UHlFigtowWI56Em3znndJ8UKqbqPIzeHBkln8nX8BZAtpFfqezSRm?=
 =?us-ascii?Q?5vWH6dgj7NskUmy8SZOA6fV0b9UMy7GCjBT8TLVwrvQb+iravV4df3eeAVyK?=
 =?us-ascii?Q?FIMFcti+PYmTsQ2zwlgHiCm1rc/mLdq4887gDD1Srgxg/8HfZ7d+iKrSDIaW?=
 =?us-ascii?Q?B739gIp+3J5eOdZBaPAp4/B0IJNGbb2RSyRoE7AZFvnMFmEpFsIZSiBYCvK2?=
 =?us-ascii?Q?0ERQAaV3oJ4p//EjbkYORNh1thw2/OYjev+WUIkStMAHILuwgZ0D8jfHNvSQ?=
 =?us-ascii?Q?HEkfjVs/KPDQmWjKBbUSZ5asg0d/FEmEzFBQX0Om6/AfkWCVjmRYroVPc59M?=
 =?us-ascii?Q?hbFPHUC6YHaFRyVFfGd6EmdPSNqllRKi4KI8sHVq4IoX0sm6ePMbZoKkvvP6?=
 =?us-ascii?Q?HbPMoT/TC2A/hYhzzcNIKd78pjZNLECabWQ/dXI+T4gpW34dS3lP7FmUP9DC?=
 =?us-ascii?Q?lrYeexkixlH8BgPuUfFCeSHCtNCEL/BDMXAW9lASYnT6Cg3VIPisIpFa9auA?=
 =?us-ascii?Q?ePZQYhL7qAayTSnHG3Pvjya9oH6BnMOBLpouONFTuabhcHrIC3EJlUfFev05?=
 =?us-ascii?Q?RWBZu8jze7KOnYFmgfXWmYyTmZXDMMV8A2+d+4r+KYPp1PxEGjLPyq/brIDW?=
 =?us-ascii?Q?MqrafgoKMdCX8r+lAzZFc0BnQaWCeaNQz3WqVnfttyBo5nH7v0hGrugTiVtd?=
 =?us-ascii?Q?A/BFOUlvP6UwgpfVwCqIrI3Z0Iz1t7K5zunZhvdDIIDZ5jxoi6C+kb2Z4yN1?=
 =?us-ascii?Q?lP480eNqx5N2W1BPR3Cw99OX32CSB+BQaJgYflXw+OzmiSYQ3a9qt61zNkd5?=
 =?us-ascii?Q?+9z6oCaae5jQdBXDwcSFJQXLztg8SwpEQiyy2PBnp630JyjhMlUFIpxeVquV?=
 =?us-ascii?Q?cnU5n9o+QB/ZyfgDiWgT34lKFtIwWDW+IhdYKiECqDauaq6+rAcBfSn3/8jt?=
 =?us-ascii?Q?xxQQ4NsrF0xncITXzzDEGYcfdRRX769fjgVLnjRF198QqVO5Zqlsmfmseba0?=
 =?us-ascii?Q?o0WM0nmZFy7FW39+8uwVFFs0isxpTXsBkWHx9b+At3qSMbf8vZHlC92q95qO?=
 =?us-ascii?Q?1yvH2iPZ1nSq5GLYrhUIHPNAeqTKHzk26bqMS73uj3m01Pt5Tv1TcULYed8G?=
 =?us-ascii?Q?q3WMtyJ/juAYN09k?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3497091d-d510-4766-32d6-08dbd04b7a93
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:31:20.1867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0La7n9nhs6MV2VIaz83dp3QI3MlRcpJngx4sj4Et+DTJMf9+zb7beJJszoYD1PFOthBchx9vnrp7lARveidkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190019
X-Proofpoint-GUID: eVSFDYN1w36MvDUeeE3XEksew9_kiHYQ
X-Proofpoint-ORIG-GUID: eVSFDYN1w36MvDUeeE3XEksew9_kiHYQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
index da6f85b7db88..b839080a2a6b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1862,7 +1862,46 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
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

