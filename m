Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8327903A2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350762AbjIAWbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjIAWbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:31:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D6191;
        Fri,  1 Sep 2023 15:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693607466; x=1725143466;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L5t9Kzw6KWSrwiduISw+A981jFlSwKlnWtK/FSRprHc=;
  b=bVDqElBALHv50SGghQnK/bDkUF9VVyKjl/A6LU9m8LLD1Wzb+Zkdg02J
   Fhn297OdcQUZjYfkv+j1e+T9cmTwOjXp0+m7WLjdqXdsy9v/iNFPErM+w
   pSlrZddJwfWEm2drgthKwspGD7E9SqqI9SXkWvGCDNaULcj4RUCkmT6Th
   8wynTIZdQU/1fgNOsJz/TWxdlT3KrTba2hZ7zO1lIqhgs7oUDlUyYC4Q5
   DLuJD7S6wZcl6oaIDVUtVVF/cPFKj9q50qBLDtco91+ZvTzbkCX5cDP1+
   YwZjEqr2IoQBXlhpjYJoGxHodcfSIRrZed/SJl0xh1LYrtKmWq1/cXfcy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375222053"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="375222053"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 15:31:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="743276177"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="743276177"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 15:31:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 15:31:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 15:31:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 15:31:05 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 15:31:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMAI+XTnjnqN0fT/Wb7/b7KFFg8HYKucowJWe2jvuAtrjOsJpsPA+2HydyJp7No3gY8X99LbGhdVpVv9yeQFDBaQ7JnWXZIZExHK50LRhdISCjkZydv/MrMm/rsgleOcTah9hVZw6Ggb5dZJXxlbbdO/yHYj5YPrcq1ggw6c61A4e/O5XsOMgfl7asBNFygQywYstnrdRlY1Su05E6aWwXilrlJDiQ3tyey+lQBQR06c5+RUYR2jQpsTzb1BVWj/VLmSTH8qn/2dkCm+y+P+baoFXtsYlwKseT/tVWkpF/6qvO28NSk7aIw+q0qxRvyRfxT5lXi+eK5sMDW8cwLbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/4Xe+UG+7zhUCXBVGPOVHewN/D+Iho0p7EkHrmVMFI=;
 b=ARQNxPVP4iman3PWzlzbsZCl8A7SW2MLcOGJGpmhWz94mdd8JkfeLCqFHFG6ifFp78e7hdoNwBKU7E4evQyiPLAhlkgNQlmM7nDyln9dFTgEScgqs4bYlhuwg2QVfGht9Q/DEWJJTMAugc57rPbRWb840+fKZ7z/MjgjpclY1GIxfgcFGSaAzd56Pgy9FplYz8YO0rOy8gnnkgohs1bku0NHBT+U8/k7FWCF9YTdgRFoa3Nzp2/dU5ISW0ERM/bZY7BIWO8HakhfThJgElG4wrXM/38m7NfckHAfKurUViSxkGjkxbbBbZNAe1HAoCfbkTsckpuF1XImAmGxJgABKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA1PR11MB8247.namprd11.prod.outlook.com (2603:10b6:208:449::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.26; Fri, 1 Sep
 2023 22:30:58 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 22:30:58 +0000
Message-ID: <6a5ed053-5d4d-f098-d37f-17eec3554536@intel.com>
Date:   Fri, 1 Sep 2023 15:31:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-5-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230821233048.434531-5-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0382.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::27) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|IA1PR11MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbf2e59-bf3d-4725-b4b4-08dbab3b1cf3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QWu8tdpD7Pf871iw9VkDLBSM70jZR+WnhoNpIs3h6JDiYURdygd3xFQ1e66/5PdXYZIzQyQKE7ygx1ibyVEivF+QWeIIIp2B0fbElXTRG8/0r8p1A3q3IOQiHzkhAjhW/qyLtBuPDtK7JePeAQdOKSvBOFIjimaCJMNDAaiIe8f9sZ1CCYbn3fcrjmDZNcqev9VkdPymEONUiuUW0Jw8k3KjVxB7GqWkN1sRBMEPzWwxJJodbGYlsVxf1TGY1pxqWlzB0l2hYv+5rG9vcvKRxJRKGCfUY+7y6otLke+V3UBhA0zR5emZO4PPkhKZ7Qf8HHaZ6ClV+4kabYoZyxe1c2YmDfxEJfjDHYQGt6MqwdqUcJZOLZIdNMZD5g6y8eALQStsvTPQaUw+KjpRVStDQdx2X1FuSjbue6WW1jl+JqPQ+0Rz5ny+yuJ2koJ8Yb0M/0nZ7RkTBg/vwYtjZlSbQR2/XhsCzEhJYLjRc7g4Y3F9skPDQ9hVeakqgr+K7Le2Av0V5Cx5XOSgUVHfVsc83JH9ebXMrdzL2t0/xZ0VzZHVBr9aeC/kOwBlg8JHEox7SnWsW6l9q2nx/I2RATbn9D8Ze182m8TQtQrBXk2wPWS9gnS5JLClIPS30X+QpaJLqfJntyoUZcXkKqDHZy0BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199024)(1800799009)(186009)(31686004)(6506007)(6666004)(6512007)(6486002)(36756003)(31696002)(82960400001)(86362001)(38100700002)(2616005)(2906002)(26005)(53546011)(478600001)(66946007)(8936002)(8676002)(5660300002)(4326008)(7406005)(7416002)(44832011)(316002)(66556008)(66476007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVYzcEhwRVhJUmZ0R2ltOUs2emYrZWhJbkVsZ2Z5WGpYYmhKSTk0YTNsa2ZY?=
 =?utf-8?B?ZEtFc0l3R0VvcVNrWXEzNWUzQmE3NVlHa3lNWWlrNWgyRUZyaE5FbDFCdXFM?=
 =?utf-8?B?MXBpOUoxMm9FcDA2L1IydFYwL0FDemFaQk9UNGtsUG1kL1ZIMWUxN1Z2YVpT?=
 =?utf-8?B?bUEwUDBaTXIzWkFSMi94RkZnSzNKc2lWNjRFYTlNRXhleUZzVk9sbHlaR25q?=
 =?utf-8?B?aktMZmJvMjF0Z3ZrTWJzTjVIZGE1TmxrbjNJaGtqcCsyRXNDOVZjRUdnNURz?=
 =?utf-8?B?RHRLTnV2MHNvd2dnWTF5cGJwTmgvaVIwYUs2eUREZkFZemxPOUIxVGlGZ1px?=
 =?utf-8?B?aXg2MzJlSDYyY2NGKzlGSy81bU0vUGx1NVNMeVF5aWFWWnZoS0NpV2VHSnhq?=
 =?utf-8?B?T3gyc3M2TXpHb3BCVk9aL1Iwb01rTVU3SWQ2T2tndENiSFM4TDlCYzl3VEhj?=
 =?utf-8?B?R2RmOHBCU2RHaEY0RXFUTXhjdXcrR01RS09wQ3llNjdUVmxqdHVwQUIwR3Iy?=
 =?utf-8?B?STE0MmErcUF2Z2c4ZXg3U2JHcjZMakM0VVM5aFZUUmttQ2tnWGY5YkRVWnM2?=
 =?utf-8?B?ZkFuV0wxTWJWOGxJMThpRXZrQ1VoSFFBT0k5WklaU3p1cHVIYm0yU2xnekpP?=
 =?utf-8?B?WlJ0MHQ5cTZkU3FzdUpzWDN5TDJtQVB2cnRoVVpIeXIzWUo5U1dpN3RJelJT?=
 =?utf-8?B?eXZxQ3ZHdlRLTEJ5N2VwU0tNVVNoem1yR0dmSk42QnBxaGdaZ3RMdzZpVlY4?=
 =?utf-8?B?TUo2QWRvYUdkeDZQMExOLzFNK1drYkszUzI4VmJDWFE2clV0OUo3dnZGVFhS?=
 =?utf-8?B?SDJUQWU3M3FDUHRVaUdFVzRVOTRuUEI5V2xyZ3ZTMTJoVUYvbnB4RGQ2bU5k?=
 =?utf-8?B?ZGxVSlhpQytCeG0va2pQajJ6N3BsaUtOZDlyU2RxTGs2SW1ia0U0eDRDZFIz?=
 =?utf-8?B?NFRvWWIwRUwvL0c4bWw5YVh1WHVpcnFKUklVNHZLNmd1OVo2MVFOc0wrWDFx?=
 =?utf-8?B?bVY5cGRCM2NROW1GeDV1S1JnSEpYUDFnTGN3OFhrcUI0dTMzTkpTcDBRL3Y0?=
 =?utf-8?B?dWtIQmxKMEJWUzRtUzNWb1gyMjRXZlpTT0NUVnJSWUo3Rkt4TXNjakQ0bTBX?=
 =?utf-8?B?ODJKOGFmNElYQ3RyY2NTTHc4K3hxOS9wakZGYUpUSm1lTi9HZTZGM3dibTZQ?=
 =?utf-8?B?TkxsRlBub0RWMHNlUmRqQnI4S3FqQkwwR3IwaUlBWmg4TlJob3cwYTRnVVEz?=
 =?utf-8?B?bWZBNHdjTEhSZDJRc0VSd0dqRHBZWml4ZVhyaW95STg5TnA5aGFTb2pqV25B?=
 =?utf-8?B?OHR5R2dCdW9NN3FZOVhjZS84NnVrTzhEYmI3ek1yVGd0aHhNd1pHVDZRWVBO?=
 =?utf-8?B?WkVCN29YUnU4L0NRZnBNUE5MZVNCS1ZXbHdvWEwvMURkVHViOXBtbElrQ0R0?=
 =?utf-8?B?My93VW01Zzd5S3dXdkNPU240clhlTCtMb0tqa0hpU0J4N3dNZzVLK2JLUVdj?=
 =?utf-8?B?cDB4byt1QlNIRVZCVHpqMXlmRDlWMWtSZk93QVMrakVxRGpIVVVvSm5tbzY5?=
 =?utf-8?B?dWl3UTdodTQ1R2VESzc2NlNUajFXVTZTMkVxaWtpNndPQ3BKNmtoY3VZTDNL?=
 =?utf-8?B?d3IwV2o5U2FSa2lObTFpeldVK2RadDdNcTZKdXdMWVcxQXdrd3VYelpDQkI0?=
 =?utf-8?B?bFYvb2MyWkRYM0xBQWRXc2VSUGxnempJQlo4MEFIcSt0LzVkeVlNZG4zVTIx?=
 =?utf-8?B?ZkJ2Z3E1eHoxbUJhaHNnZko1aThQNndGTDlUVVBybXg1ZytYWi8xWklkbFpj?=
 =?utf-8?B?TWl6UnZYaE5MeXEwNWhJU3VVRnhHaWlvUzdwcGRYL2dOdUJxRGRKellGUnBo?=
 =?utf-8?B?bzY0eGM3YVE1YUlxUENBQUFXU0R0QkE3bmwzcytCcXBKWExVWlZCTEhhRW1H?=
 =?utf-8?B?WTRhaVVSOTBTdFF0TnpzRTdLaWlDZWpZMkpsekJnOVBjYmVSbGNTdVBDeGJi?=
 =?utf-8?B?OFBnQ1dpVXErWjRMS3Y0OWZKMCtBSVR4RWZWcGJIKzBCM1k5aDVIRG12b3RX?=
 =?utf-8?B?clVQSW5RZEZOczVnYWFWNTh3OUFqd0JQS1RzQXYzdXh5WG9EZ0srREpGbndE?=
 =?utf-8?Q?lj3ccpjWIrPWPVwgxVoKv+GOw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbf2e59-bf3d-4725-b4b4-08dbab3b1cf3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 22:30:58.3132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: my6NhWUyBG/KX73dk72lhBVm2lSzJfb2mKmgrZXcRwhPeqQH1VRPNb7gBHZ+QnUPJ2QoNC0ul+bmknphnxCAsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8247
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Babu,

On 8/21/23 16:30, Babu Moger wrote:
> resctrl uses RFTYPE flags for creating resctrl directory structure.
> 
> Definitions and directory structures are not documented. Add
> comments to improve the readability and help future additions.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h | 58 ++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 2051179a3b91..b09e7abd1299 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -240,6 +240,64 @@ struct rdtgroup {
>   
>   /*
>    * Define the file type flags for base and info directories.
> + *
> + * RESCTRL filesystem has two main components
> + *	a. info
> + *	b. base
> + *
> + * /sys/fs/resctrl/
> + *	|
> + *	--> info (Top level directory named "info". Contains files that
> + *	|	  provide details on control and monitoring resources.)
> + *	|
> + *	--> base (Root directory associated with default resource group
> + *		  as well as directories created by user for MON and CTRL
> + *		  groups. Contains files to interact with MON and CTRL
> + *		  groups.)
> + *
> + *	Note: resctrl uses flags for files, not for directories.
> + *	      Directories are created based on the resource type. Added
> + *	      directories below for better understanding.
> + *
> + *	info directory structure
> + *	------------------------------------------------------------------
> + *	--> RFTYPE_INFO
> + *	    directory: info
> + *		--> RFTYPE_TOP (Files in top level of info directory)
> + *		    File: last_cmd_status
> + *
> + *		--> RFTYPE_MON (Files for all monitoring resources)
> + *		    Directory: L3_MON
> + *		        Files: mon_features, num_rmids
> + *
> + *			--> RFTYPE_RES_CACHE (Files for cache monitoring resources)
> + *			    Directory: L3_MON
> + *			        Files: max_threshold_occupancy,
> + *			               mbm_total_bytes_config,
> + *			               mbm_local_bytes_config
> + *
> + *		--> RFTYPE_CTRL (Files for all control resources)
> + *		    Directories: L2, L3, MB, SMBA

L2 CDP and L3 CDP have different dirs. So need to add them here:

  + *		    Directories: L2, L3, MB, SMBA, L2CODE, L2DATA, L3CODE, L3DATA 
(L*CODE and L*DATA only available when CDP is enabled)

> + *		           File: num_closids
> + *
> + *			--> RFTYPE_RES_CACHE (Files for cache control resources)
> + *			    Directories: L2, L3

 > + *			    Directories: L2, L3

+ *			    Directories: L2, L3, L2CODE, L2DATA, L3CODE, L3DATA

> + *			          Files: bit_usage, cbm_mask, min_cbm_bits,
> + *			                 shareable_bits
> + *
> + *			--> RFTYPE_RES_MB (Files for memory control resources)
> + *			    Directories: MB, SMBA
> + *			          Files: bandwidth_gran, delay_linear,
> + *			                 min_bandwidth, thread_throttle_mode
> + *
> + *	base directory structure
> + *	------------------------------------------------------------------
> + *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
> + *	    Files: cpus, cpus_list, tasks
> + *
> + *		--> RFTYPE_CTRL (Files only for CTRL group)
> + *		    Files: mode, schemata, size
> + *
>    */
>   #define RFTYPE_INFO			BIT(0)
>   #define RFTYPE_BASE			BIT(1)

Thanks.

-Fenghua
