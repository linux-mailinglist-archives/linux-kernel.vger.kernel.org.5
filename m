Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374607B80B7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbjJDNWC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjJDNWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:22:01 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03664A1;
        Wed,  4 Oct 2023 06:21:58 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5a505762c9dso579917b3.2;
        Wed, 04 Oct 2023 06:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425717; x=1697030517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVzjW9Eo52+SfKHVjtESmESLgB/bR8EgYwxS/kFJXaU=;
        b=XoFG6HF7r2ykjVvHvQy0z2sSJETwAvMUrOXt0bOSlfepHUBRBVIULvUCm9QdW6Njpm
         vDFRS4bXb3L+7JEvuoSeiEpUdZLqPPkS0zgY+aNKyYQtdbfKnE0xXJOcPuC3Y+iMQHo9
         FSM6CZhce2WzeUIn2PsXtmoIBirybFpkmcPq7UL/6GFdy2oIhi27keOKYZUvC+s+wmzV
         nfnWQlMChK1oFlWX8Uxuxq+60N4acdNpkFeeH1Ao7MwyMSw22SYb+cT+EqTINtUIbeyE
         iSJHV409oYdkrOR6DEcvGrPFdaySu7YY7bL6I83GDsOjupxI8r7aS4iKC8pqofuEgdUj
         Jnsw==
X-Gm-Message-State: AOJu0YzkUD656JC5qcOgY+4RXBCgBJdgSe41/SVJITWv8RZdo7mNUDGo
        J58jmGaUZSwG1oydCtlgk6XO8OrfhipucA==
X-Google-Smtp-Source: AGHT+IHyqcV23pigUpA0knuyVjlhROOr5hdHcHUKFwCYzjIRDBFGw+vzYl6kX/U1EJOjvFmJDs+/EA==
X-Received: by 2002:a0d:fb83:0:b0:586:e50:fb50 with SMTP id l125-20020a0dfb83000000b005860e50fb50mr2561771ywf.28.1696425716915;
        Wed, 04 Oct 2023 06:21:56 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id u76-20020a0deb4f000000b00583e52232f1sm1133550ywe.112.2023.10.04.06.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 06:21:56 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59c268676a9so25310877b3.0;
        Wed, 04 Oct 2023 06:21:56 -0700 (PDT)
X-Received: by 2002:a0d:ee01:0:b0:59b:c6a4:15c7 with SMTP id
 x1-20020a0dee01000000b0059bc6a415c7mr2252067ywe.46.1696425716334; Wed, 04 Oct
 2023 06:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-21-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-21-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 15:21:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVx1rNzp417=11Bi+RQUbuauuh_QASJyWevag-htVeY0Q@mail.gmail.com>
Message-ID: <CAMuHMdVx1rNzp417=11Bi+RQUbuauuh_QASJyWevag-htVeY0Q@mail.gmail.com>
Subject: Re: [PATCH v2 20/28] dt-bindings: pinctrl: renesas: document RZ/G3S SoC
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 7:40 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add documentation for pin controller found on RZ/G3S (R9A08G045) SoC.
> Compared with RZ/G2{L,UL} RZ/G3S has 82 general-purpose IOs, no slew
> rate and output impedance support and more values for drive strength
> which needs to be expressed in microamp.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - defined drive-strength-microamp as general and make if/then schema to
>   not allow specific properties depending on compatible

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
