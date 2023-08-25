Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D413789005
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjHYUyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjHYUyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:54:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3901FF0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692996860; x=1724532860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3C7JvGr4AJR6/16bCgkeVe12h0cpNID5Jz9uoMUPXLQ=;
  b=a/vTzI1kiZzUqYSsj6e5h1LAz09SPf3l1AXRxIcQkwBYih7lHIIywZTJ
   xvNlCxwxqlDbCagqlgVNcXPXg0COHe/94gPJC/g4+mYHqLv6yklSehVDd
   8tcJRuyGrLu72PNy8jVN3Q72uFLHUySDrUhvoYBwWxR7aOCod16QWk2Lz
   xL03iwu/WyhkMn1/DfksCLabdP1dhJtsl3inc9FoYV/MFpvd4s6PhulvP
   gTlIK9r4pTMFe3VeMbAmTdI8OREYlN1lkPiL3o9sw3ZKORImz8tw+Jrup
   OQe0qWZR0zyW5GAWFpD08dm4Z54zq0kUSjelxlaVekGVm8wUcm4Z0em9Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="378582404"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="378582404"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 13:54:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="911398812"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="911398812"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 13:54:18 -0700
Date:   Fri, 25 Aug 2023 13:54:17 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: resctrl2 - status
Message-ID: <ZOkU+d4AsLGSAG+y@agluck-desk3>
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
 <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
 <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
 <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 01:20:22PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 8/25/2023 12:44 PM, Luck, Tony wrote:
> >>>> Alternatively, can user space just take a "load all resctrl modules
> >>>> and see what sticks" (even modules of different architectures since
> >>>> a user space may want to be generic) approach?
> >>>
> >>> This mostly works. Except for the cases where different modules access
> >>> the same underlying hardware, so can't be loaded together.
> >>>
> >>> Examples:
> >>>
> >>> rdt_l3_cat vs. rdt_l3_cdp - user needs to decide whether they want CDP or not.
> >>> But this is already true ... they have to decide whether to pass the "-o cdp" option
> >>> to mount.
> >>>
> >>> rdt_l3_mba vs. rdt_l3_mba_MBps - does the user want to control memory bandwidth
> >>> with percentages, or with MB/sec values. Again the user already has to make this
> >>> decision when choosing mount options.
> >>>
> >>>
> >>> Maybe the "What resctrl options does this machine support?" question would be
> >>> best answered with a small utility?
> >>
> >> A user space utility or a kernel provided utility? If it is a user space utility
> >> I think it would end up needing to duplicate what the kernel is required to do
> >> to know if a particular feature is supported. It seems appropriate that this
> >> could be a kernel utility that can share this existing information with user
> >> space. resctrl already supports the interface for this via /sys/fs/resctrl/info.
> > 
> > I was imagining a user space utility. Even though /proc/cpuinfo doesn't show
> > all features, a utility has access to all the CPUID leaves that contain the
> > details of each feature enumeration.
> 
> For x86 that may work (in some scenarios, see later) for now but as I understand
> Arm would need a different solution where I believe the information is obtained
> via ACPI. I think it is unnecessary to require user space to have parsers for
> CPUID and ACPI if that same information needs to be parsed by the kernel and
> there already exists an interface with which the information is communicated
> from kernel to user space. Also, just because information CPUID shows a feature
> is supported by the hardware does not mean that the kernel has support for that
> feature. This could be because of a feature mismatch between user space and
> kernel, or even some features disabled for use via the, for example "rdt=!l3cat",
> kernel parameter.

Agreed this is complex, and my initial resctrl2 proposal lacks
functionality in this area.

> >> fyi ... as with previous attempts to discuss this work I find it difficult
> >> to discuss this work when you are selective about what you want to discuss/answer
> >> and just wipe the rest. Through this I understand that I am not your target
> >> audience.
> > 
> > Not my intent. I value your input highly. I'm maybe too avid a follower of the
> > "trim your replies" school of e-mail etiquette. I thought I'd covered the gist
> > of your message.
> > 
> > I'll try to be more thorough in responding in the future.
> 
> Two items from my previous email remain open:
> 
> First, why does making the code modular require everything to be loadable
> modules?
> I think that it is great that the code is modular. Ideally it will help to
> support the other architectures. As you explain this modular design also
> has the benefit that "modules" can be loaded and unloaded after resctrl mount.
> Considering your example of MBA and MBA_MBps support ... if I understand
> correctly with code being modular it enables changes from one to the other
> after resctrl mount. User can start with MBA and then switch to MBA_MBps
> without needing to unmount resctrl. What I do not understand is why does
> the code being modular require everything to be modules? Why, for example,
> could a user not interact with a resctrl file that enables the user to make
> this switch from, for example, MBA to MBA_MBps? With this the existing
> interfaces can remain to be respected, the existing mount parameters need
> to remain anyway, while enabling future "more modular" usages.

Lots of advantages to modules:
1) Only load what you need.
	- saves memory
	- reduces potential attack surface
	- may avoid periodic timers (e.g. for MBM overflow and
	  for LLC occupancy "limbo" mode).
2) If there is a security fix, can be deployed without a reboot.
3) Isolation between different features. 
	- Makes development and testing simpler

Sure some things like switching MBA to MBA_MBps mode by writing to
a control file are theoretically possible. But they would be far more
complex implementations with many possible oppurtunities for bugs.
I think Vikas made a good choice to make this a mount option rather
than selectable at run time.

> Second, copied from my previous email, what is the plan to deal with current
> users that just mount resctrl and expect to learn from it what features are
> supported?

Do such users exist? Resctrl is a sophisticated system management tool.
I'd expect system administrators deploying it are well aware of the
capabilities of the different types of systems in their data center.

But if I'm wrong, then I have to go back to figure out a way to
expose this information in a better way than randomly running "modprobe"
to see what sticks.

-Tony
