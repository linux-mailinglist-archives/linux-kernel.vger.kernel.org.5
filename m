Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DD17A0236
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjINLPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINLPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:15:50 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA941FC9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:15:46 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b703a0453fso12973751fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690144; x=1695294944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gzE1xt1UAc3po3dWiOSU5lTtw+EXYGxz3mz1wJE3HBQ=;
        b=OqcT+919fW9qJI5PbffBEAxN/r27PT+8+mUqybL+hgR41opi+eURCmBRd875WNWYau
         SBnjoRGhsBpBM27I2ibiWrgHo/qViVpCorAOqDbC2rcLDyzBm8JT+kNfKw1fJ/KJ2g0x
         9/MUOO8Ieb6j2zI96/1RCbWIwpkn3Jixt2o4/xSclvIg45HaiqnckHcUl+6Knoz2f4E0
         4DEM2HcJYQkb/8GBrNp/NY/U3mXP7ICsih+kn0era65jlsFu+ica1qZ6AQZ3EruNhZ9h
         sZ4yXTJCMiRdwj7hcdcIl9LT/kJYK6EITL8AyKvQj75z9YN6hTv20b3uIsXtrN8pqzVQ
         PuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690144; x=1695294944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzE1xt1UAc3po3dWiOSU5lTtw+EXYGxz3mz1wJE3HBQ=;
        b=nVde7mG0wu5wn2/uKqCC6GRbJjYG1QE9zpsu5XCcOGersdivuQelHKqlInMjcF1dIs
         S9o779umlJ8B/gZPQjEaEvujdDvegzyBx74kL/5jnZxH+hnn7Z/nsgu4ZeDUClhWlyBB
         YQbZAF7Oi86lBGiOMAWtOxKEkRiFP9PC3n8NiHxqkuFKE96Ijv5ICHlSTaqVGPyWX5mj
         2+3+ewaFv7EsU+ykJ4OyewRSGXtEhAnaoDU8MoqZe/4SMnzpZQ76WSGFVXzess6jnKfC
         oA6JWoMhw/fE4Kl7DOrTcijgqaWFtO8ncchW+xxrel7zjzYeL1D9HVhKoyVQ4SSfEBNs
         SFRQ==
X-Gm-Message-State: AOJu0YwsefgEZInI/riHz/TJPzfUavbXWY8pTjJnEnR3Glmgs1GVLATP
        LdcI8xkURK9mTrQMZuud44TKnA==
X-Google-Smtp-Source: AGHT+IFrBiYjOlea2kd9kb+iMjELbn9Wk4OW2mFSrduXUIuoK1ikB3rZCDxxmDHUihe0dYvLiIO/Mg==
X-Received: by 2002:a05:6512:3115:b0:500:b5db:990c with SMTP id n21-20020a056512311500b00500b5db990cmr3752849lfb.57.1694690144110;
        Thu, 14 Sep 2023 04:15:44 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b005009d9c6bf0sm234605lfl.207.2023.09.14.04.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:15:43 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andreas Farber <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/17] pmdomain: Move Kconfig options/files to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:15:26 +0200
Message-Id: <20230914111526.586400-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we added a new subsystem to host pmdomain (genpd) providers and moved
a bunch of code for them in there. However, their corresponding Kconfig
options/files was not moved in that first step, but instead that is taken care
of in this series. Ideally it should be easier to keep Kconfig options closer
to their corresponding implementations.

Note that, I am planning to queue this up via my pmdomain tree [1] as soon as I
have received enough of reviewed/acked-by tags from soc maintainers. If you
have reasons to belive that this can be problem, due to conflicts etc, please
let me know so we can figure out a way forward.

Kind regards
Uffe

[1]
git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git next

