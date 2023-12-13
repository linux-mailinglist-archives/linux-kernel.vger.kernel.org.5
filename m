Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A694810661
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378050AbjLMARE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377662AbjLMAQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:16:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0F71993
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702426576; x=1733962576;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cmbxdh1PuaLfIwQNFnpIPLJ6pReO1Ch91IWNw/orIFM=;
  b=PCBsWbnLdHcQ5T3LBVlI9Q/8ntTcZqwtt+3QeUF2Ky2pH4oVzb8KdmTJ
   IUAJD2rye76WCTCKTX/ofeIxgcFVENz0kJoZFcWCwyc+OC4EH7t7GsWaL
   9PsJNUFbON6Ctt8ccsytOd83CQrCkVIjbQwSFhpdysbLvmjrkfMzXmtA3
   SlPN3pI5d83jbEZFFNx6FjP0HycHCMUugJnyvFyCjH9YvgryWx7Rhq/bM
   ghxleqZVQz6IjxHskAt+7890eMu5040w3i/RtTb5C2M23W2gbqWWXoAF8
   nqE+t9Zqp+U4LacJwGum3syVReAaiqYPQGzhj2EizMxKS9vtdkgUu4LH+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1732344"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1732344"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 16:16:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="749892581"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="749892581"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Dec 2023 16:16:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDCv5-000Jsn-0v;
        Wed, 13 Dec 2023 00:16:11 +0000
Date:   Wed, 13 Dec 2023 08:15:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bhumika Goyal <bhumirks@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/fsl/p1022_rdk.c:191: warning: cannot understand function
 prototype: 'const struct snd_soc_ops p1022_rdk_ops = '
