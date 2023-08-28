Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D194F78B2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjH1OM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjH1OMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:12:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A46FCC8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7GsYOik7L+PAdi1BE8hbVmCeZ/FQnIk3ba3mVEVAHShjbkpZZeP1E3DEVwB4XRCUvZinGjMIonbWyGGRs2MN3z9/sqN4yLj0E0No7IyrfaEKmPyA3AiawVFdZEbL1nbnYzDXpBVRKZOJejbaac1RAxUnTP/pb5g0GfzEZEr8VULYMdk4pZAemjWn9HUuk6Cys8fwgMQBgfzP0eBm6z03rCWdih7QRflbG7LPUObxpZ397D/sbZZHCFfTNZWV3UgLvFd9jaG3UZFidTTLiDaL/XUc6NvFF/9BsUohrauc8pkw81m4P4e8IBPBhhsXTweI7WwHGi+g9TpSg7d29IDXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfJNPrLkJFpPRAUC2xyffRNv+NWF9VH6/19CSGqEA34=;
 b=BFcjkeplOCPaUcv/BXVcneqDCOWAdz+SVk4mhPJ1AduIVdaDLjaLKK5BPAQ0L/0w0kBZl/oQ0882csU9Br6pBqzrpYEUZ+yp5v43h8scS2BBMQImzd36I2D4vqZNWcPvtQ3lkElRx94fGAka/iKBkejl//X/Mp+PAEjFbmtLn4bolnOx0QOJZ94LTA8F4iIJceWG6GlE6zfLoZxF3PRugDtY5251D3XeO9sg0Tj9iw46iL89EJCKN+Y1ORr5zg0yTTTV1goR04Wh7iS9Y+hDBVAgM/3XR62iFkuxjE+rLFacWnl8fwQPTvCLWDPBMwxmJihxbMv9i+zzt+fOJTRMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfJNPrLkJFpPRAUC2xyffRNv+NWF9VH6/19CSGqEA34=;
 b=fKwXvlPRqPMVDm8tAkQxrMpAkU7fwqQkTH/FrKDraD6Nl3ef3GYno1rVuTzdjCduikxTOKvvqDQwaeNCG0aiHMoEHfTy89UaxUjBTln7OeddYHi5XDlmd9Dkg/gGOrUFZGi0HtESBHKr1D+cq+w7VuM3+LXfOduvURZYQ1kNrUEYVVb4+yHiwocAWdBUSjy7Zd792OGeAzecPxfAy5PbC+3JoDMyudzhE4xazcL3CNpQcpFd1P7RwKC4C6yEPxV+wGmGN6sIcfuu1ErzrcNPQk9ctcsIRfF64pEW0KROb/3yw3xZJdkllm4xo1goyDjOICioqfT/LxdRy4QaWCs6gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 14:11:27 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::926c:4184:7e6:de25]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::926c:4184:7e6:de25%7]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 14:11:27 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, david@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>, hughd@google.com
