Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62FE7B76B4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 04:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbjJDCuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 22:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjJDCub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 22:50:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D419B0;
        Tue,  3 Oct 2023 19:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696387823; x=1727923823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ClnmhsCaFZlRhEZGTnrJ+4K60cvJZGFBAonbTN8b/Ns=;
  b=mYP9kx4jJ/V7ONPjZkpE4i0P7e+gO9awOPVpM7cX3QLVTXvXxIUd7POt
   zimNXAxb8t2v/8dqBlg84Ly4M8fqdzJALw9s6Nqq2aTPVLREfD2M3nFr3
   uMDZ7Hmhy22efEmUNgRldOP3HDQtv2LdNzrOMR5vwnbnFjc94eLBJJydR
   s993rvZZpsp0ttHPmEEgZVViznpH/OKiN5J4Onw4P/rfUZvpgJmNAT1Jf
   A951ZqfxLLUWmwWrfbZ4Ol2MLh4aF0Rpi+YLdqS9CWxI90Uip9JFJFl4T
   t01+aRgdA2+FpQvrZgQuo3ZokcdEQRgOYdEvWTEBxjm+4qfel5hba5P2z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="413955805"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="413955805"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:50:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="867135637"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="867135637"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2023 19:50:19 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnrxp-000AOs-0N;
        Wed, 04 Oct 2023 02:50:17 +0000
Date:   Wed, 4 Oct 2023 10:50:17 +0800
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
Subject: Re: [PATCH v2 3/5] input/touchscreen: imagis: Add support for Imagis
 IST3038B
Message-ID: <202310041036.tddy1jGm-lkp@intel.com>
References: <20231003133440.4696-4-karelb@gimli.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003133440.4696-4-karelb@gimli.ms.mff.cuni.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
patch link:    https://lore.kernel.org/r/20231003133440.4696-4-karelb%40gimli.ms.mff.cuni.cz
patch subject: [PATCH v2 3/5] input/touchscreen: imagis: Add support for Imagis IST3038B
config: x86_64-randconfig-004-20231004 (https://download.01.org/0day-ci/archive/20231004/202310041036.tddy1jGm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231004/202310041036.tddy1jGm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310041036.tddy1jGm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/input/touchscreen/imagis.c:374:39: warning: 'imagis_3038c_data' defined but not used [-Wunused-const-variable=]
     374 | static const struct imagis_properties imagis_3038c_data = {
         |                                       ^~~~~~~~~~~~~~~~~
>> drivers/input/touchscreen/imagis.c:366:39: warning: 'imagis_3038b_data' defined but not used [-Wunused-const-variable=]
     366 | static const struct imagis_properties imagis_3038b_data = {
         |                                       ^~~~~~~~~~~~~~~~~


vim +/imagis_3038c_data +374 drivers/input/touchscreen/imagis.c

   365	
 > 366	static const struct imagis_properties imagis_3038b_data = {
   367		.interrupt_msg_cmd = IST3038B_REG_STATUS,
   368		.touch_coord_cmd = IST3038B_REG_STATUS,
   369		.whoami_cmd = IST3038B_REG_CHIPID,
   370		.whoami_val = IST3038B_WHOAMI,
   371		.protocol_b = true,
   372	};
   373	
 > 374	static const struct imagis_properties imagis_3038c_data = {
   375		.interrupt_msg_cmd = IST3038C_REG_INTR_MESSAGE,
   376		.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
   377		.whoami_cmd = IST3038C_REG_CHIPID,
   378		.whoami_val = IST3038C_WHOAMI,
   379	};
   380	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
