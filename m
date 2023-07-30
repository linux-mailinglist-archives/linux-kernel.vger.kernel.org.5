Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB5E768583
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjG3NUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjG3NTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:19:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21CF1AE;
        Sun, 30 Jul 2023 06:19:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EBB160C19;
        Sun, 30 Jul 2023 13:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93B5C433C7;
        Sun, 30 Jul 2023 13:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690723188;
        bh=VFrpwpxcLavxMY3HOmr+OiukVNHupv8GzfGgfplcls0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bKUf8CFQGFdgx0wcdsvqLNWLHUMhKZIj2b4E35AOfJj2lpMcxvx6rqOO8F1YbsK7m
         2CJLGz8H84q2eEbNDaR9OoT9ePQPDELQ5xcC+ugVY4yg69zfl5pfzWI5WzftAGW5WS
         W2UrnZegcYjrJINKJGADOUgXynsMSu3wee1XzHS0tooGh46/modtQYrxx735X4A/xH
         l+U84JySIn/sXLSrU6Hg1Wx3rs4911P28K8rEOz5y5FBmj9kNRarwlPLPHxl7BBpmL
         wuyZtFaO3ZowwXNmHqaozgO6cj8ajUMKxx0nITCaW6V7Ra6CRYuPjsvZ3eEGfVduMo
         KOfjgBg8AlCYg==
Date:   Sun, 30 Jul 2023 21:19:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 00/10] arm64: dts: imx8ulp: add more nodes
Message-ID: <20230730131937.GN151430@dragon>
References: <20230724075833.2763190-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724075833.2763190-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 03:58:23PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V2:
>  Add blank line between property and child node in patch 3
>  Move compatible in the beginning in patch 8
>  For patch 9, the pinctrl settings are same, because drive strengh only
>  has a enable/disable bit.
> 
> Add flexspi, cm33, thermal, cpuidle, reserved memory nodes
> Enable flexspi, lpi2c7, spi-nor, cm33 for i.MX8ULP-EVK
> Set default clock for SDHC
> 
> Haibo Chen (3):
>   arm64: dts: imx8ulp: add flexspi node
>   arm64: dts: imx8ulp-evk: add 100MHz/200MHz pinctrl setting for eMMC
>   arm64: dts: imx8ulp-evk: enable lpi2c7 bus
> 
> Han Xu (1):
>   arm64: dts: imx8ulp-evk: add spi-nor device support
> 
> Peng Fan (6):
>   arm64: dts: imx8ulp: add cm33 node
>   arm64: dts: imx8ulp: set default clock for SDHC
>   arm64: dts: imx8ulp: add thermal node
>   arm64: dts: imx8ulp: add cpuidle node
>   arm64: dts: imx8ulp-evk: add reserved memory for cma
>   arm64: dts: imx8ulp-evk: enable CM33 node

Applied all, thanks!
