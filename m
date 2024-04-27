Return-Path: <linux-kernel+bounces-161008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2EC8B45B5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61686282AA4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AF0495CC;
	Sat, 27 Apr 2024 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f2c4cWpS"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36BE4644E
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714215977; cv=none; b=bC6cc1/q7z6DqDbI3rWRXSP5mbr5ypJ2qmZzqgpY3ot9vEhzkI0/eCH6PJJEImZ55Vx5RDn8UBKy6DtJzNp+hIqTg9FwSYjHfqs7fg12G788fqzt0pF0YxCGpgSbglZr+v6Z3z7O2XFBCYy/XLk+4oTpGE+wURuydhA5/NVhQPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714215977; c=relaxed/simple;
	bh=NXgQHoxZpfu3GIYUh3ZBft3Ei1D6JkE0HsUmNEfG/Xo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o18MUwKR+QS0BlbjKMlg2cu1rHv5sAWZ+Yt6YG6Inb5qUqOg2iwOw76qIDfErcBhmzQheKSauAcPnSUdj27iWLzfYHZYtBUvWmqkzJ2CBX5idPzEl8XtXNN+nEhxnuVGnNZoa04CYHJTSVWRlMMFD+S63Nydws575FxBRTGmTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f2c4cWpS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4702457ccbso400466966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 04:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714215972; x=1714820772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nJLzCnFueUsIeTWZoXHlGujeNC5xYYi6/RyE8VW2No=;
        b=f2c4cWpSHskDRfnOZGiNOa+D2P90iwkayT5aRRLgz5Zu92uBuDCjf5CtNn1iACEN4q
         s4j/z/TMf4wzpdwDBhXZYaNpZXPPz+l3Bzu/MaErLNwhc3MJUFBOnsMq3gOqznypqA8j
         5Qih4pQ2a3m+r8u+lKctiikppmxXEuiSmc4jVulM5UiLaNOLtUe84/yacL9V9Kaepdaz
         HLnCRbUOsTwELmwBbRaGIaIEwaForbdRYNYC4lw00/nVJBO2Po67A8xlE2Vg3yhOdymj
         CnTC+Fvxl/8kCNz6dBQfGkXRI6w0DHWOZUC2dWO2hHA80c/tMI0nZcSw8s26lF9vmE70
         wqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714215972; x=1714820772;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nJLzCnFueUsIeTWZoXHlGujeNC5xYYi6/RyE8VW2No=;
        b=bnKimXfFUNSVvLAt3IjgmfyWtjiHW3oPT6HGgBWoH0HbVq9FlHZqihZOQKJZo78Uc9
         d0Tt4/BeaG0eg05e66vo/OSPy5gcE1rB/TnkpDLpduX4IZCafag7otZd3YntDSiBCQXi
         VNQRgUL4E3+Bp+BECfoeM+soYcGV4pjjxA+wwsSX89pwKGCFkCXyYwGA75t6rs4r2S9p
         X3LoWxjsBPommEnAoRfFsSD32S9XK+B6AhEIIIxkDN8w21kt7/B7xTfml7lLSF8mjbVr
         WsLy2Hb04zfQl7yCnESzFg5me5BO7eIAyTMJp6K9M24wdhFBaXng3qSJNxfBg9xaiCiv
         vgug==
X-Forwarded-Encrypted: i=1; AJvYcCW4ftCd9nYMgXvBfO1h6/ohAKMJ1JpDJV/ddHnZiJo4EHaFi/9zvz5aJq8nhzX6WdI0cCQV8Z2J+oma2EaIsbx4q88gk2huSgXdfqeI
X-Gm-Message-State: AOJu0Yz0NDCmQn15N1fUSWutQRe3vxeh0jySW8xxDeg+K/NzrXYqxARL
	hmyFZMrqSNST5YWIE8OsAwqeByCWf/ZylKkt5aGumzZhS08wpdvEgU/txGLIrTI=
