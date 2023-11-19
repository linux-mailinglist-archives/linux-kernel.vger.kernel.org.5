Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0A47F0968
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjKSWXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKSWW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:22:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DF512D;
        Sun, 19 Nov 2023 14:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700432576; x=1731968576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hDVxdCT5ofbYAwo/374uoa2UxFG7xWrnZZjuRvCKBFg=;
  b=DbTQCBx9lIv7KeXuJTHJJFJBeIVHngACqVQ7zLtHSrvh/xEe6x/2x3gc
   pnT9cexwtvjWjjHzlYBV7BnP/wcXQyxgaKOx8XM/uSIuoatKZx4Gf6K38
   vS6dK7JcjAPLZuwXPiA5snvEjSjBm8Ql2KYvNZgVIUgLI8bk/usCjF+xj
   l7r3LPC9er15bpXjorjoET6k+AiIJnPOMt3H+cASJfiJ73dE3JmLQfFd3
   vuV1qZ4zbRDXT2FfXSfIEyRbz/RnW2LZ5hBxZKy//+Zf7TTE0lTYxleVI
   W8Z9d8Yp5zqNCNTgdYeZe/Fe/fqx4cZc8qwV2OoVZq2nIZJIUoU0zR2N8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="10189993"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="10189993"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 14:22:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="13989382"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 19 Nov 2023 14:22:53 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4qBm-0005dX-1f;
        Sun, 19 Nov 2023 22:22:50 +0000
Date:   Mon, 20 Nov 2023 06:21:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH 1/2] iio: light: add VEML6075 UVA and UVB light sensor
 driver
Message-ID: <202311200534.wKn5Bfu1-lkp@intel.com>
References: <20231110-veml6075-v1-1-354b3245e14a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110-veml6075-v1-1-354b3245e14a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b85ea95d086471afb4ad062012a4d73cd328fa86]

url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Carrasco/iio-light-add-VEML6075-UVA-and-UVB-light-sensor-driver/20231119-130003
base:   b85ea95d086471afb4ad062012a4d73cd328fa86
patch link:    https://lore.kernel.org/r/20231110-veml6075-v1-1-354b3245e14a%40gmail.com
patch subject: [PATCH 1/2] iio: light: add VEML6075 UVA and UVB light sensor driver
reproduce: (https://download.01.org/0day-ci/archive/20231120/202311200534.wKn5Bfu1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311200534.wKn5Bfu1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/iio/light/veml6075.yaml

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
