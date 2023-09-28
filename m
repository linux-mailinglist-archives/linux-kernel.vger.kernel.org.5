Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F57A7B1B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjI1LmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjI1LmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:42:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D7D136;
        Thu, 28 Sep 2023 04:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695901332; x=1727437332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fDPIHLcRgZN0dV5cFxZPZ18rZu5WNafEq2ZC+1rL2N0=;
  b=VK9JSNLAWMr4Js8yikCInHbozYzUBzBJo3sNJoIk9sq3ly7PNITOKO8c
   y0fwVGlBKkb/LnDADy9MrmBSHWNzeb0OCoxR/Iu5pPdk28ucnWZ7yJ0cO
   NSyWgFFqKaoa+oTB0sXAB/53oKNrJnMEH94dLbLi3uBDyD44b4qVvMGIz
   yE4vd/5DS7V4N0rBGDJsqbWXcjnWd95Lbl44XG8s+x1SomZ4k8hBKVJry
   WZB5LWUwjs3L6HvK7xdxEeNuA/FQ7djwnaWVHJypZLRAMmFBFfdewiUAf
   UX8u6xWJ7/GSGK1umIg1UjMAv0tpgYZd4Vury++J3xHEfykjlA5zSU0mq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="372396041"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="372396041"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 04:42:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="815195646"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="815195646"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 28 Sep 2023 04:42:08 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlpPC-0001PK-26;
        Thu, 28 Sep 2023 11:42:06 +0000
Date:   Thu, 28 Sep 2023 19:41:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com, Wenchao Hao <haowenchao2@huawei.com>
Subject: Re: [PATCH v2 1/4] scsi: core: Add new helper to iterate all devices
 of host
Message-ID: <202309281916.qy89onYp-lkp@intel.com>
References: <20230928073543.3496394-2-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928073543.3496394-2-haowenchao2@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenchao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on jejb-scsi/for-next linus/master v6.6-rc3 next-20230928]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wenchao-Hao/scsi-core-Add-new-helper-to-iterate-all-devices-of-host/20230928-153648
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230928073543.3496394-2-haowenchao2%40huawei.com
patch subject: [PATCH v2 1/4] scsi: core: Add new helper to iterate all devices of host
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230928/202309281916.qy89onYp-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230928/202309281916.qy89onYp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309281916.qy89onYp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/scsi.c:762: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * helper for shost_for_each_device, see that for documentation


vim +762 drivers/scsi/scsi.c

   760	
   761	/**
 > 762	 * helper for shost_for_each_device, see that for documentation
   763	 * @skip_deleted: if true, sdev in progress of removing would be skipped
   764	 */
   765	struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *shost,
   766						   struct scsi_device *prev,
   767						   bool skip_deleted)
   768	{
   769		struct list_head *list = (prev ? &prev->siblings : &shost->__devices);
   770		struct scsi_device *next = NULL;
   771		unsigned long flags;
   772	
   773		spin_lock_irqsave(shost->host_lock, flags);
   774		while (list->next != &shost->__devices) {
   775			next = list_entry(list->next, struct scsi_device, siblings);
   776			/* skip devices that we can't get a reference to */
   777			if (!__scsi_device_get(next, skip_deleted))
   778				break;
   779			next = NULL;
   780			list = list->next;
   781		}
   782		spin_unlock_irqrestore(shost->host_lock, flags);
   783	
   784		if (prev)
   785			scsi_device_put(prev);
   786		return next;
   787	}
   788	EXPORT_SYMBOL(__scsi_iterate_devices);
   789	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
