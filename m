Return-Path: <linux-kernel+bounces-144256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0D48A43AD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FAADB21F61
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514D8134CC6;
	Sun, 14 Apr 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gzOlH90/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFCC134CCA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713110449; cv=none; b=rr7AfFAjHhEap2W1MDLw3FpjR5CL/V3KU3Bbo2O20vQ/q5KPQhtyX+G5DHObGcLAf6ybHP/QEseCIWFn8olUZIEndDeWEX9mlj/hz3osZ4qoAQGxx/Npre1bbEIZQSOtH1Bb5ztlk88jL44gQyoNXZ9gbpRBAGk/U/ommYd3a0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713110449; c=relaxed/simple;
	bh=AIiqf7djlShN+J1mD1JUQCkT4ifWVG2qwE3fvwX6eBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FP/ppL+1KVkVSQFpLGmYEKSTrMHq7mGurD8gXp+PIKSQ6fsMtqAyYeNnbWZ5+6PYhezlHyMePcTnhv6x0kL/vih8KSrKG1QnQr+U1880W95+90Vy+CYZAwHxf1jC5jBudI/qqhXvtpiY5pQnDfE+xjn9GRys2ZpEi2eNieixgcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gzOlH90/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e419d203bdso14284875ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713110447; x=1713715247; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoPfiPxcZuhBh2NYjX5b1F0Xb/4plDnfDKqCA0vGNrg=;
        b=gzOlH90/6mq55kbPSe4zuH8a2lp1Y375oiN5qN1bbCooYaCDPZ7uKqmvlebUO+e932
         zo+ELWxVjBu8/lk+eU8Ms+ZmQKrj7CX5r0RLqb2dhq4qsB/AnHrLWZsIqiOz0FS/o3AN
         mqIyFFatV0aNX9J5uK2VWQpjO0IZFr/0k4kKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713110447; x=1713715247;
        h=in-reply-to:autocrypt:from:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PoPfiPxcZuhBh2NYjX5b1F0Xb/4plDnfDKqCA0vGNrg=;
        b=sbuFtxDuadSQ5q/oTQSHHF65hQW3qys1cXdod0HZbW6m4Ndpf5Rae6OdXxFLGyjCUb
         Mr38AC1Y6C0qGdSlTJkAMlAkJ1A1gaQbhsvUhp8oqhyFrlthCHrfMOWunR4cfvFSYwwT
         vIJNyn+Nh5+NgfrCRtRSbS0IPDO75Jo0CiYVHFrgZydAO1A5/LKCKwHfNufYloyVljCg
         VsxMkdrJbAWe9zUyJReR84W2jwzIAjGex8GXwEp8KyPvzcQbTrN10l7m0/7Wuq2eCeIH
         0QCE9VfWYo60HNFaqrHF9E0K7hUmW4Ao4FS4IRsfqBdm/F4KMB71qR8tBmSPS5xFDGuL
         CuOw==
X-Forwarded-Encrypted: i=1; AJvYcCXI250odETinj+Xq8hhAtNW/Y8vAnbLMKnzK2i1v6tq0eVyRN/kG03qJopHlkBQxR3ZvjL0PEEX1Vl2cuFOpvc123079XpcdiYhlOav
X-Gm-Message-State: AOJu0Yy2wUZOXyVHrU5RD8lcNt9aPQlw33SyIpC/1eGnavdPhn8nfnv9
	XWQ8wBzD0Zd8tlg43b3Mff1UCsSp3je4ehMgkyJj+z1u6rWI6ELKBjWEYtMr8w==
X-Google-Smtp-Source: AGHT+IE+aYlepE2WEZxw5VP1H9YnpvF6J2iJYDioptTsHe9IcfUEPOUdN2s7ZETVSKaO+PPMgfJuuQ==
X-Received: by 2002:a17:902:9a48:b0:1e5:4f49:4036 with SMTP id x8-20020a1709029a4800b001e54f494036mr6645050plv.66.1713110446724;
        Sun, 14 Apr 2024 09:00:46 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001def175bbbfsm6176609plk.251.2024.04.14.09.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 09:00:45 -0700 (PDT)
Message-ID: <d6ab66cf-09ac-4f53-9102-11f207d16db5@broadcom.com>
Date: Sun, 14 Apr 2024 09:00:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] pinctrl: bcm: Add pinconf/pinmux controller driver
 for BCM2712
To: Andrea della Porta <andrea.porta@suse.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Kamal Dasu
 <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Jonathan Bell <jonathan@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <8fb5dde9404875777587c867e7bdb4f691ab83f2.1713036964.git.andrea.porta@suse.com>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <8fb5dde9404875777587c867e7bdb4f691ab83f2.1713036964.git.andrea.porta@suse.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000aab1120616109b4e"

--000000000000aab1120616109b4e
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/13/2024 3:14 PM, Andrea della Porta wrote:
> Add a pincontrol driver for BCM2712. BCM2712 allows muxing GPIOs
> and setting configuration on pads.
> 
> Originally-by: Jonathan Bell <jonathan@raspberrypi.com>
> Originally-by: Phil Elwell <phil@raspberrypi.com>

