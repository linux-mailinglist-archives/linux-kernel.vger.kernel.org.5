Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50437B0228
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjI0KrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI0KrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:47:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4E013A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:47:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so26117961a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695811632; x=1696416432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQ3dRWFSzFn+xxVwVVaoy7t/aSLLVEtHDoJ4V/iI1zg=;
        b=ZcaiorcXKf6of8oh7Y4tGgStw4rvHgTNKUqc5fNNOED1wG/ovpwOZcuwBB2fO1K5mt
         mT6yLp+J3AkHzFtq53FCjX9o8fP1udBd3/3q1G1NoMEuJkX0Sg+CtoF66o1m+r7Q6R9M
         KRTVz12RYv9L1YiUkBr/XzG6xgPIp9Y3VF7Kh6K6kzHrlF6rQrHl26uyv3udOJ2y0vVg
         KKNdq/2g7zUC/ToWbDHtLfq6CFFMejstg3pcHu7qeW+tfs0aZsMUFR4YrN00UVGd+Sgt
         0mfPiE8s5+nM4M1xWPcD8WzAzO1zvKnqcJ3Ervckzy2KW4wfHhkaWihRBfR6MuUq6wml
         Gk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695811632; x=1696416432;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ3dRWFSzFn+xxVwVVaoy7t/aSLLVEtHDoJ4V/iI1zg=;
        b=PQw9BdSTVePpkpxWGNDZspzDXsSjri0x8bz5l9mF8s3fEz78F5icwOqU5tpgt6RLW9
         hmLepYOCWVE/LSU9LsE6aRs4C02kXziWI0I3zOM+NggiIMfb2GOfsIB8BjAcGPynnn1B
         WwlioVs/cQUZbSVZnt0yuLre71Uc01PxvLgiDGxHAi4Pt3ONCfYmLSGXmzSb8mLnuWJa
         X1GNFLQhTSVs6EwiYHhaNWaH185MD0X3k0udaqVkd4wcGruZ5TvDq8w/O+rEUU5vSumw
         1dZhc7ez8Esci/aCJ/CrWiOQAij6vJWOUei7d0I94JjaTzGujjEQsozES1sJGGkDIubp
         uvvg==
X-Gm-Message-State: AOJu0Yw+LohQwUaeAW/hHGpivwG6oUBfuJPxaphrGKsaUOKsOMTQITqb
        cXeZIKvpJMalnY6ollHc6Ou65Q==
X-Google-Smtp-Source: AGHT+IETV+6cwPeaHCYHkCp7qDMiBWINene2tNDTs1LgDTmUSv8Os1xlNfbkHXrCpiodmdzKX2cmKQ==
X-Received: by 2002:a17:906:c144:b0:9ae:513f:a4f3 with SMTP id dp4-20020a170906c14400b009ae513fa4f3mr7899469ejc.32.1695811632037;
        Wed, 27 Sep 2023 03:47:12 -0700 (PDT)
Received: from [192.168.33.189] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709062a4500b009934b1eb577sm9212009eje.77.2023.09.27.03.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 03:47:11 -0700 (PDT)
Message-ID: <35703a29-5c5a-47a8-9a4b-04953dc3faba@linaro.org>
Date:   Wed, 27 Sep 2023 12:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: Add interconnect nodes for SDX75
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dmitry.baryshkov@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695720564-2978-1-git-send-email-quic_rohiagar@quicinc.com>
 <1695720564-2978-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1695720564-2978-2-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.2023 11:29, Rohit Agarwal wrote:
> Add interconnect nodes to support interconnects on SDX75.
> Also parallely add the interconnect property for UART required
> so that the bootup to shell does not break with interconnects
> in place.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
[...]

>  		scm: scm {
>  			compatible = "qcom,scm-sdx75", "qcom,scm";
> @@ -434,6 +448,8 @@
>  			clock-names = "m-ahb",
>  				      "s-ahb";
>  			iommus = <&apps_smmu 0xe3 0x0>;
> +			interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>;
0 -> QCOM_ICC_TAG_ALWAYS (dt-bindings/interconnect/qcom,icc.h)

Konrad
