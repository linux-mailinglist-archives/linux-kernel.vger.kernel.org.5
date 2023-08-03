Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDED776EEB2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjHCPxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbjHCPxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:53:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419B72109
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:53:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe4f5290daso1941339e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691077980; x=1691682780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qX07dZERZtkt2x/Ef7mtKlDJ3pdXlme16vQ71CFcvMg=;
        b=lNV/1Vm1Sktq6yegwfZDlJ3SHLsUKyqAGLGBzu1JPyDeBhIu08xbuA3BLMGjNQqCYm
         iKOTVxtsLilYh2IDTRtms4ySeS4gNqlPhGP8bdydEDpB4jmeqW+171mGCPuKN2Z1Jra9
         0j5V6gm2TDlEG71a3PgUzCu3xsAAWfWhrC1BJK+w8WRlWSEETzlwXnkGd360Lg+2vQc3
         5U5YL1qYeczsyHzsDnTysthikVxllMooZf5LaKBOrxU1F1VjzK1/k9i2M2Zix9dIUWFo
         Sc5UbhJqSkXhJERhoas6t+C/Y6XBJf1OeIFZIIAQUN40l+1poXcVRCjQxnSsvCJN8j96
         Ahiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691077980; x=1691682780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qX07dZERZtkt2x/Ef7mtKlDJ3pdXlme16vQ71CFcvMg=;
        b=PjYwy8hGgJdMKs0HU1F4cuq8TyWPqJzwjsWi1DamHLEnoWjhsKP7/6WHRGlR2DTnJ/
         CLVKFXhcZsi0uMXLvQvJHyEYMqn47JlV4xY0HD5gYwpoGH0TdnvCzewxb0PqAdZWXBE0
         mCDtT2qn2ot8aLEF5E8ri7lgZjtT1pFYMPNUg+icqvl6VeyUQcK6BgEUkcwYtzNG8gNd
         jWxA2oaDXzM7qP+McenIQOK7Nlj+h93U/hRoKEbJZ7WHUpUuM2cvdwXc15/aMXE7x2Tq
         nle4cU+jSGMyoZcXguL5VOw5we42vuKJ3nufKzlmDcp0gJd2LRDLii6svwPioOBH5zST
         dOug==
X-Gm-Message-State: ABy/qLbHMzrZeKw2BtyflKogdeVi611k45zqxdQvdTket4nc5Tis7NVt
        LNtRRjvAj7Rt7O6UnleTkviFNA==
X-Google-Smtp-Source: APBJJlECdy3cAAYllCy6LZlZFybimunVbeOEktk+t7kAzFaSsKLGdyMwALTIzJNGxeecwb/LWFdikg==
X-Received: by 2002:a05:6512:3e2a:b0:4fb:be3c:d8b7 with SMTP id i42-20020a0565123e2a00b004fbbe3cd8b7mr9692368lfv.51.1691077979984;
        Thu, 03 Aug 2023 08:52:59 -0700 (PDT)
Received: from [192.168.1.64] ([85.68.201.192])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906960f00b00988dbbd1f7esm10685913ejx.213.2023.08.03.08.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 08:52:59 -0700 (PDT)
Message-ID: <4ad2998c-69fa-1ffc-ef4b-a45cdffce4ba@baylibre.com>
Date:   Thu, 3 Aug 2023 17:52:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/6] arm64: dts: ti: k3-j721e-som-p0: Add TP6594 family
 PMICs
Content-Language: en-US
To:     Esteban Blanc <eblanc@baylibre.com>, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, u-kumar1@ti.com,
        aseketeli@baylibre.com, jpanis@baylibre.com
References: <20230727130908.10656-1-eblanc@baylibre.com>
 <20230727130908.10656-4-eblanc@baylibre.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <20230727130908.10656-4-eblanc@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 15:09, Esteban Blanc wrote:
> From: Jerome Neanne <jneanne@baylibre.com>
> 
[...]
> +	tps659411: pmic@4c {
> +		compatible = "ti,tps6594-q1";
> +		reg = <0x4c>;
> +		system-power-controller;
> +		interrupt-parent = <&wkup_gpio0>;
> +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		buck1234-supply = <&vsys_3v3>;
> +		buck5-supply = <&vsys_3v3>;
> +		ldo1-supply = <&vsys_3v3>;
> +		ldo2-supply = <&vsys_3v3>;
> +		ldo3-supply = <&vsys_3v3>;
> +		ldo4-supply = <&vsys_3v3>;
> +
> +		regulators {
> +			buckb1234: buck1234 {
> +				regulator-name = "vdd_core_0v8";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buckb5: buck5 {
> +				regulator-name = "vdd_ram_0v85";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldob1: ldo1 {
> +				regulator-name = "vdd_sd_dv";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldob2: ldo2 {
> +				regulator-name = "vdd_usb_3v3";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
This voltage is static 3.3V: regulator-min-microvolt = <3300000>;

> +			ldob3: ldo3 {
> +				regulator-name = "vdd_io_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldob4: ldo4 {
> +				regulator-name = "vda_pll_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
>   };
>   
>   &ospi0 {

Regards,
Jerome.
