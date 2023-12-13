Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21123811A01
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377908AbjLMQsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMQsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:48:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1716698
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702486110; x=1734022110;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v/KFm/6faPvr4qth8VZ5i/HO8H895xztIJX+DhKsil4=;
  b=CzSXDUnpaWcOYt5udzRTw91m21SQBUooEiuJic55uOFHW8mQIQkyDnnB
   bkQo/JZl4YvZAkE643LXWfzdFquUyebR47RzrLuwi3uzkay6uJMwDI88t
   YNwJ7HmSxqzMPpUE5vRZhZ8lZnKmQ2YTlbaVOo8iNQjXKLVhIBH8YnoBh
   U5ei4B0kOhehlwECNR39HyqpGUlnrVzBGY1AJXkv2RvKv5L64TJt1jMOp
   IwJ4tdv1A0WNkBVkhGCE+CaWMYG61uBk6BfImah5LohSxl8goZ4HMSEMU
   QAH0cBfwGvUgkTJAVNlyq9zF+MOo+juKJYHC6D8s4xODrKebKlqix62lu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2134042"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="2134042"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:48:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="15491570"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 08:48:06 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 08:48:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 08:48:05 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 08:48:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AicGikawWP9b16ICmfU9fujreW0hlkcpceEoULvSnz+68idz5MwfPUpA8ISOo7Fv2qrQGxqpd0q+HTVvNVtMj5z+9K9FztDej3PT7wy3075nvYeuglPxDclmWrsXCpaN/RM0X55M7XmuLRAvxglUvqLzL/IeBPdw9LWnf3sr2s9wwyS+ArYtPuyWPfDTrdsPWtW2JU5lWLVfryDNpKKTG4l/LKeGwE8KK8OCy+mwPIRSmVURNLIi3k8he27cY7VvMr4DHPlsvR1yn4asrwNS2sF/Kc4xVz0/5/vcCFuxSr5te3ijYCcxDRfob5wFLyrXW+gFFU64WSqXJLovTaX5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGfkt8h4QwU2kseYcnAz5B45fWlUG9OvgZ42Fdp8BSk=;
 b=LuAHJuCmn95fMMCL519p9OFFE/3UxBWhrxIi0JDRRbPF4kxfniNp1bNT386bWNphf0zoPDrvEWU6qMDlM71MA1v5sk8NdZRj9Bm75k+Wjv1Ko5CDsNQeHSVcbyaQ2zbb+nUGYuQHYi6ExOBl03JyViSiDvvL4DLNrUIklgaB8gvpF9YYP1qg5TLK1lgXgZxyACfAqzdhcIw0O5UGZCVjpE34IhM5RAha4tMQkFaB6ZfobzIlHmBSiYt2PDsZBEb0Z8KeB6ykdZnULdspliPQyJg8arejIRmmIngPYo+W3bSbXPLueCIcHTm1gYBX1d+01n+hf4y6NvoTq+c6/Xzl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CH3PR11MB7348.namprd11.prod.outlook.com (2603:10b6:610:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 16:47:58 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:47:58 +0000
Message-ID: <0473a930-9b80-4b81-81a1-c9adb0dc3919@intel.com>
Date:   Wed, 13 Dec 2023 09:47:55 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] nvdimm-btt: simplify code with the scope based resource
 management
