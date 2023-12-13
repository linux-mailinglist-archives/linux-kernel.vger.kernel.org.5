Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B40811476
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441872AbjLMOSh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 09:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441859AbjLMOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:18:34 -0500
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80233DD;
        Wed, 13 Dec 2023 06:18:41 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5e32af77f15so1754017b3.2;
        Wed, 13 Dec 2023 06:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702477120; x=1703081920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQIUc37L857Xy2IutTbpm0mG6sIjdIjLVU0WeFZORnk=;
        b=Gs2o2bo+cyarBUBLPPCKojhwJGamx4PHbYNeS+Z/dCtcxf5GiZoTkXEI7egmfAx31e
         bIjuegghly5LB5AYhae+/Xkqdwacv2oqmWJ2uMIuArtJQWuQpOkKLJQ14YrZ8p7Krhjt
         tl9TW/0tS1mkGwgZY7VUoV0DMr0UJ4NPBQDpZV7nbgacc9AWE/LTubaT2SxeAE5Ljbvj
         0X78P++1rFacZfiyO+cLw1qV2CpNIuJGejt4+AaeAZEzngUqnY/w9Pi46ZpzsAJEnFg6
         GWEM+tA++j0nnWLkN4spvehdOj2kHX4HhaiZAZAT4mgaDH+9cHwY1GK78dBADaellkuu
         /PKg==
X-Gm-Message-State: AOJu0YxtoDaKVAx5uZQelqNx/x+GezNJcAWJSXfudCcN1DjD03QEQivo
        0x1lGqgH+iMWsII7NoSoHuyd3Mc1PpH5iw==
X-Google-Smtp-Source: AGHT+IFoQSG35p2VxhzCnsVF4RrrrIm2UQYlRVknpgd9Z0yTw+yA18LRMMRv01W7mHC77nGGemnnBQ==
X-Received: by 2002:a0d:f3c5:0:b0:5d8:165c:17a5 with SMTP id c188-20020a0df3c5000000b005d8165c17a5mr6258032ywf.91.1702477120573;
        Wed, 13 Dec 2023 06:18:40 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id t21-20020a0dea15000000b005e295c30e4asm730248ywe.80.2023.12.13.06.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 06:18:39 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e32af77f15so1753517b3.2;
        Wed, 13 Dec 2023 06:18:39 -0800 (PST)
X-Received: by 2002:a0d:c704:0:b0:5d7:1940:53c4 with SMTP id
 j4-20020a0dc704000000b005d7194053c4mr6755236ywd.60.1702477118892; Wed, 13 Dec
 2023 06:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com> <20231120111820.87398-10-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231120111820.87398-10-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Dec 2023 15:18:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX04XKYcoXQ60DsKt-1LuEKm_kSiuYDLjiqfM2Ej0OAXQ@mail.gmail.com>
Message-ID: <CAMuHMdX04XKYcoXQ60DsKt-1LuEKm_kSiuYDLjiqfM2Ej0OAXQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] arm64: dts: renesas: r9108g045: Add IA55 interrupt
 controller node
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 7:16 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add IA55 interrupt controller node and set it as interrupt parent for pin
> controller.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