Subject: Re: [PATCH v2 5/8] mm: migrate: use __folio_test_movable()
Date:   Mon, 28 Aug 2023 10:11:25 -0400
X-Mailer: MailMate (1.14r5971)
Message-ID: <B9333BBB-3B2A-441A-B064-2E4F281369CC@nvidia.com>
In-Reply-To: <20230821115624.158759-6-wangkefeng.wang@huawei.com>
References: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
 <20230821115624.158759-6-wangkefeng.wang@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A7C6C21A-9844-4FB1-B4C3-F4ADA6348A6D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:208:23d::20) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc66957-a279-45d4-4810-08dba7d0ab4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKp+LHU20S5xaxGthsnfKsFvdPGTWMt5I58xNmjJSjehj21D78esaPLvIzPmJUFSc03gwVzqFNIcTWG9CBxkUEwN99o3r61bIveCNefkLK0b2HZU/Ub5Pik0E1UCkVWcyvjR/VtDPuSeGIf56Gis2V8GErhpqCGPB4u3YxUvcvlIuxNI+GrsDf1jW4nKfmrU0NafILTO9RYuaWrJnHtwuiB0RDg7uqMi1hMjkN98BUufgd7Mx3T4TgEdtCT7T71CsX/WowACqYBBADfcRYvGIIFJD9lNsVpUQVt3Uleoae4DIaNGqwtR4z1Pp68idN7ROzKee7blHEI7lZtS4BHpkaTFCvUD8wKwQGaocj0g0HT3T61A//Rrkjq0l1RvDYTVEGbtYJrdrvd0lAhLNz16z7/P169Xt8JTbYZFqfB9mjdXPg1qIFTnOaR8jdn2eGTpPXMJJd/SAETFHyJr55pSI0nGnXHK8rqyrHq6+GJspKUMxPTBC37ps/NwACv2PFdd/iL2icfyaKk8A/K+Ue2KlZ6GFfLEahXFvPI7wX/0uDdoZtxNXx+1RlKiwroJ/UeTDoC2PuBt8jl26wAiKYG5XzjeAHcTGq7uHQjV87tNjaKfYDV0eeqzwBu4gsjFlCUPK0ATzIFUTJFOG513yQ/Pzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(186009)(1800799009)(451199024)(6512007)(6506007)(6486002)(53546011)(478600001)(83380400001)(2616005)(26005)(2906002)(235185007)(6916009)(54906003)(316002)(66476007)(66556008)(66946007)(41300700001)(5660300002)(8936002)(8676002)(4326008)(33656002)(36756003)(38100700002)(86362001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JlZZ/NCLwX0HhPld9gXF2tYdkHt8uCcxE6crFv0YPhyIhnfoWE1SgKmM6Gft?=
 =?us-ascii?Q?bMTWq9Xs10pOPIBzCealXUru1zjhnM3JOoYdDGYrbdsGOAUaxKL1vBnaLDZi?=
 =?us-ascii?Q?ZKBaWk2hSurX9xnyG38PUXToif49jy9nPc7TuYM+gqfhXSI/qRk+TCcafjtq?=
 =?us-ascii?Q?L43+Xwbj+AZQ+iBKQKe+gzBr5n48rjr/zalTltJkM2h6HiZyDbhTq+wXAZJ+?=
 =?us-ascii?Q?bGGgSvfc77mUbjBxzHaZPjt4mgJKFybIaBk0JlLdPA3epT+vZZoXGOeSBvzo?=
 =?us-ascii?Q?mZ6yGVhMJZNUwS648YtQzv4M994j4+KqHvXo87BqxLWNgUIs+MKqoO5N0pNv?=
 =?us-ascii?Q?JjiMXM0Xxqy7RFKjmAVi+MAu7EWLImhcIsr+mzXheXQKNpmpAQWurQLSweLU?=
 =?us-ascii?Q?7UHGeo29mmBTmMCY4xX3SkYA4Kid+CZbsz5sk8kfgRVk9KNcndxEHHgFn8xi?=
 =?us-ascii?Q?Zyd7W8jNnbcwP3c3xF0SJHwM6KShFlIwvtCFSCBy5LiJXuY0jNzevvVgoKzZ?=
 =?us-ascii?Q?8X63PKYurIPGHLhD3a9qQbK3CbLqS4WhwX/3hmPQ9x4Jc9aNtVHBmj7y8qxh?=
 =?us-ascii?Q?0r39lHdwdNAUIqBl9Mv9zhcLpCi9eA3ud+RX4taoZ0eDl1NdiBXrfZlcPAlH?=
 =?us-ascii?Q?+SR1r2MOgDcb0DISO+kCt1ri/sk1TJP/upCebSEPTgAZf6EKR5uMNzOOYD1Q?=
 =?us-ascii?Q?qaeMoNvrsNEQGYxV59b86k0aOc5x9BtpmCqEultJ7KMnMj+s6cl6ee9ohuW1?=
 =?us-ascii?Q?oOGAFa7cASipzcNlcAqrbeMnka0Zw8emksiazEqsk3bzcLqNRDY23PyGF0kc?=
 =?us-ascii?Q?1+ht2orlvJEhv4HPEU6+CWl+RSLrksQpekVA1rlM+SlnfboZAhbkkoJJLqI+?=
 =?us-ascii?Q?QRDIYhuM/l+OF9zuPr5was4+OqNfIIWpcjnxpDyMuXfsMS7vXna1ZhMsHjxb?=
 =?us-ascii?Q?XUWJqG+FLK4Kl7eUZJ+iM4milq3fvTiLY0C9Gcv11H+FLbf+nHjoVmwfcA1r?=
 =?us-ascii?Q?tU6LhlYEgHAdgirHoVFtmz+qo62CuhIlmn+x65xWDhcxQRd1VU0gqby+vWot?=
 =?us-ascii?Q?wrl1NugJ7EzbW4dA0hDvsA46aho6AbjyWty+JMLMK2pNCDE3Y3i2svbCt0sb?=
 =?us-ascii?Q?mN4V9eavEZzUhjIEyFZ6k5VHVs86dg/MQ7DGDOgc/mtkHMBjioIZHeTECeZa?=
 =?us-ascii?Q?PUrs9Kqq0yzDOa9ndy3LoZ1+EUdBwmjtGltXaFvD6FQJEe7xqL2NsthrB18e?=
 =?us-ascii?Q?L5oxGzzKW5ZxjjhEcUUXZznpiytFkY7N3bBkr7apuhGGGK4ecN12sNR90D5L?=
 =?us-ascii?Q?vPAtlnqwuCMIMXQygp7LvcUrToO0MgcmKd+rRoIVGB6NzrRg6xW6BhTnoXKA?=
 =?us-ascii?Q?K+I88Hjx1O5RaRTI2xKEXv0+6QgtPI5+QH20YE2zDx/zClctUiYRRCzM7k/y?=
 =?us-ascii?Q?DgsCf3gqsLws7q1Yu4Op15MRItS/rgeusiOWrN7x4YGR6nqe6NslcXZr4RSA?=
 =?us-ascii?Q?z/hudmAgIAiwR8pY908k4YFdaCXCJqnI1+yxTTIUk/U0Dejba1e1Fhcih1cb?=
 =?us-ascii?Q?/Ef7jtDbdMk/n4mG5jsqfsJ35e09RNSxfjlWlcql?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc66957-a279-45d4-4810-08dba7d0ab4d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:11:27.3984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/yRGj/BCNB5q53FUHz6jo/8tu1X767WKe1uYCJDpl4GcnO2sWzku+jghd4qNNzG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_A7C6C21A-9844-4FB1-B4C3-F4ADA6348A6D_=
