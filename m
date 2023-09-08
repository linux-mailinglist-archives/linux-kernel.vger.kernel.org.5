Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A6A799151
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbjIHUyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjIHUyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:54:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB54119B6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:54:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388Ke5SC024550;
        Fri, 8 Sep 2023 20:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=xZZvlkBXmXKbCOOuIf+PCvILAQseIk3LRheuTlY3nrQ=;
 b=ZesyIefTMlzHABUSESVXgDgLo869IV00FU6aDwvA/EfkuCmEHHeOtwuwEPigSr8Zx49L
 BGYOHf21ztjEf2tEv2a6t2lWxvDVniq9kM7doz1CfDVxdyxhrZZNpx9sP4JOUFIo2qt/
 CJ/SYdN2rGZeHQAZ30CrpWHc1LsLckS6BgwiiIK1ynu5e4LF5Dmh8DcgnABr+7M1lh0S
 XzHizPwXqx1hHMoAXQ+NYAQR9tQbfirjN4AIb9rHjyd497nU3Z3HpelpJCcP4NnqiypH
 /KYQru1vN0l730evgQCdwEAvPJRfdwQznSdPhMIQ1pt8TraAVCr4QS04G7ECywCsnJZ1 zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0auag0p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 20:53:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 388KCAAD030576;
        Fri, 8 Sep 2023 20:53:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3syfy1vf09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 20:53:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eERnD3TFkbhmVPb3n5rJTtf7ZpRkW5vIBx4Z3MyD243P6FlQaRvEQ4s9ndl/vyZ6oDVwZGMPc4N1JNydFm8q7fXjsZw75QubFeaAbrzzGy9oSBdjuGy2wkL4C6Cxm2xqGbFZvUlFT4Yrbj0Dflv64ldG/cZghkD08xOAX2gTBKiEDCMY7KSQyAtk74e/WL7mHrsNaYbC+jtc6dRuDW4f8VDbKxVDAItoi1UNgI84niUh7Ci4dshPx9Vm+Pxou2MdJivPrsg5Y6OHo0iWwqNUOqkRsiicMDsSeI2PWX3q6fkxi9800HBy17hQuJUSSZnsg2EBOCKN/fuBX0iJ5xAEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZZvlkBXmXKbCOOuIf+PCvILAQseIk3LRheuTlY3nrQ=;
 b=MMhOm+LLQS0wBNsMlxsTSMf4nnW9AxHw8N+PgDQ+ZNNtTRZrablU56HjfYVy3q5GzKEUVJvRZ9QLZAhZ+Du+Q6fx2LFETvZhaFuU9TeFMd9MvjDE2j6wQR4mySfJmxajEfDrt3/M8Xx/18dmqdC9uXI7RJwXn72sPmooe7a1fGTrdN6cUJAzXDC4T6NWVWOl/ULJoI1gD4ivxPNCRs7/8xf4KgTDo5uc0B7pBV//v5jr2tRSfn8AkmYhuXLhgxgAEQwX9gHB0J/QRFlrNPrSHKzqfzuqpHSnccftwfZv/0XlISRGJ01/5H86ZyEBPXBBUFHwJfWctw54x6IbjxbdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZZvlkBXmXKbCOOuIf+PCvILAQseIk3LRheuTlY3nrQ=;
 b=yphM29GSslqnbRqPMcXlQw6+BmGGvBE52Ltc763wGnfqgoMSczsZn7JUq5qz/+eduSdtpxdxI7MTaUjhfHoFNwIILnNh+KkfZIgp7xTGQ1SAQagvMHngv1isyLIwoRQx4qMpFVpCM+VwYtwkJfY+r4XmXv4jJV5M5V55LHBmrhY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA0PR10MB6698.namprd10.prod.outlook.com (2603:10b6:208:442::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 20:53:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 20:53:44 +0000
Date:   Fri, 8 Sep 2023 13:53:40 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 07/11] hugetlb: perform vmemmap restoration on a list
 of pages
