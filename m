Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD5A754375
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbjGNTxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGNTxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:53:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E2D2D57;
        Fri, 14 Jul 2023 12:53:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89FDB61DE3;
        Fri, 14 Jul 2023 19:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1AAC43397;
        Fri, 14 Jul 2023 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689364392;
        bh=DnEjVGiuXfP3swFolvK4a+TN59hjw2gEVcLZQUXBvDY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FXKiP07/uyYnn3J52Pv/xGbI+H0dryvs1yPK9kNiAMLZ37UglPGpr5hwF8t9AgGFR
         MbIgF/qFjKJ0zZE4JovQWRruybyKuF8xDZ1GJGD2TnPr5JS687MRuqJUXrlRbe9upM
         awQsA1ywU6bfbkYq1156RNRo6klGk5DtuE3hAs5Dr7gqosk7Nnh0v9e1sSdKlaFjI8
         +26/qgf8uY+Bn785pgvNo3KxQ6je6+toUywNN7cX9E+dIlZMUc5naKyO1BPxRYk8VC
         jGYUIPR3evafAcz/Wcra6MNLR45SJWOMsDsqQ2XDSbumIY7WxofkDLNV3q2ai3RKXC
         iR2h6K4R4H+Ww==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so3872508e87.2;
        Fri, 14 Jul 2023 12:53:11 -0700 (PDT)
X-Gm-Message-State: ABy/qLbJMWbxAhbaUBKgPpELt8dPXaa8xqUmIDrdAlujMEGhiY9ODESO
        4nMnqD00Pn9OOP6yh/NibeJPQ/EtEFQCKT+40Q==
X-Google-Smtp-Source: APBJJlFIVq6SSfDGp/7zlzMmel1HUM1zDWT3EoUpkE1rCFI61SUoU0+rrNxJc3PIb6p4Jh4x1E4RyP9tWO4eKUbbP0E=
X-Received: by 2002:a2e:9a8a:0:b0:2b4:765b:f6ee with SMTP id
 p10-20020a2e9a8a000000b002b4765bf6eemr4915096lji.41.1689364389871; Fri, 14
 Jul 2023 12:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230714175008.4064592-1-robh@kernel.org> <CAJZ5v0i-OByOSjpxrj5d9S9QHRySK-MEUo+bK_J_4ihsCBmnSg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i-OByOSjpxrj5d9S9QHRySK-MEUo+bK_J_4ihsCBmnSg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 14 Jul 2023 13:52:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLy22S5bTFu-ZKXhSMtMPPq9z1Gdb5kJMVmhui55miDsQ@mail.gmail.com>
Message-ID: <CAL_JsqLy22S5bTFu-ZKXhSMtMPPq9z1Gdb5kJMVmhui55miDsQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: Explicitly include correct DT includes
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:54=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Fri, Jul 14, 2023 at 7:51=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it as merged into the regular platform bus.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those includ=
e
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
>
> or please let me know if you want me to pick this up.

Single patch in your subsystem with no dependencies. Please pick it up.

Rob
