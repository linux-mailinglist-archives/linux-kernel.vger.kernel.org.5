Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C44F782D63
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbjHUPhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbjHUPhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:37:02 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF74E2;
        Mon, 21 Aug 2023 08:37:01 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-48d0db157efso481707e0c.1;
        Mon, 21 Aug 2023 08:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692632220; x=1693237020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xyVHx1jRHtcJdeUzOo6rApb73WW21TZmOmliSqn3Mo=;
        b=C9IYT3+OtUW9hwweWvu3GiC1mPSXAKKkf5CvbN45O6kJgQa/GIZAh1Mk0IKAjv6rlP
         kTKx7DrtRTGVuSPdoYltArXgJvfuGB5j/YyTWQ18onlBGeXTLUvs75NdULQCf99A2zns
         UyWqmIhKFpyX/5Jo8I6jj4dB38OZH2FEyDiN0lm2ACX7ytHpCtzQLz8uvYwUnRJ8EVUQ
         2lcjjRwoRkWZSUD9C7tpLam32Kyq66bkPHKqqLmMJyc6Cx1y5btKLIu4ima4+PtJXSJu
         TCbNhWcrBYxnb/aYEQmJLWhJT2lmTBrqwgjLZTuDDd7EmQdB66WWEyOk7wH/71+ey2yQ
         ZzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692632220; x=1693237020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xyVHx1jRHtcJdeUzOo6rApb73WW21TZmOmliSqn3Mo=;
        b=LQ9zT4tSREzV4DYUhlfxN9MJfvUnvBapkjpVeQoexCMv1/+tJaq4eZKndWa7DL3/iP
         /+gjuyn+FFzQbdM/1FI+78MsKsouoorsSWcDYmfOJR970kQigXm9NJ+jLdu5ahS+GUlj
         cfsUe2ASoNQ6G2NJgQ8o4kAakRLEKdbYTgwRE+TeVFbFm5VsAfIGv/0U9nkogXoJjlsp
         ZI9CVDn5d1BvuKrb8d90OTRdyF6EY+2vQdMd2gaM+VSzVpEALxhjRyURIH5WlwrR2/bw
         CRFlr+xAFFQ7mRCsq8X6hsSBv7V18k4NTBnoURvuf3IOAvZS+SEvR1u4oPoNHZMAy/Ny
         5U5g==
X-Gm-Message-State: AOJu0YwRJ/zsgPBX0Ej7+WtU2xr2uA4fWU4Oh10U4cMmp1LqMhMpUzqc
        GTWAODz/bpUZMBKnqe0BToQei8u/AoKgjQ1grdEPKhfMciM=
X-Google-Smtp-Source: AGHT+IF5/v+rHolsxAAStdBDux4Y1lDOsbPIWa+OZFr/WjW9nAhGLgjS7+TCkBPZcczXIon7gB3pqgs7vJbUFJmqIsk=
X-Received: by 2002:a1f:ed84:0:b0:48d:1fcd:9723 with SMTP id
 l126-20020a1fed84000000b0048d1fcd9723mr2586888vkh.1.1692632220125; Mon, 21
 Aug 2023 08:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230818151039.40566-1-twoerner@gmail.com> <20230818151039.40566-2-twoerner@gmail.com>
In-Reply-To: <20230818151039.40566-2-twoerner@gmail.com>
From:   Robert Nelson <robertcnelson@gmail.com>
Date:   Mon, 21 Aug 2023 10:36:34 -0500
Message-ID: <CAOCHtYgdxeoOvTcFjwB=iqLD5K4JzeoRF8zeQPzM_1nLh5ReYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: am335x-pocketbeagle: update LED information
To:     Trevor Woerner <twoerner@gmail.com>
Cc:     drew@beagleboard.org,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
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

On Sun, Aug 20, 2023 at 5:24=E2=80=AFAM Trevor Woerner <twoerner@gmail.com>=
 wrote:
>
> The "label" property is deprecated. Replace the "label" property with
> "color" and "description" properties.
>
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts b/arch/arm=
/boot/dts/ti/omap/am335x-pocketbeagle.dts
> index 5dfe4d4bab93..1c11245f6864 100644
> --- a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
> +++ b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
> @@ -8,6 +8,7 @@
>
>  #include "am33xx.dtsi"
>  #include "am335x-osd335x-common.dtsi"
> +#include <dt-bindings/leds/common.h>
>
>  / {
>         model =3D "TI AM335x PocketBeagle";
> @@ -24,28 +25,32 @@ leds {
>                 compatible =3D "gpio-leds";
>
>                 led-usr0 {
> -                       label =3D "beaglebone:green:usr0";
> +                       color =3D <LED_COLOR_ID_BLUE>;
> +                       function =3D LED_FUNCTION_HEARTBEAT;

So some background, while the LED are not Green, and this is not the Beagle=
Bone.

We used these specific labels to keep all user documents going back to
the original BeagleBone (white) (with 3.8.x kernel), the same so users
could easily blink an led from user-space even on newer boards.

So it became our un-official abi for new users for the BeagleBoard
family of devices..

It's even what we do on the BeaglePlay..

https://git.beagleboard.org/beagleboard/BeagleBoard-DeviceTrees/-/blob/v5.1=
0.x-ti-unified/src/arm64/k3-am625-beagleplay.dts#L179-217

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
