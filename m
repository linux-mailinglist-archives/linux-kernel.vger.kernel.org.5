Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81267B2510
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjI1SPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjI1SPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:15:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A64199;
        Thu, 28 Sep 2023 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695924948; x=1727460948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qNscsCJUQoTmnFHvelDXIPIY/YE9vRQaq9zmrsSCgHg=;
  b=mEdlujH/JgBX44B/5hyqe3G5wWFVvI7Ev4zT8395OPgY1bqK4aDf7QFf
   E5JRUpGy20EyvX+RBb019yJup/0MDGjninTRXDm7/89Gv3bgsdgBLKAi7
   UbkUNa9NYcnir0cuESIWZZGrkIZRORoUiM9kohirxAnEuc2mv1ulLgeiP
   drGtXOXR4QsHMLeYkvhgaOy56fmh4LIrbtZqMtFVHlB6RFD0IpYzEtqiN
   ItU/g1qM7AI6OVNgDb3OXK/Ztp4TCC2SpQYt7fP8RTMLjsDQ6wUq0b1Cc
   gmlOho3jUCb0NSPdMKwzb8J0gBCK+HOO0MtLI2EiA/Dhk7uw2FaBEPMUa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="379409050"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="379409050"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 11:15:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="1080660230"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="1080660230"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 11:15:45 -0700
Date:   Thu, 28 Sep 2023 11:15:44 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v5 7/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Message-ID: <ZRXC0LyXhNXquKSZ@agluck-desk3>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-8-tony.luck@intel.com>
 <2da0c9a0-ebb4-f7fa-89f6-d32ce558fa00@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2da0c9a0-ebb4-f7fa-89f6-d32ce558fa00@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 04:30:22PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 8/29/2023 4:44 PM, Tony Luck wrote:
> > With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
> > per-NODE instead of per-L3 cache. Suffixes of directories with "L3" in
> > their name refer to Sub-NUMA nodes instead of L3 cache ids.
> > 
> > Users should be aware that SNC mode also affects the amount of L3 cache
> > available for allocation within each SNC node.
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  Documentation/arch/x86/resctrl.rst | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> > index cb05d90111b4..407764f43f25 100644
> > --- a/Documentation/arch/x86/resctrl.rst
> > +++ b/Documentation/arch/x86/resctrl.rst
> > @@ -345,9 +345,15 @@ When control is enabled all CTRL_MON groups will also contain:
> >  When monitoring is enabled all MON groups will also contain:
> >  
> >  "mon_data":
> > -	This contains a set of files organized by L3 domain and by
> > -	RDT event. E.g. on a system with two L3 domains there will
> > -	be subdirectories "mon_L3_00" and "mon_L3_01".	Each of these
> > +	This contains a set of files organized by L3 domain or by NUMA
> > +	node (depending on whether Sub-NUMA Cluster (SNC) mode is disabled
> > +	or enabled respectively) and by RDT event. E.g. on a system with
> > +	SNC mode disabled with two L3 domains there will be subdirectories
> > +	"mon_L3_00" and "mon_L3_01". The numerical suffix refers to the
> > +	L3 cache id.  With SNC enabled the directory names are the same,
> > +	but the numerical suffix refers to the node id.
> > +        Mappings from node ids to CPUs are available in the
> > +        /sys/devices/system/node/node*/cpulist files. Each of these
> 
> Please be consistent with tabs vs spaces.

I blame "vim" for this one. Typing <TAB> while working on a .rst file
throws in 8 spaces. Maybe there's a vim setting to stop this annoying
behaviour (set syntax=off didn't help). Had to use CTRL(V)<TAB> to make
it work.

> 
> >  	directories have one file per event (e.g. "llc_occupancy",
> >  	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
> >  	files provide a read out of the current value of the event for
> > @@ -452,6 +458,19 @@ and 0xA are not.  On a system with a 20-bit mask each bit represents 5%
> >  of the capacity of the cache. You could partition the cache into four
> >  equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
> >  
> > +Notes on Sub-NUMA Cluster mode
> > +==============================
> > +When SNC mode is enabled the "llc_occupancy", "mbm_total_bytes", and
> > +"mbm_local_bytes" will only give accurate results for well behaved NUMA
> > +applications. I.e. those that perform the majority of memory accesses
> > +to memory on the local NUMA node to the CPU where the task is executing.
> > +
> 
> Following our discussion of the cover letter I believe this will change to
> be specific about what user space can expect and what is actually "accurate".

I added more text about the importance of binding tasks to SNC nodes.
> 
> > +The cache allocation feature still provides the same number of
> > +bits in a mask to control allocation into the L3 cache. But each
> > +of those ways has its capacity reduced because the cache is divided
> > +between the SNC nodes. The values reported in the resctrl
> > +"size" files are adjusted accordingly.
> > +
> >  Memory bandwidth Allocation and monitoring
> >  ==========================================
> >  
> 
> Reinette
