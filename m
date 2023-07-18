Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21488757196
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjGRCIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGRCIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:08:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482D61711;
        Mon, 17 Jul 2023 19:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4B3C6134B;
        Tue, 18 Jul 2023 02:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC2FC433C7;
        Tue, 18 Jul 2023 02:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689646070;
        bh=+OfGIZs0SsqZi5c0p4NoWcdcjEz7/sUz96k8wnCvIM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gK9oYtETbHn4pfRknyRiV7N/fjhi+5xcKBtJntRB2kqvIVbXd9PYNfx4fCuQRVtbd
         4Qmxj3ZnepmNpLQh4OeHbLY+YzB+w5t/17Vjs0FfbKgc5Tt6Qj/TxjLm/ADE9zjPvp
         0LZmtS5HfZ/1v4SrCCuhlacIyVBQHNgo2TNb+xOeTxmMYu76cI6WyhYVjUp+XdoTPc
         B/4hEBpnpUlws2xe5k9EagPZ/fUncpBKa0WGimLTvir9ThG1ktLd3m2ANLDqXafr7g
         I7fsLWxucI1ulvBlt1thl9Jr14fMXuR+fUKbAJGMmZq7iykkiiSyeMCPp1+BzDWl8z
         nItxlMb0/PAzA==
Date:   Tue, 18 Jul 2023 10:07:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: imx8ulp-evk: add caam jr
Message-ID: <20230718020738.GX9559@dragon>
References: <20230616174050.644880-1-pankaj.gupta@nxp.com>
 <DU2PR04MB86300C782DC7637C469599EC9526A@DU2PR04MB8630.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR04MB86300C782DC7637C469599EC9526A@DU2PR04MB8630.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 04:46:46AM +0000, Pankaj Gupta wrote:
> V2: Changed the email subject line.
> ------------------------------------------------
> 
> 
> Add crypto node in device tree for:
> - CAAM job-ring
> 
> Signed-off-by: Varun Sethi <v.sethi@nxp.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

The patch only changes imx8ulp SoC instead of imx8ulp-evk board,
so the patch subject should be:

  arm64: dts: imx8ulp: ...

Shawn
