Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAA876F586
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjHCWP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjHCWPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:15:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F2A2130
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 15:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691100953; x=1722636953;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NbD7jIxZ6syhcmEyeRpAAkmzjdyogWp0Mmg1DvVQHh0=;
  b=AbSqgGiJpbqw100BLsoliLcIEqJiFoDpmPz3QC9Gkf/ZlDJ+iUcGU5Sh
   NroPZHuxb+9xKVyQNcFw3Sdvbzsw7PHWXjiTaQmaBdHjxr7m1Ak1jB4Cw
   ITdzhqDLZB2hulJGeLPxndEHYpQa9sXiTtvIclZUDOT6k2bo4OIWmRXgQ
   jGgyTfVlFClooaooPUM/dFCZRIyB8Zueyq2gMPVu65vzW7FL7Qp2beSwL
   uOHSmEX/FphFqSeyfbk7ZIcywNGvzy9SLZjanMN88Ed8Li3jQmlpyZ+9U
   kT2ckHzHXP3hQGw9kD7SJ+VmGPNcjJACRS7uHaop5omAyzlqmkxsMgNLm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="456381567"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="456381567"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 15:15:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="976295586"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="976295586"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2023 15:15:51 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRgbm-0002Oa-2f;
        Thu, 03 Aug 2023 22:15:50 +0000
Date:   Fri, 4 Aug 2023 06:15:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: sound/soc/pxa/pxa-ssp.c:594:15: warning: variable 'acds' set but not
 used
