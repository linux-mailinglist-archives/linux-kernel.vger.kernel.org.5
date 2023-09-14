Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC6F7A018D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbjINKVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbjINJLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:11:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0FC26A9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:10:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401b0d97850so7250985e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694682631; x=1695287431; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/p/h+1hjRJPkTJw7ohFZfNjwicd4vOn5u73LLVp5Pws=;
        b=pCzhq7HLcxAm3ltl3eMVbQMWzzvuDOW1/9FU7XBZOX8LaKhwH7GFKrhSCfPjRQAsWm
         tQ8Rvr8KoUzDtPrTLLXjWlwGK6BosWJelWXv4sd2mdIBz+SfORyAuL8nqkR/nCaV4+GH
         13CfYmjE+0mdmWf7cEMQERm8tNBDni3pLbYJasAL0AD4LzbOVg36Hcd5J4VHT69ghDhZ
         rJR+JYruxINgrEpRsPjjhLA0HSNUD5pNsg8hQMVCuFLDtXfAHG3qRIIqADzBDeXyeNMN
         fXP7ScemVXR1lHC/J2klOWm6itysF+MyW831kjL0gZFgmgNvJ2VoMK3EJ9GhEeKQG0ax
         CbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694682631; x=1695287431;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/p/h+1hjRJPkTJw7ohFZfNjwicd4vOn5u73LLVp5Pws=;
        b=bJn/qY5PCD1RmrLKSWkPRtm9F+QkWX4rOz8FMBymAbdjkAi1l2iqKDEB6ruhlyEKRj
         WjD/IjAqonfgSmk88BNIE/D5ZMIBtrQ+4ybtoflCS7mu7cYxciONrpPFmmPy1qFhc2x8
         sGjKNaADeU4wc2d6oXGQf2H69LC6Sa00miSkot6678eae5yvmTU12x7ZndFpBJ9p9BZC
         U20/ZoYdsaEnZqMKp7xeioRg2G+Z59Movt0qw02exrbUeKkFfBv38pfted3Jo7T5d3qJ
         LvWnctioZUf0SmfQq2sVTBCzNqOftdlE/zv4Hcmyd36eEdaLnfjV+8EYYUzOYIcO+NJt
         Xqog==
X-Gm-Message-State: AOJu0YyiadBxb+9jxqYyxEfDBaeJdBkrZdXETUDMGrHHBK2vTM/AJUpg
        cSuY8E3wOJbPYJ0v5ZCUByODYg==
X-Google-Smtp-Source: AGHT+IHOJr+9i6NWOvvuN/NveO9DgZMU7hC3xHft4L2jEtjxakLoHExd0GgllOpjdXdC9Tnpdx852A==
X-Received: by 2002:a7b:ce93:0:b0:401:daf2:2735 with SMTP id q19-20020a7bce93000000b00401daf22735mr4087319wmj.31.1694682630841;
        Thu, 14 Sep 2023 02:10:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c280700b003fed630f560sm1379458wmb.36.2023.09.14.02.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:10:30 -0700 (PDT)
Date:   Thu, 14 Sep 2023 12:10:27 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Linus Walleij <linus.walleij@linaro.org>,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] leds: triggers: gpio: Rewrite to use trigger-sources
Message-ID: <21f871bb-d409-4337-9d90-27e5c9389aaf@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912-gpio-led-trigger-dt-v1-2-1b50e3756dda@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Linus-Walleij/dt-bindings-leds-Mention-GPIO-triggers/20230912-214554
base:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
patch link:    https://lore.kernel.org/r/20230912-gpio-led-trigger-dt-v1-2-1b50e3756dda%40linaro.org
patch subject: [PATCH 2/2] leds: triggers: gpio: Rewrite to use trigger-sources
config: x86_64-randconfig-161-20230913 (https://download.01.org/0day-ci/archive/20230914/202309140825.cVUTHU1K-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230914/202309140825.cVUTHU1K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202309140825.cVUTHU1K-lkp@intel.com/

smatch warnings:
drivers/leds/trigger/ledtrig-gpio.c:98 gpio_trig_activate() error: dereferencing freed memory 'gpio_data'

vim +/gpio_data +98 drivers/leds/trigger/ledtrig-gpio.c

2282e125a406e0 drivers/leds/trigger/ledtrig-gpio.c Uwe Kleine-König 2018-07-02   78  static int gpio_trig_activate(struct led_classdev *led)
17354bfe85275f drivers/leds/ledtrig-gpio.c         Felipe Balbi     2009-02-17   79  {
17354bfe85275f drivers/leds/ledtrig-gpio.c         Felipe Balbi     2009-02-17   80  	struct gpio_trig_data *gpio_data;
2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12   81  	struct device *dev = led->dev;
2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12   82  	int ret;
17354bfe85275f drivers/leds/ledtrig-gpio.c         Felipe Balbi     2009-02-17   83  
17354bfe85275f drivers/leds/ledtrig-gpio.c         Felipe Balbi     2009-02-17   84  	gpio_data = kzalloc(sizeof(*gpio_data), GFP_KERNEL);
17354bfe85275f drivers/leds/ledtrig-gpio.c         Felipe Balbi     2009-02-17   85  	if (!gpio_data)
9bfd7d9e5d6353 drivers/leds/trigger/ledtrig-gpio.c Uwe Kleine-König 2018-07-02   86  		return -ENOMEM;
17354bfe85275f drivers/leds/ledtrig-gpio.c         Felipe Balbi     2009-02-17   87  
2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12   88  	/*
2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12   89  	 * The generic property "trigger-sources" is followed,
2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12   90  	 * and we hope that this is a GPIO.
2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12   91  	 */
2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12   92  	gpio_data->gpiod = fwnode_gpiod_get_index(dev->fwnode,
2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12   93  						  "trigger-sources",
2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12   94  						  0, GPIOD_IN,
2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12   95  						  "led-trigger");
2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12   96  	if (IS_ERR(gpio_data->gpiod)) {
2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12   97  		kfree(gpio_data);
                                                                                                ^^^^^^^^^^^^^^^^

2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12  @98  		return PTR_ERR(gpio_data->gpiod);
                                                                                                               ^^^^^^^^^^^^^^^^
Dereferencing freed memory.

2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12   99  	}
2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12  100  	if (!gpio_data->gpiod) {
2689cea6283a47 drivers/leds/trigger/ledtrig-gpio.c Linus Walleij    2023-09-12  101  		dev_err(dev, "no valid GPIO for the trigger\n");

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

