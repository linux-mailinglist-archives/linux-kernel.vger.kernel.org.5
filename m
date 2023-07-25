Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3130576229C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjGYTrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGYTrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:47:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8141FF7;
        Tue, 25 Jul 2023 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690314440; x=1721850440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iYyiH/seA0PV9vabelhVPt3S47rffBj5ZGMDDUyw+Zc=;
  b=lgQqLgIuTEXosrHhlKsc7suUSA3sgt61TiUH8+MkdYLPr1iKBAGATHD8
   JCqK1nguofoaIz7285Y9ZtTjr7B5ec9jSUMsuVSRjGuXWgzx8shDTTbJa
   ARAade3SCXncaNy5Ft1QpBxhIhlWfVAXb3FMWLXKCL+lmV7OvjZAPm+Ag
   AggiUNvjsfyAskoD1uST/CIOFuTrkeByUAi26+TVaqS+5BfxbH0AFy/1J
   afOyUeaTFlRVUzywe+GxEbAAWurTY6Nsz7nOQK0csq9Yw7TLRl61cBa7h
   13tvhEPTPno/6fr/kK1oaDtwLAfeMbBcQvPSUz6DI/wsN2+1sO3sWDy3t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="366710901"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="366710901"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 12:47:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="839957352"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="839957352"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jul 2023 12:47:15 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOO02-0000IH-1J;
        Tue, 25 Jul 2023 19:47:14 +0000
Date:   Wed, 26 Jul 2023 03:46:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
Subject: Re: [PATCH v7 08/13] coresight-tpdm: Add node to set dsb programming
 mode
Message-ID: <202307260312.vf3OCV58-lkp@intel.com>
References: <1690269353-10829-9-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690269353-10829-9-git-send-email-quic_taozha@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.5-rc3 next-20230725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tao-Zhang/coresight-tpdm-Remove-the-unnecessary-lock/20230725-152235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/1690269353-10829-9-git-send-email-quic_taozha%40quicinc.com
patch subject: [PATCH v7 08/13] coresight-tpdm: Add node to set dsb programming mode
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260312.vf3OCV58-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307260312.vf3OCV58-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm:50: WARNING: Unexpected indentation.
>> Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm:50: WARNING: Block quote ends without a blank line; unexpected unindent.

vim +50 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm

  > 50	Date:		March 2023

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
