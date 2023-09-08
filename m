Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DEF7990E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbjIHUPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjIHUPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:15:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82232A3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694204112; x=1725740112;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WWM9AH1z+dpB806pqQ4T/MGnkob0+H3cshKNwOIQvyY=;
  b=J6Zl3nmelNyVnZZdWNyL88uNCq+IAk1NU4ZLnWWvZXermy+6paeqJ5Dk
   IgnHJ8f2OqHIh9w6FEixkoJLu2SxfVx6Jfk2wjituuUvFyCx9g7k7z0EI
   STlbQ5nU72DmPQOrNCIw67o31YGj+e8GeAn8bx/I42NAvX18074u344S/
   0V6v34JNaarjl6w0BX6wC9e59wRfprVS9g10n2n70Gph99AEEYMd0Ymqg
   HUBDwGD78kWD8j/eqdVjdomxu49ymxdFoXiA0rCB7AkIT6uN9SJUk1yMe
   xc0w/F8ejJ1zkl0iTcDlyg57I3bCeLQhKNTP1wmpPibRJQbr8UlOiVAwy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="408717451"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="408717451"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 13:15:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="692387579"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="692387579"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 13:15:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 13:15:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 13:15:10 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 13:15:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmjSucHGJJ5GwTM22g6vFW5OiOsc8R1fBLibecczB8yZ9bLZNh7ag7nz8C8P8pLTxpEv0crbY6t5MlXcBGKks7LjTSmgy7cGYAs3mwwcrLBANcRbjCdg0UBGar+0vNJI/oJBlOe2fhZo6CsK+8s7VXIwVliCPdJr6X3i5XQZZX8447/qCqYqwZvTGN/Z4Buau/+C9j7p6wdrHrzHfoG7Wz+KfkwCNJxwOXClKD5lkWQxJUQf+QKaGhO1a6DJEAhJZY92aGDAJ+EKPkqgdnXZCpTrKzrq7pFzACa9sAL/00WPJpG8uw/m852Qpig3smM8h9AB2LZqhjm9/rDcyuebrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J34KpUvIg85qzq9dpvVrAsRmMy7eAg62Ucv1zYHbKlE=;
 b=ZyE8Me6edQQ3Gec4pdWUV2+vmA2fozWuaQ1s7JA6NRnbW5GZa6Til2qZathCG1WLRt6LSPbNmABQFz080MMJga9rY2o1th6Z75ItvQI0SknMgpXaQlGw43DIynnHNGpDNS3QHYEseCk4mT4+NdGuA3Rr/y9MtVgRTyc7hSVwv/ygi5whpa+Hoh0fmF9lExHWLbHvedBIMawlWCMJFlAbuQoOAijOEAccPE86PDgA4Qfr0d/hMlPP55kI7gpGwap7khbeKHJIp6PVYYtUMIhe4G/qi4/n20vCMelZDcHsmzP731Ivew1HDUu+WlK15msJTy0xB64z+B+U32tdMV20Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 20:15:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 20:15:06 +0000
