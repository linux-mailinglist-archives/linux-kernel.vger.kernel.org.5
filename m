Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4234B7E8D8E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 00:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjKKX21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 18:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKX20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 18:28:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C43B30C5;
        Sat, 11 Nov 2023 15:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699745303; x=1731281303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yLMN9BN0x0GJyChe1fur9BIfuNV27m8XBnDpqqzLe8E=;
  b=VJTYGytqfXGww5m4474Duuj1AOEH13Ef2BQ34cgTvkOAkc5Ru9ceV5PW
   KBOa9ZQ10CmPvFO/35CFcD2nv85ZnUkYTkP4IAia8M/Qa20zrmEk9Rpsm
   +W2+OOP0Ok1eufhMGYnHUNx1uzl6/duRlWs+gAuGHjhDjKlIZyB8L46B1
   JRDxcx5LmAwnHBXsCSicwUtIhRGr4g/0LhYYG93FwVU6F1p8WJMbXz3Tq
   ittUlVkkb1QyGn68/4xeq+2BoXRuYOi793h/6JfFoWt9GYHoQQz6EVcrq
   0eUUUW8D8ONGLM8R3IFQ4CemNh+CVjHe1ClNGp6ZOcURF6Ob7fRJ0vYNj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="3316457"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="3316457"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 15:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="764026399"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="764026399"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Nov 2023 15:28:15 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1xOf-000AoU-1f;
        Sat, 11 Nov 2023 23:28:13 +0000
Date:   Sun, 12 Nov 2023 07:28:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com, Matthias Brugger <matthias.bgg@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
        John Stultz <jstultz@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Vijayanand Jitta <quic_vjitta@quicinc.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Yong Wu <yong.wu@mediatek.com>, jianjiao.zeng@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        ckoenig.leichtzumerken@gmail.com, linaro-mm-sig@lists.linaro.org,
        linux-mediatek@lists.infradead.org,
        Joakim Bech <joakim.bech@linaro.org>, tjmercier@google.com,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        kuohong.wang@mediatek.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dma-buf: heaps: secure_heap: Add tee memory
 service call
Message-ID: <202311120707.FDrzrRME-lkp@intel.com>
References: <20231111111559.8218-5-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111111559.8218-5-yong.wu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yong,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on robh/for-next drm-tip/drm-tip linus/master v6.6 next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yong-Wu/dma-buf-heaps-Initialize-a-secure-heap/20231111-192115
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20231111111559.8218-5-yong.wu%40mediatek.com
patch subject: [PATCH v2 4/8] dma-buf: heaps: secure_heap: Add tee memory service call
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20231112/202311120707.FDrzrRME-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311120707.FDrzrRME-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311120707.FDrzrRME-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc64-linux-ld: warning: discarding dynamic section .glink
   powerpc64-linux-ld: warning: discarding dynamic section .plt
   powerpc64-linux-ld: linkage table error against `tee_client_open_session'
   powerpc64-linux-ld: stubs don't match calculated size
   powerpc64-linux-ld: can not build stubs: bad value
   powerpc64-linux-ld: drivers/dma-buf/heaps/secure_heap.o: in function `secure_heap_tee_session_init':
   secure_heap.c:(.text.secure_heap_tee_session_init+0xd0): undefined reference to `tee_client_open_context'
   powerpc64-linux-ld: secure_heap.c:(.text.secure_heap_tee_session_init+0x2b4): undefined reference to `tee_client_open_session'
   powerpc64-linux-ld: secure_heap.c:(.text.secure_heap_tee_session_init+0x458): undefined reference to `tee_client_close_context'
   powerpc64-linux-ld: drivers/dma-buf/heaps/secure_heap.o: in function `secure_heap_tee_service_call.constprop.0':
>> secure_heap.c:(.text.secure_heap_tee_service_call.constprop.0+0xbc): undefined reference to `tee_client_invoke_func'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
