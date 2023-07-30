Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9046076858F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjG3N00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjG3N0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:26:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8290EE7F;
        Sun, 30 Jul 2023 06:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C91A60C4D;
        Sun, 30 Jul 2023 13:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE86C433C8;
        Sun, 30 Jul 2023 13:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690723582;
        bh=WwgLymzmxnBrZ9f6hsSKR6h4CTJfMx2hwDOS2SI6yYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1b6917DMvdT8q0WB5fzqseyK0S1MaHxzqi5+CXsvOnDO8nCLXqVTc+l10YoM7Ro8
         TkLEm/AAJ4+ouDUj5DlLexfFGDmXGieMDuNjx37pvewyfCZA5KzgKLZVqfALFuEt8u
         3gWFKgCExmC/wvoBjxp+pOBwmSsuG+/4W5NSn4K5IEgl7IpBK7mYKQqcf4Y3SVWwvU
         o+KXgmFhjqUCMK2jnKaqceBr6vwr925vXvJ+5NUFH1cXSyX+dIGVUkjCSTET5EZIBH
         Yo8TJnz/aYt226jX0RkOz6LIwfrqY+jHHxWYMrXbLrWHvHpsIbATznJNfDZtK8rEW1
         X+3D9dBVNQm/Q==
Date:   Sun, 30 Jul 2023 21:26:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, richardcochran@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: dts: imx: Set default tuning step for imx7d usdhc
Message-ID: <20230730132611.GR151430@dragon>
References: <20230724154510.2532561-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724154510.2532561-1-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 11:45:10PM +0800, Xiaolei Wang wrote:
> If the tuning step is not set, the tuning step is set to 1.
> For some sd cards, the following Tuning timeout will occur.
> 
> Tuning failed, falling back to fixed sampling clock
> mmc0: Tuning failed, falling back to fixed sampling clock
> 
> So set the default tuning step. This refers to the NXP vendor's
> commit below:
> 
> https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/
> arch/arm/boot/dts/imx7s.dtsi#L1216-L1217
> 
> Fixes: 1e336aa0c025 ("mmc: sdhci-esdhc-imx: correct the tuning start tap and step setting")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks!
