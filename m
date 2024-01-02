Return-Path: <linux-kernel+bounces-14462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAE7821D4E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9CC1C22319
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DF514F98;
	Tue,  2 Jan 2024 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l/4jVEO2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880114AB9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d87df95ddso16475795e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704204230; x=1704809030; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mn8Nmeay0/jGyeSq5GijpA2IQ6OcRPPMm0Y4xiMdIGo=;
        b=l/4jVEO281lC+gDSyEu1hGTgZMEcHCO5Od82v2hB+hRk3sqHZdX+cEc1t5qau7o5YG
         iGxDfe7JqBu9VmV/pp7Iay+wsjOGf9BK6c7yKnnW61B+lAb8YIgl75/c8yWMpjC+I+mX
         CqMyGGuDvnXdbzTUlhYMk5FrGzNoq3Pt5kZWXznXajmEIADaBptLji9yWk9sjOaTlTlQ
         Lf18O7zj4R5NNp8AYkZXlizsVIKuGKDXMPb04ZA6MCCh7Rk3ur14hn2NVghvN2cIlLJ6
         BbrMhqRREzfJSU3Ukoed1yo8xq+8v90IfHupWnZCS9tT+eMt+yxG/6URwRRs+b8xo3yN
         aD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204230; x=1704809030;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mn8Nmeay0/jGyeSq5GijpA2IQ6OcRPPMm0Y4xiMdIGo=;
        b=OIaSoW9P8P4aRia5YKk5mtqcz/UaPWdh3crMQWhqiC96wcdjV1yfJFIeZblcIlyztu
         tGGgv4qD3uQeYOjlyV1P6bnUfYQL/xNqnsUDubUg0i5BR7YZRpRkto7+GUXKTB/ka+lL
         jm1RBZdXVzNd38JyOQavwkinwKB21V6SKfK4l1EpubEGG63g5BiEDckGpRKn5c8WHYpL
         geM+Sdt+/joMdsNKP9rUh36/BmzJslOcXVEhM5RfJJgWKZqggCah4x1CH6DGf7SPQ7Af
         EeSM+GF4CSf1ZOSgdBCppfv2SnusuLnO/cAfd3PCR6y3ewPJwiVK+Jd2GZXgB7PN4CrE
         QmKg==
X-Gm-Message-State: AOJu0YyliSgX74gd456FGxYi0sXdgXCLuidYE1ZH7YKCGF14ssO+BPAx
	bnZP6L+20QiYLGaqhg+D58Z8dhdqeN3ByQ==
X-Google-Smtp-Source: AGHT+IGBU0HymLDGU6oQjodCQvSQHSTYHJjjoieFLsXS2/qf7fhxN+rfZ391sZJ/PVpM2aHLTqoE1A==
X-Received: by 2002:a7b:cbd9:0:b0:40d:5c45:5379 with SMTP id n25-20020a7bcbd9000000b0040d5c455379mr2851104wmi.97.1704204229993;
        Tue, 02 Jan 2024 06:03:49 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id dr15-20020a5d5f8f000000b003373ece28efsm6089374wrb.29.2024.01.02.06.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:03:49 -0800 (PST)
Date: Tue, 2 Jan 2024 16:56:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>
Subject: drivers/phy/renesas/phy-rcar-gen3-usb2.c:747
 rcar_gen3_phy_usb2_probe() warn: missing error code 'ret'
