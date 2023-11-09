Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FD47E72FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345190AbjKIUiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIUit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:38:49 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3409130C0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:38:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBFgt5gl2xg7UeTDzZEoyLtU5wSOoUQ1CiHpb3OHVBj98Z6vt1UesLlOpv2QODBRv0upor+pa4gpfJJHaRa8wbIGz1xRNTw62AxVZ6k/7sUiSwk4A/cgzsBZj/y35BfUle1e1viNSuxa3Dj6AKavkx9lrW4rRY1VW6Po87oGs092ZlZKs+/w7VWqvESz6fxj6DpywNL2c4Wjq2Fjr673feyLVl1V63Q3Rwy8lTZd2RV/Fi6Ty1XmEJqJMMvmEIa5ATdGNxXsZ++uGG22Nl5iBlMSgJ+KcwpfQy4tQzCKk5Wv+Hl/7NnmUB5Poq6iGVWXrPI6VuaFWALf/9YhKTkU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2V/j5d4sxk2xLoWIVIDI7sqi5DubAPCiqFp9fmTTVg=;
 b=CiSaHw7Pv9ES3HU6sKO5HJ4m3JeRwUi8qSUlv9yHA7qlimOWRFCOMZ0PJAlFQ0KpWfbSilK6hyhPZIPqBniNK5mK0BCuAtNARLrZ+qVrFi3/VE+FcyZiSvZIMeH3eI4iTvhObWS1V0GFkPxH8ftvwhQAcdGmD6bIUggTsEz7QAQgtrB5iCz09J9OI241+tV8oUt/YOqDkoACL304QqeJ5eCEQU+LQblXZPtxx4XjU1buIiNH/G1lpd99SLTOjgDy/gJXaf2WwfxPqakhf0JTNXR3oeee1UdzjYzZn2qsABm2s0dFSeR73tk3mOpB/T06dpPa88qJCg/MY7YWv6T3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2V/j5d4sxk2xLoWIVIDI7sqi5DubAPCiqFp9fmTTVg=;
 b=Z3AOdpqa1Q9bJ/lNfmQgO/hSVyDUEhTjxC4X6h4bBqMaY/m/GR44rd2WTP6dhvKXVqqL78spUg0Gs/gkdyD5IlS3+88RRB4zS3IGDQPFBJrQXAd0tk1x4YSHowfWu21liGpAbUNCwEf1vz64yr09NAGZQ14q9w4HeBORmsWAjhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 20:38:44 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:38:44 +0000
Message-ID: <c87a34c6-7163-4025-9f5a-4b9225701b66@amd.com>
Date:   Thu, 9 Nov 2023 14:38:42 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 09/24] x86/resctrl: Use __set_bit()/__clear_bit()
 instead of open coding
