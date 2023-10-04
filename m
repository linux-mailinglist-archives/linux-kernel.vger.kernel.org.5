Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AA57B7764
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 07:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbjJDFQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 01:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbjJDFQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 01:16:25 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2094.outbound.protection.outlook.com [40.107.101.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72616A7;
        Tue,  3 Oct 2023 22:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxnHMv92uky9zj38ojZ3hI8YogdKTCFaIOQ5msrqiHf8ZvSH7dtEhY9AXRrKUvHPj1klzFBa+In9kY9NTnIWBle9CuOEln+A/FrHQKaI2Gpc/QlmDO/0TY2rGAfbTFEKXtMBYU5t6Pkx9G4ojaTsZAdIqMJ0d4otgwvH7q9Ddq07W+i1+O/iFbYgupxnWVR8RYXf/25V6T4ngXhSWHUbNHnMO0C/QvN09UGW1+Ilj1C43YCQ7Hl4W7nZttinngEBGTSOYe9UFTgccJ2nKi5iXhMsXs/4rVgxqzL9ATyGSuInZl/uYhATJBopibpf0RGIXQN8YiKQCM5fNB1hRwYz/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxQYvR9XLDIhzJkZU4ZWAHiDHstHMvznBHyzQ15bRVk=;
 b=V1OD2dUG/jKu15YfEpsoW7/ZoHlIWYL3zxAV2dM9Od15dhIT5AvvBIaSqaH+MtFW+5uKf6IeDqdFa2PsarYfxrDpiVtQ2F2BVo52zHo31WafbsfvBKa+mseSXYQZQvZI/t1B074yUL8UYXLTHEicENQjm8GH2zwMV86LTF6qOOHX+lP2Y/hvoRQ4Ji3zgMGBeQLovkog9UsnKjCk9MJRc2BogzcZg+4dGfZe3vmfE37w0gkFQAHJ/gUPK7dTrru7UOu3dchqyOqyQs5TAAH7FEx0fZ3pIK2tJ+4HhywJkXsOR+Is9TyPEl2F+T5pfVLPZ42PCWl1jPiG6rArjR0QvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxQYvR9XLDIhzJkZU4ZWAHiDHstHMvznBHyzQ15bRVk=;
 b=Ec9i4ZlxRTyP/O+FQLFjXkvYLVgf8Ac0dikjz0NQHfvhNisUnKPAoXdwncDQyGEJHZ/yam6ZrYagLj1RSSQNZLMmS/OdukJQxh1xo+DDbwgUwwurVEe67uMC6BxzxJYRrpCLG4FV9LNqI3mrndfPd8cubD7L1Yssv6xAUYGy0NQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 DM6PR13MB3721.namprd13.prod.outlook.com (2603:10b6:5:24a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 05:16:17 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::6287:b0d7:3d05:a8b3]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::6287:b0d7:3d05:a8b3%6]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 05:16:17 +0000
Date:   Wed, 4 Oct 2023 07:15:58 +0200
From:   Louis Peens <louis.peens@corigine.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Simon Horman <horms@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Yinjun Zhang <yinjun.zhang@corigine.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yu Xiao <yu.xiao@corigine.com>,
        Sixiang Chen <sixiang.chen@corigine.com>,
        oss-drivers@corigine.com, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] nfp: nsp: Annotate struct nfp_eth_table with __counted_by
