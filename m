Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479DA8120D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442230AbjLMVhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 16:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjLMVhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:37:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C57F4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 13:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702503437; x=1734039437;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0lFjIoIjh/8584Pz+OnOhbGAJ9BLr/6Yz3+3JN5iFhw=;
  b=VSC2r0BQpkAFX7VUjG1mRZsnSDULWu8VbWrxPF8kc3bAUfJSkZ9f3yCh
   a/bRwZvrS/dZOkOBxZRI9csCc6hJhilgoZgj2OChAjzG7C84weY4HVxGA
   wjx9/KQdAP67VSFGyllOyaSuI6OM7lgGaQclyXdhkJJciNYwkOmTux5W4
   H5J1ZB25E2yekMqvVqGLQ04SKHZFdZWXuJCbUKkUwQALKMnXRoQQiKUJl
   hedTSX0Mg2go3VrfFacxGBjyZOr/0zTJiEb6x9shyXZZgYIdSdyW/0THz
   11/GV6M9uRIaEvC5i7Lp6st/uu8POm7gZpLqHkgvhmy1yY+aow6ndk7GN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="13726413"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="13726413"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:37:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="844468205"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="844468205"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Dec 2023 13:37:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDWum-000L9n-24;
        Wed, 13 Dec 2023 21:37:12 +0000
Date:   Thu, 14 Dec 2023 05:37:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: drivers/video/fbdev/sis/init301.c:239:28: warning: 'SiS_Part2CLVX_6'
 defined but not used
