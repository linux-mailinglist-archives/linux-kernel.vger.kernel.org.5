Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8088477523A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 07:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjHIFdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 01:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHIFdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 01:33:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C01D19BC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 22:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691559186; x=1723095186;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7+khaGU7xHf5P8SWi6U28+YMb6p5v2a9co4YWgUBGOI=;
  b=TY6ENE6NSvfy8AviRUv1PRVvUV55M2Eg4/2kIi4La9MZL2dZtMpTMP0Q
   C+Q10b5QaCwJg57/nRUW/v+9EuMolELbuH9bbLgazZ98xLgLmEG8uM0BM
   4JxYO6Y7EGeCfpFElV2q2Mhd7wwKN4Wydq2MTdg3JyOGtc/OZu+jN+tSs
   wd2DwI+KtbdHQrx/vHKrQwGxVXNc0aKsAuIihfc0CipJvcNJWiB8X1o6K
   YkD9Kf0S7MdhKeP8fwx4S2uO4BkT3/bACzXl/9DkdRcQDPzOtIKHiFeJ8
   OcZpFAQcP1a18bfeGLqON8UoZwq7cyEq0ILbFJQs7NGXKc/8us7IPqp/3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437391937"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="437391937"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 22:33:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875086918"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 08 Aug 2023 22:33:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 22:33:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 22:33:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 22:33:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moAH360IUK0lcd6Qnkgn8EC8gT1X9NWleefVAC9enKg3p71UWEMqxFVElI/gH3yOHBOMSOYoCu1fesA/XjEOpxf7JrzGR7DOrgD3eUQGkWFmyn7JXYtDek/R1DsScTzVovXSujz5GyY1oqoBk8PEqquDOsEI+kv6JMubYnuGgmHFF+iopqItAYrE8CyQHbW/5dwtwxgcP1NXeo3vJYxTM5x7q+quOrBVf6u+Yjxa3huVCEUo82V0mb2xMZQYsIKSvhO3NkBjNQXxEJESZ9KQFnUwRhMUbl/ytVLSuyMwJ6fIqJ8Inr7GSfFylEMkmGcjk6noneuPxauvMsu814FT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDPDY0982yvUmKx79HG4nr65ojFQdaJT+7/srO+xwE8=;
 b=P3qLADXpqVEWgEW2w5lU1oppRKKlNiasM9ZKd5aJQLcVQ7ON4X1SPV+zY0/733SM+y9qrylaZzl2ehGPQZ4D99sJ0osGLwBQt04Rfz6DXJc9PYfVWUuaCd9KcfyckB7zNzGEtgIFYbTUZloGC37zMGn/EIuH4RsDHAZXEPN6X9an2ESuBfqgyQpmtLAQ9N4x9/RlxzPzjMRO51QFP1sceJYpU7IcrT/+/7LXLMgC6utWxPhbPkXzkzoSEOK6R2PRn7EZ4Qb+oCNnvltBraTUhmzXWOUlHJjmwzEBUP0SH72Nlua0IyztIJgNADWBys1RFj3/JFg+ALlLs6oOYnQmFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by LV3PR11MB8673.namprd11.prod.outlook.com (2603:10b6:408:21c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 05:33:03 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::38b4:292a:6bad:7775]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::38b4:292a:6bad:7775%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 05:33:03 +0000
Date:   Wed, 9 Aug 2023 13:35:32 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <dvyukov@google.com>, <nogikh@google.com>,
        <linux-kernel@vger.kernel.org>, Heng Su <heng.su@intel.com>,
        <syzkaller@googlegroups.com>, <keescook@google.com>,
        <mingo@elte.hu>, Mehta Sohil <sohil.mehta@intel.com>,
        <kirill.shutemov@linux.intel.com>, <peterz@infradead.org>
Subject: Re: [PATCH RESEND v1 1/1] x86/kernel: Increase kcov coverage under
 arch/x86/kernel folder
