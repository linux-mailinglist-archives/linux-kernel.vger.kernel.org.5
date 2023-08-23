Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC907862A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbjHWVhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbjHWVhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:37:18 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1668ACEE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:37:17 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d35a9d7a5bdso5665682276.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692826636; x=1693431436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPQKdc494QPIHcnkA/367KlIUg0pG9fALiuTu5Rcc74=;
        b=XhXw/WQhCHuhcYkLWmq6Cw8eNCIbzDcNfmF/dju3TxFX9ckOZAReErWSRdWwsD+tpF
         aY+6DH0ESMVkwRYyQqYku8sR+dltM2PcxuP8TdPBtzJRbVSN7210895YUboyfhWByDPb
         Qc3RgM60XSwzeeuzJkhnof+tvTekdsw/LipxY7dYaHt9wD+hQ0xiSIEwkp+cKYUnT/Zj
         wiB9QbNowfFuLRuaLtKB2+H2tGPqlZaErHS57XTlBN2NoISAuKeRfYBgKqyG5hT/48LX
         pAXNEJT7S5mT4IZirazL8nMZCHz+7lQXnV65FB6Wskm934AX7jdao+OLFmx3ZzoGwbKl
         9kTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692826636; x=1693431436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPQKdc494QPIHcnkA/367KlIUg0pG9fALiuTu5Rcc74=;
        b=N/CEMuQKK7sv0xsupl7ApCpbpPgGmM1lveSTd5edxweODzf0jrS8K17tJ84WgiK596
         hQrysM2KyNH3jhfigK2nghhhpTv/WTC51KQVgFIWJadTJJRX8CKYHTFDr3qZrWngcofJ
         vu4fDuUI/LF8EgDXHX6woEglmxvH6OzZm7N1O291n2YqUuriYBj87CBg01vqpI6yvf7e
         DceJASEna0++qnSIn1//wc62YcXGMJZ/1p7MSWSD1JvVRe257yZUbEFDhPWMQazCkVEE
         H2gjLbUdbgUYf7sFRB3BSd7FwcZE6WjVzjzr6gIAAefxH8tdjw5sBuY8DgQoaC3RFAa5
         Wpqg==
X-Gm-Message-State: AOJu0YxKOJMhxRAThCuypNrTZBxH9BvWS8E/EeQy+dI4ldCw7KTCbk4T
        4i4iYWHSw/Dn7fzZOgXEfvrGIoARu3TnbntfdlkLTg==
X-Google-Smtp-Source: AGHT+IEIHR7VwwuDGlXV1hnAdqmGZUSVg35WW6rmJuk5Yfdppdcmn4eYpDF++LuMpHNGtTCyNIjnMOYgd+IVrDJoT+4=
X-Received: by 2002:a25:9305:0:b0:d06:22aa:529e with SMTP id
 f5-20020a259305000000b00d0622aa529emr13772096ybo.5.1692826636297; Wed, 23 Aug
 2023 14:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230818164314.8505-1-asmaa@nvidia.com> <20230818164314.8505-3-asmaa@nvidia.com>
 <CAMRc=Mccsc=RY5Evw4-k8LYDrfuxFoWsn6wajybY4SY_89fjNw@mail.gmail.com>
 <CH2PR12MB38950DCD03CFB45E4DB34E32D71EA@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAMRc=MeLfvM28czSrKpmMxmvbDeHi2rxtm+_FCKV24H9C-RBnA@mail.gmail.com>
In-Reply-To: <CAMRc=MeLfvM28czSrKpmMxmvbDeHi2rxtm+_FCKV24H9C-RBnA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 23 Aug 2023 23:37:04 +0200
Message-ID: <CACRpkdaUiAPcjHYYX-AEAYPTradakCJ4seTkWzWZcDZkUeOxqA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] gpio: mlxbf3: Support add_pin_ranges()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 5:04=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Mon, Aug 21, 2023 at 2:55=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> w=
rote:
> >
> > > > +MODULE_SOFTDEP("pre: pinctrl-mlxbf3");
> > > >  MODULE_DESCRIPTION("NVIDIA BlueField-3 GPIO Driver");
> > > > MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
> > > > MODULE_LICENSE("Dual BSD/GPL");
> > > > --
> > > > 2.30.1
> > > >
> > >
> > > It's not clear to me whether this depends on patch 1? If only at run-=
time then I
> > > guess Linus and I can take the two patches through ours respective tr=
ees?
> >
> > Indeed from a build point of view, there is no dependency so you could =
take the 2 patches through your respective tree. However, at run-time, the =
gpio-mlxbf3.c driver fails to load without the pinctrl-mlxbf3.c driver. Sho=
uld I add a "depends on" in the Kconfig? Then you will have to include both=
 patches in your tree.
> >
>
> Linus, are you fine with me taking this patch? It will not break the
> build and with you taking the other one, next will be fine too.

Yep pick this one, I applied 1/2 to the pinctrl tree now.

Yours,
Linus Walleij
