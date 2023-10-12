Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058517C681B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbjJLImO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbjJLIlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:41:11 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971CFE1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:41:05 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-45765b55fb1so306158137.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697100064; x=1697704864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUchK6yJhWz//C11XsP9G4+UgwQz+J3953UrtKHKsyw=;
        b=vGCe0GShGTAC9HXmSE+ZVlC2obZlIVJFaDBkJT7AbyXnZc5QlToNo5SYJKFg1LQhn+
         LZFc25bflj8y0KZUMsoxQdcxU2Q/Ay+/Xm+1nU5Af6YI3LFldT8/9RKPOwmDKgk3UzGB
         JEm6tJqSjU6J9yW9NY0AdDsWq/i4wA6ICUQip1BsV04Zt61Yp1bdizRkXylLrrZkR1Ta
         erllzsf9w/d8FujiTHxaWU11xOOreL8TpnyrH6tLxKj7bL9pwf5Sicz99UC/UcLsGIch
         z7Jno8etSNMfTPRwMqLX9YHOsSR0wo+iW8OmsTlQFJ89h1io2pJ+JZk+f/HF4B3DzSuG
         EsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697100064; x=1697704864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUchK6yJhWz//C11XsP9G4+UgwQz+J3953UrtKHKsyw=;
        b=q8W31Yxa48VIetKTve61zU0sFdkb9nUMukgLob6u+hF97XJTttiFEC5WXnN1WhCpSw
         OgJe/e6XLSYP2+D2sQFOSnGWaBHngVV4Y29yHT5YC7pSS6nbloDNxKz9WC9DIqxnwyZ6
         FnU2OqvsrGE9hnxWgR1W4Pid7J4J0qzAEY8Rc8aivIPLuYu159/RLJO5TQUGH2YC53nS
         z4vXGhdumCyBRuLPRYZx3JqVI0A8xnOk1GCPBP7tAI6NE92bOucWGzem+Sw5FDdIBkGV
         gBeCU4dzfK7gnz6ak58Q24Uj5VJBsJx7jSzr1xRwdcbTyyNwHoTqj1ehRYi5YR+pSH7P
         tpXw==
X-Gm-Message-State: AOJu0Yz2V/HjQbLrJ3XmyvmctOWrsEktBJiMg9C2DU9m9HIGOsFBQdrv
        3rS3uoc625621Y2h/CQNkwKuAhmP1NM6cMXilP9wew==
X-Google-Smtp-Source: AGHT+IF9dUsX+Hz7Ltj1VdhDlRQXrND9ZDGSpF/nQuUTN95JKBLTZeKF9tkB6NlevfWnHqdaQynTkwpw0WqGRUIvfv8=
X-Received: by 2002:a67:f6c1:0:b0:452:7748:4700 with SMTP id
 v1-20020a67f6c1000000b0045277484700mr22457659vso.2.1697100064677; Thu, 12 Oct
 2023 01:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231004183906.97845-1-brgl@bgdev.pl> <169696282723.222014.3485016870976123694.b4-ty@kernel.org>
 <CAMRc=MenBeJV+p6LirsCfyaPRWfAvSrVQayqUc77KOyvRGMqvQ@mail.gmail.com>
 <f1b8555b-5acb-43cd-b48b-1dfafdb8d27c@sirena.org.uk> <CAMRc=MdLXjnYiTjfoKjqAVcLvG5r3p5mWYbSupDM3Di-BAe5eQ@mail.gmail.com>
In-Reply-To: <CAMRc=MdLXjnYiTjfoKjqAVcLvG5r3p5mWYbSupDM3Di-BAe5eQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 12 Oct 2023 10:40:53 +0200
Message-ID: <CAMRc=McY2d0tHE18qn5WAPYwTwFn+TVZt48WA-t5tMwzkPsjvg@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm2835: add a sentinel at the end of the lookup array
To:     Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
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

On Wed, Oct 11, 2023 at 1:52=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Wed, Oct 11, 2023 at 1:45=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> >
> > On Wed, Oct 11, 2023 at 09:36:19AM +0200, Bartosz Golaszewski wrote:
> > > On Tue, Oct 10, 2023 at 8:33=E2=80=AFPM Mark Brown <broonie@kernel.or=
g> wrote:
> > > > On Wed, 04 Oct 2023 20:39:06 +0200, Bartosz Golaszewski wrote:
> >
> > > > [1/1] spi: bcm2835: add a sentinel at the end of the lookup array
> > > >       commit: 9aaa25df9b02bfe5579cbc9b4cc1177c662ec33f
> >
> > > Can you provide me with an immutable branch containing commit
> > > 21f252cd29f08892d48739fd7513ad79c1cff96a (the one this one fixes)?
> >
> > > We are very close to removing gpiochip_find() from the GPIOLIB and
> > > with this pulled we could remove it for v6.7.
> >
> > Ugh, *please* say this sort of thing when sending patches rather than
> > waiting until after they've been applied.  The default is just to add
> > patches to the normal development branches which means they have the
> > whole history for the release cycle after them and may well have other
> > things applied on top of them before you get round to asking for them t=
o
> > be applied on a different branch as is the case here.
>
> I'm sorry. I didn't expect the removal process to go as fast as there
> were quite a few users but it turned out to be almost ready now.
>
> We can wait until rc7 when your for-next branch will be more or less
> immutable and then you can tag
> 21f252cd29f08892d48739fd7513ad79c1cff96a alone (it only has a few
> commits between it and v6.6-rc1) if that works for you?
>
> Bart

Alternatively - if you send your SPI PR to Linus early in the merge
window, I will send the patch removing gpiochip_find() later on top of
it?

Bart
