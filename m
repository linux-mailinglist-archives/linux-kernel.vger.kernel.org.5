Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD77D7C8D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJMS2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMS2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:28:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC47583
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697221712; x=1728757712;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oy6YYiqqJ52N/P7ZwvAKmJ1DKhqteML0WUsmdLkEZpQ=;
  b=GcdpSQzwRKC+F/tE4PJVAj58jYQznBPjUCtur2N+ddyNr+FxFbLbLZ8m
   U2X86BAG5vLSPFhoQz8aFO6DNVDkpM2wMaiSuNpZJRDox+kXjCigo1qsZ
   sfMm7ORdvK80Fboa2hv8ueY+qKMnuMw+OlAeV9tKIV3P1jfc28TMiQvYK
   6HPJcfbkhZkjyKZonCdwrrtGVkxrUSF1U8CJb+oohaHc+3XaiUxyxDc5J
   /QcyqLh9qvHEuXlKa5iVuMHNco26AHKs9UACy5J4gD8FurcMIBNxo8m+q
   ihI0cGYPQ5dpjXnlt1ou4ukBp6tffiAfC89OKcRMsoPAj86eUhw9XWkni
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="382464710"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="382464710"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 11:28:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="845576376"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="845576376"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 11:28:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 11:28:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 11:28:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 11:28:31 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 11:28:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGOftIMGN+m0m0Cq5H93wqIcVZbPLDJWH7P7EOGtC7IzWASKV5guZny/F4lkA2AjPJRDARx6e9fUht+IixtgqjfWBvgwKZkn8fcxyKNhgwAy6fe+CLLrI4ScAXpDZ83IBi4QzlzRU/cWeouLFqHtGKUq1TCKVJvWR//VlBWeTQHq41YEzWHLAQi63kPDSfq/bQ33/KXfFsLeG6g/PKZJX/ZE8i+LG0I9faByqLtjTKkPiETLrDhE05nMqJeDYaQ+8f1indY66uP2Y6iQQ+UgQAQ4ZFbSufhBCbOBc9hs4X3R07vjQTpnn3NZlaBLsp7lVlJQhG/bGQijD6mfwZzlBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQ8y3Pd30h5mwbQ0SeOU6kdqdbL5qoutquk4uigBFSU=;
 b=C/JmDzLYCoBwJcB0YsuU3ONybz3JXDTQEWunDWYCqmYLTGvFRHEcqFt+xQfP7lpTWkEsC7jkwM/YwAnTEa8mTldhbx2uXH/ws0pRSD1cyz/LCAMB4YcIrRtNi2Z3SguGJGHyO2Flx32kFUXk6jcYpR95mNYRoOxAaSn1rJia1JXWbeI5RQfU0e7e3xQtDrSXAC/zJhY4mJ/U3myLEgePiByx9kCAFrKWCDjdP34z1oCEqwJywJC3uVKkeCNreUnyZmjWQ78arH6IHOnXRfeWcoMpM4ikOQFrC8G5Ysp/hxJ+JKzTBB1XK0tdDzsvceY/yNi4BMTdgHr2DWXh8PCZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM6PR11MB4562.namprd11.prod.outlook.com (2603:10b6:5:2a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 18:28:29 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::be91:b5d8:92be:c465]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::be91:b5d8:92be:c465%2]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 18:28:29 +0000
Date:   Fri, 13 Oct 2023 11:28:22 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Yanjun Yang <yangyj.ee@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [regression] some Dell systems hang at shutdown due to "x86/smp:
 Put CPUs into INIT on shutdown if possible" (was Fwd: Kernel 6.5 hangs on
 shutdown)
Message-ID: <ZSmMRoftUrmIAeR/@a4bf019067fa.jf.intel.com>
References: <e6d1dae8-e28a-455a-a851-661c825fbdcf@gmail.com>
 <9787bd09-91b3-4a79-9ca9-e7199c925f36@leemhuis.info>
 <CAHk-=wj99i00K5ZD_OJj3d8rLG07bnTH=0_GxpzxrSzNF-WYQQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=wj99i00K5ZD_OJj3d8rLG07bnTH=0_GxpzxrSzNF-WYQQ@mail.gmail.com>
