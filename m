Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC8F7BC6A1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343758AbjJGKGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjJGKGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:06:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CC492
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 03:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696673201; x=1728209201;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8W/g0oskOi+H3ImmQUUDzMaoG2YCjP93DAlxFFEgLNc=;
  b=daN3oYb/NUMsOrGtrIjf5fBDglptsLLtabELsWbRE+h5xkLehH8+qaZg
   EGKPw1Qb8tIOFTUqZ4LFPqkQ6pkCUneYS6r6wUA4xKIPw91scv+ys6Hw2
   qFC2Rmpr3o+TnRtz7tXmJWVzDjuOyu6QHumRd9BYjPU5x5IUj+OKJT4ES
   9QgrQHhf7EcfdSaPY0cD/fdeTS5EsrOw0Zv/FX8+BxXtGIFKENLa61hew
   0Uphkpkt4e+4zNzL3fNy2uwzzzrnKqqeeBsGKmTIUshOHK0ZIqrDNy2mG
   jLQHnCw3G9y8FCrAVwDWYVwnOFllqQ6pE4bUe5Oxy4QpUJjOejXu4OIxC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="5467651"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="5467651"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 03:06:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="787660366"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="787660366"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2023 03:06:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 7 Oct 2023 03:06:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 7 Oct 2023 03:06:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sat, 7 Oct 2023 03:06:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sat, 7 Oct 2023 03:06:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMfbNZhx3ATtheZTvpCxHXb8/rwMBJ3DW+00lKF2NtwnJm5JoyKjCFZ4mhP5mKOYrQv0WLrgruNsaydMCWDa0/om3aIQYxNBbJ4YpN6IXsqy5wt8yBhW0lwq6AsKLKzPdPwTsBIlkNk4lMuRd3Lbzt/AQXlNeRe3xQbI0ycpP9AglBbTuHAWi2vtZbJzIsFQA3zQqjyUAAhHkMRluEvHxIBVRz+fXQBD0Jpq/tpUJM+BJQEPOUG0/efiAt4QtfUwJ2ZcM9ye7JKkNiRswKc2RmJtspcNLIyv1I6HZuT0n9bFiIw4xHssGQdSPi6mnW1UhD0nXKmL6meaAwvxn+w+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x61MVzqPpcdNFLtaVTip/9tX0vQb3iWIv6CvBZWcDU=;
 b=fw88TqUwVSpAMpyA6f0bXv8tKDNE9+wnMH0YvsQBJnL6ATMWGPr6JQan9xM8Zt29+ga2uERf3ZtQuZA9Qi8QJBNMI3FWwSnQ622tZZNWMW3jc4iDxeGFNyfQWDSobmdcwzC7IgIXVfTD1l+BNYNYexY6FPta66e2UeIfthmcmYfi6YcaZQO+UhbShw3iY6NhCiwk8sEQmOhQfubqWsIh58Qk52iWwhx1scITnNBiuQ+Iq9zvUCNc21tErdx5km8hfmpPZxMXmblZK9UqSiE4GGfqFZrcxEY7e1lqzJmo+MUktfw3lGeZbvSJ1S52oPfChzGcAOFf60slEm0QXx1BhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by DS7PR11MB6014.namprd11.prod.outlook.com (2603:10b6:8:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Sat, 7 Oct
 2023 10:06:32 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196%6]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 10:06:31 +0000
Date:   Sat, 7 Oct 2023 18:06:18 +0800
From:   Philip Li <philip.li@intel.com>
To:     Uros Bizjak <ubizjak@gmail.com>
CC:     kernel test robot <oliver.sang@intel.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, <linux-mm@kvack.org>
Subject: Re: [tip:x86/percpu] [x86/percpu] ca42563486:
 BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
