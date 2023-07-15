Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE5C7547F8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjGOJ0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGOJ0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:26:52 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A156B2D75;
        Sat, 15 Jul 2023 02:26:50 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1ba4460f0a4so1016438fac.0;
        Sat, 15 Jul 2023 02:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689413210; x=1692005210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHphB4LnIXM8B5KTzxaE1knTLhvmv4UUsDUmEXJtUjc=;
        b=KNtkg40Donc1RJ+Y/N6bMmujMSl9cywEa6fXVSQYqV4W4lT8G1IFlO5DKCTqezy9NY
         lefwY54PRhNWProidCgY7SJny7AEfavu3g+BjFgAL5dZzNMIElbAwgo4QZnm4OLwjy+V
         CVJWSo1L7gWOhYkpGKP0r9oukax6+UlfkfofBx8xxPcLUf3ek7zbTjABn/JHDdvTWXCu
         WWDX31kpkxyfmd7Q/WE+0i7y3grMAoIl2p8ABV+V0g6ZwAueUBzPNbjvXwLF4/1Voo58
         THpoQ4ecU8W2lHElPdLC420Acx2PDSK/3KkrYlQGhj1Cbwmy3bV4wSFCbbKfSoIqtJyV
         8cKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689413210; x=1692005210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHphB4LnIXM8B5KTzxaE1knTLhvmv4UUsDUmEXJtUjc=;
        b=JiGU52lQ8FfyJkp6QjJQSRzyHbk7kqyAUFscruPUEYIw7RNWvZZ21NHMBrIeQbhqD1
         6GtMln/NTVUZw49joEErfXV/f6tgMdbGdAZnOfAP2YKB4uuCv6bIGP4HTyjTqlGjSoac
         grXLh0eefJph+lUq1Z4xoT1vHI8tR8OZP223JRtIXP5ozuQBw1UGNmT266Qc7uFcqybh
         vajWY4OVbOaEcuuvLzlH5too7GCT7CssvOXAt81dSvNxxrimlcQBf3SlZbhnQKh3/LCx
         DHTC23/Jwgn4onqFXjA+V5CvyStnfidFSV8/OCeIFgGH00MADcc+bbkWEbELFNACTjkj
         NYRA==
X-Gm-Message-State: ABy/qLaY+efmPdXrwZqHx79HVnpLXMlNT08ZV5WWBpmQIssnVrzkVTFm
        vcyCdAU0RNP7yc8sKOtjzkCWTdpLZNeNCQprWPM=
X-Google-Smtp-Source: APBJJlGwdJmxyzGjSGIAgoqFi7CGlWiMJBmcsPBzo9lxW5BLyYxxPOYfHlixbBaupkZxkAV8b0mEWpZJ8j8VMX6oWRI=
X-Received: by 2002:a05:6870:328d:b0:177:a158:9ef6 with SMTP id
 q13-20020a056870328d00b00177a1589ef6mr6679986oac.52.1689413209848; Sat, 15
 Jul 2023 02:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230714174841.4061919-1-robh@kernel.org>
In-Reply-To: <20230714174841.4061919-1-robh@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 15 Jul 2023 11:26:38 +0200
Message-ID: <CAMhs-H-6tAV-+U-4zZDKs47eKCJr+kZ-Op8vR4SyJyE5LK_2aw@mail.gmail.com>
Subject: Re: [PATCH] phy: Explicitly include correct DT includes
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Justin Chen <justin.chen@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Yu Chen <chenyu56@huawei.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Alban Bedel <albeu@free.fr>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-can@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 7:49=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/phy/ralink/phy-mt7621-pci.c                   | 3 +--

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
