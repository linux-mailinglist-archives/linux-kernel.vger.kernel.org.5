Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6637A79772F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbjIGQWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbjIGQVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:21:45 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218E17D8A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:19:06 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so19688291fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694103454; x=1694708254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yT+j2pGsqz6g/7hkqeJl2HC5ajkztNJE87gRZrJmIGQ=;
        b=XQUJFKpPzC5a439yX+KYI415wp0hYR/T0ldVDJPuv44XgQ5EomVkA0PymiuMLcwVsx
         6RJt3SaKaZ6fey4Nw9z21EP2Gjrmnl+g2NuEeWcz7buiqQUu62LhujGXu1P16ZJ1gs9T
         2QJHhlLn5mqt8hNK5J1NCMUZzh2b8bm3i7Aqh0WiiRmhDoj3RjivkQnPhB/zaMBtSJLJ
         Fex5fUhLSD25FNlozLuKUOmFo3Za/o9TxXa6epvVerGzXZE83xT2a/+MXpz1IKLX4iVo
         1z15aj0iq5hX9I+M7DDYmwn7BKzeD6D6PI/0xGdQzIrLIvNBDxXxkvI3J/kCKH1v9att
         REZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103454; x=1694708254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yT+j2pGsqz6g/7hkqeJl2HC5ajkztNJE87gRZrJmIGQ=;
        b=EdE5gqMU064uDdw0/9+nUVC9StQDdy+8JzpftqU+FA0unxUQ8GKLj7e9uLKJmDRSfP
         dIaTNTMgoITX4O9yln793k5B7rtty3hDf4U23r903KMh7rszn+10/+l+818MLAyub5Ld
         VjvkK35obsT6I4DZYXfqaUuuUSI2OH8UKcnVKMTMz7PyR3wBZReESq8kKn4dAaCAg8s8
         Q4VtGlkWRNAlGlTSC6kMhWyW9sTcMuwSFfoAvcmJqzXOWybSTpSHfGBLz/6I2SF3816Z
         0dTfMO1P3TosxR9e6YI6lwzjqY+zJ0veWGPYF1Ob5vwKQIgFjCJxXLetPj/i2aNKFL6B
         4h4A==
X-Gm-Message-State: AOJu0YyEhGRlUVdVqFOdjdXoAaTXTYB103FC19e7jPNVqtyax81Nw/zY
        5B+z00f91x2nMrBrMcvGAkSUdDpFituakdNDgoN4GQ==
X-Google-Smtp-Source: AGHT+IGQFxHleCdB34IoNTOM/evfr23cCD6pBdZ/p+K+Fe4b+zXNzBASrpLUen6AG1Mok15vrJ6+qQ==
X-Received: by 2002:aa7:df81:0:b0:523:2e0e:5462 with SMTP id b1-20020aa7df81000000b005232e0e5462mr3180834edy.42.1694067120706;
        Wed, 06 Sep 2023 23:12:00 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id a9-20020aa7d749000000b005257da6be23sm9413857eds.75.2023.09.06.23.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 23:12:00 -0700 (PDT)
Message-ID: <cb1eb99d-5fb6-d11e-1685-3e36b12ad65d@linaro.org>
Date:   Thu, 7 Sep 2023 08:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] arm: dts: am3517-evm: Enable Ethernet PHY Interrupt
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>, linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Derald D. Woods" <woods.technical@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230907010159.330555-1-aford173@gmail.com>
 <20230907010159.330555-2-aford173@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230907010159.330555-2-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2023 03:01, Adam Ford wrote:
> The Ethernet PHY interrupt pin is routed to GPIO_58.  Create a
> PHY node to configure this GPIO for the interrupt to avoid polling.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm/boot/dts/ti/omap/am3517-evm.dts b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
> index 738189ddc8d5..19869ef906a8 100644
> --- a/arch/arm/boot/dts/ti/omap/am3517-evm.dts
> +++ b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
> @@ -172,11 +172,24 @@ hsusb1_phy: hsusb1_phy {
>  &davinci_emac {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&ethernet_pins>;
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy0>;
>  	status = "okay";
>  };
>  
>  &davinci_mdio {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
>  	status = "okay";
> +
> +	ethphy0: ethernet-phy@0 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&enet_phy_pins>;
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;	/* gpio_58 */
> +	};
>  };
>  
>  &dss {
> @@ -257,6 +270,12 @@ OMAP3_CORE1_IOPAD(0x2210, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_50mhz_clk */
>  		>;
>  	};
>  
> +	enet_phy_pins: pinmux_ent_phy_pins {

Nope. This looks like pasted from some old downstream tree. Please
rewrite downstream code to match upstream.


Best regards,
Krzysztof

