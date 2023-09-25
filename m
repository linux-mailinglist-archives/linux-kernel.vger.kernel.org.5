Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5E87ACE11
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjIYCZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIYCZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:25:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C957CF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:25:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4149DC433C7;
        Mon, 25 Sep 2023 02:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695608700;
        bh=T/XV+0SsXCSGWGhOD8i/yu+HGiaAsIrLlBsjD29NE/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5ixLGFiKW2q3sOWnAVj9ykoageE6rq4sBlzkm1loacSWrk1p554HsqJSQpZWGLhA
         lkdV/FakWD7KUeyobejc6MJYBloUEiQdE3dJN0/76XMAb11pBWAl3Y6vlVpWI2ATI3
         FzEwYCh1X8+aOfB2545/hg5YZ7nzYiXIDopdtdmMKI0bAoPP3w3IoXOjHqEkNkbWeR
         uKayjlpAJsV8aKzqr6FiMludn0h24mUUdJqSedsoCxP41DId6pQ44miUHeQuIwsUUx
         1fODBRa2nlxT3Dfniwif/bQ4D9CjqtEBrJ/aGFFNARkLyELy1xXYjmeKRyQOAE/YpY
         liTOqoJJbZ8tA==
Date:   Mon, 25 Sep 2023 10:24:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx: Add imx8mm-prt8mm.dtb to build
Message-ID: <20230925022450.GY7231@dragon>
References: <20230911214547.2200528-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911214547.2200528-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:45:37PM -0500, Rob Herring wrote:
> imx8mm-prt8mm.dts was not getting built. Add it to the build.
> 
> Fixes: 58497d7a13ed ("arm64: dts: imx: add Protonic PRT8MM board")
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/boot/dts/freescale/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index c6872b7e9471..0935626c3dfb 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -65,6 +65,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-bl-osm-s.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-mx8menlo.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-nitrogen-r2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-phg.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-prt8mm.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-rdk.dtb

I flipped above two to keep the alphabetical order.

Applied, thanks!

Shawn

>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-tqma8mqml-mba8mx.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
> -- 
> 2.40.1
> 
