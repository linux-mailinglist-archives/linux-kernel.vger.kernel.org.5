Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909497BB670
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjJFLal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjJFLaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:30:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4817FC5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696591837; x=1728127837;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H+IszHYM1esXLku7KOJni0bDrQ8n5hgTZEjMQefVctE=;
  b=Nyk9BniZczz8Aldt08N+C+lY8uXqvpcw4/g70AjL9GTZRb8SYxTJAtk8
   SrzmQop876WRNsOxNV34smto1Bf0YrgyrGyzxGCXPXZHpsibuB+bSBcCw
   5YxkG80g+oMNHN6AesPupbTl4Hescg8Zgtn7iIcNi4PBjvja82BS7p6z9
   kF8QOJdx7BA7Zk5YPruVF7twy3BpRuu3apHefNhlh8qfyB5mf/WwscdS4
   gWgulS8s4yiOBlCw9992n9x530WlSiOjOxSfb0uAZ5HcJg7Izz8F30n4w
   Enp0QGYVyA8UXwF+SdjdtkWurYI3AZF/w9KI77ctMSjC9+sjAAHaZd65K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2336685"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="2336685"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 04:30:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875911093"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="875911093"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 06 Oct 2023 04:30:34 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoj2N-000MYI-2m;
        Fri, 06 Oct 2023 11:30:31 +0000
Date:   Fri, 6 Oct 2023 19:29:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/fsl/mpc5200_dma.c:116: warning: Function parameter or
 member 'component' not described in 'psc_dma_trigger'
