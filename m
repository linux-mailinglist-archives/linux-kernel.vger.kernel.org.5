Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230EF7E7FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjKJR6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjKJRzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE23884D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 23:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699602884; x=1731138884;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NBHe1bdAAD6cGiigLy/WKj/D4p8cuiL5NFcXUyfdkBs=;
  b=B328iQWd7VEfrmLh8EJf+C4PzxEPPKCmH4Gfy7SS3aO1ze+m9TAmwEsp
   iveELwDHqKoTTAiq3urNimwWiqppwhr/QynhI1EojBhtHFEz6QH1Au4Pq
   Adzaj+DPhwQlGAv39eRh7OEvqYmXZ7SLj7gtmdTFl7WYS3JlC4N+lj2Tw
   3UbAUSKs5z/mc/b2oiTdQnEabINelUZqrtRFp2bF1j9gkICzR+1TprpzW
   OD3wQk1NE5m3bXBJcmuyLx1Uz+srNz9LIq2VQSpFLMgsdQRZYytiCQSEC
   j0ZYzYP+wJmdjFj0Hdb1hz7My9Lmowy6RYTjG/jGTytoJJmekJeWLBisS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="387311375"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="387311375"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 23:54:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="11412202"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Nov 2023 23:54:41 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1MLe-0009UA-39;
        Fri, 10 Nov 2023 07:54:38 +0000
Date:   Fri, 10 Nov 2023 15:54:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: sound/soc/fsl/mpc5200_dma.c:112: warning: Function parameter or
 member 'substream' not described in 'psc_dma_trigger'
