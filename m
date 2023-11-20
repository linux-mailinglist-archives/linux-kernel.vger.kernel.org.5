Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E187F1592
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjKTOWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjKTOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:22:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41280BC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:22:08 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32fb190bf9bso3298642f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700490127; x=1701094927; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZRoTaJ32o9tPRXkkVwVS9YWvdhMT3yvRyQ+4toqfvw=;
        b=UlEFQInu3rXWNjIi4tS3VTWiQz0ZBxO/oDNZ8qBOpurU3Q51qJEg+HzbIexfKioiha
         WXhPFo+lnwazhCOBBEf77HH24KFqD2ejU6neCd/gZKqVehabmwTvQW7p5M0DaTOPI7Ov
         rGVg67fMOXCrxs2YjuK8MryYHxfa/Ff5wi960aygDJV22YLsw6AsJtkMgFoPX4bBXIhj
         V6bxQWKVt8QTLR6eTVRDW1byaxtmbH53MSAQ+dzNxP8E9k1y0BkwlBl/Wdrah9xcU2IP
         prV2gg/AY5HHYFFx6g2mdyCAcFJvq2CS/LPHsK+e6oiPySmuaOsOUEX349VszeZdY7NS
         TFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700490127; x=1701094927;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZRoTaJ32o9tPRXkkVwVS9YWvdhMT3yvRyQ+4toqfvw=;
        b=Tg2JSfXSqqLYnGllBbVxpbnQdgXouTNlxSr8pmYcBpfp+ra+aHrSCWuhjXUHY99wNR
         EPpWnyhUPoevNvOuvUNGOAtx7gltTm4PR0NvkuXMN/jLQXBizks501rlRvwdmKZMj/L6
         gCK5BAWBkRnvSTj2nCu6KLkSBUEseho4Bw3utUY9Yh9vGB2yoJDNgKK5ef7/4gG4RsIU
         vl3GTVJCV9B6h2tIVHt+doJrha19PepVfK5/dAlQ1pkS1AK7/pqqmk1jxvC7ifiDLK94
         RoA/flM2MLfuK+2SQSbKpqd7OFzSWm1qG49O1I7s5hmyVkZnroKxPFAAkrAu+0FAoY/J
         HBag==
X-Gm-Message-State: AOJu0YyDrDnDkZ7A7+rNapONi7dd7wtCG3/gycyYOQ5e0JeC0WkjDnnx
        VIDH5hnGLlBgRfB1R7ocNOcgeg==
X-Google-Smtp-Source: AGHT+IFiA9HA9YGTYfmnRJC/OH9eFnvSMpMYsG1aOBeKPBbXmirgcRrKHviUUGkw4b9Eh2Ya3MfMqg==
X-Received: by 2002:a5d:47a6:0:b0:332:c65a:8f1e with SMTP id 6-20020a5d47a6000000b00332c65a8f1emr3774513wrb.19.1700490126592;
        Mon, 20 Nov 2023 06:22:06 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p11-20020adfcc8b000000b0032d9337e7d1sm11390181wrj.11.2023.11.20.06.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 06:22:06 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Mon, 20 Nov 2023 09:22:03 -0500
To:     oe-kbuild@lists.linux.dev, Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jenny Zhang <jenny.zhang@starfivetech.com>
Subject: drivers/char/hw_random/jh7110-trng.c:303 starfive_trng_probe() warn:
 passing zero to 'dev_err_probe'
