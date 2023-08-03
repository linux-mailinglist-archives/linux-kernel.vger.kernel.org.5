Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C4176EF38
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjHCQP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHCQP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:15:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF24A173F;
        Thu,  3 Aug 2023 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691079355; x=1722615355;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9Bae0d0hdmI3C47PmNTrZcFaOsx62EPCMajSVqJQZp8=;
  b=ZaML1TYCBdRKLQnWpkaFtctyLNdGCHfQjCjEqtdYwfStbg8L0MOzQBLJ
   ZDMFhcqtOKdpXqecpIaYtK0BjYoHJSmmMaEtcBZQjiNzrjGlVGDMzgye3
   45tEGa3OWTsoYJD2pzzeuQcUimzsdRau86fOVnWmviVtHWVBIsPWH2D8H
   E03eo3UP69OO+HnnLV+OkYE3BYcCrsYvqZqAgE2440vjh8KFT8c3Wu4aC
   u8gEGg97/ScKaO9kAyCpRv1DWnTneFbdN6QD7lljg5SFmj9F5mrUUzPpb
   o/SYrMJDyYcCaq+Nf13WOUMjjBGG1uhaZrgnJaBaz5eyHmpzhJSD/Hc8W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="369916707"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="369916707"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 09:07:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="679525948"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="679525948"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2023 09:07:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 09:07:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 09:07:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 09:07:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLUKAfInnKh42MzZsVX9N8opLfTR7F/oET45UKlcJbigVbz6vZN/PKI5B7taX3P9X4GPzlkZhID4rt8to1YIFcFAkP/hbsire84geaPhbgjKprxiIencsMAbM0V4NiF22axzuKUMYAAFhpgzX2uTn2sKD8M7XbujesVkaSI6irRrrivWX6HuPmp0zbYMpo76yWYgkmWAN+4HBQTmLi09Z2zzd1xfL71Oxf3GOKD46q8muUdGJO91UhePmN5OQuQguzJEILQoFyHxq4NiaIsYfQ1WHnbnMiVNj6zAP2fiFOFLWEEoU1yS3NsWFK7QVgK3WjVeJjISn2zLf0+vnyyYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+9bbg3PQAbSgvz3APHp/vdeuqaXUs942ymPbMl4PIE=;
 b=Hrl/HuDDw5L8Zbn5bkZhoBV9SldpOZlg8ROKMUJ0g9pVnNEfVjH84qzKi3abtmCalOun8I1FmparzyLR3JbHR/o+QGGzTkca5TKwq91E6t50OSf2rzBco03xJvEOc76GKH1BkFA+yyYyCp/RzhXp8zEKE4592AkBVBhbH2b6Jn9MaghCL/OUy9v8jIdGdUTC65Z957PJDIfgP64zArYzHi8w2SjSIG/SirOz6fNG27oxNSHs1LJDT5A5YCfJQGcYElE1bn2WWfe7f+phqMtUz2Y0XoCGNifGzaMcZ5aKeZzCP4OsB86vPFYSGwiS+RNCj7DDE3NjDGZfnpiLe/kCBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BL1PR11MB5336.namprd11.prod.outlook.com (2603:10b6:208:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 16:07:30 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 16:07:29 +0000
Message-ID: <7c1c6ec2-90cb-84e0-1bc3-cf758f15e384@intel.com>
Date:   Thu, 3 Aug 2023 18:07:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 5/9] page_pool: don't use driver-set flags field
 directly
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Yunsheng Lin <linyunsheng@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
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
 <0fe906a2-5ba1-f24a-efd8-7804ef0683b6@intel.com>
 <20230802142920.4a777079@kernel.org>
 <7b77dd3a-fd03-884a-8b8a-f76ab6de5691@intel.com>
 <20230803090029.16a6798d@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230803090029.16a6798d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::14) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BL1PR11MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 67570e5b-8a1e-47c1-3bc0-08db943bbca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3e1C2v6ybK6J3EmVJNR1YHjweluZc5MUVhDCA4+pA+hLy9fj19nbnjiP/8VRzRaFh82EUe5CPSR+2F20iQTO9RxVOoPXqWIHE4hQIc905Vp+qJPmhaMyXwoAVDnW6cTtTRvh/FtWxEker6zXqMCJlaeN0l/GmnyIDPwa3D0y3CrWqNAqe/tbNpuNLCkf/PoqD3bhLmG+4JE3aS0DyBwOyJ3yXIVrxNh9AQ5BMPseoe1AAfsnvSr0smj4ZtcdVfCvO80aa+xullnQDUhrqQYIRtIPw6qHtn6zORhKCFgxCiqmIelq0owZoX2HfPXjX6oLFUW8+x9FcuWvst1VDPo9C8Cuh1PydMJht/yIIB42eFpW1FaATs2rNCz2WK6fMWXCpk2A4QbmGCLIVuk2RkUytS6brN2rtgugCCSrDZuJCtcbQbmBb+3kMLjjZtpg+W6gMTM+0yuqc8ySZ5s65Y4taR9uS9etJD0bwPbk2bgjYs+BkhpZjEjTTMhSG6yWpXh3Ae/tFLaGouHsaCB+TV9+xrCb8EDZr8bFnvq8usvDfvbLMxrmSlLCE+YoIYjsOnS7lr7efjqZltuz6TSYEu0htY/1KTTi8UL2nqz0E+JhZdhQMhK6A7v3yRUPrPGwhSi3VT/6sEYWg7Xg2r/9yF6Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(4744005)(478600001)(31696002)(86362001)(6512007)(6486002)(36756003)(6666004)(316002)(8676002)(8936002)(41300700001)(5660300002)(31686004)(6916009)(4326008)(66556008)(66476007)(7416002)(54906003)(38100700002)(2906002)(66946007)(26005)(2616005)(6506007)(82960400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkxsS3pDOVpRZjlLSHFVWUxhNmtIejhRZmg1cjRUTGt3dVhBTDh5NnBEUWt4?=
 =?utf-8?B?Q0NydVJpaFYyZUY0RzhsQjZlcHRpYXVKRkF1TjlON20zUjRCckp1NnNYVm54?=
 =?utf-8?B?dEp4dVA5eGxKNGxMMVNQRTdhTEdUeEkxSm9NU01FTDd2T25NeDF3NS94NFpk?=
 =?utf-8?B?dmlxWTYxQmdjQkpOdmlnT0w2d2FsQ25SUW1Ba2piN0pSNmZNY1gwS1BMcmlz?=
 =?utf-8?B?UzR2TE40dHlEdUVud21jT1gwMnZ5NVB0VU5oeVVuWGpIK2F4L2UxZ2dKK0tG?=
 =?utf-8?B?UW92Q2s1OUNRR3hPWGlOZExMNitMb2lYTjdmcmYyd3YvOFl5NHNiUlRjVUYv?=
 =?utf-8?B?a3pVZEtBank5RndvUnBmTXU2Q0ZVMko5M0k1Ni9pcDRxL2lXdTlOaFNJY09m?=
 =?utf-8?B?WWgySmdoa0FuN0JwRXRHRUlhb1Q4MERCWVJBenJjU0VZMmxVTjBqSkNQR2NY?=
 =?utf-8?B?MTloaGttZUpvWFNjc3dLZHFLNzBRY3g4bUpFS3FFVkRaWGpPcCtBRXd2UGVi?=
 =?utf-8?B?OVhiR01RNlhoa0ZvZGd0OEJkVkNqd0ZrbmNjVWo3TDYwYnUva0NYNGtkaUhy?=
 =?utf-8?B?OXBNMkU0cnA1anRRVHlNM2xRVmx6SUx4dTlKM1pNTk94b1NURnE5YStTS3dV?=
 =?utf-8?B?cGpoMHM2bi9sdmFZZE10NTVhZTlPOXJEb0dndEE5YWp4NVplRjBmSnNPN2gw?=
 =?utf-8?B?TzFBR0hCZjJrWk1rVmt1Y3R6NlpvOWgwU0gwK3dHYzkyTHg5WnArRG5nNUta?=
 =?utf-8?B?cVJGT2MzL2p1bkdSWUdSanc1ZE1IYzFWZUJDa0RjUnhrY0YreEljTzd0ZVA3?=
 =?utf-8?B?RjNYR0tyNVMzS2J1NEdGUXJDWWhzbER0OHdoanlic2NyeDlUYUhiR0hGc3Uw?=
 =?utf-8?B?MUVYMUxzREFtL1QzRDlWdlVxOHJZKzBQOCs2RkRIV1Y3MDIwWXpmejZQaXZT?=
 =?utf-8?B?Y25yeXVTUjJWMjJ3cmc1VCt4SnkzNXllVzFqN0NCUVBKUllva2FLVjRIRjdZ?=
 =?utf-8?B?MzdDdERqMFQ3ZXVvVDhnME9zQ1J5NTBnbXQzdE44UzB2NlY2bitKWkVxbmVq?=
 =?utf-8?B?NWpRNXpNM0VJRXlLMy9sdGQzRU1KUkZRT09kZG1sajdXNml2Q1JFK1diUjJY?=
 =?utf-8?B?SU10Nis2OUZLczVMQk9nblMxRXI1b29WRlN0TjFBSFJxNHM3OUtybzVxckNt?=
 =?utf-8?B?SDZEUTVvZEF6OGVaSDd2T0VwU2x4eG9WUkNBTGZYdGJzUDQ5c2NQSGFqWjhh?=
 =?utf-8?B?U2ZRNVFxMnRHYUNEcTVHQlcySkYvdGEyYlNxeEZTODgvWml4N2RkdjNaZXBY?=
 =?utf-8?B?UEZOSDRQZEpXemVJY0hYM2E3aUZpc3BqSGlSK2pIVDFOYmxkTEFZaFA4RFgv?=
 =?utf-8?B?dmk4L1VIWnpmQ2NxSTBuYlhxOHczVVQ1U0lXRWNuZVFoZldibWpOQkxBZ2la?=
 =?utf-8?B?YWYzOTROeWhwcmIxK3gvREZ4N0poR2k4QUdKaTdPb3VzOExRdnFEeCt1M0tr?=
 =?utf-8?B?NitXSDR6T2JrR3ZHUzhJZVNsRDdFOWYreG1KSVd5aWhMQktJQ1cxd0xZUzQ3?=
 =?utf-8?B?UXBiY25OMmJFdHJjTkNRZ3pwTTk0NWVjc0ZCS2w5Ni8yNGdma2FwV0tFRTV2?=
 =?utf-8?B?dVgzK3R5T0U2UENSekZrNU9zNzJzVjVsWHczY2NpN2hCdkdkOXpzMWVFMDYr?=
 =?utf-8?B?OUVPSVdONFlkWEZ6Q2d0aGJLNnk3bjBPdkZLOWsvYWNMem52WkpFZWpFaEFz?=
 =?utf-8?B?Znhhajhtc29ubVJ2bjhvbXEwVmg1KzhhVUZGMlo0NmlVdGgzaWJEbVp0T1Nw?=
 =?utf-8?B?YU44bFlGSFh6YWxoZU5IcStKc2dVcDA1RkRsOEhIRVliZWJXUHRaYWE0Yytp?=
 =?utf-8?B?WVpNUTlieHhHNUVzYVZLZm1sOGlNSzJxYUxVWWpVeSs5MXpEbGF0MmJKcHRG?=
 =?utf-8?B?UnZpb0ZUY1d2Rk9kWm9NcHZlVE54d3FuZWpsTjZkeUxadWh0N01mc2hmaWg4?=
 =?utf-8?B?QjJ4amcyNSs5VGF3RW42L2dGRkZMZlJvWVAzTmtkY2xoTmwxWUQvcmNoVDRT?=
 =?utf-8?B?SFFGVjhBOVpheVVmRVBOU3ZyQ1pVQWtld2d2aWlyUVZLbWREQ1RYR2V0bXJp?=
 =?utf-8?B?NTR5ZlNoRnR6YitiTGhxNERLaTFZK3MzVWlpYTdIa0hvWHlJcTZuQU5xWTk0?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67570e5b-8a1e-47c1-3bc0-08db943bbca9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 16:07:29.5218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsuJK1CAS3j+7jfnM8ewtrVPFuKDKvSS/t1Xq7AYrqKKDwMKM14iWkI3EIrqNM/4wrZmcaFn8+H1nx4MH3xs4kDMRoQtszQfhgK6sYY6lh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5336
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 3 Aug 2023 09:00:29 -0700

> On Thu, 3 Aug 2023 16:56:22 +0200 Alexander Lobakin wrote:
>>> FWIW I'm tempted to do something like the patch below (an obvious move,
>>> I suspect). I want to add another pointer (netdev) to the params and 

[...]

>> I would propose to include it in the series, but it has grown a bunch
>> already and it's better to do that later separately :s
> 
> Yeah.. I'd be trying to split your series up a little to make progress
> rather than add more things :( I was going to suggest that you post
> just the first 3 patches for instance. Should be an easy merge.

One minute before I was going to post v2 :>
Sounds good. AFACS only #4-6 are still under question (not for me tho
:D), let me move that piece out.

Thanks,
Olek
