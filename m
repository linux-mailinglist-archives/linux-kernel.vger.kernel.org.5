Return-Path: <linux-kernel+bounces-11121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681D781E199
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 17:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06C52820F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 16:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8311F18C;
	Mon, 25 Dec 2023 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="u4gy7Mgm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF3651C26
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DO3IVj/i1qvBZ1bJmTFOQff7XWWb25de+GHNZH7f/tI=;
  b=u4gy7MgmBl3mZLYRguhzGJU+F9ReZt6IAemO1qcGe+6/7n2BYzszHV8c
   uhXPcjI+AuwGCwveSq1lA8VZ9zVZgfwwrgujNiGJHon9TJ75ZJR//3R3Q
   DjXrztRqFSslp6KFaWYUHAwB+3LTh/pHFMJTapEG0F/Eo+gzCs2TSE8il
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,303,1695679200"; 
   d="scan'208";a="143987498"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 17:37:14 +0100
Date: Mon, 25 Dec 2023 17:37:13 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Wenjing Liu <wenjing.liu@amd.com>, 
    Alex Deucher <alexander.deucher@amd.com>, 
    George Shen <George.Shen@amd.com>, Jun Lei <Jun.Lei@amd.com>
cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c:220:21-22:
 WARNING opportunity for max() (fwd)
Message-ID: <alpine.DEB.2.22.394.2312251736310.3331@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Tue, 26 Dec 2023 00:30:41 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c:220:21-22:
    WARNING opportunity for max()

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Wenjing Liu <wenjing.liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
CC: George Shen <George.Shen@amd.com>
CC: Jun Lei <Jun.Lei@amd.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861deac3b092f37b2c5e6871732f3e11486f7082
commit: bc33f5e5f05ba44e48909e2cfc5a97475ec69a4d drm/amd/display: create accessories, hwss and protocols sub folders in link
date:   11 months ago
:::::: branch date: 2 days ago
:::::: commit date: 11 months ago
config: loongarch-randconfig-r062-20231222 (https://download.01.org/0day-ci/archive/20231226/202312260025.3KcJ7K0e-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202312260025.3KcJ7K0e-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c:220:21-22: WARNING opportunity for max()
   drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c:227:21-22: WARNING opportunity for max()

vim +220 drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c

4562236b3bc0a2 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-09-12  204
4562236b3bc0a2 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-09-12  205  static uint32_t defer_delay_converter_wa(
4562236b3bc0a2 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-09-12  206  	struct ddc_service *ddc,
4562236b3bc0a2 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-09-12  207  	uint32_t defer_delay)
4562236b3bc0a2 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-09-12  208  {
d0778ebfd58f56 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-07-22  209  	struct dc_link *link = ddc->link;
4562236b3bc0a2 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-09-12  210
fd952d436446cf drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Taimur Hassan  2021-01-15  211  	if (link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_VGA_CONVERTER &&
fd952d436446cf drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Taimur Hassan  2021-01-15  212  		link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_0080E1 &&
10a9accd4842e6 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Ilya           2022-02-10  213  		(link->dpcd_caps.branch_fw_revision[0] < 0x01 ||
10a9accd4842e6 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Ilya           2022-02-10  214  				(link->dpcd_caps.branch_fw_revision[0] == 0x01 &&
10a9accd4842e6 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Ilya           2022-02-10  215  				link->dpcd_caps.branch_fw_revision[1] < 0x40)) &&
fd952d436446cf drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Taimur Hassan  2021-01-15  216  		!memcmp(link->dpcd_caps.branch_dev_name,
fd952d436446cf drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Taimur Hassan  2021-01-15  217  		    DP_VGA_DONGLE_BRANCH_DEV_NAME,
fd952d436446cf drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Taimur Hassan  2021-01-15  218  			sizeof(link->dpcd_caps.branch_dev_name)))
fd952d436446cf drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Taimur Hassan  2021-01-15  219
fd952d436446cf drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Taimur Hassan  2021-01-15 @220  		return defer_delay > DPVGA_DONGLE_AUX_DEFER_WA_DELAY ?
fd952d436446cf drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Taimur Hassan  2021-01-15  221  			defer_delay : DPVGA_DONGLE_AUX_DEFER_WA_DELAY;
fd952d436446cf drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Taimur Hassan  2021-01-15  222
df3b7e32ed459a drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Qingqing Zhuo  2019-07-31  223  	if (link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_0080E1 &&
4562236b3bc0a2 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-09-12  224  	    !memcmp(link->dpcd_caps.branch_dev_name,
4562236b3bc0a2 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-09-12  225  		    DP_DVI_CONVERTER_ID_4,
4562236b3bc0a2 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-09-12  226  		    sizeof(link->dpcd_caps.branch_dev_name)))
4562236b3bc0a2 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-09-12  227  		return defer_delay > I2C_OVER_AUX_DEFER_WA_DELAY ?
4562236b3bc0a2 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-09-12  228  			defer_delay : I2C_OVER_AUX_DEFER_WA_DELAY;
7154a51b534707 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c jinlong zhang  2020-09-25  229  	if (link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_006037 &&
7154a51b534707 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c jinlong zhang  2020-09-25  230  	    !memcmp(link->dpcd_caps.branch_dev_name,
7154a51b534707 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c jinlong zhang  2020-09-25  231  		    DP_DVI_CONVERTER_ID_5,
7154a51b534707 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c jinlong zhang  2020-09-25  232  		    sizeof(link->dpcd_caps.branch_dev_name)))
7154a51b534707 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c jinlong zhang  2020-09-25  233  		return defer_delay > I2C_OVER_AUX_DEFER_WA_DELAY_1MS ?
7154a51b534707 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c jinlong zhang  2020-09-25  234  			I2C_OVER_AUX_DEFER_WA_DELAY_1MS : defer_delay;
4562236b3bc0a2 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-09-12  235
4562236b3bc0a2 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-09-12  236  	return defer_delay;
4562236b3bc0a2 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-09-12  237  }
4562236b3bc0a2 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c Harry Wentland 2017-09-12  238

:::::: The code at line 220 was first introduced by commit
:::::: fd952d436446cffdf97a61bf456a0987011e42e0 drm/amd/display: Workaround for some legacy DP-VGA dongles

:::::: TO: Taimur Hassan <syed.hassan@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

