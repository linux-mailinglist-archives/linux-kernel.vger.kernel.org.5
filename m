Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2D07A071A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbjINOTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239870AbjINOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:19:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E72DD;
        Thu, 14 Sep 2023 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694701150; x=1726237150;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jnMvQjcsqHHv5b19Oy0JoEvHf70PhN/YFrOKIU5eBuY=;
  b=Vit+/KVfmmBuGWKf63xx5QAYFf4Og9+7Lh1B4n9P55MoIbJizimTc2bn
   f4P5HkqxSLFrCkiofcZ9xW1S+eI2YVDSQw2kcOQ8SqG8Fsf1fBcYSRekS
   9Ekt25WZTFD9nO/jnr8cErcSPhiMQfb/2vUFz6ziuXc7BtIrjz6pO3LzR
   /8KU+NHbTmA8KbhpzYcnmhT4U05PjUAmbc/wyt9oVziFTVfRvoKKFyj1Q
   uOjHOfgCIB1fQWs+EcYgmhsZRa8R9RCnf6WewIJMLyI0ZaedqS/SkpDnp
   phtI081dQ0/KW7YMt2hbIFGsbSICvb7WE9pgeDLCSY00XsOIQWkgYMqqZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="382776088"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="382776088"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 07:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="737923712"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="737923712"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 07:01:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 07:01:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 07:01:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 07:01:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iERBajyJDMVvPpEVk7RMDK3Ndq24k4PFfaBsglNl+lYXG6IN9bOBEAcGnuSA+wRa80TBG6lUW7qc3TypWbAzKqn40Ragf6QLyzmiUYltOba0p2GEVvLNZjIce4C6dfDGTdWxbIpxdH0EYj68MdqVvUpaP0Ner2LgXt1nSIgCa5WIb5+AMmWjOyYoi1d5XsJDl0qCtCne6gjOw5Y+jocjrTUwKkfqH9B28owACVeIRAuwOb+RnCIaR0mJWE0cBeufRB2SAbNBmpFl8duIhLWDF0Ka8Xz/pL9Dz6uYC5gvSOMXw6an451hBIZ9RlUzoj/rUat11cRc4HqgNS0xmhAIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=950CCQhai4LIcRncRSEBtfLPUoV+gDbpYfd1aco6jgE=;
 b=f4tRLEUNaRhQeNt6UOkk5PnfTf4qMog92OpFDnDyRggUmJghzKdtGY/YnLRZ2wLjlkZB5yUAH0uScH/BnDIdvYjRXF00K045FM+RO3isrJqv0jSVlPJwoT3O+cXYnHbFX6Ycp738oGdFIw0Or3HVM+P3xVkT1tIqQjh8tXpiwu/VG2E3goFRtdRuMe8GTrVmF8eUggmU46OynaZwoK+t2fRmugFFeY9D6trW2JKx0Tymj+MyW3hhN69TU99ZsqCzx69g3ik3zvu1GNS6Voz9hJi75tcO2NYMHV1cf7H5QIes8DnqEgyJgotoY3SnL/ECNTQ2dOQp01gMQocfJcVC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 14:01:23 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 14:01:23 +0000
