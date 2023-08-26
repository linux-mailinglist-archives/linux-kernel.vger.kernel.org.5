Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A757892E6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 03:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjHZBLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 21:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjHZBLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:11:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3AF198D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 18:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693012278; x=1724548278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hCgjM/3Cb7Q3vaGTOHAqkmDXPwHjYpY1lM7SHgHpiyA=;
  b=ILCVnRy5E2D5+aE29qbuLXwoyykPFekb+4434+JKpb/rxtTT772uMqJ9
   sJitwZNV4lTUBzU61lTTDiLt/cHYraHhbe6O0pf2Qxs4CG1CZ/fWqYbG0
   1zb8xGDojC7sp3qdsZmijMrG8anjp5ZWQh1Hxco2ytcu95ERVUOI02+RC
   48pGd1w0Dk+RK9ueU+oZ+kdiOY/lQTxXLwvliDBsluAigGDraSIsFx7DZ
   h0uCIOUx19HKO3Lo8oO1wo21Ki5ibuhen/LHL26eSewUw/jLLPEskqjTF
   xp9oAifbMR9bWZNBJy8T6ewBlymGvhyz2Cu8yF+jkpPHVrFUtKC2ncwMt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="378616691"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="378616691"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 18:11:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="1068411827"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="1068411827"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 18:11:18 -0700
Date:   Fri, 25 Aug 2023 18:11:17 -0700
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
Message-ID: <ZOlRNTq3lE7VNHjU@agluck-desk3>
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
 <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
 <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
 <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
 <ZOkU+d4AsLGSAG+y@agluck-desk3>
 <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 04:08:21PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 8/25/2023 1:54 PM, Tony Luck wrote:
> > On Fri, Aug 25, 2023 at 01:20:22PM -0700, Reinette Chatre wrote:
> >> On 8/25/2023 12:44 PM, Luck, Tony wrote:
> >>>>>> Alternatively, can user space just take a "load all resctrl modules
> >>>>>> and see what sticks" (even modules of different architectures since
> >>>>>> a user space may want to be generic) approach?
> >>>>>
> >>>>> This mostly works. Except for the cases where different modules access
> >>>>> the same underlying hardware, so can't be loaded together.
> >>>>>
> >>>>> Examples:
> >>>>>
> >>>>> rdt_l3_cat vs. rdt_l3_cdp - user needs to decide whether they want CDP or not.
> >>>>> But this is already true ... they have to decide whether to pass the "-o cdp" option
> >>>>> to mount.
> >>>>>
> >>>>> rdt_l3_mba vs. rdt_l3_mba_MBps - does the user want to control memory bandwidth
> >>>>> with percentages, or with MB/sec values. Again the user already has to make this
> >>>>> decision when choosing mount options.
> >>>>>
> >>>>>
> >>>>> Maybe the "What resctrl options does this machine support?" question would be
> >>>>> best answered with a small utility?
> >>>>
> >>>> A user space utility or a kernel provided utility? If it is a user space utility
> >>>> I think it would end up needing to duplicate what the kernel is required to do
> >>>> to know if a particular feature is supported. It seems appropriate that this
> >>>> could be a kernel utility that can share this existing information with user
> >>>> space. resctrl already supports the interface for this via /sys/fs/resctrl/info.
> >>>
> >>> I was imagining a user space utility. Even though /proc/cpuinfo doesn't show
> >>> all features, a utility has access to all the CPUID leaves that contain the
> >>> details of each feature enumeration.
> >>
> >> For x86 that may work (in some scenarios, see later) for now but as I understand
> >> Arm would need a different solution where I believe the information is obtained
> >> via ACPI. I think it is unnecessary to require user space to have parsers for
> >> CPUID and ACPI if that same information needs to be parsed by the kernel and
> >> there already exists an interface with which the information is communicated
> >> from kernel to user space. Also, just because information CPUID shows a feature
> >> is supported by the hardware does not mean that the kernel has support for that
> >> feature. This could be because of a feature mismatch between user space and
> >> kernel, or even some features disabled for use via the, for example "rdt=!l3cat",
> >> kernel parameter.
> > 
> > Agreed this is complex, and my initial resctrl2 proposal lacks
> > functionality in this area.
> 
> Why is there a need to reinvent these parts?

Perhaps there isn't ... see below.