X-Google-Smtp-Source: AGHT+IFjaaTuiL/g0Z6kLt7soHJxlk8fpucimHtMMJnKP07QMzasVrQHJk9xNhbRR49iV5OHL8EFzA==
X-Received: by 2002:a17:906:70b:b0:a58:7985:8eae with SMTP id y11-20020a170906070b00b00a5879858eaemr3611972ejb.76.1714215972297;
        Sat, 27 Apr 2024 04:06:12 -0700 (PDT)
Received: from localhost (host-87-1-234-99.retail.telecomitalia.it. [87.1.234.99])
        by smtp.gmail.com with ESMTPSA id k25-20020a1709062a5900b00a55a06d7744sm8531708eje.73.2024.04.27.04.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 04:06:12 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Sat, 27 Apr 2024 13:06:13 +0200
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH 4/6] pinctrl: bcm: Add pinconf/pinmux controller driver
 for BCM2712
Message-ID: <ZizcJT_u__-otw_-@apocalypse>
Mail-Followup-To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <8fb5dde9404875777587c867e7bdb4f691ab83f2.1713036964.git.andrea.porta@suse.com>
 <d6ab66cf-09ac-4f53-9102-11f207d16db5@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6ab66cf-09ac-4f53-9102-11f207d16db5@broadcom.com>

On 09:00 Sun 14 Apr     , Florian Fainelli wrote:
> 
> 
> On 4/13/2024 3:14 PM, Andrea della Porta wrote:
> > Add a pincontrol driver for BCM2712. BCM2712 allows muxing GPIOs
> > and setting configuration on pads.
> > 
> > Originally-by: Jonathan Bell <jonathan@raspberrypi.com>
> > Originally-by: Phil Elwell <phil@raspberrypi.com>
> 
> Is that a new tag in a comment message? Signed-off-by maybe?
> 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> 
> Was not pinctrl-single usable somehow that we had to go through a dedicated
> pinctrl driver?
> 

I'm taking a look on this. In V2 though, the pin controller will not be 
present since it's not strictly necessary tobe able to boot from sd card.

