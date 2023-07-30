Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC6C7685C7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjG3Np4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3Npy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6CCE66;
        Sun, 30 Jul 2023 06:45:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C6F160C81;
        Sun, 30 Jul 2023 13:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C170C433C8;
        Sun, 30 Jul 2023 13:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690724753;
        bh=sp8Fm2jq/sHAVV6yF5fXFezsazPyaj4wP6HZcClCkCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XocPSg93Z441RSm8+yAQz+gaQ7CMFMNRKzbg4ZSoGHv2fg13dGWfJcpJqPQmP0wHb
         z/2DD2vLMcq9QNuQay17OrKa/Q0I35pEKWVk9Ac+vXZy7nffuhRwMavh105GuuoOdm
         M4jRo/c+WpEhFhQJj143z7aqhFjz7VgS6xv775T2GZFXBwTszQJHuq8cvYydk2mNU2
         /d5nBAHClVyfTDRVXJj/Fg3Y4CxYmRHzrtTzg7XAdDSOR7kWbo4ROzWPV2UkMCVojq
         o6DAghnM2WJGrBgk6FyYk2BSF/lQ9a/ZFb1EZQOzcOAQCg3WRqWbwNA5gxvKEOpC1f
         qOh61RvJFvNwQ==
Date:   Sun, 30 Jul 2023 21:45:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, richardcochran@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx: Set default tuning step for imx6sx usdhc
Message-ID: <20230730134537.GW151430@dragon>
References: <20230726075747.1016930-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726075747.1016930-1-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 03:57:47PM +0800, Xiaolei Wang wrote:
> If the tuning step is not set, the tuning step is set to 1.
> For some sd cards, the following Tuning timeout will occur.
> 
> Tuning failed, falling back to fixed sampling clock
> 
> So set the default tuning step. This refers to the NXP vendor's
> commit below:
> 
> https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/
> arch/arm/boot/dts/imx6sx.dtsi#L1108-L1109
> 
> Fixes: 1e336aa0c025 ("mmc: sdhci-esdhc-imx: correct the tuning start tap and step setting")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Applied, thanks!
