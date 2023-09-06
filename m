Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2F779453C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbjIFVkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjIFVkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:40:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C20619BC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:40:08 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386LJdMu004286;
        Wed, 6 Sep 2023 21:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=wVpX7DUjAevG3He2LWNw+994DKKKSOT2udlLa11yhzY=;
 b=jVCM/Wo5suYqZXmtHE6aNUiSAs1ch/ElErSoDhrSdvdb8q1ILYoIuxJJzCZo03MHRSft
 l/PQUu3U6GG9rjFH7qvnDSKE4ZTJi3w+RMuWk0p1kJ3lgAscrefQaSBQIMBfl9daBx+d
 X+gEIU3iDmTY8YtzPeq2v0ZpuxMirH+BgWD6qJSPnUAWsm+qYsw2lWX8w3bLFgUSns15
 j0D9Dyoc6mIQdvZn1VzCUD5NIqqFXiL5EqowbwsThNJkc9WniJxBZJ5dX/6iEiDlKrQg
 a39q0zYxug4va43EYtiZLiAnXggvY+UaQGs/63bToEmLCEJqH2X8emTV1w7k+3+dyRfL Vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sy184g11s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 21:39:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386L38XR006596;
        Wed, 6 Sep 2023 21:39:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug7b8qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 21:39:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5FgrIjXKOucHHn6pJO2q+vjo4skJiYbv6Tg+hf2cj9NVXWTBaJNdBS11agw0pQKb9LzJPXNBbv4mLsA6u0RHMDiQOX4w03pMr+fCuU87GEHm+LWf/Bnowl2Neo1pDMygbmZFBJvtVsGLefX0cb/M9tM8x6ibLx1yfNxuqBLU+taXLaurKBFFKvoW3SNH+LKPd72Ab+8EAHl93R+wknENjRSNk7QyNBBYTJaypreBl7NYHtr1onTcaihO5EXfVM8czlnJl/SJSlmUvrw27aGxl4hS/9PiGdGXtHMUs5ElW+mtRU/GnXiTCkrPsMRr1Sq6eKLNLMs8tH+Vj9RqLr3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVpX7DUjAevG3He2LWNw+994DKKKSOT2udlLa11yhzY=;
 b=Sl3kHA/5+vCY5tvG8vA0/P3I5USmsXxydr61EnWiZ3biPhT49Hez3UC0DEJJPr/9tyff8kEufXFc6QyygdUqZd2x0zveQXJTgW24WwDKpATvMMNNbMMDpkhX3NlWZ8SxrCgv6zAwqaIsjhkI9go/2YML4gRVK1FLRbK8mfgEf3vwi50vetvP+7X3+7S4/DUwT9cnlkiH9moXokDrA/MoJmREPBymQ7Ik0Z22gO1QQR1Ev9Sxu3jMgHM5L6KXlzifDavYEmybpgztzGfG1QC7HlPTAzOkXaSE3wKLD78xzbCWmrKh5jMhSusPN6yICirQtitmAnahgT45SmP+EdIsng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVpX7DUjAevG3He2LWNw+994DKKKSOT2udlLa11yhzY=;
 b=RFTBgnnHAQOEJea+hBNBnUxO3cDdyJPYgCaL5oXoG3WsZQpJ/fq7YDkLyiz1fhhnZLJ6waTnVJboXdMLiHsBzN0A5PsQvOaAamRxD4m1HC2DmhUHlnMN4berZ0v0p5Z0OUGIIsdWRiY6TESfJKcaBMURUVKF7PVAeuC7SXvAvU0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 21:38:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 21:38:59 +0000
Date:   Wed, 6 Sep 2023 14:38:55 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 08/11] hugetlb: batch freeing of vmemmap pages
Message-ID: <20230906213855.GD3612@monkey>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-9-mike.kravetz@oracle.com>
 <b9b7351b-ddee-64c7-e78a-00df85c56e94@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b7351b-ddee-64c7-e78a-00df85c56e94@linux.dev>
