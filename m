Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C01A7D2175
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 08:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjJVGNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 02:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVGNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 02:13:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8481C5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 23:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697955226; x=1729491226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w0YnrUlNlFoxL2PukGvP3nXb19IVe2UhjY9JFtaLt80=;
  b=PaBRQfVl81nTwGVjdB6wnK5nAEf29nSp8CJSGdwPKrNbVfoQmZkWfDyL
   Hsw4tkACe5GT8IaWxzEAlFLwfFPYSHAImtpORsDb7z7NxYz5c40CNvL0v
   WKxbxpd9ERbSmYICSyBJkD46zsSMMFPE/nTYj6d6YMLV3foe7s8MORNsT
   olcABXepKvC+1WazjdU7nsW5MMhmwbqrTRllCuPgdOZL7MlYIwoPivWk4
   ZkcofGjBIpFczj7k002ThAnWCO+R0tznwCE3kfKsOVpmvT7iJ51byCxK7
   iNrIpp9ez3hSkdzk8dYU8/GgBUl5+BrvefDIkw+3FbwjpsC/feTzvfyo6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="417814182"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="417814182"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 23:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="734344991"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="734344991"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2023 23:13:43 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1quRiX-0005e6-22;
        Sun, 22 Oct 2023 06:13:41 +0000
Date:   Sun, 22 Oct 2023 14:13:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     kenechukwu maduechesi <maduechesik@gmail.com>,
        shreeya.patel23498@gmail.com, outreachy@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Add parenthesis to macro arguments
