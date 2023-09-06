Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1D67942D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbjIFSLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243765AbjIFSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:11:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D79C19B6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:10:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386Hdgdt002255;
        Wed, 6 Sep 2023 18:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ARRxFo7LN47gzdmF3ZhfpjlmTbLObZmB0s49RHFTdUM=;
 b=RRq1jGS7iRsUaDb7NJxZbjohEkSDypbNvC275bJiYFKJWJGhkChW9fHEB2xNvSK/eBn1
 s2ClQckGBE3RkQxipyRxYXhfWvAX5S3Mla/ykKdtJAZVGrIDaHHllaHu0LVqfCjBA//f
 h1w2nI3YWGddr4zC0BoGyB0dAcrjvH7Cm3vgQ6PxnYKCfMaGiuMtK+l8WGk6TLzxEJqg
 9ROdrJOtMQFAg1eKjFrTTisoM0ed8oMIsLbblbpIbKWHfMpdXAi4kk/Mmf9esv9nPt6B
 3WZveWxlRjRRiTX8YJIT2zinh979+zDzpZdx6T2RGbi1IIAZBtyyF0ZQ11i4hUlxCRBm 9w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxx1082wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 18:10:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386HKV1n037160;
        Wed, 6 Sep 2023 18:10:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugcvv95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 18:10:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqmHtOne5AOWpoPlMzMxHejU5pIOEz9PJqgCXwPspyy54VJUS8KIZNY0CcwG5h/sp+rxHq84rbpsrSpGi6D3rC9A1bsSu5kfVPRl0RYfErsSpG9IsDsZN1itVWiK9IGpvT95M6ylL6hGWcKeVutJFz8/ZISmQYCcRCtPMmekbZvYyCAU/MvivRUiF4QhMDC9ZG5wPKVJ++9XOQetvgP2ytnKdtrnFDH2u3t5x7cmBFPsiTs+dRlKlUvGlV0ZNrmKf5ktoMtPsN0G+WxQ4bX2pX4IDOJig4Bkk/lukr1F8p9fRq1NLj6ze7exjKaxfdGyotxa198/QhONl14MoShWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARRxFo7LN47gzdmF3ZhfpjlmTbLObZmB0s49RHFTdUM=;
 b=dWjwI1JeFgNR9ZmB2f9+6tH2swBu0hFn4REjLr+J7s/BZ1/+6uGVbh7JXNAkyY5OAFb8oax1tIelMpgIiW/wwgYlmv+icRwkvbsr4jr3KZC3jumzqw4cxVuLtZQ3sijCbAe4976sJIzP45Kt5yCV66BUyB7sSMLkxukTS9UYKHw2xosatMd7ST1kIeMrgPx1ri77BEv01+2GSlwiy6HLO4H33+vZ3wNmS8LtIcCyons23n4SMEgNOGcSa/Euunzz/kiJQHozsM0pIWQWBLTjZZGS1ZPJn7TmCUcsuT5PecQD0tpFfKsIEzHtPy1xoN5CEwD/6dUeSrL97MeC6Mgueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARRxFo7LN47gzdmF3ZhfpjlmTbLObZmB0s49RHFTdUM=;
 b=WNLfhqBm2Zq8Swh0jKBIV3ne9jG8NghL4ypXyQPI/Tb+9dm40cuoDBcEW876/RdVmUhbODFC1747+DKAqAcy9H/MccdWIUdNjpG6W6AytrZihXEdc7HToYNyLnBLcPS4N7exe5vlZLQ5mJJa5J8KFxspQGu5MHYjgPbc3JPBlyg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB7451.namprd10.prod.outlook.com (2603:10b6:8:18e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 18:10:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 18:10:19 +0000
Date:   Wed, 6 Sep 2023 11:10:16 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, rppt@kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Subject: Re: [v4 4/4] mm: hugetlb: Skip initialization of gigantic tail
 struct pages if freed by HVO
Message-ID: <20230906181016.GA3612@monkey>
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
 <20230906112605.2286994-5-usama.arif@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906112605.2286994-5-usama.arif@bytedance.com>
X-ClientProxiedBy: MW4PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:303:b4::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 6312578c-b1bd-4975-45c7-08dbaf04878f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmbqgXdiJkJTiYYqPCRH4cbAoTj1yLz9GEBIe1yzB/iWg0N0Ypz8rYYQApJk64LNw9Bf/iXjvmOAeU2GMW4ZylaoqpHeIsaKEPy3Gr/V4aXpcSrEPOfcmMcy34rjIeSNUA/InCKE5UZYtf+rF5ONkhbjS6MBDiQsTE7Ew2+ShqJYrZ0XZ0KTKzDCBXMw94Rpy7+fMS/Za5J7/QMb/eAsuYUHvFFxEwOYLpKz+VEOJ65vBsixxdYjBqVlqb0tJ5CHzxPo3GRCSk5tD4RM8BZQDaraHEjmj3EwKTUVTqLx3VocQ4uWWNyM1oDDZaGJB28FGQxwDVQ21vF+Cao3OhwlwqkoIucWZAqTFr0IjQ5kW8c0HK3NJkaN6SZZrT01BdGKkNP/CR/nfpsUHgkJeSw7SU+NX87Rj2r8JHavXcZSbpy9VO2kl7qkgKK+Xi8WTqGJFLvXu51TkpOkuM3FlhqeoMi29b/xLlu4l9Y8TO9YB9P/KHixHAO74e0LQ+l2wiQAGNpoe05A7x04NbRndxANF1yHgFmLnsGRMguwurRR9U7F9EzykJV4xKnEQnBrkpbA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199024)(1800799009)(186009)(66476007)(66556008)(66946007)(6916009)(316002)(478600001)(38100700002)(2906002)(44832011)(8936002)(5660300002)(6666004)(4326008)(83380400001)(6506007)(8676002)(6486002)(41300700001)(9686003)(6512007)(53546011)(26005)(86362001)(1076003)(33716001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I8q2Q+PzIpb8DJfS8ghg7lKfpvDhopOeSrXpwrodQN71SqU5kXpXb1L8WK6b?=
 =?us-ascii?Q?rkU/eqddu1VTN8QfcVfc3s9vU4m5FvfCTHwtJoxR0VbP/M310cydTcQY8dbY?=
 =?us-ascii?Q?GFAf0bL7I3jhOTVsLTc49+N/Ek25q+peMl0V9ujQ3cAoB43xlXKAebyCf2zK?=
 =?us-ascii?Q?U2/2iOQKRNSRsoC4aPSHtaNOs661mbrWJGz9bf3jWi0jkRpeb/Mpv64wSSzD?=
 =?us-ascii?Q?LZgPcvzR37Fftmo4wALVwQB1enEHKOAnWHF4rtz33SiNfBuCsaQSAPc5G/J6?=
 =?us-ascii?Q?D9e4vT2j9OA5OSEBFPqg3idUmIHxfBwyJTDKxeQP4nBsP6bJfy+TP0IMw9vI?=
 =?us-ascii?Q?Zss4L6D1NbFbspddYEVbrSlvyC8LEDKsk7MKJPW5DdpL/PxrBRF+Tp3QcHAw?=
 =?us-ascii?Q?s2GAdx0kJiP1a7e3jeynIzhLQm0HRixe9Z+wpsMiBRHODuy7UjkXHCjL/Bst?=
 =?us-ascii?Q?dvOabvHqG3ZVjoif+wy3I+Kb3aJwQ7RQpi80wmG7kVG6MflAiZz5jiX12G5+?=
 =?us-ascii?Q?afVNoKc80r2CG7CPSuQbksIlYOEXy5aN046yQJ1VHJiESqhzBrI7brUY5efG?=
 =?us-ascii?Q?x5WA3evYvU5586WaBUDdIqCHDL0cWQUy9OCMJzihru6IqqRQN9oyNVVthjq0?=
 =?us-ascii?Q?1liffrggNE3TSeRpr4dhe1KOkii3MrM2W65EQlFRQx0VzbbPsZq+leyUpB2k?=
 =?us-ascii?Q?+fZirg3wt4S81/5q+BpNRpk+Ntx61f/06kK6EUyvg4jImN0qhHVf2UHmeebp?=
 =?us-ascii?Q?P8ocuulPsQ++Q5CTebzEQJOUe9wkVn/OJKj2OS+YYPqadnHkgtYWUklcElhT?=
 =?us-ascii?Q?p1YdKmyPP7N4n9DthE/q8h7Pi9MUkFYkvN6v67+f+pbQ6u66c9alArCLw73+?=
 =?us-ascii?Q?NvnAkaefVvt59qgdaG9JFA0JuOqBi3/uL9+W3UJbc3LUBWNz2FChRo+971mL?=
 =?us-ascii?Q?eFnkBXzdg2ZCwG4+eHB+VYdB2T0QLw0kD4sz4EZc77asX4wXF9UHW2OSlHMP?=
 =?us-ascii?Q?3zXgQ7+zSSTcMjcVeliJTTsntIw3psKhKalpz3BjsqGIjBWH2DFKmKuXwlTE?=
 =?us-ascii?Q?w4u5o3WneVY+NODavIWOQc46w9YekH8AZsAHO9yvCdqZ5sw+Sf2gtViORii4?=
 =?us-ascii?Q?OLYJk4rkOmrMEHqfzRYi13fd4JmULHneSzuKsmEgSy6FEoSr9g6yfltt3Eyp?=
 =?us-ascii?Q?m1kLp8SUtNWXje/fu3HWv5aCHsnqfI/9Kx6j+uAwkddl6jF0hNSj28de1YPG?=
 =?us-ascii?Q?ipZiqaGOwhA1Nv9U8+oqKi4GG/xIZpu6bCBrCpwgFYM4qd//pdExvyUT40SH?=
 =?us-ascii?Q?OS4RxcWk6UFmwQZRUu/FpH8jLgJP0hB5PrikXtU+ttk3O3XTlrJQ+DDnasgC?=
 =?us-ascii?Q?O6nHMIEpgG5zOKfTyFo8OirEEWrPeLrzLDMUHulnBt3KwsQaf2/767UBduhV?=
 =?us-ascii?Q?XtStOwD95/87vvV65TsQKvewufjERqmCc6uCbyPW0/bnnxRoislR1Pm3+nzt?=
 =?us-ascii?Q?ysEIeY09A1vIyj9Kj7rA/7IxhDVND0P5BjA7vHg5j5YZu28yWi+G3Xon9i+8?=
 =?us-ascii?Q?nxZEQ4uuuucTl9+NWM1zvKhX9oXJOblTri33UJWvOAYurP4sCrlMZHm2HpHV?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ntMA/sbP6+Eb+EkVpGnE2LcA0UroGjPgfWCM8/2yT5g8xXW6YGbOCudYWbNtAuutjmlCMpxHdqyxQXxJVkut330s6TpnvXp7vD5STp7elgyC3ahiZjMaZyTtlSIWyrO4VltCZxSvdFcLN0Qhu01h2Oa+NaX9jCejilDKV8sXvN+GmSw6FALeIUsO93TnsRjxG5my0yt9DtBdTgzRSbmGiSM4h5IZpuuVYPNsNXF+n6Wb522d0/AMP1/hMr0TTX3OytPAicPtxtQdzRbGHfRqD+CtNWeX3GhbpUsxqHSU0AEhjFj4A8Y1X466kuwz3kE5LkonodWef7WKTxe5NgxCDD/G5e1rDPnNEZLsURgmxiSRQfo1AeS2R6VmtS2pHmudTRaZsp4ukFbAz6fC3Q01Df3+2Xy45PZhza62wSEldoSNoRhAGuuC/VQwU+xaa3b7WZYPnENxeDo2/lgQQi0bCRxPEIsXMN5kZLEM9RdoQpuCer3hM6uhQXAFvioHBMJm0wztiTwxqTLLykG2j4M6nH1fDMIZeR8jvEPvsym1LXisG/yhlNZvh8auroRlqOcoZ/yIgXX6pRyHJDPmyp9/CKB2sJ8sG/YhckxSN6YRpr75Fqfte3W1rbQ1Ai2Qb2vDKrcFB1wyCl8mGk2ezjly8cC/LTxsSO6tJz4Smeb5dy0/q3uEsOSymWbF8Kr4L++RALoPc9MfGuOCw1IB5xWxh/JGdR9W4a+nA/rAWd1z8/mQz98jONdFMtvfQGjs0f1i1siZSdFdSHEdJajwggFt/raMxrjuvuyLNyD7RxZ748oHD+SVZjapNNrzXa6Z8ilDG+keHz6TECyMtCjPp5LHW6UCNCR5UEjK/YiBvOp365vmVEmnoxM7CIYYZHVS0hSDSiAjEPNz2h0sKM4FGOEjdBf8P/1YSieLeXCu4uLgT7o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6312578c-b1bd-4975-45c7-08dbaf04878f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 18:10:19.5951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBwBGo16NCB6epQNi0X0eUstijvyc+yoL4IxMM7/cym6Mw5iakoN6KKm8OE+WUs1fb741+XXQ3Nq8asYFSWv4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7451
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060156
X-Proofpoint-GUID: j8KUtB52BMBDxZGZJ9QjtYxet2Dq99xl
X-Proofpoint-ORIG-GUID: j8KUtB52BMBDxZGZJ9QjtYxet2Dq99xl
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/23 12:26, Usama Arif wrote:
> The new boot flow when it comes to initialization of gigantic pages
> is as follows:
> - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
> the region after the first struct page is marked as noinit.
> - This results in only the first struct page to be
> initialized in reserve_bootmem_region. As the tail struct pages are
> not initialized at this point, there can be a significant saving
> in boot time if HVO succeeds later on.
> - Later on in the boot, the head page is prepped and the first
> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
> are initialized.
> - HVO is attempted. If it is not successful, then the rest of the
> tail struct pages are initialized. If it is successful, no more
> tail struct pages need to be initialized saving significant boot time.

Code looks reasonable.  Quick question.

On systems where HVO is disabled, we will still go through this new boot
flow and init hugetlb tail pages later in boot (gather_bootmem_prealloc).
Correct?
If yes, will there be a noticeable change in performance from the current
flow with HVO disabled?  My concern would be allocating a large number of
gigantic pages at boot (TB or more).

-- 
Mike Kravetz
