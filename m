Return-Path: <linux-kernel+bounces-22832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E88982A39A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1421F23E65
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F764F889;
	Wed, 10 Jan 2024 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6oTUxY3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1932C4F882;
	Wed, 10 Jan 2024 21:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704923618; x=1736459618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BvBYdkXHV9ZanHh3bS82LO02IRwGVYyQzTKuksk7rqI=;
  b=F6oTUxY39JAFWmycFYBmkh2DUgSrGH/8YvvGAzTjJpAMYlu9ivqeVZgg
   dgGWTig5qpmrwmhgXJc88VX9dTdZJmB0snCptm0SDg4iuDxsXwKHBByiV
   vrIS55ymUsgAb0uGG4sX2mPrDTpEX9VdT6jlPG3DcpyfFBIoY05a/khpk
   2lSXXdIF7XeBZCTUzm9IF9Vg2uYoIAj77aKOb3kXmPHRc2zxV/VwhVhHT
   XRUS01WGRn6OeStJYMRl/zgMOzcmQegYWjUhO6giMyd2bNGCK4pFpUb8z
   C9mafoSU07XOqHXqBCt4PKJyjqrN6TJXcmcyvQsLF20oJ7Lduw91ciF+2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5432522"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5432522"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 13:53:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="925788312"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="925788312"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jan 2024 13:53:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNgVw-0007Wk-2I;
	Wed, 10 Jan 2024 21:53:32 +0000
Date: Thu, 11 Jan 2024 05:53:14 +0800
From: kernel test robot <lkp@intel.com>
To: Vinay Varma <varmavinaym@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	jacopo.mondi@ideasonboard.com, sakari.ailus@linux.intel.com,
	laurent.pinchart@ideasonboard.com,
	Vinay Varma <varmavinaym@gmail.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: i2c: imx219: implement v4l2 selection api
Message-ID: <202401110518.L0kScfAo-lkp@intel.com>
References: <20240109035045.552097-1-varmavinaym@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109035045.552097-1-varmavinaym@gmail.com>

Hi Vinay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on media-tree/master]
[also build test WARNING on linuxtv-media-stage/master next-20240110]
[cannot apply to sailus-media-tree/streams linus/master v6.7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vinay-Varma/media-i2c-imx219-implement-v4l2-selection-api/20240109-115310
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20240109035045.552097-1-varmavinaym%40gmail.com
patch subject: [PATCH v2] media: i2c: imx219: implement v4l2 selection api
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20240111/202401110518.L0kScfAo-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240111/202401110518.L0kScfAo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401110518.L0kScfAo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/imx219.c:950:29: warning: variable 'fmt' set but not used [-Wunused-but-set-variable]
     950 |         struct v4l2_mbus_framefmt *fmt;
         |                                    ^
   1 warning generated.


vim +/fmt +950 drivers/media/i2c/imx219.c

   937	
   938	#define IMX219_ROUND(dim, step, flags)                \
   939		((flags) & V4L2_SEL_FLAG_GE ?                 \
   940			 round_up((dim), (step)) :            \
   941			 ((flags) & V4L2_SEL_FLAG_LE ?        \
   942				  round_down((dim), (step)) : \
   943				  round_down((dim) + (step) / 2, (step))))
   944	
   945	static bool imx219_set_selection_crop(struct v4l2_subdev *sd,
   946					      struct v4l2_subdev_state *sd_state,
   947					      struct v4l2_subdev_selection *sel)
   948	{
   949		struct v4l2_rect *compose, *crop;
 > 950		struct v4l2_mbus_framefmt *fmt;
   951		u32 max_binning;
   952	
   953		crop = v4l2_subdev_state_get_crop(sd_state, 0);
   954		if (v4l2_rect_equal(&sel->r, crop))
   955			return false;
   956		max_binning = binning_ratios[ARRAY_SIZE(binning_ratios) - 1];
   957		sel->r.width =
   958			clamp(IMX219_ROUND(sel->r.width, max_binning, sel->flags),
   959			      max_binning * IMX219_MIN_COMPOSE_SIZE,
   960			      IMX219_PIXEL_ARRAY_WIDTH);
   961		sel->r.height =
   962			clamp(IMX219_ROUND(sel->r.width, max_binning, sel->flags),
   963			      max_binning * IMX219_MIN_COMPOSE_SIZE,
   964			      IMX219_PIXEL_ARRAY_WIDTH);
   965		sel->r.left =
   966			min_t(u32, sel->r.left, IMX219_PIXEL_ARRAY_LEFT - sel->r.width);
   967		sel->r.top =
   968			min_t(u32, sel->r.top, IMX219_PIXEL_ARRAY_TOP - sel->r.top);
   969	
   970		compose = v4l2_subdev_state_get_compose(sd_state, 0);
   971		fmt = v4l2_subdev_state_get_format(sd_state, 0);
   972		*crop = sel->r;
   973		compose->height = crop->height;
   974		compose->width = crop->width;
   975		return true;
   976	}
   977	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

