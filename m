Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB307F3EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbjKVHUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbjKVHUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:20:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FEED4F;
        Tue, 21 Nov 2023 23:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700637595; x=1732173595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KvIjd3WcQUTAQZL0HXjLGHIwhv87e45Kod3du9RH8i4=;
  b=LUWY748kgBXpFbtJLpZdZLz2TANBeyYyNjIdKJVGxHr4KkQeSGUbWTTk
   gL+8hPT4V2Vc0TXxkr7Zf34AxdcsHESMJpj4CnSH4m9/NCY1Yx86IUide
   Cxhy04QvQgWlwmW1Diaez+BkjZvH3ZOQEYvG9zngH1JkVu8qgm5FseASA
   Ybuw8LSUYMcJaAaKgdDMM/MjxPirubiuiRRqMoWt0qW5Kr8lohYHtIMJ2
   i3tPlgS/Bn4i34F7OGpDIluj4Ac5pe8XFjZmCKlnSRIUIS2gzJJRNeDN6
   yXPMYn9aUWmBCWikcg4gnXvs069qomFP71lSW5VKc00rlsI0zB+nhKsP6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="371350507"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="371350507"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 23:19:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="795997236"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="795997236"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Nov 2023 23:19:46 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5hWR-0000Bf-2l;
        Wed, 22 Nov 2023 07:19:43 +0000
Date:   Wed, 22 Nov 2023 15:19:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        dan.j.williams@intel.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com,
        Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com,
        tony.luck@intel.com, Jon.Grimm@amd.com,
        dave.hansen@linux.intel.com, rafael@kernel.org, lenb@kernel.org,
        naoya.horiguchi@nec.com, james.morse@arm.com,
        jthoughton@google.com, somasundaram.a@hpe.com,
        erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
        mike.malvestuto@intel.com
Subject: Re: [PATCH v2 07/10] cxl/memscrub: Register CXL device patrol scrub
 with scrub configure driver
Message-ID: <202311221316.CqzLVodA-lkp@intel.com>
References: <20231121101844.1161-8-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121101844.1161-8-shiju.jose@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/cxl-mbox-Add-GET_SUPPORTED_FEATURES-mailbox-command/20231121-182247
base:   linus/master
patch link:    https://lore.kernel.org/r/20231121101844.1161-8-shiju.jose%40huawei.com
patch subject: [PATCH v2 07/10] cxl/memscrub: Register CXL device patrol scrub with scrub configure driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231122/202311221316.CqzLVodA-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311221316.CqzLVodA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311221316.CqzLVodA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/memscrub.c:330:9: warning: no previous prototype for function 'cxl_mem_patrol_scrub_is_visible' [-Wmissing-prototypes]
   umode_t cxl_mem_patrol_scrub_is_visible(const void *drv_data, u32 attr, int region_id)
           ^
   drivers/cxl/core/memscrub.c:330:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   umode_t cxl_mem_patrol_scrub_is_visible(const void *drv_data, u32 attr, int region_id)
   ^
   static 
>> drivers/cxl/core/memscrub.c:361:5: warning: no previous prototype for function 'cxl_mem_patrol_scrub_read' [-Wmissing-prototypes]
   int cxl_mem_patrol_scrub_read(struct device *dev, u32 attr, int region_id, u64 *val)
       ^
   drivers/cxl/core/memscrub.c:361:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int cxl_mem_patrol_scrub_read(struct device *dev, u32 attr, int region_id, u64 *val)
   ^
   static 
>> drivers/cxl/core/memscrub.c:381:5: warning: no previous prototype for function 'cxl_mem_patrol_scrub_write' [-Wmissing-prototypes]
   int cxl_mem_patrol_scrub_write(struct device *dev, u32 attr, int region_id, u64 val)
       ^
   drivers/cxl/core/memscrub.c:381:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int cxl_mem_patrol_scrub_write(struct device *dev, u32 attr, int region_id, u64 val)
   ^
   static 
