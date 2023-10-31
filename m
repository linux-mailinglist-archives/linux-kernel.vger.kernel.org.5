Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC1C7DD6C4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 20:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjJaTsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 15:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjJaTsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 15:48:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BECADA;
        Tue, 31 Oct 2023 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698781682; x=1730317682;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i/pvEPeHhplO52sLPReZlO2hD7CWSRcrB93zxeInVO4=;
  b=XqWHVXqpDtFcxPk+YHaL6pQHhOWi9IJITtJlMDRmrcV7Fg4VW5vaZ2yQ
   LCBPJuYl/lHtk4GyrmCsZg5edgxBlcwUXIDs5LKnOgk8vKyKtgfa4oXkp
   wZ7F0J0Tzx9JgGRusKlez6lFvd3YuLVJz8jCgoa9UENaX+FatisyeDgo1
   vIk2Z1HtvbGXCFVdAr8EM2+gySNTM6MMa6mxnCXa4+z+memfklYefGkgX
   4wWXB0tdt5Y7OwlKx0+DgQyMJ3QWUg+ZfF7/l+BuPweb8SGg5Ta113KMq
   SzAVVtYXNynEfbl26RdVqHHLZbPAVrHQwB1e4hcVwLwCBtZq5/1i8970J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="368569087"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="368569087"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 12:48:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="789896153"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="789896153"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 12:48:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 12:48:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 12:48:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 12:48:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5NhcvMF0NqEjjdtBcFDOK2mTkxm8as163DCFtJhIJQuD/zXxXbJk56cUvjuPW2nMJfAG8D1FM4ZGreuPxKOQ8QMlUH5627/nbJGZcgJDprKTsnhlFNdCXrr6m3L1vaC5G2UulJJH4UwNB0Ai48yu1O+s9XqLu8A+WvJcxZXLWPeBEWkt9Q9cVs741dowqJ0skZaqGg84dYBNzsHGx853BIrJkJSYLhevvt8UXNbVuPg0r7U2LC4y0HKMwwVnpEMNuv0Iwttww2Kk3u+DbtWH2p4VtwVMBZe1pF/cLagQj0rUFCHFvfPkdBWEaqGeQmNSYDZbrvrGtTr09GE0LlImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4+RhzuJzXyimMlQtGwBW0gLj/Nmj4xsF6t3kce72kc=;
 b=R3musz1IjQEamL2px/R7LupnbNx+kGOq3aPQSXKtVHqZ13/1Vs24VgWwbf83z8i79EyxsoUK9Ei6JPlTCApr8sPkT6HfdxeZn7hwFb9ky5t8zm3AoOR0s7mFlBdNpI35d2X+9AjhRomrEGv9BaW4G2y3XEqy8XWPS0bV+t7pn9r6MhDacCmi5QIF/+LarPAjDmaQj+IDto9ilOtYfbmANAnA+ExJ9VB5ezDQJBgsMoHpEoNUPzuxGP8Wcdr5Z7ULgSTzm84dBZNpkCX38tm3XYOBESCglqZzLhrmwrxtTaf++QkcJCDEicpVKW9X2fq2LlWdVmjd+4m9wkIceWshcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7639.namprd11.prod.outlook.com (2603:10b6:806:32a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 19:47:58 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5e89:2476:6382:34b1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5e89:2476:6382:34b1%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 19:47:58 +0000
Message-ID: <988c1d61-ac0b-452c-9a99-04f59145598a@intel.com>
Date:   Tue, 31 Oct 2023 12:47:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: stmmac: xgmac: Enable support for multiple
 Flexible PPS outputs
Content-Language: en-US
To:     Furong Xu <0x1207@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <xfr@outlook.com>,
        <rock.xu@nio.com>
References: <20231031022729.2347871-1-0x1207@gmail.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231031022729.2347871-1-0x1207@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 97eea8b8-f817-4f5d-31b8-08dbda4a489b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZudmLC89HvaSC30F6oBeG8/8GcE9FdQbPaJvsFqj3F2T2ZChDsoYFYOcfUHfPfHasjJsH+vETLqAEWyNpqut6yyZsE6TmkFKyfPb0AQV8S4qE913B6qKg3IxAy6d+H4spWGDXRuZLOhVcBt8jyX839oJ23G1D0KuyUggo+uFmjPn6NI0ed/bp2Xa+RJiogTS99vP9M0hQbR34LWUo8Xr5RwK1iAJhStr7+btneKeXRmHuu8/8d+Q3BASQgJe5fn1s3XZ+mV3Uut7yILIVKa8y+E4KNnfzQQZHBpAfcV5GaKbD/yy9rpQph+1FnD/odtuUMAJshpO6fleaeIjSk+fUsO88ZQFHj8dPE1SrdRy/c/CURSn14sxsSsYPVCJCYGtkkdmbYCqrtvmgqu7StIz1gHCNoI+F6EK7SLVZ+WPHVsDI5GMjmVx7eOqWs4oHb+fTSYmzzFDkla4/y6ndbflTen0XbKZqy/aEudzgoouspwrxqiJWaXZYhVNMs+TKMMDCw90JYkxO5drK+z6gRyzz/LluSs19mQs4NvPUVPZDsFQFoH2Q90cpHG+SP0cd80sB/T3uSACViD5GziQk9Os6B0hHP7CIa6sBTRdkxj6WGPpe5zttPy8gIGRi6fcqorEqZJKjk+Bd549TqAmsguhqEzgqIwuT+WYn0bzYjgP3rc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(4744005)(8936002)(4326008)(8676002)(5660300002)(66556008)(66476007)(66946007)(110136005)(7416002)(478600001)(2906002)(31686004)(6486002)(316002)(41300700001)(6506007)(2616005)(53546011)(26005)(921008)(36756003)(6512007)(82960400001)(86362001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2pIK0d3SlhHOUt2OFhEU3lqVkVvZnUwcFZHeXBKdDZrSkhzVkF2emRMeGRN?=
 =?utf-8?B?OXRhc0JqZjlEbHNIajQrVDhQU3QyNUNYZmJjSjU5RkFmMTNaMDZoekVIZU43?=
 =?utf-8?B?MEEzYzFjVk9BT25NK1h2WWZEYXlMc1puMm1jTWN2Wi9wcEh5VmYyZW02ZWNv?=
 =?utf-8?B?NThqbkZjYk5yenVOQWRPTjE5RnJ3R24rY1JjYklqU3dBdlU4dE5UWEZnYm1s?=
 =?utf-8?B?czRXVVEvdmt3cTQvQjBnZXlhejZ6OHl5cTg5dzJENmovaHJ4VVBia3pSdVpz?=
 =?utf-8?B?RytMNU84ZzlaZ1QzaTlINmJoMGMvM3FMcXl6bkpyZVl2VUVQWGl0aFFWWEt4?=
 =?utf-8?B?SUQ3OHpJbEFMZ2QzVGlMZnpkemw3dDJwRkVtRGtTTzMyY3J1U2RBYmlJcDBU?=
 =?utf-8?B?Mk8rVTFiV2JCbTRySHgzd3NWTGZLZDY5VnlBNFdTR290UzFBUzVpa3ZGQUlQ?=
 =?utf-8?B?N0p1WmNzc0RPM0YrZk9SWlRQclc5Zi9uVDB3a1U1QjZCWlJPTmlTSEZGRWZx?=
 =?utf-8?B?YUxWanNYbnFsYlZvTlBvc2RiRzFmeGxYVm84dEJiOXhoYW0zYmZ2RlI4aHBY?=
 =?utf-8?B?VUcxWUJ4alBHK1BqWkNscU5MeG5FcEtqQ3NHODRNODJxU0o4b3Y0VkRhaGtT?=
 =?utf-8?B?b2Evcm1uU0p5MEJubXVlajlMb2VwU2JoSmVXWjhLQko2ekJWT0RoQzVSVWtY?=
 =?utf-8?B?MFZRMDA5YWlkMFRibllZcUJUeGtZdy9PZTlQWTgwUWx6NVV4ZldoNHJXTWNY?=
 =?utf-8?B?VVpBSW00QkMrbFBSdlhqMlM3ZGlGSTFUYU5hUDFCdmFFSHV5VjB4UThKdzVF?=
 =?utf-8?B?UVB1UjdpcjFWL3h3dG9nVTJyVjZaRVhlbHpTdVQ3NzA4ZnFGaFhHb1JPb3RQ?=
 =?utf-8?B?RFplK21RbGRwMzVrazl0Rlkrbi9ycXlFYjZLeFpIRWs5azNxT29naTBubVRY?=
 =?utf-8?B?dE9BeWtCbVNrNDFQVFRmVXkwUi9heEVUTk9NMHQ0YnltZ3VLK0U2Nmw4R2VH?=
 =?utf-8?B?aUhrT2ZhK29lWkJqSytZZlBmdmJUREttVWNMdkJRVHIxaEx6WU93TTVVWFlt?=
 =?utf-8?B?RlF2aVBvU3hKb3c3QVNzbkFSMkxlZzJHcU9lS3M2ai9XVjFSdXJaemcva0xV?=
 =?utf-8?B?V0dnVUxuZjJ1bFVNdGsvc3drWjBTWGRvQXpNMUEwdUFrV0ZXS2s1K3FINlJp?=
 =?utf-8?B?UG5RQTNOaytnTDF4UGpSb05xdStHeHpRaXh4VXdoSC8rWnVtaUQzRll1d0FZ?=
 =?utf-8?B?L1FraWcveGNyLzlZSXZ1SlU3R2FOMDFPdkZZU2NPMFRNUjZPM3ZFVWt5R2tF?=
 =?utf-8?B?YTNPVFpsTFR5cmU2Und6Yi9nTlh3OWl0NDhwME5sTDdLYU9YR2ZBaWdUUWpC?=
 =?utf-8?B?Yk9ndkJBU0piSk0va2hKWVBXaVpvRzhGd1Y4dWNSSDBEUUNQRkdMbm1JVjd6?=
 =?utf-8?B?MnJmdnJtTkdQYUZOdVhGNEorR0xaT0RWNzNidWJ1M2hEM3RhV09jeTFwQWlJ?=
 =?utf-8?B?N0hSVHlYWlJzbmV5ZkI1VFhiUTJocno0VldPenluajAvaHpLd1lUK0ZEcGNp?=
 =?utf-8?B?cjRmcWgxUWc2ejRPM0ZFT2VXTVNBNHhTcTFxZXRWOFpUNDhwOGtnaGN4OC8w?=
 =?utf-8?B?eUQvWG43ZUJiUDB1a2VRSWpNbDJtb2tvdFNZbzNpeUFtTUhmT0xvYW52ZjJw?=
 =?utf-8?B?Qm5mV0swYTdzd1FvMitRbXpWY3NUZTNNR0ErTVl5RU1RS3d5V1VjTkE4YVlR?=
 =?utf-8?B?WUxpM1ZKT29yTzRzYXIvNkhzbTQ4VEMrU0NQQSsxdk1LcDJLZFpCUE1kR3Bz?=
 =?utf-8?B?b25pQVd6Y1E1d3pJZFpCemJmOWdjbzN5WnRoQXN4WHZ1TDgvWWw4TTlzVERH?=
 =?utf-8?B?cGh5SVRKbytXMUNRZlNieEhzbTQwYzFrM3pBNXlQNm40KzBVeFR6RkNVZHI2?=
 =?utf-8?B?Mk1NaDZHeUl0b3Zmb0xsaHByNG92cnVXb1V0cGpleGFlS2JSWVNJNHBRTHhG?=
 =?utf-8?B?MmRMd3RpcTEvbXp5UnFTNTZUS0lYY1lKYklpMzZaZFFxQzRLMjRNdWpMSlpO?=
 =?utf-8?B?dm8yRyt4QmNrTTh0dVJZMVhIbHVtOXV0V2drcVRQaHlGeG1YaFVrNlkzWVpL?=
 =?utf-8?B?aXJlQWZEV3Rmc3NnR2VQVExtdnRJUVBIcjcvZlZIRjU0OGVDVkdaTzYrREdl?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97eea8b8-f817-4f5d-31b8-08dbda4a489b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 19:47:58.4594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aLu8GrrpMZ3GjNSGmhWM1bd0Ya1OI89nB48BjxMcwSIZ1YuHzl4k1F3WCStpgA7ItUzCf+BPGlMtmC1+ix8bFHn20fhXF3JFjqzoiVsDZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7639
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/2023 7:27 PM, Furong Xu wrote:
> From XGMAC Core 3.20 and later, each Flexible PPS has individual PPSEN bit
> to select Fixed mode or Flexible mode. The PPSEN must be set, or it stays
> in Fixed PPS mode by default.
> XGMAC Core prior 3.20, only PPSEN0(bit 4) is writable. PPSEN{1,2,3} are
> read-only reserved, and they are already in Flexible mode by default, our
> new code always set PPSEN{1,2,3} do not make things worse ;-)
> 
> Fixes: 95eaf3cd0a90 ("net: stmmac: dwxgmac: Add Flexible PPS support")
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v3:
>   - Tagged Fixes: and sent through net instead of net-next, thanks Jacob Keller.
> 

Thanks!

-Jake
