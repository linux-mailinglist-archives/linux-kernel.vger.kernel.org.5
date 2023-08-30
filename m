Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672BC78E087
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjH3UW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjH3UW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:22:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC8A10C2;
        Wed, 30 Aug 2023 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693426913; x=1724962913;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hNx8zaEzKsokYHkG/YBQW6vPFaCs4LgGisETIUr1eBI=;
  b=iu6JLfAkY0QK82F2DF4V3uWULfYDNU1BgEWMZ+R4BqEMdPSoGvzpMvVN
   HYui2RsSYdlUF6G9rNzNgxc5CSqkKithWy2iUa7OyCyxRw/ic/ShvhC7K
   B3Ytri3sf8pAQkZ52hPxvTozvBPhrQSAiJAfdhI4GW73IJunfSc+I4zNj
   bHG0toNVZV3+TqxxS6xT1weMq54maxZNC3f7sZRv3INA4PHwRTQKN01pw
   n8lSVpUgMrvZobxHLXnjAo5Nv8th6FqgmscGUILElZh/sMR69S72sYJmh
   wAor2iI/irdxEmcq0ReWfMOZLUdda1dUlgFulzWSL09xt/jLTN58CKiWv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="378454962"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="378454962"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 13:00:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="742368395"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="742368395"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 30 Aug 2023 13:00:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 13:00:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 13:00:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 13:00:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asJAMd1W5PE+XNs/RmB8AHS+JIvfL6jvZHNcXkRhN8PTIvqbuG5jb+JC7kaW194RtX1SElVUsAyMjtuT3VSFiuOva+Y/UWmcyqrgYb2Qm4Yp5LTxoyKOYhTOEHLChOKiIa9jhylW5HTYIDx9r8FQWLBbsQbs5WnSIWp3ZEONKarYnHwqp7EWxXiEA9tAXyTyWb5i2LISHDiDdDQeB6HeHfi2a5J5skPeyZJli7LBfBw+dY7LfoFSYofgpbdBGJwdy2FO8ZFr2zLqj5uFwvp3WIkVtirAyIfLP9yx3yWp7mij1Yd+XQh19HUDMZlosGmnBNcb73KXEZSUpHiLnbcDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBUb6Ax+ihDyz/+6xj9fu5b0vfyfNn9QHqyTwL9Wz4c=;
 b=Bdl8bxRJgSGxm2NRgrntvVUdUeSyrtUkPY66U94yVJjHCMAZ1GA93ASYpnuFi/aT9L98pdDwHoL2VBQfODAEHiLAOiCvfNkwlcbSSPnn6bCjEk/nt/vySGGWIdxDypAEd8T6gl8hfKDu61lOoNJ1BI6ISmKZVzjr6+TGIKHT7wuaJUklckPKZuSuCXfJzwtMp4RAeuC3uk4G4YyJ23cyEnueSi8GkPhGbe6Ci4nOlVon0jUvEhZUOQl8hgEesjiIlvcw5QGjZLejBAwRYd8WVHEoOfw6NYxHGebqk+DTzF4Z+6fEudFKh+AgYszj7egx5IX3hOv9CPARNhWtOI+NMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5540.namprd11.prod.outlook.com (2603:10b6:610:d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 20:00:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 20:00:51 +0000
Message-ID: <05b312d1-9873-f006-cf40-1db695b4603f@intel.com>
Date:   Wed, 30 Aug 2023 13:00:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v8 6/8] x86/resctrl: Move default group file creation to
 mount
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
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-7-babu.moger@amd.com>
 <972db626-1d74-679d-72f2-3e122f95c314@intel.com>
 <5e1c084a-e224-a798-65c1-60f827634ee4@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <5e1c084a-e224-a798-65c1-60f827634ee4@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:303:b6::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5540:EE_
