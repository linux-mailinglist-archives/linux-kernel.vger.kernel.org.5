Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2127179FCAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjINHDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjINHDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:03:07 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922A2CF3;
        Thu, 14 Sep 2023 00:03:03 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c09f1f9df2so382064a34.2;
        Thu, 14 Sep 2023 00:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694674983; x=1695279783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30YvJco7VTNawIeVj2mQFLvYk/DMezr2VBhiarmaxjs=;
        b=n8EGzOKderE5rofXQQ7J3iHup1q3R1LWtDz7EFdCrAFCt5K6Y68/amQBqoHkkYwyaZ
         UDhYjcUzbXGi6yZ5E5ZKGpBo0calaLrnWev3pICQrstobaF675/tEAMYrtTNhLXjvQwP
         3Fp7O9JtCriPo4sWSNDQGH1rbRHt+gXGGMdPcthgVt4jZNlp8EphcaSF6Juu4WDpRq3P
         NM2WJXj13sbFn82dWA5teUJ5QVYOykNOMxik8TAcfo3WkXrENIJt3riK7ggfoJ2735hY
         gQzMSy1sCc5BBwNVRdKVr+ihEhY1Rr/i/wtEEWw/yGbe1SSAHuoT7MIupcPnhSvYSpN3
         tJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694674983; x=1695279783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30YvJco7VTNawIeVj2mQFLvYk/DMezr2VBhiarmaxjs=;
        b=naXAClTRTMcgMPHQeHEceHb2WA9ubY/bchOxFuolkPpSYHw+XtpiAZouTFbid8RiG0
         v/uOxdLK6PYpRYXgKpMLSQ52J8sLpuo+6n08NzNsA903hfi/oBwoa1fGh3GyGifpv6wj
         9xnOFdkyQcnzV/R8Mog8dU32MEHgJN6cVI44We/0ztqnzX0NKfPv7iD1dQ9NSLszyekw
         gR2GBuEOVKmj9lNkdo9Buc0mtccOyW8ZmfcwKYTUOeDHEo6ZCHRbBoaBGS8brPj45dA1
         phqItLeJds3xBppk5bMv30KwchdubwcqZRS0TvWaZuDj7f6vKqlwaM8FRANDqpnbsxMf
         xQcQ==
X-Gm-Message-State: AOJu0Ywq6ZO1pAYIrspfnfpHaQOODKeWx7lpvBahTylJTS0XaQlkmlQ/
        p80JpIBEjC0ZCMHCwUGqg8B6uDRRHdMZ5jLKVgg=
X-Google-Smtp-Source: AGHT+IFwN7KC0MP+yRN7HXC+8WIaA9T071jv684OsNuFmbXU0T8YGXPQiTees4sH/CN6Q5P9OE3eUQ43ejp33Zd91jw=
X-Received: by 2002:a05:6871:5ca:b0:1d5:a85a:13b6 with SMTP id
 v10-20020a05687105ca00b001d5a85a13b6mr5395171oan.45.1694674982809; Thu, 14
 Sep 2023 00:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230913115001.23183-1-brgl@bgdev.pl> <20230913115001.23183-3-brgl@bgdev.pl>
 <CAHp75Ve8aK4Pfid1JYWH86mKy-Zb-G2QDPrJYmRzPCYOsn1TqQ@mail.gmail.com>
 <CACRpkdYtYDJa6fo6RnizHNzUsyazBQxEaNMznaij8rBF4ie+ew@mail.gmail.com> <20230913222338.07d1625b@xps-13>
In-Reply-To: <20230913222338.07d1625b@xps-13>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Sep 2023 10:02:26 +0300
Message-ID: <CAHp75Vd2a06rnGCEiJW0reN00amso0RyvgLT516nZiYLYZ-xcQ@mail.gmail.com>
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

On Wed, Sep 13, 2023 at 11:23=E2=80=AFPM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> linus.walleij@linaro.org wrote on Wed, 13 Sep 2023 22:12:40 +0200:
> > On Wed, Sep 13, 2023 at 10:05=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Wed, Sep 13, 2023 at 2:50=E2=80=AFPM Bartosz Golaszewski <brgl@bgd=
ev.pl> wrote:

...

> > > Why not moving this quirk to gpiolib-of.c?
> >
> > That's a better idea here I think, it's clearly a quirk for a
> > buggy device tree.
>
> Agreed, it's just for backward compatibility purposes in a single
> driver. I believe it should stay here.

I believe Linus was for moving.

gpiolib-of.c contains a lot of quirks, including this one. Calling
these new (or old) APIs for overriding polarity in many cases
shouldn't be needed if were no issues with DT or something like that.

--=20
With Best Regards,
Andy Shevchenko
