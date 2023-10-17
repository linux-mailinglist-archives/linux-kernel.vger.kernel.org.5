Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EDF7CC376
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjJQMok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJQMoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:44:39 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D42595
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:44:37 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7dd65052aso76717307b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697546677; x=1698151477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vQVpipJ8U/Wmxx6yT1J99VV5RzOgH7yDeQqapC2EK3w=;
        b=aZkN+JxHj8YJkR2Y2POFm+6gPYcJnTyNzA6Xdkd/V7Th2EoDM+Bsr8f4Nhb6riPUMi
         2VbIugC8Ewyp3MgOw9gHJznFwTUikJCRF6kBLT7I2Yc+CEujP/cnauXeTx+QcZPN8Yo6
         GZmzsuHj3lWr1K1AcW6E0bP+10wTzvuM8GOzEbRgPMBOBYun13r4C2Kw2N3g7LPk5EpZ
         r2xM/zA4masCOD4aUUCv8yulSQZk6P1GEMPlMc80FNN/xwP9MwjTNQ4TKXMd9W/TyMYl
         PEk/9qZ2L54Eg9oOr8Bevsz4Dc6HTYBsDwcSFobbJhrvXrHF8VEz1VceYJkOsPSaAhN4
         Q5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546677; x=1698151477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQVpipJ8U/Wmxx6yT1J99VV5RzOgH7yDeQqapC2EK3w=;
        b=IbiSHujT2jbrHobn3QtR+Juvwl5jM1hwI73NdBbRIYexpbaAqW5mKPqWuBQmaC4p/m
         KUeaze60FU8issCZPI0dkxS+dxJaP0k41fz7XtcxDsXB8MdZuhcAlCQwuph9ImEpXsEw
         Wbo/1vsGsSE8llsfW7QTvuokD1LABqoiCiGkD48dZIucEwm5/TLXdwGm6FMXuDSRXuDp
         ijrWpRTaPk/I0z65Ejg9Ga7xpD4aPnSu6gzJLGStHL6TExlxA9G5hmn1qzABkv65AJjd
         0HX0sn/4k46E+d9TV464FcYwH9F9DzUJGbEih+xiKeNwcrfGNeSPSIGHyEuH3LzWPEes
         cAXw==
X-Gm-Message-State: AOJu0YyVfcUcNMI4vOcpAFNzCKsrichCR+LtZ4HsLuqjKbC5ua+cS0x4
        HASwxlCYRieaIh6beawk6uTYZ3CkCWN7ZlEqMI6ecOtyVoGVZzZb
X-Google-Smtp-Source: AGHT+IH6u1rZTSFzJPJNDnVuAD9bBkHis2cJ9J4dmYJPnnkkPUrbfgCLNfpu1LdmvHp3KGOelp8xOMi+Kr3qb1Q2mGc=
X-Received: by 2002:a0d:f701:0:b0:5a7:b481:4dd2 with SMTP id
 h1-20020a0df701000000b005a7b4814dd2mr2147572ywf.47.1697546676827; Tue, 17 Oct
 2023 05:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231017120431.68847-1-brgl@bgdev.pl> <20231017120431.68847-55-brgl@bgdev.pl>
 <ZS6BAkfFeA+6GYfz@smile.fi.intel.com>
In-Reply-To: <ZS6BAkfFeA+6GYfz@smile.fi.intel.com>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue, 17 Oct 2023 14:44:25 +0200
Message-ID: <CACMJSesgT-a8krB8gvf0gJ-C+p6s1TdRcE6W_42CxR9bDvrGHg@mail.gmail.com>
Subject: Re: [PATCH v3 54/73] pinctrl: intel: drop the wrappers around pinctrl_gpio_direction_input()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 at 14:41, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 17, 2023 at 02:04:12PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > pinctrl_gpio_direction_input() now has the same signature as the
> > wrappers around it so we can drop them.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Now, for the sake of symmetry can you add (at least to the all
> Intel drivers you modified in this series) the following:
>

Good idea but this is v6.8 material, I don't want to extend this
series anymore at this point.

Bart

>
> int pinctrl_gpio_direction_output_with_value(struct gpio_chip *gc,
>                                              unsigned int offset, int value)
> {
>         gc->set(gc, offset, value);
>         return pinctrl_gpio_direction_output(gc, offset);
> }
>
>
> ?
>
> And respectively in this driver
>
>         .direction_output = pincttl_gpio_direction_output_with_value,
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
