Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FE17A7838
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjITJ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbjITJ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:57:32 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2138EAD;
        Wed, 20 Sep 2023 02:57:25 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE52EE0008;
        Wed, 20 Sep 2023 09:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695203844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oUsRvVYool5nt9xgnn92j9nopNb++VbByZ1Kaap2nIg=;
        b=E3pRhS5NBxfZbSzNWar21eA3FnXkLGUDdoUURYFbxMagc2zONjrDloRRNvJapFW/BMsbNZ
        gnOM2aKVaYfC1G84CdZNSjkVyKqvteWPxz8NKK9gY1/uZurYrSH0RBOMVWjb0rmRtQDXPy
        aj9T56Zbvxo83PTQtAUbxrjSH85ijgdYHb+gOCTBiib+xtBnLq2bc5R5ZTxjnNLWXX0el2
        +zkzVzrv21LuSqTItm95tLyX/4aaujLsKKaGaemjuy0oY0A74FKHQbYZI5QO03Z2uXz3kr
        V/cCheVykayLSkOSfjdX1FmJs9t/Dd799yKMmtMN6UQc/rB6WCH+b2n3C7zomw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Robert Marko <robert.marko@sartura.hr>, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH 1/2] arm64: dts: marvell: uDPU: rename the SFP GPIO
 properties
In-Reply-To: <20230914094550.1519097-1-robert.marko@sartura.hr>
References: <20230914094550.1519097-1-robert.marko@sartura.hr>
Date:   Wed, 20 Sep 2023 11:57:23 +0200
Message-ID: <878r91f9q4.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Marko <robert.marko@sartura.hr> writes:

> Rename the GPIO related SFP properties to include the preffered -gpios
> suffix as defined in the SFP schema.
>
> This fixes the following warning:
> arch/arm64/boot/dts/marvell/armada-3720-eDPU.dtb: sfp-eth1: 'los-gpio', 'mod-def0-gpio', 'tx-disable-gpio', 'tx-fault-gpio' do not match any of the regexes: 'pinctrl-[0-9]+'
> from schema $id: http://devicetree.org/schemas/net/sff,sfp.yaml#
>

Applied on mvebu/dt64

Thanks,

Gregory
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
> index 3f79923376fb..3a9b6907185d 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
> @@ -61,10 +61,10 @@ led-alarm2 {
>  	sfp_eth1: sfp-eth1 {
>  		compatible = "sff,sfp";
>  		i2c-bus = <&i2c1>;
> -		los-gpio = <&gpiosb 7 GPIO_ACTIVE_HIGH>;
> -		mod-def0-gpio = <&gpiosb 8 GPIO_ACTIVE_LOW>;
> -		tx-disable-gpio = <&gpiosb 9 GPIO_ACTIVE_HIGH>;
> -		tx-fault-gpio = <&gpiosb 10 GPIO_ACTIVE_HIGH>;
> +		los-gpios = <&gpiosb 7 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpios = <&gpiosb 8 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpios = <&gpiosb 9 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpios = <&gpiosb 10 GPIO_ACTIVE_HIGH>;
>  		maximum-power-milliwatt = <3000>;
>  	};
>  };
> -- 
> 2.41.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