Ulf Hansson (17):
  pmdomain: Prepare to move Kconfig files into the pmdomain subsystem
  pmdomain: actions: Move Kconfig file to the pmdomain subsystem
  pmdomain: amlogic: Move Kconfig options to the pmdomain subsystem
  pmdomain: apple: Move Kconfig option to the pmdomain subsystem
  pmdomain: bcm: Move Kconfig options to the pmdomain subsystem
  pmdomain: imx: Move Kconfig options to the pmdomain subsystem
  pmdomain: mediatek: Move Kconfig options to the pmdomain subsystem
  pmdomain: qcom: Move Kconfig options to the pmdomain subsystem
  pmdomain: renesas: Move Kconfig options to the pmdomain subsystem
  pmdomain: rockchip: Move Kconfig option to the pmdomain subsystem
  pmdomain: samsung: Move Kconfig option to the pmdomain subsystem
  pmdomain: st: Add a Kconfig option for the ux500 power domain
  pmdomain: starfive: Move Kconfig file to the pmdomain subsystem
  pmdomain: sunxi: Move Kconfig option to the pmdomain subsystem
  pmdomain: tegra: Move Kconfig option to the pmdomain subsystem
  pmdomain: ti: Move and add Kconfig options to the pmdomain subsystem
  pmdomain: xilinx: Move Kconfig option to the pmdomain subsystem

 MAINTAINERS                                |   4 +-
 drivers/Kconfig                            |   2 +
 drivers/firmware/imx/Kconfig               |   6 --
 drivers/pmdomain/Kconfig                   |  21 ++++
 drivers/{soc => pmdomain}/actions/Kconfig  |   0
 drivers/pmdomain/amlogic/Kconfig           |  39 ++++++++
 drivers/pmdomain/apple/Kconfig             |  18 ++++
 drivers/pmdomain/bcm/Kconfig               |  46 +++++++++
 drivers/pmdomain/imx/Kconfig               |  29 ++++++
 drivers/pmdomain/mediatek/Kconfig          |  29 ++++++
 drivers/pmdomain/qcom/Kconfig              |  41 ++++++++
 drivers/pmdomain/renesas/Kconfig           | 109 +++++++++++++++++++++
 drivers/pmdomain/rockchip/Kconfig          |  16 +++
 drivers/pmdomain/samsung/Kconfig           |   8 ++
 drivers/pmdomain/st/Kconfig                |   5 +
 drivers/pmdomain/st/Makefile               |   2 +-
 drivers/{soc => pmdomain}/starfive/Kconfig |   0
 drivers/pmdomain/sunxi/Kconfig             |  10 ++
 drivers/pmdomain/tegra/Kconfig             |   6 ++
 drivers/pmdomain/ti/Kconfig                |  22 +++++
 drivers/pmdomain/ti/Makefile               |   2 +-
 drivers/pmdomain/xilinx/Kconfig            |  10 ++
 drivers/soc/Kconfig                        |   2 -
 drivers/soc/amlogic/Kconfig                |  35 -------
 drivers/soc/apple/Kconfig                  |  13 ---
 drivers/soc/bcm/Kconfig                    |  42 --------
 drivers/soc/imx/Kconfig                    |  19 ----
 drivers/soc/mediatek/Kconfig               |  23 -----
 drivers/soc/qcom/Kconfig                   |  37 -------
 drivers/soc/renesas/Kconfig                | 105 --------------------
 drivers/soc/rockchip/Kconfig               |  12 ---
 drivers/soc/samsung/Kconfig                |   4 -
 drivers/soc/sunxi/Kconfig                  |   9 --
 drivers/soc/tegra/Kconfig                  |   5 -
 drivers/soc/ti/Kconfig                     |  12 ---
 drivers/soc/xilinx/Kconfig                 |   9 --
 36 files changed, 415 insertions(+), 337 deletions(-)
 create mode 100644 drivers/pmdomain/Kconfig
 rename drivers/{soc => pmdomain}/actions/Kconfig (100%)
 create mode 100644 drivers/pmdomain/amlogic/Kconfig
 create mode 100644 drivers/pmdomain/apple/Kconfig
 create mode 100644 drivers/pmdomain/bcm/Kconfig
 create mode 100644 drivers/pmdomain/imx/Kconfig
 create mode 100644 drivers/pmdomain/mediatek/Kconfig
 create mode 100644 drivers/pmdomain/qcom/Kconfig
 create mode 100644 drivers/pmdomain/renesas/Kconfig
 create mode 100644 drivers/pmdomain/rockchip/Kconfig
 create mode 100644 drivers/pmdomain/samsung/Kconfig
 create mode 100644 drivers/pmdomain/st/Kconfig
 rename drivers/{soc => pmdomain}/starfive/Kconfig (100%)
 create mode 100644 drivers/pmdomain/sunxi/Kconfig
 create mode 100644 drivers/pmdomain/tegra/Kconfig
 create mode 100644 drivers/pmdomain/ti/Kconfig
 create mode 100644 drivers/pmdomain/xilinx/Kconfig

-- 
2.34.1

