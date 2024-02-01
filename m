Return-Path: <linux-kernel+bounces-47640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2EF845093
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A261F24661
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774CF3C08E;
	Thu,  1 Feb 2024 05:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mEznzU92"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54623BB3C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 05:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706763825; cv=none; b=lYD644DgJdU2PwcCsqP2WI0TuV6RTDwdS43qN3TbIawScd3YrzgeTJDSO3pWBoz1nGGrfpd5WZDnSBkd5GOeTErntAqMfEf1PX49dd7ERPQCDeuvEPf+3ewlmk8LuZF4MQGB+5bDis1ruOLgmJSHOBmExCWgVPawUQduNAWRIFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706763825; c=relaxed/simple;
	bh=ACnGcnZlJMoqbbdjxjmWLWk9z/051wkEqHoQSS+YLrs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XEmd0Sd5H9l1uE1r+zK4hCBtOuTR7oqWrQbGmuC4PrDrXQaDNok4zVeNsmYfS1+GzJflH2ptu/MdrDFy9CXboKAwSXC8+2fh2aTPMFM4Zrc0jy1RSraq0EHt2MEPDJ9r7OZPDTDyBjw2IWFUkxnVcglVgnP3dsBWJuW7Qpq4LuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mEznzU92; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28a6cef709so63902266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706763822; x=1707368622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L8PE05+8OKcr00s2EuOD1MuR7b2GReswfcdBmnIMwgk=;
        b=mEznzU92t70CiMRjKukOBu1i7gX/bf0Dyo+GzJSBoyeJRO+x5du297HI0gIm3LM5a4
         wLfl+/2qTUGvc+C4knesV79EbWtMro1udG6D4LhKPYTiUO4edspKOVVvcY6lf+K74vPd
         p2H426+Avo+zK9ZPxWZVL+FygoVT9ZvtBiKXMNP8t2GeTIXZwEKAklUbq4lhe94yrfnt
         /osbykOMBZdIvKaxkqxwbHsAFbXj3TmaOhDOv4yS7wW+uHzFYqz0TQYACy0rlTDfvnX4
         QkIE1dYj5027NLBnM9AOcOfOSvBTbTwW48U67X4tW1YMKuHCyv/zua/50NVrAB7fSzCB
         4TEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706763822; x=1707368622;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8PE05+8OKcr00s2EuOD1MuR7b2GReswfcdBmnIMwgk=;
        b=rpSm1mOSccWqj4XXtWY96GO31pv4zv8XoUVtgnBAqWogwe9EqOX7f7WsiWE5yNT+He
         JH2uQjP6hWn2xvWw/UOWJToO1VqMW8gFqgUudeKcnSUVb2cJB0tj/5ZG36SVuQpg5ojj
         Oq+orMJ6YrIx2nwDpUdFEvA5AwXx2jQg/yHv+GoUgO3douP/OodpZd3USxBcsKkD81PB
         NZtwg5B0LdgVJVKTmOjv+y5dmj/F30qX0LUtx5OseD15PDBaJd1NcwbIlyTx55xOgqWr
         9MxPQuBxCcjhQQoBFXreYLebvysv2l0M1PumpQ5XEvjD5OhsOrTI3euLdVVXSQhkcg/N
         D5zg==
X-Gm-Message-State: AOJu0Yy168bnQXXsIVjD3vDWPtxRnNsofj8Chv2ob6lQBJh2y1z2i/OQ
	XUNTcjUV/2CQ2P2dQELOdAigwepUoBB0+dkOR51MCUIaFFP4/i6EZ5h9nN8a+Gs=
X-Google-Smtp-Source: AGHT+IE0OOjQ3DUZmxjCtRlCDvrzt5chddJ/zMB0u+1RN+VecxdvmydlFw9/VKAkLbpaP4FDfBh/jA==
X-Received: by 2002:a17:906:4157:b0:a35:53c8:dbd with SMTP id l23-20020a170906415700b00a3553c80dbdmr2603083ejk.35.1706763821938;
        Wed, 31 Jan 2024 21:03:41 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906349600b00a367bdce1fcsm1149582ejb.64.2024.01.31.21.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 21:03:41 -0800 (PST)
Date: Thu, 1 Feb 2024 08:03:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 20/22] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
Message-ID: <3ab71aad-757f-4d5e-ac09-fdad75238fa3@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130124828.14678-21-brgl@bgdev.pl>