Message-ID: <ZSEtmiUERKp1+KX7@rli9-mobl>
References: <202310071301.a5113890-oliver.sang@intel.com>
 <CAFULd4bUu=wVhH8AweOPycEw2QsbFWSjP8ytr7SM6Z5WLOdWsA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4bUu=wVhH8AweOPycEw2QsbFWSjP8ytr7SM6Z5WLOdWsA@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|DS7PR11MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ab69b5-c8a8-4f8e-0fd6-08dbc71d1499
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8EDTJ0PJstKOLoLN9L0Pj+ldGe45vb6yGK6biOzsztseda9Kg4Lyk0dX4QxdasuXa8GYhebZCMLybBpQoevRklYChr4xww154UeH1Oh7F4rmDu1Y4Ekf3uFmo1mpis3qTzqnq80U7Ms6I2HqWAnx/63g620T4TaQUENEVif/sjsdGKuC1Ea1dU9vojPLhh4mSsn8s7kvOTDLx9ppfhZDszvJfWbBAKsyRxVA8zotkAGou6dP+ZfhUexeNe7ZFqGGM0I8Azg5YNfDg6Qk7BDC80vXWt6m7bODwLLIpEzvYAqVTCq5YNGOl30umP7s24eUWxnBUx/ATGdW7vJrjcWTKfX1RUeL3WOrtAICitz1GxVGYAS9xVexx+Oi6/yrH5O2atyGvwT2aZRXUiZuCgFbx+1zvQfbGXluvmdrvv2G/f9ZHRsPDipW8nVaENrKejdMRHSVEusAm565H7sYYMk9nGjmU2Da+ML/beVjT1BHLNXYOKrcERVLuo12X8fR9bqT76lMsevw31k6nBbIzizof8oCw+fU/tu1SgwNjWZO9AnQV40xeyplB4FZwKZGZQCiROhU6caz7xZe0Kd6CfYvCAA8iFTRnC72RgTPC9jh2Ia/R+ePqFih70YzcHOyfMb3FV08DTaIWh7FmDcu+deI6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6506007)(6486002)(478600001)(6666004)(966005)(53546011)(38100700002)(86362001)(82960400001)(2906002)(33716001)(41300700001)(316002)(83380400001)(7416002)(6512007)(26005)(9686003)(8676002)(6916009)(66476007)(66556008)(44832011)(5660300002)(66946007)(54906003)(8936002)(4326008)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2tFUEVRd0lsQzV4dHlVVklmdWk0UHp1MjV4cWNoNlZ6Q0VROHhvaTRhaTlh?=
 =?utf-8?B?SjVrKzVzQlNRZHJZdXdpNHJqY0ZmS00xcXNmd0NwTzlJOHkvQkRsNmlhSHJG?=
 =?utf-8?B?cmxVKzhyd3ROMUVIbkF2elRmVk1UVUY1UE1ZVDN1dXY0Tk9LM0xUUzFyTHJF?=
 =?utf-8?B?S0lKSFB5bmVvY0FTenlEMGNsNGs5TklYQ2hQa2pmQktPOE95TTlnbmwzMDJx?=
 =?utf-8?B?bU9TenZoVVM4TVppQnN0Qkl3ZUdWN0FZYUtKeGFleDErUHVOZEoxK2g5aG93?=
 =?utf-8?B?REkwRTBUdjhBN1J6OW1mdkRPQXNNdXZGT0x5VnkrWVFpVHlsT25oOGRmRWUw?=
 =?utf-8?B?T1M2UXZVSWFjTk5SZUtYUXRqZE9nMmVyMktwV0pIREdFbzdBQVpZSHdMK2pE?=
 =?utf-8?B?VFRoaUhNL21VblJzS0tZWWlHR0VmaTNVL3JuM2J1STNSb245ODM3cEdYdGVW?=
 =?utf-8?B?VFZDbVplelZoK3EzaTd6NSsrSVBPUUdlc0psMDN3SWxENW0vQnZrakxzQkhE?=
 =?utf-8?B?aW5NazliSzVPSnZYYS9yb2dEaTRmbTJ5bk5lVEEzUm1UUldWQVFUSjEvZ1RU?=
 =?utf-8?B?VmVVQkZSc2VIZTltMFE1SE5od1d1VHZuOEJ2R0kyaDA2Y2xmWUk4cWs2OXNi?=
 =?utf-8?B?R1pKenlUUHN0ZFl0c3JrbTB4MmR4T1Era2ZDcUt5R0pER0xScWs0SFlvblZr?=
 =?utf-8?B?aU40NnQveTVNMEpRbjJjNk9JalVyd3dtMGMybXduN2NodE1PTHdjSmMrT3hD?=
 =?utf-8?B?dHJkY0lDZW9TQkFDUk4wREMxbFhPQlpqS2N2cXA0K05weGdkYzdSOGh3RkEz?=
 =?utf-8?B?VEN5K0VkRkd1b212YlVBN0gwNmoxelpIWk5yamg4emlyc3ZUbVV2V1ZrRDBi?=
 =?utf-8?B?bnVGUXM4eEJPVkpwTzBGSm1zVFl5VnhWTjRLcTErK1VpOHJNZVAzU2JobHpp?=
 =?utf-8?B?ZFI0RVMvUkZpaGZ0Sm43RWNDeFduZ2pjWVV4ZHZ2dEg3RXNEV3U1Z3p6Y0NN?=
 =?utf-8?B?Q0JidWhhNWRhN0xlSTJoNGlEa3NQa0JwRlV6K01iZGY2NzRUNE50b2xqcFVO?=
 =?utf-8?B?TU5XQml3ZzZpdUtFdWYxKzh2akU1YzNaNUo5bCtHckVBWTF5UDRMUTh0bXl2?=
 =?utf-8?B?MHBPNkp0eUNEUUdjQXNLRjRjUFNFZlVzUTVnTzRub2NZMldWNVltM1pOSlNy?=
 =?utf-8?B?bCtkbUhTRTNGTFlpVHVJSXl4cEpBa3M3VStMRnRVVlU3NkQ0K3M5dnZkbW54?=
 =?utf-8?B?SkNCT1RIRDR3Q3VRUDBwSk1FL0NkVnZBdkx3NW5MVDBQd2pNZWRheFc2aTQ2?=
 =?utf-8?B?TEw2RlY5ZmxEaWVpVHRpTmI4a1VlZDB3YTlEOGhvQWJVZDNDNXhwRXpNRzRK?=
 =?utf-8?B?M0U3anZ5a1pMaTFMSzZkUU1nY2xwZ2p2bFExV0luaUs1dTltS0NXaFMvYmVt?=
 =?utf-8?B?Nkg0WTBKY2U1WlVLZ2oyUWtweXQ2Qnp4NTkxK0NOSWdnc0JTSWtZbU9xZ1Vm?=
 =?utf-8?B?ejNvWXlhd25zdWVUeURYMmpCR2hXL05FbzE3aWxoTlRuM1JzN05NNHlSSmN6?=
 =?utf-8?B?ajk5T0UrbENBSW53QkpDVTUvY0Y5M2xaVTBMZ2poeXAzNHpWbEVrNzh0U2Fm?=
 =?utf-8?B?aEVvTnU5THpxMXVNVEFmd1c5bmZuUm1MQVMwd2lnYnRheW4vZXg3NHlZUnlz?=
 =?utf-8?B?cElZRW01SmpkQ2lvU09OMVh5cG1HMFlWS3ZNMjh3bWxDRHhoSzdWUGJ6bVo4?=
 =?utf-8?B?RWM0K3lyQVk3RHZ3OCtsOFpQTXJXaDdBSHIxN0RvZFZEbSttR1VCWmhUeWFY?=
 =?utf-8?B?Z1BIUU54dC9Udkhma0I5L3FpRVg5QUo2d2U0dTZQNy9HVFhMNG0rNjFDM04r?=
 =?utf-8?B?cnk0TmxaSHlEK2NHK1JOWUJwdytIK1VLU0Vadk43dTl6MkpzQVJuMVgyam9t?=
 =?utf-8?B?SXZTRUtVdFkyWEEzK1kxeU1UUkdWZDVhVjVUWkF2SmFxWHZrazZCMG4xYWFH?=
 =?utf-8?B?QXZ4SWJQVXpTWTRnQ3hEdExxZUpOK0dUTTY3WDNhVDR6NDRLR1pNYXdyaDc5?=
 =?utf-8?B?N0FQUUVTT3RNcXZ3UHJDZXhVMTAxdkUvSlczS2lSa0FFYmJVRmVNRHdnOUlV?=
 =?utf-8?Q?OW+zwScGvVG9QEqe04LZJDp5/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ab69b5-c8a8-4f8e-0fd6-08dbc71d1499
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 10:06:31.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+Nh2KLyu5EZvjmuCcFf/w9StjqrMH7T6WghcLGi/pnLs+Gco0MhIT8NGBcP2+ZTmpQRlJ9OZ+ETLdzemR7X5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6014
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 11:36:26AM +0200, Uros Bizjak wrote:
> On Sat, Oct 7, 2023 at 8:16 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)" on:
> >
> > commit: ca4256348660cb2162668ec3d13d1f921d05374a ("x86/percpu: Use C for percpu read/write accessors")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/percpu
> >
> > [test failed on linux-next/master 0f0fe5040de5e5fd9b040672e37725b046e312f0]
> >
> > in testcase: boot
> >
> > compiler: gcc-12
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > +--------------------------------------------------------------------------------------+------------+------------+
> > |                                                                                      | 9a462b9eaf | ca42563486 |
> > +--------------------------------------------------------------------------------------+------------+------------+
> > | boot_successes                                                                       | 13         | 0          |
> > | boot_failures                                                                        | 0          | 13         |
> > | BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#) | 0          | 13         |
> > +--------------------------------------------------------------------------------------+------------+------------+
> 
> Since this is a randconfig (x86_64-randconfig-006-20231006), does it
> mean that all other configs worked OK:

