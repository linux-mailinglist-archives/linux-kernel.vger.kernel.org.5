Return-Path: <linux-kernel+bounces-147718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AC88A781A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C8FB23BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872C113AA31;
	Tue, 16 Apr 2024 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ldtuQV0L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED113A88F;
	Tue, 16 Apr 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307576; cv=none; b=mlrgFLwme1hfnENbzUyFnaPe3s1jzQH6gD/Pmw2uZ/TvhSGIG9VVgiRM5x0+3h5jNG93VBiEUq8DlRshSLu89t7dQUpx3v6kLF3ItriBQInjk9R5qz+NgYkAsRwhZAy+sfhRV00+r3CT4G36tNnyttSHMIB2s98kOGFgSM1i4+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307576; c=relaxed/simple;
	bh=llxZo58VP9At2K8lhG3Bchvf9TeT0/Wc3kqodjf0g5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxgApvzHieGpXtYlcC9BUJLnZk+wA7/g7ra3Pfqc6erznDK5yDA8JN5cJ4fj3rJfB5n2/fldHlKne0vq7OOOWk9d53715Tq85hU1TzXp7Iq4uaQ/En+u4eZMggamUb5ptytaVX14n5CMdlAWxkmA0wVIsegmo85txI1fyEXlax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ldtuQV0L; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713307575; x=1744843575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=llxZo58VP9At2K8lhG3Bchvf9TeT0/Wc3kqodjf0g5U=;
  b=ldtuQV0LGbagicObrNxGJReppzd2E04ODtx6XWK8GULxHFNJHU7eR7O7
   S0KBKJpvVq3ypMzF6IInKlPyVELWK1CUAk7cwjzaes7ZHzqbEpTYH4OAZ
   vtfyGSoo4xPjwT25zXtvFuIFo55PQD/KWMvYNPsQuf8MYvEPNfHExDbQ0
   9BCaH8xhnR3RQkjR82kLTipqVpbCFSTxpY1z8HSkvNwHJXbe4jSACKbyI
   vUabdjorata/GtINvVWjxPB0wDr/84C9otork/O7etYqdG55h0iyVaChN
   1YGeFFHwIBHJJtSmDLo2QjzZR2bfiG3YbR2n7ueSogUrGpE1VLOjwVjjf
   Q==;
X-CSE-ConnectionGUID: cXNZCiyXTD+e3KA4U3XlGw==
X-CSE-MsgGUID: ufHSL9WeQjezHbV0yb772w==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8641070"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="8641070"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 15:46:14 -0700
X-CSE-ConnectionGUID: IwhoHhQ0SmaPL59GKQy8TQ==
X-CSE-MsgGUID: CI93jiQiTi2bbLD+EoKvsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22480291"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 16 Apr 2024 15:46:13 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwrZ5-0005o0-0K;
	Tue, 16 Apr 2024 22:46:11 +0000
Date: Wed, 17 Apr 2024 06:45:55 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 4/4] kbuild: use $(src) instead of $(srctree)/$(src) for
 source directory
Message-ID: <202404170634.BlqTaYA0-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on masahiroy-kbuild/for-next]
[cannot apply to masahiroy-kbuild/fixes wireless-next/main wireless/main linus/master v6.9-rc4 next-20240416]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/arch-use-obj-instead-of-src-for-preprocessed-linker-scripts/20240416-202308
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
patch link:    https://lore.kernel.org/r/20240416121838.95427-5-masahiroy%40kernel.org
patch subject: [PATCH 4/4] kbuild: use $(src) instead of $(srctree)/$(src) for source directory
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240417/202404170634.BlqTaYA0-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240417/202404170634.BlqTaYA0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404170634.BlqTaYA0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> cc1: warning: -I: No such file or directory [-Wmissing-include-dirs]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

