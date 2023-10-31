Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0967DC35D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjJaABB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Oct 2023 20:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjJaAA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:00:59 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475CCFE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:00:56 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9d2d8343dc4so309785166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698710454; x=1699315254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZVJKfi+PzDUAtiv1q8ocAV1+Plo8zxDJySpo+IH4+c=;
        b=GcqL+KquePlT5kNsRHCALlx9FK6qU74VejOaMuxyUfDZwHhJzRY6hXGkKBDcATMFe2
         Hfv38STRTbBPbR4W0rSZ7U6UHG9Cm/2JYv2D6D3viJzcTdvdTK3fxK4HNmZ3HPSn6Gjo
         2ByNeECcWQyuxo/7xTDKxkkntKYsWrCzPOwy2/q1M8WI87hLve+r28Gk2ZWFlLNY/XkL
         EwNlhwW5OH6K47o7lRnkAZN0ZsKjCWzdqWZ7Hhoh7lunPSECYpyGaP2LihQIhKtziVBw
         CS2I/KBQ/8Jy8LK4wlkDs7zS0QYnkVBdyL7h86cRkQ5LhxU3ltF1yuz0eXTuOdNraLpj
         gwvw==
X-Gm-Message-State: AOJu0YwKmIEF29HHKUHrSZxYwLWTYcNwLuHj4uVtsPJZoqdGoMGaMez2
        1zOuEyAOWmkD5rLjyHoJZeUZNz30Ox+GUXNr
X-Google-Smtp-Source: AGHT+IFyPPx2Pzsh8O98vZPR5H23aUEKnjZbMKdKfA+xXeEpbxbmG5ieV/NLn8t8r5w4tt4ALE2iqg==
X-Received: by 2002:a17:907:8f0d:b0:9bf:5771:a8cf with SMTP id wg13-20020a1709078f0d00b009bf5771a8cfmr6271394ejc.70.1698710454181;
        Mon, 30 Oct 2023 17:00:54 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709062a9100b009737b8d47b6sm54365eje.203.2023.10.30.17.00.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 17:00:53 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-991c786369cso813302066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:00:53 -0700 (PDT)
X-Received: by 2002:a17:907:8f0d:b0:9bf:5771:a8cf with SMTP id
 wg13-20020a1709078f0d00b009bf5771a8cfmr6271380ejc.70.1698710453646; Mon, 30
 Oct 2023 17:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231030142620.818663-2-robh@kernel.org>
In-Reply-To: <20231030142620.818663-2-robh@kernel.org>
From:   Neal Gompa <neal@gompa.dev>
Date:   Mon, 30 Oct 2023 20:00:16 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9CsN2-GYL9hnwwYhX=B8P-M1tZfmdrQNrWtGOMTWiChA@mail.gmail.com>
Message-ID: <CAEg-Je9CsN2-GYL9hnwwYhX=B8P-M1tZfmdrQNrWtGOMTWiChA@mail.gmail.com>
Subject: Re: [RESEND PATCH] soc: apple: mailbox: Add explicit include of platform_device.h
To:     Rob Herring <robh@kernel.org>
Cc:     soc@kernel.org, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 10:27 AM Rob Herring <robh@kernel.org> wrote:
>
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other and pull in various other headers. In
> preparation to fix this, adjust the includes for what is actually needed.
>
> platform_device.h is implicitly included by of_platform.h, but that's going
> to be removed.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Note this was added in the merge window and missed the last round.
>
> Arnd, Can you apply this directly.
>
> ---
>  drivers/soc/apple/mailbox.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/apple/mailbox.c b/drivers/soc/apple/mailbox.c
> index 0cbd172f435e..780199bf351e 100644
> --- a/drivers/soc/apple/mailbox.c
> +++ b/drivers/soc/apple/mailbox.c
> @@ -26,6 +26,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> --
> 2.42.0
>
>

Pretty obvious patch.

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
