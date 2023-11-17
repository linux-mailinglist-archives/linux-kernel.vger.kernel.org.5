Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85F37EF0ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbjKQKsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345793AbjKQKr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:47:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47593C2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:47:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B167C433C8;
        Fri, 17 Nov 2023 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700218075;
        bh=7g4hbHLfUyULJOVW3vf8Sh7y3UZATocPdgH7ZaOrhwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arvcMNsWuLaHFNnEDXLSxBRNuDbZEj3hNQtXWVgddTf9FmfRlhGjqo5Djz7zD3pqg
         OopSyBIWu14DRhP8byFeQ/BySIPGnPXFUE7vOv3GuIYJKpiTOIbcpyzOxO6DHEvROj
         VbbL5rkzUMA7tRaUVh7Giuu6iEue+dpW0G31Mevq7+Db0blEd1SEnszvQcA0Icouyz
         h9zTbBlE5xIlG9NEFxUWUhBo20gk0a6kgBsJApu8ma0W/hb9UKmB+oYQwmSo7lVP/q
         4UxWMUEgwgN/lyiqp0FXvCqkXrUno38OnT1qVDbct+H3JoLtU2v8U8UIsH5pmoKNwZ
         0hi3osb5uJI+Q==
Date:   Fri, 17 Nov 2023 16:17:48 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qrb5165-rb5: correct LED panic
 indicator
Message-ID: <20231117104748.GP250770@thinkpad>
References: <20231111094623.12476-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231111094623.12476-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 10:46:23AM +0100, Krzysztof Kozlowski wrote:
> There is no "panic-indicator" default trigger but a property with that
> name:
> 
>   qrb5165-rb5.dtb: leds: led-user4: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)
> 
> Fixes: b5cbd84e499a ("arm64: dts: qcom: qrb5165-rb5: Add onboard LED support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index 3bd0c06e7315..e43f73f1be1b 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -64,8 +64,8 @@ led-user4 {
>  			function = LED_FUNCTION_INDICATOR;
>  			color = <LED_COLOR_ID_GREEN>;
>  			gpios = <&pm8150_gpios 10 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "panic-indicator";
>  			default-state = "off";
> +			panic-indicator;
>  		};
>  
>  		led-wlan {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
