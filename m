Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC077F8BFE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjKYPRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjKYPRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:17:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE1C12B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700925455; x=1732461455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=139b8toziGYJ4TPz+C2NrbBA1ldTf5B8zRgPLW1YMts=;
  b=LS1eX3o/rgE3k/jzLQoCQjd+qb09NnD5Gjob42X7pPpmnwEAdmJHucQ6
   uIcrJHSjkBN20ZFXPz3bo3u88j10PhUd71Y3lA6F1x6qB8Qkw/J/IEFyR
   EJH87R0re806m8Tp/CQEmyQpi1Veaqw0m5gNpPq5EQngRWQleVb3HmooK
   LakKJerSn7/tyFlVeXBuEIUCOin3Av/pfoX8+T4oRoCf2MvYMvd3747F2
   JQO/dWlMhizQuLAFZtub54pJ6RfMLpeFuQrf1iTacqcA/X/lXmHoyIf+L
   4Hrt8jcvXOJXfFXO/5SGm3VMHq6d8lkfAKDNCEWlENJ7AUXyD7TJt/JiE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="5678448"
X-IronPort-AV: E=Sophos;i="6.04,226,1695711600"; 
   d="scan'208";a="5678448"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 07:17:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="838313048"
X-IronPort-AV: E=Sophos;i="6.04,226,1695711600"; 
   d="scan'208";a="838313048"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Nov 2023 07:17:32 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6uPS-00047b-1k;
        Sat, 25 Nov 2023 15:17:30 +0000
Date:   Sat, 25 Nov 2023 23:17:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "mac.shen" <mac.shen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        jitao.shi@mediatek.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mac.shen@mediatek.com, shuijing.li@mediatek.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/mediatek/dp: Add the HDCP feature for DisplayPort
Message-ID: <202311252324.TTPd9IXz-lkp@intel.com>
References: <20231124085346.26602-1-mac.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124085346.26602-1-mac.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi mac.shen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v6.7-rc2]
[cannot apply to pza/reset/next pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/mac-shen/drm-mediatek-dp-Add-the-HDCP-feature-for-DisplayPort/20231125-152640
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20231124085346.26602-1-mac.shen%40mediatek.com
patch subject: [PATCH] drm/mediatek/dp: Add the HDCP feature for DisplayPort
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20231125/202311252324.TTPd9IXz-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231125/202311252324.TTPd9IXz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311252324.TTPd9IXz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/mediatek/mtk_dp.c:349:5: warning: no previous prototype for function 'mtk_dp_read' [-Wmissing-prototypes]
     349 | u32 mtk_dp_read(struct mtk_dp *mtk_dp, u32 offset)
         |     ^
   drivers/gpu/drm/mediatek/mtk_dp.c:349:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     349 | u32 mtk_dp_read(struct mtk_dp *mtk_dp, u32 offset)
         | ^
         | static 
>> drivers/gpu/drm/mediatek/mtk_dp.c:376:5: warning: no previous prototype for function 'mtk_dp_update_bits' [-Wmissing-prototypes]
     376 | int mtk_dp_update_bits(struct mtk_dp *mtk_dp, u32 offset,
         |     ^
   drivers/gpu/drm/mediatek/mtk_dp.c:376:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     376 | int mtk_dp_update_bits(struct mtk_dp *mtk_dp, u32 offset,
         | ^
         | static 
>> drivers/gpu/drm/mediatek/mtk_dp.c:2663:6: warning: no previous prototype for function 'mtk_dp_check_hdcp_version' [-Wmissing-prototypes]
    2663 | void mtk_dp_check_hdcp_version(struct mtk_dp *mtk_dp, bool only_hdcp1x)
         |      ^
   drivers/gpu/drm/mediatek/mtk_dp.c:2663:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    2663 | void mtk_dp_check_hdcp_version(struct mtk_dp *mtk_dp, bool only_hdcp1x)
         | ^
         | static 
   3 warnings generated.


vim +/mtk_dp_read +349 drivers/gpu/drm/mediatek/mtk_dp.c

   348	
 > 349	u32 mtk_dp_read(struct mtk_dp *mtk_dp, u32 offset)
   350	{
   351		return mtk_dp_reg_read(mtk_dp->regs, offset);
   352	}
   353	
   354	static int mtk_dp_write(struct mtk_dp *mtk_dp, u32 offset, u32 val)
   355	{
   356		int ret = regmap_write(mtk_dp->regs, offset, val);
   357	
   358		if (ret)
   359			dev_err(mtk_dp->dev,
   360				"Failed to write register 0x%x with value 0x%x\n",
   361				offset, val);
   362		return ret;
   363	}
   364	
   365	int mtk_dp_reg_update_bits(struct regmap *regs, u32 offset,
   366				   u32 val, u32 mask)
   367	{
   368		int ret = regmap_update_bits(regs, offset, mask, val);
   369	
   370		if (ret)
   371			pr_err("Failed to update register 0x%x with value 0x%x, mask 0x%x\n",
   372			       offset, val, mask);
   373		return ret;
   374	}
   375	
 > 376	int mtk_dp_update_bits(struct mtk_dp *mtk_dp, u32 offset,
   377			       u32 val, u32 mask)
   378	{
   379		return mtk_dp_reg_update_bits(mtk_dp->regs, offset, val, mask);
   380	}
   381	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
