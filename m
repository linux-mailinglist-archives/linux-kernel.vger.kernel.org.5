Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCF37E70A0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344810AbjKIRoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344804AbjKIRof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:44:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28082D63
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699551874; x=1731087874;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ffVaWb2/xyTV9u+o43EsVB0nyBp+w2R4tsUSq8V3He0=;
  b=K9bZpPTTWlM7YxDEduWz7Z2HHtevCyQc1E6lRo9AqU6BQ9jwFsU8J1Dj
   kmWi8NZVmV6tQIHim9Q4Zs42vZKYHBr1TpArdyUMhtNlPYIONktFkgvvb
   ZqLOFM4ftZd+Yp+0vTzJXU847iosDgrd9nuXH8Zn7vW4K3r61iegPy/pN
   vH/pRyKG+UHvdUkUvb3PATKJ2sJ8DTjQlVLQXQ3z64zrL0WjchG/ei7v7
   cd4olMOsNyPymLnv0wVFwdKgllXO+ih2rxH5tzXBk3nxzxM74qv4v+Wdo
   +9ALALRLjOM/uPbvpERNWAayTLCnBfUclop9l4Gra4OJxc5N+TJn3xvAo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="11583574"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="11583574"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:44:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="739908511"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="739908511"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 09:44:32 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:44:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:44:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 09:44:31 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 09:44:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8vEGnmDXubLV+AQx8a9p0+RcUFl4i3o06aArqr4rQHSzlNiMuLlgua2GMqT635m1DH/E2yutA0ORLXjPk4x8wJW9ckl49MQi9pokJjEikvT395jiEcFoTZ5VTYfXPtBwa5Gxyv+93nrti49u9hSSvha22k0nd3cuIn1+u8v0FYfd2ZJddGh+whzllnA4jo2+KtcEVU6vF+NhMZcoR4O06wjMPSduDRPkI3ZdqZoMeswUnNlbxsf1FP5ugiJldJSY97JouVvbFiZiz8sQaL95wmhyNMxt7oDbvi/qY4LL5GFmpM8b4Qvg3XSWa99fnstWzKel3zT1XsiDknx9DHw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39wfW6o5cyWQISiM3KrtSjqpSwBGnIrVuIElGG++6SU=;
 b=MeYzr5EJMmWMM9XqeNJnBmHy19JMJd2vTmaYnokkgYEuEprFOEBMdixHCM4SYSvRlgURPo7lFsC6/QrGOqhJwb054/6SphVqYWGW0ECewy8H5vdRR8BGVYsY+HkYX2KaJTErmJz7l+mK1n5ytBJjfYhEhgCmlFhR+/OOe+kAlvj29mORa+7hAQzsQKM3+2D5Fpm8HWeTEg2+2oTMpwZU1i1uQ+LFW5tvEzSMZ4+7/pZHoilaks4oivORoNgUKrG5JAEp0KnndTmXNXTpYwwnOGOJRTngyxZfnK3XVWCn7LLEw/vkJMex6SgjaB15tH8JDobuv9UU6l7gvo419i0Y5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 17:44:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 17:44:27 +0000
