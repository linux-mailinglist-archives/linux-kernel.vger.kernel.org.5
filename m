Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362CF7C649D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 07:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377029AbjJLF01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 01:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347049AbjJLF0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 01:26:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8EDB8;
        Wed, 11 Oct 2023 22:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697088383; x=1728624383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LeeXmusK+iW6I5sSe0haYdMvQit1ncmN9v4FBs+c+TE=;
  b=YbN5esfTev0ZskNag8jL3kaBcjGsgsXtjeoWBcX3igO19XEtJ3+gpw2I
   fMAHn9/9df5PJGtixy7XY2D2GD2RgQjZZ43h96OunDFOcfC9M1mJs6+Vq
   GiYIFuAHdaoNLRH+obLE72qAo3sAMc8rPoWeqE47W/EDJtrlqCKfOfdJY
   78iXUNWBCIGsrWaNwmpZKgPh7aId+GYPtAxYl1vjMDzK9IekEELhALuE9
   f+spymTqQiiG0cfMVJkdOJLPTh+HhD0kPVNzjnC7T1bvDWKiwItynvt7h
   yFqbt2AcUCaedTE8rbcd0BuohgkiZn4tXUEQWc6Mqc2SUEXJffAMAwfxq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="383703175"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="383703175"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 22:26:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="704022944"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="704022944"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2023 22:26:21 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqoDC-0003Dl-1h;
        Thu, 12 Oct 2023 05:26:18 +0000
Date:   Thu, 12 Oct 2023 13:25:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V3 03/16] platform/x86/intel/vsec: Use cleanup.h
Message-ID: <202310121314.3Xpqom2w-lkp@intel.com>
References: <20231012023840.3845703-4-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012023840.3845703-4-david.e.box@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on acce85a7dd28eac3858d44230f4c65985d0f271c]

url:    https://github.com/intel-lab-lkp/linux/commits/David-E-Box/platform-x86-intel-vsec-Move-structures-to-header/20231012-104217
base:   acce85a7dd28eac3858d44230f4c65985d0f271c
patch link:    https://lore.kernel.org/r/20231012023840.3845703-4-david.e.box%40linux.intel.com
patch subject: [PATCH V3 03/16] platform/x86/intel/vsec: Use cleanup.h
reproduce: (https://download.01.org/0day-ci/archive/20231012/202310121314.3Xpqom2w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310121314.3Xpqom2w-lkp@intel.com/

# many are suggestions rather than must-fix

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#31: FILE: drivers/platform/x86/intel/vsec.c:159:
+	struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
 	                                       ^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
