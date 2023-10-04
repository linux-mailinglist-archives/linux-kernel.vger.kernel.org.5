Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D1B7B8109
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242674AbjJDNeE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 09:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjJDNeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:34:02 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A45DAD;
        Wed,  4 Oct 2023 06:33:59 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59f6492b415so8883227b3.0;
        Wed, 04 Oct 2023 06:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696426438; x=1697031238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWliRVyDflCaQ0ibzTdSksrcW2qMke8NU2ExNZSvp74=;
        b=apPIulPo3JIKY6zwXTei2+3MDuwCse5BpReIfePDK7FDHPryb04kODujXZ924Wn4pB
         KFgVpQRvdHn/TP+IwOtU09PzyPrM5lsvvj447k4mkjciTpBnv37RJF+qys+03NZlJSwF
         ugi84IrEtxtccTmN9eX4SIKeUtqCPTx635q6WXc8FUgk8eyQI5FTiFNdmV9hnBTEPJ6n
         eKHwEYNVeZph/AlbSFqWJ7huIhPKS+YxmVWL9eC9Rb+vnMyzqh7KOPrkh2AP3MsooXJm
         7cmjOQtFT9VPU3on82TfumJft4tf620QNPC+KIGPhNIyxZvMfEJOAa2oVCxtoaBONIcI
         x+pQ==
X-Gm-Message-State: AOJu0Yy0P7v7PH+MZN8Sc4nNJnBvHoe7EYiPP8iOMNPZpD80IpKXoCFV
        M+0m4WEjR9gjN1DxKI4x0JE6jNruPmE6DQ==
X-Google-Smtp-Source: AGHT+IEyNbDtO9wLGuzSBbbR79dXUAD/sxOUgtSNul5Amb2wli+nEGNPHbuuZMTC6sR/aRqi2qUhxg==
X-Received: by 2002:a05:690c:4706:b0:59f:6a25:959e with SMTP id gz6-20020a05690c470600b0059f6a25959emr3957416ywb.10.1696426438562;
        Wed, 04 Oct 2023 06:33:58 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id y126-20020a0def84000000b0054bfc94a10dsm1146182ywe.47.2023.10.04.06.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 06:33:58 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59e88a28b98so8783357b3.1;
        Wed, 04 Oct 2023 06:33:58 -0700 (PDT)
X-Received: by 2002:a0d:df8a:0:b0:59b:ca32:7460 with SMTP id
 i132-20020a0ddf8a000000b0059bca327460mr4104751ywe.3.1696426438040; Wed, 04
 Oct 2023 06:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-28-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-28-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 15:33:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWAhKzdSUtcC-3jZ=wy2Oz2q+Gx0EzUKQzFMBgSMu_UEw@mail.gmail.com>
Message-ID: <CAMuHMdWAhKzdSUtcC-3jZ=wy2Oz2q+Gx0EzUKQzFMBgSMu_UEw@mail.gmail.com>
Subject: Re: [PATCH v2 27/28] arm64: dts: renesas: r9a08g045s33-smarc: add
 initial device tree for RZ/G3S SMARC EVK board
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
> Add initial device tree for RZ/G3S SMARC EVK board.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - modified compatible
> - @Geert: I haven't added you Rb tag as I've added
>   "renesas,rzg3s-smarcm" to the compatible list

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
