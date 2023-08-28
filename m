Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4689B78A67E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjH1H3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjH1H3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:29:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C57F1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:29:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so3926137a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693207746; x=1693812546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ncCz15Ca8yj1oTiFMyRiCrPjAtxLbzm5ILrKrkQBGa4=;
        b=Y3ltKNaw4XNokhKNkRsZxIRn5Sl3hDxauYsqx/tDwYM2Y/30Nbo3jEhZYwMjwLGTqz
         Cpqf2AyEf+KPajQMaPmZyAAtBLQUKEYZwu6lnYOod5mD/vCzAuRkmMd56sPV8qMAYG14
         Diom48g2eF4cf3wlPX8EhJPIIQz+5xwYbeZ1oaFWaZ1IXNe32uogjHt2jEDXI5tXNTms
         DdoRIKy0zeDK7Z4rYx620MtKiLyaSc7hJ5CCC41WKiLro2Syvj9rjQBfqpceKALj+Cly
         FgCwsWouMB5a0VWyWQE54rIEWGIYKqNlU+nbuT3cCjAIlTftJC1jVvdbyZl5oy3gzbkb
         WURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693207746; x=1693812546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncCz15Ca8yj1oTiFMyRiCrPjAtxLbzm5ILrKrkQBGa4=;
        b=bxeTGkMOsNj+XIfFQHBSlu/D6IAD8ZqI9hD7AM9YVEku5v/OKzCyLK3+sQaOT3REEo
         j/ZxoWK5vzFbYCOfYYNbFP5+q161PQzoIoOE/HG5gXqbh30h07nubfyeq00q9cnGlVZo
         bREhVrHKl2JZ4M1KTNazO+IUf3ekbblD3ARAkF887U8QKkp5Xxr1Y6T1Do7UkBss3r6A
         49i5Ked24Bhh8hGUWIvCJNAeepCE3kYSNx8IttR0Wq45eLNMQxwImKM50yGOmUn5Lmxl
         hzFOz1Bbf/WigZlo4O+de9OsalaiEWOF4qjrICABkFwU0EQezsJ39WS71SrE1oLTNblv
         K7Sg==
X-Gm-Message-State: AOJu0Yzbmw9vDeo2dwWi4iv1lo/blah30cSDHVtEPhHzo3yXsjfxvebk
        kTy7h8kG5NgwLOv3jFBFkBP44Q==
X-Google-Smtp-Source: AGHT+IEZVXu5s4APFn9qEPjvXInwBCeK+aeFnuvOZoEFe0yhJAfI53HIx6HUkp4PCUzag3ZJofaxbQ==
X-Received: by 2002:aa7:d742:0:b0:525:4f9c:3505 with SMTP id a2-20020aa7d742000000b005254f9c3505mr19277217eds.29.1693207746256;
        Mon, 28 Aug 2023 00:29:06 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id d8-20020a05640208c800b0052237dfa82fsm4155333edz.64.2023.08.28.00.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 00:29:05 -0700 (PDT)
Message-ID: <44b72757-712e-0e01-2a66-5b2a694b0ab0@linaro.org>
Date:   Mon, 28 Aug 2023 09:29:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/6] arm64: dts: freescale: add initial device tree for
 TQMLS1043A/TQMLS1046A
Content-Language: en-US
To:     Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
References: <20230823120952.317740-1-gregor.herburger@ew.tq-group.com>
 <20230823120952.317740-4-gregor.herburger@ew.tq-group.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823120952.317740-4-gregor.herburger@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 14:09, Gregor Herburger wrote:
> This adds support for the TQMLS1043A and TQMLS1046A SOM and the
> MBLS10xxA baseboard. TQMLS1043A and TQMLS1046A share a common layout
> and can be used on the MBLS10xxA.
> 
> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>

...

> +&i2c3 {
> +	status = "okay";
> +
> +	i2c-mux@70 {
> +		compatible = "nxp,pca9544";
> +		reg = <0x70>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c@0 {
> +			reg = <0x0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			gpioexp1: pca9555@20 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "nxp,pca9555";
> +				reg = <0x20>;
> +				vcc-supply = <&reg_3v3>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +			};

...

> +
> +&esdhc {
> +	/* eSDHC or eMMC: set by bootloader */
> +	non-removable;
> +	disable-wp;
> +	mmc-hs200-1_8v;
> +	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr12;
> +};
> +

Stray blank line.

Best regards,
Krzysztof

