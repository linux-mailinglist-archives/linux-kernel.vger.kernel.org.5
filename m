Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F332F7B5EF1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 04:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbjJCCLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 22:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjJCCLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 22:11:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346D49B;
        Mon,  2 Oct 2023 19:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696299079; x=1727835079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SUK+61OO5F8A0MgS6dV9KOXJGyDRUWfx8xwnVpRtUh0=;
  b=h04D9Xlng79szt9y2rsRS9Qp+lThF+9S8YEhONSGy6+jxwLe4YG3wx8c
   c/obW+7LfSmWnX8+dSOHxsWWHkGSp1izArsE2Fm+eK9mlotq7QyF19KIb
   CCddJ8sgbme4WLLBkwV1nTsdvuYq7SOwWwMYjPbFrEHxclC9bnpNyLr9v
   /poLTkRLDF+0R/XTroArzMCQ7PGukHvIaiXT6O1EDO7x8kqhdh84gP18G
   SVnCE5hPgIihyt/cus2ea+4WrDeUC7rAtbdwxtXqQhlRVttLCXYq6R1qX
   u6mJQH1bYOXyQv40KprnX8mTImTk6IZuhlWqPkBGnT6o4muEWZhMQSmkn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="413697302"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="413697302"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 19:11:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="841173112"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="841173112"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Oct 2023 19:11:13 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnUsR-0006fM-0j;
        Tue, 03 Oct 2023 02:11:11 +0000
Date:   Tue, 3 Oct 2023 10:11:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com
Cc:     oe-kbuild-all@lists.linux.dev, adrian.larumbe@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        healych@amazon.com, kernel@collabora.com,
        tvrtko.ursulin@linux.intel.com, boris.brezillon@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 2/5] drm/panfrost: Add fdinfo support GPU load metrics
Message-ID: <202310030917.Txzlpoeq-lkp@intel.com>
References: <20230929181616.2769345-3-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929181616.2769345-3-adrian.larumbe@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrián,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f45acf7acf75921c0409d452f0165f51a19a74fd]

url:    https://github.com/intel-lab-lkp/linux/commits/Adri-n-Larumbe/drm-panfrost-Add-cycle-count-GPU-register-definitions/20230930-041528
base:   f45acf7acf75921c0409d452f0165f51a19a74fd
patch link:    https://lore.kernel.org/r/20230929181616.2769345-3-adrian.larumbe%40collabora.com
patch subject: [PATCH v8 2/5] drm/panfrost: Add fdinfo support GPU load metrics
reproduce: (https://download.01.org/0day-ci/archive/20231003/202310030917.Txzlpoeq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310030917.Txzlpoeq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/gpu/panfrost.rst:8: WARNING: Title underline too short.
>> Documentation/gpu/panfrost.rst: WARNING: document isn't included in any toctree

vim +8 Documentation/gpu/panfrost.rst

     6	
     7	Panfrost DRM client usage stats implementation
   > 8	==========================================
     9	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
