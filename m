Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F9778CD55
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbjH2UJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbjH2UJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:09:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067AADB;
        Tue, 29 Aug 2023 13:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693339744; x=1724875744;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=krBOWdc4YqSurZHc3sRJ6NKNy+mQr8WOXEtkn0EmVXE=;
  b=A7lgoDZAFODCEhffxpkvapxzfHQWmEI6RLTtJccFf3ZLE1HiHWXuDtj+
   alb/16RLbs9XTbxGEqkbzOsITrT7A4XquAhkiKO0S+UPgtfIAMvylS8tV
   bDhmclE6EV0N+UODikl6xnZeJgPnJl3T06djbV6uBd7/RP2Y0mm3XRYmO
   T2T3MLevKndxs4XEtOyxBKs2qSfZeTFKPZ1nHYfA/WXcPooi76yWOKs7k
   5BDE7bMYXG2E2/VruWhZPqgpuZBEF+tx0HUO87+Br6ytYzI1QVmXalFwC
   e2Qu6kdQVlbydbsalNvPEOz3PKwJDmk8syKZWfltWlZ4AwzZ9KuT4EM0n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="372879580"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="372879580"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 13:09:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="862348845"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="862348845"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 29 Aug 2023 13:09:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 13:09:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 13:09:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 13:09:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 13:09:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaRdAGklbf3A/esc9v00QhcAXAvbwuCee0JdZERaCJGNAeoiqosnVO84c89HN8MA7k/X/RrjAf3FpTalduwO1kXX5GYfif9wHD+oFN1A+rnptFoNdX5vm+39pSNmXi4r6pjKdJSr2vhPxKNu1U7pyJR9an6qbw848zbBdwPEk66Ssr+eNaO+6rw8vHKpFRNRDaGM0ZPr6v32aAXdtrCCQfXA4WLUHpKXzr5QhJktLaeqE2isfb4x+9JYE0REGDOGmnS+acCzuPY7e7pgh+29pz1gCS1735uUPcNjqGDly9HxiV5Bi1ewL7LwwdE31IOldSbAcLDDezFznzubAvBE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsgGr5YbBzudjpyQnP2/YG6N+LIyvpduWWo7qrlAx8E=;
 b=V4MttxTNk8ZpbSZ49eZIEtYhHhkxORFQoQVzNznpTP5CcE6VxLlcizjqN590KGzEjjrMOWENqceoawh8qfcaZPXwkSGz/x/6ZEFUy0QCtZIx6YqHXWkVoZr+224tkxUBI+1IoRTKmFciT6f/KoUWAJyUZVvxFv71+iTYT0MPb4rXRGfFTDcMryJ2OtjToULz8w9qjGLugOggDtZt6JsPpY2PLlpTT+DiPbt8L33gQf+Q2MkOshzbxToB5Q3MQKi1oHl/uAIzcaE36X+MySDOoqTuuhbUh6VHvZfM8QPRiiPYZ+gH+HWo/oPniBztAslDomA2MZtMCwLiVgxaM5SDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 20:09:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 20:09:00 +0000
