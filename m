Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488247581FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjGRQWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjGRQWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:22:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A5DD3;
        Tue, 18 Jul 2023 09:22:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FD3061662;
        Tue, 18 Jul 2023 16:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92705C433CA;
        Tue, 18 Jul 2023 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689697335;
        bh=31xUigO9ECZ3RMET0Pjh5i8vKuREiDY4drbEUKMYxDk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XZVRu8UX1RrZDyQVnWywfu6B+XYnJjvsSslXOn4AgAJR5jsq1fEXj8SvM3lYECS4/
         oiH/GoqqNaLPSfeVA9zCUVDrup5wEIkI8t+tjqEDc2c3uAv6yB3/a49mzVKDyLWtZn
         7vk5fjHOzZNdGMp3w/vPTkkIYuK32OfewI/LYOLGyXWU23EMitafDT770MFBVu2Yib
         yrnedekMZ0at9fK4pAiUwmLH9ZMiZmg/l/9UFskrpNhm6oOG6f9UHGLQxVY8g15toz
         NhlMZoIdxdFsFKOSzIzXXoGIhIInOROBYydCKmwy06YfO3+470il9A9M0+0KAhFQ3i
         wGR+hLvMRcLHw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so88411841fa.1;
        Tue, 18 Jul 2023 09:22:15 -0700 (PDT)
X-Gm-Message-State: ABy/qLZyWkIdbXYzOqd2ouxDwS1zVwg+12Q2GPQ8SdKUef8id0q78oGD
        Q3vx9anDmh6FDPTLWgzSWfL8+POBVclEEylZKA==
X-Google-Smtp-Source: APBJJlG3TjU8GfpyxOrWcvtGMmD9IHeNkvxiWw1/i69kyzWYiRp+k1Km+ySEjxZjjY/q/P1dajxvVnOG/lCNPtHqTpA=
X-Received: by 2002:a2e:9f46:0:b0:2b6:9f95:46d9 with SMTP id
 v6-20020a2e9f46000000b002b69f9546d9mr10709249ljk.46.1689697333616; Tue, 18
 Jul 2023 09:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230626221010.3946263-1-robh@kernel.org>
In-Reply-To: <20230626221010.3946263-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Jul 2023 10:22:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLW6ue0TrQ=xd_7ySeMvRdjbq0YaSf-3PPowYYuwRQiFA@mail.gmail.com>
Message-ID: <CAL_JsqLW6ue0TrQ=xd_7ySeMvRdjbq0YaSf-3PPowYYuwRQiFA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: at91-vinco: Fix "status" values
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 4:10=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> The defined value for "status" is "disabled", not "disable".
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/boot/dts/microchip/at91-vinco.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Ping!

>
> diff --git a/arch/arm/boot/dts/microchip/at91-vinco.dts b/arch/arm/boot/d=
ts/microchip/at91-vinco.dts
> index ebeaa6ab500e..ecbdacf48708 100644
> --- a/arch/arm/boot/dts/microchip/at91-vinco.dts
> +++ b/arch/arm/boot/dts/microchip/at91-vinco.dts
> @@ -159,7 +159,7 @@ usb0: gadget@400000 {
>                         atmel,vbus-gpio =3D <&pioE 31 GPIO_ACTIVE_HIGH>;
>                         pinctrl-names =3D "default";
>                         pinctrl-0 =3D <&pinctrl_usba_vbus>;
> -                       status =3D "disable";
> +                       status =3D "disabled";
>                 };
>
>                 usb1: ohci@500000 {
> @@ -168,7 +168,7 @@ usb1: ohci@500000 {
>                                            &pioE 11 GPIO_ACTIVE_LOW
>                                            &pioE 12 GPIO_ACTIVE_LOW
>                                           >;
> -                       status =3D "disable";
> +                       status =3D "disabled";
>                 };
>
>                 usb2: ehci@600000 {
> --
> 2.40.1
>
