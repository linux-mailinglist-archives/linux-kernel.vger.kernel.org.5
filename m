Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FD08067B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376839AbjLFGqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376927AbjLFGqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:46:25 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB401B6;
        Tue,  5 Dec 2023 22:46:29 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a18b0f69b33so88742466b.0;
        Tue, 05 Dec 2023 22:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1701845188; x=1702449988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7HVLCsTwM0AJQ7P3LEZ/Kcz/0E6qcEp8zHBIIWNc8vA=;
        b=ZbKzSgV8f192+itH71EniBFxt5g2qsrW1o8EeSHptbqSM/JR/f5SMxHefUjJvBi/u4
         OZIUsnv6EwbP/0ZDIwAlurVJi6CpFWs/V50z33bsi+vNVqJRpPxgpfivhklFYCLDNDql
         Aiw0WFb85IKcoEygcPv4BY5d2A/OyqYKka9cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701845188; x=1702449988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HVLCsTwM0AJQ7P3LEZ/Kcz/0E6qcEp8zHBIIWNc8vA=;
        b=eiCwTNcviModvui2KJfIQ3/adgKKhxwD14abfDjP44ERWj9lPN1btqqRCxjra9qPfY
         RCgodRYpNLtaOjxNGIPOuE0WXfb3jcFYtzT0DZLCIYoXn74AxMnWoarN5CNxmG4JH5L+
         JNjcoWAvcndqXY+pYLH0TdhTTW5RukH+eC02uehgOdI0OYY/8n2sAEMk42y8fRAs3ldZ
         EFO4Cs5xr74kKyI1ko2gucKFPG76v2GHKNU8GFXO5mTW2UBU0NO9K4GVgjX2YkICMl37
         GH8z9NNcvyMEZuI7qMOYXrME0lCVQp9Inhf5qHgTfnF7cG6O0y1NY7BWRJ/DEWVGSKFo
         guqA==
X-Gm-Message-State: AOJu0YwHNqxedtw85yWhPJMq27nw1SWs3IU/2BAQYnsGaJXKc74AKCLb
        jUJ5lv4IjZGf/OdeXFnfiov4K/pYzTK1jYVVmsw=
X-Google-Smtp-Source: AGHT+IHk5A7B0U4wO24pz2HCwBWIvrSswHBxiBDm7juowHDhQdsr4u3Yd57RZEy+FbH8wjd9qhmCMTkRudGz8aw8gBA=
X-Received: by 2002:a17:906:c292:b0:a1b:75f6:165c with SMTP id
 r18-20020a170906c29200b00a1b75f6165cmr2521102ejz.52.1701845187768; Tue, 05
 Dec 2023 22:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20231202003908.3635695-1-renze@rnplus.nl>
In-Reply-To: <20231202003908.3635695-1-renze@rnplus.nl>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 6 Dec 2023 17:16:15 +1030
Message-ID: <CACPK8XfhK8eSjYvEd=7WshOh+Sj6vrERxwgAYGitVALw0pUf8w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC
To:     Renze Nicolai <renze@rnplus.nl>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@aj.id.au
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2023 at 11:09, Renze Nicolai <renze@rnplus.nl> wrote:
>
> Hello,
>
> These patches add a device-tree (and a bindings update) for the
> Aspeed BMC on the ASRock X570D4U, so that it can be added as a
> supported OpenBMC platform.

Looks great!

Reviewed-by: Joel Stanley <joel@jms.id.au>

I've also added this to the openbmc tree, so no need to send the patches there..

>
> Changes since v2:
>   - Renamed leds to led-0 and led-1 to match Documentation/devicetree/bindings/leds/leds-gpio.yaml
>   - Added aliasses and labels for the i2c-mux on i2c bus 4
>   - Added the missing blank line between the ehci1 and uhci nodes
>
> Greetings,
> Renze Nicolai
>
> Renze Nicolai (2):
>   dt-bindings: arm: aspeed: add Asrock X570D4U board
>   ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC
>
>  .../bindings/arm/aspeed/aspeed.yaml           |   1 +
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 377 ++++++++++++++++++
>  3 files changed, 379 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
>
> --
> 2.43.0
>