>> drivers/cxl/core/memscrub.c:402:5: warning: no previous prototype for function 'cxl_mem_patrol_scrub_read_strings' [-Wmissing-prototypes]
   int cxl_mem_patrol_scrub_read_strings(struct device *dev, u32 attr, int region_id,
       ^
   drivers/cxl/core/memscrub.c:402:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int cxl_mem_patrol_scrub_read_strings(struct device *dev, u32 attr, int region_id,
   ^
   static 
   drivers/cxl/core/memscrub.c:584:12: warning: unused function 'cxl_mem_ecs_set_attrbs' [-Wunused-function]
   static int cxl_mem_ecs_set_attrbs(struct device *dev, int fru_id,
              ^
   5 warnings generated.


vim +/cxl_mem_patrol_scrub_is_visible +330 drivers/cxl/core/memscrub.c

   320	
   321	/**
   322	 * cxl_mem_patrol_scrub_is_visible() - Callback to return attribute visibility
   323	 * @drv_data: Pointer to driver-private data structure passed
   324	 *	      as argument to devm_scrub_device_register().
   325	 * @attr: Scrub attribute
   326	 * @region_id: ID of the memory region
   327	 *
   328	 * Returns: 0 on success, an error otherwise
   329	 */
 > 330	umode_t cxl_mem_patrol_scrub_is_visible(const void *drv_data, u32 attr, int region_id)
   331	{
   332		const struct cxl_patrol_scrub_context *cxl_ps_ctx = drv_data;
   333	
   334		if (attr == scrub_speed_available ||
   335		    attr == scrub_speed) {
   336			if (!cxl_ps_ctx->scrub_cycle_changable)
   337				return 0;
   338		}
   339	
   340		switch (attr) {
   341		case scrub_speed_available:
   342			return 0444;
   343		case scrub_enable:
   344			return 0200;
   345		case scrub_speed:
   346			return 0644;
   347		default:
   348			return 0;
   349		}
   350	}
   351	
   352	/**
   353	 * cxl_mem_patrol_scrub_read() - Read callback for data attributes
   354	 * @dev: Pointer to scrub device
   355	 * @attr: Scrub attribute
   356	 * @region_id: ID of the memory region
   357	 * @val: Pointer to the returned data
   358	 *
   359	 * Returns: 0 on success, an error otherwise
   360	 */
 > 361	int cxl_mem_patrol_scrub_read(struct device *dev, u32 attr, int region_id, u64 *val)
   362	{
   363	
   364		switch (attr) {
   365		case scrub_speed:
   366			return cxl_mem_ps_speed_read(dev->parent, val);
   367		default:
   368			return -ENOTSUPP;
   369		}
   370	}
   371	
   372	/**
   373	 * cxl_mem_patrol_scrub_write() - Write callback for data attributes
   374	 * @dev: Pointer to scrub device
   375	 * @attr: Scrub attribute
   376	 * @region_id: ID of the memory region
   377	 * @val: Value to write
   378	 *
   379	 * Returns: 0 on success, an error otherwise
   380	 */
 > 381	int cxl_mem_patrol_scrub_write(struct device *dev, u32 attr, int region_id, u64 val)
   382	{
   383		switch (attr) {
   384		case scrub_enable:
   385			return cxl_mem_ps_enable_write(dev->parent, val);
   386		case scrub_speed:
   387			return cxl_mem_ps_speed_write(dev->parent, val);
   388		default:
   389			return -ENOTSUPP;
   390		}
   391	}
   392	
   393	/**
   394	 * cxl_mem_patrol_scrub_read_strings() - Read callback for string attributes
   395	 * @dev: Pointer to scrub device
   396	 * @attr: Scrub attribute
   397	 * @region_id: ID of the memory region
   398	 * @buf: Pointer to the buffer for copying returned string
   399	 *
   400	 * Returns: 0 on success, an error otherwise
   401	 */
 > 402	int cxl_mem_patrol_scrub_read_strings(struct device *dev, u32 attr, int region_id,
   403					      char *buf)
   404	{
   405		switch (attr) {
   406		case scrub_speed_available:
   407			return cxl_mem_ps_speed_available_read(dev->parent, buf);
   408		default:
   409			return -ENOTSUPP;
   410		}
   411	}
   412	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
