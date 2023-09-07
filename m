Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B516679767F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbjIGQLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbjIGQKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:10:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6753B86A6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694102793; x=1725638793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IH5/4Cd8kYqQbuTllI6IJ4teSuxYjc+p/Ds4/npYdFU=;
  b=TeZqPCoNJn3s/VcFayllanNFeUObxzbzFJeop2ECKpkiEjlKAFxRGvJ7
   LEB05kXXSDuDiePrfQWqaC+1QeWwVHhIYLdJe/3TUF0rbpemqSUNwHQgw
   OkBC+88SdCi+pEnr+ogouCV0oLmt1mN+gnV0qdV+1LZT/SYThvfLMQ2m3
   fX651J558lwBo1xi7tpOssD7cmG45dRJMACXmcDSTOT/rB8lo/evtBjNK
   vCBgQg/N2QPuqUbN13Hk8Qfa3v3koaFmj1A3F8oPATMWoVH884nbqYmRI
   LqBybgnTNx9nKaOPbWi+RSEjaWRRTurazVY5FIFvo77pAq8cXXUjUUJH7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="380013378"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="380013378"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 01:52:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="812059074"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="812059074"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Sep 2023 01:51:56 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeAjy-00013f-2R;
        Thu, 07 Sep 2023 08:51:54 +0000
Date:   Thu, 7 Sep 2023 16:51:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
Cc:     oe-kbuild-all@lists.linux.dev, nouveau@lists.freedesktop.org,
        Danilo Krummrich <dakr@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v2 2/7] drm/gpuvm: rename struct
 drm_gpuva_manager to struct drm_gpuvm
