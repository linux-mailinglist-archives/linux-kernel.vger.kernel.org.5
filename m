Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A0E78E51F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbjHaDoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjHaDoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:44:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8A0CD7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693453442; x=1724989442;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a0xEBQbm5pmi8Iittj2MMgKjRgZN4d5azjK0BwF2fXM=;
  b=JcirXwqWTb2+o0ROQ45+Bi6WvSjxOyXgtdCGzxp2YyK303yrclgu3Rq5
   wmSkIgKuPTx39fECJNzG4yCXrKbj7yC8+JVJfs11UmGsqI8qi3DpVtDmv
   DYIBQNw0TSWLZ5LEXHD59f5OuFoKYYAuRWvpkNMliH6Wtg31yNxOtgWLg
   LBTwO31g2ZZtyIe+Q/2DWVxO0QyNVdvUrY6DniHvqVHKkdgvMcsS7qaDk
   zzB8pGaseIZZxgm2Xyg8IgqoRCoaCJcTWbDnqR1ZZpOKI1NASTEa2RyYm
   pYVu36Y/WnphrUim0AQTO8RHYwJY8HPHPwKMbrcSPXeQyUMB1+6UM6uJm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="355300785"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="355300785"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 20:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="742472240"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="742472240"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 30 Aug 2023 20:44:00 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbYb9-000AYx-14;
        Thu, 31 Aug 2023 03:43:59 +0000
Date:   Thu, 31 Aug 2023 11:43:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Subject: fs/namespace.c:3039: warning: Function parameter or member 'mp' not
 described in 'can_move_mount_beneath'
Message-ID: <202308311134.I4o8LaaZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ef2a0b7cdbc5b84f7b3f6573b7687e72bede0964
commit: 6ac392815628f317fcfdca1a39df00b9cc4ebc8b fs: allow to mount beneath top mount
date:   3 months ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20230831/202308311134.I4o8LaaZ-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230831/202308311134.I4o8LaaZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308311134.I4o8LaaZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/namespace.c:3039: warning: Function parameter or member 'mp' not described in 'can_move_mount_beneath'


vim +3039 fs/namespace.c

  3015	
  3016	/**
  3017	 * can_move_mount_beneath - check that we can mount beneath the top mount
  3018	 * @from: mount to mount beneath
  3019	 * @to:   mount under which to mount
  3020	 *
  3021	 * - Make sure that @to->dentry is actually the root of a mount under
  3022	 *   which we can mount another mount.
  3023	 * - Make sure that nothing can be mounted beneath the caller's current
  3024	 *   root or the rootfs of the namespace.
  3025	 * - Make sure that the caller can unmount the topmost mount ensuring
  3026	 *   that the caller could reveal the underlying mountpoint.
  3027	 * - Ensure that nothing has been mounted on top of @from before we
  3028	 *   grabbed @namespace_sem to avoid creating pointless shadow mounts.
  3029	 * - Prevent mounting beneath a mount if the propagation relationship
  3030	 *   between the source mount, parent mount, and top mount would lead to
  3031	 *   nonsensical mount trees.
  3032	 *
  3033	 * Context: This function expects namespace_lock() to be held.
  3034	 * Return: On success 0, and on error a negative error code is returned.
  3035	 */
  3036	static int can_move_mount_beneath(const struct path *from,
  3037					  const struct path *to,
  3038					  const struct mountpoint *mp)
> 3039	{
  3040		struct mount *mnt_from = real_mount(from->mnt),
  3041			     *mnt_to = real_mount(to->mnt),
  3042			     *parent_mnt_to = mnt_to->mnt_parent;
  3043	
  3044		if (!mnt_has_parent(mnt_to))
  3045			return -EINVAL;
  3046	
  3047		if (!path_mounted(to))
  3048			return -EINVAL;
  3049	
  3050		if (IS_MNT_LOCKED(mnt_to))
  3051			return -EINVAL;
  3052	
  3053		/* Avoid creating shadow mounts during mount propagation. */
  3054		if (path_overmounted(from))
  3055			return -EINVAL;
  3056	
  3057		/*
  3058		 * Mounting beneath the rootfs only makes sense when the
  3059		 * semantics of pivot_root(".", ".") are used.
  3060		 */
  3061		if (&mnt_to->mnt == current->fs->root.mnt)
  3062			return -EINVAL;
  3063		if (parent_mnt_to == current->nsproxy->mnt_ns->root)
  3064			return -EINVAL;
  3065	
  3066		for (struct mount *p = mnt_from; mnt_has_parent(p); p = p->mnt_parent)
  3067			if (p == mnt_to)
  3068				return -EINVAL;
  3069	
  3070		/*
  3071		 * If the parent mount propagates to the child mount this would
  3072		 * mean mounting @mnt_from on @mnt_to->mnt_parent and then
  3073		 * propagating a copy @c of @mnt_from on top of @mnt_to. This
  3074		 * defeats the whole purpose of mounting beneath another mount.
  3075		 */
  3076		if (propagation_would_overmount(parent_mnt_to, mnt_to, mp))
  3077			return -EINVAL;
  3078	
  3079		/*
  3080		 * If @mnt_to->mnt_parent propagates to @mnt_from this would
  3081		 * mean propagating a copy @c of @mnt_from on top of @mnt_from.
  3082		 * Afterwards @mnt_from would be mounted on top of
  3083		 * @mnt_to->mnt_parent and @mnt_to would be unmounted from
  3084		 * @mnt->mnt_parent and remounted on @mnt_from. But since @c is
  3085		 * already mounted on @mnt_from, @mnt_to would ultimately be
  3086		 * remounted on top of @c. Afterwards, @mnt_from would be
  3087		 * covered by a copy @c of @mnt_from and @c would be covered by
  3088		 * @mnt_from itself. This defeats the whole purpose of mounting
  3089		 * @mnt_from beneath @mnt_to.
  3090		 */
  3091		if (propagation_would_overmount(parent_mnt_to, mnt_from, mp))
  3092			return -EINVAL;
  3093	
  3094		return 0;
  3095	}
  3096	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
