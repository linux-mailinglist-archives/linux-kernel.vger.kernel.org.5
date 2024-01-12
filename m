Return-Path: <linux-kernel+bounces-24228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E739482B971
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDB028821A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B781841;
	Fri, 12 Jan 2024 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wn33nrLr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6671A139F;
	Fri, 12 Jan 2024 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705026022; x=1736562022;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vduSvG1spMcM8XC+Oa8IuX9EfaEq9mz0+QWjIzSSm30=;
  b=Wn33nrLrwlrtr9EfRWTIE2+MRRW+HpmqtEpbnrl0xgE/XQTL3iHDxalb
   vEshEMt3NNOeLaq3BQaqHNVk/AR1FFxmaBeG/bUZbiEE3S3ov2G+Bcbek
   IbKaZMIhOfHZv6P9tKnTVTvwbD4cR8ZLJl+zcWq/myKmaogzUc1Vj3x7R
   W1OOtMWC8rqU04RfzYeMph1eX9CnCiIhYHjROh7I7RrzVGgEHOfZYZrur
   6y0iRe2c0C027rZsB8gLokZ2A+wTJD4Qu7oaIX+Gwi7B134+1vWTlZ4ty
   7Uz9KzopjOx1DAgcZMJ7Nbth3IEFaSDpG3Pm3/2gs8DNHrKeiCp2eCmap
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="20529852"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="20529852"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 18:20:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="31226295"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 11 Jan 2024 18:20:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO79a-0008x0-0L;
	Fri, 12 Jan 2024 02:20:14 +0000
Date: Fri, 12 Jan 2024 10:20:04 +0800
From: kernel test robot <lkp@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Luca Coelho <luciano.coelho@intel.com>, linux-doc@vger.kernel.org
Subject: htmldocs: Documentation/gpu/rfc/i915_scheduler.rst:138: WARNING:
 Unknown directive type "c:namespace-push".
Message-ID: <202401121027.s5YQjxIq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jani,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   22d29f1112c85c1ad519a8c0403f7f7289cf060c
commit: f6757dfcfde722fdeaee371b66f63d7eb61dd7e4 drm/doc: fix duplicate declaration warning
date:   7 months ago
reproduce: (https://download.01.org/0day-ci/archive/20240112/202401121027.s5YQjxIq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401121027.s5YQjxIq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/gpu/rfc/i915_scheduler.rst:138: WARNING: Unknown directive type "c:namespace-push".
>> Documentation/gpu/rfc/i915_scheduler.rst:143: WARNING: Unknown directive type "c:namespace-pop".

vim +138 Documentation/gpu/rfc/i915_scheduler.rst

   137	
 > 138	.. c:namespace-push:: rfc
   139	
   140	.. kernel-doc:: include/uapi/drm/i915_drm.h
   141	        :functions: i915_context_engines_parallel_submit
   142	
 > 143	.. c:namespace-pop::
   144	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