Message-ID: <202310221433.99xPzVri-lkp@intel.com>
References: <20231020065439.GA3579@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020065439.GA3579@ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kenechukwu,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-linus]
[also build test ERROR on linus/master v6.6-rc6]
[cannot apply to staging/staging-testing staging/staging-next next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/kenechukwu-maduechesi/staging-rts5208-Add-parenthesis-to-macro-arguments/20231020-145549
base:   staging/staging-linus
patch link:    https://lore.kernel.org/r/20231020065439.GA3579%40ubuntu
patch subject: [PATCH] staging: rts5208: Add parenthesis to macro arguments
config: arc-randconfig-001-20231022 (https://download.01.org/0day-ci/archive/20231022/202310221433.99xPzVri-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231022/202310221433.99xPzVri-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310221433.99xPzVri-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/staging/rts5208/rtsx_scsi.c:17:
>> drivers/staging/rts5208/rtsx.h:42:27: error: expected parameter name, found "("
      42 | #define rtsx_writel(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:44:26: error: expected parameter name, found "("
      44 | #define rtsx_readl(chip, (reg) \
         |                          ^
   drivers/staging/rts5208/rtsx.h:46:27: error: expected parameter name, found "("
      46 | #define rtsx_writew(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:48:26: error: expected parameter name, found "("
      48 | #define rtsx_readw(chip, (reg)) \
         |                          ^
   drivers/staging/rts5208/rtsx.h:50:27: error: expected parameter name, found "("
      50 | #define rtsx_writeb(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:52:26: error: expected parameter name, found "("
      52 | #define rtsx_readb(chip, (reg)) \
         |                          ^
   drivers/staging/rts5208/rtsx_scsi.c: In function 'read_host_reg':
>> drivers/staging/rts5208/rtsx_scsi.c:1350:15: error: implicit declaration of function 'rtsx_readl'; did you mean 'rtsx_dev'? [-Werror=implicit-function-declaration]
    1350 |         val = rtsx_readl(chip, addr);
         |               ^~~~~~~~~~
         |               rtsx_dev
   drivers/staging/rts5208/rtsx_scsi.c: In function 'write_host_reg':
>> drivers/staging/rts5208/rtsx_scsi.c:1388:9: error: implicit declaration of function 'rtsx_writel' [-Werror=implicit-function-declaration]
    1388 |         rtsx_writel(chip, addr, val);
         |         ^~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/staging/rts5208/spi.c:16:
>> drivers/staging/rts5208/rtsx.h:42:27: error: expected parameter name, found "("
      42 | #define rtsx_writel(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:44:26: error: expected parameter name, found "("
      44 | #define rtsx_readl(chip, (reg) \
         |                          ^
   drivers/staging/rts5208/rtsx.h:46:27: error: expected parameter name, found "("
      46 | #define rtsx_writew(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:48:26: error: expected parameter name, found "("
      48 | #define rtsx_readw(chip, (reg)) \
         |                          ^
   drivers/staging/rts5208/rtsx.h:50:27: error: expected parameter name, found "("
      50 | #define rtsx_writeb(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:52:26: error: expected parameter name, found "("
      52 | #define rtsx_readb(chip, (reg)) \
         |                          ^
--
   In file included from drivers/staging/rts5208/sd.c:16:
>> drivers/staging/rts5208/rtsx.h:42:27: error: expected parameter name, found "("
      42 | #define rtsx_writel(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:44:26: error: expected parameter name, found "("
      44 | #define rtsx_readl(chip, (reg) \
         |                          ^
   drivers/staging/rts5208/rtsx.h:46:27: error: expected parameter name, found "("
      46 | #define rtsx_writew(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:48:26: error: expected parameter name, found "("
      48 | #define rtsx_readw(chip, (reg)) \
         |                          ^
   drivers/staging/rts5208/rtsx.h:50:27: error: expected parameter name, found "("
      50 | #define rtsx_writeb(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:52:26: error: expected parameter name, found "("
      52 | #define rtsx_readb(chip, (reg)) \
         |                          ^
   drivers/staging/rts5208/sd.c: In function 'sd_check_wp_state':
>> drivers/staging/rts5208/sd.c:2278:15: error: implicit declaration of function 'rtsx_readl'; did you mean 'rtsx_dev'? [-Werror=implicit-function-declaration]
    2278 |         val = rtsx_readl(chip, RTSX_BIPR);
         |               ^~~~~~~~~~
         |               rtsx_dev
   cc1: some warnings being treated as errors
--
   In file included from drivers/staging/rts5208/rtsx_transport.c:16:
>> drivers/staging/rts5208/rtsx.h:42:27: error: expected parameter name, found "("
      42 | #define rtsx_writel(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:44:26: error: expected parameter name, found "("
      44 | #define rtsx_readl(chip, (reg) \
         |                          ^
   drivers/staging/rts5208/rtsx.h:46:27: error: expected parameter name, found "("
      46 | #define rtsx_writew(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:48:26: error: expected parameter name, found "("
      48 | #define rtsx_readw(chip, (reg)) \
         |                          ^
   drivers/staging/rts5208/rtsx.h:50:27: error: expected parameter name, found "("
      50 | #define rtsx_writeb(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:52:26: error: expected parameter name, found "("
      52 | #define rtsx_readb(chip, (reg)) \
         |                          ^
   drivers/staging/rts5208/rtsx_transport.c: In function 'rtsx_send_cmd_no_wait':
>> drivers/staging/rts5208/rtsx_transport.c:215:9: error: implicit declaration of function 'rtsx_writel'; did you mean 'vfs_write'? [-Werror=implicit-function-declaration]
     215 |         rtsx_writel(chip, RTSX_HCBAR, chip->host_cmds_addr);
         |         ^~~~~~~~~~~
         |         vfs_write
   cc1: some warnings being treated as errors
--
   In file included from drivers/staging/rts5208/rtsx_chip.c:18:
>> drivers/staging/rts5208/rtsx.h:42:27: error: expected parameter name, found "("
      42 | #define rtsx_writel(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:44:26: error: expected parameter name, found "("
      44 | #define rtsx_readl(chip, (reg) \
         |                          ^
   drivers/staging/rts5208/rtsx.h:46:27: error: expected parameter name, found "("
      46 | #define rtsx_writew(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:48:26: error: expected parameter name, found "("
      48 | #define rtsx_readw(chip, (reg)) \
         |                          ^
   drivers/staging/rts5208/rtsx.h:50:27: error: expected parameter name, found "("
      50 | #define rtsx_writeb(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:52:26: error: expected parameter name, found "("
      52 | #define rtsx_readb(chip, (reg)) \
         |                          ^
   drivers/staging/rts5208/rtsx_chip.c: In function 'rtsx_enable_card_int':
>> drivers/staging/rts5208/rtsx_chip.c:37:19: error: implicit declaration of function 'rtsx_readl'; did you mean 'rtsx_dev'? [-Werror=implicit-function-declaration]
      37 |         u32 reg = rtsx_readl(chip, RTSX_BIER);
         |                   ^~~~~~~~~~
         |                   rtsx_dev
>> drivers/staging/rts5208/rtsx_chip.c:51:9: error: implicit declaration of function 'rtsx_writel'; did you mean 'vfs_write'? [-Werror=implicit-function-declaration]
      51 |         rtsx_writel(chip, RTSX_BIER, reg);
         |         ^~~~~~~~~~~
         |         vfs_write
   cc1: some warnings being treated as errors
--
   In file included from drivers/staging/rts5208/rtsx_card.c:18:
>> drivers/staging/rts5208/rtsx.h:42:27: error: expected parameter name, found "("
      42 | #define rtsx_writel(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:44:26: error: expected parameter name, found "("
      44 | #define rtsx_readl(chip, (reg) \
         |                          ^
   drivers/staging/rts5208/rtsx.h:46:27: error: expected parameter name, found "("
      46 | #define rtsx_writew(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:48:26: error: expected parameter name, found "("
      48 | #define rtsx_readw(chip, (reg)) \
         |                          ^
   drivers/staging/rts5208/rtsx.h:50:27: error: expected parameter name, found "("
      50 | #define rtsx_writeb(chip, (reg), value) \
         |                           ^
   drivers/staging/rts5208/rtsx.h:52:26: error: expected parameter name, found "("
      52 | #define rtsx_readb(chip, (reg)) \
         |                          ^
   drivers/staging/rts5208/rtsx_card.c: In function 'rtsx_release_cards':
>> drivers/staging/rts5208/rtsx_card.c:328:25: error: implicit declaration of function 'rtsx_readl'; did you mean 'rtsx_dev'? [-Werror=implicit-function-declaration]
     328 |         chip->int_reg = rtsx_readl(chip, RTSX_BIPR);
         |                         ^~~~~~~~~~
         |                         rtsx_dev
   cc1: some warnings being treated as errors


vim +42 drivers/staging/rts5208/rtsx.h

    38	
    39	/*
    40	 * macros for easy use
    41	 */
  > 42	#define rtsx_writel(chip, (reg), value) \
    43		iowrite32(value, (chip)->rtsx->remap_addr + reg)
    44	#define rtsx_readl(chip, (reg) \
    45		ioread32((chip)->rtsx->remap_addr + reg)
    46	#define rtsx_writew(chip, (reg), value) \
    47		iowrite16(value, (chip)->rtsx->remap_addr + reg)
    48	#define rtsx_readw(chip, (reg)) \
    49		ioread16((chip)->rtsx->remap_addr + reg)
    50	#define rtsx_writeb(chip, (reg), value) \
    51		iowrite8(value, (chip)->rtsx->remap_addr + reg)
    52	#define rtsx_readb(chip, (reg)) \
    53		ioread8((chip)->rtsx->remap_addr + reg)
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
