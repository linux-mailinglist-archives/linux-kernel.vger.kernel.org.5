Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E46877278C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjHGOWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjHGOWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:22:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A41C10CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:22:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1C0861C41
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B3DC433C8;
        Mon,  7 Aug 2023 14:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691418124;
        bh=cXFiuh6QE/l5gO4LSGbmHHnCOg0r0pMDyGjk4yYWqGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0jWe+U56RKMxh65PlSh0uPPdDBU77fJ9Tn/1K+nNW3X5eLmlmcqQ1IO/XanTxc4y
         /r4mYYmhEJP9y+6hzmnp8PojJb3N1XcfwZUNwvOMrtmhTmBFO4vTjjq44TjR5Zbc+A
         KMXyo+IYxfXbHpjq9MUoGp6fL/HiZObf+2O9Z3g1HTchwW5MQj6kIO6pCxC7vQ1b2T
         O2+590JEwTPQK5Jvsy7VTDDtKkLMHICHK9o/A+rMINyr3MpMZ/80eEKqryjs96Fpmq
         GD+y1WWgWk9ePAnQ+hgEknZh6VzDY63ob2hH+dYAKRm2hN5+KfZRX0qpnshbR/dagZ
         9f9zydEc+YiOQ==
Date:   Mon, 7 Aug 2023 16:21:58 +0200
From:   Simon Horman <horms@kernel.org>
To:     Da Xue <da@libre.computer>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Luke Lu <luke.lu@libre.computer>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH v2] net: phy: meson-gxl: implement
 meson_gxl_phy_resume()
Message-ID: <ZND+BrB0OCqgLo9u@vergenet.net>
References: <20230804201903.1303713-1-da@libre.computer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804201903.1303713-1-da@libre.computer>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:19:02PM -0400, Da Xue wrote:
> After suspend and resume, the meson GXL internal PHY config needs to be initialized again or the carrier cannot be found.
> 
> Signed-off-by: Luke Lu <luke.lu@libre.computer>
> Reviewed-by: Da Xue <da@libre.computer>

Hi Da Xue,

as the posted of this patch you need to provide your signed-off-by line.

From the way things are structured above it is unclear what Luke's
role is. Was he the author of the patch? If so the body of the email,
just above the patch description, should start with:

From: Luke Lu <luke.lu@libre.computer>

Link: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

> ---
>  drivers/net/phy/meson-gxl.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
> index bb9b33b6b..2df516ed4 100644
> --- a/drivers/net/phy/meson-gxl.c
> +++ b/drivers/net/phy/meson-gxl.c
> @@ -132,6 +132,18 @@ static int meson_gxl_config_init(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int meson_gxl_phy_resume(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	genphy_resume();

This patch doesn't compile because the call to genphy_resume() has too
few arguments.

> +	ret = meson_gxl_config_init(phydev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  /* This function is provided to cope with the possible failures of this phy
>   * during aneg process. When aneg fails, the PHY reports that aneg is done
>   * but the value found in MII_LPA is wrong:
> @@ -196,7 +208,7 @@ static struct phy_driver meson_gxl_phy[] = {
>  		.config_intr	= smsc_phy_config_intr,
>  		.handle_interrupt = smsc_phy_handle_interrupt,
>  		.suspend        = genphy_suspend,
> -		.resume         = genphy_resume,
> +		.resume         = meson_gxl_phy_resume,
>  		.read_mmd	= genphy_read_mmd_unsupported,
>  		.write_mmd	= genphy_write_mmd_unsupported,
>  	}, {
> -- 
> 2.39.2
> 
> 
