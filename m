Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF07773C19
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjHHQAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjHHP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:58:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1C65FFE;
        Tue,  8 Aug 2023 08:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691509459; x=1723045459;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UGwAEGezvBseugrWI3RSnOSzJU0EupbINpShiPttMMg=;
  b=Wtnfn3+A49KI6fR3FjNBZHt9TBUkPB4um8o8V1Rx+TiYDEGY1aDfLL0J
   y1mtL0ri0Lr9/mUu7uHK5g6LoWOwbFHmFY5rd9BAkfK7QyoxU1UDTUTtt
   uTQypdkMKPjOqafNTHSPfHTTtLEJhjiJlJtvK7SZT4cwxn1G8iq5y6yCs
   0Be7Kq8Ll0AwRwYVAsUBqC1g1IfE7NTMRaGTuiQ2NHePDK7DLGevu28L8
   dmM3Aosr6AfBiCp8SAoKeGXx9YdWqjd/2ZYmsn6JTeQh81gRkbMpt59ye
   zOWW4xclyifQu1tSk94YOvVT1djF264HfbWwsCU/0aRI9nbbFDF7gbAUT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457216234"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="457216234"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:59:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821376708"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="821376708"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2023 06:59:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 06:59:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 06:59:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 06:59:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IR/KujB+i4SEibWPnh6NgqzUn/Gons0CEVRKslYiarWplGJj/OTc8J4srt/mwaRCv9/fvieKFgspTICfxK+iDsjmpMzx/h/PKmLmENR+UU0nXYZOe/UGyQ3MCzIBdf8dYKBsy8FttYUv3lkK/vjT76vgwa2pbpDYOM/0kzshO534URl9zNeu8+IJfacERJl6VBuW+mr6BDO+aRiz99ju564C7BhqJIh6IQQf8jtsGWyQJL947g5gTTLWM4uIhfi0N6eGNFn+SmymtkbJnDl/Gd4tzy9TndzVW3VISGTuY46LdFUnCBm8GpdrGYNonMrCeKeHiFVKS15EOyYRVyMeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=It760hOigrDn4Axm3w0cpBfj4f5M7D47dGF9l/+4mxo=;
 b=d1PiAE1ukK5/sLTb5ddnIk3k9DrKYaPr7TOex8U2YCB/z27hkLjeIccN9jSI+cDXWH20EJbrpyBv0Xil+1RaXYnwTu42/qNypebHzLEjWMFFAzC+LI5fkt+fgqQfv6Eore0ussNQBb9os5o8p8uudDAkLFOOSCdS5yhxBmcQddzwuTFA1E4TFqmN8SZwimkUy4JEiqQyyecDUtN+Oj+zYBf6foq5aHpbQW4AcRl7Hx0ONH/ov12ctobie0k4HbEqUaTkJiqz4QbLDWk96xrRwDBldAAegISYrYwR9t0dezpIaQ3/3DwFZxZBJ7Sg+GZBxF+zZukrV2I3Cj9/0xFgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM3PR11MB8670.namprd11.prod.outlook.com (2603:10b6:0:3d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.26; Tue, 8 Aug 2023 13:59:02 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 13:59:02 +0000
Message-ID: <ca096c35-6ce4-6c1d-7e26-a017348f6ece@intel.com>
Date:   Tue, 8 Aug 2023 15:58:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v4 5/6] page_pool: add a lockdep check for
 recycling in hardirq
Content-Language: en-US
To:     Alexander Duyck <alexander.duyck@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
 <20230804180529.2483231-6-aleksander.lobakin@intel.com>
 <692d71dc8068b3d27aba39d7141c811755965786.camel@gmail.com>
 <601c0203-ee5f-03a3-e9dd-fdb241f3bcdc@intel.com>
 <CAKgT0Uc0pLzaOfqFbvd9jFErAbTbsUMNNw5e_XY5NfCnO0=g0g@mail.gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAKgT0Uc0pLzaOfqFbvd9jFErAbTbsUMNNw5e_XY5NfCnO0=g0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::14) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM3PR11MB8670:EE_
