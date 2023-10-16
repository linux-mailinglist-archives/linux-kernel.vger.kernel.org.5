Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B517CADFB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjJPPo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjJPPow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:44:52 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93155109
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvkAX7VTOMqQRU+CLxdnWJxFLYGoaO28czjgDqmCnfbMgBVyUvP7m9rEX+KJCNbGjOAM+pAJh7a3aILUnthYGHF5nhS4upGOfoohcZGeBfFVjMrwWzoGfbv+EqAc1pNUAZZ/J2Qh5P8sK6orVtlUU+PBefgqTYmuXYLxJa6l1HHOifP7F5pCRwJPzLjiEqp6kuYDLYLbZkJ7grGJAB9346yonIsKkHulP+QtoN/VT/zBH0/oh8sftmlb6YYpo7p8nhpb+32Kajds/YRh/CYqpaeqiJ9gET4cy/INmu0YilGPfi1MHS0w3lwJKmWxWYwXfR4A/+H0yz1Oj/UG1OK4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dtki6JW6Z7fSI3e/UjJtl/zPXnr0GC3yUkLcxKODRG4=;
 b=KZYCe9fDm4QGKKqxDIJvM54NhQfURcmtbeoJ6WmT5d8JR1DHwbsH+0b/uNaAHTAimNr1Lx/6aW30v49QRWinbY8T3BGXKxcHkRBn8jIb9xj4Iu422w/yYT3h6em2vwISJEJWPq9N9MMt4G/P0RFegE/PSGUJX4OCBokT9FKKJ1CbH5qco08nTUAZMX4UQavfVFoie7i0OxsT0/dQL26l3BMZVCFT94DomtcYGUQgLVsBf65nOMBaFKusDG51pTBlczJl4lRXM0TMUl/z0R/2+DaK1GsExwo3m8AnmiDcyzUxGFOExZJIXUPn+aDrFvVrLhAbn9zYtwRAs6YPhwO1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dtki6JW6Z7fSI3e/UjJtl/zPXnr0GC3yUkLcxKODRG4=;
 b=CHUwoF+J45reSD3jnGVzLQ35Ynz9w+w7lYp7yHjw3Uo8sxZlyDn7R35CKVGt8RyMJkHvp71M5E9UaaGD+rEHvQ1mjdXV8pN/PBBb5ZsN0atOmcpyjIa1ZRpJcUlrfU62YJ6uN3wIZTQAT7Zcehb+Z/Ck1HoniSRC+KWBxSR9D++2K1IF3nmJ6GmCdMPJjg6OW4FM08SmOq85XMFMvo3V3+Nsb70efQolBRvFxWnncCH5THUIbrej0vHaV+mb/l8eTUHNbM6YcckTwcRabjFc/TvI79okX0eE28cQ6mN1HsfdEvtTmXQQb+BHPOSQvyYtC5eTNinxPlItCeKrLvCGBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.35; Mon, 16 Oct 2023 15:44:46 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:44:46 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: correct nr_failed in migrate_pages_sync()