Message-ID: <e9e60d3b-77db-4b5d-ae63-b5454f61a59f@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: c388f458bc34eb3a5728b67f6614f9375cd99087 hwrng: starfive - Add TRNG driver for StarFive SoC
config: riscv-randconfig-r071-20231112 (https://download.01.org/0day-ci/archive/20231116/202311160649.3GhKCfhd-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231116/202311160649.3GhKCfhd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311160649.3GhKCfhd-lkp@intel.com/

smatch warnings:
drivers/char/hw_random/jh7110-trng.c:303 starfive_trng_probe() warn: passing zero to 'dev_err_probe'

vim +/dev_err_probe +303 drivers/char/hw_random/jh7110-trng.c

c388f458bc34eb Jia Jie Ho 2023-01-17  274  static int starfive_trng_probe(struct platform_device *pdev)
c388f458bc34eb Jia Jie Ho 2023-01-17  275  {
c388f458bc34eb Jia Jie Ho 2023-01-17  276  	int ret;
c388f458bc34eb Jia Jie Ho 2023-01-17  277  	int irq;
c388f458bc34eb Jia Jie Ho 2023-01-17  278  	struct starfive_trng *trng;
c388f458bc34eb Jia Jie Ho 2023-01-17  279  
c388f458bc34eb Jia Jie Ho 2023-01-17  280  	trng = devm_kzalloc(&pdev->dev, sizeof(*trng), GFP_KERNEL);
c388f458bc34eb Jia Jie Ho 2023-01-17  281  	if (!trng)
c388f458bc34eb Jia Jie Ho 2023-01-17  282  		return -ENOMEM;
c388f458bc34eb Jia Jie Ho 2023-01-17  283  
c388f458bc34eb Jia Jie Ho 2023-01-17  284  	platform_set_drvdata(pdev, trng);
c388f458bc34eb Jia Jie Ho 2023-01-17  285  	trng->dev = &pdev->dev;
c388f458bc34eb Jia Jie Ho 2023-01-17  286  
c388f458bc34eb Jia Jie Ho 2023-01-17  287  	trng->base = devm_platform_ioremap_resource(pdev, 0);
c388f458bc34eb Jia Jie Ho 2023-01-17  288  	if (IS_ERR(trng->base))
c388f458bc34eb Jia Jie Ho 2023-01-17  289  		return dev_err_probe(&pdev->dev, PTR_ERR(trng->base),
c388f458bc34eb Jia Jie Ho 2023-01-17  290  				     "Error remapping memory for platform device.\n");
c388f458bc34eb Jia Jie Ho 2023-01-17  291  
c388f458bc34eb Jia Jie Ho 2023-01-17  292  	irq = platform_get_irq(pdev, 0);
c388f458bc34eb Jia Jie Ho 2023-01-17  293  	if (irq < 0)
c388f458bc34eb Jia Jie Ho 2023-01-17  294  		return irq;
c388f458bc34eb Jia Jie Ho 2023-01-17  295  
c388f458bc34eb Jia Jie Ho 2023-01-17  296  	init_completion(&trng->random_done);
c388f458bc34eb Jia Jie Ho 2023-01-17  297  	init_completion(&trng->reseed_done);
c388f458bc34eb Jia Jie Ho 2023-01-17  298  	spin_lock_init(&trng->write_lock);
c388f458bc34eb Jia Jie Ho 2023-01-17  299  
c388f458bc34eb Jia Jie Ho 2023-01-17  300  	ret = devm_request_irq(&pdev->dev, irq, starfive_trng_irq, 0, pdev->name,
c388f458bc34eb Jia Jie Ho 2023-01-17  301  			       (void *)trng);
c388f458bc34eb Jia Jie Ho 2023-01-17  302  	if (ret)
c388f458bc34eb Jia Jie Ho 2023-01-17 @303  		return dev_err_probe(&pdev->dev, irq,
                                                                                         ^^^
Should be "ret".  Weird how we're getting this warning in November when
the code is from Jan...  Looks like the bug is still their in linux-next
though.

c388f458bc34eb Jia Jie Ho 2023-01-17  304  				     "Failed to register interrupt handler\n");
c388f458bc34eb Jia Jie Ho 2023-01-17  305  
c388f458bc34eb Jia Jie Ho 2023-01-17  306  	trng->hclk = devm_clk_get(&pdev->dev, "hclk");
c388f458bc34eb Jia Jie Ho 2023-01-17  307  	if (IS_ERR(trng->hclk))
c388f458bc34eb Jia Jie Ho 2023-01-17  308  		return dev_err_probe(&pdev->dev, PTR_ERR(trng->hclk),
c388f458bc34eb Jia Jie Ho 2023-01-17  309  				     "Error getting hardware reference clock\n");
c388f458bc34eb Jia Jie Ho 2023-01-17  310  
c388f458bc34eb Jia Jie Ho 2023-01-17  311  	trng->ahb = devm_clk_get(&pdev->dev, "ahb");
c388f458bc34eb Jia Jie Ho 2023-01-17  312  	if (IS_ERR(trng->ahb))
c388f458bc34eb Jia Jie Ho 2023-01-17  313  		return dev_err_probe(&pdev->dev, PTR_ERR(trng->ahb),
c388f458bc34eb Jia Jie Ho 2023-01-17  314  				     "Error getting ahb reference clock\n");
c388f458bc34eb Jia Jie Ho 2023-01-17  315  
c388f458bc34eb Jia Jie Ho 2023-01-17  316  	trng->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
c388f458bc34eb Jia Jie Ho 2023-01-17  317  	if (IS_ERR(trng->rst))

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