> 
> >>>> fyi ... as with previous attempts to discuss this work I find it difficult
> >>>> to discuss this work when you are selective about what you want to discuss/answer
> >>>> and just wipe the rest. Through this I understand that I am not your target
> >>>> audience.
> >>>
> >>> Not my intent. I value your input highly. I'm maybe too avid a follower of the
> >>> "trim your replies" school of e-mail etiquette. I thought I'd covered the gist
> >>> of your message.
> >>>
> >>> I'll try to be more thorough in responding in the future.
> >>
> >> Two items from my previous email remain open:
> >>
> >> First, why does making the code modular require everything to be loadable
> >> modules?
> >> I think that it is great that the code is modular. Ideally it will help to
> >> support the other architectures. As you explain this modular design also
> >> has the benefit that "modules" can be loaded and unloaded after resctrl mount.
> >> Considering your example of MBA and MBA_MBps support ... if I understand
> >> correctly with code being modular it enables changes from one to the other
> >> after resctrl mount. User can start with MBA and then switch to MBA_MBps
> >> without needing to unmount resctrl. What I do not understand is why does
> >> the code being modular require everything to be modules? Why, for example,
> >> could a user not interact with a resctrl file that enables the user to make
> >> this switch from, for example, MBA to MBA_MBps? With this the existing
> >> interfaces can remain to be respected, the existing mount parameters need
> >> to remain anyway, while enabling future "more modular" usages.
> > 
> > Lots of advantages to modules:
> > 1) Only load what you need.
> > 	- saves memory
> > 	- reduces potential attack surface
> > 	- may avoid periodic timers (e.g. for MBM overflow and
> > 	  for LLC occupancy "limbo" mode).
> > 2) If there is a security fix, can be deployed without a reboot.
> > 3) Isolation between different features. 
> > 	- Makes development and testing simpler
> >
> 
> From what I understand (1) and (3) are accomplished through things
> being modular. To transition smoothly it may be required for all
> currently supported features to be loaded by default, with the
> option to unload afterwards by user space that understands new
> modular interfaces.
> 
> (2) does not need a module for each resource and feature supported
> by resctrl. A single resctrl module would accomplish this and I
> would expect it to be something everybody would like. James also
> mentioned it being on his significant to-do list.
>  
> > Sure some things like switching MBA to MBA_MBps mode by writing to
> > a control file are theoretically possible. But they would be far more
> > complex implementations with many possible oppurtunities for bugs.
> > I think Vikas made a good choice to make this a mount option rather
> > than selectable at run time.
> > 
> >> Second, copied from my previous email, what is the plan to deal with current
> >> users that just mount resctrl and expect to learn from it what features are
> >> supported?
> > 
> > Do such users exist? Resctrl is a sophisticated system management tool.
> > I'd expect system administrators deploying it are well aware of the
> > capabilities of the different types of systems in their data center.
> > 
> > But if I'm wrong, then I have to go back to figure out a way to
> > expose this information in a better way than randomly running "modprobe"
> > to see what sticks.
> 
> I always start with intel-cmt-cat but I believe that the burden would be
> on you to convince all that existing user space would not be impacted
> by this change. If I understand correctly this implementation would
> result in mounting resctrl to have an empty schemata and no resources
> in the info directory. Without knowledge about how to enable resources
> the user space could be expected to interpret that as no resources enabled
> on the system.

Reinette,

The basic issue is that my module based system has become less user
friendly. Requiring extra steps to get basic things works.

Luckily there is a simple solution. Make the modules for the basic
functions autoload.  E.g. for MBA:

+static const struct x86_cpu_id mba_feature[] = {
+       X86_MATCH_FEATURE(X86_FEATURE_MBA, 0),
+       { }
+};
+MODULE_DEVICE_TABLE(x86cpu, mba_feature);

Then immediately after booting the system looks like this:

$ lsmod | grep rdt
rdt_l3_mba             16384  0
rdt_mbm_local_bytes    12288  0
rdt_mbm_total_bytes    12288  0
rdt_llc_occupancy      12288  0
rdt_l3_cat             16384  0

And mounting resctrl:

$ sudo mount -t resctrl resctrl /sys/fs/resctrl
$ tree /sys/fs/resctrl/info
/sys/fs/resctrl/info
├── L3
│   ├── bit_usage
│   ├── cbm_mask
│   ├── min_cbm_bits
│   ├── num_closids
│   └── shareable_bits
├── L3_MON
│   ├── max_threshold_occupancy
│   ├── mbm_poll_threshold
│   ├── mon_features
│   └── num_rmids
├── last_cmd_status
└── MB
    ├── bandwidth_gran
    ├── delay_linear
    ├── min_bandwidth
    └── num_closids

3 directories, 14 files
$ cat /sys/fs/resctrl/schemata
MB: 0=0;1=0
L3: 0=fff;1=fff

Thanks for pushing me to search for this solution to make things
more compatible.

-Tony
