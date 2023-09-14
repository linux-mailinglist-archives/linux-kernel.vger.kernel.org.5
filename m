Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CFC79FCBC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbjINHFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjINHFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:05:03 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45640BB;
        Thu, 14 Sep 2023 00:04:59 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3aa14d8641cso372872b6e.3;
        Thu, 14 Sep 2023 00:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694675098; x=1695279898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzTdfD0LggvX1uBlCTC2vRtoepMYQzC2yBdB+oN7NDw=;
        b=pUI10C79RkUXxD/yVaIHXn6IPHQ7bA22lRHxYbPsUjafKbkR9ezty6ly8T+4Z1mdmJ
         Gc/kGq40vYZjsuTmDkkcSnIydBO7mT33onwziAdbOjnLMjOIl6anQowwRBph26xEULNs
         nFLz11rXgUDn0IS9f9Ua/n/VLFi5rjhBeRMfkUQ9UrAiSGMq3KyMaylpq9XaDK5y82Ll
         h4QTC1lZ8Oq6lNEJu5yg3N0PDGH9NhJIIyZdnW4mTSu6XtykSbblS5uZiS4DhDtA+VdN
         Hsia23aHJxectydeLWFBoICbIUTaO5HZhiTFEne8yHi/pBP4MgM5Te90LL3KJeBl5wHB
         w9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694675098; x=1695279898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzTdfD0LggvX1uBlCTC2vRtoepMYQzC2yBdB+oN7NDw=;
        b=J9r8vFwkY7USU2M/wjQRqcCbd2+w7Vd+Hw5hVfzaCALz4jDa2s6mwsJBZxUtJeadnF
         K+AxuN46FLHgfKdArIQOWhCX8z4XdYPPHcdZqEbSNWYPEeKxMBuGGg2L+ozzplI9+W6a
         puEub6Xc1tXF+Odgbi4wmSUU80kuB0b7vHX0Ywjk6v0KaRBx+ItiasxhIDPr2TQihVSc
         fOyvk5c3oxgFKXlSoODDVG6+zUGK6nhEHidezXQRyt0kizZtfZJQIkn81/2Bwud14jZX
         UqGGCPZA8bSKiQbUVkkzeQ9SamZWrZLDu9wfECTOy8v8ZZddTy138Rpj/lch61vPCDhG
         rb9g==
X-Gm-Message-State: AOJu0Yw+7Sp13inJSHZ7zB2XFVZWr21Sjt5Xci/v3Qi/+UM7RQ3Eiypq
        pCMXU8Q/rejNkDc3WL3G36ze80YFJ+ADwjpvUG4=
X-Google-Smtp-Source: AGHT+IEzUZhYY4nwIJ6Dlm9qukCO/53xQ9HZuRBayIOhSRBl2gZChNyMJPFJoM0Y2E3e3o3puld+m0KaJ40spNNiqwQ=
X-Received: by 2002:a05:6870:2397:b0:1c5:56f:ac08 with SMTP id
 e23-20020a056870239700b001c5056fac08mr5612105oap.12.1694675098534; Thu, 14
 Sep 2023 00:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230913115001.23183-1-brgl@bgdev.pl> <20230913115001.23183-3-brgl@bgdev.pl>
 <CAHp75Ve8aK4Pfid1JYWH86mKy-Zb-G2QDPrJYmRzPCYOsn1TqQ@mail.gmail.com>
 <CACRpkdYtYDJa6fo6RnizHNzUsyazBQxEaNMznaij8rBF4ie+ew@mail.gmail.com>
 <20230913222338.07d1625b@xps-13> <CAHp75Vd2a06rnGCEiJW0reN00amso0RyvgLT516nZiYLYZ-xcQ@mail.gmail.com>
In-Reply-To: <CAHp75Vd2a06rnGCEiJW0reN00amso0RyvgLT516nZiYLYZ-xcQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Sep 2023 10:04:22 +0300
Message-ID: <CAHp75Vdn9a8a-E=RuByNL8B93cNHuusVrqE-RnH4f3+WgxJ22Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] mtd: rawnand: ingenic: use gpiod_set_active_high()
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:02=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Sep 13, 2023 at 11:23=E2=80=AFPM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> > linus.walleij@linaro.org wrote on Wed, 13 Sep 2023 22:12:40 +0200:
> > > On Wed, Sep 13, 2023 at 10:05=E2=80=AFPM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Wed, Sep 13, 2023 at 2:50=E2=80=AFPM Bartosz Golaszewski <brgl@b=
gdev.pl> wrote:
>
> ...
>
> > > > Why not moving this quirk to gpiolib-of.c?
> > >
> > > That's a better idea here I think, it's clearly a quirk for a
> > > buggy device tree.
> >
> > Agreed, it's just for backward compatibility purposes in a single
> > driver. I believe it should stay here.
>
> I believe Linus was for moving.
>
> gpiolib-of.c contains a lot of quirks, including this one. Calling

To be clear:
"including one for the same issue"

> these new (or old) APIs for overriding polarity in many cases
> shouldn't be needed if there were no issues with DT or something like tha=
t.

To be clear:
The less we call these APIs from drivers the better. Ideally these
APIs shouldn't have existed.

--=20
With Best Regards,
Andy Shevchenko
