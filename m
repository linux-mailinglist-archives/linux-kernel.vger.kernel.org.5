Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395157BC0DE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjJFVDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjJFVDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:03:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE140BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696626215; x=1728162215;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q1QngG2jO9MT/T7RrOarBCT5P84/egIQkYSkbYS960E=;
  b=QQbT5SmANjVrBoXfVjBQkHliJB0F1f9NDwNj1vQGK79lBlBI9I46oYYa
   urtBVWYe0/rNLJAy+nCugVpmMyjCpdsjCEBjHpW06/0A8yv7GQiN/o4rr
   raPjKrsmEn5LWj8d7Fyvn7Jibbi6xHUWPocWSAhow4JRCYcCxvjQ2Odpk
   aWCtRF2S54EfW07278bDl3aNyWnLV9aOFu2X5STvutyPk8iLY+IrVF/vT
   Q7vPKj88vjUQm3ULxIO50jesmFBf2eUtBQmotLj3SQCPGttdY2wr3Mjos
   VNbx53LJdQFsSEZtbasT7UmGOZUnp+5L0zAYNfQlBFHomZ9N/O5Gtp/vu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="382696570"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="382696570"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 14:03:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="926081568"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="926081568"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Oct 2023 14:03:32 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qorys-0003eT-2I;
        Fri, 06 Oct 2023 21:03:30 +0000
Date:   Sat, 7 Oct 2023 05:03:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: arch/x86/kernel/cpu/resctrl/rdtgroup.c:1196: warning: Function
 parameter or member 'type' not described in '__rdtgroup_cbm_overlaps'
Message-ID: <202310070434.mD8eRNAz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   af95dc6fdc25e616051d0234aad638e15c02ec8f
commit: fa8f711d2f14381d1a47420b6da94b62e6484c56 x86/resctrl: Pass configuration type to resctrl_arch_get_config()
date:   2 years, 2 months ago
config: x86_64-randconfig-003-20230909 (https://download.01.org/0day-ci/archive/20231007/202310070434.mD8eRNAz-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070434.mD8eRNAz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310070434.mD8eRNAz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/kernel/cpu/resctrl/rdtgroup.c:900: warning: Function parameter or member 'of' not described in 'rdt_bit_usage_show'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:900: warning: Function parameter or member 'seq' not described in 'rdt_bit_usage_show'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:900: warning: Function parameter or member 'v' not described in 'rdt_bit_usage_show'
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1196: warning: Function parameter or member 'type' not described in '__rdtgroup_cbm_overlaps'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1279: warning: Function parameter or member 'rdtgrp' not described in 'rdtgroup_mode_test_exclusive'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1315: warning: Function parameter or member 'of' not described in 'rdtgroup_mode_write'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1315: warning: Function parameter or member 'buf' not described in 'rdtgroup_mode_write'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1315: warning: Function parameter or member 'nbytes' not described in 'rdtgroup_mode_write'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1315: warning: Function parameter or member 'off' not described in 'rdtgroup_mode_write'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1424: warning: Function parameter or member 'of' not described in 'rdtgroup_size_show'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1424: warning: Function parameter or member 's' not described in 'rdtgroup_size_show'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1424: warning: Function parameter or member 'v' not described in 'rdtgroup_size_show'


vim +1196 arch/x86/kernel/cpu/resctrl/rdtgroup.c

521348b011d64c arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-10-03  1172  
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1173  /**
e5f3530c391105 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-10-03  1174   * __rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1175   * @r: Resource to which domain instance @d belongs.
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1176   * @d: The domain instance for which @closid is being tested.
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1177   * @cbm: Capacity bitmask being tested.
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1178   * @closid: Intended closid for @cbm.
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1179   * @exclusive: Only check if overlaps with exclusive resource groups
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1180   *
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1181   * Checks if provided @cbm intended to be used for @closid on domain
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1182   * @d overlaps with any other closids or other hardware usage associated
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1183   * with this domain. If @exclusive is true then only overlaps with
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1184   * resource groups in exclusive mode will be considered. If @exclusive
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1185   * is false then overlaps with any resource group or hardware entities
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1186   * will be considered.
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1187   *
49e00eee00612b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-10-04  1188   * @cbm is unsigned long, even if only 32 bits are used, to make the
49e00eee00612b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-10-04  1189   * bitmap functions work correctly.
49e00eee00612b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-10-04  1190   *
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1191   * Return: false if CBM does not overlap, true if it does.
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1192   */
e5f3530c391105 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-10-03  1193  static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
fa8f711d2f1438 arch/x86/kernel/cpu/resctrl/rdtgroup.c   James Morse     2021-07-28  1194  				    unsigned long cbm, int closid,
fa8f711d2f1438 arch/x86/kernel/cpu/resctrl/rdtgroup.c   James Morse     2021-07-28  1195  				    enum resctrl_conf_type type, bool exclusive)
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22 @1196  {
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1197  	enum rdtgrp_mode mode;
49e00eee00612b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-10-04  1198  	unsigned long ctrl_b;
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1199  	int i;
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1200  
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1201  	/* Check for any overlap with regions used by hardware directly */
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1202  	if (!exclusive) {
49e00eee00612b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-10-04  1203  		ctrl_b = r->cache.shareable_bits;
49e00eee00612b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-10-04  1204  		if (bitmap_intersects(&cbm, &ctrl_b, r->cache.cbm_len))
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1205  			return true;
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1206  	}
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1207  
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1208  	/* Check for overlap with other resource groups */
f07e9d0250577a arch/x86/kernel/cpu/resctrl/rdtgroup.c   James Morse     2021-07-28  1209  	for (i = 0; i < closids_supported(); i++) {
fa8f711d2f1438 arch/x86/kernel/cpu/resctrl/rdtgroup.c   James Morse     2021-07-28  1210  		resctrl_arch_get_config(r, d, i, type, (u32 *)&ctrl_b);
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1211  		mode = rdtgroup_mode_by_closid(i);
dfe9674b04ff6b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1212  		if (closid_allocated(i) && i != closid &&
dfe9674b04ff6b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1213  		    mode != RDT_MODE_PSEUDO_LOCKSETUP) {
49e00eee00612b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-10-04  1214  			if (bitmap_intersects(&cbm, &ctrl_b, r->cache.cbm_len)) {
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1215  				if (exclusive) {
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1216  					if (mode == RDT_MODE_EXCLUSIVE)
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1217  						return true;
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1218  					continue;
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1219  				}
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1220  				return true;
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1221  			}
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1222  		}
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1223  	}
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1224  
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1225  	return false;
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1226  }
49f7b4efa1101b arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  1227  

:::::: The code at line 1196 was first introduced by commit
:::::: 49f7b4efa1101bbc143a960eff3a9c8f9d6f7358 x86/intel_rdt: Enable setting of exclusive mode

:::::: TO: Reinette Chatre <reinette.chatre@intel.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
