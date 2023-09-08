Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE967990DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343533AbjIHUKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjIHUKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:10:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14689C;
        Fri,  8 Sep 2023 13:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694203843; x=1725739843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NqNel2R5KgbYtfbrZSCExbO77fH9D4ny2hzmYsGAdxQ=;
  b=dStt3hAoK9nkZAC2AXyDLKYJ2eALsFUThtif9jWH5ZYYoqQ0hQlQkPv8
   SY8siwxBzaiFWJZXLekilI2R2d+imjhccebFfvnuqrA+MDlcjSMbCvvt5
   1zTtkfFWDzj2oI5U9PmSWxCBQv9QHDilkOMMK3p8QFU+kXnUJTH3DZZEI
   mHAuytNyhRmSgbPhtWtG9TFi7+XC+v3352DkzR047B0CeNNvABYYc3VN3
   QjSS5C9Ms/X4UjITYjarLoiGNZXC/2S97nRXPhgiLXwJoGCwXo6Ffx6QC
   S9fthM7lcU5gunTVKWot/yAwduqf6YHOfNjI01xQBdQ4M7oOYfa43lCb0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="441747589"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="441747589"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 13:10:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="742624962"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="742624962"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 13:10:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 13:10:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 13:10:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 13:10:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 13:10:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6QEWKSwbhmneboD32Y4MYraAC5SIAqSGuR98yzwTl6/R7+2iNmLJQLeD0NTWawtpVa66ISkeju41RKhl68g0NFUrnBpxcjvCWIq5fePiL4zKIka98aprullkn9l0MUG0wuyVNFzeNFc54SrQ+TGcU/YTDUdyjcATBDwygfOhiPsjH7sI8uUoSx8pMeit5gVO5649FMAenlzmZMruI4YT8hdwoIHrBcbuZmS8J+B+lV4qnjn+IN4nzN8t0ddS/MNkfhRwF5WJGUJg7zMLUcIVLsZcNiePmRIs3FSJdfe74QPCV8n1Pa5LjLPDLZGkj2/1utGgu5RbfcSQd5au/Fbtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4XEne+ttq9IinzGupj89EVSAjGvxVDSXyGc6Dak/oQ=;
 b=SLaM6NiWQkFKeYC1ARCegxkA9fLAxD9k1j9iLpmgndpp2T/uWO6Yk1mePjWHuNVjFjIIeQjKBNQPXA0r+SGM7WBYNB17aBE/0Hx8ekG/3eRyNQIV0vSpo9S7pQ1Lo1wDtPtRz75CdHaH1NDPRGyGIkS4bfU4A8GB3wq1U6rlrtAUCuWJ8SQTIfBq5OEWTwULj0Ucn5Sm67DsLFhIhgdfv2z+Uo4CoG3guHj/AwYgYjYezOLKPAJF4wE7S9sodsZG9CLgSxr8glX9DjbSySN0QfgjJdBl3jpf7vzXMHTzTGQz9jMOXUU1kksLm86HX5djsd4dCuxHO5c4BbR2HcmyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by MW3PR11MB4747.namprd11.prod.outlook.com (2603:10b6:303:2f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 20:10:37 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::91f3:3879:b47d:a1c3]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::91f3:3879:b47d:a1c3%3]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 20:10:37 +0000
Message-ID: <9a84e07a-d74b-aa8c-3da2-a8fa0838a11e@intel.com>
Date:   Fri, 8 Sep 2023 13:10:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net v2 2/2] iavf: schedule a request immediately after
 add/delete vlan
Content-Language: en-US
To:     Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
CC:     <jesse.brandeburg@intel.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mschmidt@redhat.com>, <ivecera@redhat.com>,
        <ahmed.zaki@intel.com>, <horms@kernel.org>
References: <20230907150251.224931-1-poros@redhat.com>
 <20230907150251.224931-2-poros@redhat.com>
