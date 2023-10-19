Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7C7CF2D2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjJSIlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjJSIlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:41:15 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E938C0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:41:13 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7fb84f6ceso95132477b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697704872; x=1698309672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6AQg01B05VfxLnMzfZahoxxkINvDHMZFVJEwTU5qiRs=;
        b=MDSCLfo95pw2fv9SdKtVqjvd5JKHvnqH6lGt2ihk4fcargCmPzeE0dOWkOd1zNtS5R
         7TuQRG9+tiNQuZkSkcTKg5FvKtYi5GmlKsxeBV43caWsS6K+g0Pmo9KlnFl+A/utUeGG
         5Lq1Di0pjsnPHMs9+20TCswOyA1Bvay3c3f2eVOXkAB0J9yy0I0HBHa5Ua/zS+34JXW0
         gDJCojJ/JlkUki7Dr6kAAWXk8MURW8Kej5NO0T5zNPI5nGCi5tvAgZ64mPO6Ro9AGH0v
         m9zsbJ33clHWKyjY8Th/whBIBOTMZ/DzYNLnYypv11gN0exNeMJa8MEowHi0m5JjiAye
         951Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697704872; x=1698309672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AQg01B05VfxLnMzfZahoxxkINvDHMZFVJEwTU5qiRs=;
        b=KfUFcB9xAbHq4rI2TpQf3dBGKTAaW3PH1vPdK/ywwe6LKyEswiO92w7WW4ZxzorDF/
         CfNk3XmLsQYVEWxMfwiZyABpdBYl9OqHDoMNvrXcs/XquvJSJMIttZjJ4IkqVvycfQjl
         pdaKHyEkEb2ethHPf1m8i/zMUnu3RuvWaHEQL/xJ6SCNEBRNtsknDznOxzwNQS9Iro1m
         jGrJA0LSS46u41najLC6mebUxQL3ipZ4CJQmHw9VbBeUn4L9/yqG9bRvQ2V/6Te1Ssxw
         M5+DjlPiksMBFYQV4hfcv9dUjUbrhfYommhBdFsJB0zWYVvGHkUIMHM0Mv3nUHXfTJbB
         04Mw==
X-Gm-Message-State: AOJu0YzvykKWkENdVsn12wFGU/Ozc7rb/tA9viYHbWSHTr/Muo8gfUdK
        ZPxXadiwq4dhUD4YIUGcCw0FOWPj3xYzTaArwz4LfA==
X-Google-Smtp-Source: AGHT+IH+awz0omnFTL+lbrNdBB0/9ZvOfng7OfPr8K7GzodrPlfaoxNbYLrs1/otmeYwSJoBUiCKWnQaMrqZEr89J84=
X-Received: by 2002:a0d:ea92:0:b0:5a7:ba17:7109 with SMTP id
 t140-20020a0dea92000000b005a7ba177109mr1649073ywe.1.1697704872711; Thu, 19
 Oct 2023 01:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231019160616.55eac2b8@canb.auug.org.au>
In-Reply-To: <20231019160616.55eac2b8@canb.auug.org.au>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Thu, 19 Oct 2023 10:41:01 +0200
Message-ID: <CACMJSev3=yB8nziqxFgdZUSqdpv+ZjLQepZTopJOcfJ0NoGR8w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the gpio-brgl tree with the
 gpio-brgl-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 07:06, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the gpio-brgl tree got a conflict in:
>
>   drivers/gpio/gpio-vf610.c
>
> between commit:
>
>   fc363413ef8e ("gpio: vf610: set value before the direction to avoid a glitch")
>
> from the gpio-brgl-fixes tree and commit:
>
>   b57587f11f81 ("gpio: vf610: simplify code by dropping data check")
>
> from the gpio-brgl tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/gpio/gpio-vf610.c
> index 656d6b1dddb5,a89ae84a1fa0..000000000000
> --- a/drivers/gpio/gpio-vf610.c
> +++ b/drivers/gpio/gpio-vf610.c
> @@@ -126,9 -140,7 +140,9 @@@ static int vf610_gpio_direction_output(
>         unsigned long mask = BIT(gpio);
>         u32 val;
>
>  +      vf610_gpio_set(chip, gpio, value);
>  +
> -       if (port->sdata && port->sdata->have_paddr) {
> +       if (port->sdata->have_paddr) {
>                 val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
>                 val |= mask;
>                 vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);

Thanks Stephen, this is correct.

My for-next tree is currently rebased on top of v6.6-rc1 while the
fixes tree tracks Linus' master.

Once the fixes are upstream, I may just rebase my for-next tree.

Bart
