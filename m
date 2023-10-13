Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E1D7C835E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjJMKkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjJMKkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:40:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD51012E;
        Fri, 13 Oct 2023 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697193591; x=1728729591;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EdUkyxDquqHULFKo1sZtr/htjjNPhFh4HnnBYrB4zq0=;
  b=RgKqENDrjNQ6YiG3Ug3iNPVPOu8eIv2/DiRGPLHt8OrqgdPb0YVVzoXz
   ZBh1SwfnFuMG/cyMp9crdGDmODisXv5jST6suS8VM5W3h+61/L4Ay9hRV
   EzBaD8FPZs4Yp/gcHwiO0OqMY7UYeVn6wtWsOX1hKqvdClA6tu+x4Si7q
   /S0kwzqbSNAoIypwZup6s9HuW/kSqCvU2AAEjCcyzsYiI1vTFCiJ2FYsE
   yMcBFrvH7/18IfePRV/nVS8kuh58xg+zuEV2r6HmuelwKmqQ6dhT6G1vQ
   aewTDEKLvxNhmtbCrZeZBthJzGP2VGbu2Fcrk4mENRQM+kVWE2MPkZANb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="388003210"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="388003210"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="871022922"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="871022922"
Received: from ttmerile-mobl1.ger.corp.intel.com ([10.249.37.202])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:39:47 -0700
Date:   Fri, 13 Oct 2023 13:39:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     kernel test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com,
        oe-kbuild-all@lists.linux.dev,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH V3 03/16] platform/x86/intel/vsec: Use cleanup.h
In-Reply-To: <6ed4cd5ae37a054d4780c8fa519dc83396b15c14.camel@linux.intel.com>
Message-ID: <b93a3e8-2d15-256a-4172-a22ef17dde9@linux.intel.com>
References: <20231012023840.3845703-4-david.e.box@linux.intel.com>  <202310121314.3Xpqom2w-lkp@intel.com> <6ed4cd5ae37a054d4780c8fa519dc83396b15c14.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1029817949-1697193589=:2026"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1029817949-1697193589=:2026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

I added checkpatch people, please check what looks a false positive below.

On Thu, 12 Oct 2023, David E. Box wrote:

> On Thu, 2023-10-12 at 13:25 +0800, kernel test robot wrote:
> > Hi David,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on acce85a7dd28eac3858d44230f4c65985d0f271c]
> > 
> > url:   
> > https://github.com/intel-lab-lkp/linux/commits/David-E-Box/platform-x86-intel-vsec-Move-structures-to-header/20231012-104217
> > base:   acce85a7dd28eac3858d44230f4c65985d0f271c
> > patch link:   
> > https://lore.kernel.org/r/20231012023840.3845703-4-david.e.box%40linux.intel.com
> > patch subject: [PATCH V3 03/16] platform/x86/intel/vsec: Use cleanup.h
> > reproduce:
> > (https://download.01.org/0day-ci/archive/20231012/202310121314.3Xpqom2w-lkp@in
> > tel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version
> > of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes:
> > > https://lore.kernel.org/oe-kbuild-all/202310121314.3Xpqom2w-lkp@intel.com/
> > 
> > # many are suggestions rather than must-fix
> > 
> > ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
> > #31: FILE: drivers/platform/x86/intel/vsec.c:159:
> > +       struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
> 
> These looks like false positives.

I agree. If I interpret the error message right checkpatch seems to think
that's a multiplication which is not the case here.

-- 
 i.

--8323329-1029817949-1697193589=:2026--
