Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397DE7713FA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 10:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjHFIeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 04:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHFIeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 04:34:10 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85F811D;
        Sun,  6 Aug 2023 01:34:07 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id C780E1F8DB;
        Sun,  6 Aug 2023 10:34:03 +0200 (CEST)
Date:   Sun, 6 Aug 2023 10:33:59 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-am64: Fix epwm_tbclk node name to
 generic name
Message-ID: <ZM9a93OTLuwIKitA@francesco-nb.int.toradex.com>
References: <20230802174521.236255-1-afd@ti.com>
 <20230802174521.236255-3-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802174521.236255-3-afd@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew, hello Nishanth

On Wed, Aug 02, 2023 at 12:45:21PM -0500, Andrew Davis wrote:
> The name "clock" is not allowed for nodes, use "clock-controller" to
> remove the DTS check warning.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index e27eb2e585f14..4e3e450e4e4c8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -61,7 +61,7 @@ phy_gmii_sel: phy@4044 {
>  			#phy-cells = <1>;
>  		};
>  
> -		epwm_tbclk: clock@4140 {
> +		epwm_tbclk: clock-controller@4140 {

I was asked to do the exact same change here [1] by Nishanth, and I'm
sending the updated patch in a short while.

However I have one question, according to the
devicetree-specification-v0.4.pdf [2] "2.2.2 Generic Names
Recommendation", clock is a valid node name.

While testing the DT (make CHECK_DTBS=y), I did not have any warning nor
error.

What am I missing?

In addition to that I guess we should also update the example in the dt
bindings yaml file.

Francesco


[1] https://lore.kernel.org/all/20230731142135.108477-2-francesco@dolcini.it/
[2] https://github.com/devicetree-org/devicetree-specification/releases/download/v0.4/devicetree-specification-v0.4.pdf
