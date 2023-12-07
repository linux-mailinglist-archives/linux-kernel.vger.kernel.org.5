Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2DC8090FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443791AbjLGTCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjLGTCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:02:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80E41703;
        Thu,  7 Dec 2023 11:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701975757; x=1733511757;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mOgeljHLbRToKdZrSsIqBNplNnL6LxZ+NBKZUUpJZcg=;
  b=Y36zZBwxMp3OFHA5gLmJBrA4TEJFERS+LprVl7ebcFlCL5WUnOL25a8L
   hkRB6JoSCDKau0K5gimFJlqACZ8Y29RzzqxMZNSaolbBcwOGAL2LQXnq5
   Ukoa1YUSmvwV45PYHq2vXXWDRyHP4jqfKlKdJbs0gDPMfnHZqsZL3hqCg
   nNARVa+LLfYIvp26KzOIc5DLLLFJe6hp4g+USO9oAMaUgifOtoqJ2nlRy
   e3+Pv3NgeOyk4/oryN0RqtVODAedk/ndlgmc0Li1B1b0BKkOf9IGiPriY
   /p8HU5TGRcwGHm4oUQfzzLPUUTo8Lwq7Mdi1uH9nNVt5aKoWmlHqJguaP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="374455009"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="374455009"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:02:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="748063648"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="748063648"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 11:02:33 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 11:02:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 11:02:33 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 11:02:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTkcFsRXLDWOgHRZ7++aNfXXMorFR6mnIQFumgt2Fp5Zc0/zjJ10D26VjtQUwk+1pFBNSrWp8ov5Mtj6fHrTov8ZLomRX/XuznV7/I2dwox/ViE3erMcmBCdTE8K/o95WXSZOhCq7xeR4171zrq28IwrHB8wH2O0SWCfhCXFzJf5ehdGpUSdDVySHOjcudJvAerb43XnlAuMO4/uVh7Wojz9QRcf4LEKWrRfbCvVH9t7CoExEZz7hXj78lr0zM65jaF4suIaWbEtIUJ+reVd47rFxN1Ng3tcw7Oms7yuCkahxqCbJxC3jaNloyL6XNYiwCyoQhkbrF75GOKEd/MmVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSsWbroIKm5CfJbgM+I6ib4NwCIHwf/nB89O71pG/eQ=;
 b=eWxJ66ERElTRl3BrG0Y8rEb+5+GMsFalefG0/mZX6+4GLKML1lZPaykGVreIs6UBWNzlWiay+PaEZawqUTaHiVDpW2r4eExANuWXTH/6I5s8P5R2VlWPKrqreqw0NSc53yme7kweatITa8v7d/Mk4B7/ZoUYt4IsRGmBcR6H6di6K8oCW9BzjW0W4YqUPwp4w5/ISdf8lH1AsRKWlN0wQLqnPgjeYaFT4tecFPY7+u6mv3gU4xiR5pBftQBgw3n1PkMwBrU0exJRixANnUsW8vdgey8PgpC+O9UR2dF8hM618AClkFCEUZFkIHIy6VnXOS2tvrPH3JFsZlHfsRYWig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB5487.namprd11.prod.outlook.com (2603:10b6:5:39f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 19:02:30 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 19:02:30 +0000
Message-ID: <26385423-6288-4f6c-b238-30c599250cdd@intel.com>
Date:   Thu, 7 Dec 2023 11:02:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] x86/resctrl: Remove hard-coded memory bandwidth
 event configuration
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
        <seanjc@google.com>, <kim.phillips@amd.com>, <jmattson@google.com>,
        <ilpo.jarvinen@linux.intel.com>, <jithu.joseph@intel.com>,
        <kan.liang@linux.intel.com>, <nikunj@amd.com>,
        <daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
        <rick.p.edgecombe@intel.com>, <rppt@kernel.org>,
        <maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>, <dhagiani@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <20231201005720.235639-3-babu.moger@amd.com>
 <47f870e0-ad1a-4a4d-9d9e-4c05bf431858@intel.com>
 <22add4c6-332c-45e4-ae0c-f287d6bff341@amd.com>
 <19e3fd3d-a2ec-4c8e-aa47-44f8f41b569b@intel.com>
 <ca471e43-b7ef-40f6-b0b3-3c79aa3a0d61@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ca471e43-b7ef-40f6-b0b3-3c79aa3a0d61@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0310.namprd04.prod.outlook.com
 (2603:10b6:303:82::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB5487:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c9c307-869b-4264-da0a-08dbf7570fc3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khR9K9qle19hEym2LvjIaDFFpiZRMQPvyvzLSuGgsXaREPJNMi78fb8ZPJMeeYC7JTmcUzQSPYinKaGnnkmGBo77wsPw2Gb/a0HzYIYm9RmogR3LYjIqX+KnwBqowQ+il69xgyNdWc82OqYvqJt4blutNT/Z04A2gvIHe3Sid83+e1OMj3n+pG9LFuGHbu1GTxLLOh74NkbiI7zArAxacET9T8va7gzZiIb5rNeSFaZafpk0K/DHpXY4e/xWL0YYXz4TnwVGdR4YRoi6O4c+Jd1038CJCVEcKHSyb1b9B26sUHjyLCmOWS+LNihtTSVjm0KJnH6L/Ik75Kuc0brlkoa0qGfrPYxoAcVnO+426/0mIlCVS2kcGYwqBukd81vUHrWm2SE1dhenemfJgYr7J8VQtvzvXbIxQ7BnC9BVSLOuRozwY85koT8edfHF3TnrT8UdmTCts2/inzsNs192M2vLvyvwNj3b//YNti28zrSOSdcglk+GLU0oBO1/kentw8q61lOrbBIXlQ/ujAJyG1F+hAPluHCNZRiHi+DIMCzagqezdr6FGVTJm9u1oKmhZ/bwxXRYuGTFpAvbjKLOmrO886d2jFTyMpeNguE1n7HVA2TqdX+4pN8g5sHqT8YoPo3RjNUyE0G5gmkl5preTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6666004)(53546011)(6506007)(83380400001)(8936002)(8676002)(44832011)(26005)(6486002)(31686004)(2616005)(6512007)(478600001)(38100700002)(316002)(66946007)(66476007)(66556008)(31696002)(41300700001)(86362001)(36756003)(5660300002)(82960400001)(4326008)(2906002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1Npay91ODF3bmRPRnE5VVhUcFJCUmpxWXR5blc4Y3VkUDJHNnpKQUh5cUE4?=
 =?utf-8?B?aExiTFVXN3dOYjI2c29qSzdwS09XdmNBemtlQ1l0SkJyUi9WK09MdnNkdTVz?=
 =?utf-8?B?bnBnZmR0RFNUZTJTS2lzL0U2Z0RSQ1pUSTBxOTd1MDVKWEZSV2VMT09nRlN6?=
 =?utf-8?B?VzRTMFZhYWxyaUxYU1I1bEsyb0pNcWszaW5uR3ducTBmdkhUeUNGL2kyNHZ3?=
 =?utf-8?B?dFpjQ0NmRFl4cURTZlBpNmkwM2RaRWx0WU9WRG52enV1S2k4ZHZ4MTJCdElD?=
 =?utf-8?B?YjdNN3kxQ1QyRFlGV09saXFoY3E1UXJTNkowTWE0Y0FPUFBVRDdYVnlqN0tY?=
 =?utf-8?B?SXRNQWExNXh0VUVtTDZOQnFQd2hVM1lyRHcwRUV4Yk5pNWdtakc4d1dhWUZx?=
 =?utf-8?B?eUcyQVFiRDNtUy82eFo2aXliNmlDa3NTSzI4Wi8zdFVXd1RjMkpHa3hLLzlF?=
 =?utf-8?B?UkdCcENJSTdkRVJjOFJVL2dpaEdZZUZIUE5SdEFoa1dhU29XZEc4Ull0TmtF?=
 =?utf-8?B?SFI3dFpxdnRJRG1nMHhpTW9sd25tK3J2TWYrTURzamtZdnFodWgxQVc0YWNa?=
 =?utf-8?B?UkxwdzRsdlBNU3pIRVJCeTBMcTJlWTlsby9oNzNzR3JVbnJDeEVocE1TQ2ow?=
 =?utf-8?B?RWlXeUNIeEw1OThYTVVNbHZhY1RUTkFNb2xjSE1oMk1XQ1NiRjNpTktDKzNn?=
 =?utf-8?B?OEV2Y3hCR1FCdEl2ZmlFUUIzenp0V1EreU01UDdvWEtwQlc0aEEwQzZidFZS?=
 =?utf-8?B?enZsYVF1bWZ3WlEyUUhSSTRwcFFBTE9wcDlBT0JFN1l4aGQ4QnR1bDhGTUJB?=
 =?utf-8?B?RjlXd0thYUJFWm9nWmEwS2pUYVNSNEFIc0pMREV2QkVtaEY5K3V3Ui9hQWYy?=
 =?utf-8?B?enpOOVZMMkgxaFlKdU9JQlUwdXhzaDkrRVdDNU5Xa3FweFNoaWEzY2tEN0tI?=
 =?utf-8?B?elVLZ3RUYzdWYmpoRVNhVWNtbFY2cHp6N0lsWDViNmpuN3ZIYmVLNkZ4aWo2?=
 =?utf-8?B?WWhGMFJBc2RTWXpOWHQrRXFTdlJjWlZQZlJ0YmZKTHRqZC8zTjQ3QlBJZWJN?=
 =?utf-8?B?NEk1WGRhMGUvTVR6RlFQSDdJZWM5OEtwTGJSTUM2ZVNjcG9LbVJVTFc5VjNz?=
 =?utf-8?B?SmFDT3h4ZDROemVucGpNYUYrZmhRYU1TRDZnZnBuRDF0WlFGMXVuVkRHemJV?=
 =?utf-8?B?aWM4YlFJYUZBdnFDRzBCZi9vVnE0TE5LVlFidVI3QTFnVkI4T29CbUovMEYv?=
 =?utf-8?B?Wm5wdG5iWmsyVTdvZ0U4TEV1eWRzc2VyZlRUS05tTDE0TGJIeGdlYXBVSjJN?=
 =?utf-8?B?T2l6bWRFajNIV0x5SVlYb0UzamFuOFBScTExWDdMQVU4VFkzbGJvazdTVUNu?=
 =?utf-8?B?YzlzYnBUdFgvcUZtcVFyWWdwVEh4SFMzbWdPOWJEaGYzb01LckxGVVZtaXRq?=
 =?utf-8?B?ZjFYWHZQeEVqQ0VaTDZ3a09jdCtYNUdmQmJYZjVoNmY1cFVJNWZHWGtwQ0F5?=
 =?utf-8?B?Zk9RaitFSWl1dExkd3RqSzcwdzh5cHNZOS9kQytHNDdMZTU5TUF6YTRvWCtr?=
 =?utf-8?B?VkdYeUMzNWFoVFp5QkdONmRUVTVlZ2g4MzlrV1gzcnUyZGpIM3ZyV25DK0w4?=
 =?utf-8?B?dXUyNlNhdzAzWWtOWSttdFBCUnNOTmdpMnlVbE9FTXFkYk1CWGptS2NDMmJ6?=
 =?utf-8?B?SXRPb1ZBWjZtN29IWjlzZTJ6YUhaL3Urak1EUTRtZkE2cksvRXFkU3QzNzlL?=
 =?utf-8?B?UTNVUUIvcVNQWUpzTFFBd3prK3NYSDl3dlJNczFtOFJGSENXcUZTYktoamls?=
 =?utf-8?B?NnRNZWNWU3loQ1BNUkRHZ0VGbmtZYzRod3lheHZxdjdPVGhCc2JqQU1zam90?=
 =?utf-8?B?UnNLVGoxVStYbTFPTzhkSmF0Q2FXYUl3MEZCMUpYSitPazlKTkVNMDN5RHJB?=
 =?utf-8?B?ZEZvT3FVSzVsazVoYjdnQmwrckJXVWd2cmh3QmkwbHN2d1JhRzBHQ1FzeWxB?=
 =?utf-8?B?OXIvVXVIR3NUdDVaanNRTG52VWdwZmtzdVRWa0tVU0ovYm5lNlpmMWkwWHhn?=
 =?utf-8?B?WWxHbmVsbURSZ1RPSlgrRnFFNkJVcFVHRHdWRWVNTE5CL2JaNENJMXNOaUZx?=
 =?utf-8?B?eUdKN0R1Z3RNVkFjS3l2YkFaSkZrTDlxUVEwYWgrbEFxMWd4Y0VPbDVUOXF3?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c9c307-869b-4264-da0a-08dbf7570fc3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 19:02:30.3788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oO1YL3qcyDd5or9IzHLNA9bGAzJAvFlicsxhovrx1lNFs5TiRrkIsYV7bXP61R8MwKIq5Nn0kiRrkxWQh6ke6OkbjIsdY646GuMW7dScrmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5487
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/6/2023 11:17 AM, Moger, Babu wrote:
> On 12/6/23 12:32, Reinette Chatre wrote:
>> On 12/6/2023 9:17 AM, Moger, Babu wrote:
>>> On 12/5/23 17:21, Reinette Chatre wrote:
>>>> On 11/30/2023 4:57 PM, Babu Moger wrote:

...

>>>>>  static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
>>>>> @@ -1621,7 +1621,7 @@ static int mbm_config_write_domain(struct rdt_resource *r,
>>>>>  	int ret = 0;
>>>>>  
>>>>>  	/* mon_config cannot be more than the supported set of events */
>>>>> -	if (val > MAX_EVT_CONFIG_BITS) {
>>>>> +	if (val > resctrl_max_evt_bitmask) {
>>>>>  		rdt_last_cmd_puts("Invalid event configuration\n");
>>>>>  		return -EINVAL;
>>>>>  	}
>>>>
>>>> This does not look right. resctrl_max_evt_bitmask contains the supported
>>>> types. A user may set a value that is less than resctrl_max_evt_bitmask but
>>>> yet have an unsupported bit set, no?
>>>
>>> I think I have to make this clear in the patch. There is no difference in
>>> the definition. Hardware supports all the events reported by the cpuid.
>>
>> I'll try to elaborate using an example. Let's say AMD decides to make
>> hardware with hypothetical support mask of:
>> 	resctrl_max_evt_bitmask = 0x4F (no support for Slow Mem).
>>
>> What if user attempts to set config that enables monitoring of Slow Mem:
>> 	val = 0x30
>>
>> In the above example, val is not larger than resctrl_max_evt_bitmask 
>> but it is an invalid config, no?
> 
> Yes. It is invalid config in this case.
> 
> How about changing the check to something like this?
> 
> if ((val & resctrl_max_evt_bitmask) != val) {
>                 rdt_last_cmd_puts("Invalid event configuration\n");
>   		return -EINVAL;
>    }

This would address the scenario. I also think that it will be helpful to
print the valid bitmask as part of the error message. The original implementation
specified that all bits are valid and in doing so no interface accompanied the
feature to share with users what the valid bits are. The only way user space can learn
this is is to read the *_config files after the first resctrl mount after a system boot
to see with which config values the system was initialized with (assuming system was
initialized with all supported bits enabled).

Reinette