Thanks Uros. The previous report you receive are for build/compling test,
which means for these tested kconfigs, the kernel are built successfully.

For this report, we have found a possible boot issue on the reported kconfig
as compared to the parent commit. You can kindly do a check.

Thanks

> 
> i386                             allmodconfig   gcc
> i386                              allnoconfig   gcc
> i386                             allyesconfig   gcc
> i386         buildonly-randconfig-001-20231005   gcc
> i386         buildonly-randconfig-002-20231005   gcc
> i386         buildonly-randconfig-003-20231005   gcc
> i386         buildonly-randconfig-004-20231005   gcc
> i386         buildonly-randconfig-005-20231005   gcc
> i386         buildonly-randconfig-006-20231005   gcc
> i386                              debian-10.3   gcc
> i386                                defconfig   gcc
> i386                  randconfig-001-20231005   gcc
> i386                  randconfig-002-20231005   gcc
> i386                  randconfig-003-20231005   gcc
> i386                  randconfig-004-20231005   gcc
> i386                  randconfig-005-20231005   gcc
> i386                  randconfig-006-20231005   gcc
> 
> and
> 
> x86_64                            allnoconfig   gcc
> x86_64                           allyesconfig   gcc
> x86_64                              defconfig   gcc
> x86_64                randconfig-001-20231005   gcc
> x86_64                randconfig-002-20231005   gcc
> x86_64                randconfig-003-20231005   gcc
> x86_64                randconfig-004-20231005   gcc
> x86_64                randconfig-005-20231005   gcc
> x86_64                randconfig-006-20231005   gcc
> x86_64                          rhel-8.3-rust   clang
> x86_64                               rhel-8.3   gcc
> 
> are of interest to me. Assuming they are built with gcc-12, I wouldn't
> immediately blame the compiler for the failure. Due to the nature of
> the change, perhaps a weakness in the kernel has been found with some
> obscure config setting. As said, my default Fedora 39 kernel (6.5.5),
> built with gcc-13 works without any problems.
> 
> Also, does a successful report from yesterday [1] mean everything was OK?
> 
> [1] https://lore.kernel.org/lkml/202310060322.yeZgaj6Q-lkp@intel.com/
> 
> Uros.
> 
