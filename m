Return-Path: <linux-kernel+bounces-1955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA981564F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBB51F25A11
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8DD10A33;
	Sat, 16 Dec 2023 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAosxstD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD93510792
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 02:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702692718; x=1734228718;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d+7Gi/e8np/nNKAVpyFu6yndYlenWqczNp7HDNjQuGU=;
  b=NAosxstDGbV+YKejKNmljlB8bbAw0B26exxGurdxi9X+94dJ67To5LJn
   AEgMN/hPpeuLWCJBI2jSg/zi0X+d5cGGqoktHqElSRcR27zDZv4UHZefc
   IDUj9XSn/xQAJzSMP41yhTRJSy/AmeIhlath4Z3Yutv6nNocbJxEmuyrx
   T8GGNDeQS20smZu4TL2acHeZuICRqD0OTjAH6nWF6SXkH+Rdf24976+WL
   yrCW407dfXKbATh8DCDxTOxJOPQ3oMZ93KlkKGspQsinCONuImzcGaj2r
   n7lkOAJEU2Lwgpcj0jFt3fmTQLWKo1Tf4WhUGvEllm56BNaqMzPeZTd58
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="375505180"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="375505180"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 18:11:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="778470047"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="778470047"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Dec 2023 18:11:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEK9f-00012M-17;
	Sat, 16 Dec 2023 02:11:51 +0000
Date: Sat, 16 Dec 2023 10:11:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>, Kees Cook <keescook@chromium.org>
Subject: scripts/kernel-doc:
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:37: warning: Excess
 struct member 'data' description in 'brcmf_fweh_queue_item'
Message-ID: <202312161035.TqxHqpc9-lkp@intel.com>
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
commit: 62d19b35808816dc2bdf5031e5401230f6a915ba wifi: brcmfmac: fweh: Add __counted_by for struct brcmf_fweh_queue_item and use struct_size()
date:   9 weeks ago
config: arc-randconfig-002-20231215 (https://download.01.org/0day-ci/archive/20231216/202312161035.TqxHqpc9-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161035.TqxHqpc9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161035.TqxHqpc9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:37: warning: Excess struct member 'data' description in 'brcmf_fweh_queue_item'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

