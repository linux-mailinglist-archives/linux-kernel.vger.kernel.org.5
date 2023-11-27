Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660B77FA03E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjK0NDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjK0NDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:03:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC579B;
        Mon, 27 Nov 2023 05:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701090189; x=1732626189;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7vt5/l1+JSFHAIX3O0PvfJWOzQ62k3pMPCe5HrbZd5E=;
  b=Ncn6fuhyriq5FV8WeghCa3zTWMrmM0kc5xyMcN4YCRVq+WnNr9ERRcf5
   9G1jOZcIwlTXnRW68nMLVy6/UCsvUo/yMkGVXFf7kqGwv5pd+SrxV8eUb
   mbx8k6oz/YGte7U9OYwkA8JtNoTnC6BvTPlrbI9vgYf/Jd/oTjXx0vuPw
   5AILPpxYCrkbW2NUcdIVppG2/Agq4Di4xKO45NDd78lE2Qx4yWhybNC+/
   27HwhY7Dbe2OwMMtyXUE+reLF6ukLYVG07Yfp1FtX94HzV0K4FbPbHfL0
   UMrXh2kwQhibyLuZtIFL++6zM+rrTVDeXq3jSrr56Y3h9R94yQFGXvLaO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="5948235"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="5948235"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 05:02:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="859042508"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="859042508"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 05:02:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 05:02:44 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 05:02:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 05:02:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 05:02:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ehddo5RxwKmNBcm/KoeEd1hfbTpJyVlv+tTu0hFQa7FagRpXK3C/x0noKI6R76q/Rdm6tNXJzPpfBJl0TcREtVJ3rJ3d+5BkaaWzd2BJNJYPdw43LpGyat+lc/pi52SwrEYtXQxtRmiwpySEjtRcvuKppSVgvoW/ATYgym1qic8ZDVF65Gys431VizRtoM+ZtSDKmz0TZBYEAVVwFnoQlw1BfXPefq4Xu8q8utrtnt0oBPQ2h5p1gBPJgITWrwJRZG8cFghzXXbKxLL7dY0nZTzvXsdtBwONYowt1GcbHFsezbUCpXCwCxATywndlUTx845HOX81ltuY9jI1czDQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blHG0mlV13DRx/jBgdK2qaxytfa6EChF3jo2qDFl/ws=;
 b=JfwmXJz6Q+rOYFoVYanjDDiwzDkko5BVMr5ZoxgwVLzaGsa3GMbKoqtM82Nxa2jhncp5iUYqZXwR3VfNgNHyPxuUrXw/THQOHEwdQZAyFt+QRp1YGYyXR6vRUfTyIx5QVWxxkOJrJkWMw+w2i6oPA61hjWzyWGFU6J8MfcTeY7M3nolqSjeawjgkImFqNIV7DvFfKrBqiOPUtoXFTIa4Rm/BVz8kKR28TDUZbv5ESqmbRcJ9NHIeYkzNe8kDKVtylV4zAg41qgPoxp1gS3+xnOw8wPUKRi5YSe8Vgo9DOKtA5c00l3PdzYEY2fV1IU0I2fzNF5V7BNaabZeNxB9qng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH0PR11MB5395.namprd11.prod.outlook.com (2603:10b6:610:ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 13:02:28 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 13:02:28 +0000
Message-ID: <673d222c-52ee-4b65-9dff-0357ed0726a8@intel.com>
Date:   Mon, 27 Nov 2023 14:01:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: phylink: Add module_exit()
To:     Gan Yi Fang <yi.fang.gan@intel.com>
CC:     Looi Hong Aun <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>,
        "Lai Peter Jun Ann" <jun.ann.lai@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231127101603.807593-1-yi.fang.gan@intel.com>
Content-Language: en-US
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20231127101603.807593-1-yi.fang.gan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH0PR11MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: e63c89ea-17b7-448d-5958-08dbef491bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fQPo+z9OMguDoplgvkp4UZkSIxm1ZN1EKK4P/YgQh5gXmiJLfusP3qvRyeUel7yiDHbHUIt4Wr0me5MOkV9C7WAnAyxydujiZX2/GEn/7a3hcjy7QAZMWM4LcdaeWfFhDx+Vw3izaomsBQoFyV/SuG/V6nGmWvcTWgoWNRMTfA8w7Wp6xqm2UcEV988MCTTRDsT0RxGazFRy5BW8dw9ut9UXoIF1cv8Au6WGq7vrCcAkmL4a8KB3098PvoSojiocVf41GZuNcEkoBVTVuZla52zxso05IUWb8Md1YToWe0heWMYwnTCmeD+R202yi0ESy1gsF+oJ397Fz+Z31fJ9vLX8d+NfS8In0/MJfaKDgABt55CtB3iB0pr3qiVZycBSDgnBoBhjm1Fi3Z9nAK9FS5CXx49hFfq2dlRSHStOKZwwkbZfawoe9tcO+c0bE1aLfsCtn21BIKeFSO/avyCxLCHHn8waokupjowVTU7PaLaBGvUoU52/7VkZ7PgSTKlJlWrDwdeRxgJ5JR8DGiGa+RzwjRXf2ju5pfeJwpH4ka0SiQYPb77C9MLDwaBi3dtL70RiWM4RprhR9o8pFCtvidFuLUfs4ePYnM8WuObSYH6Po9I2Q7ycXS3kxHqGu7vi2xASjQIr8qR0+0BS3bepw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(38100700002)(31686004)(82960400001)(8936002)(31696002)(8676002)(6512007)(6506007)(6666004)(6862004)(6636002)(316002)(37006003)(66556008)(66476007)(66946007)(54906003)(86362001)(4326008)(7416002)(6486002)(478600001)(5660300002)(2906002)(41300700001)(36756003)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rkt2VU84VDlvMTlNNGZwZEx6UjNLUWFaYXI2dnRnUnArUlltTUJFRTIzR2dO?=
 =?utf-8?B?d3IyZ2YzZWxTWXRGTWp3aU54Vy9tWi9uUG81QzVvWlFUR29Va1VRZnJnMnBF?=
 =?utf-8?B?anlZMmtHN2RKaHJPS054UmNmSHFNOHp6UTZaRmYvNmovZHhaSFQ3TGJNczN0?=
 =?utf-8?B?NmpmT0dpeHNLNHRjZ1d5YWhndjEyRU1QQ2RSWjdqck5SWTc3bjMrL2phMDNJ?=
 =?utf-8?B?RlZHUE5KSjFybzJFWFhWSUVzc0JjM0R0L0NKWU4xSmhMYkNJYlhZdWZSQUI0?=
 =?utf-8?B?RFl4eXBab2Q5ZWhOMnFHRCtHY2VYTHc1dkZqSGRTc00waU5zdlROWVVQK3Rk?=
 =?utf-8?B?R1pxaGVydjI5Sis5VEllcFhLckJkeWpKbUhVLzN3dllZRk9FL2hPWHNFdllk?=
 =?utf-8?B?UW5XOXFjU1pGVHF6cUxFZ0I0ZTE0TWVTRkR0RjhxeWw5MEpCTDNCMTFRamkx?=
 =?utf-8?B?UkR6WTRrWlo4aUZsVjZjdUs4UXJQcjM4THZsSVh5b0lBd2llR2xTclduQzFH?=
 =?utf-8?B?N0diNUQwUlNPSFJZd2IvbWw1U05CWnF0NmUvVjF5REJ0UUZydUxPY2hvM0l0?=
 =?utf-8?B?bENFZnJwVVArV0xISHcwckpSa0gyeUs4NFZjQXB4OWVPbHNlMVF1dzVJMFFZ?=
 =?utf-8?B?bnIvYUw0TWRQVHlzTXRJYmlWZCs2ODJFTUxKU1UvRjdDQ3R4SUVMZzZhaGNV?=
 =?utf-8?B?clN6cnZiSERONlpqaW5IQUplQjBaMHVrUFN3SXJhc2JRRGJ3Q1ZVckhkaUxl?=
 =?utf-8?B?UmRCai93Q2tNZ3h5TGZ1MVpCaE9CTEpqNWxzSFRZbStWSWRrQWw2YTd6UmJ1?=
 =?utf-8?B?OHozNkZTa090dGRCYmVrT0lOR0s5VGFhaU9zRGpYMUNhMS84SlFMR0E3SjNh?=
 =?utf-8?B?ZDM0aWc4M1B4cTl6Q2xoL1Z0eTc3ekZDY1Nqb2M1bnVYWURPTTYzb3BlWlls?=
 =?utf-8?B?ckQ0Nnk2RlczUmkrWlNjK3NYZExwUFUxZW5CSkV0MUVPamxuNEdEV2pvdXZJ?=
 =?utf-8?B?bzFQR0RGcVBKUXhOVkZPL0R1MUNnYU0rNFBwSXFpZGdGblNZYksrdzcxOHV6?=
 =?utf-8?B?QTZEY3dEUzVhQlBmUHdzOG02RldpL2NhUVBaZERCVnVrUjBPRmJMQWJmUXVE?=
 =?utf-8?B?QlJ5V21FckFUbHpvQ3FjdnM1VzFDeTdGK1Y2aUV5dG9lOTM0aExOWHVHekEw?=
 =?utf-8?B?aVJzVVpXZVZkUU0vOW1KN3V0Ti9EL3FNVVBqRTNHN2VDdnNpbG1FRlRGaCtB?=
 =?utf-8?B?eTcxSHRRd0Y0ak5jekN6cmdJQVo2Z2VvNW40WXRyQzlFZXV6N1A5YmVDWnJD?=
 =?utf-8?B?Q3lqbFNCa0dFQ2pyU1pIWkMwRGlYcGhYME5TbUo4ZUNEU25aeXovZEVxM3Yy?=
 =?utf-8?B?eERod2F1NkxMeXZlWDJ6dndZZDhHQ3U0bno4L0wyditIMytQR2xDZExzYjUy?=
 =?utf-8?B?VG1pUVB3QzNzRmdEMmVtRDJZODd0NGlneHgyemZyZitHTEpmYWMyN01NcE11?=
 =?utf-8?B?NlYrSG1SZFR0dFM5a1U1cVJSNWRweHorQ1gyTTYzK1VkNGdVWHJ1OWVjUzgz?=
 =?utf-8?B?bEZiV1N5aUNaUyszQlFqYTV6M2FXa0Y0ZjBqVGxpWHRJSUErYzJPOG1maUdq?=
 =?utf-8?B?MzE4VUIyV1VLcDFuRS80ZmZkM1FZNHA4UnE5QXNPRTkwbWg2MlNtb25pWmJW?=
 =?utf-8?B?bFNhU1NoWGN4TWRRYVI4RjFIVWF4UTBZMnJLK3loN3hWNGRucXMrVk9MOFRG?=
 =?utf-8?B?a0hpSHk4OFJrRnlXUFQ5Vy9neGhEazQzK1UxTFFCR1FzU20xNEd0bmsvVW5K?=
 =?utf-8?B?Uk9lajgySGUrYjh6TjBaeXZaaVhhb3laa0FDRG5McmJqemxlU1V5OFVXclA3?=
 =?utf-8?B?amZQNzRKRkdmN0VSNUV2QUtpdHI3Q3Vsb04wcjRaWU9HVlhYWXhWQ0c3d21z?=
 =?utf-8?B?eTVKME9ycVFUenNvM2tNLzdwZjFIZlU1NUYzOXg4ZnNzejByZDNpL0xNdW9F?=
 =?utf-8?B?V1dpbEFjV213Y1hscjZCN1ZaQTQvK1dEQXBPYXRvOWlUM2VWOC9Ld2FZNkVr?=
 =?utf-8?B?UERkbTljSGJSZUZWemdsUmFkYkZ4OEw2RUJubjI3VFVQZXVzbmJUYnYvbURj?=
 =?utf-8?B?NkZwODRDbU1SZTdDUGo3QW52SzNteU14elVpbmtwTWp1N3RPQkNScUVBR09P?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e63c89ea-17b7-448d-5958-08dbef491bfc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 13:02:28.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+twXevOjVU1RpGQX9gNvAaLcFcNrvhIua8wU/G1+Vef5Qy2UDlHf/cpbhMPd8Mvf5dn+McInA7jDJM7SvlZXo4nZ0QpuqIOV95L9Pfw7Nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5395
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gan Yi Fang <yi.fang.gan@intel.com>
Date: Mon, 27 Nov 2023 18:16:03 +0800

> From: "Gan, Yi Fang" <yi.fang.gan@intel.com>

Please fix your Git vs mail client settings, so that your own patches
won't contain "From:" with your own name.
I'd suggest using "Gan Yi Fang", as that Intel's versions with commas
(,) aren't optimal for mailing lists and development.

> 
> In free_module(), if mod->init callback is defined but mod->exit callback
> is not defined, it will assume the module cannot be removed and return
> EBUSY. The module_exit() is missing from current phylink module drive
> causing failure while unloading it.
> 
> This patch introduces phylink_exit() for phylink module removal.
> 
> Fixes: eca68a3c7d05 ("net: phylink: pass supported host PHY interface modes to phylib for SFP's PHYs")
> Cc: <stable@vger.kernel.org> # 6.1+
> Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
> ---
>  drivers/net/phy/phylink.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 25c19496a336..7121503c9259 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -3724,7 +3724,10 @@ static int __init phylink_init(void)
>  	return 0;
>  }
>  
> +static void __exit phylink_exit(void){}
> +
>  module_init(phylink_init);
> +module_exit(phylink_exit);

This pattern (empty __exit function + module_exit()) is +/- common in
the kernel. How about making a macro from it, just like it's done with
e.g. module_platform_driver() etc.?
So that you could just add to phylink.c something like:

module_exit_stub(phylink);

>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("phylink models the MAC to optional PHY connection");

Thanks,
Olek
