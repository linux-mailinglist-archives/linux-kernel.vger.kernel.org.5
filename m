Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376307B7A8B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbjJDIrb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 04:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjJDIra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:47:30 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F9198;
        Wed,  4 Oct 2023 01:47:27 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d865db5b4c7so1925318276.1;
        Wed, 04 Oct 2023 01:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696409246; x=1697014046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YooWuKVd1rh+nYG5HBqqiBiWwSOKPBjK/oiwvdElrQQ=;
        b=ErxKcxvT1rQIBgUnzFdDWtrJ0f4WJgZjA0dcmbYf6AZBIKUuAINlxFLJl7RBt8F6yO
         tyGZc1c8pKZ+6CMFjm/zZ9Wmwv/HTwmHL5ALnyUtdfaS1c43mc9fEwsC4x1tqgryz7W+
         CPJ/xFD4h3f/mD7UfKj4sohpQHiiZbItG2T8oTB76QjMtVOAFogCtnpCFxziBWBPMbsS
         uGDoEDyntjqicoe64n3kCgI8JWTKaXo7j3Ki+1MZIsRChjLuxGC0m2YqaNQcfLv9Tbtv
         YBpABIHJtGk53lY9PwjmxScoHmtCbHNezG2egxzAVvFYCvMfi+tkkg5ui1tIO26jUFuG
         AVpA==
X-Gm-Message-State: AOJu0YzdpL8SrayoLIe8T0CTpRFR3ctqINSqZQ9BXZR2eEQdvHdms+Dr
        Fyaq1dtce++5Zo1arZ61U6w3HzYexMgRvw==
X-Google-Smtp-Source: AGHT+IFaUl9sjwH3kv88nWiZ3YM2n1Kmqz42U1G1ewwhPQXsH4sFtojPrh8nbMnQm6AL10k4ddF4BQ==
X-Received: by 2002:a25:b34d:0:b0:d7e:b88b:1de8 with SMTP id k13-20020a25b34d000000b00d7eb88b1de8mr1327228ybg.9.1696409246709;
        Wed, 04 Oct 2023 01:47:26 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id w7-20020a05690202c700b00d7ba4c5e31fsm906073ybh.39.2023.10.04.01.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 01:47:26 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a2536adaf3so22614267b3.2;
        Wed, 04 Oct 2023 01:47:26 -0700 (PDT)
X-Received: by 2002:a81:4ec9:0:b0:59f:7110:936a with SMTP id
 c192-20020a814ec9000000b0059f7110936amr1849241ywb.1.1696409246245; Wed, 04
 Oct 2023 01:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-9-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-9-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 10:47:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWY_28uT39XhgwPtm=dKmxAmohRPjUGD1r_ZP3ev8c_pw@mail.gmail.com>
Message-ID: <CAMuHMdWY_28uT39XhgwPtm=dKmxAmohRPjUGD1r_ZP3ev8c_pw@mail.gmail.com>
Subject: Re: [PATCH v2 08/28] clk: renesas: rzg2l: add struct clk_hw_data
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

On Fri, Sep 29, 2023 at 7:39 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add clk_hw_data struct that keeps the core part of a clock data. The
> sd_hw_data embeds a member of type struct clk_hw_data along with other
> members (in the next commits). This commit prepares the field for
> refactoring the SD MUX clock driver.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>
> Changes in v2:
> - collected tags

Thanks, will queue in renesas-clk-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
