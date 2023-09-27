Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073C57AFBAB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjI0HIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjI0HIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:08:01 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D44126
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:07:59 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-495eb6e2b80so3723759e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695798478; x=1696403278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Kv7jmytR7Cl6Bx7jgRq1B3ANrXCvmoOcRtFgOD3gcI=;
        b=pWu1N9kKYNfkf2L8zwU5+ixnjjs5w7pUivF4m8G+A7JLIN1kvI/SwlZIGFmrmy82B1
         v3EYcIk91rM4BrrYZbii++MhHd0ytAFbXWSXpcyk/zl/tqJEah9MmpiQY4Co5Vj8ndL4
         ArtqurEQFS2IVuANFul2AM/R4KApZ+uDKUxwoPLBod55P7CH4es2ubX2OATTMJXU/N6w
         I7kswNOWzNXbcTjvEHo69BdLuwRZxQXKNsYTxoaShZghK9rcxGRUofK70b+IFzrCu45J
         L+N7gEw2aaZFk9kKpp1otPBTzxVo3YIytrTY+VRt/T6KiLm0lpE7q3OekC0zs21GAiDy
         DL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695798478; x=1696403278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Kv7jmytR7Cl6Bx7jgRq1B3ANrXCvmoOcRtFgOD3gcI=;
        b=ROBEbAZlj+6NNY2imbfgG4gtFEJ5Ik2xJMPdVnmIb1MTgzx5Qko3Jx7SiPjTNZYgyJ
         f7RZE5Io8UggFRmS1i7oS1cvbQCV3oJm48dZCB7sv2lByb+kRIXwt2HU5kohGNHOPFgI
         Osr/MD72bXhq+LHYlzywGwjdLjMs8RSCUBimquyFy2ebUEtjQlEGZkhWnqYW3uee7vKm
         7APcOL1hXlNLRCbUZMTi1izLCagyXkT2IZIcHK7IVB9UWwt9gfUXYWe9gq8C66787Ojg
         V1BwYxzOHsI9kcYELdTwcI+ur6DuCbhTE5zut/oUBoc/XiVLKWOCHdLgv8surIzzcq5x
         MkQQ==
X-Gm-Message-State: AOJu0YwEImg+MnmMnlUhvS6UjlIxiNrpeHKfh3dia/YuBwva9GfvLsvp
        T+KL4+JuY85ipObAecYYKJyXTuU9WDry4fZ+DHMl1g==
X-Google-Smtp-Source: AGHT+IHDPQqjVDxDkNQNRwSlqWvkdkMkG91cF3xhgI47OCkvieSGjCc5ncnHUbGVptN6z7XZUtIZRPt8+tugLd6HTj4=
X-Received: by 2002:a1f:d5c4:0:b0:495:bf5b:7e49 with SMTP id
 m187-20020a1fd5c4000000b00495bf5b7e49mr1005244vkg.13.1695798478435; Wed, 27
 Sep 2023 00:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230921015247.23478-1-zhuyinbo@loongson.cn>
In-Reply-To: <20230921015247.23478-1-zhuyinbo@loongson.cn>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 27 Sep 2023 09:07:47 +0200
Message-ID: <CAMRc=MdHcqd=3-Sd5U3nUR=fkzTEFo=UFn91E5G3VHTu=Y9qdA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] gpio: loongson: add more gpio chip support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 3:53=E2=80=AFAM Yinbo Zhu <zhuyinbo@loongson.cn> wr=
ote:
>
> This patch was to add loongson 2k0500, 2k2000 and 3a5000 gpio chip
> driver support.
>
> Change in v6:
>                 1. Add a reviewed-by for gpio driver.
>                 2. Rework the commit log.
>                 3. Replace changes to "u32" in loongson_gpio_chip_data.
> Change in v5:
>                 1. Use boolean initializer for lgpio->chip.can_sleep.
>                 2. Remove the code that about io width gain from ngpios.
>                 3. Fixup the ls7a-gpio and ls2k-gpio items in yaml file.
>                 4. Add the reviewed-by information for dt-bindings patch.
>                 5. Add some comments in loongson_gpio_to_irq.
> Change in v4:
>                 1. Reword the title and commit log information.
>                 2. Remove the offset parse in DT and add it in of_device_=
id and
>                    acpi_device_id's data field.
>                 3. Add more gpio chip dt-bindings support in yaml file.
> Change in v3:
>                 1. Reword the dt-bindings patch commit log information.
>                 2. Add "loongson,ls2k1000-gpio" compatible.
> Change in v2:
>                 1. Reword the patch commit log information.
>                 2. Add some GPIO register offset description in yaml.
>
> Yinbo Zhu (2):
>   gpio: dt-bindings: add more loongson gpio chip support
>   gpio: loongson: add more gpio chip support
>
>  .../bindings/gpio/loongson,ls-gpio.yaml       |  21 +++-
>  drivers/gpio/gpio-loongson-64bit.c            | 119 ++++++++++++++++--
>  2 files changed, 127 insertions(+), 13 deletions(-)
>
> --
> 2.20.1
>

Queued for v6.7. Thanks!

Bart
