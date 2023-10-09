Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15D67BD3C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345315AbjJIGtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjJIGtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:49:11 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48DACA
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 23:49:08 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-49dd3bb5348so1473262e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 23:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696834148; x=1697438948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8R3SEvkCEq8q6EEM7nd/KgJCNBdPF2LFQh/jnLNGpw=;
        b=Xrv6PB9ymitTxL57PllfSNTci68Tu/yQTEiDEdwUFAfKouYhfY4JMUBkfmZKkaPY7Q
         G/14J6e29ve8QF/1jt8Fh8KBwNR3SSIfrSikb35ucraoaFNsZKVHIyey+QJYfmRPUQ7v
         +iejWkRcm700zJnNDpRg+GtOAOJaP0Ih9BOj05tvT7fZ89rcS+cdxltnuk94swA9xWSA
         bgv0y89cLuuhGveXTMkY5uHcXYWJeCPGTN8tK2ZRXYpJ2TVDjei0NILja11ke6raeuUF
         YJc2tBJbw3mcUSZQYnNitUphdgFstPGFHWi/7ylOvd9Nk4okQMtmfJ0QAuffoH/nM+F0
         Ktlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696834148; x=1697438948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8R3SEvkCEq8q6EEM7nd/KgJCNBdPF2LFQh/jnLNGpw=;
        b=FnOHtXF0G+CwKjNuDdKJ0n1A6Svz/bh9RuV9dGU7P0JklPAYv+on0jCMEJ9FdrQor6
         H5Z+0lzbG8tp3G3rDUXKxKtTHAtZQKW+tDXm4TvB01M+p3HdRFUK07PrcaZpgmbjjOJE
         7gqUSgYjPQJYqGfmf+MDVkohmn1Yrf7+CY0Ar4GJUglVPBULCSeoZCkgNgnllm2o0WeA
         0NfylhXxfGpgZmZFHVfTS7VM93b+QtN82nISR8H1uVQ6lzRNsbcbnNRxT7blNO8HvYth
         ptRvIehgQuycxoVrlzYaigFIbjmDkqrGPOSny+eIq+vW5W/kpMutiW1UEcRgy9zIVFBT
         oGGQ==
X-Gm-Message-State: AOJu0YzsS8j7xbB9cIr3ZsgtxhFSxV1uLsFWo4Z3PFOVZzQC+v6PJGWN
        QbgcCN/xSjc+OLfVKWIlTnnvaHEErarsFQb+PwvCWw==
X-Google-Smtp-Source: AGHT+IGLJ/Kir7ut6JZrJcqUdoiq1uSu4D5pTXVqnjxvbtP52e+bm7khorXZzvc3cATfPWACjFwqc/2EjUYFIU5UStE=
X-Received: by 2002:a1f:4e46:0:b0:4a1:58e0:a0db with SMTP id
 c67-20020a1f4e46000000b004a158e0a0dbmr988925vkb.11.1696834147762; Sun, 08 Oct
 2023 23:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-15-brgl@bgdev.pl>
 <CACRpkda9=VULj4Cy_sit-UpUQnVEbS-RJKAeULVCw8ZCRTq1sw@mail.gmail.com>
 <CAMRc=MdTk1B4MEh9C624Upm_EcaQgJd9OU-AGfU0G-DU1+qk6A@mail.gmail.com>
 <36b17290-c643-8d8e-e82b-49afa6b34fbb@nvidia.com> <3624e973-d09a-d211-c6d0-d0ffb8c20c4b@nvidia.com>
 <90b5f887-8af4-a80d-ea4d-cf2199752de4@nvidia.com> <0e7cae42-0b81-c038-8beb-49102feea8a6@nvidia.com>
 <CAMRc=McSG6qajxt6P3vWQEeT63Pk5tggD05pUoMD1zd5ApZxgA@mail.gmail.com>
 <647d3b52-1daf-175d-d5c2-45653dd2604c@nvidia.com> <CAMRc=Mc_+LxcbV+=KPwAh4DinJAAetHrK+W3jbNp4AZBzg63TA@mail.gmail.com>
 <b0f37601-39d6-618e-fa16-3b1c9e7c0e2c@nvidia.com>
