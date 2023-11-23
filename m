Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698ED7F56F9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344522AbjKWDRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344456AbjKWDRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:17:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2901B2;
        Wed, 22 Nov 2023 19:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700709438; x=1732245438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iAcQ4HN8CRNfclzvo2vl89aCCXDlyLDgI/O6GQnrGRM=;
  b=c1EATnyCrAyNUnUUQ+415OOMHpNoQ/KrF4HtMOO9WnQNT8gEf5VJXUvE
   0qMZhWMYu8t9fTxblzvhlsqHTq2GshbZBL78vBTdvXVyS8Ue3xld2PlrE
   iVFtZ9DiGEMahT7p78Wiji9vde6oIPct90dwHKuzOpWnqbQh9xbnIEdlh
   o8LLwGgf+5Dl8bD4nVVm+z6EM/1gTSZX+tM2IUlmK30jtdkw8EmnwsyEC
   kLyxnfrr/I010RTspgeffigDNm7Z9zRpq9c/AYxUYj3iYQ1UM3vgofAgE
   F9fpLW4+3gwLqqeEzGdz0rHTbuYmPeWibAkn7N2igf4XACD+AHElDh9Kt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="372348547"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="372348547"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 19:17:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="8521855"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 22 Nov 2023 19:17:15 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r60DI-0001As-0h;
        Thu, 23 Nov 2023 03:17:12 +0000
Date:   Thu, 23 Nov 2023 11:17:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Simek <monstr@monstr.eu>, conor@kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        git@xilinx.com, robh@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: soc: xilinx: Move xilinx.yaml from
 arm to soc
Message-ID: <202311231036.ZQvuqOs2-lkp@intel.com>
References: <281ed28bccc14e7006caf17d6cfeb2a679b0e255.1700648588.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <281ed28bccc14e7006caf17d6cfeb2a679b0e255.1700648588.git.michal.simek@amd.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc2 next-20231122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Simek/dt-bindings-soc-Add-new-board-description-for-MicroBlaze-V/20231122-234634
base:   linus/master
patch link:    https://lore.kernel.org/r/281ed28bccc14e7006caf17d6cfeb2a679b0e255.1700648588.git.michal.simek%40amd.com
patch subject: [PATCH v3 1/2] dt-bindings: soc: xilinx: Move xilinx.yaml from arm to soc
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231123/202311231036.ZQvuqOs2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311231036.ZQvuqOs2-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
    	 $id: http://devicetree.org/schemas/arm/xilinx.yaml
    	file: Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
