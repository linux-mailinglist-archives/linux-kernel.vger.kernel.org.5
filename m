Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57E17FAEEC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjK1ATg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1ATf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:19:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E962192;
        Mon, 27 Nov 2023 16:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701130781; x=1732666781;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m4hnithTNjgXBjhTnLc84gB3+CVEbfaWk2bfkvNoaT4=;
  b=bla1sqwCp3BqVOb0yNJn7Qulw7ykE3EvsBAY+q7mTZ90vbkrxrEcjynC
   pN2uQD4UKQ4DyzT/B4AD5ImJsOm/frkbhOz1n/g04EOs6Slt7wb/0b13C
   +mYS3CnDPya5Opo+FQ/pUHbJjdAKKQV0dJybrh4gjjWZn+ohUCwAhcK9L
   2geGUhMWY2zl/cKGH23xHq9ze1My02K/Vt+AHVTb0k9vUx4iSwfLSJrHr
   ZN38jY605pVZYfYB2r4haFYSlym/drixrW4juQPKZKO34C4hJF72bhCcj
   hwQMaIcQq3PDnotszETMMtCoLuaALjZSmt7nKnzer3e8xmzHomYmFJqaM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="14374357"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="14374357"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 16:19:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="941743828"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="941743828"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Nov 2023 16:19:39 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r7lpA-0006nu-35;
        Tue, 28 Nov 2023 00:19:36 +0000
Date:   Tue, 28 Nov 2023 08:19:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-doc@vger.kernel.org
Subject: dtbs_check:
 Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml:
 properties:honeywell,pmin-pascal: '$ref' should not be valid under {'const':
 '$ref'}
Message-ID: <202311280502.L6YVZhv5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
commit: a765c985e69671054f397046b1d94d8c6e34149e dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor
date:   6 months ago
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231128/202311280502.L6YVZhv5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311280502.L6YVZhv5-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml: allOf:0:if:properties:compatible:contains:enum: 'oneOf' conditional failed, one must be fixed:
   	{'const': 'brcm,bcm4908-usb-phy'} is not of type 'integer'
   	{'const': 'brcm,bcm4908-usb-phy'} is not of type 'string'
   	{'const': 'brcm,brcmstb-usb-phy'} is not of type 'integer'
   	{'const': 'brcm,brcmstb-usb-phy'} is not of type 'string'
   	hint: "enum" must be an array of either integers or strings
   	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
   Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml: title: 'Broadcom BCM63268 Timer Clock and Reset Device Tree Bindings' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
   	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
   	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
>> Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml: properties:honeywell,pmin-pascal: '$ref' should not be valid under {'const': '$ref'}
   	hint: Standard unit suffix properties don't need a type $ref
   	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
>> Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml: properties:honeywell,pmax-pascal: '$ref' should not be valid under {'const': '$ref'}
   	hint: Standard unit suffix properties don't need a type $ref
   	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
   Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml: title: 'Common TI PRU Consumer Binding' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
   	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
   	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
   Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml: title: 'NXP i.MX8MP AudioMIX Block Control Binding' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
   	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
   	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
   Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml: properties:microchip,mic-pos:items: 'oneOf' conditional failed, one must be fixed:
   	{'items': [{'description': 'value for DS line'}, {'description': 'value for sampling edge'}], 'anyOf': [{'enum': [[0, 0], [0, 1], [1, 0], [1, 1]]}]} is not of type 'array'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
