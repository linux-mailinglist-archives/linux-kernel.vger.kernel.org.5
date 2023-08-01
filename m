Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176D776B604
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjHANjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjHANjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:39:13 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A04A139;
        Tue,  1 Aug 2023 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690897152; x=1722433152;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+TO5e6Us4EAz5kJeqnEB+U9+E4e07TBxdxvwJE/zpUU=;
  b=RovEBeZ4WM4of4fh+rVv/hOmCK41wDziqwcD8G1yosHiL0YjHNDFHYsk
   +xHEB5YyBI3W2K4ApTgnlOoFowV1Vqjo+BAPXve9PIFUE03qR+ULbu6cr
   X+MP0as0RTxTz6RWEf/uuH7/isIxKTzxqIUTarGNGQxU4VLkdpQfcCqc8
   vZgHaWgUktyOTxLv4Gtud1aQcjj0dZdUuI9+mA9YbCoqXiZsmEwxCuzjH
   6aI2K26UHPVr6vGELbEdfp3q+WAiSeBb8ELVICJHA46TB3BVj76jsjiEI
   surC9f7tmDAASWYI7UjIW+X8DNaXG9rPwqfokGJsOIScYlIzFJPS6FOz4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455674476"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="455674476"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 06:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="1059404660"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="1059404660"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 01 Aug 2023 06:38:24 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 06:38:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 06:38:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 06:38:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vl2KXiLtU0iXzt2LJ1KnMj0/C6YxkIhsG1xDj9T0ke3WDl4v3YuhT9OFi40Mhu/A1aZnHugVPIlsxTnGWIoKzFfPhmmf30sgafERC1Y0cVuoEbj0z0N3MiKojjMJPWf0slknZNetjq9K98mE9CoKGlxXWZmGHAgAQ5LH7QYVf0iFn+z+4byXY00BSOyyPDOzEwaM0BFXq1tkPvNpUArcicOVt/KVUf2eUNUNiXGEBP9N6OV/zKOAhp3XTAIfCYh/Is5s1PZqG2BxJUxGHV2ZKTZeyvWGwl+O14VSMdceRIn3Gi3dKIfhCIlE0/yWzi3whVVlvy/rCbol0NrQEkJ8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb6ocbmU8xOA5u2Gd0I6md2ga77d08wx8ECeNwr+oOQ=;
 b=gTHietDiZ1Q26DDJ63kX97/BQn/wAYY2jELFY/OHPkJjE/m7M8spGL2AHen83iOOxXH9Z9Lb3cubq5NRb6Iki1OhH0z5UPn+eWjAV6m3Nbf8kKr8HnLzvjAvwy3H69XHHvWeHFzSBX4vsZJm2FXg0IHVYWhSg4puJGJLEIztRYUNv2ew0axeiwBCKu41sPADwLXQlV738FaDSWKmsjjcgy/JcV/98ns9fOsJMWTwg6b5hFBZhe61fP9scREBBfNQ6d/uhpAGDdXrazQZmNQjQvAoL5QBXyrd/rXlNH2gX/59euWVNiGc3taGynSXAyw3JQV0WtA5IGiHcBQ2X/8Rtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH7PR11MB8057.namprd11.prod.outlook.com (2603:10b6:510:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 13:38:20 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:38:19 +0000
Message-ID: <0fe906a2-5ba1-f24a-efd8-7804ef0683b6@intel.com>
Date:   Tue, 1 Aug 2023 15:36:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 5/9] page_pool: don't use driver-set flags field
 directly
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
 <20230727144336.1646454-6-aleksander.lobakin@intel.com>
 <a0be882e-558a-9b1d-7514-0aad0080e08c@huawei.com>
 <6f8147ec-b8ad-3905-5279-16817ed6f5ae@intel.com>
 <a7782cf1-e04a-e274-6a87-4952008bcc0c@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <a7782cf1-e04a-e274-6a87-4952008bcc0c@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::6) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH7PR11MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f06d3bf-3c49-43fb-d23e-08db92949188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +qsa9iqcPmaoMauqcaeB4DIMggQ5tB2cFOSAVOFVeVq2MnKNY+Ca5hUc7Y3coCStkVrxmcAkufK4kXyMxRipjS7XeSCxqh86K3f0qqQ9zvZ3OX+mYaueiCC5/loHach4m950MAZUumeUMgIxo797mr3OeJI5ZieK2/ncD3HbDhcMtwqvEWDXvjkqqJoYYpMaCzP8I3L9XQJ0fSb1/nZtY+HZ8/ilP3dCpKu+4WMUhRFBzyTURh0VpNgRVrpDMn+3b8/ETJ49H171YJDnBupfWh/dkKnCvdtYQXsu763nbc12IeS1cob8tfJuAwENYFpb2dLgLdLRD5ZIaCp4tnRBVECXwaMbbGY42+HzCTah72IgR0HmMXbxI1xBZnvvB3UwAPlTCGF3D/n+C9pWh0+9HBd3Ct4E6Iw3BG6zdPN+3QiGjv0Ks7ZDKnjT6pd5XJCYFXPR01qW3zID5cEUuzrNM0DRlpfKBTvAoU/U6HPsQGFLZcw/gktog1/i/kTfT8TsGM5pPpRR+kg2Oqq8hVGxr/9cZdVlS6vXflCQbT4lc299ob1TCts8oe9spsmJIstPFz7yIASbes7b+qu8xByOY9DphsCr/Z5txgFTyHiqv1hGDNu2g7Ec/wpzcMA1q7KE2Y74EF77vviJdNkEt4Ergw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(38100700002)(66476007)(31696002)(86362001)(8676002)(8936002)(31686004)(316002)(5660300002)(4326008)(6916009)(54906003)(7416002)(66946007)(66556008)(82960400001)(41300700001)(478600001)(2906002)(6666004)(36756003)(6512007)(6486002)(6506007)(26005)(83380400001)(186003)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnV6MlJDU2ZpbDVCeDVUVzFpTlZCWWxzUFpKb2ZBQTJ6VVE0V3ZWMlV4WTdX?=
 =?utf-8?B?YzJaY1pidWhaR2dYMjE5YzhjQTNKZEVUb2RpeFIwblpxNHdjaFVIaWtQQy9R?=
 =?utf-8?B?YTZIUlR5Rmk1RjVYZFhVRkg4enFjTWFMYTlLbFBOVmw2aHZKV0ZGVmxuRHFx?=
 =?utf-8?B?M1Fpc3U5S0Z3VXJNQXd4T3VsS0xuWExHbmNZaXlVU3QrUmlNS0RORnZLTk52?=
 =?utf-8?B?YU83Q3JuRUN1T21GeHRBTlJhRXdsVkVXNzJkQ2NuWlExcVZpT2syeWRYampL?=
 =?utf-8?B?ODlOZytsRUFWVUVFSm5wYXJ1dDhoMUdXbjIxYW5EanlPQmpXakFvM3lYSkFJ?=
 =?utf-8?B?RktRbnJqUW1LRUpmZ0Y0cHVJYnJpelhsR1JhSzBMUmZTcUMzbzFmNUhZaXlw?=
 =?utf-8?B?RHZ3UjhDUHR3cEh6Nm9VblNBOUtNZXRRSEI3dkNlSEhzekNJK0RkWUlCdUFi?=
 =?utf-8?B?U01LUXdUaUlQSTJsNmd1ci9mcnF2cVk5S2wwaVZlWVZnckxkSFhQa1p2VVNS?=
 =?utf-8?B?b1NqSlFGd1NsWDZJTldEdXFNN3FnZTk3c3hMN0tnc2t6azUrL3pNc1BnMG91?=
 =?utf-8?B?R2s1ai9BV3FsOVhHQ09OZTVOZTMxZldHRUYyZG5Kb3NaNkVQWnVkM05lKy9U?=
 =?utf-8?B?eGtNc0xkZW9jaW82TUdhMnhXS2FYMTNZb1diaXI3ZzVTa0NEYWJNYjFKTkJr?=
 =?utf-8?B?TEtRQ0MxZlNTOW50QWtpeXJyd1h0VWpacHhTdEJlVnUxV3hBZjUvcmtXNUZq?=
 =?utf-8?B?MlJBOWN1ZlBaRjFEdUFCcGZyTmVPdlN6UUp1aTl3bGNGSEFvTTdhZEEreTZE?=
 =?utf-8?B?RjFaVnhUR3hJcVk5cUtWK0huYURGUFJTdFR0QldYamFVZ28wWXVBWUZhMWsr?=
 =?utf-8?B?bGd5OWVnQlJndVd2ak85N3RJQVJDVXpQWWc3NGlDakZsbUJBNkZ0Rk9TNkhX?=
 =?utf-8?B?dEZLbjZkTUF5MlQ5Tlc4cWdVckVjTC9zekZQdHcvR0Q1UEZmd2VtUlFZK2NB?=
 =?utf-8?B?SEU3NkcwOU90VFVSOVpiUmhLRTZua1dmcHAyWlMrUGxQUnJaM2piNVYxOXBk?=
 =?utf-8?B?U1JmaE9hSjdkODE0N1ptaUlYSFJwSmhLc0k3ays4Z3kxWUhwR1ZEa2xDaXl1?=
 =?utf-8?B?eHhua1hzK09xekpBNERNa2M5eFBraUdINjBCcGc2c2FoSWFGSm9WRFBMR0sr?=
 =?utf-8?B?RUdnWThkUmdRWElYelptTndwZTZiY1cyekp1S3JTbFJDN3l6SWczeUNPRjVS?=
 =?utf-8?B?YnIxMi93aFZkeXp0RW05VGwrRUd6ZzZROTlVL0JwSDUxRS9WeklXQlUzZk0y?=
 =?utf-8?B?dTY2RE9CdVl3UnlhTGlHbExUdXdsZHhHd0NTb3Y5UEtWdUpvekZEQ2lCWUgr?=
 =?utf-8?B?VWppYncyWXVvdVpBbmVhZkQ4VzkyeW84S0JZU2JBbnMvajFSa1Jyb1pVV0NC?=
 =?utf-8?B?V21JNlJiS0tTNWlNclZCU1RqcTdzN3RvWCtmdzhVWnRybkNqRWNLa2dEWm1F?=
 =?utf-8?B?RkJGTmFMd2tzYXZqVGFYdWdueEdvNjcxOE5qcVN5NjA1ZWQvTHBEbm5QUURw?=
 =?utf-8?B?cnYyRS95VFJEQnhtWGVEM1ZwV0NtWnZBSnJlcjRsODRSVmovVzYzRGpsbzM4?=
 =?utf-8?B?UXJaMFFPSTBGN2Jta201cHJ5YU1oTzVXVW5wc3ZFeWtXNDVpN3Z0ZDgyL0h1?=
 =?utf-8?B?azlNOUtvRmMrT2tabkdReEZBenBWSlZnUFNLWGN6NzVucXM4YjB5c0EwWVF2?=
 =?utf-8?B?TkZUWjcyNjMzcW5RU2sxRjdKMFJJNnY3RVBrVG5qZTZsQXpvYXlZdmJYczFh?=
 =?utf-8?B?aTlTNWJkeWlIZmQxNURMa0Q0ZzVUMVgzeElXbVAwaVc1R0tOc2RxVzJpZ3dS?=
 =?utf-8?B?dW1Jck9JYkliWXBKK0JueWNyWnU1em8yL2ZkYThQdTk5ZDluTFNHa3daZk1K?=
 =?utf-8?B?bjRqMUVXR0x1Ull1VzRWc01XQ05Lb0dJc0hONnZmeWR4U1c4RkhxeDM3dWVq?=
 =?utf-8?B?TWVDSFl3NGc4dE95Zm9HWEZWa0RVT20rSlU5ZUoyNGVFUnAyOU1zRnVPSnVm?=
 =?utf-8?B?bVZuazRnaUNYbVhLMnN5cEoxRDBOYXJyV1Z0Rk9aMVU2TzZhMTFEV1RSeEtu?=
 =?utf-8?B?SzM3QVdlNUczNjRpNW16WDVJRHhoUVZmNThKZyt4bkd1YjEyNXB2Y0JGWDEr?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f06d3bf-3c49-43fb-d23e-08db92949188
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 13:38:19.8666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4wOgvY0rxg2ddXypIKEzCREmbj+5SoPV+fbQ9FUAwFOqsG/pAEUzxXKNp2Yk3+B/8QD6Kpr7gJHPh5Wxkfomqb/4m6KOqRtKHB75Sxc8HU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8057
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Sat, 29 Jul 2023 19:40:32 +0800

