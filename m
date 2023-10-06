Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D157BB744
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjJFMDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjJFMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:03:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16669DE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696593766; x=1728129766;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KSKFq3eqO/Zz3nr5EJKgtn5wNMuBKl40MhbtHGHIXfI=;
  b=YnAjtF062vpMtQjSWJ/gQrsYwV/mA+uqhY0sNOIV51v/OkHjSGjfzfdB
   ApNEP8pb/nNFxJ7mbo7kpYH768TkfVwWBYQcQCpcKrGrktZgohzO8dhZZ
   OWW3NFymX9oOMMrgFB7qBhIdpJ9lFbsSRZvlYsjXEo/mW98T1ZsSgeP9v
   u4ySQP2sdhh0HNgnTEUdN24cevbhLj5Nq7k+TyMhb5BCdq0GhA88rdjX1
   ap5w9klaLvaC27LsmxyNf1+W2aAKri8qZ8rhAm6VsL2M+UjQBvjy7z+lo
   l8gAaH2BpPZ1fA4u2NQ4v8JxyF/jkYNUTrNvPmtglMseddbdISAZgcEOS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="386558057"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="386558057"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 05:02:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="781633611"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="781633611"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 06 Oct 2023 05:02:39 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qojXQ-000MZc-2D;
        Fri, 06 Oct 2023 12:02:36 +0000
Date:   Fri, 6 Oct 2023 20:01:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/fsl/fsl_dma.c:284: warning: Function parameter or member
 'component' not described in 'fsl_dma_new'
