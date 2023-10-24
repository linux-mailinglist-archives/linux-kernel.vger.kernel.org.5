Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601247D5124
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjJXNNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjJXNNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:13:06 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFCEC1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:13:03 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9beb863816so3975992276.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698153183; x=1698757983; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxhEyjBJFg+nNZl60fRB3lLtFYlPjJhwsqt5NZemaGg=;
        b=RpCMjppHRRvki1+EhUXQE1hk3PhN2xBMEc90YbZT47xFduEYB/RplO1yzh+5W5JXxW
         cfd7Imak4NFCbsfivqgrRFY2EzoO6ucpXYbQtEwBew8oJxI7zT659Cb/FdV6OUL7gsN3
         Vj/CzTN7CDkY3yONNnB9cDMzBlYkZ6Tr2CwhAd1gfx6JQJaLX9acYrR8al747t5akHhC
         as5o9ejjpvkR2QMbBYty6DUIkdnFSLP4eX/uaVvSe9OS889p8cAF50oUeKAPHl9gHu/z
         ZnYml3FrYmE0uanPZDc7feKSNl8ZOBF89+HTMzaAkMfTiSAJRfuNdG+RhLkep5NNPz7K
         nM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698153183; x=1698757983;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxhEyjBJFg+nNZl60fRB3lLtFYlPjJhwsqt5NZemaGg=;
        b=ZA8uX4OzmJl83k5PA6jSmvXvmKiZGx63FItppb1HPJ0au8v2QFGMLYTOAedAmGv830
         X2gguSKNOhHLLgI5btzx3kh/EPjPt+64ZNCuwI43QuYobYt8lbn+hMen6A2JWKZnNx1M
         cugonxpkydwRRqE5sLSsBexpMIfctmUTCQMIJCmCfm2WY5gGv1YdNHvwx5H+coyYu2oo
         hUKBkGGa9debe8tWi3zhM7wTzagL1PzdHmjxYGsrDlbuw1nhT+eQ6wGX9kHQSX4Hj8gP
         mkPoyKzfk1uQ3KsCOTUu6NtiG3SkSPMs3VFp7C6byB+hv9yVsWUSZUU6ZP2obUlZ1wUM
         MDAQ==
X-Gm-Message-State: AOJu0YzqfUnZ11gC4OoiINaKZRXYG9+SaHIfTX+YzOwXSOt+Ah+Zt4T0
        UPzwvTpeRoQzjV7q8n9NVbfyY5jygRquN8cTI7Mmkw==
X-Google-Smtp-Source: AGHT+IErrrJZqHr9Mi8c9Lwy4ZFjFvA+JxkTdG5/38hd7daxCpYKkX6EQ4emeikgVsqQo7An76DCm1JB7nJUvPuC/IU=
X-Received: by 2002:a25:dc52:0:b0:da0:4bda:dc41 with SMTP id
 y79-20020a25dc52000000b00da04bdadc41mr1112835ybe.37.1698153182803; Tue, 24
 Oct 2023 06:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
 <20231005025843.508689-6-takahiro.akashi@linaro.org> <20231006132346.GA3426353-robh@kernel.org>
 <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com>
 <ZSTgTC4cFFpofYAk@octopus> <CACRpkdYD6pkccYoy90AfzV3KT7oYkBPD2_4ZW-AXzT1eUVpchA@mail.gmail.com>
 <ZS3yK/f12Mxw9rXe@octopus> <CACRpkdarDrVkPmyDawhZ+H94S4F=dtDSDVuKegi-eNfQNDY3rg@mail.gmail.com>
 <ZTduWx7CH1ifI5Uc@octopus> <CACRpkdba=echR=rZYKVbROfaOp4mzjTQ9RphHFyzqSNgE1jZqg@mail.gmail.com>
 <ZTemAK/jBtv9b5xP@octopus>
In-Reply-To: <ZTemAK/jBtv9b5xP@octopus>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Oct 2023 15:12:51 +0200
Message-ID: <CACRpkdY-5uS9EeXfDFVOiRKiFmwwSn3jRVGhT-n4JMqesHEumw@mail.gmail.com>
Subject: Re: [RFC v2 5/5] dt-bindings: gpio: Add bindings for pinctrl based
 generic gpio driver
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 1:10=E2=80=AFPM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:

> As far as I understand, there is only one way for SCMI gpio driver
> to know which pins are actually GPIO pins; Calling PINCNTRL_CONFIG_GET
> command with "Input-mode" or "Output-mode" configuration type
> against *every* pin-controller's pins.
> (Here I assume that the command would fail with INVALID_PARAMETERS or
> NOT_SUPPORTED if configuring the given pin as a GPIO input or output
> is not possible. But the specification seems to be a bit ambiguous.)

As I also wrote in the reply to Christian, I expect the SCMI firmware
to consider GPIO a function on the pins, and either individual pins
(groups with just one pin in it) or entire groups of pins can be switched
to perform the "gpio function". ("gpio function" is akin to "i2c function"
or "HDMI function" etc.)

If the SCMI protocol considers GPIO usage to be something else
than a function of a pin, that is going to be a problem. Then the SCMI
protocol need some other way of determining that the pin is in
GPIO mode, and perhaps something would need to be added to
the protocol for that.

The reason is that in practice a lot of hardware has to decouple
the pin from any internal function in order to use it as GPIO, and
connect it to the GPIO block that can drive the line high and low.
And we don't select that as a function, how is the firmware going
to know that it needs to do this? Implicitly from the call requesting
the line to be output perhaps. But if the firmware can be altered
to do that, the firmware can just as well be altered to present
GPIO as a proper function.

Using a function makes most sense, because the board firmware
knows which pins are GPIO lines and what they are used for
(such as a LED or camera flash) and at boot certainly put them
into GPIO function and drive them high/low or set them as
input (high impedance).

> It means that, if SCMI firmware has 100 pinctrl pins, the driver needs
> to call the command 200 times in order to get the answer.

I think we should only need to check which function each pin
has and those that are in the GPIO function we put into the ranges.

Yours,
Linus Walleij
