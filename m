Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D3B79EC8F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbjIMPW3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 11:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjIMPW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:22:27 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDED7CE;
        Wed, 13 Sep 2023 08:22:23 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-770ef353b8fso326351585a.0;
        Wed, 13 Sep 2023 08:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618543; x=1695223343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YO1tPkDOEwQyc/Dv+HaOfcjogh4Es5EpVUGisTZOW4=;
        b=sHTB26XNZ8teze6yZ9Ixw9kqdAyYVWnLlDSTGSBflM3o/T8d/XnR0ltTMjN15mwhMe
         vAch7EnHtODeg9nb4fnZvSlCSxj0nMzfH0NA6iQn2K/AKhZHCUpd1uu4/cBDRMt4/Hx2
         zw4Rp7dEaHm5T8mKrygsErZOCXUBcHeq0m/IHBMUuapBhjadQoptgQYqi3Se4dpyxn1D
         ZkN7TiLaUjfZCH9dJUpSCuT0K33qCgrcPNjE1suEoU2X6PpWnp0VAUfraAy9RcfsQL/h
         5eHFyugAlBv5blCIvJp9geqtNvPX5Usbjh8YdTWKlDqYvTqCfqS6Yc0aP3DE74SNi0u1
         JIpQ==
X-Gm-Message-State: AOJu0YwYWS6hYq5QxE0zM8N8KayeOi75z2kpba2NetgULvXQ8O36SDxe
        QUiFn5RQiBCW5EYYAhW9sPfNcX2Pe5D5KQ==
X-Google-Smtp-Source: AGHT+IEWLMHZWuUElViNkfPsqVJNkVnRs/obn/xLwb7A1rORq0QfqkXdEdSkStvIeU9CQexjOYe1kg==
X-Received: by 2002:a0c:e147:0:b0:64a:131f:b214 with SMTP id c7-20020a0ce147000000b0064a131fb214mr2907571qvl.12.1694618542767;
        Wed, 13 Sep 2023 08:22:22 -0700 (PDT)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id a17-20020a05620a125100b0076f039d87c6sm3966650qkl.82.2023.09.13.08.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 08:22:22 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-76dc77fd01fso436119885a.3;
        Wed, 13 Sep 2023 08:22:22 -0700 (PDT)
X-Received: by 2002:a25:ad08:0:b0:d7f:8e1e:a95f with SMTP id
 y8-20020a25ad08000000b00d7f8e1ea95fmr2686664ybi.6.1694618224901; Wed, 13 Sep
 2023 08:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-36-claudiu.beznea.uj@bp.renesas.com>
 <20230912161635.GA877089-robh@kernel.org> <56cf08f2-5d8e-6098-6218-081d8f620abe@tuxon.dev>
In-Reply-To: <56cf08f2-5d8e-6098-6218-081d8f620abe@tuxon.dev>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Sep 2023 17:16:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWntLTk9ZmAF1voE-tdB+4vVzE804h=qsfaoN-8_6RN_Q@mail.gmail.com>
Message-ID: <CAMuHMdWntLTk9ZmAF1voE-tdB+4vVzE804h=qsfaoN-8_6RN_Q@mail.gmail.com>
Subject: Re: [PATCH 35/37] dt-bindings: arm: renesas: document SMARC
 Carrier-II EVK
To:     claudiu beznea <claudiu.beznea@tuxon.dev>
Cc:     Rob Herring <robh@kernel.org>, mturquette@baylibre.com,
        sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Wed, Sep 13, 2023 at 7:32 AM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
> On 12.09.2023 19:16, Rob Herring wrote:
> > On Tue, Sep 12, 2023 at 07:51:55AM +0300, Claudiu wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> Document Renesas SMARC Carrier-II EVK board which is based on RZ/G3S
> >> (R9A08G045) SoC. The SMARC Carrier-II EVK consists of RZ/G3S SoM module and
> >> SMARC Carrier-II carrier board, the SoM module sits on top of carrier
> >> board.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> >> --- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> >> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> >> @@ -476,6 +476,8 @@ properties:
> >>
> >>        - description: RZ/G3S (R9A08G045)
> >>          items:
> >> +          - enum:
> >> +              - renesas,smarc2-evk # SMARC Carrier-II EVK
> >
> > You just changed the existing binding...
> >
> >>            - enum:
> >>                - renesas,r9a08g045s33 # PCIe support
> >
> > This is the SoM module?
>
> No, this is a SoC variant which supports PCIe.

Ideally, we need a compatible value for the SoM as well, as the SoM
can be used stand-alone, or plugged in a different carrier board.

For iWave Systems RZ/G1E SODIMM, we have that.
For the existing RZ/G2L variants, we forgot, but it can still be added...

>
> > You either need to squash this change or add
> > another case with 3 entries and maintain the 2 entry case. (there's no
> > way to express any entry at the beginning or middle can be optional)
> >
> >>            - const: renesas,r9a08g045

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