Message-ID: <ZNMlpBs2u+lOMthY@xpf.sh.intel.com>
References: <cover.1690771380.git.pengfei.xu@intel.com>
 <06c0bb7b5f61e5884bf31180e8c122648c752010.1690771380.git.pengfei.xu@intel.com>
 <20230807125803.94dfb08402939e0080505a5e@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230807125803.94dfb08402939e0080505a5e@linux-foundation.org>
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|LV3PR11MB8673:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a4a35b-c65b-459a-3b7d-08db989a19d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQAcwW4AZb4hsPqePH8cHpnkX8/vXPlJXKeNMmU/MMUgLGjBUvuLI3LyNv9PSFm+Unxsv+F9blfjczYFagUZzJlhbhyoInEcHYaIFA43zBu/Hl5/+r9KZBf5oTP7xPttV/QG/3TaGpvJefb4TKWWoko019DVcN3BPoKFKgLU5+yBkIi5EXx057ggA+ThUAUdtLE0MYtDuCLU4LvgL6h0IDBshC1q/2W7iYc+iWl9bOpfGygApjGbZoFoiYS0gQxQGv0vpbWafSmUSdQxT33t22/o7lTr4xVWINfm/SskQ64i4oeYEEG2lCDX/WNOXli5pqfMwK+ZPfBf93dYxMYlJWsS7iHEwbfufX5krvg5ea5mUcm0tHASaCjQ3uwKrTU2nL6qRX8UkpIxIQ4c8Lqwh0CNssX1HI5yp3a5fD+11JUb99gYp4dRPijXk5ydIkaTCWPL1weC4ZyKsDYHx6LMPUdTb0Nn68h+1ub1D7GuT6n9CiI1igW6nr7ly6lrw0y+xcrAPU3NLHqa2rXGQE/EAk+Hda3iCq59pXsD2we2PvHY0cE676cUTw8UVZepR4hf2Oy34pKNlAm8jLy8UfpcU3bid72yjLAOKm38GhhVNdD964uF12Wl/w780U08BbAO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(186006)(1800799006)(451199021)(53546011)(26005)(6506007)(966005)(6486002)(6512007)(6666004)(478600001)(82960400001)(54906003)(38100700002)(66556008)(66946007)(66476007)(4326008)(6916009)(316002)(41300700001)(8936002)(8676002)(5660300002)(44832011)(2906002)(83380400001)(86362001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AIskptxi6tuBGY43911rA1gkrnkXYNaH/proQMr7YWvB+lyo+g0CYjAHuWPU?=
 =?us-ascii?Q?1JJfXQmpa/JquefaVMMkbFaHDyLMKh7bIWsbrkLU0dMNxsOmF3MS2Xk7G9D+?=
 =?us-ascii?Q?6RStzbm8g6ZhVCMgPrX4YsfYSPrIKsZunIbntUS7x0A4mLD3QitQLEAMplFM?=
 =?us-ascii?Q?qojLSa+xGUJkUvQ5OttDOhSuFwJwg/l1NvSmKk7qVkkd25EItb+JgV6kVDua?=
 =?us-ascii?Q?MTzXzgVrCzmIe2vrehzycAnZICREp0cbTftHQ9+ijMOIZuTJm/oRKR0AsSUj?=
 =?us-ascii?Q?CK9IaGj5yV5dSsR0x5mRduPYjiiZ0zR1ro3kStq2L5TT/9Gs6O4Q0NPc4mhM?=
 =?us-ascii?Q?01360SW/bx5zqm0z77RneGQNWNgPDadwa8HpSc0846pY71KDBHtH2Efrnmal?=
 =?us-ascii?Q?toYI7sKy+XNDb3TUdMHpDXtqvziZOUzmx1meNxde5YNPggKulVoe3CBdaGIR?=
 =?us-ascii?Q?EgR3Skm+zUnp3pQW8wMWrXfmwdr2rbEbEwD6buZ1gctzm2r2e0UP+K+ia4ee?=
 =?us-ascii?Q?eJa+vgvg2WX83bf9aXUljwR0zrbrK4jjJ4P1RD0Cpu18cTlY3tf0s5VHTe0k?=
 =?us-ascii?Q?xvBOTtcmHoxp0YQtuWtVZKrhA5DDA+IaMp6pOqetZmp/4Mjcf337e1fhdJEn?=
 =?us-ascii?Q?DYMGBZiAXEaHh8Sm6MLQonXC0OeppXqbXquoiUsCIrvrlnTkMb7NzyTlQwy/?=
 =?us-ascii?Q?WFg04+AEprrznsTswDLxpcO66VZwVsvvZSiBeu08165FHZGpylcl77sA8O3k?=
 =?us-ascii?Q?90ruUtvFxYj4nHQuBbnhdURJPCimmxb72iI0LTwm9dmntGEN/nxTrZZWovFX?=
 =?us-ascii?Q?HLlgzAeE+iGPYPeF4tTMnm4v2NpjcOw6jIS8bX/Qdur6Wh0WthsgO+lcGKHv?=
 =?us-ascii?Q?YqA3n/pLQgNYUqco+GTEGZ28RT41buYsmMT2onbSJlfQF3av/LPZ1rxwcJC5?=
 =?us-ascii?Q?sllNABBMrrJEcIN360M06FTe9Re/HjsABUKYE/AWJDZa33Ok4rcYsjKGKc+S?=
 =?us-ascii?Q?YjuU99VYwmKQWZeGizEll4x7dhfQ4Lbl9O2NYt5z5ZQL06ooR6vHePDpOvFV?=
 =?us-ascii?Q?Uk2GCmYi5Hpv894Se+EJpYEDlZMGx99iK6ZKsqx+0bCDtC073sxEoKeHkAMT?=
 =?us-ascii?Q?loESHWMTdjtxSSf0rbzfCO2kTHYe1wISgW+9NCSGgHD1tWhR9YCR9sTAPqxa?=
 =?us-ascii?Q?vZZvGwiC98I5PsThOJf08kPBZLnHfr/kwiSDBy0/u0+SPr84dIRuJyHrZedl?=
 =?us-ascii?Q?BR/2OlwVFKEhgeRaO4j2C6FijTEZVjCRFrzzBdfDzyK1ixwA9wKcZJfLl01e?=
 =?us-ascii?Q?3syRykVtZjNddvR13CSgo6Eu+rrvoDRWT+mxadmvsU8wJ+mbycjH3FEoeazZ?=
 =?us-ascii?Q?aU+MBRGDgpLzYACq44Zaxwks6ugXbr6Z+zJOSLbkEcU9vaXOb64076PSTe0a?=
 =?us-ascii?Q?JGJn8k9kLoMnXcjg3FuThQSEPYmCgJiOEL5a3mQxppA93/WK/K+I1B9b2J5W?=
 =?us-ascii?Q?Q7nB+Svxw5GwVkbJogE569fgTWhmUR+DdgHf8Bmm0IMhgjcfXJF4FLvUWJpa?=
 =?us-ascii?Q?mud8CEBrEB4uoWmkbYt/DoJhcrnFgZeAd5ZNMsm+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a4a35b-c65b-459a-3b7d-08db989a19d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 05:33:03.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emdZL/EDWeKEO2H4xr707ThRjPesjMzBSm5UH99y08Hht+ddRYIxzgWCBoNAEu7Y+Pd11Sd0ghLejqmJJmEzLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8673
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 2023-08-07 at 12:58:03 -0700, Andrew Morton wrote:
> On Mon, 31 Jul 2023 11:04:18 +0800 Pengfei Xu <pengfei.xu@intel.com> wrote:
> 
> > Currently kcov instrument is disabled for object files under arch/x86/kernel
> > folder.
> > For object files under arch/x86/kernel, actually just disabling the kcov
> > instrument of files:"head32.o or head64.o and sev.o" could achieve
> > successful booting and provide kcov coverage for object files that do not
> > disable kcov instrument.
> > The additional kcov coverage collected from arch/x86/kernel folder helps
> > kernel fuzzing efforts to find bugs.
> > 
> > Link to related improvement discussion is below:
> > https://groups.google.com/g/syzkaller/c/Dsl-RYGCqs8/m/x-tfpTyFBAAJ
> > Related ticket is as follow:
> > https://bugzilla.kernel.org/show_bug.cgi?id=198443
> > 
> > ...
> >
> > --- a/arch/x86/kernel/Makefile
> > +++ b/arch/x86/kernel/Makefile
> > @@ -33,11 +33,10 @@ KCSAN_SANITIZE := n
> >  KMSAN_SANITIZE_head$(BITS).o				:= n
> >  KMSAN_SANITIZE_nmi.o					:= n
> >  
> > -# If instrumentation of this dir is enabled, boot hangs during first second.
> > -# Probably could be more selective here, but note that files related to irqs,
> > -# boot, dumpstack/stacktrace, etc are either non-interesting or can lead to
> > -# non-deterministic coverage.
> > -KCOV_INSTRUMENT		:= n
> > +# If instrumentation of the following files is enabled, boot hangs during
> > +# first second.
> > +KCOV_INSTRUMENT_head$(BITS).o				:= n
> > +KCOV_INSTRUMENT_sev.o					:= n
> >  
> >  CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
> 
> This patch exposes (but probably doesn't cause) an objtool warning:
> 
> arch/x86/kernel/traps.o: warning: objtool: ibt_selftest+0x18: sibling call from callable instruction with modified stack frame

  Thanks for pointing out the problem!
  I found: v6.5-rc5 mainline kernel met the problem also:
"
vmlinux.o: warning: objtool: ibt_selftest+0x11: sibling call from callable instruction with modified stack frame
"

  Yes, it has something to do with the patch above, becasue after installed
above patch on top of v6.5-rc5 kernel, the offset changed from 0x11 to 0x1d:
"
vmlinux.o: warning: objtool: ibt_selftest+0x1d: sibling call from callable instruction with modified stack frame
"

  I'm still not quite sure the reason of warning from ibt_selftest function.
  Anyway, I will keep looking into this issue.

Best Regards,
Thanks!

> 
> gcc-12.2.0, x86_64 allmodconfig.
> 