Message-ID: <ZRz1DnlUCmgJdS1Z@LouisNoVo>
References: <20231003231850.work.335-kees@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003231850.work.335-kees@kernel.org>
X-ClientProxiedBy: JNAP275CA0059.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::12)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|DM6PR13MB3721:EE_
X-MS-Office365-Filtering-Correlation-Id: 11640dc4-2504-4e5b-955c-08dbc4990983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEYCBokDZXmJZNILoqMkFfC7uOq3ajNvI2XYCWTsLvFA984/4rP0JWgVVWiAOxKEoH7lWu+OXR+ZHc2h7QUXkW1Rbpb2qUYszJuMn7M/uU5dkBit5jLGIHLqMippCyHlmyBVTs6sdFJHN3tBlLqU55NVltzP8DDhdG0RC62YRNwmtXcGACG25hesbA6Tckd6C9YHiYgnK3Ap0YrSTDx9Bd/DmBhGHjimN8T2KqMcMwy3/RQ/JQBn7jb0sfKInkPRR6WfCTwBa0uwJBzi5FyJi0Wq3+K062bt91BQlxuzy37lXDQovhGBgDPnvg2Sf8Nlg4qyARvJmwIqq8aq/No1slZ8xUIFdXVvWnFSI1/g19DhPItxMyTGTb7seRvNGRezKSMk5f+gPgZ7WXw9jAfpsRQKn3Bg3WDJlZC3qtrI2jLmDa21eb4XnM3BlAbdVRQxrykOY12+mOk01RB0o/46Lfs67qy6mABZHLWf4uDnv39UIMaCu2B6sgXZ0Qd1OdKu7SCTJ2Nm7D6HVuvc/NHIa1weMmeymlmhuQXsfkd8rl65DNBfBpYjd4wxbDHVLt4+ClIpVbcsFxAafz4m5ppSyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39830400003)(136003)(396003)(366004)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(6486002)(966005)(316002)(6506007)(66556008)(6916009)(6512007)(9686003)(66476007)(54906003)(66946007)(44832011)(8676002)(26005)(4326008)(5660300002)(8936002)(6666004)(478600001)(7416002)(2906002)(83380400001)(33716001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1IKIZpHXVaXuiIAc4nQPxep+gpxYyEe1sMqMAhW0lV0dHMegxa7xRas7naRn?=
 =?us-ascii?Q?HxT7Tvp0kIoz7ZgebosqmTNcrxGCs3gnzXiGSwCzgvkurGFWVXTmMgxkPwEN?=
 =?us-ascii?Q?B8UgY9t4uUOsVBAuHd/44P7+KmAeRvESsmuXo8liSSs9ZcMgduLF/fjIapCf?=
 =?us-ascii?Q?r5ORi7u/rwQbxV0ypfvj57FtnQZE3QYM3hxcWp5cDjFa/Pq6ebowScTOv2W6?=
 =?us-ascii?Q?vKYPyBplAq8aipg/KTBqDf+VXPXnirGnuxJn68Nnp2IrJMhqZvAUqkSuYU5W?=
 =?us-ascii?Q?Fx45qp/zORiWK1FNtqRuyvwiND0PAtPt+/IMtxjYOr4SSonf9YEfQk+tOExX?=
 =?us-ascii?Q?Oa6zd2NIPozKhK8pY77frhnReKqGUM6359jEiMMU4FV6xBtOxdd8jpGRzHCh?=
 =?us-ascii?Q?TwM+jlu0XwgK6crK1Vlh8FOe0ssCSEyeaMpnxJy4XSIB2U7IfnyvTC+a1kRa?=
 =?us-ascii?Q?R+H65BPL4vmPGSzm6octKX6ESk+8GouDUqq+HuIZz6zyDi80BMwlQKsUwqqJ?=
 =?us-ascii?Q?4hbh3reZA2hyx8+z3Q5DeMOAlNpmK3VzKpMpGKYRHKAeQThbJTAQcffZmiAm?=
 =?us-ascii?Q?lDUSL3vtAKX80P+P3vqov3J5AUfTq+8nDqQvK9tuljoNVWm2m9DUvv1ygio4?=
 =?us-ascii?Q?mJxzCtBlO99gpeYR4Ul9DpfS3KHK+UQaO7rXMFzF2Um8by9dNsR/Z5R0EQlf?=
 =?us-ascii?Q?d7psDfmrK2nEWYstKFM5QDdkhqRoNVrGY2w52tF34NeQJZ8uYbqMT3qXklv1?=
 =?us-ascii?Q?PsduApr7yE5bx6hwgHK0I4tSVbM4FOzydXX36hiUm7GodMCWvlIqH84QM4fi?=
 =?us-ascii?Q?IaL7N2qwVnuti95viBS5k0xHcLILvOmxa3mW4JCdpM6olFW2srLPr2l2H6DA?=
 =?us-ascii?Q?W2SkGh9E2OP6pkvRStJgMRqzMCRSSHmCTFcYk6yYXkJQPhDZ1j+ngP0iJb8t?=
 =?us-ascii?Q?SaCamIyhFPj11q4q8cFNQggYgkEOhQGJOY6pjp9yQ3YW0qVpb53OOZLuh8UV?=
 =?us-ascii?Q?bUF1M/1r6McmZw1s0z4B56liHpUlLEvP6gljUu/wo1mPeCn9zTZNxnRB3N9v?=
 =?us-ascii?Q?ekU7OVM2RIEoZUyp1cjLkypV5hV8vDan3BjGAiJ8p3+wtRcNmDXy0K4rAxGg?=
 =?us-ascii?Q?tEp2tA7jJA1m1rAfTzTGN0ifm0dg0N7ZZSRC2EWEniLGO+R85iuq1y8CH2ez?=
 =?us-ascii?Q?TEF8pRoQ55j8Cw8VNKewvICPIcUTDxSGYOXbs9+mBQkQoPdmd0K0XT9yb8xd?=
 =?us-ascii?Q?f0tvS10HE6wW3TkaCoEVqON9F3ZhUQ0NO5XCRrTGUei/xQAgArOD6y+61pu+?=
 =?us-ascii?Q?eyf99lGk50Whndtb7QDhoZ0+v4G3NPL4rRDGogS1StyX9v+etX7H2tE+yfq1?=
 =?us-ascii?Q?kAT2A2/I6snZ1OQWHF2ngu4XLs7WhR29Iu/PzPmapF0MAQIH0So5GJ3vvPkW?=
 =?us-ascii?Q?RD75rmd0x5ghZnr5ZFbrjQnh0NWivE3mEcFJWXZZ4htEaqPT4+XOXxHGGab2?=
 =?us-ascii?Q?4+QnkU2Pi3idQ5RCmaeh62BxDHp/9aPr+yojO00y3YswHzv/CmI5BoPl/a8X?=
 =?us-ascii?Q?w03nt4DGtg5dYY14hls8seQujclidKqFFRhiEkSub1Iieb7dyJLm8E3T4IBG?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11640dc4-2504-4e5b-955c-08dbc4990983
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 05:16:17.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07djJDmyD4HXjdpolIAuMw9iHv0/cO9KNRDFK0Rj2Riv4Gqvw347ZoSGPw+kJzvt+EBhgiYVE/X6jTh4c6yi3kVAyN2gqy8ush7uWjY++n4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3721
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 04:18:51PM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nfp_eth_table.
> 
> Cc: Simon Horman <simon.horman@corigine.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Yinjun Zhang <yinjun.zhang@corigine.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Yu Xiao <yu.xiao@corigine.com>
> Cc: Sixiang Chen <sixiang.chen@corigine.com>
> Cc: oss-drivers@corigine.com
> Cc: netdev@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
Likewise here, thanks for updating

Acked-by: Louis Peens <louis.peens@corigine.com>
> ---
>  drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h
> index 6e044ac04917..00264af13b49 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h
> +++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h
> @@ -241,7 +241,7 @@ struct nfp_eth_table {
>  
>  		u64 link_modes_supp[2];
>  		u64 link_modes_ad[2];
> -	} ports[];
> +	} ports[] __counted_by(count);
>  };
>  
>  struct nfp_eth_table *nfp_eth_read_ports(struct nfp_cpp *cpp);
> -- 
> 2.34.1
> 
