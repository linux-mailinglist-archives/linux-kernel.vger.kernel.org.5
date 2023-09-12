Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1079C82E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjILHaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjILHaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:30:10 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3605AB9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:30:06 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58dce1f42d6so87777427b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694503805; x=1695108605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unPVobRM22LDRXatS2haaX8kK4OxybTIEnwtiD0j4Ro=;
        b=LcebRSBmD2CfJptfZhj0B7VomLDYysu72x6c4cIwSKNrNvHgXZ2mi+/yd7qTHb1CMf
         SijqhVZZD60kRkti3kfJJkIkSn9hpnzOo6KFvGJOisUlqDW2bSfF8RkxZcvFe9+nnjpL
         w4jk6oi+AkLfpyPZlzx1uyp73kbLyJJtBVEdr8fZQ9qVAQ7PGXTECE5eVohehAT9EmDn
         Rwie1A9QY25HzMbAlbqxaJnCOxwZqXnjIaqz4c2NZxRyclR1UnqRV9e7+Z0gM0y4al7+
         sTz6sL9q6qbME6Vw6M/9yeo4zd//C2kQuyv42ISwdvU6vbfhCOvf3MPbmd60eWA/lf6X
         XbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694503805; x=1695108605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unPVobRM22LDRXatS2haaX8kK4OxybTIEnwtiD0j4Ro=;
        b=Smdw142cLV0u6AeKsL5gUKKe1GZuNacIRbjzslZjN+rPHPrJOBV8uLGpoU3iX3P9Ur
         GG4CLr8qMoD0TVDfQOZw0czth1eEAI9Lq9MOCXinauwKZyLbLlDpyG6ztVxXClIyuSj2
         nCggndx2cW7mbjKK1P1lu6zTF9DxzkmAquhD5l1T5FQ5ZarZ4yMGeWqun/Lm3XfvA0Ec
         VWYg72EjafwqTo5fxLH443dBBH5WpKXSwNfLibgF3WpBnedvlHZ5b7gLXOHaiLweB3C+
         VfkOjjuWsaS0akCaXsp18xErgp3IRG2WHfZmolH+FBpTnV7zOq+TLTQSXN9DssWEdPxy
         NuvA==
X-Gm-Message-State: AOJu0Yy2n0NkzNMnhGS6ZFx1lfTUrSVnXHfEVqH1zii7RxShmXcd3F4A
        yPiHa7QrTeBrs/YXqNUZBuJxFGa8Dro40Y3+nzGVFQ==
X-Google-Smtp-Source: AGHT+IFuMocdUdm0DQ7vAdItPne7ZF/NofX2VpqhARe6RacyjXh8MaYxl0YUcbuPEZM23kydIOPp++zktlGUwAvUyiw=
X-Received: by 2002:a25:d30e:0:b0:d7b:9705:96e3 with SMTP id
 e14-20020a25d30e000000b00d7b970596e3mr2336071ybf.8.1694503805439; Tue, 12 Sep
 2023 00:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230901112926.13216-1-brgl@bgdev.pl> <20230901112926.13216-2-brgl@bgdev.pl>
In-Reply-To: <20230901112926.13216-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 09:29:54 +0200
Message-ID: <CACRpkdY4nqNv6Xt0hO13ohghWtxyTgUw7PNorDgfnye-CSmZ7g@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: da9062: add missing include
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2023 at 1:29=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> gpiod_is_active_low() is defined in linux/gpio/consumer.h. It's only
> because we're pulling in the gpiolib.h private header that we get this
> declaration implicitly but let's fix it as that is going away soon.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
For allt three patches.
Just apply them to the GPIO tree, that's easiest!

Yours,
Linus Walleij
