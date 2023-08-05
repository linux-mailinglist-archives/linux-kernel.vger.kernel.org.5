Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C447712E5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 00:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjHEWmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 18:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHEWmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 18:42:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB39419B5;
        Sat,  5 Aug 2023 15:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C99060F56;
        Sat,  5 Aug 2023 22:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF00C433C8;
        Sat,  5 Aug 2023 22:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691275334;
        bh=S9ambU9me0v0ysiaY4bk6weuRQD3P8ZIqAGkkWc9ffM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oW+/8bsZgVp67NaOI0KBNzJT/6iEgiCOK1PJn998V9MU45RyaybWm7pYG5kGjmNXm
         sNukLnuOqaf/WP8M2acAK5ZL2xNQLrW+38oSgm7bO3gg3Vb9FPu6Eheawzz2GPQB0j
         gWJoiD3tW0GH5C9ntJHGb71y9lmZNlgMWcKrJwkG1ZVJWrEvIs+Y0+4WDlwSjITjuh
         9EVHBh0/UqIrp2feHZggC90bJdlFpjfHnu4xK3drJku+dcibtCe5jtbARtzY9n4VfH
         qiQfvITr46S/xcZJpOsukFF/KUD7ojhr0G+O3XctWCBEQ+Xm/izCxiBowt5LJicsgQ
         4HJAM493Ex6Eg==
Date:   Sun, 6 Aug 2023 00:42:11 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Message-ID: <20230805224211.qquexvseq24hxcju@intel.intel>
References: <20230731073613.10394-1-clamor95@gmail.com>
 <20230731073613.10394-5-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731073613.10394-5-clamor95@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Svyatoslav,

On Mon, Jul 31, 2023 at 10:36:13AM +0300, Svyatoslav Ryhel wrote:
> After adding support for passing temperature data from thermal sensor
> to MAX17040 it got dependency on CONFIG_IIO. From all defconfigs
> using MAX17040 only s5pv210_defconfig did not have IIO already enabled
> so let's enable it to avoid regression.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/configs/s5pv210_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
> index 4c1e480b5bbd..24070ee3d43e 100644
> --- a/arch/arm/configs/s5pv210_defconfig
> +++ b/arch/arm/configs/s5pv210_defconfig
> @@ -97,6 +97,7 @@ CONFIG_MMC_SDHCI_S3C_DMA=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_MAX8998=m
>  CONFIG_DMADEVICES=y
> +CONFIG_IIO=y
>  CONFIG_PWM=y
>  CONFIG_PWM_SAMSUNG=y
>  CONFIG_PHY_SAMSUNG_USB2=m

Should this patch be squashed to the previous patch? I think you
break bisectability for this board if you enable iio only here.

Andi
