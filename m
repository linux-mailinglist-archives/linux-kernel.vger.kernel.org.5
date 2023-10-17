Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AA67CCD9C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjJQUMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjJQUL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:11:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA38F6FB0;
        Tue, 17 Oct 2023 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697573513; x=1729109513;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=awu1rTOkqiHr5uBQx2juqNlcoqVqBwVEHcGfdO+qc10=;
  b=Snk840E921DsDiXRuK+9/5ys7Gi+/bpNl99plecreMpO6TMyCcrPL/bJ
   V9gI+s5TTfCKofFCeOb+ufw94aXgNO/blWND+FbysF/G859RzeHaadxlV
   FndgyDo1u2ukZPmaGOWo9c3ygI3qHDTsATWqlgnUO37hzFcVce4feSpLr
   bx/HTJ3No06ECzF3x7M962z0KHnmvy770nFgzrMKO963kNv6Q20/WGPMk
   ixpICmIWFhENP9jSVDtkDC1rB0GWPJliQMkWAL1OEhyJfn4OPP6LJmqCE
   s5zC3aDiFhshjR/AIrW01+eG70WxSZ6L2Cuht6itjCKvzQCpiDiwhplRS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="370937018"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="370937018"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1003474112"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="1003474112"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 13:11:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 13:11:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 13:11:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 13:11:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKZhrT/z9VOw0rxRywpZK4hVmtoXAD9N7jHjOG5Kz/uqTSPY6dIltStjjqhoBxCDUQ0fXMLAcET8UrwqOvn9sIiqbnOBxvSdrU7e/1fzgAJMvKLgSembxI2s3QATuaKOzSocUk3FkdSIlyvDpnfcjRbTRXI46Mz78aA1GqIwa7DLPhKYpycBdXMoYgb/Lp/ii4R7X/83hDrduNaa2TSPS+fXGYc2Ilh1KvKp6VpWgwzUSDBcB0vVrlRa3Yv02JnwMlc74bH/AzmAMOYjQofMUJf4zZUskh8cvpIkhvsOrBC9F+jifVGfF3qhl9pqBmdkYKyj137HGKpqS7mq7e/EeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGO6D7evuc7CN4M5GskzkBa9fIKhMWqmxeVdIKBKkh4=;
 b=n/lC5aJLCnlVF6rDUZcwM70g9IMmrGkSCxt7JNgUGU26i+JwQNLQW63PS2ir8ASJ9IfVRo0FS8Usv84tAbrssHFTIrRluSSihPXGHlnrgRORjchlShYSnnX4Gcwb8Q1DgfjfwVF5paDiZyTNYSL/g6l5mz7srOfdybR8dcMAFKo2e56c8ymTA5gQQQM3SLrPB5Wzbcq3X8N8pWEGoKk/qRVLHFNWmjnOCJcS6qW4Ff/YO1Ekjt5SCsrQauSCrW84uopnfwxMKIVL2ZAbhQoS90G5Qp8cyEysEYvsjZM9OOz3HUAP4j0XhWcbgFg1fq+F1eBVksm7vQXGsmCGgZ1Xmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW5PR11MB5785.namprd11.prod.outlook.com (2603:10b6:303:197::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 20:11:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 20:11:42 +0000
Message-ID: <46b71cef-7170-49a8-bae9-6aa635951e5d@intel.com>
Date:   Tue, 17 Oct 2023 13:11:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20231013202602.2492645-1-babu.moger@amd.com>
 <20231013202602.2492645-5-babu.moger@amd.com>
 <d4a33013-0448-4c36-a168-b3a953024962@intel.com>
 <0acbb031-a84e-1cbc-0857-f087b07a9056@amd.com>
 <299778a6-5ea0-c70d-54d6-1ecdc1b417d6@amd.com>
 <2c86957f-9705-4f24-aa43-60d89f636c31@intel.com>
 <cc273d98-d73c-49bd-8799-b119966e226c@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cc273d98-d73c-49bd-8799-b119966e226c@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW5PR11MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: ebee7e5a-a683-4247-4b30-08dbcf4d479f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gZuvkD7O+DQUhT41I5hz6RFLTjRr2dfJy8Gvcb0IkZtryQgl8edFqkWHdo4Xqs6tSzLhPPlxiyfyhC0JtHngMHyV+rRFtdQC3feaJb0rPASrubTa6/c0rJMovqGuhCFhQCTugAVU/dXsg39qVKz4p6D7yZt5iPbD9ohdRpuzX6IXin27z05NmNQJvJ8wq8iRNoHsFqDSlQZ6Ia9/+XUTGg6HUPqclg0jYfgj3abhcQgsf2bH+tMQ6Qo9Qtyz8hmocaF6CIWY4Zfayqztv8ZPmM8GEAh+Pxz/IYdPfpQ7reBQlRV2zz4kFjiAxv2oPvB999k8lEVou4jSwWZswIJaW8Xj/WBHUCUl1wf+qlcAnfbJNcqmU15o+uj7/hhaa2GOWK3YSBOQinAA6wYVNPI9it+eBCHiGjG0LYR1iJ9DU3/7LIpSc8DcIzyhx5oO6okPKt/RK9DcXtY50xZqU66zw5JmLGiQTKiFIpVCbqNls1Swk/Dj3y7i4x4yG89ibpJh+bPfz8gha0edtfYhMLAHrebzGK2nduYGYdMbgQ8Kl/UzkRoAUMxxUd+2l0+j9JQ9Mz6DjBUUVXDPQgKDLvXpAcNojWDF2baG9WesHENDY8g0npahPAh84rP9K79c3udndm3N7B2JIEkm8MBlkhHmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66476007)(6666004)(66899024)(6486002)(82960400001)(38100700002)(478600001)(966005)(66946007)(2906002)(6512007)(6506007)(7416002)(316002)(66556008)(8936002)(4326008)(41300700001)(5660300002)(44832011)(8676002)(7406005)(30864003)(2616005)(53546011)(83380400001)(26005)(31686004)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alVBdUsweEpHbk02ZDE3aXhJL05Mbkhrc0hoY2JjbEE0VmJudmxvL2NKTjBP?=
 =?utf-8?B?V3JhcndkWUtVdm96NGlIcjVScXpQSWFxeFN0UEhxMER0dVppNVpDWEl4Q0FS?=
 =?utf-8?B?VVlFRUNvT3NLU2VNdFk5djBVNGF0aVRxbFlSR01LWTZNcVNLU2k3ZUJDN3Z0?=
 =?utf-8?B?UmZ5ZWtveHZVYUtHcGRKZHFtMlBEQTFOT09xTXBrTGJhRmMwVUQ2VjlnbERo?=
 =?utf-8?B?SXNqOUg5RVdNN2pXRzA0a2UvUnhFcGRZRHlVSENJY1BnTHhmbDJya3BRNFd0?=
 =?utf-8?B?TThmVE5QT2RRcTdwUDhHSVk4UjMyOVAxK2R6YVpsVG5kQnRid1M0QjZRT3Ur?=
 =?utf-8?B?SThtQ1Fya1ZtWi8vZjFHV2JzRjBDckl0OVJxWTVrT2JtdnNFWXVGNGk1MmFO?=
 =?utf-8?B?WmtWYW9odXBQNXhFdXIyazNneEhiQk1CSE0vYmJDcHd6bFpJblpFSXRiWFRl?=
 =?utf-8?B?NTRmNk1oWm5tNFFmQlBCT1hXdEwrU3UzMVJkSGdyL0FnTHExb1Q2aGdOODlJ?=
 =?utf-8?B?WXAwNVF5VTE3bTZnaG93RU8xbVRLeGQ2Um1UODByNmRMR0I5UDM1K2hqS3VB?=
 =?utf-8?B?czhiVE81K0NObDAxRHFHRlY1aGpQZ2t3RlBUcDkrWDZUVnVLemxVRnh5Q3k4?=
 =?utf-8?B?NGFILzNqUkVyR1Fuam9PNmJyQVBHNTFKZFpzOFBvaDZHQlZrSHhtVnVudFV5?=
 =?utf-8?B?akoreSsyckhUQ2dvWGRjYW9jYnF2NVVZTTRISnNvOWJVbEVsOWZmU21lWnVB?=
 =?utf-8?B?anBmZVdJTmdLWHJsdkRGZjZJOGJTYXhYZjlzZEw4bGNKVDNUMjRCSXYyZXVR?=
 =?utf-8?B?VnU1NEtjbkd1b2NkaW1rbWlUOG8wS2xUWTYvb1lpZys0cU03UkhFcnRKU3BQ?=
 =?utf-8?B?bi8rUXo5SXpGSGJNeFZnbWVieUVsT2lucWM2TzVvN0ZxYmhKc1NOQXRWWTJk?=
 =?utf-8?B?RkRzSXBOb29EY1I0dlVWMURBY2liRjZSVldUbWRCaWhFb3VWSVM1MmpuSzQ0?=
 =?utf-8?B?aGRyRjBta2d1ZDdkSzM1SEpVOCs4ODhBYmFZdFhVa2NDK3o3TmZoT1FDdXM2?=
 =?utf-8?B?d0VKZFNiMmpOQlg0UzVQdStFa3Iya2tkN0ViNW05VXluczA0VXVWT3dJVGVn?=
 =?utf-8?B?L2ZaVXRZUEV0bkcxMHFyV3lUVzlvcG5YUUNQM0U3OGxSbEU4QXl4VzhZam9T?=
 =?utf-8?B?RGFEMk1YZW9XZEw1dkVHc0EzMTRXdU1GVXdPWlBSQmh2alpVV0dPdUhSZTdT?=
 =?utf-8?B?dFM1S0wxRVJCOUxvWFhpaGx1VTZMVmVpcGd0bzNxb0lBTTU5cjNNMElNVzl3?=
 =?utf-8?B?UjJZNlRnc1ZBWFRRM2ZKOEhUQmVlRis4ekpsTzJYODNOa0JWdCsvL3hFZUxk?=
 =?utf-8?B?NzR6Z1JPR1Q1WG8wYndqMXZKR0M4THhFTDlPd3ZNSkNxbTkzeEsvVkxzYml6?=
 =?utf-8?B?WHFVcnRENGZ3VGhpRGZsNTZnVjJ5L3k4czlwWTNKWEU5dVJLSVZndkFhbXR2?=
 =?utf-8?B?Y0M3SGZTMmhpM3FPWTFWYXRBdjZFL1RVWmliVVNNQ0xZR2dDTnJucmEzeG5l?=
 =?utf-8?B?QWlBc3RZSCt2ZFE5N3lZdnJXQ1ZhVVJKb1VJZWlmZUpTVlpORjRBSHk0MUdM?=
 =?utf-8?B?dWU2emZ0eDYyL0ZWU3Y5d2NZRzNsWlp6YTNQNmVZM1ZyS1FJK0RvTmhWRE5L?=
 =?utf-8?B?TU9iZDRuZEZmRUdLZWVUMkJmQjlBemU5b2VwNXEvVlh1MVRpWXNzVSt1T1li?=
 =?utf-8?B?ZWIzRmhSU3BueUVxUmNiVytVVmNtWHMzYUhuem1ma3NUM0pyb1BQNlY5Q0d0?=
 =?utf-8?B?UHI3ZDg0bVZ4Q21YL1VFMGt1aDQxeWlpS1hicnVrbGsrMk02YWplK1d1NDJl?=
 =?utf-8?B?VTgrVHk5UTEveWUrTUVwZWFoVWdYQllZZEFrN3RhUUNyQlRQd0kvTHlOOUJQ?=
 =?utf-8?B?R2kvQ3lOV0RIZXdrdzkvUUJhbi9iYUs1TFRLQTUxNUxwekNiN0hUZkdyZEs3?=
 =?utf-8?B?QmVXdHo4bTljdk5MUTNyS2tGL056aDhxcnhJcE01REQ5M210RHV6YlUxRnNX?=
 =?utf-8?B?TkltcE83cWlMc0g0OFJEV1FsTkI5M3BBYmZiczAya2ZjdG9oR3F6NGJOMUdl?=
 =?utf-8?B?dFFRdE9Zc3N2cmQ2cjhleFBvMi92dlJEUVpnNzUxdDM3ZDNJakhBZU9OZEVh?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebee7e5a-a683-4247-4b30-08dbcf4d479f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 20:11:42.6013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQMU/pTGY9ts7U5TwGc89vh9w6Yu9rSOa+herXt2I9dW8xNCsiXTNtcPvcLolqY3z5Cv2r4uf++q75AjYnZxHup0jfbJD8DeRA+gkkgbyzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5785
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/17/2023 10:47 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> Boris pulled rest of the patches. Thank you very much for the feedback and
> patience.
> 
> I can send this as a separate patch with all the FTYPE documentation
> update. This need go later.

