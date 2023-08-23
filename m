Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4D0786100
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbjHWTtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbjHWTtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:49:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34B810CB;
        Wed, 23 Aug 2023 12:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E80266355;
        Wed, 23 Aug 2023 19:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBD2C433C7;
        Wed, 23 Aug 2023 19:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692820144;
        bh=FobxdKGjk+XaZrxNDpLxP3Jm4scXYpkNdSMSYXKfLC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VrIrnOXxJ1NiXM4eC6i5wDYcWnO2n2+H8JJ7WurOqnZVdoRfknp6PpjWUYjCL+aQg
         wMlA0wo6so3p7NmsQ0lVQyCbPov43nWUsY7rhLIe6PonfQsB6CTB0/Rhp0M0C4A6MU
         q2SUB837PnnyUGujlCNOu9nSpUD+SvH/iLA/gwec8Sbtxu2NpO7DkOahYZlGBkwSfS
         UD9k3jsf7sxmyqoQz3f1cJrTPiJQ1BNKrUv6RZGp1Dj3WH13LlA5iLGQU2NbRw4CIs
         Cq23xTOhm4MwfN+b05AcD8ruyhspDNVCNmPPFQN89U1kEI2tHpB3UT06BIKW68D0ef
         SFhz9NSBmf9kA==
Received: (nullmailer pid 2782531 invoked by uid 1000);
        Wed, 23 Aug 2023 19:49:02 -0000
Date:   Wed, 23 Aug 2023 14:49:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: use capital "OR" for multiple licenses in
 SPDX
