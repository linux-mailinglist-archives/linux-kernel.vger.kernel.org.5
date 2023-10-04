Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102697B80D7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjJDN3L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 09:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjJDN3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:29:09 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6E3AB;
        Wed,  4 Oct 2023 06:29:06 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59f1dff5298so25755897b3.3;
        Wed, 04 Oct 2023 06:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696426145; x=1697030945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZMJEZgZ8N6kINqOqwjxliT5IxiFwXh5O6Z8mInKae4=;
        b=k8rBZGSyYWl0muGnZRVChSXpCSlUCR/JYy7ntjmAFF8x7Dgb0oFgdlxdhqkP8gSAHc
         w8aeZhJyicdHPwLlPGabnv6OxwgeTj6VM060ahMA3/RZdFV6ctIosKfla0xZF0kFk2SO
         WGB2Jb/zv8+Ve75ad2fAvViZoFwNyc9sngvcvv3Yn1wS5Ngpfx+dqYyI9n3Nr5Wtgjeg
         sTCCdbGmeyIXsiAT09v65+yexGPyC45gbCtFOfuz1e4Gn8BqJU/EMd4p9v8DmceaYHog
         SNXsL/x0EF8nyA29oYhtV/q1QfCbnYTfNqeSf/fCqoOaNZAvffQ23s/1Y1Mdrva/t4sC
         pTLw==
X-Gm-Message-State: AOJu0Yz1Ar6YgYkiJMWD70zpejh/U2HcuvL9TGw0XBjhkgyqyp9qlM7o
        4b4S/97SFLseK4fcCWKrYuegd8odkv10yw==
X-Google-Smtp-Source: AGHT+IHqygMcoeN2akb66oKlkNRI1xJQU0bmW1lAK1arcT7G+K2LlWzTf6/zmF9tqFhiBmbgzNZdxA==
X-Received: by 2002:a81:a187:0:b0:59b:f152:8998 with SMTP id y129-20020a81a187000000b0059bf1528998mr2554015ywg.19.1696426145035;
        Wed, 04 Oct 2023 06:29:05 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id n23-20020a0dcb17000000b0058427045833sm1153408ywd.133.2023.10.04.06.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 06:29:03 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5a2536adaf3so25858907b3.2;
        Wed, 04 Oct 2023 06:29:03 -0700 (PDT)
X-Received: by 2002:a05:690c:b1c:b0:5a5:5ab:5ea0 with SMTP id
 cj28-20020a05690c0b1c00b005a505ab5ea0mr106956ywb.22.1696426143452; Wed, 04
 Oct 2023 06:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-24-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-24-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 15:28:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXXsARjdkOOB8Pf6G63P-08cEUqoTQa6zbd2YAMJN6ucg@mail.gmail.com>
Message-ID: <CAMuHMdXXsARjdkOOB8Pf6G63P-08cEUqoTQa6zbd2YAMJN6ucg@mail.gmail.com>
Subject: Re: [PATCH v2 23/28] dt-bindings: arm: renesas: document RZ/G3S SMARC SoM
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
> Document Renesas RZ/G3S SMARC SoM board which is based on RZ/G3S
> (R9A08G045S33) SoC.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - this patch is new in v2 and added as suggested by Geert

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
