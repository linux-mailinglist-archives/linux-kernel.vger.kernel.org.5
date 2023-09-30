Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC867B41C1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjI3Phk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjI3Phi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:37:38 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FB9EB
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 08:37:31 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59f7f2b1036so127911547b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696088251; x=1696693051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iij7GZPs4ta7mpI/DDP/sOC6B5pAs6vBvsF5JU59Dng=;
        b=sYzo6XUj/VGXsS/c+8iIR/YiKUJBwnimrOMTrD+9AUnOIlUUa+wIQpkqJpMyHu/bf3
         d4+1cDx5AvDqd5noI/NmQZhb10XCf2l8YeZJ+vjZgD/EBXHWLMG0DGxPXcTDNouaD37Y
         KptpNMaeTeRLAfOvYv4NWBe6a6fVZvxUlO7i8GMXc8wVhc5FpGVv285qRKt5d9Yz6M4a
         1jh5qc3Bj6I612sXZ9g4DcjZS0+7mfrkOudLL53a6W8DsPdyyCnMvvXD5BY4B3bJJJ5O
         /vNzBAyqjW70SEluDVl5R9zhVXvcSV6igSvORQ4pfcYfRmUEV0/CJ5ttuXWQddP3dS0N
         r+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696088251; x=1696693051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iij7GZPs4ta7mpI/DDP/sOC6B5pAs6vBvsF5JU59Dng=;
        b=ZYUqWotB+aVFHvBDO/ANVkNoEbVg91XclQng2Z3XPYdv8tUc+zfclad8S82PAwBeGq
         66wMaNh1/qqWBhXuaES430LRp6Oh8i7oLMCqtwJsGl/p+o5FUt7/nzKLR839L0oxBTpt
         B3TkhKheCmP+EOgByaPlMo1O9TZxLOVu291A8wBufHUMoOWTorjrjkJzWdUOpp0fK3jK
         cwSD3Yw7G5F3vSfPLhVdlTHLZB+E+l42A7b3eXPACyp11qZI/2cOYwHkNQXSjKSm1zuT
         xFfQ0xz9XqILt5A09IGdNxaDL+Y4F/LEx4XjYPf8iKt+lFiAHNUGdMBi2/AphxMFZOrG
         cxqw==
X-Gm-Message-State: AOJu0Yyd4Z28Lv4uzi7RDrHUFIG8PJTk92CZovRUJM6IqifieTipT+mn
        wcPpgiPhrnZ/B8uYYdjvtbFRcVrCYWZsDVZrYAK6eQ==
X-Google-Smtp-Source: AGHT+IGFEGxNW9iad1m1hopLGKbkXI8hjBmpaUfewF+ozAfJ+lrOwUFw+LD1rcN0USj40MfR4GqG12cZk9y2+fvzoII=
X-Received: by 2002:a0d:ddc1:0:b0:5a1:d4bc:7faa with SMTP id
 g184-20020a0dddc1000000b005a1d4bc7faamr7394744ywe.18.1696088251028; Sat, 30
 Sep 2023 08:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-pxa1908-lkml-v5-0-5aa5a1109c5f@skole.hr>
 <20230929-pxa1908-lkml-v5-7-5aa5a1109c5f@skole.hr> <CACRpkdb=8LU9Mkkn_VDcTGoH1pWn=hp9ZhN5dLm5pykif8cp-w@mail.gmail.com>
 <5715527.DvuYhMxLoT@radijator>
In-Reply-To: <5715527.DvuYhMxLoT@radijator>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 30 Sep 2023 17:37:19 +0200
Message-ID: <CACRpkdYOLjZ2thKdR7JoYxa2gr078AHO6JXu76fUU+dBzG7MPQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 7/8] arm64: dts: Add DTS for Marvell PXA1908 and samsung,coreprimevelte
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de, balejk@matfyz.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 10:25=E2=80=AFAM Duje Mihanovi=C4=87 <duje.mihanovi=
c@skole.hr> wrote:
> On Saturday, September 30, 2023 12:05:41 AM CEST Linus Walleij wrote:
> > But it exists, so I can't say you can't use it. Not my choice.
> > I understand it is convenient.
> >
> > It is possible to switch later, but only if you have a unique
> > pin controller compatible so please add that.
>
> Maybe a dumb question. I might want to do this at some point to clean up =
the
> device tree a bit, are there any such pinctrl drivers I can use as a
> reference?

Since it's Marvell after all (albeit a descendant of the 20 yo
PXA platform!) I would expect new Marvell SoCs to be more alike
the AC5 bindings that Chris Packham merged only last year:
Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
Driver:
drivers/pinctrl/mvebu/pinctrl-armada-xp.c
drivers/pinctrl/mvebu/pinctrl-mvebu.c

But if this pin controller is more related to PXA (Intel) hardware
than to either Kirkwood or Armada, you might want to do something
entirely different. It depends a bit on hardware.

Hardware such as pinctrl-single.c with one mux configuration
register per pin usually follow the Qualcomm way of doing
things, which is to simply have one group per pin, then that
can be associated with desired functions:
Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
this has the upside of using all the standard bindings for
bias etc. Driver:
drivers/pinctrl/qcom/pinctrl-msm.c
then qualcomm have subdrivers for each SoC calling into this
so you have to check "real" bindings and drivers such as:
Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
drivers/pinctrl/qcom/pinctrl-sm8550.c

Yours,
Linus Walleij