ok

> 
> 
> On 10/16/23 15:46, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 10/14/2023 4:06 PM, Moger, Babu wrote:
>>> On 10/13/2023 4:39 PM, Moger, Babu wrote:
>>>> On 10/13/2023 4:23 PM, Reinette Chatre wrote:
>>>>> On 10/13/2023 1:25 PM, Babu Moger wrote:
>>>>>> resctrl uses RFTYPE flags for creating resctrl directory structure.
>>>>>>
>>>>>> Definitions and directory structures are not documented. Add
>>>>>> comments to improve the readability and help future additions.
>>>>>>
>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>> ---
>>>>>> v13: Fixed the format issues in the documentation. Needed few minor format
>>>>>>       changes to address the syntax issues.(Reinette)
>>>>>>       Removed "Reviewed-by and Tested-by" flags as the patch has changed.
>>>>>>
>>>>>> v12: Moved the comments from arch/x86/kernel/cpu/resctrl/internal.h
>>>>>>       to Documentation/arch/x86/resctrl.rst. (Boris)
>>>>>> ---
>>>>>>   Documentation/arch/x86/resctrl.rst | 64 ++++++++++++++++++++++++++++++
>>>>>>   1 file changed, 64 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>>>> index 178ab1d8f747..1163da74f734 100644
>>>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>>>> @@ -369,6 +369,70 @@ When monitoring is enabled all MON groups will also contain:
>>>>>>       the sum for all tasks in the CTRL_MON group and all tasks in
>>>>>>       MON groups. Please see example section for more details on usage.
>>>>>>   +RESCTRL filesystem implementation notes
>>>>>> +=======================================
>>>>>> +RESCTRL filesystem has two main components
>>>>>> +    a. info
>>>>>> +    b. base
>>>>>> +
>>>>>> +    /sys/fs/resctrl/
>>>>>> +    |
>>>>>> +    -> info
>>>>>> +    |
>>>>>> +    |  (Top level directory named "info". Contains files that
>>>>>> +    |   provide details on control and monitoring resources")
>>>>>> +    |
>>>>>> +    -> base
>>>>>> +
>>>>> Could you please do a "make htmldocs" and then ensure that the output looks sane?
>>>>> The resulting output does not look right to me. For example, the above turns into
>>>>> a single line that looks like:
>>>>>
>>>>> /sys/fs/resctrl/ | -> info | | (Top level directory named "info". Contains files that | provide details on control and monitoring resources") | -> base
>>>>>
>>>>>
>>>>> The spacing also looks off when viewing this in html.
>>>>
>>> I have fixed the all the format issues. Please let me know if it
>>> looks ok. I will send the final version after that.
>>>
>>> Attached the patch and also added the diff inline.
>>
>> This still does not look as though you consider how the document 
>> looks after the changes.
>>
>> Consider the organization. Before your changes (assume numbering starts
>> at 1):
>>
>> 1. User Interface for Resource Control feature
>> 1.1 Info directory
>> 1.2 Resource alloc and monitor groups
>> 1.2.1 Resource allocation rules
>> 1.2.2 Resource monitoring rules
>> 1.3 Notes on cache occupancy monitoring and control
>> ...
>>
>> After your changes:
>>
>> 1. User Interface for Resource Control feature
>> 1.1 Info directory
>> 1.2 Resource alloc and monitor groups
>> 1.2.1 Resource allocation rules
>> 1.2.2 Resource monitoring rules
>> 1.2.3 RESCTRL filesystem implementation notes
>> 1.3 Notes on cache occupancy monitoring and control
>> ...
>>
>> Note how the "RESCTRL filesystem implementation notes" is inserted
>> as a subsection of resource and monitoring groups. Since the text
>> describes all files in resctrl (not just resource groups) I expect
>> that it would not be buried as a subsection of resource groups.
> 
> we can make a separate sub chapter for this. Something like this.
> 
> 1. User Interface for Resource Control feature
> 1.1 Info directory
> 1.2 Resource alloc and monitor groups
> 1.2.1 Resource allocation rules
> 1.2.2 Resource monitoring rules
> 1.3 RESCTRL filesystem implementation notes
> 1.3.1 info directory structure
> 1.3.2 base directory structure
> 1.3 Notes on cache occupancy monitoring and control

ok. Since this is the first addition of any implementation notes
it does set a precedent. In this case it implies that implementation
notes would accompany the feature being described as opposed to all
implementation notes being placed together. I am not aware of
customs in this regard but having consistent text, like
"implementation notes" that a developer can search for is useful.

>>
>> This addition also ignores existing customs. Nowhere in the
>> entire document will you find "RESCTRL" (well, except for the
>> config option).
> 
> Sure. We can change this to "resctrl"

Thank you.

> 
>>  
>>> Thanks
>>>
>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>> index 178ab1d8f747..e990272e9a4f 100644
>>> --- a/Documentation/arch/x86/resctrl.rst
>>> +++ b/Documentation/arch/x86/resctrl.rst
>>> @@ -396,6 +396,67 @@ Resource monitoring rules
>>>  3) Otherwise RDT events for the task will be reported in the root level
>>>     "mon_data" group.
>>>
>>> +RESCTRL filesystem implementation notes
>>> +---------------------------------------
>>> +RESCTRL filesystem has two main components.
>>
>> This documentation was extracted as-is from the header file where it
>> was next to the flags being documented. With this move all that context
>> is lost so it may be helpful to summarize what is documented here.
> 
> I can move the notes here with some modifications.
> 
>>
>>> +
>>> +a. info
>>> +b. base
>>> +
>>> +::
>>
>> If I understand correctly, instead of adjusting to the target format you
>> hardcode all the text as pre-formatted? That may be ok. I cannot speak to
>> whether this matches expectations of the proposal to move the documentation
>> here.
> 
> I am not sure either.
> 

It seems that since this you decided to stop using pre-formatted text for
some of the text but not all?

>>
>>> +
>>> +       /sys/fs/resctrl/
>>> +               |
>>> +               |--> info (Top level directory named "info". Contains files that
>>> +               |          provide details on control and monitoring resources")
>>> +               |
>>> +               |--> base (Root directory associated with default resource group as
>>> +                          well as directories created by user for MON and CTRL groups.
>>> +                          Contains files to interact with MON and CTRL groups)
>>> +
>>> +               Note: resctrl uses flags for files, not for directories. Directories
>>> +                     are created based on the resource type. Added the directories
>>> +                     below for better understanding. The RFTYPE flags are defined
>>> +                     in arch/x86/kernel/cpu/resctrl/internal.h.
>>> +
>>> +"info directory structure"::
>>> +
>>
>> This unexpected. In your previous response you noted that you did not know
>> how to make it look like a header. I expected that you would read the manual
>> to answer your own question but instead you just placed the title in quotes? I do
>> not see how placing text in quotes create impression that it is a header.
>> There is syntax to indicate section headers.
> 
> Actually, i have kind of understood all the formatting details. Still
> learning though. Attached the patch.

In the version I responded to you could have underlined the text with "~"
to turn it into a subsection of appropriate level.
For reference: https://docutils.sourceforge.io/docs/user/rst/quickstart.html

It is inconvenient to work with an attached patch. Please send patches
inline.

> Subject: [PATCH] x86/resctrl: Add comments on RFTYPE flags hierarchy
> 
> resctrl uses RFTYPE flags for creating resctrl directory structure.
> 
> Definitions and directory structures are not documented. Add
> comments to improve the readability and help future additions.
> 

Commit message needs to be reworked considering that it is now
documentation and not just comments added to a header file.

> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/arch/x86/resctrl.rst | 73 ++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index a6279df64a9d..c89a926934fe 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -407,6 +407,79 @@ Resource monitoring rules
>  3) Otherwise RDT events for the task will be reported in the root level
>     "mon_data" group.
>  
> +resctrl filesystem implementation notes
> +=======================================
> +
> +This section lists the files and directories under resctrl filesystem to
> +understand filesystem hierarchy. resctrl module uses RFTYPE flags defined
> +in arch/x86/kernel/cpu/resctrl/internal.h to create files. Directories are
> +created based on the resource type.

First sentence can be dropped. It is not clear how it relates to what this
section describes. Also, there is no resctrl module,
so "resctrl module" -> "resctrl". Code moves around, especially nowadays in
resctrl. Noting the flags are enough for a developer to find them, no
need to name the header file.

So just: 
	resctrl uses RFTYPE flags to create files. Directories are created
	based on the resource type.


> +
> +resctrl filesystem has two main components.

"components." -> "components:" ?

> +
> +1) info
> +2) base
> +
> +::
> +

