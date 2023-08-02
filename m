Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9476D92C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjHBVHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjHBVHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:07:03 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B13F26AB;
        Wed,  2 Aug 2023 14:06:59 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7672073e7b9so16379485a.0;
        Wed, 02 Aug 2023 14:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691010418; x=1691615218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=crZnLksKhXHygAFAt6KtbbotkkwISuLwd1MjzY9iUSY=;
        b=Ez/qmwAEpI8zAgjFfoEc2jA+TVE0h8CbBD0jcdPZOcUAxdNhXhj9dfL61QWXF4SdOL
         awrU41bM3y/pGxIoj5R80VFaHlU3JDeD+/UCYe/MjSXO1kSxTNYpdVyz/d0j8yBXQChD
         gSc3dX5Z1MN1XESRxjk8tHKHnsDfG6VszQkMav6o/L4fmzroAQYLPcYIq/5Vw50/w/IW
         jMmlVJJfbBqB2fIC3zS+/DSueXN9czpd3SMUXNf6DiYT+RPUqhG0RTYf00CCl2THyExR
         rArKBmT8tI9SmxAJCL/Lr2H+BvzS2jNu2QcFg0w73rXZkQrU+eroTc/MBCh1Cfl43DtO
         kgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691010418; x=1691615218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crZnLksKhXHygAFAt6KtbbotkkwISuLwd1MjzY9iUSY=;
        b=fy3DPNNHhnBZ+YAn45vb813hG6wI/OPhB2mkl4LrHsD1C8OrhPgGytf6YP0B2J3FOt
         9FQcMkmbGJgeIOUFqsZBriEpZnL+9UDKCey1SSOzGaQ+aNtrt/W8L11mQs7FpRV28Sgv
         ID2NWy/8DG4O0xhdEclOU/89xXENw8bUSjwXpVd45CCep+9ofBqfqMxD70rlFm7i8DuN
         Qe7I56A8cAOhGhbv3VY3UmzCVLKHuBzP9ppTfsk9ro+y6XXaBzKCHXrDdqEd5rtNNLnV
         bHR4JBO0EtzfnBz5NOoH6w1JgZMqZ6MDBI8FDuVjTGsZ+G3FkvKkTmIJ7X0OKY20KLfb
         kiWQ==
X-Gm-Message-State: ABy/qLYES7DeLNCBTeaKqJfn5rZU1m3pOEosBg6dnrQSV1YtnXVoOJ81
        yQiV1Yjh8nBSqVwxZypvtmY=
X-Google-Smtp-Source: APBJJlHoS5d3Ipe2H7XAm7BBbIZRwGBIiVdazN/gCWbw8Q7xM1OS6zSlh4WLA2gIzX6CTF3heoL2Wg==
X-Received: by 2002:a05:6214:313:b0:63c:d6f1:7bcb with SMTP id i19-20020a056214031300b0063cd6f17bcbmr9115831qvu.41.1691010418587;
        Wed, 02 Aug 2023 14:06:58 -0700 (PDT)
Received: from Dell-Inspiron-15 ([2601:18c:8380:74b0:e8e5:f40c:d741:8f07])
        by smtp.gmail.com with ESMTPSA id s18-20020a0cdc12000000b0063d3fef54c6sm5558313qvk.77.2023.08.02.14.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 14:06:58 -0700 (PDT)
Date:   Wed, 2 Aug 2023 17:06:55 -0400
From:   Ben Wolsieffer <benwolsieffer@gmail.com>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] arm64: dts: amlogic: Used onboard usb hub reset
 on odroid c2
Message-ID: <ZMrFb7H1ynwwBSCA@Dell-Inspiron-15>
References: <20230121175639.12818-1-linux.amoon@gmail.com>
 <20230121175639.12818-4-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121175639.12818-4-linux.amoon@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 05:56:31PM +0000, Anand Moon wrote:
> On Odroid c2 previously use gpio-hog to reset the usb hub,
> switch to used on-board usb hub reset to enable the usb hub
> and enable power to hub.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v3 - Add rev by Neil.
>      droped dr_mode
> v2 - drop the vendor name from compatible string.
>    - move the hub node to USB controller node.
>    - drop the usb_otg_pwr since it only liked to OTG port
>          and link p5v0 to the vdd-supply.
> ---
>  .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 25 ++++++++-----------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 201596247fd9..70b10934a811 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -250,21 +250,6 @@ eth_phy0: ethernet-phy@0 {
>  	};
>  };
>  
> -&gpio_ao {
> -	/*
> -	 * WARNING: The USB Hub on the Odroid-C2 needs a reset signal
> -	 * to be turned high in order to be detected by the USB Controller
> -	 * This signal should be handled by a USB specific power sequence
> -	 * in order to reset the Hub when USB bus is powered down.
> -	 */
> -	hog-0 {
> -		gpio-hog;
> -		gpios = <GPIOAO_4 GPIO_ACTIVE_HIGH>;
> -		output-high;
> -		line-name = "usb-hub-reset";
> -	};
> -};
> -
>  &hdmi_tx {
>  	status = "okay";
>  	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
> @@ -414,5 +399,15 @@ &usb0 {
>  };
>  
>  &usb1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
>  	status = "okay";
> +
> +	hub@1 {
> +		/* Genesys Logic GL852G USB 2.0 hub */
> +		compatible = "usb5e3,610";
> +		reg = <1>;
> +		vdd-supply = <&p5v0>;
> +		reset-gpio = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
> +	};
>  };
> -- 
> 2.38.1
> 

Hello,

This patch breaks USB support on the ODROID-C2. As soon as the
onboard_usb_hub module is loaded, all USB devices disconnect.
Blacklisting onboard_usb_hub makes USB work as expected.

I tried to reproduce the problem by manually toggling the reset line,
but the problem seems to be specific to this driver. When reset is
asserted manually, the devices disconnect, but they all enumerate again
as soon as reset is released.

Also, I have been unable to make USB work again (until the next reboot)
even after unloading onboard_usb_hub.

Ben
