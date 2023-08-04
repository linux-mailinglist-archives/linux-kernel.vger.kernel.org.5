Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA20770A03
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjHDUrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHDUrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:47:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C2F10CA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691182069; x=1722718069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nrb38CB1CxDtNRUV9CDVvs0KpO65X9nDYACTZ4KB2xA=;
  b=bska/+pVE4qBJTQ8VII5P6WlTQBCrUE28upi/BIgjMFRbfSC8ecH+QQ+
   Ja3GpbE/oNGMKXQJQ1aylD9G23E17OQ0+IC9uQfuksGjDZG/I+OHjZCLU
   +fhQoVXg3h2uChuq2YP7hwjpT7wLxDOkHTFCNwyt5E/TPq5WwfBIIjOva
   Pjq9+DAjL1Izx91KjJnXqpRs5hnwcStJw+l/KS381ZLmG+trU2mioTl1E
   vmgUXH+aOqKmRbGdZlwtxTVlpq5H3wC4h2OPkUz/ReFVm8AQ0VKSAD+B1
   wiBRnxs11NeXyl0UekqJDN7wHd/cmPOvBHNHu3wx1UMbEgE1GdV0F8LD1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="373897673"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="373897673"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 13:47:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="759708543"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="759708543"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2023 13:47:46 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qS1i5-000360-3C;
        Fri, 04 Aug 2023 20:47:45 +0000
