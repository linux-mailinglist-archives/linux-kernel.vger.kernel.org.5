Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D81776654F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjG1H12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjG1H1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:27:03 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD47C2D5A;
        Fri, 28 Jul 2023 00:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690529219; x=1722065219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4mUBuKQHXM+NNtp1lxugGVSkC/2iGT32uWxUetY8AQk=;
  b=D+hQTcXqPegBpLbq+VxoWgsPJb/OCkPCZKGFLC0bpvubn/qhcdXx5IsS
   MHrRayMS4lpX4bqw9QcmVRllrlfbr+Kme3VzlG4YUWP5TWflRpwE6vqP4
   6IJst8IHGDadML2/qgcnKSarkhdDmGR6EU+3ocEQyrUAIlszFv6IMd9Yg
   +/0tSs9jI7AbcwhHUSxtCzBVqnhuUKxzZJKHFSHh4GWarixJz2eIf2x6h
   JbdtKVGANtjC8q1aKaJYXlzocgVG5tjmlBH/K9+amOUHGKRGHYVIzXz1I
   nAcqEqrtRmq4VbZx8f+aKGtdsR2u4JEdvaSHjQehRo5QVGLitod/3mH8G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="399466547"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="399466547"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 00:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="841183018"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="841183018"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2023 00:26:55 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPHsE-0002yZ-1e;
        Fri, 28 Jul 2023 07:26:54 +0000
Date:   Fri, 28 Jul 2023 15:26:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Lee Jackson <lee.jackson@arducam.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        kieran.bingham@ideasonboard.com,
        Marco Felsch <m.felsch@pengutronix.de>,
        jacopo.mondi@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: Re: [PATCH 2/2] media: i2c: imx519: Support for the Sony IMX519
 sensor
Message-ID: <202307281538.bqZ5kcV9-lkp@intel.com>
References: <20230727154108.308320-3-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727154108.308320-3-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

kernel test robot noticed the following build errors:

[auto build test ERROR on media-tree/master]
[also build test ERROR on soc/for-next linus/master v6.5-rc3 next-20230727]
[cannot apply to sailus-media-tree/streams]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Umang-Jain/media-dt-bindings-imx519-Add-IMX519-DT-bindings/20230727-234440
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230727154108.308320-3-umang.jain%40ideasonboard.com
patch subject: [PATCH 2/2] media: i2c: imx519: Support for the Sony IMX519 sensor
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230728/202307281538.bqZ5kcV9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307281538.bqZ5kcV9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307281538.bqZ5kcV9-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/media/i2c/imx519.c: In function 'imx519_open':
>> drivers/media/i2c/imx519.c:1170:30: error: 'MEDIA_BUS_FMT_SENSOR_DATA' undeclared (first use in this function)
    1170 |         try_fmt_meta->code = MEDIA_BUS_FMT_SENSOR_DATA;
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/imx519.c:1170:30: note: each undeclared identifier is reported only once for each function it appears in
   drivers/media/i2c/imx519.c: In function 'imx519_enum_mbus_code':
   drivers/media/i2c/imx519.c:1319:30: error: 'MEDIA_BUS_FMT_SENSOR_DATA' undeclared (first use in this function)
    1319 |                 code->code = MEDIA_BUS_FMT_SENSOR_DATA;
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/imx519.c: In function 'imx519_enum_frame_size':
   drivers/media/i2c/imx519.c:1346:34: error: 'MEDIA_BUS_FMT_SENSOR_DATA' undeclared (first use in this function)
    1346 |                 if (fse->code != MEDIA_BUS_FMT_SENSOR_DATA || fse->index > 0)
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/imx519.c: In function 'imx519_update_metadata_pad_format':
   drivers/media/i2c/imx519.c:1382:28: error: 'MEDIA_BUS_FMT_SENSOR_DATA' undeclared (first use in this function)
    1382 |         fmt->format.code = MEDIA_BUS_FMT_SENSOR_DATA;
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/imx519.c: In function 'imx519_get_pad_format':
   drivers/media/i2c/imx519.c:1404:33: error: 'MEDIA_BUS_FMT_SENSOR_DATA' undeclared (first use in this function)
    1404 |                                 MEDIA_BUS_FMT_SENSOR_DATA;
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/MEDIA_BUS_FMT_SENSOR_DATA +1170 drivers/media/i2c/imx519.c

  1149	
  1150	static int imx519_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
  1151	{
  1152		struct imx519 *imx519 = to_imx519(sd);
  1153		struct v4l2_mbus_framefmt *try_fmt_img =
  1154			v4l2_subdev_get_try_format(sd, fh->state, IMAGE_PAD);
  1155		struct v4l2_mbus_framefmt *try_fmt_meta =
  1156			v4l2_subdev_get_try_format(sd, fh->state, METADATA_PAD);
  1157		struct v4l2_rect *try_crop;
  1158	
  1159		mutex_lock(&imx519->mutex);
  1160	
  1161		/* Initialize try_fmt for the image pad */
  1162		try_fmt_img->width = supported_modes_10bit[0].width;
  1163		try_fmt_img->height = supported_modes_10bit[0].height;
  1164		try_fmt_img->code = imx519_get_format_code(imx519);
  1165		try_fmt_img->field = V4L2_FIELD_NONE;
  1166	
  1167		/* Initialize try_fmt for the embedded metadata pad */
  1168		try_fmt_meta->width = IMX519_EMBEDDED_LINE_WIDTH;
  1169		try_fmt_meta->height = IMX519_NUM_EMBEDDED_LINES;
> 1170		try_fmt_meta->code = MEDIA_BUS_FMT_SENSOR_DATA;
  1171		try_fmt_meta->field = V4L2_FIELD_NONE;
  1172	
  1173		/* Initialize try_crop */
  1174		try_crop = v4l2_subdev_get_try_crop(sd, fh->state, IMAGE_PAD);
  1175		try_crop->left = IMX519_PIXEL_ARRAY_LEFT;
  1176		try_crop->top = IMX519_PIXEL_ARRAY_TOP;
  1177		try_crop->width = IMX519_PIXEL_ARRAY_WIDTH;
  1178		try_crop->height = IMX519_PIXEL_ARRAY_HEIGHT;
  1179	
  1180		mutex_unlock(&imx519->mutex);
  1181	
  1182		return 0;
  1183	}
  1184	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