X-ClientProxiedBy: MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::18) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DM6PR11MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e64cb1-4180-497d-2fc8-08dbcc1a322b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/6RPUouXg7j075UF6BLgyOyoyUv+Gc+r1qUHu6XbVb5XBx4mafWdv5DFKNOa9Koegssdcgx929M8OZwyqMdd11AoGRV6j90vpBAuF3VuLOFoz2cnw1oaoRK0rM+Om+iPoC0bUL6iFELARj8xaKLpBkW9BoPzJokWSX75F2YrZhoaZUWpYFdGZrl1r/faO+7nZt7ayLz7G1cMBDcrYli9CqYCUhNmoglaxl1QtYuKPQTSqnadR4mjY3Dl/I21jfv0ymKQyqVlu8VcMBDRgYZg8iaDVoePKX8nZZ7uH0By7GsIEUTDrcMn+6Og5R0H1B4CM9wWA3Oo6TCti0ptC54vOZXuhHEsoq1/L0xqpoQPbbDOFn7o9yIkXzGMXG2jwV2jVNvUjWyvNC2Cd0C6TaPdw9cayXG0BwxShHDE9k7zO0FK2uBiwgM8NnM9wqiZAbTcsw+Q94dv+FXOas+7zJgZUzgmmg8c20qEg8tX83AtZ0qDWGXQIV9nl9rGTcnIcVziivRgOxMsZVRdr5ZM5oLkumyiM8gLTaCpUmp4oozjyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82960400001)(26005)(6506007)(44832011)(66946007)(83380400001)(54906003)(316002)(66556008)(66476007)(6916009)(38100700002)(6512007)(86362001)(478600001)(6486002)(6666004)(2906002)(966005)(7416002)(5660300002)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M/e5M0R97Vs94gy0yUq/ClXUTW0buvVWpOSUi2FnYByMJ2xBviyoOGGtjW2h?=
 =?us-ascii?Q?k0Ft1BDwFeL8GsZ77kMa9CJwIQgTY1crPRXn4i97mjmnYF6jdeTSv6JolmK7?=
 =?us-ascii?Q?3lLkuMSKqCT4d7qwrQuvL68mKA1GaT/mWnooJznrRVZzXcPBPUc5BTpxClir?=
 =?us-ascii?Q?mMKC29qCv5RPW16GbMkVsyQde+/29yK0+ke176atG8VJgo02Vwu2TKAYclbs?=
 =?us-ascii?Q?JS57DzxL2ezoV8TSi6ZnM2pdwO8TVzDgd1PEZS0FaGrF37R++GqFn30cWjqj?=
 =?us-ascii?Q?MQACexTncgxvK+kj31RnRP3NgR/UMTn7i2EJn8pdFgOyiLElLfeQb68XGotC?=
 =?us-ascii?Q?2ExycQBqbqjjIdl8ATJIpBZ7tocNVaVRppcjruS1GiEBMOipf5jIh7g9vMQB?=
 =?us-ascii?Q?dm1S2my9EYt/sw8LMuEQndXyYzmB2aJkdgXSdLIHsGbwIsGX1UEK7oRmBb8a?=
 =?us-ascii?Q?9APmRXyjvxjwBXP7Bk3Mna+zEGfvfapvIdLyQuIPLMCpgMfpX20RdHum5r9D?=
 =?us-ascii?Q?AnJagfbPTIrmHOEIcV7HgxFpnG5j++POlol7RWgEcK4lc3k2uA8j2b2Dngml?=
 =?us-ascii?Q?KXCT3Ng7Nk/aQ5gUfhz6VHsiaMYPwtkqolEqKcCNbiRg8vg8l+CLX3aSKwxs?=
 =?us-ascii?Q?USz0MrGYG7q7OUaoUZmp+LcGs2Yq/y1D22O6Ak45ivMrWEYJGzSvEtypmU+R?=
 =?us-ascii?Q?T1sM6387/SqlW51P4WvXwXV5CCCG+rHWj2RMq4hcpf2n8SBjQe4nXTkx0xZE?=
 =?us-ascii?Q?lO7291nrJFPie7kGVDh86TyTTnkLp20hKOVJevL+FjJfuizCzG5I1+5584r0?=
 =?us-ascii?Q?wRh+kcofDqpxa6ib9rkd1SnWBj8NjQdD2iVtcPOjOrk+ehMIYNYKjWeqrIQC?=
 =?us-ascii?Q?OexHfLrSkK/bZKfzCVsY6MH2cvj0icGVGgLDV7+GQZyNi8uon0TtyH6/LI7f?=
 =?us-ascii?Q?6V9v7Ji30uRNSCa53jV0d4GTl/+r25zq3EDZwLm/sS3fItmgXSGmRU5np4A5?=
 =?us-ascii?Q?tL1MSlmWAPRHBlS+fx1/gNaonve1LyZlLaMN/r5eZ9m+GFiWTNWymUhlv2Gr?=
 =?us-ascii?Q?6NlY+E/tamtA5TYyX1tpnlflUAg8k4wva65edytRfS5ZJtdIPFmtKxdFNhRj?=
 =?us-ascii?Q?GfQWxQEEqs5NRH6UXaXtRFegLZdm35zm7BbTNEeITDXU4FyIXwCMzws7+a/p?=
 =?us-ascii?Q?W4e3GLYz/Nfe71jH02wHEmSBOCOwRcoT4eKoWr9+QtLxBmQzp/8zazROqb++?=
 =?us-ascii?Q?NyHopjrflXrkwuG5JzPC/i3qdfHD39zOmqRVOnZ0y5+5MrwaO7EVw5UAyPWF?=
 =?us-ascii?Q?fvjCNKQERDT/IL5ezSmNjOmyiu2rWlg4uQr2/RP96qBnAF/aarnV379ZfvN8?=
 =?us-ascii?Q?/THnIWNUoChtgSf3nZ4poVZokJGEvk8gi/FBE4PpmkKMSC6nJVaoN5BEgSSx?=
 =?us-ascii?Q?hYcIhOROpUiPLwdlsPZX3ZFJTLm+sprD+cEZ4E1JTQescEceOmrvy2OTXSM+?=
 =?us-ascii?Q?YRoxhA6M6uuEaNwl22MvZEr7oJyAU3LYHpJoqZfXYDeFcnPxLWOZ+Bf1xeLy?=
 =?us-ascii?Q?IyMxRWiH+Hc+L0btwExPqIRl99bhNXf6t2VIB46o?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e64cb1-4180-497d-2fc8-08dbcc1a322b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 18:28:28.7241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aVBdF0TAXmMfVjswv0WPRAbJgLNDMWg8D4yTqDrtp/xauYzgM/uPzWck+bhfiVtFxsB03Xp0KiLyLpEkGCGEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4562
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, Oct 13, 2023 at 10:48:19AM -0700, Linus Torvalds wrote:
> On Fri, 13 Oct 2023 at 05:05, Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
> >
> > Thomas, turns out that bisection result was slightly wrong: a recheck
> > confirmed that the regression is actually caused by 45e34c8af58f23
> > ("x86/smp: Put CPUs into INIT on shutdown if possible") [v6.5-rc1] of
> > yours. See https://bugzilla.kernel.org/show_bug.cgi?id=217995 for details.
> 
> That commit does look pretty dangerous.
> 
> If *anything* is done through SMI after the code does that
> smp_park_other_cpus_in_init() sequence, I wouldn't be surprised in the
> least if the machine is hung.
> 
> That's made worse since it looks like the shutdown sequence isn't
> necessarily run on the boot CPU, so the boot CPU itself may be in
> INIT, and any SMI quite possibly ends up treating that CPU specially.

Sending INIT to processor marked as BSP will tank the system.

> 
> Who knows what SMI does, but the fact that the affected machines seem
> to be mainly from one particular manufacturer does tend to imply it's
> something like that.

There was a report (probably this same one), and it turns out it was a
bug in the BIOS SMI handler.

The client BIOS's were waiting for the lowest APICID to be the SMI
rendevous master. If this is MeteorLake, the BSP wasn't the one
with the lowest APIC and it triped here.

The BIOS change is also being pushed to others for assimilation :)

Server BIOS's had this correctly for a while now.
> 
> And the code does do a fair amount *after* shutting down cpu's. Not
> just things like calling x86_platform.iommu_shutdown(), but also
> things like possibly the tboot shutdown sequence (which almost
> *certainly* is some SMI thing).
> 
> I dunno. Thomas - I htink the argument for that commit was fairly
> theoretical, and reverting it seems the obvious thing, unless you have
> some idea of what might be wrong.
> 
>                Linus

-- 
Cheers,
Ashok
