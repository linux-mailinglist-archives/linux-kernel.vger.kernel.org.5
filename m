Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA477558C2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjGQAMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjGQAMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BBA1B7;
        Sun, 16 Jul 2023 17:12:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADA8F60EC9;
        Mon, 17 Jul 2023 00:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF2AC433C7;
        Mon, 17 Jul 2023 00:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689552765;
        bh=MaEcBaYE19WdJ0QreuY8MWAgOhh/JJXmnevhdjfrlXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pVu9Y11PNVpvw0mBl6bdwRatOQpqE2gcna/chtZVugGi1z3Y4gpLoDMoCXH8jmolP
         ZVJarNeCbfundKjMq4G5Ds8FXpoZ49YSKe6AREWuK7EoxsUwjZQjDhZcL4KgDP8BdB
         WZP2o2ky0dzSK3i+qS2ffdx4m7B0Ex+tP+GsDrheBtarJstMebZRx4d65CoWFYbmI4
         yWgbQSq2voXGTvdnNiGRncLQ/5eJj2rUuZpA5b9F2V82lUuI4buw7LznpBr1jOfowN
         wnuNHU2kC07vo4g4NDfqn+s8sxQnxL4nfAwP69dY8+PleIeWsUIba7eaBPXHOm2vlN
         dOv/Lnxc/2JVg==
Date:   Mon, 17 Jul 2023 08:12:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw7901: add SDR50/SDR104 SDIO
 support for wifi
Message-ID: <20230717001234.GD9559@dragon>
References: <20230606153351.1448596-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606153351.1448596-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:33:51AM -0700, Tim Harvey wrote:
> The GW7901 has a Murata LBEE5H 802.11abgnac / BT5 module based on the
> Cypress CYW43455 which supports SDR50/SDR104.
> 
> Add dt pinctrl for the 100mhz and 200mhz states to support SDR50/SDR104.
> 
> While at it add the dt node for the CYW43455 wifi for the brcmfmac
> driver.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