In-Reply-To: <b0f37601-39d6-618e-fa16-3b1c9e7c0e2c@nvidia.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 9 Oct 2023 08:48:56 +0200
Message-ID: <CAMRc=MfSGY691-sFhx8GeP43g0xGk1JzNa=9q5oemQoHHAM-5Q@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 9:43=E2=80=AFPM Dipen Patel <dipenp@nvidia.com> wrot=
e:
>
> On 10/5/23 12:05 PM, Bartosz Golaszewski wrote:
> > On Thu, Oct 5, 2023 at 8:12=E2=80=AFPM Dipen Patel <dipenp@nvidia.com> =
wrote:
> >>
> >> On 10/5/23 6:48 AM, Bartosz Golaszewski wrote:
> >>> On Thu, Oct 5, 2023 at 1:52=E2=80=AFAM Dipen Patel <dipenp@nvidia.com=
> wrote:
> >>>>
> >>>> On 10/4/23 3:54 PM, Dipen Patel wrote:
> >>>>> On 10/4/23 1:33 PM, Dipen Patel wrote:
> >>>>>> On 10/4/23 1:30 PM, Dipen Patel wrote:
> >>>>>>> On 10/4/23 5:00 AM, Bartosz Golaszewski wrote:
> >>>>>>>> On Thu, Sep 7, 2023 at 9:28=E2=80=AFAM Linus Walleij <linus.wall=
eij@linaro.org> wrote:
> >>>>>>>>>
> >>>>>>>>> On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brg=
l@bgdev.pl> wrote:
> >>>>>>>>>
> >>>>>>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>>>>>>>>
> >>>>>>>>>> Using struct gpio_chip is not safe as it will disappear if the
> >>>>>>>>>> underlying driver is unbound for any reason. Switch to using r=
eference
> >>>>>>>>>> counted struct gpio_device and its dedicated accessors.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro=
.org>
> >>>>>>>>>
> >>>>>>>>> As Andy points out add <linux/cleanup.h>, with that fixed:
> >>>>>>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >>>>>>>>>
> >>>>>>>>> I think this can be merged into the gpio tree after leaving som=
e
> >>>>>>>>> slack for the HTE maintainer to look at it, things look so much
> >>>>>>>>> better after this.
> >>>>>>>>>
> >>>>>>>>> Yours,
> >>>>>>>>> Linus Walleij
> >>>>>>>>
> >>>>>>>> Dipen,
> >>>>>>>>
> >>>>>>>> if you could give this patch a test and possibly ack it for me t=
o take
> >>>>>>>> it through the GPIO tree (or go the immutable tag from HTE route=
) then
> >>>>>>>> it would be great. This is the last user of gpiochip_find() tree=
wide,
> >>>>>>>> so with it we could remove it entirely for v6.7.
> >>>>>>>
> >>>>>>> Progress so far for the RFT...
> >>>>>>>
> >>>>>>> I tried applying the patch series on 6.6-rc1 and it did not apply=
 cleanly,
> >>>>>>> some patches I needed to manually apply and correct. With all thi=
s, it failed
> >>>>>>> compilation at some spi/spi-bcm2835 driver. I disabled that and w=
as able to
> >>>>>>> compile. I thought I should let you know this part.
> >>>>>>>
> >>>>>>> Now, I tried to test the hte and it seems to fail finding the gpi=
o device,
> >>>>>>> roughly around this place [1]. I thought it would be your patch s=
eries so
> >>>>>>> tried to just use 6.6rc1 without your patches and it still failed=
 at the
> >>>>>>> same place. I have to trace back now from which kernel version it=
 broke.
