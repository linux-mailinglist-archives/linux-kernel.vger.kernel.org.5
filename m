Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AC8759067
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjGSIhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjGSIg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:36:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB70F172A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:36:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3143ccb0f75so6490720f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689755807; x=1692347807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ya0phUWs+QmSYPTf40Ec9GraTL0b1qbHJ8vStbmEBZg=;
        b=uXDiRSvYq7B/9LbpbSJ087f14uZhmCLV4ar2MPBIeY49qtQ8Tj90ZUOzErayGcK9+N
         RFLBCNzXOJqXoRlkxhJAHShg4Tf5s6ilr/Mn8LiQN432u1dxijFXvDMPjCi2NGMvtCER
         MOrpud6XSLPgXFNIdMo/xOlzMkSUQ9N9f6ZW/hBJfrel7LZAOBDzIf1TP5U4I0GFCmcM
         lIZb1+3Cgq0R+Dy+w3IEKU8Xuf0LJCm/Ln740luQUPY6dhefspBTx++bBME9qb+Q8EUA
         1ApI5aF4/NqkYIgwa2ysumTLMuXisiM7SZalWSHNYYHLIJ6KBJm2mVnAptSA+FbL3adS
         8YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689755807; x=1692347807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ya0phUWs+QmSYPTf40Ec9GraTL0b1qbHJ8vStbmEBZg=;
        b=BHOMMS9lKGJjHaETD8bMlbrBP22x28htVCXRHh8utf7gY5WvytTDA1BLR5ov/I3Ddc
         NK9RikJOUZmQ/S7L1FBwnuqHRxQMpqs1kjGQ0GGOHrK2jdYZsA8vx+mtnurPONDp8COt
         WuyF2Vw/fUpDHmWY/QsPHyiqG2dC/M56s1iqqqwfpzcXieUWD86HxAIuL5eiIQjGapNA
         mouWAWwik6Md1OqgR5M2QXIFBCndNh+1gvb5vBNsklS8hozi+ISZR5iNTOgMNilSP/cu
         wB0cR4KLNzqLrPp9BswNuSfhni1S9NbW+XHLJ6EkKVwj8P8YjeKRombAo07b7lGQZyvm
         Od8A==
X-Gm-Message-State: ABy/qLbodpWzr/6VDUliGw5mF0V/hNA8LUT3fVFjjWbS5yTbujG3gB4J
        5/z1GlePPM9FvKfqN9GeKkR1Sg==
X-Google-Smtp-Source: APBJJlFqQomm/tbefyd5bTZPZFk9Sgs26RjBrxytnX9xWsXJYSwhkjLNaz2rJXdYbYDJHf0Z17UQnA==
X-Received: by 2002:adf:ce01:0:b0:313:f783:262a with SMTP id p1-20020adfce01000000b00313f783262amr15703908wrn.21.1689755806869;
        Wed, 19 Jul 2023 01:36:46 -0700 (PDT)
Received: from linaro.org ([82.78.74.213])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d4fca000000b00314172ba213sm4567192wrw.108.2023.07.19.01.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 01:36:46 -0700 (PDT)
Date:   Wed, 19 Jul 2023 11:36:41 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Alex Helms <alexander.helms.jy@renesas.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Sh iraz Hashim <shiraz.linux.kernel@gmail.com>,
        soc@kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-oxnas@groups.io,
        linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] clk: Explicitly include correct DT includes
Message-ID: <ZLegme7zSY3EiyyN@linaro.org>
References: <20230718143156.1066339-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718143156.1066339-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-18 08:31:43, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> # samsung
> Acked-by: Heiko Stuebner <heiko@sntech.de> #rockchip
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com> # versaclock5
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Abel Vesa <abel.vesa@linaro.org> #imx

