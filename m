Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0E6767F3F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjG2Mvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjG2Mvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:51:32 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F16E6A;
        Sat, 29 Jul 2023 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690635091; x=1722171091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Logke5jGkCA3/7hxc2IPFDsWV1n65Ev/SRiHfDeV8Mk=;
  b=Klb/c0Sv4zB+kwDNF2NftNL1GkCezMi/+2QMZ3sjmkz0BxsEYItwMILI
   YeAJV2FqvMMjHsmmC0NTNTw7o0ELan4Hr5Y1VqEiIQ/RIugJ6BYmMCUqt
   SdJ9R7LJTlB9MitAOOoWVnJik1uWUXtvQsqkBIhu8bWbEA9ftTcrZ828G
   fu3zpdxfNF8jqI/her4nrVhAp67DK2yTRILkJn3a5dnVUoGE7Lq6lHFzX
   zvk06Zw59GdgJ5FFsYrOySPLmd2teomOXpaSPd0oYD2hGs734hzc0P5+A
   GypVi5lpilKHbSBMNrKweJnDKm7x5oxMXVR9U+qEofeVU+wRpTH1FkuGt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="399703152"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="399703152"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 05:51:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="757450492"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="757450492"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2023 05:51:28 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPjPr-00042N-1j;
        Sat, 29 Jul 2023 12:51:27 +0000
Date:   Sat, 29 Jul 2023 20:50:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Aleksa Savic <savicaleksa83@gmail.com>, stable@vger.kernel.org,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add selective 200ms delay
 after sending ctrl report
Message-ID: <202307292011.c34ZumSF-lkp@intel.com>
References: <20230729112732.5516-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729112732.5516-1-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aleksa,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.5-rc3 next-20230728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aleksa-Savic/hwmon-aquacomputer_d5next-Add-selective-200ms-delay-after-sending-ctrl-report/20230729-193038
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230729112732.5516-1-savicaleksa83%40gmail.com
patch subject: [PATCH] hwmon: (aquacomputer_d5next) Add selective 200ms delay after sending ctrl report
config: arm-randconfig-r005-20230729 (https://download.01.org/0day-ci/archive/20230729/202307292011.c34ZumSF-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307292011.c34ZumSF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307292011.c34ZumSF-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hwmon/aquacomputer_d5next.c: In function 'aqc_send_ctrl_data':
>> drivers/hwmon/aquacomputer_d5next.c:674:17: error: implicit declaration of function 'msleep' [-Werror=implicit-function-declaration]
     674 |                 msleep(200);
         |                 ^~~~~~
   cc1: some warnings being treated as errors


vim +/msleep +674 drivers/hwmon/aquacomputer_d5next.c

   627	
   628	/* Expects the mutex to be locked */
   629	static int aqc_send_ctrl_data(struct aqc_data *priv)
   630	{
   631		int ret;
   632		u16 checksum;
   633	
   634		/* Checksum is not needed for Aquaero */
   635		if (priv->kind != aquaero) {
   636			/* Init and xorout value for CRC-16/USB is 0xffff */
   637			checksum = crc16(0xffff, priv->buffer + priv->checksum_start,
   638					 priv->checksum_length);
   639			checksum ^= 0xffff;
   640	
   641			/* Place the new checksum at the end of the report */
   642			put_unaligned_be16(checksum, priv->buffer + priv->checksum_offset);
   643		}
   644	
   645		/* Send the patched up report back to the device */
   646		ret = hid_hw_raw_request(priv->hdev, priv->ctrl_report_id, priv->buffer, priv->buffer_size,
   647					 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
   648		if (ret < 0)
   649			return ret;
   650	
   651		/* The official software sends this report after every change, so do it here as well */
   652		ret = hid_hw_raw_request(priv->hdev, priv->secondary_ctrl_report_id,
   653					 priv->secondary_ctrl_report, priv->secondary_ctrl_report_size,
   654					 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
   655		if (ret < 0)
   656			return ret;
   657	
   658		/*
   659		 * Wait 200ms before returning to make sure that the device actually processed both reports
   660		 * and saved ctrl data to memory. Otherwise, an aqc_get_ctrl_data() call made shortly after
   661		 * may fail with -EPIPE because the device is still busy and can't provide data. This can
   662		 * happen when userspace tools, such as fancontrol or liquidctl, write to sysfs entries in
   663		 * quick succession.
   664		 *
   665		 * 200ms was found to be the sweet spot between fixing the issue and not significantly
   666		 * prolonging the call. Quadro, Octo, D5 Next and Aquaero are currently known to be
   667		 * affected.
   668		 */
   669		switch (priv->kind) {
   670		case quadro:
   671		case octo:
   672		case d5next:
   673		case aquaero:
 > 674			msleep(200);
   675			break;
   676		default:
   677			break;
   678		}
   679	
   680		return ret;
   681	}
   682	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
