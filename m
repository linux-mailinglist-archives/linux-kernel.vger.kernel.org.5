Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F44B808041
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjLGFlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGFlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:41:08 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3980DE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:41:13 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c08af319cso6628305e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 21:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701927672; x=1702532472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q7rmf1L5KTUW/E5oPwtLwfXb9Vg7b5uQANioC1qAwJQ=;
        b=yvFYhZ3h3kduYkHFrNRswyP67vA1J2b5kNkgT066XKxKEAAC2rZmn3XiJSTqF4CnS7
         JTxLrgxyCQKzOxl/3WER1ksaXSvrOFmvVdImXwUC8oR2aLv86L4NmzYhsVbKEsj92HBN
         QAMOzZR6cRDxt/3bhJra3YEGSKWr/iMKKySetRcB6CXlYlt24W4hb5wMUhNP+KOh/8r8
         aFEAZLjEdBwHyq6VY4n6zm2sCX0wVeorHBA5DcQgao3qxN4gOUi8vEsYFPDice6Qzx5l
         +Dicz5DFwd03ofchTnkbD5WEaoRw2GKNxH4596E9hTxHnVR2II6pQZSGwpkG0o0GiyED
         Gyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701927672; x=1702532472;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7rmf1L5KTUW/E5oPwtLwfXb9Vg7b5uQANioC1qAwJQ=;
        b=Zjr49P6CnCJAfy88s97ueLv+Qlc4LS5hUXrH5+xkbG1n0ZojsYdDnRMf8e0Y51MEkY
         ve5LCb24dbKbIPWuRgxUTillCrhpXvjay0AazfwpGyCApiH1di6u/iwecg3FzZW94ZiD
         TBvOfWOce9Emek+XCEIqItc5YG6wbvwh5XdN62EgwBBzuCbEXFwcHnTUaLsGIt/2LUpK
         /3k2tfiSgYwn6iivQA4cXh+0GZiI95h3YFgORYWaZjejzCoTa3aTwIGkSB2GMbeQ/NvD
         mnnXDtUkgrYGZKj5dHnbDsKWFiEP3EXx+fuOEWI4M6naeZ63peMP8m6UrgKChwvPpvd3
         NZkA==
X-Gm-Message-State: AOJu0YxJvpaqexVvIdOXDiuD+uoD3qyOHb80V1G+km84eInj6NJYVpt0
        Oh4V6SW+ODIt/+zapqXQGPkEAA==
X-Google-Smtp-Source: AGHT+IFcYPRJ0wHa3HawHgZzyaOQdVMjkxX4/+Q/hkkoscjHk6GLpxarpmJZAW4lnnUanfaDDUCLLg==
X-Received: by 2002:a7b:cb95:0:b0:40b:5e59:ea01 with SMTP id m21-20020a7bcb95000000b0040b5e59ea01mr1260067wmi.160.1701927672414;
        Wed, 06 Dec 2023 21:41:12 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b00405442edc69sm702928wmb.14.2023.12.06.21.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 21:41:12 -0800 (PST)
Date:   Thu, 7 Dec 2023 08:41:09 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, baneric926@gmail.com, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org, kwliu@nuvoton.com, kcfeng0@nuvoton.com,
        DELPHINE_CHIU@wiwynn.com, Bonnie_Lo@wiwynn.com
