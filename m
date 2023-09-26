Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4887AF6C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjIZXgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjIZXeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:34:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D86FAD3A;
        Tue, 26 Sep 2023 15:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695768078; x=1727304078;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qGi/VplU31v6e/iLwwYdhbCU7og3WogKOmu13NOmMyw=;
  b=g+IVWt+f4VBTp8qowVhV+rTa4TD/A/0/8ri0mpz/+jP56D+bpldc1Lb+
   Yi2H+/A+UVnzFH5evnkWBYCl59F/h2p1Bg2OYOWU4DlQ0QwO1wywJb0U4
   PyarbYJOqw6gFWa4VpbTdfRB8cBu2jH/MYJtaK7SJpSWcaHUzVaLy7j+p
   bpL4Me9k7CduPH0aqxfXdmEhNP2hM1LiUz6KpvPKmyV88+8OX8xH30DKN
   xHjrFw8X03xWvXnERo9W1IFFJ0a37Ct6dZNaX+KjmOU7Ka5YOnRSSxd8z
   4RP1AUk91ZWs20DzvMAeVrD7lHPcqu0fqAccwUM6Pr4LzMsRAMZnWHJoO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361048539"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="361048539"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 14:03:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="995924524"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="995924524"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 14:03:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:03:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 14:03:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 14:03:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXGsZYXf666lZSgUfFIa4N7q67qz9ZXVTU4DpMs//VzGQWPaBHLB71o0SkDMd7n06kORCHLCx4uEgVGk3Sh4YtWBdLb46z/oMTIruzVgp96oJqABkK04d8KwIMKEw3mxXc0A4dmQU4IV+Yb2I8cYqYyeAVItcOezauDQgJWaqxgvcPPwp36xxRj9bIYQQr9T9f0b5ic8gAiSiOTQFA1N3/fEqEdbkmTzFpQzyZZrGPWFHehTC86GHlJ9heInQo2eycV/tv80fHFIm+DNnbL5Q9Ns/G5OS739H4J/Qf4QFYalwYkDf/sFqvhbSP7cbi6EokKsrT5ZioSEz6fLH0UGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c52y6y6/FDcVwasc7KFmJxbDY1WNuKt2mJPaqOZ1YhM=;
 b=AluFwrQZbCBcTpAJhQzobgMN/TApCmmZzGeGjLq5xGOKeBjdVhiVYjnRspOXU+hVPrRfqCAy9BMrJjeUosEQqX0fSlWOUtsnx8wSt3e2g8eH07VLSwI4Em+mNe6jIrZ6f0i4KCvw3FdOJ4jEnmUktvHWxJKFOOtf8bMyiN8uN9msV0VbjmX/bnK8JX7RGWKOCBRWHcz255neaizNX+wq8QBvIcixYZP1d9m7chWOfbBRoDHynzM9lA7TEQ2CYsi+TytyMsGuqbSlO9QKfPfTwddovIRIbQBx1et4pb/+TfAo8Ent4ZE3Uo/wD4ks6Nr0JujcOk1nmGodexNQlXsd5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7695.namprd11.prod.outlook.com (2603:10b6:208:400::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 21:03:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 21:03:31 +0000
Message-ID: <50e1be65-8f27-c290-94b8-7dd1d98dc663@intel.com>
Date:   Tue, 26 Sep 2023 14:03:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 6/8] x86/resctrl: Sub NUMA Cluster detection and enable
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-7-tony.luck@intel.com>
 <ceff3d3a-92a2-2e67-76a1-da5639f91162@amd.com>
 <SJ1PR11MB60838A29873FAAA50C9E9536FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB60838A29873FAAA50C9E9536FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:303:16d::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: b9bd7f3c-cd63-4e99-cbb4-08dbbed409c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H+TX4VQiwrwPib+vwxWTCvxt6yjgsnR3dLp0BSXOVmWP6oE6M9iEoykexSQ6apbjOV4ZB+3CZJTjxi3J2h0nLAtPaQI1E0DiLjEX4SsREX9ANngxA6dj1W0KBviI/VgpY9TMs2QpaLbFOVX4VpyNZtWXiImW0kcwCZfZYo0DrS44LfZk/9xNLj+5qeY9YugFr3YEG+X7Wo1InhNsym1kGtFa6+7O3WUf8Qne5Pfpj51F8Nqgl3pkC6q9b5xKxmtSJMVSxYbmgxWyB3B8lzORgqGAnJju/VEqk3F48D5riBIuK4zZf6mzU2CFVS0GuXu1jD5xEjSPs2BORS/JSmNA8y8gyfJeB+Ej2ZyZLnP6jnNlKa8Ocyz2e5AYLLCDMNytHP/pDQ6MLkp0c+9VuQsL0hqGXg2hQ735NPZvHGIkKcLS11XCRd7+Kj5agsHuYZRdA5BzImQA1cGGokVESirralWwhO1IG2JIkRjedRJZOl6C0zdFhnP5Oyd3Kh0CyDPzwlcvd0zhtWATRnVWB+GpAwpmroIyIKwL6itLXTO4G+ZnZ9ad55TYUQG0TnHNryEprboYZcf3jLAyHyNTRDZ12szt8caUjnsx++dh34849C5OGw012YO83EUCHLCrN3kRB0z6/hTgiqhEga3AXzZO4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(316002)(44832011)(5660300002)(8936002)(41300700001)(4326008)(8676002)(110136005)(54906003)(66476007)(66556008)(31686004)(66946007)(7416002)(478600001)(2906002)(53546011)(2616005)(31696002)(6506007)(6512007)(36756003)(6486002)(86362001)(38100700002)(82960400001)(26005)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGZWcnFGR1o4STR0Y0F6WXZkQmU5T1dxMmtudnV4ZmI4UFIzdzJwamlUYUhx?=
 =?utf-8?B?bUhGRDNPbDZKeHVXekJRUjM2dEhZS1hoNWViS0htUnFoNFVwZURxNm8zRFgy?=
 =?utf-8?B?VmhiWnBVdjJWdXNWU2xxKys1TWdHUXQyREdUYVNVaHBnenBoaWFjNnZsZ3BI?=
 =?utf-8?B?MTBlWFV0V0tobUxhM0NtdTR0clgvOHQxODd5ejArNE5iZEwxY3V0VmpPWFVC?=
 =?utf-8?B?QlZoVzNaUnd5enM2VEdJdlZwaFJBYnZVZ21sTnB6TGdjREpOdGUrYW9zL0Zp?=
 =?utf-8?B?d1U5dUdsZFpLSkZTRVBXa2xnUWd1NGxjWm0wRzVtYmtYYmVBVzRRMFNuK1M3?=
 =?utf-8?B?Y1pmOW1FZUtZaFBFVy9jUGMzZ2M0akx5b2RGV1FoS0h3Ykh4V2JoamViaDhH?=
 =?utf-8?B?akk4M25EMEtYaEdmUkFSU0JpQ01TeXl4WUZFTlVGdWV2OGhWNG1WYmFoYmFX?=
 =?utf-8?B?WThCVlkwOU4rZlM1d0tTRXFqck9XL1daSHBlNEk2KzJFMHVnejRhZXNIUTln?=
 =?utf-8?B?QTF1Z2N5OE5PaFZuZlFmYS9uODlFdFlkUVpHbkhvOWZrUlBrUnorT3lZUjhU?=
 =?utf-8?B?eGVEZC9CZ1R0RHR4ZkNJYXhQZEkxMysvRUxMQzV6OFZRbzBZL3lCdlh4bGhz?=
 =?utf-8?B?OFVIWWlVMXN5QlVkQTVnUEdwN2xmeHJQcFYxT3FiMmhYLzE2YWx3RlJCcU40?=
 =?utf-8?B?a0Z4a3NSOUI3K0VTaHhIMjJtNDdTY2crUU9ORWtQVWxNTUR0WDRLbGxiVGE5?=
 =?utf-8?B?ZFhKT0prV0dpaVRhY3ZwekRpZms0N0padlNSY205bGFXSm5NTFNHbWdwZDBr?=
 =?utf-8?B?ai9wTXBpeFovQ3hvVkRzdUorb1c4c21ld3g4RTM2aTk1RmllKzEzc0treVFM?=
 =?utf-8?B?UGoxTGRhUnNCYWJveHpBV0dXcHRSM3JIeWdsSEZQYTFFNWRHaVBSd1ZBUXVO?=
 =?utf-8?B?VzhrM0VvVUJyQXNVRTJsOFVoVjJveXYreDFFa3htODJzMzl1dXQ1a2M0NWk3?=
 =?utf-8?B?WXlmWHVvcHFaaGxreDNaT2x4bmxCQnVpelZkRlMxT1Rzek9Pc0g4dEpzSTVw?=
 =?utf-8?B?eXUxL1M0WmFISGJZVHVESVJEeFU1Q1VPdnlSQW5mN01PRDZHeWhxdy9WMjds?=
 =?utf-8?B?clZ2NmpkM0dIdHJ0Yi9mQTJkR09DWWVpdWdOR3lzVjkzbEtiWk1KcjhuN20z?=
 =?utf-8?B?Y0djaXA3ZXhIOEJyc1BoMFdhdWtsbXBNMDhXaTFkc0E0MUIzaDl2L1ZGSE5F?=
 =?utf-8?B?RVg3WEZ5ZytIaWVLaHZIRm9ZeCs5eTRhUlpSVXhMaTdZbm1GVDk1K2IwVjIx?=
 =?utf-8?B?UmtTcFF5eS9JVFRyUURpenBBUEdDU3NnV0QyWUR2Y2RTWDdvUkJycnlmYUJw?=
 =?utf-8?B?TmhiUUoxQUdydnBoMXZqS0JlMy9lUHR4bFB6a3RZZDF0MC9IOHNQYkNCdXJ6?=
 =?utf-8?B?VGFWNFhLNXM0U2JtZDZ5bGlXWXRzeXVweVBRLzAvUFpDVUJtdEUzMk5lTHQ0?=
 =?utf-8?B?OUhubE5panRwQjgyQVdMUHl1ZFdkdTRKU09KcGNSN1FySExVdDkvS1JZbFlH?=
 =?utf-8?B?RnZMelJHbHNVVnhKV2NPT01HN1J3a2wvSkhqbEdDRUdEcGRQeWlZUkswcmFR?=
 =?utf-8?B?WWt6S1J1a0FoK1VUbVRMVkNBY2tNK01VK1pScDduWmJOVTdhaHp0UDB0RW9j?=
 =?utf-8?B?Q1VOMnd6akFmbWFrdGFaalNHNzA1T0l5ak1tOFgxWDFNTHJCUzY4aTF2eHBJ?=
 =?utf-8?B?MCsxLzVjL2xEQVNaakp1bzU0cnh6OVRVVW9HRlZaT1F5WDlZQUdCRmMvYkVK?=
 =?utf-8?B?emNMMU1zaDRFbk4wc3hSenNtN3B6V1JFNjVwZGRVVzFaYjl0VDRWQTRweTgx?=
 =?utf-8?B?TjdsNEpVOW45eVpFRnlYaTUyL0tKc1ZlOTNpTHhiaE90eUh6VHFSOG1Rbytw?=
 =?utf-8?B?SHBwTTBNS0ZoNXBzcSt0d1lLNzAwRjdDTFBac0NCOGtMUTMvMmVhMSt3aGI4?=
 =?utf-8?B?NWpRSTAvN0g2R1haVm04Q2RhdS9HeE1reFhlenlteFZTbkRQV1ExMjZOUEor?=
 =?utf-8?B?S0lvUk5NdldtYkppZkdTZzJMOG9nOXQ4bWRXTWpzZTRUaUp0VXgyUWRpQkVM?=
 =?utf-8?B?NTE4TlV2MmJnZ29XNzAzTmZIMGVlaWFYUS9wQk1zekxNMmg0TUR5ZHF0M1hV?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bd7f3c-cd63-4e99-cbb4-08dbbed409c0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:03:31.0837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyS6gvEZ6sJXeZyHLLl4W/6VZGWcoJ8rdMOe+AEGFNVsJf8UWzJEvuIj7Mw9Yrqv5AYwjF71eYR3cmWqMTINRaAKXyEl3zCz4IhKLtPc1Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7695
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

