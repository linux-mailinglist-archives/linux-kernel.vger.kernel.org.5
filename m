Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476E780CED7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbjLKOy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjLKOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:54:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1F8C3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702306471; x=1733842471;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+/NFYvHEsxdbN+nx8eF0w139widCAqIb9e2zhQ+xkYk=;
  b=B8tw2KY+og0H7+UqryOuJekw2BfJ1Nzu3Wm/oetasVTWqeQk9xeU/u6a
   68afmNx0/nq/5shnahbGO/dLZHAgzXp3C5s0FKDvpTu47Q2OVtQqEDbCs
   k2qYm1pk/gGIwiU3gQCBKI80H8SZkQfpM/1iFzNTKEYiYsbSbooS9h8Zs
   n1+bmNVvtQVzWPNwFrKj6/lnWDjGooVWomJ832DasyLPE2sD52TCvIWG9
   iWn5KBZ/8ypRjywFUxzdfCXk/E/ea2JnO2YJGSfsDWfR2uDQ7PHuRtstM
   FHEigwsIHpjFfyhe9Iz/uICcwollF8XTLjD9K8UZjVD29rGOLkW015YJ5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1466295"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1466295"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 06:54:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="776709029"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="776709029"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 11 Dec 2023 06:54:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rChfu-000I82-0G;
        Mon, 11 Dec 2023 14:54:26 +0000
Date:   Mon, 11 Dec 2023 22:53:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: sound/soc/intel/skylake/skl-topology.c:3088:53: sparse: sparse:
 incorrect type in argument 3 (different base types)
Message-ID: <202312112217.lFfzgjCM-lkp@intel.com>
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

Hi Sunil,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
commit: a91a9ffbd3a55a0ae1bb75e2b6e85b2a03f64e8f RISC-V: Add support to build the ACPI core
date:   6 months ago
config: riscv-randconfig-r133-20231211 (https://download.01.org/0day-ci/archive/20231211/202312112217.lFfzgjCM-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231211/202312112217.lFfzgjCM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312112217.lFfzgjCM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   sound/soc/intel/skylake/skl-topology.c:2525:68: sparse:     expected unsigned int [usertype] tkn
   sound/soc/intel/skylake/skl-topology.c:2525:68: sparse:     got restricted __le32 [usertype] token
   sound/soc/intel/skylake/skl-topology.c:2526:41: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2526:41: sparse:     expected unsigned int [usertype] val
   sound/soc/intel/skylake/skl-topology.c:2526:41: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2545:29: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2548:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected int fmt_cfg_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2548:38: sparse:     expected int fmt_cfg_idx
   sound/soc/intel/skylake/skl-topology.c:2548:38: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2552:73: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] caps_size @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2552:73: sparse:     expected unsigned int [usertype] caps_size
   sound/soc/intel/skylake/skl-topology.c:2552:73: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2558:74: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] set_params @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2558:74: sparse:     expected unsigned int [usertype] set_params
   sound/soc/intel/skylake/skl-topology.c:2558:74: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2563:72: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] param_id @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2563:72: sparse:     expected unsigned int [usertype] param_id
   sound/soc/intel/skylake/skl-topology.c:2563:72: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2568:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] domain @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2568:33: sparse:     expected unsigned char [usertype] domain
   sound/soc/intel/skylake/skl-topology.c:2568:33: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2574:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dma_buffer_size @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2574:42: sparse:     expected unsigned int [usertype] dma_buffer_size
   sound/soc/intel/skylake/skl-topology.c:2574:42: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2365:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2613:21: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:2613:21: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:2613:21: sparse:    right side has type restricted __le32
   sound/soc/intel/skylake/skl-topology.c:2615:30: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2643:43: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2675:32: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2675:32: sparse:     expected int
   sound/soc/intel/skylake/skl-topology.c:2675:32: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2671:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2671:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2671:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2894:13: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:2894:13: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:2894:13: sparse:    right side has type restricted __le32
   sound/soc/intel/skylake/skl-topology.c:2905:21: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:2905:21: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:2905:21: sparse:    right side has type restricted __le32
   sound/soc/intel/skylake/skl-topology.c:2915:21: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:2915:21: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:2915:21: sparse:    right side has type restricted __le32
   sound/soc/intel/skylake/skl-topology.c:3038:47: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned short [usertype] event_type @@     got restricted __le16 [usertype] event_type @@
   sound/soc/intel/skylake/skl-topology.c:3038:47: sparse:     expected unsigned short [usertype] event_type
   sound/soc/intel/skylake/skl-topology.c:3038:47: sparse:     got restricted __le16 [usertype] event_type
