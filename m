Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF777BAAA4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjJETrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjJETrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:47:20 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF684E4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 12:47:17 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7afc13d58c6so578161241.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696535237; x=1697140037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLJjywY8LzZjMJ4Ua1HVIFQQKdDKE5FDxSdi//HT1kY=;
        b=ksipxG7GnTOnJHPTocs8DMa8TTDqe/zqjzlUHoZDTh7o/xP6ti8SfoVP/KqS449Oi+
         eesDdbM6FsviLCj5O99A5fsw1Y7vXgjWerHoRpBgSSe/5cMkINWDoNfwxTTrX1YFuYs3
         DBqfPfBbcJrSxvEo94EgRtHOQoY83qsbr5F206p1T2R5QfspgYWvQG0Oci8y+DxZNzej
         aJmN4hvekDQ33cONcYGoK/g2wJrjlGfjHgz2uFxMYhQZG7DLEyyIp6ZuCCewW1I1G2rh
         7ZXl39+SlYPgLqq5k0C27L73YNerFgs/cs+GTuX+r7VAXLHQOvHjz/jtIp6ZInH321Mb
         kIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696535237; x=1697140037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLJjywY8LzZjMJ4Ua1HVIFQQKdDKE5FDxSdi//HT1kY=;
        b=hCRqt17B5Dh03LbQ9bd9c9kU5F/u44Xt7A+PB1KsgBJrmLB+NJDtxhriElPiBlVv5z
         Py/mlXb8oWnkipnzbi14tczSW0Vkjd1TmwMoWXPpVcCEJVtfp7GsY0CIL4wqGLOf8h8z
         pfIjYjUi96tYZImzVxwTJVtDbCGSh2/j+C5gwvCT7sJg7mxT2DDbue4sAejPlFqmyVno
         m1SI21pUunBth0wpst1QHuJ4uMmmEtgCRr8N7Gw+LgvXetjo4RAotscoC39VdONY8Z2b
         OBFKzuFHgF+h2bIVi7PF4EhQrasCI0iHivlfRRlVrQNUudo/blQ+sTzwNVI2auc6UHfI
         IDmg==
X-Gm-Message-State: AOJu0Yx02MRtPT+23iXnepnS0s+ReRy1WSRbO+I3xMfObofPZ7XTNmi4
        04fsEqswJAk7LzM5XofSAhu0nlH2EBnH2kiu7Xpeng==
X-Google-Smtp-Source: AGHT+IGeCrpg8IFyQIUwf3s5xsWyEwFqrBJpZnT7s4icsTYPD3Db8KtwxkcdehXnz4szYazm/HNmJ5jwZdPOio+yInU=
X-Received: by 2002:a67:f65a:0:b0:44d:3f96:6c61 with SMTP id
 u26-20020a67f65a000000b0044d3f966c61mr6494546vso.30.1696535235393; Thu, 05
 Oct 2023 12:47:15 -0700 (PDT)
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
Date:   Thu, 5 Oct 2023 21:47:04 +0200
Message-ID: <CAMRc=MdKg8cOvNFw3ay-0XVCagWE7ArS7HgPZk-YrmeDJ4c4cw@mail.gmail.com>
Subject: Re: [RFT PATCH 14/21] hte: tegra194: don't access struct gpio_chip
To:     Dipen Patel <dipenp@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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

Andy, Linus,

Do you think it makes sense to make gpiochip_add_data_with_key()
assign the chip's fwnode if it's not set by the caller (and instead
taken from the parent device) for this particular use-case?

I think it's fine but wanted to run it by you.

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
