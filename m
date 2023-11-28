Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBA97FBB44
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345084AbjK1NS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344995AbjK1NS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:18:27 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E886DD6D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:18:32 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9b8363683so4811971fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701177511; x=1701782311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tTf2yUtECbY/OYuChMFvXRgzzGsfDdzdXOehMmGhewk=;
        b=Uv/qSj6o1sNZSZ2kXTOi1x5tAFzXAgKcnXdZniakiZmORcIs8gp1osAX5u/EJ7tr5M
         oOsLuXxIO7da30JriEnm3XOiVZiX/B2Mp9cW5XIL0Ke99s5aioH7/nO+BnhMlS8IonDl
         4BjusvsEChWCE1sBeeCHKS+8VLmjcTFNkXpZSsdRWQxMIyNEW2KNyNU86qKvo2nAb15d
         06BX78YgJt5ACGFXaEArceFxkGP4TegjrYRcA5zCSZr/aVX/d540a6LrokZO+eu4dQYd
         ibl+moEY1Olb8L/1mDnFKS/ErbDoHFyoBpa/ky7dYEubDeTpbA9ev+p4alhsbIxMJt28
         Sg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177511; x=1701782311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTf2yUtECbY/OYuChMFvXRgzzGsfDdzdXOehMmGhewk=;
        b=L/6H407LBcylzLmA1FCYBB0PuLMYbX596xTLKiqduh6v9mJzJwIwPGxkeq3ShA1qUa
         TD8wE9rGq4FZ60bksPXNkx2mZBM0BcA2zQ51+vv/+On6pFn7Y/Rsk/7Pz3tBDeXcacC0
         73L2cBmiJVns1vYPP/mQ49FsTiED1VkV/xdMVpEmgXvmMtesu8b4KOsZ3yvUlg1kjPiM
         TIY8QaxwyPXXrhdlF+Oaij3A2grENcd9ljJIAhh27FKo7DCQ9HJ6aL4bBA3uQoM0ByTS
         +AfU32SKiNhgCjacrQG6UeGEphbQRZEFeRmfwYUb61V0NRmb/yHBkXuiBOO3LevdnjXs
         96XA==
X-Gm-Message-State: AOJu0YxJ5GpkUmD4djCsBaK8WJIiwDnmbWGnFu6eia1o67vNOjYhZqDj
        iOD/7X8BRHWwuPlCUrU4dQDokg==
X-Google-Smtp-Source: AGHT+IGqrSCmGnNKknw600PvCwdJ4nyNLsm/yU9AqIvf2jLutSas7DdHhjfbocjXyLUEEP7CqlRP5A==
X-Received: by 2002:a05:651c:39d:b0:2c9:9983:6fba with SMTP id e29-20020a05651c039d00b002c999836fbamr5636031ljp.52.1701177511295;
        Tue, 28 Nov 2023 05:18:31 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id t7-20020a2e9547000000b002b657f10b78sm1707226ljh.58.2023.11.28.05.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 05:18:30 -0800 (PST)
Message-ID: <83e4f84f-63bd-4f53-886e-5cff215fd802@linaro.org>
Date:   Tue, 28 Nov 2023 15:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] iommu/arm-smmu-qcom: Add QCM2290 DPU compatible
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
 <20231125-topic-rb1_feat-v2-5-979b28f35e4a@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-5-979b28f35e4a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 17:28, Konrad Dybcio wrote:
> Add the QCM2290 DPU compatible to clients compatible list, as it also
> needs the workarounds.

Nit: MDSS, not DPU compatible

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 549ae4dba3a6..aea5e85b20ff 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -245,6 +245,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>   	{ .compatible = "qcom,adreno" },
>   	{ .compatible = "qcom,mdp4" },
>   	{ .compatible = "qcom,mdss" },
> +	{ .compatible = "qcom,qcm2290-mdss" },
>   	{ .compatible = "qcom,sc7180-mdss" },
>   	{ .compatible = "qcom,sc7180-mss-pil" },
>   	{ .compatible = "qcom,sc7280-mdss" },
> 

-- 
With best wishes
Dmitry

