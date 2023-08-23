Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE3878609A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbjHWT1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbjHWT0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:26:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BB0E6E;
        Wed, 23 Aug 2023 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692818798; x=1724354798;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rVK2diL0r4YnsoxUytZ8Z92qXPZG95poF7rh4krVvWU=;
  b=EC9xYLVNm6aH0hfNO5sSuU57oupUa2bZl5uUDfTper2YvkNM4O12VKBm
   PleZB2Zn17CuG+50ZVbLQyz5kUjgk0ZZCX7yPTZVx8CkefO4agELvpkBA
   1cnnVktxSnkj57rJ2JEWF3UVTQHiafuCRyyWKySZUwqVo79eTyh8CVv6E
   2pGD9QA+ZQK+oOLfmNHNqOLlT/EIQzwIriqbBTKXgnTODV/OVNTH4eEE1
   Bdx3x36Jp9hNwCUaG6Au8yFmu3UQjkVM3jFc703MYXJMvL4Qk86pOs/j5
   0W+jKOw5JV6+S1A7JHXzFl4ZDWedfwtUYWXs57xERXeIEtUhjJuWBtof2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="376982799"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="376982799"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:26:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="766258086"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="766258086"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 23 Aug 2023 12:26:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:26:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:26:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:26:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLbKG4gY7AZaQLRYfSwTuN8n7YXkGrqxriqPxqj/7j+Jo4yD1DBTxQK+l4mPf7LlfUqoGqGtsC4tDSpJv6j6KQvyUpBtGrW0GcgqLQYwt3hzMXhAjzRO+eJFFXyJMAs8tdyjMmRu1grNkUz60R40eLKU12PcVNql7zqfHeOuuTzj4ulpNwDh234mU7CNxbfEpuLW4yCBgWemPnjNK5ui8uGSZzUBf4j9M8oHsWxncf8XNNEnqvsrcs7rs33wDqLH4Tzj+Eej1LrURKg0EgsDX5baOzitBWDYFGGzAAzGu4Rpq3m5fQYIPZssJyT4/UqbupXrQRTbNbHXb8aNvdgQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmMp7JdI8H+UrHNRNydFqPaoaHKmYW+SZK9Tg5V9q84=;
 b=TCHVkiiN4S5EbdeeynfFLQEzFqrU5EKDSv24U1zz8QXrhO0vReRPI0PBZxWaKHlJrkc4txNxQEYyhFfMKHxZC36mgA+F6v6FcwGOCIWb8ibCiDyy22VKDFVkkLLeMTPKxRC8LsKE38qwCVf0lQnUxHT4Y4kGuvmJzDa4FN4T3sLsd3H3HUGjk5SC1KfUxVmLURpAUkEPSHQmjFOhC4gkUm1yPJaTJ6T5Y2lENadG7D7ARV4f2W5VZoNZU4HfFeFvPyv2+nRp/DIaVcgJdt06+3xvPgs+tz7pNW59JGFXLla8m5lWisAgsSn4mgWysKRNhMqWI+DVZmFi8IJC3rdr1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 19:26:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 19:26:25 +0000
