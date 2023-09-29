Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD167B30A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjI2KfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjI2Kep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:34:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8956410D8;
        Fri, 29 Sep 2023 03:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695983575; x=1727519575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJL8ueWuCjgHjD1foN++iV6srjQt5o/jr0dESBTCY6U=;
  b=QZGsTkJyDQPOSSP2KZyERZvSmombqfw7mKzMnIbNs9Fy/ruHagfUxZXz
   a+33yBzLXHtFmyx7W04C1A9Zb4RF558dQZx60lhUn3Lri2Ulczb31PEvX
   lxPpRuVfDRlAnS9z//b/c081M+4FsbzDN3PIR42EZQZ5gonSsVft2sem1
   8b7a5hgNKc03Jf5D66ffL0G004tnmpJrZwQJL6PSB4vwq666D6Yt/NiAH
   KEQ0BNyDwj4qH06VLJq2M1wZCVSvnmz7npYuv/Q8SJAdqJQu9yFd21jrK
   pOZubRE7HQyNEUC/3kjlqf3iVrzegiNwhMHhJ++Sn46/s2FnxITa/PK5c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="386135525"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="386135525"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 03:31:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="820177722"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="820177722"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Sep 2023 03:31:00 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmAlt-0002k1-2z;
        Fri, 29 Sep 2023 10:30:57 +0000
Date:   Fri, 29 Sep 2023 18:30:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH] docs: update link to powerpc/vmemmap_dedup.rst
Message-ID: <202309291832.6j4oF2eE-lkp@intel.com>
References: <20230927164319.2686237-1-costa.shul@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927164319.2686237-1-costa.shul@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Costa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on linus/master v6.6-rc3 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Costa-Shulyupin/docs-update-link-to-powerpc-vmemmap_dedup-rst/20230928-004508
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/20230927164319.2686237-1-costa.shul%40redhat.com
patch subject: [PATCH] docs: update link to powerpc/vmemmap_dedup.rst
reproduce: (https://download.01.org/0day-ci/archive/20230929/202309291832.6j4oF2eE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309291832.6j4oF2eE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: Documentation/mm/vmemmap_dedup.rst references a file that doesn't exist: Documentation/arch/powerpc/vmemmap_dedup.rst

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
