Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7287DA659
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 12:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjJ1KL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 06:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjJ1KLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 06:11:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDCEF4;
        Sat, 28 Oct 2023 03:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698487881; x=1730023881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ueezLwtbvr39ZJVFUoD3Y4+eTOwTiKbv97K1nH9NctY=;
  b=MhDjFrBBuOT/625ijkdr3+baF3733LCt73PsQMQ72P+R0KI4qfSJHd+Z
   OHM5iqQZbWlp+7oH05ftXB+r+K9PCsO+Ef3byELPFrIFfGV4iUqBTS6JE
   OxVZJyzySh7yS/RUAQDpjp96Y0WE3lK5gbNuJCRKoRgibj1vLGgTHgSY3
   mygZ0tHH/Mgl2J/RN4FBUsVuFWNc61NiGhT/j6hECW9FG9d2PK3fue+BN
   1Br/TXJ/gOyykLExxKPxwYcOXPKdKV5/mrjuSXV0JktA7xh4m3WWQkPQq
   UjlqDZ/txF59HBO7w0iDuuDxWI87QideUuP0ECz4alDFejzEans+gu7ga
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="474129336"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="474129336"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 03:11:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="1035055"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Oct 2023 03:10:41 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwgHj-000Bdn-0V;
        Sat, 28 Oct 2023 10:11:15 +0000
Date:   Sat, 28 Oct 2023 18:10:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: Re: [PATCH 1/2] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe boards
 not work by default
Message-ID: <202310281723.0DAslF1o-lkp@intel.com>
References: <20231027062440.7749-2-crescentcy.hsieh@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027062440.7749-2-crescentcy.hsieh@moxa.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Crescent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next next-20231027]
[cannot apply to tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.6-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Crescent-CY-Hsieh/tty-serial-8250-Fix-MOXA-RS422-RS485-PCIe-boards-not-work-by-default/20231027-142745
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20231027062440.7749-2-crescentcy.hsieh%40moxa.com
patch subject: [PATCH 1/2] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe boards not work by default
config: i386-randconfig-002-20231028 (https://download.01.org/0day-ci/archive/20231028/202310281723.0DAslF1o-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231028/202310281723.0DAslF1o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310281723.0DAslF1o-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_pci.c:2001:5: warning: no previous declaration for 'pci_moxa_supported_rs' [-Wmissing-declarations]
    u32 pci_moxa_supported_rs(struct pci_dev *dev)
        ^~~~~~~~~~~~~~~~~~~~~


vim +/pci_moxa_supported_rs +2001 drivers/tty/serial/8250/8250_pci.c

  2000	
> 2001	u32 pci_moxa_supported_rs(struct pci_dev *dev)
  2002	{
  2003		switch (dev->device & 0x0F00) {
  2004		case 0x0000:
  2005		case 0x0600:
  2006			return MOXA_SUPP_RS232;
  2007		case 0x0100:
  2008			return MOXA_SUPP_RS232 | MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
  2009		case 0x0300:
  2010			return MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
  2011		}
  2012		return 0;
  2013	}
  2014	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
