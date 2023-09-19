Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429AD7A6910
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjISQkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISQkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:40:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55593D6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 09:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695141616; x=1726677616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lfY3ihQpe+vp9W/f3sSqFtV8Kqn3MUI0fOpKr/I5CB0=;
  b=NsHoLw+k1G9vGSm7flNHFr4gsJJr90kDm00sRa+dAjH0XO5aFO805sPN
   sPdcaXuz4AULlJsGei+TvS2Ur011AsmomSzvbZyPeR6jGdf0iYwctBmEx
   HeMHubSM8FeqI9Vzg+bYq6pGyyMB3mSP0po3ke7f9cnLxg1KHFTy5HsmS
   b4AzUDRglcWd4da06Zbfz/lxO9thFj+GfQn4vmhG+6dVjssLVsuDZfbCd
   EVg3K4jPocg/Fma5G9Mgb8w8U3tzIcdl45YRaJfAVnOXOFXB8KoURfzyW
   JiiVi7uUCltGc6KxqpZb9nppAVDbg/+Hrypxzs6XQM9x0hDWQ8BHKDw1i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="370306686"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="370306686"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 09:40:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="993236303"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="993236303"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 09:40:15 -0700
Date:   Tue, 19 Sep 2023 09:40:13 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Peter Newman <peternewman@google.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: resctrl2 - status
Message-ID: <ZQnO7XC2ygY6/Upe@agluck-desk3>
References: <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
 <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
 <ZOkU+d4AsLGSAG+y@agluck-desk3>
 <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com>
 <ZOlRNTq3lE7VNHjU@agluck-desk3>
 <9742f177-a0ce-c5d3-5d92-90dda32f5d07@intel.com>
 <ZPjDHN0nvHz9kWFn@agluck-desk3>
 <CALPaoCj_oa=nATvOO_uysYvu+PdTQtd0pvssvm9_M1+fP-Z8JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALPaoCj_oa=nATvOO_uysYvu+PdTQtd0pvssvm9_M1+fP-Z8JA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 02:53:07PM +0200, Peter Newman wrote:
> Hi Tony,
> 
> On Wed, Sep 6, 2023 at 8:21 PM Tony Luck <tony.luck@intel.com> wrote:
> > I've just pushed an updated set of patches to:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git resctrl_v65
> 
> I'm trying to understand the purpose of the resctrl_resource struct
> defined here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git/tree/include/linux/resctrl.h?h=resctrl2_v65#n356
> 
> >From the common fields, it seems to be something with a name and some
> info files that can be divided into domains and should be told when
> CPUs are hotplugged. (I skipped the scope field because I couldn't
> find any references outside fs/resctrl2/arch). The remaining fields
> are explicitly disjoint depending on whether we're talking about
> monitoring or allocation.
> 
> >From this I don't get a strong sense that a "resource" is really a
> thing and I think James's resctrl_schema struct only for the purpose
> of resource allocation was more the right direction for common code.
> Outwardly, resctrl groups seem to be the only thing relating
> monitoring to allocation.
> 

Peter,

It's a good question. I started out with separate control_resource and
monitor_resource structures, but combined them early on when it was
looking like the overall size wasn't all that big (for a structure that
will only have a dozen or so instances) and there were a bunch of common
fields. It would be easy to separate them again if consensus is that is
cleaner. There are only two places (currently) where code walks
resources of all types (mount and unmount). So no big hassle to replace
those with separate for_each_control_resource() and for_each_monitor_resource()

> I skipped the scope field ...

The scope field is for the module to tell the core code the granularity
of the control/monitor resource so it can build a custom domain list
based on L2 cache scope, L3 cache scope, NUMA ndoe scope, core scope,
or anything else that h/w folks dream up.  This means only the common
code needs to register a CPU hotplug notifier.

Note that there is no sharing of domains between modules to allow each
module to be fully independent of any other module. This also means
that the domain structure can have a common header, with some module
specific data allocated directly after ... though the need for that
might be going away as I implement James suggestion to keep the common
schemata parsing in the generic code.

> Is there a good reason for the common code to understand relationships
> between monitors and schemas with the same name? If not, I think it
> would make more sense to register monitors and control schemata
> independently.

I'm going back through my code now, breaking it into a patch series
that builds a piece at a time. One of many things to become clear as
I work through this is that the ".name" field in the resource isn't
really useful. It may disappear to be replaced more specific
fields based on usage. There's already one for the name of the "info/"
directory for the resource. I'm adding a "schemata_name" for control
resources. When I get to the monitor section I'll likley add a
field that gets used to construct the names of directories under
the "mon_data/" directories instead of using ".name". Doing that
would remove any apparent relationship between monitors and
schemas. There's no reason on X86 for them to be connected.

-Tony