Message-ID: <38b363e7-0ffc-a319-0003-97fbfb0c7501@intel.com>
Date:   Thu, 14 Sep 2023 16:01:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH v2 1/1] net: core: Use the bitmap API to allocate bitmaps
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Simon Horman <horms@kernel.org>
References: <20230913110957.485237-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20230913110957.485237-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|PH8PR11MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: a749e6b9-d545-45f4-d2ae-08dbb52b1466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etxqdaxEM3qLe8zBvo5tePhsIsREud/fRneKGeHMlArekZB+UsOM6zWhHRfOQ0RW/gEpykaM1DL7qMuj91/9CLChik50Q9C5ylGNQt61cH0aHpZFa9fhJHoaHRmvXkf0+k4sVnU/hPH2XNydh8BE99hzEz/V2I/E+W3cqsRsxfwLtJXOgkW00yziVJBtxe6gX538JPSBqCSnNJY4P050q1m88XcCAK1+ATbLAJ/l/cNSAZDiW5RRUj0pOLSsgs8VLUYZ2yMtjEd7SIsKXpKpRy2ahNIKNMl5ECOTLF8nN0oEXjDj0cAhfN3QNBRIuARUpOj+yJ1brzH9ZmtKCWMubXF3E7jivJNjyr28CTAendRJyQc0sbJkknh9fRcT1xaU4pZQaGyqu0NUXKgKdTjxcLyDJJh0oAB5xsdu9AaQhb01Ea4derrAl15iyBXXRwRuZycG8JjB0wdbO4nHSREog3mYZGa1Tn6ilSLnTjBshSYUOAHIiDA/9KzKbb0MLWujaXdvCiJOPmCHRTbAe96Z4twRyfhbsqRtnty2T2NjwInpBIXb+aVGHXVAQtC8LSROapMX8LCcyaHcqBsVLX2R7mo7B9a1bnc/dNvMWnOx5Co2s77ux8e0d/iJ7s02Z+hgADbY2uN4YvljvXp4ov0gjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(1800799009)(186009)(451199024)(66946007)(53546011)(6666004)(6506007)(6486002)(6512007)(83380400001)(478600001)(316002)(2616005)(966005)(54906003)(8676002)(26005)(66556008)(5660300002)(8936002)(4326008)(2906002)(66476007)(31696002)(36756003)(86362001)(38100700002)(82960400001)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDlkdUJaVGNYTU93Z3UwYmYwcUc2TDhrNWw2ZnluOUpJQ0VXTUJOOEtSOGhE?=
 =?utf-8?B?ZlQyeWtOMDR4Qmw0MVZ0OGVUR0YzeElSTWNCVzl0c2pBdGpMTjFOUTZScnNO?=
 =?utf-8?B?N0dtMFB4aDExVnN6UXBOSk9GUGpHSE82SmVOL242eEszWHZ5RFc0WmlQMGRQ?=
 =?utf-8?B?V1JIWkdjU24wY3ZFUU5yMXJOZEdKU1RnS0R3ODNHRlE2MURjeHNMc1Z4R0E1?=
 =?utf-8?B?SlNySGNKcGNvc09wNUcxbVBrVFVEZS91Y0N5cGd2dVlVejZ5bHlYK2VvZHN3?=
 =?utf-8?B?dVhLUWRJN2F4bFNDYUxSUWYvSDRTRFJOQkFHQmIwU29ucEJESkt3eTJaVTZL?=
 =?utf-8?B?SnVKOFV2MTA4ZVprWE1WcllPNGY1R0loZ0xkaHFNdGFnaHUrNFJoKzdMNDFD?=
 =?utf-8?B?cytVOWNKWGVxRitMYzNoN2xNK2YxcGJJeXlTd1pQMG52a2NweGQ0enR0OFJk?=
 =?utf-8?B?QkZGSTV3V0pPSEVQMmNtbjVGdmlBZzNIMTc3R2hYSXp3UFFvYVhnNkNsNEhY?=
 =?utf-8?B?L3VBeXlnbG9HQTZZRytpbWsvOHgxZGpRTURBTTRXOTZWRTAzWGZsdTlPUGxX?=
 =?utf-8?B?bGJodjhDWWZpdDR2ZXBOYUE0OUhJNGIwM0ltQUY1eDlVNmZTRVdhM2t3T3Bh?=
 =?utf-8?B?NERmQ1JGMVdzc1BYWjZ2SXlEak9RNSs4V25kdER5K3EyV3VCVllmVTl6TjRy?=
 =?utf-8?B?eStLR2ZGbnltWnhORXRmcG03RFZMTEFqV0pDS1Vuak5BVENFbHNDVnBaRDhD?=
 =?utf-8?B?aEc1THREc0ZkenlYTkpGTi9RTFppK3FvRXpKWXI1UDJpeWR1TVlqMXU5UmU5?=
 =?utf-8?B?dHp0YTVCOEZOUGZhOWNTY3NmV2JZdnJncE40Smg2em1neEhsUS81NTFQY3ZE?=
 =?utf-8?B?YUwrT2ZLWHptLy96WkFwZmt1VVk5L3RaRE1IMkNKR1NaTjFQendIT0tScDVm?=
 =?utf-8?B?aTJLVWpva0x2S2pGN0dVa0VkVXNFaUx6UDEzRHl0eHJnZGk1K293QkFNeXdX?=
 =?utf-8?B?ZDAxcFJRWkE0VTd3eGg5OWl0NERqcXFjN3d2Uzd2M0QzNnJpVGdScVZWaThr?=
 =?utf-8?B?d211VG4xZjZVRGtlYzF6WnZ3a1J6MHFvM2JpVVNFTERaYmVjbUwzd2wwTWFL?=
 =?utf-8?B?dkhYUnFLQ0R2SlVLekwrTEpUWmN5Q0crT2NjU3FHTzRmeEZmN1JrSEFWSlMx?=
 =?utf-8?B?YXpYN1pOM1g2RTF0RmViRzUyalRBNGc3bkhGS1V6azRPenA1b0grNndHb3hX?=
 =?utf-8?B?aE52bTVwY1g5OXp6eDB6dDcwZERaNE1aVDFReXZJM0RIdHY1STI1Ly9LSmZ2?=
 =?utf-8?B?US9OTjNuaHFPUXVrbSs0R1JsNWx2RVFHV1Y4YlVzY2taNm9KNThGUTMvb2hs?=
 =?utf-8?B?NFErQnU3T3FoTWdxZ0k1QmJkamY3YWxIOGlIM3pwOU1lTFB3Rkt2V0xySWha?=
 =?utf-8?B?MDkxN0oxenlvbjhYTFI4UEw1aHF2Tm4yVVBuSmhwM3pQeDdua0xxZnNPQ3h3?=
 =?utf-8?B?L2pJZzQxQ1NsS2NVK0YyWW4rNEpMRW5KVHdNeUJRN0k0UUJiNU50bEJvYkYx?=
 =?utf-8?B?Rnp4V2l2KzZpMXFDVW9WVnRicWFPZmcrS3BHR2lLTGx1R0o0aUxSTzVmaDJt?=
 =?utf-8?B?WUZBYTlSWjlHbkRWaGRnUVk0QVJKbG1zWEpYY3A2dWoyVjFXZGN5bjZyeGk4?=
 =?utf-8?B?anVkOVlqR3MybWZ5VWMrNStPakU5dGo4RVB6K1BDS3BMZTBZek11NnZ3LzA5?=
 =?utf-8?B?S0ZzampNenZqdTBGWVRKNUViVFR2QmpPcEdoL0Q3RHNqUUR2SWxBSi9MY1Fa?=
 =?utf-8?B?UExRWHlta2VDSHhmdG1STllDSkV2OWVUR3BpVHFPK3NaOU02TTV2MWgwUkJl?=
 =?utf-8?B?S1JJaEdJQnVKb2Z6QnRsSjRTRVRqby8wWm0xamtZdGd5ZlBLUW8zaWRMN3pR?=
 =?utf-8?B?dUJhaUVrZDZTSkplNXFoN1liMWdVbEphMHZ2eW8xVlF0R1N0WjR0eGl0Yzl1?=
 =?utf-8?B?OHJyWUZzbnJOSk9vUVd2TTBZdkJkSkowMmcvcGYySEhnOTJ1aXJxb3RQVlBT?=
 =?utf-8?B?VnVNZ1I5RlpBM3ZzRVdJM29HZm9sMWJGei96MDdLeU5NY3VhVXIzdWk4MXd3?=
 =?utf-8?B?ZDV0T0lSNHRhSC9BUVlMbWpkRU5WeXFTcHhlYnV4MnVDa3RkSUZRTnE3QVBP?=
 =?utf-8?Q?/myf1kIdvZy2igkdQV1dhc0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a749e6b9-d545-45f4-d2ae-08dbb52b1466
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:01:23.6120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0SvFlIQifZ9ZMCKOiZfC7vO2kqVrqTuwVcWRLrew8Q2wSKNky8bxPzY4Ip+sXRwusdCsE592sIlKPq8mAAE3h6yGo/4IehMOUVajbPvVu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6609
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 13:09, Andy Shevchenko wrote:
> Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
> It is less verbose and it improves the type checking and semantic.
> 
> While at it, add missing header inclusion (should be bitops.h,
> but with the above change it becomes bitmap.h).
> 
> Suggested-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Link: https://lore.kernel.org/r/20230911154534.4174265-1-andriy.shevchenko@linux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: added tags (Simon), sent separately from the series (Paolo)

Yeah, in any context it's hard to get people to agree to fix things when 
they started out of order :~

>   net/core/dev.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index ccff2b6ef958..85df22f05c38 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -69,7 +69,7 @@
>    */
>   
>   #include <linux/uaccess.h>
> -#include <linux/bitops.h>
> +#include <linux/bitmap.h>
>   #include <linux/capability.h>
>   #include <linux/cpu.h>
>   #include <linux/types.h>
> @@ -1080,7 +1080,7 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
>   			return -EINVAL;
>   
>   		/* Use one page as a bit array of possible slots */
> -		inuse = (unsigned long *) get_zeroed_page(GFP_ATOMIC);
> +		inuse = bitmap_zalloc(max_netdevices, GFP_ATOMIC);
>   		if (!inuse)
>   			return -ENOMEM;
>   
> @@ -1109,7 +1109,7 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
>   		}
>   
>   		i = find_first_zero_bit(inuse, max_netdevices);
> -		free_page((unsigned long) inuse);
> +		bitmap_free(inuse);
>   	}
>   
>   	snprintf(buf, IFNAMSIZ, name, i);

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
