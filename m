Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221027E157C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 18:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjKER20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 12:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKER2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 12:28:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA7AF2
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 09:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699205301; x=1730741301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IH0s2EKBm011pg6eWlimN9vEcHNbrh2FszlkPly8vwg=;
  b=mh9o/LUCrK6EpyJBOR8b5TOmF9Cx1zXINODA8Kv8cxs79j6OoWkvb/xV
   lZH41nsHSToSU5u2o9OZfD/u+mBUd4UWjoIT0TdUU7VaQveDBqOSTPius
   eDUAolvXQmEEErdxczNzeTk5Ckf49LoN7Y+LMdycwfWmmOcITFl77uY7C
   3zDqUvYphezbImWz0sW3uTDkSVk77cLwOSr88ytESIco1JJydwNW4EKHg
   KrPyKwH74yIM7fvC89jV7tab2a6dq1o9JjJR9V/NJSBeHVr3hVzs0rUM7
   lj9C+qqaOwGOFBC89M1dmyuoWzAR3c9+3SUd59iQ3q1MIzN3QJXvGmVw8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="386335179"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="386335179"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 09:28:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="885697483"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="885697483"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Nov 2023 09:28:18 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzgv2-0005fD-0n;
        Sun, 05 Nov 2023 17:28:16 +0000
Date:   Mon, 6 Nov 2023 01:27:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] drm/loongson: Allow attach drm bridge driver by
 calling lsdc_output_init()
Message-ID: <202311060159.WME8x93V-lkp@intel.com>
References: <20231029194607.379459-4-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029194607.379459-4-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v6.6 next-20231103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/drm-loongson-Introduce-a-minimal-support-for-Loongson-VBIOS/20231030-034730
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20231029194607.379459-4-suijingfeng%40loongson.cn
patch subject: [PATCH 3/8] drm/loongson: Allow attach drm bridge driver by calling lsdc_output_init()
config: x86_64-randconfig-122-20231102 (https://download.01.org/0day-ci/archive/20231106/202311060159.WME8x93V-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060159.WME8x93V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060159.WME8x93V-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/loongson/lsdc_output.c:555:5: sparse: sparse: symbol 'lsdc_encoder_init' was not declared. Should it be static?
>> drivers/gpu/drm/loongson/lsdc_output.c:578:5: sparse: sparse: symbol 'lsdc_connector_init' was not declared. Should it be static?

vim +/lsdc_encoder_init +555 drivers/gpu/drm/loongson/lsdc_output.c

   554	
 > 555	int lsdc_encoder_init(struct drm_device *ddev,
   556			      struct lsdc_output *output,
   557			      unsigned int pipe)
   558	{
   559		const struct lsdc_output_desc *descp = output->descp;
   560		struct drm_encoder *encoder = &output->encoder;
   561		int ret;
   562	
   563		ret = drm_encoder_init(ddev,
   564				       encoder,
   565				       descp->encoder_funcs,
   566				       descp->encoder_type,
   567				       descp->name);
   568		if (ret)
   569			return ret;
   570	
   571		encoder->possible_crtcs = BIT(pipe);
   572	
   573		drm_encoder_helper_add(encoder, descp->encoder_helper_funcs);
   574	
   575		return 0;
   576	}
   577	
 > 578	int lsdc_connector_init(struct drm_device *ddev,
   579				struct lsdc_output *output,
   580				struct i2c_adapter *ddc,
   581				unsigned int pipe)
   582	{
   583		const struct lsdc_output_desc *descp = output->descp;
   584		struct drm_connector *connector = &output->connector;
   585		int ret;
   586	
   587		ret = drm_connector_init_with_ddc(ddev,
   588						  connector,
   589						  descp->connector_funcs,
   590						  descp->connector_type,
   591						  ddc);
   592		if (ret)
   593			return ret;
   594	
   595		drm_connector_helper_add(connector, descp->connector_helper_funcs);
   596	
   597		drm_connector_attach_encoder(connector, &output->encoder);
   598	
   599		connector->polled = DRM_CONNECTOR_POLL_CONNECT |
   600				    DRM_CONNECTOR_POLL_DISCONNECT;
   601	
   602		connector->interlace_allowed = 0;
   603		connector->doublescan_allowed = 0;
   604	
   605		drm_info(ddev, "DisplayPipe-%u has %s\n", pipe, descp->name);
   606	
   607		return 0;
   608	}
   609	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
