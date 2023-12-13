Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374C481144B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441837AbjLMOKF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 09:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379237AbjLMOKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:10:03 -0500
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73929C;
        Wed, 13 Dec 2023 06:10:09 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5d8a772157fso61503027b3.3;
        Wed, 13 Dec 2023 06:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476608; x=1703081408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lctB7HRIwcjgOPSYwLKN7AvXZwasrHyg/ppK58pb6FQ=;
        b=rgAthnrB6ry20TwHvow877fohFwKW75PmFBDsAnV4g4DeSxKtDtQPv9wFQpPJ0EmN6
         fRDwiQfysGWH4AnyNbnTlN3QDAnH3uAc32SaLwKd5kmyLuyzMXiKVX/OtSpk5I9ovLk5
         aKHkY6sOKm3kCLyS8j1qOlZ7j2av4idIAlueo/P3VXElM1uqRCNnYkoSO+r4uBBwH3LE
         WOw8/F6OLKwYbpkrsYZ9iPXFzF6ndMiFT4inhwQheLhmgutm1jDlBDOVDhKFe5BnPJnW
         brVTcsDGX0qX2v3hIgZpAasy6lbRY5POZdlyr/hVRAWSoz/5ZL+1kUlQv5ZwAFJIaQh2
         XBzA==
X-Gm-Message-State: AOJu0YyS6dugah+M+RaGUBwTHXeZ+kgYN7dLrc+59iST9cfrrCGeCdLy
        3H3TvzppGSLvdIUIUdkMeEcIC9xe6buQKg==
X-Google-Smtp-Source: AGHT+IEod+B+NCcMD5ZPfsOWfS7gVSwpF/VNt02LFpFTCsItur++77J5mCfNM43w39sxyHR7vcHILg==
X-Received: by 2002:a25:ab23:0:b0:dbc:d22a:9135 with SMTP id u32-20020a25ab23000000b00dbcd22a9135mr446757ybi.105.1702476608583;
        Wed, 13 Dec 2023 06:10:08 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id u4-20020a258f84000000b00dafa5f86dc2sm3967368ybl.16.2023.12.13.06.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 06:10:07 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5d8a772157fso61502697b3.3;
        Wed, 13 Dec 2023 06:10:07 -0800 (PST)
X-Received: by 2002:a81:6582:0:b0:5d3:f36c:4aa3 with SMTP id
 z124-20020a816582000000b005d3f36c4aa3mr6180811ywb.15.1702476607543; Wed, 13
 Dec 2023 06:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com> <20231207070700.4156557-12-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231207070700.4156557-12-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Dec 2023 15:09:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW5PdFc6AE-G6u3hiRn8g45AYfyqytBvzWPB_Maj2x45Q@mail.gmail.com>
Message-ID: <CAMuHMdW5PdFc6AE-G6u3hiRn8g45AYfyqytBvzWPB_Maj2x45Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] arm64: dts: renesas: rzg3s-smarc-som: Enable the
 Ethernet interfaces
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
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

On Thu, Dec 7, 2023 at 8:08 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The RZ/G3S Smarc Module has Ethernet PHYs (KSZ9131) connected to each
> Ethernet IP. For this, add proper DT bindings to enable the Ethernet
> communication through these PHYs.
>
> The interface b/w PHYs and MACs is RGMII. The skew settings were set to
> zero as based on phy-mode (rgmii-id) the KSZ9131 driver enables internal
> DLL, which adds a 2ns delay b/w clocks (TX/RX) and data signals.
>
> Different pin settings were applied to TXC and TX_CTL compared with the
> rest of the RGMII pins to comply with requirements for these pins imposed
> by HW manual of RZ/G3S (see chapters "Ether Ch0 Voltage Mode Control
> Register (ETH0_POC)", "Ether Ch1 Voltage Mode Control Register (ETH1_POC)",
> for power source selection, "Ether MII/RGMII Mode Control Register
> (ETH_MODE)" for output-enable and "Input Enable Control Register (IEN_m)"
> for input-enable configurations).
>
> Commit also enables the Ethernet interfaces by selecting
> SW_CONFIG3 = SW_ON.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - removed #address-cells, #size-cells
> - adapted patch description to reflect the usage of SW_CONFIG

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
