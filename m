Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C551A7A2846
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbjIOUim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbjIOUiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:38:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4F2FB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694810299; x=1726346299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qll2EIG/++Z0LR/EySU9HTie6OVnITZ+n/uOnRdY5JM=;
  b=OjtqqYL/w5Og/avxMLFa5Mj+oxfcg3Y34mv8t0YLZmODtNgKr34JoTnS
   4nApKGHKQxpflniPlp0fBbPzf5NfmwxFycNezCrRuNJqwPsEE3y/1rcvd
   0tCucnfbIQXagsy9b4X2Hi0GXxVhH+OSJU0o5edo2RXfJbLeuO2U3BD2I
   sUHyQNy5rwahs2OscT/4wFfizjXvWN8FhDker0Crs3tK/8OEly9HPOiqh
   WLcEHRD323GtmNPWwFoyUJhJLHx5Bl4DEqHQzA5psfcXNxONaAVTrbYM7
   5tKpSmbdA35wxX/wmKnOnd/7XY+PkvMCMdykSd4F0xRD8QEvZAndZMOrv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="378248193"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="378248193"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 13:38:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="694837372"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="694837372"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 13:38:17 -0700
Date:   Fri, 15 Sep 2023 13:38:16 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: resctrl2 - status
Message-ID: <ZQTAuChYjK9Y93y7@agluck-desk3>
References: <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
 <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
 <ZOkU+d4AsLGSAG+y@agluck-desk3>
 <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com>
 <ZOlRNTq3lE7VNHjU@agluck-desk3>
 <9742f177-a0ce-c5d3-5d92-90dda32f5d07@intel.com>
 <ZPjDHN0nvHz9kWFn@agluck-desk3>
 <fa93564a-45b0-ccdd-c139-ae4867eacfb5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa93564a-45b0-ccdd-c139-ae4867eacfb5@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 06:16:11PM +0100, James Morse wrote:
> Hi Tony,

Hi James.

> 
> On 06/09/2023 19:21, Tony Luck wrote:
> > I've just pushed an updated set of patches to:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git resctrl_v65
> > 
> > Rebased to v6.5. Includes the module auto-load code discussed in
> > previous e-mail.
> 
> I've taken a look at your resctrl2_v65rc7 branch. I don't think my reply to your first
> series got sent, sorry if I'm actually repeating myself.
> 
> It goes without saying that I'd prefer we refactor the existing filesystem into the shape
> we need, instead of a wholesale replacement.

I'm going to start this e-mail by disagreeing (but there is much
agreement to come below). I think the fastest way to get to where
we want to be (core code architecture independent with a mostly
clear line between that and the architecture specific code) is to
start over from scratch.

> 
> All this focusses on the structure of the code, but we can change that anytime. I'd prefer
> we work out what user-space needs and go from there.
> 
> I think the problems are:
>  * Discovering what the platform supports, including possible conflicting schemes.
>  * Architecture/Platform specific schema. e.g. SMBA. MPAM will have a handful of these too.
> * User-space should know which schema are portable, and which are not. e.g. L2/L3/MB.
> * Different control types for the same resource. e.g. Intel uses a percentage for
> bandwidth control, AMD an absolute number. We should standardise this sort of thing and
> make it discoverable.
> * Conflicting schemes for the same hardware. e.g. CDP and mba_MBps

Good list. In addition to the user-space needs, I'd like to also look
at the developer/maintainer needs ... which is why I think we need a
clear line between core code and architecture code.

> ~
> 
> I'd really like to keep the 'core' schema in the base driver. This is to ensure that 'L3'
> doesn't behave differently due to differing software implementation on Intel/AMD/Arm/riscv.
> 
> The L{2.3} schema were really well defined as they reference other things that are already
> visible in sysfs, this makes them nice and portable. I think this is the standard we
> should aim for with any new schema, and only resort to making them arch-specific if the
> hardware is just too strange.
> I tried to find a way to do this for SMBA as arm platforms will certainly have something
> similar, but the 'any other NUMA node' behaviour was just too specific to what was built.
> 
> I suspect this could be done with a frontend/backend split, with a 'common' directory
> holding the frontend driver for schema that apply to all architectures if the backend has
> shown up.
> 
> ~
> 
> Because I think the types a schema is configured with should be portable across
> architectures, I'd prefer the string parsing code lives in the core code, and isn't
> duplicated by every submodule! String parsing in the kernel is bad enough!
> 
> The obvious types we have so far are: bitmap/percentage/number/bandwidth. I think it makes
> sense for user-space to be told what the schema is configured with, and let the core code
> do that parsing.

My PoC code went full throttle on pushing all the schemata code to the
driver. But you are right that this may be too drastic.  Drivers could
just indicate that they need one of the basic types "bitmap, percentage,
number, bandwidth" together with some parameters (number of bits for
bitmap, granularity for percentage, high/low values for number, ditto
for bandwidth) and have core code handle the inital parsing. Then give
to the module for validation (e.g. for the Intel requirement that
cache bit masks have contiguous "1" bits), and some CPU models require
that a minimum of two bits are set). Also pass to the module to apply
(wrmsr() on a CPU in the domain for x86, MMIO from anywhere for ARM).

For bitmasks - MPAM seems to allow very long masks. Perhaps the kernel
can make use of the "%*pb" format to scanf/printk to cope with those?
It would mean commas in the masks like 0000,00000fff,ffffff00,0000000f

> ~
> 
> I don't have a good answer for conflicting drivers for the same hardware resource. I think
> we'd need to find a way of making the existing command-line arguments work, causing the
> corresponding module to auto-load.
> 
> But this sucks for distros, who would need somewhere to describe the policy of which
> modules get loaded. The good news is things like libvirt aren't mounting resctrl themselves.