Message-ID: <f7744155-9526-684d-a33e-72988607a46f@intel.com>
Date:   Fri, 8 Sep 2023 13:15:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v5 12/24] x86/resctrl: Make resctrl_arch_rmid_read() retry
 when it is interrupted
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
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-13-james.morse@arm.com>
 <192aa189-8b08-c8c1-15dc-722e196493f4@intel.com>
 <5f5c2ca9-4a27-616f-1838-0740ced4525f@arm.com>
 <4006d76c-f3de-3484-844a-f54f692ece50@intel.com>
 <6cd40359-7a1c-a16e-cd2a-74bf6053f75e@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <6cd40359-7a1c-a16e-cd2a-74bf6053f75e@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:907:1::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b69ba60-c067-4df1-ab08-08dbb0a84ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rF4G4g4HflPhXUzGQ1JZxRmeNNPzsLfz1p3YiHZ9JVFYQjzCdX9AabHwh0oBSXtTL/Hs0BXGpsDkb8gAksf0J6ZXCpd+oG69mnAs2L7S+E5ADlnKWQGL8iSGWYx4nAmcZxk10IkcLMUED+PPypX+wg4gkB5Tr1xylknTJBp3oeEcx2KIWWtbGtJQJh9wVLJCj6S4Ck15IrOgEVu1dmemgtA/XGh+YdcOOJD+PiO+b4Npm7SyJABunl6qq7AC3W26wyXyRfZbzx7vmf664yFArWWkF8RqDHalPYzZsOFrsiNdEd6TzwsYVcNH2O11ptUNDkWVB1P8f7MmkrIO3K9jjOZuim2F7I2TyiH4MAPCmdp388WaTcQPSzfJgbA5nvt3qKj6fAybjs6M4JhF4Yo0nm57OCF6K93NO9OR7QL/oStzjp0PQdKIsETmNDni3Xe/7oo8S9vXBG3EYzs4ZL8QWanOODS6Nw2RM9Lst/Fs68dmrpgS4zeSw95VCQupC4OhYf6qJ/BIE0q+RdO2oBsWVlSuEajJY5ka+E3K3wugI8MCAl2vmPrhVjeVlEJzcX9oxv88teYHAO12SqU7Ic1J3R8Cdmf0jETFU5rlYp3PdgmNo4A+CcuE29A9fmVbUg055aRLyfkoa56ybpPoV3Te5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199024)(186009)(1800799009)(82960400001)(38100700002)(36756003)(86362001)(31696002)(478600001)(2906002)(31686004)(6512007)(53546011)(6666004)(4326008)(6506007)(6486002)(8936002)(8676002)(44832011)(5660300002)(316002)(66476007)(66556008)(54906003)(66946007)(41300700001)(7416002)(83380400001)(2616005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emdBTGFKb2NxTVNMdFd0Yy91ZlN5K0JDa2ZnRE1SZFpxeFJjVXBROEViMitr?=
 =?utf-8?B?cjk1amFobEM2R3VBdjZKclM3RG9iZkpXMnZpYXo4NGFKbGxLYTZ5VVRhVlI2?=
 =?utf-8?B?T0p6WXBhYlpDVzZxWXp5dEVncVp0T3BKdTEyQVIzcFRnQnRrbXR0ZU55L1l4?=
 =?utf-8?B?c2JXWmtXNm5DOUJHVCt6QzFKUU1EVCtDcEpzTExZc2doK0tBR2h4UGtxcmZN?=
 =?utf-8?B?Tk1FRFJ2RGNxQndUYmNwcFlSdnY5L3cvemRyTURCYU5QbTkyK3ZsQ2ZPd3RG?=
 =?utf-8?B?VEt4MXorR2NmQUR5NlpFVnFLL0Nad2NScGNMc2NwVDBSaFRRbHlCRWwyY2NX?=
 =?utf-8?B?UUU3cCtBR3Vnc2t5Wk84djE1ckEwSkV1OWZ5TytSMWlUeDY2ZkpCdDlxczhE?=
 =?utf-8?B?Q0x3YmlWWlcwcnQwenhNUGRyVkxOTkJnL3VlRzFEWmtXOFBLSDhPWVR4SGh3?=
 =?utf-8?B?Y1IvQmZHSFBYcVFPZHFscjlmT3FxT2IrK0haOWlCN3FVZDNvcXp4REIwNkwz?=
 =?utf-8?B?WnBSV3UvU3lUQ2k1WDZkWlMrbzhlSUtvNXlENUxWS0RYWGQ1Q2hFa1V1akdv?=
 =?utf-8?B?dENOVmYrWjN6Z1FML0docEoxM2F4MWNVRTVDRTUzQUdoeDBJdTIvV21tbUpS?=
 =?utf-8?B?Y0txeFhpK2NqL1ZVN3BZT3lJRXJveTRrcS8wWDJtM0pLMDdKamo3MmxnVWgv?=
 =?utf-8?B?ck9kaVJwNFhuV3RvamU3SU1WMjhrWk1Sa3pva2VsZUEyMWdad1lxdFMwRGNB?=
 =?utf-8?B?U2xuL2h3UTNCSEJrdHFCbUFqVkVMZDNITTE1UnBKemx4dndYMmZuMkR4U2JO?=
 =?utf-8?B?V3BMYzRkRFlLeGowWnRUREhSbGVFdDROb2RiM3hTRGlTTjhFR0pnYmhkYjRY?=
 =?utf-8?B?ZlN0NE5lYUZsbXR1eWhWZ2VUSGtmL1ZId2IrTUV5UWRJWnRtaWdWc2c3Q001?=
 =?utf-8?B?L251bWdGV1lPckR3eWs2R1dPRyt3Snc5TVU1U3VKR0V2T0ptTFRoVTdGNXly?=
 =?utf-8?B?UEs2NmFDWXhFYktyelQ3RmNBbFBuWUdhUXRIbU9YUHF4YytPaW9YOWJ0SXdv?=
 =?utf-8?B?d21KMVFBWGFBWE9DQlgvTjgrWEJnOUlpcXVvZ0ZEeU9PZ0ZPTGZOY0ZyZEhV?=
 =?utf-8?B?K0ZIcVJoR3NnZFEyMVRYZ3ZSM2xUZExyVW5maXJyQ2xOeW82VC9yNTBvR3Av?=
 =?utf-8?B?dlgwcEloUG9TbThNSWdyVWNBbGNMaExHZnBzenI4cHAvOWRrZmhJc3drZjNT?=
 =?utf-8?B?ZGNOTEczbXN6d2lrTVVLQXdYWWZqaCtaM3pUWm1HMFlxWkdmZGd1UVg5S0RM?=
 =?utf-8?B?SG1Td3dVMWRvMWxpSnkrRHZRajBqR1V0dWZYVTdTaFFXNVdPUlZHYy9QT2lB?=
 =?utf-8?B?OFd4VjR2Z3l1N3FlaG10Y1VZV2Jzclc3YTZjRVQvcEF6azRxYzlRZmFMT3M5?=
 =?utf-8?B?TWI2Mm82OUJsa3kvc0E2V0ZrYzdZRkFlaThNR3RVQTg5VkxxY1VUNjJHcnRw?=
 =?utf-8?B?OGo5N3dqMVh2bVZiQ2JuOVNRM2F2WmRKRTJRUENCRnJjdmlsRng1RElNQXJM?=
 =?utf-8?B?NktMSWRXN3MydzBPUTZaM01ldlpPUzRYdzlHcWhPVndibmNxdFpoWTdYRENE?=
 =?utf-8?B?dFJ6TTZwWTlnYklYUWRPdi93ZUJkUnVYeHJOUXJWZ1NQTG0vL2o1MGV0Q3FT?=
 =?utf-8?B?VFc3MHpCNmpiT3dMaDNQb1V6WFNBQkZSS29IRDV3TDAwM2QwWWs4cWdyU0xS?=
 =?utf-8?B?aGhwWk9SNGtaUzRkOU0razZNb0xxZ1lpY1NHMmsxbjNUN1NjbkZHU1VjY3li?=
 =?utf-8?B?blU0elZLaFNadmJ3ZG03R2hRcDhXQU9YeTVyN2Qza29DS3FxTHVIbnZKbWcx?=
 =?utf-8?B?bjRobDF6amh3bWJoOHdDUHp3SGd1RzdGWEFpR2NzMS8xc204Mi9RaEtsaXVT?=
 =?utf-8?B?aFoyUnhDQUV3OTNLK25tQkpOUmlmRTAyOWg1RVUxOFR4ZEpzS0xHYmZMSDVj?=
 =?utf-8?B?czNDM3c3K0hEOUxUamI2akZSS0E1RXpNKzNycWN2MEMrQlZ1VytIdmdrNERp?=
 =?utf-8?B?UzJLbnYzekc1dTdQNlN2UTZCaE5hTXVPYWlteS9pQmkyZXRmU1grODF0OHYw?=
 =?utf-8?B?eGJJU0RrTjVvak0zSVE0ajdBQ3VQaHUxcWNuczh2MkE0cjRCaFdacXV0Y2Fz?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b69ba60-c067-4df1-ab08-08dbb0a84ac0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 20:15:06.0156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQq560F2gHvczj+3s3yhxtbD4CWMoz7597/dZKVY8qtRF7oRtvN1RO2fr1cckO2ke+LO2DqqpqaJ3T+hW7yndWjBfXV80S4pQLoJ5X8tvKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/8/2023 8:58 AM, James Morse wrote:
> On 8/25/23 00:01, Reinette Chatre wrote:
>> On 8/24/2023 9:55 AM, James Morse wrote:
>>> On 09/08/2023 23:35, Reinette Chatre wrote:
>>>> On 7/28/2023 9:42 AM, James Morse wrote:
>>>>> resctrl_arch_rmid_read() could be called by resctrl in process context,
>>>>> and then called by the PMU driver from irq context on the same CPU.
>>>>
>>>> The changelog is written as a bug report of current behavior.
>>>> This does not seem to describe current but instead planned future behavior.
>>>
>>> I pulled this patch from much later in the tree as it's about to be a problem in this
>>> series. I haven't yet decided if its an existing bug in resctrl....
>>>
>>> ... it doesn't look like this can affect the path through mon_event_read(), as
>>> generic_exec_single() masks interrupts.
>>> But an incoming IPI from mon_event_read can corrupt the values for the limbo worker, which
>>> at the worst would result in early re-use. And the MBM overflow worker ... which would
>>> corrupt the value seen by user-space.
>>> free_rmid() is equally affected, the outcome for limbo is the same spurious delay or early
>>> re-use.
>>
>> Apologies but these races are not obvious to me. Let me take the first, where the
>> race could be between mon_event_read() and the limbo worker. From what I can tell
>> mon_event_read() can be called from user space when creating a new monitoring
>> group or when viewing data associated with a monitoring group. In both cases
>> rdtgroup_mutex is held from the time user space triggers the request until
>> all IPIs are completed. Compare that with the limbo worker, cqm_handle_limbo(),
>> that also obtains rdtgroup_mutex before it attempts to do its work.
>> Considering this example I am not able to see how an incoming IPI from
>> mon_event_read() can interfere with the limbo worker since both
>> holding rdtgroup_mutex prevents them from running concurrently.
>>
>> Similarly, the MBM overflow worker takes rdtgroup_mutex, and free_rmid()
>> is run with rdtgroup_mutex held.
> 
> Yes, sorry -I'd forgotten about that! I'll need to dig into this again.
> 
> Part of the problem is I'm looking at this from a different angle - something I haven't described properly: the resctrl_arch_ calls shouldn't depend on lock that is private to resctrl.
> 
> This allows for multiple callers, (e.g. resctrl_pmu that I haven't posted yet), and allows MPAM's
> overflow interrupt to eventually be something resctrl could support.
> It also allows the resctrl_arch_ calls to have lockdep asserts for their dependencies.
> 
> Yes the resctrl_mutex is what prevents this from being a problem today.
> (I haven't yet looked at how Peter's series solves the same problem.)
> 
> ... it may be possible to move this patch back of the 'fold' to live with the PMU code ...

In its current form this patch does appear to be out of place in 
this series.


>>> I'll change the commit messages to describe that, and float this earlier in the series.
>>> The backport will be a problem. This applies cleanly to v6.1.46, but for v5.15.127 there
>>> are at least 13 dependencies ... its probably not worth trying to fix as chances are
>>> no-one is seeing this happen in reality.
> 
> I'll remove that wording around this and mention the mutex.
> 
> [...]
> 
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>>> index f0670795b446..62350bbd23e0 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>>> @@ -266,23 +279,35 @@ int :/(struct rdt_resource *r, struct rdt_domain *d,
>>>>>   {
>>>>>       struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>>>>       struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>>>>> +    u64 start_msr_val, old_msr_val, msr_val, chunks;
>>>>>       struct arch_mbm_state *am;
>>>>> -    u64 msr_val, chunks;
>>>>> -    int ret;
>>>>> +    int ret = 0;
>>>>>         if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>>>>>           return -EINVAL;
>>>>>   +interrupted:
>>>>> +    am = get_arch_mbm_state(hw_dom, rmid, eventid);
>>>>> +    if (am)
>>>>> +        start_msr_val = atomic64_read(&am->prev_msr);
>>>>> +
>>>>>       ret = __rmid_read(rmid, eventid, &msr_val);
>>>>>       if (ret)
>>>>>           return ret;
>>>>>         am = get_arch_mbm_state(hw_dom, rmid, eventid);
>>>>>       if (am) {
>>>>> -        am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
>>>>> -                         hw_res->mbm_width);
>>>>> -        chunks = get_corrected_mbm_count(rmid, am->chunks);
>>>>> -        am->prev_msr = msr_val;
>>>>> +        old_msr_val = atomic64_cmpxchg(&am->prev_msr, start_msr_val,
>>>>> +                           msr_val);
>>>>> +        if (old_msr_val != start_msr_val)
>>>>> +            goto interrupted;
>>>>> +
>>>
>>>> hmmm ... what if interruption occurs here?
>>>
>>> This is after the MSR write/read, so this function can't get a torn value from the
>>> hardware. (e.g. reads the wrong RMID). The operations on struct arch_mbm_state are atomic,
>>> so are still safe if the function becomes re-entrant.
>>>
>>> If the re-entrant call accessed the same RMID and the same counter, its atomic64_add()
>>> would be based on the prev_msr value this call read - because the above cmpxchg succeeded.
>>>
>>> (put another way:)
>>> The interrupting call returns a lower value, consistent with the first call not having
>>> finished yet. The interrupted call returns the correct value, which is larger than it
>>> read, because it completed after the interrupting call.
> 
>> I see, thank you. If this does end up being needed for a future
>> concurrency issue, could you please add a comment describing
>> this behavior where a later call can return a lower value and
>> why that is ok? It looks to me, as accomplished with the use of
>> atomic64_add(), as though this scenario would
>> end with the correct arch_mbm_state even though the members
>> are not updated atomically as a unit.
> 
> Sure my stab at that is:
> /*
>  * At this point the hardware values have been read without
>  * being interrupted. Interrupts that occur later will read
>  * the updated am->prev_msr and safely increment am->chunks
>  * with the new data using atomic64_add().
>  */

The comment is useful and appears to address that accurate
arch_mbm_state is maintained. My question was related to the
higher level behavior encountered by the callers. repeating my
question: "could you please add a comment describing this behavior where
a later call can return a lower value and why that is ok?"

Reinette