Message-ID: <202312130848.68KoHzAZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cf52eed70e555e864120cfaf280e979e2a035c66
commit: 5ace37bd7947e28dec5559a57ddc6e1d997dbec5 ASoC: fsl: constify snd_soc_ops structures
date:   7 years ago
config: powerpc-randconfig-r002-20230712 (https://download.01.org/0day-ci/archive/20231213/202312130848.68KoHzAZ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312130848.68KoHzAZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312130848.68KoHzAZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |                                       ^~~~
   sound/soc/fsl/p1022_rdk.c:62:9: note: in expansion of macro 'clrsetbits_be32'
      62 |         clrsetbits_be32(&guts->dmuxcr, 3 << shift, device << shift);
         |         ^~~~~~~~~~~~~~~
   sound/soc/fsl/p1022_rdk.c:62:25: warning: taking address of packed member of 'struct ccsr_guts' may result in an unaligned pointer value [-Waddress-of-packed-member]
      62 |         clrsetbits_be32(&guts->dmuxcr, 3 << shift, device << shift);
   arch/powerpc/include/asm/io.h:879:21: note: in definition of macro 'clrsetbits'
     879 |         out_##type((addr), (in_##type(addr) & ~(clear)) | (set))
         |                     ^~~~
   sound/soc/fsl/p1022_rdk.c:62:9: note: in expansion of macro 'clrsetbits_be32'
      62 |         clrsetbits_be32(&guts->dmuxcr, 3 << shift, device << shift);
         |         ^~~~~~~~~~~~~~~
   sound/soc/fsl/p1022_rdk.c: In function 'p1022_rdk_machine_probe':
   sound/soc/fsl/p1022_rdk.c:106:25: warning: taking address of packed member of 'struct ccsr_guts' may result in an unaligned pointer value [-Waddress-of-packed-member]
     106 |         clrsetbits_be32(&guts->pmuxcr, CCSR_GUTS_PMUXCR_UART0_I2C1_MASK,
         |                         ^~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:879:39: note: in definition of macro 'clrsetbits'
     879 |         out_##type((addr), (in_##type(addr) & ~(clear)) | (set))
         |                                       ^~~~
   sound/soc/fsl/p1022_rdk.c:106:9: note: in expansion of macro 'clrsetbits_be32'
     106 |         clrsetbits_be32(&guts->pmuxcr, CCSR_GUTS_PMUXCR_UART0_I2C1_MASK,
         |         ^~~~~~~~~~~~~~~
   sound/soc/fsl/p1022_rdk.c:106:25: warning: taking address of packed member of 'struct ccsr_guts' may result in an unaligned pointer value [-Waddress-of-packed-member]
     106 |         clrsetbits_be32(&guts->pmuxcr, CCSR_GUTS_PMUXCR_UART0_I2C1_MASK,
   arch/powerpc/include/asm/io.h:879:21: note: in definition of macro 'clrsetbits'
     879 |         out_##type((addr), (in_##type(addr) & ~(clear)) | (set))
         |                     ^~~~
   sound/soc/fsl/p1022_rdk.c:106:9: note: in expansion of macro 'clrsetbits_be32'
     106 |         clrsetbits_be32(&guts->pmuxcr, CCSR_GUTS_PMUXCR_UART0_I2C1_MASK,
         |         ^~~~~~~~~~~~~~~
   sound/soc/fsl/p1022_rdk.c:110:25: warning: taking address of packed member of 'struct ccsr_guts' may result in an unaligned pointer value [-Waddress-of-packed-member]
     110 |         clrsetbits_be32(&guts->pmuxcr, CCSR_GUTS_PMUXCR_SSI_DMA_TDM_MASK,
         |                         ^~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:879:39: note: in definition of macro 'clrsetbits'
     879 |         out_##type((addr), (in_##type(addr) & ~(clear)) | (set))
         |                                       ^~~~
   sound/soc/fsl/p1022_rdk.c:110:9: note: in expansion of macro 'clrsetbits_be32'
     110 |         clrsetbits_be32(&guts->pmuxcr, CCSR_GUTS_PMUXCR_SSI_DMA_TDM_MASK,
         |         ^~~~~~~~~~~~~~~
   sound/soc/fsl/p1022_rdk.c:110:25: warning: taking address of packed member of 'struct ccsr_guts' may result in an unaligned pointer value [-Waddress-of-packed-member]
     110 |         clrsetbits_be32(&guts->pmuxcr, CCSR_GUTS_PMUXCR_SSI_DMA_TDM_MASK,
   arch/powerpc/include/asm/io.h:879:21: note: in definition of macro 'clrsetbits'
     879 |         out_##type((addr), (in_##type(addr) & ~(clear)) | (set))
         |                     ^~~~
   sound/soc/fsl/p1022_rdk.c:110:9: note: in expansion of macro 'clrsetbits_be32'
     110 |         clrsetbits_be32(&guts->pmuxcr, CCSR_GUTS_PMUXCR_SSI_DMA_TDM_MASK,
         |         ^~~~~~~~~~~~~~~
   sound/soc/fsl/p1022_rdk.c: In function 'p1022_rdk_machine_remove':
   sound/soc/fsl/p1022_rdk.c:178:19: warning: taking address of packed member of 'struct ccsr_guts' may result in an unaligned pointer value [-Waddress-of-packed-member]
     178 |         clrbits32(&guts->pmuxcr, CCSR_GUTS_PMUXCR_UART0_I2C1_MASK);
         |                   ^~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:863:56: note: in definition of macro 'clrbits32'
     863 | #define clrbits32(_addr, _v) out_be32((_addr), in_be32(_addr) & ~(_v))
         |                                                        ^~~~~
   sound/soc/fsl/p1022_rdk.c:178:19: warning: taking address of packed member of 'struct ccsr_guts' may result in an unaligned pointer value [-Waddress-of-packed-member]
     178 |         clrbits32(&guts->pmuxcr, CCSR_GUTS_PMUXCR_UART0_I2C1_MASK);
   arch/powerpc/include/asm/io.h:863:40: note: in definition of macro 'clrbits32'
     863 | #define clrbits32(_addr, _v) out_be32((_addr), in_be32(_addr) & ~(_v))
         |                                        ^~~~~
   sound/soc/fsl/p1022_rdk.c:179:19: warning: taking address of packed member of 'struct ccsr_guts' may result in an unaligned pointer value [-Waddress-of-packed-member]
     179 |         clrbits32(&guts->pmuxcr, CCSR_GUTS_PMUXCR_SSI_DMA_TDM_MASK);
         |                   ^~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:863:56: note: in definition of macro 'clrbits32'
     863 | #define clrbits32(_addr, _v) out_be32((_addr), in_be32(_addr) & ~(_v))
         |                                                        ^~~~~
   sound/soc/fsl/p1022_rdk.c:179:19: warning: taking address of packed member of 'struct ccsr_guts' may result in an unaligned pointer value [-Waddress-of-packed-member]
     179 |         clrbits32(&guts->pmuxcr, CCSR_GUTS_PMUXCR_SSI_DMA_TDM_MASK);
   arch/powerpc/include/asm/io.h:863:40: note: in definition of macro 'clrbits32'
     863 | #define clrbits32(_addr, _v) out_be32((_addr), in_be32(_addr) & ~(_v))
         |                                        ^~~~~
   In file included from sound/soc/fsl/p1022_rdk.c:20:
   sound/soc/fsl/p1022_rdk.c: At top level:
   include/linux/module.h:131:13: warning: 'init_module' specifies less restrictive attribute than its target 'p1022_rdk_init': 'cold' [-Wmissing-attributes]
     131 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   include/linux/module.h:121:41: note: in expansion of macro 'module_init'
     121 | #define late_initcall(fn)               module_init(fn)
         |                                         ^~~~~~~~~~~
   sound/soc/fsl/p1022_rdk.c:386:1: note: in expansion of macro 'late_initcall'
     386 | late_initcall(p1022_rdk_init);
         | ^~~~~~~~~~~~~
   sound/soc/fsl/p1022_rdk.c:358:19: note: 'init_module' target declared here
     358 | static int __init p1022_rdk_init(void)
         |                   ^~~~~~~~~~~~~~
   In file included from sound/soc/fsl/p1022_rdk.c:20:
   include/linux/module.h:137:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'p1022_rdk_exit': 'cold' [-Wmissing-attributes]
     137 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   sound/soc/fsl/p1022_rdk.c:387:1: note: in expansion of macro 'module_exit'
     387 | module_exit(p1022_rdk_exit);
         | ^~~~~~~~~~~
   sound/soc/fsl/p1022_rdk.c:381:20: note: 'cleanup_module' target declared here
     381 | static void __exit p1022_rdk_exit(void)
         |                    ^~~~~~~~~~~~~~
   sound/soc/fsl/p1022_rdk.c:2: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Freescale P1022RDK ALSA SoC Machine driver
   sound/soc/fsl/p1022_rdk.c:74: warning: cannot understand function prototype: 'struct machine_data '
   sound/soc/fsl/p1022_rdk.c:94: warning: Function parameter or member 'card' not described in 'p1022_rdk_machine_probe'
   sound/soc/fsl/p1022_rdk.c:133: warning: Function parameter or member 'substream' not described in 'p1022_rdk_startup'
   sound/soc/fsl/p1022_rdk.c:166: warning: Function parameter or member 'card' not described in 'p1022_rdk_machine_remove'
>> sound/soc/fsl/p1022_rdk.c:191: warning: cannot understand function prototype: 'const struct snd_soc_ops p1022_rdk_ops = '
   sound/soc/fsl/p1022_rdk.c:203: warning: Function parameter or member 'pdev' not described in 'p1022_rdk_probe'
   sound/soc/fsl/p1022_rdk.c:330: warning: Function parameter or member 'pdev' not described in 'p1022_rdk_remove'


vim +191 sound/soc/fsl/p1022_rdk.c

   187	
   188	/**
   189	 * p1022_rdk_ops: ASoC machine driver operations
   190	 */
 > 191	static const struct snd_soc_ops p1022_rdk_ops = {
   192		.startup = p1022_rdk_startup,
   193	};
   194	
   195	/**
   196	 * p1022_rdk_probe: platform probe function for the machine driver
   197	 *
   198	 * Although this is a machine driver, the SSI node is the "master" node with
   199	 * respect to audio hardware connections.  Therefore, we create a new ASoC
   200	 * device for each new SSI node that has a codec attached.
   201	 */
   202	static int p1022_rdk_probe(struct platform_device *pdev)
   203	{
   204		struct device *dev = pdev->dev.parent;
   205		/* ssi_pdev is the platform device for the SSI node that probed us */
   206		struct platform_device *ssi_pdev = to_platform_device(dev);
   207		struct device_node *np = ssi_pdev->dev.of_node;
   208		struct device_node *codec_np = NULL;
   209		struct machine_data *mdata;
   210		const u32 *iprop;
   211		int ret;
   212	
   213		/* Find the codec node for this SSI. */
   214		codec_np = of_parse_phandle(np, "codec-handle", 0);
   215		if (!codec_np) {
   216			dev_err(dev, "could not find codec node\n");
   217			return -EINVAL;
   218		}
   219	
   220		mdata = kzalloc(sizeof(struct machine_data), GFP_KERNEL);
   221		if (!mdata) {
   222			ret = -ENOMEM;
   223			goto error_put;
   224		}
   225	
   226		mdata->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
   227		mdata->dai[0].ops = &p1022_rdk_ops;
   228	
   229		/* ASoC core can match codec with device node */
   230		mdata->dai[0].codec_of_node = codec_np;
   231	
   232		/*
   233		 * We register two DAIs per SSI, one for playback and the other for
   234		 * capture.  We support codecs that have separate DAIs for both playback
   235		 * and capture.
   236		 */
   237		memcpy(&mdata->dai[1], &mdata->dai[0], sizeof(struct snd_soc_dai_link));
   238	
   239		/* The DAI names from the codec (snd_soc_dai_driver.name) */
   240		mdata->dai[0].codec_dai_name = "wm8960-hifi";
   241		mdata->dai[1].codec_dai_name = mdata->dai[0].codec_dai_name;
   242	
   243		/*
   244		 * Configure the SSI for I2S slave mode.  Older device trees have
   245		 * an fsl,mode property, but we ignore that since there's really
   246		 * only one way to configure the SSI.
   247		 */
   248		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
   249			SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM;
   250		mdata->codec_clk_direction = SND_SOC_CLOCK_OUT;
   251		mdata->cpu_clk_direction = SND_SOC_CLOCK_IN;
   252	
   253		/*
   254		 * In i2s-slave mode, the codec has its own clock source, so we
   255		 * need to get the frequency from the device tree and pass it to
   256		 * the codec driver.
   257		 */
   258		iprop = of_get_property(codec_np, "clock-frequency", NULL);
   259		if (!iprop || !*iprop) {
   260			dev_err(&pdev->dev, "codec bus-frequency property is missing or invalid\n");
   261			ret = -EINVAL;
   262			goto error;
   263		}
   264		mdata->clk_frequency = be32_to_cpup(iprop);
   265	
   266		if (!mdata->clk_frequency) {
   267			dev_err(&pdev->dev, "unknown clock frequency\n");
   268			ret = -EINVAL;
   269			goto error;
   270		}
   271	
   272		/* Find the playback DMA channel to use. */
   273		mdata->dai[0].platform_name = mdata->platform_name[0];
   274		ret = fsl_asoc_get_dma_channel(np, "fsl,playback-dma", &mdata->dai[0],
   275					       &mdata->dma_channel_id[0],
   276					       &mdata->dma_id[0]);
   277		if (ret) {
   278			dev_err(&pdev->dev, "missing/invalid playback DMA phandle (ret=%i)\n",
   279				ret);
   280			goto error;
   281		}
   282	
   283		/* Find the capture DMA channel to use. */
   284		mdata->dai[1].platform_name = mdata->platform_name[1];
   285		ret = fsl_asoc_get_dma_channel(np, "fsl,capture-dma", &mdata->dai[1],
   286					       &mdata->dma_channel_id[1],
   287					       &mdata->dma_id[1]);
   288		if (ret) {
   289			dev_err(&pdev->dev, "missing/invalid capture DMA phandle (ret=%i)\n",
   290				ret);
   291			goto error;
   292		}
   293	
   294		/* Initialize our DAI data structure.  */
   295		mdata->dai[0].stream_name = "playback";
   296		mdata->dai[1].stream_name = "capture";
   297		mdata->dai[0].name = mdata->dai[0].stream_name;
   298		mdata->dai[1].name = mdata->dai[1].stream_name;
   299	
   300		mdata->card.probe = p1022_rdk_machine_probe;
   301		mdata->card.remove = p1022_rdk_machine_remove;
   302		mdata->card.name = pdev->name; /* The platform driver name */
   303		mdata->card.owner = THIS_MODULE;
   304		mdata->card.dev = &pdev->dev;
   305		mdata->card.num_links = 2;
   306		mdata->card.dai_link = mdata->dai;
   307	
   308		/* Register with ASoC */
   309		ret = snd_soc_register_card(&mdata->card);
   310		if (ret) {
   311			dev_err(&pdev->dev, "could not register card (ret=%i)\n", ret);
   312			goto error;
   313		}
   314	
   315		return 0;
   316	
   317	error:
   318		kfree(mdata);
   319	error_put:
   320		of_node_put(codec_np);
   321		return ret;
   322	}
   323	
   324	/**
   325	 * p1022_rdk_remove: remove the platform device
   326	 *
   327	 * This function is called when the platform device is removed.
   328	 */
   329	static int p1022_rdk_remove(struct platform_device *pdev)
   330	{
   331		struct snd_soc_card *card = platform_get_drvdata(pdev);
   332		struct machine_data *mdata =
   333			container_of(card, struct machine_data, card);
   334	
   335		snd_soc_unregister_card(card);
   336		kfree(mdata);
   337	
   338		return 0;
   339	}
   340	
   341	static struct platform_driver p1022_rdk_driver = {
   342		.probe = p1022_rdk_probe,
   343		.remove = p1022_rdk_remove,
   344		.driver = {
   345			/*
   346			 * The name must match 'compatible' property in the device tree,
   347			 * in lowercase letters.
   348			 */
   349			.name = "snd-soc-p1022rdk",
   350		},
   351	};
   352	
   353	/**
   354	 * p1022_rdk_init: machine driver initialization.
   355	 *
   356	 * This function is called when this module is loaded.
   357	 */
   358	static int __init p1022_rdk_init(void)
   359	{
   360		struct device_node *guts_np;
   361		struct resource res;
   362	
   363		/* Get the physical address of the global utilities registers */
   364		guts_np = of_find_compatible_node(NULL, NULL, "fsl,p1022-guts");
   365		if (of_address_to_resource(guts_np, 0, &res)) {
   366			pr_err("snd-soc-p1022rdk: missing/invalid global utils node\n");
   367			of_node_put(guts_np);
   368			return -EINVAL;
   369		}
   370		guts_phys = res.start;
   371		of_node_put(guts_np);
   372	
   373		return platform_driver_register(&p1022_rdk_driver);
   374	}
   375	
   376	/**
   377	 * p1022_rdk_exit: machine driver exit
   378	 *
   379	 * This function is called when this driver is unloaded.
   380	 */
 > 381	static void __exit p1022_rdk_exit(void)
   382	{
   383		platform_driver_unregister(&p1022_rdk_driver);
   384	}
   385	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
