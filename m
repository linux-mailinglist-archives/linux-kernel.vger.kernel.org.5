Return-Path: <linux-kernel+bounces-1975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48E815692
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F841C243FA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA8D1C38;
	Sat, 16 Dec 2023 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPPi+qNN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4901875
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702695296; x=1734231296;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KVD8u6HTaUva0ZJYtB+fzDcVcg7dwQ/9dAG0hJaiIXA=;
  b=RPPi+qNNbWSK5+zgaLp7E7JIqWGc9n9fY0m+w3XQ4UTwugP6ckVu+QQF
   ZTp3NAqTRSqByIJAPd+cutIhCH97fP2dagLDep2A7nBht7yrvUuIJJ9nW
   9N44VfJC3y6YHUgWmnaJKkWhw776MLr8wPRxXtt9Ou55W1WSd95SMVUNa
   EGOTKKNuQoeSGyLWw6OWydQONGU8CUTS+mbgW2CwcAKNnS3dfNz4NMqqM
   AycoRQ6RBRDlNRaV6DIOT+IwO8GknOjeu+XH0I8v9LuxrfK6HdiAG3PNl
   4CpJKuBpDanR9qJSFiT5oAcRHMJ2TQ3IQFAueRneX5fnJmqb3wR5GvXB6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="380347104"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="380347104"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 18:54:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="845319221"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="845319221"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2023 18:54:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEKpI-00014Q-2A;
	Sat, 16 Dec 2023 02:54:52 +0000
Date: Sat, 16 Dec 2023 10:54:34 +0800
From: kernel test robot <lkp@intel.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: scripts/kernel-doc: arch/arm64/kvm/hyp/vhe/sysreg-sr.c:109: warning:
 expecting prototype for __vcpu_put_switch_syregs(). Prototype was for
 __vcpu_put_switch_sysregs() instead
Message-ID: <202312161017.ikL0YXze-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3bd7d748816927202268cb335921f7f68b3ca723
commit: 27cde4c0fe28eab228d1fc9d84c68a109219887d KVM: arm64: Rename helpers for VHE vCPU load/put
date:   8 weeks ago
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231216/202312161017.ikL0YXze-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161017.ikL0YXze-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161017.ikL0YXze-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: arch/arm64/kvm/hyp/vhe/sysreg-sr.c:109: warning: expecting prototype for __vcpu_put_switch_syregs(). Prototype was for __vcpu_put_switch_sysregs() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

