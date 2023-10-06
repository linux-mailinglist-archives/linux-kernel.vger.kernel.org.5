Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F57BB07D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjJFDVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjJFDVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:21:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F1AEB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 20:21:20 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3962OHKq004811;
        Fri, 6 Oct 2023 03:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=xoACsKEuLfdGzaswTJlVElsJTMkB6WtgGWU8LDfGKEQ=;
 b=YF1CbUhNRlcYBGRQCe2pCeqQnaFkJyUqW5NB5lroLJFmULY/Sk+p2vAdCTATvMu0RARA
 OJFsmLVWX7OT3S188RbuZbbE/ER1903O1/wyUHRriotGNnbycP46c/r7ufkhtMPCEc8w
 pzSpQ6yj8w0H6Oi7NNcRDcK2pXfH7RIuxM/RChEmwzJCMLjqvVGPsL4wV0e4/aBWG0Do
 W8U46qyHAI1UTGKOOJkVxYOPMrU62VkXBni0zHnK+twrpFv11DaLNKx3kruhVK3Mi1t8
 zCjcAFdbHfpUWakMU5nFICp4k+DPmzFLcyq1MqmEwDx/nj/47860n9Fs/QQ858bJhQ+b RQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9uk15a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3960X2DP000467;
        Fri, 6 Oct 2023 03:20:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49xvyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BObRPbY1NENFSsKHphpwfHGrQ/umd1I67fYh/eV4p5BPLDIyng26MLmGxjiuSSoLMViPccSbgK6QrlrmZmKmi1QL7Yr6616IsNdd9JaGSHfeRYecUt3rFI01CJI2E8CV6qF/CgADu6UF9l6P4vFf79zCdwTUY/NOkRWN+i3hn2bFcOUb5DYwmZoxvFjIxpp3l1hECt++NdGZhyMD8V3dHLN5OJg32kYjpzNyQ/ZUZ3oC9au56QEtltYL5EU8LobjNup+EXQ1Cl+EPBwjyHIvB4epTOZz0UV9EJHjQfXMlwo3U6c6e9xnu8O4fi3njIDeJVOrc8yzrZSPHauCAsqYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoACsKEuLfdGzaswTJlVElsJTMkB6WtgGWU8LDfGKEQ=;
 b=Vv8xCcH1QN79jYJ4U+QDyIC7SZibx9V5x/BUnIbdcbPVuOqsEtDbOeL6bs3LJCok69JNhTBlrdUsp3BTE4JJwXDkS7tLTiR0sk5ZSf0tpV+DLH540x7R4UhSC6hZ/80UHhdmi+7u6KFL3RP3B7KFhEdDK1i9foWIeepvbpP6tDO9PNA+tcR9iC6JDE0cEncBuCzMrSntSHVv839moIEgy9u98s7MASgLkisHxC763LU0TSxXftLLQTQof5KjAErpv8JcP/JISXUHu/5IGC6t1IiIQ5UsZOAr653YWVjCwSM4QZ+U1NcNH7OUA+8OXo+dsfYCFeToskUyG6ND9AkBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoACsKEuLfdGzaswTJlVElsJTMkB6WtgGWU8LDfGKEQ=;
 b=RiMHOq2Jj8umYsIfxgWusmKcR1/PPKhmEPBOcpOs8n3+O9HvLsa3/qy0UzTbX8OOVNWQYOcdx7vSAZQ71h3s7nWPzS2TuKny4LDnOsQWsPONdO7TRvW3XvbndIVJdV0ntmxfE+iL9G0bsqlKsjXmJXXMnljIh+IwvNbvh2mBrY8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB6615.namprd10.prod.outlook.com (2603:10b6:806:2b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 03:20:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 03:20:26 +0000
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
Subject: [PATCH v7 2/8] hugetlb: restructure pool allocations
Date:   Thu,  5 Oct 2023 20:20:04 -0700
Message-ID: <20231006032012.296473-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006032012.296473-1-mike.kravetz@oracle.com>
References: <20231006032012.296473-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:303:83::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8ea91f-2405-4158-c1f4-08dbc61b2f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SjVoW38GIdNkUWRiIh7mwCynK06x3jn4QMzXerEpf7dHgkbyyyWdL+CXUWB7yu8mGz17aCLBfIcEdqHn6gw7WPLkQnJ9qDpu4zrt5D1/aeyiLbHcC1sgyUyMSUTsH75FbKs3yP+O2bL8nuFPC7pLwc9kjH3xi1zoVqJBNQNW/vM1gzvDFABHEsY91IukpVEhV/ma2mAQBGuUBLaPqyeg4UA1YGLEki7DMqn90XjnIUkNaEMlWv0As8WIfapBfN3cIkud//Zb0jSFlOMw6WctkBUijQ2nfUkYt9AtBZo50TGqMCC+n8wC1s33dEUTCAKgyHUHqxf4masN9qF1wLcYuepVDI/1TO/itWG/E42Dz6wMXBHIKCqV4bOnjSKS5+0o8ESOUKjET+vVl3+6Pp5rd+SzECIdFbwFzkDmoiILISx+hL7AoArnQdOKzq4ZelBwrvYeB18Gv6NI+nHyp8kwIxKd+w1MDWcNlOw1NfjU+oL4J3TAP2XHQ7hDiAzRw3wu/tBgdsHpURNkvygs17rziKjQ2rQp5YcGOEyK+HOD6MaZPmiJMu3LQ7x2j3BYcCP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(316002)(54906003)(66946007)(66476007)(66556008)(41300700001)(1076003)(2616005)(86362001)(6512007)(107886003)(6506007)(26005)(6666004)(36756003)(6486002)(478600001)(38100700002)(83380400001)(44832011)(7416002)(30864003)(2906002)(4326008)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BJ5RM90mkTVE9gA9QXRR4aoXZ0bETMWZwsm2TMVCbu4mBbTWv05Pwg3Cy54v?=
 =?us-ascii?Q?UM35xwlL9HWVPiAh2+mCLcFAp4c0f4cc9vLfvlODaPMEP7mjQjx0hQ8dJe5l?=
 =?us-ascii?Q?c1MaoedWp5vVUWls5dOzrClFuFKk+sUmvlhie3Fj7qyspe1v3Pa4SxRfmatx?=
 =?us-ascii?Q?gO1cztAKsvQlrXEa0jcMm9C1ftW5xKIw9k3TAmxIgwrYFRmye4J4hTHj8LV2?=
 =?us-ascii?Q?Ty8x+XkjLIrdDexj8Jhm6JO5S+YO5NmGtvuD/Scbc1uSALAN6HOIeXBauzs+?=
 =?us-ascii?Q?eIGpjv50SP1xrs+4xVYpVdk89CQwv80XFUFTUPAJ/J1Lyoi1pV7HoSWbWk12?=
 =?us-ascii?Q?r/ibjjXm8JsyCiSq86GZwv+f4Pb5XlPH+R7Qg6+y5dJQjYshVZs9/yhFYxsk?=
 =?us-ascii?Q?wOl7JT+6ntDAlgirLfh7IaVpstOqlNgUe1XBgkOnnFe2v1J5olnW3uvMswEf?=
 =?us-ascii?Q?09ATRv0/JrR43lFHtDwxPYx/aUJV41VGsvSjxzH+zMd2oxCsWQ/oZqVnLSUJ?=
 =?us-ascii?Q?Xzp7a0rDXDbBEM+WkGEHHmSEnX2xCRlWOJzR1+Ifvnkp80UCEl/kCjRre2ax?=
 =?us-ascii?Q?6mo312ePTkwzw7KkhxwSHi36YoGp6xBuI00m6PWk8ehQIfl2sbhncluUK2g3?=
 =?us-ascii?Q?DsnrNoU1WBtz4+Aud9nvdtA7O9pTKZo3dlUpobMTD2tbGjxQf5P8/4mSII82?=
 =?us-ascii?Q?YEGwRscR0yAJVD+mWHrQ5mqptGXyrhMYZvbxojiFjT9sxW/sLTR7T+mfIoNa?=
 =?us-ascii?Q?UGchJV+T2UmOJvfOv5uXeE/ulgquxin3eIpI9pqN4t+xEAtZm37kqPFcSfCV?=
 =?us-ascii?Q?HBzRJ3QW/uwg2/ZlhTvkekz0k5Y1IIQZFrZjai7pzlzcUtCU5iiRT5FVonJG?=
 =?us-ascii?Q?eQG1Fop+/Jw/WhMWzpEB1+CP04aPTZGOPYu5nIX3LUlfMzXZg7HBScV79mSW?=
 =?us-ascii?Q?UZHwFCvnYFXKlhPkEdilIvOTD2vU0MYfpW2f+qw4Og0AvhpukDOA1QIyCH5P?=
 =?us-ascii?Q?p3DhDDNrhm75v9JdfVLhH2azlxOURQhrPBykUxu1OO9xd8ThYG73o2SNjztN?=
 =?us-ascii?Q?DcV7jPKmFXrOUGNf7FKAcU/xdcIht+g5lMCDZ1UKfo5qrtbi9JeSa+iI4wLU?=
 =?us-ascii?Q?7mmrS0xgfaa1F6ccal0Cu0MuwljrOTLKfwL/dFvKaPYBh7gGTdF2SPU4wG63?=
 =?us-ascii?Q?tNFGbE0BaU4UV2YxZMPCGR7ej5tIx4qgf44Qc6zt+Bcqy5OyVZ4s40lgx1ko?=
 =?us-ascii?Q?lY2JfFzAyvqYjXVwDgPkyV7nRA2XJy0kq5acTb4MZ/fkWJiEuNn65O+r3ufv?=
 =?us-ascii?Q?kgX0s/PXme7hvLE3iLNT08Sedps6ZWsjD/3Wt6ZVKvd4+cBMN7jZtiZOZZ5z?=
 =?us-ascii?Q?wO87HStpPVLzfIKVzyYwJ9grcXbBb3PM4UEUvl+/0TOfo1/FjTTu4C0/i4bA?=
 =?us-ascii?Q?mppGFeus3PGr2sGoC+Sv502PGqBnt7fpfgHwimJje896Kd7QOjgQdYDkCF4w?=
 =?us-ascii?Q?5DKrgTcLq6U7NzvhwECRyGYfJf9cjKadMNjD2glIZPDGJATDPhXhtgr3/nUN?=
 =?us-ascii?Q?aZEIOO2FbgwCeJhBZ9B2yDMyVMn44kvyVDY/NCG0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xVb4yXmg1Eew1PjHBVPoCCMohd9f7EmbYJaOJAWmjkYOIbO0Au2hdc1YZpEL?=
 =?us-ascii?Q?o8ocFiMynv+JJmVkJC4lXtNnLYejFC4BhHejUzlbV3cJ0W7W00lyEQ4/NuOC?=
 =?us-ascii?Q?+gDKR6+rFgvmLrJYAh64qP5JrOiAXNX3VJEeDjdJpbBfAzTAwOI0WAWhIh/7?=
 =?us-ascii?Q?2djgdTxFSnyj0/Gs6LJNA9QIqnFQ8+uEJhe1lLXizCyQ0DXW3iVNRSd0hAIY?=
 =?us-ascii?Q?2Vqu2vgyqPmTQGdPdjVBkLmdVKPb+FLUK2+sy4RPyWZcgfYe7Rv+T8K7SwNf?=
 =?us-ascii?Q?3zVe3cMTSaZZPPETXQb8IjKiac70b4Sn0JCORQ8iI+AeQbG+Bf7M7KjvClml?=
 =?us-ascii?Q?7t+rbl92quI5JoHXy82jotKuRZLbw5Val3Fr7FXcpU4w8WjcC+4GdTrd5tSA?=
 =?us-ascii?Q?UNkexodQjf6dp2Y+Xw7dDtZrJgTUdjUujzDVe/QxDyqgKCgRm6rqHH3n4RyT?=
 =?us-ascii?Q?nxPtawzbsz9sSiTI9j/0lmK/KObflfx2S76tPLFsqPIJZIiFXtHES4/LFY8L?=
 =?us-ascii?Q?2YQE+1ExKPdoKUph1Yam3sFebfX7KltxAIpUM3hLZKwmwLoZfWSYzkcu4QyR?=
 =?us-ascii?Q?EwoYB8LG4DUHZLTvUl4OvYgmHBhMYFoOINE3MlETkf7CXMhluXeXn1s+CK49?=
 =?us-ascii?Q?+e1DwGd/8WvMuQ0IfSWDfKe8sXg4yZfP6k+zmME0hn+7mLdGCsn58kuxT2/C?=
 =?us-ascii?Q?L1ceTZ0v27D9nHm2v1ZGJAGldSx5TUI9713DxTtX3eReXVoUuf5RifumD1HK?=
 =?us-ascii?Q?S0QyIRTWSG6u4HNlDV8HMNpLxp7LTQKkIMXannbwFzLHW4bBN5eM3/42K1ow?=
 =?us-ascii?Q?L9zD70ali3T5GEtzyLudo2uqQHb8B77L72ePVftCihCapH1J0XbvKIqEbc4u?=
 =?us-ascii?Q?FLaZ6e/jHKlB12wQJ5S9z0pdeZX4uGiq7+WDC2gggNbIfxR1XLU/Z9t+b4z/?=
 =?us-ascii?Q?d40JiYUydAMS2CRTZPt/rUMKl18Qhm7QmMPy5n0BWvwx3TZqDd0Aajc2XE/B?=
 =?us-ascii?Q?HFG6Ah1QjHnZAWkf2hgzgEW6NgnxXUEQF413RIpqQA00zBVsr4oF/SP7mt/7?=
 =?us-ascii?Q?+P5I7xm4TiFM1PAxbRRBbQyzoB8XEyjX9EyHrAwL4I6ftt/NHMmzGpa6wDzB?=
 =?us-ascii?Q?uUmfBisuShpj/FccwKMOZeLd8KK3u36klg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8ea91f-2405-4158-c1f4-08dbc61b2f61
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 03:20:26.5812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSjA2nueTEoNuKK/IIP9UDMUMMHCSusV9AaNnZkJemfnJDQ8J4gcsqOKaMk++C1giHTT2yGbgBH5ETrmzfrnfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_18,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060024
X-Proofpoint-ORIG-GUID: YnXg2MWcJqtoZt3H-8LbkffOaDQ4f8Og
X-Proofpoint-GUID: YnXg2MWcJqtoZt3H-8LbkffOaDQ4f8Og
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation of a hugetlb page for the hugetlb pool is done by the routine
alloc_pool_huge_page.  This routine will allocate contiguous pages from
a low level allocator, prep the pages for usage as a hugetlb page and
then add the resulting hugetlb page to the pool.

In the 'prep' stage, optional vmemmap optimization is done.  For
performance reasons we want to perform vmemmap optimization on multiple
hugetlb pages at once.  To do this, restructure the hugetlb pool
allocation code such that vmemmap optimization can be isolated and later
batched.

The code to allocate hugetlb pages from bootmem was also modified to
allow batching.

No functional changes, only code restructure.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 179 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 140 insertions(+), 39 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d7679d37d072..4ccb54824daa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1964,16 +1964,21 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 	h->nr_huge_pages_node[nid]++;
 }
 