Date:   Sat, 5 Aug 2023 04:46:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        loongarch@lists.linux.dev, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] LoongArch: Drop -ffreestanding from CFLAGS
Message-ID: <202308050433.0KAmYqQ2-lkp@intel.com>
References: <20230804125609.2054719-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804125609.2054719-1-kernel@xen0n.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi WANG,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5-rc4]
[cannot apply to next-20230804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/WANG-Xuerui/LoongArch-Drop-ffreestanding-from-CFLAGS/20230804-205642
base:   linus/master
patch link:    https://lore.kernel.org/r/20230804125609.2054719-1-kernel%40xen0n.name
patch subject: [PATCH] LoongArch: Drop -ffreestanding from CFLAGS
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20230805/202308050433.0KAmYqQ2-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230805/202308050433.0KAmYqQ2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308050433.0KAmYqQ2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/irqflags.h:18,
                    from include/linux/spinlock.h:59,
                    from include/linux/debugobjects.h:6,
                    from include/linux/timer.h:8,
                    from include/linux/workqueue.h:9,
                    from drivers/media/usb/em28xx/em28xx.h:21,
                    from drivers/media/usb/em28xx/em28xx-audio.c:14:
   arch/loongarch/include/asm/percpu.h:20:4: error: #error compiler support for the model attribute is necessary when a recent assembler is used
      20 | #  error compiler support for the model attribute is necessary when a recent assembler is used
         |    ^~~~~
   drivers/media/usb/em28xx/em28xx-audio.c: In function 'em28xx_audio_init':
>> drivers/media/usb/em28xx/em28xx-audio.c:808:29: warning: variable 'devnr' set but not used [-Wunused-but-set-variable]
     808 |         static int          devnr;
         |                             ^~~~~
   drivers/media/usb/em28xx/em28xx-audio.c: At top level:
   drivers/media/usb/em28xx/em28xx-audio.c:47:12: warning: 'index' defined but not used [-Wunused-variable]
      47 | static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
         |            ^~~~~


vim +/devnr +808 drivers/media/usb/em28xx/em28xx-audio.c

966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  801  
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  802  static int em28xx_audio_init(struct em28xx *dev)
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  803  {
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  804  	struct em28xx_audio *adev = &dev->adev;
c6d48134cb2682 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2016-12-07  805  	struct usb_device *udev = interface_to_usbdev(dev->intf);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  806  	struct snd_pcm      *pcm;
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  807  	struct snd_card     *card;
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12 @808  	static int          devnr;
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  809  	int		    err;
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  810  
c5874208ff78a5 drivers/media/usb/em28xx/em28xx-audio.c   Frank Schaefer        2014-09-13  811  	if (dev->usb_audio_type != EM28XX_USB_AUDIO_VENDOR) {
9f90f5371f52b4 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2018-03-03  812  		/*
9f90f5371f52b4 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2018-03-03  813  		 * This device does not support the extension (in this case
9f90f5371f52b4 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2018-03-03  814  		 * the device is expecting the snd-usb-audio module or
9f90f5371f52b4 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2018-03-03  815  		 * doesn't have analog audio support at all)
9f90f5371f52b4 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2018-03-03  816  		 */
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  817  		return 0;
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  818  	}
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  819  
29b05e22f5c68c drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2016-12-07  820  	dev_info(&dev->intf->dev, "Binding audio extension\n");
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  821  
47677e51e2a404 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-03-05  822  	kref_get(&dev->ref);
47677e51e2a404 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-03-05  823  
29b05e22f5c68c drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2016-12-07  824  	dev_info(&dev->intf->dev,
ce8591ff023ef8 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2016-10-20  825  		 "em28xx-audio.c: Copyright (C) 2006 Markus Rechberger\n");
29b05e22f5c68c drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2016-12-07  826  	dev_info(&dev->intf->dev,
ce8591ff023ef8 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2016-10-20  827  		 "em28xx-audio.c: Copyright (C) 2007-2016 Mauro Carvalho Chehab\n");
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  828  
29b05e22f5c68c drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2016-12-07  829  	err = snd_card_new(&dev->intf->dev, index[devnr], "Em28xx Audio",
e735688875208f drivers/media/usb/em28xx/em28xx-audio.c   Takashi Iwai          2014-01-29  830  			   THIS_MODULE, 0, &card);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  831  	if (err < 0)
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  832  		return err;
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  833  
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  834  	spin_lock_init(&adev->slock);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  835  	adev->sndcard = card;
c6d48134cb2682 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2016-12-07  836  	adev->udev = udev;
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  837  
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  838  	err = snd_pcm_new(card, "Em28xx Audio", 0, 0, 1, &pcm);
0cd03a0cb20c75 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  839  	if (err < 0)
0cd03a0cb20c75 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  840  		goto card_free;
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  841  
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  842  	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_em28xx_pcm_capture);
2abb1b2daf88ee drivers/media/usb/em28xx/em28xx-audio.c   Takashi Iwai          2019-12-10  843  	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_VMALLOC, NULL, 0, 0);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  844  	pcm->info_flags = 0;
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  845  	pcm->private_data = dev;
cc1e6315e83db0 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2018-09-10  846  	strscpy(pcm->name, "Empia 28xx Capture", sizeof(pcm->name));
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  847  
cc1e6315e83db0 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2018-09-10  848  	strscpy(card->driver, "Em28xx-Audio", sizeof(card->driver));
cc1e6315e83db0 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2018-09-10  849  	strscpy(card->shortname, "Em28xx Audio", sizeof(card->shortname));
cc1e6315e83db0 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2018-09-10  850  	strscpy(card->longname, "Empia Em28xx Audio", sizeof(card->longname));
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  851  
a5c075cfd2386a drivers/media/usb/em28xx/em28xx-audio.c   Frank Schaefer        2014-03-24  852  	INIT_WORK(&adev->wq_trigger, audio_trigger);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  853  
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  854  	if (dev->audio_mode.ac97 != EM28XX_NO_AC97) {
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  855  		em28xx_cvol_new(card, dev, "Video", AC97_VIDEO);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  856  		em28xx_cvol_new(card, dev, "Line In", AC97_LINE);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  857  		em28xx_cvol_new(card, dev, "Phone", AC97_PHONE);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  858  		em28xx_cvol_new(card, dev, "Microphone", AC97_MIC);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  859  		em28xx_cvol_new(card, dev, "CD", AC97_CD);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  860  		em28xx_cvol_new(card, dev, "AUX", AC97_AUX);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  861  		em28xx_cvol_new(card, dev, "PCM", AC97_PCM);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  862  
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  863  		em28xx_cvol_new(card, dev, "Master", AC97_MASTER);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  864  		em28xx_cvol_new(card, dev, "Line", AC97_HEADPHONE);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  865  		em28xx_cvol_new(card, dev, "Mono", AC97_MASTER_MONO);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  866  		em28xx_cvol_new(card, dev, "LFE", AC97_CENTER_LFE_MASTER);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  867  		em28xx_cvol_new(card, dev, "Surround", AC97_SURROUND_MASTER);
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  868  	}
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  869  
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  870  	err = em28xx_audio_urb_init(dev);
0cd03a0cb20c75 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  871  	if (err)
0cd03a0cb20c75 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  872  		goto card_free;
966f4163751b45 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  873  
6d79468dd85375 drivers/media/video/em28xx/em28xx-audio.c Mauro Carvalho Chehab 2008-01-05  874  	err = snd_card_register(card);
0cd03a0cb20c75 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  875  	if (err < 0)
0cd03a0cb20c75 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  876  		goto urb_free;
6d79468dd85375 drivers/media/video/em28xx/em28xx-audio.c Mauro Carvalho Chehab 2008-01-05  877  
29b05e22f5c68c drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2016-12-07  878  	dev_info(&dev->intf->dev, "Audio extension successfully initialized\n");
a52932b405f230 drivers/media/video/em28xx/em28xx-audio.c Markus Rechberger     2008-01-05  879  	return 0;
0cd03a0cb20c75 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  880  
0cd03a0cb20c75 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  881  urb_free:
0cd03a0cb20c75 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  882  	em28xx_audio_free_urb(dev);
0cd03a0cb20c75 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  883  
0cd03a0cb20c75 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  884  card_free:
0cd03a0cb20c75 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  885  	snd_card_free(card);
452f236fcf845b drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-14  886  	adev->sndcard = NULL;
0cd03a0cb20c75 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  887  
0cd03a0cb20c75 drivers/media/usb/em28xx/em28xx-audio.c   Mauro Carvalho Chehab 2014-01-12  888  	return err;
a52932b405f230 drivers/media/video/em28xx/em28xx-audio.c Markus Rechberger     2008-01-05  889  }
a52932b405f230 drivers/media/video/em28xx/em28xx-audio.c Markus Rechberger     2008-01-05  890  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