Message-ID: <202312140516.dZhcKheX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: 9cbaf4d969ec4f5eb7a4e97afade374ee8056ef1 video: offb: Deallocate the color map
date:   6 years ago
config: x86_64-buildonly-randconfig-004-20230906 (https://download.01.org/0day-ci/archive/20231214/202312140516.dZhcKheX-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312140516.dZhcKheX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312140516.dZhcKheX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/video/fbdev/sis/init301.c: In function 'SiS_SetCRT2ModeRegs':
   drivers/video/fbdev/sis/init301.c:2690:24: warning: variable 'modeflag' set but not used [-Wunused-but-set-variable]
    2690 |   unsigned short i, j, modeflag, tempah=0;
         |                        ^~~~~~~~
   drivers/video/fbdev/sis/init301.c: In function 'SiS_SetGroup1':
   drivers/video/fbdev/sis/init301.c:6236:52: warning: variable 'resinfo' set but not used [-Wunused-but-set-variable]
    6236 |   unsigned short  pushbx=0, CRT1Index=0, modeflag, resinfo=0;
         |                                                    ^~~~~~~
   drivers/video/fbdev/sis/init301.c: At top level:
>> drivers/video/fbdev/sis/init301.c:239:28: warning: 'SiS_Part2CLVX_6' defined but not used [-Wunused-const-variable=]
     239 | static const unsigned char SiS_Part2CLVX_6[] = {   /* 1080i */
         |                            ^~~~~~~~~~~~~~~
>> drivers/video/fbdev/sis/init301.c:230:28: warning: 'SiS_Part2CLVX_5' defined but not used [-Wunused-const-variable=]
     230 | static const unsigned char SiS_Part2CLVX_5[] = {   /* 750p */
         |                            ^~~~~~~~~~~~~~~
>> drivers/video/fbdev/sis/init301.c:211:28: warning: 'SiS_Part2CLVX_4' defined but not used [-Wunused-const-variable=]
     211 | static const unsigned char SiS_Part2CLVX_4[] = {   /* PAL */
         |                            ^~~~~~~~~~~~~~~
>> drivers/video/fbdev/sis/init301.c:192:28: warning: 'SiS_Part2CLVX_3' defined but not used [-Wunused-const-variable=]
     192 | static const unsigned char SiS_Part2CLVX_3[] = {  /* NTSC, 525i, 525p */
         |                            ^~~~~~~~~~~~~~~
>> drivers/video/fbdev/sis/init301.c:184:28: warning: 'SiS_Part2CLVX_2' defined but not used [-Wunused-const-variable=]
     184 | static const unsigned char SiS_Part2CLVX_2[] = {
         |                            ^~~~~~~~~~~~~~~
>> drivers/video/fbdev/sis/init301.c:176:28: warning: 'SiS_Part2CLVX_1' defined but not used [-Wunused-const-variable=]
     176 | static const unsigned char SiS_Part2CLVX_1[] = {
         |                            ^~~~~~~~~~~~~~~
   In file included from drivers/video/fbdev/sis/sis.h:31,
                    from drivers/video/fbdev/sis/init301.h:66,
                    from drivers/video/fbdev/sis/init301.c:72:
   drivers/video/fbdev/sis/init.h:1445:38: warning: 'SiS_LVDSCRT1640x480_1_H' defined but not used [-Wunused-const-variable=]
    1445 | static const struct SiS_LVDSCRT1Data SiS_LVDSCRT1640x480_1_H[] =
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1423:38: warning: 'SiS_LVDSCRT1640x480_1' defined but not used [-Wunused-const-variable=]
    1423 | static const struct SiS_LVDSCRT1Data SiS_LVDSCRT1640x480_1[] =
         |                                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1398:38: warning: 'SiS_LVDSCRT1320x240_3_H' defined but not used [-Wunused-const-variable=]
    1398 | static const struct SiS_LVDSCRT1Data SiS_LVDSCRT1320x240_3_H[] =
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1373:38: warning: 'SiS_LVDSCRT1320x240_3' defined but not used [-Wunused-const-variable=]
    1373 | static const struct SiS_LVDSCRT1Data SiS_LVDSCRT1320x240_3[] =
         |                                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1348:38: warning: 'SiS_LVDSCRT1320x240_2_H' defined but not used [-Wunused-const-variable=]
    1348 | static const struct SiS_LVDSCRT1Data SiS_LVDSCRT1320x240_2_H[] =
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1318:38: warning: 'SiS_LVDSCRT1320x240_2' defined but not used [-Wunused-const-variable=]
    1318 | static const struct SiS_LVDSCRT1Data SiS_LVDSCRT1320x240_2[] =
         |                                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1293:38: warning: 'SiS_LVDSCRT1320x240_1' defined but not used [-Wunused-const-variable=]
    1293 | static const struct SiS_LVDSCRT1Data SiS_LVDSCRT1320x240_1[] =
         |                                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1280:34: warning: 'SiS_CHTVONTSCData' defined but not used [-Wunused-const-variable=]
    1280 | static const struct SiS_LVDSData SiS_CHTVONTSCData[]=
         |                                  ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1269:34: warning: 'SiS_CHTVUNTSCData' defined but not used [-Wunused-const-variable=]
    1269 | static const struct SiS_LVDSData SiS_CHTVUNTSCData[]=
         |                                  ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1258:34: warning: 'SiS_LVDS1024x768Data_1' defined but not used [-Wunused-const-variable=]
    1258 | static const struct SiS_LVDSData SiS_LVDS1024x768Data_1[]=
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1247:34: warning: 'SiS_LVDS1024x600Data_1' defined but not used [-Wunused-const-variable=]
    1247 | static const struct SiS_LVDSData SiS_LVDS1024x600Data_1[] =
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1237:34: warning: 'SiS_LVDS800x600Data_1' defined but not used [-Wunused-const-variable=]
    1237 | static const struct SiS_LVDSData SiS_LVDS800x600Data_1[]=
         |                                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1228:34: warning: 'SiS_LVDS640x480Data_1' defined but not used [-Wunused-const-variable=]
    1228 | static const struct SiS_LVDSData SiS_LVDS640x480Data_1[]=
         |                                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1217:34: warning: 'SiS_LVDS320x240Data_2' defined but not used [-Wunused-const-variable=]
    1217 | static const struct SiS_LVDSData SiS_LVDS320x240Data_2[]=
         |                                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1206:34: warning: 'SiS_LVDS320x240Data_1' defined but not used [-Wunused-const-variable=]
    1206 | static const struct SiS_LVDSData SiS_LVDS320x240Data_1[]=
         |                                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1163:33: warning: 'SiS_NoScaleData' defined but not used [-Wunused-const-variable=]
    1163 | static const struct SiS_LCDData SiS_NoScaleData[] =
         |                                 ^~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1143:33: warning: 'SiS_ExtLCD1600x1200Data' defined but not used [-Wunused-const-variable=]
    1143 | static const struct SiS_LCDData SiS_ExtLCD1600x1200Data[] =
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1125:33: warning: 'SiS_StLCD1600x1200Data' defined but not used [-Wunused-const-variable=]
    1125 | static const struct SiS_LCDData SiS_StLCD1600x1200Data[] =
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1107:33: warning: 'SiS_LCD1680x1050Data' defined but not used [-Wunused-const-variable=]
    1107 | static const struct SiS_LCDData SiS_LCD1680x1050Data[] =
         |                                 ^~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1086:33: warning: 'SiS_ExtLCD1400x1050Data' defined but not used [-Wunused-const-variable=]
    1086 | static const struct SiS_LCDData SiS_ExtLCD1400x1050Data[] =
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1068:33: warning: 'SiS_StLCD1400x1050Data' defined but not used [-Wunused-const-variable=]
    1068 | static const struct SiS_LCDData SiS_StLCD1400x1050Data[] =
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1050:33: warning: 'SiS_LCD1280x960Data' defined but not used [-Wunused-const-variable=]
    1050 | static const struct SiS_LCDData SiS_LCD1280x960Data[] =
         |                                 ^~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1032:33: warning: 'SiS_LCD1280x854Data' defined but not used [-Wunused-const-variable=]
    1032 | static const struct SiS_LCDData SiS_LCD1280x854Data[] = /* 2.21.00CS (LVDS) */
         |                                 ^~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:1000:33: warning: 'SiS_LCD1280x800_2Data' defined but not used [-Wunused-const-variable=]
    1000 | static const struct SiS_LCDData SiS_LCD1280x800_2Data[] = /* 2.03.00 (LVDS) */
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:985:33: warning: 'SiS_LCD1280x800Data' defined but not used [-Wunused-const-variable=]
     985 | static const struct SiS_LCDData SiS_LCD1280x800Data[] = /* 0.93.12a (TMDS) */
         |                                 ^~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:953:33: warning: 'SiS_ExtLCD1280x768_2Data' defined but not used [-Wunused-const-variable=]
     953 | static const struct SiS_LCDData SiS_ExtLCD1280x768_2Data[] = /* 2.03.00 */
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:938:33: warning: 'SiS_StLCD1280x768_2Data' defined but not used [-Wunused-const-variable=]
     938 | static const struct SiS_LCDData SiS_StLCD1280x768_2Data[] = /* 2.03.00 */
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:916:33: warning: 'SiS_LCD1280x720Data' defined but not used [-Wunused-const-variable=]
     916 | static const struct SiS_LCDData SiS_LCD1280x720Data[] =  /* 2.03.00 */
         |                                 ^~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:902:32: warning: 'SiS_Ext750pData' defined but not used [-Wunused-const-variable=]
     902 | static const struct SiS_TVData SiS_Ext750pData[] =
         |                                ^~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:893:32: warning: 'SiS_St750pData' defined but not used [-Wunused-const-variable=]
     893 | static const struct SiS_TVData SiS_St750pData[] =
         |                                ^~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:884:32: warning: 'SiS_St525pData' defined but not used [-Wunused-const-variable=]
     884 | static const struct SiS_TVData SiS_St525pData[] =
         |                                ^~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:868:32: warning: 'SiS_ExtHiTVData' defined but not used [-Wunused-const-variable=]
     868 | static const struct SiS_TVData SiS_ExtHiTVData[] =


vim +/SiS_Part2CLVX_6 +239 drivers/video/fbdev/sis/init301.c

5908986ef3481b7 Arnd Bergmann 2018-03-12  175  
5908986ef3481b7 Arnd Bergmann 2018-03-12 @176  static const unsigned char SiS_Part2CLVX_1[] = {
5908986ef3481b7 Arnd Bergmann 2018-03-12  177      0x00,0x00,
5908986ef3481b7 Arnd Bergmann 2018-03-12  178      0x00,0x20,0x00,0x00,0x7F,0x20,0x02,0x7F,0x7D,0x20,0x04,0x7F,0x7D,0x1F,0x06,0x7E,
5908986ef3481b7 Arnd Bergmann 2018-03-12  179      0x7C,0x1D,0x09,0x7E,0x7C,0x1B,0x0B,0x7E,0x7C,0x19,0x0E,0x7D,0x7C,0x17,0x11,0x7C,
5908986ef3481b7 Arnd Bergmann 2018-03-12  180      0x7C,0x14,0x14,0x7C,0x7C,0x11,0x17,0x7C,0x7D,0x0E,0x19,0x7C,0x7E,0x0B,0x1B,0x7C,
5908986ef3481b7 Arnd Bergmann 2018-03-12  181      0x7E,0x09,0x1D,0x7C,0x7F,0x06,0x1F,0x7C,0x7F,0x04,0x20,0x7D,0x00,0x02,0x20,0x7E
5908986ef3481b7 Arnd Bergmann 2018-03-12  182  };
5908986ef3481b7 Arnd Bergmann 2018-03-12  183  
5908986ef3481b7 Arnd Bergmann 2018-03-12 @184  static const unsigned char SiS_Part2CLVX_2[] = {
5908986ef3481b7 Arnd Bergmann 2018-03-12  185      0x00,0x00,
5908986ef3481b7 Arnd Bergmann 2018-03-12  186      0x00,0x20,0x00,0x00,0x7F,0x20,0x02,0x7F,0x7D,0x20,0x04,0x7F,0x7D,0x1F,0x06,0x7E,
5908986ef3481b7 Arnd Bergmann 2018-03-12  187      0x7C,0x1D,0x09,0x7E,0x7C,0x1B,0x0B,0x7E,0x7C,0x19,0x0E,0x7D,0x7C,0x17,0x11,0x7C,
5908986ef3481b7 Arnd Bergmann 2018-03-12  188      0x7C,0x14,0x14,0x7C,0x7C,0x11,0x17,0x7C,0x7D,0x0E,0x19,0x7C,0x7E,0x0B,0x1B,0x7C,
5908986ef3481b7 Arnd Bergmann 2018-03-12  189      0x7E,0x09,0x1D,0x7C,0x7F,0x06,0x1F,0x7C,0x7F,0x04,0x20,0x7D,0x00,0x02,0x20,0x7E
5908986ef3481b7 Arnd Bergmann 2018-03-12  190  };
5908986ef3481b7 Arnd Bergmann 2018-03-12  191  
5908986ef3481b7 Arnd Bergmann 2018-03-12 @192  static const unsigned char SiS_Part2CLVX_3[] = {  /* NTSC, 525i, 525p */
5908986ef3481b7 Arnd Bergmann 2018-03-12  193      0xE0,0x01,
5908986ef3481b7 Arnd Bergmann 2018-03-12  194      0x04,0x1A,0x04,0x7E,0x03,0x1A,0x06,0x7D,0x01,0x1A,0x08,0x7D,0x00,0x19,0x0A,0x7D,
5908986ef3481b7 Arnd Bergmann 2018-03-12  195      0x7F,0x19,0x0C,0x7C,0x7E,0x18,0x0E,0x7C,0x7E,0x17,0x10,0x7B,0x7D,0x15,0x12,0x7C,
5908986ef3481b7 Arnd Bergmann 2018-03-12  196      0x7D,0x13,0x13,0x7D,0x7C,0x12,0x15,0x7D,0x7C,0x10,0x17,0x7D,0x7C,0x0E,0x18,0x7E,
5908986ef3481b7 Arnd Bergmann 2018-03-12  197      0x7D,0x0C,0x19,0x7E,0x7D,0x0A,0x19,0x00,0x7D,0x08,0x1A,0x01,0x7E,0x06,0x1A,0x02,
5908986ef3481b7 Arnd Bergmann 2018-03-12  198      0x58,0x02,
5908986ef3481b7 Arnd Bergmann 2018-03-12  199      0x07,0x14,0x07,0x7E,0x06,0x14,0x09,0x7D,0x05,0x14,0x0A,0x7D,0x04,0x13,0x0B,0x7E,
5908986ef3481b7 Arnd Bergmann 2018-03-12  200      0x03,0x13,0x0C,0x7E,0x02,0x12,0x0D,0x7F,0x01,0x12,0x0E,0x7F,0x01,0x11,0x0F,0x7F,
5908986ef3481b7 Arnd Bergmann 2018-03-12  201      0x00,0x10,0x10,0x00,0x7F,0x0F,0x11,0x01,0x7F,0x0E,0x12,0x01,0x7E,0x0D,0x12,0x03,
5908986ef3481b7 Arnd Bergmann 2018-03-12  202      0x7E,0x0C,0x13,0x03,0x7E,0x0B,0x13,0x04,0x7E,0x0A,0x14,0x04,0x7D,0x09,0x14,0x06,
5908986ef3481b7 Arnd Bergmann 2018-03-12  203      0x00,0x03,
5908986ef3481b7 Arnd Bergmann 2018-03-12  204      0x09,0x0F,0x09,0x7F,0x08,0x0F,0x09,0x00,0x07,0x0F,0x0A,0x00,0x06,0x0F,0x0A,0x01,
5908986ef3481b7 Arnd Bergmann 2018-03-12  205      0x06,0x0E,0x0B,0x01,0x05,0x0E,0x0B,0x02,0x04,0x0E,0x0C,0x02,0x04,0x0D,0x0C,0x03,
5908986ef3481b7 Arnd Bergmann 2018-03-12  206      0x03,0x0D,0x0D,0x03,0x02,0x0C,0x0D,0x05,0x02,0x0C,0x0E,0x04,0x01,0x0B,0x0E,0x06,
5908986ef3481b7 Arnd Bergmann 2018-03-12  207      0x01,0x0B,0x0E,0x06,0x00,0x0A,0x0F,0x07,0x00,0x0A,0x0F,0x07,0x00,0x09,0x0F,0x08,
5908986ef3481b7 Arnd Bergmann 2018-03-12  208      0xFF,0xFF
5908986ef3481b7 Arnd Bergmann 2018-03-12  209  };
5908986ef3481b7 Arnd Bergmann 2018-03-12  210  
5908986ef3481b7 Arnd Bergmann 2018-03-12 @211  static const unsigned char SiS_Part2CLVX_4[] = {   /* PAL */
5908986ef3481b7 Arnd Bergmann 2018-03-12  212      0x58,0x02,
5908986ef3481b7 Arnd Bergmann 2018-03-12  213      0x05,0x19,0x05,0x7D,0x03,0x19,0x06,0x7E,0x02,0x19,0x08,0x7D,0x01,0x18,0x0A,0x7D,
5908986ef3481b7 Arnd Bergmann 2018-03-12  214      0x00,0x18,0x0C,0x7C,0x7F,0x17,0x0E,0x7C,0x7E,0x16,0x0F,0x7D,0x7E,0x14,0x11,0x7D,
5908986ef3481b7 Arnd Bergmann 2018-03-12  215      0x7D,0x13,0x13,0x7D,0x7D,0x11,0x14,0x7E,0x7D,0x0F,0x16,0x7E,0x7D,0x0E,0x17,0x7E,
5908986ef3481b7 Arnd Bergmann 2018-03-12  216      0x7D,0x0C,0x18,0x7F,0x7D,0x0A,0x18,0x01,0x7D,0x08,0x19,0x02,0x7D,0x06,0x19,0x04,
5908986ef3481b7 Arnd Bergmann 2018-03-12  217      0x00,0x03,
5908986ef3481b7 Arnd Bergmann 2018-03-12  218      0x08,0x12,0x08,0x7E,0x07,0x12,0x09,0x7E,0x06,0x12,0x0A,0x7E,0x05,0x11,0x0B,0x7F,
5908986ef3481b7 Arnd Bergmann 2018-03-12  219      0x04,0x11,0x0C,0x7F,0x03,0x11,0x0C,0x00,0x03,0x10,0x0D,0x00,0x02,0x0F,0x0E,0x01,
5908986ef3481b7 Arnd Bergmann 2018-03-12  220      0x01,0x0F,0x0F,0x01,0x01,0x0E,0x0F,0x02,0x00,0x0D,0x10,0x03,0x7F,0x0C,0x11,0x04,
5908986ef3481b7 Arnd Bergmann 2018-03-12  221      0x7F,0x0C,0x11,0x04,0x7F,0x0B,0x11,0x05,0x7E,0x0A,0x12,0x06,0x7E,0x09,0x12,0x07,
5908986ef3481b7 Arnd Bergmann 2018-03-12  222      0x40,0x02,
5908986ef3481b7 Arnd Bergmann 2018-03-12  223      0x04,0x1A,0x04,0x7E,0x02,0x1B,0x05,0x7E,0x01,0x1A,0x07,0x7E,0x00,0x1A,0x09,0x7D,
5908986ef3481b7 Arnd Bergmann 2018-03-12  224      0x7F,0x19,0x0B,0x7D,0x7E,0x18,0x0D,0x7D,0x7D,0x17,0x10,0x7C,0x7D,0x15,0x12,0x7C,
5908986ef3481b7 Arnd Bergmann 2018-03-12  225      0x7C,0x14,0x14,0x7C,0x7C,0x12,0x15,0x7D,0x7C,0x10,0x17,0x7D,0x7C,0x0D,0x18,0x7F,
5908986ef3481b7 Arnd Bergmann 2018-03-12  226      0x7D,0x0B,0x19,0x7F,0x7D,0x09,0x1A,0x00,0x7D,0x07,0x1A,0x02,0x7E,0x05,0x1B,0x02,
5908986ef3481b7 Arnd Bergmann 2018-03-12  227      0xFF,0xFF
5908986ef3481b7 Arnd Bergmann 2018-03-12  228  };
5908986ef3481b7 Arnd Bergmann 2018-03-12  229  
5908986ef3481b7 Arnd Bergmann 2018-03-12 @230  static const unsigned char SiS_Part2CLVX_5[] = {   /* 750p */
5908986ef3481b7 Arnd Bergmann 2018-03-12  231      0x00,0x03,
5908986ef3481b7 Arnd Bergmann 2018-03-12  232      0x05,0x19,0x05,0x7D,0x03,0x19,0x06,0x7E,0x02,0x19,0x08,0x7D,0x01,0x18,0x0A,0x7D,
5908986ef3481b7 Arnd Bergmann 2018-03-12  233      0x00,0x18,0x0C,0x7C,0x7F,0x17,0x0E,0x7C,0x7E,0x16,0x0F,0x7D,0x7E,0x14,0x11,0x7D,
5908986ef3481b7 Arnd Bergmann 2018-03-12  234      0x7D,0x13,0x13,0x7D,0x7D,0x11,0x14,0x7E,0x7D,0x0F,0x16,0x7E,0x7D,0x0E,0x17,0x7E,
5908986ef3481b7 Arnd Bergmann 2018-03-12  235      0x7D,0x0C,0x18,0x7F,0x7D,0x0A,0x18,0x01,0x7D,0x08,0x19,0x02,0x7D,0x06,0x19,0x04,
5908986ef3481b7 Arnd Bergmann 2018-03-12  236      0xFF,0xFF
5908986ef3481b7 Arnd Bergmann 2018-03-12  237  };
5908986ef3481b7 Arnd Bergmann 2018-03-12  238  
5908986ef3481b7 Arnd Bergmann 2018-03-12 @239  static const unsigned char SiS_Part2CLVX_6[] = {   /* 1080i */
5908986ef3481b7 Arnd Bergmann 2018-03-12  240      0x00,0x04,
5908986ef3481b7 Arnd Bergmann 2018-03-12  241      0x04,0x1A,0x04,0x7E,0x02,0x1B,0x05,0x7E,0x01,0x1A,0x07,0x7E,0x00,0x1A,0x09,0x7D,
5908986ef3481b7 Arnd Bergmann 2018-03-12  242      0x7F,0x19,0x0B,0x7D,0x7E,0x18,0x0D,0x7D,0x7D,0x17,0x10,0x7C,0x7D,0x15,0x12,0x7C,
5908986ef3481b7 Arnd Bergmann 2018-03-12  243      0x7C,0x14,0x14,0x7C,0x7C,0x12,0x15,0x7D,0x7C,0x10,0x17,0x7D,0x7C,0x0D,0x18,0x7F,
5908986ef3481b7 Arnd Bergmann 2018-03-12  244      0x7D,0x0B,0x19,0x7F,0x7D,0x09,0x1A,0x00,0x7D,0x07,0x1A,0x02,0x7E,0x05,0x1B,0x02,
5908986ef3481b7 Arnd Bergmann 2018-03-12  245      0xFF,0xFF,
5908986ef3481b7 Arnd Bergmann 2018-03-12  246  };
5908986ef3481b7 Arnd Bergmann 2018-03-12  247  

:::::: The code at line 239 was first introduced by commit
:::::: 5908986ef3481b7ac783642733a4ab91c15c7550 video: fbdev: sis: avoid mismatched prototypes

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
