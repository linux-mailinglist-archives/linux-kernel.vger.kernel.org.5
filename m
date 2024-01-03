Return-Path: <linux-kernel+bounces-15873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7595823493
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291BA285511
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E431C6AE;
	Wed,  3 Jan 2024 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOU+f6M4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC5B1BDCA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704306953; x=1735842953;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8AsYcoZAN9boEgmRr/CP4cn1XlD+s8vmE1s69sgKtnY=;
  b=DOU+f6M4TXOI51tWmQKpNX3SyB3MYh3dIJ0EdqFe7t1sJZcAS9aXzvS8
   xne56z9N9U8JXKoeb5duQycqQLJ0DS0BbplvrUA45YKzSctdM2ugGptd7
   ZHHOumPOiNn9u4sTmbx+0KMiFgmH7JpCR8h6AtwaRQdIkRCkPxbKaIQAZ
   xXU9QAIA07afBelMixhRJ6YxxxlNEriAtoZHq/8SIpgy4SBxrWbwKG8rp
   FdpctKnpCsXv6WajeJ2fxhTOe+TleVS4uBqae5A5WnHTK3VnGRDiX0d95
   KAzB4OxuUYS4gvCxgBu/thuUh7fboAYqBhPlcy45I7pbWn0rNx+lO3GEZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="4391823"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="4391823"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 10:35:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="14574053"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 03 Jan 2024 10:35:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rL65g-000MS8-2P;
	Wed, 03 Jan 2024 18:35:44 +0000
Date: Thu, 4 Jan 2024 02:35:29 +0800
From: kernel test robot <lkp@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [tip:ras/core 11/13] include/linux/ras.h:9:10: fatal error:
 uapi/asm/mce.h: No such file or directory
Message-ID: <202401040257.NPrXuVk7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
head:   d48d30d8c358004c7b1cb2e16969a569d45953b3
commit: 8e1d0790e0a749a62428ff039c7a9050a06e9feb [11/13] RAS: Introduce AMD Address Translation Library
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240104/202401040257.NPrXuVk7-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240104/202401040257.NPrXuVk7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401040257.NPrXuVk7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/ras/ras.c:10:
>> include/linux/ras.h:9:10: fatal error: uapi/asm/mce.h: No such file or directory
       9 | #include <uapi/asm/mce.h>
         |          ^~~~~~~~~~~~~~~~
   compilation terminated.


vim +9 include/linux/ras.h

     8	
   > 9	#include <uapi/asm/mce.h>
    10	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

