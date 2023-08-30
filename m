Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCF078E309
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbjH3XIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344422AbjH3XHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:07:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487E8B8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693436854; x=1724972854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DM6+flIcD8OEGBYhKO07Kjcz9dVXaSyFaEs+hcpmUfs=;
  b=lDNphFkBAj/fEzKAG54Y5KJPZ8N3tpDpbdDoOFiHIS4Gl8dHBsFmCEcO
   D3badnUwX0j7QDg18gWGsznJ89JrpirLtJ7iP/B9RqKZt2hc/xU3A++sy
   Jo2NUcAQbToVH4+pwu8ZKFdABoDYHl61cxk3C8V2CIGm7zY1oaGw5r3LW
   YX5uAAGQw1w4BXIpESXhuJCCEcy3Qdos6Gh4iPq7YRHn1Eck9HRkLqC3t
   G3AroOM2AdPNupGgOCY5hRtzNifiwJTk8oZRC4S/pLNLMqTKQe3tltsaL
   fb84QlVYZbf/ykVC9UvHk78A8sLAZFjlixGylBknQ9Z7KLXbSgyBW+7pd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="360756523"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="360756523"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 16:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="985946655"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="985946655"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2023 16:07:29 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbUHY-000AJT-1V;
        Wed, 30 Aug 2023 23:07:28 +0000
Date:   Thu, 31 Aug 2023 07:06:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v4 10/11] ASoC: SOF: Intel: Move binding to display
 driver outside of deferred probe
