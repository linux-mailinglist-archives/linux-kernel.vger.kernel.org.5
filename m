Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C47E7D88A6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjJZS7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjJZS7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:59:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D044D1AD;
        Thu, 26 Oct 2023 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698346781; x=1729882781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w+jkdo2nGAM6bl91xwOy9fzuA08TAFRBLF2hy8Mzcps=;
  b=neA7AY8non8/WxUqysN6om/isnTRyzow1d1jdQWJ10DSmwj7rRD3YCiO
   NPqrC3rjvXf0FJ4rMI6iDHkJmZKrUqZYVxzNZbN+stc6K/7AJdXkGx7DT
   NvqZ86Qpt9w27JPJh4oKDohEYNiNYt8FGvAYMY2texkluhu/U+7xzBBnw
   ynJAthc/294naJAt4BlTkbqebmR18+C5mcNJWCtYKpdPHC07fHLDmM7R3
   hW5JR2qCiQuzegFV6q11Uw2tsOFUkQzSARL6Liaqbpqu6kC1bdlpb/Y7y
   1pIAoEClgSlhcqVHr1kyXFSP3x2bXo7LHRifWZWPe57TX0brBHbkMlBDo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="6249243"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="6249243"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 11:59:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="876068277"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="876068277"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 26 Oct 2023 11:59:37 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qw5Zv-000A3J-0I;
        Thu, 26 Oct 2023 18:59:35 +0000
Date:   Fri, 27 Oct 2023 02:58:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhenhua Huang <quic_zhenhuah@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, quic_tingweiz@quicinc.com,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH v1 3/5] soc: qcom: memory_dump: Add memory dump driver
Message-ID: <202310270221.jqcwE137-lkp@intel.com>
References: <1698052857-6918-4-git-send-email-quic_zhenhuah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698052857-6918-4-git-send-email-quic_zhenhuah@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhenhua,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on arm64/for-next/core linus/master v6.6-rc7 next-20231026]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhenhua-Huang/dt-bindings-soc-qcom-Add-memory_dump-driver-bindings/20231023-172245
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/1698052857-6918-4-git-send-email-quic_zhenhuah%40quicinc.com
patch subject: [PATCH v1 3/5] soc: qcom: memory_dump: Add memory dump driver
reproduce: (https://download.01.org/0day-ci/archive/20231027/202310270221.jqcwE137-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310270221.jqcwE137-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/soc/qcom/qcom,memory_dump.yaml

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
