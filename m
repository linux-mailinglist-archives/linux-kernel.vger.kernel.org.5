Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2911B7C6606
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377589AbjJLG6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377241AbjJLG6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:58:02 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B04FB8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:58:00 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59f82ad1e09so7826087b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697093879; x=1697698679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LM69six1InBTZLWkTEUw9fhsQh0Ijge8x6lDDJDQry4=;
        b=a91pK2LE+PxN4nWA3rFddtUTcjmL5Y8Xinaey7u3R8jEplauvrq/Mbpyjpmd2BIWnI
         Ty6c1oyAMPH5buBckGChIfPx6x67QuzAlHb8RXvp9UOhWc7LuRF0lA5B+QeozUOX/oBt
         DRW0qXk6NX4R4d2EOuhEKu6wsiuiLONhVo9HxqA/76pWnmYHS0JLQXvU8DEvFTQ2N2r0
         lfFfiDRYJKZwZWOYc//mP7+qHucdxoi4zRKmp3WtOuIBKuo8UtoopMYcC0cW2MIKKvK6
         Ov7gWAwcySAprPOjnHAN51bnyFKgFmDcLHBKT0140D/I3UNJ6Lr+yj4BpOr8znV6cg0E
         gnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697093879; x=1697698679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LM69six1InBTZLWkTEUw9fhsQh0Ijge8x6lDDJDQry4=;
        b=az9KY2H3H7l6YkD1c6aHmbm0sIts5vdwBPc3VmLcFViqHFTEOYydXEdenMDES5bmHt
         wxXa4EHnrvK8sX801FOUR3kyNw9Cy3adaJu49tCHsnkrgBQNfWDAsHxJCdUvIPfZKJld
         EL18rPjoWkeGQROQL3aE0cMJRPPkHyseXNTPxkelzgPPYKTuhVIl5xlojA0FaNe9QfL6
         9XUSieGPFy71QomJEd5zQQ5NV5s50dW/p3JPtiWz1ZncGK//RcqGwtjlt5uchvHpWb2T
         ehT3htaVzzJZOYVVMlDRJI5izOeJnp+GV0ZXUM3OLOhtmSOz5j5Q7xaYJbtCXfm82tN7
         91Qg==
X-Gm-Message-State: AOJu0YymXzKyQN8AqrxMQWzhTaxoiB0bM5HIuM48h+jy75U5Wm9Qbnjr
        6HMn5EgGmWGIOMmSI+o6fQLHBtJ8wj5tZLAxGzfKdA2RJjhGsJepAAg=
X-Google-Smtp-Source: AGHT+IGQP4VnanZFqXEMtI5+ShLzVdtzEVbFQP4fLT/CbIuZIDEdaVqY+lxfB6tlUvWGJFwv+1zzbITyyQzxoctdZIc=
X-Received: by 2002:a81:4e0f:0:b0:5a7:ba53:6544 with SMTP id
 c15-20020a814e0f000000b005a7ba536544mr8314062ywb.12.1697093879450; Wed, 11
 Oct 2023 23:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231011130204.52265-1-brgl@bgdev.pl> <20231011130204.52265-3-brgl@bgdev.pl>
 <CAHp75Vc2vGEYmbaurzEoh-ejkvFwGeo98LtAGvEq5idXNPgnRQ@mail.gmail.com> <CACMJSetxih3kwAVDpQNm_fApgdkOv-XfErqC8+hi7Nac4J+ZOg@mail.gmail.com>
In-Reply-To: <CACMJSetxih3kwAVDpQNm_fApgdkOv-XfErqC8+hi7Nac4J+ZOg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Oct 2023 08:57:47 +0200
Message-ID: <CACRpkdbdU-m6dBZk9rz+7MSS2+mn=Svb5G4jg60ebBfQ7-q6CQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpiolib: provide gpiod_to_gpio_device()
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
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

On Wed, Oct 11, 2023 at 5:39=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:

> The end-goal should be to make gpio_to_desc() an internal GPIOLIB
> symbol. There are still around 10 users outside drivers/gpio/ that
> will need to be addressed in one way or another. Preferably by being
> converted to using descriptors.

Conversely desc_to_gpio() as well, here is one fix for the current
merge window (yeah I keep churning away at this...)
https://lore.kernel.org/alsa-devel/20230926-descriptors-asoc-ti-v1-2-60cf4f=
8adbc5@linaro.org/

Yours,
Linus Walleij
