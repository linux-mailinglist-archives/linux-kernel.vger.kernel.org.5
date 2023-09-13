Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B532B79E0BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbjIMHTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbjIMHTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:19:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95CD1727
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:19:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so8559844a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694589558; x=1695194358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3hr2Dkoscy8OKR4lP2RVrqnAFjnoPD9KTW+WVQxYRY=;
        b=HedRivCyAvpHBOt/GY55mQe0+gM33dbCrhqcCnrF3SFFqKaMqfnk9D9E2E4RlPWSgH
         KJN76WNvfWGoS+3z3EA6OXncqmvkFOPqXDPxAlNyOOyl29csuz4tQ0L2g8rWvlM4V2rd
         3Pz0HDknYfOKAJFoaZErcJKjMhdbvMUQy6uRAcYxKvjgbUnNpw/frO4GlKN8OMTOhhhe
         1QGMfPFJvl3QWLJDRmQ3rRFzQL+KFDAE40WdKnRkTtWTlcKZZqhYHsm94q4YsL8lY7bP
         CA3dnulhM8fksmMvb/Qp4shpY2dWqJvbmmB8nIr1w/Ll5Mz0qDdaj3CtXBsVjprkAYCF
         p/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589558; x=1695194358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3hr2Dkoscy8OKR4lP2RVrqnAFjnoPD9KTW+WVQxYRY=;
        b=f7UHZH1+mJMQ1MRMtukLLqZkOKBa7jUVYuD9bxJT/Qy4P1JcqwIYPODDFKkYMe5Nfp
         AgsWsSF9fRbDYfA33JahUm5NAUmIC79EF/Si22h02iDt9wNMZG5/JPa/exJxErz9OhUV
         Rzb6hQRrR7TwDua4ug2mtzN8QtRXL5uOp9sxUm8M6px5YO8urFGg8P549L0t1k/MaWWo
         52CGNoo1GNBQ4dbt+BPLqdf6GxIF5Up3TVhM+VB8KKCJDald3RsK0NpOaPicM2vgedzr
         KSpXU9b9kO2Z1y+qJNE0M7/An5qkCEKu9EBNgb5k0St9HAQT4RYGNO+Rs9sq5mej1TXm
         QseA==
X-Gm-Message-State: AOJu0Yya25W/68cGYTPkssng/U3YSF/VF7a+35IR2Inds+10ERx84jil
        zoth1UCqMK2dAvAhTLR7RUQtmQ==
X-Google-Smtp-Source: AGHT+IE6YcmXnG2kZ7MVJ5DQQSPqKNTw5IPlBCUXbJfyxM9ZFvK7mh0xGHZANganLb81Af/8FOzTiQ==
X-Received: by 2002:a05:6402:48f:b0:528:90d7:a19 with SMTP id k15-20020a056402048f00b0052890d70a19mr1734134edv.11.1694589558276;
        Wed, 13 Sep 2023 00:19:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id b7-20020aa7c6c7000000b0052328d4268asm6841519eds.81.2023.09.13.00.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 00:19:17 -0700 (PDT)
Message-ID: <43cd38f5-20ce-a97d-0906-55faf228b377@linaro.org>
Date:   Wed, 13 Sep 2023 09:19:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 14/14] arm64: dts: qcom: sdm630: Fix USB2 clock-names
 order
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v2-14-1e506593b1bd@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-14-1e506593b1bd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 15:31, Konrad Dybcio wrote:
> The last 2 clock-names entries for the USB2 controller were swapped,
> resulting in schema warnings:
> 
> ['cfg_noc', 'core', 'mock_utmi', 'sleep'] is too short
>         'iface' was expected
>         'sleep' was expected
>         'mock_utmi' was expected
> 
> Fix it and take the liberty to make the clock-names entries more
> readable.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index f11d2a07508c..316c8fd224e0 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -1394,8 +1394,10 @@ usb2: usb@c2f8800 {
>  				 <&gcc GCC_USB20_MASTER_CLK>,
>  				 <&gcc GCC_USB20_MOCK_UTMI_CLK>,
>  				 <&gcc GCC_USB20_SLEEP_CLK>;
> -			clock-names = "cfg_noc", "core",
> -				      "mock_utmi", "sleep";
> +			clock-names = "cfg_noc",
> +				      "core",
> +				      "sleep",
> +				      "mock_utmi";

Plus this is just incorrect... :(

Best regards,
Krzysztof

