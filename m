Return-Path: <linux-kernel+bounces-152445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EF18ABE7F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 05:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B202810B0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 03:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F7453A9;
	Sun, 21 Apr 2024 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEKILsPj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02236523A
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 03:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713671065; cv=none; b=uF77RZlB/aQjhF7vhacJDn/+WE/pF+n2t1SmOyAwoJ5Qfs4o0mlLh+CJvnH07DxuSwH4V1HXDdNizy9YE+/8YYltVTDdvRUZn67kudPhQovxzKc4N1DXdw45oOsVjIru+mWeZoww4p4s5JDFuWcgs/TFsegKqFWKHrKhBZXtXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713671065; c=relaxed/simple;
	bh=qfXRZtjXybPkF602l1lJ7S7tfxomP0pt4Mo8OKeTyMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7Qr2vc4uYo4uzuL7zG4FUKaQp0turd+iMLcPNTxIMpB9Bq3976o4lUEaSNOG0yo/5XESWo6nZ80bjJNpQ0it/hgOJ4ojeBkbkYLk5+6kGK9eZPs7lKPFWxAKq8eYY2mVJy7i3U66P26Wa+ZGU5kmUhaOnZ9eUoeQpu5qQcFcI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEKILsPj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713671060; x=1745207060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qfXRZtjXybPkF602l1lJ7S7tfxomP0pt4Mo8OKeTyMk=;
  b=JEKILsPjh5iVC+R4l7neAESQ43lYkZnGtz5IdVq1tGx6GCDENxD56Si9
   PUV6PSBMN7vlDy/I7vFRoU4KqXovDBXPxULjEGhaVq3isJ7k8yL74n5Ui
   ++wfgDLTaI1jaZAnZoipJO17XGUFc4EXHovU4GYmpZ5E/MFSA3lP+Q6o0
   zxqkKSb9/ziz1Tzdtj9LBOOd/99/MJYBm2bRiyRjDiZoaCUSgaIsjbt+H
   B6gI1E5NPZRs/kAdakuieoedDFmG57JYVRJISjHvRE9+lfDszF4KWG7LN
   Ts7a5urqtZq4vz2ORRGWGNKmcDXTy4TsHqvJtBoErt+czqJ7DHJIYhqGV
   A==;
X-CSE-ConnectionGUID: 9vTO9Vp9Q7a5dN3xFOC+vQ==
X-CSE-MsgGUID: 33vZTkhbRNiZChUrIJ/26g==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="20374182"
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="20374182"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 20:44:14 -0700
X-CSE-ConnectionGUID: l3UU0oy8RsyqQHta8u4V5A==
X-CSE-MsgGUID: 20nxQJxlR0aOhoH1s1hl3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="23751070"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 20 Apr 2024 20:44:11 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ryO7c-000BfQ-2j;
	Sun, 21 Apr 2024 03:44:08 +0000
Date: Sun, 21 Apr 2024 11:43:38 +0800
From: kernel test robot <lkp@intel.com>
To: zhenwei pi <pizhenwei@bytedance.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, mst@redhat.com, david@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 2/3] virtio_balloon: introduce memory allocation stall
 counter
Message-ID: <202404211106.B9pwuFqk-lkp@intel.com>
References: <20240418062602.1291391-3-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418062602.1291391-3-pizhenwei@bytedance.com>

Hi zhenwei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.9-rc4 next-20240419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhenwei-pi/virtio_balloon-introduce-oom-kill-invocations/20240418-142934
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240418062602.1291391-3-pizhenwei%40bytedance.com
patch subject: [PATCH 2/3] virtio_balloon: introduce memory allocation stall counter
config: i386-randconfig-141-20240421 (https://download.01.org/0day-ci/archive/20240421/202404211106.B9pwuFqk-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240421/202404211106.B9pwuFqk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404211106.B9pwuFqk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/virtio/virtio_balloon.c:324:18: warning: unused variable 'stall' [-Wunused-variable]
     324 |         long available, stall = 0;
         |                         ^~~~~
   1 warning generated.


vim +/stall +324 drivers/virtio/virtio_balloon.c

   318	
   319	static unsigned int update_balloon_stats(struct virtio_balloon *vb)
   320	{
   321		unsigned long events[NR_VM_EVENT_ITEMS];
   322		struct sysinfo i;
   323		unsigned int idx = 0;
 > 324		long available, stall = 0;
   325		unsigned long caches;
   326	
   327		all_vm_events(events);
   328		si_meminfo(&i);
   329	
   330		available = si_mem_available();
   331		caches = global_node_page_state(NR_FILE_PAGES);
   332	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

