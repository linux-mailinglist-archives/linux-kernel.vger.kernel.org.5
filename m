Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21BE76BE9D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjHAUlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjHAUli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:41:38 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540D61FFD;
        Tue,  1 Aug 2023 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690922491; x=1722458491;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G0QWi/D9wZG6ZkjXnd1VLMOFSEas7bJXU++U8kxkJ+U=;
  b=aj6vHeOovKDKIk3ZPaPAX3k4lIxjcOO9hxR20epD1pUszbwnEWUjB+WH
   bfoJPHNtocEI0L1sbovge4CKKnuzzFHUB/y4gG/Ed1FA/3qnIJHP6sw5G
   pr6I74P03NxKxao2e0S1xtlLtyUTrxDW5l6qDX9FrIdHOhgOjBHnaSqm/
   KgffSGWzkBEG4U8GrhczIoOtGrJZU76GjiUVZ0OIUaUWJCanyscdun8fB
   xJt3Jad62KpiIJf1LPEVls48zMTp9DytWEV6ieqQiSBwsxIpfC8oX6xws
   Fj/W27viDgM4dQK9lS3amfTFK3hkPqJnB39R/vXqr9RTUQZYhxR/Vs3r9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="359448109"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="359448109"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 13:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="722605837"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="722605837"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 01 Aug 2023 13:41:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 13:41:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 13:41:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 13:41:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irwWgcmiEJ7OgzrzOc6bup4OMDh3FTPH7YTyqxF5DGcC5I5Yb4j8+K0342AjICSUy1uYQW3iAMV0UBxSH/OCo63hMoFCa0Gn1V14kzLlWHOYj6cYdo0EYulKmYeoqMVuCo0jsqHjxfnCYQu40fYVnUeKNwR2DTgzracjX81zq3EJR7sc+9GDr5aD27HeZL9bwyAkpowP03IpalrOfa7/pFlpTq3sS8EIza5XJAYDhpgPcOsZNH5fxfP/z2nkWqbiODX/W1nz69f9jQOTl2ASAtFjhinI5HbyXsmMW/dx9TwO4nA/g6Zq9nH7KqaPLmagYw+tr+mZE0MbWFc2bwLwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=824FkEEVlL+YTQ+QZ1OBq1CdfI+x3iOlSKwg5sPRfjw=;
 b=BE9SbKPH66wuoNudSLg6INHWSSe3NDHRtal0cc8IJdqHLewVgY9msIFLV8ll7Uqm+qpjxzSfrXMNPxYEDCaKckRcifjO6pOzL4QkbNEd3nVguA3Q34gyWdjLG55BJWmtD0b5bo1D9VHb1rhOtpED26kPdFhJNTquyK5raGq6i/27dXBIijY6r4dVxddvnkG4AzWp0Bp7Wog4kzOyhVyZgxpmy6RagpB51ExG51dTlNS9eJsSGHlyG1UfC6mnCU8+Yxvdma/+3DKxK5Byn3rY6P5PrPzeq8NB1nd5GmaB2+a6cBejpkMGbtecQlXNARSlONK8ozA2obpSgpccbAPKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA1PR11MB8596.namprd11.prod.outlook.com (2603:10b6:806:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 20:41:22 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 20:41:22 +0000
Message-ID: <cf65724c-a351-8369-156d-ddf6fa47f97f@intel.com>
Date:   Tue, 1 Aug 2023 13:41:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v2 2/2] cxl/mbox: Add handle to event processing debug
To:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230731-cxl-fix-clear-event-debug-print-v2-0-9bdd08d386e9@intel.com>
 <20230731-cxl-fix-clear-event-debug-print-v2-2-9bdd08d386e9@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230731-cxl-fix-clear-event-debug-print-v2-2-9bdd08d386e9@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0046.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::23) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA1PR11MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 054c9021-5744-436d-5ccd-08db92cfaa91
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MF0/HIBD+Qha6WUjhfKJT8sLtzmmVal56WaZRt4vGRUSdy+n+Xg4ant7uX8zM/kY00qa6vC6n+UMNvV8EyAnkeUmm9gWtINNcLPgJTGiftx44WkEIloCRMXo8MczkC13bEuvjG71aZ/fFvspjR3TaMoNLPlnsrXDIZlwU3KXQEc2qN0pvFg2LVF+peCkr056zgbYEuEOTge1Rd8s/vLQj2uLRFWF75rv3zk5cNvqA9QMUtF7Sls+jSjHX7g/bOFtz98Ew0UhiqCadY/BPyXoRsKKt79uNklCHqYgRpxL2+TSdyGW8m+ivaGWM7ZKQ/Y+UDqw7CjZP2DkfEf63u3QqH4ejTu8y1U5+b1h8kccMJPp4+V+hNGTZzUz6rWbQMCBDLJ/Ydcc20EvQHZXkDbORcmUpezIPTmMlpYJEiN75xh8HsA19a7G5tMq3fZcJ90w9dtFfc62Hh8fPB6Ck2Wci/JiNpQwAUoAtj6XO34yIceSoN4aggQJODdYMenrfLSggKxINArpEX1DsfvaC0Ls8VIqaOyvop+6ZMIie9eCyrSLgWp3IIn8TmS1j+XuPyvJ2Mvy7EcBRQG4uC5aL5YUrAYmHHjmw6PFGdt8+7PjAG+xJwuRbid7qrxm1tmAnAVQIN/tZpWwjBHDq5oiHNg7yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199021)(82960400001)(110136005)(6512007)(26005)(6506007)(6486002)(36756003)(8936002)(8676002)(6666004)(5660300002)(66556008)(66946007)(53546011)(66476007)(6636002)(4326008)(2906002)(4744005)(2616005)(83380400001)(41300700001)(478600001)(31686004)(38100700002)(86362001)(186003)(316002)(31696002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elNXV3QxNnBDOVJwdU9YSjF4M0JwT0NobUpVdjd3R3NldENzenhiZ29icjlu?=
 =?utf-8?B?bDZuNnJLOUUxeHlHZnJIT0xrWWswRmdpd3JpVXd0dEI5cEJ0NUNvV3NldW9Q?=
 =?utf-8?B?Wnh0QjJ4OHQxY1dCT1JZQUtrREpVc0svMWpDRE5UeXl3TVNwTWRvbDk5bUdN?=
 =?utf-8?B?SkhEU1NHcFp0UDQ5UDliVmtCNUc1T3E0czR2cGFrek1xMW1QSE1uNVlGMjhI?=
 =?utf-8?B?emJuZ1JBV0dTS2N1SHJRTnpNdnJ1VnIwdEIydG1mdHpRVU9RUDN3amVINjdR?=
 =?utf-8?B?a0ZKUE8rb0lCUzJNa0xUbTBDakpOT09mY0Jqd0hxVjhkUGk2YnQ0UWp2L3RW?=
 =?utf-8?B?N0c1S3MxdWt3U1BqODJKTGp6MXFEbjBqVDY1ZkNvdE8zSDZadnlOVUY2UUNL?=
 =?utf-8?B?S0dYUDVLN2pJaEVKN3BhdmVwYmlSdU5Pc0dtYXlSSkVxUFJBK2RWTlV1QWZ0?=
 =?utf-8?B?STVzQVNwKzhSMGhNZzJsNnZoSi9SL2Yra2VVQm1EUVFBay9yWXRmbkxkNVI0?=
 =?utf-8?B?TlUrSjl6YWwxeTZ5eGtqT3MwKzNCNUdKWDZETUoyMVFrSzdwczRmUVpYU1pZ?=
 =?utf-8?B?RklxNURTbnplMmFVaXNZTlg4WEErTjJMeUtlMm9jOWZ4QlY4K2xOWERlc3Jv?=
 =?utf-8?B?N2JjZ29aUGFTUk9BMU4xMkZoSy9vYW55eHEvd2JGNjVLWmxKVG5mMkR0RWlJ?=
 =?utf-8?B?UHkvSmdkVGJUWUNjbjhhaHJaVEpTSHBKN0xVYWhPSWI2VmdYS0pGVUh4cnM5?=
 =?utf-8?B?c2JsdFVaOWRJa3dORmR3NlJSd3UxZHd1ZjR6QytOV2x2UVlqWGJ0UDRjcW5l?=
 =?utf-8?B?ZEpYd3p6Q3hsUXAxNnpVMlordlQ3T3Bhb1JQeWUrNE5OT21EZ3RGWHlCWnpx?=
 =?utf-8?B?N2R1ZWZqcU5DeHRjN242OG5OYWcyb2RNT09JY043SkRMeHhDUG9NdUxQT0lq?=
 =?utf-8?B?b29GS3NXaWYwdktaWGFsZzZ1OVRtVzkyaS9hVkFJYStOTW9sZVlrb1VHSldk?=
 =?utf-8?B?YkZGUU1sY3pQcldscGwwZ3FkSU1XNFZ1Y0hJY3RhRjNKbHhNMXAzOVdJRUts?=
 =?utf-8?B?b29xa01OeFliMXVBZUZybmlTenlHMWJWOUtNaHcxU2pzN1BIb3lyTVhzQXBV?=
 =?utf-8?B?KysrcHcyMDRjWjNlUW9INjZ5TkFrUlRDRVJWUzFQUTFOZnFFUC95MjZOcTZh?=
 =?utf-8?B?ckZRY3NpZTJSdFlNeTRxaWhqY3A3dTNuT2hRcjMwbUpvZGlMUnNiTGJCRkg4?=
 =?utf-8?B?NFlvclJqUzFCNGlkSVBtY0RpMkxja3BqRGJrR1BVd2JoeDcxQ0xDVEx5Qlkz?=
 =?utf-8?B?WWZEam13cUN4YTZsTERlR3JBM2N0YlFQbFU4ZXdxRnhVME9NNlQweVFUT1d5?=
 =?utf-8?B?eW04N1Rycno3MC9QcCtJVTFKS1dIN1YyS255Wm5YK2hVTWs4ZkMrY2kxM3g0?=
 =?utf-8?B?MmxXQkpVV2VRSTRBaklOOFd6YUtnNlU5cjE1eVV6clh0c1IzaXhIUERxTHY2?=
 =?utf-8?B?MEY0UFlkNXBmVUljRTcxcmxXdUFOK2E4T2RDVkZjY1BxT3p5UEgwbjBBWEp3?=
 =?utf-8?B?WlRWZmZsclVXWUFQNlJCcjhxa1NEZFFFS05RenhDa2l0a3lMeHlpZ1Y2ME5j?=
 =?utf-8?B?dU5iWVA2RXgwdHNzNEFoY0tmVEQyb3lTUitGSnlJVitjQys3c2ZER0I5ZHBW?=
 =?utf-8?B?ZDhIVklidnU5S3dUNEZ5aFQwdlNhYWdiUVRsN1FwWVJ2WlY3K0VxWWRZbjd3?=
 =?utf-8?B?a0RxTFplZ0V3TTBLZDhnaktPbElnZC9qRUJpcWJ2c0p2UEMwUUx6SVNDZ1Zl?=
 =?utf-8?B?dkx0WjNncFZWb09jRjlOekZrZ3dacWJ5SUlzNWRuU0dLaTF6eFd4d0tsNC9W?=
 =?utf-8?B?ZDNjWkFETkxwYldpRXlOcktqQzBneGtCUWw4YStlOTN6ZVQvNkFhdWJoZHJ6?=
 =?utf-8?B?SS9sRkJPY3hjRTZqYXU2dCtRVWtsMldCSWFidGlCZjNKUGs1bjhxMkd1d1ZH?=
 =?utf-8?B?VGVuMDdlZ0lRanpVZFBkbW1rUnhES05ucXlwZUVLRFlISERFSTBzZGk2WkhP?=
 =?utf-8?B?M0xsZ1U0UG9lREkvVSttUEZiNUo3NWFIZ285Yk01QWVCa3ZqTUdDQnlDclNt?=
 =?utf-8?Q?8DwRotNX5ZBkbK8nMLBvFCkNq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 054c9021-5744-436d-5ccd-08db92cfaa91
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 20:41:22.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNV4gqGet+e40Y1Zdthpank7PVtMheGDMdv8blPzskwVMmxRKWQl/xtvOYzNFnLJOjnEVJLPsq8I+8Oj5aT99Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8596
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/23 13:13, Ira Weiny wrote:
> Knowing which handle is being processed helped in debugging new event
> code.  Add a dev_dbg() message with this information.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/mbox.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a1c490f66bbf..f052d5f174ee 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -947,9 +947,13 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>   		if (!nr_rec)
>   			break;
>   
> -		for (i = 0; i < nr_rec; i++)
> +		for (i = 0; i < nr_rec; i++) {
> +			dev_dbg(dev, "Event log %d: processing handle %u\n",
> +				type,
> +				le16_to_cpu(payload->records[i].hdr.handle));
>   			cxl_event_trace_record(cxlmd, type,
>   					       &payload->records[i]);
> +		}
>   
>   		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>   			trace_cxl_overflow(cxlmd, type, payload);
> 
