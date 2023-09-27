Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2E77B0F29
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjI0W5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0W5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:57:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D52AF;
        Wed, 27 Sep 2023 15:57:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53C9C433C7;
        Wed, 27 Sep 2023 22:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695855467;
        bh=U6mvGN6IUsN3aQ3Mg+rtFDHole4TLUqxeXU4RuqCc9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BghfInz1dtGj+a0NwGrQpQyiHTPQFE7pGKytrpsBClpu9NX2eDcjSChVYZmAF6XDB
         owkxfj0jdteMSoWlG/cGItYI7rwQRUHp8gvgTfu6LqVuG2Ju3NmaLW+PzihWROGETC
         8im2c1V6bhHXdTgg2FyeVqoOoGl2C9rGCm7cO+QnD4KASaYNOMS1b5kWe3RD3hlBwa
         8K94UVok49+wD2jCK35a7ooWNY6CyXEsRolTaaTlHbmMq6gapMGZ2q5sD3ePlXHOQS
         huIRK9HVFU8DWh9mV8DVS8hYOkca+rRCVDtybY9i3VxzNc3SAJ8sCy+Qm1xR/Ceo4m
         4kcCfJF20jzJQ==
Date:   Wed, 27 Sep 2023 16:01:58 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Joel Stanley <joel@jms.id.au>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Leo Li <leoyang.li@nxp.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Huisong Li <lihuisong@huawei.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        "zhang.songyi" <zhang.songyi@zte.com.cn>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Nick Alcock <nick.alcock@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 00/40] soc: Convert to platform remove callback returning
 void
Message-ID: <f4hvrslynlgmxu4a2gogc5idvumskhaalxgwildy56yqk2wz7d@lkh4swkv52mi>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
 <CACPK8XeROYz_XaB3TvUhdXm7Vm8fjC8yU+mfvA58=_FiDrBy-g@mail.gmail.com>
 <1b2fddf8-c0a6-4afa-8ad0-f280dea1607f@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b2fddf8-c0a6-4afa-8ad0-f280dea1607f@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:43:16AM +0200, Arnd Bergmann wrote:
> On Wed, Sep 27, 2023, at 04:25, Joel Stanley wrote:
> > On Mon, 25 Sept 2023 at 09:55, Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> >>
> >> this series converts all platform drivers below drivers/soc to use
> >> .remove_new(). The motivation is to get rid of an integer return code
> >> that is (mostly) ignored by the platform driver core and error prone on
> >> the driver side.
> >>
> >> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> >> returns no value") for an extended explanation and the eventual goal.
> >>
> >> As there is no single maintainer team for drivers/soc, I suggest the
> >> individual maintainers to pick up "their" patches.
> >
> > I'd be happy if Arnd merged the lot at once. Arnd, what do you think?
> >
> > If that will be too messy then I understand. I have queued the aspeed
> > ones locally and will push that out if we decide that's the best way
> > to go.
> 
> The main downside of merging it all at once through the soc tree
> is that there may be patches that conflict with other work going on
> in individual drivers.
> 
> What I'd suggest doing here is:
> 
> - have platform maintainers pick up patches for their drivers
>   if that is their preference for any reason
> 

I'd prefer this for the qcom drivers at least, please let me know if you
would like me to proceed.

Regards,
Bjorn

> - get a pull request from Uwe for the soc tree for anything that has
>   not been picked up in one or two weeks from now
> 
>       Arnd
