Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123FB809689
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjLGX0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGXZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:25:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311D21712;
        Thu,  7 Dec 2023 15:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701991566; x=1733527566;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l81gc2S0g6Dkb8lA5jslwk50CRvLD+GtyOS4Rh0TxHI=;
  b=SJ1PCubUvyr2vuq/pRI0VU3evvD2mkN4fHyFE7xx6bVWk4vio1p0Sil0
   172adrNDLNVHT1sleSt73gXdQHB9AI+MxDRn9vwx3Yvq+FVDFrAEoBqvO
   7h95q6K1ca7+Mti9Bv1y0fFWqVBLFpFoDuR2yCFGES3CpvbfHmQJsHv6F
   j4K7useM2yjUGlKAHbKsfUNkAIGsh6ImlfYXqQOdNpKOCa8db9gawqp9Y
   WyfIysOUpz4cyB7n8epWYRXqgFB1XdOpJde+wnR+RQEsQnGXirKgN0z2r
   yAFzKicULjzzuEOWsmEAUsi7TprRM4ZsLbvBij4Ghbl5Dlp7E+0QwqpBR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="7642622"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="7642622"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:26:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1019137334"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1019137334"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 15:26:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 15:26:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 15:26:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 15:25:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1zK62nF++xJVxpmaXLNmkcmdXzN3D62UgvXUzZkOL4KdS4ZdXtW85uKGiIQiiITFyBH8daOFUNWve/W3VpkfiWH8NLYKD5YWcFNnHY3BU6v6mZ8MCeg4mMrKGgKOFkYEsXfFLTjm4Xkwph655hTZyKCFCuvgC4eSXdXfV6Yg9XVu7bZzTPDfBSjtr2uStl9BbLP1AEWv8mZZyvGgh/NvEhRLr5yKXlNuoStY0rkINOhyHuAhLRs6iAj0g1d/9+c/AJmmD87bPuKA26SIHajV0c+oBirTdrCSpzp1RJJ8DADtJAjKxOqhH4qndWd/ivpN7OjsdY7sVpvKPbtiTNuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8FB1Dv/0QE2SU/NKmWSOI8hW4lNuprtRdaiNXMNSUU=;
 b=lOglBa0fZTS+vlkVau57aCOtATDnS2y+QGioAs+TiN0DdkQa2L/15mHaVaE4nGR9/rYDWa7MMMv+V4kSwqbVNxc5petnd8yN2ZLk5GfJtkUxlB0jS0grPcjbisJfrlIGkHtOKzuzFKJIB1dLdr+eJCLBVeY6S6+e+3+MHxOD2MGXb39/CJyejDLlNmmXmCEPyx9XPhAdcaEnpKnAFlb6UQorcJ6aWo8NM6SWfDeUoXw4lMwK8dmswSYgta+RFVzZwk/I1BfucLV8vuIms6WktZlyM43cw20juTy34+bmCL886Z9CqDnWfMQ4eboSqUSCcAcPaKkdMzwA9n359e3YSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SA1PR11MB5826.namprd11.prod.outlook.com (2603:10b6:806:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 23:25:52 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3%4]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 23:25:52 +0000
Message-ID: <92e5cc01-e8b3-b6d2-e884-3d6bd001f0d0@intel.com>
Date:   Thu, 7 Dec 2023 15:25:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 iwl-next] i40e: Use correct buffer size in
 i40e_dbg_command_read
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Kunwu Chan <chentao@kylinos.cn>
CC:     <jesse.brandeburg@intel.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jeffrey.t.kirsher@intel.com>, <shannon.nelson@amd.com>,
        <kunwu.chan@hotmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>
References: <20231205095844.2532859-1-chentao@kylinos.cn>
 <2a0f3c2a-71fe-4c79-8827-e53088bf3761@intel.com>
