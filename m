Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8867D7FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344646AbjJZJnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344685AbjJZJnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:43:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AEB1A2;
        Thu, 26 Oct 2023 02:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698313376; x=1729849376;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UhQH95HSQ0a5F6vMDXnKMvc59wLPv/Rp0FjtRjAK9bg=;
  b=L1ak0asp/MSLd6AP72/H+QNDPdbaSu1Z6vW0kmZvq3hFk3gVJDHwBlGh
   S/VHTC6zhfqyl/SKo0LllZqM2Qmc9y7dNAc6jS23BtoJSTtZq4+yN4rbr
   gf1xABvgAEUcKU7OeK7SOatHJ1ey+k3NjRppFeW7bA1WsaYZzVzg8rNoa
   ZpjbEA9qD8SldPcqs8y3SrFPuQGaVAVF69VLF4hS7MKGh4mfhX3IMmBz/
   Rw1a2+KJ4nliFlWpOm0qub8/wlZnifOudMvpDlnWERPthY3eZzyqG2JQk
   ygjxeXmYdGXVr2w/+xVYIV7YVYlLTliP0yOl4SUHBdxID1IoVNh3z1Ib1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="451737974"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="451737974"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:42:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="829555884"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="829555884"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 02:42:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:42:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 02:42:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 02:42:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov5qeHCwQOJRj+QCcyzQRtnYHyKgN1dKjABkvcUyjYfEZREue40wrnVlDVkuCz7JzoAQ8qR9G27Ltgt6ubitzwivZqvtLirBN+V67T9cFQ1ZAIhMYa73Bda53xx0+cjFqrBo+fqOdy+I7I1i0pka5SaFsnHdLRfumPz5pwJLSj7tp/0xBzlvf6KZE5BiaMMI2MprLXxJBPDRjfnttf3b2q11B+eMZHDwAFWjPxoKg5Qh7VMV2jP6pt4vFaLqBchfGmdT+tpejgsT9qvUsfLTPuea1yMWCkzOEmT7WsOyZXKrf3FLvwDmggQaehdyVHaXwUa0N23OfJCX2Qs6+t73Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSjpP5JvFVTpTt1XsyzU8t7Ub7soh/CJgVNosx84eGI=;
 b=LUFAyOWA6uZ56+jj1515EOpRh7iZT4Q5+1EK0c/LgKfoeWGvzSwPVG73YhIzDdYWbbBpc7GwQIViw3FELIAdestPFeyWImtxekmoj7+KirP0zt1piCjJdj0H53AY91CgxgnrIJ3md3XWqkcKcVe1KA+0myXhWVpDgM3g0CAOZptpfNkdj6E86aDex776oJi4FFj7pIdpj3hy31glNA4qMbJKvwnPZSScn+d+G9rTfOZ+Nygh3MUgPDgTe0zSO2h4qa6ejdPZQ1/tUPdd+BpnBWCnYDNt1vS9SBqngzm5oVWDOqM/Kno3lH+mJxDpgH9dlB/Lv9VZNbwu+JZj0FhhzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by BL3PR11MB6481.namprd11.prod.outlook.com (2603:10b6:208:3bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 09:42:52 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 09:42:52 +0000
Message-ID: <beb49134-37c7-48c6-8f3f-ac4a083d6bd6@intel.com>
Date:   Thu, 26 Oct 2023 11:42:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 1/2] i40e: Remove VF MAC types
Content-Language: en-US
To:     Jacob Keller <jacob.e.keller@intel.com>,
        Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20231025103315.1149589-1-ivecera@redhat.com>
 <20231025103315.1149589-2-ivecera@redhat.com>
 <8a8f54a8-1a18-4797-a592-b57bc6fc45c1@intel.com>
 <cbb2e9f4-03f8-4a46-99e4-e952bb754a2f@redhat.com>
 <022960b9-dfd1-4ed8-9b46-9cc11ba060e2@intel.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <022960b9-dfd1-4ed8-9b46-9cc11ba060e2@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::25) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|BL3PR11MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: f634bded-247a-4de4-83f2-08dbd607ec7d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtqEpjv9cKOxLSSS4Rjmyp9xOi4AWXT6oFx0SgAGMxJ8FwTPvOI+Mvph9Erpgl0cZlPjK8uhQyMv0bsqJYq/svCNKmwkM7IyRPggmJjIKCrqxOfxedIMuqPKRezgJh3Pob58pTt8Npv5Evx6XRVfPWvHKFVzRjvdRov9KdB0HA3qTzRASGY79KcxUGWmJ0+vkCk94SGvUJj41QzkxDoglP+I+K053yTfHzBT02rtZeNtxtDcP0LC69EAza8TvlXpUE8Vrj2yLdRlSdte0mCr/vv5tTM2Lv92zPQYRnzdTnOIB5YSPrBnXBP6BsX6hvABAvABiWflIrwojPSh+VjAWYsiyPGKDDPR+hOxIkaFwTGPXLtGm5LXsDGxvemeP4dj5oHt7orj6hRHru/Hru8veWaOEXxxPG8STlCzJwEAwXHw/6CV6+F3VBN9KV4MCCiBkWNO0eQq7nhBvb5muIplAjWFzcOio8sk2xbo7pxCoTQggVLbVSgd1FLv0gAc+DFVbKWUrO/1jrgaWbOgs5AoViV6QZ+zdHRfc7ftsRYXC80WTAI2Xa84/eFVt3Cqcm8tsl4uWa79JBqHltgADjWt+TYWvFGg/xn460q84ycXQNjESNztvSw5Due/YzQsXvVZ2MiAt669yOc506RoCWyS9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(2616005)(66556008)(31696002)(6506007)(6512007)(26005)(54906003)(6486002)(110136005)(6666004)(53546011)(66946007)(82960400001)(83380400001)(38100700002)(5660300002)(4326008)(316002)(41300700001)(66476007)(36756003)(8936002)(8676002)(44832011)(86362001)(31686004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlMxd2dLdjBTL0VmOENXd0VaNmtIeWxqeGFRTG5KUHVzSW50SG1UNkhaM0Ra?=
 =?utf-8?B?MXZwY01sUkpKL2lQQTI4OUtYalk4Y0pzcGFWaHdoaXNSeHQ1VmNsTVllaSta?=
 =?utf-8?B?bWR3SmtKQXNWTDltY2xBQmhTQXVRTkFFOXhYeXQxbERkWWc2VWtPRmxLNTlX?=
 =?utf-8?B?emQrcitYMit5dlhYQlpCUWNFOWNhdWRJRTlueUpaU09sVWVLb2lMcEZId04z?=
 =?utf-8?B?ekxLY3Fnb2x3OUN3MVFTRHhQdmpITWRPOTZxNm1NWmVNb0dnNTZ6VDkxV2N1?=
 =?utf-8?B?dFhKUzlJQWJtS3I3bUdHaFFKQXJTT2x0NXQ5dUYvVjZxU3k1YzcyQjBMVnFj?=
 =?utf-8?B?NmJjay96Sy9nNFpZd2dMMm9reXdBVE5tSnhVYVlkS1d0MEJVUVBsVDExRC9l?=
 =?utf-8?B?Qkw2Ni8xRklSVXJNdjNOMk1scVdBNTl6dmtyMkpHSElBd2gvWXVYOFVDUHNV?=
 =?utf-8?B?YmV2Z2E5VFIxRHByYXR1ektuM1hDMld3U0Z5bEVjdDFxb0VWSEdFQVRmZFln?=
 =?utf-8?B?aHdoM1Jpc2t1bkl0Y01BcVZUbGt4dXF1aWhteTZoOVcvZW9yZk83dVZsV2Ri?=
 =?utf-8?B?S2puOHFkK2R2S2V0S2ordVBpUm9WRzFqUnZwVkUxdEl0SDI3b1pPSEdKMmVr?=
 =?utf-8?B?LzNLTW5BU0ZyejhqV1BlRVlLSmVrRDJwcmFva29KdHBGd0xXOGRtWUpFekcv?=
 =?utf-8?B?UHBKYjNMY0wzS2syb2JQTHBYQVM2d1pTcGZ3UmtxSjFOTHRLRU1WdVBZYllq?=
 =?utf-8?B?VnlnTUZDUVIrWVFCUjhZZkRoWUFYUERoaHpUaVo2VVR4VE5sYUQrQlhzM1h3?=
 =?utf-8?B?UFhtbmNxQVpXaVA4MzJkZEpUbnE3M2pQT1lGaEE5Z3dEaHl2SkordkNSeXBr?=
 =?utf-8?B?a3J6WTM5bjJyMk1tRXVQWmdsQjBLZkZZN0V5SFdIbEFBdi9NaDlyL3ZtZDNU?=
 =?utf-8?B?Q1lMZE1sNzd1eUVlMzZTdVBFQlhhZ0ZPUlUrODdvWGFWM01sYWlUdmt4Yk8v?=
 =?utf-8?B?dE5hTHF2SU9iWVN5czIxRHB0cExoemJxMERhRFJQaWU3TUttbGY4bm1QcDZI?=
 =?utf-8?B?N1ZMSGR4YTFYRlNjdnFJb0tvUFlNVXQ3UWZ0T1RrYmpYbjNoMXBVZG0vVTJv?=
 =?utf-8?B?ZTBrcXB6czlUcVBhcWtUSnpJcmVma21BeGQybGRGZW55aFg5ZUE3RnRPenNy?=
 =?utf-8?B?bDNCeThSTFcvMFQ0RTd6NlZNcWRPS1JDQWZMWXVCajdRUEJPNEVYc210elJW?=
 =?utf-8?B?eUkrTzdYc1hONjhQbmYrc3ZEaFRMbEhVZzRmK0hlRWR5bnVEbWxmd2NtcEJK?=
 =?utf-8?B?YzUrWnBoR2ZhenU2Q09rRUYxN2hpVHRsTXdPV1llNStwaDlJWGZ6M0pPQk82?=
 =?utf-8?B?RGtEOXZ3MzdwcTgrMnVBUkoyMDZ3TFR3ZDViS0twcldBT3UyeFNlbnRxb3lG?=
 =?utf-8?B?NTdYZGlOTFd3VGJYTEp1V1BiQjMrMkxacEdmazJoUU0zbE04bEVOeEMwWUVw?=
 =?utf-8?B?ZzFHUkRkVTRVUmE1WitSalVvM3h2QUtzSXZ3QjlJM28xRzRhcm1JdE5MZDJD?=
 =?utf-8?B?Z3k3MWlrdWFVL2phdzdHbzlZemNNYm5oaWFrUlNQc0IvZHBCemFPMjI5NXFI?=
 =?utf-8?B?SDdnODRSVUhHZkNnSEJrR3dGcFIwd3Brc3FoVmgzMmtMQW5HYUYwQkhjSHBh?=
 =?utf-8?B?ZS9wUld3NDNsMFBpbGRVMy95bXRIQ3d5YS83M2Q5L0tHemN5VzB0Wmp3YjlF?=
 =?utf-8?B?cDd4TlhDT1BLZjJkeG5TdmhkcHppdFZCdEh5NC9DaUJJcXFQUEJjTzVsM1dx?=
 =?utf-8?B?dUN1QU5YZFRWaHpwUEFuMElpYkd4d01lNVFKdkF4S256YXlTQVFJZ0NOZWhw?=
 =?utf-8?B?dHJEVzlaZDhRVGVYL0I0MEF1OTdZWkNNSVU0NHBTNFRKVm9JdzNMMnpvS2tQ?=
 =?utf-8?B?cE9QZ1ZJSVdiYjMwYlJyVmVzcTBuS1FpZktFNjd2NXBycWxFb3BlRG44cktF?=
 =?utf-8?B?MFlrdERWTTU4MzF1dklNYzlvUmNmVndCUi9Oc3NJYjV2UDd2enFLb215RUI2?=
 =?utf-8?B?ekxqU3BPbnc2NG1vSUZ2YzhWaFJPL3p4OUtTeTZTM0ZnT0VPZmlUMGNhSnBn?=
 =?utf-8?B?NndaWkN2WVJ0TU5RV3l2VlBUaytRTW5TSVVFMnUybFRaYTk4UFo1VDU1ZDdK?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f634bded-247a-4de4-83f2-08dbd607ec7d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:42:52.6432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIRR6m4CQfilBVdB9ThhHaWoV/6+GCqlarHTAanoWBjPeIxNB1SRxBl0cKhFF1dE52mif65lqOOVm4B49+HbGhHFb5qQKp2eUAC52xMPQM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6481
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.10.2023 19:44, Jacob Keller wrote:
> 
> 
> On 10/25/2023 7:39 AM, Ivan Vecera wrote:
>>
>>
>> On 25. 10. 23 12:48, Wojciech Drewek wrote:
>>>
>>> On 25.10.2023 12:33, Ivan Vecera wrote:
>>>> The i40e_hw.mac.type cannot to be equal to I40E_MAC_VF or
>>>> I40E_MAC_X722_VF so remove helper i40e_is_vf(), simplify
>>>> i40e_adminq_init_regs() and remove enums for these VF MAC types.
>>>>
>>>> Signed-off-by: Ivan Vecera<ivecera@redhat.com>
>>>> ---
>>>>   drivers/net/ethernet/intel/i40e/i40e_adminq.c | 33 ++++++-------------
>>>>   drivers/net/ethernet/intel/i40e/i40e_type.h   |  8 -----
>>>>   2 files changed, 10 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>>>> index 29fc46abf690..896c43905309 100644
>>>> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>>>> @@ -17,29 +17,16 @@ static void i40e_resume_aq(struct i40e_hw *hw);
>>>>   static void i40e_adminq_init_regs(struct i40e_hw *hw)
>>>>   {
>>>>   	/* set head and tail registers in our local struct */
>>>> -	if (i40e_is_vf(hw)) {
>>>> -		hw->aq.asq.tail = I40E_VF_ATQT1;
>>>> -		hw->aq.asq.head = I40E_VF_ATQH1;
>>>> -		hw->aq.asq.len  = I40E_VF_ATQLEN1;
>>>> -		hw->aq.asq.bal  = I40E_VF_ATQBAL1;
>>>> -		hw->aq.asq.bah  = I40E_VF_ATQBAH1;
>>>> -		hw->aq.arq.tail = I40E_VF_ARQT1;
>>>> -		hw->aq.arq.head = I40E_VF_ARQH1;
>>>> -		hw->aq.arq.len  = I40E_VF_ARQLEN1;
>>>> -		hw->aq.arq.bal  = I40E_VF_ARQBAL1;
>>>> -		hw->aq.arq.bah  = I40E_VF_ARQBAH1;
>>> What about removing those I40E_VF_* defines?
>>> This is their only usage here, right?
>>
>> Yes, do you want to remove them in this patch? Or follow-up is sufficient?
>>
>> Ivan
>>
>>
> 
> I'm fine with a follow up.

Me too

> 
> Thanks,
> Jake