-static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
+static void init_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	folio_set_hugetlb(folio);
-	hugetlb_vmemmap_optimize(h, &folio->page);
 	INIT_LIST_HEAD(&folio->lru);
 	hugetlb_set_folio_subpool(folio, NULL);
 	set_hugetlb_cgroup(folio, NULL);
 	set_hugetlb_cgroup_rsvd(folio, NULL);
 }
 
+static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
+{
+	init_new_hugetlb_folio(h, folio);
+	hugetlb_vmemmap_optimize(h, &folio->page);
+}
+
 static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int nid)
 {
 	__prep_new_hugetlb_folio(h, folio);
@@ -2170,16 +2175,9 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 	return page_folio(page);
 }
 
-/*
- * Common helper to allocate a fresh hugetlb page. All specific allocators
- * should use this function to get new hugetlb pages
- *
- * Note that returned page is 'frozen':  ref count of head page and all tail
- * pages is zero.
- */
-static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
-		gfp_t gfp_mask, int nid, nodemask_t *nmask,
-		nodemask_t *node_alloc_noretry)
+static struct folio *__alloc_fresh_hugetlb_folio(struct hstate *h,
+				gfp_t gfp_mask, int nid, nodemask_t *nmask,
+				nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
 	bool retry = false;
@@ -2192,6 +2190,7 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 				nid, nmask, node_alloc_noretry);
 	if (!folio)
 		return NULL;