Message-ID: <202311101516.DEmRpJQC-lkp@intel.com>
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
head:   89cdf9d556016a54ff6ddd62324aa5ec790c05cc
commit: e8a3118e1f5cbe0c26704419390bf074689b349f objtool: make it visible in make V=1 output
date:   7 years ago
config: powerpc-randconfig-r026-20220616 (https://download.01.org/0day-ci/archive/20231110/202311101516.DEmRpJQC-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311101516.DEmRpJQC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311101516.DEmRpJQC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/powerpc/include/asm/uaccess.h:307:9: note: in expansion of macro 'if'
     307 |         if (likely(access_ok(VERIFY_READ, from, n))) {
         |         ^~
   include/linux/compiler.h:147:26: note: in expansion of macro '__branch_check__'
     147 | #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:307:13: note: in expansion of macro 'likely'
     307 |         if (likely(access_ok(VERIFY_READ, from, n))) {
         |             ^~~~~~
   include/linux/compiler.h:166:25: note: previous declaration here
     166 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:158:23: note: in expansion of macro '__trace_if'
     158 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:307:9: note: in expansion of macro 'if'
     307 |         if (likely(access_ok(VERIFY_READ, from, n))) {
         |         ^~
   arch/powerpc/include/asm/uaccess.h: In function 'clear_user':
   include/linux/compiler.h:127:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
     127 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:171:30: note: in definition of macro '__trace_if'
     171 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   arch/powerpc/include/asm/uaccess.h:416:9: note: in expansion of macro 'if'
     416 |         if (likely(access_ok(VERIFY_WRITE, addr, size)))
         |         ^~
   include/linux/compiler.h:147:26: note: in expansion of macro '__branch_check__'
     147 | #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:416:13: note: in expansion of macro 'likely'
     416 |         if (likely(access_ok(VERIFY_WRITE, addr, size)))
         |             ^~~~~~
   include/linux/compiler.h:166:25: note: previous declaration here
     166 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:158:23: note: in expansion of macro '__trace_if'
     158 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:416:9: note: in expansion of macro 'if'
     416 |         if (likely(access_ok(VERIFY_WRITE, addr, size)))
         |         ^~
   include/sound/compress_driver.h: In function 'snd_compr_drain_notify':
   include/linux/compiler.h:127:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
     127 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:171:30: note: in definition of macro '__trace_if'
     171 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/sound/compress_driver.h:186:9: note: in expansion of macro 'if'
     186 |         if (snd_BUG_ON(!stream))
         |         ^~
   include/linux/compiler.h:150:26: note: in expansion of macro '__branch_check__'
     150 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/sound/core.h:371:9: note: in expansion of macro 'unlikely'
     371 |         unlikely(__ret_warn_on); \
         |         ^~~~~~~~
   include/sound/compress_driver.h:186:13: note: in expansion of macro 'snd_BUG_ON'
     186 |         if (snd_BUG_ON(!stream))
         |             ^~~~~~~~~~
   include/linux/compiler.h:166:25: note: previous declaration here
     166 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:158:23: note: in expansion of macro '__trace_if'
     158 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/sound/compress_driver.h:186:9: note: in expansion of macro 'if'
     186 |         if (snd_BUG_ON(!stream))
         |         ^~
   include/linux/cred.h: In function '__validate_creds':
   include/linux/compiler.h:127:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
     127 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:171:30: note: in definition of macro '__trace_if'
     171 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/linux/cred.h:181:9: note: in expansion of macro 'if'
     181 |         if (unlikely(creds_are_invalid(cred)))
         |         ^~
   include/linux/compiler.h:150:26: note: in expansion of macro '__branch_check__'
     150 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/cred.h:181:13: note: in expansion of macro 'unlikely'
     181 |         if (unlikely(creds_are_invalid(cred)))
         |             ^~~~~~~~
   include/linux/compiler.h:166:25: note: previous declaration here
     166 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:158:23: note: in expansion of macro '__trace_if'
     158 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/linux/cred.h:181:9: note: in expansion of macro 'if'
     181 |         if (unlikely(creds_are_invalid(cred)))
         |         ^~
   sound/soc/fsl/mpc5200_dma.c: In function 'psc_dma_new':
   sound/soc/fsl/mpc5200_dma.c:305:25: warning: unused variable 'psc_dma' [-Wunused-variable]
     305 |         struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(rtd->cpu_dai);
         |                         ^~~~~~~
>> sound/soc/fsl/mpc5200_dma.c:112: warning: Function parameter or member 'substream' not described in 'psc_dma_trigger'
>> sound/soc/fsl/mpc5200_dma.c:112: warning: Function parameter or member 'cmd' not described in 'psc_dma_trigger'
--
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:171:30: note: in definition of macro '__trace_if'
     171 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/linux/freezer.h:36:9: note: in expansion of macro 'if'
      36 |         if (likely(!atomic_read(&system_freezing_cnt)))
         |         ^~
   include/linux/compiler.h:147:26: note: in expansion of macro '__branch_check__'
     147 | #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/freezer.h:36:13: note: in expansion of macro 'likely'
      36 |         if (likely(!atomic_read(&system_freezing_cnt)))
         |             ^~~~~~
   include/linux/compiler.h:166:25: note: previous declaration here
     166 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:158:23: note: in expansion of macro '__trace_if'
     158 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/linux/freezer.h:36:9: note: in expansion of macro 'if'
      36 |         if (likely(!atomic_read(&system_freezing_cnt)))
         |         ^~
   include/linux/freezer.h: In function 'try_to_freeze_unsafe':
   include/linux/compiler.h:127:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
     127 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:171:30: note: in definition of macro '__trace_if'
     171 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/linux/freezer.h:57:9: note: in expansion of macro 'if'
      57 |         if (likely(!freezing(current)))
         |         ^~
   include/linux/compiler.h:147:26: note: in expansion of macro '__branch_check__'
     147 | #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/freezer.h:57:13: note: in expansion of macro 'likely'
      57 |         if (likely(!freezing(current)))
         |             ^~~~~~
   include/linux/compiler.h:166:25: note: previous declaration here
     166 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:158:23: note: in expansion of macro '__trace_if'
     158 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/linux/freezer.h:57:9: note: in expansion of macro 'if'
      57 |         if (likely(!freezing(current)))
         |         ^~
   In file included from sound/soc/fsl/mpc5200_psc_ac97.c:12:
   sound/soc/fsl/mpc5200_psc_ac97.c: At top level:
   include/linux/module.h:137:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'psc_ac97_driver_exit': 'cold' [-Wmissing-attributes]
     137 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   include/linux/device.h:1481:1: note: in expansion of macro 'module_exit'
    1481 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/platform_device.h:228:9: note: in expansion of macro 'module_driver'
     228 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   sound/soc/fsl/mpc5200_psc_ac97.c:345:1: note: in expansion of macro 'module_platform_driver'
     345 | module_platform_driver(psc_ac97_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/node.h:17,
                    from include/linux/cpu.h:16,
                    from include/linux/of_device.h:4,
                    from sound/soc/fsl/mpc5200_psc_ac97.c:13:
   sound/soc/fsl/mpc5200_psc_ac97.c:345:24: note: 'cleanup_module' target declared here
     345 | module_platform_driver(psc_ac97_driver);
         |                        ^~~~~~~~~~~~~~~
   include/linux/device.h:1477:20: note: in definition of macro 'module_driver'
    1477 | static void __exit __driver##_exit(void) \
         |                    ^~~~~~~~
   sound/soc/fsl/mpc5200_psc_ac97.c:345:1: note: in expansion of macro 'module_platform_driver'
     345 | module_platform_driver(psc_ac97_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from sound/soc/fsl/mpc5200_psc_ac97.c:12:
   include/linux/module.h:131:13: warning: 'init_module' specifies less restrictive attribute than its target 'psc_ac97_driver_init': 'cold' [-Wmissing-attributes]
     131 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   include/linux/device.h:1476:1: note: in expansion of macro 'module_init'
    1476 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/platform_device.h:228:9: note: in expansion of macro 'module_driver'
     228 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   sound/soc/fsl/mpc5200_psc_ac97.c:345:1: note: in expansion of macro 'module_platform_driver'
     345 | module_platform_driver(psc_ac97_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/node.h:17,
                    from include/linux/cpu.h:16,
                    from include/linux/of_device.h:4,
                    from sound/soc/fsl/mpc5200_psc_ac97.c:13:
   sound/soc/fsl/mpc5200_psc_ac97.c:345:24: note: 'init_module' target declared here
     345 | module_platform_driver(psc_ac97_driver);
         |                        ^~~~~~~~~~~~~~~
   include/linux/device.h:1472:19: note: in definition of macro 'module_driver'
    1472 | static int __init __driver##_init(void) \
         |                   ^~~~~~~~
   sound/soc/fsl/mpc5200_psc_ac97.c:345:1: note: in expansion of macro 'module_platform_driver'
     345 | module_platform_driver(psc_ac97_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/fsl/mpc5200_psc_ac97.c:228: warning: cannot understand function prototype: 'const struct snd_soc_dai_ops psc_ac97_analog_ops = '


vim +112 sound/soc/fsl/mpc5200_dma.c

89dd0842527377 Jon Smirl        2009-05-23  104  
89dd0842527377 Jon Smirl        2009-05-23  105  /**
cebe77674cab51 Jon Smirl        2009-05-23  106   * psc_dma_trigger: start and stop the DMA transfer.
89dd0842527377 Jon Smirl        2009-05-23  107   *
89dd0842527377 Jon Smirl        2009-05-23  108   * This function is called by ALSA to start, stop, pause, and resume the DMA
89dd0842527377 Jon Smirl        2009-05-23  109   * transfer of data.
89dd0842527377 Jon Smirl        2009-05-23  110   */
dbcc3475623459 Jon Smirl        2009-05-26  111  static int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd)
89dd0842527377 Jon Smirl        2009-05-23 @112  {
89dd0842527377 Jon Smirl        2009-05-23  113  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
f0fba2ad1b6b53 Liam Girdwood    2010-03-17  114  	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(rtd->cpu_dai);
89dd0842527377 Jon Smirl        2009-05-23  115  	struct snd_pcm_runtime *runtime = substream->runtime;
1d8222e8df07ce Grant Likely     2009-11-07  116  	struct psc_dma_stream *s = to_psc_dma_stream(substream, psc_dma);
cebe77674cab51 Jon Smirl        2009-05-23  117  	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
89dd0842527377 Jon Smirl        2009-05-23  118  	u16 imr;
89dd0842527377 Jon Smirl        2009-05-23  119  	unsigned long flags;
dbcc3475623459 Jon Smirl        2009-05-26  120  	int i;
89dd0842527377 Jon Smirl        2009-05-23  121  
89dd0842527377 Jon Smirl        2009-05-23  122  	switch (cmd) {
89dd0842527377 Jon Smirl        2009-05-23  123  	case SNDRV_PCM_TRIGGER_START:
c4878274750ae0 Grant Likely     2009-11-07  124  		dev_dbg(psc_dma->dev, "START: stream=%i fbits=%u ps=%u #p=%u\n",
c4878274750ae0 Grant Likely     2009-11-07  125  			substream->pstr->stream, runtime->frame_bits,
c4878274750ae0 Grant Likely     2009-11-07  126  			(int)runtime->period_size, runtime->periods);
89dd0842527377 Jon Smirl        2009-05-23  127  		s->period_bytes = frames_to_bytes(runtime,
89dd0842527377 Jon Smirl        2009-05-23  128  						  runtime->period_size);
8f159d720b89f2 Grant Likely     2009-11-07  129  		s->period_next = 0;
8f159d720b89f2 Grant Likely     2009-11-07  130  		s->period_current = 0;
89dd0842527377 Jon Smirl        2009-05-23  131  		s->active = 1;
c4878274750ae0 Grant Likely     2009-11-07  132  		s->period_count = 0;
dbcc3475623459 Jon Smirl        2009-05-26  133  		s->runtime = runtime;
dbcc3475623459 Jon Smirl        2009-05-26  134  
dbcc3475623459 Jon Smirl        2009-05-26  135  		/* Fill up the bestcomm bd queue and enable DMA.
dbcc3475623459 Jon Smirl        2009-05-26  136  		 * This will begin filling the PSC's fifo.
dbcc3475623459 Jon Smirl        2009-05-26  137  		 */
dbcc3475623459 Jon Smirl        2009-05-26  138  		spin_lock_irqsave(&psc_dma->lock, flags);
dbcc3475623459 Jon Smirl        2009-05-26  139  
d56b6eb6df7f6f Grant Likely     2009-11-07  140  		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
dbcc3475623459 Jon Smirl        2009-05-26  141  			bcom_gen_bd_rx_reset(s->bcom_task);
d56b6eb6df7f6f Grant Likely     2009-11-07  142  		else
d56b6eb6df7f6f Grant Likely     2009-11-07  143  			bcom_gen_bd_tx_reset(s->bcom_task);
d56b6eb6df7f6f Grant Likely     2009-11-07  144  
dbcc3475623459 Jon Smirl        2009-05-26  145  		for (i = 0; i < runtime->periods; i++)
dbcc3475623459 Jon Smirl        2009-05-26  146  			if (!bcom_queue_full(s->bcom_task))
dbcc3475623459 Jon Smirl        2009-05-26  147  				psc_dma_bcom_enqueue_next_buffer(s);
89dd0842527377 Jon Smirl        2009-05-23  148  
89dd0842527377 Jon Smirl        2009-05-23  149  		bcom_enable(s->bcom_task);
cebe77674cab51 Jon Smirl        2009-05-23  150  		spin_unlock_irqrestore(&psc_dma->lock, flags);
89dd0842527377 Jon Smirl        2009-05-23  151  
dbcc3475623459 Jon Smirl        2009-05-26  152  		out_8(&regs->command, MPC52xx_PSC_RST_ERR_STAT);
dbcc3475623459 Jon Smirl        2009-05-26  153  
89dd0842527377 Jon Smirl        2009-05-23  154  		break;
89dd0842527377 Jon Smirl        2009-05-23  155  
89dd0842527377 Jon Smirl        2009-05-23  156  	case SNDRV_PCM_TRIGGER_STOP:
c4878274750ae0 Grant Likely     2009-11-07  157  		dev_dbg(psc_dma->dev, "STOP: stream=%i periods_count=%i\n",
c4878274750ae0 Grant Likely     2009-11-07  158  			substream->pstr->stream, s->period_count);
89dd0842527377 Jon Smirl        2009-05-23  159  		s->active = 0;
89dd0842527377 Jon Smirl        2009-05-23  160  
dbcc3475623459 Jon Smirl        2009-05-26  161  		spin_lock_irqsave(&psc_dma->lock, flags);
89dd0842527377 Jon Smirl        2009-05-23  162  		bcom_disable(s->bcom_task);
dbcc3475623459 Jon Smirl        2009-05-26  163  		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
dbcc3475623459 Jon Smirl        2009-05-26  164  			bcom_gen_bd_rx_reset(s->bcom_task);
dbcc3475623459 Jon Smirl        2009-05-26  165  		else
dbcc3475623459 Jon Smirl        2009-05-26  166  			bcom_gen_bd_tx_reset(s->bcom_task);
dbcc3475623459 Jon Smirl        2009-05-26  167  		spin_unlock_irqrestore(&psc_dma->lock, flags);
89dd0842527377 Jon Smirl        2009-05-23  168  
89dd0842527377 Jon Smirl        2009-05-23  169  		break;
89dd0842527377 Jon Smirl        2009-05-23  170  
89dd0842527377 Jon Smirl        2009-05-23  171  	default:
c4878274750ae0 Grant Likely     2009-11-07  172  		dev_dbg(psc_dma->dev, "unhandled trigger: stream=%i cmd=%i\n",
c4878274750ae0 Grant Likely     2009-11-07  173  			substream->pstr->stream, cmd);
89dd0842527377 Jon Smirl        2009-05-23  174  		return -EINVAL;
89dd0842527377 Jon Smirl        2009-05-23  175  	}
89dd0842527377 Jon Smirl        2009-05-23  176  
89dd0842527377 Jon Smirl        2009-05-23  177  	/* Update interrupt enable settings */
89dd0842527377 Jon Smirl        2009-05-23  178  	imr = 0;
cebe77674cab51 Jon Smirl        2009-05-23  179  	if (psc_dma->playback.active)
89dd0842527377 Jon Smirl        2009-05-23  180  		imr |= MPC52xx_PSC_IMR_TXEMP;
cebe77674cab51 Jon Smirl        2009-05-23  181  	if (psc_dma->capture.active)
89dd0842527377 Jon Smirl        2009-05-23  182  		imr |= MPC52xx_PSC_IMR_ORERR;
dbcc3475623459 Jon Smirl        2009-05-26  183  	out_be16(&regs->isr_imr.imr, psc_dma->imr | imr);
89dd0842527377 Jon Smirl        2009-05-23  184  
89dd0842527377 Jon Smirl        2009-05-23  185  	return 0;
89dd0842527377 Jon Smirl        2009-05-23  186  }
89dd0842527377 Jon Smirl        2009-05-23  187  
89dd0842527377 Jon Smirl        2009-05-23  188  
89dd0842527377 Jon Smirl        2009-05-23  189  /* ---------------------------------------------------------------------
89dd0842527377 Jon Smirl        2009-05-23  190   * The PSC DMA 'ASoC platform' driver
89dd0842527377 Jon Smirl        2009-05-23  191   *
89dd0842527377 Jon Smirl        2009-05-23  192   * Can be referenced by an 'ASoC machine' driver
89dd0842527377 Jon Smirl        2009-05-23  193   * This driver only deals with the audio bus; it doesn't have any
89dd0842527377 Jon Smirl        2009-05-23  194   * interaction with the attached codec
89dd0842527377 Jon Smirl        2009-05-23  195   */
89dd0842527377 Jon Smirl        2009-05-23  196  
dbcc3475623459 Jon Smirl        2009-05-26  197  static const struct snd_pcm_hardware psc_dma_hardware = {
89dd0842527377 Jon Smirl        2009-05-23  198  	.info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
89dd0842527377 Jon Smirl        2009-05-23  199  		SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
89dd0842527377 Jon Smirl        2009-05-23  200  		SNDRV_PCM_INFO_BATCH,
89dd0842527377 Jon Smirl        2009-05-23  201  	.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE |
89dd0842527377 Jon Smirl        2009-05-23  202  		SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE,
89dd0842527377 Jon Smirl        2009-05-23  203  	.period_bytes_max	= 1024 * 1024,
89dd0842527377 Jon Smirl        2009-05-23  204  	.period_bytes_min	= 32,
89dd0842527377 Jon Smirl        2009-05-23  205  	.periods_min		= 2,
89dd0842527377 Jon Smirl        2009-05-23  206  	.periods_max		= 256,
89dd0842527377 Jon Smirl        2009-05-23  207  	.buffer_bytes_max	= 2 * 1024 * 1024,
dbcc3475623459 Jon Smirl        2009-05-26  208  	.fifo_size		= 512,
89dd0842527377 Jon Smirl        2009-05-23  209  };
89dd0842527377 Jon Smirl        2009-05-23  210  
dbcc3475623459 Jon Smirl        2009-05-26  211  static int psc_dma_open(struct snd_pcm_substream *substream)
89dd0842527377 Jon Smirl        2009-05-23  212  {
dbcc3475623459 Jon Smirl        2009-05-26  213  	struct snd_pcm_runtime *runtime = substream->runtime;
89dd0842527377 Jon Smirl        2009-05-23  214  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
f0fba2ad1b6b53 Liam Girdwood    2010-03-17  215  	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(rtd->cpu_dai);
cebe77674cab51 Jon Smirl        2009-05-23  216  	struct psc_dma_stream *s;
dbcc3475623459 Jon Smirl        2009-05-26  217  	int rc;
89dd0842527377 Jon Smirl        2009-05-23  218  
dbcc3475623459 Jon Smirl        2009-05-26  219  	dev_dbg(psc_dma->dev, "psc_dma_open(substream=%p)\n", substream);
89dd0842527377 Jon Smirl        2009-05-23  220  
89dd0842527377 Jon Smirl        2009-05-23  221  	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
cebe77674cab51 Jon Smirl        2009-05-23  222  		s = &psc_dma->capture;
89dd0842527377 Jon Smirl        2009-05-23  223  	else
cebe77674cab51 Jon Smirl        2009-05-23  224  		s = &psc_dma->playback;
89dd0842527377 Jon Smirl        2009-05-23  225  
dbcc3475623459 Jon Smirl        2009-05-26  226  	snd_soc_set_runtime_hwparams(substream, &psc_dma_hardware);
dbcc3475623459 Jon Smirl        2009-05-26  227  
dbcc3475623459 Jon Smirl        2009-05-26  228  	rc = snd_pcm_hw_constraint_integer(runtime,
dbcc3475623459 Jon Smirl        2009-05-26  229  		SNDRV_PCM_HW_PARAM_PERIODS);
dbcc3475623459 Jon Smirl        2009-05-26  230  	if (rc < 0) {
dbcc3475623459 Jon Smirl        2009-05-26  231  		dev_err(substream->pcm->card->dev, "invalid buffer size\n");
dbcc3475623459 Jon Smirl        2009-05-26  232  		return rc;
dbcc3475623459 Jon Smirl        2009-05-26  233  	}
89dd0842527377 Jon Smirl        2009-05-23  234  
89dd0842527377 Jon Smirl        2009-05-23  235  	s->stream = substream;
89dd0842527377 Jon Smirl        2009-05-23  236  	return 0;
89dd0842527377 Jon Smirl        2009-05-23  237  }
89dd0842527377 Jon Smirl        2009-05-23  238  
dbcc3475623459 Jon Smirl        2009-05-26  239  static int psc_dma_close(struct snd_pcm_substream *substream)
89dd0842527377 Jon Smirl        2009-05-23  240  {
89dd0842527377 Jon Smirl        2009-05-23  241  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
f0fba2ad1b6b53 Liam Girdwood    2010-03-17  242  	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(rtd->cpu_dai);
cebe77674cab51 Jon Smirl        2009-05-23  243  	struct psc_dma_stream *s;
89dd0842527377 Jon Smirl        2009-05-23  244  
dbcc3475623459 Jon Smirl        2009-05-26  245  	dev_dbg(psc_dma->dev, "psc_dma_close(substream=%p)\n", substream);
89dd0842527377 Jon Smirl        2009-05-23  246  
89dd0842527377 Jon Smirl        2009-05-23  247  	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
cebe77674cab51 Jon Smirl        2009-05-23  248  		s = &psc_dma->capture;
89dd0842527377 Jon Smirl        2009-05-23  249  	else
cebe77674cab51 Jon Smirl        2009-05-23  250  		s = &psc_dma->playback;
89dd0842527377 Jon Smirl        2009-05-23  251  
dbcc3475623459 Jon Smirl        2009-05-26  252  	if (!psc_dma->playback.active &&
dbcc3475623459 Jon Smirl        2009-05-26  253  	    !psc_dma->capture.active) {
dbcc3475623459 Jon Smirl        2009-05-26  254  
dbcc3475623459 Jon Smirl        2009-05-26  255  		/* Disable all interrupts and reset the PSC */
dbcc3475623459 Jon Smirl        2009-05-26  256  		out_be16(&psc_dma->psc_regs->isr_imr.imr, psc_dma->imr);
dbcc3475623459 Jon Smirl        2009-05-26  257  		out_8(&psc_dma->psc_regs->command, 4 << 4); /* reset error */
dbcc3475623459 Jon Smirl        2009-05-26  258  	}
89dd0842527377 Jon Smirl        2009-05-23  259  	s->stream = NULL;
89dd0842527377 Jon Smirl        2009-05-23  260  	return 0;
89dd0842527377 Jon Smirl        2009-05-23  261  }
89dd0842527377 Jon Smirl        2009-05-23  262  
89dd0842527377 Jon Smirl        2009-05-23  263  static snd_pcm_uframes_t
dbcc3475623459 Jon Smirl        2009-05-26  264  psc_dma_pointer(struct snd_pcm_substream *substream)
89dd0842527377 Jon Smirl        2009-05-23  265  {
89dd0842527377 Jon Smirl        2009-05-23  266  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
f0fba2ad1b6b53 Liam Girdwood    2010-03-17  267  	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(rtd->cpu_dai);
cebe77674cab51 Jon Smirl        2009-05-23  268  	struct psc_dma_stream *s;
89dd0842527377 Jon Smirl        2009-05-23  269  	dma_addr_t count;
89dd0842527377 Jon Smirl        2009-05-23  270  
89dd0842527377 Jon Smirl        2009-05-23  271  	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
cebe77674cab51 Jon Smirl        2009-05-23  272  		s = &psc_dma->capture;
89dd0842527377 Jon Smirl        2009-05-23  273  	else
cebe77674cab51 Jon Smirl        2009-05-23  274  		s = &psc_dma->playback;
89dd0842527377 Jon Smirl        2009-05-23  275  
8f159d720b89f2 Grant Likely     2009-11-07  276  	count = s->period_current * s->period_bytes;
89dd0842527377 Jon Smirl        2009-05-23  277  
89dd0842527377 Jon Smirl        2009-05-23  278  	return bytes_to_frames(substream->runtime, count);
89dd0842527377 Jon Smirl        2009-05-23  279  }
89dd0842527377 Jon Smirl        2009-05-23  280  
dbcc3475623459 Jon Smirl        2009-05-26  281  static int
dbcc3475623459 Jon Smirl        2009-05-26  282  psc_dma_hw_params(struct snd_pcm_substream *substream,
dbcc3475623459 Jon Smirl        2009-05-26  283  			 struct snd_pcm_hw_params *params)
dbcc3475623459 Jon Smirl        2009-05-26  284  {
dbcc3475623459 Jon Smirl        2009-05-26  285  	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
dbcc3475623459 Jon Smirl        2009-05-26  286  
dbcc3475623459 Jon Smirl        2009-05-26  287  	return 0;
dbcc3475623459 Jon Smirl        2009-05-26  288  }
dbcc3475623459 Jon Smirl        2009-05-26  289  
dbcc3475623459 Jon Smirl        2009-05-26  290  static struct snd_pcm_ops psc_dma_ops = {
dbcc3475623459 Jon Smirl        2009-05-26  291  	.open		= psc_dma_open,
dbcc3475623459 Jon Smirl        2009-05-26  292  	.close		= psc_dma_close,
dbcc3475623459 Jon Smirl        2009-05-26  293  	.hw_free	= psc_dma_hw_free,
89dd0842527377 Jon Smirl        2009-05-23  294  	.ioctl		= snd_pcm_lib_ioctl,
dbcc3475623459 Jon Smirl        2009-05-26  295  	.pointer	= psc_dma_pointer,
dbcc3475623459 Jon Smirl        2009-05-26  296  	.trigger	= psc_dma_trigger,
dbcc3475623459 Jon Smirl        2009-05-26  297  	.hw_params	= psc_dma_hw_params,
89dd0842527377 Jon Smirl        2009-05-23  298  };
89dd0842527377 Jon Smirl        2009-05-23  299  
552d1ef6b5a98d Liam Girdwood    2011-06-07  300  static int psc_dma_new(struct snd_soc_pcm_runtime *rtd)
89dd0842527377 Jon Smirl        2009-05-23  301  {
552d1ef6b5a98d Liam Girdwood    2011-06-07  302  	struct snd_card *card = rtd->card->snd_card;
552d1ef6b5a98d Liam Girdwood    2011-06-07  303  	struct snd_soc_dai *dai = rtd->cpu_dai;
552d1ef6b5a98d Liam Girdwood    2011-06-07  304  	struct snd_pcm *pcm = rtd->pcm;
f0fba2ad1b6b53 Liam Girdwood    2010-03-17 @305  	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(rtd->cpu_dai);
dbcc3475623459 Jon Smirl        2009-05-26  306  	size_t size = psc_dma_hardware.buffer_bytes_max;
c9bd5e690a439d Russell King     2013-06-27  307  	int rc;
89dd0842527377 Jon Smirl        2009-05-23  308  
f0fba2ad1b6b53 Liam Girdwood    2010-03-17  309  	dev_dbg(rtd->platform->dev, "psc_dma_new(card=%p, dai=%p, pcm=%p)\n",
89dd0842527377 Jon Smirl        2009-05-23  310  		card, dai, pcm);
89dd0842527377 Jon Smirl        2009-05-23  311  
c9bd5e690a439d Russell King     2013-06-27  312  	rc = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
c9bd5e690a439d Russell King     2013-06-27  313  	if (rc)
c9bd5e690a439d Russell King     2013-06-27  314  		return rc;
89dd0842527377 Jon Smirl        2009-05-23  315  
6296914ccefe6e Joachim Eastwood 2012-01-01  316  	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
dbcc3475623459 Jon Smirl        2009-05-26  317  		rc = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->card->dev,
6296914ccefe6e Joachim Eastwood 2012-01-01  318  				size, &pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream->dma_buffer);
89dd0842527377 Jon Smirl        2009-05-23  319  		if (rc)
89dd0842527377 Jon Smirl        2009-05-23  320  			goto playback_alloc_err;
89dd0842527377 Jon Smirl        2009-05-23  321  	}
89dd0842527377 Jon Smirl        2009-05-23  322  
6296914ccefe6e Joachim Eastwood 2012-01-01  323  	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
dbcc3475623459 Jon Smirl        2009-05-26  324  		rc = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->card->dev,
6296914ccefe6e Joachim Eastwood 2012-01-01  325  				size, &pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream->dma_buffer);
89dd0842527377 Jon Smirl        2009-05-23  326  		if (rc)
89dd0842527377 Jon Smirl        2009-05-23  327  			goto capture_alloc_err;
89dd0842527377 Jon Smirl        2009-05-23  328  	}
89dd0842527377 Jon Smirl        2009-05-23  329  
89dd0842527377 Jon Smirl        2009-05-23  330  	return 0;
89dd0842527377 Jon Smirl        2009-05-23  331  
89dd0842527377 Jon Smirl        2009-05-23  332   capture_alloc_err:
6296914ccefe6e Joachim Eastwood 2012-01-01  333  	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream)
6296914ccefe6e Joachim Eastwood 2012-01-01  334  		snd_dma_free_pages(&pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream->dma_buffer);
dbcc3475623459 Jon Smirl        2009-05-26  335  
89dd0842527377 Jon Smirl        2009-05-23  336   playback_alloc_err:
89dd0842527377 Jon Smirl        2009-05-23  337  	dev_err(card->dev, "Cannot allocate buffer(s)\n");
dbcc3475623459 Jon Smirl        2009-05-26  338  
89dd0842527377 Jon Smirl        2009-05-23  339  	return -ENOMEM;
89dd0842527377 Jon Smirl        2009-05-23  340  }
89dd0842527377 Jon Smirl        2009-05-23  341  

:::::: The code at line 112 was first introduced by commit
:::::: 89dd08425273773fd33fc85d48d152c5679b2fb4 ASoC: Basic split of mpc5200 DMA code out of mpc5200_psc_i2s

:::::: TO: Jon Smirl <jonsmirl@gmail.com>
:::::: CC: Mark Brown <broonie@opensource.wolfsonmicro.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
