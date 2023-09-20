Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C49C7A89A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjITQim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjITQik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:38:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6A39F;
        Wed, 20 Sep 2023 09:38:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B7AC433C8;
        Wed, 20 Sep 2023 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695227915;
        bh=AgYijWzT5fNgSzF/C7Jot8W6orxc3fFWdO1GipiPPGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glL6tI1vEyAqBpV3z1E7pIHhWkHpXUMz7qTblOwbDmKT/EL9u8j6yceLwut8Tgx/n
         X81BblqXbF8R9DOUFsP0rN+mwfGH+lHUJtVgNrM4UsQuU+oXFsXWrPlL3beFHePx7c
         juhXhwm7k8sX8Nb319nGivK40ooVpm++zuXUvf9JTkN2Kzq2aMzytAB+BqCBvdrwke
         9t49eU6j30Yd5rh2vxTE+5iSLcdp1BDVDZmxsQ/HzVIitgQk9yv57iD/FMsWtO2yvT
         RuxAYfedqZRldLLCPAfL2uEQngVLq78ACz+MriKO3ucwASXBxrryPbFUczLjvVLUqN
         mGrbL8BPhCeSg==
Date:   Wed, 20 Sep 2023 09:42:42 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Danila Tikhonov <danila@jiaxyga.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: pm8150l: Add wled node
Message-ID: <sofnrufl5lkxozwjq5fzqjmkkqdk4gokevylzun6isithgfhgu@nibgf2y7tx34>
References: <20230913185514.21840-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913185514.21840-1-danila@jiaxyga.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 09:55:14PM +0300, Danila Tikhonov wrote:
> WLED is used for controlling the backlight on some boards, add the node
> for it.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/pm8150l.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
> index b1686e5777b8..ac08a09c64c2 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
> @@ -132,5 +132,15 @@ pm8150l_lpg: pwm {
>  			status = "disabled";
>  		};
>  
> +		pm8150l_wled: leds@d800 {
> +			compatible = "qcom,pm8150l-wled";
> +			reg = <0xd800>, <0xd900>;
> +			interrupts = <0x5 0xd8 0x1 IRQ_TYPE_EDGE_RISING>,
> +				     <0x5 0xd8 0x2 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "ovp", "short";
> +			label = "backlight";
> +
> +			status = "disabled";
> +		};
>  	};
>  };
> -- 
> 2.41.0
> 
