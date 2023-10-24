Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83DD7D4CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjJXJsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjJXJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:48:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8CE92;
        Tue, 24 Oct 2023 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698140899; x=1729676899;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SAmaxBIBTPilzk6IRgzZDgFA4mWT4ynbEipOJUJ6QOY=;
  b=lfsVl/7NrOP+mgEhADBvTFZbglZYWKCitXuyPXjGXPp3af1Lbj85nCJU
   rP7J/7o11O/eg0fKH3/Iw8i8lpb4ALx69U/mKC+HZ6IIK1sSWVIxxI4YN
   466yAJVQeZPGMjQ4ax3SsLGhahx/moi+yzve5dGAL6XbFVndjX2qlURyN
   7PE0eI1sUnavLQHnnTPuMgXgYv/hAm0gUkUlj0QePmxAgR87d0mAwYDQu
   bJkjbjUY/beqUuE6e0hqgLwneyNSQ704zlm/KGM1rC8geUspBV+0JwtjK
   b7BAp3cC+vWpS2xig31LYctipjUFEaBzFTGe9z4KdA+wHqcgS0vaZP0qS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="451254561"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="451254561"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1089791358"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="1089791358"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 02:48:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 02:48:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 02:48:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 02:48:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3FcP++7DAHqe95EMdwZV+BzoyZXUqEKgStZ2E0yYlI6C87e+XqNhidI+PVr6bwDyAbNenG2GjnUeXzgQGRddFrLO8merusjEicWEX9Pgq9/5BwO3ewXVNk6vy/ZDuDnthLP0VKhRCelPwvd6phDJrCi5JaC1j+QdDmV+NnM+g3Twegn1My4m9SmwkSLacq0IM+A7ZyZYQ24FUGsflaQul7hiBGNlB2rUsySjw+7LuJX76sAjYvbiPjgY8F6Hg+rEapS8ly9eAZJsUzMCT5kbgj61nUBqUhsO82xJW2pV7spsy7IpAcXVJUueTBLsEEi9oTJtyI2+SlDEGfjNaaLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6nm1FiIIuFP3phF+AWtQ+Ysrbd66VKdL/gs53D0CR8=;
 b=nZSbQhfZQmbgAiQsKod4e4E4Fw3Z0LlJKhkmRfWZyVbVu27S9BKqa8xrhZ2W2/ivC3FfzkOP6u8o0ZwodoT4Qqhv6XFz48bQs7KV8HbYxd8wga+wivOClb0LNFwBd6r+Hez/3Xt3bTghGu7jo2RDUNoVs4oD8NN41Bys1ugbjCd1mX2yWnyW6Ekfyn4lP2k3EdfSSXoKsE8F/67kQeJeLe+bEUf6xNhbPGJnDhX4nMKFey409sSxpEHUMwkO6bb1ERpq14xTcOYZ46xRY0oViIMHNUCDI4qqhQ07kpCcrYToQTLluOZj0Px8iRJTBGISfMOAfYWnH1zhj7aJq+gPSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH7PR11MB5916.namprd11.prod.outlook.com (2603:10b6:510:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 09:48:15 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 09:48:15 +0000
Message-ID: <0c432d17-cfdf-45ff-b9e2-99de17c01ddd@intel.com>
Date:   Tue, 24 Oct 2023 11:48:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net-next] net: hns3: add some link modes for hisilicon
 device
