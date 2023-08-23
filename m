Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9087853A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbjHWJQV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Aug 2023 05:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjHWJJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:09:38 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9BD1FFC;
        Wed, 23 Aug 2023 02:02:13 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-76da4437500so194601885a.1;
        Wed, 23 Aug 2023 02:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692781282; x=1693386082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtV842noA4k0ZIyALimzf7oD/qGOzDsyzAeC5Bbahhw=;
        b=Qc19fPJuEe1p3u0oQWV4AkCNYwpP9v3Ic0P7yx6HlKwP6OW8NHgP9k8G8yrQAKJFpG
         Ix/SSNULDfPePAepcByNJt8spAxHYhnymvLmrgsHLrsKzgsAmaBB6kkVrpKLbuEJmV2H
         PyOb6abatTlGWYwAxwHrNiGA6RFSMlY2QqOvfxerIZzP5tNny083YMUSD4C6RKGO/OoM
         keuUu+ZNM/0Fm+yYztg+aWz8SyIeU/nz8B3RvSpfW7Ph2410jNVtC9d/AzjUtvDoS+8Z
         IRsYUxan5XWWne5Qr5FCOeL8jwzkfbBs0xJEkUqWw9QPFDTqtGJx+sfnDcHa4c7h1KR8
         Otxw==
X-Gm-Message-State: AOJu0Yw8ek7rMaQZU7qlRTNaGXfexcM5mp6Ds1QUWKs3fAx3CPNcS7zi
        ZczwfjbQ417KOQT+94x3ziocLsn97Q6sDg==
X-Google-Smtp-Source: AGHT+IFKpxmoHYGhsmnguwReHG+/b22cfFCY4nYz+uUUUtSM2GT11veFqVBEGcCX6rtDSKCu+zL9DA==
X-Received: by 2002:a05:620a:4706:b0:76c:a3ae:1f64 with SMTP id bs6-20020a05620a470600b0076ca3ae1f64mr13828174qkb.49.1692781281995;
        Wed, 23 Aug 2023 02:01:21 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id t125-20020a0dd183000000b005837fe8dbe8sm3227563ywd.8.2023.08.23.02.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 02:01:20 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d63c0a6568fso5381640276.0;
        Wed, 23 Aug 2023 02:01:20 -0700 (PDT)
X-Received: by 2002:a25:cad7:0:b0:d12:46b1:4459 with SMTP id
 a206-20020a25cad7000000b00d1246b14459mr12184522ybg.6.1692781280284; Wed, 23
 Aug 2023 02:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230823085146.113562-1-krzysztof.kozlowski@linaro.org> <20230823085146.113562-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823085146.113562-2-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Aug 2023 11:01:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU7Gk5jTkD_hc_BAK0caQjzTBWrXedV+5rYrMRiZF1EAw@mail.gmail.com>
Message-ID: <CAMuHMdU7Gk5jTkD_hc_BAK0caQjzTBWrXedV+5rYrMRiZF1EAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: use capital "OR" for multiple licenses in SPDX
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-renesas-soc@vger.kernel.org
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

On Wed, Aug 23, 2023 at 10:52 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

>  arch/arm64/boot/dts/renesas/r8a77980a.dtsi                     | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi           | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779f0-spider.dts                | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779f0.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m0.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m1-salvator-xs.dts           | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dts               | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m1-ulcb.dts                  | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m1.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m2.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m3-salvator-xs.dts           | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dts               | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m3-ulcb.dts                  | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m3.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m4.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m5-salvator-xs.dts           | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m5.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m6.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m7.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m8.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779mb.dtsi                      | 2 +-

Mea culpa

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
