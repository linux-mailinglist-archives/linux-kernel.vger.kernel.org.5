Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850E87857ED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjHWMcF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Aug 2023 08:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjHWMcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:32:03 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA373E9;
        Wed, 23 Aug 2023 05:31:57 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-56cae50792fso556699eaf.1;
        Wed, 23 Aug 2023 05:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692793917; x=1693398717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ApOaAU2C11Pn2qOxjg2kIqTJJ7VnWEqUmde/1TenZQ=;
        b=HbLSFAH43YyJbbYXXS/ISjhnvojwIyX6slvWg94dQSOAa3rH2uS42FdLcTSKlixrCM
         RPkgnQlrnSIPwScAwHM51Z4j0g7DFoC2aILVZ7wR/PVLWb+djoPBmubnaWLhmXg15x9l
         hZOeR08y2O9oNGvml0MEwRwCWA/S64cPy6g8CeFAPzInJj2OBm0Wjzpo4i26KRCqdmOa
         u3LciQ2WrvThH19spCzdu0NI93iWLR6XTZ+Wi59l0dOQh/vrJSK9lYjKDiC1eRoM/ngl
         LXaulvMIFuxxa4pCp4QQ0el2fNEJ6SwNR1Wf18o65artX3cCCWEjk1T6jX4YB1QboqBH
         eG6w==
X-Gm-Message-State: AOJu0Yy9Hfaj7zk3hn9obuwFZZjSFDCdADn+WayGedmU6K3dUlOls0iw
        b4FX+u/TRJojWLCprfyp/BKfQ2p7nT7C2ORDHq4=
X-Google-Smtp-Source: AGHT+IHhMwKmKIBwwvi/YmGkSAgu5efCUMytt4QejM22SViosU4j5VAi4fORzp0+24y420UMM8bLIkI7yh9A1hX+wbo=
X-Received: by 2002:a4a:e741:0:b0:56e:94ed:c098 with SMTP id
 n1-20020a4ae741000000b0056e94edc098mr12003584oov.0.1692793917062; Wed, 23 Aug
 2023 05:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230714175008.4064592-1-robh@kernel.org> <CAJZ5v0i-OByOSjpxrj5d9S9QHRySK-MEUo+bK_J_4ihsCBmnSg@mail.gmail.com>
 <CAL_JsqLy22S5bTFu-ZKXhSMtMPPq9z1Gdb5kJMVmhui55miDsQ@mail.gmail.com>
 <CAJZ5v0hM63nVphwkYK1bL4uf_dXSew2+LBuG9kuhvvLdrhLxAw@mail.gmail.com> <CAL_JsqJGoDPLKgu8awJfuWpqzg8HOuruDa1z4s-Swb7Cm5OaJw@mail.gmail.com>
In-Reply-To: <CAL_JsqJGoDPLKgu8awJfuWpqzg8HOuruDa1z4s-Swb7Cm5OaJw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Aug 2023 14:31:44 +0200
Message-ID: <CAJZ5v0j2psZUYF1gYTK3G=+MdrLOg1QhOxENhSvWbvGcjzLizg@mail.gmail.com>
Subject: Re: [PATCH] thermal: Explicitly include correct DT includes
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:38 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jul 20, 2023 at 1:50 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Jul 14, 2023 at 9:53 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Jul 14, 2023 at 12:54 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Fri, Jul 14, 2023 at 7:51 PM Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > The DT of_device.h and of_platform.h date back to the separate
> > > > > of_platform_bus_type before it as merged into the regular platform bus.
> > > > > As part of that merge prepping Arm DT support 13 years ago, they
> > > > > "temporarily" include each other. They also include platform_device.h
> > > > > and of.h. As a result, there's a pretty much random mix of those include
> > > > > files used throughout the tree. In order to detangle these headers and
> > > > > replace the implicit includes with struct declarations, users need to
> > > > > explicitly include the correct includes.
> > > > >
> > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > >
> > > > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> > > >
> > > > or please let me know if you want me to pick this up.
> > >
> > > Single patch in your subsystem with no dependencies. Please pick it up.
> >
> > Done, thanks!
>
> I'm not seeing this in linux-next.

f6a756e8fb12 thermal: Explicitly include correct DT includes

It's there in my linux-next branch (and in my thermal branch) and it
should be there in linux-next too.
