Return-Path: <linux-kernel+bounces-13852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7353821384
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 11:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453BF1F21EFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 10:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8352117;
	Mon,  1 Jan 2024 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+GXuOe8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593D03C2F;
	Mon,  1 Jan 2024 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704105428; x=1735641428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HIM0sDaWfXn7qdB+TXi2x0aCAcMHh1xDl03Qvhdn/+M=;
  b=e+GXuOe85TbqI1t3/jNl2jBZ2pXmvAKogQOoha8wd+0Xc0QG/7vPEyb8
   xx1R2IKJxiWvr5f9YQErpdY7aXG3r5mRdFj9H3u3SvtMqiI67KDxWUYZo
   QRhyA0qyS5Ozc9rqH9QA738btKJjVlD8PgKW/hK4ti0Gec9z5APxVyD62
   SsnmakMtvlv2ALl7lek1kfQw/Xfut1qn2xrrRg2V4GOc3UHwbJsToSDYn
   drORhmPvlHaZ0C5DwN0D2H6e7vOIuALqDRx3EKuavwCRMtwJuq0GnKE9Y
   gB/duqa0usrFyLP7bMn+aWiR7Hxvg2SQMQUXWWERLtesUD2tcyYUsVOf6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="10176350"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="10176350"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 02:37:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="813651597"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="813651597"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 01 Jan 2024 02:37:00 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKFfG-000K8q-0x;
	Mon, 01 Jan 2024 10:36:58 +0000
Date: Mon, 1 Jan 2024 18:35:58 +0800
From: kernel test robot <lkp@intel.com>
To: Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	lee@kernel.org, andriy.shevchenko@linux.intel.com,
	daniel.lezcano@linaro.org, dmitry.baryshkov@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	quic_jprakash@quicinc.com, lars@metafoo.de, luca@z3ntu.xyz,
	marijn.suijten@somainline.org, agross@kernel.org, sboyd@kernel.org,
	rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
	linus.walleij@linaro.org, quic_subbaram@quicinc.com,
	quic_collinsd@quicinc.com, quic_amelende@quicinc.com,
	quic_kamalw@quicinc.com, kernel@quicinc.com,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-msm-owner@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio/adc: Move QCOM ADC bindings to
 iio/adc folder
Message-ID: <202401011830.DUO9bWXw-lkp@intel.com>
References: <20231231171237.3322376-2-quic_jprakash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231231171237.3322376-2-quic_jprakash@quicinc.com>

Hi Jishnu,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20231222]
[cannot apply to robh/for-next jic23-iio/togreg rafael-pm/thermal v6.7-rc7 v6.7-rc6 v6.7-rc5 linus/master v6.7-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jishnu-Prakash/dt-bindings-iio-adc-Move-QCOM-ADC-bindings-to-iio-adc-folder/20240101-011705
base:   next-20231222
patch link:    https://lore.kernel.org/r/20231231171237.3322376-2-quic_jprakash%40quicinc.com
patch subject: [PATCH v3 1/3] dt-bindings: iio/adc: Move QCOM ADC bindings to iio/adc folder
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240101/202401011830.DUO9bWXw-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240101/202401011830.DUO9bWXw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401011830.DUO9bWXw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm/boot/dts/qcom/qcom-apq8026-asus-sparrow.dts:9:
>> arch/arm/boot/dts/qcom/pm8226.dtsi:2:10: fatal error: 'dt-bindings/iio/qcom,spmi-vadc.h' file not found
   #include <dt-bindings/iio/qcom,spmi-vadc.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
   In file included from arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts:8:
>> arch/arm/boot/dts/qcom/pm8941.dtsi:2:10: fatal error: 'dt-bindings/iio/qcom,spmi-vadc.h' file not found
   #include <dt-bindings/iio/qcom,spmi-vadc.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
   In file included from arch/arm/boot/dts/qcom/qcom-apq8084-ifc6540.dts:3:
>> arch/arm/boot/dts/qcom/pma8084.dtsi:2:10: fatal error: 'dt-bindings/iio/qcom,spmi-vadc.h' file not found
   #include <dt-bindings/iio/qcom,spmi-vadc.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
   In file included from arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts:12:
>> arch/arm/boot/dts/qcom/pmx55.dtsi:8:10: fatal error: 'dt-bindings/iio/qcom,spmi-vadc.h' file not found
   #include <dt-bindings/iio/qcom,spmi-vadc.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +2 arch/arm/boot/dts/qcom/pm8226.dtsi

bc6ecf993b1023 arch/arm/boot/dts/qcom-pm8226.dtsi Rayyan Ansari 2022-12-23 @2  #include <dt-bindings/iio/qcom,spmi-vadc.h>
79ca56c11e9004 arch/arm/boot/dts/qcom-pm8226.dtsi Rayyan Ansari 2022-12-23  3  #include <dt-bindings/input/linux-event-codes.h>
266a1139ec1762 arch/arm/boot/dts/qcom-pm8226.dtsi Luca Weiss    2021-09-12  4  #include <dt-bindings/interrupt-controller/irq.h>
266a1139ec1762 arch/arm/boot/dts/qcom-pm8226.dtsi Luca Weiss    2021-09-12  5  #include <dt-bindings/spmi/spmi.h>
266a1139ec1762 arch/arm/boot/dts/qcom-pm8226.dtsi Luca Weiss    2021-09-12  6  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

