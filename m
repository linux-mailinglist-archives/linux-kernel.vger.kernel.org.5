Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284F079FBDC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbjING0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjING0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:26:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F78BF7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694672778; x=1726208778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ncX/3ojufQFnWpGsuTFsyqcxHO1fpWiWL7gR6yynDb4=;
  b=LOJjpR99Ij3ZPAZHDKJj5CKyTf8ibkFzKFS4WzYOnSTjulSKvjmj5zI/
   +hHfzyNqT5GRc2idA1w6AGj5eCPOt0JxyJ9ZFTw9M4mfpYeqV7dIm2+6Z
   quuGwZr4SMMihcaDUzkPEroik8mwi+acE5hras2QvngjkhFWoQe95s2GD
   UI3ObErjX3GkDh1f54Do9+3cycncE7nYMOLGJ8OhO+D6/QWf4DSnniVWr
   7Rj+fKXibYeUyO1mTkqdN7/ZHSCXn9CVSjM9Ge4iSHIQK7Q8HlC1exN6f
   K6d7OsLfUoPFWkRhFulXshRiw0jmW1bOiacrMRo1cqz60Dw6cu1AzeAN8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="442897809"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="442897809"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 23:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="918130824"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="918130824"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Sep 2023 23:26:15 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgfno-0001Fx-2a;
        Thu, 14 Sep 2023 06:26:12 +0000
Date:   Thu, 14 Sep 2023 14:25:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tanjore Suresh <tansuresh@google.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Daniel Wagner <dwagner@suse.de>,
        Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc:     oe-kbuild-all@lists.linux.dev,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v2] driver core: shut down devices asynchronously
Message-ID: <202309141407.CpZtIa2w-lkp@intel.com>
References: <20230913210516.3545-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913210516.3545-1-stuart.w.hayes@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stuart,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.6-rc1 next-20230913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stuart-Hayes/driver-core-shut-down-devices-asynchronously/20230914-050611
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20230913210516.3545-1-stuart.w.hayes%40gmail.com
patch subject: [PATCH v2] driver core: shut down devices asynchronously
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230914/202309141407.CpZtIa2w-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309141407.CpZtIa2w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309141407.CpZtIa2w-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/base/core.c:68: warning: Function parameter or member 'flags' not described in '__fwnode_link_add'
>> drivers/base/core.c:4771: warning: Function parameter or member 'dev' not described in 'shutdown_device_and_children'
>> drivers/base/core.c:4771: warning: Function parameter or member 'data' not described in 'shutdown_device_and_children'
>> drivers/base/core.c:4771: warning: expecting prototype for device_shutdown_async(). Prototype was for shutdown_device_and_children() instead


vim +4771 drivers/base/core.c

  4764	
  4765	/**
  4766	 * device_shutdown_async - schedule ->shutdown() on each device to shutdown
  4767	 * asynchronously, ensuring each device's children are shut down before
  4768	 * shutting down the device
  4769	 */
  4770	static int shutdown_device_and_children(struct device *dev, void *data)
> 4771	{
  4772		struct async_domain *domain = data;
  4773		struct device_private *p = dev->p;
  4774	
  4775		INIT_ASYNC_DOMAIN_EXCLUSIVE(&p->children_shutdown);
  4776	
  4777		/* make sure device doesn't go away before it is shut down */
  4778		get_device(dev);
  4779	
  4780		/* schedule shutdown of children */
  4781		device_for_each_child(dev, &p->children_shutdown,
  4782				      shutdown_device_and_children);
  4783	
  4784		/* schedule shutdown of this device */
  4785		async_schedule_domain(shutdown_device, dev, domain);
  4786	
  4787		return 0;
  4788	}
  4789	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