From:   Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <2a0f3c2a-71fe-4c79-8827-e53088bf3761@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:303:b4::35) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SA1PR11MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 23770800-eaee-476d-bca1-08dbf77bda58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDrUrED3gPT3NX6mzv+N/nc0hA8NkmDwKHkbv1g0AKfTxxSkBQhntuKxmUpsYEAIEQoz6Un2kwSTTWg9jkfDWem6pPcNrsNC4lxiEyL+6yWqBESiafJKm8Mk3wIvCjTenSHRpyVKWQC31Gv9XzuxQzqSec3/bJ1yR23npsGav3gMFtQJqOTRmciTgA6PPrw7az84sYkdvQET4jD+YlhtNLU+mPkvjsHUwtBznAcSXjAmZe1TL1lYtKYkcz+3h0N/EoRF7iifudIjA2/gUA8wJMoe7/DX3GLl8+Md3qc2SB/dQ3bD5/3xNuOf0o9Jp0Iov9778KUpOVaJcE8XDp3CD2qaAMzExe6N25SelZeuVj4mhFaUz+HEeuI4N/zEhGOFJ014v0IYSUdtFFtbK3BSWBWCOs0x7beg4CPee7BII88IB9T/7KJvyxuz1POLvDI2B2LFMUWTiXotpngyEOcGzISZmbJZ09P8kBEJcHoD5FfhSMNGrCeca/s0GGEc5zwZd8drq9xxlijhEY8YUDNHGwZbV56kSIWNB+fh8Qv/x7fvtD+cwrvZvFKiUioq6JW8CjjCT1cGB067xpfeaySkoQFMdg2dQGuBNEgbvuNMDx+2UB6Yr88V512OXkWS1PNEd1jutKP+25/wBez+qXx1BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6666004)(6512007)(83380400001)(82960400001)(6486002)(478600001)(26005)(6506007)(53546011)(2616005)(66556008)(66476007)(31696002)(110136005)(316002)(8676002)(4326008)(8936002)(66946007)(38100700002)(31686004)(5660300002)(7416002)(2906002)(36756003)(86362001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU5vWDVXdmVFUzd4a3dJUUxrZUpOVktldWVyaEhZOTI1Q0FyTENBQ3dVbjg2?=
 =?utf-8?B?bnpBclVwVXVMQ2hvOUUxcWpvbW5TeitJSU82RU9ZUFJnNG1qYTUvUWJHdkNU?=
 =?utf-8?B?clBMazdsaVZIWlY3WFpCOXFOcHpCOXpYODRRc3JJTEFRNXhwSGEzZkxKVTVY?=
 =?utf-8?B?L2JwOXcwdjRMSXpka0NGT0hJbWZ0NGhBVDBxRnVZMWhpTWJTaFlIaVlmWVRW?=
 =?utf-8?B?aUpiSWZFQ041UGhXc0w3d0FKQUlVMEoxS1RHOElIT3d2TU9pZ2lmYjNzV2pq?=
 =?utf-8?B?YUVWdnFONHFteDhtWFRDdEI3SmlJRElGbFVWcGNhZEl1Y0xyNWU4aHQybVdI?=
 =?utf-8?B?ZVB5SW05Y0V3Q3V0eHM5M0d2V0FXK2wzWGhzYStHMFJUdW14TGZ1dTFiY1J0?=
 =?utf-8?B?R1JaSEoyd2t0WDFXbUcxNGVaU0tKTk9GWDVRaTRFcG5pOUNReEdJOGJrMDNi?=
 =?utf-8?B?OGk3NkwyL1NJczZva2JCNFdvQ3hGMHRTb1gyTjNNZDZRQitMQ3V2eFhPaitF?=
 =?utf-8?B?Rk1MRHo0RTNtNHVZNEw5RExQb3FzY0NQcGJkU082UDBvaGVHTHRZSElHaFpD?=
 =?utf-8?B?Z1B2bWlPam5EeW5jYXdKTklxWGZRMGs3RHA3YVdOaHRHS0R3OUMra05ZTjBD?=
 =?utf-8?B?Mkl6MjQzT2RMZGFrWDRxSGlPeTdLY0QyR1JGZzZzNGdYRnRsUmphL21hOWQv?=
 =?utf-8?B?bTV3QUNXb280VlpYVXI0eTd4K1k3RVhOT0Q3ZnlHZC9pNmJJb0p4Qms0MFh6?=
 =?utf-8?B?b1YyMDZBUDAxZ3dZa0pmY3VnVEcwUTJLTmh2TjFXeXAvOW5wSVhLYU5DOTJY?=
 =?utf-8?B?Y3hsR1FuV0UvSjBsaGNIRnMyTU9jRTlpaVlaMXpYeE1NdlRuK3B3VTFPY1Rl?=
 =?utf-8?B?UEVud0orMmFobzBqQVlseHgxczh2ODFqWlFLaUVEaHczajRTQTlOUnhvMkJM?=
 =?utf-8?B?UG96MWdmNnRneUZQeG9hS0hPemRUNHZwdHJOeld4UERrRGN6a2hrZTlUa25h?=
 =?utf-8?B?cTEzTVA3ZEZCeHlTVGlpWk5zSm5sZVVPNHFTS1pjdjBkTHhBQnZ3Ty81ZEps?=
 =?utf-8?B?dEVVR2k3ZkRqTnI4ZTd0Z2ZLdDRaTGJ3OHg1bkpCNzR0c1poR2xaUjlvM1Vm?=
 =?utf-8?B?M1hLMTFoZVJUTlhMSHBKWlRJSktEeXJ2aTMxbTNwdHlKN1F4WnUzSDAySUZn?=
 =?utf-8?B?Y0xhb1M0R0FoWjF5UmtnRUJ1SWFqVTN0bGhpb3E0eU41SG1PTW42L2xGaE5H?=
 =?utf-8?B?R0h0Rm5KeERtZVJKWnoxeE9tU2UzV1hzbnV0Y09DdU1NbGV6UWRkVWsxbWIy?=
 =?utf-8?B?Q2diT0lDcnhuYWdhYVJYeTdRMWEzVjc2UlQ5cDArK1RNNHNWVFJXVG5OM3pX?=
 =?utf-8?B?eWtjVGo4eG56NDZjWjgwSjZZdXBKNmJMMHlzREZtU0RYSHphVFlYSmI4YWJG?=
 =?utf-8?B?VmJ4blJWRmNrYURLdm5ubWM3UWZ1Y3pPN0FOUjlaQi9pcGFsU3FUaElNd3lT?=
 =?utf-8?B?ci9rUWUyajR0VkhuSUJPQThDZ3hTMFFzNlUwdlhDU2xyTDZtb0UxQWJvYjc4?=
 =?utf-8?B?YTRiNVk3TXFWRzE0Y0xBMWpuR3VTb28vOXh0TlZDbkt5RTRzTWVUbVdQVVB0?=
 =?utf-8?B?WndPaU13a1pCa1VwNzU4N1I3NngyQ09yeURrazd5NU0wRFdadmZKOVArYWFD?=
 =?utf-8?B?Uys4QlV0dFRiQVlqZ0YyenNpaVZJL3YyZW5RTUlhQ25vSGJlNXlKWU5zTzVT?=
 =?utf-8?B?aU51NWRDT2w5UVp3WTUwY3F0Rk1sSGlIckFiTHMwd0tSaDc4MDgzVVdMOXpG?=
 =?utf-8?B?S3BPL3BNUlZrcW9xalY3OUU0N0Irei93cVY2UkJsckxrRmJCU25WNmtjdjU5?=
 =?utf-8?B?c3hzVDIycHI3Vng1SVhwdXFhWEZMZkNlRWV3SlZKbm9iN2pYQ1hzL3AyTndN?=
 =?utf-8?B?OC94cnAwV1NIcHJoWVJReEV2UGlWQzd0eE54QlAyNXhXWTJvbDNaV0ZXM0ZD?=
 =?utf-8?B?V0thQUk2c3liRVRTOEFaTWx6RndvWWsrQ3BENnFLRkNDa3VJNE9kcHhKMFlH?=
 =?utf-8?B?cEdxNitFU3FCZ2FCK0R3ODAzV0RYaitRelViVG1Xek8ydk95OG9xWmo1R3Fz?=
 =?utf-8?B?eVd4U0d6Z0ZvM2w1WnBEUDd2S1lubEFNN2NUTmFWNzNKTlVURGJnaSszOFo4?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23770800-eaee-476d-bca1-08dbf77bda58
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 23:25:52.1136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpgJh8FfN7jcxgfirBQmhPWbEdROBODr+ICXM4JSBpld49ZutCdXQosb1byQYqRMvxFCkZBS2kxjj3EJHllxgFapBoHeT0Cok8j3mxVHwUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5826
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/2023 4:40 AM, Alexander Lobakin wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> Date: Tue, 5 Dec 2023 17:58:44 +0800
> 
>> The size of "i40e_dbg_command_buf" is 256, the size of "name"
>> depends on "IFNAMSIZ", plus a null character and format size,
>> the total size is more than 256.
>>
>> Improve readability and maintainability by replacing a hardcoded string
>> allocation and formatting by the use of the kasprintf() helper.
>>
>> Fixes: 02e9c290814c ("i40e: debugfs interface")
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> Suggested-by: Simon Horman <horms@kernel.org>
>> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Your Signed-off-by must be the last tag in the block.
> Perhaps the maintainer could fix it when taking, so that you wouldn't
> need to send a new version only due to that.

You missed Intel Wired LAN (intel-wired-lan@lists.osuosl.org) on this, 
though the other versions did have it. Could you fix this up and be sure 
to include Intel Wired LAN?

Thanks,
Tony

>> ---
>> v2
>>     - Update the size calculation with IFNAMSIZ and sizeof(i40e_dbg_command_buf)
>> v3
>>     - Use kasprintf to improve readability and maintainability
>> v4
>>     - Fix memory leak in error path