Message-ID: <202309071613.s6ztMEyU-lkp@intel.com>
References: <20230906214723.4393-3-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906214723.4393-3-dakr@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6bd3d8da51ca1ec97c724016466606aec7739b9f]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-gpuva_mgr-allow-building-as-module/20230907-054931
base:   6bd3d8da51ca1ec97c724016466606aec7739b9f
patch link:    https://lore.kernel.org/r/20230906214723.4393-3-dakr%40redhat.com
patch subject: [PATCH drm-misc-next v2 2/7] drm/gpuvm: rename struct drm_gpuva_manager to struct drm_gpuvm
reproduce: (https://download.01.org/0day-ci/archive/20230907/202309071613.s6ztMEyU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309071613.s6ztMEyU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ./include/drm/drm_gpuva_mgr.h:138: warning: Function parameter or member 'vm' not described in 'drm_gpuva'

vim +138 ./include/drm/drm_gpuva_mgr.h

e6303f323b1ad9 Danilo Krummrich 2023-07-20   60  
e6303f323b1ad9 Danilo Krummrich 2023-07-20   61  /**
e6303f323b1ad9 Danilo Krummrich 2023-07-20   62   * struct drm_gpuva - structure to track a GPU VA mapping
e6303f323b1ad9 Danilo Krummrich 2023-07-20   63   *
e6303f323b1ad9 Danilo Krummrich 2023-07-20   64   * This structure represents a GPU VA mapping and is associated with a
3142f8b7e68331 Danilo Krummrich 2023-09-06   65   * &drm_gpuvm.
e6303f323b1ad9 Danilo Krummrich 2023-07-20   66   *
e6303f323b1ad9 Danilo Krummrich 2023-07-20   67   * Typically, this structure is embedded in bigger driver structures.
e6303f323b1ad9 Danilo Krummrich 2023-07-20   68   */
e6303f323b1ad9 Danilo Krummrich 2023-07-20   69  struct drm_gpuva {
e6303f323b1ad9 Danilo Krummrich 2023-07-20   70  	/**
3142f8b7e68331 Danilo Krummrich 2023-09-06   71  	 * @gpuvm: the &drm_gpuvm this object is associated with
e6303f323b1ad9 Danilo Krummrich 2023-07-20   72  	 */
3142f8b7e68331 Danilo Krummrich 2023-09-06   73  	struct drm_gpuvm *vm;
e6303f323b1ad9 Danilo Krummrich 2023-07-20   74  
e6303f323b1ad9 Danilo Krummrich 2023-07-20   75  	/**
e6303f323b1ad9 Danilo Krummrich 2023-07-20   76  	 * @flags: the &drm_gpuva_flags for this mapping
e6303f323b1ad9 Danilo Krummrich 2023-07-20   77  	 */
e6303f323b1ad9 Danilo Krummrich 2023-07-20   78  	enum drm_gpuva_flags flags;
e6303f323b1ad9 Danilo Krummrich 2023-07-20   79  
e6303f323b1ad9 Danilo Krummrich 2023-07-20   80  	/**
e6303f323b1ad9 Danilo Krummrich 2023-07-20   81  	 * @va: structure containing the address and range of the &drm_gpuva
e6303f323b1ad9 Danilo Krummrich 2023-07-20   82  	 */
e6303f323b1ad9 Danilo Krummrich 2023-07-20   83  	struct {
e6303f323b1ad9 Danilo Krummrich 2023-07-20   84  		/**
e6303f323b1ad9 Danilo Krummrich 2023-07-20   85  		 * @addr: the start address
e6303f323b1ad9 Danilo Krummrich 2023-07-20   86  		 */
e6303f323b1ad9 Danilo Krummrich 2023-07-20   87  		u64 addr;
e6303f323b1ad9 Danilo Krummrich 2023-07-20   88  
e6303f323b1ad9 Danilo Krummrich 2023-07-20   89  		/*
e6303f323b1ad9 Danilo Krummrich 2023-07-20   90  		 * @range: the range
e6303f323b1ad9 Danilo Krummrich 2023-07-20   91  		 */
e6303f323b1ad9 Danilo Krummrich 2023-07-20   92  		u64 range;
e6303f323b1ad9 Danilo Krummrich 2023-07-20   93  	} va;
e6303f323b1ad9 Danilo Krummrich 2023-07-20   94  
e6303f323b1ad9 Danilo Krummrich 2023-07-20   95  	/**
e6303f323b1ad9 Danilo Krummrich 2023-07-20   96  	 * @gem: structure containing the &drm_gem_object and it's offset
e6303f323b1ad9 Danilo Krummrich 2023-07-20   97  	 */
e6303f323b1ad9 Danilo Krummrich 2023-07-20   98  	struct {
e6303f323b1ad9 Danilo Krummrich 2023-07-20   99  		/**
e6303f323b1ad9 Danilo Krummrich 2023-07-20  100  		 * @offset: the offset within the &drm_gem_object
e6303f323b1ad9 Danilo Krummrich 2023-07-20  101  		 */
e6303f323b1ad9 Danilo Krummrich 2023-07-20  102  		u64 offset;
e6303f323b1ad9 Danilo Krummrich 2023-07-20  103  
e6303f323b1ad9 Danilo Krummrich 2023-07-20  104  		/**
e6303f323b1ad9 Danilo Krummrich 2023-07-20  105  		 * @obj: the mapped &drm_gem_object
e6303f323b1ad9 Danilo Krummrich 2023-07-20  106  		 */
e6303f323b1ad9 Danilo Krummrich 2023-07-20  107  		struct drm_gem_object *obj;
e6303f323b1ad9 Danilo Krummrich 2023-07-20  108  
e6303f323b1ad9 Danilo Krummrich 2023-07-20  109  		/**
e6303f323b1ad9 Danilo Krummrich 2023-07-20  110  		 * @entry: the &list_head to attach this object to a &drm_gem_object
e6303f323b1ad9 Danilo Krummrich 2023-07-20  111  		 */
e6303f323b1ad9 Danilo Krummrich 2023-07-20  112  		struct list_head entry;
e6303f323b1ad9 Danilo Krummrich 2023-07-20  113  	} gem;
e6303f323b1ad9 Danilo Krummrich 2023-07-20  114  
e6303f323b1ad9 Danilo Krummrich 2023-07-20  115  	/**
e6303f323b1ad9 Danilo Krummrich 2023-07-20  116  	 * @rb: structure containing data to store &drm_gpuvas in a rb-tree
e6303f323b1ad9 Danilo Krummrich 2023-07-20  117  	 */
e6303f323b1ad9 Danilo Krummrich 2023-07-20  118  	struct {
e6303f323b1ad9 Danilo Krummrich 2023-07-20  119  		/**
e6303f323b1ad9 Danilo Krummrich 2023-07-20  120  		 * @rb: the rb-tree node
e6303f323b1ad9 Danilo Krummrich 2023-07-20  121  		 */
e6303f323b1ad9 Danilo Krummrich 2023-07-20  122  		struct rb_node node;
e6303f323b1ad9 Danilo Krummrich 2023-07-20  123  
e6303f323b1ad9 Danilo Krummrich 2023-07-20  124  		/**
e6303f323b1ad9 Danilo Krummrich 2023-07-20  125  		 * @entry: The &list_head to additionally connect &drm_gpuvas
e6303f323b1ad9 Danilo Krummrich 2023-07-20  126  		 * in the same order they appear in the interval tree. This is
e6303f323b1ad9 Danilo Krummrich 2023-07-20  127  		 * useful to keep iterating &drm_gpuvas from a start node found
e6303f323b1ad9 Danilo Krummrich 2023-07-20  128  		 * through the rb-tree while doing modifications on the rb-tree
e6303f323b1ad9 Danilo Krummrich 2023-07-20  129  		 * itself.
e6303f323b1ad9 Danilo Krummrich 2023-07-20  130  		 */
e6303f323b1ad9 Danilo Krummrich 2023-07-20  131  		struct list_head entry;
e6303f323b1ad9 Danilo Krummrich 2023-07-20  132  
e6303f323b1ad9 Danilo Krummrich 2023-07-20  133  		/**
e6303f323b1ad9 Danilo Krummrich 2023-07-20  134  		 * @__subtree_last: needed by the interval tree, holding last-in-subtree
e6303f323b1ad9 Danilo Krummrich 2023-07-20  135  		 */
e6303f323b1ad9 Danilo Krummrich 2023-07-20  136  		u64 __subtree_last;
e6303f323b1ad9 Danilo Krummrich 2023-07-20  137  	} rb;
e6303f323b1ad9 Danilo Krummrich 2023-07-20 @138  };
e6303f323b1ad9 Danilo Krummrich 2023-07-20  139  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