Message-ID: <202308040619.BEismjFv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   999f6631866e9ea81add935b9c6ebaab0579d259
commit: 7036440eab3e2d47a775d4616909f8235488d714 ARM: omap1: enable multiplatform
date:   1 year, 2 months ago
config: arm-randconfig-r024-20230804 (https://download.01.org/0day-ci/archive/20230804/202308040619.BEismjFv-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230804/202308040619.BEismjFv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308040619.BEismjFv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/pxa/pxa-ssp.c:594:15: warning: variable 'acds' set but not used [-Wunused-but-set-variable]
     594 |                         int ssacd, acds;
         |                                    ^
   1 warning generated.


vim +/acds +594 sound/soc/pxa/pxa-ssp.c

05739375f1c0a10 Daniel Mack     2018-06-29  526  
1b340bd7e444f20 Mark Brown      2008-07-30  527  /*
1b340bd7e444f20 Mark Brown      2008-07-30  528   * Set the SSP audio DMA parameters and sample size.
1b340bd7e444f20 Mark Brown      2008-07-30  529   * Can be called multiple times by oss emulation.
1b340bd7e444f20 Mark Brown      2008-07-30  530   */
1b340bd7e444f20 Mark Brown      2008-07-30  531  static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
dee89c4d9443352 Mark Brown      2008-11-18  532  				struct snd_pcm_hw_params *params,
f0fba2ad1b6b53d Liam Girdwood   2010-03-17  533  				struct snd_soc_dai *cpu_dai)
1b340bd7e444f20 Mark Brown      2008-07-30  534  {
f0fba2ad1b6b53d Liam Girdwood   2010-03-17  535  	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
f9efc9df94fd126 Eric Miao       2010-02-09  536  	struct ssp_device *ssp = priv->ssp;
2d7e71fa231035d Eric Miao       2009-04-23  537  	int chn = params_channels(params);
05739375f1c0a10 Daniel Mack     2018-06-29  538  	u32 sscr0, sspsp;
1b340bd7e444f20 Mark Brown      2008-07-30  539  	int width = snd_pcm_format_physical_width(params_format(params));
baffe1699c68da5 Haojian Zhuang  2010-05-05  540  	int ttsa = pxa_ssp_read_reg(ssp, SSTSA) & 0xf;
d65a14587a9be85 Daniel Mack     2013-08-12  541  	struct snd_dmaengine_dai_dma_data *dma_data;
05739375f1c0a10 Daniel Mack     2018-06-29  542  	int rate = params_rate(params);
05739375f1c0a10 Daniel Mack     2018-06-29  543  	int bclk = rate * chn * (width / 8);
737e370a57e4e83 Daniel Mack     2018-05-21  544  	int ret;
5f712b2b73a9fc8 Daniel Mack     2010-03-22  545  
f0fba2ad1b6b53d Liam Girdwood   2010-03-17  546  	dma_data = snd_soc_dai_get_dma_data(cpu_dai, substream);
1b340bd7e444f20 Mark Brown      2008-07-30  547  
92429069d0fc9f5 Philipp Zabel   2009-03-19  548  	/* Network mode with one active slot (ttsa == 1) can be used
92429069d0fc9f5 Philipp Zabel   2009-03-19  549  	 * to force 16-bit frame width on the wire (for S16_LE), even
92429069d0fc9f5 Philipp Zabel   2009-03-19  550  	 * with two channels. Use 16-bit DMA transfers for this case.
92429069d0fc9f5 Philipp Zabel   2009-03-19  551  	 */
d93ca1ae61adf67 guoyh           2012-05-07  552  	pxa_ssp_set_dma_params(ssp,
2d7e71fa231035d Eric Miao       2009-04-23  553  		((chn == 2) && (ttsa != 1)) || (width == 32),
d93ca1ae61adf67 guoyh           2012-05-07  554  		substream->stream == SNDRV_PCM_STREAM_PLAYBACK, dma_data);
5f712b2b73a9fc8 Daniel Mack     2010-03-22  555  
1b340bd7e444f20 Mark Brown      2008-07-30  556  	/* we can only change the settings if the port is not in use */
baffe1699c68da5 Haojian Zhuang  2010-05-05  557  	if (pxa_ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
1b340bd7e444f20 Mark Brown      2008-07-30  558  		return 0;
1b340bd7e444f20 Mark Brown      2008-07-30  559  
737e370a57e4e83 Daniel Mack     2018-05-21  560  	ret = pxa_ssp_configure_dai_fmt(priv);
737e370a57e4e83 Daniel Mack     2018-05-21  561  	if (ret < 0)
737e370a57e4e83 Daniel Mack     2018-05-21  562  		return ret;
737e370a57e4e83 Daniel Mack     2018-05-21  563  
1b340bd7e444f20 Mark Brown      2008-07-30  564  	/* clear selected SSP bits */
baffe1699c68da5 Haojian Zhuang  2010-05-05  565  	sscr0 = pxa_ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
1b340bd7e444f20 Mark Brown      2008-07-30  566  
1b340bd7e444f20 Mark Brown      2008-07-30  567  	/* bit size */
1b340bd7e444f20 Mark Brown      2008-07-30  568  	switch (params_format(params)) {
1b340bd7e444f20 Mark Brown      2008-07-30  569  	case SNDRV_PCM_FORMAT_S16_LE:
972a55b62d592cf Qiao Zhou       2012-06-04  570  		if (ssp->type == PXA3xx_SSP)
1b340bd7e444f20 Mark Brown      2008-07-30  571  			sscr0 |= SSCR0_FPCKE;
1b340bd7e444f20 Mark Brown      2008-07-30  572  		sscr0 |= SSCR0_DataSize(16);
1b340bd7e444f20 Mark Brown      2008-07-30  573  		break;
1b340bd7e444f20 Mark Brown      2008-07-30  574  	case SNDRV_PCM_FORMAT_S24_LE:
1b340bd7e444f20 Mark Brown      2008-07-30  575  		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(8));
1b340bd7e444f20 Mark Brown      2008-07-30  576  		break;
1b340bd7e444f20 Mark Brown      2008-07-30  577  	case SNDRV_PCM_FORMAT_S32_LE:
1b340bd7e444f20 Mark Brown      2008-07-30  578  		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(16));
1b340bd7e444f20 Mark Brown      2008-07-30  579  		break;
1b340bd7e444f20 Mark Brown      2008-07-30  580  	}
baffe1699c68da5 Haojian Zhuang  2010-05-05  581  	pxa_ssp_write_reg(ssp, SSCR0, sscr0);
1b340bd7e444f20 Mark Brown      2008-07-30  582  
05739375f1c0a10 Daniel Mack     2018-06-29  583  	if (sscr0 & SSCR0_ACS) {
05739375f1c0a10 Daniel Mack     2018-06-29  584  		ret = pxa_ssp_set_pll(priv, bclk);
05739375f1c0a10 Daniel Mack     2018-06-29  585  
05739375f1c0a10 Daniel Mack     2018-06-29  586  		/*
05739375f1c0a10 Daniel Mack     2018-06-29  587  		 * If we were able to generate the bclk directly,
05739375f1c0a10 Daniel Mack     2018-06-29  588  		 * all is fine. Otherwise, look up the closest rate
05739375f1c0a10 Daniel Mack     2018-06-29  589  		 * from the table and also set the dividers.
05739375f1c0a10 Daniel Mack     2018-06-29  590  		 */
05739375f1c0a10 Daniel Mack     2018-06-29  591  
05739375f1c0a10 Daniel Mack     2018-06-29  592  		if (ret < 0) {
05739375f1c0a10 Daniel Mack     2018-06-29  593  			const struct pxa_ssp_clock_mode *m;
05739375f1c0a10 Daniel Mack     2018-06-29 @594  			int ssacd, acds;
05739375f1c0a10 Daniel Mack     2018-06-29  595  
05739375f1c0a10 Daniel Mack     2018-06-29  596  			for (m = pxa_ssp_clock_modes; m->rate; m++) {
05739375f1c0a10 Daniel Mack     2018-06-29  597  				if (m->rate == rate)
05739375f1c0a10 Daniel Mack     2018-06-29  598  					break;
05739375f1c0a10 Daniel Mack     2018-06-29  599  			}
05739375f1c0a10 Daniel Mack     2018-06-29  600  
05739375f1c0a10 Daniel Mack     2018-06-29  601  			if (!m->rate)
05739375f1c0a10 Daniel Mack     2018-06-29  602  				return -EINVAL;
05739375f1c0a10 Daniel Mack     2018-06-29  603  
05739375f1c0a10 Daniel Mack     2018-06-29  604  			acds = m->acds;
05739375f1c0a10 Daniel Mack     2018-06-29  605  
05739375f1c0a10 Daniel Mack     2018-06-29  606  			/* The values in the table are for 16 bits */
05739375f1c0a10 Daniel Mack     2018-06-29  607  			if (width == 32)
05739375f1c0a10 Daniel Mack     2018-06-29  608  				acds--;
05739375f1c0a10 Daniel Mack     2018-06-29  609  
05739375f1c0a10 Daniel Mack     2018-06-29  610  			ret = pxa_ssp_set_pll(priv, bclk);
05739375f1c0a10 Daniel Mack     2018-06-29  611  			if (ret < 0)
05739375f1c0a10 Daniel Mack     2018-06-29  612  				return ret;
05739375f1c0a10 Daniel Mack     2018-06-29  613  
05739375f1c0a10 Daniel Mack     2018-06-29  614  			ssacd = pxa_ssp_read_reg(ssp, SSACD);
05739375f1c0a10 Daniel Mack     2018-06-29  615  			ssacd &= ~(SSACD_ACDS(7) | SSACD_SCDB_1X);
05739375f1c0a10 Daniel Mack     2018-06-29  616  			ssacd |= SSACD_ACDS(m->acds);
05739375f1c0a10 Daniel Mack     2018-06-29  617  			ssacd |= m->scdb;
05739375f1c0a10 Daniel Mack     2018-06-29  618  			pxa_ssp_write_reg(ssp, SSACD, ssacd);
05739375f1c0a10 Daniel Mack     2018-06-29  619  		}
05739375f1c0a10 Daniel Mack     2018-06-29  620  	} else if (sscr0 & SSCR0_ECS) {
05739375f1c0a10 Daniel Mack     2018-06-29  621  		/*
05739375f1c0a10 Daniel Mack     2018-06-29  622  		 * For setups with external clocking, the PLL and its diviers
05739375f1c0a10 Daniel Mack     2018-06-29  623  		 * are not active. Instead, the SCR bits in SSCR0 can be used
05739375f1c0a10 Daniel Mack     2018-06-29  624  		 * to divide the clock.
05739375f1c0a10 Daniel Mack     2018-06-29  625  		 */
05739375f1c0a10 Daniel Mack     2018-06-29  626  		pxa_ssp_set_scr(ssp, bclk / rate);
05739375f1c0a10 Daniel Mack     2018-06-29  627  	}
05739375f1c0a10 Daniel Mack     2018-06-29  628  
1b340bd7e444f20 Mark Brown      2008-07-30  629  	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
1b340bd7e444f20 Mark Brown      2008-07-30  630  	case SND_SOC_DAIFMT_I2S:
baffe1699c68da5 Haojian Zhuang  2010-05-05  631  	       sspsp = pxa_ssp_read_reg(ssp, SSPSP);
72d7466468b471f Daniel Mack     2009-03-12  632  
05739375f1c0a10 Daniel Mack     2018-06-29  633  		if (((priv->sysclk / bclk) == 64) && (width == 16)) {
72d7466468b471f Daniel Mack     2009-03-12  634  			/* This is a special case where the bitclk is 64fs
72d7466468b471f Daniel Mack     2009-03-12  635  			 * and we're not dealing with 2*32 bits of audio
72d7466468b471f Daniel Mack     2009-03-12  636  			 * samples.
72d7466468b471f Daniel Mack     2009-03-12  637  			 *
72d7466468b471f Daniel Mack     2009-03-12  638  			 * The SSP values used for that are all found out by
72d7466468b471f Daniel Mack     2009-03-12  639  			 * trying and failing a lot; some of the registers
72d7466468b471f Daniel Mack     2009-03-12  640  			 * needed for that mode are only available on PXA3xx.
72d7466468b471f Daniel Mack     2009-03-12  641  			 */
972a55b62d592cf Qiao Zhou       2012-06-04  642  			if (ssp->type != PXA3xx_SSP)
72d7466468b471f Daniel Mack     2009-03-12  643  				return -EINVAL;
72d7466468b471f Daniel Mack     2009-03-12  644  
72d7466468b471f Daniel Mack     2009-03-12  645  			sspsp |= SSPSP_SFRMWDTH(width * 2);
72d7466468b471f Daniel Mack     2009-03-12  646  			sspsp |= SSPSP_SFRMDLY(width * 4);
72d7466468b471f Daniel Mack     2009-03-12  647  			sspsp |= SSPSP_EDMYSTOP(3);
72d7466468b471f Daniel Mack     2009-03-12  648  			sspsp |= SSPSP_DMYSTOP(3);
72d7466468b471f Daniel Mack     2009-03-12  649  			sspsp |= SSPSP_DMYSTRT(1);
0ce36c5f7f87632 Mark Brown      2009-03-13  650  		} else {
0ce36c5f7f87632 Mark Brown      2009-03-13  651  			/* The frame width is the width the LRCLK is
0ce36c5f7f87632 Mark Brown      2009-03-13  652  			 * asserted for; the delay is expressed in
0ce36c5f7f87632 Mark Brown      2009-03-13  653  			 * half cycle units.  We need the extra cycle
0ce36c5f7f87632 Mark Brown      2009-03-13  654  			 * because the data starts clocking out one BCLK
0ce36c5f7f87632 Mark Brown      2009-03-13  655  			 * after LRCLK changes polarity.
0ce36c5f7f87632 Mark Brown      2009-03-13  656  			 */
0ce36c5f7f87632 Mark Brown      2009-03-13  657  			sspsp |= SSPSP_SFRMWDTH(width + 1);
0ce36c5f7f87632 Mark Brown      2009-03-13  658  			sspsp |= SSPSP_SFRMDLY((width + 1) * 2);
0ce36c5f7f87632 Mark Brown      2009-03-13  659  			sspsp |= SSPSP_DMYSTRT(1);
0ce36c5f7f87632 Mark Brown      2009-03-13  660  		}
72d7466468b471f Daniel Mack     2009-03-12  661  
baffe1699c68da5 Haojian Zhuang  2010-05-05  662  		pxa_ssp_write_reg(ssp, SSPSP, sspsp);
1b340bd7e444f20 Mark Brown      2008-07-30  663  		break;
1b340bd7e444f20 Mark Brown      2008-07-30  664  	default:
1b340bd7e444f20 Mark Brown      2008-07-30  665  		break;
1b340bd7e444f20 Mark Brown      2008-07-30  666  	}
1b340bd7e444f20 Mark Brown      2008-07-30  667  
72d7466468b471f Daniel Mack     2009-03-12  668  	/* When we use a network mode, we always require TDM slots
1b340bd7e444f20 Mark Brown      2008-07-30  669  	 * - complain loudly and fail if they've not been set up yet.
1b340bd7e444f20 Mark Brown      2008-07-30  670  	 */
92429069d0fc9f5 Philipp Zabel   2009-03-19  671  	if ((sscr0 & SSCR0_MOD) && !ttsa) {
4f3d957718e7f0a Andy Shevchenko 2019-10-18  672  		dev_err(ssp->dev, "No TDM timeslot configured\n");
1b340bd7e444f20 Mark Brown      2008-07-30  673  		return -EINVAL;
1b340bd7e444f20 Mark Brown      2008-07-30  674  	}
1b340bd7e444f20 Mark Brown      2008-07-30  675  
1b340bd7e444f20 Mark Brown      2008-07-30  676  	dump_registers(ssp);
1b340bd7e444f20 Mark Brown      2008-07-30  677  
1b340bd7e444f20 Mark Brown      2008-07-30  678  	return 0;
1b340bd7e444f20 Mark Brown      2008-07-30  679  }
1b340bd7e444f20 Mark Brown      2008-07-30  680  

:::::: The code at line 594 was first introduced by commit
:::::: 05739375f1c0a1048fea8b9c4cb54d9e4a891938 ASoC: pxa-ssp: remove .set_pll() and .set_clkdiv() callbacks

:::::: TO: Daniel Mack <daniel@zonque.org>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
