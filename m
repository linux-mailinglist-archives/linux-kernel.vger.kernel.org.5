Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A02766990
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjG1J7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjG1J7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2671FC9;
        Fri, 28 Jul 2023 02:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A03F62099;
        Fri, 28 Jul 2023 09:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05C0C433C9;
        Fri, 28 Jul 2023 09:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690538379;
        bh=HfFbszyOKjVnbQrQRzUOs7y1BwB5d6vKlmyH1txlQ5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lF0oPOxPue7tbTceV7yKoljL4gLjeSl1AeXZ6oRFM0lCtehkimlY/6Td/0mwOsFeD
         6WHapNogJ8B3YLvlAcCRlo5thpeqdmfTKCektkk3gCkN8HN99nLF5zgdWddHX85mQY
         agi881tjsGvQJhoAjwqCqGAS/Ud2wSIn4DXp9VPJPfNvwbuXfsHoKCa4k2xgqoJonz
         BcOBq+4rcDIfGQQYV+mEyXOnU8mN9oNPeLcLGuohZJ8dpCNuF1Vk/Ff9WRJF15Svwy
         Khj8fT0JMibIk6XdfHa51UmrnPygXJmzZ2iUeTMcS3Z+YYJCJkxwM0TYQhH4tnyojl
         BfVJPBqIBOE/A==
Date:   Fri, 28 Jul 2023 10:59:33 +0100
From:   Lee Jones <lee@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Jerome Neanne <jneanne@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH 2/6] mfd: rk8xx: Specify restart mode
Message-ID: <20230728095933.GG8175@google.com>
References: <20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com>
 <20230727-pca9450-reboot-v1-2-c8edb27bf404@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230727-pca9450-reboot-v1-2-c8edb27bf404@skidata.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023, Benjamin Bara wrote:

> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> Specify the implemented restart handler as a cold one.

 * The current implementation is an issue because ...
 * If this is not fixed, the following will happen ...
 * By fixing this in this way and not another way has ... advantages ...

> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>  drivers/mfd/rk8xx-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
> index e8fc9e2ab1d0..15e8e6a9943a 100644
> --- a/drivers/mfd/rk8xx-core.c
> +++ b/drivers/mfd/rk8xx-core.c
> @@ -697,7 +697,8 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
>  		case RK809_ID:
>  		case RK817_ID:
>  			ret = devm_register_sys_off_handler(dev,
> -							    SYS_OFF_MODE_RESTART, SYS_OFF_PRIO_HIGH,
> +							    SYS_OFF_MODE_RESTART_COLD,
> +							    SYS_OFF_PRIO_HIGH,
>  							    &rk808_restart, rk808);
>  			if (ret)
>  				dev_warn(dev, "failed to register rst handler, %d\n", ret);
> 
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
