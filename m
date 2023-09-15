Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476CE7A1A43
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjIOJVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjIOJVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:21:00 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B7DCED
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:20:54 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso29931431fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769653; x=1695374453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRN1XdzJacU86KA2sgdtoR/fhwi3XR+ap0UjyCz9bgI=;
        b=YcuLTXE7msm3oCVyi5adsNaScAhv5rP90E3A82dW6i6t7aErb5pESFWOkcw35eYmX/
         D3PVowhEo813Swg9xcUX0UsICSst0TB1NAVl0SXtAGMg10wsPKztDM/UhmDP16FPuG5T
         09wNPc45MMp6DivbrQM+OESFoUOVALajJiHAJZfMXzE9jM4kCyJOqZkhsCWfUYnAwxmM
         oAe7XO4UsMf/BVdVH8daRolybx7IIdsmcJNKeyTtFUOg9bdhRaYlg9omQMpXEYh0msG+
         YAg571VBsOd7E3GgOlnSpZrrvsmur/LZ4oByGxljZKc2ILLMWXtb3vJhjfUlnq/hDfav
         Fhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769653; x=1695374453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRN1XdzJacU86KA2sgdtoR/fhwi3XR+ap0UjyCz9bgI=;
        b=pXtcMKJjlD7eK1X/qnIOJn2cEmbU97wcd+TwG3OQ59ASkG19XPA5yBaVeEZXC+vE7N
         LIuG0r0Hkq1EX6ro1H/5v6KAtWQX0/ESS4Tgf672DibIlDOKHr24MLWM+whmbGKZF6GF
         s+jCmXvFV3Wf4gcrE5XtNUroaxP5A/16uVSLzmTwQeiCrXY3faOxPgwfDX4KRhrs6sVG
         S2cmhZb7yn+OFkJZU61xiWbjaxj4xHTe3HiDgnk5XtAvQ5YIhJp+hvmxcXCAIg3g/oI2
         WzHyl08SfXQz95xDS4UW4l47MSeerUlsxcf2MulI3eKXKXHEiK2Nk4BUSO8zbSKToLsn
         0Cjw==
X-Gm-Message-State: AOJu0YyCSlUEu2HZDl1LNi/OOZSA5VGK2Gk7xwbRG+1KRJpU+Rn1XGlK
        xgqMfze5jKO4fdvNFNwcSWQ/zSWFv/MzB9XLk+7eh0RK
X-Google-Smtp-Source: AGHT+IFPBeirKxDCzno2Ml5PSyGJnKmUqqzDn0PD9t+Uea0lh+TBbyvdIMfgMmMwXrBvSOj4FGCg1A==
X-Received: by 2002:a2e:8545:0:b0:2bf:d068:d926 with SMTP id u5-20020a2e8545000000b002bfd068d926mr1149971ljj.41.1694769652086;
        Fri, 15 Sep 2023 02:20:52 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:20:51 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
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
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 00/17] pmdomain: Move Kconfig options/files to the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:19:46 +0200
Message-Id: <20230915092003.658361-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
	- Posted as a proper series, I screwed up last time.
	- Fixed bug in patch1, according to comments from Geert.
	- Moved to use "PM domains" in menus/submenus.
	- Updated MAINTAINERS for starfive, according comments from Conor/Walker.
	- Added some tags.

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

 MAINTAINERS                                |   5 +-
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
 36 files changed, 415 insertions(+), 338 deletions(-)
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