>> sound/soc/intel/skylake/skl-topology.c:3088:53: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] @@     got restricted __le32 [usertype] size @@
   sound/soc/intel/skylake/skl-topology.c:3088:53: sparse:     expected unsigned long [usertype]
   sound/soc/intel/skylake/skl-topology.c:3088:53: sparse:     got restricted __le32 [usertype] size
   sound/soc/intel/skylake/skl-topology.c:3134:29: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3107:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3107:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3155:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3185:33: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3228:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] id @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3228:29: sparse:     expected unsigned char [usertype] id
   sound/soc/intel/skylake/skl-topology.c:3228:29: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3232:63: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] tkn @@     got restricted __le32 [usertype] token @@
   sound/soc/intel/skylake/skl-topology.c:3232:63: sparse:     expected unsigned int [usertype] tkn
   sound/soc/intel/skylake/skl-topology.c:3232:63: sparse:     got restricted __le32 [usertype] token
   sound/soc/intel/skylake/skl-topology.c:3233:49: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3233:49: sparse:     expected unsigned int [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3233:49: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3226:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3252:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] input_pin_type @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3252:37: sparse:     expected unsigned char [usertype] input_pin_type
   sound/soc/intel/skylake/skl-topology.c:3252:37: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3256:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] output_pin_type @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3256:38: sparse:     expected unsigned char [usertype] output_pin_type
   sound/soc/intel/skylake/skl-topology.c:3256:38: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3260:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] max_input_pins @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3260:37: sparse:     expected unsigned char [usertype] max_input_pins
   sound/soc/intel/skylake/skl-topology.c:3260:37: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3264:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] max_output_pins @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3264:38: sparse:     expected unsigned char [usertype] max_output_pins
   sound/soc/intel/skylake/skl-topology.c:3264:38: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3268:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] nr_resources @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3268:35: sparse:     expected unsigned char [usertype] nr_resources
   sound/soc/intel/skylake/skl-topology.c:3268:35: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3272:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] nr_interfaces @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3272:36: sparse:     expected unsigned char [usertype] nr_interfaces
   sound/soc/intel/skylake/skl-topology.c:3272:36: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3250:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3250:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3250:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3250:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3250:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3250:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3306:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected int lib_count @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3306:32: sparse:     expected int lib_count
   sound/soc/intel/skylake/skl-topology.c:3306:32: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3310:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] nr_modules @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3310:33: sparse:     expected unsigned char [usertype] nr_modules
   sound/soc/intel/skylake/skl-topology.c:3310:33: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3325:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected int static mod_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3325:25: sparse:     expected int static mod_idx
   sound/soc/intel/skylake/skl-topology.c:3325:25: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3334:29: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3340:24: sparse: sparse: cast from restricted __le32
   sound/soc/intel/skylake/skl-topology.c:3340:24: sparse: sparse: cast from restricted __le32
   sound/soc/intel/skylake/skl-topology.c:3340:24: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3340:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long [usertype] factor1 @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3340:24: sparse:     expected unsigned long [usertype] factor1
   sound/soc/intel/skylake/skl-topology.c:3340:24: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3340:24: sparse: sparse: cast from restricted __le32
   sound/soc/intel/skylake/skl-topology.c:3340:24: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3340:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long [usertype] factor1 @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3340:24: sparse:     expected unsigned long [usertype] factor1
   sound/soc/intel/skylake/skl-topology.c:3340:24: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3347:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] count @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3347:52: sparse:     expected unsigned int [usertype] count
   sound/soc/intel/skylake/skl-topology.c:3347:52: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3351:29: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3357:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected int static astate_cfg_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3357:32: sparse:     expected int static astate_cfg_idx
   sound/soc/intel/skylake/skl-topology.c:3357:32: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3361:51: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] kcps @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3361:51: sparse:     expected unsigned int [usertype] kcps
   sound/soc/intel/skylake/skl-topology.c:3361:51: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3365:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] clk_src @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3365:54: sparse:     expected unsigned int [usertype] clk_src
   sound/soc/intel/skylake/skl-topology.c:3365:54: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3380:31: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3381:36: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3388:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] id @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3388:25: sparse:     expected unsigned char [usertype] id
   sound/soc/intel/skylake/skl-topology.c:3388:25: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3389:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected int static res_val_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3389:29: sparse:     expected int static res_val_idx
   sound/soc/intel/skylake/skl-topology.c:3389:29: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3396:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] fmt_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3396:30: sparse:     expected unsigned char [usertype] fmt_idx
   sound/soc/intel/skylake/skl-topology.c:3396:30: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3397:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected int static intf_val_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3397:30: sparse:     expected int static intf_val_idx
   sound/soc/intel/skylake/skl-topology.c:3397:30: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3418:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] nr_input_pins @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3418:36: sparse:     expected unsigned char [usertype] nr_input_pins
   sound/soc/intel/skylake/skl-topology.c:3418:36: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3425:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] nr_output_pins @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3425:37: sparse:     expected unsigned char [usertype] nr_output_pins
   sound/soc/intel/skylake/skl-topology.c:3425:37: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3304:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3304:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3304:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3304:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3304:25: sparse: sparse: restricted __le32 degrades to integer

vim +3088 sound/soc/intel/skylake/skl-topology.c

7a1b749b34e823 Dharageswari R 2017-05-31  3081  
7a1b749b34e823 Dharageswari R 2017-05-31  3082  	void *data;
7a1b749b34e823 Dharageswari R 2017-05-31  3083  
7a1b749b34e823 Dharageswari R 2017-05-31  3084  	if (ec->priv.size) {
7a1b749b34e823 Dharageswari R 2017-05-31  3085  		data = devm_kzalloc(dev, sizeof(ec->priv.size), GFP_KERNEL);
7a1b749b34e823 Dharageswari R 2017-05-31  3086  		if (!data)
7a1b749b34e823 Dharageswari R 2017-05-31  3087  			return -ENOMEM;
7a1b749b34e823 Dharageswari R 2017-05-31 @3088  		memcpy(data, ec->priv.data, ec->priv.size);
7a1b749b34e823 Dharageswari R 2017-05-31  3089  		se->dobj.private = data;
7a1b749b34e823 Dharageswari R 2017-05-31  3090  	}
7a1b749b34e823 Dharageswari R 2017-05-31  3091  
7a1b749b34e823 Dharageswari R 2017-05-31  3092  	return 0;
7a1b749b34e823 Dharageswari R 2017-05-31  3093  

:::::: The code at line 3088 was first introduced by commit
:::::: 7a1b749b34e8238acae8a039a8f6822f4f4e2061 ASoC: Intel: Skylake: Add enum control for mic selection

:::::: TO: Dharageswari R <dharageswari.r@intel.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
