Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD575FC1D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjGXQ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjGXQ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:29:26 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9420A1990
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:29:18 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b96789d574so61339101fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690216157; x=1690820957;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3Z/uvSiF0ayblJPOV19P4lW9dPUxNKyGAb0F+5VuKE=;
        b=GJjEeffF5gNi3mhRC+6uuaGo9TTaQGHhxA0gcpkR0/IX/xrIdtisHDPdDPweZuZYSx
         q6cRAen10YeW+N11HWRM6igj3do3QaPUS2EOjba7zVO3tNZkEShr1JbTObmObBKeHPV/
         nE2TJdOwv2C6McX6Ey/Bc1NaDACOsBB633xVWi0aicqyaDvNldXVi+ZJ1JDHLDqx2rxR
         GPvpmgiGEMpQllOVehW6Z0wo3uVjjZ6Qb8mB3q6+QrfZ3Fg5k6z5NmFITTHe/1BBgT5V
         8KCG9rtN1xhfjq33olD1MO/20Wvtvym7kDePKGNTwz2eYrIJBLwiQXv93ziAKkxsXwE0
         ggYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216157; x=1690820957;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3Z/uvSiF0ayblJPOV19P4lW9dPUxNKyGAb0F+5VuKE=;
        b=Q5duTQc3Zk1pxU3NKINf/0EdDvlCTRqHcoS0tzyKhSIm8l2Evt3r5Q9LdTUSVAGDGb
         NLTusXiLL2pSMjQsIiFH620hlRsXHaLZpVAdJ7CI2gn+vQWT7a2Y2bA5yaLbzdlwgFeY
         mnK7vOKDm19/AhFmpg54MwieSbsSsaubTPEqeJYeGkQAsIZwE7iqd7LqDAh30n4ilaEx
         nB5K0Lr5LTXvemRCtiFqL4qMUYB+/rZXO9s2Ya9+zqZNWtsZipkKzBxSo8+qZz6yUfzQ
         obOPtqzAxUKcbDChei3GwG+ibEAPcA8gHoI58z8emTPpTl1BU371sDSNpmTiI0agiRJS
         YuIg==
X-Gm-Message-State: ABy/qLY9GJiuOo4tKW+LbylSS3yBnUERf4CP2EBG5/XPe8R/I00KTFXd
        Lm6HxOTUJze6qZnTSEF6nvqXwg==
X-Google-Smtp-Source: APBJJlHNT4TYv30Cad/oFeqF8oDe13KZJxb0yqMQL1sqMpDjo8idqRDrnlP3D1TVbmTZYRSJw7qk3Q==
X-Received: by 2002:a2e:300d:0:b0:2b6:e7d6:714d with SMTP id w13-20020a2e300d000000b002b6e7d6714dmr7097165ljw.22.1690216156759;
        Mon, 24 Jul 2023 09:29:16 -0700 (PDT)
Received: from [192.168.1.101] (abxj221.neoplus.adsl.tpnet.pl. [83.9.3.221])
        by smtp.gmail.com with ESMTPSA id l22-20020a2ea316000000b002b6fed37b18sm2872746lje.101.2023.07.24.09.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 09:29:16 -0700 (PDT)
Message-ID: <898f8e84-de31-8147-ebb3-cef41f22868f@linaro.org>
Date:   Mon, 24 Jul 2023 18:29:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: Fix the I2C7 interrupt
Content-Language: en-US
To:     qaz6750 <qaz6750@outlook.com>, andersson@kernel.org,
        agross@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <SY7P282MB3787F073ED6E860E820C6CDDB202A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <SY7P282MB3787F073ED6E860E820C6CDDB202A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.07.2023 18:21, qaz6750 wrote:
> I2C6 and I2C7 use the same interrupts, which is incorrect.
> In the downstream kernel, I2C7 has interrupts of 608 instead of 607.
> 
> Signed-off-by: qaz6750 <qaz6750@outlook.com>
> ---
Fixes: 81bee6953b58 ("arm64: dts: qcom: sm8150: add i2c nodes")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 18c822abd..214f6e028 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -1231,7 +1231,7 @@ i2c7: i2c@89c000 {
>  				dma-names = "tx", "rx";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&qup_i2c7_default>;
> -				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				status = "disabled";