X-MS-Office365-Filtering-Correlation-Id: 63876686-7c77-465a-684c-08dba993cf2c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vzj3fYFNAwTmzSx+j8R+4jxWVR4ioH3D4D19f0v8rvXww0yrWVddXY4suCbjFhMDWdDWXgWNiQJ0jmum6rZvXhxyTzKAB1x+9ZOjYrsxgqBeNZM/ga3J4dxO0fK3b+62wa9ji9inb1xxkpZbUpbV6Vc/W8GcUCWoaix9SqUMQOT51PqjEOVTfkX+Nemh6VMCZZ8WVOrdvUOH5f0Nu4eZHDkpeM7I2g1fvxzHTj8Atx428CcgAYEbsqoU5gvW9wuTNoMU1A7giLVawPprWxQLxTBGGUj9J2xJrYv1s7u+Hmr1Gfi/ays8nBganUrLWKlKha9KrfzJZLZHaBHfvNwvexut01nNAZFeVa2fa4qbC6giiV1+iGHYbTdJpHmyo27ShrT7uFYsGQKxSenQGceG6ydQJQGB2KiopdXYSg3TbsNiHWZKlNZ3iIWwu3YCWpfCrARfXLwWEp9Mj3j8tGDVfLNrrSDJy5tilqT+4pS0+J1QlopEsvrpm2+aNsb/225ZGrQqyZa92q6C+UZVFmfQ9w/cUkLh7Xl7ydbJnIOaMBCSYMRPAJ12PN7RB9+zLxLD84BDiVXxtKjb6hbO/ZAh2dMghsL3KtqiTe6j/D8qxXbqOv5qlos07GhEziWRd3bUq2g/Jjx/aVewfW89ZvuZOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(186009)(1800799009)(451199024)(6506007)(6486002)(6666004)(6512007)(53546011)(83380400001)(26005)(478600001)(7416002)(7406005)(8676002)(316002)(41300700001)(66556008)(66946007)(66476007)(4326008)(8936002)(5660300002)(2906002)(44832011)(36756003)(86362001)(2616005)(38100700002)(82960400001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjR2RXZ6WnpORnpHSCsza2V4MktSWTJ3U1MzdVhZZDRHUmJzRlNySmJYSFk2?=
 =?utf-8?B?ZXpZUWlVK0dBcnhDOHhvaS9KOUpDNHA5ZjB0T1pOU2JlYnUxU1NhMjVkQ0tO?=
 =?utf-8?B?L0pteU5kU25yd014dFAxMGhFZU5QS0N4aDNsVmZjMHRxK1VmZWhFcVFNdm5K?=
 =?utf-8?B?UTZMdlRrRWNkUGhlVExpcVFaRnZOeENBd2F0WUJpZUx5M3RXVXFRNGd5emhh?=
 =?utf-8?B?Tnp5SDNDTEF0L2JMRjI5S242TkNWWkVTNEszbjJsVUl1R0pmeUFkeFBuQmEy?=
 =?utf-8?B?S1NhVUdFdnRlc2d5NEN0dUF1NjMvQTVCdUx4YWdDK2dXTHpIQlBkcnVEQXJw?=
 =?utf-8?B?d293MnI2U0lTMnhLTE1hRTZaT3ZnOWZ4c2oraXNJdmpVckZzTDc1VFNjdDFJ?=
 =?utf-8?B?T2oydTJvUm5EdU16aTdYVWVpYWVMcktwVG53KzQ3cmx6VTNib2tjWVh0bHJT?=
 =?utf-8?B?VE1FY1Z5T2dvU0hYRDZPQTlEZ3NtMWpQWGJqckdxcmtYRmt1N3RFbzRVdkl6?=
 =?utf-8?B?VFI5bDQxMDVKdFV4cFhjRi9DTTk5TWNKZ1F5Z0FvVmlPaXJjNkZHM1FGbDlD?=
 =?utf-8?B?R2VGa0pJeWFhd2ZpQmdOSFVkZTM4cFlIYjVTVjBJQ0pvVjF3ZDdUbzZ6SzBF?=
 =?utf-8?B?ak9sNWNrTEpLMnNXaDZoczZsWXJGQ2tJM1BwUG5QdzVhQklDZmZ2c1ZldFVG?=
 =?utf-8?B?d0lTbmp6YWJyT1ozT2IwN3BURldrUUFhTnBVZDRRcjd5ajMzY1RNYnlZTmg5?=
 =?utf-8?B?d2UxZ0h6UjI3S1JRSmFWbHV2SWVuVXkyM0RPQ0dpZjl0UG9VU1N4VUVDTmdw?=
 =?utf-8?B?WWxTMzlPdW1ZVk9WS0xZU0JNU1NOcHd6M3QrN0I4TmszeURMNWtmT1FDOE5x?=
 =?utf-8?B?cFRKdmVQWFNJWWtYL1MwRjlBd05PdDZicWlJWE9iaE56MXl0UlFJL0F2ckoy?=
 =?utf-8?B?dWRjYnEzeGNFQWRFcWNSbER5SEFUNjF4TWxVQUtaSlhtNG5PSGRyNUFCblM1?=
 =?utf-8?B?SzJNKzRDTmc0cUtZckR0WEp3ejJCWnZCUmxGL1hHZG9yYjlyMnFIczZJbTRh?=
 =?utf-8?B?emwxcERyVThJTnk0NG13ZWVBWWc0NE1id0hoRHJKY2FzYnNGNkVIbGU1YzZG?=
 =?utf-8?B?Y2w0MFNZK2lzejJCdDgycXNQdDNSalFnQlZvZWd3MlJjN0dCaHJTTmswZit1?=
 =?utf-8?B?WXNkeXNCeUZpUmZDdFdFZVJzT05ZSlJFWC9qSVBPV0R4K1lQdVJyc2JaSDJP?=
 =?utf-8?B?OC8ySkt2czF1QjBqbk1ERlBoZDlpUTkyeXpnNERic1RlRVg2eVZSaFloUVRX?=
 =?utf-8?B?d3lBaTlNaklEQWpTamRKdVF3MEI5VnZZS1k3TDhld3Y5cDVDa3FBOW5BU1Bo?=
 =?utf-8?B?K3cyWmdQYnZaMnBUT1R1L0loamxXdlJWbUtXZzExbllLaDVIZzN2UXpmdDVq?=
 =?utf-8?B?YW9LRzJ2YUxJRUlkRXQ1emgzTFNLRDVwL1RUNTVDZkJHYjFWcWFLb1J0VmZZ?=
 =?utf-8?B?bmFpMTNxT3p3M09OK1duQitLWDB0WHBzSlB4cmVCbGdoSThrNnFzNlVVQ2Np?=
 =?utf-8?B?ZjVieE53ZS9rd2NONnRmNHFLMXhLMDdLd0JwbXJiMGEvNHF2T29RdENDY2hk?=
 =?utf-8?B?dVFLa2xBQ0JadVVXSjFTTE5MNmROeElBSnN0Tjg0MGQ5ZWlxY1JjdjJyUEQ3?=
 =?utf-8?B?TDRHY1R3S1hYQ3RjcDN2NUplVHN5OXlNK1Z3cUN6VkQyL0NTSlRjdUR4a2V2?=
 =?utf-8?B?S3lzRnh6ZUJ6WE5iSG82elltdjUvWmZ0STRUSk1UdUk0VU44MWM3VmEvSUFV?=
 =?utf-8?B?aTZBY0JQbzNBRlRTVmI5RnEzMCtYeSt5bUcwYUhaclRFZXhXcTcydFVqUGJG?=
 =?utf-8?B?MDVjZkxhV1IxQmRVTkROODRscFczaStyamhqb1piUGFuczJJOWRuL1l3QmU2?=
 =?utf-8?B?TmpRZCtoUUl1amFNNVBzeUtCSW9CZlN5ZVpVMS9DUWJGM1owRDBua1VueTlm?=
 =?utf-8?B?RXFwK0pKc04xcldkdWs1WUNuUzJnTTByOUxSb2p1NS9PeFp0ejBwQlRzOUJM?=
 =?utf-8?B?WlMyVVB3TnNZYml4N2Yzc0F2cDFvVVByRVRlY1lKb3VXenR6YXRrMGdFMm1I?=
 =?utf-8?B?bFQ4L0JuS1RhR2FhVDMxaHNZWVVNRkhXR3dDYlUxZHlDL2xkZFNRSGtpL2Jy?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63876686-7c77-465a-684c-08dba993cf2c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 20:00:51.2703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aF4o5uNfDET1M7GR/f5lf8qeP6+gwjilpQmLTBVGjTHlmRa4Y5fVtD81l96+3HQPzwltwYAW2pyh16cNxjt4dh7xmtIucus9zSuJfusfgIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5540
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/30/2023 12:50 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 8/29/23 15:11, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 8/21/2023 4:30 PM, Babu Moger wrote:
>>> The default resource group and its files are created during kernel
>>> init time. Upcoming changes will make some resctrl files optional
>>> based on a mount parameter. If optional files are to be added to the
>>> default group based on the mount option, then each new file needs to
>>> be created separately and call kernfs_activate() again.
>>>
>>> Create all files of the default resource group during resctrl
>>> mount, destroyed during unmount, to avoid scattering resctrl
>>> file addition across two separate code flows.
>>>
>>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>>  arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 +++++++++++++++-----------
>>>  2 files changed, 33 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>> index b09e7abd1299..44ad98f8c7af 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>> @@ -611,5 +611,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>>  void __init thread_throttle_mode_init(void);
>>>  void __init mbm_config_rftype_init(const char *config);
>>>  void rdt_staged_configs_clear(void);
>>> +int rdtgroup_setup_root(struct rdt_fs_context *ctx);
>>> +void rdtgroup_destroy_root(void);
>>>  
>>
>> From what I can tell these functions are only used in rdtgroup.c.
>> Can this export be avoided by just moving these functions within
>> rdtgroup.c and making them static?
> 
> Yes. It is used only in rdtgroup.c. We can make this static by adding the
> prototypes of these function in the beginning of rdtgroup.c file to avoid
> implicit declaration compiler errors.

Why not just place the functions earlier in rdtgroup.c so that they are
located before all callers? 

Reinette
