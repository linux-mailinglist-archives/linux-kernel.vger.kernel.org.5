Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79B17BF06F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441814AbjJJBoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441802AbjJJBoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:44:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FA9C5;
        Mon,  9 Oct 2023 18:44:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036FEC433C7;
        Tue, 10 Oct 2023 01:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696902253;
        bh=FF6IvBwDHy6sXitMPI8GyfrFWNdDf68fGBCnEc0nfOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABRHxKD9sDYVXLqd1cWQ6i8JUJBmhIYSB0XwivLMKzdJWAv4fw8FaaZdnSY7LiUHi
         iF1b60fQzlhl9+CD3R3McdzWs0RoWUY4GYceKVMrAwVeuvVtgAk82Z8cxIWWLRaibU
         6GOQMBtSaerLXri4VHOluHYNuP7Ln00weK12Fd1EDyx3glZy4HJqM5p6oyyjRAI+T+
         CGsoSldNoY1IWjmI7oYpukkWFfoivBReXXbFZVwSZKnJ2IiNzhHKFZlIbOshLenZKn
         0W0LaLkEeHrF96lGSgA0HPD/SI4MFbMxnDYl1jLd/kM6lT8s8BdzojlzdvD4A0Mh1f
         A172gkcgxLIcw==
Date:   Tue, 10 Oct 2023 09:44:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v5 6/7] arm64: dts: imx8ulp: update gpio node
Message-ID: <20231010014400.GD819755@dragon>
References: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
 <20231001-vf610-gpio-v5-6-8d873a8f224a@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001-vf610-gpio-v5-6-8d873a8f224a@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 04:27:57PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX8ULP GPIO supports two interrupts and one register base,
> the current fsl,imx7ulp-gpio compatible could work for i.MX8ULP in
> gpio-vf610.c driver, it is based on the base address are splited
> into two with offset added in device tree node. Now following
> hardware design, using one register base in device tree node.
> 
> This may break users who use compatible fsl,imx7ulp-gpio to enable
> i.MX8ULP GPIO.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