Message-ID: <202310061914.jJuekdHs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b78b18fb8ee19f7a05f20c3abc865b3bfe182884
commit: 6d1048bc115259bb2664b8ef363351428a4aef30 ASoC: fsl: mpc5200_dma: remove snd_pcm_ops
date:   4 years ago
config: powerpc-randconfig-r005-20210929 (https://download.01.org/0day-ci/archive/20231006/202310061914.jJuekdHs-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310061914.jJuekdHs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310061914.jJuekdHs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/fsl/mpc5200_dma.c:116: warning: Function parameter or member 'component' not described in 'psc_dma_trigger'
   sound/soc/fsl/mpc5200_dma.c:116: warning: Function parameter or member 'substream' not described in 'psc_dma_trigger'
   sound/soc/fsl/mpc5200_dma.c:116: warning: Function parameter or member 'cmd' not described in 'psc_dma_trigger'


vim +116 sound/soc/fsl/mpc5200_dma.c

89dd0842527377 Jon Smirl         2009-05-23  107  
89dd0842527377 Jon Smirl         2009-05-23  108  /**
cebe77674cab51 Jon Smirl         2009-05-23  109   * psc_dma_trigger: start and stop the DMA transfer.
89dd0842527377 Jon Smirl         2009-05-23  110   *
89dd0842527377 Jon Smirl         2009-05-23  111   * This function is called by ALSA to start, stop, pause, and resume the DMA
89dd0842527377 Jon Smirl         2009-05-23  112   * transfer of data.
89dd0842527377 Jon Smirl         2009-05-23  113   */
6d1048bc115259 Kuninori Morimoto 2019-10-02  114  static int psc_dma_trigger(struct snd_soc_component *component,
6d1048bc115259 Kuninori Morimoto 2019-10-02  115  			   struct snd_pcm_substream *substream, int cmd)
89dd0842527377 Jon Smirl         2009-05-23 @116  {
89dd0842527377 Jon Smirl         2009-05-23  117  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  118  	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(rtd->cpu_dai);
89dd0842527377 Jon Smirl         2009-05-23  119  	struct snd_pcm_runtime *runtime = substream->runtime;
1d8222e8df07ce Grant Likely      2009-11-07  120  	struct psc_dma_stream *s = to_psc_dma_stream(substream, psc_dma);
cebe77674cab51 Jon Smirl         2009-05-23  121  	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
89dd0842527377 Jon Smirl         2009-05-23  122  	u16 imr;
89dd0842527377 Jon Smirl         2009-05-23  123  	unsigned long flags;
dbcc3475623459 Jon Smirl         2009-05-26  124  	int i;
89dd0842527377 Jon Smirl         2009-05-23  125  
89dd0842527377 Jon Smirl         2009-05-23  126  	switch (cmd) {
89dd0842527377 Jon Smirl         2009-05-23  127  	case SNDRV_PCM_TRIGGER_START:
c4878274750ae0 Grant Likely      2009-11-07  128  		dev_dbg(psc_dma->dev, "START: stream=%i fbits=%u ps=%u #p=%u\n",
c4878274750ae0 Grant Likely      2009-11-07  129  			substream->pstr->stream, runtime->frame_bits,
c4878274750ae0 Grant Likely      2009-11-07  130  			(int)runtime->period_size, runtime->periods);
89dd0842527377 Jon Smirl         2009-05-23  131  		s->period_bytes = frames_to_bytes(runtime,
89dd0842527377 Jon Smirl         2009-05-23  132  						  runtime->period_size);
8f159d720b89f2 Grant Likely      2009-11-07  133  		s->period_next = 0;
8f159d720b89f2 Grant Likely      2009-11-07  134  		s->period_current = 0;
89dd0842527377 Jon Smirl         2009-05-23  135  		s->active = 1;
c4878274750ae0 Grant Likely      2009-11-07  136  		s->period_count = 0;
dbcc3475623459 Jon Smirl         2009-05-26  137  		s->runtime = runtime;
dbcc3475623459 Jon Smirl         2009-05-26  138  
dbcc3475623459 Jon Smirl         2009-05-26  139  		/* Fill up the bestcomm bd queue and enable DMA.
dbcc3475623459 Jon Smirl         2009-05-26  140  		 * This will begin filling the PSC's fifo.
dbcc3475623459 Jon Smirl         2009-05-26  141  		 */
dbcc3475623459 Jon Smirl         2009-05-26  142  		spin_lock_irqsave(&psc_dma->lock, flags);
dbcc3475623459 Jon Smirl         2009-05-26  143  
d56b6eb6df7f6f Grant Likely      2009-11-07  144  		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
dbcc3475623459 Jon Smirl         2009-05-26  145  			bcom_gen_bd_rx_reset(s->bcom_task);
d56b6eb6df7f6f Grant Likely      2009-11-07  146  		else
d56b6eb6df7f6f Grant Likely      2009-11-07  147  			bcom_gen_bd_tx_reset(s->bcom_task);
d56b6eb6df7f6f Grant Likely      2009-11-07  148  
dbcc3475623459 Jon Smirl         2009-05-26  149  		for (i = 0; i < runtime->periods; i++)
dbcc3475623459 Jon Smirl         2009-05-26  150  			if (!bcom_queue_full(s->bcom_task))
dbcc3475623459 Jon Smirl         2009-05-26  151  				psc_dma_bcom_enqueue_next_buffer(s);
89dd0842527377 Jon Smirl         2009-05-23  152  
89dd0842527377 Jon Smirl         2009-05-23  153  		bcom_enable(s->bcom_task);
cebe77674cab51 Jon Smirl         2009-05-23  154  		spin_unlock_irqrestore(&psc_dma->lock, flags);
89dd0842527377 Jon Smirl         2009-05-23  155  
dbcc3475623459 Jon Smirl         2009-05-26  156  		out_8(&regs->command, MPC52xx_PSC_RST_ERR_STAT);
dbcc3475623459 Jon Smirl         2009-05-26  157  
89dd0842527377 Jon Smirl         2009-05-23  158  		break;
89dd0842527377 Jon Smirl         2009-05-23  159  
89dd0842527377 Jon Smirl         2009-05-23  160  	case SNDRV_PCM_TRIGGER_STOP:
c4878274750ae0 Grant Likely      2009-11-07  161  		dev_dbg(psc_dma->dev, "STOP: stream=%i periods_count=%i\n",
c4878274750ae0 Grant Likely      2009-11-07  162  			substream->pstr->stream, s->period_count);
89dd0842527377 Jon Smirl         2009-05-23  163  		s->active = 0;
89dd0842527377 Jon Smirl         2009-05-23  164  
dbcc3475623459 Jon Smirl         2009-05-26  165  		spin_lock_irqsave(&psc_dma->lock, flags);
89dd0842527377 Jon Smirl         2009-05-23  166  		bcom_disable(s->bcom_task);
dbcc3475623459 Jon Smirl         2009-05-26  167  		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
dbcc3475623459 Jon Smirl         2009-05-26  168  			bcom_gen_bd_rx_reset(s->bcom_task);
dbcc3475623459 Jon Smirl         2009-05-26  169  		else
dbcc3475623459 Jon Smirl         2009-05-26  170  			bcom_gen_bd_tx_reset(s->bcom_task);
dbcc3475623459 Jon Smirl         2009-05-26  171  		spin_unlock_irqrestore(&psc_dma->lock, flags);
89dd0842527377 Jon Smirl         2009-05-23  172  
89dd0842527377 Jon Smirl         2009-05-23  173  		break;
89dd0842527377 Jon Smirl         2009-05-23  174  
89dd0842527377 Jon Smirl         2009-05-23  175  	default:
c4878274750ae0 Grant Likely      2009-11-07  176  		dev_dbg(psc_dma->dev, "unhandled trigger: stream=%i cmd=%i\n",
c4878274750ae0 Grant Likely      2009-11-07  177  			substream->pstr->stream, cmd);
89dd0842527377 Jon Smirl         2009-05-23  178  		return -EINVAL;
89dd0842527377 Jon Smirl         2009-05-23  179  	}
89dd0842527377 Jon Smirl         2009-05-23  180  
89dd0842527377 Jon Smirl         2009-05-23  181  	/* Update interrupt enable settings */
89dd0842527377 Jon Smirl         2009-05-23  182  	imr = 0;
cebe77674cab51 Jon Smirl         2009-05-23  183  	if (psc_dma->playback.active)
89dd0842527377 Jon Smirl         2009-05-23  184  		imr |= MPC52xx_PSC_IMR_TXEMP;
cebe77674cab51 Jon Smirl         2009-05-23  185  	if (psc_dma->capture.active)
89dd0842527377 Jon Smirl         2009-05-23  186  		imr |= MPC52xx_PSC_IMR_ORERR;
dbcc3475623459 Jon Smirl         2009-05-26  187  	out_be16(&regs->isr_imr.imr, psc_dma->imr | imr);
89dd0842527377 Jon Smirl         2009-05-23  188  
89dd0842527377 Jon Smirl         2009-05-23  189  	return 0;
89dd0842527377 Jon Smirl         2009-05-23  190  }
89dd0842527377 Jon Smirl         2009-05-23  191  

:::::: The code at line 116 was first introduced by commit
:::::: 89dd08425273773fd33fc85d48d152c5679b2fb4 ASoC: Basic split of mpc5200 DMA code out of mpc5200_psc_i2s

:::::: TO: Jon Smirl <jonsmirl@gmail.com>
:::::: CC: Mark Brown <broonie@opensource.wolfsonmicro.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
