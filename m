Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA4F7BC8EE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbjJGPxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 11:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343934AbjJGPxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 11:53:39 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F97BA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 08:53:38 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a21ea6baccso38594507b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696694017; x=1697298817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIoRUVFu2cJ5wWu6WRbqqm267XrfNYzNwi2GVhtMIn4=;
        b=gRY+TGVpeTqIgehqGyZ6MvdoSL1RVeVwdLFJEN3d466nT4IS7HHMLFDRnktLaZfI4P
         289DWXG8/9WqzHKCM/EaERR/PZVz6IDZdQNj0Z6p/j4KqotchYQLouD5egv/b3YJWUMN
         jPOKM/k1CE7/aNHnFOcO3z/cb2OS+/X7zudMY9yHnClCIi03j3l+e7DPXjVfZ+29JrIp
         Bj1KGCDwFmv0ZYSpKiI/7uDa6i+LflQBnJD9g79tgiMXhcnOsHmnz7efhDYyLyBxoYZg
         Vpm8YMaJHRJkeJ6mpnTb2JF2YdCtq5zisSV0BuOyvQujQRX7Lr2LPVnRZajLZozm+bOf
         qkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696694017; x=1697298817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIoRUVFu2cJ5wWu6WRbqqm267XrfNYzNwi2GVhtMIn4=;
        b=m32bdLj7e7W6JxvQVQrqhxnMY2oW6M5wzlF0t3uwsH3zonqz/qRiPEN5mXtQtM9Lm1
         oz7UC/tlF58Ubh2H+ZSzIkDfBKzWqfXS4PWPX3hE+MtwT/sH5UDNcVdWWY+1v8Ek+/Ic
         ZxodYTv0ixoz9yFp00UhVgMUxq8enkYV5gWJMyHlZHQbz4ZMcsc3TNu09aFEhb1oEL02
         HXXa6H1TX2BQ483F74AlzFVrPbEXHT2XdWNkIYs8BdGw/dP4DTecE3D+Lre4vW5lg/p4
         nLVNm8z8P+FF+kdoizTq7shIblnxoEaJjEKlrdJ67tzA0Z1L2K2T9buJ3CfmH3+cBuXE
         /lBw==
X-Gm-Message-State: AOJu0YxWTZ8+k619yuETmjTRQV4XDOPIixA4DsHTAiEKGdxUk6mCf7ye
        SmmVX8Pxt+I2uuUaRx6u4aUQG+u8ZiTziQMoXWfbwg==
X-Google-Smtp-Source: AGHT+IHRTbP3LnCb5nL4G04xxB/6ouPYhEI50onFC7yukO0J9Hy6kprf8+ym8MVvQcqV1zG7VWRBXNGAIV3eBVseG50=
X-Received: by 2002:a05:690c:2c8a:b0:5a5:756:44f4 with SMTP id
 ep10-20020a05690c2c8a00b005a5075644f4mr7775198ywb.22.1696694017572; Sat, 07
 Oct 2023 08:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231006115147.18559-1-brgl@bgdev.pl> <ZSAIUVAQ6ifi8LTL@smile.fi.intel.com>
 <CAMRc=MdrLSPCEsQ6OEgRX-7Wh7ka+Rczja=QjY-srozj3cz68w@mail.gmail.com> <ZSEMnqAynnrfBxX1@smile.fi.intel.com>
In-Reply-To: <ZSEMnqAynnrfBxX1@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 7 Oct 2023 17:53:26 +0200
Message-ID: <CACRpkdYTQ52fT5iiUXcO_Le2nYp5akdEPuq8brrSU+C0LFeOAQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] gpiolib: reverse-assign the fwnode to struct gpio_chip
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dipen Patel <dipenp@nvidia.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Sat, Oct 7, 2023 at 9:45=E2=80=AFAM Andy Shevchenko <andy@kernel.org> wr=
ote:

> The providers decide themselves
> if they want to have any specific device node for the chip or inherit
> it from the physical hardware. Note, there are two types of the FW descri=
ptions
> of the GPIO controller, when it's 1:1 to the banks and when it's one devi=
ce
> with list of children, one per bank. Due to this differences we have
> this field in the GPIO chip to begin with.

So this is the real problem right, for example a pin controller with
six sub-nodes that are GPIO chips but not necessarily devices.

In DT terms:

pinctrl@0 {
   compatible =3D "...";
(...)
   gpio@0 {
        (...)
    };
    gpio@1 {
        (....)
    };
(...)
    gpio@5 {
        (....)
    };
};

And now each of these subnodes spawn a gpio_chip and a gpio_device
and now the big question is what fwnode (in this example of node) to use fo=
r
each.

I was under the impression that despite the main device does not
spawn subdevices in the Linux device model, the subdevices always
have their individual fwnode, and when we create the gpio_chip for
it, that creates a gpio_device and that *is* the device for that fwnode,
if there is no corresponding say platform_device or similar.

So e.g. assigning the fwnode of the parent (the pin controller in this
example) to these gpio_chips flattens the hierarchy and that
would be a *bug* in my mind (but maybe not in everyone else's
mind).

But IIUC what you are saying is that sometimes there are drivers that
do this?

Yours,
Linus Walleij
