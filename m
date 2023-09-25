Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACAE7ADDFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjIYRsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjIYRsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:48:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F79111
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:48:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso857361966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695664081; x=1696268881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/UN+h0syPysLtxsvFcqWbygnTfY7kE0+mV4pd8zbOE=;
        b=RYEr9cYaG57l52hf6D92FVsynybyMfC04x1z06kXcMPBIFTgkV3pwcPmmyEh6CHsmZ
         k9CFkgieBKsHcaSx4R3liGCSX28LEbeboiK6HiPvLpc3mbsX5BoMREGE+yark4ZU3Se3
         VJxat/ofNc+oYjiaENTdqRdcvyCkWWctYItLGqsHgn0EUopDDxjbN6Mym/OnxCnTFgci
         d58HDyP4YLN3C8hXPz7utdfofyPoHVPy9lWxenzQJSsJQ0YLBxQ2aZ/fwf4G4dQoJ1UQ
         5nXUnkFKlAgaAglDfKOysQpm/JFwVkhIaP4uidAO8XxBrxUfw7/wjSsqM/Sx4fqXv9q5
         QFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695664081; x=1696268881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/UN+h0syPysLtxsvFcqWbygnTfY7kE0+mV4pd8zbOE=;
        b=Z95iR5yLvh/NNZ1fsBjRxcdqa7qrr38gwTMBgwA+KUJ23bw+ngyToMXzTg9WSvpJI0
         j+R4YqNg5GyZ2xaDc8/VzOWCJtasiazOi9+Ip4Ogj7mMrqvH149speZN2iRwvSw049rH
         YwBxoXrk8eYL8aA0kZ1ONivL7VidlZgzAci0UmuAk9V3OZL9MGdVNe9DnMmxtUNysgFr
         zYHiQLe6t3yUEgDt+Q0jexmqkNNVQ+/BakaYBI1C0BIobp7wjBg25LMZvWlzhnQmziaF
         LZSUxA/msrF6eab9LROo4yy2KtC2ENUNA9nrXY9J02wGIjniLbWRaaDGj6KbJ4msoj05
         DXBg==
X-Gm-Message-State: AOJu0Yz1DhtrHgZ31SXDZMZtMqwr5xVmmED+Kor9TObj2nwnxnLfVrqu
        bgo6U2kqv/wbPUmNFFyBnKZFX4an+5YQR70ZhB9+Qw==
X-Google-Smtp-Source: AGHT+IFopHnRoAlyF6POHIUhcvwlhiL61OgNYhhH4qY+wuY7Lc/f7rCYUm4UIz9VvEggFLjrRogYHi+m9F2UFzb7uQQ=
X-Received: by 2002:a17:906:2189:b0:9a1:e941:6f49 with SMTP id
 9-20020a170906218900b009a1e9416f49mr6620490eju.44.1695664081274; Mon, 25 Sep
 2023 10:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230921144400.62380-1-dlechner@baylibre.com> <20230921144400.62380-2-dlechner@baylibre.com>
 <20230924175720.3be2540b@jic23-huawei>
In-Reply-To: <20230924175720.3be2540b@jic23-huawei>
From:   David Lechner <dlechner@baylibre.com>
Date:   Mon, 25 Sep 2023 12:47:50 -0500
Message-ID: <CAMknhBF56CWKNZ-xvsiaC3c+av8Dvyh+i-op1YxvXv2g8BPYWg@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] dt-bindings: iio: resolver: add devicetree
 bindings for ad2s1210
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        Apelete Seketeli <aseketeli@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 11:57=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Thu, 21 Sep 2023 09:43:42 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
...
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - spi-cpha
> > +  - clocks
> > +  - sample-gpios
> > +  - assigned-resolution-bits
> > +
> > +oneOf:
> > +  - required:
> > +      - mode-gpios
> > +  - required:
> > +      - adi,fixed-mode
> I think this allows for both.  It's fiddlier to exclude that but would be=
 a nice
> to have perhaps rather than relying on text above that says 'don't do it'=
.
>

example-schema.yaml says that oneOf is XOR (anyOf is OR and would
allow both).
