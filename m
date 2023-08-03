Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED7F76EC82
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbjHCO2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbjHCO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:28:50 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A592D42
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:28:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so1264816a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691072914; x=1691677714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5N53XkLC0ow9oyOxGkfT1b0sFLVffEcOzJFgPmWv8y4=;
        b=pbWIhIp5RelLKtambHBgT3Zm12YK9Tf5B6NmKCMXAG/5+RtCx62Wifoc+HzJkhen81
         6ur3wEu7s7ySi/9vQSrwrg1irT8PbprSyl+oAs5vWpsg6gKIA1x+cSfzZa2wS8VKtDmH
         NFrixprclHkELqnDCq06ZE/KJdjwZ6wf6vdcMTdM7qz7kPqbxWfJMnEz3yg09S43DVJp
         aQbe6hMl+/jzypYlNmyIqBySJA4xicEJn74N23Y10Co4HV0kfgsjFhu8bhI4nws+10f9
         h+SAz0b9nv1/HR3Fk/ecohYKzPcYE0mU9+KrKeY0DgCpDyBxVD2a/nDYjFIODVEuAAzm
         voGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691072914; x=1691677714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5N53XkLC0ow9oyOxGkfT1b0sFLVffEcOzJFgPmWv8y4=;
        b=EzGDwwZNiHWpzxZT7LLY5Hk19Yn4TtciaCFTDJiu6gWWZlC/4u3lXLe3Sa61qksWQb
         Ubi/kCv9k5ZdHW86PHvCA4Tx8Z+82irI+/AQyWOAxZ337oX3iVuaDx59+UCj/f6V2+IH
         XvIYJETeBwQh4xVG7RarHEQJNjUtQ0hN6yxgcW4SU9ovgeRXa1pJIZVSHG/dhDlnlZZw
         Cqv6FJqEiu0/i+YqUFI8Vhi8GXuHBaCNrjleQmw3n9idCw1jRMXP73aSzME+HLMFfZnC
         u/OeIAcG2GOOYtKdNJkyoYGIijBkqOFnGV1llcG/efSOAFbTgy1Gl+wp10LURKsRSn4b
         o7Dw==
X-Gm-Message-State: ABy/qLZzieR63lPR6FnwQdbTKZF50FAoCEFqs0iV72owJS9Bb/9xmueJ
        94Y4+AN2o7tmRNPYCpS3q1a7IA==
X-Google-Smtp-Source: APBJJlFKwEir4skN+luOBFSMcqA4fVsRirDLQHXzADij8bLk4uV6fj+XObENX31Yo+Vgki7BVlsvCQ==
X-Received: by 2002:a05:6402:70f:b0:51b:eb5f:baf with SMTP id w15-20020a056402070f00b0051beb5f0bafmr7977577edx.18.1691072913912;
        Thu, 03 Aug 2023 07:28:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id f26-20020a056402069a00b005224d960e66sm10167266edy.96.2023.08.03.07.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 07:28:33 -0700 (PDT)
Message-ID: <9f1210b8-1726-a7a3-622b-8fef778cba3e@linaro.org>
Date:   Thu, 3 Aug 2023 16:28:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v1 5/6] arm64: dts: allwinner: h616: Add BigTreeTech CB1
 SoM & boards support
Content-Language: en-US
To:     Martin Botka <martin@biqu3d.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230802220309.163804-1-martin@biqu3d.com>
 <85E425AED000D34C+20230802220309.163804-6-martin@biqu3d.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <85E425AED000D34C+20230802220309.163804-6-martin@biqu3d.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 00:02, Martin Botka wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> CB1 is Compute Module style board that plugs into Rpi board style adapter or
> Manta 3D printer boards (M4P/M8P).
> 
> The SoM features:
>   - H616 SoC
>   - 1GiB of RAM
>   - AXP313A PMIC
>   - RTL8189FTV WiFi

...

> +&mmc0 {
> +	vmmc-supply = <&reg_dldo1>;
> +	broken-cd;
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&mmc1 {
> +	vmmc-supply = <&reg_vcc33_wifi>;
> +	vqmmc-supply = <&reg_vcc_wifi_io>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	bus-width = <4>;
> +	non-removable;
> +	mmc-ddr-1_8v;
> +	status = "okay";
> +
> +	rtl8189ftv: sdio_wifi@1 {

No underxcores in node names. Generic node names, so probably "wifi".

> +		reg = <1>;

Missing compatible?



Best regards,
Krzysztof