This is where I don't think we need to perfectly emulate the system
administrator interface. People deploying resctrl features have to
understand the features. This level of QoS control isn't going to
be a "one-size-fits-all" proposition (even between different generations
of the same CPU architecture, much less across different architectures.

> ~
> 
> I suspect the CDP schemes should be made arch-specific as x86 needs the odd/even pairing,
> whereas MPAM does not. This would allow a scheme where the Iside CLOSIDs can be shared to
> avoid halving the available CLOSID.
> 
> Having somewhere sensible to put the MPAM driver is useful. It's currently dumped in
> drivers/platform as it doesn't really fit anywhere!
> 
> Allowing each submodule to add extra files to the info directories looks useful. MPAM's
> priority control has a property to say whether 0 is the top of the scale or not, this
> would allow it to be exposed to user-space, instead of having to shift the range up/down
> to hide the difference in behaviour.

I'm contemplating allowing submodules to have one extra level of
directory structure below info. E.g. so they could make
info/FEATURE/socket{0,1,...}/param{1,2,...} as I have a feature
that may be easier to describe this way.

> MPAM only needs to update the hardware on a CPU that is part of target domain on some
> platforms. The vast majority would allow the MMIO writes to come from anywhere. Having the
> applychanges behaviour specific to the submodule would reduce the number of IPI.
> >From what I've seen, riscv never needs an IPI here.

See above. The "applychanges" phase of a schemata update is necessarily
CPU architecuture specific. IPI or not is an architecture decision.

> It looks like all the core code runs at process context without touching the pre-empt
> counter or masking interrupts - this is a really nice property. Most of my headaches have
> come from this area.
> 
> The limbo work isn't arch specific, that is a property of caches, it should really be core
> code behaviour to avoid duplication. MPAM needs that, I expect riscv does too.

Yes. I'm not super happy with how much of the monitor code I stuffed
down into resctrl2/arch/x86. Partly it was done because of how many
bits need to be shared by different modules (e.g. the MBmpbs module
needs to read the MBM counters).

But note that if the user doesn't care about cache occupancy monitoring,
they can skip loading the module that reports that, and then they can
skip the whole limbo dance with periodic interrupts sampling cache
occupancy until the monitor counter gets to a low enough value to put
it back on the free list.

So while the code might be in the core, it should be aware of whether
it needs to do anything.

> Making the CLOSID/RMID allocation behaviour arch specific saves some headaches. MPAM is
> particularly different in this area. I don't know what riscv's behaviour is here.

Heh! This was my initial motivation for the rewrite. I saw where your
patches had to pass closid + rmid around to functions that only needed
one or the other on X86 and thought "we should just have a neutral
"resctrl_ids_t" typedef for that (I'm moving away from "u64" to this
typedef as I continue work on this).
> 
> 
> 
> > James: 
> > 
> > I'm now hoping for some feedback from ARM folks on whether this is a
> > useful direction. Is it possible to implement MPAM features on top of
> > this base architecture independent layer. If not, am I just missing
> > some simple extensions that you will need. Or is there some fundamental
> > problem that looks hard/impossible to resolve?
> 
> 
> You've got an rdt_l2_cat driver which is really a symlink to rdt_l3_cat built with
> different pre-processor defines. It's a good trick, but it only works because you know the
> full range of hardware that has been built.
> MPAM can't do things like this, it really is a bag of bits, and it isn't until the ACPI
> tables are parsed to find where the resources are - and then that hardware is probed -
> that we have a clue what was built.
> For example, the cache controls could be on any cache in the hierarchy, and the number is
> derived from the structure of the PPTT table. You've already got a fair amount of
> duplication when multiple struct resctrl_resources are defined. MPAM would have to
> allocate and populate these dynamically to avoid building a module for 'L5' ... just in
> case someone built that...

In my code that's an arch/x86 driver. You can do something completely
different for ARM/MPAM that meets your needs. Perhaps that's easier to
see with the changes proposed above where core code handles the basic
parsing of schemata bitmasks/numbers/...

> The mba_MBps logic is really just software, I see no reason to duplicate it on multiple
> architectures. This should be in the core of the filesystem. We already have a mount
> option to enable it.

Maybe. But it needs access to both the monitoring data, and the MBA
control registers. Would need suitable interfaces between arch specific
code that can get that data and tweak those control registers.

> I see the arch/submodules can't influence the domain numbers ... this is a problem as it
> hardcodes "you can have L2 or L3", which is something you were trying to avoid. MPAM will
> want to use NUMA-IDs for memory-side-caches, (I'd hope this to be a core/portable schema),
> as well as IOMMU-IDs for the I/O side of this.
> I don't think this is really a problem, as I'd like to add the things I need in this area
> as core/portable schema.

The modules can supply a "scope" which could be any of CPU, core,
module, socket, or tied to some specific cache domain level. If
there is something more exotic, we could add a callback function
so the module could provide its own custom CPU->domain mapping.

> Arm's IOMMU has support to label traffic with the equivalent to CLOSID/RMID. My prototype
> support for this adds IOMMU-groups to the resctrl tasks file so that the devices can be
> moved between control/monitor groups as if they were tasks. I think this would work for
> other architectures if they had similar support as IOMMU-groups are an existing concept.

So "tasks" accepts and reports non-numbers for these IOMMU-groups? And
those tie to something in /sys that tells the user which set of devices
they are monitoring/controlling?

> 
> Thanks,
> 
> James

Thanks for your detailed reply. It's given me a lot to think about.

-Tony
