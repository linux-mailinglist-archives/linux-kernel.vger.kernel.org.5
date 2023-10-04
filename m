Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B94B7B8110
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbjJDNe7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 09:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjJDNe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:34:57 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDAEA9;
        Wed,  4 Oct 2023 06:34:54 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59b5484fbe6so25419887b3.1;
        Wed, 04 Oct 2023 06:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696426493; x=1697031293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLCUsporDKIFmsMxBll0mPmZXPU4EoOlZka8Vi8S45s=;
        b=JqZvrWLJtg+ZgV4flPdwjx4z0V5BLr7AHnCzQS725rYlED0S8qTmrs0h/lPoycrNGJ
         hyI9L7ogLL8UJC0AaN2c4loIkuhCe0mCCDi8WzD2zmAKZ8h0KGgBfchq5NFWUVf+1ZXd
         +kEJKNjQB4+LzoMk8a0BHG7GXfXDprCP10YS/z60jJb7xmZC1CC7O3eBIyell2p2QrNt
         LgE3K5WG6t3bpm0eCMMUSiXjNDJhfcLiX7kE1HUk36GEcq5dkMWR/B1H+XNgxd+yvpiF
         BJIpfUwXp4ywXYcs3m/NDKHv+HMLRGMREk/f91RF3a5ZfPtGOAX4oq/PcUsJpJNLconG
         crGw==
X-Gm-Message-State: AOJu0Yy+yL2Q5ULHuMwTjHnqBnw3ogw9Jb+XpFdfLm7Ae5BSahxaOtEo
        FL3KCVh2i6YcI/psY/jJVZfJtxBogkcP0A==
X-Google-Smtp-Source: AGHT+IHfp/PfHchI4K8HSjClRLsre6rlrd11GDlmmSIEVPqOr054sftjUB6yFRW+OGCHLgZFyMnsBw==
X-Received: by 2002:a81:6203:0:b0:59b:bd55:8452 with SMTP id w3-20020a816203000000b0059bbd558452mr2777290ywb.36.1696426493219;
        Wed, 04 Oct 2023 06:34:53 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id c2-20020a0dc102000000b00559f1cb8444sm1142888ywd.70.2023.10.04.06.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 06:34:52 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59b5484fbe6so25419417b3.1;
        Wed, 04 Oct 2023 06:34:52 -0700 (PDT)
X-Received: by 2002:a81:7c86:0:b0:59f:687c:fb36 with SMTP id
 x128-20020a817c86000000b0059f687cfb36mr2554657ywc.45.1696426492360; Wed, 04
 Oct 2023 06:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-29-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-29-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 15:34:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUJkmZG+7gYNav01Y+7pfYKA5fPV3WygV8n_VyEZ-cDfQ@mail.gmail.com>
Message-ID: <CAMuHMdUJkmZG+7gYNav01Y+7pfYKA5fPV3WygV8n_VyEZ-cDfQ@mail.gmail.com>
Subject: Re: [PATCH v2 28/28] arm64: defconfig: enable RZ/G3S (R9A08G045) SoC
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
> Enable config flag for Renesas RZ/G3S (R9A08G045) SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>
> Changes in v2:
> - collected tags

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