Message-ID: <7b6ae291-b1df-4a4a-a415-da1eaeed6775@intel.com>
Date:   Thu, 9 Nov 2023 09:44:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/24] x86/resctrl: Use __set_bit()/__clear_bit()
 instead of open coding
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-10-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231025180345.28061-10-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:303:87::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 82dd52af-c26f-49a0-a87e-08dbe14b8506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PeBmMKhePGUJiOIrwc155mgtZXStndHmDUOmMqTSnUFxK/sVXWjfyDH+n5FX1VAZTN9DjHQ/00o9OY+C2fvSulPitg2FrHYkR9R1vSWXvzCR2qPayw4o5YCCrFIS8U7LKMBTflI3IBF4TDioYgz+1k/5n7lPZUnGAHOa3Wy9Uc/dMNG1AixkG/DJzmPb2Ys9Ly9sv4xowLVhiazkcR1JyzsiuDU/plLVY8D5HdzMZ4eyfW0/D33+06gXtwARZtf3tL+SfcskZubpp7wsyk0PcC+Qo8eYZ6fmqFpm7SMcGV1lqBSqWLsdYviadhOIaKM3cOfSRctQ4Z2AVLeOHGzft48bBrfBRsGI3vPKRrN8yZLqwNJq9pUBeZK9aMhzZ0ev4SQ6HlhBppu2GZ5OtNatZB67EEUjob7BPG8yLBf0xanDDm9oZ1LMLkQ6wEXjM/Q0lghRL3Ef5vdBhBQZUdHR7BqNf5gacZ5XAESZTfpgHaum/yTLDxjF/HZU7JvhgcLt9GfgeA6MHavRV5A00wr9Obqtk17MOxJZ/5TaoVdH3eK98KOln6Kk/IVGT837BMm9KPJir2FidOCNJyLFADZtv1ed/w9X/ZrFUjTJN+cL2uX2g0fwLgJZ/X2HJaQ/UgtrwjZcDB8cctBooLMVJ404zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(54906003)(38100700002)(66946007)(66556008)(86362001)(31696002)(36756003)(66476007)(82960400001)(83380400001)(26005)(2616005)(7416002)(4326008)(6512007)(53546011)(6506007)(478600001)(2906002)(6486002)(316002)(8936002)(5660300002)(8676002)(41300700001)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0U2MzVsdUhUYzhWN215aDlESUlnd0VCbVhXUmZFWUUzdDZrSWlyVmRiRVNF?=
 =?utf-8?B?VTJMWU56M3BnUVVBMXFCQUw0dXdnNTFKWHBJcWRIY01WVHF6bG0vUWFidTlF?=
 =?utf-8?B?Qmt4ckFqWUdoTHlPM3FJTFZpbzNzWTJQLytSRmUvU05PSWx3a1E1MXlReUU0?=
 =?utf-8?B?ZEJUL2JqNzFJbDIzKzBrdFZYNnBUcmh3Sm51Y2RuRExBWXkvd0RXU0Z6VTVx?=
 =?utf-8?B?UUJINGNGUDAyZm44UEVudnQrNXJyOHBqSmVWbHpxK1Iwa0UyQ2hBY3Vvb2lC?=
 =?utf-8?B?b3BaaVNxYTAybUFsZVFSZGdtNnJtUVB4SG5lc2ZISnVFck15RUVpNXE4bnNt?=
 =?utf-8?B?MDJqWXFQRGljb3B5bnZrY24vU1BNSW0vaTBLZ3pCVmJlOEF2SWphQlNFci9y?=
 =?utf-8?B?alpINWIwREp0eGhRd2NXVFJmMXJYY1VXM1N0UXpPWGE2bjB6RnZKV2UyRXBE?=
 =?utf-8?B?T3Z2eEhhNThRTUdCZlpOejIzK1gzcVRnR1VIanEzajl5dkQrVk9sUWdxOWcx?=
 =?utf-8?B?WGh2TW5Sa3dOZytHZGZhUnhjWmhVUWdneXhKOHNTSjdxWUpsTktyWWdzL3ZJ?=
 =?utf-8?B?TnR0QlA2ZlUwRlJQTkkySDJhOFE3NkV0YkNhN2t3dVB5V29VUmxVYnZvK2M4?=
 =?utf-8?B?MDBEbUQ5QjRJTzg5RldCMERkN1VPYWhTeDJGelcvOTJzSmpzN0ljSDNCZnNs?=
 =?utf-8?B?Z0pQd1dENXhMVUZtN1krWGJMQTArQlFHd2M1dVJ1WE41Ny84ZDE5ekl0SFpG?=
 =?utf-8?B?TEJWRlV1UHB3cHNoZDhpRWZ6ZWpkajFuQTdrb3BTaElCQkhRT25XNjM2d0RY?=
 =?utf-8?B?RUVVaVVkVlhQbnJDNlJWS3Z1dHJKVFJGbUxIV3RJWmNSMStqM3pnUEM2VGpO?=
 =?utf-8?B?ZEE3QitJUmdPS2pING5KVCszYzR4ZGJqREpIYjNCckpCQTl2TlpCT090a3NI?=
 =?utf-8?B?MG1LVmozd2tnSlZqTFV6Nnc0eWdwTXA5Um85YVd3VUtTa09Pa0M1dTVJMGVD?=
 =?utf-8?B?MDB1REc3dGNPTkF3LytqWk5hMVc3c1N1U3FvRnVRZXB1QS9kUHF4dElXd2wv?=
 =?utf-8?B?STRrNithbVJadThuOGdJUVppdVd5WlVlVWZjSzhuWUNOV1NWSVlmSVV4ODNv?=
 =?utf-8?B?RUVKRUN0SFB1QnZMUFlsa2M2OHk5Nkp5QTJXWjdhM1RhTlN4RjBEK3k4eTJs?=
 =?utf-8?B?ZlB6Z3lxNW90N1d3MXFNMFl3UkJDVVN3UnorcE5DZlovbVJzR09YUzltUkdL?=
 =?utf-8?B?R0tjN2w4SVlUMWd0cDhOM1lVQTllZzAzalRkR0g3ck52WHFBQ1V2Z0J1SEN1?=
 =?utf-8?B?Myt4S2FqRUd2ajJtZE9zUmI0VlFwR0ZZNlpON1ZIL0pQZDVEdUx2YUltcktm?=
 =?utf-8?B?T0JCbWRiRzdEcnY4Tms0cWp4bk9ybWJYVnBMVnVIT0cvdERMZ0xqZ1dyNXdk?=
 =?utf-8?B?cnhhWXozZ0JLZ2krcjg3MEVQTW51NWpEWldvQ1IvYzRNdXZJR1pUR0g5cW1I?=
 =?utf-8?B?ZjhjMzh3WEFiSGNsN09FdWtGV1pGTHVZOUxyVXN0aHFObzFlOUdWWmJXYXNL?=
 =?utf-8?B?bnFzMk9WaS9FVE41YnJFTjhON1JjdHhYZ01mNkdtT0ZYNDJrN0Fucm1lLzNw?=
 =?utf-8?B?YU44QStDK3M5K2VuYkdLS242Q1JsanVmRnpTWlNWeFdxYkwrZ2k3a2YxL0dL?=
 =?utf-8?B?NlRibUdDM2c4RzVBRURRYUV4aXVZSDhTTzFWYjdBZXpBcEQrOU9ERURMZ2Vt?=
 =?utf-8?B?ZDZEZkEzL2VzUDVGajVVNWlEOGJGdEdzWVpSekMvcHJWMWdjMUFGZGhDRVdq?=
 =?utf-8?B?TkdhTk4yTnVxWVlkWDdPRFl0eVljajA5ZEViZnRUTEoxakJHVEVjTVhCeXNT?=
 =?utf-8?B?TFUzZzRhZThIUHpvbG1hTFpoRGZVdHRlYTNRbDZ1a09VNXJXQjRIOEdzMjNX?=
 =?utf-8?B?M05sdUxTUkpBWWJFdnl1YzF5VE9kN0UxVmlZc2tzY2RLWUdJckxhcTNybmVC?=
 =?utf-8?B?QUZ6Q0dqb2krdThKYnA1UjFiMXJHU0VHMnl4RjVYdG00NkNzQysxbzBJMUQr?=
 =?utf-8?B?a1lRdUFlNmpvSTc2L0ZOK1J3NGw4ZkF3cHl0UEJ6ejNlVWJoMmFoc1k2aGFJ?=
 =?utf-8?B?WnBDS1U3QmdEa2VjOVA0MXVERVRJVm9tU3E5RzM0UWFrNGFGWDBORVY3enAw?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82dd52af-c26f-49a0-a87e-08dbe14b8506
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:44:27.5095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRes+c/dxqyiGH4etrDMQEnIWUTKTBondeo44eMAkduvQgU+Q+GC8VEjXO7/FYIAQiw04/wGQd7hvQHYmBeNq+sZIjf1BIYg3SzYk90wOqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/2023 11:03 AM, James Morse wrote:
> The resctrl CLOSID allocator uses a single 32bit word to track which
> CLOSID are free. The setting and clearing of bits is open coded.
> 
> A subsequent patch adds closid_allocated(), which adds more open

(Note use of "A subsequent patch ")

> coded bitmaps operations. These will eventually need changing to use
> the bitops helpers so that a CLOSID bitmap of the correct size can be
> allocated dynamically.
> 
> Convert the existing open coded bit manipulations of closid_free_map
> to use __set_bit() and friends. These don't need to be atomic as this
> list is protected by the mutex.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Changes since v6:
>  * Use the __ inatomic helpers and add lockdep_assert_held() annotations to
>    document how this is safe.
>  * Fixed a resctrl_closid_is_free()/closid_allocated() rename in the commit
>    message.
>  * Use RESCTRL_RESERVED_CLOSID to improve readability.
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 9864cb49d58c..f6051a3e7262 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -111,7 +111,7 @@ void rdt_staged_configs_clear(void)
>   * - Our choices on how to configure each resource become progressively more
>   *   limited as the number of resources grows.
>   */
> -static int closid_free_map;
> +static unsigned long closid_free_map;
>  static int closid_free_map_len;
>  
>  int closids_supported(void)
> @@ -131,7 +131,7 @@ static void closid_init(void)
>  	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
>  
>  	/* CLOSID 0 is always reserved for the default group */

Seems appropriate for the comment to be updated to the new define also.

With that addressed you can add:
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