Date:   Mon, 16 Oct 2023 11:44:43 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <1B46DDFA-4AAB-4C49-8AF0-65DDDE0EE854@nvidia.com>
In-Reply-To: <20231016154156.1948815-1-zi.yan@sent.com>
References: <20231016154156.1948815-1-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_12D76446-B7F7-4CB6-80A2-1AC99446F504_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:208:120::23) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 92eda7d0-c6ea-4f3c-47dc-08dbce5ed2a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkdWDX5ihY8Vs4fkL3hu5wHeRuBgT7u0S2MpdYT4A7elRXV2ywzdbLB/bT1RNSMAKeAlQNFioVRJQNdPUApwRApwVEmShGg1pUFx3FDwnrvh1Rex7NBM87m48hdtaBY+aixEzkJe5ZZfYrqKHiM4agaqxe59OjqNmRKQlHs4LZ202BJl3nJ9VPdwLTSHdPUfpObnv4GwbzVjUzLd6gvk+D1KPZ2qK9RAcYsi4i7agRFPH9JoQa7EeZyrpqnHA+5q45Tw7fxm9NQGkVC16GZQFBL6dLctR7+RdIww4VUIyDf6ga0752y2Yw4YTAW1JQZ708UOKKWVTZ48tHBwaLDNl1HS3x15HxTXNYlyGpyafIGFSn3IHGmu95egCSYtEeUU8uQe0eQZ8schtAq4e8+yrZ36oYtmSQ9nUwJ9CTBoEKrCQrNAzm6ncrs5px861clkTVrg+ucgiJvM7ex7XKyt1mSS+8UOlgNGRaTaocPWfvxjRaDXljh45IothIhPkcjZB6goBQeKD5aEyHg5Q85wgwcQnExL1IvBOUbd8b5Y4Gj/ccL2jXxb1JhyJBdg+G4HJveUTyZfC7JNDwbG5wt34UVdhCWdhUjL4zSOeEFpdXWIClvY8I7S3gcmdHMoovvqIDdTseWb3GWgNmJVfvZiOzSvOR+gHkoK3mcOZNjFwSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(396003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6916009)(316002)(66946007)(66476007)(54906003)(66556008)(26005)(36756003)(53546011)(83380400001)(6512007)(2616005)(38100700002)(86362001)(33656002)(966005)(478600001)(6486002)(6506007)(6666004)(41300700001)(5660300002)(235185007)(2906002)(8676002)(4326008)(8936002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QKxtkL65gTZrlVG/fP17jjNTd2vOwdzIlgMcjAHs9lp7bCxCs/bBOVAeurHv?=
 =?us-ascii?Q?vpA9GtlN8a4LL6YcaytLBJnqNTG8WHu9D3amH2nLyOHQzTQ2zVn3fAM9JgkZ?=
 =?us-ascii?Q?7V36E9FLcURrxFf3Q9VtE2R8CqOJ3dy5iGofG/i4q8I03F1wjUyaJSxJgErW?=
 =?us-ascii?Q?go4GIPkwvRAIn2cdrjaUZxDaQrrnOSD6euL1yKfYLRCbzVoD5Z16pK2oXB0w?=
 =?us-ascii?Q?2egkomUjplfLr+UVZ4s9N8jLt8Q8EEOCWP+aFHNYonnPe+8zbsp8Ql4VQ6dK?=
 =?us-ascii?Q?xjn9L4j6Tmd2uDxpCGVDHvyQG0vE+lCTS7j3OU1FPBapMqUudZUgVRXD55sT?=
 =?us-ascii?Q?lddFXKULV0H9DwmliaEDQpzP9zcRZEUJSoyyDu4jGUMtB+abNWd+lBsxcw2l?=
 =?us-ascii?Q?eSFrhApnqwWrgclL6FT6wu6bck4QCcMAZio2ZanSc9Dl1geG/RojOCj1TEgl?=
 =?us-ascii?Q?FVZfoKqOtcAj4I/KJspVKzMd1+bMkLFwMTofWf8fNzq9Rpp2D8FoE2lWKYrZ?=
 =?us-ascii?Q?i6tOUPg3xjmihcJ107v3GzdJ6SOK27TSLTXEZoYpKHvQJWzQzVt9VfIqAv+D?=
 =?us-ascii?Q?dOUapJoshdrBVEY35LhqoOJKYFEBzwbphKb8s7tlrnDu4er83sWanAWOSQwx?=
 =?us-ascii?Q?SZ+ZtNjWcI+RG3fqBqQLTC97VyV96jQvCpfLB6MG+yL6HvRsYf6pKfd8xQs/?=
 =?us-ascii?Q?jOv5SG/HDfyN0PHEvuoWJg4ikfB6eyGkU+Xmzu1pjxVx/H8qv6VgaCtI6HNx?=
 =?us-ascii?Q?IxWBM9BLHo3zd0Qf9nE1KRsGPXUsPSXOyj3xbKdjnCRm6VHc4hHWiNYw/xaM?=
 =?us-ascii?Q?6fjV3p8Rmds9E8OkjSdC6ALxzt4aMm3qlGOKGlldm4LVhjDFmfnDVU+fLixP?=
 =?us-ascii?Q?tx7wHnFh9SH9o6vLzfYr9dHoa6ZbctdFSd7nY1N5g75dF4aat1nNc3lUCZX9?=
 =?us-ascii?Q?nqZCoeHoR2mcgaHeje78TJVbT5g2YwQSfyO7eRVkfevzgGe0hTue8UCpo7vh?=
 =?us-ascii?Q?At9IbuE3Y2WKPypvXiXqWveB8lOL0FwvcgsKLXgx1KXae9bq0AnGJr+T84Qf?=
 =?us-ascii?Q?xgkeXOP6LygYcyZAlTqxQzfoZ26M1CPLdHARuk+aPj6FiV6SkYbxcL6S7U1P?=
 =?us-ascii?Q?/b6U20KsMEelT7S/+G1vQ7gDg+AFzNZDs7mQFnVcdENy6aTLADCgYidVoXWT?=
 =?us-ascii?Q?oXwSw92gF/eGP2btpNeniwUXflJV6C2BbVFo4TIw2xu/BRgpqKyU86yxvnrK?=
 =?us-ascii?Q?GMYamQt5W+PwpRDy0sOnNYnMlQpO/wBFrotd6NjXxtr/8amzGm6JZkwTM1vm?=
 =?us-ascii?Q?rmCx9jU/OJP86ypbtP7oCmQQrkAz2rRaVhexmxdKyDYK9oEU2vCG3rjLmy2d?=
 =?us-ascii?Q?f2GrIXLWBYsXcTaPWDCCkvzGlFxh5jAertzxvvsDlCYmpdijpt3B6LSPAEr4?=
 =?us-ascii?Q?MUhUnhuBPtjtEqgc/4r0JIajOut9YyyIef5SM+JAd1+nZXxjvamfng1yoHGu?=
 =?us-ascii?Q?g0XeU6fVRFq+14KtI++nURDdupEfGF9gkkIuxgj0LnBkOveXly0LjAxl9Ce3?=
 =?us-ascii?Q?832Zi/t/fE8fNpuHd9g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92eda7d0-c6ea-4f3c-47dc-08dbce5ed2a2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:44:46.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6DBzYMyLo1r6sEKxnSSWS9sClQpbY2EWvaneRwi09AYH8F1AYIzXjXyMf9efqs5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_12D76446-B7F7-4CB6-80A2-1AC99446F504_=
Content-Type: text/plain

On 16 Oct 2023, at 11:41, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> nr_failed was missing the large folio splits from migrate_pages_batch()
> and can cause a mismatch between migrate_pages() return value and the
> number of not migrated pages, i.e., when the return value of
> migrate_pages() is 0, there are still pages left in the from page list.
> It will happen when a non-PMD THP large folio fails to migrate due to
> -ENOMEM and is split successfully but not all the split pages are not
> migrated, migrate_pages_batch() would return non-zero, but
> astats.nr_thp_split = 0. nr_failed would be 0 and returned to the caller
> of migrate_pages(), but the not migrated pages are left in the from page
> list without being added back to LRU lists.
>
> Fix it by adding a new nr_split counter for large folio splits and adding
> it to nr_failed in migrate_page_sync() after migrate_pages_batch() is
> done.
>
> Fixes: 2ef7dbb26990 ("migrate_pages: try migrate in batch asynchronously firstly")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/trace/events/migrate.h | 24 ++++++++++++++----------
>  mm/migrate.c                   | 15 +++++++++++----
>  2 files changed, 25 insertions(+), 14 deletions(-)

Hi Andrew,

If Ying is OK with this patch, it should place my previous fix:
https://lore.kernel.org/linux-mm/20231009203231.1715845-2-zi.yan@sent.com/

--
Best Regards,
Yan, Zi

--=_MailMate_12D76446-B7F7-4CB6-80A2-1AC99446F504_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUtWmwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUTHkQAIuuCAZV6MlknRreqmrfC+oGfuRrwKSQKgk3
AOidkvaI/GJcRablFOtm2M7QlDRDLAfKIbMGLH44YfgrUaEJ+RHfZkJDgrgwcywA
7muLf+OMNd4wMn30Om9DwkKUW1Ip1Leu6sraqSkIOpUcXNgi5Skbl5eEp90kG0YZ
XOOVSabK3mf5Wtr4R+31n3uP7I/T2sj1UAXy8Z+Lb04x/SaeM/0LPqXok/QkhelF
Z+0b2rbQjjDe5uDiCA6hrMhiSPLUj+Q1uyjCdiACkQL7wNvqddK/aqzJZ/OJbyOy
5sjRc2CHgJF2qSn6SYPdtN4Mn9YO3yftk55tztIkqHgYSirwSHFKqInLkLqoPSsx
zT0TB3xTktlkH2inuu+uCDg9/Qxyelt26vtKtsdUjiByf759G6GvZaFEc8+DnBFt
70OmZFsS/P1mjVQN/l4H+rv53l1V6ewjvLPsMl8bVCS09G74GRmngWh1SzQh1dIY
FDpiwoUBN4iM7BqgdkiYFBi6tivLQ1OTLFAphEmRxafwSLS8wkutmYUiTUA3yUGJ
JAyyidQD7aJBbEN1Z/Fmhq1DdXAE5n2Ew5TnzQ2GiwaALvwgkfWBYiYv6+vIQ6ym
FRnFdWIoAPew/DUPuJNSWUDANOgg9FVh5d0yI1DxAs+XOtNtrcIumwlsfWXtIyLS
31Eah86F
=4gEN
-----END PGP SIGNATURE-----

--=_MailMate_12D76446-B7F7-4CB6-80A2-1AC99446F504_=--