Message-ID: <202308310618.kqqYvniK-lkp@intel.com>
References: <20230830153652.217855-11-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830153652.217855-11-maarten.lankhorst@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maarten,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on tiwai-sound/for-next tiwai-sound/for-linus linus/master next-20230830]
[cannot apply to v6.5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maarten-Lankhorst/ASoC-SOF-core-add-no_wq-probe-and-remove-callbacks/20230831-033512
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230830153652.217855-11-maarten.lankhorst%40linux.intel.com
patch subject: [PATCH v4 10/11] ASoC: SOF: Intel: Move binding to display driver outside of deferred probe
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230831/202308310618.kqqYvniK-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230831/202308310618.kqqYvniK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308310618.kqqYvniK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/soc/sof/intel/hda.c: In function 'hda_dsp_probe':
>> sound/soc/sof/intel/hda.c:1173:26: warning: variable 'bus' set but not used [-Wunused-but-set-variable]
    1173 |         struct hdac_bus *bus;
         |                          ^~~


vim +/bus +1173 sound/soc/sof/intel/hda.c

47f868f27a979a Pierre-Louis Bossart  2023-08-30  1168  
47f868f27a979a Pierre-Louis Bossart  2023-08-30  1169  int hda_dsp_probe(struct snd_sof_dev *sdev)
47f868f27a979a Pierre-Louis Bossart  2023-08-30  1170  {
47f868f27a979a Pierre-Louis Bossart  2023-08-30  1171  	struct pci_dev *pci = to_pci_dev(sdev->dev);
47f868f27a979a Pierre-Louis Bossart  2023-08-30  1172  	struct sof_intel_hda_dev *hdev = sdev->pdata->hw_pdata;
47f868f27a979a Pierre-Louis Bossart  2023-08-30 @1173  	struct hdac_bus *bus;
47f868f27a979a Pierre-Louis Bossart  2023-08-30  1174  	int ret = 0;
47f868f27a979a Pierre-Louis Bossart  2023-08-30  1175  
dd96daca6c83ec Liam Girdwood         2019-04-12  1176  	hdev->dmic_dev = platform_device_register_data(sdev->dev, "dmic-codec",
dd96daca6c83ec Liam Girdwood         2019-04-12  1177  						       PLATFORM_DEVID_NONE,
dd96daca6c83ec Liam Girdwood         2019-04-12  1178  						       NULL, 0);
dd96daca6c83ec Liam Girdwood         2019-04-12  1179  	if (IS_ERR(hdev->dmic_dev)) {
dd96daca6c83ec Liam Girdwood         2019-04-12  1180  		dev_err(sdev->dev, "error: failed to create DMIC device\n");
dd96daca6c83ec Liam Girdwood         2019-04-12  1181  		return PTR_ERR(hdev->dmic_dev);
dd96daca6c83ec Liam Girdwood         2019-04-12  1182  	}
dd96daca6c83ec Liam Girdwood         2019-04-12  1183  
dd96daca6c83ec Liam Girdwood         2019-04-12  1184  	/*
dd96daca6c83ec Liam Girdwood         2019-04-12  1185  	 * use position update IPC if either it is forced
dd96daca6c83ec Liam Girdwood         2019-04-12  1186  	 * or we don't have other choice
dd96daca6c83ec Liam Girdwood         2019-04-12  1187  	 */
dd96daca6c83ec Liam Girdwood         2019-04-12  1188  #if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_FORCE_IPC_POSITION)
dd96daca6c83ec Liam Girdwood         2019-04-12  1189  	hdev->no_ipc_position = 0;
dd96daca6c83ec Liam Girdwood         2019-04-12  1190  #else
dd96daca6c83ec Liam Girdwood         2019-04-12  1191  	hdev->no_ipc_position = sof_ops(sdev)->pcm_pointer ? 1 : 0;
dd96daca6c83ec Liam Girdwood         2019-04-12  1192  #endif
dd96daca6c83ec Liam Girdwood         2019-04-12  1193  
1f7b5d52be130e Peter Ujfalusi        2023-04-04  1194  	if (sdev->dspless_mode_selected)
1f7b5d52be130e Peter Ujfalusi        2023-04-04  1195  		hdev->no_ipc_position = 1;
1f7b5d52be130e Peter Ujfalusi        2023-04-04  1196  
dd96daca6c83ec Liam Girdwood         2019-04-12  1197  	/* set up HDA base */
dd96daca6c83ec Liam Girdwood         2019-04-12  1198  	bus = sof_to_bus(sdev);
dd96daca6c83ec Liam Girdwood         2019-04-12  1199  
9fc6786f549c4d Pierre-Louis Bossart  2023-04-04  1200  	if (sdev->dspless_mode_selected)
9fc6786f549c4d Pierre-Louis Bossart  2023-04-04  1201  		goto skip_dsp_setup;
9fc6786f549c4d Pierre-Louis Bossart  2023-04-04  1202  
dd96daca6c83ec Liam Girdwood         2019-04-12  1203  	/* DSP base */
dd96daca6c83ec Liam Girdwood         2019-04-12  1204  	sdev->bar[HDA_DSP_BAR] = pci_ioremap_bar(pci, HDA_DSP_BAR);
dd96daca6c83ec Liam Girdwood         2019-04-12  1205  	if (!sdev->bar[HDA_DSP_BAR]) {
dd96daca6c83ec Liam Girdwood         2019-04-12  1206  		dev_err(sdev->dev, "error: ioremap error\n");
dd96daca6c83ec Liam Girdwood         2019-04-12  1207  		ret = -ENXIO;
dd96daca6c83ec Liam Girdwood         2019-04-12  1208  		goto hdac_bus_unmap;
dd96daca6c83ec Liam Girdwood         2019-04-12  1209  	}
dd96daca6c83ec Liam Girdwood         2019-04-12  1210  
dd96daca6c83ec Liam Girdwood         2019-04-12  1211  	sdev->mmio_bar = HDA_DSP_BAR;
dd96daca6c83ec Liam Girdwood         2019-04-12  1212  	sdev->mailbox_bar = HDA_DSP_BAR;
9fc6786f549c4d Pierre-Louis Bossart  2023-04-04  1213  skip_dsp_setup:
dd96daca6c83ec Liam Girdwood         2019-04-12  1214  
dd96daca6c83ec Liam Girdwood         2019-04-12  1215  	/* allow 64bit DMA address if supported by H/W */
ab152afa2427bb Takashi Iwai          2021-01-14  1216  	if (dma_set_mask_and_coherent(&pci->dev, DMA_BIT_MASK(64))) {
dd96daca6c83ec Liam Girdwood         2019-04-12  1217  		dev_dbg(sdev->dev, "DMA mask is 32 bit\n");
ab152afa2427bb Takashi Iwai          2021-01-14  1218  		dma_set_mask_and_coherent(&pci->dev, DMA_BIT_MASK(32));
dd96daca6c83ec Liam Girdwood         2019-04-12  1219  	}
8872fc0d045929 Takashi Iwai          2022-02-15  1220  	dma_set_max_seg_size(&pci->dev, UINT_MAX);
dd96daca6c83ec Liam Girdwood         2019-04-12  1221  
dd96daca6c83ec Liam Girdwood         2019-04-12  1222  	/* init streams */
dd96daca6c83ec Liam Girdwood         2019-04-12  1223  	ret = hda_dsp_stream_init(sdev);
dd96daca6c83ec Liam Girdwood         2019-04-12  1224  	if (ret < 0) {
dd96daca6c83ec Liam Girdwood         2019-04-12  1225  		dev_err(sdev->dev, "error: failed to init streams\n");
dd96daca6c83ec Liam Girdwood         2019-04-12  1226  		/*
dd96daca6c83ec Liam Girdwood         2019-04-12  1227  		 * not all errors are due to memory issues, but trying
dd96daca6c83ec Liam Girdwood         2019-04-12  1228  		 * to free everything does not harm
dd96daca6c83ec Liam Girdwood         2019-04-12  1229  		 */
dd96daca6c83ec Liam Girdwood         2019-04-12  1230  		goto free_streams;
dd96daca6c83ec Liam Girdwood         2019-04-12  1231  	}
dd96daca6c83ec Liam Girdwood         2019-04-12  1232  
dd96daca6c83ec Liam Girdwood         2019-04-12  1233  	/*
dd96daca6c83ec Liam Girdwood         2019-04-12  1234  	 * register our IRQ
dd96daca6c83ec Liam Girdwood         2019-04-12  1235  	 * let's try to enable msi firstly
dd96daca6c83ec Liam Girdwood         2019-04-12  1236  	 * if it fails, use legacy interrupt mode
672ff5e3596ee2 Guennadi Liakhovetski 2019-07-22  1237  	 * TODO: support msi multiple vectors
dd96daca6c83ec Liam Girdwood         2019-04-12  1238  	 */
bb67dd1878de57 Pierre-Louis Bossart  2019-08-06  1239  	if (hda_use_msi && pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI) > 0) {
672ff5e3596ee2 Guennadi Liakhovetski 2019-07-22  1240  		dev_info(sdev->dev, "use msi interrupt mode\n");
7c11af9fcdc425 Bard Liao             2019-12-04  1241  		sdev->ipc_irq = pci_irq_vector(pci, 0);
672ff5e3596ee2 Guennadi Liakhovetski 2019-07-22  1242  		/* initialised to "false" by kzalloc() */
672ff5e3596ee2 Guennadi Liakhovetski 2019-07-22  1243  		sdev->msi_enabled = true;
672ff5e3596ee2 Guennadi Liakhovetski 2019-07-22  1244  	}
672ff5e3596ee2 Guennadi Liakhovetski 2019-07-22  1245  
672ff5e3596ee2 Guennadi Liakhovetski 2019-07-22  1246  	if (!sdev->msi_enabled) {
dd96daca6c83ec Liam Girdwood         2019-04-12  1247  		dev_info(sdev->dev, "use legacy interrupt mode\n");
dd96daca6c83ec Liam Girdwood         2019-04-12  1248  		/*
dd96daca6c83ec Liam Girdwood         2019-04-12  1249  		 * in IO-APIC mode, hda->irq and ipc_irq are using the same
dd96daca6c83ec Liam Girdwood         2019-04-12  1250  		 * irq number of pci->irq
dd96daca6c83ec Liam Girdwood         2019-04-12  1251  		 */
dd96daca6c83ec Liam Girdwood         2019-04-12  1252  		sdev->ipc_irq = pci->irq;
dd96daca6c83ec Liam Girdwood         2019-04-12  1253  	}
dd96daca6c83ec Liam Girdwood         2019-04-12  1254  
dd96daca6c83ec Liam Girdwood         2019-04-12  1255  	dev_dbg(sdev->dev, "using IPC IRQ %d\n", sdev->ipc_irq);
7c11af9fcdc425 Bard Liao             2019-12-04  1256  	ret = request_threaded_irq(sdev->ipc_irq, hda_dsp_interrupt_handler,
7c11af9fcdc425 Bard Liao             2019-12-04  1257  				   hda_dsp_interrupt_thread,
7c11af9fcdc425 Bard Liao             2019-12-04  1258  				   IRQF_SHARED, "AudioDSP", sdev);
dd96daca6c83ec Liam Girdwood         2019-04-12  1259  	if (ret < 0) {
dd96daca6c83ec Liam Girdwood         2019-04-12  1260  		dev_err(sdev->dev, "error: failed to register IPC IRQ %d\n",
dd96daca6c83ec Liam Girdwood         2019-04-12  1261  			sdev->ipc_irq);
7c11af9fcdc425 Bard Liao             2019-12-04  1262  		goto free_irq_vector;
dd96daca6c83ec Liam Girdwood         2019-04-12  1263  	}
dd96daca6c83ec Liam Girdwood         2019-04-12  1264  
dd96daca6c83ec Liam Girdwood         2019-04-12  1265  	pci_set_master(pci);
dd96daca6c83ec Liam Girdwood         2019-04-12  1266  	synchronize_irq(pci->irq);
dd96daca6c83ec Liam Girdwood         2019-04-12  1267  
dd96daca6c83ec Liam Girdwood         2019-04-12  1268  	/*
dd96daca6c83ec Liam Girdwood         2019-04-12  1269  	 * clear TCSEL to clear playback on some HD Audio
dd96daca6c83ec Liam Girdwood         2019-04-12  1270  	 * codecs. PCI TCSEL is defined in the Intel manuals.
dd96daca6c83ec Liam Girdwood         2019-04-12  1271  	 */
dd96daca6c83ec Liam Girdwood         2019-04-12  1272  	snd_sof_pci_update_bits(sdev, PCI_TCSEL, 0x07, 0);
dd96daca6c83ec Liam Girdwood         2019-04-12  1273  
dd96daca6c83ec Liam Girdwood         2019-04-12  1274  	/* init HDA capabilities */
dd96daca6c83ec Liam Girdwood         2019-04-12  1275  	ret = hda_init_caps(sdev);
dd96daca6c83ec Liam Girdwood         2019-04-12  1276  	if (ret < 0)
dd96daca6c83ec Liam Girdwood         2019-04-12  1277  		goto free_ipc_irq;
dd96daca6c83ec Liam Girdwood         2019-04-12  1278  
9fc6786f549c4d Pierre-Louis Bossart  2023-04-04  1279  	if (!sdev->dspless_mode_selected) {
1f5253b08e06bc Zhu Yingjiang         2019-05-22  1280  		/* enable ppcap interrupt */
1f5253b08e06bc Zhu Yingjiang         2019-05-22  1281  		hda_dsp_ctrl_ppcap_enable(sdev, true);
1f5253b08e06bc Zhu Yingjiang         2019-05-22  1282  		hda_dsp_ctrl_ppcap_int_enable(sdev, true);
dd96daca6c83ec Liam Girdwood         2019-04-12  1283  
dd96daca6c83ec Liam Girdwood         2019-04-12  1284  		/* set default mailbox offset for FW ready message */
dd96daca6c83ec Liam Girdwood         2019-04-12  1285  		sdev->dsp_box.offset = HDA_DSP_MBOX_UPLINK_OFFSET;
dd96daca6c83ec Liam Girdwood         2019-04-12  1286  
63e51fd33fef04 Ranjani Sridharan     2020-01-29  1287  		INIT_DELAYED_WORK(&hdev->d0i3_work, hda_dsp_d0i3_work);
9fc6786f549c4d Pierre-Louis Bossart  2023-04-04  1288  	}
63e51fd33fef04 Ranjani Sridharan     2020-01-29  1289  
e2379d4a83da44 Pierre-Louis Bossart  2022-09-20  1290  	init_waitqueue_head(&hdev->waitq);
e2379d4a83da44 Pierre-Louis Bossart  2022-09-20  1291  
95fa7a62e16463 Pierre-Louis Bossart  2022-04-21  1292  	hdev->nhlt = intel_nhlt_init(sdev->dev);
95fa7a62e16463 Pierre-Louis Bossart  2022-04-21  1293  
dd96daca6c83ec Liam Girdwood         2019-04-12  1294  	return 0;
dd96daca6c83ec Liam Girdwood         2019-04-12  1295  
dd96daca6c83ec Liam Girdwood         2019-04-12  1296  free_ipc_irq:
dd96daca6c83ec Liam Girdwood         2019-04-12  1297  	free_irq(sdev->ipc_irq, sdev);
dd96daca6c83ec Liam Girdwood         2019-04-12  1298  free_irq_vector:
dd96daca6c83ec Liam Girdwood         2019-04-12  1299  	if (sdev->msi_enabled)
dd96daca6c83ec Liam Girdwood         2019-04-12  1300  		pci_free_irq_vectors(pci);
dd96daca6c83ec Liam Girdwood         2019-04-12  1301  free_streams:
dd96daca6c83ec Liam Girdwood         2019-04-12  1302  	hda_dsp_stream_free(sdev);
dd96daca6c83ec Liam Girdwood         2019-04-12  1303  /* dsp_unmap: not currently used */
9fc6786f549c4d Pierre-Louis Bossart  2023-04-04  1304  	if (!sdev->dspless_mode_selected)
dd96daca6c83ec Liam Girdwood         2019-04-12  1305  		iounmap(sdev->bar[HDA_DSP_BAR]);
dd96daca6c83ec Liam Girdwood         2019-04-12  1306  hdac_bus_unmap:
5bb0ecddb2a7f6 Pierre-Louis Bossart  2021-03-01  1307  	platform_device_unregister(hdev->dmic_dev);
47f868f27a979a Pierre-Louis Bossart  2023-08-30  1308  
dd96daca6c83ec Liam Girdwood         2019-04-12  1309  	return ret;
dd96daca6c83ec Liam Girdwood         2019-04-12  1310  }
dd96daca6c83ec Liam Girdwood         2019-04-12  1311  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