Subject: Re: [PATCH v1 2/2] hwmon: Driver for Nuvoton NCT736X
Message-ID: <a62c8f0f-db3d-41da-b2a8-a064f0feba32@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204055650.788388-3-kcfeng0@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/baneric926-gmail-com/dt-bindings-hwmon-Add-nct736x-bindings/20231204-135942
base:   linus/master
patch link:    https://lore.kernel.org/r/20231204055650.788388-3-kcfeng0%40nuvoton.com
patch subject: [PATCH v1 2/2] hwmon: Driver for Nuvoton NCT736X
config: m68k-randconfig-r071-20231207 (https://download.01.org/0day-ci/archive/20231207/202312071152.Kfcw1KlD-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231207/202312071152.Kfcw1KlD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312071152.Kfcw1KlD-lkp@intel.com/

smatch warnings:
drivers/hwmon/nct736x.c:367 nct736x_init_chip() error: uninitialized symbol 'gpio0_3'.
drivers/hwmon/nct736x.c:370 nct736x_init_chip() error: uninitialized symbol 'gpio4_7'.
drivers/hwmon/nct736x.c:373 nct736x_init_chip() error: uninitialized symbol 'gpio10_13'.
drivers/hwmon/nct736x.c:376 nct736x_init_chip() error: uninitialized symbol 'gpio14_17'.

vim +/gpio0_3 +367 drivers/hwmon/nct736x.c

16e62bcf3c9b93 Ban Feng 2023-12-04  335  static int nct736x_init_chip(struct i2c_client *client,
16e62bcf3c9b93 Ban Feng 2023-12-04  336  			     u32 pwm_mask, u32 fanin_mask, u32 wdt_cfg)
16e62bcf3c9b93 Ban Feng 2023-12-04  337  {
16e62bcf3c9b93 Ban Feng 2023-12-04  338  	const struct i2c_device_id *id = i2c_match_id(nct736x_id, client);
16e62bcf3c9b93 Ban Feng 2023-12-04  339  	u8 i, gpio0_3, gpio4_7, gpio10_13, gpio14_17;
16e62bcf3c9b93 Ban Feng 2023-12-04  340  	int ret;
16e62bcf3c9b93 Ban Feng 2023-12-04  341  
16e62bcf3c9b93 Ban Feng 2023-12-04  342  	for (i = 0; i < NCT736X_PWM_COUNT; i++) {
16e62bcf3c9b93 Ban Feng 2023-12-04  343  		if (i < 4) {
16e62bcf3c9b93 Ban Feng 2023-12-04  344  			if (pwm_mask & BIT_CHECK(i))
16e62bcf3c9b93 Ban Feng 2023-12-04  345  				gpio0_3 |= PWM_SEL(i);

This doesn't work.  gpio0_3 needs to be initialized to zero before we
can turn on individual bits.

16e62bcf3c9b93 Ban Feng 2023-12-04  346  			if (fanin_mask & BIT_CHECK(i))
16e62bcf3c9b93 Ban Feng 2023-12-04  347  				gpio10_13 |= FANIN_SEL(i);

Etc...

16e62bcf3c9b93 Ban Feng 2023-12-04  348  		} else if (i < 8) {
16e62bcf3c9b93 Ban Feng 2023-12-04  349  			if (pwm_mask & BIT_CHECK(i))
16e62bcf3c9b93 Ban Feng 2023-12-04  350  				gpio4_7 |= PWM_SEL(i);
16e62bcf3c9b93 Ban Feng 2023-12-04  351  			if (fanin_mask & BIT_CHECK(i))
16e62bcf3c9b93 Ban Feng 2023-12-04  352  				gpio14_17 |= FANIN_SEL(i);
16e62bcf3c9b93 Ban Feng 2023-12-04  353  		} else if (i < 12) {
16e62bcf3c9b93 Ban Feng 2023-12-04  354  			if (pwm_mask & BIT_CHECK(i))
16e62bcf3c9b93 Ban Feng 2023-12-04  355  				gpio10_13 |= PWM_SEL(i);
16e62bcf3c9b93 Ban Feng 2023-12-04  356  			if (fanin_mask & BIT_CHECK(i))
16e62bcf3c9b93 Ban Feng 2023-12-04  357  				gpio0_3 |= FANIN_SEL(i);
16e62bcf3c9b93 Ban Feng 2023-12-04  358  		} else {
16e62bcf3c9b93 Ban Feng 2023-12-04  359  			if (pwm_mask & BIT_CHECK(i))
16e62bcf3c9b93 Ban Feng 2023-12-04  360  				gpio14_17 |= PWM_SEL(i);
16e62bcf3c9b93 Ban Feng 2023-12-04  361  			if (fanin_mask & BIT_CHECK(i))
16e62bcf3c9b93 Ban Feng 2023-12-04  362  				gpio4_7 |= FANIN_SEL(i);
16e62bcf3c9b93 Ban Feng 2023-12-04  363  		}
16e62bcf3c9b93 Ban Feng 2023-12-04  364  	}
16e62bcf3c9b93 Ban Feng 2023-12-04  365  
16e62bcf3c9b93 Ban Feng 2023-12-04  366  	/* Pin Function Configuration */
16e62bcf3c9b93 Ban Feng 2023-12-04 @367  	ret = nct736x_write_reg(client, NCT736X_REG_GPIO_0_3, gpio0_3);
                                                                                                      ^^^^^^^

16e62bcf3c9b93 Ban Feng 2023-12-04  368  	if (ret < 0)
16e62bcf3c9b93 Ban Feng 2023-12-04  369  		return ret;
16e62bcf3c9b93 Ban Feng 2023-12-04 @370  	ret = nct736x_write_reg(client, NCT736X_REG_GPIO_4_7, gpio4_7);
16e62bcf3c9b93 Ban Feng 2023-12-04  371  	if (ret < 0)
16e62bcf3c9b93 Ban Feng 2023-12-04  372  		return ret;
16e62bcf3c9b93 Ban Feng 2023-12-04 @373  	ret = nct736x_write_reg(client, NCT736X_REG_GPIO_10_13, gpio10_13);
16e62bcf3c9b93 Ban Feng 2023-12-04  374  	if (ret < 0)
16e62bcf3c9b93 Ban Feng 2023-12-04  375  		return ret;
16e62bcf3c9b93 Ban Feng 2023-12-04 @376  	ret = nct736x_write_reg(client, NCT736X_REG_GPIO_14_17, gpio14_17);
16e62bcf3c9b93 Ban Feng 2023-12-04  377  	if (ret < 0)
16e62bcf3c9b93 Ban Feng 2023-12-04  378  		return ret;
16e62bcf3c9b93 Ban Feng 2023-12-04  379  
16e62bcf3c9b93 Ban Feng 2023-12-04  380  	/* PWM and FANIN Monitoring Enable */

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

