Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C08F7B80A4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242577AbjJDNSW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 09:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjJDNSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:18:20 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F369E;
        Wed,  4 Oct 2023 06:18:17 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59c268676a9so25262317b3.0;
        Wed, 04 Oct 2023 06:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425496; x=1697030296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wMp+Vg307cSobQ6lm2WKyfxk9n+yqBtBGToupSFTGM=;
        b=misch/BJVoWoaIq2vp15aDmvzrFy0U7a5fO8B/2Wl0/a/GxKCAQFyxcOQVfsfBB3tW
         pWNTab4AH9kvqKqir+8OoAgxI3GKE5V32f81itWfNs2Ju6/91L6NKwHTF0sDsjyYYcSe
         ywN41ADhMthIm13PmqexFHNCfdXeKDVHSJDuNYYVenIvNdkptIu8kFDcO5Qsju+jsLOo
         oUtjeD7xtB/20F98l3pAKkPvzCKnLZgqJPL/XERAp2YO3qqjnT4mFAaMPVeQWfyS4c26
         SIDushCEhA5F61jsJV8gCW5Rszw02fmOprGehWFy9klC6rMckK+Ic2dIifB97WNH/OPp
         Ms5A==
X-Gm-Message-State: AOJu0YxTRNHjcNaVvpMfNaKwRlVw2IfLqn9sQ1RnbIopCXVpqHpNNo3F
        BWIK/2gaIH+braaXjUsRZgGMZckZUJEOvA==
X-Google-Smtp-Source: AGHT+IFjpDJ/TWx4mYP1vTavRlFj+pulva715y9H09RW7jK91X92kkZz4JebvV1USCCHTPWyZrqxgA==
X-Received: by 2002:a81:5c57:0:b0:561:a123:1041 with SMTP id q84-20020a815c57000000b00561a1231041mr2480757ywb.29.1696425496426;
        Wed, 04 Oct 2023 06:18:16 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id n16-20020a819e50000000b005837633d9cbsm1114124ywj.64.2023.10.04.06.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 06:18:16 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5a229ac185aso25149567b3.1;
        Wed, 04 Oct 2023 06:18:15 -0700 (PDT)
X-Received: by 2002:a81:4811:0:b0:5a1:eec1:b42e with SMTP id
 v17-20020a814811000000b005a1eec1b42emr2615702ywa.0.1696425495727; Wed, 04 Oct
 2023 06:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-18-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-18-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 15:18:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX+3PinKKrWbtnaGGJZcARSyMewQR6QvYVGnM7NT0ObXQ@mail.gmail.com>
Message-ID: <CAMuHMdX+3PinKKrWbtnaGGJZcARSyMewQR6QvYVGnM7NT0ObXQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/28] pinctrl: renesas: rzg2l: move ds and oi to SoC
 specific configuration
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
> Move drive strength and output impedance values to SoC specific
> configuration data structure (struct rzg2l_hwcfg). This allows extending
> the drive strength support for RZ/G3S. Along with this the DS values
> were converted to uA for simple integration with RZ/G3S support.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>
> Changes in v2:
> - s/indexes/indices in code documentation
> - s/micro amps/uA in code documentation
> - added RZG2L_IOLH_MAX_DS_ENTRIES for "+ 4" statements in code
> - changed struct rzg2l_hwcfg::iolh_groupb_oi[] size to 4 to avoid
>   oversize it in next commits when RZG2L_IOLH_IDX_MAX will be increased
>   and thus avoiding issues when executing
>   "if (index == ARRAY_SIZE(hwcfg->iolh_groupb_oi))" in
>   rzg2l_pinctrl_pinconf_set()
> - collected tags

Thanks, will queue in renesas-pinctrl-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
