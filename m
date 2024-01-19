Return-Path: <linux-kernel+bounces-31259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D86CD832B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626AD1F2274A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1908353E21;
	Fri, 19 Jan 2024 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMmj7QBa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2C94EB30;
	Fri, 19 Jan 2024 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674377; cv=none; b=eXXYpkwtv+k/Z3QXOKnC85mOjWxRliRu+KHols/CcGO0kWs6R2Wy4ea61XPsoeP4AeFXhGTyfblxsn7ENLadc7IFcdC9jj0PA0MqO8O6WbXSxFYzgfzd+fhO+Im4vUNjG+uSi9Zw/FL7szDsMhtvw0xMrYxmEA5isCQozccJNSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674377; c=relaxed/simple;
	bh=6ZyFttJi9Pj6gtg9DPLGs15qvrUf2pvBuDiSTNdqKfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlstOQpqFPCVG5DqPmZgFE1IQ8GGxbaZ+ZlUOjo1dfXih/BGfjOU6Ev+tuknkjFK/IJg6MyJkdBnwWyHgtTI2OfU/AINJ8v2cd0Yo1MqTFLYg/lhQjdYMSN6U6UyucAIGwNxMO2Rr0fUDJHO9dpHh4aK69CJ8TH69VyCSHUyGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMmj7QBa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705674375; x=1737210375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ZyFttJi9Pj6gtg9DPLGs15qvrUf2pvBuDiSTNdqKfw=;
  b=OMmj7QBanQO0Joo5tOziK/xwUtyKVg7GUFOhm71kTo/i6RzIfNnXAthk
   YPb23w7swWFLK2E/mtburyS/AACm1oaB2Mn/Xbp866r1Bw2YpxAbC6TXG
   4G2X8bbRJfs39jVEvQSB+LTIriSOhZp4OYKS9ohSoiNpfEJgyw8HZOdZ8
   AKZ/fnaMSXsA2nTs1VosLJ7BKb9MqY9DZzsxK90aOlfnU7bv8y81D9y6V
   GLsqJtcBePQfwIf8PKE0w2ArQoNC/SONTqqpXbR0bfDVKt51LNYHxkHyv
   QT9eu5AAPIufKF/NmWA7GIgghR44VwRFtyxKYt26uLz1TNeBCGAFGxCBr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7513058"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="7513058"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 06:26:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="778000589"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="778000589"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 19 Jan 2024 06:26:04 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQpon-000492-2J;
	Fri, 19 Jan 2024 14:26:01 +0000
Date: Fri, 19 Jan 2024 22:25:50 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Cercueil <paul@crapouillou.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, Paul Cercueil <paul@crapouillou.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-doc@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH v4 3/4] usb: gadget: functionfs: Add DMABUF import
 interface
Message-ID: <202401192234.0uzq25ka-lkp@intel.com>
References: <20240117122646.41616-4-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117122646.41616-4-paul@crapouillou.net>

