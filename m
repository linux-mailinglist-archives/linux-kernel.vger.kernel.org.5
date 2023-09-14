Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5BD79F998
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjINEkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjINEkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:40:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DE10E6;
        Wed, 13 Sep 2023 21:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694666401; x=1726202401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UBVevpx8iKvAQZS+erfu48NY+lVMoUPua626oN8p8HU=;
  b=XvC5/Ilr647W+sqvsxinM1nMr8/qG9+fVtaGy2Fh+TqSqSKVYcZ57g9P
   wpQRfuzwvZQJMHhnORT3mc9MDIOwNihv9ttyjeklBn03GvjdzM195TXLY
   lJgSmEPB9QtzVYsqvB/lrI3EPdMOfTddhCH7syupVo7uIJALGfoPikLDK
   AspQZ3Uvwxq+BcLNp0/qoIiYs/JM4h/LacFpgB7/vFXDlyUxMC2/UA/Pp
   DIAXA85Ote2U5pPOELQUy5HnIS8EvmdDX8DsYKmmfjkhsBXThz5ubLm4K
   glcvUr9FTFoDphgCi8yCHLQyVG8G2FGR9Q0IXQlxRR1tEulqB88BGxefv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="358281956"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="358281956"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 21:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="744388389"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="744388389"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Sep 2023 21:39:57 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qge8w-00019x-2L;
        Thu, 14 Sep 2023 04:39:54 +0000
Date:   Thu, 14 Sep 2023 12:39:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/4] hwmon: max31827: Handle new properties from the
 devicetree
Message-ID: <202309141254.Dpetnhzg-lkp@intel.com>
References: <20230913152135.457892-4-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913152135.457892-4-daniel.matyas@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.6-rc1 next-20230913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Matyas/hwmon-max31827-Make-code-cleaner/20230913-232729
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230913152135.457892-4-daniel.matyas%40analog.com
patch subject: [PATCH 3/4] hwmon: max31827: Handle new properties from the devicetree
reproduce: (https://download.01.org/0day-ci/archive/20230914/202309141254.Dpetnhzg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309141254.Dpetnhzg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/hwmon/max31827.rst:82: WARNING: Unexpected indentation.

vim +82 Documentation/hwmon/max31827.rst

    76	
    77	The conversions can be manual with the one-shot functionality and automatic with
    78	a set frequency. When powered on, the chip measures temperatures with 1 conv/s.
    79	The conversion rate can be modified with update_interval attribute of the chip.
    80	Conversion/second = 1/update_interval. Thus, the available options according to
    81	the data sheet are:
  > 82		- 64000 (ms) = 1 conv/64 sec
    83		- 32000 (ms) = 1 conv/32 sec
    84		- 16000 (ms) = 1 conv/16 sec
    85		- 4000 (ms) = 1 conv/4 sec
    86		- 1000 (ms) = 1 conv/sec (default)
    87		- 250 (ms) = 4 conv/sec
    88		- 125 (ms) = 8 conv/sec
    89	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
