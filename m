Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BAF78DA20
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjH3Sfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243194AbjH3KRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:17:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55C51BB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:17:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so1570747a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693390655; x=1693995455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bR584vZGW9FaOIQWQ+XKrXzGeqeN359N18ISef2diZA=;
        b=HNGF5Nb1Pp1wVN2xELCSsu+JG5Em2ZID0mYpaQ7dRMr5dO6L/k7OtkAyrLX0dq8NFN
         j6nb4qeA3uH+3sJClnNDeeoarubmCy6bDjN1ZzMSgiIpP+kPXCOB2vsJGCoxRlCTJudq
         nTWPjy0XAObdZjJFNKYGMGg7AgB1wW49H8TtoBhs1J0MDpghy1oV0TIDDV2IO3mTaUuF
         0QfzO01PPXzvctalm6/BXpgzhNzr7K57xyge2ysQy9dDxY+W164mDfJM1VEuAWL5kvng
         Lq1EZjFQgGQI5AzDWwF+zw/lorVrj4gSecFGVqZ1+v41c9Y2CaE0kDKsxhOZFBxzlrzt
         Xe5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693390655; x=1693995455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bR584vZGW9FaOIQWQ+XKrXzGeqeN359N18ISef2diZA=;
        b=hMoovxYmUXXSUe7rSq4y8pREQW443cYtgZZTtWXt7gHB3cY3NjASR7Qsp3dbBz6NFb
         k+LgVA3S1XQZfYeK5rjyL5/lxKeLIlO1J8sgzaXk1PZMD7mrPQlU5+viAEqrOVQuHrA2
         jGg6u2djso/ITuUiE6mdCoHs9gK4YDk0+BWBX38xWq+Y3N/C8eKafTKZOvPTIN0A5MFg
         abj/X/rWdPYZGUx60fSDPHGRpb+jglgx09djl1IlLBUVQzFnseePJfy8OhSLD0NzCz3A
         KA2HkF4Y7Jcx9UOMzjH7BaM/jZnaJ2W7wONDvzSmvDgzxymQrjmMhVwqN2qj7QYu2TNH
         0Yrw==
X-Gm-Message-State: AOJu0Yx7y4bYeb5XbyoiKTIf4d6b9qkFNu+QxzOtK7C+HR3ygK9GDAUS
        5d9QMfJa4V+y67pTs/T0I+s7VA==
X-Google-Smtp-Source: AGHT+IGsSEQ6TsVj9ioIFZ01EjPzA/5K6fZ+jDcjoLBrxP8iGnn6aeLftGsqJWjeoVwfFBCT3KItuA==
X-Received: by 2002:a05:6402:27d1:b0:51e:4218:b91b with SMTP id c17-20020a05640227d100b0051e4218b91bmr5539774ede.1.1693390655399;
        Wed, 30 Aug 2023 03:17:35 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id a26-20020aa7d91a000000b005256d4d58a6sm6620866edr.18.2023.08.30.03.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 03:17:34 -0700 (PDT)
Message-ID: <70372afc-9dad-813b-f69b-7278d3371053@linaro.org>
Date:   Wed, 30 Aug 2023 12:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 11/11] arm64: dts: qcom: qcm6490: Add device-tree for
 Fairphone 5
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-11-5a954519bbad@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230830-fp5-initial-v1-11-5a954519bbad@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 11:58, Luca Weiss wrote:
> Add device tree for the Fairphone 5 smartphone which is based on
> the QCM6490 SoC.
> 

...

> +
> +#include <dt-bindings/arm/qcom,ids.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sc7280.dtsi"
> +#include "pm7250b.dtsi"
> +#include "pm7325.dtsi"
> +#include "pm8350c.dtsi" /* PM7350C */
> +#include "pmk8350.dtsi" /* PMK7325 */
> +
> +/ {
> +	model = "Fairphone 5";
> +	compatible = "fairphone,fp5", "qcom,qcm6490";
> +	chassis-type = "handset";
> +
> +	/* required for bootloader to select correct board */
> +	qcom,msm-id = <QCOM_ID_QCM6490 0x10000>;
> +	qcom,board-id = <34 0>;

Sorry, not allowed. This is not an old, legacy platform.

> +
> +	aliases {
> +		serial0 = &uart5;
> +		serial1 = &uart7;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer0: framebuffer@a000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0xe1000000 0 (2700 * 1224 * 4)>;
> +			width = <1224>;
> +			height = <2700>;
> +			stride = <(1224 * 4)>;
> +			format = "a8r8g8b8";
> +			panel = <&panel>;
> +			clocks = <&gcc GCC_DISP_HF_AXI_CLK>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-0 = <&volume_down_default>, <&hall_sensor_default>;
> +		pinctrl-names = "default";
> +
> +		key-volume-up {
> +			label = "Volume up";
> +			gpios = <&pm7325_gpios 6 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +		};
> +
> +		/* Hall sensor uses vreg_l8c as VDD, it's being enabled using

Use Linux style comments:
/*
 * foo
 * bar...


> +		 * always-on on the regulator
> +		 */
> +		event-hall-sensor {
> +			label = "Hall Effect Sensor";
> +			gpios = <&tlmm 155 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_LID>;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +	};
> +
> +	panel: panel {
> +		compatible = "boe,rm692e5";

Undocumented. You cannot add nodes with undocumented compatibles. Drop.

> +
> +		width-mm = <68>;
> +		height-mm = <150>;
> +	};


Best regards,
Krzysztof