Hi Bartosz,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpio-protect-the-list-of-GPIO-devices-with-SRCU/20240130-205537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20240130124828.14678-21-brgl%40bgdev.pl
patch subject: [PATCH 20/22] gpio: protect the pointer to gpio_chip in gpio_device with SRCU
config: i386-randconfig-141-20240131 (https://download.01.org/0day-ci/archive/20240201/202402010641.idtEaO24-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202402010641.idtEaO24-lkp@intel.com/

New smatch warnings:
drivers/gpio/gpiolib.c:4776 gpiolib_dbg_show() error: we previously assumed 'gc' could be null (see line 4773)


vim +/gc +4776 drivers/gpio/gpiolib.c

fdeb8e1547cb9d Linus Walleij       2016-02-10  4762  static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
d2876d08d86f22 David Brownell      2008-02-04  4763  {
0338f6a6fb659f Bartosz Golaszewski 2023-12-21  4764  	bool active_low, is_irq, is_out;
0338f6a6fb659f Bartosz Golaszewski 2023-12-21  4765  	unsigned int gpio = gdev->base;
3de69ae1c407da Andy Shevchenko     2022-04-08  4766  	struct gpio_desc *desc;
2796d5332f8ac8 Bartosz Golaszewski 2024-01-30  4767  	struct gpio_chip *gc;
3de69ae1c407da Andy Shevchenko     2022-04-08  4768  	int value;
d2876d08d86f22 David Brownell      2008-02-04  4769  
2796d5332f8ac8 Bartosz Golaszewski 2024-01-30  4770  	guard(srcu)(&gdev->srcu);
2796d5332f8ac8 Bartosz Golaszewski 2024-01-30  4771  
2796d5332f8ac8 Bartosz Golaszewski 2024-01-30  4772  	gc = rcu_dereference(gdev->chip);
2796d5332f8ac8 Bartosz Golaszewski 2024-01-30 @4773  	if (!gc)
                                                            ^^^
The patch adds a NULL check

2796d5332f8ac8 Bartosz Golaszewski 2024-01-30  4774  		seq_puts(s, "Underlying GPIO chip is gone\n");
2796d5332f8ac8 Bartosz Golaszewski 2024-01-30  4775  
3de69ae1c407da Andy Shevchenko     2022-04-08 @4776  	for_each_gpio_desc(gc, desc) {
                                                                           ^^
But this dereference isn't checked...  Probably it should return after
the seq_puts().

bedc56b1695b27 Bartosz Golaszewski 2024-01-30  4777  		guard(srcu)(&desc->srcu);
3de69ae1c407da Andy Shevchenko     2022-04-08  4778  		if (test_bit(FLAG_REQUESTED, &desc->flags)) {
3de69ae1c407da Andy Shevchenko     2022-04-08  4779  			gpiod_get_direction(desc);
3de69ae1c407da Andy Shevchenko     2022-04-08  4780  			is_out = test_bit(FLAG_IS_OUT, &desc->flags);
234c52097ce416 Andy Shevchenko     2022-04-08  4781  			value = gpio_chip_get_value(gc, desc);
3de69ae1c407da Andy Shevchenko     2022-04-08  4782  			is_irq = test_bit(FLAG_USED_AS_IRQ, &desc->flags);
3de69ae1c407da Andy Shevchenko     2022-04-08  4783  			active_low = test_bit(FLAG_ACTIVE_LOW, &desc->flags);
3de69ae1c407da Andy Shevchenko     2022-04-08  4784  			seq_printf(s, " gpio-%-3d (%-20.20s|%-20.20s) %s %s %s%s\n",
32648f473c7f46 Bartosz Golaszewski 2024-01-30  4785  				   gpio, desc->name ?: "", gpiod_get_label(desc),
d2876d08d86f22 David Brownell      2008-02-04  4786  				   is_out ? "out" : "in ",
3de69ae1c407da Andy Shevchenko     2022-04-08  4787  				   value >= 0 ? (value ? "hi" : "lo") : "?  ",
90fd227029a25b Linus Walleij       2018-10-01  4788  				   is_irq ? "IRQ " : "",
90fd227029a25b Linus Walleij       2018-10-01  4789  				   active_low ? "ACTIVE LOW" : "");
3de69ae1c407da Andy Shevchenko     2022-04-08  4790  		} else if (desc->name) {
3de69ae1c407da Andy Shevchenko     2022-04-08  4791  			seq_printf(s, " gpio-%-3d (%-20.20s)\n", gpio, desc->name);
3de69ae1c407da Andy Shevchenko     2022-04-08  4792  		}
3de69ae1c407da Andy Shevchenko     2022-04-08  4793  
3de69ae1c407da Andy Shevchenko     2022-04-08  4794  		gpio++;
d2876d08d86f22 David Brownell      2008-02-04  4795  	}
d2876d08d86f22 David Brownell      2008-02-04  4796  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


