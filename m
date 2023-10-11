Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D031D7C4F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbjJKJeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjJKJeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:34:06 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45D991
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:34:03 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4a13374a1e8so1119160e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697016843; x=1697621643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amS2AGWHC9KublVJ1Jpa3dwEwkd9FC/Qfrwz2qjG5V0=;
        b=kjBtbwVs95jngRTsBx3EDfl2v1blRZs/skqsni/6Tj7o0M4Q3IveeFlRqJ3htpT+gV
         DO6AicUvTlh+p4RfyNjGTnsfAojdVslFcwx6+x50ehIi/WB2x2vOb5//SClkhYl8uTkg
         6BTvapCEv19PbQ8hdZE+mz4b7fKL1nqCOG5z5dDZHLOTjVsgv/33Mt1c98k2goDQGGp+
         ueqDex5GQTR3qzU5+wgC9CJFURg4z5q8kN7tgetXhuGBTGmwCsXvfSBcximqlFuHky/x
         Jv/5OGQCv/nSnmRvivuUFwpijSNhPvDARUcjDlJyynTO7Xo6lu7T6zWlZ4N1KgBGoAwX
         satQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697016843; x=1697621643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amS2AGWHC9KublVJ1Jpa3dwEwkd9FC/Qfrwz2qjG5V0=;
        b=iICYccu0iIVux++MH5P1/0x2JhffmuZG2SfjFhVdldwubAR5f1nfgmT8+H95X7ESH7
         R/riQtzPgSRRVzUTUDxv4tcbUkDxHbtVg5uon/sBs3Cd+b6qUTXlH5JJ3YrKfoXn8gFD
         9ue5SzyxFCHho0oe0YVTxo9Yu3dGC6FBVrZ0nzgqif6FrxcKJMsyNM8/ZsiUIEWOvPsw
         rpK5lUfsQ3o4UgdSSgfc0vrRZ70FzyjTZEv09XjLfp1QJgSvvFUijDz4vnLgQTNIAIyJ
         fsjhYiYQ+BZG+TiUf9vpwE7qDPa4SrhxJ3TQ89lS3rgSgoqPKud1jPz1WKTzspLsgxoX
         qu+w==
X-Gm-Message-State: AOJu0Yxlujl35ZXcNL75yis+kORF9HXHOpUfI785hysseK895XLw7F4X
        6zc4B+dWwz8Awxf64XmziizXZ/llWSxXeCuTqh548Q==
X-Google-Smtp-Source: AGHT+IGkIVkgSmG4dkgU+VBkUH+FMIsXlPaccGP9vqrk6hShP3Gs1TPG08W3iXU77qMOioF8utaz21CClfuklwaJ4wo=
X-Received: by 2002:ac5:ca1a:0:b0:49d:efe:520c with SMTP id
 c26-20020ac5ca1a000000b0049d0efe520cmr17438575vkm.12.1697016842719; Wed, 11
 Oct 2023 02:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 11 Oct 2023 11:33:51 +0200
Message-ID: <CAMRc=Mdiuth0=XPBsoStXN81ydfpUfqm1BMc2TZOT4Kmx6jNkA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] hte: Improve GPIO handling and other cleanups
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
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

On Tue, Oct 10, 2023 at 5:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> This is a series provides a new API to GPIO library (so far only
> available in the GPIO tree), and respective update to the Tegra
> HTE driver. On top a couple of other cleaups (patches 3 & 4, they
> can be applied separately).
>
> Patch 2 inherited tags from its respective discussion thread [1],
> but I believe the Tested-by needs to be confirmed again.
>
> Due to dependencies this either should be applied to the GPIO tree,
> or to the HTE when GPIO updates land the upstream (optionally with
> the first patch be applied even now to the GPIO tree independently).
>
> Another option is to have an immutable branch or tag, but I assume
> that was discussed and rejected (?) in [1].

The series looks good to me. I'd like to take patches 1 and 2 through
the GPIO tree once v2 is out. This way we could potentially remove
gpiochip_find() for v6.7 already.

Bart

>
> Link: https://lore.kernel.org/linux-gpio/20230905185309.131295-15-brgl@bg=
dev.pl/ [1]
> Cc: Dipen Patel <dipenp@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
>
> Andy Shevchenko (3):
>   gpiolib: provide gpio_device_find_by_fwnode()
>   hte: tegra194: Remove redundant dev_err()
>   hte: tegra194: Switch to LATE_SIMPLE_DEV_PM_OPS()
>
> Bartosz Golaszewski (1):
>   hte: tegra194: don't access struct gpio_chip
>
>  drivers/gpio/gpiolib.c      | 20 ++++++++++++++++
>  drivers/hte/hte-tegra194.c  | 46 +++++++++++++++++++------------------
>  include/linux/gpio/driver.h |  1 +
>  3 files changed, 45 insertions(+), 22 deletions(-)
>
> --
> 2.40.0.1.gaa8946217a0b
>
