Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F28880968F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444120AbjLGX0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbjLGX01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:26:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CD31717;
        Thu,  7 Dec 2023 15:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701991593; x=1733527593;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MsQ8Gj3HeC4AAWDsuLnE8tLxXSfUEN+biyEM+RFf0BI=;
  b=CNyLa9OLZ6zov8/5QezhsU2uUCMt1nGj8fgRRNcILvInTGZHAOeMQkf4
   wk5PeQVJUmsbLTpwWuLngbHSCQpA5QENa4XCZIb/AstmLrmsHVtMwGU9Z
   Tn1piFY2nd/zw9YBuV+4gykj4CbStHL/MlFlM+5SCWV83Yv0U3wbybyUU
   ZoUJhIDEOj9F2a9vPd5ibW3KCDriCGKRTi8T90WjJbmNPuVt8qfE14r3R
   SgXeSgp1A6R/9rPxXr5rdn4d26KDKz7kCQ4MEjJAZV/5AZf8aijRIRc8K
   Didc3xYHRUToo0wMrEoMc8YecT5EXDHahi3Y+M/QvTD47dQtnH3xC2AtB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1404581"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1404581"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:26:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="889903138"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="889903138"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 15:26:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 15:26:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 15:26:31 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 15:26:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ca7X0rL737WHJJfYBJ0Jd7ER2wp8Tk/aeLe0GjLFQZlBVa3awbg7w8ar9VE6j6aRrqZTV4cSnQoD1UIcPEy+cZMeJMjta1Zy7t2rSrak70w7NTT706Lel4rZBi4ig/dBai7upexVIcssvVbZsXE9JV4wKbFYNzNN6JV7nddJC+xw7I03WOlj+zDJzsbE+G6wHCMpPMVlwhwHQNgA8n/7IyuHuFHjV2Eak0dXGCJnDNJrx68ApPwGjVKPkHo615S4/L6lN7G6QwTLT0d8Yg88tuJW6cHyLInFPQ5w6zBMcSWMkAshPXCrsEPu+l9AwLB2+gdMy+Q2zfF1oUL6twwhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+falCm5ltbNv194ueqcea7y5IRkIaO8zul27hKJtyw=;
 b=hSNS8/wkEknbrZwa3fVUrk/YtjGDhsOB/8+VBiJa3xpYqfA5kGRmccfbLTg8mUyzK0s+kQWhLNBJ5Mm8sOaZ2v37pkDZ1wxweLMRwokJ8bk/SZZ0jLMoMvmisG2je2eFaoBmUqqSAWmkT8fJdItCmj/Ly2NpNZTHZ8IqBkZNQVNbLX03hBP/6ijUnhvN94Fmt79+VhhEkOlbo2PwtIDO929d5HopAbdLlPBuCc0cI+eKQDevLVqCKyC2TS6CXl5ArihbHPVoqNZnKgJ1BWef9XhH15uEYq3oCvIJ/cPKDjU/T6sPe2238hamrqPItX4cmlFjTc/ZYAAZNV0lnCMpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6157.namprd11.prod.outlook.com (2603:10b6:208:3cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 23:26:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 23:26:28 +0000
Message-ID: <c1ccdfa6-ff8a-4602-bb06-f49bf34629ff@intel.com>
Date:   Thu, 7 Dec 2023 15:26:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] x86/resctrl : Support AMD QoS RMID Pinning feature
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, James Morse <james.morse@arm.com>
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
 <d97cbeba-af6d-4b64-b5c8-32dc437a67b6@intel.com>
 <71e85bf3-a451-4adf-ad5e-d39f7935efa0@amd.com>
 <e36699cf-c73e-401b-b770-63eba708df38@intel.com>
 <5ce67d8f-e207-4029-8fb3-0bc7deab1e9f@amd.com>
 <390bbb7b-e709-4290-9bef-eed373e469b2@intel.com>
 <a6338e5d-ab94-8da8-3127-3ce90997bf65@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <a6338e5d-ab94-8da8-3127-3ce90997bf65@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbc9322-63f7-4e9f-57b6-08dbf77befa0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CV3TwJKo6djMoyNWovzgIdAXVP+qxcn858DZgZgMl/fDEJzielpR05ldxkpFFr8VMvZijejpNoacRd9zoE3yKEYW8YKZkREfruuO1WsfcbFeqmRMGhxLPTknBHY/DyoBp7dN4DePzO30LkuLIHHweqbmfdzgagIJPOF4KJV7PnOlkj7F0+t+TxglkX6A9ZOEOd27jB6ae0dy8xXrPeldfjapJI0wNyJv9amV7M4FSo2uQfncPOvJpZSnklBj0GyjJEdvF8u8odnirwwgVQp4CenuiD2NvMcXnpx5mxkpVobkE8XKEbCDwUUqM96Y9t5S1bkTRJmgi9sYiwofccxONoveSYm+exTLJ2XVjRULcfqv9qiDFCyoHsVp339QqtybZy3tCbAIFcGBoDWFrG6OIk+CpTE8D9OhBpEsfDjkbxovKVvjK2ympL/EKNA79HTXd4N0vuzAf9uSNi/9FL/mlwDeBkp0Wl/Q1wHIxauwKMSXSPTWtMCAWwiLv0pU0VEupgf+MPsN0HHR6u6zhtOcnUizISaWck6gLJaQsNFyASoPGO+d2MfUsUfQq57n3IuDLLBJBJkSv1OSV0pzwhZ8Djgk2Bb19LedWwJNPXY8zQiLSQt9+sr+qjBeWsqOLccoRqsv6iUb823qzuH30XEPJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(7416002)(2906002)(5660300002)(44832011)(86362001)(31686004)(4326008)(8676002)(8936002)(36756003)(316002)(66946007)(66556008)(6916009)(66476007)(41300700001)(38100700002)(31696002)(82960400001)(6486002)(478600001)(66899024)(83380400001)(6666004)(53546011)(6506007)(26005)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVZHd1JReVdtWUh5TDdFYW9aRE9CQWJSNENqMklDYTJXSklzM1BPSW1lMDRi?=
 =?utf-8?B?QjhBcm90SlpjN1M0NzgwSyt3QlBPeU84OTRhTWhBdjVvbnMwejRxdlEwUE5l?=
 =?utf-8?B?M0V4UTNBSFpEQWtZSWZQNktEYmpnZFVrYlZmUEduY3dLa1F5SkFvdW5XaDRC?=
 =?utf-8?B?K1lQWTdFRUhwVjRGdXpyN0R1RzRkTWZ1WXZkZGFzMU13aXdpV1hJQnVBcjcy?=
 =?utf-8?B?dEhqMU9hVHVUc0ZwajcvanQ2OEF4eDdKZ005SlRQZ00wcmdNU29OTkdxSkdy?=
 =?utf-8?B?QUxkRmdtaEp2KzZIMGx5RFFRczEyOVpUbnhmOWNXMERWTmQ3TEtsWC91aWtu?=
 =?utf-8?B?OW43UC9qemcvNlp3ekVmS2dqMHZSdlNGMENpaVo5SjZvRkpnU3BUWnp1R3Zl?=
 =?utf-8?B?bG8rTlVUYlcweDlhOW1iTnI4dkk3L2NKYkZPOGFIK21Wei9EQlU4bnA2OHpL?=
 =?utf-8?B?eEFHN2J3ZG1QMWM5WjZDenAzQnJZV3dKZGJkVXZCMjc0dXJKekVOS3hEa24z?=
 =?utf-8?B?cXIyemlaaUZpd0RLSG5EUm9waERNd3lycnZwV1F2NVdMRi9wckJYTmNHTkhU?=
 =?utf-8?B?czlHand5MmM2emFoVEcxZzlOZFdBWm9DdWYwZzFlcVpNc1pOV2tycEJVTjRw?=
 =?utf-8?B?MWIyR3BRTVBjQncxYTZUTVB3QmwxRTBkbUdKOVlrYmlwUnpCNUd3K2VNQ2w5?=
 =?utf-8?B?clI0cU9IcXlIZHVGOWVDRzRZcTZMdXB5dFBVRS9oUzhUTm1FVzZseVdsTHZ5?=
 =?utf-8?B?Q3pMalNJK241NG05UVFJb3MwWXUrL0ZCVDdtKzR5amRTa2M4VVo3RmR3NkR3?=
 =?utf-8?B?YlhoUVVpU0lZNG9XU2FoeUFTbTV3b2NsQUU5U0dxL2QvM1hmYXVaZUJMeElq?=
 =?utf-8?B?dUFBUldiQ25jaDJxaGRGRk1VTzVNZmNpeUU3WitPR3VKakE4eVpBakhTK0c5?=
 =?utf-8?B?Y2t6cGcyb0ZKQ3RMdnYyR2RZc0UxaUpBVXRHUFYrUWdmU3RwN1l1UVEyZnhZ?=
 =?utf-8?B?cGRkZDBMSURjSUZVQkc0Rmt0UmVPKzFqNVFYb0ZUNGlVdDhvZTFkajN2Q0Vo?=
 =?utf-8?B?N0Vmem5Zdy9RY3UzVzdJRkJCNUlvKzBIQVpndXVmamh2UGl5TXp0ZXFpb0d1?=
 =?utf-8?B?eVpxdHFJOVZDeWlHM0dHK1ZubzRHSm00dEZkeTB0RVBpZ3JOdWt1WWxCaHlF?=
 =?utf-8?B?bG0wU2k3YW5KaHROL3NZMW1JT29xL2JsNDNpNUtXWVFubnUzOVN1cUVnY0w3?=
 =?utf-8?B?dzJJTUM2dmJ3eDFCa0dnWXUxR2hwc3pHM2NBMFVjekhzbVZqNmlwTVYxRjVs?=
 =?utf-8?B?MzBRL082L0VaaGg3YWdUUFZ4UWRuc1VHRDRRcU9pNHlKQzVibit0aFZVaEJV?=
 =?utf-8?B?WXgwMG1JeENZRExhR0xLYkVseXY0QVAvQTFxQmh2a2tFUW1FSXpCM2NUY1E2?=
 =?utf-8?B?T1BML0pxWWcyTFJ2WEVSanNWNGM3bWVPbmJKNUpDMC95N2VBWXczcU1hREVE?=
 =?utf-8?B?U2RqWkRyanBkSmtSQmhCNS9xdnJVSWdnaUdCNlFYdzJBNmcxVWtQNzJlOHE1?=
 =?utf-8?B?WGIwNmJSbFBOVm01aGNVOUl3bExVNHhVaEpmeG1COXpIQWpONmlHTGc4M2px?=
 =?utf-8?B?alRGSzlMK2pVTkUwdU5oV3V6TTQyTkdRNUd4MHBHb1lhdTlsUWY2OXZXV1R5?=
 =?utf-8?B?NDRKaGhHMkZPSmJ4aGsvYXhVVkdmc25UN09vSk1ML3BkaWM1ZmtHcTZ2QVl2?=
 =?utf-8?B?cTZEbURYU3dKQlkwR1lkQmc4RHd4UWhPSWFNSjAxMy9HN2E0VXc1TUFyVzlU?=
 =?utf-8?B?SElXQnhvcHlIZVpQWEwzTUtZYVp2aS9FSktlYWFJcGZoWEpKSkxDNUh1QzNp?=
 =?utf-8?B?NmhkN2wxNjJ6MnZ3WHB2djk3Uk9lSHh0U3R3T3l1aWRjN2lKNFljYytObld2?=
 =?utf-8?B?OERreTQrREdWS0RPWTFNaW5BQkxDNGZXNlJvS1k4T3FiZUNnWC9HNGdCK3Fr?=
 =?utf-8?B?dmh0bmVkUnViT3l0QkhqQjdKckp4b0gxNU80ajJEcUdXMElzeG1oVFNkdm1I?=
 =?utf-8?B?ZytSWmlWM3k2dFlucFVhU3ZLUDlUMGpnTzUwS25DS2dQNk0wQkQrSDdnazBH?=
 =?utf-8?B?RHdLSE5sem91UVhkQVliMVlMNDEzdzY2M3E4aHRSV1JKMkxhcTMrZXRRRjls?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbc9322-63f7-4e9f-57b6-08dbf77befa0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 23:26:27.8356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7CtxSMj7cBydvxX39aUUrBozpnfJanGptwteHz5QQL2KDo2+Ng0t7Y3mTkNKkbpv2y0t7rP+1XW0SdaYpu2eGzDq3J1BUw5XerRPE9Z1ZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6157
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/7/2023 3:07 PM, Moger, Babu wrote:
> On 12/7/2023 1:29 PM, Reinette Chatre wrote:
>> On 12/7/2023 8:12 AM, Moger, Babu wrote:
>>> On 12/6/23 12:49, Reinette Chatre wrote:
>>>> On 12/6/2023 7:40 AM, Moger, Babu wrote:
>>>>> On 12/5/23 17:17, Reinette Chatre wrote:
>>>>>> On 11/30/2023 4:57 PM, Babu Moger wrote:
>>
>>>>>>> b. Mount with ABMC support
>>>>>>>     #umount /sys/fs/resctrl/
>>>>>>>     #mount  -o abmc -t resctrl resctrl /sys/fs/resctrl/
>>>>>>>     
>>>>>> hmmm ... so this requires the user to mount resctrl, determine if the
>>>>>> feature is supported, unmount resctrl, remount resctrl with feature enabled.
>>>>>> Could you please elaborate what prevents this feature from being enabled
>>>>>> without needing to remount resctrl?
>>>>> Spec says
>>>>> "Enabling ABMC: ABMC is enabled by setting L3_QOS_EXT_CFG.ABMC_En=1 (see
>>>>> Figure 19-7). When the state of ABMC_En is changed, it must be changed to
>>>>> the updated value on all logical processors in the QOS Domain.
>>>>> Upon transitions of the ABMC_En the following actions take place:
>>>>> All ABMC assignable bandwidth counters are reset to 0.
>>>>> The L3 default mode bandwidth counters are reset to 0.
>>>>> The L3_QOS_ABMC_CFG MSR is reset to 0."
>>>>>
>>>>> So, all the monitoring group counters will be reset.
>>>>>
>>>>> It is technically possible to enable without remount. But ABMC mode
>>>>> requires few new files(in each group) which I added when mounted with "-o
>>>>> abmc". Thought it is a better option.
>>>>>
>>>>> Otherwise we need to add these files when ABMC is supported(not when
>>>>> enabled). Need to add another file in /sys/fs/resctrl/info/L3_MON to
>>>>> enable the feature on the fly.
>>>>>
>>>>> Both are acceptable options. Any thoughts?
>>>> The new resctrl files in info/ could always be present. For example,
>>>> user space may want to know how many counters are available before
>>>> enabling the feature.
>>>>
>>>> It is not yet obvious to me that this feature requires new files
>>>> in monitor groups.
>>> There are two MBM events(total and local) in each group.
>>> We should provide an interface to assign each event independently.
>>> User can assign only one event in a group. We should also provide an
>>> option assign both the events in the group. This needs to be done at
>>> resctrl group level.
>> Understood. I would like to start by considering how (if at all) existing
>> files may be used, thus my example of using mbm_total_bytes, before adding
>> more files.
>>
>>
>> ...
>>
>>>>>>>     #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>     Unavailable
>>>>>> I believe that "Unavailable" already has an accepted meaning within current
>>>>>> interface and is associated with temporary failure. Even the AMD spec states "This
>>>>>> is generally a temporary condition and subsequent reads may succeed". In the
>>>>>> scenario above there is no chance that this counter would produce a value later.
>>>>>> I do not think it is ideal to overload existing interface with different meanings
>>>>>> associated with a new hardware specific feature ... something like "Disabled" seems
>>>>>> more appropriate.
>>>>> Hardware still reports it as unavailable. Also, there are some error cases
>>>>> hardware can report unavailable. We may not be able to differentiate that.
>>>> This highlights that this resctrl feature is currently latched to AMD's
>>>> ABMC. I do not think we should require that this resctrl feature is backed
>>>> by hardware that can support reads of counters that are disabled. A counter
>>>> read really only needs to be sent to hardware if it is enabled.
>>>>
>>>>>> Considering this we may even consider using these files themselves as a
>>>>>> way to enable the counters if they are disabled. For example, just
>>>>>> "echo 1 > /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes" can be used
>>>>> I am not sure about this. This is specific to domain 0. This group can
>>>>> have cpus from multiple domains. I think we should have the interface for
>>>>> all the domains(not for specific domain).
>>>> Are the ABMC registers not per CPU? This is unclear to me at this time
>>>> since changelog of patch #13 states it is per-CPU but yet the code
>>>> uses smp_call_function_any().
>>> Here are the clarifications from hardware engineer about this.
>>>
>>> # While configuring the counter, should we have to write (L3_QOS_ABMC_CFG)
>>> on all the logical processors in a domain?
>>>
>>> No.  In order to configure a specific counter, you only need to write it
>>> on a  single logical processor in a domain.  Configuring the actual ABMC
>>> counter is a side-effect of the write to this register.  And the actual
>>> ABMC counter configuration is a  global state.
>>>
>>> "Each logical processor implements a separate copy of these registers"
>>> identifies that if you write a 5 to L3_QOS_ABMC_CFG on C0T0, you will not
>>> read a 5 from the L3_QOS_ABMC_CFG register on C1T0.
>> Thank you for this information. Would reading L3_QOS_ABMC_DSC register on
>> C1T0 return the configuration written to L3_QOS_ABMC_CFG on C0T0 ?
> 
> Yes. Because the counter counter configuration is global. Reading L3_QOS_ABMC_DSC will return the configuration of the counter specified by
> 
> QOS_ABMC_CFG[CtrID].


To confirm, when you say "global" you mean within a domain?

> 
>>
>> Even so, you do confirm that the counter configuration is per domain. If I
>> understand correctly the implementation in this series assumes the counters
>> are programmed identically on all domains, but theoretically the system can support
>> domains with different counter configurations. For example, if a resource group
>> is limited to CPUs in one domain it would be unnecessary to consume the other
>> domain's counters.
> Yes. It is programmed on all the domains. Separating the domain
> configuration will require more changes. I am not planning to address
> in this series.

That may be ok. The priority is to consider how users want to interact with this
feature and create a suitable interface to support this. This version may not
separate domain configuration, but we do not want to create an the interface that
prevents such an enhancement in the future. Especially since it is already known
that hardware supports it.

Reinette
