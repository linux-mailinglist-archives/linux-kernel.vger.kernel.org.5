Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED4C7E8663
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjKJXQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjKJXQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:16:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4AD1B3;
        Fri, 10 Nov 2023 15:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699658162; x=1731194162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5dPcMFlaiWQAP/PNdkSWmTyVFd2Uq4xlZs9J5OOdZWs=;
  b=iF1f/obdXLmGQRj257+IoisA4eXKAl8bxqV3uQq1uS+bFcfcvMJ7a7W/
   r9p7CWXeJQyE6Dp0g5JDrgOQwNrh72uCqf1XvQFijV+4ne62MFD5B9NUw
   Vj5H7MrMvX7qd1gCprdAX1d+xV21cxpGfbKOqJ2tbiFUfZDaCMsD3/0Zo
   +JLhQo67BRJcf5GLoyT4Dw3SWzTjfUQCUTZvkQZIKH06wjpnDHGeMrfqf
   4wcPBYfE8ZTak37gwtBK0TmcbkKFxDLNa2AUFDwnnmVvtJ36yM6Mp3HNw
   Dc05OrVm9Z18u4lbbjowHf1J5//Q2akGGQHq8iYXZaoXlafigGiwDCWwk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="454543722"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="454543722"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 15:16:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="1011052062"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="1011052062"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Nov 2023 15:15:56 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1ajC-000A0S-1g;
        Fri, 10 Nov 2023 23:15:54 +0000
Date:   Sat, 11 Nov 2023 07:14:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, hverkuil@xs4all.nl,
        sakari.ailus@iki.fi, tfiga@chromium.org, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v9 12/15] media: uapi: Declare interface types for Audio
Message-ID: <202311110751.SQ7aHnyx-lkp@intel.com>
References: <1699595289-25773-13-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699595289-25773-13-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on media-tree/master]
[also build test WARNING on broonie-sound/for-next tiwai-sound/for-next tiwai-sound/for-linus linus/master v6.6 next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shengjiu-Wang/ASoC-fsl_asrc-define-functions-for-memory-to-memory-usage/20231110-143635
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/1699595289-25773-13-git-send-email-shengjiu.wang%40nxp.com
patch subject: [PATCH v9 12/15] media: uapi: Declare interface types for Audio
reproduce: (https://download.01.org/0day-ci/archive/20231111/202311110751.SQ7aHnyx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311110751.SQ7aHnyx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/output/media.h.rst:6: WARNING: undefined label: media-intf-t-v4l-audio (if the link has no caption the label must precede a section header)

vim +6 Documentation/output/media.h.rst

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
