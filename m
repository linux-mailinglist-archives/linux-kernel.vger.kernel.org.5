Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DAB812211
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjLMWwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjLMWwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:52:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB0885
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702507925; x=1734043925;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rs5vY7HcHDxk4XACzBRmtK+YkfgemqV9rt6byDcw4eA=;
  b=h0auRMWe6pIevX51AtM5VBXaTlkSc9+CMP7p6F5uIR4MFU8u6z4StQTZ
   Ou5bG/g1a5K/Hh57nkqbTA35Dq9oIwvBheAYE1q8Udjj9cfHpT5T68yAs
   nSwqAd9DpsSYuZVvMj+mAR7daqWLfCPihHMCfhWiycZjxyqLL6bdy1nJ+
   8m+XugxKwiwMTwHnCgpj6BY70S3lXqVuOY1l0lY9tDOLuFXMwzofhCZRp
   +jYiWXn0YKHV+GUSBVSM0aMtRy4GUzCWqRaa/9suUVDzhnwipWFD9jdC5
   QQceamnvSU+xShUDrvEUDqQ81/f8uJ2XZumYGlXZSaKYhV2W1/wTFdVj5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="398874803"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="398874803"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 14:52:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="844489925"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="844489925"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Dec 2023 14:52:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDY4V-000LEl-2J;
        Wed, 13 Dec 2023 22:51:40 +0000