Reply-To: babu.moger@amd.com
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-10-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-10-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0029.prod.exchangelabs.com (2603:10b6:805:b6::42)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5add53-21c5-4f13-518b-08dbe163ddf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qzLrcXaRWpSO+javCOBDr3lLVkslFPHTF3bBIhJd7p+VGIPjMrXdZIZRedLXI2fEla+0PIvFUCHz9jq2TiSEf6q9XEzr6rKPH5gZRv3tAcsctWaQxTV19VKnczxBnrm2tWiUYAGF5vIjBdzT2fkMHeRpgf8+/kvbDhe3JgN86A5VNkaY1NTYtml0a/uISbee5okb45+ayjCqBuFaAMq/twOL/JtyxGwymXuV3bBmndGwGKopVI4W5H9MQOcAR/QDOhRDWEki6XjNV10WEf+mzDj5h7it7uxi6tEqNDuenAFyWRFlQfw4ZOhyFtKQWKnZZKiKCjEtJyzMpWN5EoVBUT4ryddfQX6z3ZUUHb211k9LeFP1eVQH4Y/rGZgLCGEDtZ8pGhYiWaNNC5yYvoJ2InLXwt6qHJotB+kPRXeRWOUsCF8MsG/vhWcHRXGRsdhDOjXp55Ad3cRqjhdRjjzXzP2WBn0vzxsyIaUDHkhoiyT00LGn0M7UvL9z2CPLoqW4I5GUTj9hJbUwBiA4oHoW5v5HWrofXy0VJ/FhHxsPijjv4N5Dv9Wnn4zsjeVqqiH5EY5Odncbe2Kqr5En8n/j/D05RXQk+Y18RsbmMilx5Nwo81Wr9fRSkLm2dwKhhUPY9LF0wutQz544i0lhrGeSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(4326008)(8676002)(83380400001)(7416002)(8936002)(5660300002)(3450700001)(6486002)(53546011)(31696002)(2616005)(86362001)(316002)(478600001)(2906002)(26005)(66476007)(54906003)(36756003)(66556008)(66946007)(6506007)(41300700001)(38100700002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGRvRkZkZytpbzF6YVhsK3d5TWdKMDhJYW1ZSW8yQlIzdmQzVTlQU3IycnR3?=
 =?utf-8?B?ZXBIdUUxekVnRFArbjliR2Fid21wc2FxdHVuWWRxZGNXcFJRZE9EeTRFd2Uv?=
 =?utf-8?B?a1dqN2dPNit0ZFYwUnBNTEZYZzRyM0ZDRnFMRzBKUW9oT1QvYkxVaURFc1ox?=
 =?utf-8?B?d2FwSHJEK2U4U0FBdTVHN1BhNlR0cnJtMkhHamNWNXZDVjM4MkduQlJnbkpa?=
 =?utf-8?B?WjExdllHMXlackZvVlRITmFzaHRWUzZDcHZFM01jWXpGWWtnRlZnL1hVQ3l3?=
 =?utf-8?B?Zm9TYmdtSkZMYjFxa1IwaDRzek5RT0pacU1zTnNPV1NHR0RhRkZKblF4WDY1?=
 =?utf-8?B?dXNMLzdvUEpEYlZlclRoRnAzb1lIMytoRHBLeGdLZGlMcGc4eDJldnRhMGl4?=
 =?utf-8?B?WnNyZldRazlGYlowMzBaaSsrSERNRTlWTllTNnZBZkMvVTJnWHhGRStUcDNl?=
 =?utf-8?B?S3FIbklnK21ibkxZOUxjYjVBRUtsdTN0ZVNhZ1ByN1JMdGpQLzJVVkZqTTJT?=
 =?utf-8?B?aUVxb1JNVThaNitWN3RjaGJURHRLcTBJeGVqS3RzdVA1ZnFsZDFlMjUvUHpw?=
 =?utf-8?B?Z3hLKzJFYkYwSTJPWFZuVWI1UzVGeUJvZFVLUVhPUFBxMkd6aUlFbjcvdU1k?=
 =?utf-8?B?aGFGd2Ntcy81RWZ1dnhoMzZFSlZ4OVZnbzNMTVBVTGg5TWkwZXJWREZhV0lJ?=
 =?utf-8?B?SlBxeURDRzIwUlgrRk0vVmVjQVk2T0VNNndzRjE5WDB6dGhXNHpZamNRb25Z?=
 =?utf-8?B?bEJ6OUJyOUVIUzU4TG5LQitybk91M2x3NENCazlvNUJBczJSOFQzUUtabks3?=
 =?utf-8?B?VThzeUNXSEtUNUtTTlcxb0JQNkxGTW9jdnd4cDVZQ241cUxPekUwdElJaFF6?=
 =?utf-8?B?cTRmZzFua1lZUkNheXZKdjdEaDhWZ1ZLL1dxUzZKWkkrVFMzc1BsWTZPTTho?=
 =?utf-8?B?R1hwWUZudDRsQUZweHVzMDcwanplQitrQjVlcjFQQXh1aE1JTEp0WFN5cTVy?=
 =?utf-8?B?ekpKN3ZqdUtRSlQxYVFPSVhFRWxuUlFNVzBLQ2JxeGlCY2xLTEdYYWg5RlF1?=
 =?utf-8?B?aE1EOHlMbFJWZFJkNEtQbHRadnpwSk1OblBPRzZkdC9JVTBwZ1psbmRhMTZj?=
 =?utf-8?B?RjBNeW1QbHpneXdrWm9jb01iSUpjN2VGb1V0dUpMOWZoN1V4Q2FPbXRtQXZ5?=
 =?utf-8?B?NEU5UVp2MFo2Q0owaEVnN1EyVVFzSUNzbzhmakt6dmhkczdjQWJYQm5yc0p4?=
 =?utf-8?B?NWt3ME1KUEJ1Z2dCWFZJQWZwK1Nvc1E3T0pTS0xETHB2T0pUSnZRcWhmR016?=
 =?utf-8?B?MDdOc0R2RzlYR2lxa2E1NDl1YXJxbTFtcitSMXVKdWVvbFdjRVNYZ0xlSVlz?=
 =?utf-8?B?NVlXazJPd2pnZWtFVk9sb3hma3p5cm5mR1dGd3d1bXhORnEvQ01XdFBvNXhI?=
 =?utf-8?B?SWczSzd4ekcxTkltY0pybjl6WUtxaXJBWFVEVWxwSlhoSmZsaFkxSGwyMEpq?=
 =?utf-8?B?UkhTSkJyUUt6QTg2WEdDbDF1c3RUdU4rYkRwdHdyUDNMaXpaczFBZ0ZmSDhx?=
 =?utf-8?B?bEcrM3kxTmNCYUN4YmdvNGtLcWJLa0gxbFlOd2VwYlFBaG5ZZmh6aFJsSEl5?=
 =?utf-8?B?d3cvVjhFenNhcFlNdGpjRWM1R1N0bElXS3NDRG1lTTk5ZEFPVnJVeFFLYTQz?=
 =?utf-8?B?Ti9RN3ZsSmJuRXh1NkowUUwwWG5IbDFObTlwSW94VTJQV3FFdG1CdFZuY29F?=
 =?utf-8?B?UWJick92TVFKQjduUzl2ZEhrSm1hOXBURk85NnprLzViQ2Q5T2ZsdmZ1dnc4?=
 =?utf-8?B?TFc0U2JCSHEwckFZMi9zWEIxV1FhQm54clpndldma0FJVWliR3plVnkyZHpM?=
 =?utf-8?B?aFdGN1dJaStVV2IxMUErK0x3WTh3UmQwV3B0Ykh2TGhDRVlvT3owemVEZHpp?=
 =?utf-8?B?YTZWRWlZSGxIODVONkhKNVpnaFhyZTRXQjZDRk13U1laTW0rUDRKeHFmYjZ3?=
 =?utf-8?B?Y0VTU0dPZU1MWllGa09RZmVvd3dVMENnS0pPRnQ5VlZkQjBPMlJMVmFiY2N1?=
 =?utf-8?B?czZud0kxbG9jUDZqdnNIdUZDOWhRN0wxY2E0Z1g2akR2ZE5oak9EZjNqT1R3?=
 =?utf-8?Q?1lPM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5add53-21c5-4f13-518b-08dbe163ddf4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:38:44.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9a9SDtw66V9XcUzwZq14kt9QuIFPXwed7jLAej551cyGDZcWq53miPWO4f2LmMqG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/23 13:03, James Morse wrote:
> The resctrl CLOSID allocator uses a single 32bit word to track which
> CLOSID are free. The setting and clearing of bits is open coded.
> 
> A subsequent patch adds closid_allocated(), which adds more open
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

Reviewed-by: Babu Moger <babu.moger@amd.com>

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
> -	closid_free_map &= ~1;
> +	__clear_bit(RESCTRL_RESERVED_CLOSID, &closid_free_map);
>  	closid_free_map_len = rdt_min_closid;
>  }
>  
> @@ -139,17 +139,21 @@ static int closid_alloc(void)
>  {
>  	u32 closid = ffs(closid_free_map);
>  
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
>  	if (closid == 0)
>  		return -ENOSPC;
>  	closid--;
> -	closid_free_map &= ~(1 << closid);
> +	__clear_bit(closid, &closid_free_map);
>  
>  	return closid;
>  }
>  
>  void closid_free(int closid)
>  {
> -	closid_free_map |= 1 << closid;
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	__set_bit(closid, &closid_free_map);
>  }
>  
>  /**
> @@ -161,7 +165,9 @@ void closid_free(int closid)
>   */
>  static bool closid_allocated(unsigned int closid)
>  {
> -	return (closid_free_map & (1 << closid)) == 0;
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	return !test_bit(closid, &closid_free_map);
>  }
>  
>  /**

-- 
Thanks
Babu Moger
