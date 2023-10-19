Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD507CF3A2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344967AbjJSJLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjJSJLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:11:39 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60564129;
        Thu, 19 Oct 2023 02:11:37 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d122f6294so49991396d6.0;
        Thu, 19 Oct 2023 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697706696; x=1698311496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4MfVkjTMc7fccstJOqrfKSItoKmWfmNa1V33PWbhoI=;
        b=g1Je7CJ5nzWVJOKZsw91Qnx08YffthyF7LTB3hbWFSGTSwsv6ydCj5+JPEtctISe4b
         oKdvarGe5JHgsdcERk0ZieBHykD0tRgmSjkCU5NKHSbrEV785Y2gPyr/mbUcPYWbkG5B
         TCGmsP/hRDKf7JgoHOdWf1rk94h6a7AgWv+EeUoC/fjFgviQpUo0hEG+OS/mRXqdfJB6
         UAnUcwZl7F+fqGyJBMBOasuHnfXmw7rbqYVnTbQSQF98c7P3LdXWPUBMe++VoK+XqsAg
         hrUEUNQt8wubOdZO8+SfDnaa/vg3WmxRHtjb0UcuY/wGoBee99ITByqQGf4dHFhVKZDd
         d7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697706696; x=1698311496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4MfVkjTMc7fccstJOqrfKSItoKmWfmNa1V33PWbhoI=;
        b=lVEYsJmNm3nM4abPAvUaYLE05fw5rdZQyK2LaSo/Hf2ukUfcfcHWGNayA8FKS8sHl8
         /b05m44jmevjNRpEV8iTnAJaVFztn33oqfyHzqemsf6PKU0/6/MvUwHXTsNUJtv8nxsZ
         BZwB2rMS6W6u5QyijCSY8rYggN237O2pqIiMPCAHH77KHQFtVYJALmO/biVz1n4AE8hV
         Ng3yKs0A0lahfHNXeMIihkhH20ENlY3lDBgz/OFhhBSd4FJ2jnNZaG1dBivlmcPXaDMT
         Hv/Yn6W5F0d/tiFY1bIVrBaWqMvvLXzI0NcrZeNgoSDRWz8TRuCEGTZ3DWSHDRdFRjFm
         tddw==
X-Gm-Message-State: AOJu0YxUsHEMKfFaSMJR4V/V0+miiosGKtVFa8oHgtd3kO3y4aXpW2R9
        4Oe8dgoGRYZfVCeevzF5WaQ8lzLz4v8PkxcIqXk=
X-Google-Smtp-Source: AGHT+IFKvUJzMKNIFZwmj6Nh/2FY9BLhZkBq2xT09jrp42+mrBBAqOadAUpwagi6FNtEWCpUc1GOKlB37G/7HlW7iC4=
X-Received: by 2002:ad4:5b8b:0:b0:66d:4a22:d7cd with SMTP id
 11-20020ad45b8b000000b0066d4a22d7cdmr1776970qvp.60.1697706696428; Thu, 19 Oct
 2023 02:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231018182943.18700-1-ddrokosov@salutedevices.com> <20231018182943.18700-10-ddrokosov@salutedevices.com>
In-Reply-To: <20231018182943.18700-10-ddrokosov@salutedevices.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Oct 2023 12:10:50 +0300
Message-ID: <CAHp75Ve+1j26UAqcipHX7JAOFDAEUMHBTv1aq2XPhUCGyW90nA@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] leds: aw200xx: add support for aw20108 device
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        kernel@sberdevices.ru, rockosov@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org,
        George Stark <gnstark@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 9:30=E2=80=AFPM Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> From: George Stark <gnstark@salutedevices.com>
>
> Add support for Awinic aw20108 device from the same LED drivers famliy.

family

> New device supports 108 leds using matrix of 12x9 outputs.

LEDs
a matrix

...

> -         This option enables support for the AW20036/AW20054/AW20072 LED=
 driver.
> -         It is a 3x12/6x9/6x12 matrix LED driver programmed via
> -         an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
> +         This option enables support for the AW20036/AW20054/AW20072/AW2=
0108
> +         LED driver. It is a 3x12/6x9/6x12/9x12 matrix LED driver progra=
mmed via
> +         an I2C interface, up to 36/54/72/108 LEDs or 12/18/24/36 RGBs,
>           3 pattern controllers for auto breathing or group dimming contr=
ol.

For better maintenance I always suggest in the cases like this to
convert help to provide a list of the supported devices, like:

  This option enables support for the following Awinic LED drivers:
    - AW20036 (3x12)
    - ...
   ...

And if any new comes to this, it will be just a one liner change.

--
With Best Regards,
Andy Shevchenko
