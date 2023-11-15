Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2407E8093
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344881AbjKJSPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343898AbjKJSOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:14:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F8F7687;
        Thu,  9 Nov 2023 22:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699597955; x=1731133955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P+HrsfTgmIAQuHJtSIDJylsGuedtQJzyUXRzKrUPFZE=;
  b=gM/Z/sXC1M6lin0iLAtVJHOIYq/3Om9u/JMwWFANqvTIAlwpi57WbU7u
   ePvmUWwSqOU0QK7s3nKmnXF6AGutTGjjCUq/yTrAFTyHxH2zlkTKztCow
   2wr64xNT5hWaOZRzIofaZOVNKkC0KlN4zDVGxD/D2Ab6i8tGyF95HswY3
   EFyKfjOdqqMftIveIJdaPtxNnBorKnDLxZApyLcsueN+rJO0SEdzJ5wKz
   RnaW+QlOVhm50F5G8fQWsuE68EnysvH6v5x7zObf9DO7vBmC/o/HZgJB7
   wTEmxg5FsjrHIc+5WeCWEP39Wday0NjYERMseNO4sLrbsSoOcE6ME4OD+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="370336242"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="370336242"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 20:23:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="4745660"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Nov 2023 20:23:44 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1J3V-0009Q4-27;
        Fri, 10 Nov 2023 04:23:41 +0000
Date:   Fri, 10 Nov 2023 12:23:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Walker <danielwa@cisco.com>, Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pratyush Brahma <quic_pbrahma@quicinc.com>,
        Tomas Mudrunka <tomas.mudrunka@gmail.com>,
        Sean Anderson <sean.anderson@seco.com>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        xe-linux-external@cisco.com, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] drivers: firmware: efi: libstub: enable generic
 commandline
Message-ID: <202311101224.evyh4zgY-lkp@intel.com>
References: <20231110013817.2378507-6-danielwa@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110013817.2378507-6-danielwa@cisco.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.6]
[cannot apply to arm64/for-next/core efi/next tip/x86/core robh/for-next linus/master next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Walker/CMDLINE-add-generic-builtin-command-line/20231110-094423
base:   v6.6
patch link:    https://lore.kernel.org/r/20231110013817.2378507-6-danielwa%40cisco.com
patch subject: [PATCH 5/8] drivers: firmware: efi: libstub: enable generic commandline
config: loongarch-randconfig-002-20231110 (https://download.01.org/0day-ci/archive/20231110/202311101224.evyh4zgY-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311101224.evyh4zgY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311101224.evyh4zgY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/efi-stub-helper.c:43: warning: expecting prototype for efi_handle_cmdline(). Prototype was for efi_handle_builtin_cmdline() instead
   drivers/firmware/efi/libstub/efi-stub-helper.c:592: warning: Function parameter or member 'out' not described in 'efi_load_initrd'


vim +43 drivers/firmware/efi/libstub/efi-stub-helper.c

    32	
    33	/**
    34	 * efi_handle_cmdline() - handle adding in built-in parts of the command line
    35	 * @cmdline:	kernel command line
    36	 *
    37	 * Add in the generic parts of the commandline and start the parsing of the
    38	 * command line.
    39	 *
    40	 * Return:	status code
    41	 */
    42	efi_status_t efi_handle_builtin_cmdline(char const *cmdline)
  > 43	{
    44		efi_status_t status = EFI_SUCCESS;
    45	
    46		if (sizeof(CMDLINE_STATIC_PREPEND) > 1)
    47			status |= efi_parse_options(CMDLINE_STATIC_PREPEND);
    48	
    49		if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE))
    50			status |= efi_parse_options(cmdline);
    51	
    52		if (sizeof(CMDLINE_STATIC_APPEND) > 1)
    53			status |= efi_parse_options(CMDLINE_STATIC_APPEND);
    54	
    55		if (status != EFI_SUCCESS)
    56			efi_err("Failed to parse options\n");
    57	
    58		return status;
    59	}
    60	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