Is that a new tag in a comment message? Signed-off-by maybe?

> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---

Was not pinctrl-single usable somehow that we had to go through a 
dedicated pinctrl driver?

>   drivers/pinctrl/bcm/Kconfig           |    9 +
>   drivers/pinctrl/bcm/Makefile          |    1 +
>   drivers/pinctrl/bcm/pinctrl-bcm2712.c | 1247 +++++++++++++++++++++++++
>   3 files changed, 1257 insertions(+)
>   create mode 100644 drivers/pinctrl/bcm/pinctrl-bcm2712.c
> 
> diff --git a/drivers/pinctrl/bcm/Kconfig b/drivers/pinctrl/bcm/Kconfig
> index 35b51ce4298e..62ede44460bc 100644
> --- a/drivers/pinctrl/bcm/Kconfig
> +++ b/drivers/pinctrl/bcm/Kconfig
> @@ -3,6 +3,15 @@
>   # Broadcom pinctrl drivers
>   #
>   
> +config PINCTRL_BCM2712
> +	bool "Broadcom BCM2712 PINCONF driver"
> +	depends on OF && (ARCH_BCM2835 || ARCH_BRCMSTB || COMPILE_TEST)
> +	select PINMUX
> +	select PINCONF
> +	select GENERIC_PINCONF

Rename to PINCTRL_BRCMSTB sicne this is not BCM2712 specific at all.

> +	help
> +	  Say Y here to enable the Broadcom BCM2712 PINCONF driver.
> +
>   config PINCTRL_BCM281XX
>   	bool "Broadcom BCM281xx pinctrl driver"
>   	depends on OF && (ARCH_BCM_MOBILE || COMPILE_TEST)
> diff --git a/drivers/pinctrl/bcm/Makefile b/drivers/pinctrl/bcm/Makefile
> index 82b868ec1471..d298e4785829 100644
> --- a/drivers/pinctrl/bcm/Makefile
> +++ b/drivers/pinctrl/bcm/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   # Broadcom pinctrl support
>   
> +obj-$(CONFIG_PINCTRL_BCM2712)		+= pinctrl-bcm2712.o

Likewise.

>   obj-$(CONFIG_PINCTRL_BCM281XX)		+= pinctrl-bcm281xx.o
>   obj-$(CONFIG_PINCTRL_BCM2835)		+= pinctrl-bcm2835.o
>   obj-$(CONFIG_PINCTRL_BCM4908)		+= pinctrl-bcm4908.o
> diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2712.c b/drivers/pinctrl/bcm/pinctrl-bcm2712.c
> new file mode 100644
> index 000000000000..f9359e9eff14
> --- /dev/null
> +++ b/drivers/pinctrl/bcm/pinctrl-bcm2712.c
> @@ -0,0 +1,1247 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for Broadcom BCM2712 GPIO units (pinctrl only)
> + *
> + * Copyright (C) 2021-3 Raspberry Pi Ltd.
> + * Copyright (C) 2012 Chris Boot, Simon Arlott, Stephen Warren
> + *
> + * Based heavily on the BCM2835 GPIO & pinctrl driver, which was inspired by:
> + * pinctrl-nomadik.c, please see original file for copyright information
> + * pinctrl-tegra.c, please see original file for copyright information
> + */
> +
> +#include <linux/bitmap.h>
> +#include <linux/bug.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_address.h>
> +#include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/pinctrl/machine.h>
> +#include <linux/pinctrl/pinconf.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/platform_device.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#define MODULE_NAME "pinctrl-bcm2712"
> +
> +/* Register offsets */
> +
> +#define BCM2712_PULL_NONE	0
> +#define BCM2712_PULL_DOWN	1
> +#define BCM2712_PULL_UP		2
> +#define BCM2712_PULL_MASK	0x3
> +
> +#define BCM2712_FSEL_COUNT 9
> +#define BCM2712_FSEL_MASK  0xf
> +
> +#define FUNC(f) \
> +	[func_##f] = #f
> +#define PIN(i, f1, f2, f3, f4, f5, f6, f7, f8) \
> +	[i] = { \
> +		.funcs = { \
> +			func_##f1, \
> +			func_##f2, \
> +			func_##f3, \
> +			func_##f4, \
> +			func_##f5, \
> +			func_##f6, \
> +			func_##f7, \
> +			func_##f8, \
> +		}, \
> +	}
> +
> +#define MUX_BIT_VALID	0x8000
> +#define REG_BIT_INVALID	0xffff
> +
> +#define BIT_TO_REG(b) (((b) >> 5) << 2)
> +#define BIT_TO_SHIFT(b) ((b) & 0x1f)
> +
> +#define MUX_BIT(mr, mb) (MUX_BIT_VALID + ((mr)*4)*8 + (mb)*4)
> +#define GPIO_REGS(n, mr, mb, pr, pb) \
> +	[n] = { MUX_BIT(mr, mb), ((pr)*4)*8 + (pb)*2 }
> +
> +#define EMMC_REGS(n, pr, pb) \
> +	[n] = { 0, ((pr)*4)*8 + (pb)*2 }
> +
> +#define AGPIO_REGS(n, mr, mb, pr, pb) \
> +	[n] = { MUX_BIT(mr, mb), ((pr)*4)*8 + (pb)*2 }
> +
> +#define SGPIO_REGS(n, mr, mb) \
> +	[n+32] = { MUX_BIT(mr, mb), REG_BIT_INVALID }
> +
> +#define GPIO_PIN(a) PINCTRL_PIN(a, "gpio" #a)
> +#define AGPIO_PIN(a) PINCTRL_PIN(a, "aon_gpio" #a)
> +#define SGPIO_PIN(a) PINCTRL_PIN(a+32, "aon_sgpio" #a)
> +
> +struct pin_regs {
> +	u16 mux_bit;
> +	u16 pad_bit;
> +};
> +
> +struct bcm2712_pinctrl {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct pinctrl_dev *pctl_dev;
> +	struct pinctrl_desc pctl_desc;
> +	const struct pin_regs *pin_regs;
> +	const struct bcm2712_pin_funcs *pin_funcs;
> +	const char *const *gpio_groups;
> +	struct pinctrl_gpio_range gpio_range;
> +	spinlock_t lock;
> +};

Please s/bcm2712/brcmstb/ throughout the driver's structures and any 
declaration that is not inherently 2712 specific and just make 2712 the 
first instance using this driver.

> +
> +struct bcm_plat_data {
> +	const struct pinctrl_desc *pctl_desc;
> +	const struct pinctrl_gpio_range *gpio_range;
> +	const struct pin_regs *pin_regs;
> +	const struct bcm2712_pin_funcs *pin_funcs;
> +};
> +
> +struct bcm2712_pin_funcs {
> +	u8 funcs[BCM2712_FSEL_COUNT - 1];
> +};
> +

[snip]

> +static int bcm2712_pinctrl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	//struct device_node *np = dev->of_node;
> +	const struct bcm_plat_data *pdata;
> +	//const struct of_device_id *match;
> +	struct bcm2712_pinctrl *pc;
> +	const char **names;
> +	int num_pins, i;
> +
> +	pdata = device_get_match_data(&pdev->dev);
> +	if (!pdata)
> +		return -EINVAL;
> +
> +	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> +	if (!pc)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pc);
> +	pc->dev = dev;
> +	spin_lock_init(&pc->lock);
> +
> +	//pc->base = devm_of_iomap(dev, np, 0, NULL);

