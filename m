Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9AA7EDAAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 05:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344732AbjKPEY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 23:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjKPEYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 23:24:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13175193;
        Wed, 15 Nov 2023 20:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700108686; x=1731644686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TiPWqw/qM6n/38QVo1PwW/L4da+B9xY4k/95Cn88Zbc=;
  b=Lgmo+62GVcO098ywtoDA50J4yL27ZBw7QPDigHHfcIZ+y40kGWJ1QJOd
   4YjWWkN7NSzG6SzxmUIw4tfmTp7JgeTkzobppdBMBiuSsS62LEjzcbKNW
   KiRpaHYPLXdFlszNAVHwJiEZS/j1LxKvE9hDDd/PoArZlY6cnvHb2TakL
   EwQpgV8m37hRL/0Iesnv4hA8GSEaAEmfbItS0jNG5FS7ezKMY0hNcDZdp
   /TZdVTKpJDrShZ9rPpmysl8f6jIh29w1bXbItOeaVP+rzxISZHLurpfEG
   1q9lmvtY8VsyB/zhjd+wDXFyxHglHopYsT4UTBg/y4bHyfbxAAB3R+m6y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4087191"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="4087191"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 20:24:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768795669"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="768795669"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Nov 2023 20:24:43 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3Tvl-0001Hn-1G;
        Thu, 16 Nov 2023 04:24:41 +0000
Date:   Thu, 16 Nov 2023 12:24:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bryant Mairs <bryant@mai.rs>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6/7] ARM: dts: qcom: apq8026-samsung-milletwifi: Enable
 Wi-Fi and Bluetooth
Message-ID: <202311161232.aXIYGTAD-lkp@intel.com>
References: <20231105204759.37107-7-bryant@mai.rs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105204759.37107-7-bryant@mai.rs>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryant,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on dtor-input/next dtor-input/for-linus linus/master v6.7-rc1 next-20231115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bryant-Mairs/dt-bindings-input-melfas-mms114-add-MMS252-compatible/20231106-045021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231105204759.37107-7-bryant%40mai.rs
patch subject: [PATCH 6/7] ARM: dts: qcom: apq8026-samsung-milletwifi: Enable Wi-Fi and Bluetooth
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20231116/202311161232.aXIYGTAD-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311161232.aXIYGTAD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311161232.aXIYGTAD-lkp@intel.com/

All errors (new ones prefixed by >>):

   Error: arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts:15.15-26 Label or path mba_region not found
   Error: arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts:16.15-27 Label or path mpss_region not found
   Error: arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts:18.15-28 Label or path wcnss_region not found
>> Error: arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts:313.1-8 Label or path pronto not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
