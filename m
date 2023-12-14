Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13AD812B68
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbjLNJOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjLNJOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:14:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF8610C0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702545227; x=1734081227;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FGyrzpJZ2dPIvxGmGPOv4xqqrlVGXFxSJOp+HjLBIYI=;
  b=eZ+1aIiIYwvGMzAknQGCtzsM/HmyjM5HNhI7YARcXQ/ht/bp39nee4HH
   Hmo3pDqwIOXr3HPqiW7GPHup5MumRjR36U48vlAEOORMSvGJL0L7NYenW
   uQvGxcHEikgHKpY5Hr7HZci4qLdpu9b3c6NhBfu2XBPQb9JcaTsvzcaAy
   9cnIhn7LMu5VewxWJKdBFEZ7IAL2dN63mFpKFXtbpaYUeQdYMj2SN/0Qz
   LtfCux/MPBG8tkRhMCBc/19R+YYZX9hZtQnRAy20beNxdnbkFLqbUQJVw
   PrbgcS9NbutGSBtmKu/2xKkVU94Z0vfSqtUaR8drpGcFPa5Kq/Wk9nNuC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="13789026"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="13789026"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 01:13:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="803208081"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="803208081"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 14 Dec 2023 01:13:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDhmS-000LqJ-2P;
        Thu, 14 Dec 2023 09:13:20 +0000
Date:   Thu, 14 Dec 2023 17:13:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/8390/wd.c:427:22: sparse: sparse: cast to
 restricted __le16
Message-ID: <202312141751.nTLz3mXr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: 164af597ce945751e2dcd53d0a86e84203a6d117 powerpc/Makefile: Use cflags-y/aflags-y for setting endian options
date:   7 years ago
config: powerpc-randconfig-r121-20231107 (https://download.01.org/0day-ci/archive/20231214/202312141751.nTLz3mXr-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231214/202312141751.nTLz3mXr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141751.nTLz3mXr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/8390/wd.c:427:22: sparse: sparse: cast to restricted __le16
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/net/ethernet/8390/wd.c:31:
   include/linux/log2.h:22:1: warning: ignoring attribute 'noreturn' because it conflicts with attribute 'const' [-Wattributes]
      22 | int ____ilog2_NaN(void);
         | ^~~
   drivers/net/ethernet/8390/wd.c:129:28: warning: no previous prototype for 'wd_probe' [-Wmissing-prototypes]
     129 | struct net_device * __init wd_probe(int unit)
         |                            ^~~~~~~~
--
>> drivers/net/ethernet/8390/smc-ultra.c:452:22: sparse: sparse: cast to restricted __le16
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/net/ethernet/8390/smc-ultra.c:60:
   include/linux/log2.h:22:1: warning: ignoring attribute 'noreturn' because it conflicts with attribute 'const' [-Wattributes]
      22 | int ____ilog2_NaN(void);
         | ^~~
--
   drivers/scsi/be2iscsi/be_main.c:145:1: sparse: sparse: symbol 'beiscsi_log_enable_disp' was not declared. Should it be static?
   drivers/scsi/be2iscsi/be_main.c:145:1: sparse: sparse: symbol 'dev_attr_beiscsi_log_enable' was not declared. Should it be static?
   drivers/scsi/be2iscsi/be_main.c:155:1: sparse: sparse: symbol 'dev_attr_beiscsi_drvr_ver' was not declared. Should it be static?
   drivers/scsi/be2iscsi/be_main.c:156:1: sparse: sparse: symbol 'dev_attr_beiscsi_adapter_family' was not declared. Should it be static?
   drivers/scsi/be2iscsi/be_main.c:157:1: sparse: sparse: symbol 'dev_attr_beiscsi_fw_ver' was not declared. Should it be static?
   drivers/scsi/be2iscsi/be_main.c:158:1: sparse: sparse: symbol 'dev_attr_beiscsi_phys_port' was not declared. Should it be static?
   drivers/scsi/be2iscsi/be_main.c:159:1: sparse: sparse: symbol 'dev_attr_beiscsi_active_session_count' was not declared. Should it be static?
   drivers/scsi/be2iscsi/be_main.c:161:1: sparse: sparse: symbol 'dev_attr_beiscsi_free_session_count' was not declared. Should it be static?
   drivers/scsi/be2iscsi/be_main.c:163:25: sparse: sparse: symbol 'beiscsi_attrs' was not declared. Should it be static?
   drivers/scsi/be2iscsi/be_main.c:1375:29: sparse: sparse: cast to restricted __be16
   drivers/scsi/be2iscsi/be_main.c:1401:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] t2wait @@     got int @@
   drivers/scsi/be2iscsi/be_main.c:1401:21: sparse:     expected restricted __be16 [usertype] t2wait
   drivers/scsi/be2iscsi/be_main.c:1401:21: sparse:     got int
   drivers/scsi/be2iscsi/be_main.c:1982:41: sparse: sparse: cast to restricted __be16
   drivers/scsi/be2iscsi/be_main.c:2052:28: sparse: sparse: cast to restricted __le32
   drivers/scsi/be2iscsi/be_main.c:2068:36: sparse: sparse: cast to restricted __le32
   drivers/scsi/be2iscsi/be_main.c:4758:19: sparse: sparse: cast from restricted itt_t
   drivers/scsi/be2iscsi/be_main.c:4791:34: sparse: sparse: cast to restricted itt_t
   drivers/scsi/be2iscsi/be_main.c:4891:16: sparse: sparse: cast to restricted itt_t
   drivers/scsi/be2iscsi/be_main.c:4891:16: sparse: sparse: cast from restricted __be32
   drivers/scsi/be2iscsi/be_main.c:4947:9: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be16 [usertype] @@
   drivers/scsi/be2iscsi/be_main.c:4947:9: sparse:     expected unsigned int [usertype] value
   drivers/scsi/be2iscsi/be_main.c:4947:9: sparse:     got restricted __be16 [usertype]
   drivers/scsi/be2iscsi/be_main.c:4918:5: sparse: sparse: symbol 'beiscsi_iotask_v2' was not declared. Should it be static?
   drivers/scsi/be2iscsi/be_main.c:5007:9: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be16 [usertype] @@
   drivers/scsi/be2iscsi/be_main.c:5007:9: sparse:     expected unsigned int [usertype] value
   drivers/scsi/be2iscsi/be_main.c:5007:9: sparse:     got restricted __be16 [usertype]
   drivers/scsi/be2iscsi/be_main.c:5102:30: sparse: sparse: restricted __be32 degrades to integer
   drivers/scsi/be2iscsi/be_main.c:5178:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/be2iscsi/be_main.c:5178:17: sparse: sparse: cast from restricted itt_t
   drivers/scsi/be2iscsi/be_main.c:5280:6: sparse: sparse: symbol 'beiscsi_hba_attrs_init' was not declared. Should it be static?
   drivers/scsi/be2iscsi/be_main.c: note: in included file (through drivers/scsi/be2iscsi/be_main.h):