> ---
> v2:
> - Fix double include of of.h
> ---
>  drivers/clk/actions/owl-common.c                 | 2 --
>  drivers/clk/actions/owl-common.h                 | 2 +-
>  drivers/clk/axs10x/pll_clock.c                   | 3 +--
>  drivers/clk/baikal-t1/clk-ccu-div.c              | 1 -
>  drivers/clk/bcm/clk-bcm2835.c                    | 2 +-
>  drivers/clk/bcm/clk-bcm63xx-gate.c               | 1 -
>  drivers/clk/bcm/clk-sr.c                         | 2 +-
>  drivers/clk/clk-aspeed.c                         | 2 +-
>  drivers/clk/clk-ast2600.c                        | 2 +-
>  drivers/clk/clk-bm1880.c                         | 4 ++--
>  drivers/clk/clk-cs2000-cp.c                      | 2 +-
>  drivers/clk/clk-en7523.c                         | 3 +--
>  drivers/clk/clk-gpio.c                           | 2 +-
>  drivers/clk/clk-hsdk-pll.c                       | 1 -
>  drivers/clk/clk-k210.c                           | 1 -
>  drivers/clk/clk-oxnas.c                          | 1 -
>  drivers/clk/clk-palmas.c                         | 1 -
>  drivers/clk/clk-plldig.c                         | 2 --
>  drivers/clk/clk-qoriq.c                          | 2 +-
>  drivers/clk/clk-scpi.c                           | 1 -
>  drivers/clk/clk-si5351.c                         | 2 +-
>  drivers/clk/clk-versaclock5.c                    | 1 -
>  drivers/clk/clk-versaclock7.c                    | 1 -
>  drivers/clk/hisilicon/clk-hi3559a.c              | 2 +-
>  drivers/clk/hisilicon/clk-hi3620.c               | 1 -
>  drivers/clk/hisilicon/clk-hi3660.c               | 2 +-
>  drivers/clk/hisilicon/clk-hi3670.c               | 2 +-
>  drivers/clk/hisilicon/clk-hi6220-stub.c          | 2 +-
>  drivers/clk/hisilicon/clk-hi6220.c               | 3 ---
>  drivers/clk/hisilicon/clk-hip04.c                | 3 ---
>  drivers/clk/hisilicon/clk.c                      | 2 +-
>  drivers/clk/hisilicon/crg-hi3516cv300.c          | 2 +-
>  drivers/clk/hisilicon/crg-hi3798cv200.c          | 2 +-
>  drivers/clk/imx/clk-imx8qxp-lpcg.c               | 2 --
>  drivers/clk/imx/clk-imx8qxp.c                    | 1 -
>  drivers/clk/imx/clk-imx8ulp.c                    | 2 +-
>  drivers/clk/imx/clk-scu.c                        | 2 +-
>  drivers/clk/keystone/sci-clk.c                   | 3 +--
>  drivers/clk/mediatek/clk-mt2701-aud.c            | 2 +-
>  drivers/clk/mediatek/clk-mt2701-g3d.c            | 4 +---
>  drivers/clk/mediatek/clk-mt2701.c                | 4 +---
>  drivers/clk/mediatek/clk-mt2712.c                | 4 +---
>  drivers/clk/mediatek/clk-mt6765.c                | 2 +-
>  drivers/clk/mediatek/clk-mt6779-aud.c            | 4 +---
>  drivers/clk/mediatek/clk-mt6779.c                | 2 --
>  drivers/clk/mediatek/clk-mt6797.c                | 2 --
>  drivers/clk/mediatek/clk-mt7622-aud.c            | 2 +-
>  drivers/clk/mediatek/clk-mt7622-eth.c            | 4 +---
>  drivers/clk/mediatek/clk-mt7622-hif.c            | 4 +---
>  drivers/clk/mediatek/clk-mt7622.c                | 4 +---
>  drivers/clk/mediatek/clk-mt7629-eth.c            | 2 --
>  drivers/clk/mediatek/clk-mt7629-hif.c            | 4 +---
>  drivers/clk/mediatek/clk-mt7629.c                | 2 --
>  drivers/clk/mediatek/clk-mt7981-apmixed.c        | 4 +---
>  drivers/clk/mediatek/clk-mt7981-eth.c            | 4 +---
>  drivers/clk/mediatek/clk-mt7981-infracfg.c       | 4 +---
>  drivers/clk/mediatek/clk-mt7981-topckgen.c       | 4 +---
>  drivers/clk/mediatek/clk-mt7986-apmixed.c        | 4 +---
>  drivers/clk/mediatek/clk-mt7986-eth.c            | 4 +---
>  drivers/clk/mediatek/clk-mt7986-infracfg.c       | 4 +---
>  drivers/clk/mediatek/clk-mt7986-topckgen.c       | 4 +---
>  drivers/clk/mediatek/clk-mt8167-aud.c            | 4 +---
>  drivers/clk/mediatek/clk-mt8167-img.c            | 4 +---
>  drivers/clk/mediatek/clk-mt8167-mfgcfg.c         | 4 +---
>  drivers/clk/mediatek/clk-mt8167-mm.c             | 4 +---
>  drivers/clk/mediatek/clk-mt8167-vdec.c           | 4 +---
>  drivers/clk/mediatek/clk-mt8173-mm.c             | 2 +-
>  drivers/clk/mediatek/clk-mt8183.c                | 4 +---
>  drivers/clk/mediatek/clk-mt8188-apmixedsys.c     | 2 +-
>  drivers/clk/mediatek/clk-mt8188-topckgen.c       | 2 +-
>  drivers/clk/mediatek/clk-mt8192-cam.c            | 2 +-
>  drivers/clk/mediatek/clk-mt8192-img.c            | 2 +-
>  drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c   | 2 +-
>  drivers/clk/mediatek/clk-mt8192-ipe.c            | 2 +-
>  drivers/clk/mediatek/clk-mt8192-mdp.c            | 2 +-
>  drivers/clk/mediatek/clk-mt8192-mfg.c            | 2 +-
>  drivers/clk/mediatek/clk-mt8192-msdc.c           | 2 +-
>  drivers/clk/mediatek/clk-mt8192-scp_adsp.c       | 2 +-
>  drivers/clk/mediatek/clk-mt8192-vdec.c           | 2 +-
>  drivers/clk/mediatek/clk-mt8192-venc.c           | 2 +-
>  drivers/clk/mediatek/clk-mt8192.c                | 4 +---
>  drivers/clk/mediatek/clk-mt8195-apmixedsys.c     | 2 +-
>  drivers/clk/mediatek/clk-mt8195-topckgen.c       | 2 +-
>  drivers/clk/mediatek/clk-mt8365.c                | 4 +---
>  drivers/clk/mediatek/clk-mt8516-aud.c            | 4 +---
>  drivers/clk/meson/a1-peripherals.c               | 2 +-
>  drivers/clk/meson/a1-pll.c                       | 2 +-
>  drivers/clk/meson/axg-audio.c                    | 2 +-
>  drivers/clk/meson/axg.c                          | 2 +-
>  drivers/clk/meson/g12a.c                         | 2 +-
>  drivers/clk/meson/gxbb.c                         | 2 +-
>  drivers/clk/meson/meson-aoclk.c                  | 2 +-
>  drivers/clk/meson/meson-eeclk.c                  | 2 +-
>  drivers/clk/microchip/clk-pic32mzda.c            | 2 +-
>  drivers/clk/mvebu/ap-cpu-clk.c                   | 1 -
>  drivers/clk/mvebu/armada-37xx-periph.c           | 1 -
>  drivers/clk/qcom/apss-ipq-pll.c                  | 2 +-
>  drivers/clk/qcom/camcc-sc7180.c                  | 2 +-
>  drivers/clk/qcom/camcc-sc7280.c                  | 2 +-
>  drivers/clk/qcom/clk-rpm.c                       | 1 -
>  drivers/clk/qcom/clk-rpmh.c                      | 1 -
>  drivers/clk/qcom/clk-smd-rpm.c                   | 1 -
>  drivers/clk/qcom/dispcc-qcm2290.c                | 2 +-
>  drivers/clk/qcom/dispcc-sm6115.c                 | 2 +-
>  drivers/clk/qcom/dispcc-sm8450.c                 | 2 +-
>  drivers/clk/qcom/dispcc-sm8550.c                 | 2 +-
>  drivers/clk/qcom/gcc-apq8084.c                   | 1 -
>  drivers/clk/qcom/gcc-ipq4019.c                   | 1 -
>  drivers/clk/qcom/gcc-ipq5332.c                   | 3 ++-
>  drivers/clk/qcom/gcc-ipq6018.c                   | 1 -
>  drivers/clk/qcom/gcc-ipq806x.c                   | 2 +-
>  drivers/clk/qcom/gcc-ipq8074.c                   | 1 -
>  drivers/clk/qcom/gcc-mdm9607.c                   | 1 -
>  drivers/clk/qcom/gcc-mdm9615.c                   | 1 -
>  drivers/clk/qcom/gcc-msm8660.c                   | 1 -
>  drivers/clk/qcom/gcc-msm8909.c                   | 1 -
>  drivers/clk/qcom/gcc-msm8916.c                   | 1 -
>  drivers/clk/qcom/gcc-msm8917.c                   | 1 -
>  drivers/clk/qcom/gcc-msm8939.c                   | 1 -
>  drivers/clk/qcom/gcc-msm8953.c                   | 1 -
>  drivers/clk/qcom/gcc-msm8976.c                   | 2 +-
>  drivers/clk/qcom/gcc-msm8994.c                   | 1 -
>  drivers/clk/qcom/gcc-msm8996.c                   | 1 -
>  drivers/clk/qcom/gcc-msm8998.c                   | 1 -
>  drivers/clk/qcom/gcc-qdu1000.c                   | 3 ++-
>  drivers/clk/qcom/gcc-sa8775p.c                   | 2 +-
>  drivers/clk/qcom/gcc-sc7180.c                    | 2 +-
>  drivers/clk/qcom/gcc-sc7280.c                    | 2 +-
>  drivers/clk/qcom/gcc-sc8180x.c                   | 1 -
>  drivers/clk/qcom/gcc-sc8280xp.c                  | 2 +-
>  drivers/clk/qcom/gcc-sdm660.c                    | 1 -
>  drivers/clk/qcom/gcc-sdm845.c                    | 1 -
>  drivers/clk/qcom/gcc-sdx65.c                     | 2 +-
>  drivers/clk/qcom/gcc-sdx75.c                     | 3 ++-
>  drivers/clk/qcom/gcc-sm6115.c                    | 3 ++-
>  drivers/clk/qcom/gcc-sm6125.c                    | 1 -
>  drivers/clk/qcom/gcc-sm6375.c                    | 3 ++-
>  drivers/clk/qcom/gcc-sm7150.c                    | 4 ++--
>  drivers/clk/qcom/gcc-sm8150.c                    | 1 -
>  drivers/clk/qcom/gcc-sm8250.c                    | 2 +-
>  drivers/clk/qcom/gcc-sm8450.c                    | 3 ++-
>  drivers/clk/qcom/gcc-sm8550.c                    | 3 ++-
>  drivers/clk/qcom/gpucc-msm8998.c                 | 1 -
>  drivers/clk/qcom/gpucc-sa8775p.c                 | 4 ++--
>  drivers/clk/qcom/gpucc-sdm660.c                  | 1 -
>  drivers/clk/qcom/gpucc-sm6115.c                  | 3 ++-
>  drivers/clk/qcom/gpucc-sm6125.c                  | 3 ++-
>  drivers/clk/qcom/gpucc-sm6375.c                  | 3 ++-
>  drivers/clk/qcom/gpucc-sm8350.c                  | 2 +-
>  drivers/clk/qcom/gpucc-sm8450.c                  | 3 ++-
>  drivers/clk/qcom/gpucc-sm8550.c                  | 3 ++-
>  drivers/clk/qcom/lcc-ipq806x.c                   | 1 -
>  drivers/clk/qcom/lcc-mdm9615.c                   | 1 -
>  drivers/clk/qcom/lcc-msm8960.c                   | 1 -
>  drivers/clk/qcom/lpass-gfm-sm8250.c              | 2 +-
>  drivers/clk/qcom/lpassaudiocc-sc7280.c           | 3 ++-
>  drivers/clk/qcom/lpasscc-sc8280xp.c              | 4 +++-
>  drivers/clk/qcom/lpasscorecc-sc7180.c            | 2 +-
>  drivers/clk/qcom/lpasscorecc-sc7280.c            | 3 ++-
>  drivers/clk/qcom/mmcc-msm8974.c                  | 1 -
>  drivers/clk/qcom/mmcc-msm8994.c                  | 1 -
>  drivers/clk/qcom/mmcc-msm8996.c                  | 1 -
>  drivers/clk/qcom/mmcc-msm8998.c                  | 1 -
>  drivers/clk/qcom/tcsrcc-sm8550.c                 | 3 ++-
>  drivers/clk/qcom/videocc-sm8450.c                | 3 ++-
>  drivers/clk/qcom/videocc-sm8550.c                | 3 ++-
>  drivers/clk/renesas/rcar-usb2-clock-sel.c        | 1 -
>  drivers/clk/renesas/renesas-cpg-mssr.c           | 1 -
>  drivers/clk/renesas/rzg2l-cpg.c                  | 3 +--
>  drivers/clk/rockchip/clk-rk3568.c                | 2 +-
>  drivers/clk/rockchip/clk-rv1126.c                | 2 +-
>  drivers/clk/samsung/clk-exynos-arm64.c           | 3 ++-
>  drivers/clk/samsung/clk-exynos-audss.c           | 3 +--
>  drivers/clk/samsung/clk-exynos5-subcmu.c         | 2 +-
>  drivers/clk/samsung/clk-exynos7885.c             | 1 -
>  drivers/clk/samsung/clk-exynos850.c              | 1 -
>  drivers/clk/samsung/clk-exynosautov9.c           | 2 --
>  drivers/clk/samsung/clk-fsd.c                    | 2 --
>  drivers/clk/sifive/sifive-prci.c                 | 2 +-
>  drivers/clk/socfpga/clk-agilex.c                 | 3 +--
>  drivers/clk/socfpga/clk-s10.c                    | 3 +--
>  drivers/clk/spear/spear1310_clock.c              | 1 -
>  drivers/clk/spear/spear1340_clock.c              | 1 -
>  drivers/clk/spear/spear3xx_clock.c               | 2 +-
>  drivers/clk/sprd/common.c                        | 2 +-
>  drivers/clk/sprd/sc9860-clk.c                    | 2 +-
>  drivers/clk/sprd/ums512-clk.c                    | 2 +-
>  drivers/clk/starfive/clk-starfive-jh7100-audio.c | 1 -
>  drivers/clk/sunxi-ng/ccu-sun4i-a10.c             | 2 +-
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c           | 2 +-
>  drivers/clk/sunxi-ng/ccu-sun6i-rtc.c             | 2 ++
>  drivers/clk/sunxi-ng/ccu-sun8i-de2.c             | 2 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c              | 2 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-r.c               | 2 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-v3s.c             | 2 +-
>  drivers/clk/sunxi/clk-sun6i-apb0-gates.c         | 1 -
>  drivers/clk/sunxi/clk-sun9i-mmc.c                | 1 -
>  drivers/clk/tegra/clk-device.c                   | 2 +-
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c       | 2 +-
>  drivers/clk/tegra/clk-tegra20.c                  | 1 -
>  drivers/clk/tegra/clk-tegra30.c                  | 1 -
>  drivers/clk/tegra/clk.c                          | 2 +-
>  drivers/clk/uniphier/clk-uniphier-core.c         | 1 -
>  drivers/clk/xilinx/xlnx_vcu.c                    | 2 +-
>  drivers/clk/zynqmp/clkc.c                        | 3 ++-
>  205 files changed, 162 insertions(+), 277 deletions(-)
> 
> diff --git a/drivers/clk/actions/owl-common.c b/drivers/clk/actions/owl-common.c
> index 4de97cc7cb54..44bb4e861dbc 100644
> --- a/drivers/clk/actions/owl-common.c
> +++ b/drivers/clk/actions/owl-common.c
> @@ -8,8 +8,6 @@
>  // Copyright (c) 2018 Linaro Ltd.
>  // Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  
> -#include <linux/of_address.h>
> -#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
> diff --git a/drivers/clk/actions/owl-common.h b/drivers/clk/actions/owl-common.h
> index c000a431471e..8fb65f3e82d7 100644
> --- a/drivers/clk/actions/owl-common.h
> +++ b/drivers/clk/actions/owl-common.h
> @@ -12,10 +12,10 @@
>  #define _OWL_COMMON_H_
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of_platform.h>
>  #include <linux/regmap.h>
>  
>  struct device_node;
> +struct platform_device;
>  
>  struct owl_clk_common {
>  	struct regmap			*regmap;
> diff --git a/drivers/clk/axs10x/pll_clock.c b/drivers/clk/axs10x/pll_clock.c
> index 242bf5d75bab..6c7a2b62b406 100644
> --- a/drivers/clk/axs10x/pll_clock.c
> +++ b/drivers/clk/axs10x/pll_clock.c
> @@ -12,10 +12,9 @@
>  #include <linux/err.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/slab.h>
> -#include <linux/of.h>
>  
>  /* PLL registers addresses */
>  #define PLL_REG_IDIV	0x0
> diff --git a/drivers/clk/baikal-t1/clk-ccu-div.c b/drivers/clk/baikal-t1/clk-ccu-div.c
> index 0e772e034812..84555a00f950 100644
> --- a/drivers/clk/baikal-t1/clk-ccu-div.c
> +++ b/drivers/clk/baikal-t1/clk-ccu-div.c
> @@ -20,7 +20,6 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_platform.h>
>  #include <linux/ioport.h>
>  #include <linux/regmap.h>
>  
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 8dc476ef5bf9..fb04734afc80 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -32,7 +32,7 @@
>  #include <linux/io.h>
>  #include <linux/math.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <dt-bindings/clock/bcm2835.h>
> diff --git a/drivers/clk/bcm/clk-bcm63xx-gate.c b/drivers/clk/bcm/clk-bcm63xx-gate.c
> index 0769f98767da..36c7b302e396 100644
> --- a/drivers/clk/bcm/clk-bcm63xx-gate.c
> +++ b/drivers/clk/bcm/clk-bcm63xx-gate.c
> @@ -3,7 +3,6 @@
>  #include <linux/clk-provider.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  #include <dt-bindings/clock/bcm3368-clock.h>
> diff --git a/drivers/clk/bcm/clk-sr.c b/drivers/clk/bcm/clk-sr.c
> index 5db021685d6d..3b2cf397b789 100644
> --- a/drivers/clk/bcm/clk-sr.c
> +++ b/drivers/clk/bcm/clk-sr.c
> @@ -5,7 +5,7 @@
>  
>  #include <linux/err.h>
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  
>  #include <dt-bindings/clock/bcm-sr.h>
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 411ff5fb2c07..284710adaef5 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -4,8 +4,8 @@
>  #define pr_fmt(fmt) "clk-aspeed: " fmt
>  
>  #include <linux/mfd/syscon.h>
> +#include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index a094a2601a37..f9e27f95a967 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -5,8 +5,8 @@
>  #define pr_fmt(fmt) "clk-ast2600: " fmt
>  
>  #include <linux/mfd/syscon.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> diff --git a/drivers/clk/clk-bm1880.c b/drivers/clk/clk-bm1880.c
> index 2a19e50fff68..b47e72a3f547 100644
> --- a/drivers/clk/clk-bm1880.c
> +++ b/drivers/clk/clk-bm1880.c
> @@ -7,10 +7,10 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/io.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> diff --git a/drivers/clk/clk-cs2000-cp.c b/drivers/clk/clk-cs2000-cp.c
> index b82fee6a3d6f..35cb93ad298a 100644
> --- a/drivers/clk/clk-cs2000-cp.c
> +++ b/drivers/clk/clk-cs2000-cp.c
> @@ -9,7 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/clk.h>
>  #include <linux/i2c.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  
> diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
> index 29f0126cbd05..7cde328495e2 100644
> --- a/drivers/clk/clk-en7523.c
> +++ b/drivers/clk/clk-en7523.c
> @@ -2,9 +2,8 @@
>  
>  #include <linux/delay.h>
>  #include <linux/clk-provider.h>
> +#include <linux/io.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <dt-bindings/clock/en7523-clk.h>
>  
> diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
> index 38755a241ab7..5b114043771d 100644
> --- a/drivers/clk/clk-gpio.c
> +++ b/drivers/clk/clk-gpio.c
> @@ -15,8 +15,8 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/err.h>
>  #include <linux/device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <linux/of_device.h>
>  
>  /**
>   * DOC: basic gpio gated clock which can be enabled and disabled
> diff --git a/drivers/clk/clk-hsdk-pll.c b/drivers/clk/clk-hsdk-pll.c
> index 33b48ea5ea3d..9b4cefaf2031 100644
> --- a/drivers/clk/clk-hsdk-pll.c
> +++ b/drivers/clk/clk-hsdk-pll.c
> @@ -12,7 +12,6 @@
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> diff --git a/drivers/clk/clk-k210.c b/drivers/clk/clk-k210.c
> index 870adac5cdee..7b7329a907ab 100644
> --- a/drivers/clk/clk-k210.c
> +++ b/drivers/clk/clk-k210.c
> @@ -11,7 +11,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
>  #include <linux/of_clk.h>
> -#include <linux/of_platform.h>
>  #include <linux/of_address.h>
>  #include <linux/clk-provider.h>
>  #include <linux/bitfield.h>
> diff --git a/drivers/clk/clk-oxnas.c b/drivers/clk/clk-oxnas.c
> index 584e293156ad..f0e2f5a4c291 100644
> --- a/drivers/clk/clk-oxnas.c
> +++ b/drivers/clk/clk-oxnas.c
> @@ -9,7 +9,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/stringify.h>
>  #include <linux/regmap.h>
> diff --git a/drivers/clk/clk-palmas.c b/drivers/clk/clk-palmas.c
> index 74a241b1e1f4..5efb10776ae5 100644
> --- a/drivers/clk/clk-palmas.c
> +++ b/drivers/clk/clk-palmas.c
> @@ -14,7 +14,6 @@
>  #include <linux/mfd/palmas.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> diff --git a/drivers/clk/clk-plldig.c b/drivers/clk/clk-plldig.c
> index 25020164b89e..14357f3e4561 100644
> --- a/drivers/clk/clk-plldig.c
> +++ b/drivers/clk/clk-plldig.c
> @@ -12,8 +12,6 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/bitfield.h>
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index e3386fd98c5e..4dcde305944c 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -17,8 +17,8 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> -#include <linux/of_platform.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
>  #define PLL_DIV1	0
> diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
> index 3fb4003453ee..108b697bd317 100644
> --- a/drivers/clk/clk-scpi.c
> +++ b/drivers/clk/clk-scpi.c
> @@ -10,7 +10,6 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/module.h>
> -#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/scpi_protocol.h>
>  
> diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
> index 31c3c8a71f12..00fb9b09e030 100644
> --- a/drivers/clk/clk-si5351.c
> +++ b/drivers/clk/clk-si5351.c
> @@ -21,7 +21,7 @@
>  #include <linux/errno.h>
>  #include <linux/rational.h>
>  #include <linux/i2c.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
>  #include <linux/platform_data/si5351.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
> index 8bc54176f325..72b432f93b5f 100644
> --- a/drivers/clk/clk-versaclock5.c
> +++ b/drivers/clk/clk-versaclock5.c
> @@ -19,7 +19,6 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_platform.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> diff --git a/drivers/clk/clk-versaclock7.c b/drivers/clk/clk-versaclock7.c
> index 9babb7913c1c..7f4361084882 100644
> --- a/drivers/clk/clk-versaclock7.c
> +++ b/drivers/clk/clk-versaclock7.c
> @@ -14,7 +14,6 @@
>  #include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_platform.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/swab.h>
> diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
> index ce4028102bc2..ff4ca0edce06 100644
> --- a/drivers/clk/hisilicon/clk-hi3559a.c
> +++ b/drivers/clk/hisilicon/clk-hi3559a.c
> @@ -9,7 +9,7 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
> index a3d04c7c3da8..2d7186905abd 100644
> --- a/drivers/clk/hisilicon/clk-hi3620.c
> +++ b/drivers/clk/hisilicon/clk-hi3620.c
> @@ -14,7 +14,6 @@
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/slab.h>
>  
>  #include <dt-bindings/clock/hi3620-clock.h>
> diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
> index 41f61726ab19..50f13dbb0e48 100644
> --- a/drivers/clk/hisilicon/clk-hi3660.c
> +++ b/drivers/clk/hisilicon/clk-hi3660.c
> @@ -6,7 +6,7 @@
>  
>  #include <dt-bindings/clock/hi3660-clock.h>
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include "clk.h"
>  
> diff --git a/drivers/clk/hisilicon/clk-hi3670.c b/drivers/clk/hisilicon/clk-hi3670.c
> index 4d05a71683a5..fa20ad144c8e 100644
> --- a/drivers/clk/hisilicon/clk-hi3670.c
> +++ b/drivers/clk/hisilicon/clk-hi3670.c
> @@ -9,7 +9,7 @@
>  
>  #include <dt-bindings/clock/hi3670-clock.h>
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include "clk.h"
>  
> diff --git a/drivers/clk/hisilicon/clk-hi6220-stub.c b/drivers/clk/hisilicon/clk-hi6220-stub.c
> index 4fdee4424d82..a8319795ed1c 100644
> --- a/drivers/clk/hisilicon/clk-hi6220-stub.c
> +++ b/drivers/clk/hisilicon/clk-hi6220-stub.c
> @@ -14,7 +14,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/mailbox_client.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  /* Stub clocks id */
> diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
> index e7cdf72d4b06..c9d5a88da053 100644
> --- a/drivers/clk/hisilicon/clk-hi6220.c
> +++ b/drivers/clk/hisilicon/clk-hi6220.c
> @@ -11,9 +11,6 @@
>  #include <linux/clk-provider.h>
>  #include <linux/clkdev.h>
>  #include <linux/io.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/slab.h>
>  
>  #include <dt-bindings/clock/hi6220-clock.h>
> diff --git a/drivers/clk/hisilicon/clk-hip04.c b/drivers/clk/hisilicon/clk-hip04.c
> index 785b9faf3ea5..feb34e98af8c 100644
> --- a/drivers/clk/hisilicon/clk-hip04.c
> +++ b/drivers/clk/hisilicon/clk-hip04.c
> @@ -11,9 +11,6 @@
>  #include <linux/kernel.h>
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/slab.h>
>  
>  #include <dt-bindings/clock/hip04-clock.h>
> diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
> index 54d9fdc93599..09368fd32bef 100644
> --- a/drivers/clk/hisilicon/clk.c
> +++ b/drivers/clk/hisilicon/clk.c
> @@ -16,7 +16,7 @@
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
>  #include "clk.h"
> diff --git a/drivers/clk/hisilicon/crg-hi3516cv300.c b/drivers/clk/hisilicon/crg-hi3516cv300.c
> index fe1bd3e3f988..e602e65fbc38 100644
> --- a/drivers/clk/hisilicon/crg-hi3516cv300.c
> +++ b/drivers/clk/hisilicon/crg-hi3516cv300.c
> @@ -8,7 +8,7 @@
>  #include <dt-bindings/clock/hi3516cv300-clock.h>
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include "clk.h"
>  #include "crg.h"
> diff --git a/drivers/clk/hisilicon/crg-hi3798cv200.c b/drivers/clk/hisilicon/crg-hi3798cv200.c
> index a0b16be1e25d..f651b197e45a 100644
> --- a/drivers/clk/hisilicon/crg-hi3798cv200.c
> +++ b/drivers/clk/hisilicon/crg-hi3798cv200.c
> @@ -8,7 +8,7 @@
>  #include <dt-bindings/clock/histb-clock.h>
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include "clk.h"
>  #include "crg.h"
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> index 5e31a6a24b3a..5ce2c34e8f0c 100644
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> @@ -9,8 +9,6 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
> index 546a3703bfeb..cadcbb318f5c 100644
> --- a/drivers/clk/imx/clk-imx8qxp.c
> +++ b/drivers/clk/imx/clk-imx8qxp.c
> @@ -9,7 +9,6 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
> index e308c88cb801..6636a1921b46 100644
> --- a/drivers/clk/imx/clk-imx8ulp.c
> +++ b/drivers/clk/imx/clk-imx8ulp.c
> @@ -7,7 +7,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset-controller.h>
>  #include <linux/slab.h>
> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
> index 85041e339515..cd83c52e9952 100644
> --- a/drivers/clk/imx/clk-scu.c
> +++ b/drivers/clk/imx/clk-scu.c
> @@ -9,7 +9,7 @@
>  #include <linux/bsearch.h>
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
> index 6c1df4f11536..35fe197dd303 100644
> --- a/drivers/clk/keystone/sci-clk.c
> +++ b/drivers/clk/keystone/sci-clk.c
> @@ -9,8 +9,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/soc/ti/ti_sci_protocol.h>
> diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
> index 3ce7e71196fd..27eecb6d3a53 100644
> --- a/drivers/clk/mediatek/clk-mt2701-aud.c
> +++ b/drivers/clk/mediatek/clk-mt2701-aud.c
> @@ -7,7 +7,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
> index e03ac76279ba..d25687f6c9b4 100644
> --- a/drivers/clk/mediatek/clk-mt2701-g3d.c
> +++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
> @@ -6,9 +6,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
> index 4a154da8a543..72f20b7189e2 100644
> --- a/drivers/clk/mediatek/clk-mt2701.c
> +++ b/drivers/clk/mediatek/clk-mt2701.c
> @@ -5,9 +5,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-cpumux.h"
> diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
> index c4cc68c47af9..a8d12a1210fc 100644
> --- a/drivers/clk/mediatek/clk-mt2712.c
> +++ b/drivers/clk/mediatek/clk-mt2712.c
> @@ -7,9 +7,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
> index 0377e6dd3206..076d05b6e159 100644
> --- a/drivers/clk/mediatek/clk-mt6765.c
> +++ b/drivers/clk/mediatek/clk-mt6765.c
> @@ -9,7 +9,7 @@
>  #include <linux/of_address.h>
>  #include <linux/slab.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-gate.h"
> diff --git a/drivers/clk/mediatek/clk-mt6779-aud.c b/drivers/clk/mediatek/clk-mt6779-aud.c
> index a97e1117d30b..66ae6421e27e 100644
> --- a/drivers/clk/mediatek/clk-mt6779-aud.c
> +++ b/drivers/clk/mediatek/clk-mt6779-aud.c
> @@ -6,9 +6,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
> index f33fbaee1404..3ee2f5a2319a 100644
> --- a/drivers/clk/mediatek/clk-mt6779.c
> +++ b/drivers/clk/mediatek/clk-mt6779.c
> @@ -6,8 +6,6 @@
>  
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-gate.h"
> diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
> index 4c87c0348e5f..2ebd25f0ce71 100644
> --- a/drivers/clk/mediatek/clk-mt6797.c
> +++ b/drivers/clk/mediatek/clk-mt6797.c
> @@ -5,8 +5,6 @@
>   */
>  
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-gate.h"
> diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
> index c3ce65ced902..42bade71e2f8 100644
> --- a/drivers/clk/mediatek/clk-mt7622-aud.c
> +++ b/drivers/clk/mediatek/clk-mt7622-aud.c
> @@ -8,7 +8,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
> index df81e445026a..62fdf127e77d 100644
> --- a/drivers/clk/mediatek/clk-mt7622-eth.c
> +++ b/drivers/clk/mediatek/clk-mt7622-eth.c
> @@ -6,9 +6,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
> index 9c738d730a7b..b4a520ce362c 100644
> --- a/drivers/clk/mediatek/clk-mt7622-hif.c
> +++ b/drivers/clk/mediatek/clk-mt7622-hif.c
> @@ -6,9 +6,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
> index fa5fb5891a09..27781a62a131 100644
> --- a/drivers/clk/mediatek/clk-mt7622.c
> +++ b/drivers/clk/mediatek/clk-mt7622.c
> @@ -6,9 +6,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-cpumux.h"
> diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
> index 1e1c77cc14ba..fe714debdc9e 100644
> --- a/drivers/clk/mediatek/clk-mt7629-eth.c
> +++ b/drivers/clk/mediatek/clk-mt7629-eth.c
> @@ -7,8 +7,6 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
> index ec3a71ebb766..dd1be946a8f0 100644
> --- a/drivers/clk/mediatek/clk-mt7629-hif.c
> +++ b/drivers/clk/mediatek/clk-mt7629-hif.c
> @@ -6,9 +6,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
> index 0893fbbb68cc..2882107d0f24 100644
> --- a/drivers/clk/mediatek/clk-mt7629.c
> +++ b/drivers/clk/mediatek/clk-mt7629.c
> @@ -8,8 +8,6 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-cpumux.h"
> diff --git a/drivers/clk/mediatek/clk-mt7981-apmixed.c b/drivers/clk/mediatek/clk-mt7981-apmixed.c
> index 875813d8b4a9..98739877f430 100644
> --- a/drivers/clk/mediatek/clk-mt7981-apmixed.c
> +++ b/drivers/clk/mediatek/clk-mt7981-apmixed.c
> @@ -8,9 +8,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-gate.h"
> diff --git a/drivers/clk/mediatek/clk-mt7981-eth.c b/drivers/clk/mediatek/clk-mt7981-eth.c
> index 6bc509a54e14..fb1a8c9242ef 100644
> --- a/drivers/clk/mediatek/clk-mt7981-eth.c
> +++ b/drivers/clk/mediatek/clk-mt7981-eth.c
> @@ -8,9 +8,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt7981-infracfg.c b/drivers/clk/mediatek/clk-mt7981-infracfg.c
> index 7e9d3d309151..18bf4e8be457 100644
> --- a/drivers/clk/mediatek/clk-mt7981-infracfg.c
> +++ b/drivers/clk/mediatek/clk-mt7981-infracfg.c
> @@ -8,9 +8,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include "clk-mtk.h"
>  #include "clk-gate.h"
> diff --git a/drivers/clk/mediatek/clk-mt7981-topckgen.c b/drivers/clk/mediatek/clk-mt7981-topckgen.c
> index 4740776e7aab..682f4ca9e89a 100644
> --- a/drivers/clk/mediatek/clk-mt7981-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt7981-topckgen.c
> @@ -8,9 +8,7 @@
>  
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include "clk-mtk.h"
>  #include "clk-gate.h"
> diff --git a/drivers/clk/mediatek/clk-mt7986-apmixed.c b/drivers/clk/mediatek/clk-mt7986-apmixed.c
> index 6767e9c43886..7f807fbdfcb9 100644
> --- a/drivers/clk/mediatek/clk-mt7986-apmixed.c
> +++ b/drivers/clk/mediatek/clk-mt7986-apmixed.c
> @@ -6,9 +6,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-gate.h"
> diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
> index 854e2c565041..7ab78e0f49a1 100644
> --- a/drivers/clk/mediatek/clk-mt7986-eth.c
> +++ b/drivers/clk/mediatek/clk-mt7986-eth.c
> @@ -6,9 +6,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
> index c576e9fb986c..cb8ab3e53abf 100644
> --- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
> +++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
> @@ -6,9 +6,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include "clk-mtk.h"
>  #include "clk-gate.h"
> diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
> index af151b016872..84bc24511504 100644
> --- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
> @@ -6,9 +6,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include "clk-mtk.h"
>  #include "clk-gate.h"
> diff --git a/drivers/clk/mediatek/clk-mt8167-aud.c b/drivers/clk/mediatek/clk-mt8167-aud.c
> index b73058edf3d6..a5181f4eb34a 100644
> --- a/drivers/clk/mediatek/clk-mt8167-aud.c
> +++ b/drivers/clk/mediatek/clk-mt8167-aud.c
> @@ -7,9 +7,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt8167-img.c b/drivers/clk/mediatek/clk-mt8167-img.c
> index ba07d20f14b3..02fa52d8aabb 100644
> --- a/drivers/clk/mediatek/clk-mt8167-img.c
> +++ b/drivers/clk/mediatek/clk-mt8167-img.c
> @@ -7,9 +7,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
> index 5f7dbaf97e96..a5b5ee7ac805 100644
> --- a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
> +++ b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
> @@ -7,9 +7,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt8167-mm.c b/drivers/clk/mediatek/clk-mt8167-mm.c
> index 6472e76567a5..9b0c6b3343b9 100644
> --- a/drivers/clk/mediatek/clk-mt8167-mm.c
> +++ b/drivers/clk/mediatek/clk-mt8167-mm.c
> @@ -7,9 +7,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt8167-vdec.c b/drivers/clk/mediatek/clk-mt8167-vdec.c
> index 2f662b3f16a9..1e1e76743180 100644
> --- a/drivers/clk/mediatek/clk-mt8167-vdec.c
> +++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
> @@ -7,9 +7,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt8173-mm.c b/drivers/clk/mediatek/clk-mt8173-mm.c
> index ffed6c5bfde2..fd903bee328f 100644
> --- a/drivers/clk/mediatek/clk-mt8173-mm.c
> +++ b/drivers/clk/mediatek/clk-mt8173-mm.c
> @@ -5,7 +5,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-gate.h"
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> index 1ba421b38ec5..3155c65b15dc 100644
> --- a/drivers/clk/mediatek/clk-mt8183.c
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -5,9 +5,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> diff --git a/drivers/clk/mediatek/clk-mt8188-apmixedsys.c b/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
> index 3c1ace87796b..41ab4d6896a4 100644
> --- a/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
> +++ b/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
> @@ -5,7 +5,7 @@
>   */
>  
>  #include <dt-bindings/clock/mediatek,mt8188-clk.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-gate.h"
> diff --git a/drivers/clk/mediatek/clk-mt8188-topckgen.c b/drivers/clk/mediatek/clk-mt8188-topckgen.c
> index d2eba2d6af8d..e330a4f9a0c3 100644
> --- a/drivers/clk/mediatek/clk-mt8188-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8188-topckgen.c
> @@ -5,7 +5,7 @@
>   */
>  
>  #include <dt-bindings/clock/mediatek,mt8188-clk.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-gate.h"
> diff --git a/drivers/clk/mediatek/clk-mt8192-cam.c b/drivers/clk/mediatek/clk-mt8192-cam.c
> index 7b9327eba924..a2c0142273a8 100644
> --- a/drivers/clk/mediatek/clk-mt8192-cam.c
> +++ b/drivers/clk/mediatek/clk-mt8192-cam.c
> @@ -4,7 +4,7 @@
>  // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt8192-img.c b/drivers/clk/mediatek/clk-mt8192-img.c
> index 0208030c31a0..ee52b5b748e7 100644
> --- a/drivers/clk/mediatek/clk-mt8192-img.c
> +++ b/drivers/clk/mediatek/clk-mt8192-img.c
> @@ -4,7 +4,7 @@
>  // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
> index 275581f8c710..a97b6e8d97ac 100644
> --- a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
> +++ b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
> @@ -4,7 +4,7 @@
>  // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt8192-ipe.c b/drivers/clk/mediatek/clk-mt8192-ipe.c
> index f3656c3b9573..56ce58ac01ad 100644
> --- a/drivers/clk/mediatek/clk-mt8192-ipe.c
> +++ b/drivers/clk/mediatek/clk-mt8192-ipe.c
> @@ -4,7 +4,7 @@
>  // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt8192-mdp.c b/drivers/clk/mediatek/clk-mt8192-mdp.c
> index 5385ac95533a..bad2f3d439f5 100644
> --- a/drivers/clk/mediatek/clk-mt8192-mdp.c
> +++ b/drivers/clk/mediatek/clk-mt8192-mdp.c
> @@ -4,7 +4,7 @@
>  // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt8192-mfg.c b/drivers/clk/mediatek/clk-mt8192-mfg.c
> index 0ac7045cf5d1..666b401e778c 100644
> --- a/drivers/clk/mediatek/clk-mt8192-mfg.c
> +++ b/drivers/clk/mediatek/clk-mt8192-mfg.c
> @@ -4,7 +4,7 @@
>  // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt8192-msdc.c b/drivers/clk/mediatek/clk-mt8192-msdc.c
> index 9da647c5b8b3..52d6f0babf12 100644
> --- a/drivers/clk/mediatek/clk-mt8192-msdc.c
> +++ b/drivers/clk/mediatek/clk-mt8192-msdc.c
> @@ -4,7 +4,7 @@
>  // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
> index 44091147c813..72c8a8722b11 100644
> --- a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
> +++ b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
> @@ -4,7 +4,7 @@
>  // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt8192-vdec.c b/drivers/clk/mediatek/clk-mt8192-vdec.c
> index d82dee8317b2..cc514068bcdb 100644
> --- a/drivers/clk/mediatek/clk-mt8192-vdec.c
> +++ b/drivers/clk/mediatek/clk-mt8192-vdec.c
> @@ -4,7 +4,7 @@
>  // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt8192-venc.c b/drivers/clk/mediatek/clk-mt8192-venc.c
> index b0ef242991e5..9f6fff2dd753 100644
> --- a/drivers/clk/mediatek/clk-mt8192-venc.c
> +++ b/drivers/clk/mediatek/clk-mt8192-venc.c
> @@ -4,7 +4,7 @@
>  // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
> index 462ec4465b50..e395c04632bc 100644
> --- a/drivers/clk/mediatek/clk-mt8192.c
> +++ b/drivers/clk/mediatek/clk-mt8192.c
> @@ -6,9 +6,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> index 502a9dc1fdb8..44a4c85a67ef 100644
> --- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> +++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> @@ -10,7 +10,7 @@
>  #include "clk-pllfh.h"
>  
>  #include <dt-bindings/clock/mt8195-clk.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  static const struct mtk_gate_regs apmixed_cg_regs = {
> diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> index 81daa24cadde..5c426a1c94c7 100644
> --- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> @@ -8,7 +8,7 @@
>  #include "clk-mux.h"
>  
>  #include <dt-bindings/clock/mt8195-clk.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  static DEFINE_SPINLOCK(mt8195_clk_lock);
> diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
> index 1dca18f99134..ac45e4cc9bcd 100644
> --- a/drivers/clk/mediatek/clk-mt8365.c
> +++ b/drivers/clk/mediatek/clk-mt8365.c
> @@ -10,9 +10,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/delay.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> diff --git a/drivers/clk/mediatek/clk-mt8516-aud.c b/drivers/clk/mediatek/clk-mt8516-aud.c
> index d1e848e78fd5..53e1866fb8e2 100644
> --- a/drivers/clk/mediatek/clk-mt8516-aud.c
> +++ b/drivers/clk/mediatek/clk-mt8516-aud.c
> @@ -7,9 +7,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
> index 75dfae210fe5..c41f91b1203f 100644
> --- a/drivers/clk/meson/a1-peripherals.c
> +++ b/drivers/clk/meson/a1-peripherals.c
> @@ -8,7 +8,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include "a1-peripherals.h"
>  #include "clk-dualdiv.h"
> diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
> index bd2f1d1ec6e4..430f5320318a 100644
> --- a/drivers/clk/meson/a1-pll.c
> +++ b/drivers/clk/meson/a1-pll.c
> @@ -8,7 +8,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include "a1-pll.h"
>  #include "clk-regmap.h"
> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
> index 5016682e47c8..0c08da60af27 100644
> --- a/drivers/clk/meson/axg-audio.c
> +++ b/drivers/clk/meson/axg-audio.c
> @@ -7,8 +7,8 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/init.h>
> -#include <linux/of_device.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index 2ad3801398dc..2e334cfa5580 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -11,7 +11,7 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/init.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 310accf94830..6fe3465547c0 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -12,7 +12,7 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/init.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/module.h>
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 608e0e8ca49a..5e51636a5faf 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -6,7 +6,7 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/init.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  
> diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
> index 434cd8f9de82..4487c7168493 100644
> --- a/drivers/clk/meson/meson-aoclk.c
> +++ b/drivers/clk/meson/meson-aoclk.c
> @@ -13,7 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/reset-controller.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/module.h>
>  
>  #include <linux/slab.h>
> diff --git a/drivers/clk/meson/meson-eeclk.c b/drivers/clk/meson/meson-eeclk.c
> index 0e5e6b57eb20..42ef6d52241f 100644
> --- a/drivers/clk/meson/meson-eeclk.c
> +++ b/drivers/clk/meson/meson-eeclk.c
> @@ -5,7 +5,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> diff --git a/drivers/clk/microchip/clk-pic32mzda.c b/drivers/clk/microchip/clk-pic32mzda.c
> index eabfc4931fe9..27599829ea40 100644
> --- a/drivers/clk/microchip/clk-pic32mzda.c
> +++ b/drivers/clk/microchip/clk-pic32mzda.c
> @@ -9,8 +9,8 @@
>  #include <linux/clkdev.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <asm/traps.h>
>  
> diff --git a/drivers/clk/mvebu/ap-cpu-clk.c b/drivers/clk/mvebu/ap-cpu-clk.c
> index d8a7a4c90d54..677cc3514849 100644
> --- a/drivers/clk/mvebu/ap-cpu-clk.c
> +++ b/drivers/clk/mvebu/ap-cpu-clk.c
> @@ -15,7 +15,6 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include "armada_ap_cp_helper.h"
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> index 3ae6078f6ff7..6cd6c33b381a 100644
> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -21,7 +21,6 @@
>  #include <linux/io.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
> index ce28d882ee78..e170331858cc 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -2,7 +2,7 @@
>  // Copyright (c) 2018, The Linux Foundation. All rights reserved.
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
> diff --git a/drivers/clk/qcom/camcc-sc7180.c b/drivers/clk/qcom/camcc-sc7180.c
> index 8a4ba7a19ed1..cbffc44c4d32 100644
> --- a/drivers/clk/qcom/camcc-sc7180.c
> +++ b/drivers/clk/qcom/camcc-sc7180.c
> @@ -7,7 +7,7 @@
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_clock.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> diff --git a/drivers/clk/qcom/camcc-sc7280.c b/drivers/clk/qcom/camcc-sc7280.c
> index 4396fddba7a6..49f046ea857c 100644
> --- a/drivers/clk/qcom/camcc-sc7280.c
> +++ b/drivers/clk/qcom/camcc-sc7280.c
> @@ -7,8 +7,8 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,camcc-sc7280.h>
> diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
> index cac623e27b0e..745026ef4d9c 100644
> --- a/drivers/clk/qcom/clk-rpm.c
> +++ b/drivers/clk/qcom/clk-rpm.c
> @@ -13,7 +13,6 @@
>  #include <linux/mutex.h>
>  #include <linux/mfd/qcom_rpm.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  #include <dt-bindings/mfd/qcom-rpm.h>
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 86572570bc54..4c5b552b47b6 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -8,7 +8,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <soc/qcom/cmd-db.h>
>  #include <soc/qcom/rpmh.h>
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index e4de74b68797..4bcf2e949877 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -12,7 +12,6 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/soc/qcom/smd-rpm.h>
>  
> diff --git a/drivers/clk/qcom/dispcc-qcm2290.c b/drivers/clk/qcom/dispcc-qcm2290.c
> index 44dd5cfcc150..9206f0eed446 100644
> --- a/drivers/clk/qcom/dispcc-qcm2290.c
> +++ b/drivers/clk/qcom/dispcc-qcm2290.c
> @@ -7,8 +7,8 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,dispcc-qcm2290.h>
> diff --git a/drivers/clk/qcom/dispcc-sm6115.c b/drivers/clk/qcom/dispcc-sm6115.c
> index 1937edf23f21..1fab43f08e73 100644
> --- a/drivers/clk/qcom/dispcc-sm6115.c
> +++ b/drivers/clk/qcom/dispcc-sm6115.c
> @@ -8,8 +8,8 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,sm6115-dispcc.h>
> diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
> index adbfd30bfc96..3643af36d755 100644
> --- a/drivers/clk/qcom/dispcc-sm8450.c
> +++ b/drivers/clk/qcom/dispcc-sm8450.c
> @@ -9,8 +9,8 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/pm_runtime.h>
>  
> diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
> index 1e5a11081860..2a74be35452f 100644
> --- a/drivers/clk/qcom/dispcc-sm8550.c
> +++ b/drivers/clk/qcom/dispcc-sm8550.c
> @@ -9,8 +9,8 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/pm_runtime.h>
>  
> diff --git a/drivers/clk/qcom/gcc-apq8084.c b/drivers/clk/qcom/gcc-apq8084.c
> index 7085d2ccae49..c7ca93ef0d53 100644
> --- a/drivers/clk/qcom/gcc-apq8084.c
> +++ b/drivers/clk/qcom/gcc-apq8084.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-ipq4019.c b/drivers/clk/qcom/gcc-ipq4019.c
> index 5657e29464ad..9c75682a3915 100644
> --- a/drivers/clk/qcom/gcc-ipq4019.c
> +++ b/drivers/clk/qcom/gcc-ipq4019.c
> @@ -8,7 +8,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
> index a75ab88ed14c..ce6dc6e99a29 100644
> --- a/drivers/clk/qcom/gcc-ipq5332.c
> +++ b/drivers/clk/qcom/gcc-ipq5332.c
> @@ -4,8 +4,9 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
> index 86b43175b042..6120fbbc5de0 100644
> --- a/drivers/clk/qcom/gcc-ipq6018.c
> +++ b/drivers/clk/qcom/gcc-ipq6018.c
> @@ -8,7 +8,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  
> diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
> index 6447f3e81b55..974d01fd4381 100644
> --- a/drivers/clk/qcom/gcc-ipq806x.c
> +++ b/drivers/clk/qcom/gcc-ipq806x.c
> @@ -9,7 +9,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
> index 6541d98c0348..63ac2ced76bb 100644
> --- a/drivers/clk/qcom/gcc-ipq8074.c
> +++ b/drivers/clk/qcom/gcc-ipq8074.c
> @@ -8,7 +8,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  
> diff --git a/drivers/clk/qcom/gcc-mdm9607.c b/drivers/clk/qcom/gcc-mdm9607.c
> index 4c9078e99bb3..fb290e73ce94 100644
> --- a/drivers/clk/qcom/gcc-mdm9607.c
> +++ b/drivers/clk/qcom/gcc-mdm9607.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-mdm9615.c b/drivers/clk/qcom/gcc-mdm9615.c
> index 8bed02a748ab..8513cb5af7c6 100644
> --- a/drivers/clk/qcom/gcc-mdm9615.c
> +++ b/drivers/clk/qcom/gcc-mdm9615.c
> @@ -11,7 +11,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-msm8660.c b/drivers/clk/qcom/gcc-msm8660.c
> index a9eb6a9ac445..67870c899ab9 100644
> --- a/drivers/clk/qcom/gcc-msm8660.c
> +++ b/drivers/clk/qcom/gcc-msm8660.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-msm8909.c b/drivers/clk/qcom/gcc-msm8909.c
> index 2a00b11ce2cd..cc36e81bca7d 100644
> --- a/drivers/clk/qcom/gcc-msm8909.c
> +++ b/drivers/clk/qcom/gcc-msm8909.c
> @@ -14,7 +14,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-msm8916.c b/drivers/clk/qcom/gcc-msm8916.c
> index 0c8fe19387a7..9c7c6b23ce32 100644
> --- a/drivers/clk/qcom/gcc-msm8916.c
> +++ b/drivers/clk/qcom/gcc-msm8916.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-msm8917.c b/drivers/clk/qcom/gcc-msm8917.c
> index a4c33a2ce61c..5ec14480e068 100644
> --- a/drivers/clk/qcom/gcc-msm8917.c
> +++ b/drivers/clk/qcom/gcc-msm8917.c
> @@ -18,7 +18,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-msm8939.c b/drivers/clk/qcom/gcc-msm8939.c
> index 7f8969a77974..b45f97c07eeb 100644
> --- a/drivers/clk/qcom/gcc-msm8939.c
> +++ b/drivers/clk/qcom/gcc-msm8939.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-msm8953.c b/drivers/clk/qcom/gcc-msm8953.c
> index 8aafa6591e84..3e5a8cb14d4d 100644
> --- a/drivers/clk/qcom/gcc-msm8953.c
> +++ b/drivers/clk/qcom/gcc-msm8953.c
> @@ -7,7 +7,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-msm8976.c b/drivers/clk/qcom/gcc-msm8976.c
> index 8beb923c0e19..f60a8171972b 100644
> --- a/drivers/clk/qcom/gcc-msm8976.c
> +++ b/drivers/clk/qcom/gcc-msm8976.c
> @@ -15,8 +15,8 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,gcc-msm8976.h>
> diff --git a/drivers/clk/qcom/gcc-msm8994.c b/drivers/clk/qcom/gcc-msm8994.c
> index 0f52c48e89d8..80170a805c3b 100644
> --- a/drivers/clk/qcom/gcc-msm8994.c
> +++ b/drivers/clk/qcom/gcc-msm8994.c
> @@ -9,7 +9,6 @@
>  #include <linux/ctype.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
> index 5e44d1bcca9e..14dcc3f03668 100644
> --- a/drivers/clk/qcom/gcc-msm8996.c
> +++ b/drivers/clk/qcom/gcc-msm8996.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
> index be024f8093c5..1ba516a0c0f3 100644
> --- a/drivers/clk/qcom/gcc-msm8998.c
> +++ b/drivers/clk/qcom/gcc-msm8998.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
> index 5051769ad90c..328b306297ef 100644
> --- a/drivers/clk/qcom/gcc-qdu1000.c
> +++ b/drivers/clk/qcom/gcc-qdu1000.c
> @@ -5,7 +5,8 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,qdu1000-gcc.h>
> diff --git a/drivers/clk/qcom/gcc-sa8775p.c b/drivers/clk/qcom/gcc-sa8775p.c
> index bb94ff367abd..8171d23c96e6 100644
> --- a/drivers/clk/qcom/gcc-sa8775p.c
> +++ b/drivers/clk/qcom/gcc-sa8775p.c
> @@ -9,8 +9,8 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
> diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
> index cef3c77564cf..ede83c644716 100644
> --- a/drivers/clk/qcom/gcc-sc7180.c
> +++ b/drivers/clk/qcom/gcc-sc7180.c
> @@ -8,7 +8,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,gcc-sc7180.h>
> diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
> index 1dc804154031..2b661df5de26 100644
> --- a/drivers/clk/qcom/gcc-sc7280.c
> +++ b/drivers/clk/qcom/gcc-sc7280.c
> @@ -6,8 +6,8 @@
>  #include <linux/clk-provider.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,gcc-sc7280.h>
> diff --git a/drivers/clk/qcom/gcc-sc8180x.c b/drivers/clk/qcom/gcc-sc8180x.c
> index c41b9f010585..ae2147381559 100644
> --- a/drivers/clk/qcom/gcc-sc8180x.c
> +++ b/drivers/clk/qcom/gcc-sc8180x.c
> @@ -10,7 +10,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> index b90c71637814..1ab119b3702a 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -8,9 +8,9 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
> diff --git a/drivers/clk/qcom/gcc-sdm660.c b/drivers/clk/qcom/gcc-sdm660.c
> index 6afce8e42ede..c4fe70871b6d 100644
> --- a/drivers/clk/qcom/gcc-sdm660.c
> +++ b/drivers/clk/qcom/gcc-sdm660.c
> @@ -10,7 +10,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> index 6af08e0ca847..725cd52d2398 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-sdx65.c b/drivers/clk/qcom/gcc-sdx65.c
> index b0c17043551d..ffddbed5a6db 100644
> --- a/drivers/clk/qcom/gcc-sdx65.c
> +++ b/drivers/clk/qcom/gcc-sdx65.c
> @@ -7,8 +7,8 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,gcc-sdx65.h>
> diff --git a/drivers/clk/qcom/gcc-sdx75.c b/drivers/clk/qcom/gcc-sdx75.c
> index b6772abdcec5..573af17bd24c 100644
> --- a/drivers/clk/qcom/gcc-sdx75.c
> +++ b/drivers/clk/qcom/gcc-sdx75.c
> @@ -4,8 +4,9 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,sdx75-gcc.h>
> diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
> index 033e308ff865..13e521cd4259 100644
> --- a/drivers/clk/qcom/gcc-sm6115.c
> +++ b/drivers/clk/qcom/gcc-sm6115.c
> @@ -6,7 +6,8 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-sm6125.c b/drivers/clk/qcom/gcc-sm6125.c
> index 40ad062d1bf7..da554efee2ce 100644
> --- a/drivers/clk/qcom/gcc-sm6125.c
> +++ b/drivers/clk/qcom/gcc-sm6125.c
> @@ -8,7 +8,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-sm6375.c b/drivers/clk/qcom/gcc-sm6375.c
> index 417a0fd242ec..3dd15d765b22 100644
> --- a/drivers/clk/qcom/gcc-sm6375.c
> +++ b/drivers/clk/qcom/gcc-sm6375.c
> @@ -6,7 +6,8 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,sm6375-gcc.h>
> diff --git a/drivers/clk/qcom/gcc-sm7150.c b/drivers/clk/qcom/gcc-sm7150.c
> index 6b628178f62c..973142a1b404 100644
> --- a/drivers/clk/qcom/gcc-sm7150.c
> +++ b/drivers/clk/qcom/gcc-sm7150.c
> @@ -8,9 +8,9 @@
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,sm7150-gcc.h>
> diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
> index 70b067f3618c..41ab210875fb 100644
> --- a/drivers/clk/qcom/gcc-sm8150.c
> +++ b/drivers/clk/qcom/gcc-sm8150.c
> @@ -7,7 +7,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gcc-sm8250.c b/drivers/clk/qcom/gcc-sm8250.c
> index b6cf4bc88d4d..ee0ce6582e85 100644
> --- a/drivers/clk/qcom/gcc-sm8250.c
> +++ b/drivers/clk/qcom/gcc-sm8250.c
> @@ -7,8 +7,8 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,gcc-sm8250.h>
> diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
> index 75635d40a12d..86ad085260db 100644
> --- a/drivers/clk/qcom/gcc-sm8450.c
> +++ b/drivers/clk/qcom/gcc-sm8450.c
> @@ -6,7 +6,8 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,gcc-sm8450.h>
> diff --git a/drivers/clk/qcom/gcc-sm8550.c b/drivers/clk/qcom/gcc-sm8550.c
> index 277cd4f020ff..586126c4dd90 100644
> --- a/drivers/clk/qcom/gcc-sm8550.c
> +++ b/drivers/clk/qcom/gcc-sm8550.c
> @@ -7,7 +7,8 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,sm8550-gcc.h>
> diff --git a/drivers/clk/qcom/gpucc-msm8998.c b/drivers/clk/qcom/gpucc-msm8998.c
> index f929e0f2333f..0b6e1d6d884e 100644
> --- a/drivers/clk/qcom/gpucc-msm8998.c
> +++ b/drivers/clk/qcom/gpucc-msm8998.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/gpucc-sa8775p.c b/drivers/clk/qcom/gpucc-sa8775p.c
> index 18d23be8d435..26ecfa63be19 100644
> --- a/drivers/clk/qcom/gpucc-sa8775p.c
> +++ b/drivers/clk/qcom/gpucc-sa8775p.c
> @@ -7,9 +7,9 @@
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> -#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
> diff --git a/drivers/clk/qcom/gpucc-sdm660.c b/drivers/clk/qcom/gpucc-sdm660.c
> index d6b38a0b063d..459f123a6720 100644
> --- a/drivers/clk/qcom/gpucc-sdm660.c
> +++ b/drivers/clk/qcom/gpucc-sdm660.c
> @@ -13,7 +13,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
>  #include <dt-bindings/clock/qcom,gpucc-sdm660.h>
> diff --git a/drivers/clk/qcom/gpucc-sm6115.c b/drivers/clk/qcom/gpucc-sm6115.c
> index c84727e8352d..fb71c21c9a89 100644
> --- a/drivers/clk/qcom/gpucc-sm6115.c
> +++ b/drivers/clk/qcom/gpucc-sm6115.c
> @@ -5,8 +5,9 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,sm6115-gpucc.h>
> diff --git a/drivers/clk/qcom/gpucc-sm6125.c b/drivers/clk/qcom/gpucc-sm6125.c
> index d4f1296a48ef..61959ba02f9a 100644
> --- a/drivers/clk/qcom/gpucc-sm6125.c
> +++ b/drivers/clk/qcom/gpucc-sm6125.c
> @@ -5,8 +5,9 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,sm6125-gpucc.h>
> diff --git a/drivers/clk/qcom/gpucc-sm6375.c b/drivers/clk/qcom/gpucc-sm6375.c
> index 2d863dc3d83b..da24276a018e 100644
> --- a/drivers/clk/qcom/gpucc-sm6375.c
> +++ b/drivers/clk/qcom/gpucc-sm6375.c
> @@ -5,8 +5,9 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  
> diff --git a/drivers/clk/qcom/gpucc-sm8350.c b/drivers/clk/qcom/gpucc-sm8350.c
> index 5367ce654ac9..8dc54dff983f 100644
> --- a/drivers/clk/qcom/gpucc-sm8350.c
> +++ b/drivers/clk/qcom/gpucc-sm8350.c
> @@ -8,8 +8,8 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,gpucc-sm8350.h>
> diff --git a/drivers/clk/qcom/gpucc-sm8450.c b/drivers/clk/qcom/gpucc-sm8450.c
> index 16c0381b3087..1c4769b646b0 100644
> --- a/drivers/clk/qcom/gpucc-sm8450.c
> +++ b/drivers/clk/qcom/gpucc-sm8450.c
> @@ -4,8 +4,9 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,sm8450-gpucc.h>
> diff --git a/drivers/clk/qcom/gpucc-sm8550.c b/drivers/clk/qcom/gpucc-sm8550.c
> index 8a2e3522af51..775e0b931923 100644
> --- a/drivers/clk/qcom/gpucc-sm8550.c
> +++ b/drivers/clk/qcom/gpucc-sm8550.c
> @@ -4,8 +4,9 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,sm8550-gpucc.h>
> diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
> index 81a44a9a9abc..fa8cda63cf20 100644
> --- a/drivers/clk/qcom/lcc-ipq806x.c
> +++ b/drivers/clk/qcom/lcc-ipq806x.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  
> diff --git a/drivers/clk/qcom/lcc-mdm9615.c b/drivers/clk/qcom/lcc-mdm9615.c
> index 8d243e880d95..396f7a804cfe 100644
> --- a/drivers/clk/qcom/lcc-mdm9615.c
> +++ b/drivers/clk/qcom/lcc-mdm9615.c
> @@ -11,7 +11,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  
> diff --git a/drivers/clk/qcom/lcc-msm8960.c b/drivers/clk/qcom/lcc-msm8960.c
> index 3926184cc91b..35a30c793f92 100644
> --- a/drivers/clk/qcom/lcc-msm8960.c
> +++ b/drivers/clk/qcom/lcc-msm8960.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  
> diff --git a/drivers/clk/qcom/lpass-gfm-sm8250.c b/drivers/clk/qcom/lpass-gfm-sm8250.c
> index 96f476f24eb2..8a1ee52cbcc3 100644
> --- a/drivers/clk/qcom/lpass-gfm-sm8250.c
> +++ b/drivers/clk/qcom/lpass-gfm-sm8250.c
> @@ -15,8 +15,8 @@
>  #include <linux/pm_clock.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <linux/of_device.h>
>  #include <dt-bindings/clock/qcom,sm8250-lpass-audiocc.h>
>  #include <dt-bindings/clock/qcom,sm8250-lpass-aoncc.h>
>  
> diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
> index 134eb1529ede..c43d0b1af7f7 100644
> --- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
> +++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
> @@ -7,7 +7,8 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_clock.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> diff --git a/drivers/clk/qcom/lpasscc-sc8280xp.c b/drivers/clk/qcom/lpasscc-sc8280xp.c
> index 43b37ce397cf..3693e47d548e 100644
> --- a/drivers/clk/qcom/lpasscc-sc8280xp.c
> +++ b/drivers/clk/qcom/lpasscc-sc8280xp.c
> @@ -6,8 +6,10 @@
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,sc8280xp-lpasscc.h>
> diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
> index 010867dcc2ef..9051fd567112 100644
> --- a/drivers/clk/qcom/lpasscorecc-sc7180.c
> +++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
> @@ -6,7 +6,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_clock.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> diff --git a/drivers/clk/qcom/lpasscorecc-sc7280.c b/drivers/clk/qcom/lpasscorecc-sc7280.c
> index 6ad19b06b1ce..a2f1e6ad6da4 100644
> --- a/drivers/clk/qcom/lpasscorecc-sc7280.c
> +++ b/drivers/clk/qcom/lpasscorecc-sc7280.c
> @@ -6,7 +6,8 @@
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_clock.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
> index 82f6bad144a9..a7acdef5a14e 100644
> --- a/drivers/clk/qcom/mmcc-msm8974.c
> +++ b/drivers/clk/qcom/mmcc-msm8974.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/mmcc-msm8994.c b/drivers/clk/qcom/mmcc-msm8994.c
> index 89c5f5fa7d9a..3229ff77372f 100644
> --- a/drivers/clk/qcom/mmcc-msm8994.c
> +++ b/drivers/clk/qcom/mmcc-msm8994.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/mmcc-msm8996.c b/drivers/clk/qcom/mmcc-msm8996.c
> index 80330dab4d81..d3f2dc798567 100644
> --- a/drivers/clk/qcom/mmcc-msm8996.c
> +++ b/drivers/clk/qcom/mmcc-msm8996.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
> index 4490594bde69..c62aa270af1c 100644
> --- a/drivers/clk/qcom/mmcc-msm8998.c
> +++ b/drivers/clk/qcom/mmcc-msm8998.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/qcom/tcsrcc-sm8550.c b/drivers/clk/qcom/tcsrcc-sm8550.c
> index 2c67ee71c196..552a3eb1fd91 100644
> --- a/drivers/clk/qcom/tcsrcc-sm8550.c
> +++ b/drivers/clk/qcom/tcsrcc-sm8550.c
> @@ -7,7 +7,8 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,sm8550-tcsr.h>
> diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
> index 7d0029b8b799..16a61146e619 100644
> --- a/drivers/clk/qcom/videocc-sm8450.c
> +++ b/drivers/clk/qcom/videocc-sm8450.c
> @@ -4,8 +4,9 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  
> diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
> index e2400fe23e60..3bb136ec31b1 100644
> --- a/drivers/clk/qcom/videocc-sm8550.c
> +++ b/drivers/clk/qcom/videocc-sm8550.c
> @@ -4,8 +4,9 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  
> diff --git a/drivers/clk/renesas/rcar-usb2-clock-sel.c b/drivers/clk/renesas/rcar-usb2-clock-sel.c
> index 17c110978e33..de4896cf5f40 100644
> --- a/drivers/clk/renesas/rcar-usb2-clock-sel.c
> +++ b/drivers/clk/renesas/rcar-usb2-clock-sel.c
> @@ -15,7 +15,6 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
> index 2772499d2016..cb80d1bf6c7c 100644
> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> @@ -21,7 +21,6 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_clock.h>
>  #include <linux/pm_domain.h>
> diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
> index bc623515ad84..2996f535b7e8 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -20,8 +20,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_clock.h>
>  #include <linux/pm_domain.h>
> diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk-rk3568.c
> index f85902e2590c..8d0b8defb1b5 100644
> --- a/drivers/clk/rockchip/clk-rk3568.c
> +++ b/drivers/clk/rockchip/clk-rk3568.c
> @@ -7,8 +7,8 @@
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/of_address.h>
> +#include <linux/platform_device.h>
>  #include <linux/syscore_ops.h>
>  #include <dt-bindings/clock/rk3568-cru.h>
>  #include "clk.h"
> diff --git a/drivers/clk/rockchip/clk-rv1126.c b/drivers/clk/rockchip/clk-rv1126.c
> index c18790f5d05b..5c6f1ce34a2f 100644
> --- a/drivers/clk/rockchip/clk-rv1126.c
> +++ b/drivers/clk/rockchip/clk-rv1126.c
> @@ -8,7 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/syscore_ops.h>
>  #include <dt-bindings/clock/rockchip,rv1126-cru.h>
>  #include "clk.h"
> diff --git a/drivers/clk/samsung/clk-exynos-arm64.c b/drivers/clk/samsung/clk-exynos-arm64.c
> index 7d8937caf22a..6fb7194df7ab 100644
> --- a/drivers/clk/samsung/clk-exynos-arm64.c
> +++ b/drivers/clk/samsung/clk-exynos-arm64.c
> @@ -10,7 +10,8 @@
>   */
>  #include <linux/clk.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  
> diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
> index 7626dff41f6f..e44b172d7255 100644
> --- a/drivers/clk/samsung/clk-exynos-audss.c
> +++ b/drivers/clk/samsung/clk-exynos-audss.c
> @@ -10,8 +10,7 @@
>  #include <linux/io.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.c b/drivers/clk/samsung/clk-exynos5-subcmu.c
> index 96d74bc250e5..373129847301 100644
> --- a/drivers/clk/samsung/clk-exynos5-subcmu.c
> +++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
> @@ -5,7 +5,7 @@
>  // Common Clock Framework support for Exynos5 power-domain dependent clocks
>  
>  #include <linux/io.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> diff --git a/drivers/clk/samsung/clk-exynos7885.c b/drivers/clk/samsung/clk-exynos7885.c
> index 0d2a950ed184..0c6a84764f7a 100644
> --- a/drivers/clk/samsung/clk-exynos7885.c
> +++ b/drivers/clk/samsung/clk-exynos7885.c
> @@ -9,7 +9,6 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  #include <dt-bindings/clock/exynos7885.h>
> diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
> index 98b23af7324d..c32b2e6451a0 100644
> --- a/drivers/clk/samsung/clk-exynos850.c
> +++ b/drivers/clk/samsung/clk-exynos850.c
> @@ -9,7 +9,6 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  #include <dt-bindings/clock/exynos850.h>
> diff --git a/drivers/clk/samsung/clk-exynosautov9.c b/drivers/clk/samsung/clk-exynosautov9.c
> index 7b16320bba66..ddef546be545 100644
> --- a/drivers/clk/samsung/clk-exynosautov9.c
> +++ b/drivers/clk/samsung/clk-exynosautov9.c
> @@ -9,8 +9,6 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  #include <dt-bindings/clock/samsung,exynosautov9.h>
> diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
> index 5d009c70e97d..6f984cfcd33c 100644
> --- a/drivers/clk/samsung/clk-fsd.c
> +++ b/drivers/clk/samsung/clk-fsd.c
> @@ -13,8 +13,6 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  #include <dt-bindings/clock/fsd-clk.h>
> diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
> index e317f3454e93..af81eb835bc2 100644
> --- a/drivers/clk/sifive/sifive-prci.c
> +++ b/drivers/clk/sifive/sifive-prci.c
> @@ -7,7 +7,7 @@
>  #include <linux/clkdev.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include "sifive-prci.h"
>  #include "fu540-prci.h"
>  #include "fu740-prci.h"
> diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
> index 74d21bd82710..5c972e4ffa17 100644
> --- a/drivers/clk/socfpga/clk-agilex.c
> +++ b/drivers/clk/socfpga/clk-agilex.c
> @@ -4,8 +4,7 @@
>   */
>  #include <linux/slab.h>
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> -#include <linux/of_address.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  
>  #include <dt-bindings/clock/agilex-clock.h>
> diff --git a/drivers/clk/socfpga/clk-s10.c b/drivers/clk/socfpga/clk-s10.c
> index 9b2e0275fbf7..3752bd9c103c 100644
> --- a/drivers/clk/socfpga/clk-s10.c
> +++ b/drivers/clk/socfpga/clk-s10.c
> @@ -4,8 +4,7 @@
>   */
>  #include <linux/slab.h>
>  #include <linux/clk-provider.h>
> -#include <linux/of_device.h>
> -#include <linux/of_address.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  
>  #include <dt-bindings/clock/stratix10-clock.h>
> diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
> index 9d5959a4251a..0847f5452489 100644
> --- a/drivers/clk/spear/spear1310_clock.c
> +++ b/drivers/clk/spear/spear1310_clock.c
> @@ -12,7 +12,6 @@
>  #include <linux/clk/spear.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> -#include <linux/of_platform.h>
>  #include <linux/spinlock_types.h>
>  #include "clk.h"
>  
> diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
> index 8b51229d0471..361d344bfaf0 100644
> --- a/drivers/clk/spear/spear1340_clock.c
> +++ b/drivers/clk/spear/spear1340_clock.c
> @@ -12,7 +12,6 @@
>  #include <linux/clk/spear.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> -#include <linux/of_platform.h>
>  #include <linux/spinlock_types.h>
>  #include "clk.h"
>  
> diff --git a/drivers/clk/spear/spear3xx_clock.c b/drivers/clk/spear/spear3xx_clock.c
> index ba8791303156..6c0af99b0578 100644
> --- a/drivers/clk/spear/spear3xx_clock.c
> +++ b/drivers/clk/spear/spear3xx_clock.c
> @@ -11,7 +11,7 @@
>  #include <linux/clk/spear.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
>  #include <linux/spinlock_types.h>
>  #include "clk.h"
>  
> diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
> index 16142fbb7a47..762f0961f17f 100644
> --- a/drivers/clk/sprd/common.c
> +++ b/drivers/clk/sprd/common.c
> @@ -8,7 +8,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> -#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
>  #include "common.h"
> diff --git a/drivers/clk/sprd/sc9860-clk.c b/drivers/clk/sprd/sc9860-clk.c
> index f76305b4bc8d..cc5ed2dd8267 100644
> --- a/drivers/clk/sprd/sc9860-clk.c
> +++ b/drivers/clk/sprd/sc9860-clk.c
> @@ -9,7 +9,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> diff --git a/drivers/clk/sprd/ums512-clk.c b/drivers/clk/sprd/ums512-clk.c
> index fc25bdd85e4e..8f4441dd572b 100644
> --- a/drivers/clk/sprd/ums512-clk.c
> +++ b/drivers/clk/sprd/ums512-clk.c
> @@ -9,8 +9,8 @@
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> index 02aefb7264f8..ee4bda14a40e 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> @@ -11,7 +11,6 @@
>  #include <linux/kernel.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  #include <dt-bindings/clock/starfive-jh7100-audio.h>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
> index c19828f1aa0f..451ebb7c99a3 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
> @@ -8,7 +8,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  
>  #include "ccu_common.h"
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> index 001582ea71ba..02b28cfc5525 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> @@ -5,7 +5,7 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  
>  #include "ccu_common.h"
> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> index d65398497d5f..fdc8ccc586c9 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> @@ -5,8 +5,10 @@
>  
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
> +#include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/of_device.h>
>  
>  #include <linux/clk/sunxi-ng.h>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> index b70b312e7483..6a043a0a9dd6 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> @@ -6,7 +6,7 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> index bfebe8dbbe65..74274c17efb3 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> @@ -6,7 +6,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  
>  #include "ccu_common.h"
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
> index 4221649b311f..4890a976b1a0 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
> @@ -5,7 +5,7 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  
>  #include "ccu_common.h"
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> index fbb3529f0d3e..f3ce8664b288 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> @@ -9,7 +9,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  
>  #include "ccu_common.h"
> diff --git a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
> index e4cf1180b088..b0a93b4fb051 100644
> --- a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
> +++ b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
> @@ -10,7 +10,6 @@
>  #include <linux/clk-provider.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  #define SUN6I_APB0_GATES_MAX_SIZE	32
> diff --git a/drivers/clk/sunxi/clk-sun9i-mmc.c b/drivers/clk/sunxi/clk-sun9i-mmc.c
> index 636bcf2439ef..d6831720f977 100644
> --- a/drivers/clk/sunxi/clk-sun9i-mmc.c
> +++ b/drivers/clk/sunxi/clk-sun9i-mmc.c
> @@ -11,7 +11,6 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/reset.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset-controller.h>
> diff --git a/drivers/clk/tegra/clk-device.c b/drivers/clk/tegra/clk-device.c
> index c58beaf8afbc..8c8e2b853a99 100644
> --- a/drivers/clk/tegra/clk-device.c
> +++ b/drivers/clk/tegra/clk-device.c
> @@ -2,8 +2,8 @@
>  
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
> diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> index 2a164e565c86..a9be4b56b2b7 100644
> --- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> +++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> @@ -12,7 +12,7 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <soc/tegra/fuse.h>
> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
> index dcacc5064d33..2c58ce25af75 100644
> --- a/drivers/clk/tegra/clk-tegra20.c
> +++ b/drivers/clk/tegra/clk-tegra20.c
> @@ -9,7 +9,6 @@
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk/tegra.h>
>  #include <linux/delay.h>
> diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
> index 60f1534711f1..82a8cb9545eb 100644
> --- a/drivers/clk/tegra/clk-tegra30.c
> +++ b/drivers/clk/tegra/clk-tegra30.c
> @@ -10,7 +10,6 @@
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk/tegra.h>
>  
> diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
> index 26bda45813c0..333a3ff0db98 100644
> --- a/drivers/clk/tegra/clk.c
> +++ b/drivers/clk/tegra/clk.c
> @@ -9,7 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>  #include <linux/clk/tegra.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
> index a61213311d6c..37b495e68107 100644
> --- a/drivers/clk/uniphier/clk-uniphier-core.c
> +++ b/drivers/clk/uniphier/clk-uniphier-core.c
> @@ -8,7 +8,6 @@
>  #include <linux/init.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  #include "clk-uniphier.h"
> diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_vcu.c
> index 0786f15ebbe8..60a3ed7c7263 100644
> --- a/drivers/clk/xilinx/xlnx_vcu.c
> +++ b/drivers/clk/xilinx/xlnx_vcu.c
> @@ -15,7 +15,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/xlnx-vcu.h>
>  #include <linux/module.h>
> -#include <linux/of_platform.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> index 5636ff1ce552..a91d98e238c2 100644
> --- a/drivers/clk/zynqmp/clkc.c
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -11,7 +11,8 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  
> -- 
> 2.40.1
> 
