Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5706C785805
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjHWMsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjHWMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:48:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6679DCD2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692794885; x=1724330885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CbXqawBEj7B2MEs7M6/kZuQALHKhJDp66dmB2oKp/CY=;
  b=Z9N8uUVrPfRDLdqCp/zMjwDamw3gyNN4JJ+xTxbz+cwbU+KwxmjwX97j
   IZ9sAsllEg0trsotdez9C/SQy8rjiLB1erTZ2EbeYO23QAdrLZ2FnaMq/
   5ilW1bKPltFd3QxvLAwpaAmkQ1tv1Fk8QBRUw5VvRGOjxJlSB5gyWqetq
   vxKzaxUaLGzG1zYHP4erCP+eFeBwmbkeqoGCLNP5Birwk6kctx+BEJStM
   8zPzNeaBA6h7XF45VO+wm/QGJRRrUWnlsZXxF4SS9diIFURJAxH9uTI8S
   OsbXaa03zHs/LiAo1yip6uvnL0eoUGi7XOucGJSr8vXHQqbIs4kWbacjw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="376875972"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="376875972"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 05:47:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="771707188"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="771707188"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 23 Aug 2023 05:47:04 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYnGJ-0001Cl-36;
        Wed, 23 Aug 2023 12:47:03 +0000
Date:   Wed, 23 Aug 2023 20:46:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, bskeggs@redhat.com, kherbst@redhat.com,
        lyude@redhat.com, faith.ekstrand@collabora.com
Cc:     oe-kbuild-all@lists.linux.dev, nouveau@lists.freedesktop.org,
        Danilo Krummrich <dakr@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next] drm/nouveau: uapi: don't pass NO_PREFETCH
 flag implicitly
Message-ID: <202308232030.0r1irPMu-lkp@intel.com>
References: <20230822234139.11185-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822234139.11185-1-dakr@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ad1367f831f8743746a1f49705c28e36a7c95525]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-nouveau-uapi-don-t-pass-NO_PREFETCH-flag-implicitly/20230823-074237
base:   ad1367f831f8743746a1f49705c28e36a7c95525
patch link:    https://lore.kernel.org/r/20230822234139.11185-1-dakr%40redhat.com
patch subject: [PATCH drm-misc-next] drm/nouveau: uapi: don't pass NO_PREFETCH flag implicitly
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308232030.0r1irPMu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308232030.0r1irPMu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ./include/uapi/drm/nouveau_drm.h:344: warning: Incorrect use of kernel-doc format:          * flags: the flags for this push buffer mapping
>> ./include/uapi/drm/nouveau_drm.h:348: warning: Function parameter or member 'flags' not described in 'drm_nouveau_exec_push'

vim +344 ./include/uapi/drm/nouveau_drm.h

   327	
   328	/**
   329	 * struct drm_nouveau_exec_push - EXEC push operation
   330	 *
   331	 * This structure represents a single EXEC push operation. UMDs should pass an
   332	 * array of this structure via struct drm_nouveau_exec's &push_ptr field.
   333	 */
   334	struct drm_nouveau_exec_push {
   335		/**
   336		 * @va: the virtual address of the push buffer mapping
   337		 */
   338		__u64 va;
   339		/**
   340		 * @va_len: the length of the push buffer mapping
   341		 */
   342		__u32 va_len;
   343		/**
 > 344		 * flags: the flags for this push buffer mapping
   345		 */
   346		__u32 flags;
   347	#define DRM_NOUVEAU_EXEC_PUSH_NO_PREFETCH 0x1
 > 348	};
   349	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