Content-Type: text/plain

On 21 Aug 2023, at 7:56, Kefeng Wang wrote:

> Use __folio_test_movable(), no need to convert from folio to page again.
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/migrate.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_A7C6C21A-9844-4FB1-B4C3-F4ADA6348A6D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTsqw4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUD0kP/2OsS40txAjKRoH+ApkSRhRoFHxD5WwHLsnE
fp4VollP5KVINq0BKkxekQGqQ1UUk5irbtCsswCH40lDR/FiQQtTNk0BEWv7DyEn
0x56OiL1Q5t88IkQjNSX07HDSj7rNZMMD/oU5aeNtUoSI0MYo+GcY9SCLc7lGu4W
xOechdxBlTYREXgKgS9iQqck4nvLPgpa4y8LgbSX5H1T5ZsgZVg9nbDFQIjRe1NR
wCXD4U36UJ+4srbaBpB+ZpP8LXDC0OkbjsQxiaLS5ILx5PHSAYfeca0k3ZAJ/Tcd
F34GRs4uz3fz/kJTvxKZQG/qc7gWEY2v+leGkXYnBYrNOZF5IbEZPIiu+Ukzqoig
TXRNpZ6E5UUmszXRTea0tWaujO8ioaq5oyRReDDAt/lhUbAN4wXdwwoh4TKyikZT
XTXDrTKl8h0+HLftsi8mjlKWTx3BmLp/5rLsdHpV9g7bb5iECny3J+gWnmIlH/4R
CdX/ptKSHghlwWbGJWkbwiiNZzeJwQusW/17B4CVWhEAUmnmAUkRLw1t11HzhtmS
950bDFywSEJYPDrl9/FFXFDfapAP84oGLpXA+b7F/fqfO1qVFYsWT9YNmmKUw1aO
kuyVtBWIB57GmVdmVxyG8v7s3giN8BPYJD7Ar+AeYzxfSNSm5QMl2f/+Ew895hR7
+qT8Q/38
=9m/r
-----END PGP SIGNATURE-----

--=_MailMate_A7C6C21A-9844-4FB1-B4C3-F4ADA6348A6D_=--
