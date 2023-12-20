Return-Path: <linux-kernel+bounces-7520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B5F81A93F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9266C1C22C74
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445BF4A9B7;
	Wed, 20 Dec 2023 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CriiQRJ+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F51439FE1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703111936; x=1734647936;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7yp/mIrXqNVCXVarfj2+8+MRYJyd9csmXA3PQt7prGM=;
  b=CriiQRJ+XiYD6UJ4FWQmVCtXpHU3bgSD1nDYLXz6j34ulNZ2YFMM0H+I
   n4FmKnH+NAecpBOOa145M58EDqYuzTa/h6JApyo3cTOFVwbY6lhdRkz2I
   U459RPiwcHS1kRr3O8Mf8coFHutKTlV9MJzi6iiSp2IEKI4/Yw5TQu3sc
   CnHzvrzAbLycGVqn9Bc8PYxu2P3RH07ecvF2IEgYmKawspOdsbV/jO54k
   jgc+L6+7RdTr+QJa/ZqgMGJkPWaWsUwwJqIXBKAMrfmdwFVrgy+6hc3yc
   OK9KrhZLp5fokYkCvcXUxCcW2PhZ65OBfj6oCdzVQeMDJSsfqEtoyI+zz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="399716739"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="399716739"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 14:38:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="842417564"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="842417564"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 Dec 2023 14:38:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rG5DH-0007bD-0a;
	Wed, 20 Dec 2023 22:38:51 +0000
Date: Thu, 21 Dec 2023 06:38:32 +0800
From: kernel test robot <lkp@intel.com>
To: Zack Rusin <zackr@vmware.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Martin Krastev <krastevm@vmware.com>,
	Maaz Mombasawala <mombasawalam@vmware.com>
Subject: scripts/kernel-doc: drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:76:
 warning: Excess struct member 'transfer' description in 'vmw_stdu_dirty'
Message-ID: <202312210609.kvPv3OIN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1a44b0073b9235521280e19d963b6dfef7888f18
commit: 39985eea5a6dd1e844f216028252870e980b9e7f drm/vmwgfx: Abstract placement selection
date:   10 months ago
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20231221/202312210609.kvPv3OIN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231221/202312210609.kvPv3OIN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312210609.kvPv3OIN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:76: warning: Excess struct member 'transfer' description in 'vmw_stdu_dirty'
>> scripts/kernel-doc: drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:76: warning: Excess struct member 'transfer' description in 'vmw_stdu_dirty'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

