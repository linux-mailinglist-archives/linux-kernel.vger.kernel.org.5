Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796277B3EB4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 08:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjI3GzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 02:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjI3GzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 02:55:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3131AB;
        Fri, 29 Sep 2023 23:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696056908; x=1727592908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Er6kX/bTXC9VVyFrZm9L0oiXqmRdHvt1nCQhC2rSbxU=;
  b=EVfuCe7DARqS9flWJqNVBGfVz6JtOgh+K07mYZa4RH+kP/ppjak2kjM3
   1hEwRPsWMuhJ+mE4y0r8MibsBVFmkvtk7lHa6avq7j2Gmy3ST0NAt6KTJ
   PBd5QcNl364JGrB+rXv2QY8TUZGdOVKELrDW0Pd6vHwfbVrXeis6X+5tf
   nn3huNSL0ssGlCjxq/qhxNZ93PBmGdySMfUjzHV47QT+lNSWXu9yJOkOi
   doER0Uc1x0QxNfmF/v09Y6V6kX2kgu8jmoY7bJcPnCstsiJYiA8GZsg61
   /kBwG3yisujU6JL01D1yjX4bNm1ZcjE/ovBlA8L9DdpIdXTFc6AcJG7LZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="4000752"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="4000752"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 23:55:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="1043767"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 29 Sep 2023 23:54:28 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmTsU-0003oJ-0W;
        Sat, 30 Sep 2023 06:55:02 +0000
Date:   Sat, 30 Sep 2023 14:54:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandra Diupina <adiupina@astralinux.ru>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Alexandra Diupina <adiupina@astralinux.ru>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Wolfram Sang <wsa-dev@sang-engineering.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] drm: rcar-du: turn rcar_du_group_get() into void and
 remove its return value check
Message-ID: <202309301402.uR7IRQVj-lkp@intel.com>
References: <20230927104438.30628-1-adiupina@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927104438.30628-1-adiupina@astralinux.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandra,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc3 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandra-Diupina/drm-rcar-du-turn-rcar_du_group_get-into-void-and-remove-its-return-value-check/20230927-184651
base:   linus/master
patch link:    https://lore.kernel.org/r/20230927104438.30628-1-adiupina%40astralinux.ru
patch subject: [PATCH v2] drm: rcar-du: turn rcar_du_group_get() into void and remove its return value check
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230930/202309301402.uR7IRQVj-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309301402.uR7IRQVj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309301402.uR7IRQVj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c:203:6: error: conflicting types for 'rcar_du_group_get'; have 'void(struct rcar_du_group *)'
     203 | void rcar_du_group_get(struct rcar_du_group *rgrp)
         |      ^~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.h:20,
                    from drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c:29:
   drivers/gpu/drm/renesas/rcar-du/rcar_du_group.h:57:5: note: previous declaration of 'rcar_du_group_get' with type 'int(struct rcar_du_group *)'
      57 | int rcar_du_group_get(struct rcar_du_group *rgrp);
         |     ^~~~~~~~~~~~~~~~~


vim +203 drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c

   194	
   195	/*
   196	 * rcar_du_group_get - Acquire a reference to the DU channels group
   197	 *
   198	 * Acquiring the first reference setups core registers. A reference must be held
   199	 * before accessing any hardware registers.
   200	 *
   201	 * This function must be called with the DRM mode_config lock held.
   202	 */
 > 203	void rcar_du_group_get(struct rcar_du_group *rgrp)
   204	{
   205		if (rgrp->use_count)
   206			goto done;
   207	
   208		rcar_du_group_setup(rgrp);
   209	
   210	done:
   211		rgrp->use_count++;
   212	}
   213	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
