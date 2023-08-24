Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1505B786D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbjHXLP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbjHXLP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:15:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B619A6;
        Thu, 24 Aug 2023 04:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692875711; x=1724411711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pn8EQw0NgUrSxiYsZQ7PcOdWCJRnfghJYSzf+L1Vvpo=;
  b=m20+y/u7QRa/ldc+OPt/p02XR1VQIQAaKpFj5N3JqbWl5w23MHjIfJ4D
   /8tVz/FHu0BNy567uiJjWDCEq81zYk2rlivDokRqcVmaifSIVLQxAPFdc
   0KiVBmqEgpkEgoMwqhopZ1Q9ztefKLocZet+hc5BwguPnKg8fDACJilms
   zDMwBbg6zFMCGtK5wtfvyirCVMgwy5pkKqfmPRVfRqGUmEkkHkpPD4XCm
   7O/UICc8i4F5lBN7cjRBveOdD1GsZ8TZ2re3ZuVtwAahHKtwJLp/idX3J
   T2hyvt9j+eMEZgnK974VPJWcAT8cSMB3+N/U4Dv5nBNBVuL35mhgMQDmH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="353949353"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="353949353"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 04:15:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="802502136"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="802502136"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 24 Aug 2023 04:15:06 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZ8In-0001yk-22;
        Thu, 24 Aug 2023 11:15:03 +0000
Date:   Thu, 24 Aug 2023 19:13:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brandon Pollack <brpol@chromium.org>, marius.vlad@collabora.com,
        jshargo@chromium.org
Cc:     oe-kbuild-all@lists.linux.dev, hamohammed.sa@gmail.com,
        rodrigosiqueiramelo@gmail.com, linux-doc@vger.kernel.org,
        hirono@chromium.org, mduggan@chromium.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        melissa.srw@gmail.com, mairacanal@riseup.net, mripard@kernel.org,
        tzimmermann@suse.de, Brandon Pollack <brpol@chromium.org>
Subject: Re: [PATCH v4 5/7] drm/vkms: Support enabling ConfigFS devices
Message-ID: <202308241907.YtPY7t8j-lkp@intel.com>
References: <20230824084350.1062579-6-brpol@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824084350.1062579-6-brpol@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brandon,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on next-20230824]
[cannot apply to linus/master v6.5-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Brandon-Pollack/drm-vkms-Back-VKMS-with-DRM-memory-management-instead-of-static-objects/20230824-164550
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230824084350.1062579-6-brpol%40chromium.org
patch subject: [PATCH v4 5/7] drm/vkms: Support enabling ConfigFS devices
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230824/202308241907.YtPY7t8j-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230824/202308241907.YtPY7t8j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308241907.YtPY7t8j-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/vkms/vkms_output.c:178: warning: Function parameter or member 'vkmsdev' not described in 'validate_vkms_configfs_no_dangling_objects'


vim +178 drivers/gpu/drm/vkms/vkms_output.c

   166	
   167	/**
   168	* validate_vkms_configfs_no_dangling_objects - warn on unused objects in vkms configfs.
   169	*
   170	* This gives slightly more visible warning messaging to the user before the drm
   171	* system finds the configuration invalid and prints it's debug information.  In
   172	* this case the user may have accidentally not included some links, or the user
   173	* could be testing this faulty configuration.
   174	*
   175	*/
   176	static void
   177	validate_vkms_configfs_no_dangling_objects(struct vkms_device *vkmsdev)
 > 178	{
   179		struct vkms_configfs *configfs = vkmsdev->configfs;
   180		struct config_item *item;
   181	
   182		// 1. Planes
   183		list_for_each_entry(item, &configfs->planes_group.cg_children,
   184				    ci_entry) {
   185			struct vkms_config_plane *config_plane =
   186				item_to_config_plane(item);
   187			if (config_plane->possible_crtcs.linked_object_bitmap == 0)
   188				DRM_WARN(
   189					"Vkms configfs created plane %s has no linked crtcs",
   190					item->ci_name);
   191		}
   192	
   193		// 2. connectors
   194		list_for_each_entry(item, &configfs->connectors_group.cg_children,
   195				    ci_entry) {
   196			struct vkms_config_connector *config_connector =
   197				item_to_config_connector(item);
   198			if (config_connector->possible_encoders.linked_object_bitmap ==
   199			    0) {
   200				DRM_WARN(
   201					"Vkms configfs created connector %s has no linked encoders",
   202					item->ci_name);
   203			}
   204		}
   205	
   206		// 3. encoders
   207		list_for_each_entry(item, &configfs->encoders_group.cg_children,
   208				    ci_entry) {
   209			struct vkms_config_encoder *config_encoder =
   210				item_to_config_encoder(item);
   211			if (config_encoder->possible_crtcs.linked_object_bitmap == 0) {
   212				DRM_WARN(
   213					"Vkms configfs created encoder %s has no linked crtcs",
   214					item->ci_name);
   215			}
   216		}
   217	
   218		// 4. crtcs only require a primary plane to function, this is checked during
   219		// output initialization and returns an error.
   220	}
   221	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
