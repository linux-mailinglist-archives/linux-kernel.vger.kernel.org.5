Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C697B4B82
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbjJBGei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjJBGeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:34:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7423BB4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696228474; x=1727764474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ohMoN0O13vl59/T1Y4daJDp+6LTZG589rbJO6FTJaDA=;
  b=MKveSzP+ihL2OpxamYMs8A+jHGhj+BuzK3T/2oOm3GxUGevaqwJhUog7
   VZ+3N6RR1AhV1IM8PswIRGC2T+zfWJWoIKaK3JtRsVTyJqWU24nXdayJz
   njRgpYE1ULPLjmUmtXNzEcxN4OsTUTH4ZB7fwWQm13yQ69BBTRcVkLmDr
   9sgpRvmKvrUBjBL46weAI4xkgBQjPE8p+g8cPRApLQXipOhi6pq7d2DWc
   HNYvAqkmC1uskqv0LDwe7wnS/PXA+xjS+/kHiG0c1B+EIjEtuaYZGNu4D
   +EBrunBGYClR/WmU0slMmvZGkU6A2CR1zMcjAtc0RBp2iJAXz7EeovXaB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="468868669"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="468868669"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 23:34:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="840902494"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="840902494"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2023 23:34:30 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnCVg-0005p5-24;
        Mon, 02 Oct 2023 06:34:28 +0000
Date:   Mon, 2 Oct 2023 14:34:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     oe-kbuild-all@lists.linux.dev, nouveau@lists.freedesktop.org,
        Danilo Krummrich <dakr@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v5 3/6] drm/gpuvm: add an abstraction for a
 VM / BO combination
Message-ID: <202310021416.3jqeZtQG-lkp@intel.com>
References: <20230928191624.13703-4-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928191624.13703-4-dakr@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a4ead6e37e3290cff399e2598d75e98777b69b37]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-gpuvm-add-common-dma-resv-per-struct-drm_gpuvm/20230929-031831
base:   a4ead6e37e3290cff399e2598d75e98777b69b37
patch link:    https://lore.kernel.org/r/20230928191624.13703-4-dakr%40redhat.com
patch subject: [PATCH drm-misc-next v5 3/6] drm/gpuvm: add an abstraction for a VM / BO combination
reproduce: (https://download.01.org/0day-ci/archive/20231002/202310021416.3jqeZtQG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310021416.3jqeZtQG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ./include/drm/drm_gpuvm.h:464: warning: Function parameter or member 'vm' not described in 'drm_gpuvm_bo'

vim +464 ./include/drm/drm_gpuvm.h

   427	
   428		/**
   429		 * @gpuvm: The &drm_gpuvm the @obj is mapped in.
   430		 */
   431		struct drm_gpuvm *vm;
   432	
   433		/**
   434		 * @obj: The &drm_gem_object being mapped in the @gpuvm.
   435		 */
   436		struct drm_gem_object *obj;
   437	
   438		/**
   439		 * @kref: The reference count for this &drm_gpuvm_bo.
   440		 */
   441		struct kref kref;
   442	
   443		/**
   444		 * @list: Structure containing all &list_heads.
   445		 */
   446		struct {
   447			/**
   448			 * @gpuva: The list of linked &drm_gpuvas.
   449			 */
   450			struct list_head gpuva;
   451	
   452			/**
   453			 * @entry: Structure containing all &list_heads serving as
   454			 * entry.
   455			 */
   456			struct {
   457				/**
   458				 * @gem: List entry to attach to the &drm_gem_objects
   459				 * gpuva list.
   460				 */
   461				struct list_head gem;
   462			} entry;
   463		} list;
 > 464	};
   465	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
