Return-Path: <linux-kernel+bounces-147922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C318A7B54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3741528285C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA99542AB5;
	Wed, 17 Apr 2024 04:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTewmbo5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89A41C73;
	Wed, 17 Apr 2024 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713327626; cv=none; b=VDyTLeWIKS0JfdluJ+SQdhW9cd1GgPtUSQx7Yp2pkYGAQRfn38fvkICwN5rTQUfa3Q7qWa/JmrrwnHWeQXUYSEw1skO2r++Cx5Tpdq9gCjc3ly9umKTV7yb777VaL6KQhd4UpQlGHpXKYFQhzRXAQi8HFcXRaaPJ7+wEfAEXMa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713327626; c=relaxed/simple;
	bh=eP9CiB0rVmK0Jtt5Y4CBVHAELD9KxtAHPblOt+Tr8S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIuAp4+8kn9B0XoKrqNx/4aXQmGsU06GUhBRS6fwmB9XA2GHLxTJrqFLV1qWHdrayXIZI08OaV81+GKVj4a4Lsjv9GBdZNhcDf7Uv8jERSMSOgHkTTRpmo3QnQsATqfaEm6Ewhzd00pr/w4YCORdNVbCgK4sQxah++RWzHFqrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTewmbo5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713327624; x=1744863624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eP9CiB0rVmK0Jtt5Y4CBVHAELD9KxtAHPblOt+Tr8S8=;
  b=mTewmbo5NDOpeHNoiUs4fp7LaXMuZPDrUzPHBirY5ukmE/GvAJUb6TKn
   wNIa1shrZE0Nnq1u3GBNqtZYlvekc6dq8cyzUm1C1fnYrLVA+t1OgvyDC
   yJFGDWZ/vUiBHG8Dwx2SICboupJpL7THGl7hSL4abTlLhYV3dIRQ8X/zI
   d1RHMQmaD+gvmJcqYVikttkLj/0zvfVuol770rqrmIy95Byk8GKNllddR
   xnwlPCTFA693VeFzMSqG4OqS8Q117XlGszGHuM/42XhWlJAfuu3WfE6VR
   RbYMkFRyo4H/OfYk/gYwddaESndhdzd+fNXwoiFXCIbzKvPL5yoOfgl2H
   g==;
X-CSE-ConnectionGUID: MpWjvdvTS3uaqwxKWSv8Vg==
X-CSE-MsgGUID: Sm9icaV5R2mPpoBUUGjHSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8727250"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="8727250"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 21:20:24 -0700
X-CSE-ConnectionGUID: yy0uzlT5T06h2v68mKmbig==
X-CSE-MsgGUID: 76kdptNeS0ilm+ZYkDwsFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="59912377"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 16 Apr 2024 21:20:22 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwwmS-00067e-0O;
	Wed, 17 Apr 2024 04:20:20 +0000
Date: Wed, 17 Apr 2024 12:19:32 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 4/4] kbuild: use $(src) instead of $(srctree)/$(src) for
 source directory
Message-ID: <202404171200.q4osYsl7-lkp@intel.com>
References: <20240416121838.95427-5-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416121838.95427-5-masahiroy@kernel.org>

Hi Masahiro,

kernel test robot noticed the following build errors:

[auto build test ERROR on masahiroy-kbuild/for-next]
[cannot apply to masahiroy-kbuild/fixes wireless-next/main wireless/main linus/master v6.9-rc4 next-20240416]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/arch-use-obj-instead-of-src-for-preprocessed-linker-scripts/20240416-202308
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
patch link:    https://lore.kernel.org/r/20240416121838.95427-5-masahiroy%40kernel.org
patch subject: [PATCH 4/4] kbuild: use $(src) instead of $(srctree)/$(src) for source directory
config: arm64-randconfig-004-20240417 (https://download.01.org/0day-ci/archive/20240417/202404171200.q4osYsl7-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7089c359a3845323f6f30c44a47dd901f2edfe63)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240417/202404171200.q4osYsl7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404171200.q4osYsl7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: couldn't read rust/doctests_kernel_generated.rs: No such file or directory (os error 2)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

