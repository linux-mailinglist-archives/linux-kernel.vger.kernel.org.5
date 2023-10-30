Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E167DC065
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjJ3T0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3T0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:26:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C356B4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 12:26:28 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5090cc340a3so3638334e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698693986; x=1699298786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9psATwBWmW+HWlHMJ1Br1I84UHK88mVqrK11rMxknlU=;
        b=R8JeYNafqpPrVkJkppb7UVQ0S+w0trG80XyGOgkArUVDJf9289nzOZct57Ha5CpT2a
         oHqxT8gxg6v540WDiFMThZ5c7Av8Lb6Krxs8+HqqttX5C83v4rrmOZ1KMOdK63SlUsYJ
         O6wLMuvlDAGfu8ZAC87TzTIM64lds93mChNSdXghe+tnnX0V84RWTc+/J6c3vMYrgw04
         HwmflM+HX5ogW9KMRVlhQJw9jgd3E7TkOKdsbKNQXsJ0KjrK9O/bsrjRaAJXaCHNTITG
         QQxWoWPKUWlOxyHz1dbjiIQ/M/4MFpgcHPW0aXGXTCyY+0ASrTKtHWhsPagg7S3fQBuL
         1k1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693986; x=1699298786;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9psATwBWmW+HWlHMJ1Br1I84UHK88mVqrK11rMxknlU=;
        b=rLcP6ukwgqbrt7nvPVyeAQNkVczoxZvUQA2bJwcwTpeiaS/HLuuqi/k/Cb0rAIJlrg
         tjGZ3mAox4dPQDO9EEy9pEFqJPutrGvbtL+v228HnvV3nyn6XzMuWnj9v4R2afzTGMSm
         G80HdvTPN31ApKhIx9aJK9E2L4Ab4NMg7cXzHagxtIw8kroR49vhwZ1OAyker0RMzxK2
         +6qQyI3kSZtnxN5+7ykopcKJE1HK/zhLkDnOOG8FGLkWmbRayrHhEx3L7l6TcxkBKbIV
         i5wxfc9KXw7MeGe8vOacgXfx1qlUi8ll5WCTnqkfEwfBL0ueaECDsjLYOE1/V8DDGOiC
         3hvg==
X-Gm-Message-State: AOJu0Yyn6bSqZmPUXo2Oer+bIVSi8OzcmT7ubNUOJFU6FtRRdpwxGy1r
        cZNV0cQ6WwcDivTmPRB6wfN0yw==
X-Google-Smtp-Source: AGHT+IEbYncTmSYYVIfiXMAcINNFJCE5io5Ni7UoIn2eLrzuUPU3AX3KChBsGX1GweruuxkJGn7Xkw==
X-Received: by 2002:a19:ca42:0:b0:4fb:caed:95c3 with SMTP id h2-20020a19ca42000000b004fbcaed95c3mr6559306lfj.53.1698693982191;
        Mon, 30 Oct 2023 12:26:22 -0700 (PDT)
Received: from [192.168.133.160] (178235177091.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.91])
        by smtp.gmail.com with ESMTPSA id a20-20020a056512201400b00507a0098421sm1538610lfb.181.2023.10.30.12.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 12:26:21 -0700 (PDT)
Message-ID: <4dfe793e-4d70-427e-bce5-8191c6a42cf9@linaro.org>
Date:   Mon, 30 Oct 2023 20:26:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable
 various remoteprocs
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
 <20231027-sc7280-remoteprocs-v1-8-05ce95d9315a@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231027-sc7280-remoteprocs-v1-8-05ce95d9315a@fairphone.com>
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

On 27.10.2023 16:20, Luca Weiss wrote:
> Enable the ADSP, CDSP, MPSS and WPSS that are found on the SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> index cc092735ce17..d65eef30091b 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> @@ -490,6 +490,26 @@ &qupv3_id_1 {
>  	status = "okay";
>  };
>  
> +&remoteproc_adsp {
> +	firmware-name = "qcom/qcm6490/fairphone5/adsp.mdt";
> +	status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/qcm6490/fairphone5/cdsp.mdt";
> +	status = "okay";
> +};
> +
> +&remoteproc_mpss {
> +	firmware-name = "qcom/qcm6490/fairphone5/modem.mdt";
> +	status = "okay";
> +};
> +
> +&remoteproc_wpss {
> +	firmware-name = "qcom/qcm6490/fairphone5/wpss.mdt";
mbn?

Konrad
