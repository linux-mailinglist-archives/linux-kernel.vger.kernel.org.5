Return-Path: <linux-kernel+bounces-2757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D38C816168
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC9F1F21795
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF03F4654F;
	Sun, 17 Dec 2023 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrAkEq9s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180EA1DFE9
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702835323; x=1734371323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3jqFBxo9q1S7ibFbRMz7aaJEa8whTcur8fmA5B6pIJk=;
  b=JrAkEq9smvyDPnYsuBS1EFZ3qKHyejObpMQXr8vgs04TpzmKAdUVxxgl
   rViZOBYKh9nJpqwzk5OhQC2aIGNE5oBvBLhBgvinJuyVT8A5BLof8iTuJ
   QizbTuI+P7K4Tc4LlgWr7EsVbw46dSK2kJ+gQAyG15D29tMu4fXXhgRvp
   uSETWQ7FhD4ycij6vo8bmhB/b0vdRXWKo6Tya/I7nT31UB7xYvPFLoig2
   CwPsVTErY12BWSGx50n9r9iI0mLPuSDItMlwJzv7/lm+8oGeuXmKugq/F
   iXOdEOpGHkCVlmm3vBjxqLxjHiL7ejq7JG/NVRgquIafDcZorknbJg2vl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="14109294"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="14109294"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 09:48:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="804286414"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="804286414"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Dec 2023 09:48:41 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEvFn-0003IC-11;
	Sun, 17 Dec 2023 17:48:39 +0000
Date: Mon, 18 Dec 2023 01:48:16 +0800
From: kernel test robot <lkp@intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: htmldocs: ./scripts/kernel-doc: ./include/crypto/hash.h:245:
 warning: Excess struct member 'digestsize' description in 'shash_alg'
Message-ID: <202312180137.iKarO143-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b8a9b2e6809d281890dd0a1102dc14d2cd11caf
commit: 42808e5dc602c12ef3eb42cf96cb416b55205fa4 crypto: hash - Count error stats differently
date:   9 months ago
reproduce: (https://download.01.org/0day-ci/archive/20231218/202312180137.iKarO143-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312180137.iKarO143-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ./scripts/kernel-doc: ./include/crypto/hash.h:245: warning: Excess struct member 'digestsize' description in 'shash_alg'
>> ./scripts/kernel-doc: ./include/crypto/hash.h:245: warning: Excess struct member 'statesize' description in 'shash_alg'
>> ./scripts/kernel-doc: ./include/crypto/hash.h:245: warning: Excess struct member 'stat' description in 'shash_alg'
>> ./scripts/kernel-doc: ./include/crypto/hash.h:245: warning: Excess struct member 'base' description in 'shash_alg'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

