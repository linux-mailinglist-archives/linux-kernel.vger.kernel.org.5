Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1827ACCF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 01:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjIXXkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 19:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjIXXkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 19:40:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05D0DA;
        Sun, 24 Sep 2023 16:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695598804; x=1727134804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tTLXRE1soXSYBY2G5ExuJtYE7YESikpbce6IZI55gSg=;
  b=RieCc0P6A+XXmrbpiJmnFvY+6T0UgPiKv4En2c/oFupqG4GuwEs3nLY+
   ZtApjmPJ4BNKyOHLX9jfr9xw7rHdFdYstfanzn77eFwR9XyadHhw/kBS4
   6Ey3jx3F+2Wn7BNO6Y0O/XoPlDCZ+jo8ciAdd3Z7Mpxe38kpB4CE1roau
   ywrLJRWc6Lmz0coLMPqvsqKmk5eIqp3tK5w2qia8hfX2oeYGwYHvFFzkN
   RRnfvapJsZkbmw/B7hFIY+yRW+SQUSpdqgJ46Hwr8/xrgyiJeXHHTEj6F
   nHyJrq6QoxWvQU+G7w8s6EjGvxVXrPvUCrhEEU7WifBNtmoG11KzeZ5sk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="381042092"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="381042092"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 16:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="838402627"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="838402627"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Sep 2023 16:40:00 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkYhi-0000bx-2V;
        Sun, 24 Sep 2023 23:39:58 +0000
Date:   Mon, 25 Sep 2023 07:39:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Kemnade <andreas@kemnade.info>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com,
        jean-baptiste.maneyrol@tdk.com, chenhuiz@axis.com,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/3] dt-bindings: iio: imu: mpu6050: Add level shifter
Message-ID: <202309250753.7v7FAzek-lkp@intel.com>
References: <20230924222559.2038721-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924222559.2038721-2-andreas@kemnade.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.6-rc3 next-20230921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Kemnade/dt-bindings-iio-imu-mpu6050-Add-level-shifter/20230925-062804
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20230924222559.2038721-2-andreas%40kemnade.info
patch subject: [PATCH 1/3] dt-bindings: iio: imu: mpu6050: Add level shifter
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230925/202309250753.7v7FAzek-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309250753.7v7FAzek-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml: properties:invensense,level-shifter: True is not of type 'object'
   	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
   	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml: properties:invensense,level-shifter: More than one condition true in oneOf schema:
   	{'description': 'Vendor specific properties must have a type and '
   	                'description unless they have a defined, common '
   	                'suffix.',
   	 'oneOf': [{'additionalProperties': False,
   	            'description': 'A vendor boolean property can use "type: '
   	                           'boolean"',
   	            'properties': {'deprecated': True,
   	                           'description': True,
   	                           'type': {'const': 'boolean'}},
   	            'required': ['type', 'description']},

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
