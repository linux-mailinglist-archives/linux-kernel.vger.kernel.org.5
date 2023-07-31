Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD4B76A4FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjGaXr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGaXrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:47:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C73AE5D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:47:16 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKfvCF001804;
        Mon, 31 Jul 2023 23:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=2QbNJqa+BbPALSmLZK4Yt0JlZDh2m1AdHzY2v1xp/N0=;
 b=J1fwbOvq2Cudblg9kzMZXGIUcy0KfP8f5aRyoGaqZUATJTNyGnsWbkMN/PNUFKUajBX2
 B88k+Ws5jg9c+OxLlv+sr/KovY5LdOcBzGICcpmZT4UEUNWepYj8ox9pueWWAirABq/F
 Xh9I4Hv9XioA7yJqxSHW5okjwjD3G/TJ8KvG9EBKgtgldxQiNQjL17MeUOT4xm5/6YAT
 RyN0M8qje2L3GidlUAsLAAPhxsP2CLF+ZL7eA0hvWrhRF7Tdd2pm5GSYDYFNUTLuP9Vp
 gPU+UnPIlMWkXBALSVUUsnVcTz5BvV60APTadeWTudeOQEgLa/1y2Q7HqkrlBWyQ6KYm ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc3s55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 23:18:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VLg7qX008596;
        Mon, 31 Jul 2023 23:18:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7bvary-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 23:18:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT3bABowBu0crnGU9km26LGvZ0vaxfjxFuI7RLl81BP+cyzCSpcNZWx82aZXXZ/d1NBkGEYCjbKKDPHvR6HYW+bGttPuaNy+tKshQ50Gn8cLY7G3+nyZ9cN2qX3QOrk+E+QtzT4FJHjjmzbpV71aWgqycxLAHYyBFcGfNEneKZL6zXfny58DXbFbA7R4oUb8hGqdnQhcucEjuelkvZbgNyWRRTsm2kQ5828By0yi2Dmdyjz5rjFs+wqOKYZ3zgFME/RBqLfcwOBMKebevfBbJL9BBzXTjpjtYitu440oottNAVp5842xCTh/GxPuzByeejpxZzFXsb6iGObPBiDCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QbNJqa+BbPALSmLZK4Yt0JlZDh2m1AdHzY2v1xp/N0=;
 b=BAW2J3FexlRtdbtkskUnR/6ozox7g0PfB8MenUq4CA5hgIDh5H66UOhgBhA5Etlmwgnjm9ghz+qcwklHBzvvktIhfYKqbJkoAwQp+0714P2Huz9F3gtw8JdxFMZb1gjv6R+4PAcMAS/Zud5bs5Y4RgCZOZPfA93KqK/Q+b9f/0V1fQffd+RTIgpy2PsccuHPZV0dq1/I6Y4oBv/s8EUq2erxBxTEDIUoaisvvgPq2cAfi5fMtmfOTeJ4GJXZJZqJ2K0SpSNnzIkmQrRlUZy6chyq/QHctnKytW0QdmGcY6v9lhMk+x9IE6EV4SOGBH6EB9yNg4IqeKFYB31X9T+9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QbNJqa+BbPALSmLZK4Yt0JlZDh2m1AdHzY2v1xp/N0=;
 b=HPvcjzkK+MXyXQNkyAV9LXtr0eZc9kwTqxO+5rwJGUz9KYUFzFS0Ox4rpqJlBnwOQUL42JBKLnjV9sDsUrujHTjDcOKvSOcAOzS6qkiOIN7NCa1VGpZ/d3jner9vMy1J4wDgwOEU9dTE/yc6ynItTvma4sqMbA4P+gX2ppe80kc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5583.namprd10.prod.outlook.com (2603:10b6:a03:3df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 23:18:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 23:18:44 +0000
Date:   Mon, 31 Jul 2023 16:18:41 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, rppt@kernel.org,
        linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [v2 1/6] mm: hugetlb: Skip prep of tail pages when HVO is enabled
Message-ID: <20230731231841.GA39768@monkey>
References: <20230730151606.2871391-1-usama.arif@bytedance.com>
 <20230730151606.2871391-2-usama.arif@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730151606.2871391-2-usama.arif@bytedance.com>
X-ClientProxiedBy: MW4PR04CA0237.namprd04.prod.outlook.com
 (2603:10b6:303:87::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5583:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6926ac-3a9f-4d51-2731-08db921c7bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZ6SPho9JWo9KgdmlasJVF4Yzgnh9ykpxSggiA7c9W82rLZLhCGGGhN/Xczsm+qyb0fPYxe+hSA1/IOObAkG8GWfBcmBYgka7pZfhVtucAOapjXfjOjcVTkwIILUDiRZVDc/omP5MX1tNAvATxYolYSLV/hLyvMnQ6pJmBzgCdSSxd7FQls4SjEdug07vJYxmHdGPJVMz0gBWagqIgamew3O77eV8oHLN29Dr7AIRjhBOutT+gPE35xmsZIRwTxikZGH6/sVASGDPyh8JhifVZ3bvuT4/+Yg3AK8YCN8yc4BMr2XSY9+YA6MxWzPxdZafx+VkMrLgLLSBO50UbAi8ruU7vcw/IbmBYWfeqKP6MM6Z1BjrQNeigca2CnYeuLNYhnb3ie9Rx8dbiqppvzZuFG1Ew0cjNZ3gi24kVSJ1EniBCEbZzdJIT3DnFlhGDIT6Bf2TSwI9agJyGGSLKrSLN/m/l4jaWOdJv5PsGVSRwid7wPtkNmW0sVahQK3iKp8apMeIYUEuS18GL9gQiSNRGLJtdl/a7dsssgMK1AY4jG2QYZjLn8xDAyBq46ZUkgc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(5660300002)(66556008)(66946007)(2906002)(6916009)(66476007)(4326008)(7416002)(41300700001)(316002)(44832011)(6666004)(6486002)(6506007)(8936002)(8676002)(1076003)(26005)(186003)(53546011)(83380400001)(478600001)(33716001)(38100700002)(33656002)(9686003)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LCB5PPZuKra+JzidLtvhUYagIHgbbmpd/XOrij5Aos0Dto22R6IXTxXK7aez?=
 =?us-ascii?Q?iIwUs+tXtO2ZMroDGFOcD8A7SQ8+ockz4oiDUtaAHnYmdOKMeYT5X/SVboKS?=
 =?us-ascii?Q?QLI/iMlQNIkfZF3ddDC/t3ByCv/Pzk1M4+/rxdfyH2XQ2GXR7U18pWkMea56?=
 =?us-ascii?Q?UE84nN65ltzWea6EfKi/5m1G/RoY57HtHJccoDM8iauut2loL5ptAueF/Jze?=
 =?us-ascii?Q?thW3zshm7YcBkBpMstYznSNHGUyogcDxyo+5k24GCVT2sNGdDk1VYVgNaGza?=
 =?us-ascii?Q?l72B9HIYkxz66zOv5/G9lX/y3YPtbTT2eYVVUInj/5rOcGJpabPiMhm7zjWA?=
 =?us-ascii?Q?CaC4eK9b0AcM/eb1oVVZ9+cjEej5Trs7XpQVH87lThMuozaaVErZBu4lt6ty?=
 =?us-ascii?Q?TWiJi3YvBcvAApeKz2stRtdYFSZtVFP5bl2FKx7MlXHwRA3U9cgSxTg87x6g?=
 =?us-ascii?Q?CU/BQmuhQsWDwQuIKvkccA4uvLvWkrBY0V08sngHgG25iONG423TW3VKrC4K?=
 =?us-ascii?Q?EiZxpjb+BkN9Eh1s5wR4AxcMWExMgydDg7uvf7DAf4XwiveOYr671dyDkcYq?=
 =?us-ascii?Q?RMMg523zlLbAOGIciITygeTKgE63umgItOJRjZDmxdQGttyxfpdqGHNpTgrz?=
 =?us-ascii?Q?/ubCPMd6g/Dz1rCCByM3BAIIu1a+pHm/GOxbSukxnAO7i8iMVPXDAOYQCLjt?=
 =?us-ascii?Q?zfs1Lj94HqFLcuu0NzZ/0b+EbwX0e4WTR1JgZGnArng2DJTXYc3tB0Uu+wXT?=
 =?us-ascii?Q?eASq6dXnE/0I2Nmk0/dMobRUGfCoiJ347HU1y6qtTfJvTB+w+nOtEAp2QjSB?=
 =?us-ascii?Q?gapbw9GQBZwAxeaMrjDvArq1eaVx1bChn1YIrCd3lu4U2saOpUdDmjo5KD0+?=
 =?us-ascii?Q?3nktzfyyqXKq8GXd/Jbhyk0hJ0g1pP4AMO6fIYLB5eMXvOV0vQsnvqf4hidL?=
 =?us-ascii?Q?z8GD6zwuxH3KKRCtxoex9Hnxs2GYkMOcEjRw+cbefiNZpwIlujX4a7WnLWpD?=
 =?us-ascii?Q?r4ATumz1U0lqoMsnFU5zgenEutmk1zcXnE0UJMUUHiEViVuodbE4Dsbf6ojV?=
 =?us-ascii?Q?/ICLU9tl40VcnpdVCMDHixjJhEFKISKI0KfafVJKFHBnY42zWz0NPUrBtEDh?=
 =?us-ascii?Q?WRyIeW146Fi+F0m0Uho+Clw7hRmUH6EoNjUwNm9p5RMZqC6c+pqxkbVZw/3q?=
 =?us-ascii?Q?oEla+FVnf5Rk0EC2EVjM58i+BBdqsn5xRgj9Fy5Okmze9upbLtAtPbcH1mIU?=
 =?us-ascii?Q?iqxGQZndKwBYdYgnlMI7QNPIlf13UFmcjXd43ivdkLoEH+9r6aZ+B2rzxpgX?=
 =?us-ascii?Q?QiBEN6yXtVpO+O20Fyj3G02sdDj6MqsDa4bFKzxQPYUQCbgmKURRV0laM4kw?=
 =?us-ascii?Q?rOSoNuvyFkWdBn6sEXYJPOoDtkkWUIHMMQD/4wgHoxRnI1R5JCHwfX6GrhS7?=
 =?us-ascii?Q?E9XZDwYSZATedB0q3/CEczQ3ylsHO95a8Y9P+gsQdSdQy75/wrDfeMfUeJ3x?=
 =?us-ascii?Q?SGu31Ixbit/TxgRT0Wn91j683nwcJj2Q156jfX09eVQGgjc3PKFlzOZNaktE?=
 =?us-ascii?Q?li8hoYlMebrcx1adWDr1A1I1N9hHjmqOn34YIx07dZLCl6kiJUsLV8I0JsSW?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6c2zMpRzXP4Vj2YDhSqAqwvsJrnM8dKZsZnR3SuAlnzTl2n4N4BATbC85iOnDKknz0su7MxjS9YQychm37qY94533S/iQRFqYcAZbdfszHaAeFY6MhJhxOCVGqQ8dpqUTPE4UMP7VF3mdy1si0Rr4u79LFd3dm2vg+MkvT1NoAM8KjbU+U8Xzx9D/tvAeUtZCe5/Y0zu2AnCxH1wM/Py4+WSxngMtFf5gL3MuYCioppOKrQ2laGD9YLk7yyugsW1JUBet8s8gZqxRj718D6JXpakfpG8K1ag2agDLcekydTWuYK4rCarmSEdsdGk2P+h8jrdOeFl+rFHvgb40J85mumwtSwgHiB2kcUw+VyqwBsvYMiOSfY8KUp+2MJp5kPtlalUBvPyFGoLm6OCiRnymhE65/WPA+Tx2cLMFoRAJUQglc1r9bPARocR5szuSERHbUScAmVSq7Uoen0+E1orBWA6erGotl1km26CjQjq7dgILlD8kO0LHFY5kSzyE4+Cd/eBOBkQtjqCrcu12KpVfNiCqtXfJAcG9YXkihOtD3oZfaJbwkYvB1+CyHFQ8c7Xy7YoRb7BlGAJAz0bB+bjTarTJG8/8aoh9Vkt0M5vzZOdgpa99FOQc7/9V4ocB/o3dgZ4O4nbjQ9H3hA/m73ldfTH2Hi7cuR0iAhRX9FXda8xZHQcOQNZ/T3axsTYbznnaAqsEjXphBbJP/uYS7ay9gVFEGIlgRinmggUlZUIlA5yr6OS7wpi3SgPIzqhmU1tUQRlpH3PLKtJa9oqyCQvEJiSOfC8lbl7dzLX9YaMXDb7NqU6TmUPwg6VXgASJWP8iAmtEXAlFPywUrljgK7XCr0zxXxArhq3k96wQvT6sIrS1qEvMEaE0j8Rj0hI6saAkUXM6xsFbmdaVAjc0JlwynJQdZZfKu70i6FwKHw1Zzo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6926ac-3a9f-4d51-2731-08db921c7bec
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 23:18:44.0808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTgqyNzbi41vUSh5X2A7bsWRzZRRP50Z2OCtiJEgWQsy8mZIpyuY1mGvdlV374HvmrXXWSL2MK8k5BJlfR6sVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310212
X-Proofpoint-ORIG-GUID: gxJNKZaY51X5ari5Ggn_-fRRAnU8drYV
X-Proofpoint-GUID: gxJNKZaY51X5ari5Ggn_-fRRAnU8drYV
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/23 16:16, Usama Arif wrote:
> When vmemmap is optimizable, it will free all the duplicated tail
> pages in hugetlb_vmemmap_optimize while preparing the new hugepage.
> Hence, there is no need to prepare them.
> 
> For 1G x86 hugepages, it avoids preparing
> 262144 - 64 = 262080 struct pages per hugepage.
> 
> The indirection of using __prep_compound_gigantic_folio is also removed,
> as it just creates extra functions to indicate demote which can be done
> with the argument.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>  mm/hugetlb.c         | 32 ++++++++++++++------------------
>  mm/hugetlb_vmemmap.c |  2 +-
>  mm/hugetlb_vmemmap.h | 15 +++++++++++----
>  3 files changed, 26 insertions(+), 23 deletions(-)

Thanks,

I just started looking at this series.  Adding Muchun on Cc:

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 64a3239b6407..541c07b6d60f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1942,14 +1942,23 @@ static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int ni
>  	spin_unlock_irq(&hugetlb_lock);
>  }
>  
> -static bool __prep_compound_gigantic_folio(struct folio *folio,
> -					unsigned int order, bool demote)
> +static bool prep_compound_gigantic_folio(struct folio *folio, struct hstate *h, bool demote)
>  {
>  	int i, j;
> +	int order = huge_page_order(h);
>  	int nr_pages = 1 << order;
>  	struct page *p;
>  
>  	__folio_clear_reserved(folio);
> +
> +	/*
> +	 * No need to prep pages that will be freed later by hugetlb_vmemmap_optimize.
> +	 * Hence, reduce nr_pages to the pages that will be kept.
> +	 */
> +	if (IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP) &&
> +			vmemmap_should_optimize(h, &folio->page))

IIUC, vmemmap_optimize_enabled (checked in vmemmap_should_optimize) can be
modified at runtime via sysctl.  If so, what prevents it from being changed
after this check and the later call to hugetlb_vmemmap_optimize()?
-- 
Mike Kravetz

> +		nr_pages = HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page);
> +
>  	for (i = 0; i < nr_pages; i++) {
>  		p = folio_page(folio, i);
>  
> @@ -2019,18 +2028,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>  	return false;
>  }
>  
> -static bool prep_compound_gigantic_folio(struct folio *folio,
> -							unsigned int order)
> -{
> -	return __prep_compound_gigantic_folio(folio, order, false);
> -}
> -
> -static bool prep_compound_gigantic_folio_for_demote(struct folio *folio,
> -							unsigned int order)
> -{
> -	return __prep_compound_gigantic_folio(folio, order, true);
> -}
> -
>  /*
>   * PageHuge() only returns true for hugetlbfs pages, but not for normal or
>   * transparent huge pages.  See the PageTransHuge() documentation for more
> @@ -2185,7 +2182,7 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
>  	if (!folio)
>  		return NULL;
>  	if (hstate_is_gigantic(h)) {
> -		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
> +		if (!prep_compound_gigantic_folio(folio, h, false)) {
>  			/*
>  			 * Rare failure to convert pages to compound page.
>  			 * Free pages and try again - ONCE!
> @@ -3201,7 +3198,7 @@ static void __init gather_bootmem_prealloc(void)
>  
>  		VM_BUG_ON(!hstate_is_gigantic(h));
>  		WARN_ON(folio_ref_count(folio) != 1);
> -		if (prep_compound_gigantic_folio(folio, huge_page_order(h))) {
> +		if (prep_compound_gigantic_folio(folio, h, false)) {
>  			WARN_ON(folio_test_reserved(folio));
>  			prep_new_hugetlb_folio(h, folio, folio_nid(folio));
>  			free_huge_page(page); /* add to the hugepage allocator */
> @@ -3624,8 +3621,7 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
>  		subpage = folio_page(folio, i);
>  		inner_folio = page_folio(subpage);
>  		if (hstate_is_gigantic(target_hstate))
> -			prep_compound_gigantic_folio_for_demote(inner_folio,
> -							target_hstate->order);
> +			prep_compound_gigantic_folio(inner_folio, target_hstate, true);
>  		else
>  			prep_compound_page(subpage, target_hstate->order);
>  		folio_change_private(inner_folio, NULL);
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index c2007ef5e9b0..b721e87de2b3 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -486,7 +486,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>  }
>  
>  /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
> -static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
> +bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
>  {
>  	if (!READ_ONCE(vmemmap_optimize_enabled))
>  		return false;
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 25bd0e002431..3e7978a9af73 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -10,16 +10,17 @@
>  #define _LINUX_HUGETLB_VMEMMAP_H
>  #include <linux/hugetlb.h>
>  
> -#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> -int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
> -void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
> -
>  /*
>   * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
>   * Documentation/vm/vmemmap_dedup.rst.
>   */
>  #define HUGETLB_VMEMMAP_RESERVE_SIZE	PAGE_SIZE
>  
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
> +void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
> +bool vmemmap_should_optimize(const struct hstate *h, const struct page *head);
> +
>  static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
>  {
>  	return pages_per_huge_page(h) * sizeof(struct page);
> @@ -51,6 +52,12 @@ static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate
>  {
>  	return 0;
>  }
> +
> +static inline bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
>  
>  static inline bool hugetlb_vmemmap_optimizable(const struct hstate *h)
> -- 
> 2.25.1
> 
