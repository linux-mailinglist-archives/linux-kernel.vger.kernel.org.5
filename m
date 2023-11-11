Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DEC7E8BC1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 17:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjKKQ4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 11:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKQ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 11:56:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4EB3A98;
        Sat, 11 Nov 2023 08:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699721769; x=1731257769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X1K4nrfzoAfrPqvT537HLIANMJRwbCdUtldsJzklx6Y=;
  b=koRisca/nzJeV8jVMqkhADeHB7S5bHp6MC/s5RZgCqC0yXnJlJMMFx0y
   p4M0x4jrrI8TuXbjvAUigy+L5aQYWfjt3DrN9WfNe7Jxc5Cgo0eiLv0fQ
   wN51nmfTu+DIOh1Zg2RHD7kKDucFpg9kqsPE0ZHqkKWHbhQP0azqqAepH
   oR/XOojsKeRzbgTDr6XSZoMf+CeJGa3GmfUvb2QTAgf3Lp82eVYPnund+
   c4ktb/uYNc2acMtnallMiTjkuSMhjoDy+ZtUOrTyEL8/Kenjln+0u7oo4
   hp9XjbEfCVIXsGNwllf0EFL1BweZeTdsPnvYL9Q/ILz2JXtzDzVU98b2h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="380674567"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="380674567"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 08:56:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="5091496"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Nov 2023 08:56:01 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1rH5-000Ad0-0U;
        Sat, 11 Nov 2023 16:55:59 +0000
Date:   Sun, 12 Nov 2023 00:55:03 +0800
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
Subject: Re: [PATCH v2 3/8] dma-buf: heaps: secure_heap: Initialize tee
 session
Message-ID: <202311120053.qXNIYBzk-lkp@intel.com>
References: <20231111111559.8218-4-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111111559.8218-4-yong.wu@mediatek.com>
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

Hi Yong,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on robh/for-next drm-tip/drm-tip linus/master v6.6 next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yong-Wu/dma-buf-heaps-Initialize-a-secure-heap/20231111-192115
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20231111111559.8218-4-yong.wu%40mediatek.com
patch subject: [PATCH v2 3/8] dma-buf: heaps: secure_heap: Initialize tee session
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20231112/202311120053.qXNIYBzk-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311120053.qXNIYBzk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311120053.qXNIYBzk-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/dma-buf/heaps/secure_heap.o: in function `secure_heap_tee_session_init':
   secure_heap.c:(.text+0xc0): undefined reference to `tee_client_open_context'
>> m68k-linux-ld: secure_heap.c:(.text+0x134): undefined reference to `tee_client_open_session'
>> m68k-linux-ld: secure_heap.c:(.text+0x180): undefined reference to `tee_client_close_context'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
