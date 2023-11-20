Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AF57F169C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjKTPC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjKTPCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:02:24 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FA9A4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:02:15 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0CD5C24E23C;
        Mon, 20 Nov 2023 23:02:14 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Nov
 2023 23:02:14 +0800
Received: from [192.168.100.10] (161.142.156.101) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Nov
 2023 23:02:09 +0800
Message-ID: <3665caf1-d36a-40c8-9995-89d4064ac467@starfivetech.com>
Date:   Mon, 20 Nov 2023 23:02:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/char/hw_random/jh7110-trng.c:303 starfive_trng_probe()
 warn: passing zero to 'dev_err_probe'
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        <oe-kbuild@lists.linux.dev>
CC:     <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <e9e60d3b-77db-4b5d-ae63-b5454f61a59f@suswa.mountain>
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
In-Reply-To: <e9e60d3b-77db-4b5d-ae63-b5454f61a59f@suswa.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [161.142.156.101]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 10:22 pm, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
> commit: c388f458bc34eb3a5728b67f6614f9375cd99087 hwrng: starfive - Add TRNG driver for StarFive SoC
> config: riscv-randconfig-r071-20231112 (https://download.01.org/0day-ci/archive/20231116/202311160649.3GhKCfhd-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231116/202311160649.3GhKCfhd-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Closes: https://lore.kernel.org/r/202311160649.3GhKCfhd-lkp@intel.com/
> 
> smatch warnings:
> drivers/char/hw_random/jh7110-trng.c:303 starfive_trng_probe() warn: passing zero to 'dev_err_probe'
> 
> vim +/dev_err_probe +303 drivers/char/hw_random/jh7110-trng.c
> 
> c388f458bc34eb Jia Jie Ho 2023-01-17  274  static int starfive_trng_probe(struct platform_device *pdev)
> c388f458bc34eb Jia Jie Ho 2023-01-17  275  {
> c388f458bc34eb Jia Jie Ho 2023-01-17  276  	int ret;
> c388f458bc34eb Jia Jie Ho 2023-01-17  277  	int irq;
> c388f458bc34eb Jia Jie Ho 2023-01-17  278  	struct starfive_trng *trng;
> c388f458bc34eb Jia Jie Ho 2023-01-17  279  
> c388f458bc34eb Jia Jie Ho 2023-01-17  280  	trng = devm_kzalloc(&pdev->dev, sizeof(*trng), GFP_KERNEL);
> c388f458bc34eb Jia Jie Ho 2023-01-17  281  	if (!trng)
> c388f458bc34eb Jia Jie Ho 2023-01-17  282  		return -ENOMEM;
> c388f458bc34eb Jia Jie Ho 2023-01-17  283  
> c388f458bc34eb Jia Jie Ho 2023-01-17  284  	platform_set_drvdata(pdev, trng);
> c388f458bc34eb Jia Jie Ho 2023-01-17  285  	trng->dev = &pdev->dev;
> c388f458bc34eb Jia Jie Ho 2023-01-17  286  
> c388f458bc34eb Jia Jie Ho 2023-01-17  287  	trng->base = devm_platform_ioremap_resource(pdev, 0);
> c388f458bc34eb Jia Jie Ho 2023-01-17  288  	if (IS_ERR(trng->base))
> c388f458bc34eb Jia Jie Ho 2023-01-17  289  		return dev_err_probe(&pdev->dev, PTR_ERR(trng->base),
> c388f458bc34eb Jia Jie Ho 2023-01-17  290  				     "Error remapping memory for platform device.\n");
> c388f458bc34eb Jia Jie Ho 2023-01-17  291  
> c388f458bc34eb Jia Jie Ho 2023-01-17  292  	irq = platform_get_irq(pdev, 0);
> c388f458bc34eb Jia Jie Ho 2023-01-17  293  	if (irq < 0)
> c388f458bc34eb Jia Jie Ho 2023-01-17  294  		return irq;
> c388f458bc34eb Jia Jie Ho 2023-01-17  295  
> c388f458bc34eb Jia Jie Ho 2023-01-17  296  	init_completion(&trng->random_done);
> c388f458bc34eb Jia Jie Ho 2023-01-17  297  	init_completion(&trng->reseed_done);
> c388f458bc34eb Jia Jie Ho 2023-01-17  298  	spin_lock_init(&trng->write_lock);
> c388f458bc34eb Jia Jie Ho 2023-01-17  299  
> c388f458bc34eb Jia Jie Ho 2023-01-17  300  	ret = devm_request_irq(&pdev->dev, irq, starfive_trng_irq, 0, pdev->name,
> c388f458bc34eb Jia Jie Ho 2023-01-17  301  			       (void *)trng);
> c388f458bc34eb Jia Jie Ho 2023-01-17  302  	if (ret)
> c388f458bc34eb Jia Jie Ho 2023-01-17 @303  		return dev_err_probe(&pdev->dev, irq,
>                                                                                          ^^^
> Should be "ret".  Weird how we're getting this warning in November when
> the code is from Jan...  Looks like the bug is still their in linux-next
> though.
> 

I'll submit a patch for this.

Thanks,
Jia Jie

