Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D857D74EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjJYT4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYT4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:56:45 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D3DE5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:56:43 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9ad67058fcso89198276.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698263802; x=1698868602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XFWueEfiw2bQQie01J9PQDSlZE4Y5T3Z8ssKqoKnFg=;
        b=Ghe4xlz7glUos1/u3uBIlRZfHGRuHPtIH2qxGf15SrKXpx6VgLi6b/449MHmR8v1Ri
         2IoQeCPjSfULapuWbxBwHLUAosuCWJRlzo6V31km557GUXKBpqQUuaLBt/djqxdi+ejd
         jwe78yZgtQOAW2Q+si7ETjFBA2sBOqJAlyqzEcNxoRnJeP2+vs2VSGHlBV0bZtUSDSjm
         +dfpetrK/CgDiZWULIvQ0t7pH0pXnGRTNjhakRfV+zLwRgfJbUvKm3ePIvD7gNCU/S1y
         gKaom4HAFOKhjphkQJnSSh1zg6NjB6GYSkrNI8FmCCH0nNbrurbqKkPlzRFULpdJjeZB
         LnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698263802; x=1698868602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XFWueEfiw2bQQie01J9PQDSlZE4Y5T3Z8ssKqoKnFg=;
        b=mOjM6v3dLpOAT0DCCE3DY5sfFhIDqv/NwLhs7xV05xXhjTK4leaNK+YYjua9oEosgF
         3WD5WyM3kizr+Clc6BFYF//QqlgNIJGMt1IDVYS5iUF02vumJaGFhjo4Vqo+3o/Ec+Iv
         iTUHaTCbqx9s2sVBkflElAk6e/rrrA/HP716uxeYOexh+z+Q/uAuLYXWYC5cRmEHdE4Y
         ihPGxXznJ108kH6I0WkaA0dVd0iTH1cUn4ZXEgNflfJ2dJ111uLBsL7aK1iROZ9SfVAt
         E0XHwuMW1jC8ByWeYbpO8G0g70kJgSf3NcEEYhW4eHe/0vOTto414t/BQNw+crM9wz0O
         DSTg==
X-Gm-Message-State: AOJu0Yy9ramqcQfj6HkQVQYymj9yEm2PnnqSc7XzWRiB61NWD9LTJPeM
        TXUwEm0l6xoLuEV5gmM9MlML2YwRZMHXl5jfs95xOgn/oO3S5dOc
X-Google-Smtp-Source: AGHT+IFJkZOHWlTMDfZ6ny4sx9Gcul7tbovkfov6ZFVIneYanJF4VBjexpZoal2wlEsZeHUtz+szrVzhkR5QuVTyJQQ=
X-Received: by 2002:a25:cf14:0:b0:da0:3475:c5e9 with SMTP id
 f20-20020a25cf14000000b00da03475c5e9mr7623910ybg.18.1698263802406; Wed, 25
 Oct 2023 12:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231025190619.881090-2-robh@kernel.org>
In-Reply-To: <20231025190619.881090-2-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 Oct 2023 21:56:31 +0200
Message-ID: <CACRpkdZ9PPnGybvf2eBqBTS8o1QRat3n2SCjSPc0=ZKv3AvGyg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] leds: syscon: Support 'reg' in addition to
 'offset' for register address
To:     Rob Herring <robh@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 9:09=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:

> The register-bit-led binding now also supports 'reg' in addition to
> 'offset' for the register address. Add support to the driver to get the
> address from 'reg'.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-leds@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