X-MS-Office365-Filtering-Correlation-Id: f279a28c-7e66-4e84-c094-08db98179ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNiSrp4yyyrbkcQmLqkY6irvn09hLBCf+xhecwU0Ufh30LfP7qEYCmCHdGi9TK6tgbsNkV9FA6nppOCzqAmd+DYQ9pIdgLg7m07bmZEJfMJmWpnJvpNOBCa1fNHbY+jNf6kf3Q6l1j92qn9ZUe/4pm6OpFkG1MlqHxrL8Jz4LC7UjaQCSi+9EBEAjsF1vVxaLsZnLehUifigkRAyFgOt2R+Ki3PQ4yyj8CCazy9F0+ikYKUrcoyn0Qpy73/Tmx82hzyxQDjqtqSOklINg64VndN/Oeu5JBaEZlJ5sMnYRRj6nfJqwW7JQcOe6uYaoIrFaiyPZHBKpp42Bm+skaqtojKxc+0rD50Ln1CZH6K3xkHax+dYqrMDnmp0yQ70px/jvKvGg7ea6hT/DqviM7rAjvYqCdJ1pvJayIVTGxRie2tq1FKEtKzjLvrbWZutF46UceKcpGuIiXT7pnzMdI4dKWARxD8HGWc5KIVH/LyyT90pS8HGsd0AFzBetZ5URsGP7SJHk/L1u7OvghAleRPj5tjR9GC3v51JEILvD8IVWzXDzrScgey0R7geQV8EP/ylimijiyT7+b3gdzolE/OKLZWmwlbV2X963RZWagUIb6oS8/zIo7JJ+9JK32FZt1pT2HsX5CODsVd1yjUNypavlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(6916009)(38100700002)(54906003)(6486002)(6506007)(6666004)(86362001)(66946007)(66476007)(66556008)(478600001)(31696002)(82960400001)(53546011)(41300700001)(26005)(8676002)(8936002)(2906002)(7416002)(83380400001)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnN4YTYvZDJ5TWswakhlaTVEUm9PdWpIblF0WkxWMVdjdVVqSC9FQzNRSnRZ?=
 =?utf-8?B?bFk0K0JzZWxjaUJuL003dlhNa2EwUVN0eWtvTkIzSGMzQXZwZFQrUERkZXBm?=
 =?utf-8?B?bXpBRmVORjc4NE1laVc1SFoycWdPOE1xcFVrSlY4cUMycEF0TVkzcHdtckMz?=
 =?utf-8?B?NWRieHYrQnd2ZEFoT2lmVjloZ1RPUnZSUE5FTTNMdk1Pb2k5Q1lZa2JHSVNq?=
 =?utf-8?B?dXF4alRxT2tGWTkwVVUyOVdMQ2VqbVlXU1k3d3BNMkNVbDRXbnhBMHNqWDg2?=
 =?utf-8?B?eldkbTNPeUZxZ2cyTE43bjdmR3BlWXhrdU1LdHYyV0EzUWFZT1lib2ZZbTFC?=
 =?utf-8?B?T05GcTE0RzVOWGtwVXlKaStyV3FhYnpJWitrT0pLOU8zRjloSnJOa09HMDVl?=
 =?utf-8?B?Y2JyZTZVMm9ldk5kL2tYWkwvWWVMcU1yaWppMUxSTlZlZmEybE5NM3ZPSlVn?=
 =?utf-8?B?VmZSZ1VTZDVRZkZQWUZxZjE3SWJEeHNzRnhIK3lwQU9Gd3pKekh0NXdkNzcw?=
 =?utf-8?B?bWc0eWtrR3VzRDM1V2ZRbzFidHFPd09TOXhoOUhWUDBDYXdhUkZFMkxPSnZF?=
 =?utf-8?B?MDZaZVZBdk1acUV0bm1VMzA5UTRCcVFXcXlnRkx1MEVTeDNEMTVWaWRzQ3pM?=
 =?utf-8?B?N1hPcEdhUURTRmV6aXgxaC9GQWFMSzY5Z094UmpOMVVDUUR3ek9TcmhtVDg2?=
 =?utf-8?B?YlVrMkd2bVlMS3RmY2RHMThrZ0Y3cHlhUVA5MXRtWmo2Z3ZSVWlES05zcWZY?=
 =?utf-8?B?SWtIUDZNVHlsUFZkNko4YUx3R1lIMWl4eHBYYWxDU2NZcFllVE14NjllNkRH?=
 =?utf-8?B?Z1p0MTdvMCt6VkllNFJmL1F5TlN0SHk0UVMxazIya2JORlR2dGVkSkh6ZGRC?=
 =?utf-8?B?Rk1QNVM2eFJuNmpEUjdtZW5sT3RGU1dVZmxxTmw1WWNVdXNDNUY2OUdpYlhr?=
 =?utf-8?B?aG9jMGZ2NHduT3JLL2ZmaTBEUklvS0pQZUt0MlRFT01uUG1FKzBBVlN0R3N6?=
 =?utf-8?B?TUVUSElKWTg1TUJNNTU0dDRnYWQxNXphckt3RC9VanF1LytHUkJTTFdPbDBo?=
 =?utf-8?B?SDFMbUtwam5HWVluL2lXNUVpaktvekhtdDFTMllzN1F0azNtV2RLdEIvWDdy?=
 =?utf-8?B?emd1bndUYWE5eWJmVUpJTVZLUXZ3akxLTmhQaHdCc293VkFuVG5MMTZFNWpx?=
 =?utf-8?B?S2IyWThGbVdlaEh2d0hEa1NtSWhCcXVyRW04bFFON3NHaExJWFAxRXovR0Zq?=
 =?utf-8?B?aDdReXF1TGtwQS9OWlpBSlhiY29tQm56aHBFRGM4QVVDNGlxSzVMMkxaeS81?=
 =?utf-8?B?NnR1d3NYVC9WVG9sdWZsRWRwcXAyNjF5bnU1K3VjN1g0MW5ZUFRsb2ZDM1Yw?=
 =?utf-8?B?RXAzMkV2ZGRhemxtcWJQYmIxOEx1S2FDQXF4RUhadlJ1RzRweWhMTTNiSFds?=
 =?utf-8?B?WXFTcDV1SjF5YVpSZUFXTEcxUXY5eks4aDUzUWZWSG11SzhJbHB2TnQ5WU1S?=
 =?utf-8?B?ZUJzczRYWFlsMVFmQXROSDRBelBqMFI2Wk5NYWNyWlltazNkVGdObzdBZlBt?=
 =?utf-8?B?eFphc1ZvTlBld1drWjZTYXJRWjJmT0s0dElTQlA1WjQzbDZwaEMxRk1uSE5V?=
 =?utf-8?B?QTcwcGluWHRSajdyQnoweFMwMEwwZEZnQWpZcDg1bk1xZXR0d1dqNnNWSWhL?=
 =?utf-8?B?Ujl0bmVtVDZsZWtZNHNPRVRHUTIxTWZoK2psejJCRVcvSkxZdnRlVytPSjky?=
 =?utf-8?B?bk15cUFnSkQ4VFlEYnZwdlVZeCtKams1dlJ3d1RKQlBLNjdFdkU1WHIzT2x5?=
 =?utf-8?B?RG9ETm1xM045dmYyazN3WDY2TS9pWG5TcUJiZWpOQUNIVGxFL3JNbkx2MjBo?=
 =?utf-8?B?eXF4Q1JpbWZTNmdiSXozYmUwc0IyaG5CQ1Y1MzdjWWpsdEdjdVJycGZ4YVdm?=
 =?utf-8?B?SGJhdWhwZE5FclE1VS9iOW95TEppZUtuc1Fib2h2c0s3aXNGZ2ZMbVA0bUtr?=
 =?utf-8?B?WFR5LzZnY2lhcmkydVZKY1A3R1pMLytPUVVTTDZRSlYrTnZjbERieS9kSjlJ?=
 =?utf-8?B?azNIK2NickRZa2I1THZIdjZlU0xWZm1BMkVsV255SnVoa0p3bmFwQldpWDlG?=
 =?utf-8?B?Z2JrREhHUUVxeHFnb09pdk0rRUpnNU9NUjRReGR2L3k1QWl3SEdKeXduRENt?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f279a28c-7e66-4e84-c094-08db98179ec8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 13:59:02.0538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXUXfFsQM6ijc7OQdktdbi1JQQbocG6x3C3kpBABmalxNsuVLrY4SLQ0IDvQ6vAOu/udh6u8n0sW0KLdI+3JfR2uZzJegNF7TLk1OJcKxTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8670
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 8 Aug 2023 06:45:26 -0700

