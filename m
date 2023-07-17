Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FB77558C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjGQAPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjGQAPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:15:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83401B9;
        Sun, 16 Jul 2023 17:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46ABC60C61;
        Mon, 17 Jul 2023 00:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D87BC433C8;
        Mon, 17 Jul 2023 00:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689552912;
        bh=grf2fMTmkSCfvV9sqAgpuuU6h5bIqO/I5qwBM9dw5sQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e4bQqjdgTgZhW6Q29zv8dnRQwJqb4KhTqmduqyXcJ6440riCLRdtSR69vQbTN1oDI
         VMQylZdf9//YBXhxVbGz9jAJccjORux/ZI1R7zCSetAamR9NNOzwe0M88HsY9RywtT
         3Ab4e1ofbVxo7daeUjw5zM7Mp+sn0y7Kea9Qf9ryO6v+QyBmC8Tw6Yw3B0rd6540L2
         bunGlIQm31Q/hNy+QIfy76aSfUkSxysi5jukzboFBlE4PSVZB++jquN8BexwpqS/pl
         Nk0c5Z0AG2wGPzCDRm1KZIWAiUj9ovEe9KzIqmJQabKPEH5dpgaPO/SPmUpMYsBhBY
         KMQGwaAImULGQ==
Date:   Mon, 17 Jul 2023 08:15:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw7904: enable UART1 hardware
 flow control
Message-ID: <20230717001501.GF9559@dragon>
References: <20230606153819.1449257-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606153819.1449257-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:38:19AM -0700, Tim Harvey wrote:
> On the GW7904 uart1 can use UART3_TX/RX for hardware flow control
> which was the desired default configuration. Remove uart3 and configure
> uart1 for hardware flow control.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
