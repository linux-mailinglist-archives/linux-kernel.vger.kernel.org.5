Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CDA7BDA50
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346327AbjJILxi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 07:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjJILxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:53:37 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4831BAC;
        Mon,  9 Oct 2023 04:53:36 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-579de633419so54428567b3.3;
        Mon, 09 Oct 2023 04:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696852415; x=1697457215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybye+C8MBcGUmV871n4R2YjpePe8r44+vRs5z5Nx4zI=;
        b=OLFYtRGY+AMU98QuZGQ6OK/XyMgb6Q6JgN1oGyPoaVjwE5agRBHJ11TpfPl/D3p77E
         kD9nQKSIh6YhK1dvHaHO8TqWKi/2gAcJZ8St2/gwZqvMxZZo93Y6CPKure6yVGBOIJzI
         xIYeyjLM2haflPge70D0FaysN5INkTiHjrCK5u9zUmR9F7g6+rplVIgJ7ZpkXEVflD07
         sIDWjKIARrBjWSHAvWdoolr+IcZrsNI3qqwVTqogMz09eGxQwjhbCCE9PeIJ9+p/c1QT
         pKyF115c9x+MdJ6fz9GJUBJW/BExMY63WMZf+zNJa+DILx4zFlME2Hw2py1LijVLBmuP
         XajQ==
X-Gm-Message-State: AOJu0YwNuMFdWt8V6xAbOc1syjEfWZYfBQX6kwQUtbKp4MlmeZMzobg7
        wjfBg3iif7vii3dCvkRX19kGvGnzQ19z3g==
X-Google-Smtp-Source: AGHT+IHEk4UbDiByxR21O7SPoeWjtHDXgNHxoLPN8LktwTqJ8Du4hUmJii56fKdYl6+oWTyc4RAyqA==
X-Received: by 2002:a81:bb48:0:b0:59e:8f6d:92e with SMTP id a8-20020a81bb48000000b0059e8f6d092emr13788329ywl.49.1696852415229;
        Mon, 09 Oct 2023 04:53:35 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id w16-20020a81a210000000b005a0f9718a5fsm3610662ywg.78.2023.10.09.04.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 04:53:34 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-579de633419so54428397b3.3;
        Mon, 09 Oct 2023 04:53:34 -0700 (PDT)
X-Received: by 2002:a0d:f783:0:b0:58c:b8b4:2785 with SMTP id
 h125-20020a0df783000000b0058cb8b42785mr13288672ywf.45.1696852414682; Mon, 09
 Oct 2023 04:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231006103959.197485-1-claudiu.beznea.uj@bp.renesas.com> <20231006103959.197485-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231006103959.197485-3-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Oct 2023 13:53:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUNHRPzPBJPE0khaVuoLdEVPaum9JSSKRmdp4s7hBVV5g@mail.gmail.com>
Message-ID: <CAMuHMdUNHRPzPBJPE0khaVuoLdEVPaum9JSSKRmdp4s7hBVV5g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] clk: renesas: rzg2l: refactor sd mux driver
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

On Fri, Oct 6, 2023 at 12:40 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Refactor SD MUX driver to be able to reuse the same code on RZ/G3S.
> RZ/G2{L, UL} has a limitation with regards to switching the clock source
> for SD MUX (MUX clock source has to be switched to 266MHz before switching
> b/w 533MHz and 400MHz). This limitation has been introduced as a clock
> notifier that is registered on platform based initialization data thus the
> SD MUX code could be reused on RZ/G3S.
>
> As both RZ/G2{L, UL} and RZ/G3S has specific bits in specific registers
> to check if the clock switching has been done, this configuration (register
> offset, register bits and bits width) is now passed though
> struct cpg_core_clk::sconf (status configuration) from platform specific
> initialization code.
>
> Along with struct cpg_core_clk::sconf the mux table indices are also
> passed from platform specific initialization code.
>
> Also, mux flags are now passed to DEF_SD_MUX() as they will be later
> used by RZ/G3S.
>
> CPG_WEN_BIT macro has been introduced to select propertly the WEN bit
> of various registers.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v3:
> - return proper value from notifier
> - kept old names for members of rzg2l_cpg_sd_clk_mux_ops object
> - s/rzg2l_cpg_sd_mux_clk_notifier/rzg2l_cpg_sd_clk_mux_notifier/g
> - introduced CPG_WEN_BIT macro to set WEN bits of various registers
>   with this functionality
> - removed bitmask variable from rzg2l_cpg_sd_clk_mux_notifier() and
>   rzg2l_cpg_sd_clk_mux_set_parent() as it is no longer needed
> - tested on RZ/G2L and RZ/G3S

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.7.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