>> drivers/scsi/be2iscsi/be.h:209:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     expected unsigned int [usertype]
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/be2iscsi/be.h:209:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     expected unsigned int [usertype]
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/be2iscsi/be.h:209:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     expected unsigned int [usertype]
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/be2iscsi/be.h:209:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     expected unsigned int [usertype]
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     got restricted __le32 [usertype]
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:8,
                    from include/linux/mutex.h:14,
                    from include/linux/notifier.h:13,
                    from include/linux/reboot.h:5,
                    from drivers/scsi/be2iscsi/be_main.c:20:
   include/linux/log2.h:22:1: warning: ignoring attribute 'noreturn' because it conflicts with attribute 'const' [-Wattributes]
      22 | int ____ilog2_NaN(void);
         | ^~~
   drivers/scsi/be2iscsi/be_main.c:65:1: warning: no previous prototype for 'beiscsi_log_enable_disp' [-Wmissing-prototypes]
      65 | beiscsi_##_name##_disp(struct device *dev,60-      | ^~~~~~~~
   drivers/scsi/be2iscsi/be_main.c:134:1: note: in expansion of macro 'beiscsi_disp_param'
     134 | beiscsi_disp_param(_name)63-      | ^~~~~~~~~~~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c:145:1: note: in expansion of macro 'BEISCSI_RW_ATTR'
     145 | BEISCSI_RW_ATTR(log_enable, 0x00,
         | ^~~~~~~~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c: In function 'beiscsi_log_enable_disp':
   drivers/scsi/be2iscsi/be_main.c:70:18: warning: variable 'param_val' set but not used [-Wunused-but-set-variable]
      70 |         uint32_t param_val = 0; 70-      |                  ^~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c:134:1: note: in expansion of macro 'beiscsi_disp_param'
     134 | beiscsi_disp_param(_name)73-      | ^~~~~~~~~~~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c:145:1: note: in expansion of macro 'BEISCSI_RW_ATTR'
     145 | BEISCSI_RW_ATTR(log_enable, 0x00,
         | ^~~~~~~~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c: At top level:
   drivers/scsi/be2iscsi/be_main.c:78:1: warning: no previous prototype for 'beiscsi_log_enable_change' [-Wmissing-prototypes]
      78 | beiscsi_##_name##_change(struct beiscsi_hba *phba, uint32_t val)80-      | ^~~~~~~~
   drivers/scsi/be2iscsi/be_main.c:135:1: note: in expansion of macro 'beiscsi_change_param'
     135 | beiscsi_change_param(_name, _minval, _maxval, _defval)83-      | ^~~~~~~~~~~~~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c:145:1: note: in expansion of macro 'BEISCSI_RW_ATTR'
     145 | BEISCSI_RW_ATTR(log_enable, 0x00,
         | ^~~~~~~~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c: In function 'beiscsi_log_enable_change':
   drivers/scsi/be2iscsi/be_main.c:80:17: warning: comparison of unsigned expression in '>= 0' is always true [-Wtype-limits]
      80 |         if (val >= _minval && val <= _maxval) {90-      |                 ^~
   drivers/scsi/be2iscsi/be_main.c:135:1: note: in expansion of macro 'beiscsi_change_param'
     135 | beiscsi_change_param(_name, _minval, _maxval, _defval)93-      | ^~~~~~~~~~~~~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c:145:1: note: in expansion of macro 'BEISCSI_RW_ATTR'
     145 | BEISCSI_RW_ATTR(log_enable, 0x00,
         | ^~~~~~~~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c: At top level:
   drivers/scsi/be2iscsi/be_main.c:97:1: warning: no previous prototype for 'beiscsi_log_enable_store' [-Wmissing-prototypes]
      97 | beiscsi_##_name##_store(struct device *dev,100-      | ^~~~~~~~
   drivers/scsi/be2iscsi/be_main.c:136:1: note: in expansion of macro 'beiscsi_store_param'
     136 | beiscsi_store_param(_name)103-      | ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c:145:1: note: in expansion of macro 'BEISCSI_RW_ATTR'
     145 | BEISCSI_RW_ATTR(log_enable, 0x00,
         | ^~~~~~~~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c:116:1: warning: no previous prototype for 'beiscsi_log_enable_init' [-Wmissing-prototypes]
     116 | beiscsi_##_name##_init(struct beiscsi_hba *phba, uint32_t val) 109-      | ^~~~~~~~
   drivers/scsi/be2iscsi/be_main.c:137:1: note: in expansion of macro 'beiscsi_init_param'
     137 | beiscsi_init_param(_name, _minval, _maxval, _defval)112-      | ^~~~~~~~~~~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c:145:1: note: in expansion of macro 'BEISCSI_RW_ATTR'
     145 | BEISCSI_RW_ATTR(log_enable, 0x00,
         | ^~~~~~~~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c: In function 'beiscsi_log_enable_init':
   drivers/scsi/be2iscsi/be_main.c:118:17: warning: comparison of unsigned expression in '>= 0' is always true [-Wtype-limits]
     118 |         if (val >= _minval && val <= _maxval) {119-      |                 ^~
   drivers/scsi/be2iscsi/be_main.c:137:1: note: in expansion of macro 'beiscsi_init_param'
     137 | beiscsi_init_param(_name, _minval, _maxval, _defval)122-      | ^~~~~~~~~~~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c:145:1: note: in expansion of macro 'BEISCSI_RW_ATTR'
     145 | BEISCSI_RW_ATTR(log_enable, 0x00,
         | ^~~~~~~~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c: In function 'be_isr':
   drivers/scsi/be2iscsi/be_main.c:926:30: warning: variable 'index' set but not used [-Wunused-but-set-variable]
     926 |         unsigned long flags, index;
         |                              ^~~~~
   drivers/scsi/be2iscsi/be_main.c: In function 'beiscsi_process_async_pdu':
   drivers/scsi/be2iscsi/be_main.c:1112:37: warning: converting a packed 'struct pdu_base' pointer (alignment 1) to a 'struct iscsi_hdr' pointer (alignment 4) may result in an unaligned pointer value [-Waddress-of-packed-member]
    1112 |                 login_hdr = (struct iscsi_hdr *)ppdu;
         |                                     ^~~~~~~~~
   In file included from drivers/scsi/be2iscsi/be_main.c:43:
   drivers/scsi/be2iscsi/be_main.h:894:8: note: defined here
     894 | struct pdu_base {
         |        ^~~~~~~~
   In file included from include/scsi/libiscsi.h:32,
                    from drivers/scsi/be2iscsi/be_main.c:34:
   include/scsi/iscsi_proto.h:87:8: note: defined here
      87 | struct iscsi_hdr {
         |        ^~~~~~~~~
   drivers/scsi/be2iscsi/be_main.c:1126:44: warning: converting a packed 'struct pdu_base' pointer (alignment 1) to a 'struct iscsi_hdr' pointer (alignment 4) may result in an unaligned pointer value [-Waddress-of-packed-member]
    1126 |         __iscsi_complete_pdu(conn, (struct iscsi_hdr *)ppdu, pbuffer, buf_len);
         |                                            ^~~~~~~~~
   drivers/scsi/be2iscsi/be_main.h:894:8: note: defined here
--
   drivers/scsi/be2iscsi/be_cmds.c:27:32: sparse: sparse: Using plain integer as NULL pointer
   drivers/scsi/be2iscsi/be_cmds.c:28:34: sparse: sparse: Using plain integer as NULL pointer
   drivers/scsi/be2iscsi/be_cmds.c:29:34: sparse: sparse: Using plain integer as NULL pointer
   drivers/scsi/be2iscsi/be_cmds.c:34:29: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/scsi/be2iscsi/be_cmds.c:35:31: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/scsi/be2iscsi/be_cmds.c:36:31: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/scsi/be2iscsi/be_cmds.c:37:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/scsi/be2iscsi/be_cmds.c:37:25: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/scsi/be2iscsi/be_cmds.c:37:25: sparse:     got void *
   drivers/scsi/be2iscsi/be_cmds.c:39:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/scsi/be2iscsi/be_cmds.c:39:25: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/scsi/be2iscsi/be_cmds.c:39:25: sparse:     got void *
   drivers/scsi/be2iscsi/be_cmds.c:46:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/scsi/be2iscsi/be_cmds.c:46:33: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/scsi/be2iscsi/be_cmds.c:46:33: sparse:     got void *
   drivers/scsi/be2iscsi/be_cmds.c:56:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/scsi/be2iscsi/be_cmds.c:56:28: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/scsi/be2iscsi/be_cmds.c:56:28: sparse:     got void *
   drivers/scsi/be2iscsi/be_cmds.c:57:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/scsi/be2iscsi/be_cmds.c:57:28: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/scsi/be2iscsi/be_cmds.c:57:28: sparse:     got void *
   drivers/scsi/be2iscsi/be_cmds.c:60:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/scsi/be2iscsi/be_cmds.c:60:25: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/scsi/be2iscsi/be_cmds.c:60:25: sparse:     got void *
   drivers/scsi/be2iscsi/be_cmds.c:67:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/scsi/be2iscsi/be_cmds.c:67:33: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/scsi/be2iscsi/be_cmds.c:67:33: sparse:     got void *
   drivers/scsi/be2iscsi/be_cmds.c:81:23: sparse: sparse: Using plain integer as NULL pointer
   drivers/scsi/be2iscsi/be_cmds.c:85:20: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/scsi/be2iscsi/be_cmds.c:89:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/scsi/be2iscsi/be_cmds.c:89:33: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/scsi/be2iscsi/be_cmds.c:89:33: sparse:     got void *
   drivers/scsi/be2iscsi/be_cmds.c:107:14: sparse: sparse: symbol 'alloc_mcc_tag' was not declared. Should it be static?
   drivers/scsi/be2iscsi/be_cmds.c:350:24: sparse: sparse: cast to restricted __le32
   drivers/scsi/be2iscsi/be_cmds.c:737:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] request_length @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be_cmds.c:737:33: sparse:     expected unsigned int [usertype] request_length
   drivers/scsi/be2iscsi/be_cmds.c:737:33: sparse:     got restricted __le32 [usertype]
   drivers/scsi/be2iscsi/be_cmds.c:749:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] lo @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be_cmds.c:749:29: sparse:     expected unsigned int [usertype] lo
   drivers/scsi/be2iscsi/be_cmds.c:749:29: sparse:     got restricted __le32 [usertype]
   drivers/scsi/be2iscsi/be_cmds.c:750:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] hi @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be_cmds.c:750:29: sparse:     expected unsigned int [usertype] hi
   drivers/scsi/be2iscsi/be_cmds.c:750:29: sparse:     got restricted __le32 [usertype]
   drivers/scsi/be2iscsi/be_cmds.c:799:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] num_pages @@     got restricted __le16 [usertype] @@
   drivers/scsi/be2iscsi/be_cmds.c:799:24: sparse:     expected unsigned short [usertype] num_pages
   drivers/scsi/be2iscsi/be_cmds.c:799:24: sparse:     got restricted __le16 [usertype]
   drivers/scsi/be2iscsi/be_cmds.c:815:26: sparse: sparse: cast to restricted __le16
   drivers/scsi/be2iscsi/be_cmds.c:923:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] num_pages @@     got restricted __le16 [usertype] @@
   drivers/scsi/be2iscsi/be_cmds.c:923:24: sparse:     expected unsigned short [usertype] num_pages
   drivers/scsi/be2iscsi/be_cmds.c:923:24: sparse:     got restricted __le16 [usertype]
   drivers/scsi/be2iscsi/be_cmds.c:958:26: sparse: sparse: cast to restricted __le16
   drivers/scsi/be2iscsi/be_cmds.c:1020:28: sparse: sparse: cast to restricted __le16
   drivers/scsi/be2iscsi/be_cmds.c:1077:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] id @@     got restricted __le16 [usertype] @@
   drivers/scsi/be2iscsi/be_cmds.c:1077:25: sparse:     expected unsigned short [usertype] id
   drivers/scsi/be2iscsi/be_cmds.c:1077:25: sparse:     got restricted __le16 [usertype]
   drivers/scsi/be2iscsi/be_cmds.c:1170:26: sparse: sparse: cast to restricted __le16
   drivers/scsi/be2iscsi/be_cmds.c:1235:28: sparse: sparse: cast to restricted __le16
   drivers/scsi/be2iscsi/be_cmds.c: note: in included file (through arch/powerpc/include/asm/book3s/32/pgtable.h, arch/powerpc/include/asm/book3s/pgtable.h, ...):
   arch/powerpc/include/asm/io.h:175:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:180:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:175:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:180:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:180:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:180:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:175:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:175:1: sparse: sparse: dereference of noderef expression
   drivers/scsi/be2iscsi/be_cmds.c: note: in included file (through drivers/scsi/be2iscsi/be_main.h):
>> drivers/scsi/be2iscsi/be.h:209:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     expected unsigned int [usertype]
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/be2iscsi/be.h:209:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     expected unsigned int [usertype]
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/be2iscsi/be.h:209:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     expected unsigned int [usertype]
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/be2iscsi/be.h:209:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     expected unsigned int [usertype]
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/be2iscsi/be.h:209:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     expected unsigned int [usertype]
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/be2iscsi/be.h:209:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     expected unsigned int [usertype]
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/be2iscsi/be.h:209:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     expected unsigned int [usertype]
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/be2iscsi/be.h:209:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     expected unsigned int [usertype]
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/be2iscsi/be.h:209:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     expected unsigned int [usertype]
   drivers/scsi/be2iscsi/be.h:209:21: sparse:     got restricted __le32 [usertype]
   In file included from include/linux/kernel.h:11,
                    from include/asm-generic/bug.h:13,
                    from arch/powerpc/include/asm/bug.h:127,
                    from include/linux/bug.h:4,
                    from include/linux/scatterlist.h:6,
                    from include/scsi/scsi.h:9,
                    from include/scsi/iscsi_proto.h:25,
                    from drivers/scsi/be2iscsi/be_cmds.c:18:
   include/linux/log2.h:22:1: warning: ignoring attribute 'noreturn' because it conflicts with attribute 'const' [-Wattributes]
      22 | int ____ilog2_NaN(void);
         | ^~~
   drivers/scsi/be2iscsi/be_cmds.c:107:14: warning: no previous prototype for 'alloc_mcc_tag' [-Wmissing-prototypes]
     107 | unsigned int alloc_mcc_tag(struct beiscsi_hba *phba)
         |              ^~~~~~~~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c: In function 'beiscsi_cmd_eq_create':
   drivers/scsi/be2iscsi/be_cmds.c:796:28: warning: taking address of packed member of 'struct be_cmd_req_eq_create' may result in an unaligned pointer value [-Waddress-of-packed-member]
     796 |         be_cmd_hdr_prepare(&req->hdr, CMD_SUBSYSTEM_COMMON,
         |                            ^~~~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c:811:38: warning: taking address of packed member of 'struct be_cmd_req_eq_create' may result in an unaligned pointer value [-Waddress-of-packed-member]
     811 |         be_cmd_page_addrs_prepare(req->pages, ARRAY_SIZE(req->pages), q_mem);
         |                                   ~~~^~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c: In function 'beiscsi_cmd_cq_create':
   drivers/scsi/be2iscsi/be_cmds.c:920:28: warning: taking address of packed member of 'struct be_cmd_req_cq_create' may result in an unaligned pointer value [-Waddress-of-packed-member]
     920 |         be_cmd_hdr_prepare(&req->hdr, CMD_SUBSYSTEM_COMMON,
         |                            ^~~~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c:954:38: warning: taking address of packed member of 'struct be_cmd_req_cq_create' may result in an unaligned pointer value [-Waddress-of-packed-member]
     954 |         be_cmd_page_addrs_prepare(req->pages, ARRAY_SIZE(req->pages), q_mem);
         |                                   ~~~^~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c: In function 'beiscsi_cmd_mccq_create':
   drivers/scsi/be2iscsi/be_cmds.c:998:28: warning: taking address of packed member of 'struct be_cmd_req_mcc_create_ext' may result in an unaligned pointer value [-Waddress-of-packed-member]
     998 |         be_cmd_hdr_prepare(&req->hdr, CMD_SUBSYSTEM_COMMON,
         |                            ^~~~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c:1015:38: warning: taking address of packed member of 'struct be_cmd_req_mcc_create_ext' may result in an unaligned pointer value [-Waddress-of-packed-member]
    1015 |         be_cmd_page_addrs_prepare(req->pages, ARRAY_SIZE(req->pages), q_mem);
         |                                   ~~~^~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c: In function 'beiscsi_cmd_q_destroy':
   drivers/scsi/be2iscsi/be_cmds.c:1075:28: warning: taking address of packed member of 'struct be_cmd_req_q_destroy' may result in an unaligned pointer value [-Waddress-of-packed-member]
    1075 |         be_cmd_hdr_prepare(&req->hdr, subsys, opcode, sizeof(*req));
         |                            ^~~~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c: In function 'be_cmd_create_default_pdu_queue':
   drivers/scsi/be2iscsi/be_cmds.c:1121:28: warning: taking address of packed member of 'struct be_defq_create_req' may result in an unaligned pointer value [-Waddress-of-packed-member]
    1121 |         be_cmd_hdr_prepare(&req->hdr, CMD_SUBSYSTEM_ISCSI,
         |                            ^~~~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c:1163:38: warning: taking address of packed member of 'struct be_defq_create_req' may result in an unaligned pointer value [-Waddress-of-packed-member]
    1163 |         be_cmd_page_addrs_prepare(req->pages, ARRAY_SIZE(req->pages), q_mem);
         |                                   ~~~^~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c: In function 'be_cmd_wrbq_create':
   drivers/scsi/be2iscsi/be_cmds.c:1221:28: warning: taking address of packed member of 'struct be_wrbq_create_req' may result in an unaligned pointer value [-Waddress-of-packed-member]
    1221 |         be_cmd_hdr_prepare(&req->hdr, CMD_SUBSYSTEM_ISCSI,
         |                            ^~~~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c:1231:38: warning: taking address of packed member of 'struct be_wrbq_create_req' may result in an unaligned pointer value [-Waddress-of-packed-member]
    1231 |         be_cmd_page_addrs_prepare(req->pages, ARRAY_SIZE(req->pages), q_mem);
         |                                   ~~~^~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c: In function 'be_cmd_iscsi_post_template_hdr':
   drivers/scsi/be2iscsi/be_cmds.c:1262:28: warning: taking address of packed member of 'struct be_post_template_pages_req' may result in an unaligned pointer value [-Waddress-of-packed-member]
    1262 |         be_cmd_hdr_prepare(&req->hdr, CMD_SUBSYSTEM_COMMON,
         |                            ^~~~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c:1268:38: warning: taking address of packed member of 'struct be_post_template_pages_req' may result in an unaligned pointer value [-Waddress-of-packed-member]
    1268 |         be_cmd_page_addrs_prepare(req->pages, ARRAY_SIZE(req->pages), q_mem);
         |                                   ~~~^~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c: In function 'be_cmd_iscsi_remove_template_hdr':
   drivers/scsi/be2iscsi/be_cmds.c:1285:28: warning: taking address of packed member of 'struct be_remove_template_pages_req' may result in an unaligned pointer value [-Waddress-of-packed-member]
    1285 |         be_cmd_hdr_prepare(&req->hdr, CMD_SUBSYSTEM_COMMON,
         |                            ^~~~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c: In function 'be_cmd_iscsi_post_sgl_pages':
   drivers/scsi/be2iscsi/be_cmds.c:1315:36: warning: taking address of packed member of 'struct be_post_sgl_pages_req' may result in an unaligned pointer value [-Waddress-of-packed-member]
    1315 |                 be_cmd_hdr_prepare(&req->hdr, CMD_SUBSYSTEM_ISCSI,
         |                                    ^~~~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c:1322:46: warning: taking address of packed member of 'struct be_post_sgl_pages_req' may result in an unaligned pointer value [-Waddress-of-packed-member]
    1322 |                 be_cmd_page_addrs_prepare(req->pages, req->num_pages, q_mem);
         |                                           ~~~^~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c: In function 'beiscsi_cmd_reset_function':
   drivers/scsi/be2iscsi/be_cmds.c:1357:28: warning: taking address of packed member of 'struct be_post_sgl_pages_req' may result in an unaligned pointer value [-Waddress-of-packed-member]
    1357 |         be_cmd_hdr_prepare(&req->hdr, CMD_SUBSYSTEM_COMMON,
         |                            ^~~~~~~~~
   drivers/scsi/be2iscsi/be_cmds.c: In function 'be_cmd_set_vlan':
   drivers/scsi/be2iscsi/be_cmds.c:1393:28: warning: taking address of packed member of 'struct be_cmd_set_vlan_req' may result in an unaligned pointer value [-Waddress-of-packed-member]
    1393 |         be_cmd_hdr_prepare(&req->hdr, CMD_SUBSYSTEM_ISCSI,
         |                            ^~~~~~~~~

vim +427 drivers/net/ethernet/8390/wd.c

^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  414  
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  415  	int wd_cmdreg = dev->base_addr - WD_NIC_OFFSET; /* WD_CMDREG */
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  416  	void __iomem *hdr_start = ei_status.mem + ((ring_page - WD_START_PG)<<8);
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  417  
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  418  	/* We'll always get a 4 byte header read followed by a packet read, so
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  419  	   we enable 16 bit mode before the header, and disable after the body. */
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  420  	if (ei_status.word16)
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  421  		outb(ISA16 | ei_status.reg5, wd_cmdreg+WD_CMDREG5);
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  422  
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  423  #ifdef __BIG_ENDIAN
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  424  	/* Officially this is what we are doing, but the readl() is faster */
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  425  	/* unfortunately it isn't endian aware of the struct               */
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  426  	memcpy_fromio(hdr, hdr_start, sizeof(struct e8390_pkt_hdr));
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16 @427  	hdr->count = le16_to_cpu(hdr->count);
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  428  #else
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  429  	((unsigned int*)hdr)[0] = readl(hdr_start);
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  430  #endif
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  431  }
^1da177e4c3f41 drivers/net/wd.c Linus Torvalds 2005-04-16  432  

:::::: The code at line 427 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