+
 	if (hstate_is_gigantic(h)) {
 		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			/*
@@ -2206,32 +2205,80 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 			return NULL;
 		}
 	}
-	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 
 	return folio;
 }
 
+static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
+{
+	struct folio *folio;
+
+	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+						node_alloc_noretry);
+	if (folio)
+		init_new_hugetlb_folio(h, folio);
+	return folio;
+}
+
 /*
- * Allocates a fresh page to the hugetlb allocator pool in the node interleaved
- * manner.
+ * Common helper to allocate a fresh hugetlb page. All specific allocators
+ * should use this function to get new hugetlb pages
+ *
+ * Note that returned page is 'frozen':  ref count of head page and all tail
+ * pages is zero.
  */
-static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
-				nodemask_t *node_alloc_noretry)
+static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
-	int nr_nodes, node;
+
+	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+						node_alloc_noretry);
+	if (!folio)
+		return NULL;
+
+	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
+	return folio;
+}
+
+static void prep_and_add_allocated_folios(struct hstate *h,
+					struct list_head *folio_list)
+{
+	struct folio *folio, *tmp_f;
+
+	/* Add all new pool pages to free lists in one lock cycle */
+	spin_lock_irq(&hugetlb_lock);
+	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
+		__prep_account_new_huge_page(h, folio_nid(folio));
+		enqueue_hugetlb_folio(h, folio);
+	}
+	spin_unlock_irq(&hugetlb_lock);
+}
+
+/*
+ * Allocates a fresh hugetlb page in a node interleaved manner.  The page
+ * will later be added to the appropriate hugetlb pool.
+ */
+static struct folio *alloc_pool_huge_folio(struct hstate *h,
+					nodemask_t *nodes_allowed,
+					nodemask_t *node_alloc_noretry)
+{
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+	int nr_nodes, node;
 
 	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
-		folio = alloc_fresh_hugetlb_folio(h, gfp_mask, node,
+		struct folio *folio;
+
+		folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, node,
 					nodes_allowed, node_alloc_noretry);
-		if (folio) {
-			free_huge_folio(folio); /* free it into the hugepage allocator */
-			return 1;
-		}
+		if (folio)
+			return folio;
 	}
 