To:     <dinghao.liu@zju.edu.cn>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20231210102747.13545-1-dinghao.liu@zju.edu.cn>
 <8716bf72-e4ca-4f83-8a30-327baf459dbb@intel.com>
 <369f7d97.32dac.18c6129229a.Coremail.dinghao.liu@zju.edu.cn>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <369f7d97.32dac.18c6129229a.Coremail.dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:a03:60::39) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CH3PR11MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: edc89cb9-b946-4182-53b2-08dbfbfb42bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ghgrrxpmfCoDyVYn5Huj+1L3SynWjNdFJ9C3ez8Q8DOGD4CUn1ErXi0gt8USCUKD0A8j1lMQ+U7w5YEVXTtONuCC6PehgBaQ86yP8OHGS6QVEbMTIwwVjGzJSgVrriqYaPqkjNxnRsZPgXTOT0owTZGP+ihskfxtf/m54XcQs1BjuZJH7YcXQzESzlQaPbRNpB4eIHUT0dxd7FfVhOJZb/wn6XF55yIvj4dS2yBAgdaeS4OuK9Wo/IDWwQp4Mm7DxF/VzBu638Y+9wBLMo2nPX68yTMtP7fP3ymUv6yvafYe66f1JuH0nAPl8fubbw1chxJrcjopMp735St7e5Rp6X7D/+Wx8A36fPdUByUVL8zWBbsLKHu7u7ENpzf5ZvwDNcKKQXqLHpPTsGr24/UhD4enzKmK1RqV+AXhNQPNeo8BGX/hDae1sjOsmN3LZU+BaRunCvoh4Gu//c0/5VMoAjA07FRa+6SNqyR/hc/cimqp4l+nnfxmj4OfYZ3dy0LfiR+sYqYTagtE4IPWuc0mtklRwSX5uYII7bB3SxI2nentefuiovcAqluD/tlDVOVl631wkP8mqaRT4W0EuXj73DTD5PMogXs4T2OSSL4uaLKeKSD0Zc8BqvMfKXCIfXCt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(86362001)(66946007)(2616005)(26005)(31696002)(83380400001)(82960400001)(6512007)(6666004)(6506007)(6486002)(53546011)(478600001)(44832011)(4326008)(8936002)(8676002)(41300700001)(36756003)(2906002)(5660300002)(31686004)(38100700002)(316002)(6916009)(66556008)(54906003)(66476007)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHhoMVUxam5iWFBheVhvVE1FQm82THpmRy9wVHIyVlZQT3k0dEFyb21wNFFB?=
 =?utf-8?B?QTIyQXJkNE1VYnlLbWxudk53QnBSTnFzMThuYVFtVm42K1R3cWM0VTZDTDEr?=
 =?utf-8?B?Nlg3ZTJ2ZnQ2RTVVNFZySUFjeUt3RVdLcW51TlpBVCtkcU1NTlJUUXJTZ1Jh?=
 =?utf-8?B?NEFWOHg5OFI5VlFYOGpsM1RtRkRpcVpuWlNSZTNReEV2TmEvZ2xqNlorbFJV?=
 =?utf-8?B?c2gxTXBLeTRseWw3eWIvYkZRbUtNWkVDbEVvMGwyWjZoMnhVcTJBZklMc001?=
 =?utf-8?B?bFZGYUVxOFhHdG9WWldZUTA3VzFKaDFBUWM4RkkzZHFQS1NPbW1oZjN3Z3Ro?=
 =?utf-8?B?RndCM25pNFF2NTZrakw0Y3Z0V2JvUG0vZ04xc1RZK2U1Z0pEak1hd0dKWmRm?=
 =?utf-8?B?ZVcxb0wvVmQ3REg1eWFIaXNBRkwwYitTdFJuRlJ3L2VMa3N3d1FzMmRRYmRs?=
 =?utf-8?B?ZEs5QzNPWGRyQ3U2dFpjekJTbWh4YXdzR0VmT2hlUTFIY0VtTHcrL2pzb1lN?=
 =?utf-8?B?YXdTeU1XL3VyTHZWaG5pZHFLbE45RXk4OEdqbzFZZlovdXpQYTEwRzlRZWxF?=
 =?utf-8?B?VHhBWXY0OHhMcDRGd1hXQkRIWXN2Z0UyeVJ3bmpudTY1eXZXdHhidU14T2l2?=
 =?utf-8?B?djdlc0hReVBBOGp3dDZ0R01kSE54VExyajAraUd6TmsyUW5SeVBpazFQNyto?=
 =?utf-8?B?MUJPUHJmTUIwT3dhdDNJbExOaUVaTXZ0b05IajJpL29VZHZ6UUR1Ung1a2N3?=
 =?utf-8?B?V0JSTHBOVzRKZ3kyZ1JBcWhPNDlIT0M4UVdVSGcycENIczVBSDIyUDV2L1hM?=
 =?utf-8?B?QkowNW9OOHgzUGR3RW0xWjRiWDRuUTAxdE80UmhYVTZ1UjJYOG1IRllSdytQ?=
 =?utf-8?B?TFlUMC9RM09lQVhCbyt5a3g4ZlMvdmZGNmdTdzU1R2tBUGh5M3RlRTZkNGdD?=
 =?utf-8?B?elplSUJ3dzdkU2gyUTlpTWExRVZnejBTaHBlZ0o0amF5ZzE2QUwrL285RlhX?=
 =?utf-8?B?WGZ4NUFIOE5nOGlEVHFYcFNPbDl6STdXZS9wdWtucEFsUnI4RW5tSnVNVHZK?=
 =?utf-8?B?T2NsU255S3B5M3I5Qi8yblhJU2FMVUdjaW5pZlhJMlJFN2ZydFhnUTBBUElP?=
 =?utf-8?B?c05TS1pFaUxBOENHZVYwYmg1ckZpMW1mZmZiVXVQTUIzd1huMndtQm1ycHpy?=
 =?utf-8?B?ZzZvOWsyQlR5RDNQN1I5TStHcXlnT3NjakRCaERFSklaMTVyeGZadnNVQitI?=
 =?utf-8?B?UXhaWStLM2N2L29EUWxKUS84ZDNrRzhiQUpURTNOM2ZUZkN6L2Q1Q0dBYk9U?=
 =?utf-8?B?NWtzbWg1czNmNlFzVWN3NStCSGJFa2VwbDFtdGV0bHA5b2VwSUdEdGh5SVhn?=
 =?utf-8?B?c0dTY0diWkU4Rlc2Q09Vck5ueis0ckRlSm0yVEc1dkxWZnNHUmtuWUFwbkc5?=
 =?utf-8?B?T1VWYlJhM09ZT0VHU1drQnlkcnprMlk4TTlyWEtaWm82WHBESkhNRFdOcTk5?=
 =?utf-8?B?ZEQxcDVjTTRBak9NZXFkT2tpVjRUVGl2cFhvZlpRVThmU1ZQeFZTa2VMWnFa?=
 =?utf-8?B?eERiZjV3ZFRGNnBJNmcwNC8vVjY0NTlsa2hYMXd5YVNLUUN6WDloOVMrVjc3?=
 =?utf-8?B?UmtHYnRZc2swUGVuV3ovL1Z0NXZIY0h6Q0hqUjJiUzE4L2duRG5xMWlMeXp3?=
 =?utf-8?B?RnBFWnplTnJKT1NEWnVQUXlDWlQ2WVBoc3hreHBZK1NSSWk0bEJZQjdFVFpR?=
 =?utf-8?B?bkV3aGtlekF3VEhCMi9WdVF6Z1lTb0x4U1RaQVk0bXlLai9mWEJ4MEpobkNY?=
 =?utf-8?B?K1RlWktBK1BTWXFxT05tcjdLZ29sUkVpaXB4bExQQ3lDeS9lQ3Y5ZVBpZVRB?=
 =?utf-8?B?ZjMwUWY1RURyd0RuRDI2Z3dEMEN5emNsU3lwT0dpWmRIYUVyK1dDeExnNFVZ?=
 =?utf-8?B?OXpFbHRFcUlHWnoxM2F0emp1ckdoQmxpaTdNcnhMYnBnV2FlM1l5NGM4dGRs?=
 =?utf-8?B?R3VJanNhQ09ucGlPU2VaaGF3MUlKdjR2VjVVSEZ6ajMwMVExdndHZ0dVVlFH?=
 =?utf-8?B?Qkd6QjhWMStqMEE4NDhEQnNDQjVFOUF5SlBBZ3d6Wmtqa3pnRUxqUC9yRm9v?=
 =?utf-8?Q?khyCYCWQXaLnHqfUf8uoQsfIy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edc89cb9-b946-4182-53b2-08dbfbfb42bd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:47:57.9449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6L1nYZ3BrQaOliukXDnpB2KSyqsJsixLaptn379ZAhbkZXDkvOi6qf4L92469PqwoGhVuOiWm1iZEOxU8kMxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7348
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/23 20:12, dinghao.liu@zju.edu.cn wrote:
>>
>> On 12/10/23 03:27, Dinghao Liu wrote:
>>> Use the scope based resource management (defined in
>>> linux/cleanup.h) to automate resource lifetime
>>> control on struct btt_sb *super in discover_arenas().
>>>
>>> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
>>> ---
>>>  drivers/nvdimm/btt.c | 12 ++++--------
>>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
>>> index d5593b0dc700..ff42778b51de 100644
>>> --- a/drivers/nvdimm/btt.c
>>> +++ b/drivers/nvdimm/btt.c
>>> @@ -16,6 +16,7 @@
>>>  #include <linux/fs.h>
>>>  #include <linux/nd.h>
>>>  #include <linux/backing-dev.h>
>>> +#include <linux/cleanup.h>
>>>  #include "btt.h"
>>>  #include "nd.h"
>>>  
>>> @@ -847,7 +848,7 @@ static int discover_arenas(struct btt *btt)
>>>  {
>>>  	int ret = 0;
>>>  	struct arena_info *arena;
>>> -	struct btt_sb *super;
>>> +	struct btt_sb *super __free(kfree) = NULL;
>>>  	size_t remaining = btt->rawsize;
>>>  	u64 cur_nlba = 0;
>>>  	size_t cur_off = 0;
>>> @@ -860,10 +861,8 @@ static int discover_arenas(struct btt *btt)
>>>  	while (remaining) {
>>>  		/* Alloc memory for arena */
>>>  		arena = alloc_arena(btt, 0, 0, 0);
>>> -		if (!arena) {
>>> -			ret = -ENOMEM;
>>> -			goto out_super;
>>> -		}
>>> +		if (!arena)
>>> +			return -ENOMEM;
>>>  
>>>  		arena->infooff = cur_off;
>>>  		ret = btt_info_read(arena, super);
>>> @@ -919,14 +918,11 @@ static int discover_arenas(struct btt *btt)
>>>  	btt->nlba = cur_nlba;
>>>  	btt->init_state = INIT_READY;
>>>  
>>> -	kfree(super);
>>>  	return ret;
>>>  
>>>   out:
>>>  	kfree(arena);
>>>  	free_arenas(btt);
>>> - out_super:
>>> -	kfree(super);
>>>  	return ret;
>>>  }
>>>  
>>
>> I would do the allocation like something below for the first chunk. Otherwise the rest LGTM. 
>>
>> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
>> index d5593b0dc700..143921e7f26c 100644
>> --- a/drivers/nvdimm/btt.c
>> +++ b/drivers/nvdimm/btt.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/fs.h>
>>  #include <linux/nd.h>
>>  #include <linux/backing-dev.h>
>> +#include <linux/cleanup.h>
>>  #include "btt.h"
>>  #include "nd.h"
>>  
>> @@ -845,25 +846,23 @@ static void parse_arena_meta(struct arena_info *arena, struct btt_sb *super,
>>  
>>  static int discover_arenas(struct btt *btt)
>>  {
>> +       struct btt_sb *super __free(kfree) =
>> +               kzalloc(sizeof(*super), GFP_KERNEL);
>>         int ret = 0;
>>         struct arena_info *arena;
>> -       struct btt_sb *super;
>>         size_t remaining = btt->rawsize;
>>         u64 cur_nlba = 0;
>>         size_t cur_off = 0;
>>         int num_arenas = 0;
>>  
>> -       super = kzalloc(sizeof(*super), GFP_KERNEL);
>>         if (!super)
>>                 return -ENOMEM;
>>  
>>         while (remaining) {
>>                 /* Alloc memory for arena */
> 
> It's a little strange that we do not check super immediately after allocation.
> How about this:
> 
>  static int discover_arenas(struct btt *btt)
>  {
>         int ret = 0;
>         struct arena_info *arena;
> -       struct btt_sb *super;
>         size_t remaining = btt->rawsize;
>         u64 cur_nlba = 0;
>         size_t cur_off = 0;
>         int num_arenas = 0;
>  
> -       super = kzalloc(sizeof(*super), GFP_KERNEL);
> +       struct btt_sb *super __free(kfree) = 
> +               kzalloc(sizeof(*super), GFP_KERNEL);
>         if (!super)
>                 return -ENOMEM;
>  
>         while (remaining) {
>  

That's fine by me