Date:   Thu, 14 Dec 2023 06:50:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: drivers/isdn/hardware/mISDN/hfcmulti.c:466:22: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202312140624.tqVeZXgf-lkp@intel.com>
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
commit: eed0eabd12ef061821cbfa20d903476e07645320 MIPS: generic: Introduce generic DT-based board support
date:   7 years ago
config: mips-randconfig-r132-20231115 (https://download.01.org/0day-ci/archive/20231214/202312140624.tqVeZXgf-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231214/202312140624.tqVeZXgf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312140624.tqVeZXgf-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/isdn/hardware/mISDN/hfcmulti.c:466:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:466:22: sparse:     expected unsigned int [usertype] val
   drivers/isdn/hardware/mISDN/hfcmulti.c:466:22: sparse:     got restricted __le32 [usertype]
>> drivers/isdn/hardware/mISDN/hfcmulti.c:471:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:471:22: sparse:     expected unsigned short [usertype] val
   drivers/isdn/hardware/mISDN/hfcmulti.c:471:22: sparse:     got restricted __le16 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:486:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:486:24: sparse:     expected unsigned int [usertype] val
   drivers/isdn/hardware/mISDN/hfcmulti.c:486:24: sparse:     got restricted __le32 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:492:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:492:24: sparse:     expected unsigned short [usertype] val
   drivers/isdn/hardware/mISDN/hfcmulti.c:492:24: sparse:     got restricted __le16 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:510:32: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:515:32: sparse: sparse: cast to restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:532:25: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:538:25: sparse: sparse: cast to restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:1106:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:1106:26: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/isdn/hardware/mISDN/hfcmulti.c:1106:26: sparse:     got void *
   In file included from include/linux/kernel.h:11,
                    from include/linux/interrupt.h:5,
                    from drivers/isdn/hardware/mISDN/hfcmulti.c:167:
   include/linux/log2.h:22:1: warning: ignoring attribute 'noreturn' because it conflicts with attribute 'const' [-Wattributes]
      22 | int ____ilog2_NaN(void);
         | ^~~
   drivers/isdn/hardware/mISDN/hfcmulti.c: In function 'hfcmulti_interrupt':
   drivers/isdn/hardware/mISDN/hfcmulti.c:2767:17: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    2767 |                 ; /* external IRQ */
         |                 ^
   In file included from drivers/isdn/hardware/mISDN/hfcmulti.c:168:
   drivers/isdn/hardware/mISDN/hfcmulti.c: At top level:
   include/linux/module.h:138:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'HFCmulti_cleanup': 'cold' [-Wmissing-attributes]
     138 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   drivers/isdn/hardware/mISDN/hfcmulti.c:5585:1: note: in expansion of macro 'module_exit'
    5585 | module_exit(HFCmulti_cleanup);
         | ^~~~~~~~~~~
   drivers/isdn/hardware/mISDN/hfcmulti.c:5480:1: note: 'cleanup_module' target declared here
    5480 | HFCmulti_cleanup(void)
         | ^~~~~~~~~~~~~~~~
   include/linux/module.h:132:13: warning: 'init_module' specifies less restrictive attribute than its target 'HFCmulti_init': 'cold' [-Wmissing-attributes]
     132 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   drivers/isdn/hardware/mISDN/hfcmulti.c:5584:1: note: in expansion of macro 'module_init'
    5584 | module_init(HFCmulti_init);
         | ^~~~~~~~~~~
   drivers/isdn/hardware/mISDN/hfcmulti.c:5491:1: note: 'init_module' target declared here
    5491 | HFCmulti_init(void)
         | ^~~~~~~~~~~~~
--
   drivers/isdn/hardware/mISDN/avmfritz.c:433:23: sparse: sparse: cast to restricted __le32
>> drivers/isdn/hardware/mISDN/avmfritz.c:506:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/isdn/hardware/mISDN/avmfritz.c:506:30: sparse:     expected unsigned int [usertype] val
   drivers/isdn/hardware/mISDN/avmfritz.c:506:30: sparse:     got restricted __le32 [usertype]
   drivers/isdn/hardware/mISDN/avmfritz.c:966:1: sparse: sparse: symbol 'setup_fritz' was not declared. Should it be static?
   In file included from include/linux/kernel.h:11,
                    from include/linux/interrupt.h:5,
                    from drivers/isdn/hardware/mISDN/avmfritz.c:23:
   include/linux/log2.h:22:1: warning: ignoring attribute 'noreturn' because it conflicts with attribute 'const' [-Wattributes]
      22 | int ____ilog2_NaN(void);
         | ^~~
   drivers/isdn/hardware/mISDN/avmfritz.c:288:1: warning: no previous prototype for 'write_ctrl' [-Wmissing-prototypes]
     288 | write_ctrl(struct bchannel *bch, int which) {
         | ^~~~~~~~~~
   drivers/isdn/hardware/mISDN/avmfritz.c:745:1: warning: no previous prototype for 'clear_pending_hdlc_ints' [-Wmissing-prototypes]
     745 | clear_pending_hdlc_ints(struct fritzcard *fc)
         | ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/isdn/hardware/mISDN/avmfritz.c:966:1: warning: no previous prototype for 'setup_fritz' [-Wmissing-prototypes]
     966 | setup_fritz(struct fritzcard *fc)
         | ^~~~~~~~~~~
   In file included from drivers/isdn/hardware/mISDN/avmfritz.c:24:
   include/linux/module.h:138:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'AVM_cleanup': 'cold' [-Wmissing-attributes]
     138 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   drivers/isdn/hardware/mISDN/avmfritz.c:1176:1: note: in expansion of macro 'module_exit'
    1176 | module_exit(AVM_cleanup);
         | ^~~~~~~~~~~
   drivers/isdn/hardware/mISDN/avmfritz.c:1170:20: note: 'cleanup_module' target declared here
    1170 | static void __exit AVM_cleanup(void)
         |                    ^~~~~~~~~~~
   include/linux/module.h:132:13: warning: 'init_module' specifies less restrictive attribute than its target 'AVM_init': 'cold' [-Wmissing-attributes]
     132 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   drivers/isdn/hardware/mISDN/avmfritz.c:1175:1: note: in expansion of macro 'module_init'
    1175 | module_init(AVM_init);
         | ^~~~~~~~~~~
   drivers/isdn/hardware/mISDN/avmfritz.c:1161:19: note: 'init_module' target declared here
    1161 | static int __init AVM_init(void)
         |                   ^~~~~~~~
   drivers/isdn/hardware/mISDN/avmfritz.c: In function 'modehdlc':
   drivers/isdn/hardware/mISDN/avmfritz.c:363:28: warning: this statement may fall through [-Wimplicit-fallthrough=]
     363 |                 bch->state = -1;
         |                 ~~~~~~~~~~~^~~~
   drivers/isdn/hardware/mISDN/avmfritz.c:364:9: note: here
     364 |         case ISDN_P_NONE:
         |         ^~~~
--
   drivers/scsi/hptiop.c:158:53: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:180:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:180:35: sparse:     expected void volatile [noderef] <asn:2> *mem
   drivers/scsi/hptiop.c:180:35: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:216:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:216:34: sparse:     expected void const volatile [noderef] <asn:2> *mem
   drivers/scsi/hptiop.c:216:34: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:217:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:217:35: sparse:     expected void volatile [noderef] <asn:2> *mem
   drivers/scsi/hptiop.c:217:35: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:252:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] result @@     got int @@
   drivers/scsi/hptiop.c:252:44: sparse:     expected restricted __le32 [usertype] result
   drivers/scsi/hptiop.c:252:44: sparse:     got int
   drivers/scsi/hptiop.c:297:35: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:284:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:285:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cur_rptr @@     got restricted __le32 [usertype] outlist_rptr @@
   drivers/scsi/hptiop.c:285:34: sparse:     expected unsigned int [usertype] cur_rptr
   drivers/scsi/hptiop.c:285:34: sparse:     got restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:291:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] _tag @@     got restricted __le32 [usertype] val @@
   drivers/scsi/hptiop.c:291:38: sparse:     expected unsigned int [usertype] _tag
   drivers/scsi/hptiop.c:291:38: sparse:     got restricted __le32 [usertype] val
   drivers/scsi/hptiop.c:296:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int [assigned] [usertype] cur_rptr @@
   drivers/scsi/hptiop.c:296:52: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:296:52: sparse:     got unsigned int [assigned] [usertype] cur_rptr
   drivers/scsi/hptiop.c:377:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:377:52: sparse:     expected void volatile [noderef] <asn:2> *mem
   drivers/scsi/hptiop.c:377:52: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:378:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:378:25: sparse:     expected void const volatile [noderef] <asn:2> *mem
   drivers/scsi/hptiop.c:378:25: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:461:64: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct hpt_iop_request_get_config *info @@     got struct hpt_iop_request_get_config [noderef] <asn:2> *config @@
   drivers/scsi/hptiop.c:461:64: sparse:     expected struct hpt_iop_request_get_config *info
   drivers/scsi/hptiop.c:461:64: sparse:     got struct hpt_iop_request_get_config [noderef] <asn:2> *config
   drivers/scsi/hptiop.c:463:25: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:566:27: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:566:27: sparse:     expected void volatile [noderef] <asn:2> *mem
   drivers/scsi/hptiop.c:566:27: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:645:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hpt_iopmv_regs *regs @@     got void [noderef] <asn:2> * @@
   drivers/scsi/hptiop.c:645:24: sparse:     expected struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:645:24: sparse:     got void [noderef] <asn:2> *
   drivers/scsi/hptiop.c:651:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got struct hpt_iopmv_regs *regs @@
   drivers/scsi/hptiop.c:651:34: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/scsi/hptiop.c:651:34: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:675:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got struct hpt_iopmv_regs *regs @@
   drivers/scsi/hptiop.c:675:26: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/scsi/hptiop.c:675:26: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:942:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:947:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:948:30: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:952:43: sparse: sparse: invalid assignment: &=
   drivers/scsi/hptiop.c:952:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:952:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:953:43: sparse: sparse: invalid assignment: ^=
   drivers/scsi/hptiop.c:953:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:953:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:958:57: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:958:48: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] intrfc_len @@     got unsigned int @@
   drivers/scsi/hptiop.c:958:48: sparse:     expected restricted __le32 [usertype] intrfc_len
   drivers/scsi/hptiop.c:958:48: sparse:     got unsigned int
