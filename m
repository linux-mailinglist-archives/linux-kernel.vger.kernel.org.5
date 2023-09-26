Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227327AEF1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjIZOhY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 10:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjIZOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:37:23 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AAB116;
        Tue, 26 Sep 2023 07:37:16 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3ae5e6a536bso224320b6e.1;
        Tue, 26 Sep 2023 07:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695739035; x=1696343835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6PrewSG4swx9L/T4VeN46rKLAc+cC9QOSk8MgUINPk=;
        b=ZsO5UxeQq9SnVhwphb9cFaGLlv/OGduWQIyiE0qM0W0oP1uwhuittV1dBspXUHNHXj
         zViZG7umxmigwv9D/CWKeVg+i70DNYUZtqH3MIKGz8y0WFQ9QJfmNCY+ADY5VrLqWZan
         6oKEEmMtAw9jtSfP+Wc/oTijnbbk/Os5oZ0ERR4pTliup5/1fSC+4L4zbZfIubCW/jMS
         rLWX80ttrJXD6Cc1YwD2nQ83fwzWXW8fmZEQa1xHs2NawPiQkftvAd92GRUWn2bZzpPv
         UtSoDMc4mN/T1pSnstaUJsbgZ6yylSiHITuuZrYOCRqockzkvVffOeXfv/tzZ39oREzW
         pCsA==
X-Gm-Message-State: AOJu0YzRLGDUnEuqlLLl0n9+dKPoBombu+HiXxdS8TaKqdEjZJ1q9YmF
        iFVHFLX/d4we7NdUPjpoLKqBSCiCbV3RBw==
X-Google-Smtp-Source: AGHT+IGZYWcRgYqgr+ldrPHc3mGpBz/NRwp3iwn4/xPW5znsXqaKB8fkHVkyvs0PSr6FvMoYBtkIWQ==
X-Received: by 2002:a05:6358:9989:b0:142:fb84:92e6 with SMTP id j9-20020a056358998900b00142fb8492e6mr13345347rwb.9.1695739035278;
        Tue, 26 Sep 2023 07:37:15 -0700 (PDT)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id i10-20020a633c4a000000b005740aa41237sm9699680pgn.74.2023.09.26.07.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 07:37:15 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-578a91ac815so5812761a12.1;
        Tue, 26 Sep 2023 07:37:14 -0700 (PDT)
X-Received: by 2002:a81:9c03:0:b0:59b:54b5:7d66 with SMTP id
 m3-20020a819c03000000b0059b54b57d66mr9404795ywa.34.1695738558151; Tue, 26 Sep
 2023 07:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-31-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdV2GEKF0QjKudz529_tmUksTNMJtZu9NwC18KX-AXwaeg@mail.gmail.com> <64e91f8d-a94e-c835-75ef-ce9ab557dc54@tuxon.dev>
In-Reply-To: <64e91f8d-a94e-c835-75ef-ce9ab557dc54@tuxon.dev>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Sep 2023 16:29:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_xdNtM3Qv+9iqiyHCALMPx4DzC4-DWbXLCtum-LS_Hw@mail.gmail.com>
Message-ID: <CAMuHMdV_xdNtM3Qv+9iqiyHCALMPx4DzC4-DWbXLCtum-LS_Hw@mail.gmail.com>
Subject: Re: [PATCH 30/37] pinctrl: renesas: rzg2l: add support for RZ/G3S SoC
To:     claudiu beznea <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Tue, Sep 26, 2023 at 12:58 PM claudiu beznea
<claudiu.beznea@tuxon.dev> wrote:
> On 21.09.2023 17:58, Geert Uytterhoeven wrote:
> > On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> Add basic support for RZ/G3S to be able to boot from SD card, have a
> >> running console port and use GPIOs. RZ/G3S has 82 general-purpose IO
> >> ports. Support for the remaining pin functions (e.g. Ethernet, XSPI)
> >> will be added along with controller specific support.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> >> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> >> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> >> @@ -1330,6 +1336,36 @@ static const u32 r9a07g043_gpio_configs[] = {
> >>         RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
> >>  };
> >>
> >> +static const u32 r9a08g045_gpio_configs[] = {
> >> +       RZG2L_GPIO_PORT_PACK(4, 0x20, RZG3S_MPXED_PIN_FUNCS(A)),                        /* P0  */
> >> +       RZG2L_GPIO_PORT_PACK(5, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
> >> +                                                               PIN_CFG_IO_VMC_ETH0)),  /* P1 */
> >
> > P1_0 and P7_0 have IEN functionality.
> > I don't know how to represent that...
>
> I think Prabhakar's series at [1] may help (or make a step forward) in
> supporting this. I have in mind to wait for it and adapt RZ/G3S afterwards.

OK.

> [1]
> https://lore.kernel.org/all/20230630120433.49529-2-prabhakar.mahadev-lad.rj@bp.renesas.com/

> > Is there any specific reason you left out the XSPI, Audio clock, and I3C pins?
>
> I kept only the necessary support for booting and having SDs, GPIO
> functional as a way of proving that all that has been added has been tested
> (similar to clock support). Thus, with e.g. XSPI support I will add at the
> same time clocks and pinctrl.

IC.  I all fairness, you did write in your patch description that support
for e.g. XSPI will be added later, so I'm to blame here.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