Message-ID: <20230823194902.GA2782125-robh@kernel.org>
References: <20230823084540.112602-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823084540.112602-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 10:45:40AM +0200, Krzysztof Kozlowski wrote:
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
> 
> Correct also the format // -> .* in few Allwinner binding headers as
> pointed out by checkpatch:
> 
>   WARNING: Improper SPDX comment style for 'include/dt-bindings/reset/sun50i-h6-ccu.h', please use '/*' instead
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Rebased on next-20230822, so might not apply cleanly.  What does not
> apply, can be skipped and I will fix it after next RC.
> ---
>  Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml    | 2 +-
>  .../devicetree/bindings/arm/arm,coresight-dummy-sink.yaml       | 2 +-
>  .../devicetree/bindings/arm/arm,coresight-dummy-source.yaml     | 2 +-
>  .../devicetree/bindings/arm/arm,embedded-trace-extension.yaml   | 2 +-
>  .../devicetree/bindings/arm/arm,trace-buffer-extension.yaml     | 2 +-
>  Documentation/devicetree/bindings/arm/arm,versatile-sysreg.yaml | 2 +-
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml        | 2 +-
>  .../devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml      | 2 +-
>  Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml      | 2 +-
>  Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml  | 2 +-
>  Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml  | 2 +-
>  Documentation/devicetree/bindings/clock/ti,cdce925.yaml         | 2 +-
>  Documentation/devicetree/bindings/clock/ti,sci-clk.yaml         | 2 +-
>  Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml          | 2 +-
>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 +-
>  Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml | 2 +-
>  Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml | 2 +-
>  Documentation/devicetree/bindings/display/msm/dsi-phy-20nm.yaml | 2 +-
>  Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml | 2 +-
>  Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml  | 2 +-
>  .../devicetree/bindings/display/msm/dsi-phy-common.yaml         | 2 +-
>  Documentation/devicetree/bindings/display/msm/mdss-common.yaml  | 2 +-
>  Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml    | 2 +-
>  Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml    | 2 +-
>  .../devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml       | 2 +-
>  .../devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml      | 2 +-
>  .../devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml       | 2 +-
>  .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml      | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml        | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml       | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml        | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml       | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sc8280xp-dpu.yaml      | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sc8280xp-mdss.yaml     | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml        | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml       | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml        | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml       | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml       | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml       | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml        | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml       | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml        | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml       | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml        | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml       | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml        | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml       | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml        | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml       | 2 +-
>  .../devicetree/bindings/display/panel/himax,hx8394.yaml         | 2 +-
>  .../devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml | 2 +-
>  .../devicetree/bindings/display/panel/orisetech,otm8009a.yaml   | 2 +-
>  .../devicetree/bindings/display/panel/panel-dsi-cm.yaml         | 2 +-
>  .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml   | 2 +-
>  .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 +-
>  .../devicetree/bindings/display/panel/raydium,rm68200.yaml      | 2 +-
>  .../devicetree/bindings/display/panel/rocktech,jh057n00900.yaml | 2 +-
>  .../devicetree/bindings/display/panel/visionox,r66451.yaml      | 2 +-
>  .../devicetree/bindings/display/panel/visionox,rm69299.yaml     | 2 +-
>  .../devicetree/bindings/display/panel/visionox,vtdr6130.yaml    | 2 +-
>  .../devicetree/bindings/display/rockchip/rockchip-vop2.yaml     | 2 +-
>  .../bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml         | 2 +-
>  .../devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml          | 2 +-
>  Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml         | 2 +-
>  Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml       | 2 +-
>  Documentation/devicetree/bindings/hwmon/lm75.yaml               | 2 +-
>  Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml  | 2 +-
>  Documentation/devicetree/bindings/hwmon/national,lm90.yaml      | 2 +-
>  Documentation/devicetree/bindings/hwmon/nxp,mc34vr500.yaml      | 2 +-
>  Documentation/devicetree/bindings/hwmon/sensirion,sht15.yaml    | 2 +-
>  Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml          | 2 +-
>  Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml          | 2 +-
>  Documentation/devicetree/bindings/input/elan,ekth3000.yaml      | 2 +-
>  .../devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml | 2 +-
>  Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml      | 2 +-
>  Documentation/devicetree/bindings/mailbox/ti,omap-mailbox.yaml  | 2 +-
>  .../devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml        | 2 +-
>  .../devicetree/bindings/phy/nvidia,tegra210-xusb-padctl.yaml    | 2 +-
>  .../devicetree/bindings/power/reset/gpio-poweroff.yaml          | 2 +-
>  Documentation/devicetree/bindings/power/reset/gpio-restart.yaml | 2 +-
>  .../devicetree/bindings/power/reset/restart-handler.yaml        | 2 +-
>  Documentation/devicetree/bindings/power/supply/bq256xx.yaml     | 2 +-
>  .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml         | 2 +-
>  .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml         | 2 +-
>  .../devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml      | 2 +-
>  .../devicetree/bindings/remoteproc/ti,pru-consumer.yaml         | 2 +-
>  Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml  | 2 +-
>  .../devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml       | 2 +-
>  Documentation/devicetree/bindings/reset/ti,sci-reset.yaml       | 2 +-
>  Documentation/devicetree/bindings/reset/ti,tps380x-reset.yaml   | 2 +-
>  Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml     | 2 +-
>  Documentation/devicetree/bindings/usb/cypress,hx3.yaml          | 2 +-
>  Documentation/devicetree/bindings/usb/genesys,gl850g.yaml       | 2 +-
>  Documentation/devicetree/bindings/usb/realtek,rts5411.yaml      | 2 +-
>  Documentation/devicetree/bindings/usb/ti,usb8041.yaml           | 2 +-
>  Documentation/devicetree/bindings/usb/vialab,vl817.yaml         | 2 +-
>  include/dt-bindings/ata/ahci.h                                  | 2 +-
>  include/dt-bindings/clock/hi3559av100-clock.h                   | 2 +-
>  include/dt-bindings/clock/r8a779f0-cpg-mssr.h                   | 2 +-
>  include/dt-bindings/clock/rockchip,rk3588-cru.h                 | 2 +-
>  include/dt-bindings/clock/stm32mp1-clks.h                       | 2 +-
>  include/dt-bindings/clock/sun20i-d1-ccu.h                       | 2 +-
>  include/dt-bindings/clock/sun20i-d1-r-ccu.h                     | 2 +-
>  include/dt-bindings/clock/sun50i-a100-ccu.h                     | 2 +-
>  include/dt-bindings/clock/sun50i-h6-ccu.h                       | 2 +-
>  include/dt-bindings/clock/sun50i-h616-ccu.h                     | 2 +-
>  include/dt-bindings/clock/sun6i-rtc.h                           | 2 +-
>  include/dt-bindings/display/sdtv-standards.h                    | 2 +-
>  include/dt-bindings/gpio/meson-g12a-gpio.h                      | 2 +-
>  include/dt-bindings/power/amlogic,c3-pwrc.h                     | 2 +-
>  include/dt-bindings/power/meson-a1-power.h                      | 2 +-
>  include/dt-bindings/power/meson-axg-power.h                     | 2 +-
>  include/dt-bindings/power/meson-g12a-power.h                    | 2 +-
>  include/dt-bindings/power/meson-gxbb-power.h                    | 2 +-
>  include/dt-bindings/power/meson-s4-power.h                      | 2 +-
>  include/dt-bindings/power/meson-sm1-power.h                     | 2 +-
>  include/dt-bindings/power/meson8-power.h                        | 2 +-
>  include/dt-bindings/power/r8a779f0-sysc.h                       | 2 +-
>  include/dt-bindings/power/rk3588-power.h                        | 2 +-
>  include/dt-bindings/power/summit,smb347-charger.h               | 2 +-
>  include/dt-bindings/reset/rockchip,rk3588-cru.h                 | 2 +-
>  include/dt-bindings/reset/stm32mp1-resets.h                     | 2 +-
>  include/dt-bindings/reset/sun20i-d1-ccu.h                       | 2 +-
>  include/dt-bindings/reset/sun20i-d1-r-ccu.h                     | 2 +-
>  include/dt-bindings/reset/sun50i-a100-ccu.h                     | 2 +-
>  include/dt-bindings/reset/sun50i-a100-r-ccu.h                   | 2 +-
>  include/dt-bindings/reset/sun50i-h6-ccu.h                       | 2 +-
>  include/dt-bindings/reset/sun50i-h6-r-ccu.h                     | 2 +-
>  include/dt-bindings/reset/sun50i-h616-ccu.h                     | 2 +-
>  130 files changed, 130 insertions(+), 130 deletions(-)

Applied, thanks!

Rob
