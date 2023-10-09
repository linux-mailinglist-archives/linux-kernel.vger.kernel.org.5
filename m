Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2807BEAB4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378434AbjJITgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346671AbjJITgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:36:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4E994;
        Mon,  9 Oct 2023 12:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696880203; x=1728416203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X9PWs4fx1Fze5txYfCsU9IVHLTnD+8E8ECbvUSHCBac=;
  b=eH314hIidCKnLqCQ+EFG9XEFwyIzSd9PJfJgw0TIYx1g69b7maWxSHCc
   9ICz7Hr5vi4mlnQ+EM0BdNvP2GhGRGICInNNBs5wtEWaDRVLztyfa+7VP
   XWuSXWIhHroUdK4QHpHnQJ59XenrUBB3dcFyDdg93KZbnGmgYKxCf26FH
   uL3GQDzwImPxGyfGEqCdo98r/05FYycy4OIY43y8PFxc5LC4KyNezLFn0
   GtEM0eyLZd0jkC2Lun8lmKGXM9aa86IqkTo6m8XC9foNIQZRt3lXp/nvK
   FPnKHfptA9GfH9i7qdqrbgEyqUDrY+Hy3FpPKQN2kAOoVxzFe14h/ipMN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374566425"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="374566425"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 12:36:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="753120648"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="753120648"
Received: from lkp-server02.sh.intel.com (HELO 4ed589823ba4) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 09 Oct 2023 12:36:37 -0700
Received: from kbuild by 4ed589823ba4 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpw3Q-0000ag-1T;
        Mon, 09 Oct 2023 19:36:36 +0000
Date:   Tue, 10 Oct 2023 03:36:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.satterthwaite@touchnetix.com, pedro.torruella@touchnetix.com,
        bartp@baasheep.co.uk, hannah.rossiter@touchnetix.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        bsp-development.geo@leica-geosystems.com,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v2 3/3] Input: Add TouchNetix aXiom i2c touchscreen driver
Message-ID: <202310100300.oAC2M62R-lkp@intel.com>
References: <20231009134435.36311-4-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009134435.36311-4-kamel.bouhara@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus robh/for-next krzk-dt/for-next linus/master v6.6-rc5 next-20231009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kamel-Bouhara/dt-bindings-vendor-prefixes-Add-TouchNetix-AS/20231009-214751
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20231009134435.36311-4-kamel.bouhara%40bootlin.com
patch subject: [PATCH v2 3/3] Input: Add TouchNetix aXiom i2c touchscreen driver
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231010/202310100300.oAC2M62R-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310100300.oAC2M62R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310100300.oAC2M62R-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/byteorder/big_endian.h:5,
                    from arch/sparc/include/uapi/asm/byteorder.h:5,
                    from include/asm-generic/qrwlock_types.h:6,
                    from arch/sparc/include/asm/spinlock_types.h:17,
                    from include/linux/spinlock_types_raw.h:7,
                    from include/linux/ratelimit_types.h:7,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/sparc/include/asm/bug.h:25,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from arch/sparc/include/asm/current.h:15,
                    from include/linux/sched.h:12,
                    from include/linux/delay.h:23,
                    from drivers/input/touchscreen/touchnetix_axiom_i2c.c:16:
   drivers/input/touchscreen/touchnetix_axiom_i2c.c: In function 'axiom_i2c_read':
>> include/uapi/linux/byteorder/big_endian.h:36:26: warning: conversion from 'short unsigned int' to 'unsigned char:1' changes value from '256' to '0' [-Woverflow]
      36 | #define __cpu_to_le16(x) ((__force __le16)__swab16((x)))
         |                          ^
   include/linux/byteorder/generic.h:90:21: note: in expansion of macro '__cpu_to_le16'
      90 | #define cpu_to_le16 __cpu_to_le16
         |                     ^~~~~~~~~~~~~
   drivers/input/touchscreen/touchnetix_axiom_i2c.c:214:27: note: in expansion of macro 'cpu_to_le16'
     214 |         cmd_header.read = cpu_to_le16(1);
         |                           ^~~~~~~~~~~
   drivers/input/touchscreen/touchnetix_axiom_i2c.c: At top level:
>> drivers/input/touchscreen/touchnetix_axiom_i2c.c:527:6: warning: no previous prototype for 'axiom_handle_events' [-Wmissing-prototypes]
     527 | void axiom_handle_events(struct axiom_data *ts)
         |      ^~~~~~~~~~~~~~~~~~~
--
>> drivers/input/touchscreen/touchnetix_axiom_i2c.c:164: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Translate usage/page/offset triplet into physical address.


vim +/axiom_handle_events +527 drivers/input/touchscreen/touchnetix_axiom_i2c.c

   522	
   523	/*
   524	 * Validates the crc and demultiplexes the axiom reports to the appropriate
   525	 * report handler
   526	 */
 > 527	void axiom_handle_events(struct axiom_data *ts)
   528	{
   529		char *report_data = ts->rx_buf;
   530		struct device *dev = ts->dev;
   531		char usage = report_data[1];
   532		u16 crc_report;
   533		u16 crc_calc;
   534		char len;
   535	
   536		axiom_i2c_read(ts->client, AXIOM_REPORT_USAGE_ID, 0, report_data, ts->max_report_len);
   537	
   538		if ((report_data[0] & AXIOM_COMMS_OVERFLOW_MASK) != 0)
   539			ts->report_overflow_counter++;
   540	
   541		len = (report_data[0] & AXIOM_COMMS_REPORT_LEN_MASK) * 2;
   542		if (!len) {
   543			dev_err(dev, "Zero length report discarded.\n");
   544			return;
   545		}
   546	
   547		dev_dbg(dev, "Payload Data %*ph\n", len, report_data);
   548	
   549		/* Validate the report CRC */
   550		crc_report = (report_data[len - 1] << 8) | (report_data[len - 2]);
   551		/* Length is in 16 bit words and remove the size of the CRC16 itself */
   552		crc_calc = crc16(0, report_data, (len - 2));
   553	
   554		if (crc_calc != crc_report) {
   555			dev_err(dev,
   556				"CRC mismatch! Expected: %#x, Calculated CRC: %#x.\n",
   557				crc_report, crc_calc);
   558			return;
   559		}
   560	
   561		switch (usage) {
   562		case AXIOM_USAGE_2DCTS_REPORT_ID:
   563			axiom_process_u41_report(ts, &report_data[1]);
   564			break;
   565	
   566		case AXIOM_USAGE_2AUX_REPORT_ID:
   567			/* This is an aux report (force) */
   568			axiom_process_u46_report(ts, &report_data[1]);
   569			break;
   570	
   571		case AXIOM_USAGE_2HB_REPORT_ID:
   572			/* This is a heartbeat report */
   573			break;
   574		}
   575	
   576		ts->report_counter++;
   577	}
   578	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
