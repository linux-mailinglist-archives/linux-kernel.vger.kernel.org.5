Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E16E759634
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjGSNGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjGSNGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:06:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F711A6;
        Wed, 19 Jul 2023 06:06:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98e39784a85so169244166b.1;
        Wed, 19 Jul 2023 06:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689771990; x=1690376790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZtf6wPvmdI5XB4ZBWnhF7mL0dr2RvE2aBgDVg6Qk2Y=;
        b=l40oiNW976jYKeozDkrHlzyeEX/Ek02ChfyQq9DYnDiEjuxByJf2+IWoYFuWNbWvJh
         oA44zhFVSoe1Gu0OBAQOVCPn0bk3d6FnlgOi+yQDNky47iSzF37ZOrP4ikIZRE3K1RXm
         Dvnm/Fk/SQUZO8nDeIia/uKgIjS1iuQX803qy1DcC8jU9zm/slO4+EOW7grgmzK3jzGG
         iit/QEyIZKM1Bv3DZ90ANGS7jnHQ4rAu22a1vfSQEJ+2BiQWP484apeJguHlRflArXLJ
         5r0QeikOapab6Wt8ikGBzGDQ/YzDH36A7ki2kXTtBib9thzN/vWmw0710X4Aem7lPCQt
         ckdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689771990; x=1690376790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZtf6wPvmdI5XB4ZBWnhF7mL0dr2RvE2aBgDVg6Qk2Y=;
        b=FhCyNdVglozy3LAdPgZntdofgyaFrjgEVxPdtUtiaqykd6xK/uk5lQAnEO2ZZM/sWA
         vffPCNg4pdWV44Qr61Cup6mYH5r1O68khP1V6KKZHMfy3fEBRFxqlzYY82ba3pAFIP4W
         TDn8TGioRHRL20vTt8k4J1w3y7aaIwM1iZc2ZE/aMt5jHZ6LBO3wt5FcnCqF7gCnXgXG
         2pEtNTc5Dn/PyaxXuWDfne/55hOT4OJvaNUY+9rynEi+jNNAahDT/KE3nn5yPA8QwBxl
         FyXA7n0/h6WOHEfpfDC5ufIGQj0c7KrSeaYbamRCFWrK4ZY6xNLuS/HmNRoDd6otpyk3
         M4kg==
X-Gm-Message-State: ABy/qLYHTCq7Pw5K014jNTtTFngLk70ZJ0s4Jeipo6uauLGKv/yY3nlF
        UNQqeFSfH8HmeJAqihyuJrGxSfZZLt0mqNuWBWc=
X-Google-Smtp-Source: APBJJlEHEVkOO3cPzh5Xx3bm4mJcbzv/fm1Zn8syzWS4wMwevnhD7NDg3akzvaoMz+weeZpiYIPkKAPqfTiqOUouD6g=
X-Received: by 2002:a17:906:64d7:b0:993:f127:2391 with SMTP id
 p23-20020a17090664d700b00993f1272391mr2450955ejn.32.1689771989603; Wed, 19
 Jul 2023 06:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230719101339.18256-1-aboutphysycs@gmail.com> <CAJhJPsUBWC6h2ZL_wcqwkd0Krih-PxErVeGFdFdPxocL1RTNcw@mail.gmail.com>
In-Reply-To: <CAJhJPsUBWC6h2ZL_wcqwkd0Krih-PxErVeGFdFdPxocL1RTNcw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Jul 2023 16:05:53 +0300
Message-ID: <CAHp75Vf2ZyOU2Vz8qGjnCmXb5FkuBnA3VM1fGOc0FhEQEv9C8Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: loongson1 :remove unneeded platform_set_drvdata()call
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mips@vger.kernel.org, andy@kernel.org, brgl@bgdev.pl,
        linus.walleij@linaro.org, Alexandru Ardelean <alex@shruggie.ro>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 3:30=E2=80=AFPM Keguang Zhang <keguang.zhang@gmail.=
com> wrote:
>
> On Wed, Jul 19, 2023 at 6:14=E2=80=AFPM Andrei Coardos <aboutphysycs@gmai=
l.com> wrote:
> >
> > In the drivers/gpio/gpio-loongson1 the call to platform_set_drvdata was
> > removed.
> > This function call was found to be unnecesarry as the associated

unnecessary

> > structure is defined inside the local .c file.
> > It doesn't use any type of function either so it can be removed without
> > any complications.
>
> If there is a ls1x_gpio_remove(), platform_get_drvdata() will be called.
> Then platform_set_drvdata() will be necessary.

I don't get this. Is it just a side note? To me the patch looks legit.

...

With typo fixed,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


--=20
With Best Regards,
Andy Shevchenko
