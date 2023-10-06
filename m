Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C432A7BBE33
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjJFR6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjJFR6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:58:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896CBC2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:58:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396Cbw59027830;
        Fri, 6 Oct 2023 17:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=SafbgJCqcBVK23BqUbWMsN/OWU3+bcN3jUoXt28ZByI=;
 b=XjcMm5D2XTW1RxNYfCWB4HM0KMLnEYVBFWf2P0myZxV27YnBWSG+zjuKdRPeP4QDQuv1
 WFlPevn/T5kv62rWoGJvXX4TNV/l25x5Mig8yJbreJkzX0ITF7rHBZ7XrQwGJA3RS+av
 0RcgCcLejdl/2/tKhA9HOXM7HMdC/Y6B/itXnuE82+nYU2x/mBRtkndyT4PmA9XPxSd0
 DVhe9Yy3zalKK32wxsa7bp6QnZL1kdouu+iPny1DGy/MECUD4DwEI0Qyg3XNiKrpJxVN
 hEXag57rv2meZ8z+qBTd7vM40kKB8ziZ0T76N7kClG5TH8gZ6+IvPQYGZO6Ugk0fy9vl dQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vmaeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 17:57:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 396Gl3IU005789;
        Fri, 6 Oct 2023 17:57:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4b24pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 17:57:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9e6t+2MYeaA2cj+o08Cvmvf0sh/PGZ/l24vdqFAW2wqc8DMaEEeuvxlFyFsGuEVJKzfOsF5B7xYRGyVqo6JMjCtAf8vSJzk1zLfFmBVbLlavuxX6Bf3jV8eiYACctHahWaseKQ8MAVGFbvhgGE/LUVzc+3HW7IEzExwTMTCR14PsN/rZ5ctimdBTd50um5dsi5Jnc0QGz+j5ELhNv8hDmwCvixYUYUeF7Vpzw2nm4rkyKUYoRUiZOOW7saRYx14HZZVfcPiPC7MKCdxEBEcBgbaoCizWZ1ToCzci7/db/BvDdr7YH93X1BTzQGfBianhHW7WQRtk+12Yp9LbAmAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SafbgJCqcBVK23BqUbWMsN/OWU3+bcN3jUoXt28ZByI=;
 b=FQOg8MOddJaFGUpgjHkKA9ZZUIia9aHvx6VlCxtrvQzG/vLO76ExnKU7Z63CZz3W1ikDSP1HxFTSXsFpWSQwxu+bgiXdbiaJrYNvUgMaj3LglUQp2nafFvhhwWsXcHbjS/xx/B2Hjn3YBQPuhvXp1F4sCl39sypD+VsYTD5yvIlrwLWTf5TiGuTh3xZ4+XMhPF64ccTvgBDHDhIZ8k34msFS9UXFr3uHL26kgtXzeSk2CDC83lhxblYoV6J7hKLDC5M3AAPNi22PbEh1ajh4wcGMJgO18PzmpRcZsLiD5r47212uMro/aKMEpehMbMnjrrjTcs5+32KvQqTCounveA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SafbgJCqcBVK23BqUbWMsN/OWU3+bcN3jUoXt28ZByI=;
 b=pVRk/fD1rCnS31aCQQ7w2vGWliWBO26piVsNReqPAkTEF55urFow9Mv/bJVzKAdQm4pcgdARJWVsFDQJjzmxio41EdCO0GAhFQF4YY92m3u1uZPx+W7NFnU83lMXQ1/Mp9aVvW/5qy3/SE7qESK8ILVgbNDrlJurZ9k5pfbn0RE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5309.namprd10.prod.outlook.com (2603:10b6:5:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Fri, 6 Oct
 2023 17:57:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 17:57:26 +0000
Date:   Fri, 6 Oct 2023 10:57:19 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org,
        stable@kernel.org
Subject: Re: [PATCH 3/4] hugetlbfs: close race between MADV_DONTNEED and page
 fault
Message-ID: <20231006175719.GA3861@monkey>
References: <20231006040020.3677377-1-riel@surriel.com>
 <20231006040020.3677377-4-riel@surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006040020.3677377-4-riel@surriel.com>
X-ClientProxiedBy: MW4PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:303:6b::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5309:EE_
X-MS-Office365-Filtering-Correlation-Id: ff29e005-cd1d-4699-63cb-08dbc695b351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOnzqVhoQIQoNU1klIV77iz9UTj3Kj/A5ZyqnyuBOx7JewqSiXlYvXsvsG9xldkaDZjhbnh120L7JiIELgOnVWwIGOwWIib/DNUoL1PjElUVfnAGrqAeQafpgtMMN1rHT/DC6/ope9lCnuYGut8i3hp0pOz7H9CXGjf1D+2j665vLYaOkE65b5iow2948XJxX/VOAFu3p5gHdYnxfFYshLUs9e1dAMqzVZBet+paaJfbk2uVep36GDryAjeE2qxap9vQMYvouyZLRGRg/Zgu4viGFdknAYRS7pli9x/KEUSD9UcdyFuYfdZhsnc1fedK4LGRRxrTC1M8OUT81UqF4tQIPMFUwb9ckS/ozC/b2o25a1czqcCqJof1eXgEG2/tT85sMTOO/Dlua0L5UjEWY5ms8ugv1hLxheAFIkV0A9tTVWIgxSpLS5vlGRxqyvCl5gWKitmm+DZYVUze6ZhvRUCjbPg4ouorR2lc+xAIW3c7Q/plNu0N65p8+CwcCmAXYnHxpjJtUOTL4QX7xHa/6JqIlCqZ9rNox3N12bVLFVE5R9YifsejSIz8L1FBxwj2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6666004)(53546011)(83380400001)(316002)(2906002)(8936002)(41300700001)(44832011)(5660300002)(4326008)(8676002)(66556008)(66476007)(6916009)(86362001)(26005)(33716001)(66946007)(33656002)(6486002)(6506007)(9686003)(6512007)(1076003)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X0K/kyqilrOVmkTZGIcK5jJfI+Xc8MjMDvHiqoJiGx38fiYt4aV+AIHq64NH?=
 =?us-ascii?Q?VwQ/pNoBLrsXpBK/kpqrbjioelSg1v9XeTDFJSkKc9TEKuHyyUClDVmls5sq?=
 =?us-ascii?Q?EGOueoRPt68+oeDhp4JhPfmabVmtZoQ7Wk6qO9PWZcYqoaS8NJDRnELDzySD?=
 =?us-ascii?Q?blyP2sR7YghOcSTugB4u2L8HTy6z3G5hmKoHkGXI02j08vPfoQcLTl5y53uS?=
 =?us-ascii?Q?omvlJDUb3/HVtdv5wHT5SfmjIprPaGqOOstpe/5U8biEuMTAhUr9fUdB0zYc?=
 =?us-ascii?Q?QP89rhh4dY6Q1QcgQpTmpfqL2asAK0cauFjtwWXIywIewUhBShRkG1fKnsVj?=
 =?us-ascii?Q?YXBfLBZqiVd8sYy0FwXSry5v/CXU0XEn/yBiUw+szR3cuP9ZxLJeqkaEkgwi?=
 =?us-ascii?Q?7H70vskT2qUMZPDinEyXQFEwBdwM3rWniBDxtMtuiLlFZ+2ko4g5qMqats+I?=
 =?us-ascii?Q?FEjsnEOcKN/sT24mqEYS6Wc4XlPLPu/EtO+g/p+7jPpBrE5HKy2SnpCJyoqw?=
 =?us-ascii?Q?3urrwhDMxUsl94s2YPBm3gAK0o7uPDgbVSua3biYLOUi5bAz4LLV8OsNJR4z?=
 =?us-ascii?Q?gkErvJNnam3vl4baPmxFBZme1cbM1hsPtUGFEGAoFhYYnTfNCryacXN9frkx?=
 =?us-ascii?Q?h7fIrPEDccE7s+/rBhB9SInqNTOjmohkSllNM4E9B0LI+C4h1ZECA5WH7oeZ?=
 =?us-ascii?Q?j6B1eXgcaUwlds4rInA0pqZkapVl1MBkQ9gDsA39MTXonhk7+ML73CTiYWj7?=
 =?us-ascii?Q?d5dpie+HRVuY5rCyWp0cg8Emxqoc3HQY4SNjI4ObqxP/L8A195XmLdpqZRnB?=
 =?us-ascii?Q?372tDudzBM9SH7xF9mfKGoB5G3q9TgeDI/1eqlhmUYjI8otj5w+YWXRGOPj7?=
 =?us-ascii?Q?bdP2dXr05l/nmNMKZ3KHX8VckByhK9exWFLjPQalLIbQNCxfYvXNiqqkBf64?=
 =?us-ascii?Q?CNSV72LrIqzLAMzJ7u99we8XS0gQ/CT4R1G7vDBFVgVv3mhnMF0v1zCF5b0t?=
 =?us-ascii?Q?eUAf906pfxl2UnVCj8P48jbd1IJnUdA5OfT8PL9bZNQfE+OntysmYvZ4c324?=
 =?us-ascii?Q?xbDLHqpCrwtZ/ahN5dw4EwXgNqTE7bfwLMx7Runa3zXgnbgoUbM0J/HOwJ+z?=
 =?us-ascii?Q?LKUIC+Fik0jpf47OjC+MUEEwlNLWO+cQ/nXgj8p4A9niQhr0DauHlALprl7v?=
 =?us-ascii?Q?gPWg66SccX/sZMu2uC59spLN5fgvQ02am3mjgYWVU1kg3EjyEb5zLmZWjGqn?=
 =?us-ascii?Q?MLAHHO4MsEfT3JLRUTMxFHWyoHfzWIo2WVtGRf6usQjjSle4JPhhUmKOtO5D?=
 =?us-ascii?Q?NzO7a5VN6trxkqDfZNgnK7AykexLDoHw9rgB6AmAgrTn0wf3bANiBqYk6xfD?=
 =?us-ascii?Q?4dOtaXu9qlSRINk+ZtRqx6HeQqqE7nOm3Av3wjDMffKbj/7BXRZjR/rlXxXm?=
 =?us-ascii?Q?FpECf/STcWRn9/DTyZU8UhMq0ILgyswvHgL7O+X1uJPuEQsiTwc58t67I1jB?=
 =?us-ascii?Q?qimYQzocuvQMBEbMcr78Aj3/vCQGrnDVd56VlwMVH8kSKr1uPzxOqqOdMMLi?=
 =?us-ascii?Q?JTXANBhL1+LJ58AohJXe6PzAw8ENLWyAobhUaFSP0MGDnP4v/ocLzE4cSV+8?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?x3p3jjiPdSD8dhNHKTQh+URASmUO2Ic0pAwS0yQQpFfjqdITZ16MDfnyu4zL?=
 =?us-ascii?Q?UODloE8eI1sPP42CsCnJQyHo7Z7hS6GAJXPqGtDFSSSZZhWgoDEEckeg4ccE?=
 =?us-ascii?Q?rB00BLek93h2yCp8dmlV/YwsO5yOYo92XAwuzFYAbHBLIGk6odk64HybpQtR?=
 =?us-ascii?Q?OUU0QXCq7UEvC7Ks4lvFuXLvGo5IuwMB6LlKjWV4t7Wnmk9jahx32ZCxcH5f?=
 =?us-ascii?Q?pVANPPXUKRN6Wx49PTbqeDuBEIUnJVFYcB0t9/N3tW0/o+cix9d4WseqiNzh?=
 =?us-ascii?Q?7WHLhyhyL1BIg3PPV0qalHk7rWJvQOKHZAeaS+2I3ak1ptEa9Gj0F3xGsxld?=
 =?us-ascii?Q?WyYxib/C6MYce/MCTnEB1mejM8EDvBh5GXJGvWt/LKbBRW0CVhkMFYg/1djm?=
 =?us-ascii?Q?yR/O8KXV0zOg6Qw7J7GSh7Dli252wfLnsPtnBT3wkZRJ8LszA4Y4IylEol76?=
 =?us-ascii?Q?kxhQdDyHeSzWDXPoGPX4zTD3yEHdsGDxigN39YtU9ac0vrQQZnFZbR2sQjI4?=
 =?us-ascii?Q?uTMc6qORE/5CYwfcc+abhAhR9k9P8Y6JaKt3KoId1XghvwMPnhuOKvTIcimf?=
 =?us-ascii?Q?Z8wBLqTaitobJtNpA9+ku76WiFV5CYzmZm1NY/xE5UvHN0XrRGgjERKFcs/L?=
 =?us-ascii?Q?E+dNglgkq8pryOEWtfoqfAfoXUEgL0MpZzlVBuNLpCpXF1wVG4u/zA5CaaxZ?=
 =?us-ascii?Q?RON3HZpwZGOCfUXy91mFsiy8VtfEqF30KwyDvs9rvh719EZOUpeREdcknKIp?=
 =?us-ascii?Q?7GfSlFc3kg+qJlRxHG07rFwDmNZvyn9s+ae4fHMP3bS686vvgccJV3Aw6RlZ?=
 =?us-ascii?Q?Ko670wr4lNEqEPvr7giPuFi9cla0zGblrPpOhA5ZuMPx3W0pcpyvQrA/ddcT?=
 =?us-ascii?Q?JWYJDCY9OvTD23RFw7KT0RzrECUFdeW2JoXmaDKAYD20M83ez144/J2BiV3l?=
 =?us-ascii?Q?LN8fKE/Kh6yAAa+ubC/pKoYPpUAezg83l+QJM6AhygI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff29e005-cd1d-4699-63cb-08dbc695b351
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 17:57:26.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Ba/4fzIwfAMphyK0stUPH98Xqxi5hXNtanpnArrSUxMeCSIOWLXdBShSGYOhNPLGXvTsfZQForLkZYM/CazRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_14,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=787 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060134
X-Proofpoint-ORIG-GUID: ZcV2njvPRJbdbEl1S1CFjMnKVq3GoliZ
X-Proofpoint-GUID: ZcV2njvPRJbdbEl1S1CFjMnKVq3GoliZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/23 23:59, riel@surriel.com wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Malloc libraries, like jemalloc and tcalloc, take decisions on when
> to call madvise independently from the code in the main application.
> 
> This sometimes results in the application page faulting on an address,
> right after the malloc library has shot down the backing memory with
> MADV_DONTNEED.
> 
> Usually this is harmless, because we always have some 4kB pages
> sitting around to satisfy a page fault. However, with hugetlbfs
> systems often allocate only the exact number of huge pages that
> the application wants.
> 
> Due to TLB batching, hugetlbfs MADV_DONTNEED will free pages outside of
> any lock taken on the page fault path, which can open up the following
> race condition:
> 
>        CPU 1                            CPU 2
> 
>        MADV_DONTNEED
>        unmap page
>        shoot down TLB entry
>                                        page fault
>                                        fail to allocate a huge page
>                                        killed with SIGBUS
>        free page
> 
> Fix that race by pulling the locking from __unmap_hugepage_final_range
> into helper functions called from zap_page_range_single. This ensures
> page faults stay locked out of the MADV_DONTNEED VMA until the
> huge pages have actually been freed.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Cc: stable@kernel.org
> Fixes: 04ada095dcfc ("hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing")
> ---
>  include/linux/hugetlb.h | 35 +++++++++++++++++++++++++++++++++--
>  mm/hugetlb.c            | 34 ++++++++++++++++++++++------------
>  mm/memory.c             | 13 ++++++++-----
>  3 files changed, 63 insertions(+), 19 deletions(-)

Thanks for all the revisions,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