> On 2023/7/28 22:03, Alexander Lobakin wrote:
>> From: Yunsheng Lin <linyunsheng@huawei.com>
>> Date: Fri, 28 Jul 2023 20:36:50 +0800
>>
>>> On 2023/7/27 22:43, Alexander Lobakin wrote:
>>>
>>>>  
>>>>  struct page_pool {
>>>>  	struct page_pool_params p;
>>>> -	long pad;
>>>> +
>>>> +	bool dma_map:1;				/* Perform DMA mapping */
>>>> +	enum {
>>>> +		PP_DMA_SYNC_ACT_DISABLED = 0,	/* Driver didn't ask to sync */
>>>> +		PP_DMA_SYNC_ACT_DO,		/* Perform DMA sync ops */
>>>> +	} dma_sync_act:1;
>>>> +	bool page_frag:1;			/* Allow page fragments */
>>>>  
>>>
>>> Isn't it more common or better to just remove the flags field in
>>> 'struct page_pool_params' and pass the flags by parameter like
>>> below, so that patch 4 is not needed?
>>>
>>> struct page_pool *page_pool_create(const struct page_pool_params *params,
>>> 				   unsigned int	flags);
>>
>> You would need a separate patch to convert all the page_pool_create()
>> users then either way.
>> And it doesn't look really natural to me to pass both driver-set params
>> and driver-set flags as separate function arguments. Someone may then
>> think "why aren't flags just put in the params itself". The fact that
>> Page Pool copies the whole params in the page_pool struct after
>> allocating it is internals, page_pool_create() prototype however isn't.
>> Thoughts?
> 
> It just seems odd to me that dma_map and page_frag is duplicated as we
> seems to have the same info in the page_pool->p.flags.

It's just because we copy the whole &page_pool_params passed by the
driver. It doesn't look good to me to define a new structure and copy
the values field-by-field just to avoid duplicating 3 bits :s

> 
> What about:
> In [PATCH net-next 4/9] page_pool: shrink &page_pool_params a tiny bit,
> 'flags' is bit-field'ed with 'dma_dir', what about changing 'dma_dir'
> to be bit-field'ed with 'dma_sync_act', so that page_pool->p.flags stays
> the same as before, and 'dma_map' & 'page_frag' do not seems be really
> needed as we have the same info in page_pool->p.flags?

Not sure I follow :z ::dma_dir is also passed by the driver, so we can't
drop it from the params struct.

> 
> 
>>
>> Thanks,
>> Olek
>>
>> .
>>

Thanks,
Olek
