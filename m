Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972F87F4FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343790AbjKVSdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKVSdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:33:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6C51B3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 10:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700678029; x=1732214029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZtOI3P+73D+xoSiDpddoMtHCbPxN/JLlZwoFdrAlN6g=;
  b=Xzlf3XBLJLe+Rj90N7V9tHOk2EiU/fdRQzunUMqgSghfqb2QABpOsOGg
   Rfsy1otDoqLU8v3DnMCJllFE7oy6nVfsTLP7vGZCfLTkvSxUaKK+BGaL9
   0+UDMKPZZvML/gITRqWMoH2yS85TxefRz2nyclb/3uYEThfwejsfYYy4O
   OZ/7VqkZOvqKSRnTHXw5fRGdg058t1s6CgC0+BzQgRWBmd1/mc1FzDdmI
   OBL2AqsOwcCK1+Mtd1Ca8v4+1Y6WIDkmIawYGpgDyKt+xCDpmmL5QyZmr
   fnM9Kms5QG66SOvfVQLdTnnTpGQPFu01QtxmbaBHwfUKC1SicxhZntkof
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13671869"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="13671869"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP; 22 Nov 2023 10:33:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="743340984"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="743340984"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:29:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r5kLW-0000000G3pL-01Mp;
        Wed, 22 Nov 2023 12:20:38 +0200
Date:   Wed, 22 Nov 2023 12:20:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: drivers/extcon/extcon-intel-cht-wc.c:153:3: warning: this
 statement may fall through
Message-ID: <ZV3V9VTRxmFqIj0E@smile.fi.intel.com>
References: <202311220741.oIvJcjV4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311220741.oIvJcjV4-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 07:27:14AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c2d5304e6c648ebcf653bace7e51e0e6742e46c8
> commit: de85d79f4aab67fe0537dd6e2c5d545b88239cc4 mfd: Add Cherry Trail Whiskey Cove PMIC driver
> date:   6 years ago
> config: i386-randconfig-002-20231120 (https://download.01.org/0day-ci/archive/20231122/202311220741.oIvJcjV4-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220741.oIvJcjV4-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311220741.oIvJcjV4-lkp@intel.com/

...

> db0f3baaa38bb5 Hans de Goede 2017-03-23  151  	switch (usbsrc) {
> db0f3baaa38bb5 Hans de Goede 2017-03-23  152  	default:
> db0f3baaa38bb5 Hans de Goede 2017-03-23 @153  		dev_warn(ext->dev,
> db0f3baaa38bb5 Hans de Goede 2017-03-23  154  			"Unhandled charger type %d, defaulting to SDP\n",
> db0f3baaa38bb5 Hans de Goede 2017-03-23  155  			 ret);

> db0f3baaa38bb5 Hans de Goede 2017-03-23  156  		/* Fall through, treat as SDP */

Replacing this comment by a fallthrough annotation should fix this (and comment
itself is redundant as long as properly annotated).

> db0f3baaa38bb5 Hans de Goede 2017-03-23  157  	case CHT_WC_USBSRC_TYPE_SDP:
> db0f3baaa38bb5 Hans de Goede 2017-03-23  158  	case CHT_WC_USBSRC_TYPE_FLOAT_DP_DN:
> db0f3baaa38bb5 Hans de Goede 2017-03-23  159  	case CHT_WC_USBSRC_TYPE_OTHER:
> db0f3baaa38bb5 Hans de Goede 2017-03-23  160  		return EXTCON_CHG_USB_SDP;
> db0f3baaa38bb5 Hans de Goede 2017-03-23  161  	case CHT_WC_USBSRC_TYPE_CDP:
> db0f3baaa38bb5 Hans de Goede 2017-03-23  162  		return EXTCON_CHG_USB_CDP;
> db0f3baaa38bb5 Hans de Goede 2017-03-23  163  	case CHT_WC_USBSRC_TYPE_DCP:
> db0f3baaa38bb5 Hans de Goede 2017-03-23  164  	case CHT_WC_USBSRC_TYPE_DCP_EXTPHY:
> db0f3baaa38bb5 Hans de Goede 2017-03-23  165  	case CHT_WC_USBSRC_TYPE_MHL: /* MHL2+ delivers upto 2A, treat as DCP */
> db0f3baaa38bb5 Hans de Goede 2017-03-23  166  		return EXTCON_CHG_USB_DCP;
> db0f3baaa38bb5 Hans de Goede 2017-03-23  167  	case CHT_WC_USBSRC_TYPE_ACA:
> db0f3baaa38bb5 Hans de Goede 2017-03-23  168  		return EXTCON_CHG_USB_ACA;
> db0f3baaa38bb5 Hans de Goede 2017-03-23  169  	}

-- 
With Best Regards,
Andy Shevchenko


