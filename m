Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3B7622D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjGYT7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjGYT7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:59:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93449122;
        Tue, 25 Jul 2023 12:59:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29A95618DF;
        Tue, 25 Jul 2023 19:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82604C4167D;
        Tue, 25 Jul 2023 19:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690315169;
        bh=jVkGbzOh79AEXIeMVY1s/WgLpPOOReQVmsy9pu11HgA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RK+5U9OHGM5kVctFC0fXVoH/MPRkxl3yqjH0JkiqY14J62a84cAuHHldU+QJmZwJw
         m+XqPzyLakTqHV2HXVcWKWGF1mJiOi483ksql83UAjacp2W+449PAc1Gy7ne7EwyeR
         MsoU56g+i2jjsXGJeJINbc52BCaV8HU0tYJJ7er833v7XkogTWiQi1fNS2kICYDa74
         P8CPb6B9Topo5JelE0Q1Pj/c79T5XDlopvnCrd/HqoNTziMh4A4pI0EHt0afJyJ7vk
         ha8zpcp3YQiQ9ilYgEvI8y/bppIY1jkW6W5qaFxm4Z0AGFxqSgeeGZwG6UB78Vkakt
         mzVNJZl4/0d6w==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b74fa5e7d7so86559981fa.2;
        Tue, 25 Jul 2023 12:59:29 -0700 (PDT)
X-Gm-Message-State: ABy/qLbI9Y5P+8UuUMiQS5vzxtUz9KqZZjgFLvu9EGq2SorJqdtBXn4t
        LKHbvRFikbW9zfYVyMFFWmvhSHIWureFQRetTg==
X-Google-Smtp-Source: APBJJlFwGjXaJCJydGIeGV4iVYCIq6ysqPH1CxKSwb/h2lZDdMtrrV65McGRvNB57SLo+rUN/j76IhUhQXfq96gAGDg=
X-Received: by 2002:a2e:8786:0:b0:2b6:dd26:c02a with SMTP id
 n6-20020a2e8786000000b002b6dd26c02amr8693672lji.14.1690315146580; Tue, 25 Jul
 2023 12:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230724212222.809909-1-robh@kernel.org> <ZMAD25Yp6gCNq+wH@corigine.com>
In-Reply-To: <ZMAD25Yp6gCNq+wH@corigine.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Jul 2023 13:58:54 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+UYF79tUWvHh=5AfrERJPvFRaV4vh1mnbYn_nNjOQTcw@mail.gmail.com>
Message-ID: <CAL_Jsq+UYF79tUWvHh=5AfrERJPvFRaV4vh1mnbYn_nNjOQTcw@mail.gmail.com>
Subject: Re: [PATCH v2] net: Explicitly include correct DT includes
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Andreas Larsson <andreas@gaisler.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Chris Snook <chris.snook@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Douglas Miller <dougmill@linux.ibm.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Taras Chorny i <taras.chornyi@plvision.eu>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Timur Tabi <timur@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Kevin Brace <kevinbrace@bracecomputerlab.com>,
        Francois Romieu <romieu@fr.zoreil.com>,
        Michal Simek <michal.simek@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alex Elder <elder@kernel.org>, A ndrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Alex Elder <elder@linaro.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-amlogic@lists.infradead.org, linux-oxnas@groups.io,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:18=E2=80=AFAM Simon Horman <simon.horman@corigin=
e.com> wrote:
>
> On Mon, Jul 24, 2023 at 03:22:16PM -0600, Rob Herring wrote:
>
> ...
>
> >  90 files changed, 88 insertions(+), 92 deletions(-)
>
> Hi Rob,
>
> I suppose that it's reasonable to take this patch through netdev.
> But it does have a pretty wide surface, and netdev moves a lot.
>
> As it stands the patch doesn't apply due to a conflict
> in dwmac-qcom-ethqos.c

It did yesterday... Anyways, looks like 0-day decided to find something els=
e.

Rob
