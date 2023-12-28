Return-Path: <linux-kernel+bounces-12415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E987381F473
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6C5283AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E74E15C3;
	Thu, 28 Dec 2023 03:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dl94ql23"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3181104
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 03:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703735243; x=1735271243;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8+m+uqWzLht9Jkcg4p2SuWNA1HdjU9m0+M1AHAZCiJU=;
  b=dl94ql23s9+L5QDrgmKt4s/wBqD4elBgrOk/zFQGm/64Ifca+SrLdA41
   tkvxNSBQoINsXpN91y/Ddgc9L1RD5ZvlFFuXs4HJid0dhbA1+sqV7+0o4
   9qKlzSxS9kesItjtJ6M6Fvginwzbti/GMFriGD8z8X8bApZWVQtB3sNkS
   X+dAjliWtjJJkBktQatPRqf+R7vS3v4psFfKQbLV5P0bcGjxRlN0ndpLm
   jES8ehHed8wRDQRKpB35EICRzO8FnjoIkETdSAZWVqbYwzctZIIEvdrDE
   XXSDYP8PJn+L5t4dxOCA5dId81lSF5PnYCfza6L76C7cpnPeEF6BddjWT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="396231219"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="396231219"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 19:47:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="754624593"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="754624593"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 27 Dec 2023 19:47:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIhMb-000Fzx-39;
	Thu, 28 Dec 2023 03:47:17 +0000
Date: Thu, 28 Dec 2023 11:46:31 +0800
From: kernel test robot <lkp@intel.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: panel-raydium-rm692e5.c:undefined reference to
 `drm_dsc_pps_payload_pack'
Message-ID: <202312281138.PHn1Js8S-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f5837722ffecbbedf1b1dbab072a063565f0dad1
commit: 988d0ff29ecf7ab750b9be29fddae588156c3d03 drm/panel: Add driver for BOE RM692E5 AMOLED panel
date:   3 months ago
config: csky-randconfig-001-20231228 (https://download.01.org/0day-ci/archive/20231228/202312281138.PHn1Js8S-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231228/202312281138.PHn1Js8S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312281138.PHn1Js8S-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/gpu/drm/panel/panel-raydium-rm692e5.o: in function `rm692e5_prepare':
>> panel-raydium-rm692e5.c:(.text+0xfc0): undefined reference to `drm_dsc_pps_payload_pack'
>> csky-linux-ld: panel-raydium-rm692e5.c:(.text+0x1090): undefined reference to `drm_dsc_pps_payload_pack'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

