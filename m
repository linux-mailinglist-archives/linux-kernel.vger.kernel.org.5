Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADB8768571
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjG3NPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjG3NPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:15:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C700D10D8;
        Sun, 30 Jul 2023 06:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BA3E60C4F;
        Sun, 30 Jul 2023 13:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1277AC433C7;
        Sun, 30 Jul 2023 13:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690722931;
        bh=BK1r8DOIxzdujiBN1L0w5O9SUnU/br1497dAezYTeIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uvdKWb5GJjIemnTazj8fgX5tCfLUK1DaqAf3qxBlXF0q8vUTMN+bsWu5IKFQP7tlJ
         MM9Ao3fJfcSPZHDImMsUXVozebvDTlxYGnbwFaQNlN9v4gbZRmCTtAuVHwnlj48qcm
         GOYOFuWBz5d7ebNVNB4NwVfmIvUyFQsvQfrTBOulnbwT09Yxs3MyuKr+PI548WMFvM
         maX5l4Z30tFosSjmk4QsJRiWqd3W0n6MfHoS9BUn73nU4+AyWSsDUTUxC0CDUsow3x
         qO0HEnC5cfgP/Cd8A4Y4ByEYy/Hf8w1twowYVjQGMt9t9W+BQw+U9ESfs1ES5ihoow
         WSh9kpmeI61sQ==
Date:   Sun, 30 Jul 2023 21:15:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-phycore: drop uncorrect vselect-en
Message-ID: <20230730131509.GL151430@dragon>
References: <20230725142653.157510-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725142653.157510-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 04:26:53PM +0200, Krzysztof Kozlowski wrote:
> There is no "vselect-en" property, neither in the bindings nor in the
> Linux driver:
> 
>   imx8mm-phyboard-polis-rdk.dtb: pmic@8: regulators:ldo2: Unevaluated properties are not allowed ('vselect-en' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!