From:   Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20230907150251.224931-2-poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:303:2b::8) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|MW3PR11MB4747:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c8282c-3d02-4dfb-e177-08dbb0a7aad8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/cBRibkXmjxUjnYYRn4is+AisQ1J1oNl2qPRMKmUagHUYbL1b5lRk5Y2DqkH782ozqKZqZAA/7BFFBCMZwtppyw7FnofpslQVtUvg6ea0Fbf6sppsZZtVGggwqIMqvwRuyrdefSahg4uZ7cdAEbhemh1k7xHcFyZlVNHi3fUETC0R36mtC1Dkfqwbc0a4NWNA04/sGTaFbXi1bqGgb4sQ9UQbEv9XDXcVGnvj+hALuPFO1O3f2+zoaPTMGIFnyc9ms7w2E5vxEreoYHcGjMD54ZZx7uK9Y7zw5VDGbKsAgPSCglT3BX7Y0zDLefCfCC7eBFPUkezABQdDYDEOELpJPWb7S7XexBrvVRuBw1bKKicJY+gmut6knXZscMUMkTsIL7ScPAPpA9yFFDtg50iYhFPsLT84S9E8bbt+n00aqRF4+tpAMhrgWbP+2/URyPtyguf/x9Vmx4ihx/IY7QYcbqS3SXld4bycNwyuEy+HvsTpM2Ha+Pz0OUNBIeMd3lVkaE66JzxAPOEWR7w7GNo1zpVCe21w+GJg1S42IWSJmTJoP5XzE/UHtQqJmkk8PV18rI6dDYwsy3HW6JPuBeiPPNlVHzowpupmlVWnAsdj5pvKp3mXW85th2M5+VzPlrxsx4/BCR19NuzbvyOTZky8LYZIpWaJvgc/XfaujWxro=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(186009)(1800799009)(451199024)(2906002)(86362001)(31696002)(53546011)(2616005)(26005)(6666004)(36756003)(6506007)(6486002)(14773004)(478600001)(6512007)(83380400001)(38100700002)(82960400001)(41300700001)(8936002)(8676002)(5660300002)(4326008)(7416002)(31686004)(316002)(66946007)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzE5VW1XNUI4bHcvZytlTWNIZ3c4RVcxeVI5L3EwRUxFU1BvbkRmaDE1NklX?=
 =?utf-8?B?ZytsNTVuZ2c4N3NpdXVSNS91OHdseDVwbDU3YzMyUUoydHliVVdEZklMek55?=
 =?utf-8?B?MVFUbVdhRnRqWWlVV1oxa1lJWXNrcE5Mc2g5YXAzTXBQNUdOWGhjdnpDUXhG?=
 =?utf-8?B?NUZncG9jWDBZakNHUkUybG9xcTJQTUE1UUVzc2ttVk44Rzd6MGY5aXBwSXVC?=
 =?utf-8?B?WlRRbEdUa0xDZUMxalVVcFNLYmdSaklEUm03MGpmSWhncUZhblB4YWJsUXhG?=
 =?utf-8?B?QWFlMXVEMy9EZ3FDR3lTQURmbGZwbXpMM0p4bk5oRmFsODdZZjA0b3F6cjlp?=
 =?utf-8?B?SzEwaWtZOFpFa1lDRkpyVlFNL1crUTVKR2E0QmRwVjJDZ2F0K3RBOWt1UkJr?=
 =?utf-8?B?UEtEV05va09TN29JS2hMM1N2ZUhzOWM1YjdSL2dxd0pXeThWNTJ4a3NQWWUv?=
 =?utf-8?B?WDkwZythN2F0MndvT2dodmJMMUVTbEprd1NGQTNTY2dUY3l2S1FZUnNsOFFL?=
 =?utf-8?B?SjFzWUh6SXZNbFJUbWFhSkhsTmhpSnd4cGRVWDFsVmlmQ2tyU3dhcmg5M3JI?=
 =?utf-8?B?aU4ySm5sbHkvU2pFdXZpL29PNlFOYU1MZjFnaFhoSVpueSs5L2U5Sk9TaFRm?=
 =?utf-8?B?VEh1ZSs3QUFuSnZIZ3c3MEhMM1UwcjFzVUdldU5xT3FXOEFCUGxGejM1Mmt6?=
 =?utf-8?B?OWFObCttMDNIL0cyOFNCMURXWXpVTGdCT2IzNTY4akxOUFBGYXpMZG13dU00?=
 =?utf-8?B?Y3orL1pEVmhOeDI2T0xQeHBOeDN5QmdqeWRtQ3lsL08zVFh6NTZmQ2xVN3JT?=
 =?utf-8?B?MEhMTDV2N1RMejI2ZG5kRnVpdng1ODlmY1k4dFJEWHE5ZCs1Y3pPSmYyN29B?=
 =?utf-8?B?YUZrMGhkQjdQWGVYemI4N0lSZy81aWppWmtacUwwanZBN2puWEhjWkRteUFi?=
 =?utf-8?B?UklLbU1UYlhrV0ZVZUFPVXRBREc3WVNnclVZdFNjNDFOMXluWjMzRlZYZmM3?=
 =?utf-8?B?WWdXZ0JLNkliZkFIbFc4T0ZIZ3dFOWJEYmd6ajltaXRnb3Y0SUM2bVVEWlVv?=
 =?utf-8?B?d2YzYmNScTZpdlNIeFAxQ2VveFhSeU9LNTdrdnhDT09DSy9GeXp6TnJrQ2xy?=
 =?utf-8?B?eVVEOVhsc1Q0bzdpSytKb1Irc1lxVkdja3pRT01ubUxsdldBMDA5N1gvS2Ez?=
 =?utf-8?B?YVVhL1RUVldKYU9icFdyaGU5WFhKZGM5KzV5aHhmalgwYWNFamVJYVN1b294?=
 =?utf-8?B?dnYrcnNPSTBTblNqNEZjang1RUQza0lXNXlXbjdmdzJBSG1Cb0cxcXNNdWJo?=
 =?utf-8?B?V2o5RVd2OTdVZTdSWFhDRnlSUkw1eXVYQVl6SHNnOStBZE1Pd25hZXUwdVlx?=
 =?utf-8?B?a25iRWt1eVNya2xDOU9ZMXJhQXN6RWtMN2QrZVNqNjloM3h0emZqRWVqZXpR?=
 =?utf-8?B?Ym1qWFRPeFA3cXdPbXJSZnVqd3pYVG1VdUZyczRKc0dDUDh2L09CeTB2YU5S?=
 =?utf-8?B?UWRJa2R0d3A5QWw1QnJ5RURtOCs0TGpLTVBIK05Bc2o4QU4rSjlld0lobDNC?=
 =?utf-8?B?Mzl3M25UWEl6MHMraHl0VWNkMVhtQmFjWGttRFZWZzB3Q0QxWFJ0UFJVSWUv?=
 =?utf-8?B?WFhKVExRNmZlT1R1a0tvdXQ1N0NPYm5hNzFndlIxTmtNQzYwSkp5WDFVaHQr?=
 =?utf-8?B?YkdmL3F5aVdRV0RjeUJVZUkzMUgrOWUrc3lNb21WaFpqVm1GcEYwcGtSZXpz?=
 =?utf-8?B?L0psY3BucHlNMXQ3MXhRTHZTMjlhcy9zbnZGanRkbWFyVUs4TWJkc3JHV1Jl?=
 =?utf-8?B?NWgxS2FhK3BxMkxXQUxXaG5iZi9iUEtjRjhUVkVqVkRZWExoQU9CdzJMTXE4?=
 =?utf-8?B?TkZwZ3YzS24vc1kxYnd6ZWRtbkxqWWx3V0toWlRWSjBaSzAyaFhYTkV5citm?=
 =?utf-8?B?RXFtbnowWTQydGVjVXorMmpRWTdycTZ5bExkZWlzQ1crZktSay8wNXZ5VGFS?=
 =?utf-8?B?bVlLZkNNb2N3eHFOcGpaTFBkcURmTU54aFZVN3V4YnkwMmh0YUlkK2FuR0sw?=
 =?utf-8?B?Y3NsaVRYaDJkR2pnUVdJWUtxdHBqUXNEcXlqK1hEQjArT3VGN3VwTWxFQkt0?=
 =?utf-8?B?RnljRHEwQXZZYm5iejB3VlRQZExYNHNOUHdnV21XcVhMK0FWYzlublFBcHIz?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c8282c-3d02-4dfb-e177-08dbb0a7aad8
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 20:10:37.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIwQCLJ8ishvwT4tFCs05nRTir19HKOS1X30+Sr6zK10xGcxhKMz0Mv+wAKUkjnr7Yc/ZpTyyJ7VA3SLoIQG6LHbc/pBl+bsqLGZC+kC700=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4747
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2023 8:02 AM, Petr Oros wrote:
> When the iavf driver wants to reconfigure the VLAN filters
> (iavf_add_vlan, iavf_del_vlan), it sets a flag in
> aq_required:
>    adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
> or:
>    adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;
> 
> This is later processed by the watchdog_task, but it runs periodically
> every 2 seconds, so it can be a long time before it processes the request.
> 
> In the worst case, the interface is unable to receive traffic for more
> than 2 seconds for no objective reason.
> 

Changes look ok, however, can you supply or add a Fixes:?

> Signed-off-by: Petr Oros <poros@redhat.com>
> Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 86d472dfdbc10c..d9f8ac1d57fd62 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -821,7 +821,7 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter,
>   		list_add_tail(&f->list, &adapter->vlan_filter_list);
>   		f->state = IAVF_VLAN_ADD;
>   		adapter->num_vlan_filters++;
> -		adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
> +		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_VLAN_FILTER);
>   	}
>   
>   clearout:
> @@ -843,7 +843,7 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, struct iavf_vlan vlan)
>   	f = iavf_find_vlan(adapter, vlan);
>   	if (f) {
>   		f->state = IAVF_VLAN_REMOVE;
> -		adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;
> +		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_VLAN_FILTER);
>   	}
>   
>   	spin_unlock_bh(&adapter->mac_vlan_list_lock);
