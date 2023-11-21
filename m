Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C227F3A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjKUX1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUX1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:27:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6420199
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700609260; x=1732145260;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nmONMqtdZ9WeSXxVi5kC5ZT2wE/vBAzjIaI/gpz6O10=;
  b=aj6oL1Ot/1ZNGpabzQh0lQPWljqAUNItQQF/5cZejX5IIaORaojYiYq3
   gdMvo1Y7g0EDz5dzd4Qr5nE1xeMVKnSGaLbVUFKWVe40XyK9PT+dMK80q
   cnvxUzHNYL6Gh5t0rjStK8d0S1t/LBbbCRYCxAus0/Ly3T8JFkOvP2FMY
   A4Xve3Yul79/MTXvmwirCgZI5qkYYnLaNGz71SFq9WKEMO1SknQYow8wr
   EY1oa2ss7eINuwMOutCHprCXyiNMWBAorrmbxQ+63gXIZFHmHblrbrJde
   SeMVi6pFvEqyCRdGKw7bE8gV36gcNY6/+ChZ7LwkdHcY6fvdhk+Pl04RI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="13493314"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="13493314"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 15:27:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="884357691"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="884357691"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Nov 2023 15:27:36 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5a9W-0008OM-1G;
        Tue, 21 Nov 2023 23:27:34 +0000
Date:   Wed, 22 Nov 2023 07:27:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/extcon/extcon-intel-cht-wc.c:153:3: warning: this statement
 may fall through
