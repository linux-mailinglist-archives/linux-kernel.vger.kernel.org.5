Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2817761E0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjHIN62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjHIN61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:58:27 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93AA98;
        Wed,  9 Aug 2023 06:58:24 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qTjgu-0007Qm-Nw; Wed, 09 Aug 2023 15:57:36 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Daniel Mack <daniel@zonque.org>, Jay Fang <f.fangjian@huawei.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Rob Herring <robh@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>, soc@kernel.org,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Patrick Venture <venture@google.com>,
        Michal Simek <michal.simek@amd.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Avi Fishman <avifishman70@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nancy Yuen <yuenn@google.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Shiraz Has him <shiraz.linux.kernel@gmail.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Chen-Yu Tsai <wens@csie.org>,
        Antoine Tenart <atenart@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <treding@nvidia.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-sunxi@lists.linux.dev, openbmc@lists.ozlabs.org,
        linux-aspeed@lists.ozlabs.org
Subject: Re: (subset) [PATCH v2 00/23] ARM: DT include cleanups
Date:   Wed,  9 Aug 2023 15:57:33 +0200
Message-Id: <169158939237.3288791.15504684466280859190.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2023 16:42:40 -0600, Rob Herring wrote:
> Arnd, This is all the remaining ARM and SoC related patches of DT
> include cleanups which have not be applied by sub-arch maintainers.
> 
> A few of these are v2, but most are just resends of v1.
> 
> 

Applied, thanks!

I didn't find a reply to the thread in terms of it going
in alltogether, so went forward and picked the Rockchip things
I missed before.


[12/23] ARM: rockchip: Drop unused includes
        commit: 8cbdf5d2880923070198c240534f4cca3e04dfb1
[20/23] soc: rockchip: Explicitly include correct DT includes
        commit: fc7696e2ae81404c6ca176e7ebbddd4b19c40953

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