Hi Paul,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus lwn/docs-next linus/master v6.7 next-20240119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/usb-gadget-Support-already-mapped-DMA-SGs/20240117-203111
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240117122646.41616-4-paul%40crapouillou.net
patch subject: [PATCH v4 3/4] usb: gadget: functionfs: Add DMABUF import interface
config: sh-randconfig-r052-20240119 (https://download.01.org/0day-ci/archive/20240119/202401192234.0uzq25ka-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240119/202401192234.0uzq25ka-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401192234.0uzq25ka-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/usb/gadget/function/f_fs.o: in function `ffs_dmabuf_signal_done':
>> f_fs.c:(.text+0x254c): undefined reference to `dma_fence_begin_signalling'
>> sh4-linux-ld: f_fs.c:(.text+0x2560): undefined reference to `dma_fence_signal'
>> sh4-linux-ld: f_fs.c:(.text+0x2564): undefined reference to `dma_fence_end_signalling'
   sh4-linux-ld: drivers/usb/gadget/function/f_fs.o: in function `ffs_epfile_release':
>> f_fs.c:(.text+0x28a0): undefined reference to `dma_buf_detach'
>> sh4-linux-ld: f_fs.c:(.text+0x28a4): undefined reference to `dma_buf_put'
   sh4-linux-ld: drivers/usb/gadget/function/f_fs.o: in function `ffs_dmabuf_unmap_work':
>> f_fs.c:(.text+0x2c6c): undefined reference to `dma_buf_unmap_attachment'
>> sh4-linux-ld: f_fs.c:(.text+0x2c70): undefined reference to `dma_resv_reset_max_fences'
>> sh4-linux-ld: f_fs.c:(.text+0x2c84): undefined reference to `dma_buf_detach'
   sh4-linux-ld: f_fs.c:(.text+0x2c88): undefined reference to `dma_buf_put'
>> sh4-linux-ld: f_fs.c:(.text+0x2c94): undefined reference to `dma_fence_release'
   sh4-linux-ld: drivers/usb/gadget/function/f_fs.o: in function `ffs_dmabuf_transfer':
>> f_fs.c:(.text+0x2e30): undefined reference to `dma_buf_get'
   sh4-linux-ld: f_fs.c:(.text+0x2e3c): undefined reference to `dma_buf_put'
>> sh4-linux-ld: f_fs.c:(.text+0x2ef4): undefined reference to `dma_resv_test_signaled'
>> sh4-linux-ld: f_fs.c:(.text+0x2efc): undefined reference to `dma_buf_map_attachment'
>> sh4-linux-ld: f_fs.c:(.text+0x3098): undefined reference to `dma_resv_reserve_fences'
>> sh4-linux-ld: f_fs.c:(.text+0x30bc): undefined reference to `dma_fence_init'
>> sh4-linux-ld: f_fs.c:(.text+0x30c0): undefined reference to `dma_resv_add_fence'
   sh4-linux-ld: f_fs.c:(.text+0x30c4): undefined reference to `dma_resv_reset_max_fences'
>> sh4-linux-ld: f_fs.c:(.text+0x30d4): undefined reference to `dma_fence_begin_signalling'
   sh4-linux-ld: f_fs.c:(.text+0x30e0): undefined reference to `dma_fence_end_signalling'
   sh4-linux-ld: f_fs.c:(.text+0x30f0): undefined reference to `dma_buf_put'
   sh4-linux-ld: f_fs.c:(.text+0x321c): undefined reference to `dma_fence_release'
>> sh4-linux-ld: f_fs.c:(.text+0x3224): undefined reference to `dma_buf_unmap_attachment'
   sh4-linux-ld: f_fs.c:(.text+0x3228): undefined reference to `dma_resv_reset_max_fences'
   sh4-linux-ld: f_fs.c:(.text+0x3230): undefined reference to `dma_buf_detach'
   sh4-linux-ld: f_fs.c:(.text+0x3234): undefined reference to `dma_buf_put'
   sh4-linux-ld: drivers/usb/gadget/function/f_fs.o: in function `ffs_epfile_ioctl':
   f_fs.c:(.text+0x41f0): undefined reference to `dma_buf_get'
>> sh4-linux-ld: f_fs.c:(.text+0x41f4): undefined reference to `dma_buf_attach'
   sh4-linux-ld: f_fs.c:(.text+0x4200): undefined reference to `dma_buf_detach'
>> sh4-linux-ld: f_fs.c:(.text+0x4210): undefined reference to `dma_fence_context_alloc'
   sh4-linux-ld: f_fs.c:(.text+0x4220): undefined reference to `dma_buf_put'
   sh4-linux-ld: f_fs.c:(.text+0x43b0): undefined reference to `dma_buf_detach'
   sh4-linux-ld: f_fs.c:(.text+0x43b4): undefined reference to `dma_buf_put'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