Message-ID: <410830e4-51ba-0e22-ea73-3a71fbed3643@intel.com>
Date:   Tue, 29 Aug 2023 13:08:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v8 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
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
 <20230821233048.434531-5-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230821233048.434531-5-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0279.namprd04.prod.outlook.com
 (2603:10b6:303:89::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3d9e71-d035-4b3a-3f5a-08dba8cbc874
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brAz/QP53Lo5zrEqlXC/SvmfJ0zIuP0KaxuZgdqWxC3HKFlytHLHw5nMcOPdab4YL1yppLZyx7hN01IQWevltXlDDtP1QmTad8Gq2P57dYu+mTMiEsys5KPDOKTXqOoT3j0vxYwrbxi21JhismcjC3IXE9tldfop2hQ8+MyhwDlpkEklNUknfIPqDV1xdwVeRgUlvm3sCCmqXBE9k1/wYzf2NuDwvzzcx6B5U6m0hYTwzhtsuFHQogZnbSb9x9lOUoaK9fJWSJagqUWJaVxFXXnZ97Sl7Oq6iaIRDG7DB4PhdLYTqzQ1bxTG0mWZdZsLSAE/NYF6Fn8suaTwoT4rF9NYlpiv7AzfW4qDIztEz5cqJQGbfb97FNGEmqN49d1dHZbzIMPUd/XEKXcRvLjeI+0MgDFSzJf8PtSyG9FMQXnUQeqsrhqgnMMP9vmOP6i+t5HoppjZEeeQFJB7gFmkTGz2xtI9/h6OwxQ1bvb14Gl8hVWpTsE8GJlmnGk5+ZS92Vh6OjOXFr9PKTjCoTryGwb6ETyztJeRJy9SuGFlwQ/05Dd3rjZa9T3g0PBbKoh3vouSO5sKsOi99fu8VxK/8N/oxZu0PQBwQI+SYg6iKkDTZHApomYqCiErVKe00u7CAM9FKdRp/4AWdcUgQ4QWEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199024)(1800799009)(186009)(26005)(6512007)(38100700002)(316002)(41300700001)(82960400001)(4326008)(7406005)(7416002)(2906002)(31696002)(4744005)(2616005)(86362001)(36756003)(8676002)(44832011)(5660300002)(8936002)(6666004)(6506007)(6486002)(66476007)(66556008)(53546011)(478600001)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmNUeDFZS1Z5Smp5MnhLbEZxZ0FUT2VsVTNaWW45OG9uVExnWEJRaTBVekJn?=
 =?utf-8?B?djlPeUZ1MW9PemVyRWN1WDRjS1dRTCtXQldyWDJnZGk0Zm5xUU1qZ1hUZVZ3?=
 =?utf-8?B?TTl4TVhYUjU2d3ZsT1BYOE9VdWNwemh0Y2tMNDNWekpzRTVWeXlnM3FSZlBy?=
 =?utf-8?B?UkdHNTVOQ0R4bU9lWGFrSWlrdVJmQ2ZhdEJEU3NYZXBiaElPd0hycW1CZE52?=
 =?utf-8?B?NjJFVk16d29KSVdpdVlzOGxidUU3YjFTZXJ6UTN1Yk9xWE91RDZRbWFpcmNG?=
 =?utf-8?B?ZWZjMlJzOXVwQWdMOWRXbHgraFp6OVVoZ2tweDFCVWpBSldzd2hleGg4dm9m?=
 =?utf-8?B?amdMZzRWUmpIemh5TkptNUttbUhIcjZBVG5nZlBmVVltOW0xQU1JMjA3TjBH?=
 =?utf-8?B?MWJMUHN0V0o5R1NFVEZMNmlodmJmNmdZbnYrNUxKUDN2em1TVDhzMW1CZVJG?=
 =?utf-8?B?UDRUV2hDSlRTTk13SkRvWXRIVExHdXlTNm9QUjgxT3hDMXRuOUJUQ05Ya2Fp?=
 =?utf-8?B?NDN3eHNsZW9ZRks2U2o5bVpOZjlTQ2pRTTJydFcwVC9HQTRkbU5IRWZkMGpl?=
 =?utf-8?B?UEhXRlI4VVR2RTluMHF5OFZXdUtEMk5xQnRZRjMwbmdjQ0dLaVVRM2d6N2w2?=
 =?utf-8?B?enV2cllLMlkzME5KRDdadGFkVnJpNXZsaks3YjBzSlQxck5tcWY0bUFobElk?=
 =?utf-8?B?dlhqMG1jQ0IzdXcwYm5LUmlMaEx3eTA4Wi85RkNjdlY4ZURCN1pvRU4yQlZL?=
 =?utf-8?B?akRONWNHa1ZMeGpCK0d2aTZ2eVdPN0pDWHNSZkJkRVdHRGhaaWVvUUdzT1M1?=
 =?utf-8?B?Rlc1NG9SNWpIZzcweVdOY1g0ckdMcUlDWlhHNnlEV010WjlhN3F2bjdiVjZG?=
 =?utf-8?B?cmkvNWJyUDZlMWM4ajZyRldqWHM0QWdlam9BeUphYzBaMlA1UnJkVkZhK2FQ?=
 =?utf-8?B?dzV4WS9NdGx1VTZ6SmRJOVFaRVF0UG83a3JDNk9lMXdRWGw4Z3dLUks3V3Av?=
 =?utf-8?B?TGF2c2c5ZGZsZE9DbWZ5VlJnVXl6eXBUY3lzTVM4S1NQalpNVE5kOVRJaWww?=
 =?utf-8?B?UTc1SkZ0ZDdQc3c4OTFUSFlrY3hTMHRHZnhqV1k0VXpSaWpMVFBhZTdwSXVo?=
 =?utf-8?B?NFZMQTltVXFIYlY4aXlxVkVSYi8wamxvck9mcnhmYXFmaXUvenlVMUJwRUE0?=
 =?utf-8?B?N01CSC9Pbk9HdG5BME9DQ1hyTm95TU5Xb0l6T2Z1TjNZSmRINGZxUHhyb0N6?=
 =?utf-8?B?NG1LSU1iWTgrclVPeTJiRFdkMjlaTHpNbHRZUVN6OWtKMXVBYnZJMlc3a3Er?=
 =?utf-8?B?SkJsZXQwU2NiWnpOMVNjSlJ6bldlbHpXaGZRaEtTNGlrREY3UitNWitGOTF2?=
 =?utf-8?B?NUtUOVpTbEdVU1VKdnc0ejRIcytPNllhQ0M5Mmh6U3dOOWxtTkdEbVYxRzlJ?=
 =?utf-8?B?NzNSVE81VityWVM5M0c0RjJEWVlFMmcxZ0h1eWp0WVpYYVNNdDc4dFZwVHhM?=
 =?utf-8?B?anVNaW9PK2dyUkE1Z0lRQU95L3ZxZ1JVbTQvalc2eW9jWjNVSXBLeW5JNWIx?=
 =?utf-8?B?WTNaZW82ZGphTXpBRmRZQjRGT0pOK1dzN0txRWNJMHFWVmNxeXJpSTExMy8v?=
 =?utf-8?B?OFVmaHZSc3EzRDNoSHk1UWNFdGp2UGVqclYzc25ta3dWWTFFbzZ6UjNKQWMz?=
 =?utf-8?B?ckF3aGhRaWRUK2Y1MEpqaFU0cEM3T0Zia2R3YUdudkVnWE5kQ01aWkN4ZnV6?=
 =?utf-8?B?ZFh1S3hTZWo2WkdtWUZyOXo1dWMybU9LMTJmSDh4bzBVcTc4d0pXVkNpMVVP?=
 =?utf-8?B?MndqenQyWkM3dmZMTndFaHUyczV5N09rTzYwWS9vTUptMFpGM2NBb0JIcUZy?=
 =?utf-8?B?WXZXTmJHb000Y3pLR08zRHNsY1JPUjdwdTROUzdDaTBMSzFXdVZnOVlEM0Zm?=
 =?utf-8?B?UUlKMFk5WDZuSjl5YVk1TWR2L0ZiNjV6bW1mTVBtSVUvbVB5ZWIyVVJzSzN1?=
 =?utf-8?B?ZW50VHZhcVp0WUcycTlaNkpGand3WG5ySnhrQVN5aDdWUDJ5c3k2bzBIbnNH?=
 =?utf-8?B?a2NkekRvclUwQXYrdFdGblJjb3NCemR3RlBqcndScXU5eHhVV0xlYjlWTHhD?=
 =?utf-8?B?OVFKYmdkZXJZY01hM083dnZLUEwzeWVYdnlVRy9mdHN1eVpJWGVCeUpDV1dF?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3d9e71-d035-4b3a-3f5a-08dba8cbc874
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 20:09:00.0523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9hK+NeJVWhEVvcHHjcRqdutQzVcl5sH90LWhFDLya4zYQ9AbD8apTGpRIe9uK9hZIdHH/LtGZc3Li7uukbM7TSDLOn/SlqTzYoScE8KHsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/21/2023 4:30 PM, Babu Moger wrote:
> resctrl uses RFTYPE flags for creating resctrl directory structure.
> 
> Definitions and directory structures are not documented. Add
> comments to improve the readability and help future additions.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

After the typo that Shaopeng pointed out is fixed you
can add:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
