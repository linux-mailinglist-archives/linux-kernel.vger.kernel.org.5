Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C02801108
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378682AbjLARCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378634AbjLARCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:02:04 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0702198
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:02:08 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9bbb30c34so29782441fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701450127; x=1702054927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWTh4se+UruTw1n6D9cikBRfGAJlzspbt4OfaTxkr5o=;
        b=m4zBEm0Q7+2iCo3wggfcXtWIUfDN7FFqjNVpC614RWEXUURjyE5cNwZ2ulSzsPnIqp
         pnsluCY4yyKJr8Lm0dIG1zhmVd4aB/LYoB4guoG+v0+S2pjiv+5z90l8R4ipmtvXOLDf
         /5O486evXfYNyWKc/3mU3WmiPOSknN7UqdlJTJ2yyE+bgpxOXc7ArTI3Ezy2k8RNFCvi
         EOhWEVyKZIr68nsMedeIDCb+f/6m5ObdARn+liYUBq5qA8jnyKzaKP457R0fwyQhaVre
         3KZVjqoGTtHSu0f87KUEvGU6REufwaMDeD5ctPSKrjhNGzouXKwsZTwnXRA3jnYajwhD
         H8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701450127; x=1702054927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWTh4se+UruTw1n6D9cikBRfGAJlzspbt4OfaTxkr5o=;
        b=jMw3BMBXq7k+e/+oE/7xXj7QmfHruIPu4CpF/5fnauuzh2M9HF+F0ONdRofUCvQkel
         B9kln6VX/pzYcdho/m8ZaGEIoyy8DVLOG02dIR5XyEBoD5AIHet1UHhJtbivvRl8jgl7
         u4SuMcO/9iAUGb6xUfNHsOR4c9FFJNfBdrFY27C9ha7n9Nu4Qer1E2WNayW45KY8nZIN
         DIed6wrInfLo0sAf6NT3V9wfxJ5zNRGWAE5j903V6z5k5KKaGXQdQxwzqseas2iYgIQw
         QXn1DUHmKtXDgKGoYHHx/n/cov9HqBikNtnO6TFB2Mq8YD9W55U3lTkuBvY6yHgnawaO
         lPTQ==
X-Gm-Message-State: AOJu0YzWggdiRhAnfAgPdLhj6g+KHbXXx9L9JG/geNmZK7Gr85nDe1E1
        IROTnLzRmMaDbaJyGt2dHiP3q5EzEEZoe/pOcHsZPw==
X-Google-Smtp-Source: AGHT+IFzZhwCfRX+2zsNSp8Z0s3T+pMhyo8HmnS8o8v7ThxvW3SppTsn8thwCmoggkZ46Wv3+hYa15AKRWeebUC6O5k=
X-Received: by 2002:a2e:95d4:0:b0:2c9:d874:4b75 with SMTP id
 y20-20020a2e95d4000000b002c9d8744b75mr860509ljh.101.1701450127003; Fri, 01
 Dec 2023 09:02:07 -0800 (PST)
MIME-Version: 1.0
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
 <20231121-dev-iio-backend-v1-4-6a3d542eba35@analog.com> <CAMknhBGCqnzCp6vQ+59Z-SybScvbtU7aWdAD6KnP1e6=q60gVQ@mail.gmail.com>
 <d534c3323c32d4ed2aedae19a9f101be90ef0cc7.camel@gmail.com>
In-Reply-To: <d534c3323c32d4ed2aedae19a9f101be90ef0cc7.camel@gmail.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Fri, 1 Dec 2023 11:01:55 -0600
Message-ID: <CAMknhBGjm2ja9HOenOWi9O5Ao8qUg=gT=_Vz8CyxQ=pfNX2EJQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] iio: adc: ad9467: fix reset gpio handling
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     nuno.sa@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 2:47=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
>
> On Thu, 2023-11-30 at 15:41 -0600, David Lechner wrote:
> > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > >
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >
> > > The reset gpio was being requested with GPIOD_OUT_LOW which means, no=
t
> > > asserted. Then it was being asserted but never de-asserted which mean=
s
> > > the devices was left in reset. Fix it by de-asserting the gpio.
> >
> > It could be helpful to update the devicetree bindings to state the
> > expected active-high or active-low setting for this gpio so it is
> > clear which state means asserted.
> >
>
> You could state that the chip is active low but I don't see that change t=
hat
> important for now. Not sure if this is clear and maybe that's why your co=
mment.
> GPIOD_OUT_HIGH has nothing to do with active high or low. It just means, =
"get me the
> pin in the asserted state".
>

I would assume that this bug happened in the first place because
someone forgot GPIOD_OUT_LOW in the devicetree when they were
developing the driver. So this is why I suggested that updating the
devicetree binding docs so that future users are less likely to make
the same mistake. Currently, the bindings don't even have reset-gpios
in the examples.