>> drivers/scsi/hptiop.c:959:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] inlist_wptr @@
   drivers/scsi/hptiop.c:959:29: sparse:     expected unsigned int [usertype] val
   drivers/scsi/hptiop.c:959:29: sparse:     got restricted __le32 [usertype] inlist_wptr
>> drivers/scsi/hptiop.c:984:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/scsi/hptiop.c:984:16: sparse:     expected unsigned int [usertype] val
   drivers/scsi/hptiop.c:984:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/hptiop.c:986:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/scsi/hptiop.c:986:16: sparse:     expected unsigned int [usertype] val
   drivers/scsi/hptiop.c:986:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/hptiop.c:989:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/scsi/hptiop.c:989:16: sparse:     expected unsigned int [usertype] val
   drivers/scsi/hptiop.c:989:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/hptiop.c:991:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/scsi/hptiop.c:991:16: sparse:     expected unsigned int [usertype] val
   drivers/scsi/hptiop.c:991:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/hptiop.c:994:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/scsi/hptiop.c:994:16: sparse:     expected unsigned int [usertype] val
   drivers/scsi/hptiop.c:994:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/hptiop.c:996:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/scsi/hptiop.c:996:16: sparse:     expected unsigned int [usertype] val
   drivers/scsi/hptiop.c:996:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/hptiop.c:999:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] inlist_wptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:999:35: sparse:     expected restricted __le32 [usertype] inlist_wptr
   drivers/scsi/hptiop.c:999:35: sparse:     got unsigned int
   drivers/scsi/hptiop.c:1000:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got unsigned int @@
   drivers/scsi/hptiop.c:1000:37: sparse:     expected restricted __le32 [usertype]
   drivers/scsi/hptiop.c:1000:37: sparse:     got unsigned int
   drivers/scsi/hptiop.c:1001:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:1001:36: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:1001:36: sparse:     got unsigned int
   drivers/scsi/hptiop.c:1544:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1544:29: sparse:     expected void volatile [noderef] <asn:2> *mem
   drivers/scsi/hptiop.c:1544:29: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:1545:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1545:25: sparse:     expected void const volatile [noderef] <asn:2> *mem
   drivers/scsi/hptiop.c:1545:25: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:158:51: sparse: sparse: dereference of noderef expression
   drivers/scsi/hptiop.c:158:51: sparse: sparse: dereference of noderef expression
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/scsi/hptiop.c:18:
   include/linux/log2.h:22:1: warning: ignoring attribute 'noreturn' because it conflicts with attribute 'const' [-Wattributes]
      22 | int ____ilog2_NaN(void);
         | ^~~
   include/linux/module.h:138:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'hptiop_module_exit': 'cold' [-Wmissing-attributes]
     138 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   drivers/scsi/hptiop.c:1709:1: note: in expansion of macro 'module_exit'
    1709 | module_exit(hptiop_module_exit);
         | ^~~~~~~~~~~
   drivers/scsi/hptiop.c:1702:20: note: 'cleanup_module' target declared here
    1702 | static void __exit hptiop_module_exit(void)
         |                    ^~~~~~~~~~~~~~~~~~
   include/linux/module.h:132:13: warning: 'init_module' specifies less restrictive attribute than its target 'hptiop_module_init': 'cold' [-Wmissing-attributes]
     132 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   drivers/scsi/hptiop.c:1708:1: note: in expansion of macro 'module_init'
    1708 | module_init(hptiop_module_init);
         | ^~~~~~~~~~~
   drivers/scsi/hptiop.c:1696:19: note: 'init_module' target declared here
    1696 | static int __init hptiop_module_init(void)
         |                   ^~~~~~~~~~~~~~~~~~
