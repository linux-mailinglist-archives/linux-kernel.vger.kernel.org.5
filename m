Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5D178C386
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjH2LmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjH2Llv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:41:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0700109
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 365C461F7D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625D8C433C8;
        Tue, 29 Aug 2023 11:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693309307;
        bh=ymfDnb1wNojQ0jGjJUgnVBim6gA/rLm0coxCCDMJGWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QhbD38kB5M9zVuy7OYjG0Q92tnvjC1HsMMr4zWzHR20mIk43cpLQPVNCiEx+Dji0Z
         lnk14D7A/Fnrxy3UGN9ZDQr7KGesf5cAhrjbwc52kxErnmrtslx2XIDoZzvX3lqkRL
         fcdD1UB35h4syD44cYE5LWl4hHf+RH0HPd0Km043uN6R4f1iZimUyC6sneECVGll4b
         e2O2k/izNe2/d4aispw15Y8mwBX45y3P7OneCy/p75qJo3E50Cs7rAUP5pMmvUrQLH
         QoY6/X7DgEpVX6jP8aGzNPHSchPj2DnCfFE4S3bs8KLmH6LDsxmKke+lrS1hx54VKb
         hjrdGbW4mKftg==
Date:   Tue, 29 Aug 2023 19:29:52 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 00/22] convert to devm_stmmac_probe_config_dt
Message-ID: <ZO3WsHH1GDWdcLAU@xhacker>
References: <20230829104033.955-1-jszhang@kernel.org>
 <ZO3UuY9jKz8VenGA@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZO3UuY9jKz8VenGA@shell.armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 12:21:29PM +0100, Russell King (Oracle) wrote:
> On Tue, Aug 29, 2023 at 06:40:11PM +0800, Jisheng Zhang wrote:
> > Russell pointed out there's a new devm_stmmac_probe_config_dt()
> > helper now when reviewing my starfive gmac error handling patch[1].
> > After greping the code, this nice helper was introduced by Bartosz in
> > [2], I think it's time to convert all dwmac users to this helper and
> > finally complete the TODO in [2] "but once all users of the old
> > stmmac_pltfr_remove() are converted to the devres helper, it will be
> > renamed back to stmmac_pltfr_remove() and the no_dt function removed."
> 
> I think a useful final patch may be to make stmmac_probe_config_dt()
> static so there aren't any new uses of stmmac_probe_config_dt().

Good idea!
> 
> Also note that net-next is now closed, so please wait until after -rc1
> for net-next to re-open, or post as RFC. Thanks.

oops, I didn't notice this cycle of window is closed, I will wait for next
development window.

Thank you
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
