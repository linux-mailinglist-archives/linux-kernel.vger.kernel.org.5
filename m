Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42D97DB1B1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 01:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjJ3ANA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 20:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjJ3AM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 20:12:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF20EA7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 17:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698624774; x=1730160774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ty/PnS3WJCZjGn2JzyfXWoC5lQ3l5SVcDaNCHHJuxvU=;
  b=FN/GnwaJlhgxpVyq0skv+xNc8+goYgXAreskfkW2ws2oA9sAuhbymfaQ
   vZGGzYzmgqrZT3LJ5yoMpLbKpY8KPQJiiNsC2LldGYsAsHV2Y9w3GFDfy
   AxPBoYu57A7xNxVaJGbxnledwG8jMPhlRZxJEG3zI9TIuOsccmRWZwUU2
   GxxdcJyy+KtyGbWTfm68ol8wrDYF04wwvTrL9IGIkmKkH4HBuZSERCGOw
   QnlZY/u9+7iE1W9hWbxRr3BZrx5QxBWINFfCnyidhkJI+Cp4Q5eQOe6B4
   AfdYW424DgwadFplffEgLJwlG21ivjKamlLzrwmZGO3snGgf14Aq7cpea
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="390847907"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="390847907"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 17:12:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="1091462885"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="1091462885"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Oct 2023 17:12:52 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxFth-000Cv1-2l;
        Mon, 30 Oct 2023 00:12:49 +0000
Date:   Mon, 30 Oct 2023 08:12:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] drm/loongson: Allow attach drm bridge driver by
 calling lsdc_output_init()
Message-ID: <202310300738.zcudNQfj-lkp@intel.com>
References: <20231029194607.379459-4-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029194607.379459-4-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v6.6-rc7 next-20231027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/drm-loongson-Introduce-a-minimal-support-for-Loongson-VBIOS/20231030-034730
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20231029194607.379459-4-suijingfeng%40loongson.cn
patch subject: [PATCH 3/8] drm/loongson: Allow attach drm bridge driver by calling lsdc_output_init()
config: loongarch-randconfig-002-20231030 (https://download.01.org/0day-ci/archive/20231030/202310300738.zcudNQfj-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231030/202310300738.zcudNQfj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310300738.zcudNQfj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/loongson/lsdc_output.c:555:5: warning: no previous prototype for 'lsdc_encoder_init' [-Wmissing-prototypes]
     555 | int lsdc_encoder_init(struct drm_device *ddev,
         |     ^~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/loongson/lsdc_output.c:578:5: warning: no previous prototype for 'lsdc_connector_init' [-Wmissing-prototypes]
     578 | int lsdc_connector_init(struct drm_device *ddev,
         |     ^~~~~~~~~~~~~~~~~~~


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
