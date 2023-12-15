Return-Path: <linux-kernel+bounces-268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0614813E77
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABB81F22646
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2782DB70;
	Fri, 15 Dec 2023 00:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdV879Qj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4D66C6F1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702598445; x=1734134445;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ibRUCA0a5idl9mmBZkdHmaZtWu7tHqQ0HONv608hxJk=;
  b=jdV879QjqCEoNEcIUsWO0bV9UCRB7uGRP79rwzVYmK9iFzaFLIVCNxff
   ORF1HXUc3UYZNnVKwTsPxRX/vPid1fjg/sYpRW40frAG3j1c6jm688ogT
   IGxR8hv4v5Ge6+yKeL43JsyO4XuNtxoQ4tv0WgSUcIgUNAV9zJ0CARayZ
   GOHy6ulCqGA7HdQDVAzD/ptf0CX3weWsVb5kkUH+NP4HVXKOXaCvkJ+P0
   tbEIVfZQfLlOcQA5/U20w6BxHgCku6lX/nns4Gj7GMz5waTv00lnnWq+K
   4VN8pHFRe7L6R/cHmzm5zsUjiS1P/N666ExDAmgueI1XSKd5U2aQNXle1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8605533"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="8605533"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 16:00:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="808771687"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="808771687"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Dec 2023 16:00:42 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDvd9-000Mlr-24;
	Fri, 15 Dec 2023 00:00:39 +0000
Date: Fri, 15 Dec 2023 08:00:11 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Zack Rusin <zackr@vmware.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:81: warning: Excess struct
 member 'boxes' description in 'vmw_surface_dirty'
Message-ID: <202312150701.kNI9LuM3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c7402612e2e61b76177f22e6e7f705adcbecc6fe
commit: 45744668746b0bcb36d58a73c2cab603090da9ac drm/vmwgfx: Annotate struct vmw_surface_dirty with __counted_by
date:   2 months ago
config: i386-buildonly-randconfig-004-20231214 (https://download.01.org/0day-ci/archive/20231215/202312150701.kNI9LuM3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150701.kNI9LuM3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150701.kNI9LuM3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:55: warning: Excess struct member 'base' description in 'vmw_user_surface'
>> drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:81: warning: Excess struct member 'boxes' description in 'vmw_surface_dirty'


vim +81 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c

543831cfc97666 Thomas Hellstrom 2012-11-20  70  
9ca7d19ff8ba62 Thomas Hellstrom 2019-03-19  71  /**
cde3435af618c7 Lee Jones        2021-01-15  72   * struct vmw_surface_dirty - Surface dirty-tracker
9ca7d19ff8ba62 Thomas Hellstrom 2019-03-19  73   * @cache: Cached layout information of the surface.
9ca7d19ff8ba62 Thomas Hellstrom 2019-03-19  74   * @num_subres: Number of subresources.
9ca7d19ff8ba62 Thomas Hellstrom 2019-03-19  75   * @boxes: Array of SVGA3dBoxes indicating dirty regions. One per subresource.
9ca7d19ff8ba62 Thomas Hellstrom 2019-03-19  76   */
9ca7d19ff8ba62 Thomas Hellstrom 2019-03-19  77  struct vmw_surface_dirty {
ebc9ac7c3dfe85 Zack Rusin       2021-06-15  78  	struct vmw_surface_cache cache;
9ca7d19ff8ba62 Thomas Hellstrom 2019-03-19  79  	u32 num_subres;
45744668746b0b Kees Cook        2023-09-22  80  	SVGA3dBox boxes[] __counted_by(num_subres);
9ca7d19ff8ba62 Thomas Hellstrom 2019-03-19 @81  };
9ca7d19ff8ba62 Thomas Hellstrom 2019-03-19  82  

:::::: The code at line 81 was first introduced by commit
:::::: 9ca7d19ff8ba6207bccab46536814fe4839df80a drm/vmwgfx: Add surface dirty-tracking callbacks

:::::: TO: Thomas Hellstrom <thellstrom@vmware.com>
:::::: CC: Thomas Hellstrom <thellstrom@vmware.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