--
   sound/pci/mixart/mixart.c:1205:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1205:23: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart.c:1205:23: sparse:     got unsigned int *
>> sound/pci/mixart/mixart.c:1205:23: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1208:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1208:47: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart.c:1208:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1208:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1209:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1209:47: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart.c:1209:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1209:47: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart.c:1210:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart.c:1210:47: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart.c:1210:47: sparse:     got unsigned int *
   sound/pci/mixart/mixart.c:1210:47: sparse: sparse: cast to restricted __be32
   In file included from include/linux/kernel.h:11,
                    from include/linux/interrupt.h:5,
                    from sound/pci/mixart/mixart.c:25:
   include/linux/log2.h:22:1: warning: ignoring attribute 'noreturn' because it conflicts with attribute 'const' [-Wattributes]
      22 | int ____ilog2_NaN(void);
         | ^~~
   In file included from sound/pci/mixart/mixart.c:28:
   include/linux/module.h:138:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'mixart_driver_exit': 'cold' [-Wmissing-attributes]
     138 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   include/linux/device.h:1355:1: note: in expansion of macro 'module_exit'
    1355 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/pci.h:1205:9: note: in expansion of macro 'module_driver'
    1205 |         module_driver(__pci_driver, pci_register_driver, 32-      |         ^~~~~~~~~~~~~
   sound/pci/mixart/mixart.c:1422:1: note: in expansion of macro 'module_pci_driver'
    1422 | module_pci_driver(mixart_driver);
         | ^~~~~~~~~~~~~~~~~
   In file included from include/linux/pci.h:30,
                    from sound/pci/mixart/mixart.c:26:
   sound/pci/mixart/mixart.c:1422:19: note: 'cleanup_module' target declared here
    1422 | module_pci_driver(mixart_driver);
         |                   ^~~~~~~~~~~~~
   include/linux/device.h:1351:20: note: in definition of macro 'module_driver'
    1351 | static void __exit __driver##_exit(void) 43-      |                    ^~~~~~~~
   sound/pci/mixart/mixart.c:1422:1: note: in expansion of macro 'module_pci_driver'
    1422 | module_pci_driver(mixart_driver);
         | ^~~~~~~~~~~~~~~~~
   include/linux/module.h:132:13: warning: 'init_module' specifies less restrictive attribute than its target 'mixart_driver_init': 'cold' [-Wmissing-attributes]
     132 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   include/linux/device.h:1350:1: note: in expansion of macro 'module_init'
    1350 | module_init(__driver##_init); 52-      | ^~~~~~~~~~~
   include/linux/pci.h:1205:9: note: in expansion of macro 'module_driver'
    1205 |         module_driver(__pci_driver, pci_register_driver, 55-      |         ^~~~~~~~~~~~~
   sound/pci/mixart/mixart.c:1422:1: note: in expansion of macro 'module_pci_driver'
    1422 | module_pci_driver(mixart_driver);
         | ^~~~~~~~~~~~~~~~~
   sound/pci/mixart/mixart.c:1422:19: note: 'init_module' target declared here
    1422 | module_pci_driver(mixart_driver);
         |                   ^~~~~~~~~~~~~
   include/linux/device.h:1346:19: note: in definition of macro 'module_driver'
    1346 | static int __init __driver##_init(void) 64-      |                   ^~~~~~~~
   sound/pci/mixart/mixart.c:1422:1: note: in expansion of macro 'module_pci_driver'
    1422 | module_pci_driver(mixart_driver);
         | ^~~~~~~~~~~~~~~~~
   sound/pci/mixart/mixart.c: In function 'mixart_set_clock':
   sound/pci/mixart/mixart.c:183:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
     183 |                 if(rate != 0)
         |                   ^
   sound/pci/mixart/mixart.c:185:9: note: here
     185 |         default:
         |         ^~~~~~~
--
   sound/pci/mixart/mixart_core.c:54:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:54:19: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:54:19: sparse:     got unsigned int *
>> sound/pci/mixart/mixart_core.c:54:19: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:55:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:55:19: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:55:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:55:19: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:65:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:65:22: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:65:22: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:65:22: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart_core.c:71:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_core.c:71:9: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_core.c:71:9: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_core.c:71:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:71:9: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:71:9: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:90:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:90:32: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:90:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:90:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:91:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:91:32: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:91:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:91:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:92:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:92:32: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:92:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:92:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:93:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:93:32: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:93:32: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:93:32: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:117:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:117:19: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:117:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:117:19: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:125:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_core.c:125:9: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_core.c:125:9: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_core.c:125:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:125:9: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:125:9: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:132:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_core.c:132:9: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_core.c:132:9: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_core.c:132:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:132:9: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:132:9: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:159:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:159:19: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:159:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:159:19: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:160:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:160:19: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:160:19: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:160:19: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:171:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:171:29: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:171:29: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:171:29: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_core.c:179:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_core.c:179:9: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_core.c:179:9: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_core.c:179:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:179:9: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:179:9: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:184:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_core.c:184:9: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_core.c:184:9: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_core.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:184:9: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:184:9: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:185:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_core.c:185:9: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_core.c:185:9: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_core.c:185:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:185:9: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:185:9: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:186:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_core.c:186:9: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_core.c:186:9: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_core.c:186:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:186:9: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:186:9: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:187:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_core.c:187:9: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_core.c:187:9: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_core.c:187:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:187:9: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:187:9: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:188:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_core.c:188:9: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_core.c:188:9: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_core.c:188:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:188:9: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:188:9: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:189:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_core.c:189:9: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_core.c:189:9: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_core.c:189:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:189:9: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:189:9: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:190:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_core.c:190:9: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_core.c:190:9: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_core.c:190:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_core.c:190:9: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_core.c:190:9: sparse:     got unsigned int *
   sound/pci/mixart/mixart_core.c:191:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_core.c:191:9: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_core.c:191:9: sparse:     got restricted __be32 [usertype]
--
   sound/pci/mixart/mixart_hwdep.c:58:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:58:24: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:58:24: sparse:     got unsigned int *
>> sound/pci/mixart/mixart_hwdep.c:58:24: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:116:31: sparse: sparse: cast to restricted __be16
   sound/pci/mixart/mixart_hwdep.c:117:35: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:117:80: sparse: sparse: cast to restricted __be16
   sound/pci/mixart/mixart_hwdep.c:123:54: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:124:66: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:125:54: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:352:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:352:25: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:352:25: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:352:25: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:354:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:354:22: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:354:22: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:354:22: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:356:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:356:25: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:356:25: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:356:25: sparse: sparse: cast to restricted __be32
>> sound/pci/mixart/mixart_hwdep.c:387:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:387:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:387:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:387:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:387:17: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:387:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:390:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:390:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:390:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:390:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:390:17: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:390:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:392:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:392:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:392:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:392:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:392:17: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:392:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:398:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:398:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:398:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:398:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:398:17: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:398:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:427:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:427:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:427:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:427:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:427:17: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:427:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:428:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:428:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:428:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:428:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:428:17: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:428:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:431:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:431:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:431:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:431:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:431:17: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:431:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:438:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:438:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:438:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:438:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:438:17: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:438:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:448:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:448:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:448:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:448:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:448:17: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:448:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:470:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:470:57: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:470:57: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:470:57: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:494:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:494:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:494:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:494:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:494:17: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:494:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:497:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:497:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:497:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:497:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:497:17: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:497:17: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:507:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:507:23: sparse:     expected void const volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:507:23: sparse:     got unsigned int *
   sound/pci/mixart/mixart_hwdep.c:507:23: sparse: sparse: cast to restricted __be32
   sound/pci/mixart/mixart_hwdep.c:515:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   sound/pci/mixart/mixart_hwdep.c:515:17: sparse:     expected unsigned int [usertype] val
   sound/pci/mixart/mixart_hwdep.c:515:17: sparse:     got restricted __be32 [usertype]
   sound/pci/mixart/mixart_hwdep.c:515:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   sound/pci/mixart/mixart_hwdep.c:515:17: sparse:     expected void volatile [noderef] <asn:2> *mem
   sound/pci/mixart/mixart_hwdep.c:515:17: sparse:     got unsigned int *
   In file included from include/linux/kernel.h:11,
                    from include/linux/interrupt.h:5,
                    from sound/pci/mixart/mixart_hwdep.c:23:
   include/linux/log2.h:22:1: warning: ignoring attribute 'noreturn' because it conflicts with attribute 'const' [-Wattributes]
      22 | int ____ilog2_NaN(void);
         | ^~~

vim +466 drivers/isdn/hardware/mISDN/hfcmulti.c

af69fb3a8ffa37 Karsten Keil 2008-07-27  459  
af69fb3a8ffa37 Karsten Keil 2008-07-27  460  /* write fifo data (REGIO) */
5b8343540a3d27 Hannes Eder  2008-12-12  461  static void
af69fb3a8ffa37 Karsten Keil 2008-07-27  462  write_fifo_regio(struct hfc_multi *hc, u_char *data, int len)
af69fb3a8ffa37 Karsten Keil 2008-07-27  463  {
af69fb3a8ffa37 Karsten Keil 2008-07-27  464  	outb(A_FIFO_DATA0, (hc->pci_iobase) + 4);
af69fb3a8ffa37 Karsten Keil 2008-07-27  465  	while (len >> 2) {
b3e0aeeb7e0f89 Karsten Keil 2008-08-02 @466  		outl(cpu_to_le32(*(u32 *)data), hc->pci_iobase);
af69fb3a8ffa37 Karsten Keil 2008-07-27  467  		data += 4;
af69fb3a8ffa37 Karsten Keil 2008-07-27  468  		len -= 4;
af69fb3a8ffa37 Karsten Keil 2008-07-27  469  	}
af69fb3a8ffa37 Karsten Keil 2008-07-27  470  	while (len >> 1) {
b3e0aeeb7e0f89 Karsten Keil 2008-08-02 @471  		outw(cpu_to_le16(*(u16 *)data), hc->pci_iobase);
af69fb3a8ffa37 Karsten Keil 2008-07-27  472  		data += 2;
af69fb3a8ffa37 Karsten Keil 2008-07-27  473  		len -= 2;
af69fb3a8ffa37 Karsten Keil 2008-07-27  474  	}
af69fb3a8ffa37 Karsten Keil 2008-07-27  475  	while (len) {
af69fb3a8ffa37 Karsten Keil 2008-07-27  476  		outb(*data, hc->pci_iobase);
af69fb3a8ffa37 Karsten Keil 2008-07-27  477  		data++;
af69fb3a8ffa37 Karsten Keil 2008-07-27  478  		len--;
af69fb3a8ffa37 Karsten Keil 2008-07-27  479  	}
af69fb3a8ffa37 Karsten Keil 2008-07-27  480  }
af69fb3a8ffa37 Karsten Keil 2008-07-27  481  /* write fifo data (PCIMEM) */
5b8343540a3d27 Hannes Eder  2008-12-12  482  static void
af69fb3a8ffa37 Karsten Keil 2008-07-27  483  write_fifo_pcimem(struct hfc_multi *hc, u_char *data, int len)
af69fb3a8ffa37 Karsten Keil 2008-07-27  484  {
af69fb3a8ffa37 Karsten Keil 2008-07-27  485  	while (len >> 2) {
b3e0aeeb7e0f89 Karsten Keil 2008-08-02  486  		writel(cpu_to_le32(*(u32 *)data),
b3e0aeeb7e0f89 Karsten Keil 2008-08-02  487  		       hc->pci_membase + A_FIFO_DATA0);
af69fb3a8ffa37 Karsten Keil 2008-07-27  488  		data += 4;
af69fb3a8ffa37 Karsten Keil 2008-07-27  489  		len -= 4;
af69fb3a8ffa37 Karsten Keil 2008-07-27  490  	}
af69fb3a8ffa37 Karsten Keil 2008-07-27  491  	while (len >> 1) {
b3e0aeeb7e0f89 Karsten Keil 2008-08-02  492  		writew(cpu_to_le16(*(u16 *)data),
b3e0aeeb7e0f89 Karsten Keil 2008-08-02  493  		       hc->pci_membase + A_FIFO_DATA0);
af69fb3a8ffa37 Karsten Keil 2008-07-27  494  		data += 2;
af69fb3a8ffa37 Karsten Keil 2008-07-27  495  		len -= 2;
af69fb3a8ffa37 Karsten Keil 2008-07-27  496  	}
af69fb3a8ffa37 Karsten Keil 2008-07-27  497  	while (len) {
b3e0aeeb7e0f89 Karsten Keil 2008-08-02  498  		writeb(*data, hc->pci_membase + A_FIFO_DATA0);
af69fb3a8ffa37 Karsten Keil 2008-07-27  499  		data++;
af69fb3a8ffa37 Karsten Keil 2008-07-27  500  		len--;
af69fb3a8ffa37 Karsten Keil 2008-07-27  501  	}
af69fb3a8ffa37 Karsten Keil 2008-07-27  502  }
eac74af9b547e2 Karsten Keil 2009-05-22  503  

:::::: The code at line 466 was first introduced by commit
:::::: b3e0aeeb7e0f89791c4c3bdfd98b36074c5178e6 Fix remaining big endian issue of hfcmulti

:::::: TO: Karsten Keil <kkeil@suse.de>
:::::: CC: Karsten Keil <kkeil@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
