Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F7F7BA652
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjJEQd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjJEQcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:32:32 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AC0170D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:48:43 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-49d0d90a7ddso421018e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696513722; x=1697118522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHY/ZQQzp7Eh1tubbFWWOn2NxVKU0m/orXkn9/Odof0=;
        b=c1xWPf3/mvf8/i/TrzUZOuGMDYM91CxU4gozBvzeOu2ANTQu3NigwJHRxAYRlObQqp
         mGf1s0ZoZDZNFUmlPKqBXHnqYT7LXulZN9+sfdJJmqJCFjEgs92Vk0yBa3G/q8oMJ+QZ
         Zb9QHMuDZbGpMOJo6qUE14TZZBs7zp8GACSN4MIQ877omaJeiqg49MfpeuVURa5DIQUW
         hH6U04Vo1CtUk7GClCSandDXKRDybCuxZFCy9bdFwGUHJ4UA8Yjqn71+CRQadgPARLBf
         +1wfv4PZ3iKh2/U6NgKpv95dm+FfiACztMxZUqS0ZZtENf16EiKUaqeRGxGMO2p+1EHd
         dc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696513722; x=1697118522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHY/ZQQzp7Eh1tubbFWWOn2NxVKU0m/orXkn9/Odof0=;
        b=XbXLizOrZolwMdCnbBt6bKtFYQ3QkNe3jEB5pUw9acXa2HJkFZT+UP+SkzAwqPo1tn
         kdLil4js9I4q9+dBfX2NFIoUU8clVU/ZPhMmizQDfzYcMGg1TG9ECEAIgV6tpC+vrxTA
         TSXd6jKepzPjssMe5am9FAY/vlzOXEQDwtJ4trBvVyEWCMfoBX7VjcMkRshJrN2IMZWW
         qkGqqYQnJaehelMY4KzoT/EIaLujulecl8osPDCQLz/345cgb8AjykOszReEZXQKQ+Vf
         TZOmtsbwt2j/d8Om9aQzdZ+T2510yop53lfkCVzOiHghjxndohupaxBdoIGxX3f7XFKf
         c9Tg==
X-Gm-Message-State: AOJu0YyFFzc5O1CIujBWTNDiGaUCj+TxC2SVEWcOf13UFpiUzAXGn7Bo
        KgJGUFy5zx/dOUT14hjNJueEGBpMD83P3Dfw4ugbvg==
X-Google-Smtp-Source: AGHT+IEs24zy6ibJecOnCN0EfrO6wFAW3J5eW9qxeqqcBUsb4ootHwEPnzV2453v5/6B/ux1FD3fv13iIIuy1J493K0=
X-Received: by 2002:a1f:e2c3:0:b0:49c:37a1:2358 with SMTP id
 z186-20020a1fe2c3000000b0049c37a12358mr4560513vkg.14.1696513722632; Thu, 05
 Oct 2023 06:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-15-brgl@bgdev.pl>
 <CACRpkda9=VULj4Cy_sit-UpUQnVEbS-RJKAeULVCw8ZCRTq1sw@mail.gmail.com>
 <CAMRc=MdTk1B4MEh9C624Upm_EcaQgJd9OU-AGfU0G-DU1+qk6A@mail.gmail.com>
 <36b17290-c643-8d8e-e82b-49afa6b34fbb@nvidia.com> <3624e973-d09a-d211-c6d0-d0ffb8c20c4b@nvidia.com>
 <90b5f887-8af4-a80d-ea4d-cf2199752de4@nvidia.com> <0e7cae42-0b81-c038-8beb-49102feea8a6@nvidia.com>