> On Tue, Aug 8, 2023 at 6:16 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Alexander H Duyck <alexander.duyck@gmail.com>
>> Date: Mon, 07 Aug 2023 07:48:54 -0700
>>
>>> On Fri, 2023-08-04 at 20:05 +0200, Alexander Lobakin wrote:
>>>> From: Jakub Kicinski <kuba@kernel.org>
>>>>
>>>> Page pool use in hardirq is prohibited, add debug checks
>>>> to catch misuses. IIRC we previously discussed using
>>>> DEBUG_NET_WARN_ON_ONCE() for this, but there were concerns
>>>> that people will have DEBUG_NET enabled in perf testing.
>>>> I don't think anyone enables lockdep in perf testing,
>>>> so use lockdep to avoid pushback and arguing :)
>>>>
>>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>> ---
>>>>  include/linux/lockdep.h | 7 +++++++
>>>>  net/core/page_pool.c    | 2 ++
>>>>  2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
>>>> index 310f85903c91..dc2844b071c2 100644
>>>> --- a/include/linux/lockdep.h
>>>> +++ b/include/linux/lockdep.h
>>>> @@ -625,6 +625,12 @@ do {                                                                    \
>>>>      WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirq_context)); \
>>>>  } while (0)
>>>>
>>>> +#define lockdep_assert_no_hardirq()                                 \
>>>> +do {                                                                        \
>>>> +    WARN_ON_ONCE(__lockdep_enabled && (this_cpu_read(hardirq_context) || \
>>>> +                                       !this_cpu_read(hardirqs_enabled))); \
>>>> +} while (0)
>>>> +
>>>>  #define lockdep_assert_preemption_enabled()                         \
>>>>  do {                                                                        \
>>>>      WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)   &&              \
>>>> @@ -659,6 +665,7 @@ do {                                                                     \
>>>>  # define lockdep_assert_irqs_enabled() do { } while (0)
>>>>  # define lockdep_assert_irqs_disabled() do { } while (0)
>>>>  # define lockdep_assert_in_irq() do { } while (0)
>>>> +# define lockdep_assert_no_hardirq() do { } while (0)
>>>>
>>>>  # define lockdep_assert_preemption_enabled() do { } while (0)
>>>>  # define lockdep_assert_preemption_disabled() do { } while (0)
>>>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>>>> index 03ad74d25959..77cb75e63aca 100644
>>>> --- a/net/core/page_pool.c
>>>> +++ b/net/core/page_pool.c
>>>> @@ -587,6 +587,8 @@ static __always_inline struct page *
>>>>  __page_pool_put_page(struct page_pool *pool, struct page *page,
>>>>                   unsigned int dma_sync_size, bool allow_direct)
>>>>  {
>>>> +    lockdep_assert_no_hardirq();
>>>> +
>>>>      /* This allocator is optimized for the XDP mode that uses
>>>>       * one-frame-per-page, but have fallbacks that act like the
>>>>       * regular page allocator APIs.
>>>
>>> So two points.
>>>
>>> First could we look at moving this inside the if statement just before
>>> we return the page, as there isn't a risk until we get into that path
>>> of needing a lock.
>>>
>>> Secondly rather than returning an error is there any reason why we
>>> couldn't just look at not returning page and instead just drop into the
>>> release path which wouldn't take the locks in the first place? Either
>>
>> That is exception path to quickly catch broken drivers and fix them, why
>> bother? It's not something we have to live with.
> 
> My concern is that the current "fix" consists of stalling a Tx ring.
> We need to have a way to allow forward progress when somebody mixes
> xdp_frame and skb traffic as I suspect we will end up with a number of
> devices doing this since they cannot handle recycling the pages in
> hardirq context.

You could've seen that several vendors already disabled recycling XDP
buffers when in hardirq (= netpoll) in their drivers. hardirq is in
general not for networking-related operations.

> 
> The only reason why the skbs don't have the problem is that they are
> queued and then cleaned up in the net_tx_action. That is why I wonder
> if we shouldn't look at adding some sort of support for doing
> something like that with xdp_frame as well. Something like a
> dev_kfree_pp_page_any to go along with the dev_kfree_skb_any.

I still don't get why we may need to clean XDP buffers in hardirq, maybe
someone could give me some links to read why we may need this and how
that happens? netpoll is a very specific thing for some debug
operations, isn't it? XDP shouldn't in general be enabled when this
happens, should it?

(unrelated: 6:58 AM West Coast, you use to wake up early or traveling?
 :D)

Thanks,
Olek
