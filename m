Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FFF7D1970
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjJTW6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjJTW6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:58:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED368D6D;
        Fri, 20 Oct 2023 15:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697842717; x=1729378717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aEPV/k3NY8uJOB/dkexMNXWNSU+79ekJlzkbVmpGyH0=;
  b=WiMAsH9dXdPxCaUnxgjqrvr1BJn9jIyK1wOd9C5rCKh6IFUK+cOAN/0V
   VXRjfGNSRZpkA6aZ2fY2E0L3oLXm0P4cABO2E4M052nJGp8lJOOLDKxuz
   DZbOoJcWEzYcfcQIR75MHBYLLW+b8dM+SwiLoxQxInxuK62oaE/4h/WX0
   Ns1ZZTc2WdsD5+zQyNZma8J+sxwPlly3R2KkHhpO2GX3sdH8JlK4OrOQ/
   vjidXq7ZrnTIy7DSCsuhZAMAOlTaor8QZIBOyJ8hEIS6FFSSySJ6BICxZ
   7msc+ZbYpNdrmB0qyzDMUtPg997sHm5mN1MT3P7Iiz/0fgCm8X6It2fyu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="417720316"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="417720316"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 15:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="1088877862"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="1088877862"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Oct 2023 15:58:33 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtyRr-00044C-0v;
        Fri, 20 Oct 2023 22:58:31 +0000
Date:   Sat, 21 Oct 2023 06:57:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5 01/15] firmware: qcom: move Qualcomm code into its own
 directory
Message-ID: <202310210628.teHKnfqS-lkp@intel.com>
References: <20231017092732.19983-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017092732.19983-2-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20231017]
[cannot apply to arm64/for-next/core krzk-dt/for-next linus/master v6.6-rc6 v6.6-rc5 v6.6-rc4 v6.6-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/firmware-qcom-move-Qualcomm-code-into-its-own-directory/20231017-173059
base:   next-20231017
patch link:    https://lore.kernel.org/r/20231017092732.19983-2-brgl%40bgdev.pl
patch subject: [PATCH v5 01/15] firmware: qcom: move Qualcomm code into its own directory
config: x86_64-buildonly-randconfig-003-20231021 (https://download.01.org/0day-ci/archive/20231021/202310210628.teHKnfqS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231021/202310210628.teHKnfqS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310210628.teHKnfqS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/qcom/qcom_scm.c:1652:34: warning: 'qcom_scm_qseecom_allowlist' defined but not used [-Wunused-const-variable=]
    1652 | static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/qcom_scm_qseecom_allowlist +1652 drivers/firmware/qcom/qcom_scm.c

00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1647  
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1648  /*
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1649   * We do not yet support re-entrant calls via the qseecom interface. To prevent
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1650   + any potential issues with this, only allow validated machines for now.
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1651   */
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27 @1652  static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1653  	{ .compatible = "lenovo,thinkpad-x13s", },
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1654  	{ }
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1655  };
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1656  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