Remove stray commented lines.

> +	pc->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (WARN_ON(IS_ERR(pc->base))) {
> +		//dev_err(dev, "could not get IO memory\n");
> +		return PTR_ERR(pc->base);
> +	}
> +
> +	pc->pctl_desc = *pdata->pctl_desc;
> +	num_pins = pc->pctl_desc.npins;
> +	names = devm_kmalloc_array(dev, num_pins, sizeof(const char *),
> +				   GFP_KERNEL);
> +	if (!names)
> +		return -ENOMEM;
> +	for (i = 0; i < num_pins; i++)
> +		names[i] = pc->pctl_desc.pins[i].name;
> +	pc->gpio_groups = names;
> +	pc->pin_regs = pdata->pin_regs;
> +	pc->pin_funcs = pdata->pin_funcs;
> +	pc->pctl_dev = devm_pinctrl_register(dev, &pc->pctl_desc, pc);
> +	if (IS_ERR(pc->pctl_dev))
> +		return PTR_ERR(pc->pctl_dev);
> +
> +	pc->gpio_range = *pdata->gpio_range;
> +	pinctrl_add_gpio_range(pc->pctl_dev, &pc->gpio_range);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver bcm2712_pinctrl_driver = {
> +	.probe = bcm2712_pinctrl_probe,
> +	.driver = {
> +		.name = MODULE_NAME,
> +		.of_match_table = bcm2712_pinctrl_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +builtin_platform_driver(bcm2712_pinctrl_driver);

There is no MODULE_LICENSE(), MODULE_AUTHOR() or MODULE_DESCRIPTION(), 
please provide some.
-- 
Florian

--000000000000aab1120616109b4e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIP8a9Dct0ldn/FSo
eTI8IodWg2I488InZnKpOlORuOAnMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDQxNDE2MDA0N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAH5ICHl3mupWuoftnxxN7R7VkK6+AKeI+o
b6scf8to2Fw8hirvJmXb1FPgTjlNmOvEuhhFldY5pg1NavHPYS29CFDoqDTfK3JerryyIFj23jA9
ExYpDh5359kQ+muf9oTCNNiLVPstU9aAcsLo+vc8CAyZEpLY2XadWQyWpBtey27YDLO7GXHakKZz
uC6ZplkrIZyuU0zxtvqDW+povBX5WTs6l+e3cuENgkinyKOBlWc7XAH4F+Key8aQZk/I/gguvYsM
0+zyYlC47AGeEuUxBAW7L/U/s+bskiVncTXguK5QLCKkrqGAwOWFPFXh10OC50H6VnQDTQCQ+Yxy
6Y0U
--000000000000aab1120616109b4e--