X-ClientProxiedBy: MW2PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:302:1::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 948627ef-4488-4bdf-91e6-08dbaf21ae00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zzfiqQ9tE3dmCc9WsHO9dGDrlIyZl08X0PDBg9Q1yhKAHLY2//asNynY+eQtG3nv977CoqaOz/QQEIoxOL7XBbjBzNyq1d9SI/8uGYa2HSmOhzVO9tcIKzOFJWBb17hw3TXwWoGl+vUz0+R37qDfliT1ZxTSTtBOLR1duz+sEEcbJgFWqFvkM+gsdJoZ8hYrvJzufa24Jb1QNHzFXz0k6z5i9SkWAuSKpD55B8sSP9At7pFKBm+cT+GDSY7Yn0Admw4ldXKqg4oSzbc6Va2li9baAqzG3XborFgFu3IfpK+YoW6lcgbj73JjbKdjqV65TmJgY9H5hSJSyL0zI3WxjaB6D5FIk5uFLQVlVXb+FmBFGpZ3z5qgT4L3UM1OmVg6oN3VkHr/OaAXzvGYMQCnF6/5l31VVB+7nl0dpuLC+JZ2iiaG+eL/l+bo+K/fARSlSB9ck8yt+5RdNlFwrIXmHSz8fd7jbkiUX1FLKnWF8xKaxOhwktS0Jka7pqUb50LSc6visIkzaIxV/FX2WZGj6qVMndGNp7HMbB8XP0s42yfmeqZvT7eamqcoMYjvlqqF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(366004)(376002)(346002)(136003)(186009)(451199024)(1800799009)(33656002)(33716001)(316002)(2906002)(41300700001)(86362001)(7416002)(38100700002)(44832011)(5660300002)(8936002)(4326008)(8676002)(83380400001)(26005)(1076003)(6512007)(9686003)(6486002)(53546011)(6506007)(6666004)(478600001)(54906003)(66946007)(66556008)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aTaJAb3V9//wBiTP5mFuzhCxekea2spena0lUlUFd+6ZTxZxtsSqBiv2R3no?=
 =?us-ascii?Q?2rQTNyrTQ+xGLk7SnnBMHNIoncz4Q3DTzZYpyHi3/thbEJJq2OKXNdZRLHZf?=
 =?us-ascii?Q?/pr5ER70As0Y03JnQRAoybFuBOe8pFjn9zLywLRceRWFYhjZEuIUToZf6V7J?=
 =?us-ascii?Q?OYb2WrT30ZioPpraGqmpJOuxKILw/Gx18C0T58fuaN49BxGvEjq8yUMJnx50?=
 =?us-ascii?Q?LgfftDjt82uFG9Xbgm39KI9Z8uf/9SfpqbwkZQzcgcKlk+ma/QSnALVlcM9T?=
 =?us-ascii?Q?xcjuLg8PN5feipPLuXnj/cyhqMT/kdIrUvnENW6kx3aGN2v04Gou/luQcy4/?=
 =?us-ascii?Q?HvkCZGZE5oy7XoWUrVfmAMFUjMYjSRJnKEEwT7wTIPQSLqQNE1eAX8UhZTSp?=
 =?us-ascii?Q?Jui3lv9WGUs7ICJuHBP0/r0n5XhKY17O3/RxhIftGc16e89gXD8sruG3ZBL9?=
 =?us-ascii?Q?TrRUhu5DSwRrVeTvRo9uRumHxX9tcxJv9HDRmgeQycuH44mxEjGHdIjM7UZr?=
 =?us-ascii?Q?RBuXSAWEjQalE7kyS0/Ai6+GgH18074/S1F9lM+BuxZ1/8i9CexGpvF7GUp9?=
 =?us-ascii?Q?S9BZkJLKACXXtnqxDIzKZ9Qq4Vaif6OA1nq7k8YL9S8cbGIXTDbWvBYGC6O+?=
 =?us-ascii?Q?FgP+yrNFj51/H02pv9tDZ80rLgvdU3/tNZvWGLA8WPi7/GDqz9OP1+evQMHo?=
 =?us-ascii?Q?pS5wntASiYggzOiwHgLRjGq3/qYbtK3QDsvKBWo2fJnpRAN3ARZr5NbnJwyD?=
 =?us-ascii?Q?/DlYb7pw6YyBNcIAtyKsfp24qY6cV4dg4Da8lS2FTW4ZH8PIKLdXyDq0w6Vp?=
 =?us-ascii?Q?wTQopebLrcgUi87+hwMyhXV8WINBt2m4egtMpRR3z2HNKt8ZF1CgHMACdISo?=
 =?us-ascii?Q?j20tbEOdk3GVrdMVjbKnVTsCRWG1kclus9EE6z7i5UsNnWOzKvKB/RBq8ezF?=
 =?us-ascii?Q?OUcntHIYli7pwJew10QSyCG59P4GowwmrNsYi+Vst8A6sJIny5W5rk1+Zf0P?=
 =?us-ascii?Q?XY7HwIVMf/HJxxiAxDvCavlG7QGe1nstt9ul6LmKjszK1Rn0YV++yrvQq80O?=
 =?us-ascii?Q?4CZUB/8gXyqwkDAO1OVC6+ghHy4ZVPmd4TO9C/IwefbGxzgLlhKglYNQjNzd?=
 =?us-ascii?Q?8pS/h4IDqQtaECuLERva8WKbq6mMro8UGI/xlZdTDs7C0jZdXYnW6r7mLBp7?=
 =?us-ascii?Q?n2C4x2+a7M5DxH6EMgzywU0jUvWAcoOKNFKS9tN3DOEdZFZNi01TqIM8yhs1?=
 =?us-ascii?Q?d7UhShT0hpaeIt2MWGGAoVLAoMvfSB5JIenJ98JGq3urH/fyXQ+j1Ya2/kFt?=
 =?us-ascii?Q?AQRfDrs6mDHI8wBVcVRH2nx6Aqw/QYuhYav2ZfdgecCHlEaoVezqX8E8/AIG?=
 =?us-ascii?Q?7w8rNkwlVAATuy0+6RNmQKV6Ov1sgWQ+gaz4p9JjOevXI13ncOkKxPX/wqQO?=
 =?us-ascii?Q?lA/zaevO+/dXWbRP1bIvDsOippJEBRSzBrpDbXpXw0u3Bp7fIx7GcKWLpg+K?=
 =?us-ascii?Q?RtTIXz+6DEi+ATvQzX2uBkZSDfcgeEPzGEl0StEsVPaKVc5evBjU6AvUqrKv?=
 =?us-ascii?Q?NLOLHa1I1d4GJB71UQx/kXjRNAR6Vg8DBrCLF5rKnxDLvKi9p+MYEL7CSpXQ?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pnnbdMD+/m49qIiZ/0r6Gp1wENm72PGw/f5ZKqcPSNkMk+3pG6NAJ9QO6DO+?=
 =?us-ascii?Q?x13zyIqCExO90BpnJznYZlHxm7k7LGsG7wr+Rl0f/BFXtX0mfyJhFo2OafI3?=
 =?us-ascii?Q?M+yugb3LK2UZNP5qp+lcffiJzcgSSJPtxve4gAAQitBF0B0vbJ1fVVE9Fprg?=
 =?us-ascii?Q?xF1WwXzCoGJVuzTkNHNKwsp7GTt45ynf5z3dRBKoAZvzhEJXnMqMQElWPYP/?=
 =?us-ascii?Q?SOc37AergymtJtuRyP+qCSJjEABqvxiY/XFGtGx4T76l0hFCmOGApenOeOcj?=
 =?us-ascii?Q?PEUXkbNburCWajHFPe9lev3I5GjLDdZcUJoOaiqobFmuJ4Qf/5zDPt7xgaLN?=
 =?us-ascii?Q?u8fc+KTxXKcTxBP+hh8noa0n4ToVU3/ek90f8IN+1Vg2l67zL9+s03DNSqym?=
 =?us-ascii?Q?g5KdLYq7kJrpts8SGFx/+XDSvwNG71RErlbfP1QsYeejrxZCWWT+YYsNpqhI?=
 =?us-ascii?Q?HB2uLTjpnbWNsm50rl4tcdN386/gYvY2nUqsTxLyGQH4H/dmZ69+P9UGIcNE?=
 =?us-ascii?Q?fp89YRFVtfa96hh5kz2A0AaZE+vSFuP+/CFJj2VDD0SPZ4mJS/QLT3f78uxb?=
 =?us-ascii?Q?2EaDrME3JfFRtO5q5HzLBGlAHgUxY+4eV38oNv2V4LhpYKl/dRamvdCTgwpd?=
 =?us-ascii?Q?3JATGChphbrtuWnSXoPCb2jj2d5UxBm93YzskVZ2+p6Xi21ouLx8kOyYR/md?=
 =?us-ascii?Q?KgflG8TUeuc2cqSwuv1bjH4RfqkMhFhFTWSnGO5O29U1JI/ayprnBpQ42FLG?=
 =?us-ascii?Q?sTLXI2TQlsnkH/LkT+kYJjwJScZ59QW0oMTSV5hPKef9F3bzavh2MN0XR1rz?=
 =?us-ascii?Q?tPv79rKqfl5NgoR0OhWTTIldv1VX/vCdbhxlwZ39FcOL8Sxzf7ikWssUFAQp?=
 =?us-ascii?Q?VNKHP1wMwgb9BZCpNJb/p8mP1jkkKKX/3X6nEcZ8hAevyrU3kEFzNxJ9TKkD?=
 =?us-ascii?Q?aYDrdIUIACXE16QtH0NdtVK4502Ei5lzs9foWUxlsOxKTry/306SVPQCvseo?=
 =?us-ascii?Q?tebMmfTH6GbW/uEAjujkYxvFIYC+xqhsHgo8yfUTbkr9222PAjvxx92tHWRx?=
 =?us-ascii?Q?4DjU9MCHG0ljKSiwPLAmMhYWFPAB6w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948627ef-4488-4bdf-91e6-08dbaf21ae00
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 21:38:59.3218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjkIO9BFPUFzbLKIqbpfzplmEpX3Q38zHgNgKHriiPAIWY9Vs40OTJ31Totjt8o8hgzBs/e1oU9RVEmfoKrqwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060188
X-Proofpoint-GUID: Z44c-lpfWe_IsdkuHBEufHTMWOpnr1AV
X-Proofpoint-ORIG-GUID: Z44c-lpfWe_IsdkuHBEufHTMWOpnr1AV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/23 15:38, Muchun Song wrote:
> 
> 
> On 2023/9/6 05:44, Mike Kravetz wrote:
> > Now that batching of hugetlb vmemmap optimization processing is possible,
> > batch the freeing of vmemmap pages.  When freeing vmemmap pages for a
> > hugetlb page, we add them to a list that is freed after the entire batch
> > has been processed.
> > 
> > This enhances the ability to return contiguous ranges of memory to the
> > low level allocators.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >   mm/hugetlb_vmemmap.c | 60 ++++++++++++++++++++++++++++----------------
> >   1 file changed, 38 insertions(+), 22 deletions(-)
> > 
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 79de984919ef..a715712df831 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -306,18 +306,21 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
> >    * @end:	end address of the vmemmap virtual address range that we want to
> >    *		remap.
> >    * @reuse:	reuse address.
> > + * @vmemmap_pages: list to deposit vmemmap pages to be freed.  It is callers
> > + *		responsibility to free pages.
> >    *
> >    * Return: %0 on success, negative error code otherwise.
> >    */
> >   static int vmemmap_remap_free(unsigned long start, unsigned long end,
> > -			      unsigned long reuse)
> > +			      unsigned long reuse,
> > +			      struct list_head *vmemmap_pages)
> >   {
> >   	int ret;
> > -	LIST_HEAD(vmemmap_pages);
> > +	LIST_HEAD(freed_pages);
> 
> IIUC, we could reuse the parameter of @vmemmap_pages directly instead of
> a temporary variable, could it be dropped?
> 

I was concerned about the error case where we call vmemmap_remap_range a
second time.  In the first call to vmemmap_remap_range with vmemmap_remap_pte,
vmemmap pages to be freed are added to the end of the list (list_add_tail).
In the call to vmemmap_remap_range after error with vmemmap_restore_pte,
pages are taken off the head of the list (list_first_entry).  So, it seems
that it would be possible to use a different set of pages in the restore
operation.  This would be an issue if pages had different characteristics such
as being on different nodes.  Is that a real concern?

I suppose we could change vmemmap_remap_pte to add pages to the head of
the list?  I do not recall the reasoning behind adding to tail.
-- 
Mike Kravetz