Message-ID: <72255d4c-5c69-e58f-b7b7-0de2bb58173d@intel.com>
Date:   Wed, 23 Aug 2023 12:26:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 5/5] net: ti: icssg-prueth: am65x SR2.0 add 10M full
 duplex support
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Andrew Lunn" <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230823113254.292603-1-danishanwar@ti.com>
 <20230823113254.292603-6-danishanwar@ti.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230823113254.292603-6-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0366.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 4731c220-32b5-4c5e-6206-08dba40ed749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxEZSCzXDKLpb7rqMhTaFngKYm5AxNmnODfFZk0j/mzgI9lSn56TzSymwKqANknUSSTXOb/LgyDVagTmcxhhYd/jsK1dT4ntmTwOBrF5uvhinpj76XmM/vz4GbQ0bW0M7rEPJDS8uK1axEg+Z/jZM5siMTN6L/IOQJfDphkuTj3SFSr3ca162XWYrXUaQezwrM4cqD8GxrPCEFEUGNrbZJhzuakeF8o9eQDKT6ZqMZftJAGO9IAYUzo3gTyzkb7YIrPP5XDwdXAekC8T2nNKEUNdWkrI4/Ww5RmY56eOn02iUgh5+BOOH3JK7RXdqOCcayZL/X/cOBnyP7y1EF4HRaMzxVgZmu0dJKwvWZ0mmww35EUjh+CTT8MtRLjD/JvRsS7wNuz5WOPcMjQVgRKGqDnPzZxBAJKj5Iq0LFP4uSiYO0ZYAJJ2LAMTAzILJ6YZud5G0RkPpXkYZxCbVJH2o/bLodOodl4JFht1qJTeDpVABJm+zVEhJBtH6KN2uXBWLarr6yqjgQMp565ud4Hdp0j3PA++s6qXQBpSUXxWDn9FsEsoYHC/n22z9qawfSSwG1XTNRjUd5A9hQM7mgjnOssgF8Q3mF2YcM9B795xPL2pzi43I1RnkrUdCy4MJQ5XbMELiT6EJn8SLe90WbeMpbXNqrpP0p5+gk1Q8MQJVuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(186009)(1800799009)(451199024)(6506007)(6486002)(6666004)(53546011)(6512007)(921005)(86362001)(31696002)(38100700002)(82960400001)(36756003)(26005)(2616005)(2906002)(316002)(66946007)(66556008)(4744005)(41300700001)(110136005)(66476007)(5660300002)(8676002)(7416002)(4326008)(31686004)(8936002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFU5RXNRelZLWWUrOVVTaXptYVhndU92WExFcEZIZjV6dllhYVZZUHdnNWt6?=
 =?utf-8?B?NnR5aE9Gd3orbUE2OEsrejFvVExQc1RJM05LeGpJbWpRN0NtMklGdXRLZU93?=
 =?utf-8?B?T1lNMllFMGFxcHBtd3V0MGtEbGFwRTZIbTJobzdVaXVYMEpvL2dERklWcmIx?=
 =?utf-8?B?ZUxDNy9WZUdJVGR2S2pLVmNkclJzOFVTaUd2S3dtaG1jZUNXdGdSTGswNU9B?=
 =?utf-8?B?MWpTdU43VzRBWUdJWFZqTW00a2tXQTRDc1E4RjJhZGEvTmNJNlhNMGV6MnFT?=
 =?utf-8?B?S3o4WEZNQlBBYXVnaFlIYytuUVpKcy9HSHZHM3h4eDdvbW9rSmdsTnFVcHFV?=
 =?utf-8?B?QWhhL1lONEFnK2did1pJcnBGa1pkSmJGbm1oc3V6aGpPMVJ5K0dFaElYK0tq?=
 =?utf-8?B?YXQ0bjNSQ0QzTlZTaVFoa1hobHJJY2prWHNsVnFMcEJDZHYzVzhFd2ZNaWJ6?=
 =?utf-8?B?MHkvY1B5Ynp3T204cTIyTUEyUUdvUkVhbldmdkxCNjBaOGhBakhtOGNQeFVn?=
 =?utf-8?B?MWhNdGl1THZXZ3FweEVFaFFmWDU3WXFKaEF4MHRZbVlUSlQ4M3JlenZZMzBl?=
 =?utf-8?B?UmVkM2lBeEozNGtxVFhPWlhzUUY3MWFYWnNIaGtweWZSd01oby9ERktvRm4r?=
 =?utf-8?B?azdFZnF6b1huK3FJNkdzY3lSYlNDcEhXcktMUE5CSVBaRjh6bU9ZWTM2NWEw?=
 =?utf-8?B?WWQzMkNFVDgxbzcxSGlGeS9FTlJCZjUvV01wQTBjS2hRZ3ZpV1VYZUJvTkxi?=
 =?utf-8?B?Um82dUMxTVF4WTNYSU90MjlQWHZwQjM3U0RxcTFpQW1SMkZoRE4xL2JhQ2Fk?=
 =?utf-8?B?RDJjVTA3UE9BRTRtQ28rZ203TVVQMTJkZEF6dWtTaC92V3F3ZDIxeHY0QmNL?=
 =?utf-8?B?M0U1SVVoek9oS1N2UXN4MEd4SiszMDVBK3JlV21DSlRZcmJBbU5BUUZXUzcr?=
 =?utf-8?B?S1hyV3ZYck5PdVlaVmY3STZDcEF3cnVXQVNrVEN6blQ0bHNXWktaTTFMa21r?=
 =?utf-8?B?TVlVR1ZEZU5KYytvY1I5Skx6K2FyMGxtM0MzNEwxSzJDNUhPWUloQ2ZxQkxv?=
 =?utf-8?B?NTRwWGNFS2xja1RGRGRYYlpYYzdBNlI1ZjM3K2FHelVGNy9ubGRlcUZvN25l?=
 =?utf-8?B?NEltMllSdjlCR3JDdlNNbUJ3c0xXamNYeUl2M3lrNkw5U3RvY2JhODBIMzcr?=
 =?utf-8?B?QWVqOUtGdWFoOFFOczV3blFtMEF6RGFZanJlU1FvNGhwL2RHRnBGbm9UcXNk?=
 =?utf-8?B?ZFR4Nlk0N1ZjbkoyMlpDL2FvaUxZa2d4cHBVQi9EK3E1VEdVQU5QK1M1WHR5?=
 =?utf-8?B?a2ZPNzVEbDRHM3ZoZjZreklxMndHc2RYY2RBb0d3SEV5SmFHM0t3SVlSaHlw?=
 =?utf-8?B?Vmhib2d3WUV6TFRuM3g3c1p0d0plS0VIeitJeVBmdkxFdmMvcFcxREZOR2Ja?=
 =?utf-8?B?M0VvRkNiR2hHcGtPZnJaMGVIWTlRUVU3ZFFSemJwUjNYWmF6R1ZTdXVKd0hh?=
 =?utf-8?B?YXRwTmYreER6aEpnWmJRa2dVNVB0Ykk1Y21KYkhnbnptRW0rWjJGV0t3bTNM?=
 =?utf-8?B?dm9mM1NEcWx3WEN1L1dXbERZYzc0Q2E2YnJYVUMvVXk1MWI4REdQc0UrZTJW?=
 =?utf-8?B?c0JhendUZHlmSGRMc0VkODQrSVVXNXJNVFhKTXM0NjFVWWNoOWEvbENrNldm?=
 =?utf-8?B?QkpHbXJ0cWhzMUVvWDNieXBSM2hqLzUybHhzaithUkIweWowejZGckk2RUtZ?=
 =?utf-8?B?eTFDUEZtMUhHS0xLRkg0ckRBUU9icHF2V3MvMDlReEY1S3pJOTdza3dBWWox?=
 =?utf-8?B?NmR0MEo1cGM2ek5VZjdQMjFHekUvZzVkYU1Rc24yS3ZCVUVDRWF0cDBtZ0Jj?=
 =?utf-8?B?RmtLN2hQT2dXV0JVOXNEdTFkeTl5bXVWM0NyTWdsYytJQ2NsMmRsbEYvYUFq?=
 =?utf-8?B?TFI1M050ckw0TXV5RWRhSVVxVm1HWDJscDhNcmFUMHhERVZlTWRvUGNpMVF6?=
 =?utf-8?B?OEVxQzZQWVVQQU9GU01FUUZWV1RpT1grc2NDTXErcEczMmRveGhjMXFlWHBm?=
 =?utf-8?B?ZFVDWmhuZi8vMU5LcGpPV3RNQTBNclJRU0VpNkdqTG5HVWZnV0cxTmtObEdB?=
 =?utf-8?B?OTNPMEJDbUZjRHFsN2FMOHd6d3BkaUFheEV1YzRzdTNZc1lCWnFwZkVKN216?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4731c220-32b5-4c5e-6206-08dba40ed749
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:26:25.3320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FujwfqwiusZ/W6ZDCBUksRYdlxZLCcnWAHUBm2eWCLyf44r6rVA0u/Es44bwJpTe6DvZfyrFpMZ6rOieZvfJwuOiIq05LkmWKGxObny7EhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4953
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/2023 4:32 AM, MD Danish Anwar wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> For AM65x SR2.0 it's required to enable IEP1 in raw 64bit mode which is
> used by PRU FW to monitor the link and apply w/a for 10M link issue.
> Note. No public errata available yet.
> 
> Without this w/a the PRU FW will stuck if link state changes under TX
> traffic pressure.
> 
> Hence, add support for 10M full duplex for AM65x SR2.0:
>  - add new IEP API to enable IEP, but without PTP support
>  - add pdata quirk_10m_link_issue to enable 10M link issue w/a.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---

I should really checkout the regmap stuff :D It looks neat.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
