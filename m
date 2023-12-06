Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAD28064FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjLFCRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLFCRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:17:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D01B183
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 18:17:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C6CC433C8;
        Wed,  6 Dec 2023 02:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701829036;
        bh=YeTwiVbDlwwkb6nXIwsuaLI6YXDhUOf6XkJyFLo6N54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQ2jHMDZ3eHgMJosbDwMaTQsQAepkKCOjHb8rsgSto4LL3IjZk/btCwF/pnBDAd8l
         JvubPeVzR9XQipALknUlEgm+nvw3cdDNBJCfByFx8D90dubfAutTq8a3hWQd9tf4xW
         wsCfXlL4jX5ZbECuNzFEC1yytLDYqffMxgQS05laGbpoxC1ohOowj/g6pCSmn5gcGY
         S1wUgpu9Lup6AYgGGspVwWNCnIkGWMuq0vAJhpCE86pJFbwGUSJVjbb/JGK0u8yj6o
         Di/XScK3dyp2BSDBeFGuHyI3z86WpwvSDh6tuTpgCFmqMwJPWS0mJYCoHJmLn6mOG8
         Ue0W5QMzI3wPQ==
Date:   Wed, 6 Dec 2023 10:17:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembeded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: imx8mm: Simplify mipi_dsi clocks
Message-ID: <20231206021711.GJ236001@dragon>
References: <20231128045415.210682-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128045415.210682-1-aford173@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:54:13PM -0600, Adam Ford wrote:
> The device tree clock structure for the mipi_dsi is
> unnecessarily redundant.
> 
> The default clock parent of IMX8MM_CLK_DSI_PHY_REF is
> already IMX8MM_CLK_24M, so there is no need to set the
> parent-child relationship between them.  The default clock
> rates for IMX8MM_SYS_PLL1_266M and IMX8MM_CLK_24M are
> already defined to be 266MHz and 24MHz respectively,
> so there is no need to define those clock rates.
> 
> On i.MX8M[MNP] the  samsung,pll-clock-frequency is not
> necessary, because the driver will read it from sclk_mipi
> which is also already set to 24MHz making it also
> redundant.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied all, thanks!