-	return 0;
+	return NULL;
 }
 
 /*
@@ -3246,25 +3293,35 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
  */
 static void __init gather_bootmem_prealloc(void)
 {
+	LIST_HEAD(folio_list);
 	struct huge_bootmem_page *m;
+	struct hstate *h, *prev_h = NULL;
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
 		struct folio *folio = (void *)page;
-		struct hstate *h = m->hstate;
+
+		h = m->hstate;
+		/*
+		 * It is possible to have multiple huge page sizes (hstates)
+		 * in this list.  If so, process each size separately.
+		 */
+		if (h != prev_h && prev_h != NULL)
+			prep_and_add_allocated_folios(prev_h, &folio_list);
+		prev_h = h;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
 
 		hugetlb_folio_init_vmemmap(folio, h,
 					   HUGETLB_VMEMMAP_RESERVE_PAGES);
-		prep_new_hugetlb_folio(h, folio, folio_nid(folio));
+		__prep_new_hugetlb_folio(h, folio);
 		/* If HVO fails, initialize all tail struct pages */
 		if (!HPageVmemmapOptimized(&folio->page))
 			hugetlb_folio_init_tail_vmemmap(folio,
 						HUGETLB_VMEMMAP_RESERVE_PAGES,
 						pages_per_huge_page(h));
-		free_huge_folio(folio); /* add to the hugepage allocator */
+		list_add(&folio->lru, &folio_list);
 
 		/*
 		 * We need to restore the 'stolen' pages to totalram_pages
@@ -3274,6 +3331,8 @@ static void __init gather_bootmem_prealloc(void)
 		adjust_managed_page_count(page, pages_per_huge_page(h));
 		cond_resched();
 	}
+
+	prep_and_add_allocated_folios(h, &folio_list);
 }
 
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
@@ -3307,9 +3366,22 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 	h->max_huge_pages_node[nid] = i;
 }
 
+/*
+ * NOTE: this routine is called in different contexts for gigantic and
+ * non-gigantic pages.
+ * - For gigantic pages, this is called early in the boot process and
+ *   pages are allocated from memblock allocated or something similar.
+ *   Gigantic pages are actually added to pools later with the routine
+ *   gather_bootmem_prealloc.
+ * - For non-gigantic pages, this is called later in the boot process after
+ *   all of mm is up and functional.  Pages are allocated from buddy and
+ *   then added to hugetlb pools.
+ */
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long i;
+	struct folio *folio;
+	LIST_HEAD(folio_list);
 	nodemask_t *node_alloc_noretry;
 	bool node_specific_alloc = false;
 
@@ -3351,14 +3423,25 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
+			/*
+			 * gigantic pages not added to list as they are not
+			 * added to pools now.
+			 */
 			if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
 				break;
-		} else if (!alloc_pool_huge_page(h,
-					 &node_states[N_MEMORY],
-					 node_alloc_noretry))
-			break;
+		} else {
+			folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+							node_alloc_noretry);
+			if (!folio)
+				break;
+			list_add(&folio->lru, &folio_list);
+		}
 		cond_resched();
 	}
