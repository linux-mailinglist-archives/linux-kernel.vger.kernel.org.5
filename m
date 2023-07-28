Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A7B7676AC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjG1T6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjG1T6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:58:46 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E193C07
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:58:45 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a37909a64eso1993672b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690574324; x=1691179124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOz/xiFr6Lpg5C5vNZBLjx/aE5FgujEgkR6UJsFwc8Q=;
        b=YfiqFaNGI47iAR+b/z2vg/KlNoAbPZ/Oe0fVrGyDKo907rX0xbVwf884ADFbkGRfoz
         ieNm2vAG9QNnQdT+f2RgR0yFTAes9+aMMsP8GugPB1OvpQkNykKL9N1R7p+/QHITEo+s
         aAmGNPvIKwX+z92nENUF4mJEP1+UNl73R07favImFpFFE220X450QZxpPdi7DyTkUnrb
         8kR2YlU9YGYsebZK7cMrDq5PDDjBOASmotm7qzxkh52htjgmLsCn2+DSaVpDweJAobxl
         sjDKLiIgyvw/cg92cfY35vNEbpsFG6yCjBq5FiHT73MZP7t1eiLKiunL8Iz23GgQYxno
         /9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690574324; x=1691179124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOz/xiFr6Lpg5C5vNZBLjx/aE5FgujEgkR6UJsFwc8Q=;
        b=L3bndGvPH4HEiXVL/fK1vhaCvbSeqGLNjroLBzTs0tBrVT1cRzQ9MA4qmG86WPu1X8
         Q33HsGCZMY/ROzxYGwu/qBuH60V/WuYNkSvocHBK8T78vJekdjdoa1aHbJ6z2nS1rqby
         UZmphsE5A0Uor2KRH0dNZG3k+OCmS3EizF/zr1vyayhZsTHe8XcTUIEzcKbAByaRDmND
         J0NRT4p+bHW6WGrgkuttHcQnWBqF5ZplnTIKsytsaS7rxBlMqabuQzw9l55qbheNzJj7
         WThmSGQhpQhlZXIuyCB8g3LllTx2Y81xlxl2y1j/ZuyCZRGuFGttEMhyKegUT8rSWgP9
         ZsFQ==
X-Gm-Message-State: ABy/qLbGtXJStXXWMe+Hd27aOnkYdkPX0V5MKTts9powHpp3hVUymOUA
        4CxxiFq/O9f8ipZzaGr2+PS/JtQCWON8HFge85jo1w==
X-Google-Smtp-Source: APBJJlHk37Vclt39f+KLJMdrQ7UsaQ0tZEv3cDZnJ6rhjJbQMOQr/oolj1cGCV4RTctUX4rC9c+lTQFhi5rpNeGNoVE=
X-Received: by 2002:a05:6358:5916:b0:139:65ca:5d6 with SMTP id
 g22-20020a056358591600b0013965ca05d6mr4570664rwf.25.1690574324680; Fri, 28
 Jul 2023 12:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <ZMQU7ap9CxfY5eIu@standask-GA-A55M-S2HP>
In-Reply-To: <ZMQU7ap9CxfY5eIu@standask-GA-A55M-S2HP>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Jul 2023 21:58:33 +0200
Message-ID: <CACRpkdbzWt7BRfFNAZnptTkVHvp34baOnY3ZfR+1JMDJvRS2Mg@mail.gmail.com>
Subject: Re: [RFC] dt-bindings: gpio: brcm,kona-gpio: convert to YAML
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 9:20=E2=80=AFPM Stanislav Jakubek
<stano.jakubek@gmail.com> wrote:

> Documentation/devicetree/bindings/gpio/brcm,kona-gpio.example.dtb: gpio@3=
5003000: interrupts: [[0], [106], [4], [0], [115], [4], [0], [114], [4], [0=
], [113], [4], [0], [112], [4], [0], [111], [4]] is too long
>
> Here I'm not even sure what the issue is.

(...)
> +  interrupts:
> +    maxItems: 1

^ There

> +        interrupts =3D <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
> +                      GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH
> +                      GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH
> +                      GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
> +                      GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH
> +                      GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;

This is more than one item.

Yours,
Linus Walleij
