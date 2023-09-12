Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC8679CFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjILLYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjILLYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:24:13 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1114E1719
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:24:01 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7a512434bc9so4020232241.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694517840; x=1695122640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLhc8iMbw9INgbW/oH4hagu1vdQLEQ9RJpYm3m2tpso=;
        b=EJ14mE1s0P/favfYDo/bVmr8+1V8vvlJGd4UVr0X4Tw1QUqcxvcKqUfsC39zX3r9u9
         g3n4N/dwm76jVeLqHLwMACBERcV5XQF6BCNCLa2SCIp8CJ+jccdwOv3a4jDTfmZ6BGtv
         Z7rkmDHfWomg/jYJFEDwKAI+DtChyx9o/bSdMgAeI5NuNGyQtP7HgsW7pHk0UIKzRk2m
         Vz7wjjUKn1mRt/WQqKaQNSiY237QOzu6WxO/icRxjPQiDGHJ12MBMWwsEnl142JQaXUD
         S0RitoGKNPcuo5hYnXmG69R+wFI1fSElt/Bkgk2o3kv9tKlzeoZ2NRYyOmSQX4CE/RUf
         jBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694517840; x=1695122640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLhc8iMbw9INgbW/oH4hagu1vdQLEQ9RJpYm3m2tpso=;
        b=UJrwugXPQSvItX/Fdn0B07RX5X/M0jnslooZ8m0TgyI/eJxxavdrp8B/nDOgG8OjCz
         UILA+piH/1ACpcVIzsOCJWzWPer7n82aAtuSRhi+fO38jAux0SJTTBb6lwFhwhAxNoFb
         Gg1MPjhY8bGAyWWIoSrdVLrFs6OAVki6oFOWeEj7+qZ6nb7WXYX3SXVrltRLrHbp4EAO
         xvSjuGKJ9S9hMgNsgik9dmXrxKP9t+bNwJ96IKcEzIn24oDw8qnS1J3Q8dKax4mfcjnK
         e4+l/6cXksYvcUK+50uewHtI7ifW7QQPs+5+gVxJt7xJNwqjoTwnF3KMhCFOWN7hdpYO
         gcsg==
X-Gm-Message-State: AOJu0YwHv9XePYvMLVZjDOJ5ZVWtvEY52PG4HTbyYTrBz7Zr2RE5SCgD
        xUqbjjD64XH7CcPYeP+skTH0vNjHAPtc4lMSkJdViQ==
X-Google-Smtp-Source: AGHT+IE4IqCuIX3KrrXjgai861PYFw3vAuWDA9SCwCjZEAr6cx8Pa+/+T2iZB8t5fAoLBp5JFtsLxbs18LIJDUBwJX4=
X-Received: by 2002:a67:e918:0:b0:44d:453c:a837 with SMTP id
 c24-20020a67e918000000b0044d453ca837mr1156694vso.11.1694517840104; Tue, 12
 Sep 2023 04:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230912094519.22769-1-brgl@bgdev.pl> <20230912094519.22769-2-brgl@bgdev.pl>
 <ZQA+716X8EVmIRAt@smile.fi.intel.com>
In-Reply-To: <ZQA+716X8EVmIRAt@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Sep 2023 13:23:49 +0200
Message-ID: <CAMRc=McVgkt+BQ33dYE0V3-dWcJbNHALaE4-Ao02Y7jh=P=0rg@mail.gmail.com>
Subject: Re: [RFT PATCH 2/3] gpio: eic-sprd: use a helper variable for &pdev->dev
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:35=E2=80=AFPM Andy Shevchenko <andy@kernel.org> =
wrote:
>
> On Tue, Sep 12, 2023 at 11:45:18AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Instead of dereferencing pdev everywhere, just store the address of the
> > underlying struct device in a local variable.
>
> ...
>
> > -     return devm_add_action_or_reset(&pdev->dev,
> > -                                     sprd_eic_unregister_notifier,
> > +     return devm_add_action_or_reset(dev, sprd_eic_unregister_notifier=
,
> >                                       &sprd_eic->irq_nb);
>
> Ping-pong style detected: Lines added / modified by previous patch in the=
 same
> series got modified again.
>
> If you look at how I do that, I introduce the temporary variable with my =
new
> code and then reuse it later on.
>
> OTOH, I see that the first one is supposed to be backported (?) in such c=
ase
> perhaps it's fine.

I would typically do the same but the fix comes first in series.

Bart
