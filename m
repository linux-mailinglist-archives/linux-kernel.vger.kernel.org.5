Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2317EFF3D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 12:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjKRLZ6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 18 Nov 2023 06:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKRLZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 06:25:55 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07539D71;
        Sat, 18 Nov 2023 03:25:52 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-db048181cd3so2779125276.3;
        Sat, 18 Nov 2023 03:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700306751; x=1700911551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiuDqUTCUS6Y1KK2h70TEMMBLCqAZgtzwDLAEo8GjcA=;
        b=S4CIUpAeVYNDCmi5ABFuKT5Ni/nnWByDwAqcRusGdtEjF4Q5jr6pwzo5TEuq+PKlp5
         O9AyX3mioaX/8X63DW17EbTgvD+VkMr5PY4ZY9karyKbT2Bs4+OYRS0eb+gs3QLgBOlp
         P58d9c/dH5r/RPVunuOydX/eRRb+i6+h8EtfzXTF+wmVMJUcv+0L6CZErz3HXxbHgT04
         aAdyKwXy5KN1g+vz2xNIk/yUSJmD1msznvCu4IXROPsH8OV6jXwo3Dsk0d2DHKdLyp24
         zO8B9EsNdl0qqSq2+4L0mCE8tr21moSswfGTqIkYTEa1eDXGJ9nPcTTU7PuPc90XSBLZ
         +F5Q==
X-Gm-Message-State: AOJu0YxJNytnhjlzpnP+t4CnTpAx2FvKS8n3IA0I7fDnHBircTrnY+Vk
        7WccVv5RuNyMzjoD6U98wdvHuwqpbyhfFQ==
X-Google-Smtp-Source: AGHT+IEoRkEeP0n+mDokBkb0DbQr3cNR1tl9n65dTQYg/PvmzOZ9YCLBelUGDPHdL6r0DZDxMz8pNQ==
X-Received: by 2002:a5b:46:0:b0:daf:76da:fe2b with SMTP id e6-20020a5b0046000000b00daf76dafe2bmr1966062ybp.10.1700306750972;
        Sat, 18 Nov 2023 03:25:50 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id x36-20020a25aca4000000b00d81bb7ef494sm907531ybi.19.2023.11.18.03.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Nov 2023 03:25:49 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a82f176860so31137327b3.1;
        Sat, 18 Nov 2023 03:25:48 -0800 (PST)
X-Received: by 2002:a81:d512:0:b0:5a7:d461:a2b7 with SMTP id
 i18-20020a81d512000000b005a7d461a2b7mr2347982ywj.43.1700306748519; Sat, 18
 Nov 2023 03:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20231116181218.18886-1-krzysztof.kozlowski@linaro.org>
 <7592981.EvYhyI6sBW@phil> <2cb3f992-f214-4cdf-8443-9e14ab864a66@ti.com> <4289147.1BCLMh4Saa@diego>
In-Reply-To: <4289147.1BCLMh4Saa@diego>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 18 Nov 2023 12:25:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWgzasx-8X6TJJE1f5Y8wi+5Tv7pTEFvJVPGGaY2pEfeQ@mail.gmail.com>
Message-ID: <CAMuHMdWgzasx-8X6TJJE1f5Y8wi+5Tv7pTEFvJVPGGaY2pEfeQ@mail.gmail.com>
Subject: Re: [PATCH] docs: dt-bindings: add DTS Coding Style document
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Davis <afd@ti.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Fri, Nov 17, 2023 at 8:38 PM Heiko Stübner <heiko@sntech.de> wrote:
> Am Freitag, 17. November 2023, 15:03:38 CET schrieb Andrew Davis:
> > On 11/16/23 2:33 PM, Heiko Stuebner wrote:
> > > Am Donnerstag, 16. November 2023, 21:23:20 CET schrieb Krzysztof Kozlowski:
> > >> On 16/11/2023 21:03, Heiko Stuebner wrote:
> > > going with the vcc5v0_host regulator of the rk3588-quartzpro64 and
> > >
> > > +1. compatible
> > > +2. reg
> > > +3. ranges
> > > +4. All properties with values
> > > +5. Boolean properties
> > > +6. status (if applicable)
> > > +7. Child nodes
> > >
> > > we'd end up with
> > >
> > >          vcc5v0_host: vcc5v0-host-regulator {
> > > /* 1. */        compatible = "regulator-fixed";
> > > /* 4. */        gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> > >                  pinctrl-names = "default";
> > >                  pinctrl-0 = <&vcc5v0_host_en>;
> > >                  regulator-min-microvolt = <5000000>;
> > >                  regulator-max-microvolt = <5000000>;
> > >                  regulator-name = "vcc5v0_host";
> > >                  vin-supply = <&vcc5v0_usb>;
> > > /* 5. */        enable-active-high;
> > >                  regulator-always-on;
> > >                  regulator-boot-on;
> > >          };
> > >
> >
> > How about grouping like properties (defined in the same schema),
> > then sorting within that group. Would also allow for defining
> > where to add spacing.
> >
> > 1. compatible
> > 2. reg
> > 3. ranges
> > 4. All property groups
> >    4.1 Properties with values
> >    4.2 Boolean properties
> >    4.3 Separating space
> > 6. status (if applicable)
> > 7. Child nodes
> >
> > Your node then would look like we expect:
> >
> > vcc5v0_host: vcc5v0-host-regulator {
> > /* 1   */   compatible = "regulator-fixed";
> >
> > /* 4.1 */   pinctrl-names = "default";
> > /* 4.1 */   pinctrl-0 = <&vcc5v0_host_en>;
> > /* 4.3 */
> > /* 4.1 */   regulator-min-microvolt = <5000000>;
> > /* 4.1 */   regulator-max-microvolt = <5000000>;
> > /* 4.1 */   regulator-name = "vcc5v0_host";
> > /* 4.2 */   regulator-always-on;
> > /* 4.2 */   regulator-boot-on;
> > /* 4.2 */   enable-active-high;
> > /* 4.3 */
> > /* 4.1 */   gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> > ...
> > };
>
> I'm really not sure about adding big sets of rules.
> In the above example you'd also need to define which schema has a higher
> priority? ;-)
>
>
> When I started with Rockchip stuff, I also had some fancy way of sorting
> elements in mind that was really intuitive to myself :-) .
> Over time I realized that it was quite complex - especially when I had to
> explain it to people.

Feel familiar.

> There are definite advantages for having compatible + reg + status in
> fixed positions, as it helps going over a whole dt to spot the huge
> mistakes (accidentially disabled, wrong address), but for the rest a
> simple alphabetical sorting is easiest to explain to people :-) .
>
> And alphabetic elements are also easier on my eyes.

Alphabetical does break logical ordering and grouping.

Apart from compatible/reg order, on Renesas SoCs we usually
also have the clocks/resets/power-domains block.

> I just think having a short clean set of rules like Krzysztof proposed,
> is easier to follow and "enforce" and also most likely doesn't deter
> people from contributing, if mainline work is not their main occupation.

And in reality, most of this is created by copy-and-corrupt^Wmodify...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
