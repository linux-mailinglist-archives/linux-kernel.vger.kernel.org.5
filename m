Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227067D1814
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjJTV2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjJTV2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:28:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7EDD68;
        Fri, 20 Oct 2023 14:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697837317; x=1729373317;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+bBDaIyCgeWdSSfEkdNP0PPszT1giZ10J4LsktuvG8Q=;
  b=BLE36/pnyHo0VFoghFsnezOaIM8MdnqOx/QSXxGVKjdl26xvMVS4PGKk
   YjuKn1g5l48n/MOQGsCpKkQ+oue6vVMV1v1kkvJOxDNe1t8KctyoQrgaV
   7axFRPM+1ADgiG0wB7kA3QBWkuzG+hTY3gXLGcEZwEhlgg+4BysxYvVLy
   V2p0u041r+NxS53qZkwEl+kVETQ/+11EMz7nwk+9KCogZWGW7jEELXOnt
   kvPRZoHy34azDHxD+0Zb7gU2aLKg8AqChjogWO4pahmOiV66yU8rSpChm
   KR4KEjPbbqFOfRnRwLWZAYVO7gPrNmZqjpPsEvZvX9R0P33v/CPGXJkPf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="453055980"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="453055980"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 14:28:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="901243072"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="901243072"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 14:26:25 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 14:28:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 14:28:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 14:28:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdlFeiO73QpfaoVb6XJQ128sNKx0KVhaR09D40lhhLXf+0u2HUxYlH4TVAhYY+VnN8Wvrn/hsvcbtoWQ4ERxqSO3M2ZwGuE68/Qjxn6NYyhNqGDPkoOUcwYBk7xfyPkBZ0d5qEimbcQRAi/gjIGw03Ltr2tVGFljWHaJcgruF7Uz24HGvmbhwiTlH36DpHCoOTHAE73CQZHJq+z+1RUFqMSU26kzNlUALGq5nietC4zDykdLlhZ4+M0wgfixhM3zJoI1+1rIi2lfzvYqIili1mqgmVQmATJPkkLsxXps8iIvK/ublFFb6gqv5Ym0M63ElmcH6z6xGFNwVYKBILD71Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xe8PCvC9/R2oPuup+1Dp6ip0vmU6nVkpkqbsdub+dqE=;
 b=is+HiPs18cP4QnlkuvfsohOzALDrMRBDjO4csETfMGl1+IkBDcdavsc90QlHu0T/j5lr5vnjPHHNQL4R7FOaO/nEKXNPQ+2wWGd1c1w6wveu5Vp8vicELNzjFqi+P6dVIp+Ffc8HCmMCOiEIeMjHSeCiRLgwW7q2tpmvdgTHtnt+FaobZdxc1jox05vhlUu7XiNF4myOAAKzrvo8Hj3vVgiYMk2CF9yZwxv0IYZomFE0shF71Ls7nqj9+jO/NpKfwL3fLSCNJCCaYhlQ18X6rJZ3hjyAwuf7I/iTWHkjX5v2nDB7Rodd4fFspdHifYExkkbQh7fJ8NcI4EqvKbyG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN6PR11MB8194.namprd11.prod.outlook.com (2603:10b6:208:477::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 21:28:31 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 21:28:31 +0000
Message-ID: <dadb40dc-3e09-470d-9eb4-8c725249aabd@intel.com>
Date:   Fri, 20 Oct 2023 14:28:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 3/6] i40e: Use DECLARE_BITMAP for flags and
 hw_features fields in i40e_pf
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     <mschmidt@redhat.com>, <dacampbe@redhat.com>, <poros@redhat.com>,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231020193746.2274379-1-ivecera@redhat.com>
 <20231020193746.2274379-3-ivecera@redhat.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231020193746.2274379-3-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0364.namprd04.prod.outlook.com
 (2603:10b6:303:81::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN6PR11MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: fa47b8a8-177a-4835-4e93-08dbd1b38206
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0JlwYBUpnqcBk2xh/2uJBuoqic/zATSbJ1rNuw4ydbMt2tq/Ez6urufL9coIsjsB3WuODiL37dEdqVirf81VKJkRXW79BOsLxKrHSSqh0LPbzMogD28uhrvNUtgbZaIWH9yG77z4OFZMvm+ihSUKMmGmzhUeSrJOR/YUHyEHiMIz8scvyovx3gs/UcBuv3AWdJlcDwfPSEtFQ65JqEfymS3+iuS20xhaC8GnHTmX3hY4/QhRcQFx8Oaw+tob6vXk3zA8X5CsQTMWxBe5G5NEf82ffDJYKtWc0mAbyGzJYHFXHWefT2nDAjt3fIPRq+pycTozt/Yc1gEEcW/fY9PPRcGi5K7ZLTvedLPvZpCamNAfyrdIPnpKcNuyF936BfGwcyyN9HBUHgpfM6Yq1uW1yxWwEJJeluNhmSVw3f5tlEt4iFcwhw6SelP+N3yW77mLRAj4+GWf9v6jUITm5TWfRXY+I5tTGyju1iy+ePvrBAsbxVbmshleFeWzZ06qtpurYQYi23V71dCl671hWnyEItHiP/KyzpPJejQndlbX2BYgiVvHd3TGzfdqsAHVsy497du9ZFsgyPJ2LtgBZMmE8lkUh+NXWAvZ5VhfmCaH7Qc3gKpl+I4DPll/LQ69cpPoUy0xMeUohjJvRwVP+Ch4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(376002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31686004)(66946007)(54906003)(66556008)(316002)(66476007)(83380400001)(26005)(2616005)(53546011)(6512007)(6506007)(478600001)(8676002)(4326008)(8936002)(36756003)(38100700002)(5660300002)(82960400001)(7416002)(31696002)(41300700001)(86362001)(2906002)(4744005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkNRUXNKQ0VJTk5GQ3N4UXR0REh5bEltRWttOHJOemRPdDJPNTFPVm1hRTJv?=
 =?utf-8?B?Mkx5Tno2dzRTSUkvSExGT08wRjVrZ2tOcTR0VFFsYVE5cmprV0QySXdVMXE4?=
 =?utf-8?B?bFE2Sk5tbEhGamw0R3RVbG1zSTMxeFVrMElwZ2liOTljRk5hUWd2VlVDWCtP?=
 =?utf-8?B?UEFZMmh0Vk9WeDZvK0huK2NXZ2VMcXAwMFlOUDJTaFdpdmJCZUJPL1RTWW13?=
 =?utf-8?B?UGE1TnROckVyYitXTC9JQ2JXeis2S1VIMC9CYWw5eEJVd201dzZJVUcxVnlE?=
 =?utf-8?B?SzIyTkEyUUFaRkR6VGNBL2Y0a1p0azQ5bCt3bHkvdjJrckVZYStqV3lXVlBL?=
 =?utf-8?B?MXlCbkN5VzBaanhHU2NkZnBQbFdtcFR6SjlLNlJCS21DTmQxMkN2UTNmMjQw?=
 =?utf-8?B?QUFXamZmYnZ2cVh4QnQ5ZmdiWmxBeGVBdis2KzBCdDZ2RzlvOEVKcEVSbFZT?=
 =?utf-8?B?bEV5ZlI4S0p2eTBEdzlzZ04xVDcvUEdjcGhZL1VJdEZaeGV4YVE2U1FwQWlG?=
 =?utf-8?B?MkgybDgrNjRydXc4aDNPS3lzc2ExYkFNbDhCa1FJbnJpeHJDNGwyRzNML0FW?=
 =?utf-8?B?SnlRSWpGUWQ1a3hBN2lZTWNJejEwZkFHMGVvaGxETXdJTTZzRDI5R1M3YU9L?=
 =?utf-8?B?M2tlb1F4L1kvTkFlZEE1OUFHWjBBeks3dlcrUzNTenN4TzY2Mk5pR0dpd1c0?=
 =?utf-8?B?TW5uZW9WeTltdEQyQ1NzVnpVTU5INnZXY1U3ekZYSmt2NmRmT25OWVlENjZ3?=
 =?utf-8?B?UENjMTdnbklnai9HSjVoNGcyczd0QnhzNU5kT2FEbFVuS2IrdFJHSHF0YXI1?=
 =?utf-8?B?UGVZRlJiWXJtb3llYmdIUjJjTlUrWlZWN0w4VFowWTNyNGU1dlljL1Rzek1n?=
 =?utf-8?B?b1A2V3JJVEVxb3BEVVdoRG50blJUS01nTm5Od254YjRGYkl3MGN0Y3VLQ1lH?=
 =?utf-8?B?c1ZjSDdTSmZ3WGV0ekc4Z2xpS1ZHMVJsY1VmVTl6YmJBajFub3lXc0gwTGly?=
 =?utf-8?B?TVo3Y2dydmthMlRGQkt2bGsyTG4zRHhhR3JuVkFvWERjUnh3NmI3VjVKSThJ?=
 =?utf-8?B?MHIzN1ZqVTVEU254bkhpRG5xZ3BlT2hZR0pEaDF4WkRiNE1yREo0VXl4eGNM?=
 =?utf-8?B?YTQwMXN1d01uWlZoTjgzeW5LbTBidkZqV3ljb1A4dnlLWHFJSWZncGh1dCtM?=
 =?utf-8?B?Rk55K1pDamlOT3NGVXZFWDdEWWxkSllRWGlwdEZwQi9DYktIcVM4eXhZMEt6?=
 =?utf-8?B?bFZaSjk1SDlWQ2tpRUlOSkRLeEdtdWg4ZlJKVU9KYk9WcjJleFl0c2FhZFI2?=
 =?utf-8?B?TkhDUHZSYUd5V2FQdU5JZEp6WVVHQUU1MTE2YkRjbFgxWjFwQ2ZxWkhYbHY4?=
 =?utf-8?B?L3ZvNmlJdDlESVlXQ0p3dWF6YWpVNkxEN1BwQmdtRnFVYnI3dFJEekFneURR?=
 =?utf-8?B?SnhxVmFYRCtGaDljdkxIcE9lM3FGM21JbTRTd0s0SlB6bnVFNFNkaHVuaUVC?=
 =?utf-8?B?YUdsQmZiRTFORzJZK1ltQm9hQkhkWjcrV0l2Njhjc09QamVaZmZiMVZJVjAw?=
 =?utf-8?B?NUVTdzZCWGdjTzB5dGVMd0U5RkFYOFVPRVVaR3BiV0ZETTlvNGUyM01hbWpX?=
 =?utf-8?B?MitaRTRPRVlocFN1dzRNQ2pHZWdmUTVsY0gwZzBMS0FNNGJmLzJIdkp4MVBl?=
 =?utf-8?B?VkxCbW1wbm5xZkM4VEtSYUo2bkdQMS9XdkZRVHdCN01qTDN3ZHlNeUc3Vlho?=
 =?utf-8?B?N1g1aC9pU3NkWFhUZkxJOGkrYmM1VmdpbmFVTFQzbVpQWXhaNHRVT2hneHNv?=
 =?utf-8?B?emtZdlFvT25xL0dyazFpVTVRL0szWlFaRjVuTUVJRTloVHR6T1NWcE1Hb0NI?=
 =?utf-8?B?RGpTcG1acHcxTGFwY2FSSzBBbzNGbzQzeVpmZndWaEUrYUpLakFqNXo5eGlE?=
 =?utf-8?B?NTFkeTlHclFuYXQyUFlrN2tmN082L2d4WDZIbnBsR2cwcHBnT05XK0RqSVhu?=
 =?utf-8?B?YXhrNWRVR3RVNmcwMTZ6bnRQMDh5cDYxRVVjUTlPOGRWWlgvd1JtKzJHOHlh?=
 =?utf-8?B?Rk5tcXBDVTNvbG5IZXlGSFFYZVBqRU9JbkVBY1JTR0VvbkhiMzJmcnZGSStT?=
 =?utf-8?B?dGxJRHkwdER0N3dleEJ0T1ZibEdJQWl0NmpUSk5QNmZWbWRlVGhPSnk3QUw4?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa47b8a8-177a-4835-4e93-08dbd1b38206
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:28:31.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pw8kGFPum5CfFRKXeABI2/2J+y35+f/dvqCUHneXJEiH9LVdW9KKPlGK5JDRiyavLXT5gB7PAKSp06z0C3S/KIw75ovLmUc1wvHEaDnQECw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8194
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 12:37 PM, Ivan Vecera wrote:
> Convert flags and hw_features fields from i40e_pf from u32 to
> bitmaps and their usage to use bit access functions.
> 
> Changes:
> - Convert "pf_ptr->(flags|hw_features) & FL" to "test_bit(FL, ...)"
> - Convert "pf_ptr->(flags|hw_features) |= FL" to "set_bit(FL, ...)"
> - Convert "pf_ptr->(flags|hw_features) &= ~FL" to "clear_bit(FL, ...)"
> - Rename flag field to bitno in i40e_priv_flags and adjust ethtool
>   callbacks to work with flags bitmap
> - Rename flag names where '_ENABLED'->'_ENA' and '_DISABLED'->'_DIS'
>   like in ice driver

I've not been a big fan of the overly-shortened names in ice, but I
agree consistency is probably better.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