Message-ID: <202311220741.oIvJcjV4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2d5304e6c648ebcf653bace7e51e0e6742e46c8
commit: de85d79f4aab67fe0537dd6e2c5d545b88239cc4 mfd: Add Cherry Trail Whiskey Cove PMIC driver
date:   6 years ago
config: i386-randconfig-002-20231120 (https://download.01.org/0day-ci/archive/20231122/202311220741.oIvJcjV4-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220741.oIvJcjV4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220741.oIvJcjV4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/extcon/extcon-intel-cht-wc.c: In function 'cht_wc_extcon_get_charger':
>> drivers/extcon/extcon-intel-cht-wc.c:153:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
      dev_warn(ext->dev,
      ^~~~~~~~~~~~~~~~~~
       "Unhandled charger type %d, defaulting to SDP\n",
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        ret);
        ~~~~
   drivers/extcon/extcon-intel-cht-wc.c:157:2: note: here
     case CHT_WC_USBSRC_TYPE_SDP:
     ^~~~
>> drivers/extcon/extcon-intel-cht-wc.c:1: warning: no structured comments found


vim +153 drivers/extcon/extcon-intel-cht-wc.c

db0f3baaa38bb5 Hans de Goede 2017-03-23   @1  /*
db0f3baaa38bb5 Hans de Goede 2017-03-23    2   * Extcon charger detection driver for Intel Cherrytrail Whiskey Cove PMIC
db0f3baaa38bb5 Hans de Goede 2017-03-23    3   * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
db0f3baaa38bb5 Hans de Goede 2017-03-23    4   *
db0f3baaa38bb5 Hans de Goede 2017-03-23    5   * Based on various non upstream patches to support the CHT Whiskey Cove PMIC:
db0f3baaa38bb5 Hans de Goede 2017-03-23    6   * Copyright (C) 2013-2015 Intel Corporation. All rights reserved.
db0f3baaa38bb5 Hans de Goede 2017-03-23    7   *
db0f3baaa38bb5 Hans de Goede 2017-03-23    8   * This program is free software; you can redistribute it and/or modify it
db0f3baaa38bb5 Hans de Goede 2017-03-23    9   * under the terms and conditions of the GNU General Public License,
db0f3baaa38bb5 Hans de Goede 2017-03-23   10   * version 2, as published by the Free Software Foundation.
db0f3baaa38bb5 Hans de Goede 2017-03-23   11   *
db0f3baaa38bb5 Hans de Goede 2017-03-23   12   * This program is distributed in the hope it will be useful, but WITHOUT
db0f3baaa38bb5 Hans de Goede 2017-03-23   13   * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
db0f3baaa38bb5 Hans de Goede 2017-03-23   14   * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
db0f3baaa38bb5 Hans de Goede 2017-03-23   15   * more details.
db0f3baaa38bb5 Hans de Goede 2017-03-23   16   */
db0f3baaa38bb5 Hans de Goede 2017-03-23   17  
db0f3baaa38bb5 Hans de Goede 2017-03-23   18  #include <linux/extcon.h>
db0f3baaa38bb5 Hans de Goede 2017-03-23   19  #include <linux/interrupt.h>
db0f3baaa38bb5 Hans de Goede 2017-03-23   20  #include <linux/kernel.h>
db0f3baaa38bb5 Hans de Goede 2017-03-23   21  #include <linux/mfd/intel_soc_pmic.h>
db0f3baaa38bb5 Hans de Goede 2017-03-23   22  #include <linux/module.h>
db0f3baaa38bb5 Hans de Goede 2017-03-23   23  #include <linux/platform_device.h>
db0f3baaa38bb5 Hans de Goede 2017-03-23   24  #include <linux/regmap.h>
db0f3baaa38bb5 Hans de Goede 2017-03-23   25  #include <linux/slab.h>
db0f3baaa38bb5 Hans de Goede 2017-03-23   26  
db0f3baaa38bb5 Hans de Goede 2017-03-23   27  #define CHT_WC_PHYCTRL			0x5e07
db0f3baaa38bb5 Hans de Goede 2017-03-23   28  
db0f3baaa38bb5 Hans de Goede 2017-03-23   29  #define CHT_WC_CHGRCTRL0		0x5e16
db0f3baaa38bb5 Hans de Goede 2017-03-23   30  #define CHT_WC_CHGRCTRL0_CHGRRESET	BIT(0)
db0f3baaa38bb5 Hans de Goede 2017-03-23   31  #define CHT_WC_CHGRCTRL0_EMRGCHREN	BIT(1)
db0f3baaa38bb5 Hans de Goede 2017-03-23   32  #define CHT_WC_CHGRCTRL0_EXTCHRDIS	BIT(2)
db0f3baaa38bb5 Hans de Goede 2017-03-23   33  #define CHT_WC_CHGRCTRL0_SWCONTROL	BIT(3)
db0f3baaa38bb5 Hans de Goede 2017-03-23   34  #define CHT_WC_CHGRCTRL0_TTLCK_MASK	BIT(4)
db0f3baaa38bb5 Hans de Goede 2017-03-23   35  #define CHT_WC_CHGRCTRL0_CCSM_OFF_MASK	BIT(5)
db0f3baaa38bb5 Hans de Goede 2017-03-23   36  #define CHT_WC_CHGRCTRL0_DBPOFF_MASK	BIT(6)
db0f3baaa38bb5 Hans de Goede 2017-03-23   37  #define CHT_WC_CHGRCTRL0_WDT_NOKICK	BIT(7)
db0f3baaa38bb5 Hans de Goede 2017-03-23   38  
db0f3baaa38bb5 Hans de Goede 2017-03-23   39  #define CHT_WC_CHGRCTRL1		0x5e17
db0f3baaa38bb5 Hans de Goede 2017-03-23   40  
db0f3baaa38bb5 Hans de Goede 2017-03-23   41  #define CHT_WC_USBSRC			0x5e29
db0f3baaa38bb5 Hans de Goede 2017-03-23   42  #define CHT_WC_USBSRC_STS_MASK		GENMASK(1, 0)
db0f3baaa38bb5 Hans de Goede 2017-03-23   43  #define CHT_WC_USBSRC_STS_SUCCESS	2
db0f3baaa38bb5 Hans de Goede 2017-03-23   44  #define CHT_WC_USBSRC_STS_FAIL		3
db0f3baaa38bb5 Hans de Goede 2017-03-23   45  #define CHT_WC_USBSRC_TYPE_SHIFT	2
db0f3baaa38bb5 Hans de Goede 2017-03-23   46  #define CHT_WC_USBSRC_TYPE_MASK		GENMASK(5, 2)
db0f3baaa38bb5 Hans de Goede 2017-03-23   47  #define CHT_WC_USBSRC_TYPE_NONE		0
db0f3baaa38bb5 Hans de Goede 2017-03-23   48  #define CHT_WC_USBSRC_TYPE_SDP		1
db0f3baaa38bb5 Hans de Goede 2017-03-23   49  #define CHT_WC_USBSRC_TYPE_DCP		2
db0f3baaa38bb5 Hans de Goede 2017-03-23   50  #define CHT_WC_USBSRC_TYPE_CDP		3
db0f3baaa38bb5 Hans de Goede 2017-03-23   51  #define CHT_WC_USBSRC_TYPE_ACA		4
db0f3baaa38bb5 Hans de Goede 2017-03-23   52  #define CHT_WC_USBSRC_TYPE_SE1		5
db0f3baaa38bb5 Hans de Goede 2017-03-23   53  #define CHT_WC_USBSRC_TYPE_MHL		6
db0f3baaa38bb5 Hans de Goede 2017-03-23   54  #define CHT_WC_USBSRC_TYPE_FLOAT_DP_DN	7
db0f3baaa38bb5 Hans de Goede 2017-03-23   55  #define CHT_WC_USBSRC_TYPE_OTHER	8
db0f3baaa38bb5 Hans de Goede 2017-03-23   56  #define CHT_WC_USBSRC_TYPE_DCP_EXTPHY	9
db0f3baaa38bb5 Hans de Goede 2017-03-23   57  
db0f3baaa38bb5 Hans de Goede 2017-03-23   58  #define CHT_WC_PWRSRC_IRQ		0x6e03
db0f3baaa38bb5 Hans de Goede 2017-03-23   59  #define CHT_WC_PWRSRC_IRQ_MASK		0x6e0f
db0f3baaa38bb5 Hans de Goede 2017-03-23   60  #define CHT_WC_PWRSRC_STS		0x6e1e
db0f3baaa38bb5 Hans de Goede 2017-03-23   61  #define CHT_WC_PWRSRC_VBUS		BIT(0)
db0f3baaa38bb5 Hans de Goede 2017-03-23   62  #define CHT_WC_PWRSRC_DC		BIT(1)
db0f3baaa38bb5 Hans de Goede 2017-03-23   63  #define CHT_WC_PWRSRC_BAT		BIT(2)
db0f3baaa38bb5 Hans de Goede 2017-03-23   64  #define CHT_WC_PWRSRC_ID_GND		BIT(3)
db0f3baaa38bb5 Hans de Goede 2017-03-23   65  #define CHT_WC_PWRSRC_ID_FLOAT		BIT(4)
db0f3baaa38bb5 Hans de Goede 2017-03-23   66  
585cb239f4de6c Hans de Goede 2017-04-05   67  #define CHT_WC_VBUS_GPIO_CTLO		0x6e2d
585cb239f4de6c Hans de Goede 2017-04-05   68  #define CHT_WC_VBUS_GPIO_CTLO_OUTPUT	BIT(0)
585cb239f4de6c Hans de Goede 2017-04-05   69  
db0f3baaa38bb5 Hans de Goede 2017-03-23   70  enum cht_wc_usb_id {
db0f3baaa38bb5 Hans de Goede 2017-03-23   71  	USB_ID_OTG,
db0f3baaa38bb5 Hans de Goede 2017-03-23   72  	USB_ID_GND,
db0f3baaa38bb5 Hans de Goede 2017-03-23   73  	USB_ID_FLOAT,
db0f3baaa38bb5 Hans de Goede 2017-03-23   74  	USB_RID_A,
db0f3baaa38bb5 Hans de Goede 2017-03-23   75  	USB_RID_B,
db0f3baaa38bb5 Hans de Goede 2017-03-23   76  	USB_RID_C,
db0f3baaa38bb5 Hans de Goede 2017-03-23   77  };
db0f3baaa38bb5 Hans de Goede 2017-03-23   78  
db0f3baaa38bb5 Hans de Goede 2017-03-23   79  enum cht_wc_mux_select {
db0f3baaa38bb5 Hans de Goede 2017-03-23   80  	MUX_SEL_PMIC = 0,
db0f3baaa38bb5 Hans de Goede 2017-03-23   81  	MUX_SEL_SOC,
db0f3baaa38bb5 Hans de Goede 2017-03-23   82  };
db0f3baaa38bb5 Hans de Goede 2017-03-23   83  
db0f3baaa38bb5 Hans de Goede 2017-03-23   84  static const unsigned int cht_wc_extcon_cables[] = {
db0f3baaa38bb5 Hans de Goede 2017-03-23   85  	EXTCON_USB,
db0f3baaa38bb5 Hans de Goede 2017-03-23   86  	EXTCON_USB_HOST,
db0f3baaa38bb5 Hans de Goede 2017-03-23   87  	EXTCON_CHG_USB_SDP,
db0f3baaa38bb5 Hans de Goede 2017-03-23   88  	EXTCON_CHG_USB_CDP,
db0f3baaa38bb5 Hans de Goede 2017-03-23   89  	EXTCON_CHG_USB_DCP,
db0f3baaa38bb5 Hans de Goede 2017-03-23   90  	EXTCON_CHG_USB_ACA,
db0f3baaa38bb5 Hans de Goede 2017-03-23   91  	EXTCON_NONE,
db0f3baaa38bb5 Hans de Goede 2017-03-23   92  };
db0f3baaa38bb5 Hans de Goede 2017-03-23   93  
db0f3baaa38bb5 Hans de Goede 2017-03-23   94  struct cht_wc_extcon_data {
db0f3baaa38bb5 Hans de Goede 2017-03-23   95  	struct device *dev;
db0f3baaa38bb5 Hans de Goede 2017-03-23   96  	struct regmap *regmap;
db0f3baaa38bb5 Hans de Goede 2017-03-23   97  	struct extcon_dev *edev;
db0f3baaa38bb5 Hans de Goede 2017-03-23   98  	unsigned int previous_cable;
c42a880c3139cd Hans de Goede 2017-04-05   99  	bool usb_host;
db0f3baaa38bb5 Hans de Goede 2017-03-23  100  };
db0f3baaa38bb5 Hans de Goede 2017-03-23  101  
db0f3baaa38bb5 Hans de Goede 2017-03-23  102  static int cht_wc_extcon_get_id(struct cht_wc_extcon_data *ext, int pwrsrc_sts)
db0f3baaa38bb5 Hans de Goede 2017-03-23  103  {
db0f3baaa38bb5 Hans de Goede 2017-03-23  104  	if (pwrsrc_sts & CHT_WC_PWRSRC_ID_GND)
db0f3baaa38bb5 Hans de Goede 2017-03-23  105  		return USB_ID_GND;
db0f3baaa38bb5 Hans de Goede 2017-03-23  106  	if (pwrsrc_sts & CHT_WC_PWRSRC_ID_FLOAT)
db0f3baaa38bb5 Hans de Goede 2017-03-23  107  		return USB_ID_FLOAT;
db0f3baaa38bb5 Hans de Goede 2017-03-23  108  
db0f3baaa38bb5 Hans de Goede 2017-03-23  109  	/*
db0f3baaa38bb5 Hans de Goede 2017-03-23  110  	 * Once we have iio support for the gpadc we should read the USBID
db0f3baaa38bb5 Hans de Goede 2017-03-23  111  	 * gpadc channel here and determine ACA role based on that.
db0f3baaa38bb5 Hans de Goede 2017-03-23  112  	 */
db0f3baaa38bb5 Hans de Goede 2017-03-23  113  	return USB_ID_FLOAT;
db0f3baaa38bb5 Hans de Goede 2017-03-23  114  }
db0f3baaa38bb5 Hans de Goede 2017-03-23  115  
c42a880c3139cd Hans de Goede 2017-04-05  116  static int cht_wc_extcon_get_charger(struct cht_wc_extcon_data *ext,
c42a880c3139cd Hans de Goede 2017-04-05  117  				     bool ignore_errors)
db0f3baaa38bb5 Hans de Goede 2017-03-23  118  {
db0f3baaa38bb5 Hans de Goede 2017-03-23  119  	int ret, usbsrc, status;
db0f3baaa38bb5 Hans de Goede 2017-03-23  120  	unsigned long timeout;
db0f3baaa38bb5 Hans de Goede 2017-03-23  121  
db0f3baaa38bb5 Hans de Goede 2017-03-23  122  	/* Charger detection can take upto 600ms, wait 800ms max. */
db0f3baaa38bb5 Hans de Goede 2017-03-23  123  	timeout = jiffies + msecs_to_jiffies(800);
db0f3baaa38bb5 Hans de Goede 2017-03-23  124  	do {
db0f3baaa38bb5 Hans de Goede 2017-03-23  125  		ret = regmap_read(ext->regmap, CHT_WC_USBSRC, &usbsrc);
db0f3baaa38bb5 Hans de Goede 2017-03-23  126  		if (ret) {
db0f3baaa38bb5 Hans de Goede 2017-03-23  127  			dev_err(ext->dev, "Error reading usbsrc: %d\n", ret);
db0f3baaa38bb5 Hans de Goede 2017-03-23  128  			return ret;
db0f3baaa38bb5 Hans de Goede 2017-03-23  129  		}
db0f3baaa38bb5 Hans de Goede 2017-03-23  130  
db0f3baaa38bb5 Hans de Goede 2017-03-23  131  		status = usbsrc & CHT_WC_USBSRC_STS_MASK;
db0f3baaa38bb5 Hans de Goede 2017-03-23  132  		if (status == CHT_WC_USBSRC_STS_SUCCESS ||
db0f3baaa38bb5 Hans de Goede 2017-03-23  133  		    status == CHT_WC_USBSRC_STS_FAIL)
db0f3baaa38bb5 Hans de Goede 2017-03-23  134  			break;
db0f3baaa38bb5 Hans de Goede 2017-03-23  135  
db0f3baaa38bb5 Hans de Goede 2017-03-23  136  		msleep(50); /* Wait a bit before retrying */
db0f3baaa38bb5 Hans de Goede 2017-03-23  137  	} while (time_before(jiffies, timeout));
db0f3baaa38bb5 Hans de Goede 2017-03-23  138  
db0f3baaa38bb5 Hans de Goede 2017-03-23  139  	if (status != CHT_WC_USBSRC_STS_SUCCESS) {
c42a880c3139cd Hans de Goede 2017-04-05  140  		if (ignore_errors)
c42a880c3139cd Hans de Goede 2017-04-05  141  			return EXTCON_CHG_USB_SDP; /* Save fallback */
c42a880c3139cd Hans de Goede 2017-04-05  142  
db0f3baaa38bb5 Hans de Goede 2017-03-23  143  		if (status == CHT_WC_USBSRC_STS_FAIL)
db0f3baaa38bb5 Hans de Goede 2017-03-23  144  			dev_warn(ext->dev, "Could not detect charger type\n");
db0f3baaa38bb5 Hans de Goede 2017-03-23  145  		else
db0f3baaa38bb5 Hans de Goede 2017-03-23  146  			dev_warn(ext->dev, "Timeout detecting charger type\n");
db0f3baaa38bb5 Hans de Goede 2017-03-23  147  		return EXTCON_CHG_USB_SDP; /* Save fallback */
db0f3baaa38bb5 Hans de Goede 2017-03-23  148  	}
db0f3baaa38bb5 Hans de Goede 2017-03-23  149  
db0f3baaa38bb5 Hans de Goede 2017-03-23  150  	usbsrc = (usbsrc & CHT_WC_USBSRC_TYPE_MASK) >> CHT_WC_USBSRC_TYPE_SHIFT;
db0f3baaa38bb5 Hans de Goede 2017-03-23  151  	switch (usbsrc) {
db0f3baaa38bb5 Hans de Goede 2017-03-23  152  	default:
db0f3baaa38bb5 Hans de Goede 2017-03-23 @153  		dev_warn(ext->dev,
db0f3baaa38bb5 Hans de Goede 2017-03-23  154  			"Unhandled charger type %d, defaulting to SDP\n",
db0f3baaa38bb5 Hans de Goede 2017-03-23  155  			 ret);
db0f3baaa38bb5 Hans de Goede 2017-03-23  156  		/* Fall through, treat as SDP */
db0f3baaa38bb5 Hans de Goede 2017-03-23  157  	case CHT_WC_USBSRC_TYPE_SDP:
db0f3baaa38bb5 Hans de Goede 2017-03-23  158  	case CHT_WC_USBSRC_TYPE_FLOAT_DP_DN:
db0f3baaa38bb5 Hans de Goede 2017-03-23  159  	case CHT_WC_USBSRC_TYPE_OTHER:
db0f3baaa38bb5 Hans de Goede 2017-03-23  160  		return EXTCON_CHG_USB_SDP;
db0f3baaa38bb5 Hans de Goede 2017-03-23  161  	case CHT_WC_USBSRC_TYPE_CDP:
db0f3baaa38bb5 Hans de Goede 2017-03-23  162  		return EXTCON_CHG_USB_CDP;
db0f3baaa38bb5 Hans de Goede 2017-03-23  163  	case CHT_WC_USBSRC_TYPE_DCP:
db0f3baaa38bb5 Hans de Goede 2017-03-23  164  	case CHT_WC_USBSRC_TYPE_DCP_EXTPHY:
db0f3baaa38bb5 Hans de Goede 2017-03-23  165  	case CHT_WC_USBSRC_TYPE_MHL: /* MHL2+ delivers upto 2A, treat as DCP */
db0f3baaa38bb5 Hans de Goede 2017-03-23  166  		return EXTCON_CHG_USB_DCP;
db0f3baaa38bb5 Hans de Goede 2017-03-23  167  	case CHT_WC_USBSRC_TYPE_ACA:
db0f3baaa38bb5 Hans de Goede 2017-03-23  168  		return EXTCON_CHG_USB_ACA;
db0f3baaa38bb5 Hans de Goede 2017-03-23  169  	}
db0f3baaa38bb5 Hans de Goede 2017-03-23  170  }
db0f3baaa38bb5 Hans de Goede 2017-03-23  171  

:::::: The code at line 153 was first introduced by commit
:::::: db0f3baaa38bb587d831b1127082643b5e813074 extcon: intel-cht-wc: Add Intel Cherry Trail Whiskey Cove PMIC extcon driver

:::::: TO: Hans de Goede <hdegoede@redhat.com>
:::::: CC: Chanwoo Choi <cw00.choi@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