Hi Tony,

On 9/26/2023 12:40 PM, Luck, Tony wrote:
>>> +#include <linux/mod_devicetable.h>
>>
>> I didn't see the need for this include.
> 
> struct x86_cpu_id is defined in this #include file.
> 
>>> +static void snc_remap_rmids(int cpu)
>>
>> While adding the new functions, i see that new function names start with
>> resctrl_ prefix.  However, we are all not very consistent. Can ypu rename
>> this function to resctrl_snc_remap_rmids?
> 
> I try to put a subsystem prefix on any global symbols to avoid random
> conflicts in other parts of the kernel. But I'm less sure of the value for
> static functions and variables that are only visible inside a single ".c"
> file.
> 
> If it must have a prefix, should it be "intel_" rather than "resctrl_" to
> indicate that it is an Intel specific function?
> 
> 
>>> +static __init int get_snc_config(void)
>>
>> Same comment as above.
> 
> Same answer.
> 
> 
> Reinette: Any opinions on these?
> 

I agree with you that a consistent prefix is expected from the global
symbols and a prefix of resctrl_ is indeed the goal as can be seen in
the growing include/linux/resctrl.h. resctrl has no established pattern
for static functions (look at the other static functions in this file
being changed) or even those non-static functions and data
structures shared between the resctrl files (see
arch/x86/kernel/cpu/resctrl/internal.h).

I'm ok with the static functions named snc_remap_rmids() and get_snc_config().

We can surely start a discussion if there is concern about resctrl static
function prefixes but that discussion will have larger scope than
this series.

If we do want to focus on function naming I do think a change that may
benefit this work is to be consistent with verb placement in the function
names. i.e either always have verb first or have a consistent snc_ prefix
followed by a verb. I do not recall if there are x86 requirements in this
regard.

Reinette
