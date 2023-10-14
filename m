Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED1E7C9248
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 04:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjJNCGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 22:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNCG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 22:06:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA347A9;
        Fri, 13 Oct 2023 19:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697249187; x=1728785187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xyjrz+nCGtVP4cpNDKqWDKVaYylaSAY+4OG7ML8ydcU=;
  b=iFkmK4IhZHzcBMlH+dtJjLUysZqJk5vi93PncWoN4+9r19+QNNJ38yIa
   qivKClZlMRKQxTPHRqtM5gPO4pNsSAeRCF6iTE4Yrh4kyacbQSl7u2rm+
   OkphSbTaY9kQidEgZUsjgxSu/FZZYD6UE3dI+RwB8W6vpu83upYv+K9We
   blbCzHXVE92rY0ZQqQ1hTef9MCTGXS0D1iRX3AR3SqVgDVzpk38DfXm2r
   4+UA0pW+SxHpiAU2cfql9E9nj6JjX40ctsaAzMszILBlB4tYQtnjYaJH3
   /xAEkzw1UWEDdS2c0oFALfr/rrhqfg1YzZjaV+4mDvBJy1EMbzHDFVvLh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="384166978"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="384166978"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 19:06:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="754918435"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="754918435"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2023 19:06:23 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qrU2m-0005bv-2y;
        Sat, 14 Oct 2023 02:06:20 +0000
Date:   Sat, 14 Oct 2023 10:05:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Claudiu <claudiu.beznea@tuxon.dev>, geert+renesas@glider.be,
        mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, magnus.damm@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 4/4] clk: renesas: add minimal boot support for RZ/G3S
 SoC
Message-ID: <202310140917.e8Qm1PYJ-lkp@intel.com>
References: <20231006103959.197485-5-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006103959.197485-5-claudiu.beznea.uj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

kernel test robot noticed the following build errors:

[auto build test ERROR on geert-renesas-drivers/renesas-clk]
[cannot apply to tty/tty-testing tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.6-rc5 next-20231013]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Claudiu/dt-bindings-serial-renesas-scif-document-r9a08g045-support/20231006-184301
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git renesas-clk
patch link:    https://lore.kernel.org/r/20231006103959.197485-5-claudiu.beznea.uj%40bp.renesas.com
patch subject: [PATCH v3 4/4] clk: renesas: add minimal boot support for RZ/G3S SoC
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20231014/202310140917.e8Qm1PYJ-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231014/202310140917.e8Qm1PYJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310140917.e8Qm1PYJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clk/renesas/r9a08g045-cpg.c:13:10: fatal error: dt-bindings/clock/r9a08g045-cpg.h: No such file or directory
      13 | #include <dt-bindings/clock/r9a08g045-cpg.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +13 drivers/clk/renesas/r9a08g045-cpg.c

    12	
  > 13	#include <dt-bindings/clock/r9a08g045-cpg.h>
    14	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
