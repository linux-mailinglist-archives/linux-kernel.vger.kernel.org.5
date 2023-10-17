Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A4C7CC789
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbjJQPdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQPc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:32:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDCC92;
        Tue, 17 Oct 2023 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697556775; x=1729092775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=srDxnBNHRQaODgGyHHLg4Ca0cHzUY3CP2XKcDBmpcHc=;
  b=OWvhNy53pT85u6JVSF17QosaXtyj5s028R+sR+qddlJdr14C1P4BKdsQ
   XCzbOOpHnIrA5XtzLVqArgQgd8UWezWfBTu4td8XmikP7WR1MguCwcNzO
   alAQXzVaJ5uu1Q+rSO2fS/B7zM+SpP4lvpcgDGGuAVSXBr7BnZEruTl2q
   Of/9E0k50VzCJK3APcwZa6Kxtb0vIo56yEoouuPVof5YVY/CqER7wkr+J
   nmH0jgO9Z3W8NS76RGIAUNfpc6iba/J4HSDCHzANywRj9iRXsf4cJ7JSz
   FLbaWScmpksnA4gh/aYEzKrIsRfhhYxrxKL6swm4kuXcIH0MZFtTOuxYg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="7367433"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="7367433"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 08:32:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1003396513"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="1003396513"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Oct 2023 08:32:37 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsm3f-0009kB-1w;
        Tue, 17 Oct 2023 15:32:35 +0000
Date:   Tue, 17 Oct 2023 23:31:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com, Wenchao Hao <haowenchao2@huawei.com>
Subject: Re: [PATCH v3 1/4] scsi: core: Add new helper to iterate all devices
 of host
Message-ID: <202310172345.jViTGPKD-lkp@intel.com>
References: <20231016020314.1269636-2-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016020314.1269636-2-haowenchao2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenchao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on jejb-scsi/for-next linus/master v6.6-rc6 next-20231017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wenchao-Hao/scsi-core-Add-new-helper-to-iterate-all-devices-of-host/20231017-140049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20231016020314.1269636-2-haowenchao2%40huawei.com
patch subject: [PATCH v3 1/4] scsi: core: Add new helper to iterate all devices of host
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310172345.jViTGPKD-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310172345.jViTGPKD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310172345.jViTGPKD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/scsi.c:767: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * helper for shost_for_each_device, see that for documentation


vim +767 drivers/scsi/scsi.c

   765	
   766	/**
 > 767	 * helper for shost_for_each_device, see that for documentation
   768	 * @skip_deleted: if true, sdev in progress of removing would be skipped
   769	 */
   770	struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *shost,
   771						   struct scsi_device *prev,
   772						   bool skip_deleted)
   773	{
   774		struct list_head *list = (prev ? &prev->siblings : &shost->__devices);
   775		struct scsi_device *next = NULL;
   776		unsigned long flags;
   777	
   778		spin_lock_irqsave(shost->host_lock, flags);
   779		while (list->next != &shost->__devices) {
   780			next = list_entry(list->next, struct scsi_device, siblings);
   781			/* skip devices that we can't get a reference to */
   782			if (!__scsi_device_get(next, skip_deleted))
   783				break;
   784			next = NULL;
   785			list = list->next;
   786		}
   787		spin_unlock_irqrestore(shost->host_lock, flags);
   788	
   789		if (prev)
   790			scsi_device_put(prev);
   791		return next;
   792	}
   793	EXPORT_SYMBOL(__scsi_iterate_devices);
   794	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