+
+	/* list will be empty if hstate_is_gigantic */
+	prep_and_add_allocated_folios(h, &folio_list);
+
 	if (i < h->max_huge_pages) {
 		char buf[32];
 
@@ -3492,7 +3575,9 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
-	unsigned long min_count, ret;
+	unsigned long min_count;
+	unsigned long allocated;
+	struct folio *folio;
 	LIST_HEAD(page_list);
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
@@ -3569,7 +3654,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			break;
 	}
 
-	while (count > persistent_huge_pages(h)) {
+	allocated = 0;
+	while (count > (persistent_huge_pages(h) + allocated)) {
 		/*
 		 * If this allocation races such that we no longer need the
 		 * page, free_huge_folio will handle it by freeing the page
@@ -3580,15 +3666,32 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		/* yield cpu to avoid soft lockup */
 		cond_resched();
 
-		ret = alloc_pool_huge_page(h, nodes_allowed,
+		folio = alloc_pool_huge_folio(h, nodes_allowed,
 						node_alloc_noretry);
-		spin_lock_irq(&hugetlb_lock);
-		if (!ret)
+		if (!folio) {
+			prep_and_add_allocated_folios(h, &page_list);
+			spin_lock_irq(&hugetlb_lock);
 			goto out;
+		}
+
+		list_add(&folio->lru, &page_list);
+		allocated++;
 
 		/* Bail for signals. Probably ctrl-c from user */
-		if (signal_pending(current))
+		if (signal_pending(current)) {
+			prep_and_add_allocated_folios(h, &page_list);
+			spin_lock_irq(&hugetlb_lock);
 			goto out;
+		}
+
+		spin_lock_irq(&hugetlb_lock);
+	}
+
+	/* Add allocated pages to the pool */
+	if (!list_empty(&page_list)) {
+		spin_unlock_irq(&hugetlb_lock);
+		prep_and_add_allocated_folios(h, &page_list);
+		spin_lock_irq(&hugetlb_lock);
 	}
 
 	/*
@@ -3614,8 +3717,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * Collect pages to be removed on list without dropping lock
 	 */
 	while (min_count < persistent_huge_pages(h)) {
-		struct folio *folio;
-
 		folio = remove_pool_hugetlb_folio(h, nodes_allowed, 0);
 		if (!folio)
 			break;
-- 
2.41.0

