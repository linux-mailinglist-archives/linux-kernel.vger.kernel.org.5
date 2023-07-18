Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AD77574B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjGRGzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjGRGzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:55:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDC41AC;
        Mon, 17 Jul 2023 23:55:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD5516147F;
        Tue, 18 Jul 2023 06:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC91DC433C7;
        Tue, 18 Jul 2023 06:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689663299;
        bh=10CI098V1t65CYGkiX4ByK3/bvI8ZoHLMYNFdH0STWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WS2ML1wcSo9l4EVleXydJ9ABtW2qraRGAC6sDmq/CyiF3vQffyLBD2iek8uToP0QE
         HpS2Vm3MrJLBB3EkVbIiq3Eqqg3/I1JaTqKRLrROQaWfX7EuIbTpQmAW0ppzCbeBi4
         jlulsRph9+ab7w8I4eAwKD8DzvNxur5CjU/Mi10Rgny0BzsVyOkQ0phK1aLuJfkngz
         devSfRBX2GB7/k45iB9G43YujrPPxJkmhENZ63/H0PCs2ZEycgpeQrBOMtCwNCmP4r
         fMIE/0UkscSA3BotbR2wVG8GKeGPNOYQx2BjPm6m5qQGfVR49y+V05SuXB6mRqAX2E
         92+a0Cf0kc5kg==
Date:   Tue, 18 Jul 2023 14:54:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH 06/18] soc: imx: Move power-domain drivers to the genpd
 dir
Message-ID: <20230718065446.GN9559@dragon>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-7-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707140434.723349-7-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 04:04:22PM +0200, Ulf Hansson wrote:
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: <kernel@pengutronix.de>
> Cc: <linux-imx@nxp.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/genpd/imx/Makefile                   | 7 +++++++
>  drivers/{soc => genpd}/imx/gpc.c             | 0
>  drivers/{soc => genpd}/imx/gpcv2.c           | 0
>  drivers/{soc => genpd}/imx/imx8m-blk-ctrl.c  | 0
>  drivers/{soc => genpd}/imx/imx8mp-blk-ctrl.c | 0
>  drivers/{soc => genpd}/imx/imx93-blk-ctrl.c  | 0
>  drivers/{soc => genpd}/imx/imx93-pd.c        | 0
>  drivers/soc/imx/Makefile                     | 7 +------
>  8 files changed, 8 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/genpd/imx/Makefile
>  rename drivers/{soc => genpd}/imx/gpc.c (100%)
>  rename drivers/{soc => genpd}/imx/gpcv2.c (100%)
>  rename drivers/{soc => genpd}/imx/imx8m-blk-ctrl.c (100%)
>  rename drivers/{soc => genpd}/imx/imx8mp-blk-ctrl.c (100%)
>  rename drivers/{soc => genpd}/imx/imx93-blk-ctrl.c (100%)
>  rename drivers/{soc => genpd}/imx/imx93-pd.c (100%)

Acked-by: Shawn Guo <shawnguo@kernel.org>
