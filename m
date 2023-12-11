Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEE780DF77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjLKX1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjLKX1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:27:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0956ACD;
        Mon, 11 Dec 2023 15:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702337245; x=1733873245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DdRXcLF5La/fFvm5gRAwmGzIOBnpwPil+HPUgFmjR5I=;
  b=PC5Az13b+2i7NFtsUEWn7zis7XeOiwjcGXpeP0/FwQxf+WgZ1KntbVhH
   o9GY7ICqAw3m7b/cfGpc5hT/ArP1IlxS0KDXEF00z6Tjq7xSE5iakfvHc
   rwGtvQYOSb6OB0aMCNMwcep3u06nT2Kg4C1A4VjELtotBmVDMB3EAIT7J
   qCqe75W28k5pt0IuAFMvuWI2MwRaAsIoQb1Ux4HwF5nRQoNwuiArf2fqD
   d1zTUuoZxCcwH+UGfV/1nFpAVD4d5Y/A8JsguGgz3wr0yQGjusSS8bjdN
   3U+bCMmkNjvoCzVgjwsHM7f6kwQGTSdWtc1FpNuwxmOBtX22Nacjq8eKH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="391898878"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="391898878"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 15:27:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="776850510"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="776850510"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 11 Dec 2023 15:27:22 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCpgG-000IZD-12;
        Mon, 11 Dec 2023 23:27:20 +0000
Date:   Tue, 12 Dec 2023 07:27:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs: sphinx/requirement.txt: Reflect recommended Sphinx
 version
Message-ID: <202312120740.HxQGwUoL-lkp@intel.com>
References: <50830030-dca7-4c43-bcc8-449c7cfa9fbb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50830030-dca7-4c43-bcc8-449c7cfa9fbb@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akira,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on linus/master v6.7-rc5 next-20231211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Akira-Yokosawa/docs-sphinx-requirement-txt-Reflect-recommended-Sphinx-version/20231210-074628
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/50830030-dca7-4c43-bcc8-449c7cfa9fbb%40gmail.com
patch subject: [PATCH] docs: sphinx/requirement.txt: Reflect recommended Sphinx version
reproduce: (https://download.01.org/0day-ci/archive/20231212/202312120740.HxQGwUoL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312120740.HxQGwUoL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/gpu/drm-kms:360: ./drivers/gpu/drm/drm_fourcc.c:344: WARNING: Duplicate C declaration, also defined at gpu/drm-kms:39.
>> Documentation/gpu/drm-kms:461: ./drivers/gpu/drm/drm_modeset_lock.c:392: WARNING: Duplicate C declaration, also defined at gpu/drm-kms:49.
>> Documentation/gpu/drm-uapi:434: ./drivers/gpu/drm/drm_ioctl.c:928: WARNING: Duplicate C declaration, also defined at gpu/drm-uapi:70.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
