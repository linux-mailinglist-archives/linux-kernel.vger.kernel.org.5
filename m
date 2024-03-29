Return-Path: <linux-kernel+bounces-124287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30DA891518
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8978A287C01
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4A94AEDF;
	Fri, 29 Mar 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba8FkR0U"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF7249ED;
	Fri, 29 Mar 2024 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711700267; cv=none; b=PvzS8PJs72f14sRgvPJeAYyz5/GevKtphTLtpUx53JnkYUA+LyobgtzibarRh43uCApKL7euHju1nXUVfVtgTNfQPhhyQsOMF46/Q9BQKvBRniL0Jpb2j8lcNFNSnVtN9+mIo/PSOIp48Gn+OaaSE+ItRYsVr3ta8iia6XwSv+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711700267; c=relaxed/simple;
	bh=xcI33/1wG7Kt9NX9R3scZ3uOF9kigUKYPJzA7QpnciQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyMZj9mUChYDItH1P3Eh83WPJUYVxTXZlVTZKAdbcZyRF40yArlwvd6pKIB+NlHc6XVZS90+FK4cl5PP/S46j5fdYJmuW+d5vB+stAOzVn5Eln7dU1bqeJaovIAl+HjgUFhhepXwK6ZRDpCj1z+S5iKQhOEh4SW2Ws4g9N56rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba8FkR0U; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6eae2b57ff2so787851b3a.2;
        Fri, 29 Mar 2024 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711700264; x=1712305064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FO9tV3Xn+H5beEgAxwVhgbmhSxv5Ufnf/uazK/ynCgc=;
        b=ba8FkR0Ul1VjK6Y+z/ERVKgEs7TTZC7UYBfrbFYQmomHu5HZqzB/drf1VBmaSKlP9a
         scs6921t6emn7vRyjw+HTf0l67W2f3v81Qd7QjT9K0FOb1dviczxoGhzrF81A0YBlPya
         4dMdduRYa/ZvHS15T/61hAUOi85tYZqDm93G8dISphYJ6dqC0mecjl9y5KgcRFhxQUiq
         ECOLomLh+TDNAgFRwkK2DpTvqizOWybsMWYE9M6/nATVitU4+tNTYmGBX4u9uv55cGEu
         78rYkGtZGYUGescuNIWMmIZsEmBr9ja8GgLD1ygoSL9uWSTp6Nl8BhdRah4isCRAeC/3
         nE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711700264; x=1712305064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FO9tV3Xn+H5beEgAxwVhgbmhSxv5Ufnf/uazK/ynCgc=;
        b=h2LmF1nmrKZdxAp5uRjJ1J2JU+Twc6LzOCBXe9ktkNAQcdGSRk5ScdUSHTGbiUj2R9
         EFsANVYTngw7ZfBVX9JRz4x8DGQ8kpq1uEsWX1HQCZNrbq0CY91Opm8MGkx8kJM7MScG
         7tcG53JXLb3fny+k1cq9aNHdfQ/Ge05+/FvIC9gy2pE0Y+dNw5KmEdDnQT1rTK3I4pug
         FMaWUjyPtCcVEwU8M9ujRywqKIr2UcTYSYZ+2Ld1QYaIWwEK/ofoc+Qj7Kn3g/TvzJIZ
         8g89fkjLfOYzSUuT1R4JgL6YglRAE0ekg9DrByYDbShkKElqhQBOr9kv7jsUPFb02Bvn
         MmAw==
X-Forwarded-Encrypted: i=1; AJvYcCWdC6IN26YEVSSkD84s59efFB6oKdDZsXf7QseToBgBa5D6SFiDunfRipuLt2m4yCFoL1zevghnqdB4Ds1kFvdkBsEVOWb0hgf1Q8Nk20eC4zp9l1kgS9rup/j2i3SWjWNJW7nXZ+7f9FYN7u1EEINVBe1Vuol+ZoTzf/xeeQVcco8HUYk=
X-Gm-Message-State: AOJu0YxFDjPPLvhzQEyMGBsq6mGSe9JSg2ADlb1bprwNXVSgOpK6SJiO
	CpO+JCxvwEQrxOYpS6I0c3ORXTKqWFlsNsWXF1tu8xh9wkVHNu2XASlRHSWA
X-Google-Smtp-Source: AGHT+IGrWLGrCMmOqVpiFcT4g1I5JXdy19B2EPJ2VkIa2LhwPNd5vqTRTYCemyJ/a61nIuwaXik/sg==
X-Received: by 2002:a05:6a00:3a22:b0:6ea:e2d8:468 with SMTP id fj34-20020a056a003a2200b006eae2d80468mr1711036pfb.26.1711700264472;
        Fri, 29 Mar 2024 01:17:44 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id fj33-20020a056a003a2100b006e57247f4e5sm2569841pfb.8.2024.03.29.01.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 01:17:44 -0700 (PDT)
