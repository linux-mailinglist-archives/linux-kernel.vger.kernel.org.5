Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED447E5ECF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjKHTnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHTnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:43:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DED2118;
        Wed,  8 Nov 2023 11:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699472631; x=1731008631;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cBJDWlWZeMvv/A1S9HJ03qsvuyMDLiw8XE1DoS3ATr0=;
  b=ghjOv7+DBCSfObKOjbsjre70cp3nhODzYfF/zycydW88KpI6uS86oaYC
   wX4IWaXR9eTn04li3FBReA74HhwecvFUVi/N4AX4rh69qRLCoABzlWAZH
   VaiI5BNsUb0TwU1PC0RQ8gjrXrPe0+XqnOyfRVpNdIr5CAHjnca3ehkDj
   Rxi0PrzLPn5bEwaRyrTH8HJzh9bztfrRjIupBUDEF/qhpcmqipxcUCM4J
   l/Ycgf6KIzXD63Z/zOAY+HnQ8RBmwY9iGaG24jAlG7zMYIpwhMqnWMVK/
   OjVySbJ/QRVhvkLVmqsSNBBebSR2K/mgpqYZFVlZZnqPQ/TSQaj0nftxb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="2799412"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="2799412"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:43:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="11295538"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 11:43:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 11:43:49 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 11:43:49 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 11:43:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoAnvUN+hMcHaLAw10ma5Pwfqmya+rvUYxXMQkNpw4bzHP64xO/pLBuaD62OoEijK4TCbcYzRd5Ustg+nC2DQzjIqnArXPJ9FPhfdrzWQmpeVQwijkFaGReGa1ZebI5MbiLSHduZZ9Sb9LiIloD6IXPNwWR5MwMaJwrbatjR0OXJqk8QHxogkSkwo4VPEVwCl4E9XZfqAMLNllC6iSIpk7zIZEugxik/ECb/eq05T+riVXn700oHKD78Be3I08ob+FfUNNO/nVVUYbVLvP2r7dGB/ADr4J9wuPmtRSc3Jg/U00MiVw4eylpx6Cbhgkixg204qJ6UxVugy4In98fC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehUtGtCdHLAKL21MG8emRkqfhnR8TPzfhvby6QMifkM=;
 b=XqXPN7scLPTjoIG6WmqCqy+9S1lB3tKs4qTGEIM0B1ditXft83UauXZFmS5Wh/H1dLJWytqCxnsefznz/Wl2vVMQT3Ojao3uwGbUK+jbrzW5gc9eBiQBPfYZIZlaMpbbl/04caDNo8UnKujgBYE/Bk4DM2p+lUdtDaVXLKrJJUyVT2jhhX0cazjP9QTZMcoMvn53YJy1jb+v51/HRrn662xC2DrueQaoYKX5VUYSvhqSJ3+3Q+KPxrSibROeEG8oc5hqyjX+szTn5aVQKqzcfT5391fxwgIusI2WQZEqrRVrcRfHR2y8LSrYb/FzFbdRTcg0BmC90VcDnJXBJabI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB6174.namprd11.prod.outlook.com (2603:10b6:8:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 19:43:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 19:43:46 +0000
Message-ID: <3c2ff898-97a6-451d-97e5-095c499b7c22@intel.com>
Date:   Wed, 8 Nov 2023 11:43:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/8] x86/resctrl: Split the rdt_domain and
 rdt_hw_domain structures
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231020213100.123598-1-tony.luck@intel.com>
 <20231031211708.37390-1-tony.luck@intel.com>
 <20231031211708.37390-5-tony.luck@intel.com>
 <51332bf8-d641-4a89-bcec-60b849fc6a34@intel.com>
 <ZUvfSbnOY+niAr+e@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZUvfSbnOY+niAr+e@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: f668ee7b-4e6f-48b6-04b6-08dbe093058c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 62eDy5DR7vO5R4B5lGqhcwu1wGVFWmifKI3kSgqyoapUQLgTwEOCz0QkGBwSeeLBBYZe4dOQYV6d8ZANc0BfP0Dcvu05KN6OKg+43jVMxWmmnyrcCiYl5DN3HUovyzk/j64fDvxUFQmPF95KQyPnpjOXb+5T139809J3Y5YK3QqiIro9r7c7Q8deNKiP0ar/vdPsfI8Qs0mAL8mOXtAciWYwqM9xPQYU7J3nL5YL2Zr0imZ3dKBXRHZTlCmEgqHV7mRFHwn44n3rLinFGJpDdO3/FF/zpLRE6Ka0XSnm2qTLG0Exztl++ez71bg+fwv23euPOVfB/SqADZQ2TDkhaPjTLaHuWUr5atkI5b1PBdrq3J1yNMPcg3VMRSbmpPDnTGGCQgF/vOewFvocRXndgT9yH/o0NYErJZolk4CdUOjALlAq/lLcU/Ts37ZuVK7ti7WM/kFusL5yVcxiFyR2Htxm7+Kf9jo3ulIOS5Q5bLUGEVgI5A4C81jyXkLG+doBQ37IjdkMbV2khvxiKOpwg64X2EnPZySe9UY5/2b5f7hbTkdwsCdG7sD3ZKI4xGUUdAE1Nk3DYM+SepqngQBZ3yWyJ1qMnFUYe4zzfV276aKUGoAtMKzv4jeoKr3JKwox6OXbP8EXWgo72y8pcVCgtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(38100700002)(82960400001)(83380400001)(478600001)(6636002)(53546011)(37006003)(6506007)(6666004)(66476007)(6486002)(66946007)(26005)(66556008)(2616005)(54906003)(6512007)(7416002)(316002)(5660300002)(8676002)(6862004)(36756003)(4326008)(86362001)(31696002)(8936002)(44832011)(2906002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3BQNUdNQWcwbkZiRzdGVjJTckZEZEQzUmRIYkVucDdmWDNROCtPMnN1bWdN?=
 =?utf-8?B?UmR6dkZqVStCNWRPT210VnlNcXdCNVdJeG10MTJxdHpNVHdSenRXYUFYdXRw?=
 =?utf-8?B?U1RIbExpRVAzOHV2TzlzdldMbUNab09PVi95ZVRZNVVPTU1yZmwxNUlOK0Nm?=
 =?utf-8?B?QklVOVVMRWZML1kxakZ0QWNqYUFKRVRER011a0g2Nmt6OC9peDM0MWJ4ejdr?=
 =?utf-8?B?L3lJVTZwM054OVYyL1dFbnNMU254U2ZiVFBCQXpvWStJYnhCdFRidVRsUFF2?=
 =?utf-8?B?enhlY1lKTHNSNlMxSWlqRXhHZGpkbmo3U2JPTWd2VWV4NUU0ZXovbnVTZ1RJ?=
 =?utf-8?B?STFaa2lmZmFiSmVCOG5SNm1iRk04L1NOTDlmQWtTclJTVERueUcxc2FPbjNp?=
 =?utf-8?B?c0E3M3EzVFJKTWR3bEpyQTVxMFRRK0RhUGhMbVg4OWhseFFMNmoxQTlLUXhl?=
 =?utf-8?B?ZVppVFg1YUN6SGV3QThhbDB3NlR0emVRVDhHNjlDaHZIMHJOTW5Jcy9pd3k2?=
 =?utf-8?B?TUk4THN2Z0hFYzdPMEZZV040ME5menZ1NndRcXRsL09vWEpMWkZZVDJVY3hr?=
 =?utf-8?B?WFVCdzJ3MjRoT3Q4UFJJaGh0MmZJOEFKNzFmcnV2SzR6RS9KclFvY3lBSDBS?=
 =?utf-8?B?NktuRWJLWldjK3JrQlFLZm4vL0RyTGtuTFo5WVprMUEraGFBUlVaRjFTVWFH?=
 =?utf-8?B?V0E5dkJLd2hISTQveTlzRUhQYmxhTVJrUlZwclpYZHNEL3Y3Q1FENjBvSlo3?=
 =?utf-8?B?Y2pkQ3BrSEhVZ3NsZXFSeHpjRllDZzFabWxuNmpXdnErVGhGQWNVVTNGcS80?=
 =?utf-8?B?VlNpTHFjY2pwaU4vc3JyVmRJUWpzbEdmOUJhZ2RadVFDdHQ3RjdPcGszNHEw?=
 =?utf-8?B?TDA4Qlh2WGZtK3ZQR0RpQUE5MDFkcVRrU3JuSVYzRGV4c0RVZE5kS015OXR5?=
 =?utf-8?B?MlFrUW5KejlUZDRSNmtSTXA0YVBnMXllTDk4VkxDbjA4SE9Xdld0OVBPeHpF?=
 =?utf-8?B?LzNTWXdZREc2QS9kWUlpT0lPSzN6Ykk0Z3R5RGswK09hZlFvZTE1Y3ptOWh2?=
 =?utf-8?B?ZzBBbUhIeDNkUlIyK041b1VTZUgvZm1VVmJncTQzMXdFK3BDa3lqUDgraGFN?=
 =?utf-8?B?OExCdkdCaGwyRXRmVkRFZjNrVUY1cFN2cnA2eTB1Y3VmZnY2RkNxR00yZmI1?=
 =?utf-8?B?Y0pqb1BXMVZyQUp4MFBkM3I4SW55NDYvN1ZGV0J6WU5GQW40bUkxdmNMVUhF?=
 =?utf-8?B?YjNzcHBObnF4anF2N0xRdi9IaUgzSG11b2cydi9RL3FRRVN0RUUyRVBKbGpW?=
 =?utf-8?B?V1I1d2pQUHkwYTMyMnYrZG8vUTY5SitEMllBRDdKYlh4ZHJmdTNSbXYyd0ps?=
 =?utf-8?B?NTV4VDFDU3FWb2lpRFNZS21ZNVVHcCtBVU9vV2s5RG5XSDJ2U1pRWVJ2RHUx?=
 =?utf-8?B?Y3VJUnFXVjFwWFVIRnBOeHMxYnczSlhUZG80NXEwR3gvdmszWHR6cjRjMFl0?=
 =?utf-8?B?Z2F6SFN4K3JJaVc5cXZJNnQvbnFndE1hcjduR2NQNEY4TXZOR1B6a2VqU2lh?=
 =?utf-8?B?cUs3MUdMekpCYS9TdnFtT0FJVWR1dWUrdDRQQ2lCUUIyS09RN0ZVNWdxdzRE?=
 =?utf-8?B?S0t2UmdsUTdqT2Q0bXFhUEJRU2t4bjVCOHJjSlQ5c25vVWtFTkhkT1lyWnF3?=
 =?utf-8?B?VVRlTU15UWZqakVnM3htc3pOcCtVZjRZYXdqbmtrMDgwMkxGQmxaa1M1Q2wv?=
 =?utf-8?B?WEQ2bnNOOFVTa29BaDNmeVdScXE4N0ZSV2NVNUx1QWdKWTJ3UU0zNURVOFo3?=
 =?utf-8?B?QUYzUUdSeVRqNytNWTBKSjFmSHE4VjRpRVVFQW1jdGQ2V01vZmVWZ00zMDhT?=
 =?utf-8?B?aEYyYnVIZ0poSUtjdVdpaWdlK212VDNDUW8zT0pnWUNnNU0zaUsvTHV4QTdn?=
 =?utf-8?B?RGViT1YwNUVKT1FlQnY2THhKbXNHMmc5NXlwZFR6blJCc0xoUC91NUIwZGht?=
 =?utf-8?B?cE5GWk5DOEZsZ1RwenlOaEV4bFhVcVdXTjZpQkZodHo0aTNhRFlRNCs3bmU0?=
 =?utf-8?B?MVVCS3NoeWtNUVowa01zbW1seGFFR2xqMWxPTVpHRWtKWFJ4ZFY5OG01aDBa?=
 =?utf-8?B?QUJuRk85ZUY4ZENlVk9yNHBzZW1KWXdCbnRZR2Z3dG9yTkNvdVdnOE1GWlp3?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f668ee7b-4e6f-48b6-04b6-08dbe093058c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:43:46.2511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epSlAT7Ybgogi9TaaklJBwqbhrrGAJJgYY6MyeoTAr1muBDywKYeD2uRp+JHiHqyDrdE4j0fUWiTvTB53rDRq5evGBBSW1dzZMgK4kuzJI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6174
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 11/8/2023 11:19 AM, Tony Luck wrote:
> On Mon, Nov 06, 2023 at 04:32:56PM -0800, Reinette Chatre wrote:
>> Hi Tony,
>>
>> On 10/31/2023 2:17 PM, Tony Luck wrote:
>>> The same rdt_domain structure is used for both control and monitor
>>> functions. But this results in wasted memory as some of the fields are
>>> only used by control functions, while most are only used for monitor
>>> functions.
>>>
>>> Split into separate rdt_ctrl_domain and rdt_mon_domain structures with
>>> just the fields required for control and monitoring respectively.
>>>
>>> Similar split of the rdt_hw_domain structure into rdt_hw_ctrl_domain
>>> and rdt_hw_mon_domain.
>>>
>>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>>> ---
>>> Changes since v9
>>> Comment against patch 4, but now fixed in patch #2. cpu_mask
>>> is included in common header.

This is the expected change I referred to. Specifically:
	"cpu_mask is included in common header"

> What am I missing? (Apart from a silly cut & paste error in the comments
> that I just noticed and will fix now).


	struct rdt_ctrl_domain {
		struct rdt_domain_hdr		hdr;
		struct cpumask			cpu_mask;
		...
	}

Considering the description of the changes to expect in this version I
did not expect to see a cpu_mask member in struct rdt_ctrl_domain since
it has now been moved to struct rdt_domain_hdr. What am I missing?

Reinette



