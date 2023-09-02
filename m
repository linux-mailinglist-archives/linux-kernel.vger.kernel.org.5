Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9648A7908C3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjIBQ5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIBQ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:57:07 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04399E54
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 09:57:04 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d7830c5b20aso133296276.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693673823; x=1694278623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ys7Ptt3vouhvDmGvnohD/T/0YM16X316blFuKjq/vI=;
        b=C/k5c70ewmnYtF7/qQCP6ju/TuKP8B2VTPg4PaCT2skLYzqZUKBrvN4Aty7vTnRR2e
         d37UxbQv6RLqeiTC2Q1c7A+njNbIqrJxFxw0NEgHWKFJvb0+CemTihNPQqlcklCGgDtD
         MFaHZLwVx8Ip9clEpbFBl1pxeW2oGTphpUHAMR1SO13FWgmuDCnoH9dPUrCtgup0b24j
         9BtaW37CFBQEzwa96aKD1eneQ1l1Kn+Twuc7On8YV6zqsgi7AANcRIaF3IMQVNoRAhNy
         ZflQPEvR7l5YqPBsrStp5VtXsDorM0HTfVKHRxrlNyArzTSPJZA1dEIiDT3byHSfIUby
         6syA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693673823; x=1694278623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ys7Ptt3vouhvDmGvnohD/T/0YM16X316blFuKjq/vI=;
        b=lAgaesJIF1SoOqUPqGn4NYIXarBzGbkpwjV4XFcWqpr1Rn6Dx98pNYPdL7zmnGWtpc
         VBk45rZz0hvNuf6P/vsaj8OfCpWYUylqOBGYdvBcOg7xQGTuvRhjNHop4EhFayva5VpK
         AW6UWRY3lDwFthrN38CjMAWphaVjZkLVPEzLg6TmPAvhl58UkuXdQqEfGrtABYTxjaa6
         zhONwVeHeEdPSuWCDAw8YTVDWgVhruQkvBaM+d0bSnYh5bjIoQKj/CcYPV0JY+q8qtGl
         8dcjLB8/39eoR6UShUXSqd6zIwIajyVSpTRBRldxgHW+O18OXgSXHnZ7xmPk8McHJQ2X
         Vk3Q==
X-Gm-Message-State: AOJu0YxMrQjsuIRT4BUi0pYiSQha3ustueA17i94b/pG3yyTcroVncs/
        FAA3IzWL1mQWnuf/YbdNKytBMQXENyb3nKmw3prMPg==
X-Google-Smtp-Source: AGHT+IEuKfD5QlVNltjchmvAiVIFV8nY6p9/ilbXHrzqZdlWmHsDdcWuXvaClm9zyhkCdh/n1u3/aHgw85il/vwSGA0=
X-Received: by 2002:a25:acc3:0:b0:d60:b5f2:9824 with SMTP id
 x3-20020a25acc3000000b00d60b5f29824mr6964370ybd.23.1693673823171; Sat, 02 Sep
 2023 09:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230901111548.12733-1-brgl@bgdev.pl> <CACRpkdYLcOZQ9r46aBwesh-H392C_0AWC8n2ikuwUknfEhoNNA@mail.gmail.com>
 <ba9803e9-3aff-42b9-87ad-4e6d75d36d87@sirena.org.uk>
In-Reply-To: <ba9803e9-3aff-42b9-87ad-4e6d75d36d87@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 2 Sep 2023 18:56:51 +0200
Message-ID: <CACRpkdaDG30k_OM_xTCM6yOTB3rjzxrsbbrLZpvYCh7e66Zt7g@mail.gmail.com>
Subject: Re: [RFT PATCH v2] spi: bcm2835: reduce the abuse of the GPIO API
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
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

On Fri, Sep 1, 2023 at 2:31=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:

> > > +       struct gpiod_lookup_table *lookup __free(kfree) =3D NULL;
>
> > Whoa!
> > This is really neat.
> > As noted, it will confuse static checkers at no end, but they just have
> > to adopt. (CC to Dan C if he now runs into this.)
>
> It also doesn't look amazing for humans, it's very not C like...

<linux/cleanup.h> and the __free() macro was introduced by Peter
Z who also very famously suggested (OTOMH!) that instead of
adopting Rust to the kernel it would be possible to bring the
desired Rust features into C.

Which is what he does, well the feature has been there for a while
but he identified it and made it easily accessible.

Now if this path is desirable ... yeah. Maybe a matter of taste.

Yours,
Linus Walleij