> >   drivers/pinctrl/bcm/Kconfig           |    9 +
> >   drivers/pinctrl/bcm/Makefile          |    1 +
> >   drivers/pinctrl/bcm/pinctrl-bcm2712.c | 1247 +++++++++++++++++++++++++
> >   3 files changed, 1257 insertions(+)
> >   create mode 100644 drivers/pinctrl/bcm/pinctrl-bcm2712.c
> > 
> > diff --git a/drivers/pinctrl/bcm/Kconfig b/drivers/pinctrl/bcm/Kconfig
> > index 35b51ce4298e..62ede44460bc 100644
> > --- a/drivers/pinctrl/bcm/Kconfig
> > +++ b/drivers/pinctrl/bcm/Kconfig
> > @@ -3,6 +3,15 @@
> >   # Broadcom pinctrl drivers
> >   #
> > +config PINCTRL_BCM2712
> > +	bool "Broadcom BCM2712 PINCONF driver"
> > +	depends on OF && (ARCH_BCM2835 || ARCH_BRCMSTB || COMPILE_TEST)
> > +	select PINMUX
> > +	select PINCONF
> > +	select GENERIC_PINCONF
> 
> Rename to PINCTRL_BRCMSTB sicne this is not BCM2712 specific at all.
> 
> > +	help
> > +	  Say Y here to enable the Broadcom BCM2712 PINCONF driver.
> > +
> >   config PINCTRL_BCM281XX
> >   	bool "Broadcom BCM281xx pinctrl driver"
> >   	depends on OF && (ARCH_BCM_MOBILE || COMPILE_TEST)
> > diff --git a/drivers/pinctrl/bcm/Makefile b/drivers/pinctrl/bcm/Makefile
> > index 82b868ec1471..d298e4785829 100644
> > --- a/drivers/pinctrl/bcm/Makefile
> > +++ b/drivers/pinctrl/bcm/Makefile
> > @@ -1,6 +1,7 @@
> >   # SPDX-License-Identifier: GPL-2.0
> >   # Broadcom pinctrl support
> > +obj-$(CONFIG_PINCTRL_BCM2712)		+= pinctrl-bcm2712.o
> 
> Likewise.
> 
> >   obj-$(CONFIG_PINCTRL_BCM281XX)		+= pinctrl-bcm281xx.o
> >   obj-$(CONFIG_PINCTRL_BCM2835)		+= pinctrl-bcm2835.o
> >   obj-$(CONFIG_PINCTRL_BCM4908)		+= pinctrl-bcm4908.o
> > diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2712.c b/drivers/pinctrl/bcm/pinctrl-bcm2712.c
> > new file mode 100644
> > index 000000000000..f9359e9eff14
> > --- /dev/null
> > +++ b/drivers/pinctrl/bcm/pinctrl-bcm2712.c
> > @@ -0,0 +1,1247 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Driver for Broadcom BCM2712 GPIO units (pinctrl only)
> > + *
> > + * Copyright (C) 2021-3 Raspberry Pi Ltd.
> > + * Copyright (C) 2012 Chris Boot, Simon Arlott, Stephen Warren
> > + *
> > + * Based heavily on the BCM2835 GPIO & pinctrl driver, which was inspired by:
> > + * pinctrl-nomadik.c, please see original file for copyright information
> > + * pinctrl-tegra.c, please see original file for copyright information
> > + */
> > +
> > +#include <linux/bitmap.h>
> > +#include <linux/bug.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of.h>
> > +#include <linux/pinctrl/consumer.h>
> > +#include <linux/pinctrl/machine.h>
> > +#include <linux/pinctrl/pinconf.h>
> > +#include <linux/pinctrl/pinctrl.h>
> > +#include <linux/pinctrl/pinmux.h>
> > +#include <linux/pinctrl/pinconf-generic.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/seq_file.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/types.h>
> > +
> > +#define MODULE_NAME "pinctrl-bcm2712"
> > +
> > +/* Register offsets */
> > +
> > +#define BCM2712_PULL_NONE	0
> > +#define BCM2712_PULL_DOWN	1
> > +#define BCM2712_PULL_UP		2
> > +#define BCM2712_PULL_MASK	0x3
> > +
> > +#define BCM2712_FSEL_COUNT 9
> > +#define BCM2712_FSEL_MASK  0xf
> > +
> > +#define FUNC(f) \
> > +	[func_##f] = #f
> > +#define PIN(i, f1, f2, f3, f4, f5, f6, f7, f8) \
> > +	[i] = { \
> > +		.funcs = { \
> > +			func_##f1, \
> > +			func_##f2, \
> > +			func_##f3, \
> > +			func_##f4, \
> > +			func_##f5, \
> > +			func_##f6, \
> > +			func_##f7, \
> > +			func_##f8, \
> > +		}, \
> > +	}
> > +
> > +#define MUX_BIT_VALID	0x8000
> > +#define REG_BIT_INVALID	0xffff
> > +
> > +#define BIT_TO_REG(b) (((b) >> 5) << 2)
> > +#define BIT_TO_SHIFT(b) ((b) & 0x1f)
> > +
> > +#define MUX_BIT(mr, mb) (MUX_BIT_VALID + ((mr)*4)*8 + (mb)*4)
> > +#define GPIO_REGS(n, mr, mb, pr, pb) \
> > +	[n] = { MUX_BIT(mr, mb), ((pr)*4)*8 + (pb)*2 }
> > +
> > +#define EMMC_REGS(n, pr, pb) \
> > +	[n] = { 0, ((pr)*4)*8 + (pb)*2 }
> > +
> > +#define AGPIO_REGS(n, mr, mb, pr, pb) \
> > +	[n] = { MUX_BIT(mr, mb), ((pr)*4)*8 + (pb)*2 }
> > +
> > +#define SGPIO_REGS(n, mr, mb) \
> > +	[n+32] = { MUX_BIT(mr, mb), REG_BIT_INVALID }
> > +
> > +#define GPIO_PIN(a) PINCTRL_PIN(a, "gpio" #a)
> > +#define AGPIO_PIN(a) PINCTRL_PIN(a, "aon_gpio" #a)
> > +#define SGPIO_PIN(a) PINCTRL_PIN(a+32, "aon_sgpio" #a)
> > +
> > +struct pin_regs {
> > +	u16 mux_bit;
> > +	u16 pad_bit;
> > +};
> > +
> > +struct bcm2712_pinctrl {
> > +	struct device *dev;
> > +	void __iomem *base;
> > +	struct pinctrl_dev *pctl_dev;
> > +	struct pinctrl_desc pctl_desc;
> > +	const struct pin_regs *pin_regs;
> > +	const struct bcm2712_pin_funcs *pin_funcs;
> > +	const char *const *gpio_groups;
> > +	struct pinctrl_gpio_range gpio_range;
> > +	spinlock_t lock;
> > +};
> 
> Please s/bcm2712/brcmstb/ throughout the driver's structures and any
> declaration that is not inherently 2712 specific and just make 2712 the
> first instance using this driver.
> 
> > +
> > +struct bcm_plat_data {
> > +	const struct pinctrl_desc *pctl_desc;
> > +	const struct pinctrl_gpio_range *gpio_range;
> > +	const struct pin_regs *pin_regs;
> > +	const struct bcm2712_pin_funcs *pin_funcs;
> > +};
> > +
> > +struct bcm2712_pin_funcs {
> > +	u8 funcs[BCM2712_FSEL_COUNT - 1];
> > +};
> > +
> 
> [snip]
> 
> > +static int bcm2712_pinctrl_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	//struct device_node *np = dev->of_node;
> > +	const struct bcm_plat_data *pdata;
> > +	//const struct of_device_id *match;
> > +	struct bcm2712_pinctrl *pc;
> > +	const char **names;
> > +	int num_pins, i;
> > +
> > +	pdata = device_get_match_data(&pdev->dev);
> > +	if (!pdata)
> > +		return -EINVAL;
> > +
> > +	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> > +	if (!pc)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, pc);
> > +	pc->dev = dev;
> > +	spin_lock_init(&pc->lock);
> > +
> > +	//pc->base = devm_of_iomap(dev, np, 0, NULL);
> 
> Remove stray commented lines.
> 
> > +	pc->base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (WARN_ON(IS_ERR(pc->base))) {
> > +		//dev_err(dev, "could not get IO memory\n");
> > +		return PTR_ERR(pc->base);
> > +	}
> > +
> > +	pc->pctl_desc = *pdata->pctl_desc;
> > +	num_pins = pc->pctl_desc.npins;
> > +	names = devm_kmalloc_array(dev, num_pins, sizeof(const char *),
> > +				   GFP_KERNEL);
> > +	if (!names)
> > +		return -ENOMEM;
> > +	for (i = 0; i < num_pins; i++)
> > +		names[i] = pc->pctl_desc.pins[i].name;
> > +	pc->gpio_groups = names;
> > +	pc->pin_regs = pdata->pin_regs;
> > +	pc->pin_funcs = pdata->pin_funcs;
> > +	pc->pctl_dev = devm_pinctrl_register(dev, &pc->pctl_desc, pc);
> > +	if (IS_ERR(pc->pctl_dev))
> > +		return PTR_ERR(pc->pctl_dev);
> > +
> > +	pc->gpio_range = *pdata->gpio_range;
> > +	pinctrl_add_gpio_range(pc->pctl_dev, &pc->gpio_range);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver bcm2712_pinctrl_driver = {
> > +	.probe = bcm2712_pinctrl_probe,
> > +	.driver = {
> > +		.name = MODULE_NAME,
> > +		.of_match_table = bcm2712_pinctrl_match,
> > +		.suppress_bind_attrs = true,
> > +	},
> > +};
> > +builtin_platform_driver(bcm2712_pinctrl_driver);
> 
> There is no MODULE_LICENSE(), MODULE_AUTHOR() or MODULE_DESCRIPTION(),
> please provide some.
> -- 
> Florian



