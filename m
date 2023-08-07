Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09400771CAD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjHGIzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjHGIzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:55:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1689C10FD;
        Mon,  7 Aug 2023 01:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F4D9616AF;
        Mon,  7 Aug 2023 08:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F572C433C9;
        Mon,  7 Aug 2023 08:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691398547;
        bh=aNHge0yiOY/VAZNLBKBPp6ymBzs24Uuzx4hIU+sZ4Bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dv+bBEYxfrdjDt9exFHQnOm6yz2T0hfWEHmoB1ikclVu9UGCPJYDihDTBaJahEkWI
         TeBoB5SYhh0IftBkmwAeos3ClYRh6utWZq47Ff6uM8Jp94/MB/DRtdhrbCaEyrpuvr
         q491IdUyRkqrYES0o/eP6ms+oz260Ji9EUZMx6ylmXyneOCwE8vUCMdFfn8grI8XKV
         DBkuE9pFnMNoq9aBgwSffrej09PrYPtF+EPKP+xloM2uHCdGRdxtQgUmIGoBqQbts3
         J+ZgzHNmdYDVpRah/Fc9Z0YyRlKRcZUpHmDkXsjUkg3iGlyBFk6yJKZf+shx4eZHQR
         +BQmY7Jqi1elA==
Date:   Mon, 7 Aug 2023 10:55:43 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Iskren Chernev <me@iskren.info>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stefan Hansson <newbie13xd@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 4/4] ARM: configs: s5pv210_defconfig: enable IIO
 required by MAX17040
Message-ID: <20230807085543.3tfzpsa2joolay3r@intel.intel>
References: <20230731073613.10394-1-clamor95@gmail.com>
 <20230731073613.10394-5-clamor95@gmail.com>
 <20230805224211.qquexvseq24hxcju@intel.intel>
 <16047849-1001-4d6f-4995-0fdfc065cded@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16047849-1001-4d6f-4995-0fdfc065cded@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 06, 2023 at 10:29:04AM +0200, Krzysztof Kozlowski wrote:
> On 06/08/2023 00:42, Andi Shyti wrote:
> > Hi Svyatoslav,
> > 
> > On Mon, Jul 31, 2023 at 10:36:13AM +0300, Svyatoslav Ryhel wrote:
> >> After adding support for passing temperature data from thermal sensor
> >> to MAX17040 it got dependency on CONFIG_IIO. From all defconfigs
> >> using MAX17040 only s5pv210_defconfig did not have IIO already enabled
> >> so let's enable it to avoid regression.
> >>
> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> ---
> >>  arch/arm/configs/s5pv210_defconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
> >> index 4c1e480b5bbd..24070ee3d43e 100644
> >> --- a/arch/arm/configs/s5pv210_defconfig
> >> +++ b/arch/arm/configs/s5pv210_defconfig
> >> @@ -97,6 +97,7 @@ CONFIG_MMC_SDHCI_S3C_DMA=y
> >>  CONFIG_RTC_CLASS=y
> >>  CONFIG_RTC_DRV_MAX8998=m
> >>  CONFIG_DMADEVICES=y
> >> +CONFIG_IIO=y
> >>  CONFIG_PWM=y
> >>  CONFIG_PWM_SAMSUNG=y
> >>  CONFIG_PHY_SAMSUNG_USB2=m
> > 
> > Should this patch be squashed to the previous patch? I think you
> > break bisectability for this board if you enable iio only here.
> 
> The defconfig change matters less - distros don't use them - so this
> points to the fact that patchset affected the users. All existing users
> of max17040 drivers, who do not enable IIO, will have their setups broken.

That's why I'm suggesting to squash this patch with the previous.

Anyway, up to you... except of this note everything looks fine in
the series.

Andi