Message-ID: <c39611b6-25ab-425b-8a16-9f700086e6eb@gmail.com>
Date: Fri, 29 Mar 2024 16:17:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO
 driver
To: Linus Walleij <linus.walleij@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240313035719.768469-1-ychuang570808@gmail.com>
 <20240313035719.768469-4-ychuang570808@gmail.com>
 <CACRpkdYnG+SgrgAWW8+qdiBwO5d+nE8g_31Evyw0pA2dXz3BPw@mail.gmail.com>
Content-Language: en-US
From: Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <CACRpkdYnG+SgrgAWW8+qdiBwO5d+nE8g_31Evyw0pA2dXz3BPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Dear Linus,

Thanks for your review.


On 2024/3/28 下午 05:10, Linus Walleij wrote:
> Hi Jacky,
>
> overall this looks very good.
>
> On Wed, Mar 13, 2024 at 4:57 AM Jacky Huang <ychuang570808@gmail.com> wrote:
>
>
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add common pinctrl and GPIO driver for Nuvoton MA35 series SoC, and
>> add support for ma35d1 pinctrl.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> (...)
>> +static int ma35_pinmux_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
>> +                              unsigned int group)
>> +{
>> +       struct ma35_pinctrl *npctl = pinctrl_dev_get_drvdata(pctldev);
>> +       struct ma35_pin_group *grp = &npctl->groups[group];
>> +       struct ma35_pin_setting *setting = grp->settings;
>> +       u32 i, regval;
>> +
>> +       dev_dbg(npctl->dev, "enable function %s group %s\n",
>> +               npctl->functions[selector].name, npctl->groups[group].name);
>> +
>> +       for (i = 0; i < grp->npins; i++) {
>> +               regmap_read(npctl->regmap, setting->offset, &regval);
>> +               regval &= ~GENMASK(setting->shift + 3, setting->shift);
> Add a comment explaining why you add +3

The pinmux selection is 4 bits. I will use a constant for the bitmask 
width instead.

>
>> +static int ma35_gpio_core_direction_in(struct gpio_chip *gc, unsigned int gpio)
>> +{
>> +       struct ma35_pin_bank *bank = gpiochip_get_data(gc);
>> +       void __iomem *reg_mode = bank->reg_base + MA35_GP_REG_MODE;
>> +       unsigned long flags;
>> +       unsigned int regval;
>> +
>> +       spin_lock_irqsave(&bank->lock, flags);
>> +
>> +       regval = readl(reg_mode);
>> +       regval &= ~GENMASK(gpio * 2 + 1, gpio * 2);
>> +       regval |= MA35_GP_MODE_INPUT << gpio * 2;
> Here the first time you do this magic explain in a comment why you
> use *2+1 and *2 overall (I guess two bits per line).

Yes, it is two bits per pin. I will add a comment to explain this.

>> +static int ma35_gpio_core_get(struct gpio_chip *gc, unsigned int gpio)
>> +{
>> +       struct ma35_pin_bank *bank = gpiochip_get_data(gc);
>> +
>> +       return readl(bank->reg_base + MA35_PIN_MAP_BASE + gpio * 4);
> Here add a comment explaining the *4
> I guess one 32-bit register per pin?

Yes, it maps one 32-bit register to a gpio pin.
I will add a comment to explain this.

>> +static int ma35_irq_irqtype(struct irq_data *d, unsigned int type)
>> +{
>> +       struct ma35_pin_bank *bank = gpiochip_get_data(irq_data_get_irq_chip_data(d));
>> +       void __iomem *reg_itype = bank->reg_base + MA35_GP_REG_INTTYPE;
>> +       void __iomem *reg_ien = bank->reg_base + MA35_GP_REG_INTEN;
>> +       unsigned int num = (d->hwirq);
>> +
>> +       if (type == IRQ_TYPE_PROBE) {
>> +               writel(readl(reg_itype) & ~BIT(num), reg_itype);
>> +               writel(readl(reg_ien) | BIT(num) | BIT(num + 16), reg_ien);
>> +               bank->irqtype &= ~BIT(num);
>> +               bank->irqinten |= BIT(num) | BIT(num + 16);
>> +               return 0;
>> +       }
>> +
>> +       if (type & IRQ_TYPE_LEVEL_MASK) {
>> +               writel(readl(reg_itype) | BIT(num), reg_itype);
>> +               writel(readl(reg_ien) & ~(BIT(num) | BIT(num + 16)), reg_ien);
>> +               bank->irqtype |= BIT(num);
>> +               bank->irqinten &= ~(BIT(num) | BIT(num + 16));
>> +               if (type == IRQ_TYPE_LEVEL_HIGH) {
>> +                       writel(readl(reg_ien) | BIT(num + 16), reg_ien);
>> +                       bank->irqinten |= BIT(num + 16);
>> +                       return 0;
>> +               }
>> +
>> +               if (type == IRQ_TYPE_LEVEL_LOW) {
>> +                       writel(readl(reg_ien) | BIT(num), reg_ien);
>> +                       bank->irqinten |= BIT(num);
>> +                       return 0;
>> +               }
>> +
>> +       } else {
>> +               writel(readl(reg_itype) & ~BIT(num), reg_itype);
>> +               bank->irqtype &= ~BIT(num);
>> +
>> +               if (type & IRQ_TYPE_EDGE_RISING) {
>> +                       writel(readl(reg_ien) | BIT(num + 16), reg_ien);
>> +                       bank->irqinten |= BIT(num + 16);
>> +
>> +               } else {
>> +                       writel(readl(reg_ien) & ~BIT(num + 16), reg_ien);
>> +                       bank->irqinten &= ~BIT(num + 16);
>> +               }
>> +
>> +               if (type & IRQ_TYPE_EDGE_FALLING) {
>> +                       writel(readl(reg_ien) | BIT(num), reg_ien);
>> +                       bank->irqinten |= BIT(num);
>> +
>> +               } else {
>> +                       writel(readl(reg_ien) & ~BIT(num), reg_ien);
>> +                       bank->irqinten &= ~BIT(num);
>> +               }
>> +       }
>> +       return 0;
>> +}
> I don't understand why you don't set the irq_handler:
> irq_set_handler_locked(d, handle_edge_irq);
> irq_set_handler_locked(d, handle_level_irq);

I will add the irq_set_handler_locked().
> It seems you are not handling IRQ_TYPE_EDGE_BOTH?
> What happens if both rising and falling is specified simultaneously?
>
> The if/else nesting is hard to read.
> switch (type) {
>          case IRQ_TYPE_EDGE_BOTH:
> (...)
>          case IRQ_TYPE_EDGE_RISING:
> (...)
>
> See drivers/gpio/gpio-ftgpio010.c for an example.

We'll refer to this driver to modify our code.

> Have you checked that handling edge and level IRQs really work
> as expected?

This driver works with edge or level IRQs in linux-5.10, and some 
modifications
have been made for upstream. We'll verify if it also works in linux-6.9.

>> +static int ma35_gpiolib_register(struct platform_device *pdev, struct ma35_pinctrl *npctl)
>> +{
>> +       struct ma35_pin_ctrl *ctrl = npctl->ctrl;
>> +       struct ma35_pin_bank *bank = ctrl->pin_banks;
>> +       int ret;
>> +       int i;
>> +
>> +       for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
>> +               if (!bank->valid) {
>> +                       dev_warn(&pdev->dev, "bank %s is not valid\n",
>> +                                bank->np->name);
>> +                       continue;
>> +               }
>> +               bank->irqtype = 0;
>> +               bank->irqinten = 0;
>> +               bank->chip.label = bank->name;
>> +               bank->chip.of_gpio_n_cells = 2;
>> +               bank->chip.parent = &pdev->dev;
>> +               bank->chip.request = ma35_gpio_core_to_request;
>> +               bank->chip.direction_input = ma35_gpio_core_direction_in;
>> +               bank->chip.direction_output = ma35_gpio_core_direction_out;
>> +               bank->chip.get = ma35_gpio_core_get;
>> +               bank->chip.set = ma35_gpio_core_set;
>> +               bank->chip.base = -1;
>> +               bank->chip.ngpio = bank->nr_pins;
>> +               bank->chip.can_sleep = false;
>> +               spin_lock_init(&bank->lock);
>> +
>> +               if (bank->irq > 0) {
>> +                       struct gpio_irq_chip *girq;
>> +
>> +                       girq = &bank->chip.irq;
>> +                       gpio_irq_chip_set_chip(girq, &ma35_gpio_irqchip);
>> +                       girq->parent_handler = ma35_irq_demux_intgroup;
>> +                       girq->num_parents = 1;
>> +
>> +                       girq->parents = devm_kcalloc(&pdev->dev, 1, sizeof(*girq->parents),
>> +                                                    GFP_KERNEL);
>> +                       if (!girq->parents)
>> +                               return -ENOMEM;
>> +
>> +                       girq->parents[0] = bank->irq;
>> +                       girq->default_type = IRQ_TYPE_NONE;
>> +                       girq->handler = handle_level_irq;
> Does this really work for the edge IRQs?
>
> I recommend setting this to handle_bad_irq and assign the right
> handler in .set_type().
>
> Yours,
> Linus Walleij

OK, I will fix it.


Best Regards,
Jacky Huang





