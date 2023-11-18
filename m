Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01357EFD00
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 02:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjKRBh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 20:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRBh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 20:37:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3F7D6D;
        Fri, 17 Nov 2023 17:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700271472; x=1731807472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pMYJRearNjtZkenGLNFLuV6YB4UiY53eVk4RlzqHmMA=;
  b=UQ7jMs4eH7TOnR3JDpljTBRTJKn/FP/3v4XAZDw3kg1YH9YOIBKAhRNr
   MGN59ibu4jq7sjuFlPjhoJo2WnkiJCvzv0uxYF6lkYZAg4Ww/z4unNvOV
   RT2mI+iYPP/1PRdj+0OVu6cU1aBAy0yldU894mvhXpl5QLvjj9DMoNyWg
   ILQ6DWWrnMNq91lxiRLXEjOzSoMH7kzl4TX2aef6xniY0Ier+SR6K+G4U
   39zZnmUC0ur8Vt44KNqC0vlGhMK9N/PIRcMegDh+sJveO8LGxJ6FSiocn
   I8ZvLUpbSTYjSSJDulhFLYfiSLyHYVcfcoyGeqjoFe2uQQx17DXueQo/7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="394247003"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="394247003"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 17:37:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1097265410"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="1097265410"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2023 17:37:49 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4AHL-0003OZ-1R;
        Sat, 18 Nov 2023 01:37:47 +0000
Date:   Sat, 18 Nov 2023 09:37:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Tai <james.tai@realtek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: interrupt-controller: Add support
 for Realtek DHC SoCs
Message-ID: <202311180921.ayKhiFHL-lkp@intel.com>
References: <20231117162709.1096585-2-james.tai@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117162709.1096585-2-james.tai@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on robh/for-next linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Tai/dt-bindings-interrupt-controller-Add-support-for-Realtek-DHC-SoCs/20231118-003036
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20231117162709.1096585-2-james.tai%40realtek.com
patch subject: [PATCH v2 1/6] dt-bindings: interrupt-controller: Add support for Realtek DHC SoCs
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231118/202311180921.ayKhiFHL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311180921.ayKhiFHL-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1619b-intc.yaml: title: 'Realtek DHC RTD1619B Interrupt Controller Device Tree Bindings' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
   	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
   	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
>> Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319-intc.yaml: title: 'Realtek DHC RTD1319 Interrupt Controller Device Tree Bindings' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
   	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
   	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
>> Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319d-intc.yaml: title: 'Realtek DHC RTD1319D Interrupt Controller Device Tree Bindings' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
   	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
   	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
>> Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1325-intc.yaml: title: 'Realtek DHC RTD1325 Interrupt Controller Device Tree Bindings' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
   	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
   	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
