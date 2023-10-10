Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F537C406D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJJTzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbjJJTzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:55:33 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B831AA4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:55:31 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c1807f3400so2345561fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696967730; x=1697572530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rl5xfKNIMhqVf9XxJ6NHKzGj+/S+F5nmD0njh3SwUk0=;
        b=d9iRK8YRDBwX8sUwkyzr6Sqtc+xRy+yaBm6SfkaVVqb7iGonQQR5xOuohS1ja5gcM2
         otBxqCaTW+/xorw9gRcNhUNJL9fDWyPU9XO4Vb+YYQrgdyDbyXrz6eamdLFHXUg5l9ki
         cUtj4VMm45e2ghSYAk+1cmFpMcmyP6FMG4ucBjyGgGMtOyZNU8e4irZS/HXt5H0upxo0
         Fs/ZaJWQFZ/IwY/wbEz1EsVhcZOOHaNeMt6ePW9XfirXusTLhDf8OxI6wvIb9gLJaWC5
         4NkShBeghunFD+Fsy9sx1a8hgtzyr2OwvfflAt0knDX+BihpQxSoNxGk6lbZlaWNWPaG
         1XXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696967730; x=1697572530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl5xfKNIMhqVf9XxJ6NHKzGj+/S+F5nmD0njh3SwUk0=;
        b=dGgSMhSRxTzGZpmjBxaVP/Tz84jI4MkuRTLsjhF6PG5cqToIW0qBKjvtCBckF2fThb
         oTCEfo5wQehgJosvbNfZSiwiC5tuFFBjvso38zAPMY5ZywVanQDl9A0biX79SfAGF3Xk
         dn+0diCtjctxdNltaa//mEs1fe6WXHgIJMYoosb8cz3ayKj9ZX1y3EHivKIUcjdxVEW0
         Ax0MHlze8twzF9JVpQN/frGp/BO2w9a6gZUCiGnUDVpgBUkjgC13v8Z0mf4fzQgbofNb
         QLtaCsDYAPadexm0AfmlyCL9/lDJT9dOL+gxSe1iU1TGrkzRe8vOgSyzuk3SaBnwAhvx
         tu0g==
X-Gm-Message-State: AOJu0YxV2J+LskQ4seo+e7/7PodJ3DnW/d2IpxlZYhNmHYyBjhWltz6N
        np3L5RAt7D9n8nll2OU8WSkOnw==
X-Google-Smtp-Source: AGHT+IGUBfWjT3swZMqxVuEwraVPRHXHAFpVdg0kljzTwPMMEycuzBLnpMNaPXBAeu4IjC8BNMUkbw==
X-Received: by 2002:a2e:8188:0:b0:2c0:1eea:d9c0 with SMTP id e8-20020a2e8188000000b002c01eead9c0mr11472447ljg.25.1696967729955;
        Tue, 10 Oct 2023 12:55:29 -0700 (PDT)
Received: from [172.30.204.182] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a4-20020a2eb164000000b002b9bf5b071bsm2548323ljm.20.2023.10.10.12.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 12:55:29 -0700 (PDT)
Message-ID: <e2d6c9c7-ff59-408f-94cf-81e66d291963@linaro.org>
Date:   Tue, 10 Oct 2023 21:55:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] ARM: dts: qcom: ipq8064: Add CPU OPP table
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
References: <20230930102218.229613-1-robimarko@gmail.com>
 <20230930102218.229613-4-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230930102218.229613-4-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/23 12:21, Robert Marko wrote:
> From: Christian Marangi <ansuelsmth@gmail.com>
> 
> Add CPU OPP table for IPQ8062, IPQ8064 and IPQ8065 SoC.
> Use opp-supported-hw binding to correctly enable and disable the
> frequency as IPQ8062 supports up to 1.0Ghz, IPQ8064 supports up to
> 1.4GHz with 1.2GHz as an additional frequency and IPQ8065 supports
> 1.7GHZ but doesn't have 1.2GHZ frequency and has to be disabled.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes v4:
> * Add OPP DTS patch for IPQ8064
> 
>   arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi | 30 +++++++++++
>   arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 67 ++++++++++++++++++++++++
>   arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi | 65 +++++++++++++++++++++++
>   3 files changed, 162 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
> index 5d3ebd3e2e51..72d9782c3d6f 100644
> --- a/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
> @@ -6,3 +6,33 @@ / {
>   	model = "Qualcomm Technologies, Inc. IPQ8062";
>   	compatible = "qcom,ipq8062", "qcom,ipq8064";
>   };
> +
> +&opp_table_cpu {
> +	opp-384000000 {
> +		opp-microvolt-speed0-pvs0 = <1000000 950000 1050000>;
> +		opp-microvolt-speed0-pvs1 = <925000 878750 971250>;
> +		opp-microvolt-speed0-pvs2 = <875000 831250 918750>;
> +		opp-microvolt-speed0-pvs3 = <800000 760000 840000>;
We can just make use of opp-supported-hw and define opp-384...-0, 
opp-384..-1 etc. with a valid corresponding bitmask in opp-supported-hw

otherwise it's somewhat confusing to follow, I think..

Konrad
