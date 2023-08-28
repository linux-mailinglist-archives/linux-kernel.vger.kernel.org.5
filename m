Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C61E78B114
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjH1Mw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjH1Mwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:52:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA82107;
        Mon, 28 Aug 2023 05:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693227147; x=1724763147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=63cN16He7oU1cpUOTTDNru9E4nWgxrEdWbwOQMyKlZ0=;
  b=KXN8QtfMx+at/9PMPQdeuMAjAJkmK8d4BWtuPuBiToL5KG+JxcFSFSFC
   WRFARnlVF4vaFF7+jdMW26VrJVztuqi61xrai2eUJqKq7lLcjDwZpmgBt
   e7c6h4jY0A+s5ezF3IpDAqoaa0Oj/kYu4QEyVnTYoUwGOlUHrLaexwneo
   ca1B1DuXNamkxCzOorriMxD21upf0ctDl3TS5m7FwTPeUWsqF5RJybOHk
   D+2Sq60d6bimjpmYhtwhSUaJd50lnQle5iB4FxKJLJwznbkOAfQrbaysS
   Dx/XWlXBbXHYDfiDVlzAtU5mZaXsKpVZingwDmqbM7QDrtmUh8HlCVXRm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="439038877"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="439038877"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 05:52:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="912044321"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="912044321"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 28 Aug 2023 05:52:22 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qabj4-0007sp-1l;
        Mon, 28 Aug 2023 12:52:16 +0000
Date:   Mon, 28 Aug 2023 20:52:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brandon Pollack <brpol@chromium.org>, marius.vlad@collabora.com,
        mairacanal@riseup.net, jshargo@chromium.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        hamohammed.sa@gmail.com, rodrigosiqueiramelo@gmail.com,
        linux-doc@vger.kernel.org, hirono@chromium.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        melissa.srw@gmail.com, mduggan@chromium.org, mripard@kernel.org,
        tzimmermann@suse.de, Brandon Pollack <brpol@chromium.org>
Subject: Re: [PATCH v5 5/7] drm/vkms: Support enabling ConfigFS devices
Message-ID: <202308282031.pHgZz2pY-lkp@intel.com>
References: <20230828081929.3574228-6-brpol@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828081929.3574228-6-brpol@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brandon,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on next-20230828]
[cannot apply to linus/master v6.5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Brandon-Pollack/drm-vkms-Back-VKMS-with-DRM-memory-management-instead-of-static-objects/20230828-162136
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230828081929.3574228-6-brpol%40chromium.org
patch subject: [PATCH v5 5/7] drm/vkms: Support enabling ConfigFS devices
config: x86_64-randconfig-r015-20230828 (https://download.01.org/0day-ci/archive/20230828/202308282031.pHgZz2pY-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230828/202308282031.pHgZz2pY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308282031.pHgZz2pY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/vkms/vkms_output.c:180: warning: Function parameter or member 'vkmsdev' not described in 'validate_vkms_configfs_no_dangling_objects'


vim +180 drivers/gpu/drm/vkms/vkms_output.c

   166	
   167	/**
   168	* validate_vkms_configfs_no_dangling_objects - warn on unused objects in vkms
   169	* configfs.
   170	* @vkmsdev vkms device
   171	*
   172	* This gives slightly more visible warning messaging to the user before the drm
   173	* system finds the configuration invalid and prints it's debug information.  In
   174	* this case the user may have accidentally not included some links, or the user
   175	* could be testing this faulty configuration.
   176	*
   177	*/
   178	static void
   179	validate_vkms_configfs_no_dangling_objects(struct vkms_device *vkmsdev)
 > 180	{
   181		struct vkms_configfs *configfs = vkmsdev->configfs;
   182		struct config_item *item;
   183	
   184		// 1. Planes
   185		list_for_each_entry(item, &configfs->planes_group.cg_children,
   186				    ci_entry) {
   187			struct vkms_config_plane *config_plane =
   188				item_to_config_plane(item);
   189			if (config_plane->possible_crtcs.linked_object_bitmap == 0)
   190				DRM_WARN(
   191					"Vkms configfs created plane %s has no linked crtcs",
   192					item->ci_name);
   193		}
   194	
   195		// 2. connectors
   196		list_for_each_entry(item, &configfs->connectors_group.cg_children,
   197				    ci_entry) {
   198			struct vkms_config_connector *config_connector =
   199				item_to_config_connector(item);
   200			if (config_connector->possible_encoders.linked_object_bitmap ==
   201			    0) {
   202				DRM_WARN(
   203					"Vkms configfs created connector %s has no linked encoders",
   204					item->ci_name);
   205			}
   206		}
   207	
   208		// 3. encoders
   209		list_for_each_entry(item, &configfs->encoders_group.cg_children,
   210				    ci_entry) {
   211			struct vkms_config_encoder *config_encoder =
   212				item_to_config_encoder(item);
   213			if (config_encoder->possible_crtcs.linked_object_bitmap == 0) {
   214				DRM_WARN(
   215					"Vkms configfs created encoder %s has no linked crtcs",
   216					item->ci_name);
   217			}
   218		}
   219	
   220		// 4. crtcs only require a primary plane to function, this is checked during
   221		// output initialization and returns an error.
   222	}
   223	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
