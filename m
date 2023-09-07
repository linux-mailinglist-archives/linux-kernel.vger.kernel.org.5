Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A6C79792B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbjIGRE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbjIGRE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:04:28 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0081724
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:04:00 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d7b79a4899bso1026001276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694106187; x=1694710987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoLVfI/Qa17hM0LLGxXlqleEL6Bcc6ph7u/GtpOctOM=;
        b=yiVAsnh7aI22/ZYzNGbbOSHYy3f3nTDb4BzTeL2Jx+eKWD8BMwQdq09igWC4EVG84J
         NdWUam/zLhYsYD0AcKe9cgooBbGNQ4UlOUxuGVoueQhLsGBqqO0LJUgESo3HRNevQfgD
         2scu2N7QDjYFMhsOZVTSiWMuxOGXuRxfYyXwsEbl1C1l35ySvZNNuF9otXBe3RVQn796
         RGh3HJJnzMsZONQsNA1ouSVIeX6DYE7ZqFGWOVYwyz7wKHl8pA1DpJn05b9DMANiw8xW
         GNlEavp4VkETr3R+x1e7CouXfZSuK+wcx6u1imhB2+iivD+OrWek73+z27bIHgOlKnoh
         vecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694106187; x=1694710987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoLVfI/Qa17hM0LLGxXlqleEL6Bcc6ph7u/GtpOctOM=;
        b=ZA7XYLLQlDaAE93tLRNF75Zk9uqmGY91jHlkWoBESQx7xSeTKO5sM2qGumwXkOIjUW
         3+DtX91Zsj28za8oqK3eFT1MS9X+Awu4QzBdqf+3ezc2q9agJNXQg/0sPrTm40UBPEQ6
         5mQq99F5oLd9JR0QKjN1X6XSCyjqvkgqTquLZs2iTQZOSdXUnDoK/LFhLAyB9gB9PkgB
         +2f7jTWoyUjcRETts3rzjHEXFR6NA0N1XHZthm6jP+Ant98lMLMmBLrJPZECaQ4T9bNo
         5xFZ2Mkz8pjFDf6pNkZL/wZZZ2Ub1JTVo3hIBLfsbxvj6FL9d6PetlhwFHj2Lui+S3K3
         mnHw==
X-Gm-Message-State: AOJu0YwbedajvOt+dLV4NUq13ImyATm/DABW3bM127xgzBKuiX7reva2
        QZJgfc9P9yKrZIvi+H8ooNg+7FgepZiD3RId97+43LVR7qQdFw3Q
X-Google-Smtp-Source: AGHT+IHG0TBlmxyoTQFIa7FFpqQqYMcVr4pyVQslrpSztqetV//HxeApegU4hZ/YXLQ350AtIlPtITxSVFId9gOqRWY=
X-Received: by 2002:a25:40a:0:b0:d7f:7690:d865 with SMTP id
 10-20020a25040a000000b00d7f7690d865mr6786114ybe.6.1694072130152; Thu, 07 Sep
 2023 00:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-16-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-16-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:35:18 +0200
Message-ID: <CACRpkdaLKqNM1xMCo9jz1Pe_18A=GJodbaTHL+VmoRZa5jJbjQ@mail.gmail.com>
Subject: Re: [RFT PATCH 15/21] arm: omap1: ams-delta: stop using gpiochip_find()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops one more note:

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> gpiochip_find() is going away as it's not hot-unplug safe. This platform
> is not affected by any of the related problems as this GPIO controller
> cannot really go away but in order to finally remove this function, we
> need to convert it to using gpio_device_find() as well.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
(...)
> +       struct gpio_device *gdev;
(...)
> +       gdev =3D gpio_device_find_by_label(OMAP_GPIO_LABEL);

This leaves a reference to the gdev right? No scoped guard?

If you leave a dangling reference intentionally I think it warrants
a comment ("leaving a ref here so the device will never be
free:ed").

Yours,
Linus Walleij
