Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3417E8046
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343878AbjKJSIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345639AbjKJSGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:06:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604BE44B3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699596705; x=1731132705;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BwUK2lhp0aL0k4mLHSHuWAbnPDKPIUyDN82k4U5czaU=;
  b=T67x3n8orx7g9I8xJB+UzyFh2k9njN3fA5z2n3TcEN2ysLy6KWMt0isx
   zTdgT9PFWQENccS7TyBClr2erqgnyEgbGxT0Fn7WKPbbfvI+ZMJvYOqaQ
   rEJPe7Hz8UVzHxQo9TXecUmka45bv6dCUa5uRHV0BkfeKeCaJ3rbqUx63
   lBZZxR1Gue3wbdXxkW2E0cUO000F4ddAUwgAo3oElggiH68rh9seMCJLw
   o8NgKkN/fRksBfqpUKVqaWP40M7ypxN8bO+Emch71IoWDGbbzP8pTEmJs
   sMaxzmBn58liW/tHO+Ff9WQEH9HPcEv2yl86ClTnWNCO0nMZL+hZfwbk6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="393012192"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="393012192"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 22:10:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="907383922"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="907383922"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Nov 2023 22:10:44 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1Kj3-0009SO-2K;
        Fri, 10 Nov 2023 06:10:41 +0000
Date:   Fri, 10 Nov 2023 14:09:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ognjen Galic <smclt30p@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: drivers/platform/x86/thinkpad_acpi.c:9270: warning: Function
 parameter or member 'method' not described in 'tpacpi_battery_acpi_eval'
Message-ID: <202311101401.V95EdtRq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ognjen,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89cdf9d556016a54ff6ddd62324aa5ec790c05cc
commit: 2801b9683f740012863f7f0b1f0bc770c417fe72 thinkpad_acpi: Add support for battery thresholds
date:   6 years ago
config: i386-randconfig-004-20230904 (https://download.01.org/0day-ci/archive/20231110/202311101401.V95EdtRq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311101401.V95EdtRq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311101401.V95EdtRq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/platform/x86/thinkpad_acpi.c: In function 'create_attr_set':
   drivers/platform/x86/thinkpad_acpi.c:1034:31: warning: taking address of packed member of 'struct attribute_set_obj' may result in an unaligned pointer value [-Waddress-of-packed-member]
    1034 |         sobj->s.group.attrs = &sobj->a;
         |                               ^~~~~~~~
   drivers/platform/x86/thinkpad_acpi.c:1037:16: warning: taking address of packed member of 'struct attribute_set_obj' may result in an unaligned pointer value [-Waddress-of-packed-member]
    1037 |         return &sobj->s;
         |                ^~~~~~~~
   drivers/platform/x86/thinkpad_acpi.c: In function 'tpacpi_battery_store':
   drivers/platform/x86/thinkpad_acpi.c:9451:27: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
    9451 |                 if (value < 0 || value > 99)
         |                           ^
   drivers/platform/x86/thinkpad_acpi.c: In function 'thermal_get_sensor':
   drivers/platform/x86/thinkpad_acpi.c:6224:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
    6224 |                 if (idx >= 8 && idx <= 15) {
         |                    ^
   drivers/platform/x86/thinkpad_acpi.c:6230:9: note: here
    6230 |         case TPACPI_THERMAL_TPEC_8:
         |         ^~~~
   drivers/platform/x86/thinkpad_acpi.c: In function 'hotkey_notify':
   drivers/platform/x86/thinkpad_acpi.c:4181:28: warning: this statement may fall through [-Wimplicit-fallthrough=]
    4181 |                         if (tp_features.hotkey_wlsw &&
         |                            ^
   drivers/platform/x86/thinkpad_acpi.c:4189:17: note: here
    4189 |                 default:
         |                 ^~~~~~~
>> drivers/platform/x86/thinkpad_acpi.c:9270: warning: Function parameter or member 'method' not described in 'tpacpi_battery_acpi_eval'
>> drivers/platform/x86/thinkpad_acpi.c:9270: warning: Function parameter or member 'ret' not described in 'tpacpi_battery_acpi_eval'
>> drivers/platform/x86/thinkpad_acpi.c:9270: warning: Function parameter or member 'param' not described in 'tpacpi_battery_acpi_eval'


vim +9270 drivers/platform/x86/thinkpad_acpi.c

  9263	
  9264	/**
  9265	 * This evaluates a ACPI method call specific to the battery
  9266	 * ACPI extension. The specifics are that an error is marked
  9267	 * in the 32rd bit of the response, so we just check that here.
  9268	 */
  9269	static acpi_status tpacpi_battery_acpi_eval(char *method, int *ret, int param)
> 9270	{
  9271		int response;
  9272	
  9273		if (!acpi_evalf(hkey_handle, &response, method, "dd", param)) {
  9274			acpi_handle_err(hkey_handle, "%s: evaluate failed", method);
  9275			return AE_ERROR;
  9276		}
  9277		if (response & METHOD_ERR) {
  9278			acpi_handle_err(hkey_handle,
  9279					"%s evaluated but flagged as error", method);
  9280			return AE_ERROR;
  9281		}
  9282		*ret = response;
  9283		return AE_OK;
  9284	}
  9285	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