Content-Language: en-US
To:     Jijie Shao <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231024032034.417509-1-shaojijie@huawei.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231024032034.417509-1-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::14) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH7PR11MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a98ec0-30b7-4024-e7ea-08dbd4765838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tV1Q5iJRzGjSt1/FnNspE6lAGrRlsgecRZ5Nf9aU7Lj32KCGiF54ij7pUCiNOdtqsbXgAzW/dvbTgXhjt/wUDIOpCVhN7fANrF/2BgpbyBT3CNcWkspsoLfBrcnNjrjmPp1xdRRbFKkD7le1/RJKpGPXGUkekB8l30Rqynl50MgakUVfLsM3ah3VEnr5rwZl4kqfmVrwVkyBBgQCp8Pktmh1tRup3lEb1zPOws1VuT1HpKAuKZMBt2v8EG/ND+BOn8NUjxbAcEqhTDvlQBvGm921fP9PsLg6RURNYyl3iJ5LZyd1aMeYibPbloNShbQl/R/OhfhaPcZcLHLMO70E42yLN9RWl/8PaiEBj0kw4AZ8edhyE/di7c1KVz6iascXoFq1W4+IUQfIMlRlfax/uC7o1E5Wc3Rq0Fhjwqor6j+0jaHqIUXdd437t7AKt6aH3mn+0cjdXGrndgAAyLLW9hVJWrZV7tx0ioxmjlYAeLg5vjDD6BNgKZPbT/oMtTgC9XtOhD5lM8S8MjCtDJEo3XoNtFJLhEVdVudmbB4vsnjUTOnYkaDNPsXldtbiKvkevEJoGPr1VdqD0HE+4qnOxOQ7gmCSWv/e8E9no02AGiLAdKHuGJfzn0uf6RzOnG6OtOmUeJdCtJMi5IAiN2Hvtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(4326008)(30864003)(2616005)(53546011)(31696002)(6666004)(66556008)(66476007)(478600001)(86362001)(6486002)(66946007)(83380400001)(26005)(82960400001)(5660300002)(38100700002)(7416002)(316002)(41300700001)(36756003)(44832011)(6512007)(8936002)(8676002)(6506007)(966005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGpVazBmbk9xb25yR1lTekh2SWNJMU9yVWJBZ1JRaXdGTU1pdm02MnhpeDIv?=
 =?utf-8?B?Q2FNeDBPUVp5YjRQVk01REdEaFd6SDVpdTAvWXEwMjVPdU1DYk8xNWhuZU1s?=
 =?utf-8?B?UVhmN0JXdEJYUlFsdE9LMDRJL0hhRktsQkk1WjBURkREeEIzbU53a2UxSVlh?=
 =?utf-8?B?WklBckFTUkFFQ1RLSVpjQUNNYUpsaHJaZExSdkt2blVKRmpxUVRuTkgvaitY?=
 =?utf-8?B?N0dnOGQzZm1tUGN5N3VadGhEMFpVdktXc09wZUNQeEFKeld4bWhKckxIcmVj?=
 =?utf-8?B?UmJhU3FSckNXYXU2R1ZxeHJUTmVKYVV5Qko2YWY5TytHN1RJcW1QVXlpekhR?=
 =?utf-8?B?MHdPZ0RQQS84aTFPbDJhaGx4WDJDUkJsV3ovc2dyZVFiM3EwREJ3K3ZnbU5C?=
 =?utf-8?B?SGRTZC9xdHJEUVlremwzcVoyWUFrZ2VLcXJrWnhiZ3luWXllOWN0dVVVOENa?=
 =?utf-8?B?OEZvdWxGbjhCWUEvdGQ3a2g2Q1NudzROWUlwZjVQdDFkR0RTZUZSTEFvYVNy?=
 =?utf-8?B?dnFCcUhFeW05QnpaWkpjTE1qek9TaG8wWWNKdEw5dEgzS2I1enE1NVV5elpt?=
 =?utf-8?B?T0l2QVp5aDUrNGlQUkFRRHk0ajRIV2thWWhUMmk3UE9PMmRZQVJFcnJxR0dP?=
 =?utf-8?B?ZHdZMzZzemdoTFRzTXJETjh6VEJyN0x5MTNBN25kKzc5YlNSMEJsM0V4SkVv?=
 =?utf-8?B?WnBpYytKR0xXVGxTbEhycElTM0tQWi9CL0k1OGlDcVhEdU00VzRzS3hUZ2JQ?=
 =?utf-8?B?YXp5Zy9yOC9HZ0REMS9FL3RMQ0xEZXVYMkRNbDRKY2dEQmR6bkkwRmVWWmN6?=
 =?utf-8?B?clpWN3ZieStwME5QcUJOZE9KMk1oRk53cFN6S1hzZzZsM2ZrV2lxYUtvV1Fm?=
 =?utf-8?B?bVNEWGIzOGsvT1Q0V1RydVc0LzlCNXYzSHZmOVJRRmV0NjI1YzhUNGZHZ1Z5?=
 =?utf-8?B?V1JPYmlEb1R3RTlTUGhjaGUzL09SNGtsVUlFSkdwOEJBU2ZIZlhLaituZWZ0?=
 =?utf-8?B?YThXOUFEeUN4WWFJYkNvV0l5NUtneVpvYkhneEh6elZoa1hBQzhWNFE4cGhO?=
 =?utf-8?B?RGFJMC8rcW1OejMzTTNBa2NhMXJiTDhxY0dwL0YzUmMyV0FhZmF5cnZXVGpm?=
 =?utf-8?B?NXR3SkNKNEtiS3ZudG5TdVVJdkgrbVdmdUxqeXdGUjBrK1FNUVlvR1pFNDFm?=
 =?utf-8?B?UVcyVTZlMlBKTmJhbTE2V2w5bkdST0dmK3JVejdab2twZnBBSFJ3WGNIdlFi?=
 =?utf-8?B?YmtjK2xFNmRnWk1IRW84cWRwMmN1UmNwR3lFQlJPdW5udWVFK05mbGxtcDJm?=
 =?utf-8?B?dkdHR2luNVd0NEwyc2NCMXRtbEEzVHVvTVVHOTV6U01EL01vTG9oMWlqNHl3?=
 =?utf-8?B?ZFZRNHJheFNGWUplWjZRZzBBSEwvZzc2MU8wVUFqbGE2SFBkckpqNzVheWJE?=
 =?utf-8?B?Tlo0T1k3bkFUTjNWUmJieUlXRlFFMVppQnpyUVVXeUdZbThEZEtYVGRXWU5z?=
 =?utf-8?B?aU55bEZLWHZFTzEzRUdVZTRDRVFWNWsvSmF6NG5MQXNQWTN2ZnRVTGhmSzZp?=
 =?utf-8?B?ZnBCbE9FczkycVNCa2F3WHNVRGNVRllXWHpJSzlrZlpJeEFBbEhDaEpEbHlV?=
 =?utf-8?B?T1ZOSzBQZkpCOFV6VWtBN09mY0ZxMTZJbnZ4NWdzNXJwdHcyS1hFS3pmVXp1?=
 =?utf-8?B?ZDhaWVdqU0xWZjlNS0V4b0J5TVJmQkRSZnZQZ3ZlOXVRSm5vUCs2cFp3NkdY?=
 =?utf-8?B?TTErcnUwRTFpTEFLc1YvYmdDY2dBWjFLZmlSUnZJMks0Yjk5Sy9za0VkQnVm?=
 =?utf-8?B?azFPbkY4cnVmS0M5SFhBYUtwTldVaUpIdzgzUzk5aC85dUJYMkRUemxJUXhF?=
 =?utf-8?B?K1hlcFJXTSs0OEUrTkFDdm9Hd1c3OTRRRWl4MkFJcTJmY3VCZUJQakU1cEND?=
 =?utf-8?B?L2NnRDZ0c0ZoaU1MbURneTYwK29tSGtMTzNCVy9nYUlHc3ovT0dqOVVvMDZ1?=
 =?utf-8?B?RVoxOVY0TW96L3IybGJpbkE5YXFPTWZiYWJ5UXlpQThMWFVpWXlJanhVc3RK?=
 =?utf-8?B?NDNIbHN0WWdqNlhVWlJjRnpWcndJOExxUC9vTVV0dnM2dXJiLytjREZtanph?=
 =?utf-8?B?cHVYQ1B4YXp2U2lWN3F1Y1lyb1R2YXBPU1dSZU1sM0VzcEROSE94bU03OG5U?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a98ec0-30b7-4024-e7ea-08dbd4765838
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 09:48:15.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6odf3AX1hNCC2g4LvCB7TfTzgs2HaVeLDREJLlvvb5A/y74Vq2mPJ7hXlCc+InKr5NohElEfgHwU2BckiMdJFPe/X6d2J9+QEOZFXi33zsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5916
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.10.2023 05:20, Jijie Shao wrote:
> From: Hao Chen <chenhao418@huawei.com>
> 
> Add HCLGE_SUPPORT_50G_R1_BIT and HCLGE_SUPPORT_100G_R2_BIT two
> capability bits and Corresponding link modes.
> 
> Signed-off-by: Hao Chen <chenhao418@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> ChangeLog:
>   1. Change "bit_map" to "bmap" to shorten the variable name length,
>      suggested by Drewek, Wojciech
>   v1: https://lore.kernel.org/all/20231023010836.507078-1-shaojijie@huawei.com/

Thanks!
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> ---
>  .../hisilicon/hns3/hns3pf/hclge_main.c        | 158 +++++++++---------
>  .../hisilicon/hns3/hns3pf/hclge_main.h        |  16 +-
>  2 files changed, 92 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index 99c0576e6383..66e5807903a0 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -881,8 +881,8 @@ static const struct hclge_speed_bit_map speed_bit_map[] = {
>  	{HCLGE_MAC_SPEED_10G, HCLGE_SUPPORT_10G_BIT},
>  	{HCLGE_MAC_SPEED_25G, HCLGE_SUPPORT_25G_BIT},
>  	{HCLGE_MAC_SPEED_40G, HCLGE_SUPPORT_40G_BIT},
> -	{HCLGE_MAC_SPEED_50G, HCLGE_SUPPORT_50G_BIT},
> -	{HCLGE_MAC_SPEED_100G, HCLGE_SUPPORT_100G_BIT},
> +	{HCLGE_MAC_SPEED_50G, HCLGE_SUPPORT_50G_BITS},
> +	{HCLGE_MAC_SPEED_100G, HCLGE_SUPPORT_100G_BITS},
>  	{HCLGE_MAC_SPEED_200G, HCLGE_SUPPORT_200G_BIT},
>  };
>  
> @@ -939,100 +939,98 @@ static void hclge_update_fec_support(struct hclge_mac *mac)
>  				 mac->supported);
>  }
>  
> +static const struct hclge_link_mode_bmap hclge_sr_link_mode_bmap[8] = {
> +	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseSR_Full_BIT},
> +	{HCLGE_SUPPORT_25G_BIT, ETHTOOL_LINK_MODE_25000baseSR_Full_BIT},
> +	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT},
> +	{HCLGE_SUPPORT_50G_R2_BIT, ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT},
> +	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseSR_Full_BIT},
> +	{HCLGE_SUPPORT_100G_R4_BIT, ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT},
> +	{HCLGE_SUPPORT_100G_R2_BIT, ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT},
> +	{HCLGE_SUPPORT_200G_BIT, ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT},
> +};
> +
> +static const struct hclge_link_mode_bmap hclge_lr_link_mode_bmap[6] = {
> +	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseLR_Full_BIT},
> +	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT},
> +	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT},
> +	{HCLGE_SUPPORT_100G_R4_BIT,
> +	 ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT},
> +	{HCLGE_SUPPORT_100G_R2_BIT,
> +	 ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT},
> +	{HCLGE_SUPPORT_200G_BIT,
> +	 ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT},
> +};
> +
> +static const struct hclge_link_mode_bmap hclge_cr_link_mode_bmap[8] = {
> +	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseCR_Full_BIT},
> +	{HCLGE_SUPPORT_25G_BIT, ETHTOOL_LINK_MODE_25000baseCR_Full_BIT},
> +	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT},
> +	{HCLGE_SUPPORT_50G_R2_BIT, ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT},
> +	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseCR_Full_BIT},
> +	{HCLGE_SUPPORT_100G_R4_BIT, ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT},
> +	{HCLGE_SUPPORT_100G_R2_BIT, ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT},
> +	{HCLGE_SUPPORT_200G_BIT, ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT},
> +};
> +
> +static const struct hclge_link_mode_bmap hclge_kr_link_mode_bmap[9] = {
> +	{HCLGE_SUPPORT_1G_BIT, ETHTOOL_LINK_MODE_1000baseKX_Full_BIT},
> +	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseKR_Full_BIT},
> +	{HCLGE_SUPPORT_25G_BIT, ETHTOOL_LINK_MODE_25000baseKR_Full_BIT},
> +	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT},
> +	{HCLGE_SUPPORT_50G_R2_BIT, ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT},
> +	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseKR_Full_BIT},
> +	{HCLGE_SUPPORT_100G_R4_BIT, ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT},
> +	{HCLGE_SUPPORT_100G_R2_BIT, ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT},
> +	{HCLGE_SUPPORT_200G_BIT, ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT},
> +};
> +
>  static void hclge_convert_setting_sr(u16 speed_ability,
>  				     unsigned long *link_mode)
>  {
> -	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT,
> -				 link_mode);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(hclge_sr_link_mode_bmap); i++) {
> +		if (speed_ability & hclge_sr_link_mode_bmap[i].support_bit)
> +			linkmode_set_bit(hclge_sr_link_mode_bmap[i].link_mode,
> +					 link_mode);
> +	}
>  }
>  
>  static void hclge_convert_setting_lr(u16 speed_ability,
>  				     unsigned long *link_mode)
>  {
> -	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
> -		linkmode_set_bit(
> -			ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT,
> -			link_mode);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(hclge_lr_link_mode_bmap); i++) {
> +		if (speed_ability & hclge_lr_link_mode_bmap[i].support_bit)
> +			linkmode_set_bit(hclge_lr_link_mode_bmap[i].link_mode,
> +					 link_mode);
> +	}
>  }
>  
>  static void hclge_convert_setting_cr(u16 speed_ability,
>  				     unsigned long *link_mode)
>  {
> -	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseCR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT,
> -				 link_mode);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(hclge_cr_link_mode_bmap); i++) {
> +		if (speed_ability & hclge_cr_link_mode_bmap[i].support_bit)
> +			linkmode_set_bit(hclge_cr_link_mode_bmap[i].link_mode,
> +					 link_mode);
> +	}
>  }
>  
>  static void hclge_convert_setting_kr(u16 speed_ability,
>  				     unsigned long *link_mode)
>  {
> -	if (speed_ability & HCLGE_SUPPORT_1G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT,
> -				 link_mode);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(hclge_kr_link_mode_bmap); i++) {
> +		if (speed_ability & hclge_kr_link_mode_bmap[i].support_bit)
> +			linkmode_set_bit(hclge_kr_link_mode_bmap[i].link_mode,
> +					 link_mode);
> +	}
>  }
>  
>  static void hclge_convert_setting_fec(struct hclge_mac *mac)
> @@ -1158,10 +1156,10 @@ static u32 hclge_get_max_speed(u16 speed_ability)
>  	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
>  		return HCLGE_MAC_SPEED_200G;
>  
> -	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
> +	if (speed_ability & HCLGE_SUPPORT_100G_BITS)
>  		return HCLGE_MAC_SPEED_100G;
>  
> -	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
> +	if (speed_ability & HCLGE_SUPPORT_50G_BITS)
>  		return HCLGE_MAC_SPEED_50G;
>  
>  	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
> index 02c7aab3546e..51979cf71262 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
> @@ -185,15 +185,22 @@ enum HLCGE_PORT_TYPE {
>  #define HCLGE_SUPPORT_1G_BIT		BIT(0)
>  #define HCLGE_SUPPORT_10G_BIT		BIT(1)
>  #define HCLGE_SUPPORT_25G_BIT		BIT(2)
> -#define HCLGE_SUPPORT_50G_BIT		BIT(3)
> -#define HCLGE_SUPPORT_100G_BIT		BIT(4)
> +#define HCLGE_SUPPORT_50G_R2_BIT	BIT(3)
> +#define HCLGE_SUPPORT_100G_R4_BIT	BIT(4)
>  /* to be compatible with exsit board */
>  #define HCLGE_SUPPORT_40G_BIT		BIT(5)
>  #define HCLGE_SUPPORT_100M_BIT		BIT(6)
>  #define HCLGE_SUPPORT_10M_BIT		BIT(7)
>  #define HCLGE_SUPPORT_200G_BIT		BIT(8)
> +#define HCLGE_SUPPORT_50G_R1_BIT	BIT(9)
> +#define HCLGE_SUPPORT_100G_R2_BIT	BIT(10)
> +
>  #define HCLGE_SUPPORT_GE \
>  	(HCLGE_SUPPORT_1G_BIT | HCLGE_SUPPORT_100M_BIT | HCLGE_SUPPORT_10M_BIT)
> +#define HCLGE_SUPPORT_50G_BITS \
> +	(HCLGE_SUPPORT_50G_R2_BIT | HCLGE_SUPPORT_50G_R1_BIT)
> +#define HCLGE_SUPPORT_100G_BITS \
> +	(HCLGE_SUPPORT_100G_R4_BIT | HCLGE_SUPPORT_100G_R2_BIT)
>  
>  enum HCLGE_DEV_STATE {
>  	HCLGE_STATE_REINITING,
> @@ -1076,6 +1083,11 @@ struct hclge_mac_speed_map {
>  	u32 speed_fw; /* speed defined in firmware */
>  };
>  
> +struct hclge_link_mode_bmap {
> +	u16 support_bit;
> +	enum ethtool_link_mode_bit_indices link_mode;
> +};
> +
>  int hclge_set_vport_promisc_mode(struct hclge_vport *vport, bool en_uc_pmc,
>  				 bool en_mc_pmc, bool en_bc_pmc);
>  int hclge_add_uc_addr_common(struct hclge_vport *vport,