> >>>>>>
> >>>>>> [1].
> >>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/lin=
ux.git/tree/drivers/hte/hte-tegra194.c?h=3Dfor-next#n781
> >>>>>>
> >>>>>> of course with your patches it would fail for the gdev instead of =
the chip.
> >>>>>
> >>>>> Small update:
> >>>>>
> >>>>> I put some debugging prints in the gpio match function in the hte-t=
egra194.c as
> >>>>> below:
> >>>>>
> >>>>> static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
> >>>>>  {
> >>>>> +       struct device_node *node =3D data;
> >>>>> +       struct fwnode_handle *fw =3D of_node_to_fwnode(data);
> >>>>> +       if (!fw || !chip->fwnode)
> >>>>> +               pr_err("dipen patel: fw is null\n");
> >>>>>
> >>>>> -       pr_err("%s:%d\n", __func__, __LINE__);
> >>>>> +       pr_err("dipen patel, %s:%d: %s, %s, %s, match?:%d, fwnode n=
ame:%s\n",
> >>>>> __func__, __LINE__, chip->label, node->name, node->full_name, (chip=
->fwnode =3D=3D
> >>>>> fw), fw->dev->init_name);
> >>>>>         return chip->fwnode =3D=3D of_node_to_fwnode(data);
> >>>>>  }
> >>>>>
> >>>>> The output of the printfs looks like below:
> >>>>> [    3.955194] dipen patel: fw is null -----> this message started =
appearing
> >>>>> when I added !chip->fwnode test in the if condition line.
> >>>>>
> >>>>> [    3.958864] dipen patel, tegra_gpiochip_match:689: tegra234-gpio=
, gpio,
> >>>>> gpio@c2f0000, match?:0, fwnode name:(null)
> >>>>>
> >>>>> I conclude that chip->fwnode is empty. Any idea in which conditions=
 that node
> >>>>> would be empty?
> >>>>
> >>>> sorry for spamming, one last message before I sign off for the day..=
..
> >>>>
> >>>> Seems, adding below in the tegra gpio driver resolved the issue I am=
 facing, I
> >>>> was able to verify your patch series.
> >>>>
> >>>> diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra1=
86.c
> >>>> index d87dd06db40d..a56c159d7136 100644
> >>>> --- a/drivers/gpio/gpio-tegra186.c
> >>>> +++ b/drivers/gpio/gpio-tegra186.c
> >>>> @@ -989,6 +989,8 @@ static int tegra186_gpio_probe(struct platform_d=
evice *pdev)
> >>>>                 offset +=3D port->pins;
> >>>>         }
> >>>>
> >>>> +       gpio->gpio.fwnode =3D of_node_to_fwnode(pdev->dev.of_node);
> >>>> +
> >>>>         return devm_gpiochip_add_data(&pdev->dev, &gpio->gpio, gpio)=
;
> >>>>  }
> >>>>
> >>>> Now, few follow up questions:
> >>>> 1) is this the correct way of setting the chip fwnode in the gpio dr=
iver?
> >>>
> >>> You shouldn't need this. This driver already does:
> >>>
> >>>     gpio->gpio.parent =3D &pdev->dev;
> >>>
> >>> so fwnode should be assigned in gpiochip_add_data_with_key(). Can you
> >>> check why this doesn't happen?
> >>
> >> I do not see anywhere chip->fwnode being set in the gpiochip_add_* fun=
ction.
> >> The only reference I see is here [1]. Does it mean I need to change my=
 match
> >> function from:
> >>
> >> chip->fwnode =3D=3D of_node_to_fwnode(data)
> >>
> >> to:
> >> dev_fwnode(chip->parent) =3D=3D of_node_to_fwnode(data)?
> >
> > No! chip->fwnode is only used to let GPIOLIB know which fwnode to
> > assign to the GPIO device (struct gpio_device).
> What do you suggest I should use for the match as I do not see chip->fwno=
de
> being set?
>

This is most likely going to be a longer discussion. I suggest that in
the meantime you just assign the gc->fwnode pointer explicitly from
the platform device in the tegra GPIO driver and use it in the lookup
function. Note that this is NOT wrong or a hack. It's just that most
devices don't need to be looked up using gpio_device_find().

Bart

> >
> > Bart
> >
> >>
> >> [1]:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/gpio/gpiolib.c?h=3Dv6.6-rc1#n767
> >>
> >>>
> >>> Bart
> >>>
> >>>> 2) Or should I use something else in hte matching function instead o=
f fwnode so
> >>>> to avoid adding above line in the gpio driver?
> >>>>
> >>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Bart
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>
>