In-Reply-To: <0e7cae42-0b81-c038-8beb-49102feea8a6@nvidia.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 5 Oct 2023 15:48:31 +0200
Message-ID: <CAMRc=McSG6qajxt6P3vWQEeT63Pk5tggD05pUoMD1zd5ApZxgA@mail.gmail.com>
Subject: Re: [RFT PATCH 14/21] hte: tegra194: don't access struct gpio_chip
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 1:52=E2=80=AFAM Dipen Patel <dipenp@nvidia.com> wrot=
e:
>
> On 10/4/23 3:54 PM, Dipen Patel wrote:
> > On 10/4/23 1:33 PM, Dipen Patel wrote:
> >> On 10/4/23 1:30 PM, Dipen Patel wrote:
> >>> On 10/4/23 5:00 AM, Bartosz Golaszewski wrote:
> >>>> On Thu, Sep 7, 2023 at 9:28=E2=80=AFAM Linus Walleij <linus.walleij@=
linaro.org> wrote:
> >>>>>
> >>>>> On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bg=
dev.pl> wrote:
> >>>>>
> >>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>>>>
> >>>>>> Using struct gpio_chip is not safe as it will disappear if the
> >>>>>> underlying driver is unbound for any reason. Switch to using refer=
ence
> >>>>>> counted struct gpio_device and its dedicated accessors.
> >>>>>>
> >>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org=
>
> >>>>>
> >>>>> As Andy points out add <linux/cleanup.h>, with that fixed:
> >>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >>>>>
> >>>>> I think this can be merged into the gpio tree after leaving some
> >>>>> slack for the HTE maintainer to look at it, things look so much
> >>>>> better after this.
> >>>>>
> >>>>> Yours,
> >>>>> Linus Walleij
> >>>>
> >>>> Dipen,
> >>>>
> >>>> if you could give this patch a test and possibly ack it for me to ta=
ke
> >>>> it through the GPIO tree (or go the immutable tag from HTE route) th=
en
> >>>> it would be great. This is the last user of gpiochip_find() treewide=
,
> >>>> so with it we could remove it entirely for v6.7.
> >>>
> >>> Progress so far for the RFT...
> >>>
> >>> I tried applying the patch series on 6.6-rc1 and it did not apply cle=
anly,
> >>> some patches I needed to manually apply and correct. With all this, i=
t failed
> >>> compilation at some spi/spi-bcm2835 driver. I disabled that and was a=
ble to
> >>> compile. I thought I should let you know this part.
> >>>
> >>> Now, I tried to test the hte and it seems to fail finding the gpio de=
vice,
> >>> roughly around this place [1]. I thought it would be your patch serie=
s so
> >>> tried to just use 6.6rc1 without your patches and it still failed at =
the
> >>> same place. I have to trace back now from which kernel version it bro=
ke.
> >>
> >> [1].
> >> https://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.g=
it/tree/drivers/hte/hte-tegra194.c?h=3Dfor-next#n781
> >>
> >> of course with your patches it would fail for the gdev instead of the =
chip.
> >
> > Small update:
> >
> > I put some debugging prints in the gpio match function in the hte-tegra=
194.c as
> > below:
> >
> > static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
> >  {
> > +       struct device_node *node =3D data;
> > +       struct fwnode_handle *fw =3D of_node_to_fwnode(data);
> > +       if (!fw || !chip->fwnode)
> > +               pr_err("dipen patel: fw is null\n");
> >
> > -       pr_err("%s:%d\n", __func__, __LINE__);
> > +       pr_err("dipen patel, %s:%d: %s, %s, %s, match?:%d, fwnode name:=
%s\n",
> > __func__, __LINE__, chip->label, node->name, node->full_name, (chip->fw=
node =3D=3D
> > fw), fw->dev->init_name);
> >         return chip->fwnode =3D=3D of_node_to_fwnode(data);
> >  }
> >
> > The output of the printfs looks like below:
> > [    3.955194] dipen patel: fw is null -----> this message started appe=
aring
> > when I added !chip->fwnode test in the if condition line.
> >
> > [    3.958864] dipen patel, tegra_gpiochip_match:689: tegra234-gpio, gp=
io,
> > gpio@c2f0000, match?:0, fwnode name:(null)
> >
> > I conclude that chip->fwnode is empty. Any idea in which conditions tha=
t node
> > would be empty?
>
> sorry for spamming, one last message before I sign off for the day....
>
> Seems, adding below in the tegra gpio driver resolved the issue I am faci=
ng, I
> was able to verify your patch series.
>
> diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
> index d87dd06db40d..a56c159d7136 100644
> --- a/drivers/gpio/gpio-tegra186.c
> +++ b/drivers/gpio/gpio-tegra186.c
> @@ -989,6 +989,8 @@ static int tegra186_gpio_probe(struct platform_device=
 *pdev)
>                 offset +=3D port->pins;
>         }
>
> +       gpio->gpio.fwnode =3D of_node_to_fwnode(pdev->dev.of_node);
> +
>         return devm_gpiochip_add_data(&pdev->dev, &gpio->gpio, gpio);
>  }
>
> Now, few follow up questions:
> 1) is this the correct way of setting the chip fwnode in the gpio driver?

You shouldn't need this. This driver already does:

    gpio->gpio.parent =3D &pdev->dev;

so fwnode should be assigned in gpiochip_add_data_with_key(). Can you
check why this doesn't happen?

Bart

> 2) Or should I use something else in hte matching function instead of fwn=
ode so
> to avoid adding above line in the gpio driver?
>
> >
> >>>
> >>>>
> >>>> Bart
> >>>
> >>
> >
>
