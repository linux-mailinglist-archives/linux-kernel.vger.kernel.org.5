Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1087886A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbjHYMKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244484AbjHYMKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:10:12 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CB2199E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:10:10 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d77a4e30e97so840057276.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692965410; x=1693570210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W1ZXaAxt+/qreECWmUwSQxF6mPK3tFp076msIpV1KBo=;
        b=YPJTawHEDHia5KYjZSr+WOlLLuYzo6IVvRtfvdu/oIYmgHGwTXkRPZ7g7rjLHlpXca
         uNu8RaKwMvDNWa8br1OtQFZN3rnH1gBXdR5Of2KZzT6W8aRb5mwU0HXJII1I9Q2PLTqS
         IOKCx0sey/2QVRgRKOpS4ujyDwIiN5FyxM5yS2YiDuDqOMgrofFZGUJmQPEm+g/NlzWq
         zaydvqtcJpJZV0jQct73GWP528FlptREalk2j7NMwkucH3CGDOetDYGCeiEMez2Q4NPw
         7qDiDVO809WVBJQYrJV7xJtiGW2GjvUFACKAOAxzUN1DHReJN22DN8X8mXrt8I5n4cmh
         vXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692965410; x=1693570210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1ZXaAxt+/qreECWmUwSQxF6mPK3tFp076msIpV1KBo=;
        b=XeCFkjLdYXh5gdIY+t3XU9m5Lf4fJX3HqVvPz9GjzscZoQJDn90PoiAeoy1EsVjmm5
         HPaKYRfOmThg85+gZ4H7FzdbKTo973xM8t76BvKQ3b1YOQzE3to2sowsvbH7cPV2PuNs
         MeBgOFroTs7cuvThQpcgOlQ0qZ9PJZlZbIQnmJpS70HlfIF7iMEdQWcWb4pXUDarFLef
         vMh/N/LZZmcxuWy/XH7NtkqpsZeQhL5TPymqxG+NlqPkR230ikdXH3lic2UbgGK0qVOv
         hG3cUbwZ8ljuOUnRRRbf76VYxP6m5VDt0e6wpHTwebC8b4WL0RSGor4/3omkVh8pCXEU
         1VWQ==
X-Gm-Message-State: AOJu0Yw3iLl1P/CZt/RMev6I1dcBpWqaBZ897M5K0zVCdSk856Qe1FUy
        PlqOt9nSzteLTGE8nuS5bkegqp0pj2I8B+wESM9cVw==
X-Google-Smtp-Source: AGHT+IExnGXE8C1EbVN7jY0Wc5ZWg3qZ07JB7Re+7JVXnXTnMc9Qbkxu+/lPq/5Jb49jB4fufcAmeKCbsT8MgEZb7DE=
X-Received: by 2002:a25:32d0:0:b0:d78:8eb:9924 with SMTP id
 y199-20020a2532d0000000b00d7808eb9924mr4283668yby.52.1692965409795; Fri, 25
 Aug 2023 05:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230825095157.76073-1-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20230825095157.76073-1-balamanikandan.gunasundar@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Aug 2023 14:09:33 +0200
Message-ID: <CAPDyKFrabm3gUJ1pfnq3PhROuRo_8TjocemMy93rJgDK04qqKQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] mmc: atmel-mci: Convert to gpio descriptors
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     linus.walleij@linaro.org, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, hari.prasathge@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 at 11:53, Balamanikandan Gunasundar
<balamanikandan.gunasundar@microchip.com> wrote:
>
> v6:
> - 0001-mmc-atmel-mci-Convert-to-gpio-descriptors.patch
>   Remove code duplication while checking if the device is compatible with
>   atmel,hsmci
> - Add Suggested-by tag
>
> v5:
> - Rebase to latest next branch of
>   https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
> - Move handling active_high inversion logic to gpiolib instead of reading
>   the raw value of gpio and inverting it manually.
> - Use PTR_ERR_OR_ZERO instead of IS_ERR. To avoid ignoring valid errors as
>   suggested by Dmitry Torokhov
> - Use gpiod_get_value_cansleep() instead of gpiod_get_value()
>
> v4:
> - Rebase on top of next branch
>   https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
>
> v3:
> - [PATCH v3 1/2] mmc: atmel-mci: Convert to gpio descriptors
>   Convert devm_gpiod_get_from_of_node() into devm_fwnode_gpiod_get()
>
> v2:
> - [PATCH 1/2] mmc: atmel-mci: Convert to gpio descriptors
>   Remove "#include <linux/gpio.h>" as it is not necessary
> - [PATCH 2/2] mmc: atmel-mci: move atmel MCI header file
>   Move linux/atmel-mci.h into drivers/mmc/host/atmel-mci.c as it is
>   used only by one file
>
> Balamanikandan Gunasundar (3):
>   mmc: atmel-mci: Convert to gpio descriptors
>   mmc: atmel-mci: move atmel MCI header file
>   mmc: atmel-mci: Move card detect gpio polarity quirk to gpiolib
>
>  drivers/gpio/gpiolib-of.c    |  20 +++++-
>  drivers/mmc/host/atmel-mci.c | 133 +++++++++++++++++++++--------------
>  include/linux/atmel-mci.h    |  46 ------------
>  3 files changed, 100 insertions(+), 99 deletions(-)
>  delete mode 100644 include/linux/atmel-mci.h
>
> --
> 2.25.1
>

Applied for next, thanks!

Kind regards
Uffe
