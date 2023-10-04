Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5F67B7812
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241437AbjJDGmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjJDGmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:42:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3605CAD;
        Tue,  3 Oct 2023 23:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696401759; x=1727937759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fEbusEUadP7aAf4Qt7Tnn0hCBtGQxdtH+HZZwg9ht6Q=;
  b=Bi08ZIEGRLDdiDLRZu9tNn2v2pphbOvTnvDDuxmiq+B6dG9bGMDEf6DP
   r03QopO2z+0C/5UwgIYDaD9dNn/uoyDXLjkhrrKT9Sm0cal+u/adJAXcy
   pDA3n3YIJ5SrctScZTuqFcM/OYVDUDq2gH5goHPYq1X9PUK5odaZrdmo+
   KTtxVFIkEVO9WY3Td5H/rHctMc72PBRPoZL1VJIFDTRFDKFKYs/J/B7ka
   QGNIHCXx/EsvTAiEjGwLz65iczNl9dwnhTakxLnA0b5YzyY5+abreYXg5
   baS8x+fk9hsF437Sed4cKYdsN989hCw4SpWIHNyJg0mCzoNUcF5q28kFr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="368134988"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="368134988"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 23:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="874976835"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="874976835"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 03 Oct 2023 23:42:35 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnvab-000D9y-0c;
        Wed, 04 Oct 2023 06:42:33 +0000
Date:   Wed, 4 Oct 2023 14:42:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     karelb@gimli.ms.mff.cuni.cz,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     oe-kbuild-all@lists.linux.dev,
        Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Subject: Re: [PATCH v2 5/5] input/touchscreen: imagis: add support for
 IST3032C
Message-ID: <202310041406.DCcjrpLd-lkp@intel.com>
References: <20231003133440.4696-6-karelb@gimli.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003133440.4696-6-karelb@gimli.ms.mff.cuni.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus robh/for-next linus/master v6.6-rc4 next-20231003]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/karelb-gimli-ms-mff-cuni-cz/input-touchscreen-imagis-Correct-the-maximum-touch-area-value/20231003-213739
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20231003133440.4696-6-karelb%40gimli.ms.mff.cuni.cz
patch subject: [PATCH v2 5/5] input/touchscreen: imagis: add support for IST3032C
config: x86_64-randconfig-004-20231004 (https://download.01.org/0day-ci/archive/20231004/202310041406.DCcjrpLd-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231004/202310041406.DCcjrpLd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310041406.DCcjrpLd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/input/touchscreen/imagis.c:383:39: warning: 'imagis_3038c_data' defined but not used [-Wunused-const-variable=]
     383 | static const struct imagis_properties imagis_3038c_data = {
         |                                       ^~~~~~~~~~~~~~~~~
   drivers/input/touchscreen/imagis.c:375:39: warning: 'imagis_3038b_data' defined but not used [-Wunused-const-variable=]
     375 | static const struct imagis_properties imagis_3038b_data = {
         |                                       ^~~~~~~~~~~~~~~~~
>> drivers/input/touchscreen/imagis.c:368:39: warning: 'imagis_3032c_data' defined but not used [-Wunused-const-variable=]
     368 | static const struct imagis_properties imagis_3032c_data = {
         |                                       ^~~~~~~~~~~~~~~~~


vim +/imagis_3032c_data +368 drivers/input/touchscreen/imagis.c

   367	
 > 368	static const struct imagis_properties imagis_3032c_data = {
   369		.interrupt_msg_cmd = IST3038C_REG_INTR_MESSAGE,
   370		.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
   371		.whoami_cmd = IST3038C_REG_CHIPID,
   372		.whoami_val = IST3032C_WHOAMI,
   373	};
   374	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