Message-ID: <8b1bc7f4-f83f-413d-9fa9-3ee68577750d@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3bd7d748816927202268cb335921f7f68b3ca723
commit: 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1 riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
config: riscv-randconfig-r081-20231216 (https://download.01.org/0day-ci/archive/20231216/202312161021.gOLDl48K-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312161021.gOLDl48K-lkp@intel.com/

smatch warnings:
drivers/phy/renesas/phy-rcar-gen3-usb2.c:747 rcar_gen3_phy_usb2_probe() warn: missing error code 'ret'

vim +/ret +747 drivers/phy/renesas/phy-rcar-gen3-usb2.c

f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  652  static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  653  {
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  654  	const struct rcar_gen3_phy_drv_data *phy_data;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  655  	struct device *dev = &pdev->dev;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  656  	struct rcar_gen3_chan *channel;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  657  	struct phy_provider *provider;
08b0ad375ca661 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2020-07-17  658  	int ret = 0, i;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  659  
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  660  	if (!dev->of_node) {
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  661  		dev_err(dev, "This driver needs device tree\n");
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  662  		return -EINVAL;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  663  	}
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  664  
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  665  	channel = devm_kzalloc(dev, sizeof(*channel), GFP_KERNEL);
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  666  	if (!channel)
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  667  		return -ENOMEM;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  668  
0b5604affbec02 drivers/phy/renesas/phy-rcar-gen3-usb2.c Chunfeng Yun      2020-11-06  669  	channel->base = devm_platform_ioremap_resource(pdev, 0);
801a69c787812f drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-03-03  670  	if (IS_ERR(channel->base))
801a69c787812f drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-03-03  671  		return PTR_ERR(channel->base);
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  672  
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  673  	channel->obint_enable_bits = USB2_OBINT_BITS;
08b0ad375ca661 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2020-07-17  674  	/* get irq number here and request_irq for OTG in phy_init */
08b0ad375ca661 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2020-07-17  675  	channel->irq = platform_get_irq_optional(pdev, 0);
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  676  	channel->dr_mode = rcar_gen3_get_dr_mode(dev->of_node);
73801b90a38ff1 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2018-09-21  677  	if (channel->dr_mode != USB_DR_MODE_UNKNOWN) {
7e0540f41332cb drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2017-10-12  678  		int ret;

I would delete this "ret" declaration.

7e0540f41332cb drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2017-10-12  679  
979b519c7a1bff drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2018-09-21  680  		channel->is_otg_channel = true;
8dde0008ffc9e2 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2018-09-21  681  		channel->uses_otg_pins = !of_property_read_bool(dev->of_node,
8dde0008ffc9e2 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2018-09-21  682  							"renesas,no-otg-pins");
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  683  		channel->extcon = devm_extcon_dev_allocate(dev,
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  684  							rcar_gen3_phy_cable);
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  685  		if (IS_ERR(channel->extcon))
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  686  			return PTR_ERR(channel->extcon);
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  687  
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  688  		ret = devm_extcon_dev_register(dev, channel->extcon);
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  689  		if (ret < 0) {
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  690  			dev_err(dev, "Failed to register extcon\n");
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  691  			return ret;
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  692  		}
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  693  	}
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  694  
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  695  	/*
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  696  	 * devm_phy_create() will call pm_runtime_enable(&phy->dev);
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  697  	 * And then, phy-core will manage runtime pm for this device.
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  698  	 */
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  699  	pm_runtime_enable(dev);
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  700  
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  701  	phy_data = of_device_get_match_data(dev);
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  702  	if (!phy_data) {
51e339deab1e51 drivers/phy/renesas/phy-rcar-gen3-usb2.c Wang Li           2020-11-26  703  		ret = -EINVAL;
51e339deab1e51 drivers/phy/renesas/phy-rcar-gen3-usb2.c Wang Li           2020-11-26  704  		goto error;
51e339deab1e51 drivers/phy/renesas/phy-rcar-gen3-usb2.c Wang Li           2020-11-26  705  	}
5d8042e95fd471 drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2019-04-10  706  
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  707  	channel->soc_no_adp_ctrl = phy_data->no_adp_ctrl;
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  708  	if (phy_data->no_adp_ctrl)
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  709  		channel->obint_enable_bits = USB2_OBINT_IDCHG_EN;
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  710  
5c9dc6379f539c drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-06-10  711  	mutex_init(&channel->lock);
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  712  	for (i = 0; i < NUM_OF_PHYS; i++) {
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  713  		channel->rphys[i].phy = devm_phy_create(dev, NULL,
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  714  							phy_data->phy_usb2_ops);
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  715  		if (IS_ERR(channel->rphys[i].phy)) {
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  716  			dev_err(dev, "Failed to create USB2 PHY\n");
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  717  			ret = PTR_ERR(channel->rphys[i].phy);
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  718  			goto error;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  719  		}
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  720  		channel->rphys[i].ch = channel;
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  721  		channel->rphys[i].int_enable_bits = rcar_gen3_int_enable[i];
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  722  		phy_set_drvdata(channel->rphys[i].phy, &channel->rphys[i]);
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  723  	}
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  724  
6dcfd7c300bf35 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-03-03  725  	channel->vbus = devm_regulator_get_optional(dev, "vbus");
6dcfd7c300bf35 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-03-03  726  	if (IS_ERR(channel->vbus)) {
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  727  		if (PTR_ERR(channel->vbus) == -EPROBE_DEFER) {
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  728  			ret = PTR_ERR(channel->vbus);
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  729  			goto error;
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  730  		}
6dcfd7c300bf35 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-03-03  731  		channel->vbus = NULL;
6dcfd7c300bf35 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-03-03  732  	}
6dcfd7c300bf35 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-03-03  733  
9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-11-09  734  	platform_set_drvdata(pdev, channel);
92fec1c27caa7b drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  735  	channel->dev = dev;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  736  
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  737  	provider = devm_of_phy_provider_register(dev, rcar_gen3_phy_usb2_xlate);
9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-11-09  738  	if (IS_ERR(provider)) {
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  739  		dev_err(dev, "Failed to register PHY provider\n");
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  740  		ret = PTR_ERR(provider);
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  741  		goto error;
979b519c7a1bff drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2018-09-21  742  	} else if (channel->is_otg_channel) {
9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-11-09  743  		int ret;

Shadow ret declaration.

9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-11-09  744  
9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-11-09  745  		ret = device_create_file(dev, &dev_attr_role);
9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-11-09  746  		if (ret < 0)

The "ret" here is the shadow ret so we end up returning success.

441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14 @747  			goto error;
9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-11-09  748  	}
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  749  
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  750  	return 0;
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  751  
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  752  error:
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  753  	pm_runtime_disable(dev);
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  754  
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  755  	return ret;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  756  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


