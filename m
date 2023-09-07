Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C44A79779C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239755AbjIGQ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244184AbjIGQ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:28:59 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16FE211C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:26:24 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-573f8083b9fso916096a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694103920; x=1694708720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdWsNUufxYU54d2v+3Wxi5MrfQGJIJLOBq5vhtohyVg=;
        b=f6Ft8MmCanyG1BvQeXEVkd/B9xxlaBWcEh2ZEF+/XY0lY2X+EXExpT/7NLokhjhp4I
         E1IPxGzMeDUh6xs/Uis8PUV2Q7c8AGYPAp4Jmq9JPzsJZX9NwF7yqkl3+AqB5878codl
         mTW0Rk6PHSGjDlcQHVn2fd/wFAjxHW+A44JplJmOCRA62E+0IUufKZRJFwTXsZXFgr3M
         D/Ndqc0Zmk6j8qX7U7fOGbomvkdjk7KLQ5cysE709j+YAUVeSXr2Y8CihoYTno0oLLum
         e0nXHCfxR3jIf+fdIuUQE8XG8lzrbvczWrgU/k9wb83m7Dhw5sUwQ3fTDEbSryvas4bs
         lrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103920; x=1694708720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdWsNUufxYU54d2v+3Wxi5MrfQGJIJLOBq5vhtohyVg=;
        b=NNFWg6ClxLDpIhP4huABvFdHLKErvr9NVT9Z9sCIcryRBE8mLfjIu4DFooZVaqeiYS
         Rq0s2NoE2xYZDg5WPgBAAg0KvJkMHOxfhxn65KEW9o3ERUGoy2xpSfCJE7g1eNTz0bUO
         gWw+nQNWel7UA06Z7yC/zPI8rLIKP49r/756jZf6e7qyRnTGfgv72AjzEuWY/LIzhPJq
         dfLrGzAvLExN7W6hWpGI/QvmzAVAOUTJL90R+c6U2nHKAMdyz18Vp80IEPIF9+ROcuNO
         PzlyGdLz+Cw3fuxOsczHubh3ffXZZXA7LgVMr1jAYh/4pWDz0k7qWOFrfyjukxE6ghTP
         9qww==
X-Gm-Message-State: AOJu0YyxXS9cYThySdHLN1sdchpJrjS1wzKlma9mLSE0xHGpxCrUwppg
        Dm8bhMtE/rAjYUVcj5GODDfVM0zey21Uid4/f3JK8asEiut2SjOZ1fo=
X-Google-Smtp-Source: AGHT+IGMY/aPJYeBu1Pp0IzmGxqtgA0g7tRf3VGot5Pdq6hh1Y77T4EpHI+nXikBBcDxY/Os4mlIAHH2bnKyBxN7wMo=
X-Received: by 2002:a25:258f:0:b0:d7a:edf3:f0a9 with SMTP id
 l137-20020a25258f000000b00d7aedf3f0a9mr17868648ybl.50.1694070333187; Thu, 07
 Sep 2023 00:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-3-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-3-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:05:22 +0200
Message-ID: <CACRpkdZEphqvwpid7QzXuYX79q2==58eKT7wg9Cmr8m1FLOuRA@mail.gmail.com>
Subject: Re: [PATCH 02/21] gpiolib: provide gpio_device_find()
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

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> gpiochip_find() is wrong and its kernel doc is misleading as the
> function doesn't return a reference to the gpio_chip but just a raw
> pointer. The chip itself is not guaranteed to stay alive, in fact it can
> be deleted at any point. Also: other than GPIO drivers themselves,
> nobody else has any business accessing gpio_chip structs.
>
> Provide a new gpio_device_find() function that returns a real reference
> to the opaque gpio_device structure that is guaranteed to stay alive for
> as long as there are active users of it.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
