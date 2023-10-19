Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90CF7CF226
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjJSINk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjJSINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:13:39 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AADC121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:13:37 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7b3d33663so103093027b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697703216; x=1698308016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9fhwJmlR888T70x9Uiw048WLxhTWy/cYSAVt4Gvh1A=;
        b=TA8w8XQhS0CYGJ8/hoZ94FUOBWfWMuiFzgh+tI/t3kc/ryQ8MAqa3BGTkKUSXvzB3a
         OMSASFciFqA/c/MEbWOGIlbMkfQqODORyu7ZxHG4y86yb0hNHCPEMT4lI0G3H1vk/d0u
         7iwG8krNXWCp5W2h+qwM0gqJuOz9LbVwIpf+mN6uM8geS+h0xQWIWCsW9YK4uq5C+EiT
         GXb/1HC8FcZ03pDui9yveZokgp+R1MMqE10mdpr31GAhI8Zp9HA2OgkGooNDK8+i6pMC
         vQA0asLhfpXjdaWZyWDvQ0thPVUyd+b0kKj1Rg/U+4HfuY8Fx2lFxmY4Ram8iRB4dS+D
         BuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697703216; x=1698308016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9fhwJmlR888T70x9Uiw048WLxhTWy/cYSAVt4Gvh1A=;
        b=ChVgLorZpbvIfOR/tAtxwBkaqEsDD53veWM4xWmYBQEMDRLWlcpA30xt0SZwSEWfb+
         C9xvM+640/6ROh8+31yMyh2oPSXBz33dbtalPYy8fQ2XbhqYk6fqCV5xECa6i0WGRNDU
         d2k32ftvxFKv30O6aoYtvimf8/6ZnqwGwG8r6npFRy1Pd3cpEEgdgY50AkojtP5w8Za+
         PgcQiZIPCRJsEMiTry9RjouveHQdgcK27c6FbeX+92rMhZyLHoPPl164FQfBIuuP34NY
         /VpDARgQrlH577bFLbUKGDtYk4HxuSCnLeUJOjIY97AAJ6xPrlua9E+kWcDbL6u9xUQ/
         jAxw==
X-Gm-Message-State: AOJu0YwRktCNKojlyk7bWy9rriLaeGegeq4/BR+6yC8b62/WyQwKVn0Q
        IdsZyX+1XScgPWTb2S91RoKGeze4gqUJ21ViCyJ/PJqhI3/MYhwZ
X-Google-Smtp-Source: AGHT+IHBd1+CaBIqmM2Ccl54AyWx1wdFGrKQjzy3cvBUKP57YP7Xo7lRZQp/InkGvDJiozj5p0zCtls8KQ/5oXL7mi0=
X-Received: by 2002:a0d:d303:0:b0:5a7:d9e6:8fd4 with SMTP id
 v3-20020a0dd303000000b005a7d9e68fd4mr1691317ywd.12.1697703216544; Thu, 19 Oct
 2023 01:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231017141806.535191-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231017141806.535191-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Oct 2023 10:13:25 +0200
Message-ID: <CACRpkdYZonHWTtArvYLGBWJz6rae-aDHS5J5QHtzAb7qCkxTKQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Revert "pinctrl: avoid unsafe code pattern in find_pinctrl()"
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 4:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:


> The commit breaks MMC enumeration on the Intel Merrifield
> plaform.
>
> Before:
> [   36.439057] mmc0: SDHCI controller on PCI [0000:00:01.0] using ADMA
> [   36.450924] mmc2: SDHCI controller on PCI [0000:00:01.3] using ADMA
> [   36.459355] mmc1: SDHCI controller on PCI [0000:00:01.2] using ADMA
> [   36.706399] mmc0: new DDR MMC card at address 0001
> [   37.058972] mmc2: new ultra high speed DDR50 SDIO card at address 0001
> [   37.278977] mmcblk0: mmc0:0001 H4G1d 3.64 GiB
> [   37.297300]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10
>
> After:
> [   36.436704] mmc2: SDHCI controller on PCI [0000:00:01.3] using ADMA
> [   36.436720] mmc1: SDHCI controller on PCI [0000:00:01.0] using ADMA
> [   36.463685] mmc0: SDHCI controller on PCI [0000:00:01.2] using ADMA
> [   36.720627] mmc1: new DDR MMC card at address 0001
> [   37.068181] mmc2: new ultra high speed DDR50 SDIO card at address 0001
> [   37.279998] mmcblk1: mmc1:0001 H4G1d 3.64 GiB
> [   37.302670]  mmcblk1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10
>
> This reverts commit c153a4edff6ab01370fcac8e46f9c89cca1060c2.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied for pronto fixes!

Yours,
Linus Walleij