Message-ID: <20230908205340.GA62663@monkey>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-8-mike.kravetz@oracle.com>
 <5e091211-9a32-8480-55fb-faff6a0fadef@linux.dev>
 <38E2F051-E00B-4104-A616-0EEB2729386F@linux.dev>
 <20230906211234.GC3612@monkey>
 <B8F68838-8C78-4BF1-AEC8-D89BCD49ECC7@linux.dev>
 <20230907185421.GD3640@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907185421.GD3640@monkey>
X-ClientProxiedBy: MW4PR04CA0340.namprd04.prod.outlook.com
 (2603:10b6:303:8a::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA0PR10MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 468ea7e5-3ca3-4dbc-8096-08dbb0adb076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XojvQxAkWkcjSaQh33MZOF6muQsrNr+eYSfMI1kKTxIPntLI4mh8lBpCbQbr6CvtKFzubqa+wz/cgyCcW6uMNF5lp4QiJJS5bfcuup6Madz5UrhuJWyv42CuB3mENNcbBzDDJ9ovadDza4zGSxFwx5OZmlHqcXWwx/mPLNWEEx0S/zaGyIwD7msjRPYSN9SBxN5vHwsFKsFYPdoVhg/yNo8cnVDcf26jtyreDvvHESo0XmezL3t3kFSrda7XcuZvR9FofOr462v5Dk1ChI+DV1W1FP04Ljuh20zb1XDOeAEOmGqPthd/TKjRd0WLWBf4kaau7+tc9JZnxnhpCpz5I1xoxOr1kPX2iXdFDzeIs9f1T22SRj78kjIq4xJPyoWDlnACF2A1ReNU/1/agwgSczLdUt+oUSkNNV6pBMsQsb/jllstAp9VXGcPfLwkGNsbM2vm2D3RhQQqP90uKF4veqVss6F74BUdj8WGYymKk+UWKwHF+gI7voFYX1eSj7buNj0v8NpoZncawj++bRSBFf+yfSuxFi5RO38Yfoq8yWO8u1amA3RRWi4F8GeIXfTC0yaQQox7QwNjRiQyOlrZjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199024)(186009)(1800799009)(8936002)(4326008)(966005)(8676002)(478600001)(66946007)(66476007)(66556008)(44832011)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(33656002)(54906003)(86362001)(6916009)(316002)(6666004)(6486002)(6506007)(53546011)(9686003)(6512007)(33716001)(26005)(38100700002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DzadguY3eK6WsmLaMxevjOM5Q3Xv7wpExvnHnxM/ta030xkjFp1xYVEY/UKq?=
 =?us-ascii?Q?dA/BQ9VbWkJ6hVBV4ZWojFfMEypddYiedZAx2ZjpXVUI3CjEY1ZM/Q8+O0F9?=
 =?us-ascii?Q?3cxmvo9LSXKA5UE2tbGED9nqlkQX9cdm1sxK/UKmqFp/AEDiTatR06zmmzOi?=
 =?us-ascii?Q?PNSIhoQx6RY7gnN8Y4SmHlknXvFQ8e3rP+JO65pf6z3WQqnsdPM78jukAigL?=
 =?us-ascii?Q?PfO7omLCzldTitQy98KiqIse0a0UDvv/+EP6a92BaQLhozfz/EITw9nluKMu?=
 =?us-ascii?Q?eQdeWEe0loWNq7tmcJKxJuL2DhjpuSSgLHFn0nHnmlg1zEKpJ0n2ikhh1a1s?=
 =?us-ascii?Q?apGV9y1M2AONBhw/gMon7YhdpsinprWkUds7d4d3zEcJ+B/3rTdnZyevzhwD?=
 =?us-ascii?Q?W26V0onBZT3GzsD0OTdsRqkqVUo9pgRYE8c1PF9ux0gUqDkk7VLLp49Ayi5S?=
 =?us-ascii?Q?Fvv7Nxhk+UCUKBUK+Dne6vmSnbnMdDns4EKKTbnwkYfaGr8e0CR/v8MMFNW3?=
 =?us-ascii?Q?4phL5c0imFvIQAEzz4exbvRfvcWRW6yFSdSIi2WkLhiOHEDeZOWPnLHPRYG+?=
 =?us-ascii?Q?fzN9f6z5RSCnPAEEKq9/U3dJWdGjJ5C2rIjJ24CSEvMxrTuMr/uq9AzwQXKh?=
 =?us-ascii?Q?gW+F8xh7YIZc9ENqIXltfG1kFEjmkOsjdMbtYc8PXdHGa5qx04any1m0GnlH?=
 =?us-ascii?Q?mnG1kMFzckw2X9s55AZtOm3QphlXM34XZE27WM0b99oShgcVokoXTuctljUt?=
 =?us-ascii?Q?6t09JJge+QxCGkW0YB4NR9mFDEVH1ih0zTpsVcRPHrhhxzTA9xueTAUfdCgE?=
 =?us-ascii?Q?sxTfA/awXMsJX32WM44JvgTG2itK9zoaqKW14CJO4+0br91qGYqD1gtq+0RM?=
 =?us-ascii?Q?m5vJbV3qzoHMt2ssr6MSDXHnYuDj7WoFjY/wJTLKdDbb+FPM3XfUmEUEYbyD?=
 =?us-ascii?Q?vcrK5vyS9DJ5e9YY5ZMytm5+mreqiJz6HoqdrQTJVf5C93YjhvA/Qms0WrLK?=
 =?us-ascii?Q?mVW6sqN8MygtdoR3+0NaZwds507BALHjaquybfY37iDNuBv71yCO4AUT9EG7?=
 =?us-ascii?Q?G/80uYEsyg4dNY4mzx2kAaFgeASVjzVAjXDGhhgKx05BPnl4p/KN4BGmHdMQ?=
 =?us-ascii?Q?wV7izwE1PsANorLxCwx93UriyLxi8EMJ+BrVi4T5SL2JuemQIuQzoq76TMUI?=
 =?us-ascii?Q?U1MquqmybHuFnUKzN3cKky2+NFtJGkkY7bViEjolY97ZSFIsaqryz1nw9ZC6?=
 =?us-ascii?Q?yq7p1m0DJwq223RtoULu5PQtirguq4JPrkTo19NyDWlnM9I4QlWgyZ9chwvG?=
 =?us-ascii?Q?6PolJra0cMzyYKPD2E2KgYgeY7vrTrYXHfEWLVFAF7/e3QoNRfPmJlZQIkZG?=
 =?us-ascii?Q?llTQHaouFNUR6h0Fi8jKn8nVveW2+3QZxX7gABxsmdfTIp01hjQclXOWFTkv?=
 =?us-ascii?Q?fC7r65lnHX2RB6n6I+2TrQLc/HLDTH8W4GxQzPNZ/EEbgc2gimEI2+WOltwy?=
 =?us-ascii?Q?9wGCv5VB+XO+yVl1LdLRAPNl8Q8N8c8tFizq0Ezf97uNJ0TkO0+eWwT18vsp?=
 =?us-ascii?Q?MkaaTM/t7rxHKAUPbSJDeuXNKtz83fGmVZJFjSqdlkrg9wFJOxAdJEzxh4Eg?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?IRWk8dunconepwXCfNLO/ARllxN0t8eCzCxj7LggYGugpXockf84arS5OQe/?=
 =?us-ascii?Q?eRKeoEKEn+d4jF/CrvSDurrvqHd7XM5Fmden2NoIJ9rRPodrhgz+eXWmuNBU?=
 =?us-ascii?Q?Rg2zsuSV0a8j4ebKCmSLhwX8ePgARvmzs6fhOb6sUkvirtzwrb/ZXVud8u18?=
 =?us-ascii?Q?tkCTYT6uuGNzG/SawHSGjHeahOP11uQEXfq7CIN8eYDGVJQBGzpBhGkXqgw9?=
 =?us-ascii?Q?IdkPgufDN9EBmKmA+QlUuPeL5AIHHShKrPYWkL7o81yn5lDXI1TrA7aMPTra?=
 =?us-ascii?Q?mFjr1QA8rX/EG6AYuWTiL2aC0jfyQuOwCyasXL6fKWFtaXokXpGMvHFd6TZ3?=
 =?us-ascii?Q?LqCSHZIDJA0u3csVLFuioh4EKF7V28rXY7f8TcIzM8WZswCmfYiGjDooXS5C?=
 =?us-ascii?Q?WmzYdx9YAYq6fxe0LkpfUj0PgCU0C+gMui6Tvu7qa4aSvLmCndlH1gGrbCWF?=
 =?us-ascii?Q?ZR+R9hZHRpcRWz3YWpyMs/ksFcnT5VUmRoCh/vKk8ff8/Xl9WjiGvBUPwLIu?=
 =?us-ascii?Q?eKfhDlNc5f4CQeUQuFD88GsOEvk6YZ1DoJc2ied9kMFGiznzaUe5LQvUdzcI?=
 =?us-ascii?Q?AymcOUeJmojGAZTt9MJhAIeopW0DwDK4T4IjrAretozpyg78pmPYV/iEyhEY?=
 =?us-ascii?Q?Z3Z9ZgDMwhjm2ZMSYlvrVX2XUgRFWBRXEA5hAppDQ73nH8wnwk/Sr1pH/1j+?=
 =?us-ascii?Q?MZQmxkIXsrm1bndJnHxZBjYJ9jQEUXjZwDuwwelwzF49QeQYj+qRSoOW3sU1?=
 =?us-ascii?Q?PW13P/RiM93CpfuWpL3cFe4oZi+8bqbaeyF3+Ull9fvPCuwYZQYG1Q0N/2oc?=
 =?us-ascii?Q?jBH+cxfg3aMMTuKXu2sQsOyOHwIZKelrthRsT6289LVIPM/fL9ZmH3zRP2nW?=
 =?us-ascii?Q?GlhGx28MXQ+GTubDpoASvo4VayEdgcFFYHpjENmW8nh8zXlzjeq31jiekkDo?=
 =?us-ascii?Q?m9TF8tCdu95HKvvf03DLLwe8tbab5kV6Vo7HcXCnWQMghdx4ycLpkZdnNYEu?=
 =?us-ascii?Q?I3pFSgvS+bLOVNx2FQSSELGTGYfnJUzQ9tckA2MBUTsf9DByf2hNOiJpRfro?=
 =?us-ascii?Q?Mkn2QZIu8kGlmxpfLNJENkFbvKz/GKWXnE4bfvSPbzhnGAZzYl4Iczon+quh?=
 =?us-ascii?Q?uFtlF/d4POc0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468ea7e5-3ca3-4dbc-8096-08dbb0adb076
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 20:53:44.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yhhEHyE4Lg7DMPXLIDrvcaHH4rN7orS1h+HSYu7f2lQQqE+9JHzLxGt4oU9x52aso/yoWr1eJq0Jj9r/dGuPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080190
X-Proofpoint-ORIG-GUID: vM0P0S3Chc7g4pLQKqXQYbQjAYLJsVXW
X-Proofpoint-GUID: vM0P0S3Chc7g4pLQKqXQYbQjAYLJsVXW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/23 11:54, Mike Kravetz wrote:
> On 09/07/23 11:33, Muchun Song wrote:
> > 
> > 
> > > On Sep 7, 2023, at 05:12, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > 
> > > On 09/06/23 16:07, Muchun Song wrote:
> > >>> On Sep 6, 2023, at 15:33, Muchun Song <muchun.song@linux.dev> wrote:
> > >>> On 2023/9/6 05:44, Mike Kravetz wrote:
> > >>>> When removing hugetlb pages from the pool, we first create a list
> > >>>> of removed pages and then free those pages back to low level allocators.
> > >>>> Part of the 'freeing process' is to restore vmemmap for all base pages
> > >>>> if necessary.  Pass this list of pages to a new routine
> > >>>> hugetlb_vmemmap_restore_folios() so that vmemmap restoration can be
> > >>>> performed in bulk.
> > >>>> 
> > >>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > >>>> ---
> > >>>> mm/hugetlb.c         |  3 +++
> > >>>> mm/hugetlb_vmemmap.c | 13 +++++++++++++
> > >>>> mm/hugetlb_vmemmap.h |  5 +++++
> > >>>> 3 files changed, 21 insertions(+)
> > >>>> 
> > >>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > >>>> index 554be94b07bd..dd2dbc256172 100644
> > >>>> --- a/mm/hugetlb.c
> > >>>> +++ b/mm/hugetlb.c
> > >>>> @@ -1838,6 +1838,9 @@ static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> > >>>> {
> > >>>>  struct folio *folio, *t_folio;
> > >>>> + /* First restore vmemmap for all pages on list. */
> > >>>> + hugetlb_vmemmap_restore_folios(h, list);
> > >>>> +
> > >>>>  list_for_each_entry_safe(folio, t_folio, list, lru) {
> > >>>>  update_and_free_hugetlb_folio(h, folio, false);
> > >>>>  cond_resched();
> > >>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > >>>> index ac5577d372fe..79de984919ef 100644
> > >>>> --- a/mm/hugetlb_vmemmap.c
> > >>>> +++ b/mm/hugetlb_vmemmap.c
> > >>>> @@ -481,6 +481,19 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> > >>>>  return ret;
> > >>>> }
> > >>>> +/*
> > >>>> + * This function will attempt to resore vmemmap for a list of folios.  There
> > >>>> + * is no guarantee that restoration will be successful for all or any folios.
> > >>>> + * This is used in bulk operations, and no feedback is given to the caller.
> > >>>> + */
> > >>>> +void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list)
> > >>>> +{
> > >>>> + struct folio *folio;
> > >>>> +
> > >>>> + list_for_each_entry(folio, folio_list, lru)
> > >>>> + (void)hugetlb_vmemmap_restore(h, &folio->page);
> > >>> 
> > >>> I am curious about the purpose of "void" here, seems it it not necessnary,
> > >>> ritgh? We cound see so many palces where we do not add the void if the caller
> > >>> does not care about the return value of the callee.
> > >> 
> > >> Another question: should we stop restoring vmemmap pages when
> > >> hugetlb_vmemmap_restore() fails? In which case, I suspect there
> > >> is no memory probably, there is no need to continue, right?
> > > 
> > > Recall that the list of hugetlb pages may be from multiple nodes.  My first
> > > thought was that we should continue because memory allocation may fail on one
> > > node but succeed on another.  However, with
> > > https://lore.kernel.org/linux-mm/20230905031312.91929-1-yuancan@huawei.com/
> > > memory allocation should fall back to other nodes.  So, yes I do believe it
> > > would make sense to stop when hugetlb_vmemmap_restore returns ENOMEM as
> > > we are unlikely to make forward progress.
> > 
> > Agree.
> > 
> > > 
> > > Today's behavior will try to restore vmemmap for all pages.  No stopping
> > > on error.
> > > 
> > > I have mixed thoughts on this.  Quitting on error 'seems reasonable'.
> > > However, if we continue we 'might' be able to allocate vmemmap for one
> > > hugetlb page.  And, if we free one hugetlb page that should provide
> > > vmemmap for several more and we may be able to free most pages on the
> > > list.
> > 
> > Yes. A good point. But there should be a non-optimized huge page been
> > freed somewhere in parallel, otherwise we still cannot allocate memory.
> 
> It does not have to be another huge page being freed in parallel.  It
> could be that when allocating vmemmap for a 1G hugetlb page we were one
> (4K) page short of what was required.  If someone else frees a 4K page,
> freeing the next 1G page may succeed.
> -- 
> Mike Kravetz
> 
> > However, the freeing operation happens after hugetlb_vmemmap_restore_folios.
> > If we want to handle this, we should rework update_and_free_pages_bulk()
> > to do a try when at least a huge pages is freed.

This seemed familiar.  Recall this patch which Muchun Reviewed and James Acked,
https://lore.kernel.org/linux-mm/20230718004942.113174-3-mike.kravetz@oracle.com/

If we can not restore vmemmap for a page, then it must be turned into a
surplus huge page.  In this patch (not the previous one referenced), we
will try to restore vmemmap one more time in a later call to
update_and_free_hugetlb_folio.  Certainly, we do not want to try twice!

My 'plan' is to include the previous patch as part of this series.  With
that patch in place, the list_for_each_entry calls to hugetlb_vmemmap_restore
can be replaced with a call to hugetlb_vmemmap_restore_folios.  We would
change the behavior of hugetlb_vmemmap_restore_folios to return an error
instead of being of type void.  If an error is returned, then we will
make another pass through the list looking for unoptimized pages and add
them as surplus.

I think it best if we try to restore vmemmap at least once before
converting to a surplus page.
-- 
Mike Kravetz
