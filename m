Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EA97942FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243782AbjIFSVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbjIFSVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:21:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD29F10C8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694024478; x=1725560478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TMEii4Jj19WYLeTuZA4EsMmAdVxojylah3wKsp6y6/Y=;
  b=UWA020pmzqLSHlTxTsYu7DFDST+KzVd+wBR5KsbTxRm3dE104XhY9XUa
   tO4SStLpyt5Y/ZwFioLEDV27pclOpP4vIJ8y9+ERQp5/XubCwd7/e4i3s
   f0OKuBEaBDhcsE13LatSunC5QEiMTIU3ILrAmx77d1d96bESJ93M85rZy
   vlxKhgJUKDnVCWTZdqhI1a29DOjDQcfdUWAinv73IQVQDIYhv9G1pA/iY
   adP/8PPz460gZueTH3mFQW9ioSprXr5wYFU6fLyz/3izTQxq7F8rXO+E9
   HHCIlY2Wmr5EaHj+QOIDSHV3uPCANdbuQ8YCeTaRSp7ke+FnmojEjcKCR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="408155775"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="408155775"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 11:21:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="807131113"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="807131113"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 11:21:17 -0700
Date:   Wed, 6 Sep 2023 11:21:16 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>
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
Message-ID: <ZPjDHN0nvHz9kWFn@agluck-desk3>
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
 <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
 <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
 <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
 <ZOkU+d4AsLGSAG+y@agluck-desk3>
 <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com>
 <ZOlRNTq3lE7VNHjU@agluck-desk3>
 <9742f177-a0ce-c5d3-5d92-90dda32f5d07@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9742f177-a0ce-c5d3-5d92-90dda32f5d07@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Aug 28, 2023 at 07:50:12AM -0700, Reinette Chatre wrote:
> heh ... sounds familiar to "To transition smoothly it may be required
> for all currently supported features to be loaded by default". It is not
> obvious to me how this also closes the other opens.

Reinette,

It seems unlikley that I'll be able to close every open. But I'll
keep trying as you point them out.

I've just pushed an updated set of patches to:

  git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git resctrl_v65

Rebased to v6.5. Includes the module auto-load code discussed in
previous e-mail.

James: 

I'm now hoping for some feedback from ARM folks on whether this is a
useful direction. Is it possible to implement MPAM features on top of
this base architecture independent layer. If not, am I just missing
some simple extensions that you will need. Or is there some fundamental
problem that looks hard/impossible to resolve?

Babu:

Can you try this out on an AMD system. I think I covered most of the
existing AMD resctrl features, but I have no machine to test the code
on, so very likely there are bugs in these code paths.

I'd like to make any needed changes now, before I start breaking this
into reviewable bite-sized patches to avoid too much churn.

-Tony
