Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6462810D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 10:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjLMJbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjLMJbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:31:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE4CEB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 01:31:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD4DC433C9;
        Wed, 13 Dec 2023 09:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702459904;
        bh=OKprM+aHu/jySbasH7HjZ8dwjDD56azbPOQ3iTmiTy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHA7OgSxTtE0ZSRPd6QYBOmmci2ModnKa9W7elAFi7SDdLYo3pAVBIw5SncLta2Ku
         yXytO60Thw6GaFZMJtJYtTBHP6+LS9FUl3UkLYhZHCB6EbpiaKRE8uFvqGjW6jJklZ
         halGRl9Foz7MJoWCg8wzCnhL7AEWf1cFCtEDh2jVltQIlkw+xyV83URf9etnvs1dNW
         1BMsUTmgvR20PIvOed2w5SIHSPtUE6Ygw/NLS8rlPqUWutrxM2GJeTMgUMH53C4/Pg
         wkfug32WYJwxUtkuD7rPcLisgZ9eBvUQnDjQVaPMRFnW3EoPpToph17FIIaGQwoIVy
         iMgxfqOe3w47A==
Date:   Wed, 13 Dec 2023 17:31:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v3 00/14] arm64: dts: imx8mm-kontron: DT updates
Message-ID: <20231213093134.GN270430@dragon>
References: <20231206144201.46911-1-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206144201.46911-1-frieder@fris.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 03:41:03PM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
...
>  arch/arm64/boot/dts/freescale/Makefile        |   4 +
>  .../dts/freescale/imx8mm-kontron-bl-osm-s.dts | 295 +++------
>  .../boot/dts/freescale/imx8mm-kontron-bl.dts  | 198 +++++-
>  .../boot/dts/freescale/imx8mm-kontron-dl.dtso | 201 +++++++
>  .../dts/freescale/imx8mm-kontron-osm-s.dtsi   | 567 +++++++++++++++++-
>  .../boot/dts/freescale/imx8mm-kontron-sl.dtsi |   4 +-
>  6 files changed, 1035 insertions(+), 234 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso

A couple of things:

- I have to use 'git am -3' apply some of the patches.  Could you rebase
  the series on imx/dt64 branch?

- There are a few DTC warnings that need to be addressed.

../arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts:235.34-238.7: Warning (graph_endpoint): /soc@0/bus@30800000/i2c@30a40000/bridge@2c/ports/port@0/endpoint: graph connection to node '/soc@0/bus@32c00000/dsi@32e10000/ports/port@1/endpoint' is not bidirectional

arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtbo: Warning (graph_port): /fragment@3: graph port node name should be 'port'
../arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso:61.17-63.3: Warning (graph_endpoint): /fragment@3/__overlay__: graph endpoint node name should be 'endpoint'

Shawn