The "::" above means that the text below is pre-formatted. Thus, all that
was needed was to copy the text from what you had in v11 to the new document.
I do not understand how so many issues could have slipped in while doing so 
(see below).

> +	/sys/fs/resctrl/
> +	|
> +	|--> info (Top level directory named "info". Contains files that
> +	|         provide details on control and monitoring resources")

monitoring resources" -> monitoring resources. ?

Also note that the alignment is different between the two sections. Can
the text be aligned to the parenthesis as before to match what is done
below?

> +	|
> +	--> base (Root directory associated with default resource group as
> +	          well as directories created by user for MON and CTRL groups.
> +	          Contains files to interact with MON and CTRL groups)
> +


This is different from what you had before and it now appears as though base is
at a different level from info. 

Also, sentence needs to end with a period.


The text above is pre-formatted ...

> +info directory structure
> +------------------------
> +

... but the text below is no longer pre-formatted ? Why is this inconsistent?
I assumed from previous exchange that you switched to pre-formatted to not have
to deal with inconsistent spacing when using the same text in a reStructuredText
doc ... but now you are back to using the same text with the inconsistent spacing.

> +	--> RFTYPE_INFO
> +	    Directory: info
> +		--> RFTYPE_TOP (Files in top level of info directory)
> +		    File: last_cmd_status
> +
> +		--> RFTYPE_MON (Files for all monitoring resources)
> +		    Directory: L3_MON
> +		        Files: mon_features, num_rmids
> +
> +			--> RFTYPE_RES_CACHE (Files for cache monitoring resources)
> +			    Directory: L3_MON
> +			        Files: max_threshold_occupancy,
> +			               mbm_total_bytes_config,
> +			               mbm_local_bytes_config
> +
> +		--> RFTYPE_CTRL (Files for all control resources)
> +		    Directories: L2, L3, MB, SMBA, L2CODE, L2DATA, L3CODE, L3DATA
> +		           File: num_closids
> +
> +			--> RFTYPE_RES_CACHE (Files for cache control resources)
> +			    Directories: L2, L3, L2CODE, L2DATA, L3CODE, L3DATA
> +			          Files: bit_usage, cbm_mask, min_cbm_bits,
> +			                 shareable_bits
> +
> +			--> RFTYPE_RES_MB (Files for memory control resources)
> +			    Directories: MB, SMBA
> +			          Files: bandwidth_gran, delay_linear,
> +			                 min_bandwidth, thread_throttle_mode
> +
> +base directory structure
> +--------------------------
> +

I am not familiar enough with the syntax to know if the underlining needs to
be precise.

As above, the text below is no longer pre-formatted? This brings some
unexpected views when I try to look at it in the generated html ...

> +	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
> +	    Files: cpus, cpus_list, tasks
> +
> +		--> RFTYPE_MON (Files for MON group)
> +
> +			--> RFTYPE_DEBUG (Files to help resctrl debugging)
> +			    File: mon_hw_id
> +
> +		--> RFTYPE_CTRL (Files for CTRL group)
> +		    Files: mode, schemata, size
> +

For some reason the above snippet appears different when attempting a html
view. The "-->" uses a different character and the "Files" line is next to
the flag line, not below. Could you please run "make htmldocs" and confirm
that the generated file looks sane?

> +			-> RFTYPE_DEBUG (Files to help resctrl debugging)
> +			   File: ctrl_hw_id
> +
>  
>  Notes on cache occupancy monitoring and control
>  ===============================================
> -- 

Reinette
