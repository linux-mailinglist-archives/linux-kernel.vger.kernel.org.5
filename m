Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240247B6B5E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbjJCOXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbjJCOXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:23:54 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657C7AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:23:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-405417465aaso10258755e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696343029; x=1696947829; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=i9W+xcDsLhxBNouI0kvlQgnQl4ggfNC0ZxsEX/ORR1o=;
        b=uUsJDjWnA77ThynfgbmXeVSLL1afkio3i8kwYjstpjMQqZM7j8ltwnI4DW0EvHh1N5
         ZpXbY0psPztAKCgFtumn4qR4WCUjpY1diosrrOZu1InIn+Pv/Kkaz0FRWA1QUPI0yKuj
         4OQYMjMv/JzF7/p5QEH3gj8U00gZAHnmf0iQifM7fkDGAitrZW9bz9qjEI02oKJgz1Yz
         qSuFRdojjBluPXJBb555QnRBDF5SdDBwuD4xme6oRfDRedb+SAhtnOpSImGsPc9MBBiI
         PpBkiw9kALRhQv4glNEbuginYOI63jN8n7JXHdQF645S/4f2DWFuJTWyGnRZf0sjUKL3
         +BPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696343029; x=1696947829;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9W+xcDsLhxBNouI0kvlQgnQl4ggfNC0ZxsEX/ORR1o=;
        b=o6zjtGHlBjqzlbn6Ihmatv5W/7X9eQttdo3cip5pfP4LWQa2etjC69h7CyMAwpVlaR
         cmVVT++5P2YrdbnIcApXzkoYLYn/ff6Rnf6M/SUonDjJ3H0rWFmQG0JGKwV2+99zuov3
         mnbnOGqD5otIlyJBzSjQmLKI0ynINkeqq4JvZleVppesEoIR+4JLuiClCtf7htOmbdJ/
         h/oWcBB0D/BTFYV8ipECilx+ufIdfwel9hL5OHehE9Cq2WWTCB3KnkI+2pXbZodk19bh
         SJCo199iXm925jSM+pXuMuiH7WU4W1lEZjZqxAYLZck2tWDhYIMRMraZeqThy2dhHHD+
         yvwA==
X-Gm-Message-State: AOJu0Yxi0eg9O5mLBLnxt4bJ9mO2Wf7OvAEMLt6UbhgIaJfD3tCPXCLg
        uyqP/Zn3IFeeOfZTvZfcqXwB8Q==
X-Google-Smtp-Source: AGHT+IEitvNMt+a+vtvvuOtdMuApyI5AShG40m6AYATZJ5FSglCpEvc26P3572jMqNTAg060w3jzgw==
X-Received: by 2002:a05:600c:2146:b0:401:b53e:6c3b with SMTP id v6-20020a05600c214600b00401b53e6c3bmr13317155wml.6.1696343028424;
        Tue, 03 Oct 2023 07:23:48 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:15bf:5b59:3e24:71fe])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c0b5000b003fe61c33df5sm9569933wmr.3.2023.10.03.07.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:23:47 -0700 (PDT)
References: <20231003121205.2870923-1-jbrunet@baylibre.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, Da Xue <da.xue@libretech.co>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: amlogic: add spdifout on libretech potatoes
Date:   Tue, 03 Oct 2023 16:19:08 +0200
In-reply-to: <20231003121205.2870923-1-jbrunet@baylibre.com>
Message-ID: <1jsf6ryebw.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 03 Oct 2023 at 14:12, Jerome Brunet <jbrunet@baylibre.com> wrote:

> SPDIF output is available libretech's Potato v1 and v2, on a dedicated
> header. Add the codec, pinmux and dai link to enable it on the sound card.

After discussing further within Da,
while the the schematics says SPDIF_OUT this is actually not the only
use of the header. This mis-understanding is on me.

Please do not merge this change.

At least the information is out there.

>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../amlogic/meson-gxl-s905x-libretech-cc-v2.dts | 17 +++++++++++++++++
>  .../amlogic/meson-gxl-s905x-libretech-cc.dts    | 17 +++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
> index 2825db91e462..ca6f922d162d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
> @@ -23,6 +23,13 @@ aliases {
>  		spi0 = &spifc;
>  	};
>  
> +	spdif_dit: audio-codec {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dit";
> +		status = "okay";
> +		sound-name-prefix = "9J2";
> +	};
> +
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> @@ -189,11 +196,21 @@ codec-0 {
>  				sound-dai = <&hdmi_tx>;
>  			};
>  		};
> +
> +		dai-link-3 {
> +			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
> +
> +			codec-0 {
> +				sound-dai = <&spdif_dit>;
> +			};
> +		};
>  	};
>  };
>  
>  &aiu {
>  	status = "okay";
> +	pinctrl-0 = <&spdif_out_h_pins>;
> +	pinctrl-names = "default";
>  };
>  
>  &cec_AO {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> index 27093e6ac9e2..8b3234a9cb45 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> @@ -29,6 +29,13 @@ dio2133: analog-amplifier {
>  		enable-gpios = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
>  	};
>  
> +	spdif_dit: audio-codec {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dit";
> +		status = "okay";
> +		sound-name-prefix = "9J1";
> +	};
> +
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> @@ -183,6 +190,14 @@ codec-0 {
>  				sound-dai = <&acodec>;
>  			};
>  		};
> +
> +		dai-link-4 {
> +			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
> +
> +			codec-0 {
> +				sound-dai = <&spdif_dit>;
> +			};
> +		};
>  	};
>  };
>  
> @@ -193,6 +208,8 @@ &acodec {
>  
>  &aiu {
>  	status = "okay";
> +	pinctrl-0 = <&spdif_out_h_pins>;
> +	pinctrl-names = "default";
>  };
>  
>  &cec_AO {

