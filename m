Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D8C7A44BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240771AbjIRIac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbjIRIaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:30:23 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A111B0;
        Mon, 18 Sep 2023 01:30:06 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1c26bb27feeso2769462fac.0;
        Mon, 18 Sep 2023 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695025805; x=1695630605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CykTjmm7r3sahhI260p/6w2uA7V4sOftOr/1tge5W8=;
        b=ihHwqw5w9NOJ9y3OP0mQhvyP8nuMxqf7d9wNguj0HlfnzZntmELOGiRneB0IIE73Y/
         olp4c/OsmAFSj1Rtf3+UxCaQi9QkeWMk9BvBm6qUHlc6V4xWJtFIhE+6jqyfuOV4BsR1
         wQPEC7i8lQuhtgMPJC7UgAcW8F+lpDUWx0qVXr3XjUE37uBu77v6v0dbJqz39Bo0x91y
         yr8NxirIjYg6WmsIlT2P9HTiqlZ3cFNAy3Gxhm96giv0JwqM1CU9mZzfzUbyfWe9nzw2
         /hwfFC3B6yeS3il8ZCHYy7pEfBaLnCVHPLJ+mJBQAT/EUk6UhScKL/6XRnGawgmT5JHZ
         LlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695025805; x=1695630605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CykTjmm7r3sahhI260p/6w2uA7V4sOftOr/1tge5W8=;
        b=EtAYlIu7RCVyp7WNcz9dqbq2ECF5KN4Q2xyQQZTcYwCI9e/iVaKr93sS2cwur4kuN5
         IhJjPFZHg9ENVkAocSu02jozgM3/w0gvzGKFIcTSyeRVFi2fc/rhKVARc8gcxdrPY2Dz
         hnrwPDgtQ8HQIK4o6iaO2yIlgqK7hN2sQV2qqADa25FlXb++JxKSup1SIgw+quVZDXdx
         yREvkxUxF2xsuJN6y1T4dG2zXE7ZpFnLWN9HPIU0qrSvaWLDWpFYmcv6X7y/ybvSd25p
         /AxrDejJYTLLjc4hryN3x7JD8vauW1rhh1D56PmVdTnn/9tIy6zbjG2pLixqLEM4oSWK
         kgwg==
X-Gm-Message-State: AOJu0YxjB0L51gwOvJgzt9G8QtTnAtbPC1aX1V28umSv9ywXfpraLmer
        ZZCV55aGsEYFIxkuqkkJHqfcfa8wSdAVVk6y3P8=
X-Google-Smtp-Source: AGHT+IHd3O6UWBhTfjMpeyY7l/jNxI1rxA5vGGYYhuI3QEm+rbwzZV3V7t2xnSEqW2T43g98zxSn8zCrKLmuUgWJnko=
X-Received: by 2002:a05:6870:3906:b0:1d5:f814:567b with SMTP id
 b6-20020a056870390600b001d5f814567bmr9383856oap.5.1695025805604; Mon, 18 Sep
 2023 01:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230917162837.277405-1-arinc.unal@arinc9.com>
In-Reply-To: <20230917162837.277405-1-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 18 Sep 2023 10:29:54 +0200
Message-ID: <CAMhs-H99_O5jt7j6kHhKYfO3yQDXHKqzb=Gi8GDzJDxCs=JYuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: mtmips: add deprecated ralink,rt2880-pinmux
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Sun, Sep 17, 2023 at 6:29=E2=80=AFPM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.un=
al@arinc9.com> wrote:
>
> The "ralink,rt2880-pinmux" compatible string applies to all MediaTek MTMI=
PS
> SoC pin controllers. Add it as a deprecated compatible string.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml | 5 ++++-
>  .../devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml | 5 ++++-
>  .../devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml | 5 ++++-
>  .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml   | 5 ++++-
>  .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml   | 5 ++++-
>  .../devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml   | 5 ++++-
>  .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml   | 5 ++++-
>  .../devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml   | 5 ++++-
>  8 files changed, 32 insertions(+), 8 deletions(-)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
