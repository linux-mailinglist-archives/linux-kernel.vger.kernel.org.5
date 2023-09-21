Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61D07A9021
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjIUAVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjIUAVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:21:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19B3CC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 17:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695255674; x=1726791674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HM+uOoZk64Z4WIVFmaIOtHvJb14KM46fqD4q873r+vA=;
  b=QzsKVTJWqdRpicnb/VOkA4C8YqCIl+j8QYBHTdZKx9PYcwwyH9+Uw4vD
   btTi8QghFdUCaAX6K3/Ol/NBwpqpEe5rcwQglnRzdkjhNnJzioFXXW4ZK
   u/Xa9iepd9Dx5et+Q5UyjJrCgjJgEbtRO8pIDCHf0HcaR2pj4b93iXAvp
   jFmvm53q+OjsGvL1YMmZaJdb4LHkfS/jtM2dJNdPmArBL0YuTaAioGR8N
   NuIImxDmRMBVNfBbMPZrpYbWn/NgAN2rrEfuO837KWp+/FQWKStvOmgfN
   C6I6ZCzlLnF9Y0VmQt8RV9lSwHOrCFkeasigxVJdvEl7AsOmO1XNTQ6//
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384216538"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="384216538"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 17:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="890156991"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="890156991"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 17:20:23 -0700
Date:   Wed, 20 Sep 2023 17:21:12 -0700
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
Message-ID: <ZQuMeCCUm2sHuX8p@agluck-desk3>
References: <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
 <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
 <ZOkU+d4AsLGSAG+y@agluck-desk3>
 <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com>
 <ZOlRNTq3lE7VNHjU@agluck-desk3>
 <9742f177-a0ce-c5d3-5d92-90dda32f5d07@intel.com>
 <ZPjDHN0nvHz9kWFn@agluck-desk3>
 <fa93564a-45b0-ccdd-c139-ae4867eacfb5@arm.com>
 <ZQTAuChYjK9Y93y7@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQTAuChYjK9Y93y7@agluck-desk3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 01:38:16PM -0700, Tony Luck wrote:
> My PoC code went full throttle on pushing all the schemata code to the
> driver. But you are right that this may be too drastic.  Drivers could
> just indicate that they need one of the basic types "bitmap, percentage,
> number, bandwidth" together with some parameters (number of bits for
> bitmap, granularity for percentage, high/low values for number, ditto
> for bandwidth) and have core code handle the inital parsing. Then give
> to the module for validation (e.g. for the Intel requirement that
> cache bit masks have contiguous "1" bits), and some CPU models require
> that a minimum of two bits are set). Also pass to the module to apply
> (wrmsr() on a CPU in the domain for x86, MMIO from anywhere for ARM).
> 
> For bitmasks - MPAM seems to allow very long masks. Perhaps the kernel
> can make use of the "%*pb" format to scanf/printk to cope with those?
> It would mean commas in the masks like 0000,00000fff,ffffff00,0000000f

James,

Your earlier e-mail came at a fortuitous moment. I am breaking my
giant patches into smaller pieces. I had just got to the "add the
schemata file" section of the series. I took your advice and put
the majority of the parsing code into the core, leaving the arch
specific modules just a hook to handle weird quirks.

Modules specify the "type" of their schemata entries, together with
a parameter that the core can use. I implemented two types so far.
But should be easy to add additional types like "bandwidth" as you
had suggested.

1) Bitmask. Parameter is the number of bits.
2) Unsigned long. Parameter is the max value.

Examples of quirks:
1) Intel L3 CAT requires all "1" bits to be in a consecutive block.
   In this case core code will accept any bitmask that doesn't exceed
   the number of bits. The module can reject if the user doesn't
   follow the consecutive bits rule.
2) Intel L3 MBA requires that throttle percentage values be a multiple of the
   h/w enumerated granularity (e.g. 10%). Here the module does a
   roundup() to quietly fix invalid input (same as legacy resctrl).

I've only got through the "control" section of converting to patches.
But I think this is well past the halfway point.

Current snapshot of code is here:


git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git resctrl2_patches


* Comes with just the rdt_l3_cat and rdt_l3_mba modules.
  Without the AMD support bits at this point.
* No "cpus", "mode", "size" files yet.
* Just CTRL_MON directories.
* No monitoring support yet.

-Tony
