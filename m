Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2C67CF3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345074AbjJSJND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345047AbjJSJM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:12:57 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AB1FE;
        Thu, 19 Oct 2023 02:12:55 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41ccd38eaa5so1752491cf.0;
        Thu, 19 Oct 2023 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697706774; x=1698311574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jm+a1EuoiTTN/alkQCgFR86RQ23t58zNKZMZBfegWhg=;
        b=H9hZ0yD7LWtbQmxigkVCo7zP6lJEBV9/+ctLyEsb3QiLtMTbz4Hp8PDoU2+1WZfv06
         q6TFwxGE8GE7+V3djnGB3p0wYejYR8e/1NMw395pn7cgt3woeP8ZI5Yssb/pv2+4wZhE
         OSFvXO/Dv+qIt3dNtJfbRNZsBdhkOyXlVwFH+9uAGGN261JdckUpaKg6wBz07IZihxH/
         cB0dIUVkgTzmd5Q3Eiq8rumEIpGU40qwK9tvOeyrJIdjRgtWDgLz1Z10U6qb3Ca4dBxZ
         RzGyEehU4gbsT3l9pluQtaMKmFXeBH2ZBPLeU/c9S/ZjoPJJ9HSzqvV5sLvEA4YCXe2t
         KNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697706774; x=1698311574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jm+a1EuoiTTN/alkQCgFR86RQ23t58zNKZMZBfegWhg=;
        b=DXQISz9bl+XmFzSESN4ECuiHkXIvcGJHn5H0SmRZcmNl0L2xYcxGzz8bboTjqyJ5+c
         4qbJmj6x9m+UBhosirw7nolxAgC1aL7kZYA8ijjsYKG2OoU49UN+N6XZetu83TDMtDmJ
         8DBokZ9Uq9yGTIVkRUvfUQ3CzawGsFfyLr/pcrUScKGdDQ6SpArR1s8aY4nnDj63ZF1g
         GuGkh5vWGhytBhXm/Ro8nBXGpU3ZAgQB3wsxf/W3x0I5/BqPcklo2Eq/GWALB2y9kETG
         6Gmiq0vrvNbPcV3WYzAgypAE9VbfdFrOp8d3hNDnKON8WNAav3FKa+9Qe65045E4CDZZ
         R86Q==
X-Gm-Message-State: AOJu0YwEIGRJfTdZmSOjFi1/7EL2RAi0y1+mMneUw9d2WY4RMhV/C8An
        dpDy78yMWP/Xr4vr/l10ZSkkyy1fVqdqQf3Xdtw=
X-Google-Smtp-Source: AGHT+IHKctxTIP1mKKifGm4PH2K3oAfQsayvzmk7PTKwPL1yB5kob8ZPzhInkP5uc0PgDckeLJGQE5tohnO2/KT0VYE=
X-Received: by 2002:a05:622a:1790:b0:41c:c27e:f8f6 with SMTP id
 s16-20020a05622a179000b0041cc27ef8f6mr1515910qtk.23.1697706774348; Thu, 19
 Oct 2023 02:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231018182943.18700-1-ddrokosov@salutedevices.com>
 <20231018182943.18700-10-ddrokosov@salutedevices.com> <CAHp75Ve+1j26UAqcipHX7JAOFDAEUMHBTv1aq2XPhUCGyW90nA@mail.gmail.com>
In-Reply-To: <CAHp75Ve+1j26UAqcipHX7JAOFDAEUMHBTv1aq2XPhUCGyW90nA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Oct 2023 12:12:18 +0300
Message-ID: <CAHp75VevbE=t1V-zCGNXaW=1W2X6CxBGeTD5hUrrH3rWw_tNgw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 12:10=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Oct 18, 2023 at 9:30=E2=80=AFPM Dmitry Rokosov
> <ddrokosov@salutedevices.com> wrote:

...

> > -         This option enables support for the AW20036/AW20054/AW20072 L=
ED driver.
> > -         It is a 3x12/6x9/6x12 matrix LED driver programmed via
> > -         an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
> > +         This option enables support for the AW20036/AW20054/AW20072/A=
W20108
> > +         LED driver. It is a 3x12/6x9/6x12/9x12 matrix LED driver prog=
rammed via
> > +         an I2C interface, up to 36/54/72/108 LEDs or 12/18/24/36 RGBs=
,
> >           3 pattern controllers for auto breathing or group dimming con=
trol.
>
> For better maintenance I always suggest in the cases like this to
> convert help to provide a list of the supported devices, like:
>
>   This option enables support for the following Awinic LED drivers:
>     - AW20036 (3x12)

(and other specifics can be listed in parentheses, or in free way, but
short enough to occupy only a single line)

>     - ...
>    ...
>
> And if any new comes to this, it will be just a one liner change.

And you may do that conversion as a precursor to this one and you will
see what I mean.

--=20
With Best Regards,
Andy Shevchenko
