Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E9D7BE3D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376365AbjJIPFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346567AbjJIPFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:05:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877F9CA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:05:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399EY1Wt011856;
        Mon, 9 Oct 2023 15:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=tORvW6klyEVvDhiHhWzkKzzQSPL2T2YeEOgu7gGFj8M=;
 b=GxIDU3uZT/VlU0UoUq09FPZtlIpHNa3h4YW6DWt6BQrN2kJPQYYzrQiokHUhMjXgqIkK
 vzjBoWAjNlqobQAMmtjuptpJCoVT0MBw321Q69ORXW+3Vp5427adMEy93kKs9m+YEXyc
 6L13PVFqEbrOj/weYp+ZgnIy3qFnesSt7xkYfd82NllH4G6xGr1o2+D7XP2qYnQL6n+w
 jS/0GOa9/LRwW7yB2CnRRVGqBmcA3lMyAJS+ZnlWaYzf8/eMqb4l5YzMn5uHjk37rHb7
 ktjOz1r2E8MvQwlftxi9GvqZAftnqn57j97fjOgRhRXqV9/umRALQBhvVSyu2hk9eI4Z qA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh89rd84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 15:04:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 399DagAN014448;
        Mon, 9 Oct 2023 15:04:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsancns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 15:04:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJgC9hGvkgFw8tMd22w1dIoayEsq9QdgwK9cSJeFwgf38Z3QYu0XQWGpdzHffNIgAOyafq5GIsIhkr2ac3/hyS/uLgt0tu6qtpWinAyrT4QcmUKbLbBQ8CzidrrHhDJ8iUxUCHvx1aiu+DobXIaRuIkIP2DWtt8RIup/aivb6MaoUpxAK3n6Z83NrLtM7nWzDQPJ0e+HKcUwggZVnLi3xtbgDA2o9hQ5RYA/6MAWpmQcLwLk9asgZtoUxiI8ZiNspI1daQsNZ6Gdh4bsX9mJA+VLwHqIt/Rfc/C/HuQMvnxcticJqjaGje/mOiC5tJmpNOeKeJNZOmuay0W1/xNvdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tORvW6klyEVvDhiHhWzkKzzQSPL2T2YeEOgu7gGFj8M=;
 b=keFQtfifHcIJiHRuZk67wkOP9xp5tt2Jc451xotm0UonnrqZC5XI8DBnE1xGthlhoqbzo5vPhnnjxNAR+ZGlKbbxjahavFXaBR0cM45QYg3sBIQh9ZkjtHBG9U9wWrqpZeGtsuyTeiR/3tvcotXLz/WMdZVkjkXndEnf9t1Um1qA+Aom7WBCTLJRBUXqt1fK4uiUhoHYe8sNA5HkPRODdXvQMF/7m31yruOZu5t4C1ht4T1hJFc3K9jdO4tnTL21Q/HEHjE6nqmVuHmOEb5X7CPyVHQAH6fHyBoBFYDYIdY+4l6X13MmXQzz0E5q41mMC7geOpyyTPR1ZYP3QPdKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tORvW6klyEVvDhiHhWzkKzzQSPL2T2YeEOgu7gGFj8M=;
 b=B21lenumfUomkpz0MPPMHnQv8k5KwXFeCD/rmBguUH4wRKOmlCSKtugBMYHQuT1knpbW7qviesVs+3rzD5ilCH/oOiG6z/VengXU60nFMCJqLj23+QjhkFvRfy3s1sFpOFTeqgPy0fWnvyUJTCeGpiByBa4n/ewJzU7/0qf/fAo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB4890.namprd10.prod.outlook.com (2603:10b6:610:c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 15:04:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 15:04:11 +0000
Date:   Mon, 9 Oct 2023 08:04:01 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Barry Song <21cnbao@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Message-ID: <20231009150401.GA3846@monkey>
References: <20230925234837.86786-3-mike.kravetz@oracle.com>
 <ddc10c41-515f-48c9-966d-4ae7756d208c@kernel.org>
 <20230929205731.GA10357@monkey>
 <ba5a528d-7e85-77a2-5096-5a143a3b1606@linaro.org>
 <20231006030836.GC86415@monkey>
 <5d14b681-a2c9-4210-a0c1-bf38708b7998@linaro.org>
 <20231006223512.GC3861@monkey>
 <20231009032926.GA3376@monkey>
 <070bd916-d4d6-41c2-9f51-af35e80c96b9@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <070bd916-d4d6-41c2-9f51-af35e80c96b9@linaro.org>
X-ClientProxiedBy: CH3P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH0PR10MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b00734-8e61-48e3-3416-08dbc8d8fe7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ut1ZEMWvbQiBWfBmwWmD6fsMRSxOrtMFwTshp9BJhHsl5tPyKEGRluu18LaLUg69jrEZuYO6eCMq6sw/3qvYYCPDwhcs6SH/lLPkkZ8SDkKsfgwCfiVlAEWcVs1XJJkTjDOZqZx5lL10mA8tfZbjBlANXw+8+sz0mnGOVqmY+fdMP1qCioa5k3fG1xnIAoQWgKOcvthJVf3aZnqTsm/wtO71g55fKtlg1Gb+o+Xtp2YJ7TWqwnu/ozrpiEh+4QyfVE39oRmWJx2XU/TMfkGEVINcjBGWWhgMHvnaLvkiA1Eeuf+wlEomZAbjjZjWyhWWK9/PoI+U3SahZjrzIF+kNBRQq/V3IT02CWlY3QS4cx260WmiXhqvmX7lOnbo0xRwzTuTeLIuGqDcwU9lo4/mumY1ko3Zk75EeUaMZntDUqEjeYoogQmHa1oLaIuOxzXeMlyAEgTeKEq4Rn5EX6XBodvqSUsSore/ORp8FgdOImMHVuAlxnHLEIB90/EcyYZEFCSxh4FZnJKWVIxTKEvJlmbEY+Qa6o8+uCAHk3leoPlXHoSOmsFN8iACCqcZKPA+jQExqNTupvFUQlAGJ9c7sTujeQ4OdLACzOvWEIAV3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(86362001)(33716001)(33656002)(9686003)(6512007)(478600001)(6486002)(966005)(5660300002)(4326008)(6666004)(8676002)(41300700001)(44832011)(2906002)(53546011)(8936002)(1076003)(6506007)(66476007)(66556008)(316002)(7416002)(66946007)(54906003)(6916009)(26005)(10126625003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pS4FrU2FCCgu+c1WlDdib45Slz4IDS7IcrsBKRi2RT1o0unrtIK9xr+Pn6WD?=
 =?us-ascii?Q?RRSfVGtNcxW3hFDfJVhT2jrR77H7O6kITTV4Cn9H9JWR5xR1nJG52wn3kwux?=
 =?us-ascii?Q?33vdXT3MiCExz9FIzsYBZGagNPvqOqPaEK9VULwoPiGZ7WgDYxGM9n7TKk2s?=
 =?us-ascii?Q?AJNqVN+6BeBoc/xY0OfGD9IVpxXR8fdb4DFl9mE+JBA9QeonyJdVQGdCkKO3?=
 =?us-ascii?Q?G53vk0nxfzV9srcnqSuaXv6SnjX+glpvIcKGd+08bMJmhqCmkdgfjTuZSIek?=
 =?us-ascii?Q?pOpYowhRwO2df7l8/g9O4Jr5AiPF5GsbKgaEB+4hBHV2ltyinc3gelgrMe2s?=
 =?us-ascii?Q?LPKLx/rz3LVZmX/mJ4feF3Y5Uwn4ksSp0FdOv8UqlNihhnFAROoGQPBgRGVy?=
 =?us-ascii?Q?pmPPbjiQwKRXLxUf89tXuap8f60w6q5jRDEJzM7f6VuCaQPCd46g87+sfWcd?=
 =?us-ascii?Q?Py6RW08IjMO8blvj5YQaJPLmusvp2UVicCPNg65Tm+P+KuMjJZIeMNGhTkNN?=
 =?us-ascii?Q?ds7hl5Vak0ZMsfw8iOLEJvY+P1xMFkMGFvJvPpJVhGGKmGAkvtcvKG2E04TP?=
 =?us-ascii?Q?E3mRn6SBvIJYbWVaXq4wZTUCVKtL/eVQYFKk2UaZ2lx0I51F30t4fiPvN4a8?=
 =?us-ascii?Q?sGvByWL7/latQxWRmf1GOrkkY4hHLoTCYq5zOVF9N6+qjPdzLcSxnkvwMl6F?=
 =?us-ascii?Q?yJfOGYI36dyn+XPoZK1nVs/Lk88kRI0R4AW2slXGEePEh0iNk0jD+cxQJ1+D?=
 =?us-ascii?Q?a/qANae9O6cjJYUuMkBDfcSZKfAsInrWGQ5frTzClN2FW+jauT8Qi+YVxaKO?=
 =?us-ascii?Q?Es5fHRDmx+A4NP4sJKs8N0wz9pgueAR1cCPrrpb+/FCSgWL41tvRta+IDzHT?=
 =?us-ascii?Q?JDKGBEoj9OcplQQcBenVrTJM8q7EyfwFIqcqmr4ClT0Q73JwRpGPOmvBGVYQ?=
 =?us-ascii?Q?fLbZyXY9kntJP8x6n8vWc+I2Y+qjMeWoipE+3ekilK8lZzHuQdjaLD633FqS?=
 =?us-ascii?Q?FqYAwndHT6IW0Kvk8hy6+AE7qfFtKfqOyDBGqhFyml705Wh/SKaGzceH6Bx6?=
 =?us-ascii?Q?GskkPgXi8NzIpjNA6aGNJ9aEKL5chaFIIRFLhQRaS4hXBBWzZ6WPoV3xJBaQ?=
 =?us-ascii?Q?Y9WjO4hvpRvj3aWQDgCV71UhCJNNt+iyzk6DumV5wy84Dq1LBnAaRfo1F9TK?=
 =?us-ascii?Q?U8Ob7UcLpwhVIAkkYuFLzT4j1SROwx4GQNBDH3ENuEpTlQhrtH9W39bwNXtw?=
 =?us-ascii?Q?EK9hGnkYcz7YYJsx9GT8/elwPzDV6Qh5fXjzVZooqXsx8Q5pxhZohjGAPx03?=
 =?us-ascii?Q?xgZWi/c2FVRHm44AMDzUsyEVJqtuEYFS+RYuoEz63dbMj4saTTHpub0GRegS?=
 =?us-ascii?Q?qo1fko3zAsplCok2nBB9IzDOTkwCPqnq9pXLiDIZd8ip0XJJO6QQ9Amjvu5s?=
 =?us-ascii?Q?t+QEO5uYzzb+Gm9qNxnHma/Kx3NzOEMMf/lQ7CE2vE+4o8erkjjgOtiFaAT9?=
 =?us-ascii?Q?34XGaUuPYp7qJm7Xi670KNNQeC8KEAftMrvydm4rFp9DWzoFIf1tZZAsaCP2?=
 =?us-ascii?Q?gd7X6QJJeT3FhKHBi9TANoIcR9ODZRaI4yLnK8rCwUVi9CpcxtGPx7KSfRLi?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?D6TECCR/G5sjsnDvnka7oSd85UcC2DW2TpdpdOHYVNm7/uOtTOrB73gV20Fy?=
 =?us-ascii?Q?tEGy+sEYEMPS9flzXe+daGBy73f5dlZ6luWTVEsASWtbDLCRMfrZS1wzO1xV?=
 =?us-ascii?Q?dVbk4xb4Uq2Glu5mj45SLTGjdh9DBCzs3RGXNtwRjOnbvMev+SGbLlxz4UIX?=
 =?us-ascii?Q?LPObTR8jOoXX8HEYOzXOvRnEQYVSnGUhKeWPP12uAWU7O5ICFFF6xvmi9l3/?=
 =?us-ascii?Q?lv/VLGmrg6WN7oqjaP8ONZzUce067h5rRdphVfk+dfI7EGau+US+ExAUE98J?=
 =?us-ascii?Q?l4yMueLrtZ081pEjWAYx0mJx9hkmkVjhTDG1FTQkbr1ZJSYOWgZIzntQHpY2?=
 =?us-ascii?Q?JkX01TYBlzpD7LPmfATa5T8u0fK/vV3Vl/irZptOryUrSeRhn6prwY7BpKxj?=
 =?us-ascii?Q?wuAszfl40cr4T40Rk9W8ycNz1BWuFAudusFhjofBBuLZZBJlH3+oh/hsZvBb?=
 =?us-ascii?Q?BFUk8NgoQWhvjwCN8wMb1MkxwVH5YpP0ESi5ReeC15FYi0CekiqkGKbVNdsl?=
 =?us-ascii?Q?hDCBFWsokZ+paJxx0BX7C0ro1Q2wCLOeVZq9Gsxs53rDR+4TJ31Arsxsd4Wz?=
 =?us-ascii?Q?Ph+vmrTU1wuvCve8oslXfljLJHd/q+biIY1o4m8LuPdxowsixwPdLzffN9+c?=
 =?us-ascii?Q?kGI6zaq9PEjREK8QvKWgCUtv5YLfWtaFtEAzStFY6kkaZh9tPgQuTY6HY8uf?=
 =?us-ascii?Q?/agsqGqCT+/sj+b+DA+iUDF74H8QIY45Hen/fXYcgF1XbdfYHsWTlNGfBt2s?=
 =?us-ascii?Q?Vg3Dgc32Wp4vHnGLGlvnVbCPjODnyENbP3IAQivcf9LOQrlgm7k94pjtd7mG?=
 =?us-ascii?Q?dfAwhPcutlwNGKHPoJjG6L7L7A9cnioGfbTUsLfcyJMI2HyP8KcKXlJ9/Z5q?=
 =?us-ascii?Q?gxisd2V9cUFVVea0DotpFZKVlZbwqDd6azFTSL5qn88GLTiv4CK2VBWUmB6q?=
 =?us-ascii?Q?K/PnfS6hSbAAq7Pn+3YvPQ9wVV7hOSYGmYW+h5D05EWpvHvg3NQKw31MMBBx?=
 =?us-ascii?Q?TvGRI5yM4a61FIwlbSk6AucUaj1IcFK15Rd8ajOVkJ01rr8hGcaaDCQfD8od?=
 =?us-ascii?Q?ErxYvo9bYOfkCfLrSCTixIy/VdcuGmFDmc91lTDwNQe5coaaM9RYMBeKaDvi?=
 =?us-ascii?Q?1uTPI/Z2UkoxjuvIQL3Cph1RsODzj+9g1Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b00734-8e61-48e3-3416-08dbc8d8fe7b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:04:11.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iy8ixeg6IA1lzQZvpa7geckoC01yny0PTHRSgsl8YxVUiVG1LKDwtLLcS4zNzwzjQ1duWhwuGBNBlC1vCiibWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_13,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090125
X-Proofpoint-GUID: wkZvEbQhulMyiCFiCrfvfORcPU2DS9Au
X-Proofpoint-ORIG-GUID: wkZvEbQhulMyiCFiCrfvfORcPU2DS9Au
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/23 12:11, Konrad Dybcio wrote:
> On 9.10.2023 05:29, Mike Kravetz wrote:
> > On 10/06/23 15:35, Mike Kravetz wrote:
> >> On 10/06/23 23:39, Konrad Dybcio wrote:
> >>> On 6.10.2023 05:08, Mike Kravetz wrote:
> >>>> On 10/02/23 11:57, Konrad Dybcio wrote:
> >>>>> On 9/29/23 22:57, Mike Kravetz wrote:
> >>>>>> On 09/27/23 13:26, Konrad Dybcio wrote:
> >>>>>>> On 26.09.2023 01:48, Mike Kravetz wrote:
>
> I managed to get a boot log:
> 
> https://pastebin.com/GwurpCw9
> 
> This is using arch/arm64/boot/dts/qcom/sm8550-mtp.dts for reference
> 

Early on in boot log before the panic, I see this in the log:

[    0.000000] efi: UEFI not found.
[    0.000000] [Firmware Bug]: Kernel image misaligned at boot, please fix your bootloader!

Isn't that misalignment pretty serious?  Or, is is possible to run with that?

There are no hugetlb pages allocated at boot time:

[    0.000000] Kernel command line: PMOS_NO_OUTPUT_REDIRECT console=ttyMSM0 earlycon clk_ignore_unused pd_ignore_unused androidboot.bootdevice=1d84000.ufshc androidboot.fstab_suffix=default androidboot.boot_devices=soc/1d84000.ufshc androidboot.serialno=ab855d8d androidboot.baseband=msm 

So, the routine where we are panic'ing (gather_bootmem_prealloc) should be a
noop.  The first thing it does is:
list_for_each_entry(m, &huge_boot_pages, list) {
...
}

However, huge_boot_pages should be empty as initialized here:
__initdata LIST_HEAD(huge_boot_pages);

At the end of the routine, we call prep_and_add_bootmem_folios to
process the local list created withing that above loop:

LIST_HEAD(folio_list);

This should also be empty and a noop.

Is it possible that the misaligned kernel image could make these lists
appear as non-empty?
-- 
Mike Kravetz
