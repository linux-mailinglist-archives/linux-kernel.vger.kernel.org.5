Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1FB78E02F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241633AbjH3TT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343957AbjH3RhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:37:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62801193;
        Wed, 30 Aug 2023 10:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693417027; x=1724953027;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dnc4M1uYFuS8CZ293twnDtGg/yC+WbDYGqtAqXGyWaA=;
  b=JZ7GPAOW8qI/c7uwJQx2DDFGpXkucmOuMcSzi/9DSZ7+Od8bnXOsYW+0
   8uWhxir5wcXdDxw2Fhmx0DYKRuJLXp8iyzcIXcw7ZCAUQ6U++dG+xaRK9
   8x7LVW5WaDNivewv0g9ehyoJ4Q3abHP+HnsX7WWpCfyP9Gb4mQPU9phce
   ENE8b13bxdTY8A7HlrC6ukFLhvFLQLm1KjbWGTSEzc/lSZzQ0vuVXS2pC
   9SuyMDxQGDaUMzumj+eFhGIEAPROeFAOxKih0sS2BhuyHSGBdc+wpPVrQ
   Ixtxjw5QsV1iJqmEqaqKtAGbc6lZW56whFUKAUXNbN8Gide/FeD0IGDj/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="379458415"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="379458415"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 10:37:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="732731441"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="732731441"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 30 Aug 2023 10:37:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 10:37:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 10:37:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 10:37:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 10:37:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LafJGjXL5INSw/Namhx28IVdijZWwMbTZHvJ0lxayFuso80MT1LKvOSuXzPnZWXkbcmaa8cIVN1Ipid9idK8GPs6Nnl7uQeaQpYmlaCiu1o/RzGUk/F9BtMlOnzAbPQKMQjBvJrkiUVCYeD+z69euRAO/sNRvCo35wOhztcWdlRsICSYnYuIFMcpsOtsOR5tzC68W9qPik4Z3cUTdy9qkgnZi/7SD8R3ZLrY3IeztziD1maInaPDkpYX9nf9FydWvFVrNbMBaxMM4M4BrOB7JnJ9UKSH+rL8vZiy0Mkn7+GRhrJntJ8DHcH1r+omnRw2tALEq8nfQG8ThPp3JlE7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBxtIhw17uxhix7O7gNe2+het5Svn+jLDxJMs3U3lEE=;
 b=CE0LO8KtDO4Maqa3MdGSagVLrI+xUiUNVxzWLM+3+p9XBL4bq2lFUNIT7IKEMFRBZ4cF4N9Y9xIiwAU/l3y+M9g+3yuRPEz3FEzFxSgipW7kd1JoNr2BDMAJikK6VfWcihHPA6ieQR5hztUGkaZMpR9dMQB/eTAL9DpcM67eKtQKK/MkiWBAD3jXca054cd8W4TFF7ZJ2p9lkdymCM9yJgdMkCV8ea2DSMw9dleD0BcYkv3QBTr/dfJRdGTj8YibUr0q2wK+53rFaGnHjzrTLp1+snOEGu65BQv9BsTPIhKakibhg+kyFDj+g3phGLBK+IV5Tsrg6uq0fE3zNLHeOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB6326.namprd11.prod.outlook.com (2603:10b6:8:ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 17:37:03 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 17:37:03 +0000
Message-ID: <1723022b-26f9-c097-e7c0-f5c214750723@intel.com>
Date:   Wed, 30 Aug 2023 10:36:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] cxl/region: Clarify pointers in unregister_region()
To:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ben Widawsky <bwidawsk@kernel.org>
References: <20230829-cxl-clarify-ptrs-v1-1-40e0705c6188@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230829-cxl-clarify-ptrs-v1-1-40e0705c6188@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::32) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bca8695-a37f-446b-8e13-08dba97fb8b5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrItLNzwyT6A0E7/fEDvPlnyEXiAEQY3F4UI9khpo/99n/4kKWdDCEk4lmWO6ygANOJjWjdlAGuQry7qrIwhG+XHc+ETAgIRSsJtda1zBlRgy5FHbeK0EtP5maWnqrFQQ/AUosEPDpqlb31lFxeOSCUa5yEgSj3h/S9vFQOIaSkpWLZ84Bk2j55qm6txVV21EH7OA+cMjZrQpGlcnNgHtto//6X9iKnQTXB8eIQ6lcYb+XqafMI86tfzaUYq68b0UPAqQhNn7T3fZKZk4xLGKAL0CV6qpGMgs8/emoQRad7Dirgaidyebk83nQHMeKPlyBNjvGWmYoUDmW0otdOPtsCKFa80A0HouPljnNuDl+EP8pkJ1WGVisb/5XF0NLCtnRqzMhD1UqWt6yYHmRBH3rfDUfeZhqZr6Nh6Sr8M2OF6JeFkKvJ2rQmFolUQS6Xeee7A7gWUi39Vr31Kp7Yzm5srFxHXiGiX7b7mw35ylfYjkOeIlTzCZ6CaqBeVjxRxaiUtnOoz9rkDgjmC1sV6P9TqrGVPfXe8v9cHBpIIbzK7ww2oZR6Xj0NbeFFGHghqKCs0BjrCjb5IcISVO3mn0Db1GWCSspiQ+tFKecdiWWOKna8QevP0XqYDFAy9jekyUvcFV5uNf0LpQudrtDaWvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(1800799009)(186009)(451199024)(66946007)(82960400001)(66556008)(66476007)(316002)(6636002)(110136005)(38100700002)(478600001)(2906002)(31696002)(86362001)(41300700001)(8676002)(8936002)(5660300002)(4326008)(83380400001)(44832011)(53546011)(6512007)(6666004)(6486002)(6506007)(26005)(2616005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2Y3dmxyNkVtQ3ljQVJyLzd2clljdG9tT3JvUE1EdFRvNHg1eDRPekk0OHJX?=
 =?utf-8?B?a2NGa3psT1dFTHhQZWFNNnpTVzlBTFIvL1FoRmpHa2xHN2dkVHBUNmYxOEFm?=
 =?utf-8?B?aE80SXlINXVXZjAxWkhiM2tIZ3ZSdU85b0wrYjNiS0Voc2kydlZMWStzZUdh?=
 =?utf-8?B?TXFNb1RIVnErRXhwYlVZamRycTEvZEFlVzJ2Um9VYmNiT1VUYXpKSHRQLzdk?=
 =?utf-8?B?WlZBekUyYWhpWXU2LzIzTysrb3lQOVZlei9LZmg0ZGJoZXRXOXR1N0lYVGQy?=
 =?utf-8?B?ZGhvOWc4S0YzbnA4ZVVxUWxiN2FiY1poRWdVSjByRWZZOXdPdXBmbzJiYlVJ?=
 =?utf-8?B?QzJ0ZXhoVTZ2bS8rZ3VxZ2YyUlRMWEtndjNxM3MvUytFamtSMGdOTVZqNytB?=
 =?utf-8?B?WFBLN1A5NVIwSkJWQW1HdUE4Qmw2Q2JianE5YlpsSFpuOCtFa2dwS2sweW9D?=
 =?utf-8?B?d1dGQzVERldKRklPcTMwQmJOVUVoQ21pUFU4TXlCOWdIWW1MY0NPak01Qndv?=
 =?utf-8?B?WWVzNVFLNlhML1p2MW1xb256OWRDNHFmNU40ZVAzUy9JNitibTJ1aUErTHBY?=
 =?utf-8?B?NlJsV2w5RkFmTEpVdzVMWWVWSWtMWkpwNXd1UHdjblo2UHdlZ0FvT1VrWlF2?=
 =?utf-8?B?eTdZbkZjRVRzQTd1Mlhva3BSUGh1RXhKWU1OZlZRWlhkU05tOTlQQjlta2Qw?=
 =?utf-8?B?bEtSQ20xNmwzRmMzSlV2RURvb21kS3BzZVZCemo4VWcvUzJ4YmhXTjFWS0Y3?=
 =?utf-8?B?UWlUeEkvR2d0RDJ4Y05FNTFBLzhLY3Uva1RwR1dmQSthL3BBcTRZd2lvVzNn?=
 =?utf-8?B?NE5yV0RiMnRDaWRzeGZPSmlFY1QxcjMrOGFIVzJLL2JyalR0Sk5OblR0TCs0?=
 =?utf-8?B?TkNvRDd2alZEa2pqbGJGZ3pUb1I3T2YwcXJQNGl1Vk5odlN6WnF4N0c5NFJO?=
 =?utf-8?B?NkVwd0gyWDJNaXIzbHErOEwyMUxrZ3BaQTVWb3lqSjhieVozS2VjbXNOUzRN?=
 =?utf-8?B?aysvQThvTGdCOW9RUi9RdmpaSjhjVHJZdlVtTkU2ekxxaU9oWGh0RS80aUJ2?=
 =?utf-8?B?a1lFZVlwRkRCK0cwN1dOb041WW1VSmFBeFk4ZjBVOHA0ei9tWUE4NW9tYlNu?=
 =?utf-8?B?YVBSVHZwU1g3RGlGV05TdndKNWpPZHM2Q0JXZjZna01TN0FsUUVVRnRYK1R0?=
 =?utf-8?B?TGJxVlFyeFZyN0d4OVFWaUZINjNMSkNUaks5OVZseGh0MmxhRzV4SHdmNXJM?=
 =?utf-8?B?N2ZnNGZ3dXR2N3pSdW5VcDRXVnpFK2RqR3ExckpBb1pGdXhtSWQxRHQzSCtm?=
 =?utf-8?B?TzhEY2VOWjJjZ1lUNGp2a2YrWkdDVnE2RklHWVkwbjVrUlB5bDNkbTJhdDlz?=
 =?utf-8?B?Q0hZcGVyVldOQzEvaWhWWVdINGtWK1VVaDJranBKOEc4S1liRmtnM1Z4ZDJP?=
 =?utf-8?B?U0tESG1oMEtCSmNjZlh3c0lGL3V4bEM5WEtkb1pnSXR3dWdUWGdoTjJGQVRR?=
 =?utf-8?B?TTlLMVpzb21URkRvbWVTMTJXUEZjMUNlTUZwVjlubGx1bGZVVGJrcDNVZ0lk?=
 =?utf-8?B?UXlYcTV5U2FmSEhRQk1PQ3FwMVhxN3p6d3Z1NmNXTlE2a1h2c29WTDIwb2o3?=
 =?utf-8?B?dEdySDE3b0I2YlhYVGFzdHVJdTMxSzBGMnFrS20yYWxSQmNFcmQvTEFxYy9I?=
 =?utf-8?B?a0dySGNIMlBCbzhIcDJVZnRUc0hIZ0pGS2k3QWFQN3FSUnA2eGdzM0NGVVpI?=
 =?utf-8?B?QVJIL28vRVpOam54MjlNYnFiN2U3WnN4MWNaN3dRUmZuTUFxTHVKYXBXVWVZ?=
 =?utf-8?B?T0xvcGl0WUY3MGxJTDVpa1F2dFJsQXNwRnRrTGJ6dDFBNzhDckMrai9xc2hT?=
 =?utf-8?B?cGRCTEZGNFlXL3UvM29MZkFGemF3V0RreDZidVJBSFppZEExek5GWVF6NGtx?=
 =?utf-8?B?Qk9kSE9zNmpRbzMzVW4zcHlzV2o1S2RXd25KWENjQTVTQ1VpeTN0TFpic3dP?=
 =?utf-8?B?N2ovalh0OG5VL2M5L01OVmF5UnJnYXdsbm5LdHVNQUNzMVhVZzJPWlBwU1JM?=
 =?utf-8?B?NERqZHhuWHZ3U0FhY29ONDZCT1RTaEZtV0lGK2dyK01zS0R0RDY4RWlKY0d6?=
 =?utf-8?B?ckFSR1NDVjdQRTZnaG1kQVRjdkRSRlA0WmFDaVJFYlZLTGdKc0Zzck9ML1dQ?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bca8695-a37f-446b-8e13-08dba97fb8b5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 17:37:03.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fw+0wiqxs4RITrfdKQj4Parr/+tUSJkF0CVenFOYzZY+9f342X3/a4uAhjNtdpRK0seECY2sztlFsMPJ4aCPtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6326
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/23 14:47, Ira Weiny wrote:
> devm_add_action_or_reset() passes a void * data parameter to the
> callback.  In the case of CXL regions, unregister_region() is passed a
> struct cxl_region *.
> 
> unregister_region() incorrectly interprets this as a struct device
> pointer.  Fortunately the device structure was the first member of
> cxl_region.  Therefore the code still works.  However, should struct
> cxl_region change the bug could be subtle.
> 
> Use the proper types in unregister_region() and extract the device
> pointer correctly.
> 
> Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Great catch!
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/region.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..471d305ef675 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2018,10 +2018,11 @@ static struct cxl_region *to_cxl_region(struct device *dev)
>   	return container_of(dev, struct cxl_region, dev);
>   }
>   
> -static void unregister_region(void *dev)
> +static void unregister_region(void *_cxlr)
>   {
> -	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_region *cxlr = _cxlr;
>   	struct cxl_region_params *p = &cxlr->params;
> +	struct device *dev = &cxlr->dev;
>   	int i;
>   
>   	device_del(dev);
> 
> ---
> base-commit: 1c59d383390f970b891b503b7f79b63a02db2ec5
> change-id: 20230829-cxl-clarify-ptrs-f38255b7e52b
> 
> Best regards,