Message-ID: <202310061950.aejBQNM7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b78b18fb8ee19f7a05f20c3abc865b3bfe182884
commit: d3de1eb461e5bac0b07f5c785e6e0d959915df96 ASoC: fsl: fsl_dma: fix build failure
date:   3 years, 11 months ago
config: powerpc-randconfig-s032-20211008 (https://download.01.org/0day-ci/archive/20231006/202310061950.aejBQNM7-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310061950.aejBQNM7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310061950.aejBQNM7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/soc/fsl/fsl_dma.c:128: warning: cannot understand function prototype: 'const struct snd_pcm_hardware fsl_dma_hardware = '
   sound/soc/fsl/fsl_dma.c:150: warning: Function parameter or member 'substream' not described in 'fsl_dma_abort_stream'
   sound/soc/fsl/fsl_dma.c:161: warning: Function parameter or member 'dma_private' not described in 'fsl_dma_update_pointers'
>> sound/soc/fsl/fsl_dma.c:284: warning: Function parameter or member 'component' not described in 'fsl_dma_new'
   sound/soc/fsl/fsl_dma.c:284: warning: Function parameter or member 'rtd' not described in 'fsl_dma_new'
>> sound/soc/fsl/fsl_dma.c:385: warning: Function parameter or member 'component' not described in 'fsl_dma_open'
   sound/soc/fsl/fsl_dma.c:385: warning: Function parameter or member 'substream' not described in 'fsl_dma_open'
>> sound/soc/fsl/fsl_dma.c:538: warning: Function parameter or member 'component' not described in 'fsl_dma_hw_params'
   sound/soc/fsl/fsl_dma.c:538: warning: Function parameter or member 'substream' not described in 'fsl_dma_hw_params'
   sound/soc/fsl/fsl_dma.c:538: warning: Function parameter or member 'hw_params' not described in 'fsl_dma_hw_params'
>> sound/soc/fsl/fsl_dma.c:701: warning: Function parameter or member 'component' not described in 'fsl_dma_pointer'
   sound/soc/fsl/fsl_dma.c:701: warning: Function parameter or member 'substream' not described in 'fsl_dma_pointer'
>> sound/soc/fsl/fsl_dma.c:765: warning: Function parameter or member 'component' not described in 'fsl_dma_hw_free'
   sound/soc/fsl/fsl_dma.c:765: warning: Function parameter or member 'substream' not described in 'fsl_dma_hw_free'
>> sound/soc/fsl/fsl_dma.c:799: warning: Function parameter or member 'component' not described in 'fsl_dma_close'
   sound/soc/fsl/fsl_dma.c:799: warning: Function parameter or member 'substream' not described in 'fsl_dma_close'
   sound/soc/fsl/fsl_dma.c:852: warning: Function parameter or member 'dma_channel_np' not described in 'find_ssi_node'


vim +284 sound/soc/fsl/fsl_dma.c

17467f23395f05 Timur Tabi        2008-01-11  108  
17467f23395f05 Timur Tabi        2008-01-11  109  /**
17467f23395f05 Timur Tabi        2008-01-11  110   * fsl_dma_hardare: define characteristics of the PCM hardware.
17467f23395f05 Timur Tabi        2008-01-11  111   *
17467f23395f05 Timur Tabi        2008-01-11  112   * The PCM hardware is the Freescale DMA controller.  This structure defines
17467f23395f05 Timur Tabi        2008-01-11  113   * the capabilities of that hardware.
17467f23395f05 Timur Tabi        2008-01-11  114   *
17467f23395f05 Timur Tabi        2008-01-11  115   * Since the sampling rate and data format are not controlled by the DMA
17467f23395f05 Timur Tabi        2008-01-11  116   * controller, we specify no limits for those values.  The only exception is
17467f23395f05 Timur Tabi        2008-01-11  117   * period_bytes_min, which is set to a reasonably low value to prevent the
17467f23395f05 Timur Tabi        2008-01-11  118   * DMA controller from generating too many interrupts per second.
17467f23395f05 Timur Tabi        2008-01-11  119   *
17467f23395f05 Timur Tabi        2008-01-11  120   * Since each link descriptor has a 32-bit byte count field, we set
17467f23395f05 Timur Tabi        2008-01-11  121   * period_bytes_max to the largest 32-bit number.  We also have no maximum
17467f23395f05 Timur Tabi        2008-01-11  122   * number of periods.
be41e941d5f1a4 Timur Tabi        2008-07-28  123   *
be41e941d5f1a4 Timur Tabi        2008-07-28  124   * Note that we specify SNDRV_PCM_INFO_JOINT_DUPLEX here, but only because a
be41e941d5f1a4 Timur Tabi        2008-07-28  125   * limitation in the SSI driver requires the sample rates for playback and
be41e941d5f1a4 Timur Tabi        2008-07-28  126   * capture to be the same.
17467f23395f05 Timur Tabi        2008-01-11  127   */
17467f23395f05 Timur Tabi        2008-01-11 @128  static const struct snd_pcm_hardware fsl_dma_hardware = {
17467f23395f05 Timur Tabi        2008-01-11  129  
4052ce4cbf4853 Timur Tabi        2008-01-17  130  	.info   		= SNDRV_PCM_INFO_INTERLEAVED |
4052ce4cbf4853 Timur Tabi        2008-01-17  131  				  SNDRV_PCM_INFO_MMAP |
be41e941d5f1a4 Timur Tabi        2008-07-28  132  				  SNDRV_PCM_INFO_MMAP_VALID |
3a638ff2727442 Timur Tabi        2009-03-06  133  				  SNDRV_PCM_INFO_JOINT_DUPLEX |
3a638ff2727442 Timur Tabi        2009-03-06  134  				  SNDRV_PCM_INFO_PAUSE,
17467f23395f05 Timur Tabi        2008-01-11  135  	.formats		= FSLDMA_PCM_FORMATS,
17467f23395f05 Timur Tabi        2008-01-11  136  	.period_bytes_min       = 512,  	/* A reasonable limit */
17467f23395f05 Timur Tabi        2008-01-11  137  	.period_bytes_max       = (u32) -1,
17467f23395f05 Timur Tabi        2008-01-11  138  	.periods_min    	= NUM_DMA_LINKS,
17467f23395f05 Timur Tabi        2008-01-11  139  	.periods_max    	= (unsigned int) -1,
17467f23395f05 Timur Tabi        2008-01-11  140  	.buffer_bytes_max       = 128 * 1024,   /* A reasonable limit */
17467f23395f05 Timur Tabi        2008-01-11  141  };
17467f23395f05 Timur Tabi        2008-01-11  142  
17467f23395f05 Timur Tabi        2008-01-11  143  /**
17467f23395f05 Timur Tabi        2008-01-11  144   * fsl_dma_abort_stream: tell ALSA that the DMA transfer has aborted
17467f23395f05 Timur Tabi        2008-01-11  145   *
17467f23395f05 Timur Tabi        2008-01-11  146   * This function should be called by the ISR whenever the DMA controller
17467f23395f05 Timur Tabi        2008-01-11  147   * halts data transfer.
17467f23395f05 Timur Tabi        2008-01-11  148   */
17467f23395f05 Timur Tabi        2008-01-11  149  static void fsl_dma_abort_stream(struct snd_pcm_substream *substream)
17467f23395f05 Timur Tabi        2008-01-11 @150  {
1fb8510cdb5b7b Takashi Iwai      2014-11-07  151  	snd_pcm_stop_xrun(substream);
17467f23395f05 Timur Tabi        2008-01-11  152  }
17467f23395f05 Timur Tabi        2008-01-11  153  
17467f23395f05 Timur Tabi        2008-01-11  154  /**
17467f23395f05 Timur Tabi        2008-01-11  155   * fsl_dma_update_pointers - update LD pointers to point to the next period
17467f23395f05 Timur Tabi        2008-01-11  156   *
17467f23395f05 Timur Tabi        2008-01-11  157   * As each period is completed, this function changes the the link
17467f23395f05 Timur Tabi        2008-01-11  158   * descriptor pointers for that period to point to the next period.
17467f23395f05 Timur Tabi        2008-01-11  159   */
17467f23395f05 Timur Tabi        2008-01-11  160  static void fsl_dma_update_pointers(struct fsl_dma_private *dma_private)
17467f23395f05 Timur Tabi        2008-01-11  161  {
17467f23395f05 Timur Tabi        2008-01-11  162  	struct fsl_dma_link_descriptor *link =
17467f23395f05 Timur Tabi        2008-01-11  163  		&dma_private->link[dma_private->current_link];
17467f23395f05 Timur Tabi        2008-01-11  164  
1a3c5a491af675 Timur Tabi        2010-08-02  165  	/* Update our link descriptors to point to the next period. On a 36-bit
1a3c5a491af675 Timur Tabi        2010-08-02  166  	 * system, we also need to update the ESAD bits.  We also set (keep) the
1a3c5a491af675 Timur Tabi        2010-08-02  167  	 * snoop bits.  See the comments in fsl_dma_hw_params() about snooping.
1a3c5a491af675 Timur Tabi        2010-08-02  168  	 */
1a3c5a491af675 Timur Tabi        2010-08-02  169  	if (dma_private->substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
1a3c5a491af675 Timur Tabi        2010-08-02  170  		link->source_addr = cpu_to_be32(dma_private->dma_buf_next);
1a3c5a491af675 Timur Tabi        2010-08-02  171  #ifdef CONFIG_PHYS_64BIT
1a3c5a491af675 Timur Tabi        2010-08-02  172  		link->source_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP |
1a3c5a491af675 Timur Tabi        2010-08-02  173  			upper_32_bits(dma_private->dma_buf_next));
1a3c5a491af675 Timur Tabi        2010-08-02  174  #endif
1a3c5a491af675 Timur Tabi        2010-08-02  175  	} else {
1a3c5a491af675 Timur Tabi        2010-08-02  176  		link->dest_addr = cpu_to_be32(dma_private->dma_buf_next);
1a3c5a491af675 Timur Tabi        2010-08-02  177  #ifdef CONFIG_PHYS_64BIT
1a3c5a491af675 Timur Tabi        2010-08-02  178  		link->dest_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP |
1a3c5a491af675 Timur Tabi        2010-08-02  179  			upper_32_bits(dma_private->dma_buf_next));
1a3c5a491af675 Timur Tabi        2010-08-02  180  #endif
1a3c5a491af675 Timur Tabi        2010-08-02  181  	}
17467f23395f05 Timur Tabi        2008-01-11  182  
17467f23395f05 Timur Tabi        2008-01-11  183  	/* Update our variables for next time */
17467f23395f05 Timur Tabi        2008-01-11  184  	dma_private->dma_buf_next += dma_private->period_size;
17467f23395f05 Timur Tabi        2008-01-11  185  
17467f23395f05 Timur Tabi        2008-01-11  186  	if (dma_private->dma_buf_next >= dma_private->dma_buf_end)
17467f23395f05 Timur Tabi        2008-01-11  187  		dma_private->dma_buf_next = dma_private->dma_buf_phys;
17467f23395f05 Timur Tabi        2008-01-11  188  
17467f23395f05 Timur Tabi        2008-01-11  189  	if (++dma_private->current_link >= NUM_DMA_LINKS)
17467f23395f05 Timur Tabi        2008-01-11  190  		dma_private->current_link = 0;
17467f23395f05 Timur Tabi        2008-01-11  191  }
17467f23395f05 Timur Tabi        2008-01-11  192  
17467f23395f05 Timur Tabi        2008-01-11  193  /**
17467f23395f05 Timur Tabi        2008-01-11  194   * fsl_dma_isr: interrupt handler for the DMA controller
17467f23395f05 Timur Tabi        2008-01-11  195   *
17467f23395f05 Timur Tabi        2008-01-11  196   * @irq: IRQ of the DMA channel
17467f23395f05 Timur Tabi        2008-01-11  197   * @dev_id: pointer to the dma_private structure for this DMA channel
17467f23395f05 Timur Tabi        2008-01-11  198   */
17467f23395f05 Timur Tabi        2008-01-11  199  static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
17467f23395f05 Timur Tabi        2008-01-11  200  {
17467f23395f05 Timur Tabi        2008-01-11  201  	struct fsl_dma_private *dma_private = dev_id;
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  202  	struct snd_pcm_substream *substream = dma_private->substream;
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  203  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
a21192a7daf45f Kuninori Morimoto 2019-10-02  204  	struct device *dev = rtd->dev;
17467f23395f05 Timur Tabi        2008-01-11  205  	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
17467f23395f05 Timur Tabi        2008-01-11  206  	irqreturn_t ret = IRQ_NONE;
17467f23395f05 Timur Tabi        2008-01-11  207  	u32 sr, sr2 = 0;
17467f23395f05 Timur Tabi        2008-01-11  208  
17467f23395f05 Timur Tabi        2008-01-11  209  	/* We got an interrupt, so read the status register to see what we
17467f23395f05 Timur Tabi        2008-01-11  210  	   were interrupted for.
17467f23395f05 Timur Tabi        2008-01-11  211  	 */
17467f23395f05 Timur Tabi        2008-01-11  212  	sr = in_be32(&dma_channel->sr);
17467f23395f05 Timur Tabi        2008-01-11  213  
17467f23395f05 Timur Tabi        2008-01-11  214  	if (sr & CCSR_DMA_SR_TE) {
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  215  		dev_err(dev, "dma transmit error\n");
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  216  		fsl_dma_abort_stream(substream);
17467f23395f05 Timur Tabi        2008-01-11  217  		sr2 |= CCSR_DMA_SR_TE;
17467f23395f05 Timur Tabi        2008-01-11  218  		ret = IRQ_HANDLED;
17467f23395f05 Timur Tabi        2008-01-11  219  	}
17467f23395f05 Timur Tabi        2008-01-11  220  
17467f23395f05 Timur Tabi        2008-01-11  221  	if (sr & CCSR_DMA_SR_CH)
17467f23395f05 Timur Tabi        2008-01-11  222  		ret = IRQ_HANDLED;
17467f23395f05 Timur Tabi        2008-01-11  223  
17467f23395f05 Timur Tabi        2008-01-11  224  	if (sr & CCSR_DMA_SR_PE) {
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  225  		dev_err(dev, "dma programming error\n");
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  226  		fsl_dma_abort_stream(substream);
17467f23395f05 Timur Tabi        2008-01-11  227  		sr2 |= CCSR_DMA_SR_PE;
17467f23395f05 Timur Tabi        2008-01-11  228  		ret = IRQ_HANDLED;
17467f23395f05 Timur Tabi        2008-01-11  229  	}
17467f23395f05 Timur Tabi        2008-01-11  230  
17467f23395f05 Timur Tabi        2008-01-11  231  	if (sr & CCSR_DMA_SR_EOLNI) {
17467f23395f05 Timur Tabi        2008-01-11  232  		sr2 |= CCSR_DMA_SR_EOLNI;
17467f23395f05 Timur Tabi        2008-01-11  233  		ret = IRQ_HANDLED;
17467f23395f05 Timur Tabi        2008-01-11  234  	}
17467f23395f05 Timur Tabi        2008-01-11  235  
17467f23395f05 Timur Tabi        2008-01-11  236  	if (sr & CCSR_DMA_SR_CB)
17467f23395f05 Timur Tabi        2008-01-11  237  		ret = IRQ_HANDLED;
17467f23395f05 Timur Tabi        2008-01-11  238  
17467f23395f05 Timur Tabi        2008-01-11  239  	if (sr & CCSR_DMA_SR_EOSI) {
17467f23395f05 Timur Tabi        2008-01-11  240  		/* Tell ALSA we completed a period. */
17467f23395f05 Timur Tabi        2008-01-11  241  		snd_pcm_period_elapsed(substream);
17467f23395f05 Timur Tabi        2008-01-11  242  
17467f23395f05 Timur Tabi        2008-01-11  243  		/*
17467f23395f05 Timur Tabi        2008-01-11  244  		 * Update our link descriptors to point to the next period. We
17467f23395f05 Timur Tabi        2008-01-11  245  		 * only need to do this if the number of periods is not equal to
17467f23395f05 Timur Tabi        2008-01-11  246  		 * the number of links.
17467f23395f05 Timur Tabi        2008-01-11  247  		 */
17467f23395f05 Timur Tabi        2008-01-11  248  		if (dma_private->num_periods != NUM_DMA_LINKS)
17467f23395f05 Timur Tabi        2008-01-11  249  			fsl_dma_update_pointers(dma_private);
17467f23395f05 Timur Tabi        2008-01-11  250  
17467f23395f05 Timur Tabi        2008-01-11  251  		sr2 |= CCSR_DMA_SR_EOSI;
17467f23395f05 Timur Tabi        2008-01-11  252  		ret = IRQ_HANDLED;
17467f23395f05 Timur Tabi        2008-01-11  253  	}
17467f23395f05 Timur Tabi        2008-01-11  254  
17467f23395f05 Timur Tabi        2008-01-11  255  	if (sr & CCSR_DMA_SR_EOLSI) {
17467f23395f05 Timur Tabi        2008-01-11  256  		sr2 |= CCSR_DMA_SR_EOLSI;
17467f23395f05 Timur Tabi        2008-01-11  257  		ret = IRQ_HANDLED;
17467f23395f05 Timur Tabi        2008-01-11  258  	}
17467f23395f05 Timur Tabi        2008-01-11  259  
17467f23395f05 Timur Tabi        2008-01-11  260  	/* Clear the bits that we set */
17467f23395f05 Timur Tabi        2008-01-11  261  	if (sr2)
17467f23395f05 Timur Tabi        2008-01-11  262  		out_be32(&dma_channel->sr, sr2);
17467f23395f05 Timur Tabi        2008-01-11  263  
17467f23395f05 Timur Tabi        2008-01-11  264  	return ret;
17467f23395f05 Timur Tabi        2008-01-11  265  }
17467f23395f05 Timur Tabi        2008-01-11  266  
17467f23395f05 Timur Tabi        2008-01-11  267  /**
17467f23395f05 Timur Tabi        2008-01-11  268   * fsl_dma_new: initialize this PCM driver.
17467f23395f05 Timur Tabi        2008-01-11  269   *
17467f23395f05 Timur Tabi        2008-01-11  270   * This function is called when the codec driver calls snd_soc_new_pcms(),
875065491fba8e Mark Brown        2008-11-18  271   * once for each .dai_link in the machine driver's snd_soc_card
17467f23395f05 Timur Tabi        2008-01-11  272   * structure.
1a3c5a491af675 Timur Tabi        2010-08-02  273   *
1a3c5a491af675 Timur Tabi        2010-08-02  274   * snd_dma_alloc_pages() is just a front-end to dma_alloc_coherent(), which
1a3c5a491af675 Timur Tabi        2010-08-02  275   * (currently) always allocates the DMA buffer in lowmem, even if GFP_HIGHMEM
1a3c5a491af675 Timur Tabi        2010-08-02  276   * is specified. Therefore, any DMA buffers we allocate will always be in low
1a3c5a491af675 Timur Tabi        2010-08-02  277   * memory, but we support for 36-bit physical addresses anyway.
1a3c5a491af675 Timur Tabi        2010-08-02  278   *
1a3c5a491af675 Timur Tabi        2010-08-02  279   * Regardless of where the memory is actually allocated, since the device can
1a3c5a491af675 Timur Tabi        2010-08-02  280   * technically DMA to any 36-bit address, we do need to set the DMA mask to 36.
17467f23395f05 Timur Tabi        2008-01-11  281   */
4ac85de9977e73 Kuninori Morimoto 2019-10-02  282  static int fsl_dma_new(struct snd_soc_component *component,
4ac85de9977e73 Kuninori Morimoto 2019-10-02  283  		       struct snd_soc_pcm_runtime *rtd)
17467f23395f05 Timur Tabi        2008-01-11 @284  {
552d1ef6b5a98d Liam Girdwood     2011-06-07  285  	struct snd_card *card = rtd->card->snd_card;
552d1ef6b5a98d Liam Girdwood     2011-06-07  286  	struct snd_pcm *pcm = rtd->pcm;
17467f23395f05 Timur Tabi        2008-01-11  287  	int ret;
17467f23395f05 Timur Tabi        2008-01-11  288  
c9bd5e690a439d Russell King      2013-06-27  289  	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(36));
c9bd5e690a439d Russell King      2013-06-27  290  	if (ret)
c9bd5e690a439d Russell King      2013-06-27  291  		return ret;
17467f23395f05 Timur Tabi        2008-01-11  292  
c04019d450a885 Timur Tabi        2010-08-19  293  	/* Some codecs have separate DAIs for playback and capture, so we
c04019d450a885 Timur Tabi        2010-08-19  294  	 * should allocate a DMA buffer only for the streams that are valid.
c04019d450a885 Timur Tabi        2010-08-19  295  	 */
c04019d450a885 Timur Tabi        2010-08-19  296  
6296914ccefe6e Joachim Eastwood  2012-01-01  297  	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
5c15a6869a7500 Anton Vorontsov   2009-04-04  298  		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
17467f23395f05 Timur Tabi        2008-01-11  299  			fsl_dma_hardware.buffer_bytes_max,
6296914ccefe6e Joachim Eastwood  2012-01-01  300  			&pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream->dma_buffer);
17467f23395f05 Timur Tabi        2008-01-11  301  		if (ret) {
c04019d450a885 Timur Tabi        2010-08-19  302  			dev_err(card->dev, "can't alloc playback dma buffer\n");
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  303  			return ret;
17467f23395f05 Timur Tabi        2008-01-11  304  		}
c04019d450a885 Timur Tabi        2010-08-19  305  	}
17467f23395f05 Timur Tabi        2008-01-11  306  
6296914ccefe6e Joachim Eastwood  2012-01-01  307  	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
5c15a6869a7500 Anton Vorontsov   2009-04-04  308  		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
17467f23395f05 Timur Tabi        2008-01-11  309  			fsl_dma_hardware.buffer_bytes_max,
6296914ccefe6e Joachim Eastwood  2012-01-01  310  			&pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream->dma_buffer);
17467f23395f05 Timur Tabi        2008-01-11  311  		if (ret) {
c04019d450a885 Timur Tabi        2010-08-19  312  			dev_err(card->dev, "can't alloc capture dma buffer\n");
6296914ccefe6e Joachim Eastwood  2012-01-01  313  			snd_dma_free_pages(&pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream->dma_buffer);
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  314  			return ret;
17467f23395f05 Timur Tabi        2008-01-11  315  		}
c04019d450a885 Timur Tabi        2010-08-19  316  	}
17467f23395f05 Timur Tabi        2008-01-11  317  
17467f23395f05 Timur Tabi        2008-01-11  318  	return 0;
17467f23395f05 Timur Tabi        2008-01-11  319  }
17467f23395f05 Timur Tabi        2008-01-11  320  
17467f23395f05 Timur Tabi        2008-01-11  321  /**
17467f23395f05 Timur Tabi        2008-01-11  322   * fsl_dma_open: open a new substream.
17467f23395f05 Timur Tabi        2008-01-11  323   *
17467f23395f05 Timur Tabi        2008-01-11  324   * Each substream has its own DMA buffer.
bf9c8c9ddef7ef Timur Tabi        2008-08-01  325   *
bf9c8c9ddef7ef Timur Tabi        2008-08-01  326   * ALSA divides the DMA buffer into N periods.  We create NUM_DMA_LINKS link
bf9c8c9ddef7ef Timur Tabi        2008-08-01  327   * descriptors that ping-pong from one period to the next.  For example, if
bf9c8c9ddef7ef Timur Tabi        2008-08-01  328   * there are six periods and two link descriptors, this is how they look
bf9c8c9ddef7ef Timur Tabi        2008-08-01  329   * before playback starts:
bf9c8c9ddef7ef Timur Tabi        2008-08-01  330   *
bf9c8c9ddef7ef Timur Tabi        2008-08-01  331   *      	   The last link descriptor
bf9c8c9ddef7ef Timur Tabi        2008-08-01  332   *   ____________  points back to the first
bf9c8c9ddef7ef Timur Tabi        2008-08-01  333   *  |   	 |
bf9c8c9ddef7ef Timur Tabi        2008-08-01  334   *  V   	 |
bf9c8c9ddef7ef Timur Tabi        2008-08-01  335   *  ___    ___   |
bf9c8c9ddef7ef Timur Tabi        2008-08-01  336   * |   |->|   |->|
bf9c8c9ddef7ef Timur Tabi        2008-08-01  337   * |___|  |___|
bf9c8c9ddef7ef Timur Tabi        2008-08-01  338   *   |      |
bf9c8c9ddef7ef Timur Tabi        2008-08-01  339   *   |      |
bf9c8c9ddef7ef Timur Tabi        2008-08-01  340   *   V      V
bf9c8c9ddef7ef Timur Tabi        2008-08-01  341   *  _________________________________________
bf9c8c9ddef7ef Timur Tabi        2008-08-01  342   * |      |      |      |      |      |      |  The DMA buffer is
bf9c8c9ddef7ef Timur Tabi        2008-08-01  343   * |      |      |      |      |      |      |    divided into 6 parts
bf9c8c9ddef7ef Timur Tabi        2008-08-01  344   * |______|______|______|______|______|______|
bf9c8c9ddef7ef Timur Tabi        2008-08-01  345   *
bf9c8c9ddef7ef Timur Tabi        2008-08-01  346   * and here's how they look after the first period is finished playing:
bf9c8c9ddef7ef Timur Tabi        2008-08-01  347   *
bf9c8c9ddef7ef Timur Tabi        2008-08-01  348   *   ____________
bf9c8c9ddef7ef Timur Tabi        2008-08-01  349   *  |   	 |
bf9c8c9ddef7ef Timur Tabi        2008-08-01  350   *  V   	 |
bf9c8c9ddef7ef Timur Tabi        2008-08-01  351   *  ___    ___   |
bf9c8c9ddef7ef Timur Tabi        2008-08-01  352   * |   |->|   |->|
bf9c8c9ddef7ef Timur Tabi        2008-08-01  353   * |___|  |___|
bf9c8c9ddef7ef Timur Tabi        2008-08-01  354   *   |      |
bf9c8c9ddef7ef Timur Tabi        2008-08-01  355   *   |______________
bf9c8c9ddef7ef Timur Tabi        2008-08-01  356   *          |       |
bf9c8c9ddef7ef Timur Tabi        2008-08-01  357   *          V       V
bf9c8c9ddef7ef Timur Tabi        2008-08-01  358   *  _________________________________________
bf9c8c9ddef7ef Timur Tabi        2008-08-01  359   * |      |      |      |      |      |      |
bf9c8c9ddef7ef Timur Tabi        2008-08-01  360   * |      |      |      |      |      |      |
bf9c8c9ddef7ef Timur Tabi        2008-08-01  361   * |______|______|______|______|______|______|
bf9c8c9ddef7ef Timur Tabi        2008-08-01  362   *
bf9c8c9ddef7ef Timur Tabi        2008-08-01  363   * The first link descriptor now points to the third period.  The DMA
bf9c8c9ddef7ef Timur Tabi        2008-08-01  364   * controller is currently playing the second period.  When it finishes, it
bf9c8c9ddef7ef Timur Tabi        2008-08-01  365   * will jump back to the first descriptor and play the third period.
bf9c8c9ddef7ef Timur Tabi        2008-08-01  366   *
bf9c8c9ddef7ef Timur Tabi        2008-08-01  367   * There are four reasons we do this:
bf9c8c9ddef7ef Timur Tabi        2008-08-01  368   *
bf9c8c9ddef7ef Timur Tabi        2008-08-01  369   * 1. The only way to get the DMA controller to automatically restart the
bf9c8c9ddef7ef Timur Tabi        2008-08-01  370   *    transfer when it gets to the end of the buffer is to use chaining
bf9c8c9ddef7ef Timur Tabi        2008-08-01  371   *    mode.  Basic direct mode doesn't offer that feature.
bf9c8c9ddef7ef Timur Tabi        2008-08-01  372   * 2. We need to receive an interrupt at the end of every period.  The DMA
bf9c8c9ddef7ef Timur Tabi        2008-08-01  373   *    controller can generate an interrupt at the end of every link transfer
bf9c8c9ddef7ef Timur Tabi        2008-08-01  374   *    (aka segment).  Making each period into a DMA segment will give us the
bf9c8c9ddef7ef Timur Tabi        2008-08-01  375   *    interrupts we need.
bf9c8c9ddef7ef Timur Tabi        2008-08-01  376   * 3. By creating only two link descriptors, regardless of the number of
bf9c8c9ddef7ef Timur Tabi        2008-08-01  377   *    periods, we do not need to reallocate the link descriptors if the
bf9c8c9ddef7ef Timur Tabi        2008-08-01  378   *    number of periods changes.
bf9c8c9ddef7ef Timur Tabi        2008-08-01  379   * 4. All of the audio data is still stored in a single, contiguous DMA
bf9c8c9ddef7ef Timur Tabi        2008-08-01  380   *    buffer, which is what ALSA expects.  We're just dividing it into
bf9c8c9ddef7ef Timur Tabi        2008-08-01  381   *    contiguous parts, and creating a link descriptor for each one.
17467f23395f05 Timur Tabi        2008-01-11  382   */
4ac85de9977e73 Kuninori Morimoto 2019-10-02  383  static int fsl_dma_open(struct snd_soc_component *component,
4ac85de9977e73 Kuninori Morimoto 2019-10-02  384  			struct snd_pcm_substream *substream)
17467f23395f05 Timur Tabi        2008-01-11 @385  {
17467f23395f05 Timur Tabi        2008-01-11  386  	struct snd_pcm_runtime *runtime = substream->runtime;
4cb1ea925e66a2 Kuninori Morimoto 2018-01-29  387  	struct device *dev = component->dev;
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  388  	struct dma_object *dma =
4cb1ea925e66a2 Kuninori Morimoto 2018-01-29  389  		container_of(component->driver, struct dma_object, dai);
17467f23395f05 Timur Tabi        2008-01-11  390  	struct fsl_dma_private *dma_private;
bf9c8c9ddef7ef Timur Tabi        2008-08-01  391  	struct ccsr_dma_channel __iomem *dma_channel;
17467f23395f05 Timur Tabi        2008-01-11  392  	dma_addr_t ld_buf_phys;
bf9c8c9ddef7ef Timur Tabi        2008-08-01  393  	u64 temp_link;  	/* Pointer to next link descriptor */
bf9c8c9ddef7ef Timur Tabi        2008-08-01  394  	u32 mr;
17467f23395f05 Timur Tabi        2008-01-11  395  	unsigned int channel;
17467f23395f05 Timur Tabi        2008-01-11  396  	int ret = 0;
bf9c8c9ddef7ef Timur Tabi        2008-08-01  397  	unsigned int i;
17467f23395f05 Timur Tabi        2008-01-11  398  
17467f23395f05 Timur Tabi        2008-01-11  399  	/*
17467f23395f05 Timur Tabi        2008-01-11  400  	 * Reject any DMA buffer whose size is not a multiple of the period
17467f23395f05 Timur Tabi        2008-01-11  401  	 * size.  We need to make sure that the DMA buffer can be evenly divided
17467f23395f05 Timur Tabi        2008-01-11  402  	 * into periods.
17467f23395f05 Timur Tabi        2008-01-11  403  	 */
17467f23395f05 Timur Tabi        2008-01-11  404  	ret = snd_pcm_hw_constraint_integer(runtime,
17467f23395f05 Timur Tabi        2008-01-11  405  		SNDRV_PCM_HW_PARAM_PERIODS);
17467f23395f05 Timur Tabi        2008-01-11  406  	if (ret < 0) {
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  407  		dev_err(dev, "invalid buffer size\n");
17467f23395f05 Timur Tabi        2008-01-11  408  		return ret;
17467f23395f05 Timur Tabi        2008-01-11  409  	}
17467f23395f05 Timur Tabi        2008-01-11  410  
17467f23395f05 Timur Tabi        2008-01-11  411  	channel = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
17467f23395f05 Timur Tabi        2008-01-11  412  
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  413  	if (dma->assigned) {
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  414  		dev_err(dev, "dma channel already assigned\n");
17467f23395f05 Timur Tabi        2008-01-11  415  		return -EBUSY;
17467f23395f05 Timur Tabi        2008-01-11  416  	}
17467f23395f05 Timur Tabi        2008-01-11  417  
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  418  	dma_private = dma_alloc_coherent(dev, sizeof(struct fsl_dma_private),
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  419  					 &ld_buf_phys, GFP_KERNEL);
17467f23395f05 Timur Tabi        2008-01-11  420  	if (!dma_private) {
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  421  		dev_err(dev, "can't allocate dma private data\n");
17467f23395f05 Timur Tabi        2008-01-11  422  		return -ENOMEM;
17467f23395f05 Timur Tabi        2008-01-11  423  	}
17467f23395f05 Timur Tabi        2008-01-11  424  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  425  		dma_private->ssi_sxx_phys = dma->ssi_stx_phys;
17467f23395f05 Timur Tabi        2008-01-11  426  	else
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  427  		dma_private->ssi_sxx_phys = dma->ssi_srx_phys;
17467f23395f05 Timur Tabi        2008-01-11  428  
8e9d869028f3ce Timur Tabi        2010-08-06  429  	dma_private->ssi_fifo_depth = dma->ssi_fifo_depth;
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  430  	dma_private->dma_channel = dma->channel;
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  431  	dma_private->irq = dma->irq;
17467f23395f05 Timur Tabi        2008-01-11  432  	dma_private->substream = substream;
17467f23395f05 Timur Tabi        2008-01-11  433  	dma_private->ld_buf_phys = ld_buf_phys;
17467f23395f05 Timur Tabi        2008-01-11  434  	dma_private->dma_buf_phys = substream->dma_buffer.addr;
17467f23395f05 Timur Tabi        2008-01-11  435  
0cd114fff9ace7 Timur Tabi        2011-06-08  436  	ret = request_irq(dma_private->irq, fsl_dma_isr, 0, "fsldma-audio",
0cd114fff9ace7 Timur Tabi        2011-06-08  437  			  dma_private);
17467f23395f05 Timur Tabi        2008-01-11  438  	if (ret) {
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  439  		dev_err(dev, "can't register ISR for IRQ %u (ret=%i)\n",
17467f23395f05 Timur Tabi        2008-01-11  440  			dma_private->irq, ret);
f0fba2ad1b6b53 Liam Girdwood     2010-03-17  441  		dma_free_coherent(dev, sizeof(struct fsl_dma_private),
17467f23395f05 Timur Tabi        2008-01-11  442  			dma_private, dma_private->ld_buf_phys);
17467f23395f05 Timur Tabi        2008-01-11  443  		return ret;
17467f23395f05 Timur Tabi        2008-01-11  444  	}
17467f23395f05 Timur Tabi        2008-01-11  445  
d0657fe8c645e3 Fabio Estevam     2015-05-09  446  	dma->assigned = true;
17467f23395f05 Timur Tabi        2008-01-11  447  
17467f23395f05 Timur Tabi        2008-01-11  448  	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
17467f23395f05 Timur Tabi        2008-01-11  449  	snd_soc_set_runtime_hwparams(substream, &fsl_dma_hardware);
17467f23395f05 Timur Tabi        2008-01-11  450  	runtime->private_data = dma_private;
17467f23395f05 Timur Tabi        2008-01-11  451  
bf9c8c9ddef7ef Timur Tabi        2008-08-01  452  	/* Program the fixed DMA controller parameters */
bf9c8c9ddef7ef Timur Tabi        2008-08-01  453  
bf9c8c9ddef7ef Timur Tabi        2008-08-01  454  	dma_channel = dma_private->dma_channel;
bf9c8c9ddef7ef Timur Tabi        2008-08-01  455  
bf9c8c9ddef7ef Timur Tabi        2008-08-01  456  	temp_link = dma_private->ld_buf_phys +
bf9c8c9ddef7ef Timur Tabi        2008-08-01  457  		sizeof(struct fsl_dma_link_descriptor);
bf9c8c9ddef7ef Timur Tabi        2008-08-01  458  
bf9c8c9ddef7ef Timur Tabi        2008-08-01  459  	for (i = 0; i < NUM_DMA_LINKS; i++) {
85ef2375ef2ebb Timur Tabi        2009-02-05  460  		dma_private->link[i].next = cpu_to_be64(temp_link);
bf9c8c9ddef7ef Timur Tabi        2008-08-01  461  
bf9c8c9ddef7ef Timur Tabi        2008-08-01  462  		temp_link += sizeof(struct fsl_dma_link_descriptor);
17467f23395f05 Timur Tabi        2008-01-11  463  	}
bf9c8c9ddef7ef Timur Tabi        2008-08-01  464  	/* The last link descriptor points to the first */
bf9c8c9ddef7ef Timur Tabi        2008-08-01  465  	dma_private->link[i - 1].next = cpu_to_be64(dma_private->ld_buf_phys);
17467f23395f05 Timur Tabi        2008-01-11  466  
bf9c8c9ddef7ef Timur Tabi        2008-08-01  467  	/* Tell the DMA controller where the first link descriptor is */
bf9c8c9ddef7ef Timur Tabi        2008-08-01  468  	out_be32(&dma_channel->clndar,
bf9c8c9ddef7ef Timur Tabi        2008-08-01  469  		CCSR_DMA_CLNDAR_ADDR(dma_private->ld_buf_phys));
bf9c8c9ddef7ef Timur Tabi        2008-08-01  470  	out_be32(&dma_channel->eclndar,
bf9c8c9ddef7ef Timur Tabi        2008-08-01  471  		CCSR_DMA_ECLNDAR_ADDR(dma_private->ld_buf_phys));
bf9c8c9ddef7ef Timur Tabi        2008-08-01  472  
bf9c8c9ddef7ef Timur Tabi        2008-08-01  473  	/* The manual says the BCR must be clear before enabling EMP */
bf9c8c9ddef7ef Timur Tabi        2008-08-01  474  	out_be32(&dma_channel->bcr, 0);
bf9c8c9ddef7ef Timur Tabi        2008-08-01  475  
bf9c8c9ddef7ef Timur Tabi        2008-08-01  476  	/*
bf9c8c9ddef7ef Timur Tabi        2008-08-01  477  	 * Program the mode register for interrupts, external master control,
bf9c8c9ddef7ef Timur Tabi        2008-08-01  478  	 * and source/destination hold.  Also clear the Channel Abort bit.
bf9c8c9ddef7ef Timur Tabi        2008-08-01  479  	 */
bf9c8c9ddef7ef Timur Tabi        2008-08-01  480  	mr = in_be32(&dma_channel->mr) &
bf9c8c9ddef7ef Timur Tabi        2008-08-01  481  		~(CCSR_DMA_MR_CA | CCSR_DMA_MR_DAHE | CCSR_DMA_MR_SAHE);
bf9c8c9ddef7ef Timur Tabi        2008-08-01  482  
bf9c8c9ddef7ef Timur Tabi        2008-08-01  483  	/*
bf9c8c9ddef7ef Timur Tabi        2008-08-01  484  	 * We want External Master Start and External Master Pause enabled,
bf9c8c9ddef7ef Timur Tabi        2008-08-01  485  	 * because the SSI is controlling the DMA controller.  We want the DMA
bf9c8c9ddef7ef Timur Tabi        2008-08-01  486  	 * controller to be set up in advance, and then we signal only the SSI
bf9c8c9ddef7ef Timur Tabi        2008-08-01  487  	 * to start transferring.
17467f23395f05 Timur Tabi        2008-01-11  488  	 *
bf9c8c9ddef7ef Timur Tabi        2008-08-01  489  	 * We want End-Of-Segment Interrupts enabled, because this will generate
bf9c8c9ddef7ef Timur Tabi        2008-08-01  490  	 * an interrupt at the end of each segment (each link descriptor
bf9c8c9ddef7ef Timur Tabi        2008-08-01  491  	 * represents one segment).  Each DMA segment is the same thing as an
bf9c8c9ddef7ef Timur Tabi        2008-08-01  492  	 * ALSA period, so this is how we get an interrupt at the end of every
bf9c8c9ddef7ef Timur Tabi        2008-08-01  493  	 * period.
17467f23395f05 Timur Tabi        2008-01-11  494  	 *
bf9c8c9ddef7ef Timur Tabi        2008-08-01  495  	 * We want Error Interrupt enabled, so that we can get an error if
bf9c8c9ddef7ef Timur Tabi        2008-08-01  496  	 * the DMA controller is mis-programmed somehow.
bf9c8c9ddef7ef Timur Tabi        2008-08-01  497  	 */
bf9c8c9ddef7ef Timur Tabi        2008-08-01  498  	mr |= CCSR_DMA_MR_EOSIE | CCSR_DMA_MR_EIE | CCSR_DMA_MR_EMP_EN |
bf9c8c9ddef7ef Timur Tabi        2008-08-01  499  		CCSR_DMA_MR_EMS_EN;
bf9c8c9ddef7ef Timur Tabi        2008-08-01  500  
bf9c8c9ddef7ef Timur Tabi        2008-08-01  501  	/* For playback, we want the destination address to be held.  For
bf9c8c9ddef7ef Timur Tabi        2008-08-01  502  	   capture, set the source address to be held. */
bf9c8c9ddef7ef Timur Tabi        2008-08-01  503  	mr |= (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
bf9c8c9ddef7ef Timur Tabi        2008-08-01  504  		CCSR_DMA_MR_DAHE : CCSR_DMA_MR_SAHE;
bf9c8c9ddef7ef Timur Tabi        2008-08-01  505  
bf9c8c9ddef7ef Timur Tabi        2008-08-01  506  	out_be32(&dma_channel->mr, mr);
bf9c8c9ddef7ef Timur Tabi        2008-08-01  507  
bf9c8c9ddef7ef Timur Tabi        2008-08-01  508  	return 0;
bf9c8c9ddef7ef Timur Tabi        2008-08-01  509  }
bf9c8c9ddef7ef Timur Tabi        2008-08-01  510  

:::::: The code at line 284 was first introduced by commit
:::::: 17467f23395f05ba7b361f7b504fe0f1095d5bb7 [ALSA] Add ASoC drivers for the Freescale MPC8610 SoC

:::::: TO: Timur Tabi <timur@freescale.com>
:::::: CC: Jaroslav Kysela <perex@perex.cz>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
